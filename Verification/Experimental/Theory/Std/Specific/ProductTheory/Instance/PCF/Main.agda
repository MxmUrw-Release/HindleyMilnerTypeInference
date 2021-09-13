
module Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.PCF.Main where

open import Verification.Conventions hiding (ℕ)

open import Verification.Experimental.Set.Discrete
open import Verification.Experimental.Algebra.Monoid.Definition
open import Verification.Experimental.Algebra.Monoid.Free
open import Verification.Experimental.Algebra.Monoid.Free.Element
-- open import Verification.Experimental.Order.Lattice
open import Verification.Experimental.Data.Universe.Everything
open import Verification.Experimental.Data.Product.Definition
-- open import Verification.Experimental.Theory.Std.Generic.TypeTheory.Definition
-- open import Verification.Experimental.Theory.Std.Generic.TypeTheory.Simple
-- open import Verification.Experimental.Theory.Std.Generic.TypeTheory.Simple.Judgement2
-- open import Verification.Experimental.Theory.Std.TypologicalTypeTheory.CwJ.Kinding
-- open import Verification.Experimental.Theory.Std.Generic.TypeTheory.Simple
-- open import Verification.Experimental.Theory.Std.Specific.MetaTermCalculus2.Pattern.Definition

open import Verification.Experimental.Category.Std.Category.Definition
open import Verification.Experimental.Category.Std.Category.Sized.Definition
open import Verification.Experimental.Category.Std.Category.Structured.Monoidal.Definition
open import Verification.Experimental.Category.Std.Functor.Definition
open import Verification.Experimental.Category.Std.RelativeMonad.Definition
open import Verification.Experimental.Category.Std.RelativeMonad.KleisliCategory.Definition
-- open import Verification.Experimental.Category.Std.Category.Subcategory.Definition
-- open import Verification.Experimental.Category.Std.Morphism.EpiMono
open import Verification.Experimental.Category.Std.Morphism.Iso
open import Verification.Experimental.Category.Std.Limit.Specific.Coproduct.Definition
-- open import Verification.Experimental.Category.Std.Limit.Specific.Coproduct.Preservation.Definition

open import Verification.Experimental.Order.WellFounded.Definition
open import Verification.Experimental.Order.WellFounded.Construction.Product
open import Verification.Experimental.Order.WellFounded.Construction.Sum
open import Verification.Experimental.Order.Preorder 
open import Verification.Experimental.Order.Lattice hiding (⊥)

open import Verification.Experimental.Data.List.Definition
open import Verification.Experimental.Data.Nat.Definition
open import Verification.Experimental.Data.Nat.Free
open import Verification.Experimental.Data.Indexed.Definition
open import Verification.Experimental.Data.Indexed.Instance.Monoid
open import Verification.Experimental.Data.FiniteIndexed.Definition
open import Verification.Experimental.Data.FiniteIndexed.Property.Merge
open import Verification.Experimental.Data.Renaming.Definition
open import Verification.Experimental.Data.Renaming.Instance.CoproductMonoidal
open import Verification.Experimental.Data.Substitution.Definition

open import Verification.Experimental.Theory.Std.Generic.FormalSystem.Definition
open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Definition
open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.FormalSystem

open import Verification.Experimental.Computation.Unification.Categorical.PrincipalFamilyCat

open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.PCF.Base
open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.PCF.Size
open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.PCF.DirectFail

module _ {𝑨 : 𝕋× 𝑖} where

  ∂-𝕋× : ∀{x y : 𝐂𝐭𝐱 𝑨} -> (t : HomPair x y) -> (isBase-𝕋× t +-𝒰 (∑ λ n -> isSplittableC (𝐂𝐭𝐱 𝑨) n t))
  ∂-𝕋× (⧜subst ◌-⧜ , ⧜subst ◌-⧜) = left isBase:⊥
  ∂-𝕋× {x} {y} (⧜subst (f₀ ⋆-⧜ f₁) , ⧜subst (g₀ ⋆-⧜ g₁)) = right (2 , record { famC = fam' ; coversC = (λ h -> covers-0 h , covers-1 h) ; fampropsC = sizes })
    where
      fam' : Fin-R 2 -> ∑ λ x' -> HomPair x' y
      fam' (zero) = _ , ⧜subst f₀ , ⧜subst g₀
      fam' (suc zero) = _ , ⧜subst f₁ , ⧜subst g₁

      covers-0 : {x = x₁ : 𝐂𝐭𝐱ᵘ 𝑨} (h : y ⟶ x₁) →
                (⧜subst ((f₀ ◆-⧜𝐒𝐮𝐛𝐬𝐭 h) ⋆-⧜ (f₁ ◆-⧜𝐒𝐮𝐛𝐬𝐭 h)))
                      ∼ (⧜subst ((g₀ ◆-⧜𝐒𝐮𝐛𝐬𝐭 h) ⋆-⧜ (g₁ ◆-⧜𝐒𝐮𝐛𝐬𝐭 h))) →
                      (p : Fin-R 2) →
                      (⧜subst (⟨ fst (fam' p .snd) ⟩ ◆-⧜𝐒𝐮𝐛𝐬𝐭 h))
                      ∼ (⧜subst (⟨ snd (fam' p .snd) ⟩ ◆-⧜𝐒𝐮𝐛𝐬𝐭 h))

      covers-0 {x = x₁} h q (zero) = π₀-⋆-⧜𝐒𝐮𝐛𝐬𝐭-≣ q
      covers-0 {x = x₁} h q (suc zero) = π₁-⋆-⧜𝐒𝐮𝐛𝐬𝐭-≣ q

      covers-1 : {x = x₁ : 𝐂𝐭𝐱ᵘ 𝑨} (h : y ⟶ x₁) →
                      ((p : Fin-R 2) →
                      (⧜subst (⟨ fst (fam' p .snd) ⟩ ◆-⧜𝐒𝐮𝐛𝐬𝐭 h))
                      ∼ (⧜subst (⟨ snd (fam' p .snd) ⟩ ◆-⧜𝐒𝐮𝐛𝐬𝐭 h))) ->
                      (⧜subst ((f₀ ◆-⧜𝐒𝐮𝐛𝐬𝐭 h) ⋆-⧜ (f₁ ◆-⧜𝐒𝐮𝐛𝐬𝐭 h)))
                            ∼ (⧜subst ((g₀ ◆-⧜𝐒𝐮𝐛𝐬𝐭 h) ⋆-⧜ (g₁ ◆-⧜𝐒𝐮𝐛𝐬𝐭 h)))

      covers-1 h p = cong-Str ⧜subst (cong₂-Str _⋆-⧜_ (cong-Str ⟨_⟩ (p (zero))) (cong-Str ⟨_⟩ (p (suc zero))))

      sizes : ∀(k : Fin-R 2) -> sizeC (fam' k .snd) ≪ sizeC (⧜subst (f₀ ⋆-⧜ f₁) , ⧜subst (g₀ ⋆-⧜ g₁))
      sizes (zero) = right ((incl (sizeC-half (⧜subst f₁) , comm-⋆ {a = sizeC-half (⧜subst f₁)} {b = _})) , (incl (sizeC-half (⧜subst g₁) , comm-⋆ {a = sizeC-half (⧜subst g₁)} {b = _})))
      sizes (suc zero) = right (incl (sizeC-half (⧜subst f₀) , (+-suc (sizeC-half (⧜subst f₀)) _)) , incl (sizeC-half (⧜subst g₀) , (+-suc (sizeC-half (⧜subst g₀)) _)))


  ∂-𝕋× (⧜subst (incl (var x)) , ⧜subst (incl (var y))) with compare-∍ y x
  ... | left ¬p = left (isBase:var _ _ ¬p)
  ... | right (p , q) with isset-Str p refl-≣
  ∂-𝕋× (⧜subst (incl (var x)) , ⧜subst (incl (var .x))) | just (.refl-≣ , refl-≣) | refl-≣ = left isBase:id
  ∂-𝕋× (⧜subst (incl (var x)) , ⧜subst (incl (con c x₁))) = left (isBase:sym (isBase:con-var _ _ _))
  ∂-𝕋× (⧜subst (incl (con c x)) , ⧜subst (incl (var x₁))) = left (isBase:con-var _ _ _)
  ∂-𝕋× (⧜subst (incl (con {αs = αsx} cx tsx)) , ⧜subst (incl (con {αs = αsy} cy tsy))) with αsx ≟-Str αsy
  ... | no ¬p = left (isBase:con≠con cx cy tsx tsy ¬p)
  ... | yes refl-≣ with cx ≟-Str cy
  ... | no ¬p = left (isBase:con≠con₂ cx cy tsx tsy ¬p)
  ... | yes refl-≣ = right (1 , record { famC = fam' ; coversC = λ h → covers-0 h , covers-1 h ; fampropsC = λ k → right (reflexive , reflexive) })
    where
      f₀ = ⧜subst (tsx)
      g₀ = ⧜subst (tsy)

      fam' : Fin-R 1 -> _
      fam' x = _ , f₀ , g₀

      covers-0 : {x : 𝐂𝐭𝐱ᵘ 𝑨}
                    (h : incl _ ⟶ x) →
                    ⧜subst (incl (subst-⧜𝐒𝐮𝐛𝐬𝐭 h (con cx tsx))) ∼ ⧜subst (incl (subst-⧜𝐒𝐮𝐛𝐬𝐭 h (con cx tsy)))
                    ->
                    ((p : Fin-R 1) →
                    ((fst (fam' p .snd) ◆ h))
                    ∼ (snd (fam' p .snd) ◆ h))
      covers-0 h p q = cong-Str ⟨_⟩ p
        >> incl (subst-⧜𝐒𝐮𝐛𝐬𝐭 h (con cx tsx)) ≣ (incl (subst-⧜𝐒𝐮𝐛𝐬𝐭 h (con cx tsy))) <<
        ⟪ cancel-injective-incl-Hom-⧜𝐒𝐮𝐛𝐬𝐭 ⟫
        ⟪ cancel-injective-con₃ refl-≣ ⟫
        ⟪ §-reext-Terms-𝕋×.prop-2 h tsx ≀∼≀ §-reext-Terms-𝕋×.prop-2 h tsy ⟫
        ⟪ cong-Str ⧜subst ⟫
        >> (⧜subst tsx ◆ h) ∼ (⧜subst tsy ◆ h) <<

      covers-1 : {x : 𝐂𝐭𝐱ᵘ 𝑨}
                    (h : incl _ ⟶ x) →
                    ((p : Fin-R 1) →
                    ((fst (fam' p .snd) ◆ h))
                    ∼ (snd (fam' p .snd) ◆ h))
                    ->
                    ⧜subst (incl (subst-⧜𝐒𝐮𝐛𝐬𝐭 h (con cx tsx))) ∼ ⧜subst (incl (subst-⧜𝐒𝐮𝐛𝐬𝐭 h (con cx tsy)))
      covers-1 h p = p (zero)
        >> (⧜subst tsx ◆ h) ∼ (⧜subst tsy ◆ h) <<
        ⟪ cong-Str ⟨_⟩ ⟫
        ⟪ §-reext-Terms-𝕋×.prop-2 h tsx ⁻¹ ≀∼≀ §-reext-Terms-𝕋×.prop-2 h tsy ⁻¹ ⟫
        ⟪ cong-Str (con cx) ⟫
        ⟪ cong-Str incl ⟫
        ⟪ cong-Str ⧜subst ⟫


