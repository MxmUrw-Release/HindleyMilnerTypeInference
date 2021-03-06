
-- {-# OPTIONS --overlapping-instances #-}

module Verification.Core.Order.Frame where

open import Verification.Conventions
-- open import Verification.Core.Category.Definition
-- open import Verification.Core.Category.Instance.Set.Definition
open import Verification.Core.Order.Preorder
open import Verification.Core.Order.Lattice


data Test : ð°â where

record isFrame (A : Preorder ð :& (hasAllJoins :, hasFiniteMeets)) : ð° (ð âº) where
  field distribute-Frame : â{X} {F : X -> â¨ A â©} {a} -> â F â§ a â â (Î» x -> F x â§ a)

Frame : â(ð) -> ð° (ð âº)
Frame ð = _ :& (isFrame {ð = ð})

-- mytest2 : â{A : ð° ð}
--           {_ : Frame ð on A}
--           -> ð-ð°
-- mytest2 {ð} {A = A} =
--   let X : Frame ð on A
--       X = it
--   in tt

-- unquoteDecl Frame frame = #struct "Frame" (quote isFrame) "A" Frame frame

-- instance
--   backP : {UU : ð° ð} {{U : hasU UU ð ð}} {P : UU -> ð° ð} -> {a : getU U} -> {{p1 : getP U a}} -> {{_ : P (reconstruct U (a , p1))}} -> âi Î» (p1 : getP U a) -> P (reconstruct U (a , p1))
--   backP = makeâi

-- âi Î» () -> P (reconstruct U (a , p1))

-- mytest2 : â{A} {{_ : Preorder ð on A}} -> ð-ð°
-- mytest2 {A = A} =
--   let X : isFrame A
--       X = it
--   in ?

record isFrameHom {A B : ð° ð} {{_ : Frame ð on A}} {{_ : Frame ð on B}}
  (f : (A -> B)
     :& isMonotone
     :& preservesAllJoins :, preservesFiniteMeets)

     : ð° ð where

FrameHom : â (A B : ð° ð) -> {_ : Frame ð on A} {_ : Frame ð on B} -> ð° (ð âº)
FrameHom A B = _ :& isFrameHom {A = A} {B = B}

isCategory:Frame : ICategory (Frame ð) (ð âº , ð)
ICategory.Hom isCategory:Frame A B = FrameHom (â¨ A â©) (â¨ B â©)
ICategory._â£_ isCategory:Frame f g = â¨ f â© â¡ â¨ g â©
ICategory.IEquiv:â£ isCategory:Frame = {!!}
ICategory.id isCategory:Frame = {!!}
ICategory._â_ isCategory:Frame = {!!}
ICategory.unit-l-â isCategory:Frame = {!!}
ICategory.unit-r-â isCategory:Frame = {!!}
ICategory.unit-2-â isCategory:Frame = {!!}
ICategory.assoc-l-â isCategory:Frame = {!!}
ICategory.assoc-r-â isCategory:Frame = {!!}
ICategory._â_ isCategory:Frame = {!!}

-- record isFrameHom2 (A : Frame ð)
--   (B : ð° ð) {{_ : Frame ð on B}}
--   (f : (â¨ A â© -> B) :& isMonotone :& isCompleteJoinPreserving) : ð° (ð ï½¤ ð) where



