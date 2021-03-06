
{-# OPTIONS --cubical --allow-unsolved-metas #-}

module Verification.Old.Core.Order.Lattice where

open import Verification.Conventions
open import Verification.Old.Core.Category.Definition
open import Verification.Old.Core.Category.Instance.Set.Definition
open import Verification.Old.Core.Order.Partialorder
open import Verification.Old.Core.Order.Preorder


record hasâ¥-Preorder (A : ð° ð) {{_ : IPreorder A}} : ð° ð where
-- record hasâ¥-Preorder (A : Preorder ð) : ð° ð where
  field â¥ : A
        initial-â¥ : â(a : A) -> â¥ â¤ a

open hasâ¥-Preorder {{...}} public

record hasâ¨-Preorder (A : ð° ð) {{_ : IPreorder A}} : ð° ð where
  field _â¨_ : A -> A -> A
        Î¹â-â¨ : {a b : A} -> a â¤ a â¨ b
        Î¹â-â¨ : {a b : A} -> b â¤ a â¨ b
        [_,_]-â¨ : {a b c : A} -> a â¤ c -> b â¤ c -> a â¨ b â¤ c

  infixl 60 _â¨_

open hasâ¨-Preorder {{...}} public

module _ {A : ð° ð} {{_ : IPreorder A}} {{_ : hasâ¥-Preorder A}} {{_ : hasâ¨-Preorder A}} where
  â : Vec A n -> A
  â [] = â¥
  â (a â· as) = a â¨ (â as)


-- record IJoinLattice (A : ð° ð) : ð° (ð âº) where
--   field {{Impl}} : IPartialorder A
--         _â¨_ : A -> A -> A
--         Î¹â-â¨ : {a b : A} -> a â¤ a â¨ b
--         Î¹â-â¨ : {a b : A} -> b â¤ a â¨ b
--         â¥ : A
--         initial-â¥ : â{a : A} -> â¥ â¤ a

--   infixl 60 _â¨_

-- unquoteDecl JoinLattice joinLattice = #struct "JLat" (quote IJoinLattice) "A" JoinLattice joinLattice

-- open IJoinLattice {{...}} public

-- instance
--   IJoinLattice:â¤ : IJoinLattice (Lift {j = ð} ð-ð°)
--   IJoinLattice.Impl IJoinLattice:â¤ = IPartialorder:â¤
--   IJoinLattice._â¨_ IJoinLattice:â¤ = Î» _ _ -> â¥ tt
--   IJoinLattice.Î¹â-â¨ IJoinLattice:â¤ = â¥ tt
--   IJoinLattice.Î¹â-â¨ IJoinLattice:â¤ = â¥ tt
--   IJoinLattice.â¥ IJoinLattice:â¤ = â¥ tt
--   IJoinLattice.initial-â¥ IJoinLattice:â¤ = â¥ tt





