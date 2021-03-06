
module Verification.Core.Data.State.Definition where

open import Verification.Conventions
open import Verification.Core.Data.Product.Everything
open import Verification.Core.Data.Sum.Definition
open import Verification.Core.Data.Universe.Definition
open import Verification.Core.Data.Universe.Instance.Category
open import Verification.Core.Category.Std.Category.Definition
open import Verification.Core.Category.Std.Functor.Definition
open import Verification.Core.Category.Std.Monad.Definition
open import Verification.Core.Category.Std.Monad.TypeMonadNotation


module _ (T : Monad (ππ§π’π― π)) where
  record StateTα΅ (A : π° π) (B : π° π) : π° (π) where
    constructor stateT
    field runStateT : A -> β¨ T β© (A Γ B)

  open StateTα΅ public

  module _ (A : π° π) where
    macro StateT = #structureOn (StateTα΅ A)

module _ {T : Monad (ππ§π’π― π)} where
  private
    isFunctor:T : isFunctor (ππ§π’π― π) (ππ§π’π― π) β¨ T β©
    isFunctor:T = it

  module _ {s : π° π} where
    map-StateT : β{a b : π° π} (f : a -> b) -> StateT T s a -> StateT T s b
    map-StateT f (stateT x) = stateT (map {{isFunctor:T}} (map (id , f)) β x)

    instance
      isFunctor:StateT : isFunctor (ππ§π’π― π) (ππ§π’π― π) (StateT T s )
      isFunctor.map isFunctor:StateT = map-StateT
      isFunctor.isSetoidHom:map isFunctor:StateT = {!!}
      isFunctor.functoriality-id isFunctor:StateT = {!!}
      isFunctor.functoriality-β isFunctor:StateT = {!!}

    pure-StateT : β{a : π° π} -> a -> StateT T s a
    pure-StateT a = stateT (Ξ» s β pure (s , a))

    join-StateT : β{a : π° π} -> StateT T s (StateT T s a) -> StateT T s a
    join-StateT (stateT f) = stateT (Ξ» x β do x2 , (stateT f2) <- f x ; f2 x2)

    instance
      isMonad:StateT : isMonad (StateT T s)
      isMonad.pure isMonad:StateT = pure-StateT
      isMonad.join isMonad:StateT = join-StateT
      isMonad.isNatural:pure isMonad:StateT = {!!}
      isMonad.isNatural:join isMonad:StateT = {!!}
      isMonad.unit-l-join isMonad:StateT = {!!}
      isMonad.unit-r-join isMonad:StateT = {!!}
      isMonad.assoc-join isMonad:StateT = {!!}

    get : StateT T s s
    get = stateT (Ξ» s β pure (s , s))

    put : β{b} -> b -> StateT T s b
    put b = stateT (Ξ» s β pure (s , b))

    liftStateT : β{b} -> β¨ T β© b -> StateT T s b
    liftStateT b = stateT (Ξ» s β do b <- b ; return (s , b))



