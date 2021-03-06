
{-# OPTIONS --cubical --allow-unsolved-metas #-}

module Verification.Old.Core.Algebra.Basic.Group where

open import Verification.Conventions
open import Verification.Old.Core.Category.Definition
open import Verification.Old.Core.Category.Instance.Type
open import Verification.Old.Core.Algebra.Basic.Monoid


-- === Groups
-- | We define groups as monoids with an inverse involution.

-- [Hide]

record IMonoid:WithInverse (A : ๐ฐ ๐) {{_ : IMonoid A}} : ๐ฐ ๐ where
  field _โปยน-Monoid : A -> A
open IMonoid:WithInverse {{...}} public

record IGroup (A : ๐ฐ ๐) : ๐ฐ ๐ where
  field {{Impl1}} : IMonoid A
        {{Impl2}} : IMonoid:WithInverse A
open IGroup {{...}} public
unquoteDecl Group group = #struct "Grp" (quote IGroup) "A" Group group

IGroupHom : (M : Group ๐) (N : Group ๐) (f : โจ M โฉ -> โจ N โฉ) -> ๐ฐ (๐ โ ๐)
IGroupHom M N f = IMonoidHom (monoid โจ M โฉ {{Impl1 {A = โจ M โฉ}}}) (monoid โจ N โฉ) f

unquoteDecl GroupHom groupHom = #struct "GrpHom" (quote IGroupHom) "f" GroupHom groupHom

instance
  INotation:Inverse:Group : {A : ๐ฐ ๐} {{_ : IGroup A}} -> Notation-Inverse A A
  INotation:Inverse:Group Notation-Inverse.โปยน = _โปยน-Monoid

instance
  IMonoidHom:โปยน : โ{A : ๐ฐ ๐} {{_ : IGroup A}} -> IMonoidHom (โฒ A โฒ) (โฒ A โฒ) _โปยน-Monoid
  IMonoidHom:โปยน = record {}

-- //


