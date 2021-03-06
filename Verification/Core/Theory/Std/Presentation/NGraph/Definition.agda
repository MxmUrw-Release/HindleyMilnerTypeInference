
module Verification.Core.Theory.Std.Presentation.NGraph.Definition where


open import Verification.Conventions
open import Verification.Core.Set.Function.Surjective
open import Verification.Core.Algebra.Monoid.Definition
open import Verification.Core.Data.Product.Definition
open import Verification.Core.Data.Sum.Definition
open import Verification.Core.Data.List.Variant.Binary.Natural
open import Verification.Core.Data.Sum.Instance.Functor
open import Verification.Core.Data.Universe.Definition
open import Verification.Core.Data.Universe.Instance.Category
open import Verification.Core.Category.Std.Category.Definition
open import Verification.Core.Category.Std.Functor.Definition


module _ (N : π° π) (size : N -> δΊΊβ) where
  record isNGraph (V : π° π) : π° (π ο½€ π) where
    field node : V -> N
    field neigh : (v : V) -> [ size (node v) ]αΆ  -> V

  open isNGraph {{...}} public

  module _ {π : π} where
    NGraph = (π° π) :& isNGraph

  module _ {β¬ : Category π} (F : Functor β¬ (ππ§π’π― π)) where
    record isANG (G : NGraph {π}) : π° (π ο½€ π ο½€ π ο½€ π) where
      field bo : β¨ G β© -> β¨ β¬ β©
      field ann : (v : β¨ G β©) -> [ size (node v) ]αΆ  -> β¨ F β© (bo v)



    record isConstantANG (bβ : β¨ β¬ β©) (G : NGraph {π}) : π° (π ο½€ π ο½€ π ο½€ π) where
      -- field bβ : β¨ β¬ β©
      field ann : (v : β¨ G β©) -> [ size (node v) ]αΆ  -> β¨ F β© (bβ)

    open isConstantANG {{...}} public

    record TypingAnnotation (π : π) : π° (π ο½€ π ο½€ π ο½€ π βΊ) where
      field isOfType : (b : β¨ β¬ β©) -> (n : N) -> ([ size n ]αΆ  -> β¨ F β© b) -> π° π

    open TypingAnnotation public

    module _ {G : NGraph {π}} {bβ} {{_ : isConstantANG bβ G}} where
      record isContracted : π° (π ο½€ π ο½€ π ο½€ π) where
        field iscontr : β{v w : β¨ G β©}
                        -> (iv : [ size (node v) ]αΆ  )
                        -> (iw : [ size (node w) ]αΆ  )
                        -> neigh v iv β‘ w
                        -> neigh w iw β‘ v
                        -> ann v iv β‘ ann w iw

      open isContracted {{...}} public

      record isWellTyped (TA : TypingAnnotation πβ) : π° (π ο½€ πβ ο½€ π ο½€ π ο½€ π) where
        field hasType : (v : β¨ G β©) -> isOfType TA bβ _ (ann v)

      open isWellTyped {{...}} public

--   record isAnnGraph (E : π° π) (V : π° π) : π° (π ο½€ π ο½€ π) where
--     constructor anngraph
--     field bo : V -> β¨ β¬ β©
--     field source : E -> β Ξ» v -> β¨ F β© (bo v)
--     field target : E -> β Ξ» v -> β¨ F β© (bo v)

--   open isAnnGraph {{...}} public

--   AnnGraph : (E : π° π) -> _
--   AnnGraph E = _ :& isAnnGraph E





