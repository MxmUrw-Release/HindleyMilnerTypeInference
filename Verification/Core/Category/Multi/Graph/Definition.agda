
module Verification.Core.Category.Multi.Graph.Definition where

open import Verification.Conventions
open import Verification.Core.Data.Fin.Definition
open import Verification.Core.Set.Finite.ReachableSubsets.Definition
open import Verification.Core.Category.Std.Category.Definition
open import Verification.Core.Data.Universe.Definition
open import Verification.Core.Data.Universe.Instance.Category
open import Verification.Core.Order.Preorder
open import Verification.Core.Order.Lattice


record isMultiGraph (๐ : ๐) (G : ๐ฐ ๐) : ๐ฐ (๐ ๏ฝค ๐ โบ) where
  field Edgeแต : โ{n : โ} -> (๐ฝสณ n -> G) -> G -> ๐ฐ ๐

open isMultiGraph {{...}} public

MultiGraph : (๐ : ๐ ^ 2) -> _
MultiGraph ๐ = ๐ฐ (๐ โ 0) :& isMultiGraph (๐ โ 1)



