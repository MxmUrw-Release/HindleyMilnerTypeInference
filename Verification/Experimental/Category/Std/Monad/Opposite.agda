
module Verification.Experimental.Category.Std.Monad.Opposite where

open import Verification.Conventions

open import Verification.Experimental.Set.Setoid
open import Verification.Experimental.Category.Std.Category.Definition
open import Verification.Experimental.Category.Std.Category.Opposite
open import Verification.Experimental.Category.Std.Functor.Definition
open import Verification.Experimental.Category.Std.Functor.Instance.Category
open import Verification.Experimental.Category.Std.Natural.Definition
open import Verification.Experimental.Category.Std.Category.Instance.Category
open import Verification.Experimental.Category.Std.Monad.Definition



module _ {𝒞 : Category 𝑖} where
  OpFunctor : (Functor 𝒞 𝒞) -> Functor (𝒞 ᵒᵖ) (𝒞 ᵒᵖ)
  OpFunctor F = ⟨ F ⟩ since P
    where
      P : isFunctor (𝒞 ᵒᵖ) (𝒞 ᵒᵖ) ⟨ F ⟩
      isFunctor.map P = map
      isFunctor.isSetoidHom:map P = it
      isFunctor.functoriality-id P = functoriality-id
      isFunctor.functoriality-◆ P = functoriality-◆

  -- note, this does not work. We do have that "F ᵒᵖ" is a comonad!
  OpMonad : ∀{F : 𝒞 ⟶ 𝒞} -> {{_ : isMonad F}} -> isMonad (OpFunctor F)
  OpMonad = {!!}




