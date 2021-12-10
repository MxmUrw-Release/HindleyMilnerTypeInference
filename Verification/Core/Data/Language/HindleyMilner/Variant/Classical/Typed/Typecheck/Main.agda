
module Verification.Core.Data.Language.HindleyMilner.Variant.Classical.Typed.Typecheck.Main where

open import Verification.Conventions hiding (ℕ ; _⊔_)
open import Verification.Core.Set.Setoid.Definition
open import Verification.Core.Set.Discrete
open import Verification.Core.Set.Contradiction
open import Verification.Core.Algebra.Monoid.Definition

open import Verification.Core.Data.Product.Definition
open import Verification.Core.Data.Sum.Definition

open import Verification.Core.Data.Substitution.Variant.Base.Definition

open import Verification.Core.Data.List.Variant.Unary.Definition
open import Verification.Core.Data.List.Variant.Unary.Element
open import Verification.Core.Data.List.Variant.Binary.Definition
open import Verification.Core.Data.List.Variant.Unary.Element
open import Verification.Core.Data.List.Dependent.Variant.Unary.Definition
open import Verification.Core.Data.List.Dependent.Variant.Binary.Definition

open import Verification.Core.Theory.Std.Specific.FreeFiniteCoproductTheory.Param
open import Verification.Core.Theory.Std.Specific.FreeFiniteCoproductTheory.Definition
open import Verification.Core.Theory.Std.Specific.FreeFiniteCoproductTheory.Instance.Functor
open import Verification.Core.Theory.Std.Specific.FreeFiniteCoproductTheory.Instance.RelativeMonad

open import Verification.Core.Category.Std.Category.Definition
open import Verification.Core.Category.Std.Morphism.Iso
open import Verification.Core.Category.Std.Category.Subcategory.Full
open import Verification.Core.Category.Std.Limit.Specific.Coequalizer
open import Verification.Core.Category.Std.Limit.Specific.Coproduct.Definition
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
open import Verification.Core.Data.Language.HindleyMilner.Variant.Classical.Typed.Typecheck.Case.Var
-- open import Verification.Core.Data.Language.HindleyMilner.Variant.Classical.Typed.Typecheck.Case.SLet
open import Verification.Core.Data.Language.HindleyMilner.Variant.Classical.Typed.Typecheck.Case.Lam
-- open import Verification.Core.Data.Language.HindleyMilner.Variant.Classical.Typed.Typecheck.Case.App

open import Verification.Core.Order.Preorder


{-# DISPLAY isCoequalizer.π₌ _ = π₌ #-}
{-# DISPLAY isCoproduct.ι₀ _ = ι₀ #-}
{-# DISPLAY isCoproduct.ι₁ _ = ι₁ #-}
{-# DISPLAY _内◆-⧜𝐒𝐮𝐛𝐬𝐭_ f g = f ◆ g #-}
{-# DISPLAY 内id-⧜𝐒𝐮𝐛𝐬𝐭 = id #-}

instance
  hasSplitEpiMonoFactorization:ℒHMTypes : hasSplitEpiMonoFactorization ℒHMTypes
  hasSplitEpiMonoFactorization:ℒHMTypes = {!!}


assoc-l-⊔-ℒHMTypes : ∀{a b c : ℒHMTypes} -> (a ⊔ b) ⊔ c ≅ a ⊔ (b ⊔ c)
assoc-l-⊔-ℒHMTypes = {!!}





-- [Theorem]
-- | Typechecking for HM is decidable, the algorithm produces the
--   initial typing instance. That is, there is a function [....]
γ : ∀{μs k} {Q : ℒHMQuant k} -> (Γ : ℒHMCtx Q μs) -> (te : UntypedℒHM k)
  -> (¬ CtxTypingInstance Γ te)
    +
     (InitialCtxTypingInstance Γ te)

-- | Proof.
γ {μs} {k} {Q} Γ (var k∍i) = right $ (_ , typecheck-Var.Result Γ k∍i)

γ {μs = νs} {Q = Q} Γ (slet te se) = {!!}
-- γ {μs = νs} {Q = Q} Γ (slet te se) with γ Γ te
-- ... | (left err) = {!!}
-- ... | (right 𝑇-te) with γ _ se
-- ... | (left err) = {!!}
-- ... | (right 𝑇-se) = right (typecheck-slet.Result Γ te se 𝑇-te 𝑇-se)

γ {μs = νsₐ} Γ (app te se) = {!!}
-- γ {μs = νsₐ} Γ (app te se) with γ Γ te
-- ... | (left err) = {!!}
-- ... | (right 𝑇-te) with γ _ se
-- ... | (left err) = {!!}
-- ... | (right 𝑇-se) with unify-ℒHMTypes _ _
-- ... | (left err) = {!!}
-- ... | (right x) = right (typecheck-app.Result Γ te se 𝑇-te 𝑇-se x)

γ {μs} {k} {Q = Q} Γ (lam te) with γ _ te
... | (left err) = left (typecheck-lam.Fail-te.Result Γ te err)
... | (right 𝑇-te) = right (typecheck-lam.Success-te.Result Γ te 𝑇-te)

-- //


