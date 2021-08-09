
module Verification.Experimental.Data.Indexed.Xiix where

open import Verification.Experimental.Conventions

open import Verification.Experimental.Set.Setoid.Definition
open import Verification.Experimental.Set.Set.Definition
open import Verification.Experimental.Set.Contradiction
open import Verification.Experimental.Set.Set.Instance.Category
open import Verification.Experimental.Category.Std.Category.Definition
open import Verification.Experimental.Category.Std.Functor.Definition
open import Verification.Experimental.Category.Std.Morphism.Iso
open import Verification.Experimental.Category.Std.Functor.Adjoint

open import Verification.Experimental.Data.Universe.Definition
open import Verification.Experimental.Data.Universe.Everything
open import Verification.Experimental.Data.Indexed.Definition
open import Verification.Experimental.Category.Std.Limit.Specific.Coproduct.Definition

module _ {𝒞 : Category 𝑖} {I : 𝒰 𝑗} where

  ix' : I -> 𝐈𝐱 I 𝒞 -> ⟨ 𝒞 ⟩
  ix' i a = ix a i

  macro
    𝑖𝑥 : ∀(i : I) -> SomeStructure
    𝑖𝑥 i = #structureOn (ix' i)

  module _ {i : I} where
    instance
      isFunctor:𝑖𝑥 : isFunctor (𝐈𝐱 I 𝒞) 𝒞 (𝑖𝑥 i)
      isFunctor.map isFunctor:𝑖𝑥               = λ x → x {i}
      isFunctor.isSetoidHom:map isFunctor:𝑖𝑥   = record { cong-∼ = λ x → x }
      isFunctor.functoriality-id isFunctor:𝑖𝑥  = refl
      isFunctor.functoriality-◆ isFunctor:𝑖𝑥   = refl


module _ {𝒞 : Category 𝑖} {I : 𝒰 𝑗} {{_ : hasInitial 𝒞}} {{_ : isDiscrete I}} where

  xiₗ : (i : I) -> ⟨ 𝒞 ⟩ -> 𝐈𝐱 I 𝒞
  xiₗ i a = indexed f
    where
      f : I -> ⟨ 𝒞 ⟩
      f j with (i ≟-Str j)
      ... | yes p = a
      ... | no ¬p = ⊥

  macro
    𝑥𝑖ₗ : ∀(i : I) -> SomeStructure
    𝑥𝑖ₗ i = #structureOn (xiₗ i)

  module _ {i : I} where
    map-𝑥𝑖ₗ : ∀{a b : ⟨ 𝒞 ⟩} -> (f : a ⟶ b) -> 𝑥𝑖ₗ i a ⟶ 𝑥𝑖ₗ i b
    map-𝑥𝑖ₗ f {j} with i ≟-Str j
    ... | yes p = f
    ... | no ¬p = id

    instance
      isFunctor:𝑥𝑖ₗ : isFunctor 𝒞 (𝐈𝐱 I 𝒞) (𝑥𝑖ₗ i)
      isFunctor.map              isFunctor:𝑥𝑖ₗ = map-𝑥𝑖ₗ
      isFunctor.isSetoidHom:map  isFunctor:𝑥𝑖ₗ = {!!}
      isFunctor.functoriality-id isFunctor:𝑥𝑖ₗ = {!!}
      isFunctor.functoriality-◆  isFunctor:𝑥𝑖ₗ = {!!}

    private
      coadj-𝑥𝑖ₗ' : ∀{a : ⟨ 𝒞 ⟩} {j} -> j ≣ i -> a ⟶ 𝑖𝑥 i (𝑥𝑖ₗ j a)
      coadj-𝑥𝑖ₗ' {a} {j} p with j ≟-Str i
      ... | yes p₁ = id
      ... | no ¬p = impossible (¬p p)

    coadj-𝑥𝑖ₗ : ∀{a : ⟨ 𝒞 ⟩} -> a ⟶ 𝑖𝑥 i (𝑥𝑖ₗ i a)
    coadj-𝑥𝑖ₗ = coadj-𝑥𝑖ₗ' refl-≣

    adj-𝑥𝑖ₗ : ∀{a : 𝐈𝐱 I 𝒞} -> 𝑥𝑖ₗ i (𝑖𝑥 i a) ⟶ a
    adj-𝑥𝑖ₗ {a} {j} with i ≟-Str j
    ... | yes refl-≣ = id
    ... | no ¬p = elim-⊥

    instance
      isAdjoint:𝑥𝑖ₗ𝑖𝑥 : isAdjoint (𝑥𝑖ₗ i) (𝑖𝑥 i)
      isAdjoint:𝑥𝑖ₗ𝑖𝑥 = record
                        { adj    = adj-𝑥𝑖ₗ
                        ; coadj  = coadj-𝑥𝑖ₗ
                        }



