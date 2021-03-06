
module Verification.Core.Category.Std.Category.Opposite.Strict.Definition where

open import Verification.Conventions

open import Verification.Core.Set.Setoid
open import Verification.Core.Category.Std.Category.Definition


-- | For a more general kind of example, consider an arbitrary category |๐|.
--   Then we can construct another category |๐ แตแต| which has the same objects
--   as |๐|, but where the direction of all arrows is reversed.

-- [Definition]
-- | There is a function [..], mapping a category to its opposite. It is defined as:
_แตแต : Category ๐ -> Category ๐
_แตแต ๐ = โฒ โจ ๐ โฉ โฒ {{Op}}
  where Op : isCategory โจ ๐ โฉ
        isCategory.Hom Op a b = Hom b a
        isCategory.isSetoid:Hom Op = isSetoid:Hom {{of ๐}}
        isCategory.id Op = id
        isCategory._โ_ Op f g = g โ f
        isCategory.unit-l-โ Op = unit-r-โ
        isCategory.unit-r-โ Op    = unit-l-โ       -- incl โจ unit-l-โ โฉ
        isCategory.unit-2-โ Op    = unit-2-โ       -- incl โจ unit-2-โ โฉ
        isCategory.assoc-l-โ Op   = assoc-r-โ      -- incl โจ assoc-r-โ โฉ
        isCategory.assoc-r-โ Op   = assoc-l-โ      -- incl โจ assoc-l-โ โฉ
        isCategory._โ_ Op (p) (q) = q โ p -- incl โจ incl q โ incl p โฉ

module _ {๐ : Category ๐} where
  แตแตแตแต : (๐ แตแต แตแต) โก-Str ๐
  แตแตแตแต = refl-โฃ
