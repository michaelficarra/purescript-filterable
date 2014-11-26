# Module Documentation

## Module Data.Filterable

### Type Classes

    class Consable t where
      czero :: forall a. t a
      cons :: forall a. a -> t a -> t a

    class Filterable t where
      fzero :: forall a. t a
      filter :: forall a. (a -> Boolean) -> t a -> t a



