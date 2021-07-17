
module Verification.Experimental.Category.Std.Category.Construction.Id where

open import Verification.Conventions
open import Verification.Experimental.Set.Setoid
open import Verification.Experimental.Data.Product.Definition
-- open import Verification.Experimental.Data.Fin.Definition
-- open import Verification.Experimental.Algebra.Monoid.Definition
open import Verification.Experimental.Category.Std.Category.Definition
open import Verification.Experimental.Category.Std.Functor.Definition
open import Verification.Experimental.Category.Std.Morphism.Iso



module _ {A : 𝒰 𝑖} where
  sym-≣ : ∀{a b : A} -> a ≣ b -> b ≣ a
  sym-≣ refl-≣ = refl-≣

  _∙-≣_ : ∀{a b c : A} -> a ≣ b -> b ≣ c -> a ≣ c
  _∙-≣_ refl-≣ q = q

  isSetoid:byId : isSetoid A
  isSetoid:byId = setoid _≣_ refl-≣ sym-≣ _∙-≣_

private
  module _ {A : 𝒰 𝑖} where
    lem-1 : ∀{a b : A} {p : a ≣ b} -> p ∙-≣ refl-≣ ≣ p
    lem-1 {p = refl-≣} = refl-≣

    lem-2 : ∀{a b c d : A} {p : a ≣ b} {q : b ≣ c} {r : c ≣ d} -> (p ∙-≣ q) ∙-≣ r ≣ p ∙-≣ (q ∙-≣ r)
    lem-2 {p = refl-≣} = refl-≣

    lem-3 : ∀{a b c : A} -> {p₀ p₁ : a ≣ b} {q₀ q₁ : b ≣ c} -> (p₀ ≣ p₁) -> (q₀ ≣ q₁) -> (p₀ ∙-≣ q₀ ≣ p₁ ∙-≣ q₁)
    lem-3 refl-≣ refl-≣ = refl-≣


module _ {A : 𝒰 𝑖} where

  isCategory:byId : isCategory A
  isCategory.Hom isCategory:byId          = _≣_
  isCategory.isSetoid:Hom isCategory:byId = isSetoid:byId
  isCategory.id isCategory:byId           = refl-≣
  isCategory._◆_ isCategory:byId          = _∙-≣_
  isCategory.unit-l-◆ isCategory:byId     = refl-≣
  isCategory.unit-r-◆ isCategory:byId     = lem-1
  isCategory.unit-2-◆ isCategory:byId     = refl-≣
  isCategory.assoc-l-◆ isCategory:byId {f = p} = lem-2 {p = p}
  isCategory.assoc-r-◆ isCategory:byId {f = p} = sym-≣ (lem-2 {p = p})
  isCategory._◈_ isCategory:byId          = lem-3



