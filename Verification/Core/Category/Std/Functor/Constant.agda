
module Verification.Core.Category.Std.Functor.Constant where

open import Verification.Conventions

open import Verification.Core.Set.Setoid.Definition
open import Verification.Core.Category.Std.Category.Definition
open import Verification.Core.Category.Std.Functor.Definition

--------------------------------------------------------------
-- constant functor
module _ {๐ : Category ๐} {๐ : Category ๐} where
  isFunctor:const : {x : โจ ๐ โฉ} -> isFunctor ๐ ๐ (const x)
  isFunctor.map (isFunctor:const {x})              = const id
  isFunctor.isSetoidHom:map (isFunctor:const {x})  = record { cong-โผ = const refl }
  isFunctor.functoriality-id (isFunctor:const {x}) = refl
  isFunctor.functoriality-โ (isFunctor:const {x})  = unit-2-โ โปยน

  Const : (x : โจ ๐ โฉ) -> Functor ๐ ๐
  Const x = const x since isFunctor:const



--------------------------------------------------------------
-- definition via structureOn

-- this probably doesn't work because then the instance resolution
-- gets confused with other functors (since `const` is to un-unique as function)
{-
module _ {A : ๐ฐ ๐} {B : ๐ฐ ๐} where
  module _ (b : B) where
    ๐๐๐๐ ๐กแต : A -> B
    ๐๐๐๐ ๐กแต _ = b

    macro ๐๐๐๐ ๐ก = #structureOn ๐๐๐๐ ๐กแต

  module _ {{_ : isCategory {๐โ} A}} {{_ : isCategory {๐โ} B}} {b : B} where
    instance
      isFunctor:๐๐๐๐ ๐ก : isFunctor โฒ A โฒ โฒ B โฒ (๐๐๐๐ ๐ก b)
      isFunctor:๐๐๐๐ ๐ก = isFunctor:const
-}







