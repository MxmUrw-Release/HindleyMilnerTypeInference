
module Verification.Core.Data.Language.HindleyMilner.Variant.Unnamed.Typed.Instance.AdjointInfer where

open import Verification.Conventions hiding (โ ; _โ_)
open import Verification.Core.Set.Discrete
open import Verification.Core.Algebra.Monoid.Definition
open import Verification.Core.Algebra.Monoid.Free
open import Verification.Core.Data.AllOf.Collection.Basics
open import Verification.Core.Data.AllOf.Collection.TermTools
open import Verification.Core.Category.Std.AllOf.Collection.Basics
open import Verification.Core.Category.Std.AllOf.Collection.Limits
open import Verification.Core.Category.Std.AllOf.Collection.Monads
open import Verification.Core.Category.Std.Fibration.GrothendieckConstruction.Definition

open import Verification.Core.Theory.Std.Specific.ProductTheory.Module
open import Verification.Core.Theory.Std.Specific.ProductTheory.Instance.hasBoundaries

open import Verification.Core.Data.Language.HindleyMilner.Type.Definition
open import Verification.Core.Data.Language.HindleyMilner.Variant.Unnamed.Typed.Definition
open import Verification.Core.Data.Language.HindleyMilner.Variant.Unnamed.Typed.Instance.Monad

open import Verification.Core.Data.Language.HindleyMilner.Variant.Unnamed.Untyped.Definition
open import Verification.Core.Data.Language.HindleyMilner.Variant.Unnamed.Untyped.Instance.Monad



module _ {๐ : Category ๐} {๐ : Category ๐} (f : Functor ๐ ๐) where
  โ* : ๐๐ฎ๐ง๐ ๐ (๐๐๐ญ ๐) -> ๐๐ฎ๐ง๐ ๐ (๐๐๐ญ ๐)
  โ* g = f โ-๐๐๐ญ g

  โโ : ๐๐ฎ๐ง๐ ๐ (๐๐๐ญ ๐) -> ๐๐ฎ๐ง๐ ๐ (๐๐๐ญ ๐)
  โโ g = h since {!!}
    where
      h : โจ ๐ โฉ -> ๐๐๐ญ ๐
      h d = โจ (F โ-๐๐๐ญ g)
        where
          ๐'แต : ๐ฐ _
          ๐'แต = โ ฮป (c : โจ ๐ โฉ) -> โจ f โฉ c โฃ d

          Fแต : ๐'แต -> โจ ๐ โฉ
          Fแต = fst

          ๐' : ๐๐๐ญ _
          ๐' = ๐'แต since {!!}

          F : ๐' โถ ๐
          F = Fแต since {!!}




sแต : โHMJudgement -> ไบบโ
sแต (ฮ โข ฯ) = size-โListแดฐ ฮ
-- map-โList (const tt) ฮ

macro s = #structureOn sแต

instance
  isFunctor:s : isFunctor โHMJudgement ไบบโ s
  isFunctor:s = {!!}

ใพ : ๐๐ฎ๐ง๐ ไบบโ ๐๐๐ญโ -> ๐๐ฎ๐ง๐ โHMJudgement ๐๐๐ญโ
ใพ = โ* s

ใต : ๐๐ฎ๐ง๐ โHMJudgement ๐๐๐ญโ -> ๐๐ฎ๐ง๐ ไบบโ ๐๐๐ญโ
ใต = โโ s

-- ๅ* (ฮป (ฮ โข ฯ) โ map-โList (const tt) ฮ)


ฯ : โ A -> TypedโHM (ใพ A) โถ ใพ (UntypedโHM A)
ฯ A = ฯแต since {!!}
  where
    ฯแตแต : โ x -> โจ โจ (TypedโHM (ใพ A)) โฉ x โฉ -> โจ โจ (ใพ (UntypedโHM A)) โฉ x โฉ
    ฯแตแต .(_ โข _) (var) = {!!} -- var (map-โ (const tt) x)
    ฯแตแต x (hole xโ) = hole xโ
    ฯแตแต x (gen xโ te) = {!!}
    ฯแตแต .(_ โข (โ[ _ ] _)) (app te teโ) = {!!}
    ฯแตแต .(_ โข (โ[ _ ] _ โ _)) (lam te) = {!!}
    ฯแตแต .(_ โข _) (convert x te) = {!!}
    ฯแตแต .(_ โข _) (instantiate x te) = {!!}

    ฯแต : โ x -> โจ (TypedโHM (ใพ A)) โฉ x โถ โจ (ใพ (UntypedโHM A)) โฉ x
    ฯแต = ฮป x -> ฯแตแต x since {!!}


ฮณ : โ A -> UntypedโHM A โถ ใต (TypedโHM (ใพ (UntypedโHM A)))
ฮณ A = ฮณแต since {!!}
  where
    ฮณแตแต : โ x -> โจ โจ UntypedโHM A โฉ x โฉ -> โจ โจ ใต (TypedโHM (ใพ (UntypedโHM A))) โฉ x โฉ
    ฮณแตแต x (var xโ) = {!!}
    ฮณแตแต x (hole xโ) = {!!}
    ฮณแตแต x (slet te teโ) = {!!}
    ฮณแตแต x (app te teโ) = {!!}
    ฮณแตแต x (lam te) with ฮณแตแต {!!} te
    ... | (((ฮ โ-โง incl xโ) โข (โ[ fstโ ] sndโ)) , refl-โฃ) , tx = (ฮ โข {!!} , refl-โฃ) , {!!}

    ฮณแต : โ x -> โจ UntypedโHM A โฉ x โถ โจ ใต (TypedโHM (ใพ (UntypedโHM A))) โฉ x
    ฮณแต = ฮป x -> ฮณแตแต x since {!!}




{-
forgetJudgement : ๐๐ฑ โHMJudgement ๐๐ง๐ข๐ฏโ -> ๐๐ฑ ไบบโ ๐๐ง๐ข๐ฏโ
forgetJudgement x = indexed (ฮป n โ  โ ฮป metas -> โ ฮป (ฮ : ไบบVecแต (โHMPolyType metas) n) -> โ ฮป (ฯ : โHMPolyType metas) -> x โ (โจ ฮ โฉ โข ฯ))

-- โ ฮป (j : โHMJudgement) -> (mapOf โฒ โList โฒ (const tt) (context j) โฃ i) ร (x โ j))

instance
  isFunctor:forgetJudgement : isFunctor (๐๐ฑ โHMJudgement ๐๐ง๐ข๐ฏโ) (๐๐ฑ ไบบโ ๐๐ง๐ข๐ฏโ) forgetJudgement
  isFunctor:forgetJudgement = {!!}

{-
{-# TERMINATING #-}
printแต-TypedโHM : โ A -> forgetJudgement (TypedโHM A) โถ UntypedโHM (forgetJudgement A)
printแต-TypedโHM A ฮ (.(_ โข _) , refl-โฃ , var x) = var (map-โ (const tt) x)
printแต-TypedโHM A ฮ (j , refl-โฃ , hole x) = hole (j , refl-โฃ , x)
printแต-TypedโHM A ฮ (j , refl-โฃ , gen x te) = printแต-TypedโHM A ฮ (_ , {!!} , te)
printแต-TypedโHM A ฮ (.(_ โข (โ[ _ ] _)) , refl-โฃ , app te teโ) = {!!}
printแต-TypedโHM A ฮ (.(_ โข (โ[ _ ] _ โ _)) , refl-โฃ , lam te) = {!!}
printแต-TypedโHM A ฮ (.(_ โข _) , refl-โฃ , convert x te) = {!!}
printแต-TypedโHM A ฮ (.(_ โข _) , refl-โฃ , instantiate x te) = {!!}

print-TypedโHM : ๅคงMonadHom (_ , TypedโHM) (_ , UntypedโHM)
print-TypedโHM = record { fst = โฒ forgetJudgement โฒ ; snd = printแต-TypedโHM since {!!} }
-}

makeJudgement : ๐๐ฑ ไบบโ ๐๐ง๐ข๐ฏโ -> ๐๐ฑ โHMJudgement ๐๐ง๐ข๐ฏโ
makeJudgement = ๅ* (ฮป (ฮ โข ฯ) โ map-โList (const tt) ฮ)

-- map-โList (const tt)
-- indexed (ฮป (ฮ โข ฯ) โ x โ map-โList (const tt) ฮ)

print2-TypedโHM : โ A -> TypedโHM (makeJudgement A) โถ makeJudgement (UntypedโHM A)
print2-TypedโHM A (ฮ โข ฯ) (var x) = var (map-โ (const tt) x)
print2-TypedโHM A (ฮ โข ฯ) (hole x) = hole x
print2-TypedโHM A (ฮ โข ฯ) (gen x te) = {!!}
print2-TypedโHM A (ฮ โข (โ[ _ ] sndโ)) (app x y) = app (print2-TypedโHM _ _ x) (print2-TypedโHM _ _ y)
print2-TypedโHM A (ฮ โข (โ[ _ ] .(_ โ _))) (lam x) = lam (print2-TypedโHM _ _ x)
print2-TypedโHM A (ฮ โข ฯ) (convert x xโ) = {!!}
print2-TypedโHM A (ฮ โข ฯ) (instantiate x te) = print2-TypedโHM _ _ te


-- this is the type inference for โHM
module โHM-Inference where
  private
    -- โHMFin


    f : โ {A} metas n
        -> (ฮ : ไบบVecแต (โHMPolyType metas) n)
        -> UntypedโHM A โ n
        -> โ ฮป ฯ -> TypedโHM (makeJudgement (UntypedโHM A)) โ (โจ ฮ โฉ โข ฯ)
    f {A} metas n ฮ (var x) = _ , var (get-โ-ไบบVecแต ฮ x)
    f {A} metas n ฮ (hole x) = {!!} , (hole (hole {!!}))
    f {A} metas n ฮ (slet te teโ) = {!!}
    f {A} metas n ฮ (app te teโ) = {!!}
    f {A} metas n ฮ (lam te) =
      let
          -- we create a new type variable
          -- by increasing the metas
          metasโ = metas โ st

          -- we embed the old context into
          -- the one containing the new variable
          ฮ' = mapOf โHMCtx ฮนโ โจ ฮ โฉ

          -- the new context contains the new type variable
          ฮโ = ฮ' โ incl (โ[ โฅ ] (var (left-โ (right-โ incl))))

          -- we infer the type of the body of the lambda expression
          ฮฒ , te' = f metasโ _ (vecแต ฮโ {!!}) te

      in {!!}


infer-TypedโHM : โ A -> UntypedโHM A โถ forgetJudgement (TypedโHM (makeJudgement (UntypedโHM A)))
infer-TypedโHM A x te = {!!} , {!!} , {!!} , {!!}



-}


