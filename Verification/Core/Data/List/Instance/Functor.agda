
module Verification.Core.Data.List.Instance.Functor where

open import Verification.Conventions

open import Verification.Core.Set.Setoid
open import Verification.Core.Set.Contradiction
open import Verification.Core.Set.Decidable
open import Verification.Core.Set.Discrete
open import Verification.Core.Category.Std.Category.Definition
open import Verification.Core.Category.Std.Functor.Definition
open import Verification.Core.Data.AllOf.Universe


instance
  isFunctorList : isFunctor (𝐓𝐲𝐩𝐞 𝑖) (𝐓𝐲𝐩𝐞 𝑖) (List)
  isFunctor.map isFunctorList = map-List
  isFunctor.isSetoidHom:map isFunctorList = {!!}
  isFunctor.functoriality-id isFunctorList = {!!}
  isFunctor.functoriality-◆ isFunctorList = {!!}
