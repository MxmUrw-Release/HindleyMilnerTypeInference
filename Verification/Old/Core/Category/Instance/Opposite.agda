
module Verification.Old.Core.Category.Instance.Opposite where

open import Verification.Conventions
open import Verification.Old.Core.Category.Definition

-- | For a more general kind of example, consider an arbitrary category |๐|.
--   Then we can construct another category |๐ แตแต| which has the same objects
--   as |๐|, but where the direction of all arrows is reversed.

-- [Definition]
-- | There is a function [..], mapping a category to its opposite. It is defined as:
_แตแต : Category ๐ -> Category ๐
โจ ๐ แตแต โฉ                         = โจ ๐ โฉ
isCategory.Hom (of ๐ แตแต) a b  = Hom {{of ๐}} b a

-- |> All equations for |๐ แตแต| can be proven by simply using their symmetric counterpart in $๐$.
isCategory._โฃ_        (of ๐ แตแต)  = _โฃ_
isCategory.isEquivRel:โฃ   (of ๐ แตแต)  = isEquivRel:โฃ
isCategory.id         (of ๐ แตแต)  = id
isCategory._โ_        (of ๐ แตแต)  = ฮป f g -> g โ f
isCategory._โ_        (of ๐ แตแต)  = ฮป p q -> q โ p
isCategory.unit-l-โ   (of ๐ แตแต)  = unit-r-โ
isCategory.unit-r-โ   (of ๐ แตแต)  = unit-l-โ
isCategory.unit-2-โ   (of ๐ แตแต)  = unit-2-โ
isCategory.assoc-l-โ  (of ๐ แตแต)  = assoc-r-โ
isCategory.assoc-r-โ  (of ๐ แตแต)  = assoc-l-โ
-- //
