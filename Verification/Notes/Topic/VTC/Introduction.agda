
module Verification.Notes.Topic.VTC.Introduction where

-- = Introduction
-- | The Hindley-Milner type system is well-studied. It forms the
--   core theory of many real-life programming languages such as Standard-ML,
--   OCaml and Haskell, each with its own various extensions of the core
--   typing system. Its main feature is the availability of type polymorphism,
--   and at the same time the possibility of complete type inference. This means that programs may be written
--   without the additional overhead of specifying types, yet full type safety
--   can be guaranteed after the type checker inferred that the program is well-typed
--   at compile time. Polymorphism guarantees that functions which in an untyped
--   programming language would be applicable to a value of any type continue
--   to work exactly the same under this type system (by assigning them a type
--   which expresses exactly this property).
--
-- | \medskip
--
-- | It was independently described by Hindley
--   as an inference system for combinatorial logic \cite{HM:Hindley:1969}
--   and by Milner as a type system for ML \cite{HM:Milner:1978}.
--   Both give a type inference algorithm and prove soundness with respect to
--   the typing rules. Completeness was shown by \citet{HM:Damas:1984}.
--
-- | Formalizations of the Hindley-Milner type inference (hereafter HM) algorithm were first
--   done independently by Naraschewski and Nipkow in Isabelle$/$HOL \cite{HMForm:NaraschewskiNipkow:1999},
--   and by \citet{HMForm:DuboisMenissier-Morain:1999} in Coq.
--   Later work includes a further implementation
--   by \citet{HMForm:UrbanNipkow:2008}, with an alternative representation of term variables
--   using nominal sets. As well as a verified implementation
--   of a full compiler for a subset of ML by \citet{HMForm:KMNO:2014}.
--
-- | \medskip
--
-- | The inference algorithm depends on a unification algorithm for first order terms.
--   Such an algorithm was first described by \citet{Unify:Robinson:1965}, a textbook account
--   may be found in \cite{siekmann1989unification}.
--
-- | Most of the formalizations of HM mentioned above do not include a unification algorithm;
--   that such an algorithm exists is merely postulated axiomatically. This is possible because
--   the type inference does not depend on the actual unification algorithm used, merely requires that
--   a few key properties are satisfied --- i.e., the algorithm should compute the /most general unifier/ of
--   two given terms.
--
-- | Instead, a formalization of unification may be found in \cite{UnifyForm:MannaWaldinger:1981} (a hand-derived synthesis), \cite{UnifyForm:Paulson:1985} (a from that derived version in LCF),
--    in \cite{UnifyForm:Bove:1999} and in \cite{UnifyForm:McBride:2000}.
--
-- | \medskip
--
-- | That the notion of unification is closely related to that of a coequalizer in
--   category theory was noticed by Joe Goguen. It is expanded upon by \citet{UnifyCat:RydeheardBurstall:1986}, and also by \citet{UnifyCat:Goguen:1989} himself.
--   A thesis which includes explanations of basic concepts is \citet{UnifyCat:Garcia:2004}.
--   A formalization of higher order unification in Agda, which utilizes some categorical concepts,
--   is presented in \cite{UnifyCat:VezzosiAbel:2014}.
-- | \medskip
--
-- ==* Contributions
--
-- | In this thesis we present our formalization of a first-order unification algorithm,
--   and an implementation of algorithm W which is proven to be sound and complete.
--   The following aspects distinguish it from the pre-existing literature:
-- | - Since we provide both a formalization of unification and of type inference,
--     our algorithm can theoretically be executed (the current problem being that
--     one lemma, namely epi-mono factorization in the category of substitutions is not completely
--     formalized).
-- | - The recursion of our unification algorithm is defined in purely category theoretic terms.
--     This can be seen as a follow up on a claim made in \cite{UnifyCat:RydeheardBurstall:1986}.
--     Such an abstract formulation could make implementations of unification for other theories,
--     such as higher order unification simpler.
-- | - The type variables in the implementation and proof of algorithm W are treated
--     purely categorically. This should make it feasible to
--     turn it into a proof for a family of HM-like type theories, requiring only
--     certain properties from their category of substitutions.
-- |: {}
--
-- ==* Structure
-- | - First, we give a short explanation about the process of creating this formalization.
-- | - Then, before really beginning, we give a short and informal introduction to
--      theorem proving in Agda, and the notation
--      of Agda in particular, explaining a few design choices of our most basic data
--      data types on the way.
-- | - Next, we introduce the categorical concepts required by the later chapters.
--      These are mostly categories, coproducts, and coequalizers.
-- | - We define many-sorted first order terms over a signature of function symbols.
--      We sketch that this category has coproducts.
-- | - We present unification informally, note how it relates to coequalizers.
--      We show how the main induction step of unification can be proven in
--      purely category-theoretic terms, compare with partially similar
--      approaches in the literature. We briefly sketch all other proofs necessary
--      which exist in the formalization.
-- | - We present HM type inference informally, and introduce the required definitions
--      to state the soundness and completeness theorem.
--




