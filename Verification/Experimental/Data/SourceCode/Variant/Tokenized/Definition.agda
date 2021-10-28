
module Verification.Experimental.Data.SourceCode.Variant.Tokenized.Definition where

open import Verification.Conventions hiding (lookup ; ℕ)
open import Verification.Experimental.Data.AllOf.Sum
open import Verification.Experimental.Data.Universe.Everything

----------------------------------------------------------
-- definition of tokens for parsing

{-# FOREIGN GHC import Hata.Runtime.Experimental.Data.SourceCode.Variant.Tokenized.Definition #-}

record hasElementNames (Tok : 𝒰₀) : 𝒰₀ where
  field all : List Tok
  field name : Tok -> Text

open hasElementNames {{...}} public

{-# COMPILE GHC hasElementNames = data HasElementNames (HasElementNames) #-}



record TokenizedSourceCodeData : 𝒰₁ where
  field TokenType : 𝒰₀
  field {{IShow:TokenType}} : IShow TokenType
  field {{hasElementNames:TokenType}} : hasElementNames TokenType

open TokenizedSourceCodeData public











