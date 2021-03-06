
{-# OPTIONS --cubical --allow-unsolved-metas #-}

module Verification.VHM3.Old.Core.Type.FinFam where

open import Verification.VHM3.Old.Core.Base
open import Verification.VHM3.Old.Core.Meta
open import Verification.VHM3.Old.Core.Notation
open import Verification.VHM3.Old.Core.Algebra.Basic.Monoid
open import Verification.VHM3.Old.Core.Space.Order
open import Verification.VHM3.Old.Core.Type
open import Verification.VHM3.Old.Core.Category.Base
open import Verification.VHM3.Old.Core.Category.Instance.Type
open import Verification.VHM3.Old.Core.Category.Instance.TypeProperties
open import Verification.VHM3.Old.Core.Category.Instance.Cat
open import Verification.VHM3.Old.Core.Category.Instance.CatProperties
open import Verification.VHM3.Old.Core.Category.Limit
open import Verification.VHM3.Old.Core.Category.Idempotent

--------------------------------------------------------------------
-- == Normed type

record INormed (V : Totalorder ð) (A : ð° ð) : ð° (ð â ð) where
  field size : A -> â¨ V â©
open INormed {{...}} public

instance
  INotation:Absolute:INormed : â{V : Totalorder ð} {A : ð° ð} {{_ : INormed V A}} -> INotation:Absolute A â¨ V â©
  INotation:Absolute.â£ INotation:Absolute:INormed â£ = size



module _ (A : Totalorderâ®Dec ð) (V : Monoid ð) where
  private
    AV = â¨ A â© Ã â¨ V â©
  PreFinFam = List AV

  size-PreFinFam : PreFinFam -> â¨ A â© +-ð° Lift {j = ð} â¤
  size-PreFinFam [] = right (lift tt)
  size-PreFinFam ((a , v) â· xs) = min (left a) (size-PreFinFam xs)

  instance
    INormed:PreFinFam : INormed ((â â¨ A â©) â (â Lift â¤)) PreFinFam
    INormed.size INormed:PreFinFam = size-PreFinFam

  insert : AV -> PreFinFam -> PreFinFam
  insert (a , v) [] = (a , v) â· []
  insert (a , av) ((x , xv) â· xs) with a < x ï¼ | (a â¡ x) ï¼
  ... | P | right xâ = (a , av â xv) â· xs
  ... | left xâ | left xâ = (x , xv) â· insert (a , av) xs
  ... | right xâ | left xâ = (a , av) â· (x , xv) â· xs

  sort : PreFinFam -> PreFinFam
  sort [] = []
  sort (x â· xs) = insert x (sort xs)

  instance
    IIdempotent:sort : IIdempotent sort
    IIdempotent./idempotent IIdempotent:sort = {!!}

  FinFam = Normal (â sort)

module _ {A : Totalorderâ®Dec ð} {V : Monoid ð} where
  instance
    INotation:Union:FinFam : INotation:Union (FinFam A V)
    INotation:Union._âª_ INotation:Union:FinFam = {!!} -- _âª-FinFam_
    INotation:Union.â INotation:Union:FinFam = {!!} -- []


{-


-- open TypeNotation

--------------------------------------------------------------------
-- == Definition of Finite subsets

-- module _ (A : ð° ð) {{_ : ITotalorderâ®Dec A}} (V : ð° ð) {{_ : IMonoid V}} where
module _ (A : Totalorderâ®Dec ð) (V : Monoid ð) where
  data FinFam : ð° (ð)

  size-FinFam : FinFam -> â¨ A â© +-ð° Lift â¤

  instance
    INormed:FinFam : INormed ((â â¨ A â©) â (â Lift â¤)) FinFam
    INormed.size INormed:FinFam = size-FinFam

  data FinFam where
    [] : FinFam
    _â·[_] : (a : â¨ A â© Ã â¨ V â©) -> (â Î» (S : FinFam) -> (left (fst a) < â£ S â£)) -> FinFam

  size-FinFam [] = right (lift tt)
  size-FinFam ((a , _) â·[ S , p ]) = min (left a) (size-FinFam S)

--------------------------------------------------------------------
-- == Set operations of finite subsets
-- module _ {A : ð° ð} {{_ : ITotalorderâ®Dec A}} {V : ð° ð} {{_ : IMonoid V}} where
module _ {A : Totalorderâ®Dec ð} {V : Monoid ð} where

  private
    insert : (â¨ A â© Ã-ð° â¨ V â©) -> FinFam A V -> FinFam A V
    insert a [] = a â·[ [] , decide-yes ]
    insert (a , va) ((b , vb) â·[ U , x ]) with (a â¤ b) ï¼ | (a â¡ b) ï¼
    ... | P | right Q = (b , va â vb) â·[ U , x ]
    ... | left P | left Q = (a , va) â·[ (b , vb) â·[ U , x ] , ({!!} , {!!}) ]
    ... | right P | left Q = (b , vb) â·[ insert (a , va) U , {!!} ]

  _âª-FinFam_ : FinFam A V -> FinFam A V -> FinFam A V
  [] âª-FinFam w = w
  (a â·[ v , _ ]) âª-FinFam w = insert a (v âª-FinFam w)

  instance
    INotation:Union:FinFam : INotation:Union (FinFam A V)
    INotation:Union._âª_ INotation:Union:FinFam = _âª-FinFam_
    INotation:Union.â INotation:Union:FinFam = []



--------------------------------------------------------------------
-- Functoriality on contained items
module _ {A : Totalorderâ®Dec ð} {B : Totalorderâ®Dec ð} {V : Monoid ð} {W : Monoid ð} where

  map-FinFam : (â¨ A â© -> â¨ B â©) -> (MonoidHom V W) -> FinFam A V -> FinFam B W
  map-FinFam f g [] = []
  map-FinFam f g ((a , va) â·[ x , P ]) = (f a , â¨ g â© va) â·[ map-FinFam f g x , {!!} ]


module _ {A : Totalorderâ®Dec ð} where
  instance
    IFunctor:FinFam : IFunctor (â Monoid ð) (â ð° (ð)) (FinFam A)
    IFunctor.map IFunctor:FinFam = map-FinFam id
    IFunctor.map/id IFunctor:FinFam = {!!}
    IFunctor.map/comp IFunctor:FinFam = {!!}


-}
