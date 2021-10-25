
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

open import Verification.Experimental.Theory.Std.Inference.Definition
open import Verification.Experimental.Theory.Std.Inference.Task


module _ {A : 𝒰 𝑖} {B : 𝒰 𝑗} where
  instance
    IShow:+-𝒰 : {{_ : IShow A}} {{_ : IShow B}} -> IShow (A + B)
    IShow:+-𝒰 = record { show = either show show }

record InferStandaloneState : 𝒰₀ where
  constructor printExe

-- instance
--   IShow:Bool : IShow Bool
--   IShow.show IShow:Bool false = "false"
--   IShow.show IShow:Bool true = "true"

data InferStandaloneError : 𝒰₀ where
  persistencyError : PersistencyError -> InferStandaloneError

instance
  IShow:InferStandaloneError : IShow InferStandaloneError
  IShow.show IShow:InferStandaloneError (persistencyError x) = show x

doInferStandalone : Text -> InferStandaloneError + Text
doInferStandalone input = do
  contentfile <- mapLeft (persistencyError ∘ parseError) (parseContentFile input)
  contentfile' <- mapLeft persistencyError (unbaseContentFile contentfile)
  return (inferCF contentfile')

  where
    inferCF : ContentFile -> String
    inferCF (contentFile language content) =
      let _ , task = getInferenceTask language
      in executeInferenceFlat task content

inferStandaloneExecutable : Executable InferStandaloneState
inferStandaloneExecutable = executable (printExe) loop
  where
    loop : Event → InferStandaloneState → List (Reaction InferStandaloneState) ×~ InferStandaloneState
    loop (Event-ReadFile f) s = (Reaction-PrintDebug (show (doInferStandalone f)) ∷ []) , s
    loop _ s = Reaction-PrintDebug "not implemented" ∷ [] , s



-- inferStandaloneApplication : Application
-- inferStandaloneApplication = execute "infer" inferStandaloneExecutable








