
{-# OPTIONS --cubical --allow-unsolved-metas #-}

module Verification.Old.Core.Category.Instance.SmallCategories where

open import Verification.Conventions
open import Verification.Old.Core.Category.Definition
open import Verification.Old.Core.Category.Instance.Type
open import Verification.Old.Core.Category.Iso
open import Verification.Old.Core.Category.Quiver
open import Verification.Old.Core.Category.FreeCategory
open import Verification.Old.Core.Category.Lift

------------------
-- ===* Category with 2 points

data π-π° : π°β where
  β β : π-π°

Category:π = Category:Discrete π-π°
instance ICategory:π = #openstruct Category:π

instance
  Notation-π:Category : β{π} -> Notation-π (Category π)
  Notation-π.`π` (Notation-π:Category {π}) = β Category:π


------------------
-- ===* Category with pair of arrows

data Pair : π°β where
  β β : Pair

data PairHom : Pair -> Pair -> π°β where
  arrβ : PairHom β β
  arrβ : PairHom β β

Quiver:Pair : Quiver (many ββ)
β¨ Quiver:Pair β© = Pair
IQuiver.Edge (of Quiver:Pair) = PairHom
IQuiver._β_ (of Quiver:Pair) = _β‘_
IQuiver.isEquivRelInst (of Quiver:Pair) = isEquivRel:Path

Category:Pair = Category:Free (Quiver:Pair)

instance
  ICategory:Pair = of Category:Pair

πΌ : β{π} -> Category π
πΌ = β Category:Pair



