module Tests where

import Prelude ((:), Ord)
import Data.Filterable (Filterable, fzero, filter, Consable, czero, cons)

import qualified Data.Set as Set

instance consableArray :: Consable [] where
  czero = []
  cons = (:)

--instance consableSet :: (Ord a) => Consable (Set.Set a) where
--  czero = Set.empty
--  cons = Set.insert
