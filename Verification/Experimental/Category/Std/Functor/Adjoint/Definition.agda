
module Verification.Experimental.Category.Std.Functor.Adjoint.Definition where

open import Verification.Conventions

open import Verification.Experimental.Set.Setoid.Morphism
open import Verification.Experimental.Set.Setoid.Definition
open import Verification.Experimental.Category.Std.Category.Definition
open import Verification.Experimental.Category.Std.Category.Instance.Category
open import Verification.Experimental.Category.Std.Functor.Definition
open import Verification.Experimental.Category.Std.Natural.Definition
open import Verification.Experimental.Category.Std.Category.Notation.Associativity


module _ {𝒞 : Category 𝑖} {𝒟 : Category 𝑗} where
  record isAdjoint (F : Functor 𝒞 𝒟) (G : Functor 𝒟 𝒞) : 𝒰 (𝑖 ､ 𝑗) where
    field adj    : ∀{a : ⟨ 𝒟 ⟩} -> ⟨ F ⟩ (⟨ G ⟩ a) ⟶ a
    field coadj  : ∀{a : ⟨ 𝒞 ⟩} -> a ⟶ ⟨ G ⟩ (⟨ F ⟩ a)
    field {{isNatural:adj}} : isNatural (G ◆-𝐂𝐚𝐭 F) id adj
    field {{isNatural:coadj}} : isNatural id (F ◆-𝐂𝐚𝐭 G) coadj
    field reduce-coadj : ∀{b : ⟨ 𝒟 ⟩}  -> coadj ◆ map adj ∼ id {a = ⟨ G ⟩ b}
    field reduce-adj : ∀{a : ⟨ 𝒞 ⟩}    -> map coadj ◆ adj ∼ id {a = ⟨ F ⟩ a}

  open isAdjoint {{...}} public

  _⊣_ = isAdjoint


  module _ {F : Functor 𝒞 𝒟} {G : Functor 𝒟 𝒞} {{_ : isAdjoint F G}} where

    -- |> For any two objects [..] and [..],
    module _ {a : ⟨ 𝒞 ⟩} {b : ⟨ 𝒟 ⟩} where

      -- |> we have an isomorphism between hom-types as follows:
      free : (a ⟶ ⟨ G ⟩ b) -> (⟨ F ⟩ a ⟶ b)
      free f = map f ◆ adj

      -- | The inverse direction is given by:
      cofree : (⟨ F ⟩ a ⟶ b) -> (a ⟶ ⟨ G ⟩ b)
      cofree f = coadj ◆ map f

      inv-free : ∀{f} -> free (cofree f) ∼ f
      inv-free {f} =
        map (coadj ◆ (map f)) ◆ adj      ⟨ functoriality-◆ ◈ refl ⟩-∼
        map coadj ◆ map (map f) ◆ adj    ⟨ assoc-l-◆ ⟩-∼
        map coadj ◆ (map (map f) ◆ adj)  ⟨ refl ◈ naturality f ⁻¹ ⟩-∼
        map coadj ◆ (adj ◆ f)            ⟨ assoc-r-◆ ⟩-∼
        (map coadj ◆ adj) ◆ f            ⟨ reduce-adj ◈ refl ⟩-∼
        id ◆ f                           ⟨ unit-l-◆ ⟩-∼
        f                                ∎

      inv-cofree : ∀{f} -> cofree (free f) ∼ f
      inv-cofree {f} = {!!}

      cong-∼-free : ∀{f g} -> f ∼ g -> free f ∼ free g
      cong-∼-free p = p
        ⟪ cong-∼ ⟫
        ⟪ (_◈ refl) ⟫

      cong-∼-cofree : ∀{f g} -> f ∼ g -> cofree f ∼ cofree g
      cong-∼-cofree p = p
        ⟪ cong-∼ ⟫
        ⟪ (refl ◈_) ⟫

      cancel-injective-free : ∀{f g} -> free f ∼ free g -> f ∼ g
      cancel-injective-free p = p
        ⟪ cong-∼-cofree ⟫
        ⟪ inv-cofree ≀∼≀ inv-cofree ⟫

      cancel-injective-cofree : ∀{f g} -> cofree f ∼ cofree g -> f ∼ g
      cancel-injective-cofree p = p
        ⟪ cong-∼-free ⟫
        ⟪ inv-free ≀∼≀ inv-free ⟫

      -- isSetoidHom:free : isSetoidHom ′(a ⟶ ⟨ G ⟩ b)′ ′(⟨ F ⟩ a ⟶ b)′ free
      -- isSetoidHom:free = record { cong-∼ = {!!} }

      -- isSetoidHom:cofree : isSetoidHom ′(⟨ F ⟩ a ⟶ b)′ ′(a ⟶ ⟨ G ⟩ b)′ cofree
      -- isSetoidHom:cofree = record { cong-∼ = {!!} }

      -- isInjective:free : isInjective free
      -- isInjective:free = record { cancel-injective = {!!} }

      -- isInjective:cofree : isInjective cofree
      -- isInjective:cofree = record { cancel-injective = {!!} }

