
module Verification.Unification.Instance.Signature where

open import Verification.Conventions hiding (k)
open import Verification.Core.Category
open import Verification.Core.Order
open import Verification.Core.Type
open import Verification.Core.Category.Monad
open import Verification.Core.Category.Instance.Kleisli
open import Verification.Core.Category.Instance.IdxSet
open import Verification.Unification.RecAccessible

open import Verification.Core.Syntax.SignatureZ

instance
  IDiscreteStr:Vec : â{A : ð° ð} {{_ : IDiscreteStr A}} -> IDiscreteStr (Vec A n)
  (IDiscreteStr:Vec IDiscreteStr.â-Str a) b = {!!}

  IDiscreteStr:â : IDiscreteStr â
  IDiscreteStr:â = {!!}


module _ {K : ð°â} {{_ : IDiscreteStr K}} where

  module _ {Ï : Signature} where
    private
      variable k : K
               ks : Vec K n
               -- j : K

    module _ {{_ : â{n k} {ks : Vec K (suc n)} -> IDiscreteStr (Ï k ks)}} where

    -- private
    --   ð : Category _
    --   ð = ` IdxSet (Maybe K) ââ `

    -- data SigEdge : (a b : Maybe K) -> ð°â where
    --   e-arg : â {k} {ks : Vec K (suc n)} -> (i : Fin-R n) -> Ï k ks -> SigEdge (just (lookup i ks)) (just k)
    --   e-noarg : â{k} -> Ï k [] -> SigEdge nothing (just k)

      data SigEdge : (a b : K) -> ð°â where
        edge : â {k} {ks : Vec K (suc n)} -> (i : Fin-R (suc n)) -> Ï k ks -> SigEdge (lookup i ks) k
        fail : â{a : K} -> SigEdge a a

      ð : Quiver â¥
      â¨ ð â© = K
      IQuiver.Edge (of ð) = SigEdge
      IQuiver._â_ (of ð) = _â¡_
      IQuiver.IEquivInst (of ð) = IEquiv:Path

      -- compare-sig : â{k jâ jâ : K} -> {nâ nâ : â} -> (s )

      module _ {V : K -> ð°â} where
        lookup-Term : â{ks : Vec K (n)} -> (i : Fin-R (n)) -> Terms Ï V ks -> Term Ï V (lookup i ks)
        lookup-Term zero    (t â· ts) = t
        lookup-Term (suc i) (t â· ts) = lookup-Term i ts

        lookup-Term-try : â{nâ nâ : â} {ksâ : Vec K (suc nâ)} {ksâ : Vec K (suc nâ)} (sâ : Ï k ksâ) (sâ : Ï k ksâ) (i : Fin-R (suc nâ)) (ts : Terms Ï V ksâ) -> Maybe (TermZ Ï V (lookup i ksâ))
        lookup-Term-try {nâ = nâ} {nâ} {ksâ} {ksâ} sâ sâ i ts with (nâ â-Str nâ)
        ... | no Â¬p = nothing
        ... | yes refl-StrId with (ksâ â-Str ksâ)
        ... | no Â¬p = nothing
        ... | yes refl-StrId with (sâ â-Str sâ)
        ... | no Â¬p = nothing
        ... | yes refl-StrId = right (valid (lookup-Term i ts))

      module _ {X Y : K -> ð°â} where
        naturality-lookup-Term : (f : â{k} -> X k -> Y k) -> â{ks : Vec K (n)} -> (i : Fin-R (n)) -> (ts : Terms Ï X ks) -> (map-Term f (lookup-Term i ts)) â¡ (lookup-Term i (map-Terms f ts))
        naturality-lookup-Term f zero (t â· ts) = refl
        naturality-lookup-Term f (suc i) (t â· ts) = naturality-lookup-Term f i ts

        naturality-lookup-Term-try : (f : â{k} -> X k -> Y k) {k : K} -> â {n nâ}
                                     -> â {ksâ : Vec K (suc n)} {ksâ : Vec K (suc nâ)} ->
                            -- (t : TermZ Ï X k) â
                            (sâ : Ï k ksâ) ->
                            (sâ : Ï k ksâ) ->
                            (ts  : Terms Ï X ksâ) â
                            (i : Fin-R (suc nâ)) ->
                            map-Maybe (map-TermZ f) (lookup-Term-try sâ sâ i ts) â¡
                                  lookup-Term-try sâ sâ i (map-Terms f ts)
        naturality-lookup-Term-try f {k} {n} {nâ} {ksâ} {ksâ} sâ sâ ts i with (n â-Str nâ)
        ... | no Â¬p = refl
        ... | yes refl-StrId with (ksâ â-Str ksâ)
        ... | no Â¬p = refl
        ... | yes refl-StrId with (sâ â-Str sâ)
        ... | no Â¬p = refl
        ... | yes refl-StrId = Î» j -> just (valid (naturality-lookup-Term f i ts j))

      -- [Theorem]
      -- | The |Monad:TermZ| is recursively accessible.
      interleaved mutual
        RecAccessible:TermZ : IRecAccessible (Monad:TermZ Ï)

        -- | First we build the decomposition function:
        decomp : {k : K} {V : K -> ð°â} -> TermZ Ï V k -> (â{j : K} -> SigEdge j k -> Maybe (TermZ Ï V j))
        decomp _ fail = right fail
        decomp fail (edge _ _) = right fail
        decomp (valid (var x)) (edge _ _) = nothing
        decomp (valid (te sâ ts)) (edge i sâ) = lookup-Term-try sâ sâ i ts

        module _ {X Y : K -> ð°â} where
          naturality-decomp : (f : â{k} -> X k -> Y k) {k : K}
                              (t : TermZ Ï X k) â
                              â{j} -> (e : SigEdge j k) ->
                              map-Maybe (map-TermZ f) (decomp t e) â¡ decomp (map-TermZ f t) e
          naturality-decomp f t fail = refl
          naturality-decomp f fail (edge i x) = refl
          naturality-decomp f (valid (te sâ ts)) (edge i sâ) = naturality-lookup-Term-try f sâ sâ ts i
          naturality-decomp f (valid (var xâ)) (edge i x) = refl

        module lem-20 {X : K -> ð°â} where
          proof : (t : TermZ Ï (TermZ Ï X) k) â
                  â{j} -> (e : SigEdge j k) ->
                  map-Maybe join-TermZ (decomp t e) â¡ decomp (join-TermZ t) e
          proof t fail = refl
          proof fail (edge i x) = refl
          proof (valid (te xâ xâ)) (edge i x) = {!!}
          proof (valid (var fail)) (edge i x) = {!!}
          proof (valid (var (valid xâ))) (edge i x) = {!!}

        module lem-25 {X Y : K -> ð°â} (f : â{k} -> X k -> TermZ Ï Y k) where
          interleaved mutual
            proof : â{j k} -> â(e : Edge {{of ð}} k j) -> â t -> (decomp t e â¢ nothing) -> map-Maybe (Î» a â join-TermZ (map-TermZ f a)) (decomp t e)
                    â¡ decomp (join-TermZ (map-TermZ f t)) e

            P0 :  {k : K} -> â {n nâ} -> â {ksâ : Vec K (suc n)} {ksâ : Vec K (suc nâ)} ->
                              -- (t : TermZ Ï X k) â
                              (sâ : Ï k ksâ) ->
                              (sâ : Ï k ksâ) ->
                              (ts  : Terms Ï X ksâ) â
                              (i : Fin-R (suc nâ)) ->
                              -- (decomp t e â¢ nothing) ->
                              (lookup-Term-try sâ sâ i ts â¢ nothing) ->
                              map-Maybe (Î» a -> join-TermZ (map-TermZ f a)) (lookup-Term-try sâ sâ i ts) â¡
                                    decomp (join-Term (te sâ (map-Terms f ts))) (edge i sâ)
                                    -- lookup-Term-try sâ sâ i (map-Terms f ts)
            P0 {k} {nâ} {nâ} {ksâ} {ksâ} sâ sâ ts i P with (nâ â-Str nâ)
            ... | no Â¬p = ð-rec (P refl)
            ... | yes refl-StrId with (ksâ â-Str ksâ)
            ... | no Â¬p = ð-rec (P refl)
            ... | yes refl-StrId with (sâ â-Str sâ)
            ... | no Â¬p = ð-rec (P refl)
            ... | yes refl-StrId = {!!}

-- with (ksâ â-Str ksâ)
--         ... | no Â¬p = refl
--         ... | yes refl-StrId with (sâ â-Str sâ)

            proof (edge i x) fail _ = refl
            proof fail t _ = refl
            proof (edge i x) (valid (te s (ts))) P = P0 s x ts i P
            proof (edge i x) (valid (var xâ)) P = ð-rec (P refl)



        -- | For this we take the following:
        IRecAccessible.Dir RecAccessible:TermZ = of ð
        IRecAccessible.ISet:Dir RecAccessible:TermZ = {!!}
        IRecAccessible.ISet:K RecAccessible:TermZ = {!!}
        IRecAccessible.IDiscreteStr:Dir RecAccessible:TermZ = {!!}
        IRecAccessible.IDiscreteStr:K RecAccessible:TermZ = {!!}
        â¨ â¨ IRecAccessible.decompose RecAccessible:TermZ â© â© = decomp
        INatural.naturality (of IRecAccessible.decompose RecAccessible:TermZ) f t i e = naturality-decomp â¨ f â© t e i
        IRecAccessible.commutes:decompose RecAccessible:TermZ t i e = lem-20.proof t e i
        IRecAccessible.Î´-comm RecAccessible:TermZ f {j} {k} e x = lem-25.proof â¨ f â© e x
        â¨ â¨ IRecAccessible.pts RecAccessible:TermZ â© â© _ = fail
        INatural.naturality (of IRecAccessible.pts RecAccessible:TermZ) _ _ = refl
        IRecAccessible.a0 RecAccessible:TermZ = fail
        IRecAccessible.a0-adsorb RecAccessible:TermZ _ = refl
        IRecAccessible.k-a1 RecAccessible:TermZ = {!!}
        IRecAccessible.a1 RecAccessible:TermZ = {!!}
        IRecAccessible.isDecomposableP RecAccessible:TermZ = {!!}
        IRecAccessible.isPureP RecAccessible:TermZ = {!!}
        IRecAccessible.decideDecompose RecAccessible:TermZ = {!!}
        IRecAccessible.makeDec RecAccessible:TermZ = {!!}
        IRecAccessible.makePure RecAccessible:TermZ = {!!}
        IRecAccessible.isWellfounded::âº RecAccessible:TermZ = {!!}
        IRecAccessible.cancel-Î´ RecAccessible:TermZ = {!!}

{-
        decomp : {k : K} -> Term Ï V k -> V k +-ð° (â(j : K) -> SigEdge j k -> Maybe (Term Ï V j))
        decomp {k = k} (te {n = nâ} {ks = ksâ} sâ ts) = right f
          where
            f : (j : K) â SigEdge j k â Maybe (Term Ï V j)
            f .(lookup i _) (edge {n = nâ} {ks = ksâ} i sâ) with (nâ â-Str nâ)
            ... | no Â¬p = nothing
            ... | yes refl-StrId with (ksâ â-Str ksâ)
            ... | no Â¬p = nothing
            ... | yes refl-StrId with (sâ â-Str sâ)
            ... | no Â¬p = nothing
            ... | yes refl-StrId = right (lookup-Term i ts)
        decomp (var x) = left x

        isMono:decomp : â {k} -> (t s : Term Ï V k) -> decomp t â¡-Str decomp s -> t â¡-Str s
        isMono:decomp (te x xâ) (te xâ xâ) p = {!!}
        isMono:decomp (var x) (var .x) refl-StrId = refl-StrId

      -- decomp nothing none = right (Î» j ())
      -- decomp {V = V} (just k) (some (te t ts)) = right (f ts)
      --   where f : Terms Ï (V) ks -> (j : K) -> SigEdge j (just k) -> Maybe (Term Ï _ j)
      --         f = ?
              -- f xs .(just (lookup i _)) (e-arg i x) = {!!}
              -- f xs .nothing (e-noarg x) = {!!}
              -- f .(just (lookup i _)) (e-arg i x) = {!!}
              -- f .nothing (e-noarg x) = {!!}
      -- decomp (just k) (some (var v)) = left v

      RecAccessible:Term : IRecAccessible (Monad:Term Ï)
      IRecAccessible.Dir RecAccessible:Term = of ð
      IRecAccessible.ISet:Dir RecAccessible:Term = {!!}
      â¨ â¨ IRecAccessible.decompose RecAccessible:Term â© â© _ = decomp
      of IRecAccessible.decompose RecAccessible:Term = {!!}
      IRecAccessible.IMono:decompose RecAccessible:Term = {!!}
      IRecAccessible.wellfounded RecAccessible:Term = {!!}


-}

