
module Verification.Core.Theory.Std.Specific.MetaTermCalculus2.Pattern.Instance.FiniteColimitCategory where

open import Verification.Core.Conventions hiding (Structure)
open import Verification.Core.Set.Decidable
open import Verification.Core.Set.Discrete
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
open import Verification.Core.Theory.Std.TypologicalTypeTheory.CwJ.Definition
open import Verification.Core.Theory.Std.Generic.TypeTheory.Simple

open import Verification.Core.Category.Std.Category.Definition
open import Verification.Core.Category.Std.Category.As.Monoid
open import Verification.Core.Category.Std.Category.Structured.Monoidal.Definition
open import Verification.Core.Category.Std.Functor.Definition
open import Verification.Core.Category.Std.RelativeMonad.Definition
open import Verification.Core.Category.Std.RelativeMonad.KleisliCategory.Definition
open import Verification.Core.Category.Std.Category.Subcategory.Definition
open import Verification.Core.Category.Std.Morphism.EpiMono
open import Verification.Core.Category.Std.Morphism.Iso
open import Verification.Core.Category.Std.Limit.Specific.Coproduct.Definition
open import Verification.Core.Category.Std.Limit.Specific.Coequalizer

open import Verification.Core.Data.Indexed.Definition
open import Verification.Core.Data.Indexed.Instance.Monoid
open import Verification.Core.Data.FiniteIndexed.Definition
open import Verification.Core.Data.Renaming.Definition
open import Verification.Core.Data.Renaming.Instance.CoproductMonoidal

open import Verification.Core.Theory.Std.Specific.MetaTermCalculus2.Pattern.Definition
open import Verification.Core.Theory.Std.Specific.MetaTermCalculus2.Pattern.Instance.Category

open import Verification.Core.Computation.Unification.Monoidic.PrincipalFamilyCat2
open import Verification.Core.Order.WellFounded.Definition
open import Verification.Core.Order.Preorder
open import Verification.Core.Order.Lattice
open import Verification.Core.Computation.Unification.Definition
open import Verification.Core.Computation.Unification.Monoidic.PrincipalFamily
open import Verification.Core.Computation.Unification.Monoidic.ToCoequalizer
open import Verification.Core.Algebra.Monoid.Definition
open import Verification.Core.Algebra.MonoidWithZero.Definition
open import Verification.Core.Algebra.MonoidWithZero.Ideal
open import Verification.Core.Algebra.MonoidAction.Definition
open import Verification.Core.Category.Std.Limit.Specific.Coequalizer


module _ {K : Kinding ????} {{_ : isMetaTermCalculus ???? K}} where

  -- coeq-???????????? : (a b : ???????????? K) -> ???????????? K
  -- coeq-???????????? = {!!}

  instance
    isDiscrete:???????????? : isDiscrete (???????????? K)
    isDiscrete:???????????? = {!!}

  instance
    isSet-Str:???????????? : isSet-Str (???????????? K)
    isSet-Str:???????????? = {!!}

  instance
    isPrincipalFamilyCat:???????????? : isPrincipalFamilyCat (???????????? K)
    isPrincipalFamilyCat:???????????? = {!!}

  private
    module _ {a b : ???????????? K} (f g : a ??? b) where

      M : Monoid??? _
      M = ??? PathMon (???????????? K) ???

      lem-10 : isPrincipalFamily M _ _ _
      lem-10 = by-PrincipalCat-Principal (???????????? K)

      lem-20 : isPrincipal/???-r _ ???(CoeqSolutions (arrow f) (arrow g))???
      lem-20 = isPrincipal:Family M _ _ _ {{lem-10}} _ (just (_ , _ , f , g)) refl-???

      lem-30 : isDecidable (hasCoequalizer f g)
      lem-30 = by-Principal-Unification.proof f g lem-20

  instance
    hasUnification:???????????? : hasUnification (???????????? K)
    hasUnification:???????????? = record { unify = lem-30 }





