

module Verification.Experimental.Theory.Std.Specific.ProductClosedTheory.Definition where

open import Verification.Conventions hiding (_⊔_)

open import Verification.Experimental.Set.Discrete
open import Verification.Experimental.Algebra.Monoid.Definition
open import Verification.Experimental.Algebra.Monoid.Free
open import Verification.Experimental.Algebra.Monoid.Free.Element
open import Verification.Experimental.Category.Std.Category.Definition
open import Verification.Experimental.Data.Substitution.Definition

open import Verification.Experimental.Computation.Unification.Definition
open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Definition
open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.PCF
open import Verification.Experimental.Theory.Std.Presentation.Token.Definition
open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.FromString3
open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.hasBoundaries
open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.FormalSystem
open import Verification.Experimental.Theory.Std.Generic.FormalSystem.Definition
open import Verification.Experimental.Category.Std.Limit.Specific.Coproduct.Definition
open import Verification.Experimental.Category.Std.Limit.Specific.Coequalizer.Definition
open import Verification.Experimental.Data.Substitution.Definition

open import Verification.Experimental.Theory.Std.Specific.Product.Type

pattern _⇒_ α β = (con ⇒ᵗ ((incl α) ⋆-⧜ ((incl β) ⋆-⧜ ◌-⧜)))
pattern _▻_ Γ τ = (con ▻ᵗ ((incl Γ) ⋆-⧜ ((incl τ) ⋆-⧜ ◌-⧜)))
pattern _分⊢_ Γ τ = (con 分⊢ᵗ ((incl Γ) ⋆-⧜ ((incl τ) ⋆-⧜ ◌-⧜)))
pattern _影⊢_ Γ τ = (con 影⊢ᵗ ((incl Γ) ⋆-⧜ ((incl τ) ⋆-⧜ ◌-⧜)))

module 𝕋× where
  分Term = Term₁-𝕋×

module 𝕋Λ where
  module 統 where
    -- BoundaryAxiom = TypeAxiom-𝕋Λ

    分Boundary = 𝕋×.分Term 𝒷

    _⊩_ = 分Boundary


    data Term {μ} : ∀{ξ} -> (β : μ ⊩ ξ) -> 𝒰 ℓ₀ where
      zero : ∀{Γ τ} -> Term ((Γ ▻ τ) 影⊢ τ)
      suc : ∀{Γ α β} -> Term (Γ 影⊢ α) -> Term ((Γ ▻ β) 影⊢ α)

      var : ∀{Γ τ} -> Term (Γ 影⊢ τ) -> Term (Γ 分⊢ τ)
      app : ∀{Γ α β} -> Term (Γ 分⊢ (α ⇒ β)) -> Term (Γ 分⊢ α) -> Term (Γ 分⊢ β)
      lam : ∀{Γ α β} -> Term ((Γ ▻ α) 分⊢ β) -> Term (Γ 分⊢ (α ⇒ β))

      slet : ∀{Γ α β} -> Term (Γ 分⊢ α) -> Term ((Γ ▻ α) 分⊢ β) -> Term (Γ 分⊢ β)

  -- Γ 影 τ  ->  Γ ⊩ τ  -> Γ 全 [ τ ]

-- a = 𝕋Λ.統.分-Term

-- a = 𝕋Λ.厳.分Term


