
module Verification.Temporary.Coproduct where

open import Verification.Conventions
open import Verification.Core.Data.Sum.Definition
open import Verification.Core.Data.Universe.Definition
_+_ = _+-ð°_
pattern Î¹â = left
pattern Î¹â = right
[_,_] = either
_â_ = _â-ð°_
infixl 40 _â_
id = id-ð°

postulate
  B C D Î¾ : ð°â
  h : B + Î¾ -> D
  Ï : B -> C + Î¾
  i : C -> D + Î¾
  Pâ : â a -> (Ï â [ i , Î¹â ]) a â¡ (Î¹â â h â Î¹â) a

thm1 : Ï â [ i â [ id , Î¹â â h ] , Î¹â â h ] â¡ Î¹â â h
thm1 = {!!}

thm2 : â a -> (Ï â [ i â [ id , Î¹â â h ] , Î¹â â h ]) a â¡ (Î¹â â h) a
thm2 a with split-+ (Ï a)
... | left (x , g) =
  let -- Pâ : (Ï â i â [ id , Î¹â â h ]) (x) â¡ (Ï â Î¹â â h) a
      -- Pâ = ?

      Pâ : (i â [ id , Î¹â â h ]) (x) â¡ (Î¹â â h) a
      Pâ = {!!}

      Pâ : ([ i â [ id , Î¹â â h ] , Î¹â â h ]) (left x) â¡ (Î¹â â h) a
      Pâ = Pâ
  in {!!}
... | just (x , g) =
  let Pâ : [ i , Î¹â ] (just x) â¡ (Î¹â â h â Î¹â) (a)
      Pâ = transport (Î» j -> [ i , Î¹â ] (g j) â¡ (Î¹â â h â Î¹â) a) (Pâ a)
  in ð-rec (rightâ¢left Pâ)





