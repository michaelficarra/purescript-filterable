module Data.Filterable (Filterable, cons, filter) where

import Prelude ((:))
import qualified Data.Foldable as Foldable
import qualified Data.Monoid as Monoid -- TODO: Zero

class Zero t where
  zero :: forall a. t a

-- TODO: these structures can be appended from the left; streams can only be appended from the right
class (Foldable.Foldable t, Zero t) <= Filterable t where
  cons :: forall a. a -> t a -> t a

-- filter (const false) == const zero
-- filter (const true) == id
-- TODO: some relationship between `filter pred` and `filter (not pred)`
filter :: forall t a. (Filterable t) => (a -> Boolean) -> t a -> t a
filter pred = Foldable.foldl (\memo x -> if pred x then cons x memo else memo) zero

instance zeroArray :: Zero [] where
  zero = Monoid.mempty

instance filterableArray :: Filterable [] where
  cons = (:)
