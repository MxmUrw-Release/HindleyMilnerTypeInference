
module Verification.Core.Category.Std.Limit.Specific.Coequalizer.Definition where

open import Verification.Conventions
open import Verification.Core.Set.Setoid
open import Verification.Core.Category.Std.Category.Definition
open import Verification.Core.Category.Std.Morphism.EpiMono

-- [Hide]
module _ {X : 𝒰 𝑖} {{_ : isCategory {𝑗} X}} where
  LiftU : (X -> 𝒰 𝑘) -> (Obj ′ X ′ -> 𝒰 𝑘)
  LiftU P o = P ⟨ o ⟩
-- //

-- | Let [..] [] be a category.
module _ {X : 𝒰 𝑖} {{_ : isCategory {𝑗} X}} where

  -- [Definition]
  -- | Something
  record isCoequalizer {a b : X} (f g : a ⟶ b) (x : X) : 𝒰 (𝑖 ､ 𝑗) where
    field π₌ : b ⟶ x
          equate-π₌ : f ◆ π₌ ∼ g ◆ π₌
          compute-Coeq : ∀{c : X} -> (h : b ⟶ c) -> (p : f ◆ h ∼ g ◆ h) -> ∑ λ (ξ : x ⟶ c) -> π₌ ◆ ξ ∼ h
          {{isEpi:π₌}} : isEpi π₌


    ⦗_⦘₌ : ∀{c : X} -> (∑ λ (h : b ⟶ c) -> (f ◆ h ∼ g ◆ h)) -> x ⟶ c
    ⦗_⦘₌ (h , p) = fst (compute-Coeq h p)
    reduce-π₌ : ∀{c : X} -> {h : b ⟶ c} -> {p : f ◆ h ∼ g ◆ h} -> π₌ ◆ ⦗ h , p ⦘₌ ∼ h
    reduce-π₌ {h = h} {p} = snd (compute-Coeq h p)

  open isCoequalizer {{...}} public
  -- //

  -- [Hide]

  hasCoequalizer : {a b : X} (f g : a ⟶ b) -> 𝒰 _
  hasCoequalizer f g = _ :& LiftU (isCoequalizer f g)


  ----------------------------------------------------------
  -- Coequalizer without uniqueness
  record isCoequalizerCandidate {a b : X} (f g : a ⟶ b) (x : X) : 𝒰 (𝑖 ､ 𝑗) where
    field π₌? : b ⟶ x
          equate-π₌? : f ◆ π₌? ∼ g ◆ π₌?

  open isCoequalizerCandidate {{...}} public

  hasCoequalizerCandidate : {a b : X} (f : HomPair a b) -> 𝒰 _
  hasCoequalizerCandidate (f , g) = _ :& LiftU (isCoequalizerCandidate f g)


record hasCoequalizers (𝒞 : Category 𝑖) : 𝒰 𝑖 where
  field Coeq : ∀{a b : ⟨ 𝒞 ⟩} (f g : a ⟶ b) -> ⟨ 𝒞 ⟩
  field {{isCoequalizer:Coeq}} : ∀{a b : ⟨ 𝒞 ⟩} {f g : a ⟶ b} -> isCoequalizer f g (Coeq f g)

open hasCoequalizers {{...}} public
-- //
