
module Verification.Core.Theory.Std.Specific.MetaTermCalculus2.Pattern.Instance.Category where

open import Verification.Core.Conventions hiding (Structure)
open import Verification.Core.Algebra.Monoid.Definition
open import Verification.Core.Algebra.Monoid.Free
open import Verification.Core.Data.List.Variant.Binary.Element
open import Verification.Core.Order.Lattice
open import Verification.Core.Data.Universe.Definition
open import Verification.Core.Data.Universe.Instance.Category
open import Verification.Core.Data.Product.Definition
open import Verification.Core.Theory.Std.Generic.TypeTheory.Definition
open import Verification.Core.Theory.Std.Generic.TypeTheory.Simple
open import Verification.Core.Theory.Std.Generic.TypeTheory.Simple.Judgement2
open import Verification.Core.Theory.Std.TypologicalTypeTheory.CwJ.Kinding
open import Verification.Core.Theory.Std.Generic.TypeTheory.Simple
open import Verification.Core.Theory.Std.Specific.MetaTermCalculus2.Pattern.Definition

open import Verification.Core.Category.Std.Category.Definition
open import Verification.Core.Category.Std.Category.Structured.Monoidal.Definition
open import Verification.Core.Category.Std.Functor.Definition
open import Verification.Core.Category.Std.RelativeMonad.Definition
open import Verification.Core.Category.Std.RelativeMonad.KleisliCategory.Definition
open import Verification.Core.Category.Std.Category.Subcategory.Definition
open import Verification.Core.Category.Std.Morphism.EpiMono
open import Verification.Core.Category.Std.Limit.Specific.Coproduct.Preservation.Definition

open import Verification.Core.Data.Indexed.Definition
open import Verification.Core.Data.Indexed.Instance.Monoid
open import Verification.Core.Data.FiniteIndexed.Definition
open import Verification.Core.Data.Renaming.Definition
open import Verification.Core.Data.Renaming.Instance.CoproductMonoidal
open import Verification.Core.Data.Substitution.Definition


module _ {K : Kinding ð} {{_ : isMetaTermCalculus ð K}} where

  private
    ð© : ð° _
    ð© = Jdgâ â¨ K â©

  -- Pat' : ðð¢ð§ðð± ð© -> ðð± (Jdgâ â¨ K â©) (ðð§ð¢ð¯ _)
  -- Pat' (incl js) = indexed (Î» j â js â©á¶ -patlam j)

  macro ððð¡ = #structureOn Pat
  -- macro ððð¡' = #structureOn Pat'

  repure-ððð¡ : â{j : ðð¢ð§ðð± ð©} -> ðð â¨ j â© â¶ ððð¡ j
  repure-ððð¡ i x = app-meta x id

  -- mutual
    -- reext-ððð¡' : â{j k : ðð¢ð§ðð± ð©} -> ðð â¨ j â© â¶ ððð¡ k -> ððð¡' j â¶ ððð¡' k
    -- reext-ððð¡' f _ (lam s) = lam (reext-ððð¡ f _ s)

  reext-ððð¡ : â{j k : ðð¢ð§ðð± ð©} -> ðð â¨ j â© â¶ ððð¡ k -> ððð¡ j â¶ ððð¡ k
  reext-ððð¡ f _ (app-meta M s) = apply-injVars s (f _ M)
  reext-ððð¡ f _ (app-var v (lam ts)) = app-var v (lam (Î» i x -> reext-ððð¡ f _ (ts i x)))
  reext-ððð¡ f _ (app-con c (lam ts)) = app-con c (lam (Î» i x -> reext-ððð¡ f _ (ts i x)))

  map-ððð¡ : â{a b : ðð¢ð§ðð± ð©} -> (a â¶ b) -> ððð¡ a â¶ ððð¡ b
  map-ððð¡ = {!!}

  instance
    isFunctor:Pat : isFunctor (ðð¢ð§ðð± ð©) (ðð± ð© (ðð§ð¢ð¯ _)) Pat
    isFunctor.map isFunctor:Pat = map-ððð¡
    isFunctor.isSetoidHom:map isFunctor:Pat = {!!}
    isFunctor.functoriality-id isFunctor:Pat = {!!}
    isFunctor.functoriality-â isFunctor:Pat = {!!}

  instance
    isRelativeMonad:Pat : isRelativeMonad (ðð¢ðð _ _) ððð¡
    isRelativeMonad.repure   isRelativeMonad:Pat = repure-ððð¡
    isRelativeMonad.reext    isRelativeMonad:Pat = reext-ððð¡
    isRelativeMonad.reunit-l isRelativeMonad:Pat = {!!}
    isRelativeMonad.reunit-r isRelativeMonad:Pat = {!!}
    isRelativeMonad.reassoc  isRelativeMonad:Pat = {!!}

  -- instance
  --   isFiniteCoproductPreserving:ððð¡ : isFiniteCoproductPreserving ððð¡
  --   isFiniteCoproductPreserving.preservesCoproducts:this isFiniteCoproductPreserving:ððð¡ = {!!}
  --   isFiniteCoproductPreserving.preservesInitial:this isFiniteCoproductPreserving:ððð¡ = {!!}

    -- isRelativeMonad.repure isRelativeMonad:Pat = repure-ððð¡
    -- isRelativeMonad.reext  isRelativeMonad:Pat = reext-ððð¡ 

module _ (K : Kinding ð) {{_ : isMetaTermCalculus ð K}} where
  macro
    -- ððð­ : SomeStructure
    -- ððð­ = #structureOn (RelativeKleisli ððð¡)

    â§ððð­ : SomeStructure
    â§ððð­ = #structureOn (InductiveSubstitution ððð¡)

    ððð­ : SomeStructure
    ððð­ = #structureOn (Substitution ððð¡)


  -- private
  --   ð© : ð° _
  --   ð© = Jdgâ â¨ K â©

  -- Î¹-ððð§áµ : ððð§ ð© -> ððð­ K
  -- Î¹-ððð§áµ x = incl (incl (â¨ â¨ x â© â©))

  -- map-Î¹-ððð§ : â{a b : ððð§ ð©} -> (a â¶ b) -> Î¹-ððð§áµ a â¶ Î¹-ððð§áµ b
  -- map-Î¹-ððð§ {a} {b} f = incl (Î» {i x â app-meta (â¨ â¨ f â© â© i x) id})


-- module _ {K : Kinding ð} {{_ : isMetaTermCalculus ð K}} where
--   subst-ððð­ : â{j k : ððð­ K} {a : Jdgâ â¨ K â©} -> â¨ â¨ j â© â© â©á¶ -pat a -> (j â¶ k) -> â¨ â¨ k â© â© â©á¶ -pat a
--   subst-ððð­ {a = a} t Ï = â¨ (incl (Î» {i incl â t}) â Ï) â© a incl



  -- Hom-Subs : â (J K : ðð¢ð§ðð± ð©) -> ð° _
  -- Hom-Subs J K = (ðð â¨ J â©) â¶ (Pat K)


  -- â{k} -> K â k -> J â©á¶ -pat k
  -- Subs _â©á¶ -pat_ âs ðs


{-
  mutual
    subst-patlam : â{âs ðs ð} -> Subs _â©á¶ -pat_ âs ðs -> ðs â©á¶ -patlam ð -> (âs â©á¶ -patlam ð)
    subst-patlam Ï (lam ts) = lam (subst-pat Ï ts)

    subst-pat : â{âs ðs ð} -> Subs _â©á¶ -pat_ âs ðs -> ðs â©á¶ -pat ð -> (âs â©á¶ -pat ð)
    subst-pat Ï (app-meta M s) =
      let N = getvar Ï M
      in apply-injVars N s
    subst-pat Ï (app-var v ts) = app-var v (Î» x â subst-patlam Ï (ts x))
    subst-pat Ï (app-con c ts) = app-con c (Î» x -> subst-patlam Ï (ts x))


  subst-pat-Hom : â{âs ðs ðs} -> Subs _â©á¶ -pat_ âs ðs -> Subs _â©á¶ -pat_ ðs ðs -> Subs _â©á¶ -pat_ âs ðs
  subst-pat-Hom s [] = []
  subst-pat-Hom s (x â· t) = subst-pat s x â· subst-pat-Hom s t

  infixl 40 _â-Subs_
  _â-Subs_ = subst-pat-Hom

  mutual
    wk-meta-lam : â{ð§ ðs ð} -> ðs â©á¶ -patlam ð -> (ð§ â· ðs) â©á¶ -patlam ð
    wk-meta-lam (lam t) = lam (wk-meta t)

    wk-meta : â{ð§ ðs ð} -> ðs â©á¶ -pat ð -> (ð§ â· ðs) â©á¶ -pat ð
    wk-meta (app-meta M s) = app-meta (suc M) s
    wk-meta (app-var c ts) = app-var c (Î» x -> (wk-meta-lam (ts x)))
    wk-meta (app-con c ts) = app-con c (Î» x -> (wk-meta-lam (ts x)))


  wk-meta-Subs : â{ð§ ðs ðs} -> Hom-Subs ðs ðs -> Hom-Subs (ð§ â· ðs) ðs
  wk-meta-Subs [] = []
  wk-meta-Subs (x â· s) = wk-meta x â· wk-meta-Subs s


  id-Subs : â{ðs} -> Hom-Subs ðs ðs
  id-Subs {â¦â¦} = []
  id-Subs {x â· J} = app-meta zero id â· wk-meta-Subs (id-Subs)

  instance
    isSetoid:Hom-Subs : â{a b} -> isSetoid (Hom-Subs a b)
    isSetoid:Hom-Subs = isSetoid:byPath

  instance
    isSetoid:â©á¶ -pat : â{a b} -> isSetoid (a â©á¶ -pat b)
    isSetoid:â©á¶ -pat = isSetoid:byPath


{-
  wk-getvar-comm : â{a b c d} -> {Ï : Hom-Subs a b} {x : b â¨-var c} -> getvar (wk-meta-Subs {d} Ï) x â£ wk-meta (getvar Ï x)
  wk-getvar-comm {Ï = xâ â· Ï} {x = zero} = refl-â£
  wk-getvar-comm {Ï = xâ â· Ï} {x = suc x} = wk-getvar-comm {Ï = Ï} {x = x}

  unit-l-var : â{a b} -> {x : a â¨-var b} -> getvar id-Subs x â£ meta x
  unit-l-var {x = zero} = refl-â£
  unit-l-var {a = a} {x = suc x} =
    let p = wk-getvar-comm {Ï = id-Subs} {x = x}
    in p â (cong-Str wk-meta unit-l-var)


-}

  private
    lem-10 : â{Î Î a Î±} (M : a â¨-var Î â Î±) (s : injVars Î Î)
           -> apply-injVars (getvar id-Subs M) s â¡ app-meta M s
    lem-10 zero s = {!!}
    lem-10 (suc M) s = {!!}



  mutual
    unit-l-subst-lam : â{a b} -> {t : a â©á¶ -patlam b} -> subst-patlam id-Subs t â¡ t
    unit-l-subst-lam {t = lam s} = cong lam unit-l-subst

    unit-l-subst : â{a b} -> {t : a â©á¶ -pat b} -> subst-pat id-Subs t â¡ t
    unit-l-subst {t = app-meta M s} = lem-10 M s
    unit-l-subst {t = app-var c ts} = congâ app-var refl-â¡ (Î» i x -> unit-l-subst-lam {t = ts x} i)
    unit-l-subst {t = app-con c ts} = congâ app-con refl-â¡ (Î» i x -> unit-l-subst-lam {t = ts x} i)
  -- unit-l-subst {t = meta x} = unit-l-var
  -- unit-l-subst {t = lam t s} = congâ-Str lam unit-l-subst unit-l-subst
  -- unit-l-subst {t = app t s} = congâ-Str app unit-l-subst unit-l-subst
  -- unit-l-subst {t = con x} = refl-â£
  -- unit-l-subst {t = var x} = refl-â£

  unit-l-Subs : â{a b} -> {f : Hom-Subs a b} -> id-Subs â-Subs f â¼ f
  unit-l-Subs {f = []} = refl
  unit-l-Subs {f = x â· f} = congâ _â·_ unit-l-subst unit-l-Subs

module _ {K : Kinding ð} where
  record MTCSubs (Î³ : MetaTermCalculus K ð) : ð° ð where
    field â¨_â© : List (Jdgâ â¨ K â©)

  open MTCSubs public

module _ {K : Kinding ð} {Î³ : MetaTermCalculus K ð} where
  instance
    isCategory:Subs : isCategory (MTCSubs Î³)
    isCategory.Hom isCategory:Subs           = Î» a b -> Hom-Subs {Î³ = Î³} â¨ b â© â¨ a â©
    isCategory.isSetoid:Hom isCategory:Subs  = isSetoid:Hom-Subs
    isCategory.id isCategory:Subs            = id-Subs
    isCategory._â_ isCategory:Subs           = Î» f g -> g â-Subs f
    isCategory.unit-l-â isCategory:Subs      = {!!}
    isCategory.unit-r-â isCategory:Subs      = unit-l-Subs
    isCategory.unit-2-â isCategory:Subs      = {!!}
    isCategory.assoc-l-â isCategory:Subs     = {!!}
    isCategory.assoc-r-â isCategory:Subs     = {!!}
    isCategory._â_ isCategory:Subs           = {!!}

-}




