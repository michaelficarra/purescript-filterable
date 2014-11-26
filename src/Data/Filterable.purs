module Data.Filterable (Filterable, fzero, filter, Consable, czero, cons) where

import Prelude (Monad, return)
import Data.Foldable (Foldable, foldl)
import Control.MonadPlus (MonadPlus)
import Control.Plus (empty)

class Consable t where
  czero :: forall a. t a

  -- cons x xs /= xs
  -- cons x <<< cons x /= cons x
  -- if x /= y then cons x <<< cons y /= cons y <<< cons x
  cons :: forall a. a -> t a -> t a

class Filterable t where
  fzero :: forall a. t a

  -- filter (const false) == const fzero
  -- filter (const true) == id
  -- filter p0 <<< filter p1 == filter (\x -> p0 x && p1 x)
  filter :: forall a. (a -> Boolean) -> t a -> t a

instance foldableFilterable :: (Foldable t, Consable t) => Filterable t where
  fzero = czero
  filter pred = foldl (\memo x -> if pred x then cons x memo else memo) fzero

instance monadPlusFilterable :: (MonadPlus t) => Filterable t where
  fzero = empty
  filter pred xs = do
    x <- xs
    if pred x then return x else fzero
