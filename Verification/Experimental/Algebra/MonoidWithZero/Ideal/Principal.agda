
module Verification.Experimental.Algebra.MonoidWithZero.Ideal.Principal where

open import Verification.Conventions

open import Verification.Experimental.Set.Setoid.Definition
open import Verification.Experimental.Set.Setoid.Subsetoid
open import Verification.Experimental.Order.Preorder
open import Verification.Experimental.Order.Lattice
open import Verification.Experimental.Data.Prop.Everything
open import Verification.Experimental.Algebra.Monoid.Definition
open import Verification.Experimental.Algebra.MonoidWithZero.Definition
open import Verification.Experimental.Algebra.MonoidWithZero.Special
open import Verification.Experimental.Algebra.MonoidAction.Definition
open import Verification.Experimental.Algebra.MonoidWithZero.Ideal.Definition
open import Verification.Experimental.Algebra.MonoidWithZero.Ideal.Instance.Lattice
open import Verification.Experimental.Algebra.MonoidWithZero.Ideal.Instance.hasAction




module _ {𝑖 : 𝔏} {A : Monoid₀ (𝑖 , 𝑖)} where

  record isPrincipalᵣ (I : Idealᵣ A) : 𝒰 (𝑖 ⁺) where
    field rep : ⟨ A ⟩
    field principal-r : I ∼ (rep ↷ ′ ⊤ ′)

  open isPrincipalᵣ {{...}} public

  repOf : (I : Idealᵣ A) -> {{_ : isPrincipalᵣ I}} -> ⟨ A ⟩
  repOf I = rep

  module §-Principalᵣ where
    -- Principalᵣ::rep-in-ideal
    prop-1 : ∀{I : Idealᵣ A} -> {{_ : isPrincipalᵣ I}} -> repOf I ∈ I
    prop-1 {I} =
      let P₀ = inv-∼-Setoid (⟨ principal-r ⟩) (incl (◌ , tt , unit-r-⋆ ⁻¹))
      in P₀


Principalᵣ : (Monoid₀ (𝑖 , 𝑖)) -> 𝒰 _
Principalᵣ A = Idealᵣ A :& isPrincipalᵣ


module _ {𝑖 : 𝔏} {A : Monoid₀ (𝑖 , 𝑖)} where

  transp-isPrincipalᵣ : ∀{I J : Idealᵣ A} -> (I ∼ J) -> isPrincipalᵣ I -> isPrincipalᵣ J
  transp-isPrincipalᵣ I∼J pI = record
    { rep = rep {{pI}}
    ; principal-r = I∼J ⁻¹ ∙ principal-r {{pI}}
    }

  instance
    isPrincipalᵣ:⊤ : isPrincipalᵣ {A = A} ⊤
    isPrincipalᵣ:⊤ = record
      { rep = ◌
      ; principal-r = {!!} -- antisym (incl (λ x → incl (_ , tt , unit-l-⋆ ⁻¹))) (incl (λ x → tt))
        -- (incl (λ {a} x → incl $ a , tt , unit-l-⋆ ⁻¹))
        -- (incl (λ x → tt))
      }

  instance
    isPrincipalᵣ:0-Idealᵣ : isPrincipalᵣ {A = A} ⊥-Idealᵣ
    isPrincipalᵣ:0-Idealᵣ = {!!}




module _ {𝑖 : 𝔏} {A : Monoid₀ (𝑖 , 𝑖)} {{_ : hasSpecial A}} where


  record isSpecialEpi (I : Principalᵣ A) : 𝒰 𝑖 where
    field zeroOrEpi : isZeroOrEpi (rep {{of I}})
    field special : rep {{of I}} ∈ Special
  open isSpecialEpi {{...}} public

  isSpecialEpiPrincipalᵣ : (I : Idealᵣ A) -> 𝒰 _
  isSpecialEpiPrincipalᵣ = isPrincipalᵣ :> isSpecialEpi

  transp-isSpecialEpiPrincipalᵣ : ∀{I J : Idealᵣ A} -> (I ∼ J) -> isSpecialEpiPrincipalᵣ I -> isSpecialEpiPrincipalᵣ J
  transp-isSpecialEpiPrincipalᵣ {I} {J} I∼J PI =
    let instance
          P₀ : isPrincipalᵣ ′ ⟨ J ⟩ ′
          P₀ = transp-isPrincipalᵣ I∼J it
          P₁ : isSpecialEpi ′ ⟨ J ⟩ ′
          P₁ = record { zeroOrEpi = zeroOrEpi {{_:>_.Proof2> PI}} ; special = special {{_:>_.Proof2> PI}} }
    in it


  instance
    isSpecialEpi:⊤ : isSpecialEpi ′ ⊤ ′
    isSpecialEpi:⊤ = record
      { zeroOrEpi = case decide-◍ ◌ of
                              (λ (◌≁◍) ->
                                let P : ∀{b c : ⟨ A ⟩} -> (◌ ⋆ b) ∼ ◌ ⋆ c -> b ∼ c
                                    P p = unit-l-⋆ ⁻¹ ∙ p ∙ unit-l-⋆
                                in right (◌≁◍ , P))
                              (λ (◌∼◍) -> left ◌∼◍)
      ; special = closed-◌
      }

  instance
    isSpecialEpi:⊥ : isSpecialEpi ⊥-Idealᵣ
    isSpecialEpi:⊥ = {!!}

  closed-⋆-isZeroOrEpi : ∀{a b : ⟨ A ⟩} -> isZeroOrEpi a -> isZeroOrEpi b -> isZeroOrEpi (a ⋆ b)
  closed-⋆-isZeroOrEpi (left x) y = left ((x ≀⋆≀ refl) ∙ absorb-l-⋆)
  closed-⋆-isZeroOrEpi (just x) (left y) = left ((refl ≀⋆≀ y) ∙ absorb-r-⋆)
  closed-⋆-isZeroOrEpi {a} {b} (just (a≁◍ , cancel-a)) (just (b≁◍ , cancel-b)) with decide-◍ (a ⋆ b)
  ... | just x = left x
  ... | left (a≁b) =
    let P₀ : ∀{x y : ⟨ A ⟩} -> (a ⋆ b) ⋆ x ∼ (a ⋆ b) ⋆ y -> x ∼ y
        P₀ {x} {y} p =
          let q : a ⋆ (b ⋆ x) ∼ a ⋆ (b ⋆ y)
              q = assoc-r-⋆ ∙ p ∙ assoc-l-⋆
          in cancel-b (cancel-a q)

    in right (a≁b , P₀)
