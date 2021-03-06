
--
-- NOTE: This file is originally from the cubical std library.
--       (https://github.com/agda/cubical)
--       It was copied here to replace references to cubical paths,
--       since cubical agda files cannot currently be compiled to binaries.
--       All copyright belongs to the original authors.
--
-- See:
-- module Cubical.Data.Nat.Order where
--

module Verification.Conventions.Prelude.Data.Nat.Order where

open import Verification.Conventions.Proprelude.CubicalConventions
open import Verification.Conventions.Prelude.Data.Nat.Base
open import Verification.Conventions.Prelude.Data.Nat.Properties
open import Verification.Conventions.Proprelude
open import Verification.Conventions.Prelude.Data.StrictId
open import Verification.Conventions.Prelude.Classes.EquivalenceRelation
open import Verification.Conventions.Prelude.Classes.Setoid

-- open import Cubical.Foundations.Prelude
-- open import Cubical.Foundations.Function
-- open import Cubical.Foundations.HLevels

private
  β₯ = π-π°


-- open import Cubical.Data.Empty as β₯
-- open import Cubical.Data.Sigma
-- open import Cubical.Data.Sum as β

-- open import Cubical.Data.Nat.Base
-- open import Cubical.Data.Nat.Properties

-- open import Cubical.Induction.WellFounded

-- open import Cubical.Relation.Nullary

infix 4 _β€_ _<_

_β€_ : β β β β Typeβ
m β€ n = Ξ£[ k β β ] k + m β£ n

_<_ : β β β β Typeβ
m < n = suc m β€ n

data Trichotomy (m n : β) : Typeβ where
  lt : m < n β Trichotomy m n
  eq : m β£ n β Trichotomy m n
  gt : n < m β Trichotomy m n

private
  variable
    k l m n : β

-- private
--   witness-prop : β j β isProp (j + m β£ n)
--   witness-prop {m} {n} j = isSetβ (j + m) n

-- mβ€n-isProp : isProp (m β€ n)
-- mβ€n-isProp {m} {n} (k , p) (l , q)
--   = Ξ£β£Prop witness-prop lemma
--   where
--   lemma : k β£ l
--   lemma = inj-+m (p β (sym q))

zero-β€ : 0 β€ n
zero-β€ {n} = n , +-zero n

suc-β€-suc : m β€ n β suc m β€ suc n
suc-β€-suc (k , p) = k , (+-suc k _) β (cong-Str suc p)

β€-+k : m β€ n β m + k β€ n + k
β€-+k {m} {k = k} (i , p)
  = i , +-assoc i m k β cong-Str (_+ k) p

β€-k+ : m β€ n β k + m β€ k + n
β€-k+ {m} {n} {k}
  = subst-Str (_β€ k + n) (+-comm m k)
  β subst-Str (m + k β€_) (+-comm n k)
  β β€-+k

pred-β€-pred : suc m β€ suc n β m β€ n
pred-β€-pred (k , p) = k , injSuc ((sym (+-suc k _)) β p)

β€-refl : m β€ m
β€-refl = 0 , refl

β€-suc : m β€ n β m β€ suc n
β€-suc (k , p) = suc k , cong-Str suc p

β€-predβ : predβ n β€ n
β€-predβ {zero} = β€-refl
β€-predβ {suc n} = β€-suc β€-refl

β€-trans : k β€ m β m β€ n β k β€ n
β€-trans {k} {m} {n} (i , p) (j , q) = i + j , l2 β (l1 β q)
  where
  l1 : j + i + k β£ j + m
  l1 = (sym (+-assoc j i k)) β (cong-Str (j +_) p)
  l2 : i + j + k β£ j + i + k
  l2 = cong-Str (_+ k) (+-comm i j)

β€-antisym : m β€ n β n β€ m β m β£ n
β€-antisym {m} (i , p) (j , q) = (cong-Str (_+ m) l3) β p
  where
  l1 : j + i + m β£ m
  l1 = (sym (+-assoc j i m)) β ((cong-Str (j +_) p) β q)
  l2 : j + i β£ 0
  l2 = m+nβ£nβmβ£0 l1
  l3 : 0 β£ i
  l3 = sym (snd (m+nβ£0βmβ£0Γnβ£0 l2))

β€-k+-cancel : k + m β€ k + n β m β€ n
β€-k+-cancel {k} {m} (l , p) = l , inj-m+ (sub k m β p)
 where
 sub : β k m β k + (l + m) β£ l + (k + m)
 sub k m = +-assoc k l m β cong-Str (_+ m) (+-comm k l) β sym (+-assoc l k m)

β€-+k-cancel : m + k β€ n + k β m β€ n
β€-+k-cancel {m} {k} {n} (l , p) = l , cancelled
 where
 cancelled : l + m β£ n
 cancelled = inj-+m (sym (+-assoc l m k) β p)

<-k+-cancel : k + m < k + n β m < n
<-k+-cancel {k} {m} {n} = β€-k+-cancel β subst-Str (_β€ k + n) (sym (+-suc k m))

Β¬-<-zero : Β¬ m < 0
Β¬-<-zero (k , p) = snotz ((sym (+-suc k _)) β p)

Β¬m<m : Β¬ m < m
Β¬m<m {m} = Β¬-<-zero β β€-+k-cancel {k = m}

β€0ββ£0 : n β€ 0 β n β£ 0
β€0ββ£0 {zero} ineq = refl
β€0ββ£0 {suc n} ineq = π-rec (Β¬-<-zero ineq)

predβ-β€-predβ : m β€ n β (predβ m) β€ (predβ n)
predβ-β€-predβ {zero} {zero}   ineq = β€-refl
predβ-β€-predβ {zero} {suc n}  ineq = zero-β€
predβ-β€-predβ {suc m} {zero}  ineq = π-rec (Β¬-<-zero ineq)
predβ-β€-predβ {suc m} {suc n} ineq = pred-β€-pred ineq

Β¬m+n<m : Β¬ m + n < m
Β¬m+n<m {m} {n} = Β¬-<-zero β <-k+-cancel β subst-Str (m + n <_) (sym (+-zero m))

<-weaken : m < n β m β€ n
<-weaken (k , p) = suc k , sym (+-suc k _) β p

β€<-trans : l β€ m β m < n β l < n
β€<-trans {l} {m} {n} (i , p) (j , q) = (j + i) , reason
  where
  reason : j + i + suc l β£ n
  reason = j + i + suc l β£β¨ sym (+-assoc j i (suc l)) β©
           j + (i + suc l) β£β¨ cong-Str (j +_) (+-suc i l) β©
           j + (suc (i + l)) β£β¨ cong-Str (_+_ j β suc) p β©
           j + suc m β£β¨ q β©
           n β

<β€-trans : l < m β m β€ n β l < n
<β€-trans {l} {m} {n} (i , p) (j , q) = j + i , reason
  where
  reason : j + i + suc l β£ n
  reason = j + i + suc l β£β¨ sym (+-assoc j i (suc l)) β©
           j + (i + suc l) β£β¨ cong-Str (j +_) p β©
           j + m β£β¨ q β©
           n β

<-trans : l < m β m < n β l < n
<-trans p = β€<-trans (<-weaken p)

<-asym : m < n β Β¬ n β€ m
<-asym m<n = Β¬m<m β <β€-trans m<n

Trichotomy-suc : Trichotomy m n β Trichotomy (suc m) (suc n)
Trichotomy-suc (lt m<n) = lt (suc-β€-suc m<n)
Trichotomy-suc (eq m=n) = eq (cong-Str suc m=n)
Trichotomy-suc (gt n<m) = gt (suc-β€-suc n<m)

_β_ : β m n β Trichotomy m n
zero β zero = eq refl
zero β suc n = lt (n , +-comm n 1)
suc m β zero = gt (m , +-comm m 1)
suc m β suc n = Trichotomy-suc (m β n)

-- <-split : m < suc n β (m < n) β (m β£ n)
-- <-split {n = zero} = inr β snd β m+nβ£0βmβ£0Γnβ£0 β snd β pred-β€-pred
-- <-split {zero} {suc n} = Ξ» _ β inl (suc-β€-suc zero-β€)
-- <-split {suc m} {suc n} = β.map suc-β€-suc (cong-Str suc) β <-split β pred-β€-pred

-- private
--   acc-suc : Acc _<_ n β Acc _<_ (suc n)
--   acc-suc a
--     = acc Ξ» y y<sn
--     β case <-split y<sn of Ξ»
--     { (inl y<n) β access a y y<n
--     ; (inr yβ£n) β subst-Str _ (sym yβ£n) a
--     }

-- <-wellfounded : WellFounded _<_
-- <-wellfounded zero = acc Ξ» _ β π-rec β Β¬-<-zero
-- <-wellfounded (suc n) = acc-suc (<-wellfounded n)

-- module _
--     (bβ : β)
--     (P : β β Typeβ)
--     (base : β n β n < suc bβ β P n)
--     (step : β n β P n β P (suc bβ + n))
--   where
--   open WFI (<-wellfounded)

--   private
--     dichotomy : β b n β (n < b) β (Ξ£[ m β β ] n β£ b + m)
--     dichotomy b n
--       = case n β b return (Ξ» _ β (n < b) β (Ξ£[ m β β ] n β£ b + m)) of Ξ»
--       { (lt o) β inl o
--       ; (eq p) β inr (0 , p β sym (+-zero b))
--       ; (gt (m , p)) β inr (suc m , sym p β +-suc m b β +-comm (suc m) b)
--       }

--     dichotomy<β£ : β b n β (n<b : n < b) β dichotomy b n β£ inl n<b
--     dichotomy<β£ b n n<b
--       = case dichotomy b n return (Ξ» d β d β£ inl n<b) of Ξ»
--       { (inl x) β cong-Str inl (mβ€n-isProp x n<b)
--       ; (inr (m , p)) β π-rec (<-asym n<b (m , sym (p β +-comm b m)))
--       }

--     dichotomy+β£ : β b m n β (p : n β£ b + m) β dichotomy b n β£ inr (m , p)
--     dichotomy+β£ b m n p
--       = case dichotomy b n return (Ξ» d β d β£ inr (m , p)) of Ξ»
--       { (inl n<b) β π-rec (<-asym n<b (m , +-comm m b β sym p))
--       ; (inr (m' , q))
--       β cong-Str inr (Ξ£β£Prop (Ξ» x β isSetβ n (b + x)) (inj-m+ {m = b} (sym q β p)))
--       }

--     b = suc bβ

--     lemmaβ : β{x y z} β x β£ suc z + y β y < x
--     lemmaβ {y = y} {z} p = z , +-suc z y β sym p

--     subStep : (n : β) β (β m β m < n β P m) β (n < b) β (Ξ£[ m β β ] n β£ b + m) β P n
--     subStep n _   (inl l) = base n l
--     subStep n rec (inr (m , p))
--       = transport (cong-Str P (sym p)) (step m (rec m (lemmaβ p)))

--     wfStep : (n : β) β (β m β m < n β P m) β P n
--     wfStep n rec = subStep n rec (dichotomy b n)

--     wfStepLemmaβ : β n (n<b : n < b) rec β wfStep n rec β£ base n n<b
--     wfStepLemmaβ n n<b rec = cong-Str (subStep n rec) (dichotomy<β£ b n n<b)

--     wfStepLemmaβ : β n rec β wfStep (b + n) rec β£ step n (rec n (lemmaβ refl))
--     wfStepLemmaβ n rec
--       = cong-Str (subStep (b + n) rec) (dichotomy+β£ b n (b + n) refl)
--       β transportRefl _

--   +induction : β n β P n
--   +induction = induction wfStep

--   +inductionBase : β n β (l : n < b) β +induction n β£ base n l
--   +inductionBase n l = induction-compute wfStep n β wfStepLemmaβ n l _

--   +inductionStep : β n β +induction (b + n) β£ step n (+induction n)
--   +inductionStep n = induction-compute wfStep (b + n) β wfStepLemmaβ n _
