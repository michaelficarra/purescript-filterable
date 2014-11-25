module Tests where

import Data.Filterable (Filterable, fzero, fcons, filter)
import qualified Data.Set as Set

instance filterableArray :: Filterable [] where
  fzero = []
  fcons = (:)

instance filterableSet :: Filterable Set.Set where
  fzero = Set.empty
  fcons = Set.insert
