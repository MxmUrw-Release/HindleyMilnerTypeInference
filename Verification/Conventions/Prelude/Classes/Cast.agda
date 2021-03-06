

module Verification.Conventions.Prelude.Classes.Cast where

open import Verification.Conventions.Proprelude
open import Verification.Conventions.Prelude.Classes.Anything
open import Verification.Conventions.Prelude.Classes.Structure

--------------------------------------------------------------------
-- ====* Casting between different types

record Cast (A : ๐ฐ ๐) (Pred : A -> ๐ฐ ๐) (B : ๐ฐ ๐) : ๐ฐ (๐ โ ๐ โ ๐) where
  constructor newcast
  field cast : (a : A) -> {{_ : Pred a}} -> B
open Cast {{...}} public

-- #Notation/Rewrite# ยก = {}
-- ยก_ = cast
infixr 60 โฉ_
โฉ_ = cast
`_` = cast

instance
  Cast:A,A : โ{A : ๐ฐ ๐} -> Cast A IAnything A
  Cast.cast Cast:A,A a = a

instance
  Cast:Structure : โ{A : ๐ฐ ๐} {P : A -> ๐ฐ ๐} -> Cast A P (Structure P)
  Cast.cast Cast:Structure a = โฒ a โฒ




