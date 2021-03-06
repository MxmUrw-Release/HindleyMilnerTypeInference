
-- {-# OPTIONS --cubical --allow-unsolved-metas #-}

module Verification.Conventions.Prelude.Data.StrictId where

open import Verification.Conventions.Proprelude

data StrId {a} {A : π° a} (x : A) : A β π° a where
  instance refl-StrId : StrId x x

{-# BUILTIN EQUALITY StrId #-}

pattern refl-β£ = refl-StrId

infix 4 _β£_
_β£_ = StrId
_β‘-Str_ = StrId


_β’-Str_ : β{X : π° π} -> (a b : X) -> π° π
a β’-Str b = Β¬ StrId a b

transport-Str : β{A B : π° π} -> (p : A β‘-Str B) -> (a : A) -> B
transport-Str refl-StrId a = a

cong-Str : β{A : π° π} {B : π° π} {a b : A} -> (f : A -> B) -> (a β‘-Str b) -> (f a β‘-Str f b)
cong-Str f refl-StrId = refl-StrId

congβ-Str : β{A : π° π} {B : π° π} {X : π° π} {a b : A} {c d : B} -> (f : A -> B -> X) -> (a β‘-Str b) -> (c β‘-Str d) -> (f a c β‘-Str f b d)
congβ-Str f refl-StrId refl-StrId = refl-StrId

subst-Str : β{A : π° π} {x y : A} (B : A β π° π) (p : x β£ y) β B x β B y
subst-Str B p pa = transport-Str (cong-Str B p) pa

