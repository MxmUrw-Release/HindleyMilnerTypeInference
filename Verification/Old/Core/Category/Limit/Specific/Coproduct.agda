
module Verification.Old.Core.Category.Limit.Specific.Coproduct where

open import Verification.Conventions
open import Verification.Old.Core.Category.Definition
open import Verification.Old.Core.Category.Instance.Cat.Products



module _ {X : ๐ฐ ๐} {{_ : isCategory X ๐}} where
  record isCoproduct (a b x : X) : ๐ฐ (๐ ๏ฝค ๐) where
    field ฮนโ : a โถ x
          ฮนโ : b โถ x
          [_,_] : {c : X} -> (f : a โถ c) (g : b โถ c) -> (x โถ c)
          reduce-+-โ : โ{c : X} -> {f : a โถ c} -> {g : b โถ c} -> ฮนโ โ [ f , g ] โฃ f
          reduce-+-โ : โ{c : X} -> {f : a โถ c} -> {g : b โถ c} -> ฮนโ โ [ f , g ] โฃ g
          expand-+   : โ{c : X} -> {f : x โถ c} -> f โฃ [ ฮนโ โ f , ฮนโ โ f ]

  open isCoproduct {{...}} public
unquoteDecl hasCoproduct hascoproduct = #struct "isCoprod" (quote isCoproduct) "x" hasCoproduct hascoproduct

record hasCoproducts (๐ : Category ๐) : ๐ฐ ๐ where
  field _+_ : (a b : โจ ๐ โฉ) -> โจ ๐ โฉ
        {{isCoproduct:+}} : โ{a b} -> isCoproduct a b (a + b)
  infixl 100 _+_
open hasCoproducts {{...}} public

module _ {๐ : Category ๐} {{P : hasCoproducts ๐}} where
  Functor:+ : Functor (๐ ร-Cat ๐) ๐
  โจ Functor:+ โฉ (a , b) = a + b
  IFunctor.map (of Functor:+) (f , g) = [ f โ ฮนโ , g โ ฮนโ ]
  IFunctor.functoriality-id (of Functor:+) = {!!}
  IFunctor.functoriality-โ (of Functor:+) = {!!}
  IFunctor.functoriality-โฃ (of Functor:+) = {!!}

  map-+-r : โ{a b c : โจ ๐ โฉ} -> (f : a โถ b) -> (c + a) โถ (c + b)
  map-+-r f = map {{of Functor:+}} (id , f)




