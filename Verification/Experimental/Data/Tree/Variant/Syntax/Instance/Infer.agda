
module Verification.Experimental.Data.Tree.Variant.Syntax.Instance.Infer where

open import Verification.Conventions hiding (lookup ; ℕ)

open import Verification.Experimental.Set.Setoid.Definition
open import Verification.Experimental.Set.Setoid.Instance.Category
open import Verification.Experimental.Algebra.Monoid.Definition
open import Verification.Experimental.Algebra.Monoid.Free
open import Verification.Experimental.Data.AllOf.Nat
open import Verification.Experimental.Data.AllOf.Product
open import Verification.Experimental.Data.AllOf.Sum
open import Verification.Experimental.Data.AllOf.List
open import Verification.Experimental.Data.Expr.Variant.Base.Definition
open import Verification.Experimental.Data.Universe.Everything
open import Verification.Experimental.Category.Std.Category.Definition
open import Verification.Experimental.Category.Std.Category.Opposite
open import Verification.Experimental.Category.Std.Category.Construction.Product
open import Verification.Experimental.Category.Std.Category.Instance.Category
open import Verification.Experimental.Category.Std.Category.Instance.FiniteProductCategory
open import Verification.Experimental.Category.Std.Limit.Specific.Product
open import Verification.Experimental.Category.Std.Limit.Specific.Product.Instance.Functor
open import Verification.Experimental.Category.Std.Functor.Definition
open import Verification.Experimental.Category.Std.Functor.Constant
open import Verification.Experimental.Category.Std.Morphism.Iso
open import Verification.Experimental.Set.Setoid.As.Category
open import Verification.Experimental.Set.Setoid.Discrete
open import Verification.Experimental.Set.Setoid.Definition

open import Verification.Experimental.Data.Indexed.Definition
open import Verification.Experimental.Data.Indexed.Duplicate

open import Verification.Experimental.Data.Substitution.Variant.Base.Definition
open import Verification.Experimental.Data.Substitution.Variant.Normal.Definition

open import Verification.Experimental.Category.Std.Monad.Definition
open import Verification.Experimental.Category.Std.Monad.Instance.Category
open import Verification.Experimental.Category.Std.Monad.Instance.LargeCategory
open import Verification.Experimental.Category.Std.Category.Subcategory.Definition
open import Verification.Experimental.Theory.Std.Inference.Definition
open import Verification.Experimental.Theory.Std.Inference.Task

open import Verification.Experimental.Data.Tree.Variant.Syntax.Data
open import Verification.Experimental.Data.Tree.Variant.Syntax.Definition
open import Verification.Experimental.Data.Tree.Variant.Syntax.Instance.Monad

open import Verification.Experimental.Data.Tree.Variant.Token.Data
open import Verification.Experimental.Data.Tree.Variant.Token.Definition
open import Verification.Experimental.Data.Tree.Variant.Token.Instance.Monad




data SyntaxTreeToken : 𝒰₀ where
  binder : SyntaxTreeToken

tokenSize-SyntaxTreeToken : SyntaxTreeToken -> ♮ℕ
tokenSize-SyntaxTreeToken binder = 2

tokenName-SyntaxTreeToken : SyntaxTreeToken -> Text
tokenName-SyntaxTreeToken binder = "↦"

toTokenTreeData : SyntaxTreeData -> TokenTreeData
toTokenTreeData 𝒹 = record
  { TokenType = SyntaxTreeToken + (TokenType 𝒹)
  ; tokenSize = either tokenSize-SyntaxTreeToken (λ xs -> map-List (const tt) (tokenSize 𝒹 xs))
  ; tokenName = either tokenName-SyntaxTreeToken (tokenName 𝒹)
  ; tokenList = left binder ∷ map-List right (tokenList 𝒹)
  }

private δ = toTokenTreeData

module _ {𝒹 : SyntaxTreeData} where
  -----------------------------------------
  -- printing of the syntax tree
  mutual

    printᵘ-SyntaxTreeBinding : ∀ {A} {Γ} {n} -> SyntaxTreeBinding 𝒹 A Γ n -> TokenTree (δ 𝒹) (∑ A)
    printᵘ-SyntaxTreeBinding (incl x) = printᵘ-SyntaxTree' _ _ x
    printᵘ-SyntaxTreeBinding (hole x) = hole (_ , x)
    printᵘ-SyntaxTreeBinding (bind name x) = node (left binder) ((var name) ∷ (printᵘ-SyntaxTreeBinding x) ∷ [])


    printᵘ-SyntaxTrees : ∀ {A} {Γ} {n} -> DList (SyntaxTreeBinding 𝒹 (ix A) Γ) (n)
                                          -> ConstDList (TokenTreeᵘ (δ 𝒹) (⨆ᵘ A)) (map-List (const tt) n)
    printᵘ-SyntaxTrees [] = []
    printᵘ-SyntaxTrees (x ∷ xs) = printᵘ-SyntaxTreeBinding x ∷ (printᵘ-SyntaxTrees xs)

    -- NOTE: we need to write the induction without the ∑ on SyntaxTree,
    --       because with it, the termination checker does not see that
    --       the recursion terminates. Hence this implementation version with "'"
    printᵘ-SyntaxTree' : ∀ A i -> (SyntaxTreeᵈ 𝒹 A) i -> TokenTree (δ 𝒹) (∑ A)
    printᵘ-SyntaxTree' A i (hole x) = hole (i , x)
    printᵘ-SyntaxTree' A i (var name x) = var name
    printᵘ-SyntaxTree' A i (node t x) = node (right t) (printᵘ-SyntaxTrees x)
    printᵘ-SyntaxTree' A i (annotation a x) = annotation a (printᵘ-SyntaxTree' A i x)

  printᵘ-SyntaxTree : ∀ A -> ⨆ (SyntaxTree 𝒹 A) -> TokenTree (δ 𝒹) (⨆ A)
  printᵘ-SyntaxTree A (i , x) = printᵘ-SyntaxTree' (ix A) i x

  print-SyntaxTree : 大MonadHom (_ , SyntaxTree 𝒹) (_ , TokenTree (δ 𝒹))
  print-SyntaxTree = record { fst = ⨆ ; snd = printᵘ-SyntaxTree since {!!} }


  -----------------------------------------
  -- Parsing from a token tree

  mutual
    parseᵘ-SyntaxTreeBinding : ∀ {A} {Γ} {n}
                           -> (TokenTreeᵘ (δ 𝒹) (A))
                           -> (SyntaxTreeBinding 𝒹 (ix (写 (TokenTree (δ 𝒹) A))) Γ) n
    parseᵘ-SyntaxTreeBinding {Γ = Γ} {n = ⦋⦌} t = incl (parseᵘ-SyntaxTree' Γ t)

    parseᵘ-SyntaxTreeBinding {Γ = Γ} {n = tt ∷ n} (node (left binder) (var name ∷ (t ∷ []))) = bind name (parseᵘ-SyntaxTreeBinding t)
    parseᵘ-SyntaxTreeBinding {Γ = Γ} {n = tt ∷ n} other@(t) = hole (annotation "Expected binder here." other)

    parseᵘ-SyntaxTrees : ∀ {A} {Γ} {n}
                           -> ConstDList (TokenTreeᵘ (δ 𝒹) (A)) (map-List (const tt) n)
                           -> DList (SyntaxTreeBinding 𝒹 (ix (写 (TokenTree (δ 𝒹) A))) Γ) (n)
    parseᵘ-SyntaxTrees {n = ⦋⦌} [] = []
    parseᵘ-SyntaxTrees {n = _ ∷ _} (x ∷ xs) = parseᵘ-SyntaxTreeBinding x ∷ parseᵘ-SyntaxTrees xs


    parseᵘ-SyntaxTree' : ∀ {A} -> (Γ : 人List Text) -> TokenTree (δ 𝒹) A -> (ix (SyntaxTree 𝒹 (写 (TokenTree (δ 𝒹) A))) Γ)
    parseᵘ-SyntaxTree' Γ (hole x) = hole (hole x)
    parseᵘ-SyntaxTree' Γ (var x) = case find-first-∍ Γ x of
                                           (λ p -> hole (annotation ("The variable " <> x <> " is not in scope") (var x)))
                                           (λ Γ∍x → var x Γ∍x)
    parseᵘ-SyntaxTree' Γ (node (left binder) x) = hole (annotation "No variable binding allowed here." ((node (left binder) x)))
    parseᵘ-SyntaxTree' Γ (node (just t) x) = node t (parseᵘ-SyntaxTrees x)
    parseᵘ-SyntaxTree' Γ (annotation a x) = annotation a (parseᵘ-SyntaxTree' Γ x)

  parseᵘ-SyntaxTree : ∀ A -> TokenTree (δ 𝒹) A -> (⨆ (SyntaxTree 𝒹 (写 (TokenTree (δ 𝒹) A))))
  parseᵘ-SyntaxTree A t = _ , parseᵘ-SyntaxTree' ◌ t


  -----------------------------------------
  -- This gives us an inference morphism

  isInferHom:print-SyntaxTree : isInferHom print-SyntaxTree
  isInferHom:print-SyntaxTree = record
    { inferF = 写
    ; infer = parseᵘ-SyntaxTree since {!!}
    ; eval-infer = {!!}
    }

  infer-SyntaxTree : SyntaxTreeInfer 𝒹 ⟶ TokenTreeInfer (δ 𝒹)
  infer-SyntaxTree = subcathom print-SyntaxTree isInferHom:print-SyntaxTree



