
{-# OPTIONS --cubical --allow-unsolved-metas --no-import-sorts #-}

module Verification.Old.Core.Category.Instance.SetProperties where

open import Verification.Conventions
open import Verification.Old.Core.Category.Definition
open import Verification.Old.Core.Category.Functor
open import Verification.Old.Core.Category.Adjunction
open import Verification.Old.Core.Category.KanLimit.Definition2
-- open import Verification.Old.Core.Category.Limit.Definition
-- open import Verification.Old.Core.Category.Limit.Product
-- open import Verification.Old.Core.Category.Limit.Equalizer
-- open import Verification.Old.Core.Category.Monad
open import Verification.Old.Core.Category.Instance.Type
open import Verification.Old.Core.Category.Instance.Cat
open import Verification.Old.Core.Category.FreeCategory
open import Verification.Old.Core.Category.Quiver
open import Verification.Old.Core.Category.Instance.Set.Definition
open import Verification.Old.Core.Category.Lift
open import Verification.Old.Core.Homotopy.Level


--------------------------------------------------------------------
-- Equalizers

data Pair : π°β where
  β β : Pair


data PairHom : Pair -> Pair -> π°β where
  arrβ : PairHom β β
  arrβ : PairHom β β

Quiver:Pair : Quiver (many ββ)
β¨ Quiver:Pair β© = Pair
IQuiver.Edge (of Quiver:Pair) = PairHom
-- IQuiver.Edge (of Quiver:Pair) β β = β₯
-- IQuiver.Edge (of Quiver:Pair) β β = π-π°
-- IQuiver.Edge (of Quiver:Pair) β b = β₯
IQuiver._β_ (of Quiver:Pair) = _β‘_
IQuiver.IEquivInst (of Quiver:Pair) = IEquiv:Path

Category:Pair = Category:Free (Quiver:Pair)

instance
  ICategory:Pair = of Category:Pair

-- instance
--   Index-Notation:Diagram : β{S : Quiver (ββ , ββ , ββ)} {X : Category π} -> Index-Notation ((β Category:Free S) βΆ X)
--                                                                                            (β¨ S β© Γ-π° β¨ S β©)
--                                                                                            (IAnything)
--                                                                                            (Ξ» (D , (a , b)) -> Edge {{of S}} a b -> Hom (β¨ D β© (lift a)) (β¨ D β© (lift b)))
--   (Index-Notation:Diagram Index-Notation.β D) (a , b) e = map (lift (some (last e)))


record _=?=-Set_ {A : Set π} {B : Set π} (f g : HTypeHom A B) : π° (π ο½€ π) where
  constructor _,_
  field fst : β¨ A β©
        snd : β¨ f β© fst β‘ β¨ g β© fst
        -- {{Set:B}} : IHType 2 β¨ B β©
open _=?=-Set_ public

-- _S,_ : {A : Set π} {B : Set π} {f g : HTypeHom A B} -> (a : β¨ A β©) -> (p : β¨ f β© a β‘ β¨ g β© a) -> f =?=-Set g
-- _S,_ {B = B} a p = _,_ a p {{of B}}

_Set:=?=-Set_ : {A : Set π} {B : Set π} -> (f g : HTypeHom A B) -> Set (π ο½€ π)
β¨ f Set:=?=-Set g β© = f =?=-Set g
of (f Set:=?=-Set g) = {!!}


-- _=?=-Set_ : {A : Set π} {B : Set π} -> (f g : HTypeHom A B) -> Set (π ο½€ π)
-- β¨ f =?=-Set g β© = β Ξ» a -> β¨ f β© a β‘ β¨ g β© a
-- IHType.hlevel (of (_=?=-Set_  {A = A} {B} f g)) = isOfHLevelΞ£ 2 (hlevel {{of A}}) (Ξ» x -> isOfHLevelSuc 1 (hlevel {{of B}} _ _))


byFirst1 : {A : Set π} {B : Set π} -> {f g : HTypeHom A B} -> {a b : f =?=-Set g} -> fst a β‘ fst b -> a β‘ b
byFirst1 {A = A}{B}{f}{g}{a}{b} p i = p i , isSetβisSet' (hlevel {{of B}}) (snd a) (snd b) (cong β¨ f β© (p)) (cong β¨ g β© (p)) i

-- instance
--   Cast:SigmaEq : β{π π : π} {A : Set π} {B : Set π} -> {f g : HTypeHom A B} -> {a b : f =?=-Set g} -> Cast (fst a β‘ fst b) IAnything (a β‘ b)
--   Cast.cast Cast:SigmaEq p = byFirst1 p


-- {β¨ f β© (fst a)} {β¨ g β© (fst a)} {β¨ f β© (fst b)} {β¨ g β© (fst b)} ? ? ? ? i
-- byFirst1 {A = A}{B}{f}{g}{a}{b} p i = p i , isSetβisSet' (hlevel {{of B}}) {β¨ f β© (fst a)} {β¨ g β© (fst a)} {β¨ f β© (fst b)} {β¨ g β© (fst b)} ? ? ? ? i

-- byFirst0 : {A : Set π} {B : Set π} -> {f g : HTypeHom A B} -> {a : β¨ A β©} -> {b1 b2 : β¨ f β© a β‘ β¨ g β© a} -> PathP (Ξ» i -> f =?=-Set g) (a , b1) (a , b2)
-- byFirst0 {B = B} {f} {g} {a} {b1} {b2} i = _ , hlevel {{of B}} _ _ b1 b2 i
-- byFirst1 p = {!!}


-- instance
--   setinstance : β{A : π° π} -> {F : A -> Set π} -> β{a : A} -> ISet (β¨ F a β©)
--   setinstance {F = F} {a = a} = of (F a)

byfirst : β{A : π° π} {B : A -> π° π} -> β{a1 : A} -> {b1 : B a1} {b2 : B a1} -> (isOfHLevel 1 (B a1)) -> PathP (Ξ» i -> β Ξ» (a : A) -> B a) (a1 , b1) (a1 , b2)
byfirst {b1 = b1} {b2} lev i = _ , lev b1 b2 i



byfirst2 : β{A : π° π} {B : A -> π° π} -> β{a1 : A} -> {b1 : B a1} {b2 : B a1} -> {{_ : IHType 1 (B a1)}} -> PathP (Ξ» i -> β Ξ» (a : A) -> B a) (a1 , b1) (a1 , b2)
byfirst2 {b1 = b1} {b2} {{lev}} i = _ , (hlevel {{lev}}) b1 b2 i

-- testttt = cong2

funExtSet : β{A : Set π} {B : Set π} -> {f g : HTypeHom A B} -> (β(a : β¨ A β©) -> {{_ : IHType 2 β¨ B β©}} -> β¨ f β© a β‘ β¨ g β© a) -> HTypeHomEq f g
β¨ funExtSet p β© = Ξ» i x -> p x i
of funExtSet p = record {}

-- explicitArgs : β{A : π° π} {B : π° π} {C : π° π} {D : π° π} -> (f : )

module _ where
  private
    L : Functor (β© (β Category:Pair βΆ β© Set π)) (β© (π βΆ β© Set π))
    β¨ L {π} β© F = free-Diagram-Lift f
      where f : QuiverHom (β© β€) (ForgetCategory (β© Set _))
            β¨ f β© _ = ((map {{of F}} (β₯ ` arrβ `)) Set:=?=-Set (map {{of F}} (β₯ ` arrβ `)))
              -- where instance _ = of (β¨ F β© (β₯ β))
              --                _ = of (β¨ F β© (β₯ β))
            -- β Ξ» (x : β¨ β¨ F β© (β₯ β) β©) -> (F β (β , β)) β x β‘ (F β (β , β)) β x
            IQuiverHom.qmap (of f) e = β Ξ» x -> x
    IFunctor.map (of L) Ξ± = free-Diagram-Nat f (Ξ» {()})
      where f = Ξ» {_ -> β Ξ» {(x , xp) -> β¨ β¨ Ξ± β© β© x , let P : β¨ (β¨ Ξ± β© β map _) β© x β‘ β¨ (β¨ Ξ± β© β map _) β© x
                                                           P = ((naturality _ x)) β cong β¨ β¨ Ξ± β© β© xp β ( (naturality _ x β»ΒΉ))
                                                           -- P = (cong (Ξ» ΞΎ -> ΞΎ $ x) (naturality _ x)) β cong β¨ β¨ Ξ± β© β© xp β (cong (Ξ» ΞΎ -> ΞΎ $ x) (naturality _ β»ΒΉ))
                                                        in P}}
      -- where f = Ξ» {_ (x , xp) -> β¨ Ξ± β© x , let P : β¨ Ξ± β© β map _ β‘ β¨ Ξ± β© β map _
      --                                          P = naturality _ β {!!}
      --                                      in cong (_$ x) P}
    IFunctor.functoriality-id (of L) {a = a} Ξ± _ = byFirst1 refl --funExt (Ξ» _ -> byFirst1 refl)
    -- funExt (Ξ» {(x , xp) -> byfirst (targethlevel {{of (map Ξ±)}} _ _) }) -- {{of β¨ a β© (β₯ β)}}
    -- x , hlevel {{of β¨ a β© (β₯ β)}} _ _ _ _ i}) -- ({!!} , {!!})
    IFunctor.functoriality-β (of L) {a = a} {b} {c} x _ = byFirst1 refl -- funExt (Ξ» _ -> byFirst1 refl) -- funExt (Ξ» _ -> byfirst (hlevel {{of β¨ c β© (β₯ β)}} _ _))
    IFunctor.functoriality-β£ (of L) p _ x = byFirst1 (p _ (fst x))


    π« : β{π} -> Category π
    π« = β Category:Pair

    -- FG = Functor:comp-Cat L (! π« *)


    Ξ΅ : β(x : (π«) βΆ ` Set π `) -> β(a : Pair)
        -> (β¨ β¨ ! π« * β© (β¨ L β© x) β© (β₯ a)) βΆ β¨ x β© (β₯ a)
    Ξ΅ x β = β Ξ» (a , p) -> a
    Ξ΅ x β = β Ξ» (a , p) -> β¨ map {{of x}} (` arrβ `) β© a -- ((x β (β , β)) β)β© a

    Ξ΅p : β{π} -> β(x : π« βΆ (β© Set π)) -> β{a b : Pair} -> (e : Edge {{of Quiver:Pair}} a b)
        -> Ξ΅ x a β map (` e `) β£ map {{of (β¨ ! π« * β© (β¨ L β© x))}} {a = β₯ a} {b = β₯ b} (` e `) β Ξ΅ x b
        -- (β¨ β¨ ! (β Category:Pair) * β© (β¨ L β© x) β© (β₯ a)) βΆ β¨ x β© (β₯ a)
    Ξ΅p x {β} {β} arrβ _ = refl
    Ξ΅p x {β} {β} arrβ (y , yp) =  let -- P : ? fst (β¨ map {{of x}} (β₯ ` β `) β© (y , yp)) β‘ ?
                                      P : (β¨ map {{of x}} (` arrβ `) β© y) β‘ (β¨ map {{of x}} (` arrβ `) β© y)
                                      P = yp β»ΒΉ
                                  in P

    Ξ΅' : β(x : π« βΆ ` Set π `) -> Natural (β¨ ! π« * β© (β¨ L β© x)) x
    Ξ΅' x = free-Diagram-Nat (Ξ΅ x) (Ξ΅p x)

    -- Ξ΅2 : β{π : π} -> β{a b : Pair}
    --     -> β(g : Edge a b) -> β(x : (β Category:Pair) βΆ (Category:Set π)) -> β€ -- β(e : ) -- (β¨ β¨ ! (β Category:Pair) * β© (β¨ L β© x) β© (β₯ a)) βΆ β¨ x β© (β₯ a)
    -- Ξ΅2 = {!!}

    Ξ· : β(x : π βΆ ` Set π `) -> β(a : β€)
        -> β¨ x β© (β₯ a) βΆ (β¨ β¨ L β© (β¨ ! π« * β© x) β© (β₯ a))
    Ξ· _ = Ξ» _ -> β Ξ» {a -> (a , refl)}

    Ξ·' : β(x : π βΆ ` Set π `) -> Natural x (β¨ L β© (β¨ ! π« * β© x))
    Ξ·' x = free-Diagram-Nat (Ξ· x) (Ξ» {()})


    lem::1 : (! (β Category:Pair) *) β£ L {π = π}
    β¨ IAdjoint.embed lem::1 β© {x = x} = Ξ·' x -- free-Diagram-Nat (Ξ· x) 
      -- where f = Ξ» _ -> β Ξ» {a -> (a , refl)}
      --       fp = Ξ» {()}
    INatural.naturality (of IAdjoint.embed lem::1) f x _ = byFirst1 refl -- funExt (Ξ» {_ -> byFirst1 refl})
    β¨ IAdjoint.eval lem::1 β© {x = x} = Ξ΅' x
    -- free-Diagram-Nat (Ξ΅ x) (Ξ΅p x) -- (Ξ΅p x) --  (Ξ» {{a = β} {b = β} β -> {!!};
    --                                                           {β} {β} β -> ?})
    --   where f = Ξ» {β -> (β Ξ» {(a , p) -> a});
    --                β -> (β Ξ» {(a , p) -> β¨((x β (β , β)) β)β© a})}
            -- fp = ?
    INatural.naturality (of IAdjoint.eval lem::1) Ξ± (β₯ β) _ = refl -- funExt (Ξ» {_ -> byFirst1 refl})
    INatural.naturality (of IAdjoint.eval lem::1) {x = a} {b} Ξ± (β₯ β) (x , xp) =
                           let P : β¨ β¨ Ξ± β© β© (β¨ map {{of a}} (` arrβ `) β© x) β‘ β¨ map {{of b}} (` arrβ `) β© (β¨ β¨ Ξ± β© β© x)
                               P = naturality {{of Ξ±}} (` arrβ `) x β»ΒΉ
                            in P
    IAdjoint.reduce-Adj-Ξ² lem::1 (β₯ β) _ = refl
    IAdjoint.reduce-Adj-Ξ² lem::1 {a = a} (β₯ β) x = functoriality-id {{of a}} x
    IAdjoint.reduce-Adj-Ξ· lem::1 (β₯ tt) _ = byFirst1 refl -- funExt (Ξ» _ -> byFirst1 refl)


-- Evaluating reduce-Ξ² by hand...
-- even though agda can show it...
      -- let -- P : β¨ (map {{of ! π« *}} (Ξ·' a) β Ξ΅' (β¨ ! π« * β© a)) β© {β₯ β} β£ id
      --     -- P = {!!}
      --     -- Q : β¨ map {{of ! π« *}} (Ξ·' a) β© {β₯ β} β β¨ Ξ΅' (β¨ ! π« * β© a) β© {β₯ β} β£ id
      --     -- Q = {!!}

      --     -- Q' : β¨ β¨ map {{of ! π« *}} (Ξ·' a) β© {β₯ β} β β¨ Ξ΅' (β¨ ! π« * β© a) β© {β₯ β} β© β‘ id {{of Category:π° _}}
      --     -- Q' = {!!}

      --     -- Q'' : β¨ β¨ map {{of ! π« *}} (Ξ·' a) β© {β₯ β} β© β β¨ β¨ Ξ΅' (β¨ ! π« * β© a) β© {β₯ β} β© β‘ id {{of Category:π° _}}
      --     -- Q'' = {!!}

      --     -- Q''' : β x -> β¨ β¨ Ξ΅' (β¨ ! π« * β© a) β© {β₯ β} β© (β¨ β¨ map {{of ! π« *}} (Ξ·' a) β© {β₯ β} β© x) β‘ x
      --     -- Q''' = {!!}

      --     -- Q'''' : β x -> β¨ map {{of (β¨ ! π« * β© a)}} ` arrβ ` β© (fst (β¨ β¨ map {{of ! π« *}} (Ξ·' a) β© {β₯ β} β© x)) β‘ x
      --     -- Q'''' = {!!}

      --     -- Q''''' : β x -> β¨ map {{of (β¨ ! π« * β© a)}} ` arrβ ` β© (fst (β¨ β¨ Ξ·' a β© { β¨ (! π«) β© (β₯ β)} β© x)) β‘ x
      --     -- Q''''' = {!!}

      --     -- Q'''''' : β x -> β¨ map {{of (β¨ ! π« * β© a)}} ` arrβ ` β© (fst (β¨ β¨ Ξ·' a β© { (β₯ tt)} β© x)) β‘ x
      --     -- Q'''''' = {!!}

      --     -- Q''''''' : β x -> β¨ map {{of (! π« β a)}} ` arrβ ` β© (x) β‘ x
      --     -- Q''''''' = {!!}

      --     -- Q'''''''' : β x -> β¨ map {{of a}} (map {{of ! π«}} ` arrβ `) β© (x) β‘ x
      --     -- Q'''''''' = {!!}

      --     -- Q''''''''' : β x -> β¨ map {{of a}} (id {{of π}}) β© (x) β‘ x
      --     -- Q''''''''' = {!!}
      --     aa : β
      --     aa = 1

      -- in functoriality-id {{of a}}



