
module Verification.Old.Core.Syntax.Signature where

open import Verification.Conventions hiding (k)
open import Verification.Old.Core.Category
open import Verification.Old.Core.Order
open import Verification.Old.Core.Category.Monad
open import Verification.Old.Core.Category.Instance.Kleisli
open import Verification.Old.Core.Category.Instance.IdxSet
-- open import Verification.Unification.RecAccessible

module _ {K : π°β} where
  -- Symbol : π°β
  -- Symbol = β Ξ» (n : β) -> K Γ-π° (Vec K n)

  Signature : π°β
  Signature = {n : β} -> K -> Vec K n -> π°β

  data Term (s : Signature) (V : K -> π°β) (k : K) : π°β
  data Terms (Ο : Signature) (V : K -> π°β) : {n : β} (ks : Vec K n) -> π°β where
    [] : Terms Ο V []
    _β·_ : β{k} {ks : Vec K n} -> Term Ο V k -> Terms Ο V ks -> Terms Ο V (k β· ks)

  data Term Ο V k where
    te : β{ks : Vec K n} -> Ο k ks -> Terms Ο V ks -> Term Ο V k
    var : V k -> Term Ο V k

  data Termβ (s : Signature) (V : Maybe K -> π°β) : (k : Maybe K) -> π°β where
    none : Termβ s V nothing
    some : β{k} -> Term s (Ξ» k -> V (just k)) k -> Termβ s V (just k)

  Kβ = Maybe K


  module _ {Ο : Signature} where
    private
      variable k : K
               ks : Vec K n
               j : Kβ

    join-Term : β{V : K -> π°β} -> Term Ο (Term Ο V) k -> Term Ο V k

    join-Terms : β{V : K -> π°β} -> Terms Ο (Term Ο V) ks -> Terms Ο V ks
    join-Terms [] = []
    join-Terms (t β· ts) = join-Term t β· join-Terms ts

    join-Term (te a ts) = te a (join-Terms ts)
    join-Term (var t) = t

    β_ : (Kβ -> π°β) -> (K -> π°β)
    β_ V k = V (just k)


    join-Termβ' : β{V : Kβ -> π°β} -> Term Ο (β Termβ Ο V) k -> Term Ο (β V) k

    join-Termsβ : β{V : Kβ -> π°β} -> Terms Ο (β Termβ Ο V) ks -> Terms Ο (β V) ks
    join-Termsβ [] = []
    join-Termsβ (t β· ts) = join-Termβ' t β· join-Termsβ ts

    join-Termβ' (te t ts) = te t (join-Termsβ ts)
    join-Termβ' {k = k} (var (some x)) = x

    join-Termβ : β{V : Kβ -> π°β} -> Termβ Ο (Termβ Ο V) j -> Termβ Ο V j
    join-Termβ none = none
    join-Termβ (some t) = some (join-Termβ' t)

    map-Termβ : β{V W : Kβ -> π°β} -> (f : β k -> V k -> W k) -> Termβ Ο V j -> Termβ Ο W j
    map-Termβ f none = none
    map-Termβ f (some (te x xβ)) = {!!}
    map-Termβ f (some (var x)) = {!!}

{-

    private
      π : Category _
      π = ` IdxSet (Maybe K) ββ `

    Functor:Term : Functor π π
    β¨ β¨ Functor:Term β© X β© k = Termβ Ο β¨ X β© k
    of β¨ Functor:Term β© z = {!!}
    β¨ IFunctor.map (of Functor:Term) f β© k = map-Termβ β¨ f β©
    IFunctor.functoriality-id (of Functor:Term) = {!!}
    IFunctor.functoriality-β (of Functor:Term) = {!!}
    IFunctor.functoriality-β£ (of Functor:Term) = {!!}


    Monad:Term : Monad π
    β¨ Monad:Term β© = Functor:Term
    β¨ IMonad.return (of Monad:Term) β© nothing x = none
    β¨ IMonad.return (of Monad:Term) β© (just k) x = some (var x)
    β¨ IMonad.join (of Monad:Term) β© _ = join-Termβ
    IMonad.INatural:return (of Monad:Term) = {!!}
    IMonad.INatural:join (of Monad:Term) = {!!}
    IMonad.unit-l-join (of Monad:Term) = {!!}
    IMonad.unit-r-join (of Monad:Term) = {!!}
    IMonad.assoc-join (of Monad:Term) = {!!}

    data SigEdge : (a b : Maybe K) -> π°β where
      e-arg : β {k} {ks : Vec K n} -> (i : Fin-R n) -> Ο k ks -> SigEdge (just (lookup i ks)) (just k)
      e-noarg : β{k} -> Ο k [] -> SigEdge nothing (just k)

    π : Quiver β₯
    β¨ π β© = Maybe K
    IQuiver.Edge (of π) = SigEdge
    IQuiver._β_ (of π) = _β‘_
    IQuiver.IEquivInst (of π) = IEquiv:Path


    decomp : β{V : Kβ -> π°β} (k : Kβ) -> Termβ Ο V k -> V k +-π° (β(j : Kβ) -> SigEdge j k -> Maybe (Termβ Ο V j))
    decomp nothing none = right (Ξ» j ())
    decomp {V = V} (just k) (some (te t ts)) = right (f ts)
      where f : Terms Ο (β V) ks -> (j : Kβ) -> SigEdge j (just k) -> Maybe (Termβ Ο _ j)
            f xs .(just (lookup i _)) (e-arg i x) = {!!}
            f xs .nothing (e-noarg x) = {!!}
            -- f .(just (lookup i _)) (e-arg i x) = {!!}
            -- f .nothing (e-noarg x) = {!!}
    decomp (just k) (some (var v)) = left v

    -- RecAccessible:Term : IRecAccessible Monad:Term
    -- IRecAccessible.Dir RecAccessible:Term = of π
    -- IRecAccessible.ISet:Dir RecAccessible:Term = {!!}
    -- β¨ β¨ IRecAccessible.decompose RecAccessible:Term β© β© = decomp
    -- of IRecAccessible.decompose RecAccessible:Term = {!!}
    -- IRecAccessible.IMono:decompose RecAccessible:Term = {!!}
    -- IRecAccessible.wellfounded RecAccessible:Term = {!!}

{-

  -- π : Signature n -> Quiver β₯
  -- β¨ π {n} s β© = K
  -- IQuiver.Edge (of π s) = {!!}
  -- IQuiver._β_ (of π s) = {!!}
  -- IQuiver.IEquivInst (of π s) = {!!}





-}
-}


