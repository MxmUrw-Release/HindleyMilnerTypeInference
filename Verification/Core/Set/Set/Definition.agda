
module Verification.Core.Set.Set.Definition where

open import Verification.Core.Conventions renaming (isSet to isSetα΅)

record isSet (A : π° π) : π° π where
  field fillPath-Set : isSetα΅ A

Set : β π -> π° _
Set π = π° π :& isSet

macro
  πππ­ : β π -> SomeStructure
  πππ­ π = #structureOn (Set π)






