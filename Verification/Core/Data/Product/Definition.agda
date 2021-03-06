
module Verification.Core.Data.Product.Definition where

open import Verification.Conventions


macro
  _Γ_ : β{π π : π} {π π : π ^ 2} -> (π°' π) [ π ]β (π°' π) [ π ]β SomeStructure
  _Γ_ = Ξ»str A β¦ Ξ»str B β¦ #structureOn (A Γ-π° B)
  infixr 40 _Γ_


-- The product for haskell

record _Γ~_ (A : π° π) (B : π° π) : π° (π ο½€ π) where
  constructor _,_
  field fst : A
  field snd : B


{-# FOREIGN GHC type AgdaProduct a b = (,) #-}
-- {-# FOREIGN GHC makeProduct a b = (a,b) #-}
{-# COMPILE GHC _Γ~_ = data AgdaProduct ((,)) #-}



--------------------------------------------------------------
-- The 0-ary product

macro
  π : β {π} -> SomeStructure
  π {π} = #structureOn (β€-π° {π})

isProp:β€-π° : β{a b : β€-π° {π}} -> a β£ b
isProp:β€-π° {a = tt} {tt} = refl-β£

isSet:β€-π° : β{a b : β€-π° {π}} {p q : a β£ b} -> p β£ q
isSet:β€-π° {p = refl-β£} {q} = {!!}

instance
  isDiscrete:β€-π° : isDiscrete (β€-π° {π})
  isDiscrete:β€-π° = record { _β-Str_ = Ξ» {tt tt β yes refl-β£} }

instance
  IShow:β€-π° : IShow (β€-π° {π})
  IShow:β€-π° = record { show = const "()" }

