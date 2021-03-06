
-- {-# OPTIONS --overlapping-instances #-}

module Verification.Core.Algebra.Ring.Localization.Instance.Preorder where

open import Verification.Conventions

open import Verification.Core.Algebra.Setoid.Definition
open import Verification.Core.Algebra.Monoid.Definition
open import Verification.Core.Algebra.Group.Definition
-- open import Verification.Core.Algebra.Group.Quotient
open import Verification.Core.Algebra.Abelian.Definition
open import Verification.Core.Algebra.Ring.Definition
open import Verification.Core.Algebra.Ring.Localization
open import Verification.Core.Algebra.Ring.Ordered
open import Verification.Core.Algebra.Ring.Domain

open import Verification.Core.Order.Preorder



record Repr {ð ð : ð} {A : ð° ð} {{_ : isSetoid ð A}} (P : A -> ð° ð) (a : A) : ð° (ð ï½¤ ð ï½¤ ð) where
  field â¨_â© : A
  field represents : a â¼ â¨_â©
  field hasProperty : P â¨_â©
open Repr public

record hasRepr {ð ð : ð} (A : ð° ð) {{_ : isSetoid ð A}} (P : A -> ð° ð) : ð° (ð ï½¤ ð ï½¤ ð) where
  field repr : â(a : A) -> Repr P a
open hasRepr public

-- module _ {A : CRing (ââ , ââ)} {M : MCS A} where
-- module _ {ð : ð ^ 2} {R : CRing ð} {M : MCS R} where
module _ {ð : ð ^ 2} {ð : ð} {R : CRing ð} {M : MCS R} {{_ : isOrderedRing ð â² â¨ R â© â²}} where
  -- locâ = Localize.numer
  -- locâ = Localize.denom

  -- positive denominator
  hasPositiveDenom : Localize R M -> ð° _
  hasPositiveDenom (a / (da â _)) = isPositive da

module _ {ð : ð ^ 2} {ð : ð} {R : CRing ð} {M : MCS R} {{_ : isOrderedRing ð â² â¨ R â© â²}} {{_ : isDomain â² â¨ R â© â²}} where
  module _ {{Î´ : hasRepr (Localize R M) hasPositiveDenom}} where
    private
      â¤-Loc-impl : (a b : Localize R M) -> ð° _
      â¤-Loc-impl a' b' =
        let a = â¨ Î´ .repr a' â©
            b = â¨ Î´ .repr b' â©
        in locâ a â â¨ locâ b â© â¤ locâ b â â¨ locâ a â©

        -- let (a / (da â _)) = â¨ Î´ .repr a' â©
        --     (b / (db â _)) = â¨ Î´ .repr b' â©
        -- in â Î» (s : â¦ isPositive â¦) -> a â db â â¨ s â© â¤ b â da â â¨ s â©

    -- record â¤-Loc-impl (a b : Localize R M) : ð° ð where
    --   field repr-l : Repr hasPositiveDenom a
    --         repr-r : Repr hasPositiveDenom b
    --         expand : â¦ hasPositiveDenom â¦
    --         by-â¤ : 
    -- LELoc (a / da) (b / db) = a â â¨ db â© â¤ b â â¨ da â©

      _â¤-Loc_ : (a b : Localize R M) -> ð° _
      _â¤-Loc_ = LE â¤-Loc-impl

      lem-10 : â{a : Localize R M} -> a â¤-Loc a
      lem-10 {a'} = incl refl-â¤
        -- let (a / (da â _)) = â¨ Î´ .repr a' â©
        --     -- P : a â da â¤ a â da
        --     -- P = refl-â¤
        -- in incl (refl-â¤)

      lem-20 : â{a b c : Localize R M} -> a â¤-Loc b -> b â¤-Loc c -> a â¤-Loc c
      lem-20 {a'} {b'} {c'} (incl p) (incl q) =
        let (a / (da â _)) = â¨ Î´ .repr a' â©
            (b / (db â _)) = â¨ Î´ .repr b' â©
            (c / (dc â _)) = â¨ Î´ .repr c' â©

            Pâ : a â db â dc â¤ b â da â dc
            Pâ = cong-â-â¤-r p (Î´ .repr c' .hasProperty .Ï-â¤)

            Pâ : b â dc â da â¤ c â db â da
            Pâ = cong-â-â¤-r q (Î´ .repr a' .hasProperty .Ï-â¤)

            Pâ : a â dc â db â¤ c â da â db
            Pâ = a â dc â db   â¨ by-â¼-â¤ assoc-l-â â (refl âââ comm-â) â assoc-r-â â©-â¤
                 a â db â dc   â¨ Pâ â©-â¤
                 b â da â dc   â¨ by-â¼-â¤ assoc-l-â â (refl âââ comm-â) â assoc-r-â â©-â¤
                 b â dc â da   â¨ Pâ â©-â¤
                 c â db â da   â¨ by-â¼-â¤ assoc-l-â â (refl âââ comm-â) â assoc-r-â â©-â¤
                 c â da â db   â-â¤

        in {!!}

    instance
      isPreorder:Localize : isPreorder _ â² Localize R M â²
      isPreorder.myLE isPreorder:Localize = â¤-Loc-impl
      isPreorder.refl-â¤ isPreorder:Localize = lem-10
      isPreorder._â-â¤_ isPreorder:Localize = lem-20
      isPreorder.transp-â¤ isPreorder:Localize = {!!}

{-
{-

-}



-- record _:&2_ (UU : ð° ð) {{U : hasU UU ð ð}} {Q : UU -> ð° ðâ} (P : (u : UU) -> Q u -> ð° ð) : ð° (ð ï½¤ ð ï½¤ ð ï½¤ ðâ) where
--   constructor â²_â²
--   field â¨_â© : getU U
--   -- field overlap {{oldProof}} : getP U â¨_â©
--   field {oldProof} : getP U â¨_â©
--   field overlap {{ProofQ}} : Q (reconstruct U (â¨_â© , oldProof))
--   field overlap {{Proof}} : P (reconstruct U (â¨_â© , oldProof)) ProofQ
-- open _:&2_ {{...}} public hiding (â¨_â©)
-- open _:&2_ public using (â¨_â©)

-- infixl 30 _:&2_

-}
