

module Verification.Core.Category.Multi.Category.Definition where

open import Verification.Conventions
open import Verification.Core.Data.Fin.Definition
open import Verification.Core.Set.Finite.ReachableSubsets.Definition
open import Verification.Core.Category.Std.Category.Definition
open import Verification.Core.Data.Universe.Definition
open import Verification.Core.Data.Universe.Instance.Category
open import Verification.Core.Order.Preorder
open import Verification.Core.Order.Lattice


--
-- Definition based on
-- https://github.com/agda/agda-categories/blob/master/src/Categories/Multi/Category/Indexed.agda
--
-- (MIT)-License and copyright as described there.
--



module _ {A : ๐ฐ ๐} {B : A -> ๐ฐ ๐} {C : โ{a} -> B a -> ๐ฐ ๐} where
  uncurry : (โ(a : A) -> (b : B a) -> C b) -> โ (x : โ B) -> C (x .snd)
  uncurry f (a , b) = f a b



record isMultiCategory (๐ : ๐) (โณ : ๐ฐ ๐) : ๐ฐ (๐ ๏ฝค ๐ โบ) where
  field Homแต : โ{A : ๐ฐโ} {{_ : isFinite A}} -> (A -> โณ) -> โณ -> ๐ฐ ๐
        idแต : โ{a : โณ} -> Homแต {๐ฝสณ 1} (const a) a
        _โแต_ : โ{A : ๐ฐโ} -> {B : A -> ๐ฐโ}
               -- the finiteness proofs
                  -> {{_ : isFinite A}} -> {{_ : โ{a : A} -> isFinite (B a)}}
               -- the objects
                  -> {x : โณ} -> {y : A -> โณ} {z : โ(a : A) -> B a -> โณ}
               -- the homs
                  -> Homแต y x
                  -> (โ{a : A} -> Homแต (z a) (y a))
                  -> Homแต (uncurry z) x


open isMultiCategory {{...}} public

-- module _ {๐ : ๐ฐ ๐} {{_ : isMultiCategory ๐ ๐}} where
--   compose-l : โ{x : ๐} -> (c : ComposeObjects Hom-MC 2 x) -> Hom-MC (alltails Hom-MC c .fst) (alltails Hom-MC c .snd) x
--   compose-l = {!!}


