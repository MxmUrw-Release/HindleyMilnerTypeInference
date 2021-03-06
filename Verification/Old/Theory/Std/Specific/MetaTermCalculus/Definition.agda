

module Verification.Core.Theory.Std.Specific.MetaTermCalculus.Definition where

open import Verification.Core.Conventions hiding (Structure)
open import Verification.Core.Algebra.Monoid.Definition
open import Verification.Core.Order.Lattice
open import Verification.Core.Data.Universe.Definition
open import Verification.Core.Data.Universe.Instance.Category
open import Verification.Core.Category.Std.Category.Definition
open import Verification.Core.Theory.Std.Generic.TypeTheory.Definition
open import Verification.Core.Theory.Std.Generic.TypeTheory.Simple
open import Verification.Core.Theory.Std.TypologicalTypeTheory.CwJ
open import Verification.Core.Category.Std.Category.Structured.Monoidal.Definition
open import Verification.Core.Category.Std.Functor.Definition
open import Verification.Core.Theory.Std.Generic.TypeTheory.Simple

data MetaSort : ๐ฐโ where
  main var : MetaSort

module _ (K : ๐ฐ ๐) where
  --- basic definitions

  data Type-MTC : ๐ฐ ๐ where
    kind : K -> Type-MTC
    _โ_ : Type-MTC -> Type-MTC -> Type-MTC

  infixr 30 _โ_

data MetaJ (A : ๐ฐ ๐) : ๐ฐ ๐ where
  _โ_ : Jdg-โฆฟ A -> MetaSort -> MetaJ A

module _ {A : ๐ฐ ๐} {B : ๐ฐ ๐} where
  map-MetaJ : (f : A -> B) -> MetaJ A -> MetaJ B
  map-MetaJ f (x โ s) = map-Jdg-โฆฟ f x โ s

-----------------------------------
-- ==* MTC signatures


record MetaTermCalculus (K : Kinding ๐) (๐ : ๐ ^ 1): ๐ฐ (๐ โบ ๏ฝค ๐ โบ) where
  -- field MetaKind : ๐ฐ (๐ โ 0)
  -- field varzero : MetaKind
  -- field โโแต : MetaKind -> MetaKind
  -- field isGoodType : Type' MetaKind -> ๐ฐโ
  field isHiddenMeta : Jdg-โฆฟ (Type-MTC โจ K โฉ) -> ๐ฐ (๐)
  field TermCon : (ฯ : Rule-โฆฟ โจ K โฉ) -> ๐ฐ (๐ โ 0 โ ๐)
  โโ : Type-MTC โจ K โฉ -> Type-MTC โจ K โฉ
  โโ (kind x) = kind (โโ x)
  โโ (a โ b) = a โ (โโ b)

open MetaTermCalculus public

macro
  MTC : (K : Kinding ๐) -> โ ๐ -> SomeStructure
  MTC K ๐ = #structureOn (MetaTermCalculus K ๐)

module _ {K : Kinding ๐} (A B : MTC K ๐) where
  -- record isHom-MTC (f : MetaKind A -> MetaKind B) : ๐ฐ ๐ where
  --   -- field map-varzero : f (varzero A) โก varzero B
  --   -- field map-varsuc : f (varsuc A) โก varsuc B
  --   field map-TermCon : โ ฯ -> TermCon A ฯ -> TermCon B (map f ฯ)
  -- Hom-MTC = _ :& isHom-MTC

  postulate
    Hom-MTC : ๐ฐ (๐ โ ๐)

module _ {K : Kinding ๐} where
  instance
    isCategory:MTC : isCategory (MetaTermCalculus K ๐)
    isCategory.Hom isCategory:MTC = Hom-MTC
    isCategory.isSetoid:Hom isCategory:MTC = isSetoid:byPath
    isCategory.id isCategory:MTC = {!!}
    isCategory._โ_ isCategory:MTC = {!!}
    isCategory.unit-l-โ isCategory:MTC = {!!}
    isCategory.unit-r-โ isCategory:MTC = {!!}
    isCategory.unit-2-โ isCategory:MTC = {!!}
    isCategory.assoc-l-โ isCategory:MTC = {!!}
    isCategory.assoc-r-โ isCategory:MTC = {!!}
    isCategory._โ_ isCategory:MTC = {!!}



module MTCDefinitions {K : Kinding ๐} (ฯ : MetaTermCalculus K ๐) where

  --- basic definitions
  private
    Type = Type-MTC (โจ K โฉ)
    -- K = K


  -- โฆ_โง-Con : TermConType (K) -> Type
  -- โฆ [] โ ฮฒ โง-Con       = kind ฮฒ
  -- โฆ (x โท as) โ ฮฒ โง-Con = {!!}

  -- Ctx = SCtx Type

  module _ {J K : ๐ฐ ๐} where
    arrify : (f : J -> Type-MTC K) -> Ctx-โฆฟ J -> Type-MTC K -> Type-MTC K
    arrify f [] = ฮป ฮฑ -> ฮฑ
    arrify f (ฮ ,, ฮฑ) = ฮป ฮฒ -> arrify f ฮ (f ฮฑ โ ฮฒ)

  โฆ_โง-J : Jdg-โฆฟ โจ K โฉ -> Type-MTC โจ K โฉ
  โฆ_โง-J (ฮ โข ฮฑ) = arrify kind ฮ (kind ฮฑ)

  โฆ_โง-R : Rule-โฆฟ โจ K โฉ -> Type-MTC โจ K โฉ
  โฆ_โง-R (๐งs โฉ ๐ฆ) = arrify โฆ_โง-J ๐งs (โฆ_โง-J ๐ฆ)


  arrify-arrify-โฅ : โ{ฮ ฮฑ ฮฒ} {x : โจ K โฉ} -> arrify kind ฮ (ฮฑ โ ฮฒ) โฃ kind x -> ๐-๐ฐ
  arrify-arrify-โฅ {G ,, x} p = arrify-arrify-โฅ {G} p

  arrify-J-kind : โ{ฮ ฮฑ ฮฒ} -> โฆ ฮ โข ฮฑ โง-J โฃ kind ฮฒ -> (ฮ โฃ []) โง (ฮฑ โฃ ฮฒ)
  arrify-J-kind {[]} {a} {.a} refl-โฃ = refl-โฃ , refl-โฃ
  arrify-J-kind {G ,, x} {a} {b} p = ๐-rec (arrify-arrify-โฅ {G} {kind x} {kind a} p)

  arrify-R-kind : โ{ฮ ฯ ฮฒ} -> โฆ ฮ โฉ ฯ โง-R โฃ kind ฮฒ -> (ฮ โฃ []) โง (ฯ โฃ [] โข ฮฒ)
  arrify-R-kind = {!!}

  arrify-J-split : โ{ฮ ฮฑ ฮฒ ฯ} -> โฆ ฮ โข ฯ โง-J โฃ (ฮฑ โ ฮฒ) -> โ ฮป ฮ' -> โ ฮป ฮฑ' -> (ฮฑ โฃ kind ฮฑ') โง (ฮ โฃ ([] ,, ฮฑ') โ ฮ') โง (โฆ ฮ' โข ฯ โง-J โฃ ฮฒ)
  arrify-J-split = {!!}

  MetaJ'  = Jdg-โฆฟ (Type-MTC (โจ K โฉ))

  data OptMeta (๐ง : MetaJ') (Opt : MetaJ' -> ๐ฐ ๐) (Fam : MetaJ' -> ๐ฐ ๐) : ๐ฐ (๐ ๏ฝค ๐) where
    skip : Opt ๐ง -> OptMeta ๐ง Opt Fam
    give : Fam ๐ง -> (ยฌ Opt ๐ง) -> OptMeta ๐ง Opt Fam



  data _โฉแถ?_ (ฮ : Ctx-โฆฟ (Jdg-โฆฟ (Type-MTC โจ(K)โฉ))) : MetaJ (Type-MTC โจ(K)โฉ) -> ๐ฐ (๐ ๏ฝค ๐) where
    meta : โ{๐ง} -> OptMeta ๐ง (isHiddenMeta ฯ) (ฮ โข-Ctx-โฆฟ_) -> ฮ โฉแถ? (๐ง โ main)
    var : โ{ฮ ฯ} -> (ฮ โฉแถ? (ฮ โข ฯ โ var)) -> ฮ โฉแถ? (ฮ โข ฯ โ main)
    con :  โ{ฮ ฯ ฯ'} -> (โฆ ฯ โง-R โฃ ฯ') -> (TermCon ฯ ฯ) -> ฮ โฉแถ? (ฮ โข ฯ' โ main)
    lam : โ{ฮ ฮฑ ฮฒ} -> ฮ โฉแถ? ((ฮ ,, ฮฑ) โข ฮฒ โ main) -> ฮ โฉแถ? (ฮ โข (ฮฑ โ ฮฒ) โ main)
    app : โ{ฮ ฮฑ ฮฒ} -> ฮ โฉแถ? (ฮ โข (ฮฑ โ ฮฒ) โ main) -> ฮ โฉแถ? (ฮ โข ฮฑ โ main) -> ฮ โฉแถ? (ฮ โข ฮฒ โ main)

    suc  : โ{ฮ ฮฑ ฮฒ} -> ฮ โฉแถ? (ฮ โข โโ ฯ ฮฑ โ main)  -> ฮ โฉแถ? (ฮ โข ฮฒ โ var) -> ฮ โฉแถ? ((ฮ ,, ฮฑ) โข ฮฒ โ var)
    zero : โ{ฮ ฮฑ}   -> ฮ โฉแถ? (ฮ โข โโ ฯ ฮฑ โ main) -> ฮ โฉแถ? ((ฮ ,, ฮฑ) โข ฮฑ โ var)




  mutual
    data _โฉแถ?โ-app_ (ฮ : Ctx-โฆฟ (Jdg-โฆฟ (Type-MTC โจ(K)โฉ))) : MetaJ (Type-MTC โจ(K)โฉ) -> ๐ฐ (๐ ๏ฝค ๐) where
      app : โ{ฮ ฮฑ ฯ ฮฒ} -> โฆ ฯ โง-J โฃ ฮฑ -> ฮ โฉแถ?โ-app (ฮ โข (ฮฑ โ ฮฒ) โ main) -> ฮ โฉแถ?โ (ฮ โข ฮฑ โ main) -> ฮ โฉแถ?โ-app (ฮ โข ฮฒ โ main)
      var : โ{ฮ ฯ} -> (ฮ โฉแถ?โ (ฮ โข ฯ โ var)) -> ฮ โฉแถ?โ-app (ฮ โข ฯ โ main)
      con :  โ{ฮ ฯ ฯ'} -> โฆ ฯ โง-R โฃ ฯ' -> (TermCon ฯ ฯ) -> ฮ โฉแถ?โ-app (ฮ โข ฯ' โ main)
      meta : โ{๐ง} -> OptMeta ๐ง (isHiddenMeta ฯ) (ฮ โข-Ctx-โฆฟ_) -> ฮ โฉแถ?โ-app (๐ง โ main)
      -- meta : โ{๐ง} -> OptMeta ๐ง (isHiddenMeta ฯ) (ฮ โข-Ctx-โฆฟ_) -> ฮ โฉแถ? ๐ง


    data _โฉแถ?โ_ (ฮ : Ctx-โฆฟ (Jdg-โฆฟ (Type-MTC โจ(K)โฉ))) : MetaJ (Type-MTC โจ(K)โฉ) -> ๐ฐ (๐ ๏ฝค ๐) where
      lam : โ{ฮ ฮฑ ฮฒ} -> ฮ โฉแถ?โ ((ฮ ,, ฮฑ) โข ฮฒ โ main) -> ฮ โฉแถ?โ (ฮ โข (ฮฑ โ ฮฒ) โ main)
      getapp : โ{ฮ ฮฑ s} -> ฮ โฉแถ?โ-app (ฮ โข kind ฮฑ โ s) -> ฮ โฉแถ?โ (ฮ โข kind ฮฑ โ s)

      suc  : โ{ฮ ฮฑ ฮฒ} -> ฮ โฉแถ?โ (ฮ โข โโ ฯ ฮฑ โ main)  -> ฮ โฉแถ?โ (ฮ โข ฮฒ โ var) -> ฮ โฉแถ?โ ((ฮ ,, ฮฑ) โข ฮฒ โ var)
      zero : โ{ฮ ฮฑ}   -> ฮ โฉแถ?โ (ฮ โข โโ ฯ ฮฑ โ main) -> ฮ โฉแถ?โ ((ฮ ,, ฮฑ) โข ฮฑ โ var)

    _โฉแถ?โ'_ : (ฮ : Ctx-โฆฟ (Jdg-โฆฟ (Type-MTC โจ(K)โฉ))) -> MetaJ' -> ๐ฐ (๐ ๏ฝค ๐)
    _โฉแถ?โ'_ a b = _โฉแถ?โ_ a (b โ main)


record Ctx-MTC {K : Kinding ๐} (ฮณ : MetaTermCalculus K ๐) : ๐ฐ (๐) where
  constructor incl
  field โจ_โฉ : (Ctx-โฆฟ (Jdg-โฆฟ (โจ K โฉ)))
open Ctx-MTC {{...}} public

module _ {K : Kinding ๐} {ฮณ : MetaTermCalculus K ๐} where
  open MTCDefinitions ฮณ

  -- instance
  --   isCategory:Ctx-MTC : isCategory (Ctx-โฆฟ (MetaJ (K)))
  --   isCategory.Hom isCategory:Ctx-MTC = Sub-โฆฟ (_โฉแถ?โ_)

  instance
    isCategory:Ctx-MTC : isCategory (Ctx-MTC ฮณ)
    isCategory.Hom isCategory:Ctx-MTC = ฮป A B -> Sub-โฆฟ (_โฉแถ?โ'_) (map-Ctx-โฆฟ (map-Jdg-โฆฟ kind) โจ A โฉ) (map-Ctx-โฆฟ (map-Jdg-โฆฟ kind) โจ B โฉ)
    isCategory.isSetoid:Hom isCategory:Ctx-MTC = isSetoid:byPath
    isCategory.id isCategory:Ctx-MTC = {!!}
    isCategory._โ_ isCategory:Ctx-MTC = {!!}
    isCategory.unit-l-โ isCategory:Ctx-MTC = {!!}
    isCategory.unit-r-โ isCategory:Ctx-MTC = {!!}
    isCategory.unit-2-โ isCategory:Ctx-MTC = {!!}
    isCategory.assoc-l-โ isCategory:Ctx-MTC = {!!}
    isCategory.assoc-r-โ isCategory:Ctx-MTC = {!!}
    isCategory._โ_ isCategory:Ctx-MTC = {!!}

    isMonoidal:Ctx-MTC : isMonoidal โฒ Ctx-MTC ฮณ โฒ
    isMonoidal:Ctx-MTC = {!!}

  instance
    isCwJ:Ctx-MTC : isCwJ K โฒ Ctx-MTC ฮณ โฒ
    isCwJ:Ctx-MTC = {!!} 
    -- record { JKind = (K) ; JObj = ฮป ๐ง -> {!!} } -- incl ([] ,, ([] โข โฆ ๐ง โง-J โ main)) }


  --   isMonoidal:Ctx-MTC : isMonoidal โฒ Ctx-โฆฟ (MetaJ (K)) โฒ
  --   isMonoidal:Ctx-MTC = {!!}

  -- instance
  --   isCwJ:Ctx-MTC : isCwJ K โฒ Ctx-โฆฟ (MetaJ (K)) โฒ
  --   isCwJ:Ctx-MTC = record { JKind = (K) ; JObj = ฮป ๐ง -> [] ,, ([] โข โฆ ๐ง โง-J โ main) }

{-
-}
      -- suc  : โ{ฮ ฮฑ ฮฒ} -> ฮ โฉแถ? (ฮ โข ฮฒ โ var) -> ฮ โฉแถ? ((ฮ ,, ฮฑ) โข ฮฒ โ var)
      -- zero : โ{ฮ ฮฑ}   -> ฮ โฉแถ? ((ฮ ,, ฮฑ) โข ฮฑ โ var)


    -- data [_]_โข_ (ฮ : SCtx MetaVar) : Ctx -> Type -> ๐ฐโ where
      -- meta : โ{ฮ ฯ} -> (ฮ ฮ ฯ)     -> [ ฮ ] (map-SCtx kind ฮ) โข kind ฯ
      -- con : โ{ฮ ฯ} -> (TermCon ฯ ฮ ฯ) -> [ ฮ ] (map-SCtx โฆ_โง-Con ฮ) โข kind ฯ
      -- var : โ{ฮ ฯ} -> (ฯ-Ctx ฮ ฯ) -> (ฯ-Ctx ฮ (ฮ โข ฯ , var)) -> [ ฮ ] ฮ โข ฯ
      -- lam : โ{ฮ ฮฑ ฮฒ} -> [ ฮ ] (ฮ ,, ฮฑ) โข ฮฒ -> [ ฮ ] ฮ โข (ฮฑ โ ฮฒ)
      -- app : โ{ฮ ฮฑ ฮฒ} -> [ ฮ ] ฮ โข (ฮฑ โ ฮฒ) -> [ ฮ ] ฮ โข ฮฑ -> [ ฮ ] ฮ โข ฮฒ





















{-


-- module _ (MetaKind : ๐ฐโ) where
  -- data TermConConditionType : ๐ฐโ where
  --   _โ_ : List MetaKind -> MetaKind -> TermConConditionType

  -- data TermConType : ๐ฐโ where
  --   _โ_ : List MetaKind -> MetaKind -> TermConType

data MetaSort : ๐ฐโ where
  main var special : MetaSort

module _ (K : ๐ฐโ) where
  --- basic definitions

  data Type-MTC : ๐ฐโ where
    kind : K -> Type-MTC
    _โ_ : Type-MTC -> Type-MTC -> Type-MTC

  infixr 30 _โ_

  data MetaJ : ๐ฐโ where
    _โ_ : Judgement (SCtx Type-MTC) Type-MTC -> MetaSort -> MetaJ

  data isKindSCtx : SCtx Type-MTC -> ๐ฐโ where
    [] : isKindSCtx []
    _,,_ : โ k {ฮ} -> isKindSCtx ฮ -> isKindSCtx (ฮ ,, kind k)

  data isKindMetaJ : MetaJ -> ๐ฐโ where
    _โ_ : โ{ฮ} -> isKindSCtx ฮ -> โ k s -> isKindMetaJ (ฮ โข kind k โ s)

  KindMetaJ = โ isKindMetaJ

  data isConArg : Type-MTC -> ๐ฐโ where
    kind : โ k -> isConArg (kind k)
    _โ_ : โ k {a} -> isConArg a -> isConArg (kind k โ a)

  data isConType : Type-MTC -> ๐ฐโ where
    kind : โ k -> isConType (kind k)
    _โ_ : โ {a t} -> isConArg a -> isConType t -> isConType (a โ t)


record MetaTermCalculus : ๐ฐโ where
  field MetaKind : ๐ฐโ
  field varzero : MetaKind
  field varsuc : MetaKind
  field isGoodType : Type-MTC MetaKind -> ๐ฐโ
  field isHiddenMeta : MetaJ MetaKind -> ๐ฐโ
  field TermCon : (ฯ : Type-MTC MetaKind) -> isGoodType ฯ -> ๐ฐโ

open MetaTermCalculus




-}


