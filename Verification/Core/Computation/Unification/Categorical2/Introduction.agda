
module Verification.Core.Computation.Unification.Categorical2.Introduction where

-- | At the heart of the formulation of the optimist's lemma
--   is a concept which McBride calls /downward-closed constraint/,
--   and defines as a certain subset of arrows in a category.
--   This same concept appears in many fields of mathematics:
--   It is the notion of /ideals/. Under this name it is used
--   for both rings and lattices. In cases where mathematical objects
--   have both structures, such as boolean rings, the two notions of ideals
--   overlap. There is a generalization to ideals in monoids,
--   and from there to ideals in categories, though in the latter case
--   they are also known as /sieves/. \cite{nlab:ideal}
--
-- | Even though the definition we need to use is the one for
--   categories, we use the terminology of rings. This is mainly because
--   of familiarity of the author with this field. Nevertheless,
--   no knowledge of any of these concepts is required for following the
--   text, as everything is motivated in terms of coequalizers in the category
--   of substitutions.
--
-- | The idea behind the formal treatment of unification in this
--   thesis begins with the following observation:
--   Let |t s : 𝒯⊔Term Σ 1 αs| be two terms, considered as a pair of parallel arrows.
--   Then the unifiers (not necessarily most general) of |t| and |s| are given
--   by pairs of another object |βs| and an arrow |f : αs ⟶ βs|
--   such that |t ◆ f ≡ t ◆ g| holds.
-- | Now move the focus away from the terms |t| and |s|, and rather consider
--   this set which is generated by it: a subset of arrows from |αs| to other
--   objects of the category. This set has the following property: if
--   an arrow |f : αs ⟶ βs| is in this set (it unifies |t| and |s|),
--   then so is the composition of |f| with any other arrow |βs ⟶ γs|.
--   Such a subset
--   is what McBride calls downward closed,
--   and at the same time is exactly the notion of ideals in a category.
--
-- | \medskip
--
-- | The general idea of what we are doing here is fully present
--   in \cite{UnifyForm:McBride:2000}. There are two differences:
--   The smaller one is that
--   we expand somewhat on the notions employed, in the hope that
--   this makes the intuition behind the proof of the optimist's lemma
--   a bit clearer: in our formalization that
--   proof is reduced to a single chain of equational reasoning,
--   requiring four steps. The larger one is explained in the next subsection.


