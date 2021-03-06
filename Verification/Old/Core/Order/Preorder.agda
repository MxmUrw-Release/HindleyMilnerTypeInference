
{-# OPTIONS --cubical --allow-unsolved-metas #-}

module Verification.Old.Core.Order.Preorder where

open import Verification.Conventions
open import Verification.Old.Core.Category.Definition
open import Verification.Old.Core.Category.Instance.Set.Definition
-- open import Verification.Old.Core.Type

--------------------------------------------------------------------
-- == Preorder

record IPreorder (A : ๐ฐ ๐) : ๐ฐ (๐ โบ) where
  field _โค_ : A -> A -> ๐ฐ ๐
        refl-โค : {a : A} -> a โค a
        trans-โค : {a b c : A} -> a โค b -> b โค c -> a โค c
open IPreorder {{...}} public

unquoteDecl Preorder preorder = #struct "PreOrd" (quote IPreorder) "A" Preorder preorder


module _ {A : ๐ฐ ๐} {{_ : IPreorder A}} where
  infix 30 _<_
  _<_ : A -> A -> ๐ฐ ๐
  a < b = (a โค b) ร-๐ฐ (a โก b -> ๐-๐ฐ)

  instance
    Cast:โกโโค : โ{a b : A} -> Cast (a โก b) IAnything (a โค b)
    Cast.cast (Cast:โกโโค {a = a} {b}) e = transport (ฮป i -> e (~ i) โค b) refl-โค


-- record IPreorderHom {A B : Preorder} (f : โจ A โฉ -> โจ B โฉ) : ๐ฐโ where

-- record PreorderHom (A B : Preorder) : ๐ฐโ where

instance
  -- ICategory:Preorder : ICategory Preorder (๐ , ๐ ,-)
  -- ICategory:Preorder = {!!}
{-
  ICategory.Hom ICategory:Preorder = PreorderHom
  ICategory.id ICategory:Preorder = {!!}
  ICategory._โ_ ICategory:Preorder = {!!}
-}

  IPreorder:โ : IPreorder โ
  IPreorder._โค_ IPreorder:โ = _โค-โ_
  IPreorder.refl-โค IPreorder:โ = refl-โค-โ
  IPreorder.trans-โค IPreorder:โ = trans-โค-โ




--------------------------------------------------------------------
-- == Concatenation of preorders

module _ {A : ๐ฐ ๐} {B : ๐ฐ ๐} {{_ : IPreorder A}} {{_ : IPreorder B}} where

  data _โค-โ_ : (a b : A +-๐ฐ B) -> ๐ฐ ๐ where
    left-โค : โ{a b : A} -> a โค b -> left a โค-โ left b
    right-โค : โ{a b : B} -> a โค b -> right a โค-โ right b
    left-right-โค : โ{a : A} {b : B} -> left a โค-โ right b


  trans-โค-โ : โ{a b c} -> (a โค-โ b) -> (b โค-โ c) -> a โค-โ c
  trans-โค-โ (left-โค p) (left-โค q) = left-โค (trans-โค p q)
  trans-โค-โ (left-โค x) left-right-โค = left-right-โค
  trans-โค-โ (right-โค p) (right-โค q) = right-โค (trans-โค p q)
  trans-โค-โ left-right-โค (right-โค x) = left-right-โค

  refl-โค-โ : โ{a} -> (a โค-โ a)
  refl-โค-โ {left x} = left-โค refl-โค
  refl-โค-โ {just x} = right-โค refl-โค


  instance
    IPreorder:+ : IPreorder (A +-๐ฐ B)
    IPreorder._โค_ IPreorder:+ = _โค-โ_
    IPreorder.refl-โค IPreorder:+ {a = a} = refl-โค-โ {a}
    IPreorder.trans-โค IPreorder:+ {a = a} = trans-โค-โ {a = a}


_โ-Preorder_ : Preorder ๐ -> Preorder ๐ -> Preorder ๐
A โ-Preorder B = preorder (โจ A โฉ +-๐ฐ โจ B โฉ)

instance
  INotation:DirectSum:Preorder : INotation:DirectSum (Preorder ๐)
  INotation:DirectSum._โ_ INotation:DirectSum:Preorder = _โ-Preorder_


--------------------------------------------------------------------
-- == Example instances

instance
  IPreorder:โค : โ{๐} -> IPreorder (Lift {j = ๐} ๐-๐ฐ)
  IPreorder._โค_ IPreorder:โค a b = `๐`
  IPreorder.refl-โค IPreorder:โค = lift tt
  IPreorder.trans-โค IPreorder:โค a b = lift tt



