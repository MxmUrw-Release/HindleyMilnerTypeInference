
module Verification.Experimental.Algebra.MonoidAction.Definition where

open import Verification.Conventions

open import Verification.Experimental.Set.Setoid.Definition
open import Verification.Experimental.Data.Prop.Definition
open import Verification.Experimental.Algebra.Monoid.Definition


record hasActionₗ (M : Monoid 𝑖) (A : Setoid 𝑗) : 𝒰 (𝑖 ､ 𝑗) where
  field _↷_ : ⟨ M ⟩ -> ⟨ A ⟩ -> ⟨ A ⟩
        assoc-l-↷ : ∀{m n a} -> (m ⋆ n) ↷ a ∼ m ↷ (n ↷ a)
        _≀↷≀_ : ∀{a b} {m n} -> (a ∼ b) -> (m ∼ n) -> (a ↷ m) ∼ (b ↷ n)

  infixr 30 _↷_
open hasActionₗ {{...}} public

module _ {M : 𝒰 _} {A : 𝒰 _} {{_ : Monoid 𝑖 on M}} {{_ : Setoid 𝑗 on A}} {{_ : hasActionₗ ′ M ′ ′ A ′}} where
  -- _≀↷≀'_ : ∀{a b : ⟨ M ⟩} {m n : ⟨ A ⟩} -> (a ∼ b) -> (m ∼ n) -> (a ↷ m) ∼ (b ↷ n)
  _≀↷≀'_ : ∀{a b : M} {m n : A} -> (a ∼ b) -> (m ∼ n) -> (a ↷ m) ∼ (b ↷ n)
  _≀↷≀'_ = {!!}


record hasDistributiveActionₗ (M : Monoid 𝑖) (A : Setoid 𝑗 :& (isMonoid :, hasActionₗ M)) : 𝒰 (𝑖 ､ 𝑗) where
  private
    ◌A : ⟨ A ⟩
    ◌A = ◌
  field absorb-r-↷ : ∀{m : ⟨ M ⟩} -> m ↷ ◌A ∼ ◌A
  field distr-l-↷ : ∀{m : ⟨ M ⟩} {a b : ⟨ A ⟩} -> m ↷ (a ⋆ b) ∼ ((m ↷ a) ⋆ (m ↷ b))

open hasDistributiveActionₗ {{...}} public



