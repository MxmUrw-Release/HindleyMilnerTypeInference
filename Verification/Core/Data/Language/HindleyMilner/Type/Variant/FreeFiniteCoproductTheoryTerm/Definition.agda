
module Verification.Core.Data.Language.HindleyMilner.Type.Variant.FreeFiniteCoproductTheoryTerm.Definition where


open import Verification.Conventions hiding (ℕ ; _⊔_)
open import Verification.Core.Set.Setoid.Definition
open import Verification.Core.Set.Discrete
open import Verification.Core.Algebra.Monoid.Definition

open import Verification.Core.Data.Product.Definition

open import Verification.Core.Data.Nat.Free
open import Verification.Core.Data.Universe.Definition
open import Verification.Core.Data.Universe.Instance.Category
open import Verification.Core.Data.List.Variant.Unary.Definition
open import Verification.Core.Data.List.Variant.Unary.Element
open import Verification.Core.Data.List.Variant.Unary.Natural
open import Verification.Core.Data.List.Variant.Binary.Definition
open import Verification.Core.Data.List.Dependent.Variant.Unary.Definition
open import Verification.Core.Data.List.Dependent.Variant.Binary.Definition
open import Verification.Core.Data.Substitution.Variant.Base.Definition

-- open import Verification.Core.Category.Std.Category.Definition
open import Verification.Core.Category.Std.Limit.Specific.Coequalizer
open import Verification.Core.Category.Std.Limit.Specific.Coproduct.Definition using (append-⦗⦘ ; ⦗≀_≀⦘)
open import Verification.Core.Category.Std.Limit.Specific.Coproduct.Instance.Functor
  -- renaming (_⇃⊔⇂_ to _⇃⊔⇂ᵘ_)

open import Verification.Core.Computation.Unification.Definition

open import Verification.Core.Theory.Std.Specific.FreeFiniteCoproductTheory.Param
open import Verification.Core.Theory.Std.Specific.FreeFiniteCoproductTheory.Definition
open import Verification.Core.Theory.Std.Specific.FreeFiniteCoproductTheory.Instance.Functor
open import Verification.Core.Theory.Std.Specific.FreeFiniteCoproductTheory.Instance.RelativeMonad
open import Verification.Core.Theory.Std.Specific.FreeFiniteCoproductTheory.Unification

open import Verification.Core.Data.Language.HindleyMilner.Helpers
open import Verification.Core.Data.Language.HindleyMilner.Type.Variant.FreeFiniteCoproductTheoryTerm.Signature

--------------------------------------
-- optimizations

open Overwrite:isCategory:⧜𝒯⊔Term 𝒹
open Overwrite:isCoproduct:⧜𝒯⊔Term 𝒹
open Overwrite:hasCoproducts:⧜𝒯⊔Term 𝒹
open Overwrite:hasFiniteCoproducts:⧜𝒯⊔Term 𝒹
open Overwrite:hasInitial:⧜𝒯⊔Term 𝒹
open Overwrite:isInitial:⧜𝒯⊔Term 𝒹

private
  _⟶_ = Hom
  -- _≅_ = _≅ᵘ_ {𝒞 = ⧜𝒯⊔Term 𝒹} {{isCategory:⧜𝐒𝐮𝐛𝐬𝐭 {T = 𝒯⊔term 𝒹}}}
  -- ⟨_⟩⁻¹ = ⟨_⟩⁻¹ᵘ {𝒞 = ⧜𝒯⊔Term 𝒹} {{isCategory:⧜𝐒𝐮𝐛𝐬𝐭 {T = 𝒯⊔term 𝒹}}}


-- abstract
--   infixl 100 _⇃⊔⇂_
--   _⇃⊔⇂_ : ∀{a b c d : ⧜𝒯⊔Term 𝒹} -> (a ⟶ b) -> (c ⟶ d) -> (a ⊔ c ⟶ b ⊔ d)
--   _⇃⊔⇂_ = _⇃⊔⇂ᵘ_



--------------------------------------
-- actual beginning

-- [Notation]
-- | We write |ℒHMType| for a term in that signature, i.e.:
ℒHMType : (Γ : 人ℕ) -> 𝒰₀
ℒHMType Γ = 𝒯⊔Term 𝒹 Γ tt
-- //

-- [Notation]
-- | We denote the category of type substitutions by:
ℒHMTypesᵘ : 𝒰₀
ℒHMTypesᵘ = ⧜𝐒𝐮𝐛𝐬𝐭 (𝒯⊔term 𝒹)

macro ℒHMTypes = #structureOn ℒHMTypesᵘ

-- //

-- [Hide]
st : ℒHMTypes
st = incl (incl tt)


asArr : ∀ {a} -> ℒHMType ⟨ a ⟩ -> st ⟶ a
asArr t = ⧜subst (incl t)

fromArr : ∀ {a} -> st ⟶ a -> ℒHMType ⟨ a ⟩
fromArr (⧜subst (incl x)) = x

abstract
  unify-ℒHMTypes : ∀{a b : ℒHMTypes} -> (f g : a ⟶ b) -> (¬ hasCoequalizerCandidate (f , g)) +-𝒰 (hasCoequalizer f g)
  unify-ℒHMTypes f g = unify f g


infixl 80 _⇃[_]⇂

abstract
  _⇃[_]⇂ : ∀{a b : ℒHMTypes} -> 𝒯⊔Term 𝒹 ⟨ a ⟩ tt -> (a ⟶ b) -> 𝒯⊔Term 𝒹 ⟨ b ⟩ tt
  _⇃[_]⇂ x f = fromArr (asArr x ◆ f)
  -- subst-⧜𝐒𝐮𝐛𝐬𝐭 f tt x

-- //



-- [Hide]

  --------------------------------------
  -- is setoid hom
  _⇃[≀_≀]⇂ : ∀{a b : ℒHMTypes} -> (τ : ℒHMType ⟨ a ⟩) -> {f g : a ⟶ b}
                -> f ∼ g -> τ ⇃[ f ]⇂ ≡ τ ⇃[ g ]⇂
  _⇃[≀_≀]⇂ τ {f = f} {g} p = cong fromArr (≡-Str→≡ (refl-≣ ◈ p))

  --------------------------------------
  -- respects ◆

  module _ {a b c : ℒHMTypes} where
    abstract
      functoriality-◆-⇃[]⇂ : ∀{τ : ℒHMType ⟨ a ⟩} -> {f : a ⟶ b} -> {g : b ⟶ c}
                              -> τ ⇃[ f ]⇂ ⇃[ g ]⇂ ≡ τ ⇃[ f ◆ g ]⇂
      functoriality-◆-⇃[]⇂ {τ} {f} {g} = cong fromArr lem-0
        where

          -- | Removing the abstraction. We switch over in two steps from the abstract
          --   to the non-abstract.
          lem-3a : (⧜subst (incl (fromArr (⧜subst (incl τ) 内◆-⧜𝐒𝐮𝐛𝐬𝐭 f))) 内◆-⧜𝐒𝐮𝐛𝐬𝐭 g)
                  ≡ (⧜subst (incl (fromArr (⧜subst (incl τ) ◆-⧜𝐒𝐮𝐛𝐬𝐭 f))) ◆-⧜𝐒𝐮𝐛𝐬𝐭 g)
          lem-3a =
            let p-0 : (⧜subst (incl (fromArr (⧜subst (incl τ) 内◆-⧜𝐒𝐮𝐛𝐬𝐭 f))) 内◆-⧜𝐒𝐮𝐛𝐬𝐭 g)
                    ≡ (⧜subst (incl (fromArr (⧜subst (incl τ) 内◆-⧜𝐒𝐮𝐛𝐬𝐭 f))) ◆-⧜𝐒𝐮𝐛𝐬𝐭 g)
                p-0 = sym-Path $ ≡-Str→≡ $ abstract-◆-⧜𝐒𝐮𝐛𝐬𝐭
                        {f = ⧜subst (incl (fromArr (⧜subst (incl τ) 内◆-⧜𝐒𝐮𝐛𝐬𝐭 f)))}
                        {g = g}

                p-1 : ((⧜subst (incl τ) 内◆-⧜𝐒𝐮𝐛𝐬𝐭 f))
                    ≡ ((⧜subst (incl τ) ◆-⧜𝐒𝐮𝐛𝐬𝐭 f))
                p-1 = sym-Path $ ≡-Str→≡ $ abstract-◆-⧜𝐒𝐮𝐛𝐬𝐭
                        {f = (⧜subst (incl τ))}
                        {g = f}

            in trans-Path p-0 (cong (λ ξ -> ⧜subst (incl (fromArr ξ)) ◆-⧜𝐒𝐮𝐛𝐬𝐭 g) p-1)

          -- | With removed `abstract`, the terms are definitionally equal.
          lem-3 : (⧜subst (incl (fromArr (⧜subst (incl τ) ◆-⧜𝐒𝐮𝐛𝐬𝐭 f))) ◆-⧜𝐒𝐮𝐛𝐬𝐭 g) ≡ (((asArr τ ◆-⧜𝐒𝐮𝐛𝐬𝐭 f)) ◆-⧜𝐒𝐮𝐛𝐬𝐭 g)
          lem-3 = refl-≡

          -- | Recreating the abstraction.
          lem-3b : (((asArr τ ◆-⧜𝐒𝐮𝐛𝐬𝐭 f)) ◆-⧜𝐒𝐮𝐛𝐬𝐭 g) ≡ (((asArr τ ◆ f)) ◆ g)
          lem-3b =
            let p-0 : (asArr τ ◆-⧜𝐒𝐮𝐛𝐬𝐭 f) ≡ (asArr τ ◆ f)
                p-0 = ≡-Str→≡ $ abstract-◆-⧜𝐒𝐮𝐛𝐬𝐭
                                    {f = asArr τ}
                                    {g = f}

                p-1 : (((asArr τ ◆ f)) ◆-⧜𝐒𝐮𝐛𝐬𝐭 g) ≡ (((asArr τ ◆ f)) ◆ g)
                p-1 = ≡-Str→≡ $ abstract-◆-⧜𝐒𝐮𝐛𝐬𝐭
                                    {f = asArr τ ◆ f}
                                    {g = g}

            in trans-Path (cong (_◆-⧜𝐒𝐮𝐛𝐬𝐭 g) p-0) p-1

          -- | The actual proof is by associativity.
          lem-2 : (((asArr τ 内◆-⧜𝐒𝐮𝐛𝐬𝐭 f)) 内◆-⧜𝐒𝐮𝐛𝐬𝐭 g) ≡ (⧜subst (incl τ) 内◆-⧜𝐒𝐮𝐛𝐬𝐭 (f 内◆-⧜𝐒𝐮𝐛𝐬𝐭 g))
          lem-2 = ≡-Str→≡ assoc-l-◆

          -- | With that we are done.
          lem-0 : (⧜subst (incl (fromArr (⧜subst (incl τ) 内◆-⧜𝐒𝐮𝐛𝐬𝐭 f))) 内◆-⧜𝐒𝐮𝐛𝐬𝐭 g) ≡ (⧜subst (incl τ) 内◆-⧜𝐒𝐮𝐛𝐬𝐭 (f 内◆-⧜𝐒𝐮𝐛𝐬𝐭 g))
          lem-0 = trans-Path (trans-Path lem-3a lem-3b) (lem-2)


  -------------------------
  -- respects id

  module _ {a : ℒHMTypes} where
    abstract
      functoriality-id-⇃[]⇂ : ∀{τ : ℒHMType ⟨ a ⟩} -> τ ⇃[ id ]⇂ ≡ τ
      functoriality-id-⇃[]⇂ {τ} = lem-0
        where
          lem-0 : fromArr (⧜subst (incl τ) 内◆-⧜𝐒𝐮𝐛𝐬𝐭 内id-⧜𝐒𝐮𝐛𝐬𝐭) ≡ τ
          lem-0 = cong fromArr (≡-Str→≡ (unit-r-◆ {f = (⧜subst (incl τ))}))

-- //
