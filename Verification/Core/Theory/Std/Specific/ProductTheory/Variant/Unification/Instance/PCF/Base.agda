
{-# OPTIONS --experimental-lossy-unification #-}

module Verification.Core.Theory.Std.Specific.ProductTheory.Variant.Unification.Instance.PCF.Base where

open import Verification.Conventions hiding (Structure)

-- open import Verification.Core.Conventions hiding (Structure ; isSetoid:byPath)
open import Verification.Core.Set.Decidable
open import Verification.Core.Set.Discrete
open import Verification.Core.Algebra.Monoid.Definition
open import Verification.Core.Algebra.Monoid.Free
open import Verification.Core.Data.List.Variant.Binary.Element.Definition
open import Verification.Core.Data.List.Variant.Binary.Misc
open import Verification.Core.Data.List.Variant.Binary.Definition
open import Verification.Core.Data.List.Variant.Binary.Instance.Monoid
open import Verification.Core.Data.List.Variant.Binary.Instance.Setoid
open import Verification.Core.Data.List.VariantTranslation.Definition
open import Verification.Core.Data.List.Dependent.Variant.Binary.Definition
-- open import Verification.Core.Order.Lattice
open import Verification.Core.Data.Universe.Definition
open import Verification.Core.Data.Universe.Instance.Category -- hiding (isSetoid:Function)
open import Verification.Core.Data.Product.Definition
-- open import Verification.Core.Theory.Std.Generic.TypeTheory.Definition
-- open import Verification.Core.Theory.Std.Generic.TypeTheory.Simple
-- open import Verification.Core.Theory.Std.Generic.TypeTheory.Simple.Judgement2
-- open import Verification.Core.Theory.Std.TypologicalTypeTheory.CwJ.Kinding
-- open import Verification.Core.Theory.Std.Generic.TypeTheory.Simple
-- open import Verification.Core.Theory.Std.Specific.MetaTermCalculus2.Pattern.Definition

open import Verification.Core.Category.Std.Category.Definition
open import Verification.Core.Category.Std.Category.Sized.Definition
-- open import Verification.Core.Category.Std.Category.Structured.Monoidal.Definition
open import Verification.Core.Category.Std.Functor.Definition
open import Verification.Core.Category.Std.RelativeMonad.Definition
open import Verification.Core.Category.Std.RelativeMonad.KleisliCategory.Definition
open import Verification.Core.Category.Std.Category.Subcategory.Definition
open import Verification.Core.Category.Std.Morphism.EpiMono
open import Verification.Core.Category.Std.Morphism.Iso
open import Verification.Core.Category.Std.Limit.Specific.Coproduct.Definition
open import Verification.Core.Category.Std.Limit.Specific.Coequalizer.Definition
open import Verification.Core.Category.Std.Limit.Specific.Coequalizer.Property.Base
open import Verification.Core.Category.Std.Limit.Specific.Coequalizer.Property.Sized
open import Verification.Core.Category.Std.Limit.Specific.Coequalizer.Reflection
-- open import Verification.Core.Category.Std.Limit.Specific.Coproduct.Preservation.Definition

open import Verification.Core.Order.WellFounded.Definition
open import Verification.Core.Order.Preorder 
open import Verification.Core.Order.Lattice hiding (???)

open import Verification.Core.Data.List.Variant.Unary.Definition
open import Verification.Core.Data.List.Variant.Binary.Natural
open import Verification.Core.Data.Indexed.Definition
open import Verification.Core.Data.Indexed.Instance.Monoid
open import Verification.Core.Data.FiniteIndexed.Definition
open import Verification.Core.Data.Renaming.Definition
open import Verification.Core.Data.Renaming.Instance.CoproductMonoidal
open import Verification.Core.Data.Substitution.Variant.Base.Definition
open import Verification.Core.Data.FiniteIndexed.Property.Merge

open import Verification.Core.Theory.Std.Generic.FormalSystem.Definition
open import Verification.Core.Theory.Std.Specific.ProductTheory.Variant.Unification.Definition
open import Verification.Core.Theory.Std.Specific.ProductTheory.Variant.Unification.Instance.FormalSystem

open import Verification.Core.Computation.Unification.Categorical.PrincipalFamilyCat

open import Verification.Core.Theory.Std.Specific.ProductTheory.Variant.Unification.Instance.PCF.Var
open import Verification.Core.Theory.Std.Specific.ProductTheory.Variant.Unification.Instance.PCF.Occur
open import Verification.Core.Theory.Std.Specific.ProductTheory.Variant.Unification.Instance.PCF.OccurFail
open import Verification.Core.Theory.Std.Specific.ProductTheory.Variant.Unification.Instance.PCF.DirectFail
open import Verification.Core.Theory.Std.Specific.ProductTheory.Variant.Unification.Instance.PCF.Size




module _ {???? : ?????? ????} where


  data isBase-?????? : ???{x y : ???????????? ????} -> HomPair x y -> ???? ???? where
    isBase:??? : ???{x : ???????????? ????} -> {f g : ??? ??? x} -> isBase-?????? (f , g)
    isBase:sym : ???{x y : ???????????? ????} -> {f g : x ??? y} -> isBase-?????? (f , g) -> isBase-?????? (g , f)
    isBase:id : ???{x y : ???????????? ????} -> {f : x ??? y} -> isBase-?????? (f , f)
    isBase:var : ???{s : Type ????} {?? : ???????????? ????} (x y : ??? ?? ??? ??? s) -> (y ???-??? x) -> isBase-?????? (???subst (incl (var x)) , ???subst (incl (var y)))
    isBase:con-var : ???{s : Type ????} {?? : ???????????? ????}
                     -> ???{??s} -> (c : Con ???? ??s s) -> (ts : Terms-?????? ???? (incl (?? ??s)) (incl ??? ?? ???)) -> (x : ??? ?? ??? ??? s) -> isBase-?????? (???subst (incl (con c ts)) , ???subst (incl (var x)))
    isBase:con???con : ???{??sx ??sy ??} {?? : ???????????? ????}-> (c : Con ???? ??sx ??) (d : Con ???? ??sy ??)
                     -> (tsx : Terms-?????? ???? (incl (?? ??sx)) (incl ??? ?? ???))
                     -> (tsy : Terms-?????? ???? (incl (?? ??sy)) (incl ??? ?? ???))
                     -> ?? (??sx ??? ??sy)
                     -> isBase-?????? (???subst (incl (con c tsx)) , ???subst (incl (con d tsy)))

    isBase:con???con??? : ???{??sx ??} {?? : ???????????? ????}-> (c : Con ???? ??sx ??) (d : Con ???? ??sx ??)
                     -> (tsx : Terms-?????? ???? (incl (?? ??sx)) (incl ??? ?? ???))
                     -> (tsy : Terms-?????? ???? (incl (?? ??sx)) (incl ??? ?? ???))
                     -> ?? (c ??? d)
                     -> isBase-?????? (???subst (incl (con c tsx)) , ???subst (incl (con d tsy)))


  -- postulate
  --   size-?????? : ???{a b : ???????????? ????} -> Pair a b -> ????-??????

  -- SplitP : IxC (???????????? ????) -> IxC (???????????? ????) -> ???????
  -- SplitP (_ , _ , i) = (?? (_ , _ , j) -> size-?????? j ???-????-?????? size-?????? i)




  decide-Base-?????? : ???{a b : ???????????? ????} -> ???(f g : a ??? b) -> isBase-?????? (f , g) -> hasSizedCoequalizerDecision (f , g)
  decide-Base-?????? f g isBase:??? = right (hasSizedCoequalizer:byInitial)
  decide-Base-?????? f g (isBase:sym p) with decide-Base-?????? g f p
  ... | left ??p = left $ ?? q -> ??p (hasCoequalizerCandidate:bySym q)
  ... | right p = right (hasSizedCoequalizer:bySym p)
  decide-Base-?????? f .f isBase:id = right (hasSizedCoequalizer:byId)
  decide-Base-?????? .(???subst (incl (var x))) .(???subst (incl (var y))) (isBase:var {s} {??} x y y???x) = right (hasSizedCoequalizer:varvar x y y???x)
  decide-Base-?????? f g (isBase:con-var c ts v) with isFreeVar (con c ts) v
  ... | left ??occ = right (hasSizedCoequalizer:byNoOccur (con c ts) v ??occ)
  ... | just occ  = left (hasNoCoequalizerCandidate:byOccur (con c ts) v occ refl)
  decide-Base-?????? (???subst (incl (con c tsx))) (???subst (incl (con d tsy))) (isBase:con???con .c .d .tsx .tsy p)  = left (hasNoCoequalizerCandidate:byCon  c d tsx tsy p)
  decide-Base-?????? (???subst (incl (con c tsx))) (???subst (incl (con d tsy))) (isBase:con???con??? .c .d .tsx .tsy p) = left (hasNoCoequalizerCandidate:byCon??? c d tsx tsy p)



