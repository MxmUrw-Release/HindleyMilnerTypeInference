
module Verification.Core.Theory.Std.Specific.ProductTheory.Variant.Unification.Definition where

open import Verification.Conventions hiding (_β_)

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



record ProductTheory (π : π) : π° (π βΊ) where
  field Sort : π° π
  field {{isDiscrete:Sort}} : isDiscrete Sort
  field {{isSet-Str:Sort}} : isSet-Str Sort
  field Con : List Sort -> Sort -> π° π
  field {{isDiscrete:Con}} : β{Ξ±s Ξ±} -> isDiscrete (Con Ξ±s Ξ±)
open ProductTheory public

module _ (π : π) where
  macro πΓ = #structureOn (ProductTheory π)

  π = ProductTheory π

Type-πΓ : ProductTheory π -> π° π
Type-πΓ a = Sort a



data Termβ-πΓ (a : πΓ π) : (Ξ : βList (Type-πΓ a)) (Ο : Type-πΓ a) -> π° π where
  var : β{Ο Ξ} -> Ξ β Ο -> Termβ-πΓ a Ξ Ο
  con : β{Ξ Ξ±s Ξ±} -> (c : Con a Ξ±s Ξ±) -> CtxHom (Termβ-πΓ a) ((ΞΉ Ξ±s)) (Ξ) -> Termβ-πΓ a Ξ Ξ±


Term-πΓ : (a : πΓ π) -> (ππ’π§ππ± (Type-πΓ a)) -> (ππ± (Type-πΓ a) (ππ§π’π― π))
Term-πΓ a Ξ = indexed (Ξ» Ο β Termβ-πΓ a β¨ Ξ β© Ο)

Terms-πΓ : (π¨ : πΓ π) -> (Ξ : ππ’π§ππ± (Type-πΓ π¨)) -> (Ξ : ππ’π§ππ± (Type-πΓ π¨)) -> π° π
Terms-πΓ π¨ Ξ Ξ = CtxHom (Termβ-πΓ π¨) β¨ Ξ β© β¨ Ξ β©

εTerm = Termβ-πΓ

ε¨Term = Terms-πΓ


module _ {π¨ : πΓ π} where
  mutual
    data VarPath-Terms-πΓ : β{Ξ Ξ} -> (t : Terms-πΓ π¨ Ξ Ξ) -> {s : Sort π¨} -> (β¨ Ξ β© β s) -> π° π where
      left-Path : β{Ξ Ξ Ξ'} -> {t : Terms-πΓ π¨ Ξ Ξ} -> {t' : Terms-πΓ π¨ Ξ' Ξ} -> {s : Sort π¨} -> {v : β¨ Ξ β© β s}
                  -> (p : VarPath-Terms-πΓ t v) -> VarPath-Terms-πΓ (t β-β§ t') v

      right-Path : β{Ξ Ξ Ξ'} -> {t : Terms-πΓ π¨ Ξ Ξ} -> {t' : Terms-πΓ π¨ Ξ' Ξ} -> {s : Sort π¨} -> {v : β¨ Ξ β© β s}
                  -> (p : VarPath-Terms-πΓ t v) -> VarPath-Terms-πΓ (t' β-β§ t) v

      incl : β{Ξ Ο} -> {t : Termβ-πΓ π¨ Ξ Ο} -> {s : Sort π¨} -> {v : Ξ β s}
                  -> (p : VarPath-Term-πΓ t v) -> VarPath-Terms-πΓ (incl t) v

    data VarPath-Term-πΓ : β{Ξ Ο} -> (t : Termβ-πΓ π¨ Ξ Ο) -> {s : Sort π¨} -> (Ξ β s) -> π° π where
      var : β{Ξ s} -> (x : Ξ β s) -> VarPath-Term-πΓ (var x) x
      con : β{Ξ Ξ±s Ξ± s} {x : Ξ β s} -> (c : Con π¨ Ξ±s Ξ±) -> {ts : Terms-πΓ π¨ (incl (ΞΉ Ξ±s)) (incl Ξ) }
            -> VarPath-Terms-πΓ ts x
            -> VarPath-Term-πΓ (con c ts) x



