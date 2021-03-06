
{-# OPTIONS --cubical --allow-unsolved-metas #-}

module Verification.Old.Core.Order.Instance.Level where

open import Verification.Conventions
open import Verification.Old.Core.Category.Definition
open import Verification.Old.Core.Category.Instance.Set.Definition
open import Verification.Old.Core.Order.Lattice
open import Verification.Old.Core.Order.Partialorder
open import Verification.Old.Core.Order.Preorder


Preorder:๐ : Preorder โโ
โจ Preorder:๐ โฉ = ๐
IPreorder._โค_ (of Preorder:๐) a b = (a โ b) โก b
IPreorder.refl-โค (of Preorder:๐) = refl
IPreorder.trans-โค (of Preorder:๐) {a = a} {b} {c} p q =
  let P = transport (ฮป i -> p (~ i) โ c โก c) q
      Q = transport (ฮป i -> a โ q i โก c) P
  in Q

instance IPreorder:๐ = #openstruct Preorder:๐

Partialorder:๐ : Partialorder โโ
โจ Partialorder:๐ โฉ = ๐
IPartialorder.Impl (of Partialorder:๐) = IPreorder:๐
IPartialorder.antisym-โค (of Partialorder:๐) p q = sym q โ p

instance IPartialorder:๐ = #openstruct Partialorder:๐

instance
  hasโจ-Preorder:๐ : hasโจ-Preorder ๐
  hasโจ-Preorder._โจ_ hasโจ-Preorder:๐ = _โ_
  hasโจ-Preorder.ฮนโ-โจ hasโจ-Preorder:๐ = refl
  hasโจ-Preorder.ฮนโ-โจ hasโจ-Preorder:๐ = refl
  hasโจ-Preorder.[_,_]-โจ hasโจ-Preorder:๐ p q = {!!}

  hasโฅ-Preorder:๐ : hasโฅ-Preorder ๐
  hasโฅ-Preorder.โฅ hasโฅ-Preorder:๐ = โโ
  hasโฅ-Preorder.initial-โฅ hasโฅ-Preorder:๐ _ = refl

-- JoinLattice:๐ : JoinLattice โโ
-- โจ JoinLattice:๐ โฉ = ๐
-- IJoinLattice.Impl (of JoinLattice:๐) = IPartialorder:๐
-- IJoinLattice._โจ_ (of JoinLattice:๐) = ฮป a b -> a โ b
-- IJoinLattice.ฮนโ-โจ (of JoinLattice:๐) = refl
-- IJoinLattice.ฮนโ-โจ (of JoinLattice:๐) = refl
-- IJoinLattice.โฅ (of JoinLattice:๐) = โโ
-- IJoinLattice.initial-โฅ (of JoinLattice:๐) = refl

-- instance IJoinLattice:๐ = #openstruct JoinLattice:๐




