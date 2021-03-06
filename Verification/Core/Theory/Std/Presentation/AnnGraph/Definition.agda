
module Verification.Core.Theory.Std.Presentation.AnnGraph.Definition where


open import Verification.Conventions
open import Verification.Core.Set.Function.Surjective
open import Verification.Core.Algebra.Monoid.Definition
open import Verification.Core.Data.Product.Definition
open import Verification.Core.Data.Sum.Definition
open import Verification.Core.Data.Sum.Instance.Functor
open import Verification.Core.Data.Universe.Definition
open import Verification.Core.Data.Universe.Instance.Category
open import Verification.Core.Category.Std.Category.Definition
open import Verification.Core.Category.Std.Functor.Definition


module _ {β¬ : Category π} (F : Functor β¬ (ππ§π’π― π)) where
  record isAnnGraph (E : π° π) (V : π° π) : π° (π ο½€ π ο½€ π) where
    constructor anngraph
    field bo : V -> β¨ β¬ β©
    field source : E -> β Ξ» v -> β¨ F β© (bo v)
    field target : E -> β Ξ» v -> β¨ F β© (bo v)

  open isAnnGraph {{...}} public

  AnnGraph : (E : π° π) -> _
  AnnGraph E = _ :& isAnnGraph E


module _ {β¬ : Category π} {F : Functor β¬ (ππ§π’π― π)} where

  module _ {E : π° π} where

    data UPath (π : AnnGraph F E) : (a b : β¨ π β©) -> π° (π ο½€ π ο½€ π) where
      [] : β{a} -> UPath π a a
      stepβ : β{a b c} -> (e : E) -> source e .fst β‘ a -> target e .fst β‘ b -> UPath π b c -> UPath π a c
      stepβ : β{a b c} -> (e : E) -> target e .fst β‘ a -> source e .fst β‘ b -> UPath π b c -> UPath π a c

    trans-UPath : β{π : AnnGraph F E} {a b c : β¨ π β©} -> (UPath π a b) -> UPath π b c -> UPath π a c
    trans-UPath = {!!}

    sym-UPath : β{π : AnnGraph F E} {a b : β¨ π β©} -> (UPath π a b) -> UPath π b a
    sym-UPath [] = []
    sym-UPath (stepβ e x xβ p) = {!!} -- stepβ e {!!} {!!} {!!}
    sym-UPath (stepβ e x xβ p) = {!!}

    isConnected : AnnGraph F E -> π° _
    isConnected π = β(a b : β¨ π β©) -> UPath π a b

    isContracted : AnnGraph F E -> π° _
    isContracted π = β(e : E) -> source e β‘ target e

    module _ (π β¬ : AnnGraph F E) where
      record isAnnHom (f : β¨ π β© -> β¨ β¬ β©) : π° (π ο½€ π ο½€ π) where
        field mapBo : β{v : β¨ π β©} -> bo v βΆ bo (f v)
        field compatSource : β{e : E} -> source e β‘ (f (fst (source e)) , map mapBo (snd (source e)))
        field compatTarget : β{e : E} -> target e β‘ (f (fst (target e)) , map mapBo (snd (target e)))

      AnnHom = _ :& isAnnHom

      open isAnnHom {{...}} public


    module Β§-AnnGraph where
      prop-2 : β{π β¬ : AnnGraph F E} -> (h : AnnHom π β¬) -> β{a b : β¨ π β©} -> (p : UPath π a b) -> UPath β¬ (β¨ h β© a) (β¨ h β© b)
      prop-2 h {a} {.a} [] = []
      prop-2 h {a} {b} (stepβ e p1 p2 r) = stepβ e
                                                 (trans-Path (cong fst compatSource) (cong β¨ h β© p1))
                                                 (trans-Path (cong fst compatTarget) (cong β¨ h β© p2))
                                                 (prop-2 h r)

      prop-2 h {a} {b} (stepβ e p1 p2 r) = stepβ e
                                                 (trans-Path (cong fst compatTarget) (cong β¨ h β© p1))
                                                 (trans-Path (cong fst compatSource) (cong β¨ h β© p2))
                                                 (prop-2 h r)

      prop-1 : β{π β¬ : AnnGraph F E} -> (h : AnnHom π β¬) -> {{_ : isSurjective-π° β¨ h β©}} -> isConnected π -> isConnected β¬
      prop-1 {π} {β¬} h πp a b = p3
        where
          p0 : UPath π (surj-π° a) (surj-π° b)
          p0 = πp _ _

          p1 : UPath β¬ (β¨ h β© (surj-π° a)) (β¨ h β© (surj-π° b))
          p1 = prop-2 h p0

          pair' : β¨ β¬ β© Γ-π° β¨ β¬ β©
          pair' = a , b

          q : (β¨ h β© (surj-π° a) , β¨ h β© (surj-π° b)) β‘ pair'
          q = congβ _,_ inv-surj-π° inv-surj-π°

          p3 : UPath β¬ a b
          p3 = transport (Ξ» i -> UPath β¬ (q i .fst) (q i .snd)) p1

      private
        infixl 40 _β:_
        _β:_ = trans-Path

      prop-4 : β{π : AnnGraph F E} -> isContracted π -> β(a b : β¨ π β©) -> UPath π a b -> a β‘ b
      prop-4 contr a .a [] = refl-β‘
      prop-4 contr a b (stepβ e p1 p2 r) = sym-Path p1 β: (cong fst (contr e)) β: p2 β: prop-4 contr _ _ r
      prop-4 contr a b (stepβ e p1 p2 r) = sym-Path p1 β: sym-Path (cong fst (contr e)) β: p2 β: prop-4 contr _ _ r

      prop-3 : β{π : AnnGraph F E} -> isConnected π -> isContracted π -> β(a b : β¨ π β©) -> a β‘ b
      prop-3 con contr a b = prop-4 contr a b (con a b)




