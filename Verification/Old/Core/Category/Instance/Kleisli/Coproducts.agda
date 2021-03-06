
module Verification.Old.Core.Category.Instance.Kleisli.Coproducts where

open import Verification.Conventions hiding (๐-elim)
open import Verification.Old.Core.Category.Definition
open import Verification.Old.Core.Category.Monad.Definition
open import Verification.Old.Core.Category.Instance.Kleisli.Definition
open import Verification.Old.Core.Category.Limit.Specific.Coproduct
open import Verification.Old.Core.Category.Limit.Specific.Initial

module _ {๐ : Category ๐} {T : Monad ๐} where
  -- [Lemma]
  -- | If |๐| has coproducts, i.e., [..], then |๐ โ T| has them as well.

  module _ {{_ : hasCoproducts ๐}} where
    instance
      hasCoproducts:๐โT : hasCoproducts (๐ โ T)
      (hasCoproducts:๐โT hasCoproducts.+ a) b = ` โจ a โฉ + โจ b โฉ `
      โจ isCoproduct.ฮนโ (hasCoproducts.isCoproduct:+ hasCoproducts:๐โT) โฉ = ฮนโ โ return
      โจ isCoproduct.ฮนโ (hasCoproducts.isCoproduct:+ hasCoproducts:๐โT) โฉ = ฮนโ โ return
      โจ isCoproduct.[_,_] (hasCoproducts.isCoproduct:+ hasCoproducts:๐โT) f g โฉ = [ โจ f โฉ , โจ g โฉ ]
      isCoproduct.reduce-+-โ (hasCoproducts.isCoproduct:+ hasCoproducts:๐โT) =
        let P : ฮนโ โ return โ map [ _ , _ ] โ join โฃ _
            P = {!!}
        in P
      isCoproduct.reduce-+-โ (hasCoproducts.isCoproduct:+ hasCoproducts:๐โT) = {!!}
      isCoproduct.expand-+ (hasCoproducts.isCoproduct:+ hasCoproducts:๐โT) = {!!}
  -- //

  module _ {{_ : hasInitial ๐}} where
    instance
      hasInitial:๐โT : hasInitial (๐ โ T)
      โจ hasInitial.๐ hasInitial:๐โT โฉ = ๐
      โจ isInitial.๐-elim (hasInitial.isInitial:๐ hasInitial:๐โT) b โฉ = ๐-elim _
      isInitial.expand-๐ (hasInitial.isInitial:๐ hasInitial:๐โT) f = expand-๐ _


