

module Verification.Conventions.Meta.Universe where

open import Verification.Conventions.Prelude
open import Verification.Conventions.Meta.Term


try-unify-πn : Term -> β -> TC β
try-unify-πn hole n =
  do target-Type <- quoteTC (π ^ n)
     -- target-Type <- normalise target-Type
     _ <- unify hole target-Type
     return n

try-eq-πn : Term -> β -> TC β
try-eq-πn hole n =
  do `cmp` <- quoteTC (π ^ n)
     `cmp` <- normalise `cmp`
     if (`cmp` β hole) then (return n) else (printErr (show `cmp` <> "\nis not eq to\n" <> show hole))


try-all : β{a : π°' π} -> β -> (β -> TC a) -> TC a
try-all zero f = noConstraints (f zero)
try-all (suc n) f = catchTC (noConstraints (f (suc n))) (try-all n f)



macro
  π2 : Term -> Term -> TC π-π°
  π2 level-Term hole-Term = do
      level-Type <- inferType level-Term
      `π` <- quoteTC π
      `β` <- quoteTC β
      -- `π°''` <- quoteΟTC π°''

      let try-simple = (
            do
              n <- try-all 0 (try-unify-πn level-Type)
              target-Type <- quoteTC (π ^ n)
              target-Type <- normalise target-Type
              unify level-Type target-Type

              level <- assertType (π ^ n) $ unquoteTC level-Term
              checkType level-Term `β`

              `π°` <- quoteTC (π°' (merge level))
              unify hole-Term `π°`)

      -- try-simple
      -- let otherwise = printErr "Could not find universe type"
      -- level-Type <- catchTC try-simple otherwise

      level <- unquoteTC level-Term

      final-Type <- quoteTC (π°' level)

      res <- checkType final-Type `β`
      unify hole-Term res

      return tt

postulate
  ls : π ^ 10


#merge : β{A : π°' π} -> Term -> TC π-π°
#merge {A = A} hole =
  do
     `A` <- quoteTC A
     `A` <- normalise `A`

     let dofirst =
          do n <- try-all 5 (try-eq-πn `A`)
             fun <- quoteTC (Ξ» (ls : π ^ n) -> (merge ls))
             unify hole fun

     let otherwise =
          do res <- quoteTC (Ξ» (a : A) -> a)
             unify hole res

     catchTC dofirst otherwise



π° : β{A : π°' π} -> (a : A) -> {@(tactic #merge {A = A}) f : A -> π} -> π°' (f a βΊ')
π° a {f = f} = π°' (f a)

π°β = π°' ββ
π°β = π°' ββ
π°β = π°' ββ


-- test : π° (ls β 7)
-- test = {!!}

