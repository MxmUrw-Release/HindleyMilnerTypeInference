
module Verification.Core.Data.Language.HindleyMilner.Variant.Classical.Typed.Definition where

open import Verification.Conventions hiding (lookup ; ℕ ; _⊔_)
open import Verification.Core.Set.Discrete
open import Verification.Core.Algebra.Monoid.Definition
open import Verification.Core.Algebra.Monoid.Free
open import Verification.Core.Data.AllOf.Collection.Basics
open import Verification.Core.Data.AllOf.Collection.TermTools
open import Verification.Core.Category.Std.AllOf.Collection.Basics
open import Verification.Core.Category.Std.AllOf.Collection.Limits

open import Verification.Core.Theory.Std.Specific.ProductTheory.Module
open import Verification.Core.Theory.Std.Specific.ProductTheory.Instance.hasBoundaries

open import Verification.Core.Data.Language.HindleyMilner.Type.Definition
open import Verification.Core.Data.Language.HindleyMilner.Variant.Classical.Untyped.Definition

-----------------------------------------
-- 人Vecᵖ

{-

record 人Vecᵖ (A : 𝒰 𝑖) (n : 人ℕ) : 𝒰 𝑖 where
  constructor vecᵖ
  field ⟨_⟩ : 人List A
  field hasSize : map-Free-𝐌𝐨𝐧 (const tt) ⟨_⟩ ≡ n

open 人Vecᵖ public

get-人Vecᵖ : ∀{i} -> ∀{A : 𝒰 𝑖} {n : 人ℕ} -> (xs : 人Vecᵖ A n) -> (n ∍ i) -> A
get-人Vecᵖ = {!!}

get-∍-人Vecᵖ : ∀{i} -> ∀{A : 𝒰 𝑖} {n : 人ℕ} -> (xs : 人Vecᵖ A n) -> (p : n ∍ i) -> ⟨ xs ⟩ ∍ get-人Vecᵖ xs p
get-∍-人Vecᵖ = {!!}

-}

module _ {A : 𝒰 𝑖} {F : A -> 𝒰 𝑗} where
  size-D人List : ∀{m} -> D人List F m -> 人List A
  size-D人List {m} _ = m

module _ {A : 𝒰 𝑖} {F : A -> 𝒰 𝑗} where
  size-DList : ∀{m} -> DList F m -> List A
  size-DList {m} _ = m

module _ {A : 𝒰 𝑖} {B : A -> 𝒰 𝑗} where
  lookup-DList : ∀{as : List A} -> (xs : DList B as) -> ∀{a} -> (as ∍♮ a) -> B a
  lookup-DList = {!!}



-- module _ {A : 𝒰 𝑖} where
--   data _∍♮D_ : ∀{as : ♮ℕ} -> (xs : ConstDList A as) -> (a : A) -> 𝒰 𝑖 where

    -- incl : ∀{a bs} -> (a ∷ bs) ∍♮ a
    -- skip : ∀{a b bs} -> bs ∍♮ a ->  (b ∷ bs) ∍♮ a


record ℒHMJudgementᵈ : 𝒰₀ where
  constructor _⊩_⊢_
  field metavars : ℒHMTypes
  field {contextsize} : ♮ℕ
  field context : DList (const (ℒHMPolyType metavars)) contextsize
  -- ℒHMCtx' metavars
  field type : ℒHMType ⟨ metavars ⟩

open ℒHMJudgementᵈ public

macro ℒHMJudgement = #structureOn ℒHMJudgementᵈ

-- instance
--   isCategory:ℒHMJudgement : isCategory {ℓ₀ , ℓ₀} ℒHMJudgement
--   isCategory:ℒHMJudgement = {!!}

sᵘ : ℒHMJudgement -> ♮ℕ
sᵘ (_ ⊩ Γ ⊢ τ) = size-DList Γ

macro s = #structureOn sᵘ

-- ℒHMJudgementCategory : 𝐂𝐚𝐭₀
-- ℒHMJudgementCategory = ℒHMJudgement

pattern _∷'_ x xs = _∷_ {a = tt} x xs
infix 30 ∀[]_
pattern ∀[]_ xs = ∀[ incl [] ] xs

record isAbstr {k} (κs : ℒHMTypes) {μs₀ μs₁} (Γ₀ : ℒHMCtx' k μs₀) (Γ₁ : ℒHMCtx' k μs₁)
               (τ₀ : ℒHMType ⟨ μs₀ ⟩) (τ₁ : ℒHMType ⟨ μs₁ ⊔ κs ⟩) : 𝒰₀ where
  field metasProof : (μs₁ ⊔ κs) ≅ μs₀
  field ctxProof : Γ₁ ⇃[ ι₀ ◆ ⟨ metasProof ⟩ ]⇂-Ctx ≡ Γ₀
  field typeProof : τ₁ ⇃[ ⟨ metasProof ⟩ ]⇂ ≡ τ₀

open isAbstr public


  -- incl : ∀{k n} -> ∀{τ : ℒHMPolyType (n ⊔ m)} -> ∀{Γ : ℒHMCtx' n k}
  --        -> isAbstr m (mapOf ℒHMCtx' ι₀ μs ⊩ Γ ⊢ τ) (μs ⊩ Γ ⊢ abstr τ)

record Abstraction (𝐽 : ℒHMJudgement) : 𝒰₀ where
  field baseMetas : ℒHMTypes
  field extraMetas : ℒHMTypes
  field metasProof : (baseMetas ⊔ extraMetas) ≅ metavars 𝐽
  field baseCtx : ℒHMCtx' _ baseMetas
  field baseCtxProof : baseCtx ⇃[ ι₀ ◆ ⟨ metasProof ⟩ ]⇂-Ctx ≡ context 𝐽
  field baseType : ℒHMType ⟨ baseMetas ⊔ extraMetas ⟩
  field baseTypeProof : baseType ⇃[ ⟨ metasProof ⟩ ]⇂ ≡ type 𝐽

open Abstraction public


data isTypedℒHMᵈ : (Γ : ℒHMJudgement) -> (te : UntypedℒHM (s Γ)) -> 𝒰₀ where
  var  : ∀{μs k i} -> {Γ : ℒHMCtx' k μs} -> ∀{vα vα' α}
         -> (k∍i : k ∍♮ i)
         -> lookup-DList Γ k∍i ≣ (∀[ vα ] α)
         -> (σ : ι vα ⟶ vα')
         -> isTypedℒHMᵈ ((μs ⊔ vα') ⊩ Γ ⇃[ ι₀ ]⇂-Ctx ⊢ α ⇃[ id ⇃⊔⇂ σ ]⇂) (var k∍i)


{-
  gen : ∀{k μs te} {Γ₀ Γ₁ : ℒHMCtx' k μs} {τ₀ τ₁ : ℒHMType ⟨ μs ⟩}
        -> isAbstr μs (μs ⊩ Γ₀ ⊢ τ₀) (μs ⊩ Γ₁ ⊢ τ₁)
        -> isTypedℒHMᵈ (μs ⊩ Γ₀ ⊢ τ₀) te
        -> isTypedℒHMᵈ (μs ⊩ Γ₁ ⊢ τ₁) te
-}

  app : ∀{μs k te₀ te₁} {Γ : ℒHMCtx' k μs} {α β : ℒHMType ⟨ μs ⟩}
        -> isTypedℒHMᵈ (μs ⊩ Γ ⊢ (α ⇒ β)) te₀
        -> isTypedℒHMᵈ (μs ⊩ Γ ⊢ α) te₁
        -> isTypedℒHMᵈ (μs ⊩ Γ ⊢ β) (app te₀ te₁)

  lam : ∀{μs k te} {Γ : ℒHMCtx' k μs}
         {α : ℒHMType ⟨ μs ⟩}
         {β : ℒHMType ⟨ μs ⟩}
         -> isTypedℒHMᵈ (μs ⊩ ((∀[] (α ⇃[ ι₀ ]⇂)) ∷' Γ) ⊢ β) te
         -> isTypedℒHMᵈ (μs ⊩ Γ ⊢ α ⇒ β) (lam te)

  slet : ∀{μs κs νs k te₀ te₁} {Γ : ℒHMCtx' k μs} {Γ' : ℒHMCtx' k νs}
        -> {α : ℒHMType ⟨ μs ⟩}
        -> {α' : ℒHMType ⟨ νs ⊔ ι κs ⟩}
        -> {β : ℒHMType ⟨ νs ⟩}
        -> isAbstr (ι κs) Γ Γ' α α'
        -> isTypedℒHMᵈ (μs ⊩ Γ ⊢ α) te₀
        -> isTypedℒHMᵈ (νs ⊩ (∀[ κs ] α' ∷ Γ') ⊢ β) te₁
        -> isTypedℒHMᵈ (νs ⊩ Γ' ⊢ β) (slet te₀ te₁)

{-
  -- convert : ∀{m0 m1 k} -> (m0 ⟶ m1) -> {Γ₀ : ℒHMCtx' k m0} -> ∀{τ₀} -> {Γ₁ : ℒHMCtx' k m1} -> ∀{τ₁}
  --           -> isTypedℒHMᵈ (m0 ⊩ Γ₀ ⊢ τ₀)
  --           -> isTypedℒHMᵈ (m1 ⊩ Γ₁ ⊢ τ₁)

  mapmeta : ∀{k μs νs} (ϕ : μs ⟶ νs) -> {Γ₀ : ℒHMCtx' k μs} -> ∀{τ₀}
            -> isTypedℒHMᵈ (μs ⊩ Γ₀ ⊢ τ₀)
            -> isTypedℒHMᵈ (νs ⊩ mapOf (ℒHMCtx' k) ϕ Γ₀ ⊢ mapOf ℒHMPolyType ϕ τ₀)

  instantiate : ∀{μs k} {Γ : ℒHMCtx' k μs} {α β : ℒHMPolyType μs}
         -> (α ⟶ β)
         -> isTypedℒHMᵈ (μs ⊩ Γ ⊢ α)
         -> isTypedℒHMᵈ (μs ⊩ Γ ⊢ β)
-}
-- instance
--   isCategory:TypedℒHM : ∀{X Γ} -> isCategory {ℓ₀ , ℓ₀} (isTypedℒHMᵈ Γ)
--   isCategory:TypedℒHM = {!!}

isTypedℒHM = isTypedℒHMᵈ

module §-isTypedℒHM where
  prop-1 : ∀{μs k} -> {Γ : ℒHMCtx' k μs} {τ : ℒHMType ⟨ μs ⟩}
           -> ∀ te
           -> isTypedℒHM (μs ⊩ Γ ⊢ τ) (lam te)
           -> ∑ λ νs -> ∑ λ (Δ : ℒHMCtx' (tt ∷ k) νs) -> ∑ λ (τ' : ℒHMType ⟨ νs ⟩)
           -> isTypedℒHM (νs ⊩ Δ ⊢ τ') te
  prop-1 te (lam p) = {!!} , ({!!} , ({!!} , p))


  prop-2 : ∀{k μs νs te} {Γ : ℒHMCtx' k μs} {τ : ℒHMType ⟨ μs ⟩}
         -> (σ : μs ⟶ νs)
         -> isTypedℒHM (μs ⊩ Γ ⊢ τ) te
         -> isTypedℒHM (νs ⊩ (Γ ⇃[ σ ]⇂-Ctx) ⊢ (τ ⇃[ σ ]⇂)) te
  prop-2 σ (var x xp ρ) = {!!}
  prop-2 σ (app te se) =
    let te' = prop-2 σ te
        se' = prop-2 σ se
    in app te' se'
  prop-2 σ (lam te) = let res = prop-2 σ te
                      in lam {!!} -- res

  prop-2 σ (slet ab te se) = {!!}

abstr-Ctx : ∀{μs k te} -> {Γ : ℒHMCtx' k μs} -> {τ : ℒHMType ⟨ μs ⟩}
          -> isTypedℒHM (μs ⊩ Γ ⊢ τ) te
          -> ∑ λ νs -> ∑ λ (Γ' : ℒHMCtx' k νs) -> ∑ λ (τ' : ℒHMPolyType νs)
          -> isAbstr _ Γ Γ' τ (snd τ')
            -- -> 
            -- -> isTypedℒHM (νs ⊩ Γ' ⊢ τ') te
abstr-Ctx = {!!}

  -- isTypedℒHM
  -- (νs ⊩ Γ ⇃[ σ ]⇂-Ctx ⊢
  --  ((∀[ fst₁ ]
  --    con ⇒ᵗ
  --    (incl
  --     (α ⇃[
  --      isCategory.id
  --      (Verification.Core.Category.Std.Functor.Faithful.isCategory:byFaithful
  --       Hom-⧜𝐒𝐮𝐛𝐬𝐭' id-⧜𝐒𝐮𝐛𝐬𝐭 _◆-⧜𝐒𝐮𝐛𝐬𝐭_ ι-⧜𝐒𝐮𝐛𝐬𝐭ᵘ map-ι-⧜𝐒𝐮𝐛𝐬𝐭
  --       Verification.Core.Data.Substitution.Variant.Base.Definition.lem-03
  --       Verification.Core.Data.Substitution.Variant.Base.Definition.lem-02)
  --      ⇃⊔⇂
  --      isInitial.elim-⊥
  --      (hasInitial.isInitial:⊥
  --       Verification.Core.Category.Std.Limit.Specific.Coproduct.Reflection.Definition.hasInitial:byFFEso)
  --      ]⇂)
  --     ⋆-⧜ (incl β ⋆-⧜ ◌-⧜)))
  --   ⇃[ σ ]⇂-poly))
  -- (lam te₁)


-- res  : isTypedℒHMᵈ
--        (νs ⊩
--         (∀[]
--          𝕋×.統.reext-Term-𝕋×
--          (λ i x →
--             destruct-D人List
--             (construct-D人List
--              (λ a x₁ →
--                 destruct-D人List
--                 (construct-D人List
--                  (λ i₁ a₁ →
--                     𝕋×.統.reext-Term-𝕋×
--                     (λ i₂ x₂ →
--                        destruct-D人List (construct-D人List (λ i₃ a₂ → var (left-∍ a₂))) i₂
--                        x₂)
--                     i₁ (destruct-D人List ⟨ σ ⟩ i₁ a₁)))
--                 a x₁)
--              ⋆-⧜ ◌-⧜)
--             i x)
--          tyᵗ α)
--         ∷ map-ℒHMCtx' σ Γ
--         ⊢
--         (∀[ fst₁ ]
--          𝕋×.統.reext-Term-𝕋×
--          (λ i x →
--             destruct-D人List
--             (construct-D人List
--              (λ a x₁ →
--                 destruct-D人List
--                 (construct-D人List
--                  (λ i₁ a₁ →
--                     𝕋×.統.reext-Term-𝕋×
--                     (λ i₂ x₂ →
--                        destruct-D人List (construct-D人List (λ i₃ a₂ → var (left-∍ a₂))) i₂
--                        x₂)
--                     i₁ (destruct-D人List ⟨ σ ⟩ i₁ a₁)))
--                 a x₁)
--              ⋆-⧜
--              construct-D人List
--              (λ a x₁ →
--                 destruct-D人List
--                 (construct-D人List
--                  (λ i₁ a₁ →
--                     𝕋×.統.reext-Term-𝕋×
--                     (λ i₂ x₂ →
--                        destruct-D人List (construct-D人List (λ i₃ a₂ → var (right-∍ a₂))) i₂
--                        x₂)
--                     i₁ (destruct-D人List (construct-D人List (λ i₂ x₂ → var x₂)) i₁ a₁)))
--                 a x₁))
--             i x)
--          tyᵗ β))
--        te₁




{-

record ℒHMJudgement : 𝒰₀ where
  constructor _⊢_
  field {metavars} : ℒHMTypes
  field context : ℒHMCtx metavars
  field type : ℒHMPolyType metavars

open ℒHMJudgement public

data isAbstr (m : ℒHMTypes) : (a b : ℒHMJudgement) -> 𝒰₀ where
  incl : ∀{n} -> ∀{τ : ℒHMPolyType (n ⊔ m)} -> ∀{Γ : ℒHMCtx n}
         -> isAbstr m (mapOf ℒHMCtx ι₀ μs ⊩ Γ ⊢ τ) (μs ⊩ Γ ⊢ abstr τ)

data isTypedℒHMᵈ (X : ℒHMJudgement -> 𝒰₀) : (Γ : ℒHMJudgement) -> 𝒰₀ where
  var  : ∀{μs} -> {Γ : ℒHMCtx μs} {α : ℒHMPolyType μs}
         -> Γ ∍ α -> isTypedℒHMᵈ (μs ⊩ Γ ⊢ α)

  hole : ∀{Γ} -> X Γ -> isTypedℒHMᵈ Γ

  gen : ∀{m a b} -> isAbstr m a b -> TypedℒHMᵈ X a -> TypedℒHMᵈ X b

  app : ∀{μs} {Γ : ℒHMCtx μs} {α β : Term₁-𝕋× 𝒹 ⟨ μs ⊔ ⊥ ⟩ tt}
        -> TypedℒHMᵈ X (μs ⊩ Γ ⊢ ∀[ ⊥ ] (α ⇒ β))
        -> TypedℒHMᵈ X (μs ⊩ Γ ⊢ ∀[ ⊥ ] α)
        -> TypedℒHMᵈ X (μs ⊩ Γ ⊢ ∀[ ⊥ ] β)

  lam : ∀{μs} {Γ : ℒHMCtx μs} {α β : Term₁-𝕋× 𝒹 ⟨ μs ⊔ ⊥ ⟩ tt}
        -> TypedℒHMᵈ X ((Γ ⋆ incl (∀[ ⊥ ] α)) ⊢ ∀[ ⊥ ] β)
        -> TypedℒHMᵈ X (μs ⊩ Γ ⊢ ∀[ ⊥ ] α ⇒ β)

  convert : ∀{m0 m1} -> (m0 ⟶ m1) -> {Γ₀ : ℒHMCtx m0} -> ∀{τ₀} -> {Γ₁ : ℒHMCtx m1} -> ∀{τ₁}
            -> TypedℒHMᵈ X (Γ₀ ⊢ τ₀)
            -> TypedℒHMᵈ X (Γ₁ ⊢ τ₁)

  instantiate : ∀{μs} {Γ : ℒHMCtx μs} {α β : ℒHMPolyType μs}
         -> (α ⟶ β)
         -> TypedℒHMᵈ X (μs ⊩ Γ ⊢ α)
         -> TypedℒHMᵈ X (μs ⊩ Γ ⊢ β)

-}

-- isTypedℒHM : 𝐈𝐱 _ (𝐔𝐧𝐢𝐯 ℓ₀) -> 𝐈𝐱 _ (𝐔𝐧𝐢𝐯 ℓ₀)
-- isTypedℒHM A = indexed (TypedℒHMᵈ (ix A))

-- macro TypedℒHM = #structureOn TypedℒHMᵘ



-- module mytest where
--   Γ : ℒHMCtx ⊥
--   Γ = ◌

  -- mytest : TypedℒHMᵈ (const ⊥-𝒰) (μs ⊩ Γ ⊢ ∀[ incl (incl tyᵗ) ] var (right-∍ incl) ⇒ var (right-∍ incl))
  -- mytest = convert id (gen incl (lam (var (right-∍ incl))))


-- TypedℒHMᵘ : 𝐈𝐱 _ (𝐔𝐧𝐢𝐯 ℓ₀) -> 𝐈𝐱 _ (𝐔𝐧𝐢𝐯 ℓ₀)
-- TypedℒHMᵘ A = indexed (TypedℒHMᵈ (ix A))

-- macro TypedℒHM = #structureOn TypedℒHMᵘ


