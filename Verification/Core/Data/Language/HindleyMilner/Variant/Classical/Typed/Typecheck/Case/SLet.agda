
module Verification.Core.Data.Language.HindleyMilner.Variant.Classical.Typed.Typecheck.Case.SLet where

open import Verification.Conventions hiding (ℕ ; _⊔_)
open import Verification.Core.Set.Setoid.Definition
open import Verification.Core.Set.Discrete
open import Verification.Core.Algebra.Monoid.Definition

open import Verification.Core.Data.Product.Definition
open import Verification.Core.Data.Sum.Definition

open import Verification.Core.Data.Substitution.Variant.Base.Definition

open import Verification.Core.Data.List.Variant.Unary.Definition
open import Verification.Core.Data.List.Variant.Unary.Element
open import Verification.Core.Data.List.Variant.Unary.Natural
open import Verification.Core.Data.List.Variant.Binary.Definition
open import Verification.Core.Data.List.Variant.Unary.Element
open import Verification.Core.Data.List.Dependent.Variant.Unary.Definition
open import Verification.Core.Data.List.Dependent.Variant.Binary.Definition

open import Verification.Core.Theory.Std.Specific.FreeFiniteCoproductTheory.Param
open import Verification.Core.Theory.Std.Specific.FreeFiniteCoproductTheory.Definition
open import Verification.Core.Theory.Std.Specific.FreeFiniteCoproductTheory.Instance.Functor
open import Verification.Core.Theory.Std.Specific.FreeFiniteCoproductTheory.Instance.RelativeMonad

-- open import Verification.Core.Category.Std.Category.Definition
open import Verification.Core.Category.Std.Morphism.Iso renaming (_≅_ to _≅ᵘ_ ; ⟨_⟩⁻¹ to ⟨_⟩⁻¹ᵘ)
open import Verification.Core.Category.Std.Category.Subcategory.Full
open import Verification.Core.Category.Std.Limit.Specific.Coequalizer
-- open import Verification.Core.Category.Std.Limit.Specific.Coproduct.Definition
open import Verification.Core.Category.Std.Limit.Specific.Coproduct.Instance.Functor
open import Verification.Core.Category.Std.Factorization.EpiMono.Variant.Split.Definition
open import Verification.Core.Computation.Unification.Definition

open import Verification.Core.Data.Language.HindleyMilner.Type.Variant.FreeFiniteCoproductTheoryTerm.Definition
open import Verification.Core.Data.Language.HindleyMilner.Type.Variant.FreeFiniteCoproductTheoryTerm.Signature
open import Verification.Core.Data.Language.HindleyMilner.Helpers
open import Verification.Core.Data.Language.HindleyMilner.Variant.Classical.Untyped.Definition
open import Verification.Core.Data.Language.HindleyMilner.Variant.Classical.Typed.Context
open import Verification.Core.Data.Language.HindleyMilner.Variant.Classical.Typed.Context.Definition
open import Verification.Core.Data.Language.HindleyMilner.Variant.Classical.Typed.Context.Properties
open import Verification.Core.Data.Language.HindleyMilner.Variant.Classical.Typed.Definition
open import Verification.Core.Data.Language.HindleyMilner.Variant.Classical.Typed.Typecheck.Statement
open import Verification.Core.Data.Language.HindleyMilner.Variant.Classical.Typed.Definition2

open import Verification.Core.Order.Preorder

open Overwrite:isCategory:⧜𝒯⊔Term 𝒹
open Overwrite:isCoproduct:⧜𝒯⊔Term 𝒹
open Overwrite:hasCoproducts:⧜𝒯⊔Term 𝒹
open Overwrite:hasFiniteCoproducts:⧜𝒯⊔Term 𝒹
open Overwrite:hasInitial:⧜𝒯⊔Term 𝒹
open Overwrite:isInitial:⧜𝒯⊔Term 𝒹

private
  _≅_ = _≅ᵘ_ {𝒞 = ⧜𝒯⊔Term 𝒹} {{isCategory:⧜𝐒𝐮𝐛𝐬𝐭 {T = 𝒯⊔term 𝒹}}}
  ⟨_⟩⁻¹ = ⟨_⟩⁻¹ᵘ {𝒞 = ⧜𝒯⊔Term 𝒹} {{isCategory:⧜𝐒𝐮𝐛𝐬𝐭 {T = 𝒯⊔term 𝒹}}}
  _⟶_ = Hom


-- {-# DISPLAY isCoequalizer.π₌ _ = π₌ #-}
-- {-# DISPLAY isCoproduct.ι₀ _ = ι₀ #-}
-- {-# DISPLAY isCoproduct.ι₁ _ = ι₁ #-}
{-# DISPLAY _内◆-⧜𝐒𝐮𝐛𝐬𝐭_ f g = f ◆ g #-}
{-# DISPLAY 内id-⧜𝐒𝐮𝐛𝐬𝐭 = id #-}


private
  assoc-l-⊔-ℒHMTypes : ∀{a b c : ℒHMTypes} -> (a ⊔ b) ⊔ c ≅ a ⊔ (b ⊔ c)
  assoc-l-⊔-ℒHMTypes = {!!}


-- [Lemma]
-- | "Inversion of SLet". The following holds.

inv-slet : ∀{k νs} {Q : ℒHMQuant k} {Γ' : ℒHMCtxFor Q νs} {β : ℒHMType ⟨ νs ⟩}
           --------------------------------------
           -- constructor inputs
           -> {te₀ : UntypedℒHM k} {te₁ : UntypedℒHM (tt ∷ k)}
           --------------------------------------
           -- condition: is typed
           -> isTypedℒHM (νs ⊩ (Q , Γ') ⊢ β) (slet te₀ te₁)
           --------------------------------------
           -- result: we have a lot
           -> ∑ λ μs -> ∑ λ κs -> ∑ λ (Γ : ℒHMCtxFor Q μs)
           -> ∑ λ (α : ℒHMType ⟨ μs ⟩)
           -> ∑ λ (α' : ℒHMType ⟨ νs ⊔ κs ⟩)
           -> isAbstr κs Γ Γ' α α'
              × isTypedℒHM (μs ⊩ (Q , Γ) ⊢ α) te₀
              × isTypedℒHM (νs ⊩ (κs ∷' Q , α' ∷ Γ') ⊢ β) te₁
-- //
-- [Proof]
-- | By definition [].
inv-slet (slet x x₁ x₂) = _ , _ , _ , _ , _ , x , x₁ , x₂
-- //

-- [Proposition]
-- | Assuming the induction hypothesis, the /slet/ case is
--   typecheckable with an initial typing instance.

-- //

-- [Proof]
-- | Let [..], [..], [..], [..] be the input of the
--   algorithm.
module typecheck-slet {μsᵤ : ℒHMTypes} {k : ♮ℕ} {Q : ℒHMQuant k} (Γ : ℒHMCtxFor Q μsᵤ) where

  -- | Furthermore, assume we have the terms [..] and [..].
  module _ (te : UntypedℒHM k) (se : UntypedℒHM (tt ∷ k)) where

    -- | First, the algorithm computes the typing for |te|,
    --   thus we assume that there is such a typing instance.
    module _ (𝑇-te! : InitialCtxTypingInstance Γ te) where

      open Σ 𝑇-te! renaming
        ( fst to 𝑇-te
        ; snd to Ω₀
        )

      open CtxTypingInstance 𝑇-te renaming
        ( metas to νs₀ₐ
        ; typeMetas to νs₀ₓ
        ; ctx to Γ₀
        ; typ to αᵇ₀
        ; isInstance to Γ<Γ₀
        ; hasType to Γ₀⊢αᵇ₀
        )
      -- (νs₀ₐ / νs₀ₓ ⊩ Γ₀ , αᵇ₀ , Γ<Γ₀ , Γ₀⊢αᵇ₀)

      -- | Once we have typechecked te, we know that νs₀ₓ are the
      --   variables over which the type αᵇ₀ is quantified
      --   thus the context in which we typecheck `se` is the following
      α₀Γ₀ : ℒHMCtxFor (νs₀ₓ ∷' Q) νs₀ₐ
      α₀Γ₀ = αᵇ₀ ∷ Γ₀

      σᵃᵤ₀ = fst Γ<Γ₀

      -- | With this context we typecheck |se|, thus let us assume
      --   that there is such a typing instance [....]
      module _ (𝑇-se! : InitialCtxTypingInstance (α₀Γ₀) se) where

        open Σ 𝑇-se! renaming
          ( fst to 𝑇-se
          ; snd to Ω₁
          )

        open CtxTypingInstance 𝑇-se renaming
          ( metas to νs₁ₐ
          ; typeMetas to νs₁ₓ
          ; ctx to Δ
          ; typ to βᵇ₁
          ; isInstance to α₀Γ₀<Δ
          ; hasType to Δ⊢βᵇ₁
          )
        -- (νs₁ₐ / νs₁ₓ ⊩ Δ , βᵇ₁ , α₀Γ₀<Δ , Δ⊢βᵇ₁)
        -- module _ (((νs₁ₐ / νs₁ₓ ⊩ α₁Γ₁ , βᵇ₁ , α₀Γ₀<α₁Γ₁ , α₁Γ₁⊢βᵇ₁), Ω₁) : InitialCtxTypingInstance (α₀Γ₀) se) where

        -- | Since we know that |Δ| has the same quantifications as |α₀Γ₀|,
        --   we also know that it splits into [..] and [..].
        α₁ = split-Listᴰ² Δ .fst
        Γ₁ = split-Listᴰ² Δ .snd

        -- | Call this one
        α₁Γ₁ : ℒHMCtxFor (νs₀ₓ ∷' Q) νs₁ₐ
        α₁Γ₁ = α₁ ∷ Γ₁

        -- | And we have actually [..] [] [].
        lem-00 : Δ ≡ α₁Γ₁
        lem-00 with Δ
        ... | (α₁ ∷ Γ₁) = refl-≡

        -- | We can restore the typing judgement to this context, i.e., we have
        α₁Γ₁⊢βᵇ₁ : isTypedℒHM ((νs₁ₐ ⊔ νs₁ₓ) ⊩ (_ , α₁Γ₁ ⇃[ ι₀ ]⇂ᶜ) ⊢ βᵇ₁) se
        α₁Γ₁⊢βᵇ₁ = Δ⊢βᵇ₁
                   ⟪ transp-isTypedℒHM (cong (_⇃[ ι₀ ]⇂ᶜ) lem-00) refl-≡ ⟫

        -- | We have the following facts.
        Γ₀<Γ₁ : Γ₀ <Γ Γ₁
        Γ₀<Γ₁ = record { fst = α₀Γ₀<Δ .fst ; snd = {!!} }
        -- Γ₀<Γ₁ = record { fst = α₀Γ₀<α₁Γ₁ .fst ; snd = {!!} }
        --   -- tail-SomeℒHMCtx α₀Γ₀<α₁Γ₁

        σᵃ₀₁ = fst Γ₀<Γ₁

        α₁' : ℒHMType ⟨ νs₁ₐ ⊔ νs₁ₓ ⊔ νs₀ₓ ⟩
        α₁' = (α₁ ⇃[ ι₀ ⇃⊔⇂ id ]⇂)

        lem-1a : αᵇ₀ ⇃[ σᵃ₀₁ ⇃⊔⇂ id ]⇂ ≡ α₁
        lem-1a = {!!} -- λ i -> split-Listᴰ² (α₀Γ₀<α₁Γ₁ .snd i) .fst

        lem-1b : Γ₀ ⇃[ σᵃ₀₁ ]⇂ᶜ ≡ Γ₁
        lem-1b = {!!} -- λ i -> split-Listᴰ² (α₀Γ₀<α₁Γ₁ .snd i) .snd


        -- | And this typing judgement.
        -- abstract
        Γ₁⊢α₁' : isTypedℒHM (νs₁ₐ ⊔ νs₁ₓ ⊔ νs₀ₓ ⊩ (_ , Γ₁ ⇃[ ι₀ ◆ ι₀ ]⇂ᶜ) ⊢ α₁') te
        Γ₁⊢α₁' = Γ₀⊢αᵇ₀
                  >> isTypedℒHM ((νs₀ₐ ⊔ νs₀ₓ) ⊩ Q , (Γ₀ ⇃[ ι₀ ]⇂ᶜ) ⊢ αᵇ₀) te <<

                  ⟪ §-isTypedℒHM.prop-4 {Γ = Γ₀} σᵃ₀₁ id ⟫

                  >> isTypedℒHM (_ ⊩ Q , (Γ₀ ⇃[ σᵃ₀₁ ]⇂ᶜ ⇃[ ι₀ ]⇂ᶜ) ⊢ αᵇ₀ ⇃[ σᵃ₀₁ ⇃⊔⇂ id ]⇂) te <<

                  ⟪ transp-isTypedℒHM (cong _⇃[ ι₀ ]⇂ᶜ lem-1b) lem-1a ⟫

                  >> isTypedℒHM (_ ⊩ Q , (Γ₁ ⇃[ ι₀ ]⇂ᶜ) ⊢ α₁ ) te <<

                  ⟪ §-isTypedℒHM.prop-4 {Γ = Γ₁} ι₀ id ⟫

                  >> isTypedℒHM (_ ⊩ Q , (Γ₁ ⇃[ ι₀ ]⇂ᶜ ⇃[ ι₀ ]⇂ᶜ) ⊢ α₁ ⇃[ ι₀ ⇃⊔⇂ id ]⇂ ) te <<

                  ⟪ transp-isTypedℒHM (functoriality-◆-⇃[]⇂-CtxFor {Γ = Γ₁}) refl-≡ ⟫

                  >> isTypedℒHM (_ ⊩ Q , (Γ₁ ⇃[ ι₀ ◆ ι₀ ]⇂ᶜ) ⊢ α₁ ⇃[ ι₀ ⇃⊔⇂ id ]⇂ ) te <<



        -- | And this lemma.
        lem-2 : Γ₁ ⇃[ ι₀ {b = νs₁ₓ} ◆ ι₀ {b = νs₀ₓ} ]⇂ᶜ ⇃[ ⟨ refl-≅ ⟩ ]⇂ᶜ ≡ Γ₁ ⇃[ ι₀ ]⇂ᶜ ⇃[ ι₀ ]⇂ᶜ
        lem-2 = trans-Path (functoriality-id-⇃[]⇂-CtxFor) (sym-Path (functoriality-◆-⇃[]⇂-CtxFor {Γ = Γ₁}))

        -- | And something is an abstraction.
        isAb : isAbstr νs₀ₓ (Γ₁ ⇃[ ι₀ ◆ ι₀ ]⇂ᶜ) (Γ₁ ⇃[ ι₀ ]⇂ᶜ) α₁' (α₁ ⇃[ ι₀ ⇃⊔⇂ id ]⇂)
        isAb = record { metasProof = refl-≅ ; ctxProof = lem-2 ; typeProof = functoriality-id-⇃[]⇂ }


        -- | And this together gives us this typing instance.
        𝑇 : CtxTypingInstance Γ (slet te se)
        𝑇 = νs₁ₐ / νs₁ₓ ⊩ Γ₁ , βᵇ₁ , Γ<Γ₀ ⟡ Γ₀<Γ₁ , (slet isAb Γ₁⊢α₁' α₁Γ₁⊢βᵇ₁)


        -- | Now assume we are given another typing instance.
        module _ (𝑆 : CtxTypingInstance Γ (slet te se)) where
          open CtxTypingInstance 𝑆 renaming
            ( metas to νs₃ₐ
            ; typeMetas to νs₃ₓ
            ; ctx to Γ₃
            ; typ to β₃
            ; isInstance to Γ<Γ₃
            ; hasType to Γ₃⊢slettese
            )
          -- (νs₃ₐ / νs₃ₓ ⊩ Γ₃ , β₃ , Γ<Γ₃ , Γ₃⊢slettese)


          -- | We know that since we have a typing instance |Γ₃ ⊢ slet te se : β₃|,
          --   there must be [..].
          invR = inv-slet Γ₃⊢slettese
          νs₂ = invR .fst
          νs₃ₓ₊ = invR .snd .fst
          Γ₂ = invR .snd .snd .fst
          α₂ = invR .snd .snd .snd .fst
          α₃ = invR .snd .snd .snd .snd .fst
          isAb₂ = invR .snd .snd .snd .snd .snd .fst
          Γ₂⊢α₂ = invR .snd .snd .snd .snd .snd .snd .fst
          α₃Γ₃⊢β₃ = invR .snd .snd .snd .snd .snd .snd .snd

          -- slet {μs = νs₂} {κs = νs₃ₓ₊} {Γ = Γ₂} {α = α₂} {α' = α₃}  isAb₂ Γ₂⊢α₂ α₃Γ₃⊢β₃

          σ₂₃₊ : νs₂ ≅ νs₃ₐ ⊔ νs₃ₓ ⊔ νs₃ₓ₊
          σ₂₃₊ = metasProof isAb₂

          あ : ((νs₃ₐ ⊔ νs₃ₓ) ⊔ νs₃ₓ₊) ≅ (νs₃ₐ ⊔ (νs₃ₓ ⊔ νs₃ₓ₊))
          あ = {!!} -- let x = assoc-l-⊔-ℒHMTypes {a = νs₃ₐ} {b = νs₃ₓ} {c = νs₃ₓ₊} in x

          α₃' : ℒHMType ⟨(νs₃ₐ ⊔ (νs₃ₓ ⊔ νs₃ₓ₊))⟩
          α₃' = α₃ ⇃[ ⟨ あ ⟩ ]⇂

          -- | We have this lemma.
          module lem-11 where abstract
            Proof : isTypedℒHM (νs₃ₐ ⊔ (νs₃ₓ ⊔ νs₃ₓ₊) ⊩ (_ , Γ₃ ⇃[ ι₀ ]⇂ᶜ) ⊢ α₃') te
            Proof = Γ₂⊢α₂
                  >> isTypedℒHM (νs₂ ⊩ Q , Γ₂ ⊢ α₂) te <<
                  ⟪ §-isTypedℒHM.prop-2 ⟨ σ₂₃₊ ⟩ ⟫
                  >> isTypedℒHM (_ ⊩ Q , Γ₂ ⇃[ ⟨ σ₂₃₊ ⟩ ]⇂ᶜ ⊢ α₂ ⇃[ ⟨ σ₂₃₊ ⟩ ]⇂) te <<
                  ⟪ transp-isTypedℒHM (trans-Path (ctxProof isAb₂) (functoriality-◆-⇃[]⇂-CtxFor {Γ = Γ₃})) (typeProof isAb₂) ⟫
                  >> isTypedℒHM (_ ⊩ Q , Γ₃ ⇃[ ι₀ ◆ ι₀ ]⇂ᶜ ⊢ α₃) te <<
                  ⟪ §-isTypedℒHM.prop-2 ⟨ あ ⟩ ⟫
                  >> isTypedℒHM (_ ⊩ Q , Γ₃ ⇃[ ι₀ ◆ ι₀ ]⇂ᶜ ⇃[ ⟨ あ ⟩ ]⇂ᶜ ⊢ α₃ ⇃[ ⟨ あ ⟩ ]⇂) te <<
                  ⟪ transp-isTypedℒHM (trans-Path (functoriality-◆-⇃[]⇂-CtxFor {Γ = Γ₃}) (Γ₃ ⇃[≀ {!!} ≀]⇂ᶜ)) refl-≡ ⟫
                  >> isTypedℒHM (_ ⊩ Q , Γ₃ ⇃[ ι₀ ]⇂ᶜ ⊢ α₃') te <<

          -- | And we call this one.
          module Ω₀R where abstract
            Proof : (νs₀ₐ / νs₀ₓ ⊩ Γ₀ , αᵇ₀ , Γ<Γ₀ , Γ₀⊢αᵇ₀) <TI ((νs₃ₐ) / (νs₃ₓ ⊔ νs₃ₓ₊) ⊩ Γ₃ , α₃' , Γ<Γ₃ , lem-11.Proof)
            Proof = Ω₀ ((νs₃ₐ) / (νs₃ₓ ⊔ νs₃ₓ₊) ⊩ Γ₃ , α₃' , Γ<Γ₃ , lem-11.Proof)


          σᵃ₀₃ : νs₀ₐ ⟶ νs₃ₐ
          σᵃ₀₃ = tiSubₐ Ω₀R.Proof

          σˣ₀₃ : νs₀ₓ ⟶ νs₃ₐ ⊔ (νs₃ₓ ⊔ νs₃ₓ₊)
          σˣ₀₃ = tiSubₓ Ω₀R.Proof

          α₀' = αᵇ₀ ⇃[ σᵃ₀₃ ⇃⊔⇂ id ]⇂

          -- ⟨a⟩⁻¹ : (νs₃ₐ ⊔ (νs₃ₓ ⊔ νs₃ₓ₊)) ⟶ (νs₃ₐ ⊔ νs₃ₓ ⊔ νs₃ₓ₊)
          -- ⟨a⟩⁻¹ = {!!}

          -- module lem-14 where abstract
          --   Proof : ⦗ σᵃ₀₃ ◆ ι₀ ◆ ι₀ , σˣ₀₃ ◆ ⟨a⟩⁻¹ ⦘ ≣ ⦗ σᵃ₀₃ ◆ ι₀ , σˣ₀₃ ⦘ ◆ ⟨a⟩⁻¹
          --   Proof = {!!}

          module lem-14 where abstract
            Proof : ⦗ σᵃ₀₃ ◆ ι₀ ◆ ι₀ , σˣ₀₃ ◆ ⟨ あ ⟩⁻¹ ⦘ ≣ ⦗ σᵃ₀₃ ◆ ι₀ , σˣ₀₃ ⦘ ◆ ⟨ あ ⟩⁻¹
            Proof = {!!}

          module lem-15 where abstract
            Proof : α₀' ⇃[ ι₀ ⇃⊔⇂ id ]⇂ ⇃[ ⦗ ι₀ , σˣ₀₃ ◆ ⟨ あ ⟩⁻¹ ⦘ ]⇂ ≡ α₃
            Proof = {!!}

          abstract
            lem-20 : isTypedℒHM ((νs₃ₐ ⊔ νs₃ₓ) ⊩ (νs₀ₓ ∷ Q) , ((α₀' ∷ Γ₃) ⇃[ ι₀ ]⇂ᶜ) ⊢ β₃) se
            lem-20 = α₃Γ₃⊢β₃
                  >> isTypedℒHM ((νs₃ₐ ⊔ νs₃ₓ) ⊩ (νs₃ₓ₊ ∷ Q) , (α₃ ∷ (Γ₃ ⇃[ ι₀ ]⇂ᶜ)) ⊢ β₃) se <<
                  ⟪ transp-isTypedℒHM ((λ i -> lem-15.Proof (~ i) ∷ (Γ₃ ⇃[ ι₀ ]⇂ᶜ))) refl-≡ ⟫
                  >> isTypedℒHM ((νs₃ₐ ⊔ νs₃ₓ) ⊩ (νs₃ₓ₊ ∷ Q) , (α₀' ⇃[ ι₀ ⇃⊔⇂ id ]⇂ ⇃[ ⦗ ι₀ , σˣ₀₃ ◆ ⟨ あ ⟩⁻¹ ⦘ ]⇂ ∷ (Γ₃ ⇃[ ι₀ ]⇂ᶜ)) ⊢ β₃) se <<
                  ⟪ {!!} ⟫
                  >> isTypedℒHM ((νs₃ₐ ⊔ νs₃ₓ) ⊩ (νs₀ₓ ∷ Q) , (α₀' ⇃[ ι₀ ⇃⊔⇂ id ]⇂ ∷ (Γ₃ ⇃[ ι₀ ]⇂ᶜ)) ⊢ β₃) se <<

          α₀Γ₀<α₀'Γ₃ :  α₀Γ₀ <Γ (α₀' ∷ Γ₃)
          α₀Γ₀<α₀'Γ₃ = record { fst = σᵃ₀₃ ; snd = λ i -> α₀' ∷ ctxProofTI Ω₀R.Proof i }


          -- | Then, call this.
          module Ω₁R where abstract
            Proof : (νs₁ₐ / νs₁ₓ ⊩ Δ , βᵇ₁ , α₀Γ₀<Δ , Δ⊢βᵇ₁) <TI (νs₃ₐ / νs₃ₓ ⊩ α₀' ∷ Γ₃ , β₃ , α₀Γ₀<α₀'Γ₃ , lem-20)
            Proof = Ω₁ (νs₃ₐ / νs₃ₓ ⊩ α₀' ∷ Γ₃ , β₃ , α₀Γ₀<α₀'Γ₃ , lem-20)

          σᵃ₁₃ : νs₁ₐ ⟶ νs₃ₐ
          σᵃ₁₃ = tiSubₐ Ω₁R.Proof

          σˣ₁₃ : νs₁ₓ ⟶ (νs₃ₐ ⊔ νs₃ₓ)
          σˣ₁₃ = tiSubₓ Ω₁R.Proof

          lem-30 : βᵇ₁ ⇃[ ⦗ σᵃ₁₃ ◆ ι₀ , σˣ₁₃ ⦘ ]⇂ ≡ β₃
          lem-30 = typProof Ω₁R.Proof

          -- | The final equation chain.
          lem-40 : σᵃᵤ₀ ◆ σᵃ₀₁ ◆ σᵃ₁₃ ∼ fst Γ<Γ₃
          lem-40 = σᵃᵤ₀ ◆ σᵃ₀₁ ◆ σᵃ₁₃   ⟨ assoc-l-◆ ⟩-∼
                   σᵃᵤ₀ ◆ (σᵃ₀₁ ◆ σᵃ₁₃) ⟨ refl {a = σᵃᵤ₀} ◈ subProof Ω₁R.Proof ⟩-∼
                   σᵃᵤ₀ ◆ σᵃ₀₃          ⟨ subProof Ω₀R.Proof ⟩-∼
                   fst Γ<Γ₃             ∎

          -- | All together we see that [..], by taking [....]
          lem-50 : 𝑇 <TI 𝑆
          lem-50 = record { tiSubₐ = σᵃ₁₃ ; tiSubₓ = σˣ₁₃ ; typProof = lem-30 ; subProof = lem-40 }

        Result : InitialCtxTypingInstance Γ (slet te se)
        Result = 𝑇 , lem-50


  -- | With this we are done.

-- //
{-
-}
