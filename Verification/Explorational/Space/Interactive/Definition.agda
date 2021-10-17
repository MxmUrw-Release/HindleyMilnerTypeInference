
module Verification.Explorational.Space.Interactive.Definition where

open import Verification.Conventions
-- open import Verification.Experimental.Algebra.Monoid.Definition
-- open import Verification.Experimental.Algebra.Monoid.Free.Definition
open import Verification.Experimental.Data.Product.Definition
open import Verification.Experimental.Data.Nat.Free
-- open import Verification.Experimental.Data.Sum.Definition
-- open import Verification.Experimental.Data.Sum.Instance.Functor
open import Verification.Experimental.Data.Universe.Everything
open import Verification.Experimental.Category.Std.Category.Definition
open import Verification.Experimental.Category.Std.Functor.Definition


record isInteractive (𝑗 : 𝔏) (𝒳 : Category 𝑖) : 𝒰 (𝑖 ､ 𝑗 ⁺) where
  field Coord : ⟨ 𝒳 ⟩ -> (𝐔𝐧𝐢𝐯 𝑗)
  field {{isFunctor:Coord}} : isFunctor 𝒳 (𝐔𝐧𝐢𝐯 𝑗) Coord

  field _at_ : (x : ⟨ 𝒳 ⟩) (a : Coord x) -> ⟨ 𝒳 ⟩

  field ↑ : ∀{x y} {a : Coord x}
               -> (f : (x at a) ⟶ y)
               -> ⟨ 𝒳 ⟩

  field inside : ∀{x y} {a : Coord x}
            -> (f : (x at a) ⟶ y)
            -> x ⟶ (↑ f)




