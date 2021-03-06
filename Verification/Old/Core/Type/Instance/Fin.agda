
module Verification.Old.Core.Type.Instance.Fin where

open import Verification.Conventions
open import Verification.Old.Core.Category.Definition
open import Verification.Old.Core.Category.Instance.Type
open import Verification.Old.Core.Order.Lattice
open import Verification.Old.Core.Order.Preorder
open import Verification.Old.Core.Order.Partialorder
open import Verification.Old.Core.Order.Totalorder
open import Verification.Old.Core.Order.Instance.Level

open import Verification.Old.Core.Type.Instance.Nat
open import Verification.Old.Core.Type.Decidable

-- data _β€-Fin_ : Fin m -> Fin n -> π° ββ where
--   refl-β€-Fin : β {i : Fin n} -> i β€-Fin i
--   suc-β€-Fin : β{i : Fin m} {j : Fin n} -> i β€-Fin j -> i β€-Fin (suc j)

data _β€-Fin_ : Fin m -> Fin n -> π° ββ where
  from-β€ : β{i j : β} -> β{ip : i <-β m} -> β{jp : j <-β n} -> i β€ j -> (i , ip) β€-Fin (j , jp)


Preorder:Fin : β n -> Preorder β₯
β¨ Preorder:Fin n β© = Fin n
IPreorder._β€_ (of Preorder:Fin n) = _β€-Fin_
IPreorder.refl-β€ (of Preorder:Fin n) = from-β€ refl-β€
IPreorder.trans-β€ (of Preorder:Fin n) (from-β€ p) (from-β€ q)= from-β€ (trans-β€ p q)

instance IPreorder:Fin = #openstruct Preorder:Fin



Partialorder:Fin : β n -> Partialorder β₯
β¨ Partialorder:Fin n β© = Fin n
IPartialorder.Impl (of Partialorder:Fin n) = it
IPartialorder.antisym-β€ (of Partialorder:Fin n) {a = a} {b = b} (from-β€ p) (from-β€ q) =
  let P = antisym-β€ p q
  in toβ-injective P

instance IPartialorder:Fin = #openstruct Partialorder:Fin

Totalorder:Fin : β n -> Totalorder β₯
β¨ Totalorder:Fin n β© = Fin n
ITotalorder.Impl (of Totalorder:Fin n) = it
ITotalorder.total-β€ (of Totalorder:Fin n) p q = total-β€ (Ξ» a -> p (from-β€ a)) (Ξ» b -> q (from-β€ b))

instance ITotalorder:Fin = #openstruct Totalorder:Fin

syntax-as : β(A : π° π) -> A -> A
syntax-as _ a = a

infixl 10 syntax-as
syntax syntax-as A a = a as A
-- _as_ : β{}

-- instance _ = IDec-Totalorder:β

instance _ = IDec-Totalorder.Impl2 {{ITotalorder:β}} IDec-Totalorder:β
instance _ = IDec-Totalorder.Impl3 {{ITotalorder:β}} IDec-Totalorder:β

mytesta : (a b : β) -> Decision (a β€ b)
mytesta a b = decide

instance
  IDec-Totalorder:Fin : IDec-Totalorder (Fin n)
  IDec.decide (IDec-Totalorder.Impl2 IDec-Totalorder:Fin {a = a} {b}) with decide as Decision ((a .fst) β€ (b .fst))
  ... | yes p = yes (from-β€ p)
  ... | no Β¬p = no (Ξ» {(from-β€ x) -> Β¬p x})
  IDec.decide (IDec-Totalorder.Impl3 IDec-Totalorder:Fin {a = a} {b}) with decide as Decision (a .fst β‘ b .fst)
  ... | yes p = yes (toβ-injective p)
  ... | no Β¬p = no (Ξ» e -> Β¬p (cong fst e))


