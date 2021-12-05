
module Verification.Core.Set.Function.Property where

open import Verification.Conventions
open import Verification.Core.Set.Function.Injective
open import Verification.Core.Category.Std.Morphism.Iso.Definition
open import Verification.Core.Category.Std.Category.Definition
open import Verification.Core.Data.Universe.Definition
open import Verification.Core.Data.Universe.Instance.Category



module _ {A : 𝒰 𝑖} {B : 𝒰 𝑖} where
  isInjective-𝒰:byIso : {f : A -> B} {{fP : isIso {𝒞 = 𝐔𝐧𝐢𝐯 𝑖} (hom f)}} -> isInjective-𝒰 f
  isInjective-𝒰:byIso {f} {{fP}} = injective (λ {a} {b} fa∼fb ->
    let
      g = (inverse-◆ fP)
      p' = cong g fa∼fb
      p0 : a ≡ g (f a)
      p0 = funExt⁻¹ (inv-r-◆ fP ⁻¹) _

      p1 : g (f b) ≡ b
      p1 = funExt⁻¹ (inv-r-◆ fP) _

      p'' = trans-Path (trans-Path p0 p') p1

    in p''
    )

