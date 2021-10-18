
module Verification.Application.Applications.InferStandalone.Definition where

open import Verification.Conventions
open import Verification.Experimental.Algebra.Monoid.Definition
open import Verification.Application.Definition
open import Verification.Application.Configuration.Static
open import Verification.Experimental.Data.AllOf.Sum
open import Verification.Experimental.Data.AllOf.Product
open import Verification.Experimental.Data.AllOf.Universe
open import Verification.Experimental.Data.Int.Definition
open import Verification.Experimental.Data.Expr.Variant.Base.Definition

open import Verification.Application.Persistent

open import Verification.Experimental.Category.Std.Monad.Definition
open import Verification.Experimental.Category.Std.Monad.TypeMonadNotation


record InferStandaloneState : 𝒰₀ where
  constructor printExe

-- instance
--   IShow:Bool : IShow Bool
--   IShow.show IShow:Bool false = "false"
--   IShow.show IShow:Bool true = "true"

inferStandaloneExecutable : Executable InferStandaloneState
inferStandaloneExecutable = executable (printExe) loop
  where
    loop : Event → InferStandaloneState → List (Reaction InferStandaloneState) ×~ InferStandaloneState
    loop (Event-ReadFile f) s = Reaction-PrintDebug "not implemented" ∷ [] , s
    -- (Reaction-PrintDebug (show (compareLambdaType f)) ∷ []) , s
    loop _ s = Reaction-PrintDebug "not implemented" ∷ [] , s

data InferStandaloneError : 𝒰₀ where
  persistencyError : PersistencyError -> InferStandaloneError

doInferStandalone : String -> InferStandaloneError + String
doInferStandalone input = do
  contentfile <- mapLeft persistencyError (parseContentFile input)
  contentfile' <- mapLeft persistencyError (unbaseContentFile contentfile)
  infer contentfile'

  where
    infer : ContentFile -> InferStandaloneError + String
    infer (contentFile language content) = {!!}










