-- {-# OPTIONS --overlapping-instances #-}

module Verification.Core.Algebra.Ring.PartiallyOrdered where

open import Verification.Conventions

open import Verification.Core.Algebra.Setoid.Definition
open import Verification.Core.Algebra.Monoid.Definition
open import Verification.Core.Algebra.Group.Definition
open import Verification.Core.Algebra.Group.Quotient
open import Verification.Core.Algebra.Abelian.Definition
open import Verification.Core.Algebra.Ring.Definition
open import Verification.Core.Algebra.Ring.Domain
open import Verification.Core.Order.Preorder
open import Verification.Core.Order.Totalorder

module _ {๐ : ๐ ^ 2} where
  record isOrderedRing (๐ : ๐) (R : Ring ๐)  : ๐ฐ (๐ โบ ๏ฝค ๐ โบ) where
    field overlap {{OProof}} : ((isPreorder ๐ :> isPartialorder)) โฒ โจ R โฉ โฒ
    field cong-โ-โค-r : โ{a b c : โจ R โฉ} -> a โค b -> a โ c โค b โ c
          _โ-isNonNegative_ : โ{a b : โจ R โฉ} -> โ โค a -> โ โค b -> โ โค a โ b

  open isOrderedRing {{...}} public


module _ {๐ : ๐ ^ 2} {๐ : ๐} where
  module _ {R : ๐ฐ _} {_ : Ring ๐ on R} {{_ : isOrderedRing ๐ โฒ R โฒ}} where

    ta : isRing โฒ R โฒ
    ta = it
  -- module _ {R : Ring ๐} {{_ : isOrderedRing ๐ โฒ โจ R โฉ โฒ}} where
    cong-โ-โค-r : โ{a b c : R} -> a โค b -> (โ โค c) -> a โ c โค b โ c
    cong-โ-โค-r {a} {b} {c} p q =
      let Pโ = โ       โจ inv-r-โ โปยน โฉ-โผ-โค
              a โ โก a  โจ cong-โ-โค-r p โฉ-โค
              b โ โก a  โ-โค

          Pโ = โ                โจ Pโ โ-isNonNegative q โฉ-โค-โผ
               (b โ โก a) โ c    โจ distr-r-โ โฉ-โผ
               b โ c โ โก a โ c  โ-โผ

          Pโ = a โ c                      โจ unit-l-โ โปยน โฉ-โผ-โค
               โ โ a โ c                  โจ cong-โ-โค-r Pโ โฉ-โค-โผ
               (b โ c โ โก a โ c) โ a โ c   โจ assoc-l-โ โฉ-โผ
               b โ c โ (โก a โ c โ a โ c)   โจ refl โโโ (switch-โก-โ-l โปยน โโโ refl) โฉ-โผ
               b โ c โ (โก(a โ c) โ a โ c)  โจ refl โโโ inv-l-โ โฉ-โผ
               b โ c โ โ                  โจ unit-r-โ โฉ-โผ
               b โ c                      โ
      in Pโ



  isPositive : {R : ๐ฐ _} {{_ : Ring ๐ on R}} {{_ : isOrderedRing ๐ โฒ R โฒ}} -> R -> ๐ฐ _
  isPositive a = โ < a

  isNonNegative : {R : ๐ฐ _} {{_ : Ring ๐ on R}} {{_ : isOrderedRing ๐ โฒ R โฒ}} -> R -> ๐ฐ _
  isNonNegative a = โ โค a

  record isDecidable-OrderedRing (R : Ring ๐ :& isOrderedRing ๐) : ๐ฐ (๐ โบ ๏ฝค ๐ โบ) where
    field overlap {{DecOProof}} : (isTotalorder :> isDecidable-Totalorder) โฒ โจ R โฉ โฒ

  module _ (R : Ring ๐)
           {{_ : isDomain R}}
           {{_ : isOrderedRing ๐ R}} where
           -- {{_ : isDecidable-OrderedRing โฒ โจ R โฉ โฒ}} where

    cong-โ-โค-r

    -- cancel-โ-โค-r : โ{a b c : โจ R โฉ} -> a โ c โค b โ c -> isPositive c -> a โค b
    -- cancel-โ-โค-r =
    --   let Pโ : 









{-
  record isDecidable-OrderedRing (R : Ring ๐ :& isOrderedRing ๐) : ๐ฐ (๐ โบ ๏ฝค ๐ โบ) where
    field overlap {{DecOProof}} : (isTotalorder :> isDecidable-Totalorder) โฒ โจ R โฉ โฒ

-- module _ {๐ : ๐ ^ 2} {๐ : \}
  module _ (R : Ring ๐) {{_ : isOrderedRing ๐ R}} {{_ : isDecidable-OrderedRing โฒ โจ R โฉ โฒ}} where

    -- isPositive-โจก : isPositive โจก
    -- isPositive-โจก with compare โ โจก
    -- ... | LT x = {!!}
    -- ... | EQ x = transp-โค {!!} {!!} refl-โค
    -- ... | GT x = {!!}

-}





