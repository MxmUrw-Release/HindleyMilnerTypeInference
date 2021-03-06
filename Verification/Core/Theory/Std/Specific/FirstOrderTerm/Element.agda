
module Verification.Core.Theory.Std.Specific.FirstOrderTerm.Element where

open import Verification.Conventions hiding (_โ_)

open import Verification.Core.Set.Discrete

open import Verification.Core.Algebra.Monoid.Definition

open import Verification.Core.Category.Std.Category.Subcategory.Full

open import Verification.Core.Data.Universe.Definition
open import Verification.Core.Data.Universe.Instance.Category
open import Verification.Core.Data.Product.Definition
open import Verification.Core.Data.Indexed.Definition
open import Verification.Core.Data.FiniteIndexed.Definition
open import Verification.Core.Data.Substitution.Variant.Base.Definition

open import Verification.Core.Data.List.Variant.Binary.Definition
open import Verification.Core.Data.List.Variant.Binary.Element.Definition
open import Verification.Core.Data.List.VariantTranslation.Definition
open import Verification.Core.Data.List.Dependent.Variant.Binary.Definition

open import Verification.Core.Theory.Std.Specific.FirstOrderTerm.Signature
open import Verification.Core.Theory.Std.Specific.FirstOrderTerm.Definition



-- [Definition]
-- | Let [..] be a parametrization.
module _ (๐ : ๐ฏFOSignature ๐) where
-- |> Similar to occurences of variables in lists, we define
--    the type of occurences of variables in multisorted terms.
  mutual
    data VarPath-๐ฏโTerms : โ{ฮ ฮ : โList (Sort ๐)} -> (t : ๐ฏโTerms ๐ ฮ ฮ) -> {s : Sort ๐} -> (ฮ โ s) -> ๐ฐ ๐ where
      left-Path : โ{ฮ ฮ ฮ'} -> {t : ๐ฏโTerms ๐ ฮ ฮ} -> {t' : ๐ฏโTerms ๐ ฮ' ฮ} -> {s : Sort ๐} -> {v : ฮ โ s}
                  -> (p : VarPath-๐ฏโTerms t v) -> VarPath-๐ฏโTerms (t โ-โง t') v

      right-Path : โ{ฮ ฮ ฮ'} -> {t : ๐ฏโTerms ๐ ฮ ฮ} -> {t' : ๐ฏโTerms ๐ ฮ' ฮ} -> {s : Sort ๐} -> {v : ฮ โ s}
                  -> (p : VarPath-๐ฏโTerms t v) -> VarPath-๐ฏโTerms (t' โ-โง t) v

      incl : โ{ฮ ฯ} -> {t : ๐ฏโTerm ๐ ฮ ฯ} -> {s : Sort ๐} -> {v : ฮ โ s}
                  -> (p : VarPath-Term-๐ร t v) -> VarPath-๐ฏโTerms (incl t) v

    data VarPath-Term-๐ร : โ{ฮ ฯ} -> (t : ๐ฏโTerm ๐ ฮ ฯ) -> {s : Sort ๐} -> (ฮ โ s) -> ๐ฐ ๐ where
      var : โ{ฮ s} -> (x : ฮ โ s) -> VarPath-Term-๐ร (var x) x
      con : โ{ฮ ฮฑs ฮฑ s} {x : ฮ โ s} -> (c : Con ๐ ฮฑs ฮฑ) -> {ts : ๐ฏโTerms ๐ (ฮน ฮฑs) ฮ }
            -> VarPath-๐ฏโTerms ts x
            -> VarPath-Term-๐ร (con c ts) x
-- //





