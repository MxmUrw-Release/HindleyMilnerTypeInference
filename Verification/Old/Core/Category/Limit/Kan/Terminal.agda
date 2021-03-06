
module Verification.Old.Core.Category.Limit.Kan.Terminal where

open import Verification.Conventions
open import Verification.Old.Core.Category.Definition
open import Verification.Old.Core.Category.Instance.Cat
open import Verification.Old.Core.Category.Quiver
open import Verification.Old.Core.Category.FreeCategory
open import Verification.Old.Core.Category.Lift


--------------------------------------------------------------------
-- Terminal object

-- [Definition]
-- | We call an object terminal if ...
record ITerminal (X : Category š) (x : āØ X ā©) : š° (š āŗ) where
  field ! : ā(a : āØ X ā©) -> Hom a x
        unique : ā{a : āØ X ā©} -> (f : Hom a x) -> f ā£ ! a
open ITerminal {{...}} public
unquoteDecl Terminal terminal = #struct "Term" (quote ITerminal) "x" Terminal terminal
-- //

-- [Notation]
-- | We write |š| for the terminal object of a category, if it exists.
š : {X : š° š} {{_ : isCategory X š}} {{_ : Terminal (ā© X)}} -> X
š {{_}} {{t}} = āØ t ā©
-- //



--------------------------------------------------------------------
-- Cat has terminal object

-- [Example]
-- | The discrete category on |ā¤| is a terminal object of Cat
-- | For this, we define it by:
Category:š : Category _
Category:š = Category:Discrete š-š°

instance isCategory:š = #openstruct Category:š

-- | And now we show that it is indeed terminal.
private
  module _ {š : Category š} where
    !-Cat : š ā¶ ā Category:š
    āØ !-Cat ā© _ = ā„ tt
    IFunctor.map (of !-Cat) _ = ā„ id
    IFunctor.functoriality-id (of !-Cat) = ā„ refl
    IFunctor.functoriality-ā (of !-Cat) = ā„ refl
    IFunctor.functoriality-ā£ (of !-Cat) p = ā„ refl

    unique::!-Cat : ā(F G : š ā¶ ā Category:š) -> F ā£ G
    unique::!-Cat F G = record { object-path = refl ; arrow-path = Ī» f -> ā„ (Pā _ _) }
      where Pā : ā{a b : š-š°} -> (f g : Hom a b) -> f ā£ g
            Pā {tt} {.tt} id-Q id-Q = refl
            Pā {a} {.a} id-Q (some (last ()))
            Pā {a} {.a} id-Q (some (() ā· xā))
            Pā {a} {b} (some (last ())) g
            Pā {a} {b} (some (() ā· xā)) g

instance
  Terminal:Category : Terminal (Category:Category š)
  āØ Terminal:Category ā© = ā Category:š
  ITerminal.! (of Terminal:Category) _ = !-Cat
  ITerminal.unique (of Terminal:Category) F = unique::!-Cat _ _

instance ITerminal:Category = #openstruct Terminal:Category
-- //


