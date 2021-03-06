

module Verification.Old.Core.Category.Limit.Kan.Equalizer where

open import Verification.Conventions
open import Verification.Old.Core.Category.Definition
open import Verification.Old.Core.Category.Instance.Cat
open import Verification.Old.Core.Category.Instance.Functor
open import Verification.Old.Core.Category.Functor.Adjunction
open import Verification.Old.Core.Category.Instance.SmallCategories
open import Verification.Old.Core.Category.Quiver
open import Verification.Old.Core.Category.FreeCategory
open import Verification.Old.Core.Category.Lift
open import Verification.Old.Core.Category.Limit.Kan.Definition
open import Verification.Old.Core.Category.Limit.Kan.Terminal

-- module _ {π : Category π} where





hasEqualizers : Category π -> π° π
hasEqualizers = has(πΌ)ShapedLimits
module _ {π : Category π} where
  Diagram-πΌ :  β{a b : β¨ π β©} -> (f g : a βΆ b) -> πΌ βΆ π
  Diagram-πΌ {a = a} {b} f g = free-Diagram-Lift D
      where D : QuiverHom Quiver:Pair (ForgetCategory π)
            β¨ D β© β = a
            β¨ D β© β = b
            IQuiverHom.qmap (of D) arrβ = f
            IQuiverHom.qmap (of D) arrβ = g

  -- module _ {{_ : hasEqualizers π}} where
  Cone-πΌ : {D : πΌ βΆ π} -> β{x : β¨ π β©} -> (f : x βΆ β¨ D β© (β₯ β)) -> (p : f β map ` arrβ ` β£ f β map ` arrβ `) -> β¨ ! πΌ * β© (Diagram-π x) βΆ D
  Cone-πΌ f p = free-Diagram-Nat X (Ξ» {arrβ -> unit-l-β β»ΒΉ;
                                        arrβ -> p β»ΒΉ β unit-l-β β»ΒΉ})
    where X = Ξ» {β -> f ;
                  β -> f β map ` arrβ `}

module _ {π : Category π} {{_ : hasEqualizers π}}  where
  Eq : β{a b : β¨ π β©} -> (f g : a βΆ b) -> β¨ π β©
  Eq f g = lim (Diagram-πΌ f g)





