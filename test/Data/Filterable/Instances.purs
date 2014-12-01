module Test.Data.Filterable.Instances where

import Prelude ((:), Ord, return, unit)
import Data.Filterable (Filterable, fzero, filter, Consable, czero, cons)

import qualified Data.Set as Set

instance consableArray :: Consable [] where
  czero = []
  cons = (:)

--instance consableSet :: (Ord a) => Consable (Set.Set a) where
--  czero = Set.empty
--  cons = Set.insert
