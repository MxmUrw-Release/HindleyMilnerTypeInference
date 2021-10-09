
module Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.hasBoundaries where

open import Verification.Conventions hiding (_⊔_)
open import Verification.Experimental.Set.Discrete
open import Verification.Experimental.Set.Contradiction
open import Verification.Experimental.Set.Setoid.Definition
open import Verification.Experimental.Set.Function.Surjective
open import Verification.Experimental.Data.Nat.Free
open import Verification.Experimental.Data.Sum.Definition
open import Verification.Experimental.Data.Product.Definition
open import Verification.Experimental.Data.Sum.Instance.Functor
open import Verification.Experimental.Category.Std.Monad.Definition
open import Verification.Experimental.Category.Std.Monad.KleisliCategory.Instance.Monoidal
open import Verification.Experimental.Category.Std.Monad.TypeMonadNotation
open import Verification.Experimental.Data.Sum.Instance.Monad
open import Verification.Experimental.Data.Universe.Everything
open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Definition
open import Verification.Experimental.Theory.Std.Presentation.Token.Definition
open import Verification.Experimental.Category.Std.Category.Definition
open import Verification.Experimental.Category.Std.Functor.Definition
open import Verification.Experimental.Category.Std.Category.Subcategory.Definition
open import Verification.Experimental.Category.Std.Category.Subcategory.Full
open import Verification.Experimental.Data.Indexed.Definition
open import Verification.Experimental.Data.Indexed.Instance.Monoid
open import Verification.Experimental.Data.FiniteIndexed.Definition
open import Verification.Experimental.Algebra.Monoid.Definition
open import Verification.Experimental.Algebra.Monoid.Free
open import Verification.Experimental.Algebra.Monoid.Free.Element
open import Verification.Experimental.Data.Substitution.Definition
open import Verification.Experimental.Data.Substitution.Property.Base
open import Verification.Experimental.Theory.Std.Presentation.NGraph.Definition
open import Verification.Experimental.Category.Std.Limit.Specific.Coproduct.Definition
open import Verification.Experimental.Category.Std.Morphism.Iso
open import Verification.Experimental.Theory.Std.Generic.FormalSystem.Definition
open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Definition
open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.FormalSystem
open import Verification.Experimental.Computation.Unification.Definition
open import Verification.Experimental.Category.Std.Limit.Specific.Coequalizer

open import Verification.Experimental.Category.Std.RelativeMonad.Definition
open import Verification.Experimental.Category.Std.RelativeMonad.KleisliCategory.Definition
open import Verification.Experimental.Theory.Std.Presentation.CheckTree.Definition2
open import Verification.Experimental.Theory.Std.Presentation.CheckTree.FromUnification

open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.PCF

-- open import Verification.Experimental.Theory.Std.Specific.ProductTheory.Instance.FromString2
-- open import Verification.Experimental.Theory.Std.Presentation.CheckTree.Definition2

instance
  isSet-Str:⊤ : isSet-Str (⊤-𝒰 {𝑖})
  isSet-Str:⊤ = {!!}

  isDiscrete:⊤ : isDiscrete (⊤-𝒰 {𝑖})
  isDiscrete:⊤ = {!!}


module _ (A : 𝒰 𝑖) (l : A -> ℕ) where
  data VecTree1 : 𝒰 (𝑖) where
    node1 : (a : A) -> (Vec VecTree1 (l a)) -> VecTree1


module _ {A : 𝒰 𝑖} {R : 人List A -> A -> 𝒰 𝑖} where
  π₀-⋆-⧜ : ∀{as0 as1 bs : 人List A} -> CtxHom R (as0 ⋆ as1) bs -> CtxHom R as0 bs
  π₀-⋆-⧜ (f ⋆-⧜ g) = f

  π₁-⋆-⧜ : ∀{as0 as1 bs : 人List A} -> CtxHom R (as0 ⋆ as1) bs -> CtxHom R as1 bs
  π₁-⋆-⧜ (f ⋆-⧜ g) = g


ι-Fin-R : Fin-R n -> ℕ
ι-Fin-R zero = zero
ι-Fin-R (suc m) = suc (ι-Fin-R m)

instance
  IShow:Fin-R : IShow (Fin-R n)
  IShow:Fin-R = record { show = λ x → show (ι-Fin-R x) }

UntypedCon : ProductTheory 𝑖 -> 𝒰 _
UntypedCon 𝒯 = ∑ λ xs -> ∑ λ x -> Con 𝒯 xs x

module _ (𝒯 : ProductTheory ℓ₀) {{_ : IShow (Sort 𝒯)}} where

  -----------------------------------------
  -- nodes of the NGraph
  data Node (n : 人ℕ) : 𝒰₀ where
    isNode : UntypedCon 𝒯 -> Node n
    isVar :  [ n ]ᶠ -> Node n

  -- l' : UntypedCon 𝒯 -> 人ℕ
  -- l' (τs , τ , _) = map (const tt) (ι τs)

  -- size' : ∀{n} -> Node n -> 人ℕ
  -- size' (isNode n) = l' n
  -- size' (isVar x) = ◌

  -- data Node (n : 人ℕ) : 𝒰₀ where
  --   isTop : Node n
  --   notTop : Node n -> Node n

  size× : ∀{n} -> Node n -> ℕ
  size× (isNode (τs , τ , c)) = length τs
  size× (isVar x) = 0
  -- size (notTop x) = suc size x
  -- size isTop = incl tt

  -----------------------------------------
  -- the category of sorts and substitutions

  -- data SortTermᵈ (n : 人ℕ) : 𝒰₀ where
  --   var : [ n ]ᶠ -> SortTermᵈ n
  --   con : Sort 𝒯 -> SortTermᵈ n

  data SortCon : (List (⊤-𝒰 {ℓ₀})) -> ⊤-𝒰 {ℓ₀} -> 𝒰₀ where
    incl : ∀{α} -> Sort 𝒯 -> SortCon [] α

  instance
    isDiscrete:SortCon : ∀{αs α} -> isDiscrete (SortCon αs α)
    isDiscrete:SortCon = {!!}

  Sort×Theory : ProductTheory ℓ₀
  Sort×Theory = record { Sort = ⊤-𝒰 ; Con = SortCon }


  -- SortTermᵘ : 𝐅𝐢𝐧𝐈𝐱 (⊤-𝒰 {ℓ₀}) -> 𝐈𝐱 (⊤-𝒰 {ℓ₀}) (𝐔𝐧𝐢𝐯 ℓ₀)
  -- SortTermᵘ a = indexed (λ _ → SortTermᵈ ⟨ a ⟩)


{-
  macro SortTerm = #structureOn SortTermᵘ

  instance
    isFunctor:SortTerm : isFunctor (𝐅𝐢𝐧𝐈𝐱 ⊤-𝒰) (𝐈𝐱 ⊤-𝒰 (𝐔𝐧𝐢𝐯 ℓ₀)) SortTerm
    isFunctor.map isFunctor:SortTerm = {!!}
    isFunctor.isSetoidHom:map isFunctor:SortTerm = {!!}
    isFunctor.functoriality-id isFunctor:SortTerm = {!!}
    isFunctor.functoriality-◆ isFunctor:SortTerm = {!!}

  instance
    isRelativeMonad:SortTerm : isRelativeMonad (𝑓𝑖𝑛 ⊤-𝒰) SortTerm
    isRelativeMonad.repure isRelativeMonad:SortTerm = {!!}
    isRelativeMonad.reext isRelativeMonad:SortTerm = {!!}
    isRelativeMonad.reunit-l isRelativeMonad:SortTerm = {!!}
    isRelativeMonad.reunit-r isRelativeMonad:SortTerm = {!!}
    isRelativeMonad.reassoc isRelativeMonad:SortTerm = {!!}
-}

  -- macro
  --   ℬ× : SomeStructure
  --   ℬ× = #structureOn (InductiveSubstitution SortTerm)

  macro
    ℬ× : SomeStructure
    ℬ× = #structureOn (𝐂𝐭𝐱ᵘ Sort×Theory)

  SortTermᵈ : (n : 人ℕ) -> 𝒰₀
  SortTermᵈ n = Term₁-𝕋× Sort×Theory n tt

module _ {𝒯 : ProductTheory ℓ₀} {{_ : IShow (Sort 𝒯)}} where

  instance
    is1Category:ℬ× : is1Category (ℬ× 𝒯)
    is1Category:ℬ× = {!!}

module _ (𝒯 : ProductTheory ℓ₀) {{_ : IShow (Sort 𝒯)}} where
  F× : 人ℕ -> Functor (ℬ× 𝒯) (𝐔𝐧𝐢𝐯 ℓ₀)
  F× n = HomF (incl (n ⋆ incl tt))
  -- f since {!!}
  --   where
  --     f : ℬ× -> 𝐔𝐧𝐢𝐯 ℓ₀
  --     f b = (incl (n ⋆ incl tt) ⟶ b)

  makeSort : SortTermᵈ 𝒯 ◌ -> Sort 𝒯
  makeSort (con (incl c) x) = c
  -- makeSort (con x) = x

module _ {𝒯 : ProductTheory ℓ₀} {{_ : IShow (Sort 𝒯)}} where

  module _ {n : 人ℕ} where
    _⊫_ : ∀{b : ℬ× 𝒯} -> (Γ : CtxHom (λ b a -> Term₁-𝕋× (Sort×Theory 𝒯) b a) n ⟨ b ⟩) -> SortTermᵈ 𝒯 ⟨ b ⟩ -> ⟨ F× 𝒯 n ⟩ b
    _⊫_ {b} Γ τ = ⧜subst (Γ ⋆-⧜ (incl τ))

    module _ {b : ℬ× 𝒯} where
      data isSameCtx : (Γ : CtxHom (Term₁-𝕋× (Sort×Theory 𝒯)) n ⟨ b ⟩)
                       -> (τs : List (Sort 𝒯))
                       -> (vs : Vec (⟨ F× 𝒯 n ⟩ b) (length τs))
                       -> 𝒰 ℓ₀ where
        [] : ∀{Γ} -> isSameCtx Γ [] []
        _∷_ : ∀{Γ τs vs} -> (τ : Sort 𝒯) -> isSameCtx Γ τs vs -> isSameCtx Γ (τ ∷ τs) (Γ ⊫ con (incl τ) ◌-⧜ ∷ vs)

    data isWellTyped× {b : ℬ× 𝒯} : (a : Node 𝒯 n)
                                 -> (v : ⟨ F× 𝒯 n ⟩ b)
                                 -> (vs : Vec (⟨ F× 𝒯 n ⟩ b) (size× 𝒯 a))
                                 -> 𝒰 ℓ₀ where
      varType : (i : [ n ]ᶠ)
                -> ∀{Γ τ}
                -> atList Γ i ≣ τ
                -> isWellTyped× (isVar i) (Γ ⊫ τ) []

      conType : ∀{τs τ} -> (c : Con 𝒯 τs τ)
                -> ∀{Γ vs}
                -> isSameCtx Γ τs vs
                -> isWellTyped× (isNode (_ , _ , c)) (Γ ⊫ (con (incl τ) ◌-⧜)) vs


  -----------------------------------------
  -- boundary definitions

  -- tryMerge× : ∀{n} -> ∀{b0 b1 : ℬ× 𝒯} -> (v0 : ⟨ F× 𝒯 n ⟩ b0) (v1 : ⟨ F× 𝒯 n ⟩ b1)
  --                  -> Maybe (∑ λ bx -> ∑ λ (f0 : b0 ⟶ bx) -> ∑ λ (f1 : b1 ⟶ bx) -> map {{of F× 𝒯 n}} f0 v0 ≡ map {{of F× 𝒯 n}} f1 v1)
  -- tryMerge× {n} {b0} {b1} v0 v1 =
  --   let v0' : ⟨ F× 𝒯 n ⟩ (b0 ⊔ b1)
  --       v0' = v0 ◆ ι₀
  --       v1' : ⟨ F× 𝒯 n ⟩ (b0 ⊔ b1)
  --       v1' = v1 ◆ ι₁
  --   in case unify v0' v1' of
  --        (λ x → nothing)
  --        λ x → right (⟨ x ⟩ , (ι₀ ◆ π₌ , ι₁ ◆ π₌ , {!!}))


  instance
    isCheckingBoundary:× : ∀{n : 人ℕ} -> isCheckingBoundary (ℬ× 𝒯) (HomF (incl n))
    isCheckingBoundary:× = isCheckingBoundary:byUnification (ℬ× 𝒯)
    -- record { tryMerge = tryMerge× }

  private
    initb× : ∀{n} -> Node 𝒯 n → 𝐂𝐭𝐱ᵘ (Sort×Theory 𝒯)
    initb× {n} _ = incl n
    -- (isNode x) = incl {!n!}
    -- initb× {n} (isVar x) = {!!}

    makeNode : ∀{n : ℬ× 𝒯} -> (a : Sort 𝒯) → (incl (⟨ n ⟩ ⋆-Free-𝐌𝐨𝐧 incl tt)) ⟶ n
    makeNode τ = ⧜subst (id-⧜𝐒𝐮𝐛𝐬𝐭' {T = ′ Term-𝕋× (Sort×Theory 𝒯) ′} ⋆-⧜ (incl ((con (incl τ) ◌-⧜))))
    -- ⦗ ⟨ id ⟩ , ⧜subst (incl ((con (incl τ) ◌-⧜))) ⦘

    initv× : ∀{n : ℬ× 𝒯} -> (a : Node 𝒯 ⟨ n ⟩) → (incl (⟨ n ⟩ ⋆-Free-𝐌𝐨𝐧 incl tt)) ⟶ n
    initv× {n} (isNode (τs , τ , x)) = makeNode τ
    initv× {n} (isVar (tt , x)) = ⧜subst (id-⧜𝐒𝐮𝐛𝐬𝐭' {T = ′ Term-𝕋× (Sort×Theory 𝒯) ′} ⋆-⧜ (incl (var x)))
    -- ⦗ id , ⧜subst (incl (var x)) ⦘

    makeNodeVec : ∀{n} -> (τs : List (Sort 𝒯)) → Vec (⟨ F× 𝒯 n ⟩ (incl n)) (length τs)
    makeNodeVec ⦋⦌ = ⦋⦌
    makeNodeVec (x ∷ ts) = makeNode x ∷ makeNodeVec ts

    initvs× : ∀{n} -> (a : Node 𝒯 n) → Vec (⟨ F× 𝒯 n ⟩ (initb× a)) (size× 𝒯 a)
    initvs× {n} (isNode (τs , τ , x)) = makeNodeVec τs
    initvs× {n} (isVar x) = ⦋⦌


    initwt× : ∀{n} -> {a : Node 𝒯 n} → isWellTyped× a (initv× a) (initvs× a)
    initwt× {n} {isNode (τs , τ , x)} = conType x samectxP
      where
        samectxP : ∀{τs : List (Sort 𝒯)} -> isSameCtx (id-⧜𝐒𝐮𝐛𝐬𝐭' {T = ′ Term-𝕋× (Sort×Theory 𝒯) ′}) τs (makeNodeVec τs)
        samectxP {⦋⦌} = []
        samectxP {x ∷ ts} = x ∷ samectxP
    initwt× {n} {isVar (tt , x)} = varType (tt , x) (varlistP x)
      where
        varlistP : ∀{n : 人ℕ} -> (x : n ∍ tt) -> atList (id-⧜𝐒𝐮𝐛𝐬𝐭' {T = ′ Term-𝕋× (Sort×Theory 𝒯) ′}) (tt , x) ≣ var x
        varlistP x = ≡→≡-Str λ i -> inv-l-◆-construct-CtxHom {R = Term₁-𝕋× (Sort×Theory 𝒯)} (λ _ v -> var v) i tt x

    map-WT× : ∀{n} -> {b x : 𝐂𝐭𝐱ᵘ (Sort×Theory 𝒯)} {a : Node 𝒯 n}
              {v0 : ⟨ F× 𝒯 n ⟩ b} {vs : Vec (⟨ F× 𝒯 n ⟩ b) (size× 𝒯 a)}
              (ϕ : b ⟶ x) →
              isWellTyped× a v0 vs →
              isWellTyped× a (isFunctor.map (_:&_.of F× 𝒯 n) ϕ v0)
              (map-Vec (isFunctor.map (_:&_.of F× 𝒯 n) ϕ) vs)
    map-WT× {b} {x} {a} {.(isVar i)} {.(Γ ⊫ τ)} ϕ (varType i {Γ = Γ} {τ = τ} x₁) = varType i (mapatlist i {Γ = Γ} {τ = τ} x₁)
      where
        mapatlist : ∀{b} -> ∀(i : [ b ]ᶠ)-> ∀{Γ : CtxHom (Term₁-𝕋× (Sort×Theory 𝒯)) b ⟨ x ⟩} -> {τ : Term₁-𝕋× (Sort×Theory 𝒯) ⟨ x ⟩ tt}
                    -> atList {R = Term₁-𝕋× (Sort×Theory 𝒯)} Γ i ≣ τ
                    -> atList {R = Term₁-𝕋× (Sort×Theory 𝒯)}
                        (construct-CtxHom
                        (λ a₁ x₂ →
                            (destruct-CtxHom ⟨ Γ ⊫ τ ⟩ ◆-𝐈𝐱 subst-⧜𝐒𝐮𝐛𝐬𝐭 ϕ) a₁ (left-∍ x₂)))
                        i
                        ≣ (destruct-CtxHom ⟨ Γ ⊫ τ ⟩ ◆-𝐈𝐱 subst-⧜𝐒𝐮𝐛𝐬𝐭 ϕ) tt (right-∍ incl)
        mapatlist (tt , incl) {incl x}  refl-≣ = refl-≣
        mapatlist (tt , right-∍ i) {G ⋆-⧜ H}  refl-≣ = mapatlist (tt , i) {Γ = H} refl-≣
        mapatlist (tt , left-∍ i) {G ⋆-⧜ H} {t} refl-≣ = mapatlist (tt , i) {Γ = G} refl-≣

    map-WT× {b} {x} {a} {.(isNode (_ , _ , c))} {.(_ ⊫ con (incl _) ◌-⧜)} ϕ (conType {τs} {τ} c {Γ} {vs} p) = conType c (mapcon Γ τ τs vs p)
      where
        mapcon : ∀{b} -> (Γ : CtxHom (Term₁-𝕋× (Sort×Theory 𝒯)) b ⟨ x ⟩) -> (τ : Sort 𝒯)
                 -> (τs : List (Sort 𝒯))
                 -> (vs : Vec (⟨ F× 𝒯 b ⟩ x) (length τs))
                 -> isSameCtx Γ τs vs
                 -> isSameCtx
                    (construct-CtxHom
                    (λ a₁ x₂ →
                        (destruct-CtxHom (Γ ⋆-⧜ incl {a = a₁} (con (incl τ) ◌-⧜)) ◆-𝐈𝐱
                        subst-⧜𝐒𝐮𝐛𝐬𝐭 ϕ)
                        a₁ (left-∍ x₂)))
                    τs (map-Vec (isFunctor.map (_:&_.of F× 𝒯 b) ϕ) vs)
        mapcon Γ τ .⦋⦌ .⦋⦌ [] = []
        mapcon Γ τ .(τ₁ ∷ _) .((Γ ⊫ con (incl τ₁) ◌-⧜) ∷ _) (τ₁ ∷ p) = τ₁ ∷ mapcon Γ τ _ _ p

  instance
    hasBoundary:× : ∀{n} -> hasBoundary (ℬ× 𝒯) (F× 𝒯 n) (Node 𝒯 n) (size× 𝒯)
    hasBoundary:× = record
                      { initb = initb×
                      ; initv = initv×
                      ; initvs = initvs×
                      ; WT = isWellTyped×
                      ; initwt = initwt×
                      ; map-WT = map-WT×
                      }

  instance
    isSet-Str:ℬ× : isSet-Str (ℬ× 𝒯)
    isSet-Str:ℬ× = {!!}

{-
-}
{-
-}


{-
  module §-SortTerm where
    prop-1 : ∀{n : 人ℕ} -> n ∼ ◌ -> SortTermᵈ n -> Sort 𝒯
    prop-1 {n} n∼◌ (var (a , x)) = impossible p4
      where
        p1 : el n ≅ el ◌
        p1 = cong-∼ n∼◌

        p2 : ix (el n) a
        p2 = x

        p3 : ix (el ◌) a
        p3 = ⟨ p1 ⟩ a p2

        p4 : 𝟘-𝒰
        p4 with p3
        ... | ()

    prop-1 {n} n∼◌ (con x) = x

    prop-2 : ∀{m n : 人ℕ} -> n ∼ ◌ -> Hom-⧜𝐒𝐮𝐛𝐬𝐭 {T = SortTerm} (incl (m ⋆ incl tt)) (incl n) -> 人List (Sort 𝒯) × Sort 𝒯
    prop-2 n∼◌ (f ⋆-⧜ incl x) = map (prop-1 n∼◌) f' , (prop-1 n∼◌ x)
      where
        f' = §-⧜𝐒𝐮𝐛𝐬𝐭-⊤.prop-1 {T = SortTerm} (f)

  getCtx : ∀{m n : 人ℕ} -> Hom-⧜𝐒𝐮𝐛𝐬𝐭 {T = SortTerm} (incl (m ⋆ incl tt)) (incl n) -> 人List (SortTermᵈ n)
  -- [ m ]ᶠ -> SortTermᵈ n
  getCtx s = asList (π₀-⋆-⧜ s)

  getRet : ∀{m n : 人ℕ} -> Hom-⧜𝐒𝐮𝐛𝐬𝐭 {T = SortTerm} (incl (m ⋆ incl tt)) (incl n) -> SortTermᵈ n
  getRet (f ⋆-⧜ incl g) = g

  makeSort : SortTermᵈ ◌ -> Sort 𝒯
  makeSort (con x) = x
-}
