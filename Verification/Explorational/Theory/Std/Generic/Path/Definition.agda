
module Verification.Explorational.Theory.Std.Generic.Path.Definition where

open import Verification.Conventions hiding (_โ_)
open import Verification.Core.Data.List.Variant.Binary.Natural
open import Verification.Core.Data.Sum.Definition
open import Verification.Core.Category.Std.Category.Definition

record PathsAxiom (๐ : ๐) : ๐ฐ (๐ โบ) where
  field Conโ : ๐ฐ ๐
  field Conโ : ๐ฐ ๐

open PathsAxiom public

module _ {๐จ : PathsAxiom ๐} where
  data Paths (B : ๐ฐ ๐) : ๐ฐ ๐ where
    _0-โง_ : Paths B
    _1-โง_ : Paths B
    _+-โง_ : (x y : Paths B) -> Paths B
    inclโ : Conโ ๐จ -> Paths B
    inclโ : Conโ ๐จ -> Paths B -> Paths B
    _โ-โง_ : (x y : Paths B) -> Paths B

  data โฎPaths (B : ๐ฐ ๐) : ๐ฐ ๐ where

  -- _โ_ : โ{A B : ๐ฐ ๐} -> Paths A -> Paths B -> Paths (A + B)
  -- _โ_ t s = {!!}






