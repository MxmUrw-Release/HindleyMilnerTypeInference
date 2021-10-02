
module Verification.Experimental.Theory.Std.Presentation.CheckTree.Definition2 where

open import Verification.Conventions
open import Verification.Experimental.Set.Function.Surjective
open import Verification.Experimental.Set.Setoid.Definition
open import Verification.Experimental.Set.Set.Definition
open import Verification.Experimental.Set.Discrete
open import Verification.Experimental.Algebra.Monoid.Definition
open import Verification.Experimental.Algebra.Monoid.Free
open import Verification.Experimental.Algebra.Monoid.Free.Element
open import Verification.Experimental.Data.Product.Definition
open import Verification.Experimental.Data.Sum.Definition
open import Verification.Experimental.Data.Nat.Free
open import Verification.Experimental.Data.Sum.Instance.Functor
open import Verification.Experimental.Data.Universe.Everything
open import Verification.Experimental.Category.Std.Category.Definition
open import Verification.Experimental.Category.Std.Morphism.Iso
open import Verification.Experimental.Category.Std.Functor.Definition
open import Verification.Experimental.Data.FiniteIndexed.Property.Merge
open import Verification.Experimental.Data.Indexed.Definition
open import Verification.Experimental.Data.Indexed.Instance.Monoid
open import Verification.Experimental.Data.Universe.Everything
open import Verification.Experimental.Data.Universe.Instance.Semiring

open import Verification.Experimental.Category.Std.Monad.Definition
open import Verification.Experimental.Category.Std.Monad.KleisliCategory.Instance.Monoidal
open import Verification.Experimental.Category.Std.Monad.TypeMonadNotation
open import Verification.Experimental.Data.Sum.Instance.Monad


record isCheckingBoundary (ℬ : Category 𝑖) (F : Functor ℬ (𝐔𝐧𝐢𝐯 𝑗)) : 𝒰 (𝑖 ､ 𝑗) where
  field tryMerge : ∀{b0 b1 : ⟨ ℬ ⟩} -> (v0 : ⟨ F ⟩ b0) (v1 : ⟨ F ⟩ b1)
                   -> Maybe (∑ λ bx -> ∑ λ (f0 : b0 ⟶ bx) -> ∑ λ (f1 : b1 ⟶ bx) -> map f0 v0 ≡ map f1 v1)

open isCheckingBoundary {{...}} public

module _ {ℬ : 𝒰 𝑖} {{_ : isCategory {𝑗} ℬ}} {{_ : isSet-Str ℬ}} {F : Functor ′ ℬ ′ (𝐔𝐧𝐢𝐯 𝑙)} {{_ : isCheckingBoundary ′ ℬ ′ F}}
       where

  record ResolutionTarget (as : 人List ℬ) : 𝒰 (𝑖 ､ 𝑙) where
    constructor rtarget
    field fst : ℬ
    field snd : as ∍ fst
    field thd : ⟨ F ⟩ fst

  ResolutionPair : (as bs : 人List ℬ) -> 𝒰 _
  ResolutionPair as bs = ResolutionTarget as × ResolutionTarget bs

  data Strategy : (as : 人List ℬ) -> 𝒰 (𝑖 ､ 𝑙) where
    begin : ∀ a -> Strategy (incl a)
    resolve : ∀{as bs} -> Strategy as -> Strategy bs
            -- -> (as ∍ a) -> (bs ∍ b) -> ⟨ F ⟩ a -> ⟨ F ⟩ b
            -> ResolutionPair as bs
            -> Strategy (as ⋆ bs)

  data _∍-St_ : ∀{xs} -> (s : Strategy xs) -> ∀{as bs} -> (p : ResolutionPair as bs) -> 𝒰 (𝑖 ､ 𝑙) where
    incl : ∀{as bs} -> {sa : Strategy as} -> {sb : Strategy bs}
            -> (p : ResolutionPair as bs)
            -> resolve sa sb p ∍-St p
    left-∍ : ∀{as bs} -> {sa : Strategy as} -> {sb : Strategy bs}
            -> {p : ResolutionPair as bs}
            -> ∀{as' bs'} -> {q : ResolutionPair as' bs'} -> sa ∍-St q
            -> resolve sa sb p ∍-St q

    right-∍ : ∀{as bs} -> {sa : Strategy as} -> {sb : Strategy bs}
            -> {p : ResolutionPair as bs}
            -> ∀{as' bs'} -> {q : ResolutionPair as' bs'} -> sb ∍-St q
            -> resolve sa sb p ∍-St q

  data Execution : ∀{as} -> Strategy as -> (x : ℬ) -> 𝒰 (𝑖 ､ 𝑗 ､ 𝑙) where
    begin : ∀{a} -> Execution (begin a) a
    resolve : ∀{as bs xa xb x} -> {sa : Strategy as} -> {sb : Strategy bs}
            -> (exa : Execution sa xa) -> (exb : Execution sb xb)
            -- -> {pa : as ∍ a} -> {pb : bs ∍ b} -> {va : ⟨ F ⟩ a} -> {vb : ⟨ F ⟩ b}
            -> {p : ResolutionPair as bs}
            -> (fa : xa ⟶ x) -> (fb : xb ⟶ x)
            -> Execution (resolve sa sb p) x

  baseSt : ∀{xs} -> {s : Strategy xs} -> ∀{as bs} -> {p : ResolutionPair as bs} -> s ∍-St p -> Strategy (as ⋆ bs)
  baseSt (incl {sa = sa} {sb} p) = resolve sa sb p
  baseSt (left-∍ p) = baseSt p
  baseSt (right-∍ p) = baseSt p

  extendPath : ∀{xs a} -> {s : Strategy xs} -> ∀{as bs} -> {p : ResolutionPair as bs} -> s ∍-St p -> (as ⋆ bs ∍ a) -> xs ∍ a
  extendPath (incl _) r = r
  extendPath (left-∍ q) r = left-∍ (extendPath q r)
  extendPath (right-∍ q) r = right-∍ (extendPath q r)

  -- subexec : ∀{as bs xs} -> {s : Strategy xs} -> {x : ℬ} -> (Execution s x) -> {p : ResolutionPair as bs} -> (q : s ∍-St p) -> Execution (baseSt q) 

  execHom : ∀{as a} -> {sa : Strategy as} -> {x : ℬ} -> (Execution sa x) -> (pa : as ∍ a) -> a ⟶ x
  execHom begin incl = id
  execHom (resolve exa exb fa fb) (right-∍ pa) = execHom exb pa ◆ fb
  execHom (resolve exa exb fa fb) (left-∍ pa) = execHom exa pa ◆ fa

  -- execHom : ∀{xs as a} -> {s : Strategy xs} -> {x : ℬ} -> (Execution s x) -> (pa : as ∍ a) -> a ⟶ x
  -- execHom begin incl = {!!}
  -- execHom (resolve exa exb fa fb) (right-∍ pa) = execHom exb pa ◆ fb
  -- execHom (resolve exa exb fa fb) (left-∍ pa) = execHom exa pa ◆ fa

  isCorrect : ∀{xs x} -> {s : Strategy xs} -> (ex : Execution s x) -> 𝒰 _
  isCorrect {xs} {x} {s} ex = ∀{as bs} -> ∀((rtarget a pa va , rtarget b pb vb) : ResolutionPair as bs)
                              -> (q : s ∍-St (rtarget a pa va , rtarget b pb vb))
                              -> map (execHom ex (extendPath q (left-∍ pa))) va ≡ map (execHom ex (extendPath q (right-∍ pb))) vb

  execute : ∀{as} -> (sa : Strategy as) -> Maybe (∑ λ x -> ∑ λ (ex : Execution sa x) -> isCorrect ex)
  execute (begin a) = just (_ , (begin , {!!}))
  execute (resolve sa sb (rtarget a pa va , rtarget b pb vb)) = do
    xa , exa , exaP <- execute sa
    xb , exb , exbP <- execute sb

    let va' = map (execHom exa pa) va
    let vb' = map (execHom exb pb) vb

    case tryMerge va' vb' of
      (λ _ → nothing)
      (λ (x , fa , fb , fa≡fb) →
        right (x , (resolve exa exb fa fb)
              , λ {(p1 , p2) (incl _) → {!!}
                  ;(p1 , p2) (left-∍ q) -> {!!}
                  ;(p1 , p2) (right-∍ q) -> {!!}
                  })
        )






