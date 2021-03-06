
module Verification.Core.Meta.Structure3 where

open import Verification.Conventions
-- open import Verification.Core.Category.Definition
-- open import Verification.Core.Category.Instance.Set.Definition
open import Verification.Core.Order.Preorder renaming (IPreorder to isPreorder)

record _:>_ {A : ð° ð} (P : A -> ð° ð) (Q : (a : A) -> {{_ : P a}} -> ð° ð) (a : A) : ð° (ð ï½¤ ð ï½¤ ð) where
  instance constructor make:>
  field {{Proof1}} : P a
  field {{Proof2}} : Q a {{Proof1}}

infixl 50 _:>_

record _:>>_ {A : ð° ð} {P0 : A -> ð° ðâ} (P : (a : A) -> {{_ : P0 a}} -> ð° ð) (Q : (a : A) -> {{_ : (P0 :> P) a}} -> ð° ð) (a : A) {{_ : P0 a}} : ð° (ð ï½¤ ð ï½¤ ð) where
  field {{Proof1}} : P a
  field {{Proof2}} : Q a

infixl 50 _:>>_


record âi_ {A : ð° ð} (B : A -> ð° ð) : ð° (ð ï½¤ ð) where
  instance constructor makeâi
  -- field overlap {{ifst}} : A
  field {ifst} : A
  field overlap {{isnd}} : B (ifst)
open âi_ {{...}} public

record âp (ð : ð) {ð ð : ð} {A : ð° ð} {Q : A -> ð° ð} (B : (a : A) -> {{_ : Q a}} -> ð° ð) : ð° (ð ï½¤ ð) where
  instance constructor makeâp
  -- field overlap {{ifst}} : A
  -- field {ifst} : A
  -- field overlap {{isnd}} : B (ifst)
open âp {{...}} public




record hasU (A : ð° ð) ð ð : ð° (ð âº ï½¤ ð âº) where
  field getU : ð° ð
  field getP : getU -> ð° ð

open hasU public

instance
  hasU:âi : â{A : ð° ð} {P : A -> ð° ð} -> hasU (âi P) _ _
  getU (hasU:âi {A = A} {P}) = A
  getP (hasU:âi {A = A} {P}) = P

instance
  hasU:Structure : â{A : ð° ð} {P : A -> ð° ð} -> hasU (Structure P) _ _
  getU (hasU:Structure {A = A} {P}) = A
  getP (hasU:Structure {A = A} {P}) = P

_on_ : (UU : ð° ð) {{U : hasU UU ð ð}} -> (a : getU U) -> ð° _
_on_ UU {{U}} a = getP U a

is_ : (UU : ð° ð) {{U : hasU UU ð ð}} -> (a : getU U) -> ð° _
is_ UU {{U}} a = getP U a

infixl 100 is_


record _:,_ {U : ð° ð} {R : U -> ð° ðâ} (P : (a : U) -> {{_ : R a}} -> ð° ð) (Q : (a : U) -> {{_ : R a}} -> ð° ðâ) (a : U) {{_ : R a}} : ð° (ð ï½¤ ðâ) where
  constructor make,
  field overlap {{Proof1}} : P a
  field overlap {{Proof2}} : Q a

infixr 80 _:,_


--------------------------------------------------
-- Testcase

module TEST where
  private
    record isType (ð : ð) (A : ð° ð) : ð° ð where
    instance
      isType:Any : â{A : ð° ð} -> isType ð A
      isType:Any = record {}

    record isTypoid ð A {{_ : isType ð A}} : ð° (ð ï½¤ (ð âº)) where
      field _â¼_ : A -> A -> ð° ð
    open isTypoid {{...}} public

    Typoid : â(ð : ð ^ 2) -> ð° _
    Typoid ð = Structure (isType (ð â 0) :> isTypoid (ð â 1))

    record isMonoid (A : ð° _) {{_ : Typoid ð on A}} : ð° (ð) where
      field _â_ : A -> A -> A
    -- record isMonoid A {{_ : (isType ð :> isTypoid) A}} : ð° (ð) where
    open isMonoid {{...}} public

    Monoid : â(ð) -> ð° _
    Monoid ð = Structure (is Typoid ð :> isMonoid)

    -- âp (ð âº) {ð = ð} {Q = isTypoid} isMonoid

    record isCommutative (A : ð° _) {{_ : Monoid ð on A}} : ð° ð where
      field comm-â : â{a b : A} -> (a â b) â¼ (b â a)
    open isCommutative {{...}} public
    record isGroup (A : ð° _) {{_ : Monoid ð on A}} : ð° ð where
      field â¡_ : A -> A

    Group : â(ð) -> ð° _
    Group ð = Structure ((Monoid ð on_) :> isGroup)


    record isSemiring (A : ð° _) {{_ : (is Monoid ð :> isCommutative) A}} : ð° ð where
      field _â_ : A -> A -> A

    Semiring : â(ð) -> ð° _
    Semiring ð = Structure (_ :> isSemiring {ð = ð})

    record isRing (A : ð° _) {{_ : (is Monoid ð :> ((isCommutative :>> isSemiring) :, isGroup)) A}} : ð° ð where

    record isTypoidHom {A B} {{_ : Typoid ð on A}} {{_ : Typoid ð on B}} (f : A -> B) : ð° (ð ï½¤ ð) where
      field preserves-â¼ : â{a b : A} -> a â¼ b -> f a â¼ f b

    TypoidHom : (A : Typoid ð) (B : Typoid ð) -> ð° _
    TypoidHom A B = Structure (isTypoidHom {{of A}} {{of B}})

    -- record isTypoidHom (A : Typoid ð) (B : Typoid ð) (f : â¨ A â© -> â¨ B â©) : ð° (ð ï½¤ ð) where
    --   field preserves-â¼ : â{a b : â¨ A â©} -> a â¼ b -> f a â¼ f b

    -- TypoidHom : (A : Typoid ð) (B : Typoid ð) -> ð° _
    -- TypoidHom A B = Structure (isTypoidHom A B)

    -- record isMonoidHom {A B} {{_ : Monoid ð on A}} {{_ : Monoid ð on B}} (f : A -> B) {{_ : isTypoidHom f}} : ð° (ð ï½¤ ð) where

    record isMonoidHom (A : Monoid ð) (B : Monoid ð) (f : â¨ A â© -> â¨ B â©) {{_ : TypoidHom (â² â¨ A â© â²) (â² â¨ B â© â²) on f}} : ð° (ð ï½¤ ð) where

{-
    MonoidHom : (A : Monoid ð) (B : Monoid ð) -> ð° _
    MonoidHom A B = Structure (_ :> isMonoidHom {{of A}} {{of B}})



    record isGroupHom {A B} {{_ : Group ð on A}} {{_ : Group ð on B}} (f : A -> B) {{_ : (_ :> isMonoidHom) f}} : ð° (ð ï½¤ ð) where

-}
    -- record isMonoidHom (A : Monoid ð) (B : Monoid ð) f {{_ : TypoidHom (â â¨ A â©) (â â¨ B â©) on f}} : ð° (ð ï½¤ ð) where

    -- record isCommutative (A : ð° ð) {{_ : (isTypoid :> isMonoid) A}} : ð° ð where






