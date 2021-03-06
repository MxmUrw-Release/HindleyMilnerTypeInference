
module Verification.Old.Core.Syntax.SignatureZ2 where

open import Verification.Conventions hiding (k)
open import Verification.Old.Core.Category
open import Verification.Old.Core.Order
open import Verification.Old.Core.Category.Monad
open import Verification.Old.Core.Category.Instance.Kleisli
open import Verification.Old.Core.Category.Instance.IdxSet
open import Verification.Old.Core.Category.Limit.Specific
open import Verification.Old.Core.Category.Limit.Kan
-- open import Verification.Unification.RecAccessible


module _ {K : π°β} where
  -- Symbol : π°β
  -- Symbol = β Ξ» (n : β) -> K Γ-π° (Vec K n)

  β : (K -> π°β) -> (K -> π°β)
  β V k = Lift π-π° +-π° V k

  Signature : π°β
  Signature = {n : β} -> K -> Vec K (suc n) -> π°β

  isInhabited-Sig : Signature -> π°β
  isInhabited-Sig Ο = β k -> β Ξ» n -> β Ξ» (ks : Vec K (suc n)) -> Ο k ks

  data Term (Ο : Signature) (V : K -> π°β) (k : K) : π°β
  data Terms (Ο : Signature) (V : K -> π°β) : {n : β} (ks : Vec K n) -> π°β where
    [] : Terms Ο V []
    _β·_ : β{k} {ks : Vec K n} -> Term Ο V k -> Terms Ο V ks -> Terms Ο V (k β· ks)

  data Term Ο V k where
    te : β{ks : Vec K (suc n)} -> Ο k ks -> Terms Ο V ks -> Term Ο V k
    var : V k -> Term Ο V k

  module _ {Ο : Signature} {V : K -> π°β} where
    join-Term : {k : K} -> Term Ο (Term Ο V) k -> Term Ο V k

    join-Terms : {ks : Vec K n} -> Terms Ο (Term Ο V) ks -> Terms Ο V ks
    join-Terms [] = []
    join-Terms (t β· ts) = join-Term t β· join-Terms ts

    join-Term (te t ts) = te t (join-Terms ts)
    join-Term (var x) = x

  module _ (Ο : Signature) where
    IdxTerm : IdxSet K ββ -> IdxSet K ββ
    β¨ IdxTerm V β© = Term Ο β¨ V β©
    of (IdxTerm V) = {!!}

  module _ {Ο : Signature} where
    instance
      IdxSet:IdxTerm : {A : K -> π°β} -> {{_ : IIdxSet K A}} -> IIdxSet K (Term Ο A)
      IdxSet:IdxTerm {A} {{_}} = of IdxTerm Ο ` A `

  instance
    IdxSet:IdxTermβ : {A : K -> π°β} -> {{_ : IIdxSet K A}} -> IIdxSet K (β A)
    IdxSet:IdxTermβ {A} = of _+-IdxSet_ π ` A `
  -- = #openstruct IdxTerm


  module _ {Ο : Signature} {V W : K -> π°β} where
    map-Term : {k : K} -> (β{k} -> V k -> W k) -> Term Ο V k -> Term Ο W k

    map-Terms : {ks : Vec K n} -> (β{k} -> V k -> W k) -> Terms Ο V ks -> Terms Ο W ks
    map-Terms f [] = []
    map-Terms f (t β· ts) = map-Term f t β· map-Terms f ts

    map-Term f (te s ts) = te s (map-Terms f ts)
    map-Term f (var x) = var (f x)

  private
    π : Category _
    π = Category:IdxSet K ββ

  module _ (Ο : Signature) where
    Functor:Term : Functor π π
    β¨ Functor:Term β© X = IdxTerm Ο X
    -- β¨ β¨ Functor:Term β© X β© = Term Ο β¨ X β©
    -- IIdxSet.ISet:this (of β¨ Functor:Term β© z) = {!!}
    β¨ IFunctor.map (of Functor:Term) f β© = map-Term β¨ f β©
    IFunctor.functoriality-id (of Functor:Term) = {!!}
    IFunctor.functoriality-β (of Functor:Term) = {!!}
    IFunctor.functoriality-β£ (of Functor:Term) = {!!}

    Monad:Term : Monad π
    β¨ Monad:Term β© = Functor:Term
    β¨ IMonad.return (of Monad:Term) β© x = (var x)
    β¨ IMonad.join (of Monad:Term) β© = join-Term
    IMonad.INatural:return (of Monad:Term) = {!!}
    IMonad.INatural:join (of Monad:Term) = {!!}
    IMonad.unit-l-join (of Monad:Term) = {!!}
    IMonad.unit-r-join (of Monad:Term) = {!!}
    IMonad.assoc-join (of Monad:Term) = {!!}


    Functor:TermZ2 = Functor:EitherT π (Monad:Term)
    Monad:TermZ2 = Monad:EitherT π (Monad:Term)

    TermZ2 : (V : K -> π°β) -> K -> π°β
    TermZ2 V k = Term Ο (β V) k

    IdxTermZ2 : (V : IdxSet K ββ) -> IdxSet K ββ
    IdxTermZ2 V = IdxTerm Ο (π + V)

    TermsZ2 : (V : K -> π°β) -> (Vec K n) -> π°β
    TermsZ2 V ks = Terms Ο (β V) ks

  module _ {Ο : Signature} {V W : IdxSet K ββ} where
    map-TermZ2 : {k : K} -> (V βΆ W) -> TermZ2 Ο β¨ V β© k -> TermZ2 Ο β¨ W β© k
    map-TermZ2 {k} f = β¨ map {{of Functor:TermZ2 Ο}} f β© {k}

    map-TermsZ2 : {ks : Vec K n} -> (V βΆ W) -> TermsZ2 Ο β¨ V β© ks -> TermsZ2 Ο β¨ W β© ks
    map-TermsZ2 f = map-Terms (β¨ map-+-r {c = π} f β© {_})

  module _ {Ο : Signature} {V : IdxSet K ββ} where
    join-TermZ2 : {k : K} -> TermZ2 Ο (TermZ2 Ο β¨ V β©) k -> TermZ2 Ο β¨ V β© k
    join-TermZ2 {k} x = β¨ join {{of Monad:TermZ2 Ο}} {A = V} β© {k} x


