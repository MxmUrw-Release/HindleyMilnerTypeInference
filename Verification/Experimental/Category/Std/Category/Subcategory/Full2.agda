
module Verification.Experimental.Category.Std.Category.Subcategory.Full2 where

open import Verification.Experimental.Conventions

open import Verification.Experimental.Set.Setoid
open import Verification.Experimental.Set.Discrete
open import Verification.Experimental.Category.Std.Category.Definition
open import Verification.Experimental.Category.Std.Functor.Definition


module _ {𝒞 : 𝒰 𝑖} {{_ : isCategory {𝑗} 𝒞}} {X : 𝒰 𝑘} (ι : X -> 𝒞) where

  isCategory:FullSubcategory : isCategory {𝑗} X
  isCategory.Hom isCategory:FullSubcategory = λ a b -> Hom (ι a) (ι b)
  isCategory.isSetoid:Hom isCategory:FullSubcategory = {!!}
  isCategory.id isCategory:FullSubcategory = {!!}
  isCategory._◆_ isCategory:FullSubcategory = {!!}
  isCategory.unit-l-◆ isCategory:FullSubcategory = {!!}
  isCategory.unit-r-◆ isCategory:FullSubcategory = {!!}
  isCategory.unit-2-◆ isCategory:FullSubcategory = {!!}
  isCategory.assoc-l-◆ isCategory:FullSubcategory = {!!}
  isCategory.assoc-r-◆ isCategory:FullSubcategory = {!!}
  isCategory._◈_ isCategory:FullSubcategory = {!!}






