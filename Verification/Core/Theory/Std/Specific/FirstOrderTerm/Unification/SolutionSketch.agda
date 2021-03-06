
module Verification.Core.Theory.Std.Specific.FirstOrderTerm.Unification.SolutionSketch where

open import Verification.Conventions hiding (_â_ ; â)

open import Verification.Core.Set.Discrete

open import Verification.Core.Algebra.Monoid.Definition

open import Verification.Core.Category.Std.Category.Subcategory.Full

open import Verification.Core.Data.Universe.Definition
open import Verification.Core.Data.Universe.Instance.Category
open import Verification.Core.Data.Substitution.Variant.Base.Definition

open import Verification.Core.Data.List.Variant.Binary.Natural
open import Verification.Core.Data.List.Variant.Binary.Definition
open import Verification.Core.Data.List.Variant.Binary.Element.Definition
open import Verification.Core.Data.List.VariantTranslation.Definition
open import Verification.Core.Data.List.Dependent.Variant.Binary.Definition

open import Verification.Core.Theory.Std.Specific.FirstOrderTerm.Signature
open import Verification.Core.Theory.Std.Specific.FirstOrderTerm.Definition
open import Verification.Core.Theory.Std.Specific.FirstOrderTerm.Substitution.Definition
open import Verification.Core.Data.Language.HindleyMilner.Type.Variant.FirstOrderTerm.Signature
open import Verification.Core.Data.Language.HindleyMilner.Type.VariantTranslation.Definition
open import Verification.Core.Data.Language.HindleyMilner.Type.Variant.Direct.Definition

open import Verification.Core.Data.Language.HindleyMilner.Variant.Classical.Typed.Imports hiding (unify ; [_])

open import Verification.Core.Data.Language.HindleyMilner.Variant.Classical.Typed.Type.Properties
private variable Î¼s Î½s : ðð®ðð¬ð­-Sim Î£-Sim

-- [Hide]
â' = â_
infixl 5 â'
syntax â' (Î» x -> P) = â[ x ] P

postulate
  here : â{A : ð° ð} -> Text -> A

_[_] : â{Î±s Î²s : ðð®ðð¬ð­-Sim Î£-Sim} -> ð¯âTerm Î£-Sim â¨ Î±s â© tt ->  Î±s â¶ Î²s -> ð¯âTerm Î£-Sim â¨ Î²s â© tt
_[_] = Î» Ï Ï -> Ï â[ Ï ]â
-- //

-- ==* A sketch of a solution
-- | Based on the problem description above, we present a simplified
--   unification algorithm --- again using terms from |ð¯âTerm Î£-Sim| for
--   the sake of concreteness. A very similar definition can already be found in
--   the original paper on categorical unification of \citeauthor{UnifyCat:RydeheardBurstall:1986}.
--   The same general approach, yet formulated differently, is the one taken
--   by \citet{UnifyForm:McBride:2000}.
--
-- | The algorithm has the following type [...,] We present it using
--   partially implemented Agda terms.
{-# TERMINATING #-}
unify : (t s : ð¯âTerm Î£-Sim â¨ Î¼s â© tt) -> Maybe (â[ Î½s ] (Î¼s â¶ Î½s))
-- |> taking the terms |t| and |s|, both with variables from |Î¼s| and returning
--   a new list of variables |Î½s|, as well as a substitution |Î¼s â¶ Î½s|.
--   The intention is that this substitution should be the most general unifier
--   of |t| and |s|.
-- | An implementation in terms of recursion on both arguments is very
--   natural: Compare the topmost constructors; If either
--   of them is a variable, we are done. Otherwise they must both be
--   arrows, then recurse on their arguments.
-- | It is customary to denote the cases involving variables by /flex/
--   and the ones involving constructors by /rigid/, relating to the fact
--   that variables can be changed by substitutions, while constructors cannot.
-- | We examine the cases in more detail REF.
-- | - The flex-flex case.
unify (var Î±) (var Î²) = {!!}
-- |> Here we need to check whether |Î± â¡ Î²| holds: if both
--    variables are the same, the most general unifier
--    is the identity substitution. Otherwise we return a substitution
--    which maps |Î±| and |Î²| to the same variable; |Î½s| contains
--    one variable less than |Î¼s|.

-- | - The rigid-flex cases.
unify (â) (var Î²) = {!!}
unify (ð¹) (var Î²) = {!!}
unify (tâ â tâ) (var Î²) = {!!}

-- |> When the rigid term is a constant without arguments, the
--    mgu is straightforward: substitute the variable |Î²| with that type constant.
--    If it is a term with arguments, the result depends on whether
--    the variable |Î²| occurs in either of |tâ| or |tâ|. If it does not,
--    proceed by substituting |Î²| like before. If it does, the result is that
--    no unifier exists. Intuitively, this is so because if we were to
--    substitute |Î²| by the term on the left hand side, that term,
--    itself containing |Î²|, would change as well. Meaning
--    that |(tâ â tâ) [ Ï ] â  Î² [ Ï ]|.

-- [Hide]
unify (var Î±) (â) = {!!}
unify (var Î±) (ð¹) = {!!}
unify (var Î±) (tâ â tâ) = {!!}
-- //

-- | - The rigid-rigid case.

-- [Hide]
unify (ð¹) (ð¹) = {!!}
unify (â) (ð¹) = {!!}
unify (ð¹) (â) = {!!}
unify (â) (â) = {!!}
unify (ð¹) (sâ â sâ) = {!!}
unify (â) (sâ â sâ) = {!!}
unify (tâ â tâ) (ð¹) = {!!}
unify (tâ â tâ) (â) = {!!}
-- //

-- |> We ignore the sub-cases where either of the inputs are
--   type constants: the mgu is the identity substitution
--   if both inputs are the same, or it does not exist if they are
--   different.
-- | Instead, focus on the case where both inputs are arrows:

unify (tâ â tâ) (sâ â sâ) with unify tâ sâ
... | nothing = nothing
... | just (Î½sâ , Ïâ) with unify (tâ [ Ïâ ]) (sâ [ Ïâ ])
... | nothing = nothing
... | just (Î½sâ , Ïâ) = just (Î½sâ , Ïâ â Ïâ)

-- |> The reasoning behind this implementation is the following:
--   we want to solve the unification problem by solving the partial problems
--   of |tâ â tâ| and |sâ â sâ|, and then combining their solutions.
--   But as shown in the previous example,
--   the results of these partial solutions may influence each other.
--   If a variable is substituted in one branch of the execution, that must be taken
--   into account in the other branch, where that same variable may have
--   another occurence.
-- | The solution is remarkably simple: we solve the subproblems sequentially.
--   As seen in the implementation above, we first unify |tâ| and |tâ|.
--   If these terms have no mgu (the result is |nothing|),
--   than neither does our original pair (we also return |nothing|).
--   The crux of the algorithm is the case where unification of |tâ| and |sâ|
--   succeeds: The mgu of this pair is applied to both |tâ| and |sâ|
--   before these are unified. Afterwards, the only thing left is to compose the
--   two substitutions if successful, or return |nothing| if not.
-- |: Unfortunately, a verification of this implementation for the rigid-rigid
--   case is not immediate. The two problems that arise are:
-- | 1. Correctness needs to be shown. This is, in fact, the content of the "optimist's
--   lemma".
-- | 2. Termination of the algorithm is not obvious. When |unify| is
--      called the second time, its arguments have the substitution |Ïâ|
--      applied. Such a substitution usually increases the size of terms,
--      which makes it unclear whether the resulting chain of recursive calls
--      ever terminates. In Agda, this problem is visible immediately,
--      as the termination checker complains about not being able to show termination.

-- |: {}

-- | A verification of the other cases, flex-flex and rigid-flex,
--   is of course also required. In the present formalization this
--   takes a rather traditional form, as for example described in REF.
--   Most of the rest of
--   this chapter therefore is devoted to describing the correctness and
--   termination of the rigid-rigid case in a purely categorical setting,
--   as well as to the translation of that proof back to
--   the concrete category of substitutions of first order terms.


