
-- {-# OPTIONS --cubical --allow-unsolved-metas #-}

module Verification.Conventions.Prelude.Classes.EquivalenceRelation where

open import Verification.Conventions.Proprelude
open import Verification.Conventions.Prelude.Classes.Operators.Unary
open import Verification.Conventions.Prelude.Classes.Cast
open import Verification.Conventions.Prelude.Classes.Anything
open import Verification.Conventions.Prelude.Data.StrictId
open import Verification.Conventions.Prelude.Classes.Setoid
-- open import Verification.Conventions.Prelude.Data.Product


--------------------------------------------------------------------------------
-- == Equivalence relation
--






-- [Definition]
record isEquivRel {X : ๐ฐ ๐} (_โฃ_ : X -> X -> ๐ฐ ๐) : ๐ฐ (๐ โ ๐) where
  constructor equivRel
  field refl-Equiv : โ{x : X} -> x โฃ x
        sym-Equiv : โ{x y : X} -> x โฃ y -> y โฃ x
        _โ-Equiv_ : โ{x y z : X} -> x โฃ y -> y โฃ z -> x โฃ z

  infixl 30 _โ-Equiv_
open isEquivRel {{...}} public
-- //

-- module _ {X : ๐ฐ ๐} {_โฃ_ : X -> X -> ๐ฐ ๐} {{_ : isEquivRel _โฃ_}} where
--   instance
--     Notation-Inverse:Equiv : {x y : X} -> Notation-Inverse (x โฃ y) (y โฃ x)
--     Notation-Inverse:Equiv Notation-Inverse.โปยน = sym




infixl 10 >><<-syntax
>><<-syntax : โ(A : ๐ฐ ๐) -> A -> A
>><<-syntax A a = a
syntax >><<-syntax A a = a >> A <<

infixl 10 โชโซ-syntax
โชโซ-syntax : โ{A : ๐ฐ ๐} {B : ๐ฐ ๐} -> A -> (A -> B) -> B
โชโซ-syntax a f = f a
syntax โชโซ-syntax a f = a โช f โซ


module _ {A : ๐ฐ ๐} {{_ : isSetoid {๐} A}} where
  both : {a b c d : A} -> (a โผ c) -> (b โผ d) -> a โผ b -> c โผ d
  both p q r = p โปยน โ r โ q


_โโผโ_ = both






  -- setoid _โฃ_ refl-โฃ (ฮป {refl-โฃ -> refl-โฃ}) (ฮป{refl-โฃ q -> q})

-- instance
-- module _ where
  -- isEquivRel:Path : {X : ๐ฐ ๐} -> isEquivRel (ฮป (x y : X) -> x โก y)
  -- isEquivRel.refl  isEquivRel:Path = refl-Path
  -- isEquivRel.sym   isEquivRel:Path = sym-Path
  -- isEquivRel._โ_   isEquivRel:Path = trans-Path


-- module _ {X : ๐ฐ ๐} (_โผ_ : X -> X -> ๐ฐ ๐) where
--   record hasTransport : ๐ฐ ๐ where
--     field transport : โ{a b : X} (a โผ b) -> 



-- module _ {X : ๐ฐ ๐} {_โผ_ : X -> X -> ๐ฐ ๐} {{_ : isEquivRel _โผ_}} where
--   fromPath : โ{a b : X} -> a โก b -> a โผ b
--   fromPath {a = a} p = transport (ฮป i -> a โผ p i) refl

-- sym-Id : โ{X : ๐ฐ ๐} {x y : X} -> Id x y -> Id y x
-- sym-Id {x = x} {y = y} p = J-Id (ฮป y _ -> Id y x) refl-Id p

{-
trans-Id : โ{X : ๐ฐ ๐} {x y z : X} -> Id x y -> Id y z -> Id x z
trans-Id {x = x} {y} {z} p q = J-Id (ฮป z _ -> Id x z) p q

instance
-- module _ where
  isEquivRel:Id : {X : ๐ฐ ๐} -> isEquivRel (ฮป (x y : X) -> Id x y)
  isEquivRel.refl isEquivRel:Id = refl-Id
  isEquivRel.sym isEquivRel:Id = sym-Id
  isEquivRel._โ_ isEquivRel:Id = trans-Id

module _ {X : ๐ฐ ๐} {x : X} where
  record โId (P : (y : X) -> Id x y -> ๐ฐ ๐) : ๐ฐ (๐ โ ๐) where
    constructor idproof
    field getProof : โ{y : X} -> (p : Id x y) -> P y p

  open โId public

  J-โId : โ{P : (y : X) -> Id x y -> ๐ฐ ๐} -> (d : P x refl-Id) -> โId P
  J-โId {P = P} d = idproof $ ฮป p -> (J-Id P d p)

congโ-Id-helper : โ{A : ๐ฐ ๐} {B : ๐ฐ ๐} {C : ๐ฐ ๐} -> {a1 : A} {b1 : B} -> (f : A -> B -> C)
                 -> โId (ฮป a2 (p : Id a1 a2) -> โId (ฮป b2 (q : Id b1 b2) -> Id (f a1 b1) (f a2 b2)))
congโ-Id-helper f = J-โId (J-โId refl-Id)

congโ-Id : โ{A : ๐ฐ ๐} {B : ๐ฐ ๐} {C : ๐ฐ ๐} -> {a1 a2 : A} {b1 b2 : B} -> (f : A -> B -> C) -> (Id a1 a2) -> (Id b1 b2) -> Id (f a1 b1) (f a2 b2)
congโ-Id f p q = congโ-Id-helper f .getProof p .getProof q
-}

-- instance
-- module _ where
  -- isEquivRel:StrId : {X : ๐ฐ ๐} -> isEquivRel (ฮป (x y : X) -> StrId x y)
  -- isEquivRel.refl isEquivRel:StrId = refl-StrId
  -- isEquivRel.sym isEquivRel:StrId refl-StrId = refl-StrId
  -- (isEquivRel:StrId isEquivRel.โ refl-StrId) q = q


instance
  Cast:โกStr : โ{X : ๐ฐ ๐} -> โ{a b : X} -> Cast (a โก-Str b) IAnything (a โก b)
  Cast.cast Cast:โกStr refl-StrId = refl-Path

โก-Strโโก : โ{X : ๐ฐ ๐} -> โ{a b : X} -> (a โก-Str b) -> (a โก b)
โก-Strโโก refl-StrId = refl-Path

โกโโก-Str : โ{X : ๐ฐ ๐} -> โ{a b : X} -> (a โก b) -> (a โก-Str b)
โกโโก-Str {a = a} {b} p = transport (ฮป i -> a โก-Str (p i)) refl-StrId

-- rightโขleft-Str : โ{a : A}

โก-change-iso : โ{X : ๐ฐ ๐} -> โ{a b : X} -> (p : a โก-Str b) -> (โกโโก-Str (โก-Strโโก p) โก p)
โก-change-iso refl-StrId = transportRefl refl-StrId

--------------------------------------------------------------------------------
-- === path syntax

module _ {A : ๐ฐ ๐} {{_ : isSetoid {๐} A}} where
  _โฃโจ_โฉ_ : (x : A) {y : A} {z : A} โ x โผ y โ y โผ z โ x โผ z
  _ โฃโจ xโกy โฉ yโกz = xโกy โ yโกz

  โฃโจโฉ-syntax : (x : A) {y z : A} โ x โผ y โ y โผ z โ x โผ z
  โฃโจโฉ-syntax = _โฃโจ_โฉ_
  infixr 2 โฃโจโฉ-syntax
  infix  3 _โ
  infixr 2 _โฃโจ_โฉ_

  _โ : (x : A) โ x โผ x
  _ โ = refl


-- new syntax with โผ
module _ {A : ๐ฐ ๐} {{_ : isSetoid {๐} A}} where
  _โจ_โฉ-โผ_ : (x : A) {y : A} {z : A} โ x โผ y โ y โผ z โ x โผ z
  _ โจ xโกy โฉ-โผ yโกz = xโกy โ yโกz

  โจโฉ-โผ-syntax : (x : A) {y z : A} โ x โผ y โ y โผ z โ x โผ z
  โจโฉ-โผ-syntax = _โจ_โฉ-โผ_
  infixr 2 โจโฉ-โผ-syntax
  infixr 2 _โจ_โฉ-โผ_

  infix  3 _โ-โผ

  _โ-โผ : (x : A) โ x โผ x
  _ โ-โผ = refl


module _ {A : ๐ฐ ๐} where
  _โจ_โฉ-โก_ : (x : A) {y : A} {z : A} โ x โก y โ y โก z โ x โก z
  _ โจ xโกy โฉ-โก yโกz = trans-Path xโกy yโกz

  โจโฉ-โก-syntax : (x : A) {y z : A} โ x โก y โ y โก z โ x โก z
  โจโฉ-โก-syntax = _โจ_โฉ-โก_
  infixr 2 โจโฉ-โก-syntax
  infixr 2 _โจ_โฉ-โก_

  infix  3 _โ-โก

  _โ-โก : (x : A) โ x โก x
  _ โ-โก = refl-โก

module _ {A : ๐ฐ ๐} where
  _โจ_โฉ-โฃ_ : (x : A) {y : A} {z : A} โ x โฃ y โ y โฃ z โ x โฃ z
  _ โจ xโฃy โฉ-โฃ yโฃz =  xโฃy โ-โฃ yโฃz

  โจโฉ-โฃ-syntax : (x : A) {y z : A} โ x โฃ y โ y โฃ z โ x โฃ z
  โจโฉ-โฃ-syntax = _โจ_โฉ-โฃ_
  infixr 2 โจโฉ-โฃ-syntax
  infixr 2 _โจ_โฉ-โฃ_

  infix  3 _โ-โฃ

  _โ-โฃ : (x : A) โ x โฃ x
  _ โ-โฃ = refl-โฃ
