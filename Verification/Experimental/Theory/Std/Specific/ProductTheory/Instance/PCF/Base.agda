
module Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.PCF.Base where

open import Verification.Conventions hiding (Structure)

-- open import Verification.Experimental.Conventions hiding (Structure ; isSetoid:byPath)
open import Verification.Experimental.Set.Decidable
open import Verification.Experimental.Set.Discrete
open import Verification.Experimental.Algebra.Monoid.Definition
open import Verification.Experimental.Algebra.Monoid.Free
open import Verification.Experimental.Algebra.Monoid.Free.Element
-- open import Verification.Experimental.Order.Lattice
open import Verification.Experimental.Data.Universe.Everything -- hiding (isSetoid:Function)
open import Verification.Experimental.Data.Product.Definition
-- open import Verification.Experimental.Theory.Std.Generic.TypeTheory.Definition
-- open import Verification.Experimental.Theory.Std.Generic.TypeTheory.Simple
-- open import Verification.Experimental.Theory.Std.Generic.TypeTheory.Simple.Judgement2
-- open import Verification.Experimental.Theory.Std.TypologicalTypeTheory.CwJ.Kinding
-- open import Verification.Experimental.Theory.Std.Generic.TypeTheory.Simple
-- open import Verification.Experimental.Theory.Std.Specific.MetaTermCalculus2.Pattern.Definition

open import Verification.Experimental.Category.Std.Category.Definition
-- open import Verification.Experimental.Category.Std.Category.Structured.Monoidal.Definition
open import Verification.Experimental.Category.Std.Functor.Definition
open import Verification.Experimental.Category.Std.RelativeMonad.Definition
open import Verification.Experimental.Category.Std.RelativeMonad.KleisliCategory.Definition
open import Verification.Experimental.Category.Std.Category.Subcategory.Definition
open import Verification.Experimental.Category.Std.Morphism.EpiMono
open import Verification.Experimental.Category.Std.Morphism.Iso
open import Verification.Experimental.Category.Std.Limit.Specific.Coproduct.Definition
open import Verification.Experimental.Category.Std.Limit.Specific.Coequalizer.Definition
open import Verification.Experimental.Category.Std.Limit.Specific.Coequalizer.Property.Base
open import Verification.Experimental.Category.Std.Limit.Specific.Coequalizer.Reflection
-- open import Verification.Experimental.Category.Std.Limit.Specific.Coproduct.Preservation.Definition

open import Verification.Experimental.Order.WellFounded.Definition
open import Verification.Experimental.Order.Preorder 
open import Verification.Experimental.Order.Lattice hiding (⊥)

open import Verification.Experimental.Data.List.Definition
open import Verification.Experimental.Data.Nat.Free
open import Verification.Experimental.Data.Indexed.Definition
open import Verification.Experimental.Data.Indexed.Instance.Monoid
open import Verification.Experimental.Data.FiniteIndexed.Definition
open import Verification.Experimental.Data.Renaming.Definition
open import Verification.Experimental.Data.Renaming.Instance.CoproductMonoidal
open import Verification.Experimental.Data.Substitution.Definition
open import Verification.Experimental.Data.FiniteIndexed.Property.Merge

open import Verification.Experimental.Theory.Std.Generic.FormalSystem.Definition
open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Definition
open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.FormalSystem

open import Verification.Experimental.Computation.Unification.Monoidic.PrincipalFamilyCat2

-- open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.PCF.Var
-- open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.PCF.Occur
-- open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.PCF.OccurFail
-- open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.PCF.DirectFail


WF-𝕋× : 𝒰₀
WF-𝕋× = ℕ ^ 3

macro 𝒲-𝕋× = #structureOn WF-𝕋×

postulate
  _≪-𝒲-𝕋×_ : 𝒲-𝕋× -> 𝒲-𝕋× -> 𝒰 ℓ₀
  WellFounded-≪-𝒲-𝕋× : WellFounded _≪-𝒲-𝕋×_


instance
  isWellfounded:𝒲-𝕋× : isWF {ℓ₀} ℓ₀ 𝒲-𝕋×
  isWellfounded:𝒲-𝕋× = record { _≪_ = _≪-𝒲-𝕋×_ ; wellFounded = WellFounded-≪-𝒲-𝕋× }

instance
  isWFT:𝒲-𝕋× : isWFT 𝒲-𝕋×
  isWFT:𝒲-𝕋× = {!!}



module _ {𝑨 : 𝕋× 𝑖} where


  data isBase-𝕋× : ∀{x y : 𝐂𝐭𝐱 𝑨} -> Pair x y -> 𝒰 𝑖 where
    isBase:⊥ : ∀{x : 𝐂𝐭𝐱 𝑨} -> {f g : ⊥ ⟶ x} -> isBase-𝕋× (f , g)
    isBase:sym : ∀{x y : 𝐂𝐭𝐱 𝑨} -> {f g : x ⟶ y} -> isBase-𝕋× (f , g) -> isBase-𝕋× (g , f)
    isBase:id : ∀{x y : 𝐂𝐭𝐱 𝑨} -> {f : x ⟶ y} -> isBase-𝕋× (f , f)
    isBase:var : ∀{s : Type 𝑨} {Γ : 𝐂𝐭𝐱 𝑨} (x y : ⟨ Γ ⟩ ∍ s) -> (y ≠-∍ x) -> isBase-𝕋× (incl (var x) , incl (var y))
    isBase:con-var : ∀{s : Type 𝑨} {Γ : 𝐂𝐭𝐱 𝑨}
                     -> ∀{αs} -> (c : Con 𝑨 αs s) -> (ts : Terms-𝕋× 𝑨 (incl (ι αs)) (incl ⟨ Γ ⟩)) -> (x : ⟨ Γ ⟩ ∍ s) -> isBase-𝕋× (incl (con c ts) , incl (var x))
    isBase:con≠con : ∀{αsx αsy α} {Γ : 𝐂𝐭𝐱 𝑨}-> (c : Con 𝑨 αsx α) (d : Con 𝑨 αsy α)
                     -> (tsx : Terms-𝕋× 𝑨 (incl (ι αsx)) (incl ⟨ Γ ⟩))
                     -> (tsy : Terms-𝕋× 𝑨 (incl (ι αsy)) (incl ⟨ Γ ⟩))
                     -> ¬ (αsx ≣ αsy)
                     -> isBase-𝕋× (incl (con c tsx) , incl (con d tsy))

    isBase:con≠con₂ : ∀{αsx α} {Γ : 𝐂𝐭𝐱 𝑨}-> (c : Con 𝑨 αsx α) (d : Con 𝑨 αsx α)
                     -> (tsx : Terms-𝕋× 𝑨 (incl (ι αsx)) (incl ⟨ Γ ⟩))
                     -> (tsy : Terms-𝕋× 𝑨 (incl (ι αsx)) (incl ⟨ Γ ⟩))
                     -> ¬ (c ≣ d)
                     -> isBase-𝕋× (incl (con c tsx) , incl (con d tsy))


  postulate
    size-𝕋× : ∀{a b : 𝐂𝐭𝐱 𝑨} -> Pair a b -> 𝒲-𝕋×

  SplitP : IxC (𝐂𝐭𝐱 𝑨) -> IxC (𝐂𝐭𝐱 𝑨) -> 𝒰₀
  SplitP (_ , _ , i) = (λ (_ , _ , j) -> size-𝕋× j ≪-𝒲-𝕋× size-𝕋× i)


{-
  decide-Base-𝕋× : ∀{a b : 𝐂𝐭𝐱 𝑨} -> ∀(f g : a ⟶ b) -> isBase-𝕋× (f , g) -> isDecidable (hasCoequalizer f g)
  decide-Base-𝕋× f g isBase:⊥ = right hasCoequalizer:byInitial
  decide-Base-𝕋× f g (isBase:sym p) with decide-Base-𝕋× g f p
  ... | left ¬p = left $ λ q -> ¬p (hasCoequalizer:bySym q)
  ... | right p = right (hasCoequalizer:bySym p)
  decide-Base-𝕋× f .f isBase:id = right hasCoequalizer:byId
  decide-Base-𝕋× .(incl (var x)) .(incl (var y)) (isBase:var {s} {Γ} x y y≠x) = right (hasCoequalizer:varvar x y y≠x)
  decide-Base-𝕋× f g (isBase:con-var c ts v) with isFreeVar (con c ts) v
  ... | left ¬occ = right (hasCoequalizer:byNoOccur (con c ts) v ¬occ)
  ... | just occ  = left (hasNoCoequalizer:byOccur (con c ts) v occ refl)
  decide-Base-𝕋× (incl (con c tsx)) (incl (con d tsy)) (isBase:con≠con .c .d .tsx .tsy p)  = left (hasNoCoequalizer:byCon  c d tsx tsy p)
  decide-Base-𝕋× (incl (con c tsx)) (incl (con d tsy)) (isBase:con≠con₂ .c .d .tsx .tsy p) = left (hasNoCoequalizer:byCon₂ c d tsx tsy p)

-}

