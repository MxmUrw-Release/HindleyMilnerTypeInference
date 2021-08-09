
module Verification.Experimental.Data.Universe.Property.EpiMono where

open import Verification.Conventions

open import Verification.Experimental.Set.Setoid.Definition
open import Verification.Experimental.Category.Std.Category.Definition
open import Verification.Experimental.Category.Std.Morphism.Iso
open import Verification.Experimental.Category.Std.Morphism.EpiMono
open import Verification.Experimental.Data.Universe.Definition
open import Verification.Experimental.Data.Universe.Instance.Category
open import Verification.Experimental.Set.Function.Injective

module _ {A B : 𝒰 𝑖} where
  construct-isMono-𝐔𝐧𝐢𝐯 : ∀{f : A -> B} -> isInjective f -> isMono f
  isMono.cancel-mono (construct-isMono-𝐔𝐧𝐢𝐯 p) αf∼βf = λ i a → cancel-injective (λ j -> αf∼βf j a) i
    where instance _ = p

  destruct-isMono-𝐔𝐧𝐢𝐯 : ∀{f : A -> B} -> isMono f -> isInjective f
  isInjective.cancel-injective (destruct-isMono-𝐔𝐧𝐢𝐯 {f} p) {a} {b} fa∼fb = λ i -> P₁ i tt
    where
      instance _ = p

      α : ⊤-𝒰 {𝑖} -> A
      α = const a

      β : ⊤-𝒰 {𝑖} -> A
      β = const b

      P₀ : α ◆ f ≡ β ◆ f
      P₀ = λ i _ → fa∼fb i

      P₁ : α ≡ β
      P₁ = cancel-mono P₀





