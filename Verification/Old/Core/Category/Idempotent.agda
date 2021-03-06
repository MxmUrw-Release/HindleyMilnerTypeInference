
{-# OPTIONS --cubical --allow-unsolved-metas #-}

module Verification.Old.Core.Category.Idempotent where


open import Verification.Conventions
open import Verification.Old.Core.Category.Definition
open import Verification.Old.Core.Category.Instance.Functor
-- open import Verification.Old.Core.Category.Instance.Cat
-- open import Verification.Old.Core.Category.Instance.Type
open import Verification.Old.Core.Category.FreeCategory
open import Verification.Old.Core.Category.Lift
open import Verification.Old.Core.Category.Functor.Adjunction
open import Verification.Old.Core.Category.Limit.Kan.Definition
open import Verification.Old.Core.Category.Limit.Kan.Equalizer
open import Verification.Old.Core.Category.Limit.Kan.Terminal
open import Verification.Old.Core.Category.Instance.SmallCategories

module _ {X : π° π} {{_ : ICategory X π}} where
  record IIdempotent {a : X} (f : a βΆ a) : π° (π ο½€ π) where
    field idempotent : f β f β£ f
open IIdempotent {{...}} public
unquoteDecl Idempotent mkIdempotent = #struct "Idpt" (quote IIdempotent) "f" Idempotent mkIdempotent

module _ {π : Category π} {{_ : hasEqualizers π}} where
  -- instance _ = of π

  Normal : {x : β¨ π β©} -> (I : Idempotent x) -> β¨ π β©
  Normal I = Eq β¨ I β© id

  module _ {x : β¨ π β©} {I : x βΆ x} {{_ : IIdempotent I}} where
    private
      D : Functor πΌ π
      D = Diagram-πΌ I id

      xcone : Cone D x
      xcone = Cone-πΌ I (idempotent β unit-r-β β»ΒΉ)

      normalize-impl : Diagram-π x βΆ _
      normalize-impl = freeβ»ΒΉ xcone

    normalize : x βΆ lim D
    normalize = β¨ normalize-impl β© {β₯ tt}


