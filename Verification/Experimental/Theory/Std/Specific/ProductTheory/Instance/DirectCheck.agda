
module Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.DirectCheck where

open import Verification.Conventions hiding (_⊔_ ; lookup)
open import Verification.Experimental.Set.Discrete
open import Verification.Experimental.Set.Contradiction
open import Verification.Experimental.Set.Setoid.Definition
open import Verification.Experimental.Set.Function.Surjective
open import Verification.Experimental.Data.Nat.Free
open import Verification.Experimental.Data.Sum.Definition
open import Verification.Experimental.Data.Product.Definition
open import Verification.Experimental.Data.Vec.Instance.Functor
open import Verification.Experimental.Data.Sum.Instance.Functor
open import Verification.Experimental.Category.Std.Monad.Definition
open import Verification.Experimental.Category.Std.Monad.KleisliCategory.Instance.Monoidal
open import Verification.Experimental.Category.Std.Monad.TypeMonadNotation
open import Verification.Experimental.Data.Sum.Instance.Monad
open import Verification.Experimental.Data.Universe.Everything
open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Unification.Definition
open import Verification.Experimental.Theory.Std.Presentation.Token.Definition
open import Verification.Experimental.Category.Std.Category.Definition
open import Verification.Experimental.Category.Std.Functor.Definition
open import Verification.Experimental.Category.Std.Category.Subcategory.Definition
open import Verification.Experimental.Category.Std.Category.Subcategory.Full
open import Verification.Experimental.Data.Indexed.Definition
open import Verification.Experimental.Data.Indexed.Instance.Monoid
open import Verification.Experimental.Data.FiniteIndexed.Definition
open import Verification.Experimental.Algebra.Monoid.Definition
open import Verification.Experimental.Algebra.Monoid.Free
open import Verification.Experimental.Algebra.Monoid.Free.Element
open import Verification.Experimental.Data.Substitution.Definition
open import Verification.Experimental.Data.Substitution.Property.Base
open import Verification.Experimental.Theory.Std.Presentation.NGraph.Definition
open import Verification.Experimental.Category.Std.Limit.Specific.Coproduct.Definition
open import Verification.Experimental.Category.Std.Morphism.Iso

open import Verification.Experimental.Category.Std.RelativeMonad.Definition
open import Verification.Experimental.Category.Std.RelativeMonad.KleisliCategory.Definition


-- open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.FromString2
open import Verification.Experimental.Theory.Std.Presentation.CheckTree.Definition2
open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.FromANVecTree
open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.hasBoundaries



module _ {A : 𝒰 𝑖} {l : A -> ℕ} {ℬ : 𝒰 𝑖} {{_ : isCategory {𝑗} ℬ}} {{_ : isSet-Str ℬ}} {F : Functor ′ ℬ ′ (𝐔𝐧𝐢𝐯 𝑙)} {{_ : isCheckingBoundary ′ ℬ ′ F}} where

  -- module _ (initb : A -> ℬ)
  --          (initv : ∀(a : A) -> ⟨ F ⟩ (initb a))
  --          (initvs : ∀(a : A) -> Vec (⟨ F ⟩ (initb a)) (l a))
  --          (WT : ∀{b} -> (a : A) -> ⟨ F ⟩ b -> Vec (⟨ F ⟩ b) (l a) -> 𝒰 𝑘)
           -- where
  module _ {{_ : hasBoundary ′ ℬ ′ F A l}} where

    ADANVecTree1 = ADANVecTree A l ℬ F

    mutual
      makeInitialTrees : ∀{n} -> Vec (VecTree1 A l) n -> Vec (∑ ADANVecTree A l ℬ F) n
      makeInitialTrees ⦋⦌ = ⦋⦌
      makeInitialTrees (x ∷ ts) = (makeInitialTree x) ∷ (makeInitialTrees ts)

      makeInitialTree : VecTree1 A l -> ∑ ADANVecTree A l ℬ F
      makeInitialTree (node1 a x) = _ , (node1 a (initb a) (initv a) (initvs a) initwt (makeInitialTrees x))

    mutual
      makeFinalTrees : ∀{n b} -> (vs : Vec (⟨ F ⟩ b) n) -> (ts : Vec (∑ ADANVecTree A l ℬ F) n)
                       -> String + (∑ λ x -> ∑ λ (ϕ : b ⟶ x) -> DVec (ANVecTree A l ℬ F x) (map-Vec (map ϕ) vs))
      makeFinalTrees ⦋⦌ ⦋⦌ = right (_ , (id , []))
      makeFinalTrees (v0 ∷ vs) (t0 ∷ ts) with makeFinalTree (t0 .snd)
      ... | left x = left x
      ... | just (b , bv , bt) with tryMerge v0 bv
      ... | left x = left "Type mismatch"
      ... | just (x₀ , ϕ₀ , ϕ₁ , p) with makeFinalTrees (map-Vec (map ϕ₀) vs) ts
      ... | left x = left x
      ... | just (x , ϕ , ts') = right (x , ((ϕ₀ ◆ ϕ) , (bt'₀ ∷ ts'')))
        where
          bt' : ANVecTree A l ℬ F x (map (ϕ₁ ◆ ϕ) bv)
          bt' = map-ANVecTree A l ℬ F (ϕ₁ ◆ ϕ) bt

          btp : map (ϕ₁ ◆ ϕ) bv ≡ map (ϕ₀ ◆ ϕ) v0
          btp = map (ϕ₁ ◆ ϕ) bv   ⟨ (λ i -> functoriality-◆ {f = ϕ₁} {g = ϕ} i bv) ⟩-≡
                map ϕ (map ϕ₁ bv) ⟨ ((λ i -> map ϕ (p (~ i)))) ⟩-≡
                map ϕ (map ϕ₀ v0) ⟨ ((λ i -> functoriality-◆ {f = ϕ₀} {g = ϕ} (~ i) v0)) ⟩-≡
                map (ϕ₀ ◆ ϕ) v0   ∎-≡

          bt'₀ : ANVecTree A l ℬ F x (map (ϕ₀ ◆ ϕ) v0)
          bt'₀ = transport (λ i -> ANVecTree A l ℬ F x (btp i)) bt'

          pts : map-Vec (map ϕ) (map-Vec (map ϕ₀) vs) ≡ (map-Vec (map (ϕ₀ ◆ ϕ)) vs)
          pts = map-Vec (map ϕ) (map-Vec (map ϕ₀) vs)  ⟨ funExt⁻¹ (functoriality-◆ {f = map ϕ₀} {g = map ϕ} ⁻¹) vs ⟩-≡
                map-Vec (map ϕ ∘ map ϕ₀) vs            ⟨ (λ i -> map-Vec (functoriality-◆ {f = ϕ₀} {g = ϕ} (~ i)) vs) ⟩-≡
                map-Vec (map (ϕ₀ ◆ ϕ)) vs              ∎-≡

          ts'' : DVec (ANVecTree A l ℬ F x) (map-Vec (map (ϕ₀ ◆ ϕ)) vs)
          ts'' = transport (λ i -> DVec (ANVecTree A l ℬ F x) (pts i)) ts'


      makeFinalTree : ∀{b0} -> {vb0 : ⟨ F ⟩ b0} (t : ADANVecTree A l ℬ F (b0 , vb0)) -> String + (∑ λ bx -> ∑ ANVecTree A l ℬ F bx)
      makeFinalTree (node1 a b vb vs wt ts) with makeFinalTrees vs ts
      ... | left x₁ = left x₁
      ... | just (x , ϕ , ts') = right (x , (map ϕ vb  , (node1 a (map ϕ vb) (map-Vec (map ϕ) vs) (map-WT ϕ wt) ts')))

      -- = do
      --   _ <- makeFinalTrees vs ts
      --   right ({!!} , ({!!} , (node1 a {!!} {!!} {!!} {!!})))


    -- makeFinalTree {b0} vb0 curtree@(node1 a .b0 .vb0 vs wt ts) p = (node1 a (map f0 vb0) (map-Vec (map f0) vs) {!!} ts')
