
module Verification.Core.Theory.Std.Specific.MetaTermCalculus2.Pattern.Instance.DoubleCategory where

open import Verification.Core.Conventions hiding (Structure ; _⊔_ ; extend)
open import Verification.Core.Algebra.Monoid.Definition
open import Verification.Core.Algebra.Monoid.Free
open import Verification.Core.Data.List.Variant.FreeMonoid.Element
open import Verification.Core.Order.Lattice hiding (⊥)
open import Verification.Core.Data.Universe.Everything
open import Verification.Core.Data.Product.Definition
open import Verification.Core.Theory.Std.Generic.TypeTheory.Definition
open import Verification.Core.Theory.Std.Generic.TypeTheory.Simple
open import Verification.Core.Theory.Std.Generic.TypeTheory.Simple.Judgement2
open import Verification.Core.Theory.Std.TypologicalTypeTheory.CwJ.Kinding
open import Verification.Core.Theory.Std.Generic.TypeTheory.Simple
open import Verification.Core.Theory.Std.Specific.MetaTermCalculus2.Pattern.Definition

open import Verification.Core.Category.Std.Category.Definition
open import Verification.Core.Category.Std.Category.Opposite
open import Verification.Core.Category.Std.Category.Opposite.Instance.Monoid
open import Verification.Core.Category.Std.Category.Instance.Category
open import Verification.Core.Category.Std.Category.Structured.Monoidal.Definition
open import Verification.Core.Category.Std.Functor.Definition
open import Verification.Core.Category.Std.RelativeMonad.Definition
open import Verification.Core.Category.Std.RelativeMonad.KleisliCategory.Definition
open import Verification.Core.Category.Std.Category.Subcategory.Definition
open import Verification.Core.Category.Std.Morphism.EpiMono
open import Verification.Core.Category.Std.Limit.Specific.Coproduct.Preservation.Definition
open import Verification.Core.Category.Std.Limit.Specific.Coproduct.Definition

open import Verification.Core.Data.Universe.Everything
open import Verification.Core.Data.Universe.Instance.FiniteCoproductCategory
open import Verification.Core.Data.Indexed.Definition
open import Verification.Core.Data.Indexed.Instance.Monoid
open import Verification.Core.Data.FiniteIndexed.Definition
open import Verification.Core.Data.Indexed.Instance.FiniteCoproductCategory
open import Verification.Core.Data.Renaming.Definition
open import Verification.Core.Data.Renaming.Instance.CoproductMonoidal
open import Verification.Core.Data.Substitution.Definition
open import Verification.Core.Data.MultiRenaming.Definition
open import Verification.Core.Data.MultiRenaming.Instance.FiniteCoproductCategory

open import Verification.Core.Category.Std.Category.Opposite
open import Verification.Core.Category.Std.Category.Subcategory.Full
open import Verification.Core.Category.Std.Category.Subcategory.Definition
open import Verification.Core.Category.Std.Fibration.GrothendieckConstruction.Op.Definition
open import Verification.Core.Category.Std.Fibration.GrothendieckConstruction.Op.Instance.FiniteCoproductCategory



module _ {A : 𝒰 𝑖} where
  FinFam : (as : ⋆List A) -> (B : 𝒰 𝑗) -> 𝒰 _
  FinFam as B = ∀{a} -> (as ∍ a) -> B

  data ⧜FinFam (B : 𝒰 𝑗) : (as : ⋆List A) -> 𝒰 (𝑖 ､ 𝑗) where
    incl : ∀{a} -> B -> ⧜FinFam B (incl a)
    ◌-⧜ : ⧜FinFam B ◌
    _⋆-⧜_ : ∀{as bs} -> ⧜FinFam B as -> ⧜FinFam B bs -> ⧜FinFam B (as ⋆ bs)


  data ∏-⧜FinFam {𝑗} : (as : ⋆List A) (B : ⧜FinFam (𝒰 𝑗) as) -> 𝒰 (𝑖 ､ 𝑗 ⁺) where
    incl : ∀{a} {B : 𝒰 𝑗} -> (b : B) -> ∏-⧜FinFam (incl a) (incl B)
    _⋆-⧜_ : ∀{as bs A B} -> ∏-⧜FinFam as A -> ∏-⧜FinFam bs B -> ∏-⧜FinFam (as ⋆ bs) (A ⋆-⧜ B)
    ◌-⧜ : ∏-⧜FinFam ◌ ◌-⧜

  module _ {X : 𝒰 _} {{_ : Monoid 𝑗 on X}} where
    ⭑ : {as : ⋆List A} (F : FinFam as X) -> X
    ⭑ {incl x} F = F incl
    ⭑ {as ⋆-⧜ bs} F = ⭑ {as} (λ x → F (left-∍ x)) ⋆ ⭑ {bs} (λ x → F (right-∍ x))
    ⭑ {◌-⧜} F = ◌


module _ {K : Kinding 𝑖} {{_ : isMetaTermCalculus 𝑖 K}} where


  private
    𝖩 : 𝒰 _
    𝖩 = Jdg₂ ⟨ K ⟩


  ν₋ : 𝐌𝐮𝐥𝐭𝐢𝐑𝐞𝐧 ⟨ K ⟩ 𝖩 -> ⋆List 𝖩
  ν₋ (incl (incl a) , as)            = incl $ ⟨ ⟨ ⟨ ix as (a , incl) ⟩ ⟩ ⟩ ⇒ a
  ν₋ (incl (a ⋆-⧜ b) , as)   = ν₋ ((incl a) , {!!}) ⋆ ν₋ ((incl b) , {!!})
  ν₋ (incl ◌-⧜ , as)          = {!!}

  -- ν₋ (interren (incl (incl α)) αs) = incl (⟨ ⟨ αs incl ⟩ ⟩ ⇒ α)
  -- ν₋ (interren (incl (a ⋆-⧜ b)) αs) = 
  -- ν₋ (interren (incl ◌-⧜) αs) = {!!}

  ν₊ : ⋆List 𝖩 -> 𝐌𝐮𝐥𝐭𝐢𝐑𝐞𝐧 ⟨ K ⟩ 𝖩
  ν₊ (incl (αs ⇒ α)) = incl (incl α) , indexed (λ x → incl (incl (incl αs)))
  -- interren (incl (incl α)) λ x → incl (incl αs)
  ν₊ (a ⋆-⧜ b) = ν₊ a ⊔ ν₊ b
  ν₊ ◌-⧜ = ⊥

  ν₊-∍ : ∀{J : ⋆List 𝖩} -> ∀{a} -> (p : ⟨ base (ν₊ J) ⟩ ∍ a) -> J ∍ (⟨ ⟨ ⟨ ix (fib (ν₊ J)) (a , p) ⟩ ⟩ ⟩ ⇒ a)
  ν₊-∍ {incl x} incl = incl
  ν₊-∍ {J₁ ⋆-⧜ J₂} (right-∍ p) = right-∍ (ν₊-∍ p)
  ν₊-∍ {J₁ ⋆-⧜ J₂} (left-∍ p)  = left-∍ (ν₊-∍ p)




  mutual
    data Pat-inter (Γ : List 𝖩) : (Δ : ⋆List 𝖩) (𝔍 : ⋆List 𝖩) -> 𝒰 𝑖 where
      incl : ∀{𝔍 : (⋆List 𝖩)} -> ∀{j} -> 𝔍 ⊩-inter (γₗ Γ j) -> Pat-inter Γ (incl j) 𝔍
      _⋆-⧜_ : ∀{j1 j2 k1 k2} -> Pat-inter Γ j1 k1 -> Pat-inter Γ j2 k2 -> Pat-inter Γ (j1 ⋆ j2) (k1 ⋆ k2)
      ◌-⧜ : Pat-inter Γ ◌ ◌



    data _⊩-inter_ : (𝔍s : ⋆List 𝖩) -> 𝖩 -> 𝒰 𝑖 where

      app-meta  : (Γ : ⟨ InjVars ⟩) (α : ⟨ K ⟩)
                -- -> (M : 𝔍 ∍ ((⟨ ⟨ Δ ⟩ ⟩ ⇒ α))) -- -> (s : (Δ) ⟶ (Γ))
                -> incl (⟨ ⟨ Γ ⟩ ⟩ ⇒ α) ⊩-inter (⟨ ⟨ Γ ⟩ ⟩  ⇒ α)

      app-var : ∀{𝔍 Γ Δ α}
              -> ι Γ ∍ (Δ ⇒ α) -> Pat-inter Γ (ι Δ) 𝔍
              -> 𝔍 ⊩-inter (Γ ⇒ α)

      app-con : ∀{𝔍 Γ Δ α}
              -> TermCon (Δ ⇒ α) -> Pat-inter Γ (ι Δ) 𝔍
              -> 𝔍 ⊩-inter (Γ ⇒ α)

  -- mutual
  --   compose-lam : {Γ : List 𝖩} {Δ : ⋆List 𝖩} -> {I J : ⋆List 𝖩}
  --               -> ν₊ (I) ⟶ ν₊ J
  --               -> Pat-inter Γ Δ I
  --               -> 𝑒𝑙 Δ ⟶ indexed (λ {j -> J ⊩ᶠ-pat (γₗ Γ j)})
  --   compose-lam f (incl x)  i incl        = compose f x
  --   compose-lam f (x ⋆-⧜ y) i (left-∍ p)  = compose-lam (ι₀ ◆ f) x i p
  --   compose-lam f (x ⋆-⧜ y) i (right-∍ p) = compose-lam (ι₁ ◆ f) y i p
  --   compose-lam f ◌-⧜       i ()


  --   compose : ∀{I J : ⋆List 𝖩} {i : 𝖩} -> (ν₊ I ⟶ ν₊ J) -> I ⊩-inter i -> J ⊩ᶠ-pat i
  --   compose {I} {J} f (app-meta Γ α) = app-meta (ν₊-∍ (⟨ base f ⟩ α incl)) ⟨(fib f (α , incl))⟩
  --   compose f (app-var x (tsx)) = app-var x (lam (compose-lam f tsx))
  --   compose f (app-con x (tsx)) = app-con x (lam (compose-lam f tsx))

  mutual
    decompose : ∀{J : ⋆List 𝖩} {i : 𝖩} -> J ⊩ᶠ-pat i -> ∑ λ I -> ∑ λ (f : (ν₊ I ⟶ ν₊ J)) -> I ⊩-inter i
    decompose (app-meta {Γ = Γ} {Δ = Δ} {α = α} M s) = incl (⟨ ⟨ Γ ⟩ ⟩ ⇒ α) , ({!!} , app-meta Γ α)
    decompose (app-var x x₁) = {!!}
    decompose (app-con x x₁) = {!!}

    extend : ∀{J : ⋆List 𝖩} {Γ Δ : ♮𝐑𝐞𝐧 𝖩} {α : ⟨ K ⟩} -> J ⊩-inter (⟨ ⟨ Δ ⟩ ⟩ ⇒ α) -> Γ ⟶ Δ
             -> ∑ λ (L : ⋆List 𝖩) -> ∑ λ (f' : ν₊ J ⟶ ν₊ L) -> L ⊩-inter (⟨ ⟨ Γ ⟩ ⟩ ⇒ α)

    extend {J} {Γ} {Δ} {α} (app-meta (incl (incl a)) α) f = _ , ((id , λ i → incl f) , app-meta _ α)
    extend (app-var x x₁) f = {!!} , ({!!} , app-var {!!} {!!})
    extend (app-con x ts) f = {!!} , ({!!} , app-con x {!!})






