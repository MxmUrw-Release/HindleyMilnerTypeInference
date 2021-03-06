
module Verification.Core.Theory.Std.Specific.FirstOrderTerm.Unification where

open import Verification.Conventions hiding (_โ_)

open import Verification.Core.Set.Discrete

open import Verification.Core.Algebra.Monoid.Definition

open import Verification.Core.Category.Std.Category.Subcategory.Full
open import Verification.Core.Computation.Unification.Definition

open import Verification.Core.Data.Universe.Definition
open import Verification.Core.Data.Universe.Instance.Category
open import Verification.Core.Data.Substitution.Variant.Base.Definition

open import Verification.Core.Data.List.Variant.Binary.Definition
open import Verification.Core.Data.List.Variant.Binary.Element.Definition
open import Verification.Core.Data.List.VariantTranslation.Definition
open import Verification.Core.Data.List.Dependent.Variant.Binary.Definition

open import Verification.Core.Theory.Std.Specific.FirstOrderTerm.Signature
open import Verification.Core.Theory.Std.Specific.FirstOrderTerm.Definition
open import Verification.Core.Theory.Std.Specific.FirstOrderTerm.Instance.RelativeMonad


module _ {๐ : ๐ฏFOSignature ๐} where

  postulate
    instance
      hasUnification:๐ฏโterm : hasUnification (โง๐๐ฎ๐๐ฌ๐ญ (๐ฏโterm ๐))

