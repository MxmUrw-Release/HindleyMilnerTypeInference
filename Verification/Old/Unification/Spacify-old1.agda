

{-# OPTIONS --rewriting #-}

module Verification.Unification.Spacify-old1 where

open import Verification.Conventions
open import Verification.Core.Type
open import Verification.Core.Algebra
open import Verification.Core.Order
open import Verification.Core.Category.Definition
open import Verification.Core.Category.Monad
open import Verification.Core.Category.Quiver
open import Verification.Core.Category.FreeCategory
open import Verification.Core.Category.Functor
open import Verification.Core.Category.Instance.Type
open import Verification.Core.Category.Instance.SmallCategories
open import Verification.Core.Category.Instance.TypeProperties
open import Verification.Core.Category.Instance.Set
open import Verification.Core.Category.KanLimit.Definition
open import Verification.Core.Category.Monad
open import Verification.Unification.RecAccessible
open import Verification.Core.Homotopy.Level


{-# BUILTIN REWRITE _โก_ #-}

--------------------------------------------------------------------
-- == The functor to Recursion Modules
-- | Let A, B, C be sets, and let $T$ be a fixed \AD{RecMonad} in this section.

-- Monoid:Path : Quiver ๐ -> Monoid (๐ โ 0 โ ๐ โ 1)
-- โจ Monoid:Path Q โฉ = Maybe (โ ฮป (x : โจ Q โฉ) -> โ ฮป (y : โจ Q โฉ) -> Edge {{of Q}} x y)
-- IMonoid.๐ท (of Monoid:Path Q) = {!!}
-- IMonoid._โ_ (of Monoid:Path Q) = {!!}
-- IMonoid.assoc-โ (of Monoid:Path Q) = {!!}
-- IMonoid.unit-l-โ (of Monoid:Path Q) = {!!}
-- IMonoid.unit-r-โ (of Monoid:Path Q) = {!!}

mirror : โ{๐ : Category ๐} {๐ : Category ๐} -> Functor ๐ (๐ แตแต) -> Functor (๐ แตแต) ๐
โจ mirror F โฉ = โจ F โฉ
IFunctor.map (of mirror F) = map
IFunctor.functoriality-id (of mirror F) = functoriality-id
IFunctor.functoriality-โ (of mirror F) = functoriality-โ
IFunctor.functoriality-โฃ (of mirror F) = functoriality-โฃ

byFirstP : โ{A : ๐ฐ ๐} {B : A -> ๐ฐ ๐} {{_ : โ{a : A} -> IHType 1 (B a)}}
           -> {a1 a2 : A} {b1 : B a1} {b2 : B a2} -> (p : a1 โก a2)
           -> PathP (ฮป i -> โ ฮป (a : A) -> B a) (a1 , b1) (a2 , b2)
byFirstP = {!!}


PSh : (๐ : Category ๐) -> โ ๐ -> ๐ฐ _
PSh ๐ ๐ = Functor (๐ แตแต) `(Set ๐)`


module _ {K : ๐ฐ ๐} (T : Functor `(IdxSet K ๐)` `(IdxSet K ๐)`) {{_ : IMonad T}} {{_ : IRecAccessible-Monad T}} where
  private
    Q : Quiver (๐ , ๐ , ๐)
    โจ Q โฉ = K
    IQuiver.Edge (of Q) a b = Maybe (Edge {{Dir}} a b)
    IQuiver._โ_ (of Q) = _โก_
    IQuiver.IEquivInst (of Q) = IEquiv:Path

  ๐ = (Category:Free Q)

  instance _ = of ๐
  instance _ = of Q

  Mod : IdxSet K ๐ -> K -> Set ๐
  โจ Mod X k โฉ = โ ฮป j -> Hom {{of ๐}} j k ร-๐ฐ (๐-๐ฐ +-๐ฐ (โจ โจ T โฉ X โฉ j))
  of Mod X k = {!!}

  private
    data isNormal {A : IdxSet K ๐} {k} : โจ Mod A k โฉ -> ๐ฐ (๐) where
      anything : โ{a : โจ Mod A k โฉ} -> isNormal a
        -- by-[] : โ{a : โจ T โฉ A} -> (depth a โก 0 -> ๐-๐ฐ) -> isNormal ([] , a)
        -- by-depth : โ{ds} -> โ{a : โจ T โฉ A} -> depth a โก 0 -> isNormal (ds , a)

    instance
      IProp:isNormal : โ{A : IdxSet K ๐} {k} {a : โจ Mod A k โฉ} -> IHType 1 (isNormal a)
      IProp:isNormal = {!!}

  Mod-Normal : IdxSet K ๐ -> K -> Set ๐
  โจ Mod-Normal X k โฉ = โ ฮป (a : โจ Mod X k โฉ) -> isNormal a
  of Mod-Normal X k = {!!}

  -- syntax โจ_โฉ (โจ_โฉ a) = โจโจ_โฉโฉ a

  private
    module _ {X : IdxSet K ๐} where

      -- ฮฝ-impl-1 : {j : K} {k : K} -> (p : Edge {{of Q}} k j) -> โจ โจ T โฉ X โฉ j -> Maybe (๐-๐ฐ +-๐ฐ (โจ โจ T โฉ X โฉ k))
      -- ฮฝ-impl-1 nothing x = just (left โ)
      -- ฮฝ-impl-1 (just e) x with โจ โจ decompose โฉ โฉ _ x
      -- ... | left _ = nothing
      -- ... | just xs = just (xs _ e)

      ฮฝ-impl : {j : K} {k : K} -> (p : QPath {{of Q}} j k) -> ๐-๐ฐ +-๐ฐ โจ โจ T โฉ X โฉ j -> โจ Mod X k โฉ
      ฮฝ-impl p (left x) = _ , id , left โ
      ฮฝ-impl (last nothing) (right x) = _ , id , left โ
      ฮฝ-impl (last (just e)) (right x) with split-+ (โจ โจ decompose โฉ โฉ _ x)
      ... | left _        = _ , some (last (just e)) , right x
      ... | just (xs , _) = _ , id , (xs _ e)
      ฮฝ-impl (nothing โท p) (right x) = _ , id , left โ
      ฮฝ-impl (just e โท p) (right x) with split-+ (โจ โจ decompose โฉ โฉ _ x)
      ... | left _        = _ , some (just e โท p) , right x
      ... | just (xs , _) = ฮฝ-impl p (xs _ e)

      ฮฝ : โ{k} -> โจ Mod X k โฉ -> โจ Mod X k โฉ
      ฮฝ (j , id-Q , x) = (j , id-Q , x)
      ฮฝ (j , some p , x) = ฮฝ-impl p x


      isNormal-ฮฝ : โ{k} -> โ(x : โจ Mod X k โฉ) -> isNormal (ฮฝ x)
      isNormal-ฮฝ x = anything

      ฮฝโ : โ{k} -> โจ Mod X k โฉ -> โจ Mod-Normal X k โฉ
      ฮฝโ x = ฮฝ x , isNormal-ฮฝ x

      idempotent-ฮฝ : โ{k} -> โ{x : โจ Mod X k โฉ} -> ฮฝ (ฮฝ x) โก ฮฝ x
      idempotent-ฮฝ = {!!}

      write : โ{k j} -> (e : Edge {{of Q}} k j) -> โจ Mod X k โฉ -> โจ Mod X j โฉ
      write e (_ , p , x) = (_ , p โ ` e ` , x)

      write-comm-impl : {j k l : K} -> (e : Edge {{of Q}} k l) -> (p : QPath {{of Q}} j k) -> (x : ๐-๐ฐ +-๐ฐ โจ โจ T โฉ X โฉ j) -> ฮฝ (write e (ฮฝ-impl p x)) โก ฮฝ-impl (comp-QPath p (last e)) x
      write-comm-impl e p (left x) = refl
      write-comm-impl f (last (nothing)) (just x) = refl
      write-comm-impl f (last (just xโ)) (just x) with split-+ (โจ โจ decompose โฉ โฉ _ x)
      ... | just _ = refl
      ... | left P with split-+ (โจ โจ decompose โฉ โฉ _ x)
      ... | left _ = refl
      ... | just Q = {!!} -- ๐-elim (leftโขright (snd P โปยน โ snd Q))
      write-comm-impl f (e โท p) (just x) = {!!}
      -- write-comm-impl e' (last e) x with (ฮฝ-impl-1 _ e x)
      -- ... | just X = {!!}
      -- ... | left xโ = {!!}
      -- with split-+ (ฮฝ-impl-1 _ e x)
      -- ... | left xโ = {!!}
      -- ... | just xโ = {!!}
      -- write-comm-impl e' (e โท p) x = {!!}

      write-comm : โ{k j} -> (e : Edge {{of Q}} k j) -> (x : โจ Mod X k โฉ)-> ฮฝ (write e (ฮฝ x)) โก ฮฝ (write e x)
      write-comm e (j , id-Q , x) = refl
      write-comm e (j , some p , x) = write-comm-impl e p x
      -- write-comm e (j , p , left x) = refl
      -- write-comm e (j , id-Q , just x) = refl
      -- write-comm e (j , some p , just x) = ?

{-
    module _ {X Y : IdxSet K ๐} where
      apply : โ{k} -> (f : X โถ โจ T โฉ Y) -> โจ Mod X k โฉ -> โจ Mod Y k โฉ
      apply f (_ , p , left x) = (_ , p , left x)
      apply f (_ , p , right x) = (_ , p , right (โจ f =<< โฉ _ x))

      apply-comm : โ{k} -> (f : X โถ โจ T โฉ Y) -> (x : โจ Mod X k โฉ) -> ฮฝ (apply f (ฮฝ x)) โก ฮฝ (apply f x)
      apply-comm f x = {!!}
      -- (_ , p , x) = (_ , ` e ` โ p , x)

  ๐บ : IdxSet K ๐ -> PSh ๐ ๐
  ๐บ X = free-Diagram f
    where f : QuiverHom (Q) (ForgetCategory ` Set ๐ `)
          โจ f โฉ k = Mod-Normal X k
          โจ IQuiverHom.qmap (of f) e โฉ (x , _) = ฮฝโ (write e x)
          of IQuiverHom.qmap (of f) e = record {}

  private
    module _ {X Y : IdxSet K ๐} (f : X โถ โจ T โฉ Y) where
      g' : โ{k} -> โจ Mod X k โฉ -> โจ Mod Y k โฉ
      g' ((j , p , left a)) = ((j , p , left a)) -- normaliz
      g' ((j , p , just x)) = (j , p , just (โจ f =<< โฉ j x))

      g : โ(k : K) -> โจ ๐บ X โฉ k โถ โจ ๐บ Y โฉ k
      โจ g k โฉ (x , xp) = ฮฝโ (apply f x)

      -- โจ g k โฉ ((j , p , left a) , _) = ฮฝ ((j , p , left a)) -- ฮฝ (j , p , {!!}) -- (j , p ,  โจ f =<< โฉ j x)
      -- โจ g k โฉ ((j , p , just x) , _) = ฮฝ (j , p , just (โจ f =<< โฉ j x)) -- (j , p ,  โจ f =<< โฉ j x)
      of g k = record {}

      gp : {a b : K} (e : Maybe (Edge {{Dir}} a b)) (x : โจ โจ ๐บ X โฉ a โฉ) โ
            โจ map {{of ๐บ Y}} (โฉ e) โฉ (โจ g a โฉ x) โก
            โจ g b โฉ (โจ map {{of ๐บ X}} (โฉ e) โฉ x)
      gp e ((j , p , left x) , _) = byFirstP refl
      gp e ((j , p , just x) , pp) = byFirstP P

       where P : ฮฝ (write e (ฮฝ (apply f (j , p , just x))))
                  โก
                ฮฝ (apply f (ฮฝ (write e (j , p , just x))))
             P = write-comm e (apply f (j , p , just x)) โ apply-comm f (write e (j , p , just x)) โปยน

       -- where P : ฮฝ (write e ((ฮฝ (j , p , just (โจ f =<< โฉ j x)))))
       --            โก
       --          ฮฝ (apply f ((ฮฝ ((j , ` e ` โ p , just x)))))
       --       P = {!!}

       -- where P : ฮฝ
       --          (fst (fst (ฮฝ (j , p , just (โจ f =<< โฉ j x)))) ,
       --          ` e ` โ
       --          (fst (snd (fst (ฮฝ (j , p , just (โจ f =<< โฉ j x))))))
       --          , snd (snd (fst (ฮฝ (j , p , just (โจ f =<< โฉ j x))))))
       --          โก
       --          ฮฝ (g' (fst (ฮฝ ((j , ` e ` โ p , just x)))))
       --       P = {!!}



        -- where P : ฮฝ
        --         (fst (fst (ฮฝ (j , p , just (โจ f =<< โฉ j x)))) ,
        --         ` e ` โ
        --         (fst (snd (fst (ฮฝ (j , p , just (โจ f =<< โฉ j x))))))
        --         , snd (snd (fst (ฮฝ (j , p , just (โจ f =<< โฉ j x))))))
        --         โก
        --         ((ฮฝ (g' (j , ` e ` โ p , just x))))
        --       P = {!!}

  module _ {X Y : IdxSet K ๐} where
    map-๐บ : (f : X โถ โจ T โฉ Y) -> ๐บ X โถ ๐บ Y
    map-๐บ f = free-Diagram-Natimpl (g f) (ฮป e x -> gp f e x)

-}


      -- where g : โ(k : K) -> โจ ๐บ X โฉ k โถ โจ ๐บ Y โฉ k
      --       โจ g k โฉ ((j , p , left a) , _) = ฮฝ ((j , p , left a)) -- ฮฝ (j , p , {!!}) -- (j , p ,  โจ f =<< โฉ j x)
      --       โจ g k โฉ ((j , p , just x) , _) = ฮฝ (j , p , just (โจ f =<< โฉ j x)) -- (j , p ,  โจ f =<< โฉ j x)
      --       of g k = record {}

      --       gp : {a b : K} (e : Maybe (Edge {{Dir}} a b)) (x : โจ โจ ๐บ X โฉ a โฉ) โ
      --             โจ map {{of ๐บ Y}} (โฉ e) โฉ (โจ g a โฉ x) โก
      --             โจ g b โฉ (โจ map {{of ๐บ X}} (โฉ e) โฉ x)
      --       gp e ((j , p , left x) , _) = {!!}
      --       gp e ((j , p , just x) , _) = {!!}


            -- gp2 : {a b : K}
            --         (e : ๐-๐ฐ +-๐ฐ Edge {{Dir}} a b)
            --         (x
            --         : ฮฃ (ฮฃ K (ฮป j โ ฮฃ (Hom {{of ๐ แตแต}} j a) (ฮป aโ โ ๐-๐ฐ +-๐ฐ โจ โจ T โฉ X โฉ j)))
            --           (isNormal X a)) โ
            --         ฮฝ
            --         (fst (fst (โจ g a โฉ x)) ,
            --         (some (last e)) โ (fst (snd (fst (โจ g a โฉ x)))) ,
            --         snd (snd (fst (โจ g a โฉ x))))
            --         โก
            --         โจ g b โฉ
            --         (ฮฝ
            --         (fst (fst x) ,
            --           (some (last e)) โ (fst (snd (fst x)))  ,
            --           snd (snd (fst x))))
            -- gp2 = {!!}
    -- โจ โจ map-๐บ f โฉ {x = k} โฉ ((j , p , x) , _) = ฮฝ (j , p ,  โจ f =<< โฉ j x)
    -- of โจ map-๐บ f โฉ = record {}
    -- INatural.naturality (of map-๐บ f) = {!!}


  -- Functor:๐บ : Functor `(Kleisli ` T `)` `(PSh ๐ ๐)`
  -- โจ Functor:๐บ โฉ = ๐บ
  -- IFunctor.map (of Functor:๐บ) = map-๐บ
  -- IFunctor.functoriality-id (of Functor:๐บ) = {!!}
  -- IFunctor.functoriality-โ (of Functor:๐บ) = {!!}
  -- IFunctor.functoriality-โฃ (of Functor:๐บ) = {!!}


{-
  ๐ = Monoid:Free Dir

  private
    Mon : โ(A : ๐ฐ ๐) -> MonoidModule ๐ ๐
    Mon A = MonoidModule:Free ๐ (โจ T โฉ A)

  norm' : โจ ๐ โฉ -> โจ T โฉ A -> โจ Mon A โฉ
  norm' [] a = ([] , a)
  norm' (d โท ds) a with โจ decompose โฉ a
  ... | left x = (d โท ds , a)
  ... | just x = norm' ds (x d)

  norm : โจ Mon A โฉ -> โจ Mon A โฉ
  norm (ds , a) = norm' ds a



  private
    data isNormal : โจ Mon A โฉ -> ๐ฐ (๐ โบ) where
       by-[] : โ{a : โจ T โฉ A} -> (depth a โก 0 -> ๐-๐ฐ) -> isNormal ([] , a)
       by-depth : โ{ds} -> โ{a : โจ T โฉ A} -> depth a โก 0 -> isNormal (ds , a)

    lem::1 : โ(a : โจ Mon A โฉ) -> isNormal a -> norm a โก a
    lem::1 ([] , a) P = refl
    lem::1 (d โท ds , a) (by-depth P) with โจ decompose โฉ a | strict a
    ... | left aโ | X = refl
    ... | just aโ | X =
      let Pโ : depth (aโ d) < depth a
          Pโ = X d

          Pโ : depth (aโ d) < 0
          Pโ = transport (ฮป i -> depth (aโ d) < P i) Pโ

          Pโ : ๐-๐ฐ
          Pโ = Pโ .snd (โค0โโก0 (Pโ .fst))

      in ๐-elim Pโ

    lem::2 : โ(ds : โจ ๐ โฉ) -> (a : โจ T โฉ A) -> isNormal (norm' ds a)
    lem::2 [] a with split-โ (depth a)
    ... | left x = by-depth x
    ... | just x = by-[] (ฮป aโก0 -> zeroโขsuc (aโก0 โปยน โ snd x))
    lem::2 (d โท ds) a with โจ decompose โฉ a | strict a
    ... | left x | P = by-depth (transport (ฮป i -> depth (P (~ i)) โก 0) depth/return)
    ... | just x | P = lem::2 ds (x d)

    lem::3 : โ(a : โจ Mon A โฉ) -> norm (norm a) โก norm a
    lem::3 a = lem::1 (norm a) (lem::2 (fst a) (snd a))

  -}



