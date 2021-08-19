
module Verification.Experimental.Category.Std.Fibration.GrothendieckConstruction.Op.Definition where

open import Verification.Conventions

open import Verification.Experimental.Set.Setoid.Definition
open import Verification.Experimental.Category.Std.Category.Definition
open import Verification.Experimental.Category.Std.Category.Opposite
open import Verification.Experimental.Category.Std.Functor.Definition
open import Verification.Experimental.Category.Std.Category.Instance.Category
open import Verification.Experimental.Category.Std.Functor.Instance.Category
open import Verification.Experimental.Category.Std.Natural.Definition
open import Verification.Experimental.Category.Std.Morphism.Iso
-- open import Verification.Experimental.Category.Std.Natural.Instance.Category

record hasGrothendieckSumOp (A : 𝒰 𝑖) (B : 𝒰 𝑗) : 𝒰 (𝑖 ､ 𝑗) where
  field ⨊ᵒᵖ : A -> B

open hasGrothendieckSumOp {{...}} public

module _ {𝒞 : Category 𝑖} where


  record ⨊ᵒᵖ-𝐂𝐚𝐭 (F : Functor (𝒞 ᵒᵖ) (𝐂𝐚𝐭 𝑗)) : 𝒰 ((𝑖 ⌄ 0) ⊔ (𝑗 ⌄ 0)) where
    constructor _,_
    field base : ⟨ 𝒞 ⟩
    field fib : ⟨ ⟨ F ⟩ base ⟩

  open ⨊ᵒᵖ-𝐂𝐚𝐭 public

  instance
    hasGrothendieckSumOp:𝐂𝐚𝐭 : hasGrothendieckSumOp (Functor (𝒞 ᵒᵖ) (𝐂𝐚𝐭 𝑗)) _
    hasGrothendieckSumOp:𝐂𝐚𝐭 = record { ⨊ᵒᵖ = ⨊ᵒᵖ-𝐂𝐚𝐭 }


  module _ {F : Functor (𝒞 ᵒᵖ) (𝐂𝐚𝐭 𝑗)} where
    private
      instance
        isCategory:F : ∀{b : ⟨ 𝒞 ⟩} -> isCategory (⟨ ⟨ F ⟩ b ⟩)
        isCategory:F {b} = of ⟨ F ⟩ b

      instance
        isSetoid:F : ∀{b : ⟨ 𝒞 ⟩} {x y : ⟨ ⟨ F ⟩ b ⟩} -> isSetoid (x ⟶ y)
        isSetoid:F {b} = isSetoid:Hom {{of ⟨ F ⟩ b}}

    record Hom-⨊ᵒᵖ-𝐂𝐚𝐭 (a b : ⨊ᵒᵖ F) : 𝒰 ((𝑖 ⌄ 1) ､ (𝑗 ⌄ 1)) where
      constructor _,_
      field base : base a ⟶ base b
      field fib : Hom (fib a) (⟨ map base ⟩ (fib b))

    open Hom-⨊ᵒᵖ-𝐂𝐚𝐭 public

    module _ {a b : ⨊ᵒᵖ F} where
      record _∼-Hom-⨊ᵒᵖ-𝐂𝐚𝐭_ (f g : Hom-⨊ᵒᵖ-𝐂𝐚𝐭 a b) : 𝒰 (𝑖 ⌄ 2 ､ 𝑗 ⌄ 2) where
        constructor _,_
        field ∼-base : base f ∼ base g
        field ∼-fib : (fib f) ◆ (⟨ ⟨ cong-∼ ∼-base ⟩ ⟩ {_}) ∼ fib g


      instance
        isSetoid:Hom-⨊ᵒᵖ-𝐂𝐚𝐭 : isSetoid (Hom-⨊ᵒᵖ-𝐂𝐚𝐭 a b)
        isSetoid:Hom-⨊ᵒᵖ-𝐂𝐚𝐭 = setoid _∼-Hom-⨊ᵒᵖ-𝐂𝐚𝐭_ {!!} {!!} {!!}



    instance
      isCategory:⨊ᵒᵖ-𝐂𝐚𝐭 : isCategory (⨊ᵒᵖ-𝐂𝐚𝐭 F)
      isCategory.Hom isCategory:⨊ᵒᵖ-𝐂𝐚𝐭          = Hom-⨊ᵒᵖ-𝐂𝐚𝐭
      isCategory.isSetoid:Hom isCategory:⨊ᵒᵖ-𝐂𝐚𝐭 = isSetoid:Hom-⨊ᵒᵖ-𝐂𝐚𝐭
      isCategory.id isCategory:⨊ᵒᵖ-𝐂𝐚𝐭           = {!!}
      isCategory._◆_ isCategory:⨊ᵒᵖ-𝐂𝐚𝐭          = {!!}
      isCategory.unit-l-◆ isCategory:⨊ᵒᵖ-𝐂𝐚𝐭     = {!!}
      isCategory.unit-r-◆ isCategory:⨊ᵒᵖ-𝐂𝐚𝐭     = {!!}
      isCategory.unit-2-◆ isCategory:⨊ᵒᵖ-𝐂𝐚𝐭     = {!!}
      isCategory.assoc-l-◆ isCategory:⨊ᵒᵖ-𝐂𝐚𝐭    = {!!}
      isCategory.assoc-r-◆ isCategory:⨊ᵒᵖ-𝐂𝐚𝐭    = {!!}
      isCategory._◈_ isCategory:⨊ᵒᵖ-𝐂𝐚𝐭          = {!!}



