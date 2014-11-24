module Data.Filterable (Filterable, fzero, fcons, filter) where

import Prelude ((:))
import qualified Data.Foldable as Foldable

-- TODO: these structures can be appended from the left; streams can only be appended from the right
class (Foldable.Foldable t) <= Filterable t where
  fzero :: forall a. t a
  fcons :: forall a. a -> t a -> t a

-- filter (const false) == const fzero
-- filter (const true) == id
-- TODO: some relationship between `filter pred` and `filter (not pred)`
filter :: forall t a. (Filterable t) => (a -> Boolean) -> t a -> t a
filter pred = Foldable.foldl (\memo x -> if pred x then fcons x memo else memo) fzero

instance filterableArray :: Filterable [] where
  fzero = []
  fcons = (:)
