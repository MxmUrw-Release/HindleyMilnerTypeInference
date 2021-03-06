
{-# OPTIONS --cubical --allow-unsolved-metas #-}

module Verification.Old.Core.Algebra.Basic.Abelian where

open import Verification.Conventions
open import Verification.Old.Core.Category.Definition
open import Verification.Old.Core.Category.Instance.Set.Definition
open import Verification.Old.Core.Algebra.Basic.Group
open import Verification.Old.Core.Algebra.Basic.Monoid


-- ===* Abelian Groups
-- | We define abelian groups by taking the same definition as for groups, but using additive instead of multiplicative notation.

-- [Hide]

-- record Hide (A : ๐ฐ ๐) : ๐ฐ ๐ where
--   constructor hide
--   field unhide : A
-- open Hide public

-- map-Hide : โ{A : ๐ฐ ๐} {B : ๐ฐ ๐} -> (A -> B) -> (Hide A -> Hide B)
-- map-Hide f (hide x) = hide (f x)

-- instance
--   IFunctor:Hide : IFunctor (โ ๐ฐ ๐) (โ ๐ฐ ๐) Hide
--   IFunctor.map IFunctor:Hide = map-Hide
--   IFunctor.functoriality-id IFunctor:Hide = {!!}
--   IFunctor.functoriality-โ IFunctor:Hide = {!!}



record IAbelian (A : ๐ฐ ๐) : ๐ฐ ๐ where
  field AsMult : IMonoid A
        AsMultInv : IMonoid:WithInverse A {{AsMult}}
open IAbelian {{...}} public

module _ {A : ๐ฐ ๐} {{#A : IAbelian A}} where
  infixl 30 _+_
  _+_ : A -> A -> A
  _+_ a b = _โ_ {{AsMult}} a b

  -_ : A -> A
  -_ a = _โปยน-Monoid {{AsMult}} {{AsMultInv}} a

  ๐ถ : A
  ๐ถ = ๐ท {{AsMult}}

unquoteDecl Abelian abelian = #struct "Ab" (quote IAbelian) "A" Abelian abelian


instance
  INotation:Reinterpret:Abelian : INotation:Reinterpret (Abelian ๐) (Group ๐)
  โจ INotation:Reinterpret.reinterpret INotation:Reinterpret:Abelian A โฉ = โจ A โฉ
  IGroup.Impl1 (of (INotation:Reinterpret.reinterpret INotation:Reinterpret:Abelian A)) = AsMult
  IGroup.Impl2 (of (INotation:Reinterpret.reinterpret INotation:Reinterpret:Abelian A)) = AsMultInv

-- IAbelianHom : (M : Abelian ๐) (N : Abelian ๐) (f : โจ M โฉ -> โจ N โฉ) -> ๐ฐ (๐ โ ๐)
-- IAbelianHom M N f = IGroupHom (reinterpret M) (reinterpret N) f

record IAbelianHom (M : Abelian ๐) (N : Abelian ๐) (f : โจ M โฉ -> โจ N โฉ) : ๐ฐ (๐ โ ๐) where
  field unwrap : IGroupHom (reinterpret M) (reinterpret N) f
open IAbelianHom public

unquoteDecl AbelianHom abelianHom = #struct "AbHom" (quote IAbelianHom) "f" AbelianHom abelianHom

instance
  INotation:Reinterpret:AbelianHom : โ{M : Abelian ๐} {N : Abelian ๐} -> INotation:Reinterpret (AbelianHom M N) (GroupHom (reinterpret M) (reinterpret N))
  INotation:Reinterpret.reinterpret (INotation:Reinterpret:AbelianHom {M = M} {N = N}) f = groupHom {M = (reinterpret M)} {N = (reinterpret N)} โจ f โฉ {{(of f) .unwrap}}

-- AbelianHom : (M : Abelian ๐) (N : Abelian ๐) -> ๐ฐ (๐ โ ๐)
-- AbelianHom M N = MonoidHom ((โ โจ M โฉ) {{AsMult}}) ((โ โจ N โฉ) {{AsMult}})

  -- โจ INotation:Reinterpret.reinterpret INotation:Reinterpret:Abelian A โฉ = โจ A โฉ
  -- IMonoid.๐ท (of (of (INotation:Reinterpret.reinterpret INotation:Reinterpret:Abelian A))) = ๐ถ
  -- IMonoid._โ_ (of (of (INotation:Reinterpret.reinterpret INotation:Reinterpret:Abelian A))) = _+_
  -- of (INotation:Reinterpret.reinterpret INotation:Reinterpret:Abelian A) โปยน-Group = -_

{-

record IAbelian (A : ๐ฐ ๐) : ๐ฐ ๐ where
  field instance asGroup : IGroup (Hide A)
  ๐ถ : A
  ๐ถ = unhide ๐ท
  -_ : A -> A
  - x = unhide ((hide x) โปยน)
  _+_ : A -> A -> A
  a + b = unhide (hide a โ hide b)

open IAbelian {{...}} public

IAbelianHom : (M : Abelian ๐) (N : Abelian ๐) (f : โจ M โฉ -> โจ N โฉ) -> ๐ฐ (๐ โ ๐)
IAbelianHom M N f = IMonoidHom (โ Hide (โจ M โฉ)) (โ Hide โจ N โฉ) (map-Hide f)

AbelianHom : (M : Abelian ๐) (N : Abelian ๐) -> ๐ฐ (๐ โ ๐)
AbelianHom M N = MonoidHom (โ Hide (โจ M โฉ)) (โ Hide โจ N โฉ)

abelianHom : {M : Abelian ๐} {N : Abelian ๐} (f : โจ M โฉ -> โจ N โฉ) {{_ : IAbelianHom M N f}} -> AbelianHom M N
abelianHom f = monoidHom (map-Hide f)

-- record IAbelianHom (M : Abelian ๐) (N : Abelian ๐) (f : โจ M โฉ -> โจ N โฉ) : ๐ฐ (๐ โ ๐) where
-- unquoteDecl AbelianHom abelianHom = #struct (quote IAbelianHom) "f" AbelianHom abelianHom



open IGroup


-}

-- //
