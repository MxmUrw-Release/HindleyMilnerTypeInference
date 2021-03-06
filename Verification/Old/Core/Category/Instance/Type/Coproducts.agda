
module Verification.Old.Core.Category.Instance.Type.Coproducts where

open import Verification.Conventions
open import Verification.Old.Core.Category.Definition
open import Verification.Old.Core.Category.Instance.Type.Definition
open import Verification.Old.Core.Category.Limit.Specific
-- open import Verification.Old.Core.Category.Instance.Functor
-- open import Verification.Old.Core.Category.Functor.Adjunction
-- open import Verification.Old.Core.Category.Limit.Kan.Definition
-- open import Verification.Old.Core.Category.Limit.Kan.Terminal
-- open import Verification.Old.Core.Category.Limit.Kan.Equalizer
-- open import Verification.Old.Core.Category.Limit.Definition
-- open import Verification.Old.Core.Category.Limit.Product
-- open import Verification.Old.Core.Category.Limit.Equalizer
-- open import Verification.Old.Core.Category.Monad
-- open import Verification.Old.Core.Category.Instance.SmallCategories
-- open import Verification.Old.Core.Category.FreeCategory
-- open import Verification.Old.Core.Category.Quiver
-- open import Verification.Old.Core.Category.Instance.Set.Definition
-- open import Verification.Old.Core.Category.Lift
-- open import Verification.Old.Core.Homotopy.Level

-- open import Verification.Old.Core.Category.Instance.Set.Definition

-- _+-๐ฐ_ : Set ๐ -> Set ๐ -> Set (๐ ๏ฝค ๐)
-- โจ A +-๐ฐ B โฉ = โจ A โฉ +-๐ฐ โจ B โฉ
-- IHType.hlevel (of (A +-Set B)) = {!!}

instance
  hasCoproducts:๐ฐ : โ{๐ : ๐} -> hasCoproducts (` ๐ฐ ๐ `)
  hasCoproducts._+_ hasCoproducts:๐ฐ = _+-๐ฐ_
  isCoproduct.ฮนโ (hasCoproducts.isCoproduct:+ hasCoproducts:๐ฐ) = {!!}
  isCoproduct.ฮนโ (hasCoproducts.isCoproduct:+ hasCoproducts:๐ฐ) = {!!}
  isCoproduct.[_,_] (hasCoproducts.isCoproduct:+ hasCoproducts:๐ฐ) = {!!}
  isCoproduct.reduce-+-โ (hasCoproducts.isCoproduct:+ hasCoproducts:๐ฐ) = {!!}
  isCoproduct.reduce-+-โ (hasCoproducts.isCoproduct:+ hasCoproducts:๐ฐ) = {!!}
  isCoproduct.expand-+ (hasCoproducts.isCoproduct:+ hasCoproducts:๐ฐ) = {!!}

