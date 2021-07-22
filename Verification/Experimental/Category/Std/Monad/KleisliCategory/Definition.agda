
module Verification.Experimental.Category.Std.Monad.KleisliCategory.Definition where

open import Verification.Conventions

open import Verification.Experimental.Set.Setoid
open import Verification.Experimental.Set.Discrete
open import Verification.Experimental.Category.Std.Category.Definition
open import Verification.Experimental.Category.Std.Functor.Definition
open import Verification.Experimental.Category.Std.Functor.Instance.Category
open import Verification.Experimental.Category.Std.Natural.Definition
open import Verification.Experimental.Category.Std.Category.Instance.Category
open import Verification.Experimental.Category.Std.Monad.Definition


record Kleisli {𝒞 : Category 𝑖} (T : Monad 𝒞) : 𝒰 𝑖 where
  constructor incl
  field ⟨_⟩ : ⟨ 𝒞 ⟩
open Kleisli {{...}} public

macro
  𝐊𝐥𝐬 : {𝒞 : Category 𝑖} (T : Monad 𝒞) -> SomeStructure
  𝐊𝐥𝐬 T = #structureOn (Kleisli T)


module _ {𝒞 : Category 𝑖} {T : Monad 𝒞} where


  KleisliHom : (A B : Kleisli T) -> 𝒰 _
  KleisliHom = Hom-Base (λ x y -> ⟨ x ⟩ ⟶ ⟨ T ⟩ ⟨ y ⟩)

  module _ {A B : Kleisli T} where
    _∼-KleisliHom_ : (f g : KleisliHom A B) -> 𝒰 _
    _∼-KleisliHom_ = ∼-Base (λ f g -> ⟨ f ⟩ ∼ ⟨ g ⟩)


    instance
      isSetoid:KleisliHom : isSetoid (KleisliHom A B)
      isSetoid._∼_ isSetoid:KleisliHom = _∼-KleisliHom_
      isSetoid.refl isSetoid:KleisliHom {a} = incl refl
      isSetoid.sym isSetoid:KleisliHom {a} {b} p = incl (sym ⟨ p ⟩)
      isSetoid._∙_ isSetoid:KleisliHom {a} p q = incl $ ⟨ p ⟩ ∙ ⟨ q ⟩

  private
    lem-1 : ∀{a b : ⟨ 𝒞 ⟩} -> {f : a ⟶ ⟨ T ⟩ b} -> (pure >=> f) ∼ f
    lem-1 {f = f} = pure ◆ map f ◆ join     ⟨ naturality f ◈ refl ⟩-∼
                    f ◆ pure ◆ join         ⟨ assoc-l-◆ ⟩-∼
                    f ◆ (pure ◆ join)       ⟨ refl ◈ unit-l-join ⟩-∼
                    f ◆ id                  ⟨ unit-r-◆ ⟩-∼
                    f                       ∎

    lem-2 : ∀{a b : ⟨ 𝒞 ⟩} -> {f : a ⟶ ⟨ T ⟩ b} -> (f >=> pure) ∼ f
    lem-2 {f = f} = f ◆ map pure ◆ join   ⟨ assoc-l-◆ ⟩-∼
                    f ◆ (map pure ◆ join) ⟨ refl ◈ unit-r-join ⟩-∼
                    f ◆ id                ⟨ unit-r-◆ ⟩-∼
                    f                     ∎

    lem-3 : ∀{a b c d : ⟨ 𝒞 ⟩} -> {f : a ⟶ ⟨ T ⟩ b} {g : b ⟶ ⟨ T ⟩ c} {h : c ⟶ ⟨ T ⟩ d} -> (f >=> g) >=> h ∼ f >=> (g >=> h)
    lem-3 {f = f} {g} {h} =
      f ◆ map g ◆ join ◆ map h ◆ join            ⟨ assoc-l-◆ ⟩-∼
      f ◆ map g ◆ join ◆ (map h ◆ join)          ⟨ assoc-l-◆ ⟩-∼
      f ◆ map g ◆ (join ◆ (map h ◆ join))        ⟨ refl ◈ assoc-r-◆ ⟩-∼
      f ◆ map g ◆ ((join ◆ map h) ◆ join)        ⟨ refl ◈ ((naturality h) ◈ refl) ⟩-∼
      f ◆ map g ◆ ((map (map h) ◆ join) ◆ join)  ⟨ refl ◈ assoc-l-◆ ⟩-∼
      f ◆ map g ◆ (map (map h) ◆ (join ◆ join))  ⟨ refl ◈ ((refl ◈ assoc-join) ∙ assoc-r-◆) ⟩-∼
      f ◆ map g ◆ ((map (map h) ◆ map join) ◆ join)  ⟨ refl ◈ (functoriality-◆ ⁻¹ ◈ refl) ⟩-∼
      f ◆ map g ◆ (map (map h ◆ join) ◆ join)    ⟨ assoc-r-◆ ⟩-∼
      f ◆ map g ◆ map (map h ◆ join) ◆ join      ⟨ assoc-l-◆ ◈ refl ⟩-∼
      f ◆ (map g ◆ map (map h ◆ join)) ◆ join    ⟨ refl ◈ functoriality-◆ ⁻¹ ◈ refl ⟩-∼
      f ◆ map (g ◆ (map h ◆ join)) ◆ join        ⟨ refl ◈ cong-∼ assoc-r-◆ ◈ refl ⟩-∼
      f ◆ map (g ◆ map h ◆ join) ◆ join          ∎

    lem-4 : ∀{a b c : ⟨ 𝒞 ⟩} -> {f₀ f₁ : a ⟶ ⟨ T ⟩ b} {g₀ g₁ : b ⟶ ⟨ T ⟩ c} -> (f₀ ∼ f₁) -> (g₀ ∼ g₁) -> (f₀ >=> g₀ ∼ f₁ >=> g₁)
    lem-4 {f₀ = f₀} {f₁} {g₀} {g₁} p q = p ◈ cong-∼ q ◈ refl

  instance
    Category:Kleisli : isCategory (Kleisli T)
    isCategory.Hom Category:Kleisli A B = KleisliHom A B
    isCategory.isSetoid:Hom Category:Kleisli = it
    isCategory.id Category:Kleisli         = incl pure
    isCategory._◆_ Category:Kleisli        = λ f g -> incl (⟨ f ⟩ >=> ⟨ g ⟩)
    isCategory.unit-l-◆ Category:Kleisli   = incl lem-1
    isCategory.unit-r-◆ Category:Kleisli   = incl lem-2
    isCategory.unit-2-◆ Category:Kleisli   = incl lem-2
    isCategory.assoc-l-◆ Category:Kleisli  = incl lem-3
    isCategory.assoc-r-◆ Category:Kleisli  = incl (lem-3 ⁻¹)
    isCategory._◈_ Category:Kleisli        = λ p q -> incl $ lem-4 ⟨ p ⟩ ⟨ q ⟩


  instance
    isFunctor:Kleisli : isFunctor 𝒞 (𝐊𝐥𝐬 T) incl
    isFunctor.map isFunctor:Kleisli              = λ x → incl (x ◆ pure)
    isFunctor.isSetoidHom:map isFunctor:Kleisli  = record { cong-∼ = λ x → incl (x ◈ refl) }
    isFunctor.functoriality-id isFunctor:Kleisli = incl unit-l-◆
    isFunctor.functoriality-◆ isFunctor:Kleisli  = {!!}





