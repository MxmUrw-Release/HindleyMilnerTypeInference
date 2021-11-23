
module Verification.Core.Data.Language.HindleyMilner.Variant.Classical.Typed.Typecheck where

open import Verification.Conventions hiding (lookup ; ℕ ; _⊔_)
open import Verification.Core.Set.Setoid.Definition
open import Verification.Core.Set.Discrete
open import Verification.Core.Algebra.Monoid.Definition
open import Verification.Core.Algebra.Monoid.Free
open import Verification.Core.Data.AllOf.Collection.Basics
open import Verification.Core.Data.AllOf.Collection.TermTools
open import Verification.Core.Category.Std.AllOf.Collection.Basics
open import Verification.Core.Category.Std.AllOf.Collection.Limits
open import Verification.Core.Computation.Unification.Definition
open import Verification.Core.Category.Std.AllOf.Collection.Monads
-- open import Verification.Core.Category.Std.Fibration.GrothendieckConstruction.Definition

open import Verification.Core.Theory.Std.Specific.ProductTheory.Module
open import Verification.Core.Theory.Std.Specific.ProductTheory.Instance.hasBoundaries

open import Verification.Core.Data.Language.HindleyMilner.Type.Definition
open import Verification.Core.Data.Language.HindleyMilner.Variant.Classical.Typed.Definition
open import Verification.Core.Data.Language.HindleyMilner.Variant.Classical.Typed.Proofs
open import Verification.Core.Data.Language.HindleyMilner.Variant.Classical.Untyped.Definition
open import Verification.Core.Data.Language.HindleyMilner.Helpers

open import Verification.Core.Category.Std.Limit.Specific.Coequalizer
open import Verification.Core.Set.Decidable

open import Verification.Core.Category.Std.RelativeMonad.KleisliCategory.Definition



record _<Γ_ {k} {Q : ℒHMQuant k} {μs νs} (Γ : ℒHMCtxFor Q μs) (Γ' : ℒHMCtxFor Q νs) : 𝒰₀ where
  field fst : μs ⟶ νs
  field snd : Γ ⇃[ fst ]⇂-CtxFor ≡ Γ'
open _<Γ_ public

record CtxTypingInstance {μs k} {Q : ℒHMQuant k} (Γ : ℒHMCtxFor Q μs) (te : UntypedℒHM k) : 𝒰₀ where
  constructor _⊩_,_,_,_
  field metas : ℒHMTypes
  field ctx : ℒHMCtxFor Q metas
  field typ : ℒHMType (⟨ metas ⟩)
  field isInstance : Γ <Γ ctx
  field hasType : isTypedℒHM (metas ⊩ (Q , ctx) ⊢ typ) te

open CtxTypingInstance public


module _ {μs k} {Q : ℒHMQuant k} {Γ : ℒHMCtxFor Q μs} {te : UntypedℒHM k}  where
  record _<TI_ (𝑇 𝑆 : CtxTypingInstance Γ te) : 𝒰₀ where
    field tiSub : metas 𝑇 ⟶ metas 𝑆
    field typProof : typ 𝑇 ⇃[ tiSub ]⇂ ≡ typ 𝑆
    field subProof : isInstance 𝑇 .fst ◆ tiSub ∼ isInstance 𝑆 .fst

    ctxProofTI : ctx 𝑇 ⇃[ tiSub ]⇂-CtxFor ≡ ctx 𝑆
    ctxProofTI = {!!}

  open _<TI_ public

InitialCtxTypingInstance : ∀{μs k} -> {Q : ℒHMQuant k} -> (Γ : ℒHMCtxFor Q μs) (te : UntypedℒHM k) -> 𝒰₀
InitialCtxTypingInstance Γ te = ∑ λ (𝑇 : CtxTypingInstance Γ te) -> ∀(𝑆 : CtxTypingInstance Γ te) -> 𝑇 <TI 𝑆


γ : ∀{μs k} {Q : ℒHMQuant k} -> (Γ : ℒHMCtxFor Q μs) -> (te : UntypedℒHM k)
  -> (CtxTypingInstance Γ te -> ⊥-𝒰 {ℓ₀})
    +
     (InitialCtxTypingInstance Γ te)
γ {μs} {k} {Q} Γ (var k∍i) = {!!}
{-
  let vα = lookup-DList Q k∍i
      α = lookup-DDList Γ k∍i
      σᵤ₀ : μs ⟶ μs ⊔ vα
      σᵤ₀ = ι₀

      α₀ = α ⇃[ id ⇃⊔⇂ id ]⇂

      Γ₀ = Γ ⇃[ ι₀ ]⇂-CtxFor

      Γ<Γ₀ : Γ <Γ Γ₀
      Γ<Γ₀ = record { fst = σᵤ₀ ; snd = refl-≡ }

  in right (((μs ⊔ vα) ⊩ Γ₀ , α₀ , Γ<Γ₀ , var k∍i refl-≣ id)

           -- now we have to prove that this is the "initial" such typing instance
           , λ {(.(μs₁ ⊔ vα₁) ⊩ Γ₁ , α₁ , Γ<Γ₁ , var {μs = μs₁} {Γ = Γ₁'} _ {vα' = vα₁} refl-≣ ρ) →

               -- given another instance, which has to use `var` to prove the typing

                let σᵤ₁ : μs ⟶ μs₁ ⊔ vα₁
                    σᵤ₁ = Γ<Γ₁ .fst

                    σ₀₁ : μs ⊔ vα ⟶ μs₁ ⊔ vα₁
                    σ₀₁ = ⦗ σᵤ₁ , (ρ ◆ ι₁) ⦘

                    --------------------------------------
                    -- next, we need to show that this
                    -- substitution recreates the given Δ and δ

                    -------------
                    -- i) for σ₀₁
                    -------------

                    lem-10 : σᵤ₀ ◆ σ₀₁ ∼ σᵤ₁
                    lem-10 = reduce-ι₀ {g = ρ ◆ ι₁}

                    -------------
                    -- ii) for α₀
                    -------------

                    lem-11 : α₀ ≡ α
                    lem-11 = α ⇃[ id ⇃⊔⇂ id ]⇂    ⟨ α ⇃[≀ functoriality-id-⊔ ≀]⇂ ⟩-≡
                              α ⇃[ id ]⇂           ⟨ functoriality-id-⇃[]⇂ {τ = α} ⟩-≡
                              α                    ∎-≡

                    lem-12 : α₀ ⇃[ σ₀₁ ]⇂ ≡ lookup-DDList Γ₁ k∍i ⇃[ ⦗ id , ρ ◆ ι₁ ⦘ ]⇂
                    lem-12 = α ⇃[ id ⇃⊔⇂ id ]⇂ ⇃[ σ₀₁ ]⇂     ⟨ cong _⇃[ σ₀₁ ]⇂ lem-11 ⟩-≡
                              lookup-DDList Γ k∍i ⇃[ ⦗ σᵤ₁ , ρ ◆ ι₁ ⦘ ]⇂  ⟨ sym-Path (§-ℒHMCtx.prop-2 {Γ = Γ} k∍i σᵤ₁ (ρ ◆ ι₁)) ⟩-≡
                              lookup-DDList (Γ ⇃[ σᵤ₁ ]⇂-CtxFor) k∍i ⇃[ ⦗ id , ρ ◆ ι₁ ⦘ ]⇂

                              ⟨ (λ i -> lookup-DDList (Γ<Γ₁ .snd i ) k∍i ⇃[ ⦗ id , ρ ◆ ι₁ ⦘ ]⇂) ⟩-≡

                              lookup-DDList Γ₁ k∍i ⇃[ ⦗ id , ρ ◆ ι₁ ⦘ ]⇂                     ∎-≡


                    lem-15 : Γ₁' ⇃[ id ◆ ι₀ ]⇂-CtxFor ≡ Γ₁
                    lem-15 = Γ₁' ⇃[ id ◆ ι₀ ]⇂-CtxFor  ⟨ Γ₁' ⇃[≀ unit-l-◆ ≀]⇂-CtxFor ⟩-≡
                             Γ₁' ⇃[ ι₀ ]⇂-CtxFor       ∎-≡

                    lem-16 : α₁ ≡ lookup-DDList Γ₁ k∍i ⇃[ ⦗ id , ρ ◆ ι₁ ⦘ ]⇂
                    lem-16 = lookup-DDList Γ₁' k∍i ⇃[ ⦗ id ◆ ι₀ , ρ ◆ ι₁ ⦘ ]⇂   ⟨ sym-Path (§-ℒHMCtx.prop-2 {Γ = Γ₁'} k∍i (id ◆ ι₀) (ρ ◆ ι₁)) ⟩-≡
                              lookup-DDList (Γ₁' ⇃[ id ◆ ι₀ ]⇂-CtxFor) k∍i ⇃[ ⦗ id , ρ ◆ ι₁ ⦘ ]⇂

                              ⟨ (λ i -> lookup-DDList (lem-15 i) k∍i ⇃[ ⦗ id , ρ ◆ ι₁ ⦘ ]⇂) ⟩-≡

                              lookup-DDList (Γ₁) k∍i ⇃[ ⦗ id , ρ ◆ ι₁ ⦘ ]⇂                       ∎-≡

                    lem-20 : α₀ ⇃[ σ₀₁ ]⇂ ≡ α₁
                    lem-20 = trans-Path lem-12 (sym-Path lem-16)

                in record { tiSub = σ₀₁ ; typProof = lem-20 ; subProof = lem-10 }

               })
-}
γ Γ (slet te se) with γ Γ te
... | (left _) = {!!}
... | (right ((νs₀ ⊩ Γ₀ , τ₀ , Γ₀<Γ , Γ₀⊢τ₀), Ξ)) = {!!}
{-
  let νs₀' , Γ₀' , τ₀' , isAb = abstr-Ctx Γ₀⊢τ₀

      ϕ = metasProof isAb

      κs = τ₀' .fst

      -- add the type τ₀' to the context
      -- and typecheck se
      x = γ (τ₀' ∷ Γ₀') se

  in case x of
        {!!}

        -- if we get a good result
        λ {(μs ⊩ (τ₁ ∷ Γ₁) , β , Γ₁<τ₀Γ , Γ₁⊢τ₁) →

          let σ = fst Γ₁<τ₀Γ

              Γ₀v = Γ₀ ⇃[ ⟨ ϕ ⟩⁻¹ ◆ (σ ⇃⊔⇂ id) ]⇂-Ctx
              τ₀v = τ₀ ⇃[ ⟨ ϕ ⟩⁻¹ ◆ (σ ⇃⊔⇂ id) ]⇂

              tepv : isTypedℒHM ((μs ⊔ ι κs) ⊩ Γ₀v ⊢ τ₀v) te
              tepv = §-isTypedℒHM.prop-2 _ Γ₀⊢τ₀

              abPv : isAbstr (ι (τ₁ .fst)) Γ₀v Γ₁ τ₀v (τ₁ .snd)
              abPv =
                let
                    lem-1 : μs ⊔ ι (τ₁ .fst) ≅ (μs ⊔ ι κs)
                    lem-1 = {!!} -- but we know that actually ι (τ₁.fst) ≡ ι κs
                                 -- since they both come from the quantified part of the context
                in record { metasProof = lem-1 ; ctxProof = {!!} ; typeProof = {!!} }

          in right (μs ⊩ Γ₁ , β , {!!} , slet abPv tepv Γ₁⊢τ₁)
        }
-}
-- the case of an application
-- typecheck the first term with the given context
γ {μs = νs} Γ (app te se) = {!!}
{-
with γ Γ te
... | (left _) = {!!}
... | (right ((νs₀ ⊩ Γ₀ , α₀ , Γ<Γ₀ , Γ₀⊢α₀), Ω₀)) with γ Γ₀ se
... | (left _) = {!!}
... | (right ((νs₁ ⊩ Γ₁ , β₁ , Γ₀<Γ₁ , Γ₁⊢β₁), Ω₁)) = resn
  where

    σᵤ₀ : _ ⟶ νs₀
    σᵤ₀ = fst Γ<Γ₀

    -- lift the τ0 typing to Γ₁
    σ₀₁ : νs₀ ⟶ νs₁
    σ₀₁ = fst Γ₀<Γ₁

    -- we lift α₀ to the metas νs₁
    -- τ₀'
    α₁ : ℒHMType _
    α₁ = α₀ ⇃[ σ₀₁ ]⇂

    -- we need a new type variable for the return
    -- type of the application, so we move to νs₂
    νs₂ = (νs₁) ⊔ st
    σ₁₂ : νs₁ ⟶ νs₂
    σ₁₂ = ι₀

    -- τ₀''
    α₂ : ℒHMType ⟨ νs₂ ⟩
    α₂ = α₁ ⇃[ σ₁₂ ]⇂

    β₂ : ℒHMType ⟨ νs₂ ⟩
    β₂ = β₁ ⇃[ σ₁₂ ]⇂

    -- Γ₁'
    Γ₂ = Γ₁ ⇃[ σ₁₂ ]⇂-Ctx

    -- we call the new type γ
    γ₂ : ℒHMType ⟨ νs₂ ⟩
    γ₂ = var (right-∍ incl)

    -- the types which we unify are:
    u : ℒHMType ⟨ νs₂ ⟩
    u = α₂

    v : ℒHMType ⟨ νs₂ ⟩
    v = β₂ ⇒ γ₂

    res = unify-ℒHMTypes (asArr u) (asArr v)

    resn = case res of
           {!!}
           λ x →
             let νs₃ = ⟨ x ⟩
                 σ₂₃ : νs₂ ⟶ νs₃
                 σ₂₃ = π₌

                 β₃ = β₂ ⇃[ σ₂₃ ]⇂
                 Γ₃ = Γ₂ ⇃[ σ₂₃ ]⇂-Ctx

                 -- thus the full substitution we need is the following
                 σᵤ₃ = σᵤ₀ ◆ σ₀₁ ◆ σ₁₂ ◆ σ₂₃

                 Γ<Γ₃ : Γ <Γ Γ₃
                 Γ<Γ₃ = record { fst = σᵤ₃ ; snd = {!!} }

{-
                 -- move the typing of se to Γ₂ = Γ₁[ ι₀ ◆ σ ]
                 sp : isTypedℒHM (νs₂ ⊩ (Γ₁ ⇃[ ι₀ ]⇂-Ctx) ⊢ (τ₁ ⇃[ ι₀ ]⇂)) se
                 sp = §-isTypedℒHM.prop-2 ι₀ Γ₁⊢τ₁

                 sp' : isTypedℒHM (⟨ x ⟩ ⊩ (Γ₁ ⇃[ ι₀ ]⇂-Ctx ⇃[ σ ]⇂-Ctx) ⊢ (τ₁ ⇃[ ι₀ ]⇂ ⇃[ σ ]⇂)) se
                 sp' = §-isTypedℒHM.prop-2 σ sp

                 -- move the typing of te to Γ₂ = Γ₀[ σᵤ₀ ◆ ι₀ ◆ σ ]
                 tp : isTypedℒHM (νs₁ ⊩ Γ₁ ⊢ (τ₀ ⇃[ σᵤ₀ ]⇂)) te
                 tp = {!!}

                 tp' : isTypedℒHM (νs₂ ⊩ (Γ₁ ⇃[ ι₀ ]⇂-Ctx) ⊢ (τ₀ ⇃[ σᵤ₀ ]⇂ ⇃[ ι₀ ]⇂)) te
                 tp' = §-isTypedℒHM.prop-2 ι₀ tp

                 tp'' : isTypedℒHM (⟨ x ⟩ ⊩ (Γ₁ ⇃[ ι₀ ]⇂-Ctx ⇃[ σ ]⇂-Ctx) ⊢ (τ₀ ⇃[ σᵤ₀ ]⇂ ⇃[ ι₀ ]⇂ ⇃[ σ ]⇂)) te
                 tp'' = §-isTypedℒHM.prop-2 σ tp'

                 tp''' : isTypedℒHM (⟨ x ⟩ ⊩ (Γ₁ ⇃[ ι₀ ]⇂-Ctx ⇃[ σ ]⇂-Ctx) ⊢ (τ₁ ⇃[ ι₀ ]⇂ ⇃[ σ ]⇂ ⇒ β ⇃[ σ ]⇂)) te
                 tp''' = {!!}
-}

             in right ((νs₃ ⊩ Γ₃ , β₃ , Γ<Γ₃ , {!!} ), -- app tp''' sp'),
                      λ {(νs₄ ⊩ Ξ , ξ , Γ<Ξ , app {α = ξ₄} {β = ζ₄} Ξ⊢ξ⇒ζ Ξ⊢ξ) ->
                        let σᵤ₄ : νs ⟶ νs₄
                            σᵤ₄ = fst Γ<Ξ

                            ΩR₀ = Ω₀ (νs₄ ⊩ Ξ , (ξ₄ ⇒ ζ₄) , Γ<Ξ , Ξ⊢ξ⇒ζ)

                            σ₀₄ : νs₀ ⟶ νs₄
                            σ₀₄ = tiSub ΩR₀

                            Γ₀<Ξ : Γ₀ <Γ Ξ
                            Γ₀<Ξ = record { fst = σ₀₄ ; snd = ctxProof ΩR₀ }

                            ΩR₁ = Ω₁ (νs₄ ⊩ Ξ , ξ₄ , Γ₀<Ξ , Ξ⊢ξ)

                            σ₁₄ : νs₁ ⟶ νs₄
                            σ₁₄ = tiSub ΩR₁

                            -- we can build a substitution from νs₂ by mapping γ to ζ₄
                            σ₂₄ : νs₂ ⟶ νs₄
                            σ₂₄ = ⦗ σ₁₄ , ⧜subst (incl ζ₄) ⦘

                            -- we know that under this substitution,
                            -- u = α₂ and v = β₂ ⇒ γ₂ become both ξ⇒ζ
                            lem-1 : u ⇃[ σ₂₄ ]⇂ ≡ ξ₄ ⇒ ζ₄
                            lem-1 = α₁ ⇃[ ι₀ ]⇂ ⇃[ σ₂₄ ]⇂       ⟨ {!!} ⟩-≡
                                     α₁ ⇃[ ι₀ ◆ ⦗ σ₁₄ , _ ⦘ ]⇂   ⟨ {!!} ⟩-≡
                                     α₁ ⇃[ σ₁₄ ]⇂                ⟨ {!!} ⟩-≡
                                     α₀ ⇃[ σ₀₁ ]⇂ ⇃[ σ₁₄ ]⇂      ⟨ {!!} ⟩-≡
                                     α₀ ⇃[ σ₀₁ ◆ σ₁₄ ]⇂          ⟨ {!!} ⟩-≡
                                     α₀ ⇃[ σ₀₄ ]⇂                ⟨ typProof ΩR₀ ⟩-≡
                                     ξ₄ ⇒ ζ₄                    ∎-≡

                            -- ... thus we can use the universal property
                            -- to get νs₃ ⟶ νs₄
                            σ₃₄ : νs₃ ⟶ νs₄
                            σ₃₄ = {!!}

                            -- and we know that
                            lem-20 : σᵤ₃ ◆ σ₃₄ ∼ σᵤ₄
                            lem-20 = {!!}

                        in record { tiSub = σ₃₄ ; typProof = {!!} ; ctxProof = {!!} ; subProof = lem-20 }
                -}

{-
                      let ΩR₀ = Ω₀ (ζs ⊩ Ξ , (ξ₀ ⇒ ξ₁) , Γ?<Ξ , Ξ⊢ξ₀⇒ξ₁)

                          σᵤ₀ = tiSub ΩR₀

                          Γ₀<Ξ : Γ₀ <Γ Ξ
                          Γ₀<Ξ = record { fst = σᵤ₀ ; snd = ctxProof ΩR₀ }

                          ΩR₁ = Ω₁ (ζs ⊩ Ξ , ξ₀ , Γ₀<Ξ , Ξ⊢ξ₀)

                          σ₀₁ = tiSub ΩR₁

                          aa = τ₀'' ⇃[ σᵤ₀ ]⇂


                      in record { tiSub = {!!} ; typProof = {!!} ; ctxProof = {!!} }

                      })

-}
-- the case of a lambda
γ {μs} {k} {Q = Q} Γ (lam te) = resn
  where
    -- create a new metavariable
    μs₀ = μs ⊔ st

    αᵘ : ℒHMType ⟨ st ⟩
    αᵘ = var incl

    α₀ : ℒHMType ⟨ μs₀ ⊔ ⊥ ⟩
    α₀ = αᵘ ⇃[ ι₁ ◆ ι₀ ]⇂

    -- create the context which contains this new variable
    Γ₀ : ℒHMCtxFor Q μs₀
    Γ₀ = Γ ⇃[ ι₀ ]⇂-CtxFor

    σ₀ : μs ⟶ μs ⊔ st
    σ₀ = ι₀

    -- call typechecking recursively on `te`
    res = γ (α₀ ∷ Γ₀) te

    -- computing the initial typing instance
    -- assuming we have one for te
    success : InitialCtxTypingInstance (α₀ ∷ Γ₀) te -> InitialCtxTypingInstance Γ (lam te)
    success ((μs₁ ⊩ (α₁ ∷ Γ₁) , β₁ , α₀Γ₀<α₁Γ₁ , hastype) , Ω) = 𝑇 , isInitial:𝑇
      where
        σ₀₁ : μs₀ ⟶ μs₁
        σ₀₁ = α₀Γ₀<α₁Γ₁ .fst

        σᵤ₁ : μs ⟶ μs₁
        σᵤ₁ = σ₀ ◆ σ₀₁

        lem-1 : Γ ⇃[ σᵤ₁ ]⇂-CtxFor ≡ Γ₁
        lem-1 = Γ ⇃[ σᵤ₁ ]⇂-CtxFor                  ⟨ sym-Path (functoriality-◆-⇃[]⇂-CtxFor {Γ = Γ} {f = σ₀} {σ₀₁}) ⟩-≡
                Γ ⇃[ σ₀ ]⇂-CtxFor ⇃[ σ₀₁ ]⇂-CtxFor  ⟨ (λ i -> split-DDList (α₀Γ₀<α₁Γ₁ .snd i) .snd ) ⟩-≡
                Γ₁                                  ∎-≡

        Γ<Γ₁ : Γ <Γ Γ₁
        Γ<Γ₁ = record { fst = σᵤ₁ ; snd = lem-1 }

        𝑇 : CtxTypingInstance Γ (lam te)
        𝑇 = (μs₁ ⊩ Γ₁ , _ , Γ<Γ₁ , lam hastype)

        isInitial:𝑇 : (𝑆 : CtxTypingInstance Γ (lam te)) -> 𝑇 <TI 𝑆
        isInitial:𝑇 (μs₂ ⊩ Γ₂ , .(_ ⇒ _) , Γ<Γ₂ , lam {α = α₂} {β = β₂} Γ₂α₂⊢β₂) =
          record { tiSub = σ₁₂ ; typProof = lem-30 ; subProof = lem-40 }

          where
            σᵤ₂ : μs ⟶ μs₂
            σᵤ₂ = Γ<Γ₂ .fst

            σₜ₂ : st ⟶ μs₂
            σₜ₂ = ⧜subst (incl α₂) ◆ ⦗ id , elim-⊥ ⦘

            -- μs ⊔ st = μs₀
            σ₀₂ : (μs ⊔ st) ⟶ μs₂
            σ₀₂ = ⦗ σᵤ₂ , σₜ₂ ⦘

            lem-5 : Γ₀ ⇃[ σ₀₂ ]⇂-CtxFor ≡ Γ₂
            lem-5 = Γ ⇃[ ι₀ ]⇂-CtxFor ⇃[ σ₀₂ ]⇂-CtxFor  ⟨ §-HM-Proofs.prop-2 σᵤ₂ σₜ₂ Γ ⟩-≡
                    Γ ⇃[ σᵤ₂ ]⇂-CtxFor                  ⟨ Γ<Γ₂ .snd ⟩-≡
                    Γ₂                                  ∎-≡

            lem-10 : (α₀ ∷ Γ₀) ⇃[ σ₀₂ ]⇂-CtxFor ≡ (α₂ ∷ Γ₂)
            lem-10 = λ i → §-HM-Proofs.prop-1 α₂ σ₀₂ i ∷ lem-5 i

            α₀Γ₀<α₂Γ₂ : (α₀ ∷ Γ₀) <Γ (α₂ ∷ Γ₂)
            α₀Γ₀<α₂Γ₂ = record { fst = σ₀₂ ; snd = lem-10 }

            ΩR = Ω (μs₂ ⊩ (α₂ ∷ Γ₂) , β₂ , α₀Γ₀<α₂Γ₂ , Γ₂α₂⊢β₂)

            σ₁₂ : μs₁ ⟶ μs₂
            σ₁₂ = tiSub ΩR

            lem-21 : (α₁ ∷ Γ₁) ⇃[ σ₁₂ ]⇂-CtxFor ≡ α₂ ∷ Γ₂
            lem-21 = ctxProofTI ΩR

            lem-24 : α₁ ⇃[ σ₁₂ ⇃⊔⇂ id ]⇂ ≡ α₂
            lem-24 = λ i → split-DDList (lem-21 i) .fst

            lem-25 : α₁ ⇃[ σ₁₂ ⇃⊔⇂ id ]⇂ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂ ≡ α₂ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂
            lem-25 = cong _⇃[ ⦗ id , elim-⊥ ⦘ ]⇂ lem-24

            lem-26 : α₁ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂ ⇃[ σ₁₂ ]⇂ ≡ α₂ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂
            lem-26 = α₁ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂ ⇃[ σ₁₂ ]⇂          ⟨ functoriality-◆-⇃[]⇂ {τ = α₁} {f = ⦗ id , elim-⊥ ⦘} {g = σ₁₂} ⟩-≡
                    α₁ ⇃[ ⦗ id , elim-⊥ ⦘ ◆ σ₁₂ ]⇂              ⟨ α₁ ⇃[≀ §-HM-Helpers.prop-1 {f = σ₁₂} ≀]⇂ ⟩-≡
                    α₁ ⇃[ (σ₁₂ ⇃⊔⇂ id) ◆ ⦗ id , elim-⊥ ⦘ ]⇂     ⟨ sym-Path (functoriality-◆-⇃[]⇂ {τ = α₁} {f = σ₁₂ ⇃⊔⇂ id} {g = ⦗ id , elim-⊥ ⦘}) ⟩-≡
                    α₁ ⇃[ (σ₁₂ ⇃⊔⇂ id) ]⇂ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂ ⟨ lem-25 ⟩-≡
                    α₂ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂                 ∎-≡

            lem-29 : β₁ ⇃[ σ₁₂ ]⇂ ≡ β₂
            lem-29 = typProof ΩR

            lem-30 : (α₁ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂ ⇒ β₁) ⇃[ σ₁₂ ]⇂ ≡ (α₂ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂ ⇒ β₂)
            lem-30 = λ i → lem-26 i ⇒ lem-29 i

            lem-40 : σᵤ₁ ◆ σ₁₂ ∼ σᵤ₂
            lem-40 = (σ₀ ◆ σ₀₁) ◆ σ₁₂   ⟨ assoc-l-◆ {f = σ₀} {σ₀₁} {σ₁₂} ⟩-∼
                     σ₀ ◆ (σ₀₁ ◆ σ₁₂)   ⟨ refl {x = σ₀} ◈ subProof ΩR ⟩-∼
                     σ₀ ◆ σ₀₂           ⟨ reduce-ι₀ {g = σₜ₂} ⟩-∼
                     σᵤ₂                ∎


    -------------------------------------------------
    -- putting it together

    -- distinguish between failure and not
    resn = case res of
      -- if there was a failure,
      -- we also have to fail
      (λ ¬typing → left
         -- assume we have a typing for lambda
         -- this means that we also have a typing for te
         -- which we know is impossible
         λ {(νs ⊩ Δ , τ , Γ₀<Δ , hastyp)
                → let νs' , Δ' , τ' , hastyp' = §-isTypedℒHM.prop-1 te hastyp
                  in {!!} -- ¬typing (νs' ⊩ Δ' , τ' , {!!} , hastyp')
                  })
      (right ∘ success)



{-
      -- if there was no failure, we can use this result
      λ {
        -- we know that `α` has no quantification
          ((μs₁ ⊩ (α₁ ∷ Γ₁) , β₁ , α₀Γ₀<α₁Γ₁ , hastype) , Ω) →
          let σ₀₁ : μs₀ ⟶ μs₁
              σ₀₁ = α₀Γ₀<α₁Γ₁ .fst

              σᵤ₁ : μs ⟶ μs₁
              σᵤ₁ = σ₀ ◆ σ₀₁

              lem-1 : Γ ⇃[ σᵤ₁ ]⇂-CtxFor ≡ Γ₁
              lem-1 = Γ ⇃[ σᵤ₁ ]⇂-CtxFor                  ⟨ sym-Path (functoriality-◆-⇃[]⇂-CtxFor {Γ = Γ} {f = σ₀} {σ₀₁}) ⟩-≡
                      Γ ⇃[ σ₀ ]⇂-CtxFor ⇃[ σ₀₁ ]⇂-CtxFor  ⟨ (λ i -> split-DDList (α₀Γ₀<α₁Γ₁ .snd i) .snd ) ⟩-≡
                      Γ₁                                  ∎-≡

              Γ<Γ₁ : Γ <Γ Γ₁
              Γ<Γ₁ = record { fst = σᵤ₁ ; snd = lem-1 }

          in right ((μs₁ ⊩ Γ₁ , _ , Γ<Γ₁ , lam hastype),

                -- here we have to show that we are the best typing instance
                λ {(μs₂ ⊩ Γ₂ , .(_ ⇒ _) , Γ<Γ₂ , lam {α = α₂} {β = β₂} Γ₂α₂⊢β₂) →
                  let σᵤ₂ : μs ⟶ μs₂
                      σᵤ₂ = Γ<Γ₂ .fst

                      -- μs ⊔ st = μs₀
                      σ₀₂ : (μs ⊔ st) ⟶ μs₂
                      σ₀₂ = ⦗ σᵤ₂ , ⧜subst (incl α₂) ◆ ⦗ id , elim-⊥ ⦘ ⦘

                      lem-5 : Γ₀ ⇃[ σ₀₂ ]⇂-CtxFor ≡ Γ₂
                      lem-5 = Γ ⇃[ ι₀ ]⇂-CtxFor ⇃[ σ₀₂ ]⇂-CtxFor  ⟨ §-HM-Proofs.prop-2 σᵤ₂ (⧜subst (incl α₂) ◆ ⦗ id , elim-⊥ ⦘) Γ ⟩-≡
                              Γ ⇃[ σᵤ₂ ]⇂-CtxFor                  ⟨ Γ<Γ₂ .snd ⟩-≡
                              Γ₂                                  ∎-≡

                      lem-10 : (α₀ ∷ Γ₀) ⇃[ σ₀₂ ]⇂-CtxFor ≡ (α₂ ∷ Γ₂)
                      lem-10 = λ i → §-HM-Proofs.prop-1 α₂ σ₀₂ i ∷ lem-5 i

                      α₀Γ₀<α₂Γ₂ : (α₀ ∷ Γ₀) <Γ (α₂ ∷ Γ₂)
                      α₀Γ₀<α₂Γ₂ = record { fst = σ₀₂ ; snd = lem-10 }

                      ΩR = Ω (μs₂ ⊩ (α₂ ∷ Γ₂) , β₂ , α₀Γ₀<α₂Γ₂ , Γ₂α₂⊢β₂)

                  -- let ΩR = Ω (μs₂ ⊩ (α₂ ∷ Γ₂) , β₂ , {!!} , Γ₂α₂⊢β₂)

                      σ₁₂ : μs₁ ⟶ μs₂
                      σ₁₂ = tiSub ΩR

                      lem-21 : (α₁ ∷ Γ₁) ⇃[ σ₁₂ ]⇂-CtxFor ≡ α₂ ∷ Γ₂
                      lem-21 = ctxProofTI ΩR

                      lem-24 : α₁ ⇃[ σ₁₂ ⇃⊔⇂ id ]⇂ ≡ α₂
                      lem-24 = λ i → split-DDList (lem-21 i) .fst

                      lem-25 : α₁ ⇃[ σ₁₂ ⇃⊔⇂ id ]⇂ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂ ≡ α₂ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂
                      lem-25 = cong _⇃[ ⦗ id , elim-⊥ ⦘ ]⇂ lem-24

                      lem-26 : α₁ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂ ⇃[ σ₁₂ ]⇂ ≡ α₂ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂
                      lem-26 = α₁ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂ ⇃[ σ₁₂ ]⇂          ⟨ functoriality-◆-⇃[]⇂ {τ = α₁} {f = ⦗ id , elim-⊥ ⦘} {g = σ₁₂} ⟩-≡
                              α₁ ⇃[ ⦗ id , elim-⊥ ⦘ ◆ σ₁₂ ]⇂              ⟨ α₁ ⇃[≀ §-HM-Helpers.prop-1 {f = σ₁₂} ≀]⇂ ⟩-≡
                              α₁ ⇃[ (σ₁₂ ⇃⊔⇂ id) ◆ ⦗ id , elim-⊥ ⦘ ]⇂     ⟨ sym-Path (functoriality-◆-⇃[]⇂ {τ = α₁} {f = σ₁₂ ⇃⊔⇂ id} {g = ⦗ id , elim-⊥ ⦘}) ⟩-≡
                              α₁ ⇃[ (σ₁₂ ⇃⊔⇂ id) ]⇂ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂ ⟨ lem-25 ⟩-≡
                              α₂ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂                 ∎-≡

                      lem-29 : β₁ ⇃[ σ₁₂ ]⇂ ≡ β₂
                      lem-29 = typProof ΩR

                      lem-30 : (α₁ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂ ⇒ β₁) ⇃[ σ₁₂ ]⇂ ≡ (α₂ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂ ⇒ β₂)
                      lem-30 = λ i → lem-26 i ⇒ lem-29 i

                      lem-40 : σᵤ₁ ◆ σ₁₂ ∼ σᵤ₂
                      lem-40 = ?

                  in record { tiSub = σ₁₂ ; typProof = lem-30 ; subProof = lem-40 }

                  })

        }
-}





