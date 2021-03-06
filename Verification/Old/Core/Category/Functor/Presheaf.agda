
module Verification.Old.Core.Category.Functor.Presheaf where

open import Verification.Conventions
open import Verification.Old.Core.Category.Definition
open import Verification.Old.Core.Category.Instance.Functor
open import Verification.Old.Core.Category.Instance.Set
open import Verification.Old.Core.Category.Instance.Opposite public

-- ===* Presheaves

-- [Hide]
mirror-Functor : โ{๐ : Category ๐} {๐ : Category ๐} -> Functor ๐ (๐ แตแต) -> Functor (๐ แตแต) ๐
โจ mirror-Functor F โฉ = โจ F โฉ
IFunctor.map (of mirror-Functor F) = map
IFunctor.functoriality-id (of mirror-Functor F) = functoriality-id
IFunctor.functoriality-โ (of mirror-Functor F) = functoriality-โ
IFunctor.functoriality-โฃ (of mirror-Functor F) = functoriality-โฃ

mirror-Nat : โ{๐ : Category ๐} {๐ : Category ๐} -> {F G : Functor ๐ (๐ แตแต)} -> (ฮฑ : Natural F G) -> Natural (mirror-Functor G) (mirror-Functor F)
โจ mirror-Nat a โฉ {x} = โจ a โฉ
INatural.naturality (of mirror-Nat a) = ฮป f -> sym (naturality f)
-- //


-- [Definition]
-- | A presheaf on a category |๐| is simply a functor |๐ แตแต โถ Set|.
PSh : (๐ : Category ๐) -> (๐ : ๐) -> ๐ฐ _
PSh ๐ ๐ = Functor (๐ แตแต) ` Set ๐ `
-- //

