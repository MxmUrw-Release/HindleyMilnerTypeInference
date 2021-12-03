
module Verification.Core.Theory.Std.Specific.ProductClosedTheory.Inference.Definition where

open import Verification.Conventions hiding (_⊔_)

open import Verification.Core.Set.Discrete
open import Verification.Core.Algebra.Monoid.Definition
open import Verification.Core.Algebra.Monoid.Free
open import Verification.Core.Data.List.Variant.FreeMonoid.Element
open import Verification.Core.Category.Std.Category.Definition
open import Verification.Core.Data.Substitution.Variant.Base.Definition

open import Verification.Core.Computation.Unification.Definition
-- open import Verification.Core.Theory.Std.Specific.ProductTheory.Definition
-- open import Verification.Core.Theory.Std.Specific.ProductTheory.Instance.PCF
open import Verification.Core.Theory.Std.Presentation.Token.Definition
-- open import Verification.Core.Theory.Std.Specific.ProductTheory.Instance.FromString3
-- open import Verification.Core.Theory.Std.Specific.ProductTheory.Instance.hasBoundaries
-- open import Verification.Core.Theory.Std.Specific.ProductTheory.Instance.FormalSystem
open import Verification.Core.Theory.Std.Generic.FormalSystem.Definition
open import Verification.Core.Category.Std.Limit.Specific.Coproduct.Definition
open import Verification.Core.Category.Std.Limit.Specific.Coequalizer.Definition
open import Verification.Core.Data.Substitution.Variant.Base.Definition
open import Verification.Core.Theory.Std.Specific.ProductTheory.Module

open import Verification.Core.Theory.Std.Specific.ProductClosedTheory.Inference.Boundary


pattern _⇒_ α β = (con ⇒ᵗ ((incl α) ⋆-⧜ ((incl β) ⋆-⧜ ◌-⧜)))
pattern _▻_ Γ τ = (con ▻ᵗ ((incl Γ) ⋆-⧜ ((incl τ) ⋆-⧜ ◌-⧜)))
pattern _分⊢_ Γ τ = (con 分⊢ᵗ ((incl Γ) ⋆-⧜ ((incl τ) ⋆-⧜ ◌-⧜)))
pattern _影⊢_ Γ τ = (con 影⊢ᵗ ((incl Γ) ⋆-⧜ ((incl τ) ⋆-⧜ ◌-⧜)))


private
  _⊩_ = 𝕋×.統.分Term 𝒷


data Term {μ} : ∀{ξ} -> (β : μ ⊩ ξ) -> 𝒰 ℓ₀ where
  zero : ∀{Γ τ} -> Term ((Γ ▻ τ) 影⊢ τ)
  suc : ∀{Γ α β} -> Term (Γ 影⊢ α) -> Term ((Γ ▻ β) 影⊢ α)

  var : ∀{Γ τ} -> Term (Γ 影⊢ τ) -> Term (Γ 分⊢ τ)
  app : ∀{Γ α β} -> Term (Γ 分⊢ (α ⇒ β)) -> Term (Γ 分⊢ α) -> Term (Γ 分⊢ β)
  lam : ∀{Γ α β} -> Term ((Γ ▻ α) 分⊢ β) -> Term (Γ 分⊢ (α ⇒ β))

  slet : ∀{Γ α β} -> Term (Γ 分⊢ α) -> Term ((Γ ▻ α) 分⊢ β) -> Term (Γ 分⊢ β)


