
module Verification.Core.Theory.Std.Specific.MetaTermCalculus2.Pattern.Instance.PrincipalFamilyCat where

open import Verification.Core.Conventions hiding (Structure)
open import Verification.Core.Set.Decidable
open import Verification.Core.Set.Discrete
open import Verification.Core.Set.Contradiction
open import Verification.Core.Set.Setoid.Definition
open import Verification.Core.Algebra.Monoid.Definition
open import Verification.Core.Algebra.Monoid.Free
open import Verification.Core.Data.List.Variant.FreeMonoid.Element
open import Verification.Core.Data.Universe.Everything
open import Verification.Core.Data.Product.Definition
open import Verification.Core.Data.List.Variant.Base.Definition
-- open import Verification.Core.Theory.Std.Generic.TypeTheory.Definition
-- open import Verification.Core.Theory.Std.Generic.TypeTheory.Simple
-- open import Verification.Core.Theory.Std.Generic.TypeTheory.Simple.Judgement2
open import Verification.Core.Theory.Std.TypologicalTypeTheory.CwJ.Kinding
-- open import Verification.Core.Theory.Std.Generic.TypeTheory.Simple

open import Verification.Core.Category.Std.Category.Definition
-- open import Verification.Core.Category.Std.Category.As.Monoid
-- open import Verification.Core.Category.Std.Category.Structured.Monoidal.Definition
open import Verification.Core.Category.Std.Functor.Definition
open import Verification.Core.Category.Std.RelativeMonad.Definition
open import Verification.Core.Category.Std.RelativeMonad.KleisliCategory.Definition
open import Verification.Core.Category.Std.Category.Subcategory.Definition
-- open import Verification.Core.Category.Std.Morphism.EpiMono
open import Verification.Core.Category.Std.Morphism.Iso
open import Verification.Core.Category.Std.Limit.Specific.Coproduct.Definition
open import Verification.Core.Category.Std.Limit.Specific.Coequalizer

open import Verification.Core.Data.Indexed.Definition
open import Verification.Core.Data.Indexed.Instance.Monoid
open import Verification.Core.Data.FiniteIndexed.Definition
open import Verification.Core.Data.Renaming.Definition
open import Verification.Core.Data.Renaming.Instance.CoproductMonoidal

open import Verification.Core.Theory.Std.Specific.MetaTermCalculus2.Pattern.Definition
open import Verification.Core.Theory.Std.Specific.MetaTermCalculus2.Pattern.Instance.Category
open import Verification.Core.Theory.Std.Specific.MetaTermCalculus2.Pattern.Instance.FiniteCoproductCategory

open import Verification.Core.Computation.Unification.Monoidic.PrincipalFamilyCat2
open import Verification.Core.Order.WellFounded.Definition
open import Verification.Core.Order.Preorder 
open import Verification.Core.Order.Lattice hiding (⊥)
open import Verification.Core.Computation.Unification.Definition
-- open import Verification.Core.Computation.Unification.Monoidic.PrincipalFamily
-- open import Verification.Core.Computation.Unification.Monoidic.ToCoequalizer
open import Verification.Core.Algebra.Monoid.Definition
-- open import Verification.Core.Algebra.MonoidWithZero.Definition
-- open import Verification.Core.Algebra.MonoidWithZero.Ideal
-- open import Verification.Core.Algebra.MonoidAction.Definition

-- ap : ∀{A : 𝒰 𝑖} {B : 𝒰 𝑗} -> {f g : A -> B} -> (f ≡ g) -> (a : A) -> f a ≡ g a
-- ap p a i = p i a


-- private
--   mWF : 𝒰₀
--   mWF = ℕ ^ 3

--   macro 𝒲 = #structureOn mWF

--   postulate
--     _≪-𝒲_ : 𝒲 -> 𝒲 -> 𝒰 ℓ₀
--     WellFounded-≪-𝒲 : WellFounded _≪-𝒲_


--   instance
--     isWellfounded:mWF : isWF {ℓ₀} ℓ₀ 𝒲
--     isWellfounded:mWF = record { _≪_ = _≪-𝒲_ ; wellFounded = WellFounded-≪-𝒲 }

--   instance
--     isWFT:mWF : isWFT 𝒲
--     isWFT:mWF = {!!}




module _ {K : Kinding 𝑖} {{_ : isMetaTermCalculus 𝑖 K}} where

  -- coeq-𝐏𝐚𝐭 : (a b : 𝐏𝐚𝐭 K) -> 𝐏𝐚𝐭 K
  -- coeq-𝐏𝐚𝐭 = {!!}

  -- private
  --   single : ∀{a : Jdg₂ ⟨ K ⟩} {b : 𝐏𝐚𝐭 K} -> (t : ⟨ ⟨ b ⟩ ⟩ ⊩ᶠ-pat a) -> incl (incl (incl a)) ⟶ b
  --   single t = incl (λ {i incl → t})

  -- instance
  --   isDiscrete:𝐏𝐚𝐭 : isDiscrete (𝐏𝐚𝐭 K)
  --   isDiscrete:𝐏𝐚𝐭 = {!!}

  -- instance
  --   isSet-Str:𝐏𝐚𝐭 : isSet-Str (𝐏𝐚𝐭 K)
  --   isSet-Str:𝐏𝐚𝐭 = {!!}

  -- private
  --   data isBase-𝐏𝐚𝐭 : {a b : 𝐏𝐚𝐭 K} -> Pair a b -> 𝒰 𝑖 where
  --     empty-domain : ∀{b : 𝐏𝐚𝐭 K} -> {σ ρ : ⊥ ⟶ b} -> isBase-𝐏𝐚𝐭 (σ , ρ)
  --     no-unification : ∀{a : Jdg₂ ⟨ K ⟩} {b : 𝐏𝐚𝐭 K} -> {t s : ⟨ ⟨ b ⟩ ⟩ ⊩ᶠ-pat a} -> (∀{c} -> (σ : b ⟶ c) -> subst-𝐏𝐚𝐭 t σ ≣ subst-𝐏𝐚𝐭 s σ -> ⊥-𝒰 {ℓ₀})
  --                     -> {f g : incl (incl (incl a)) ⟶ b}
  --                     -> f ∼ single t -> g ∼ single s
  --                     -> isBase-𝐏𝐚𝐭 (f , g)

    -- lem-10 : ∀{a b : 𝐏𝐚𝐭 K} -> (f g : a ⟶ b) -> isBase-𝐏𝐚𝐭 (f , g) -> isDecidable (hasCoequalizer f g)
    -- lem-10 f g empty-domain = right (hasCoequalizer:byInitial f g)
    -- lem-10 f g (no-unification {a} {b} {t} {s} p {f} {g} fp gp) = left {!!} -- P
      -- where
      --   P : hasCoequalizer f g -> 𝟘-𝒰
      --   P (e since eP) =
      --     let P₀ = ∼-Coeq

      --              >> f ◆ π-Coeq ∼ g ◆ π-Coeq <<

      --              ⟪ ( λ q -> ap (⟨ q ⟩ a) incl ) ⟫

      --              >> subst-𝐏𝐚𝐭 t π-Coeq ≡ subst-𝐏𝐚𝐭 s π-Coeq <<

      --              ⟪ ≡→≡-Str ⟫

      --              >> subst-𝐏𝐚𝐭 t π-Coeq ≣ subst-𝐏𝐚𝐭 s π-Coeq <<

      --              ⟪ p π-Coeq ⟫

      --              >> ⊥-𝒰 <<

      --     in impossible P₀

    ∂-𝐏𝐚𝐭 : ∀{x y : 𝐏𝐚𝐭 K} -> (i : Pair x y)
           -> (isBase-𝐏𝐚𝐭 i
              +-𝒰 (∑ λ n -> isSplittableC (𝐏𝐚𝐭 K) n (x , y , i) (λ (_ , _ , j) -> msize j ≪-𝒲 msize i)))

    -- if the domain is not a singleton, we can split it
    ∂-𝐏𝐚𝐭 {incl (incl (a ⋆-⧜ b))} {y} (f , g) =
      right (2 , record
                 { famC      = mfam
                 ; coversC   = {!!}
                 ; fampropsC = {!!}
                 })
        where
          f₀ g₀ : incl (incl a) ⟶ y
          f₀ = incl (λ i x → ⟨ f ⟩ i (left-∍ x))
          g₀ = incl (λ i x → ⟨ g ⟩ i (left-∍ x))

          f₁ g₁ : incl (incl b) ⟶ y
          f₁ = incl (λ i x → ⟨ f ⟩ i (right-∍ x))
          g₁ = incl (λ i x → ⟨ g ⟩ i (right-∍ x))

          mfam : Fin-R 2 -> _
          mfam zero = incl (incl a) , y , (f₀ , g₀)
          mfam (suc zero) = incl (incl b) , y , (f₁ , g₁)

    -- if the domain is empty, we reached a base case
    ∂-𝐏𝐚𝐭 {incl (incl ◌-⧜)} {y} (f , g) = left ({!!})

    -- if the domain is a singleton, we look at the values of f and g at this singleton
    ∂-𝐏𝐚𝐭 {incl (incl (incl x))} {y} (f , g) with (⟨ f ⟩ x incl) in fp | (⟨ g ⟩ x incl) in gp
    ... | app-meta M s | app-meta M₁ s₁ = {!!}
    ... | app-meta M s | app-var x x₁   = {!!}
    ... | app-meta M s | app-con x x₁   = {!!}
    ... | app-var x x₁ | app-meta M s   = {!!}
    ... | app-var {Δ = Δ₀} v₀ ts₀ | app-var {Δ = Δ₁} v₁ ts₁  with Δ₀ ≟-Str Δ₁
    ... | yes refl-≣ = {!!}
    ... | no ¬p = left (no-unification {t = app-var v₀ ts₀} (lem-20-var-var ¬p) (incl (λ {i i₁ incl → (≡-Str→≡ fp i₁) })) {!!})
    -- ... | no ¬p = left (no-unification {t = app-var v₀ ts₀} {s = app-var {Δ = Δ₁} v₁ ts₁} (lem-20-var-var ¬p) (incl (λ {i i₁ incl → (≡-Str→≡ fp i₁) })) {!!})
    ∂-𝐏𝐚𝐭 {incl (incl (incl x))} {y} (f , g) | app-var v ts₀ | app-con c ts₁  =
      left (no-unification {t = app-var v ts₀} {s = app-con c ts₁} (lem-20-var-con) (incl (λ {i i₁ incl → (≡-Str→≡ fp i₁) })) {!!})
    ∂-𝐏𝐚𝐭 {incl (incl (incl x))} {y} (f , g) | app-con c x₁ | app-meta M s   = {!!}
    ∂-𝐏𝐚𝐭 {incl (incl (incl x))} {y} (f , g) | app-con c x₁ | app-var x₂ x₃  = {!!}
    ∂-𝐏𝐚𝐭 {incl (incl (incl x))} {y} (f , g) | app-con c x₁ | app-con x₂ x₃  = {!!}

  instance
    isPrincipalFamilyCat:𝐏𝐚𝐭 : isPrincipalFamilyCat (𝐏𝐚𝐭 K)
    isPrincipalFamilyCat.SizeC isPrincipalFamilyCat:𝐏𝐚𝐭         = 𝒲
    isPrincipalFamilyCat.isBase isPrincipalFamilyCat:𝐏𝐚𝐭        = isBase-𝐏𝐚𝐭
    isPrincipalFamilyCat.sizeC isPrincipalFamilyCat:𝐏𝐚𝐭         = msize
    isPrincipalFamilyCat.∂C isPrincipalFamilyCat:𝐏𝐚𝐭            = ∂-𝐏𝐚𝐭
    isPrincipalFamilyCat.size0 isPrincipalFamilyCat:𝐏𝐚𝐭         = {!!}
    isPrincipalFamilyCat.initial-size0 isPrincipalFamilyCat:𝐏𝐚𝐭 = {!!}
    isPrincipalFamilyCat.isPrincipalC:Base isPrincipalFamilyCat:𝐏𝐚𝐭 f g x = {!!}

{-
-}
