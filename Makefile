default: build doc
all: build doc test

MODULE = Data.Filterable
OUT = lib
TESTSOUT = built-tests
MODULE_PATH = $(OUT)/$(MODULE)

build: $(MODULE_PATH).js
build-tests: $(TESTSOUT)/index.js
externs: $(MODULE_PATH).externs.purs
deps: node_modules bower_components
doc: README.md

BOWER_DEPS = $(shell find bower_components/purescript-*/src -name '*.purs' -type f | sort)
SRC = $(shell find src -name '*.purs' -type f | sort)
TESTS = $(shell [ -d test ] && find test -name '*.purs' -type f | sort)

BOWER = node_modules/.bin/bower
ISTANBUL = node_modules/.bin/istanbul
NPM = $(shell command -v npm || { echo "npm not found."; exit 1; })
PSC = $(shell command -v psc || { echo "PureScript compiler (psc) not found."; exit 1; })
PSCDOCS = $(shell command -v psc-docs || command -v docgen)

$(MODULE_PATH).js: bower_components $(SRC)
	@mkdir -p '$(@D)'
	$(PSC) --verbose-errors \
	  --module $(MODULE) \
	  --browser-namespace exports \
	  $(BOWER_DEPS) $(SRC) \
	  > $(MODULE_PATH).js

.PHONY: default all build externs deps doc clean test build-tests

$(MODULE_PATH).externs.purs: bower_components $(SRC)
	@mkdir -p '$(@D)'
	$(PSC) --verbose-errors \
	  --module $(MODULE) \
	  --codegen $(MODULE) \
	  --externs $(MODULE_PATH).externs.purs \
	  $(BOWER_DEPS) $(SRC) \
	  > /dev/null

README.md: $(MODULE_PATH).externs.purs
	@mkdir -p '$(@D)'
	$(PSCDOCS) $(MODULE_PATH).externs.purs >'$@'

$(TESTSOUT)/index.js: $(TESTS) $(SRC) bower_components
	@mkdir -p '$(@D)'
	$(PSC) --verbose-errors --module Main --main Main \
	  $(BOWER_DEPS) $(SRC) $(TESTS) \
	  >'$@'

node_modules:
	$(NPM) install

bower_components: node_modules
	$(BOWER) install

test: node_modules $(TESTSOUT)/index.js
	[ -d test ] && $(ISTANBUL) cover --root $(TESTSOUT) -- $(TESTSOUT)/index.js

clean:
	rm -rf $(OUT) $(TESTSOUT) coverage bower_components node_modules
