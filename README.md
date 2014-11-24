# Module Documentation

## Module Data.Filterable

### Type Classes

    class (Data.Foldable.Foldable t) <= Filterable t where
      fzero :: forall a. t a
      fcons :: forall a. a -> t a -> t a


### Values

    filter :: forall t a. (Data.Filterable.Filterable t) => (a -> Boolean) -> t a -> t a



