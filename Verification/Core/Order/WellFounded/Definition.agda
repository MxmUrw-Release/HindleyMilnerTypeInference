
module Verification.Core.Order.WellFounded.Definition where

open import Verification.Core.Set.Induction.WellFounded
open import Verification.Core.Conventions


record isWF đ (A : đ° đ) : đ° (đ ïœ€ (đ âș)) where
  field _âȘ_ : A -> A -> đ° đ
  field wellFounded : WellFounded _âȘ_
open isWF {{...}} public

WF : (đ : đ ^ 2) -> đ° _
WF đ = (đ° (đ â 0)) :& isWF (đ â 1)

module _ {A : đ° đ} {{_ : isWF đ A}} where
  _âȘŁ_ : A -> A -> đ° _
  _âȘŁ_ a b = (a âĄ-Str b) +-đ° (a âȘ b)

record isWFT (A : WF đ) : đ° (đ) where
  field _âĄ-âȘ_ : â{a b c : âš A â©} -> a âȘ b -> b âȘ c -> a âȘ c

open isWFT {{...}} public

WFT : (đ : đ ^ 2) -> đ° _
WFT đ = (WF đ) :& isWFT

record isWFT0 (A : WFT đ) : đ° đ where
  field â„-WFT : âš A â©
  field initial-â„-WFT : â{a} -> â„-WFT âȘŁ a

open isWFT0 {{...}} public

WFT0 : (đ : đ ^ 2) -> đ° _
WFT0 đ = (WFT đ) :& isWFT0


