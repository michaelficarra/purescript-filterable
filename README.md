# Module Documentation

## Module Data.Filterable

### Type Classes

    class (Data.Foldable.Foldable t, Data.Filterable.Zero t) <= Filterable t where
      cons :: forall a. a -> t a -> t a


### Values

    filter :: forall t a. (Data.Filterable.Filterable t) => (a -> Boolean) -> t a -> t a



