

module Verification.Conventions.Prelude.Classes.Operators.Unary where

open import Verification.Conventions.Proprelude

record Notation-Absolute (A : ๐ฐ ๐) (B : ๐ฐ ๐) : (๐ฐ (๐ โ ๐)) where
  field โฃ_โฃ : A -> B
  infix 50 โฃ_โฃ

open Notation-Absolute {{...}} public

record Notation-Inverse (A : ๐ฐ ๐) (B : ๐ฐ ๐) : ๐ฐ (๐ โ ๐) where
  field _โปยน : A -> B
  infix 300 _โปยน
open Notation-Inverse {{...}} public

--------------------------------------------------------------------
-- ====* Join notation

record IMultiJoinable (X : ๐ฐ ๐) (V : ๐ฐ ๐) : ๐ฐ (๐ โ ๐ โบ) where
  field โฉ : X -> V

open IMultiJoinable {{...}} public




