module Test.Data.Filterable (tests) where

import Data.Filterable (Filterable, fzero, filter)

import Prelude (($), (==), (&&), Eq, const)

import Test.QuickCheck (Arbitrary, quickCheck)
import Test.QuickCheck.Gen (arrayOf, uniform)

-- property0 :: forall f a. (Eq (f a), Filterable f) => f a -> Boolean
property0 :: [Number] -> Boolean
property0 f = filter (const false) f == fzero

property1 :: [Number] -> Boolean
property1 f = filter (const true) f == f

property2 :: (Number -> Boolean) -> (Number -> Boolean) -> [Number] -> Boolean
property2 p0 p1 f = filter p0 (filter p1 f) == filter (\x -> p0 x && p1 x) f

tests = do
  quickCheck property0
  quickCheck property1
  quickCheck property2
