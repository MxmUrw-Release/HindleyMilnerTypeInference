{-
  case (γ Γ te) of
  {!!}
  continue₀ where

  continue₀ : InitialCtxTypingInstance Γ te -> TypingDecision Γ (app te se)
  continue₀ ((νs₀ₐ / νs₀ₓ ⊩ Γ₀ , αᵇ₀ , Γ<Γ₀ , Γ₀⊢αᵇ₀), Ω₀) =
    case (γ _ se) of
    {!!}
    continue₁ where

    continue₁ : InitialCtxTypingInstance Γ₀  se -> TypingDecision Γ (app te se)
    continue₁ ((νs₁ₐ / νs₁ₓ ⊩ Γ₁ , βᵇ₁ , Γ₀<Γ₁ , Γ₁⊢βᵇ₁), Ω₁) = resn res where

      νs = νsₐ


      σᵃᵤ₀ : _ ⟶ νs₀ₐ
      σᵃᵤ₀ = fst Γ<Γ₀

      -- lift the τ0 typing to Γ₁
      σᵃ₀₁ : νs₀ₐ ⟶ νs₁ₐ
      σᵃ₀₁ = fst Γ₀<Γ₁

      σᵃᵤ₁ : νsₐ ⟶ νs₁ₐ
      σᵃᵤ₁ = σᵃᵤ₀ ◆ σᵃ₀₁

      νs₀ = νs₀ₐ ⊔ νs₀ₓ

      σᵤ₀ : νs ⟶ νs₀
      σᵤ₀ = σᵃᵤ₀ ◆ ι₀


      νs₁ = νs₁ₐ ⊔ (νs₀ₓ ⊔ νs₁ₓ)

      σ₀₁ : νs₀ ⟶ νs₁
      σ₀₁ = σᵃ₀₁ ⇃⊔⇂ ι₀


      -- we lift α₀ to the metas νs₁
      -- τ₀'
      α₁ : ℒHMType ⟨ νs₁ₐ ⊔ (νs₀ₓ ⊔ νs₁ₓ) ⟩
      α₁ = αᵇ₀ ⇃[ σ₀₁ ]⇂

      β₁ : ℒHMType ⟨ νs₁ₐ ⊔ (νs₀ₓ ⊔ νs₁ₓ) ⟩
      β₁ = βᵇ₁ ⇃[ id ⇃⊔⇂ ι₁ ]⇂

      -- we need a new type variable for the return
      -- type of the application, so we move to νs₂
      νs₂ₐ = νs₁ₐ
      νs₂ = νs₂ₐ ⊔ (νs₀ₓ ⊔ νs₁ₓ ⊔ st)

      σ₁₂ : νs₁ ⟶ νs₂
      σ₁₂ = id ⇃⊔⇂ ι₀

      -- σᵤ₂ : νs ⟶ νs₂
      -- σᵤ₂ = σᵤ₀ ◆ σ₀₁ ◆ σ₁₂

      α₂ : ℒHMType ⟨ νs₂ₐ ⊔ (νs₀ₓ ⊔ νs₁ₓ ⊔ st) ⟩
      α₂ = α₁ ⇃[ σ₁₂ ]⇂

      β₂ : ℒHMType ⟨ νs₂ ⟩
      β₂ = β₁ ⇃[ σ₁₂ ]⇂


      -- Γ₂ = Γ₁ ⇃[ σ₁₂ ]⇂ᶜ
      Γ₂ = Γ₁

      -- we call the new type γ
      γᵇₜ : ℒHMType ⟨ st ⟩
      γᵇₜ = var incl

      γ₂ : ℒHMType ⟨ νs₂ ⟩
      γ₂ = γᵇₜ ⇃[ ι₁ ◆ ι₁ ]⇂

      -- the types which we unify are:
      u : ℒHMType ⟨ νs₂ ⟩
      u = α₂

      v : ℒHMType ⟨ νs₂ ⟩
      v = β₂ ⇒ γ₂


      res = unify-ℒHMTypes (asArr u) (asArr v)

      resn : (¬ hasCoequalizerCandidate (asArr u , asArr v)) +-𝒰 (hasCoequalizer (asArr u) (asArr v))
            -> (CtxTypingInstance Γ (app te se) -> ⊥-𝒰 {ℓ₀}) + InitialCtxTypingInstance Γ (app te se)
      resn (left _) = {!!}
      resn (right x) = right (𝑇 , {!!}) -- right (𝑇 , isInitial:𝑇)
        where
          -- we now have the coequalizer `π₌`,
          -- but we need to factorize the map ι₀ ◆ π₌
          f : νs₂ₐ ⟶ ⟨ x ⟩
          f = ι₀ ◆ π₌

          factor:f = factorize f

          νs₃ₐ = image factor:f
          νs₃ₓ = rest factor:f

          νs₃ = νs₃ₐ ⊔ νs₃ₓ

          σ₂₃ : νs₂ ⟶ νs₃
          σ₂₃ = π₌ ◆ ⟨ splitting factor:f ⟩⁻¹

          ϕ = splitting factor:f

          σᵃ₂₃ : νs₂ₐ ⟶ νs₃ₐ
          σᵃ₂₃ = epiHom factor:f

          β₃ = β₂ ⇃[ σ₂₃ ]⇂
          γ₃ = γ₂ ⇃[ σ₂₃ ]⇂
          Γ₃ = Γ₂ ⇃[ σᵃ₂₃ ]⇂ᶜ

          lem-0 : ι₀ ◆ σ₂₃ ∼ σᵃ₂₃ ◆ ι₀
          lem-0 = {!!}

          -- thus the full substitution we need is the following
          -- σᵤ₃ = σᵤ₀ ◆ σ₀₁ ◆ σ₁₂ ◆ σ₂₃

          Γ₂<Γ₃ : Γ₂ <Γ Γ₃
          Γ₂<Γ₃ = record { fst = σᵃ₂₃ ; snd = refl-≡ }

          Γ<Γ₃ : Γ <Γ Γ₃
          Γ<Γ₃ = Γ<Γ₀ ⟡ Γ₀<Γ₁ ⟡ Γ₂<Γ₃


          -- we know that under `σ₂₃` both α₂ and `β₂ ⇒ γ₂` are the same
          postulate lem-5 : α₂ ⇃[ σ₂₃ ]⇂ ≡ (β₂ ⇒ γ₂) ⇃[ σ₂₃ ]⇂
          {-
          lem-5 = α₂ ⇃[ π₌ ◆ ⟨ splitting factor:f ⟩⁻¹ ]⇂      ⟨ sym-Path (functoriality-◆-⇃[]⇂ {τ = α₂} {f = π₌} {⟨ splitting factor:f ⟩⁻¹}) ⟩-≡
                  α₂ ⇃[ π₌ ]⇂ ⇃[ ⟨ splitting factor:f ⟩⁻¹ ]⇂  ⟨ cong _⇃[ ⟨ splitting factor:f ⟩⁻¹ ]⇂ lem-5b ⟩-≡
                  (β₂ ⇒ γ₂) ⇃[ π₌ ]⇂ ⇃[ ⟨ splitting factor:f ⟩⁻¹ ]⇂ ⟨ functoriality-◆-⇃[]⇂ {τ = β₂ ⇒ γ₂} {f = π₌} {⟨ splitting factor:f ⟩⁻¹} ⟩-≡
                  (β₂ ⇒ γ₂) ⇃[ σ₂₃ ]⇂                              ∎-≡

            where
              lem-5a : (asArr α₂) ◆ π₌ ∼ (asArr (β₂ ⇒ γ₂)) ◆ π₌
              lem-5a = equate-π₌

              lem-5a' : ((asArr α₂) ◆-⧜𝐒𝐮𝐛𝐬𝐭 π₌) ∼ ((asArr (β₂ ⇒ γ₂)) ◆-⧜𝐒𝐮𝐛𝐬𝐭 π₌)
              lem-5a' = (abstract-◆-⧜𝐒𝐮𝐛𝐬𝐭 ∙-≣ lem-5a) ∙-≣ (sym-≣ abstract-◆-⧜𝐒𝐮𝐛𝐬𝐭)

              lem-5b : α₂ ⇃[ π₌ ]⇂ ≡ (β₂ ⇒ γ₂) ⇃[ π₌ ]⇂
              lem-5b = let x = lem-5a'
                           y = cong-Str ⟨_⟩ x
                           z = cancel-injective-incl-Hom-⧜𝐒𝐮𝐛𝐬𝐭 y
                           q = ≡-Str→≡ z
                       in q
          -}

          postulate lem-6 : Γ₂ ⇃[ ι₀ ]⇂ᶜ ⇃[ σ₂₃ ]⇂ᶜ ≡ Γ₂ ⇃[ σᵃ₂₃ ]⇂ᶜ ⇃[ ι₀ ]⇂ᶜ
          {-
          lem-6 = Γ₂ ⇃[ ι₀ ]⇂ᶜ ⇃[ σ₂₃ ]⇂ᶜ  ⟨ functoriality-◆-⇃[]⇂-CtxFor {Γ = Γ₂} {f = ι₀} {σ₂₃} ⟩-≡
                  Γ₂ ⇃[ ι₀ ◆ σ₂₃ ]⇂ᶜ       ⟨ Γ₂ ⇃[≀ lem-0 ≀]⇂-CtxFor ⟩-≡
                  Γ₂ ⇃[ σᵃ₂₃ ◆ ι₀ ]⇂ᶜ      ⟨ sym-Path functoriality-◆-⇃[]⇂-CtxFor ⟩-≡
                  Γ₂ ⇃[ σᵃ₂₃ ]⇂ᶜ ⇃[ ι₀ ]⇂ᶜ ∎-≡
          -}

          -------------
          -- lift the typing of se and te to νs₃

          postulate sp₃ : isTypedℒHM (νs₃ ⊩ (_ , Γ₃ ⇃[ ι₀ ]⇂ᶜ) ⊢ β₃) se
          {-
          sp₃ = Γ₁⊢βᵇ₁
                >> isTypedℒHM (νs₁ₐ ⊔ νs₁ₓ ⊩ (_ , Γ₁ ⇃[ ι₀ ]⇂ᶜ) ⊢ βᵇ₁) se <<
                ⟪ §-isTypedℒHM.prop-3 ι₁ ⟫
                >> isTypedℒHM (νs₁ ⊩ (_ , Γ₁ ⇃[ ι₀ ]⇂ᶜ) ⊢ β₁) se <<
                ⟪ §-isTypedℒHM.prop-3 ι₀ ⟫
                >> isTypedℒHM (νs₂ ⊩ (_ , Γ₁ ⇃[ ι₀ ]⇂ᶜ) ⊢ β₁ ⇃[ id ⇃⊔⇂ ι₀ ]⇂) se <<
                >> isTypedℒHM (νs₂ ⊩ (_ , Γ₂ ⇃[ ι₀ ]⇂ᶜ) ⊢ β₂) se <<
                ⟪ §-isTypedℒHM.prop-2 {Γ = _ , Γ₂ ⇃[ ι₀ ]⇂ᶜ} {τ = β₂} σ₂₃ ⟫
                >> isTypedℒHM (νs₃ ⊩ (_ , Γ₂ ⇃[ ι₀ ]⇂ᶜ ⇃[ σ₂₃ ]⇂ᶜ) ⊢ β₂ ⇃[ σ₂₃ ]⇂) se <<
                ⟪ transp-isTypedℒHM lem-6 refl-≡ ⟫
                >> isTypedℒHM (νs₃ ⊩ (_ , Γ₂ ⇃[ σᵃ₂₃ ]⇂ᶜ ⇃[ ι₀ ]⇂ᶜ) ⊢ β₂ ⇃[ σ₂₃ ]⇂) se <<
                >> isTypedℒHM (νs₃ ⊩ (_ , Γ₃ ⇃[ ι₀ ]⇂ᶜ) ⊢ β₃) se <<
          -}

          postulate tp₃ : isTypedℒHM (νs₃ ⊩ (_ , Γ₃ ⇃[ ι₀ ]⇂ᶜ) ⊢ (β₃ ⇒ γ₃)) te
          {-
          tp₃ = Γ₀⊢αᵇ₀

                >> isTypedℒHM (νs₀ ⊩ (_ , Γ₀ ⇃[ ι₀ ]⇂ᶜ ) ⊢ αᵇ₀ ) te <<

                ⟪ §-isTypedℒHM.prop-4 σᵃ₀₁ ι₀ ⟫

                >> isTypedℒHM (νs₁ ⊩ (_ , Γ₀ ⇃[ σᵃ₀₁ ]⇂ᶜ ⇃[ ι₀ ]⇂ᶜ ) ⊢ αᵇ₀ ⇃[ σᵃ₀₁ ⇃⊔⇂ ι₀ ]⇂) te <<

                ⟪ transp-isTypedℒHM (cong _⇃[ ι₀ ]⇂ᶜ (Γ₀<Γ₁ .snd)) refl-≡ ⟫

                >> isTypedℒHM (νs₁ ⊩ (_ , Γ₁ ⇃[ ι₀ ]⇂ᶜ ) ⊢ α₁ ) te <<

                ⟪ §-isTypedℒHM.prop-3 ι₀ ⟫

                >> isTypedℒHM (νs₂ ⊩ (_ , Γ₁ ⇃[ ι₀ ]⇂ᶜ ) ⊢ α₁ ⇃[ id ⇃⊔⇂ ι₀ ]⇂) te <<
                >> isTypedℒHM (νs₂ ⊩ (_ , Γ₂ ⇃[ ι₀ ]⇂ᶜ ) ⊢ α₂) te <<

                ⟪ §-isTypedℒHM.prop-2 σ₂₃ ⟫

                >> isTypedℒHM (νs₃ ⊩ (_ , Γ₂ ⇃[ ι₀ ]⇂ᶜ ⇃[ σ₂₃ ]⇂ᶜ) ⊢ α₂ ⇃[ σ₂₃ ]⇂) te <<

                ⟪ transp-isTypedℒHM lem-6 lem-5 ⟫

                >> isTypedℒHM (νs₃ ⊩ (_ , Γ₂ ⇃[ σᵃ₂₃ ]⇂ᶜ ⇃[ ι₀ ]⇂ᶜ) ⊢ (β₂ ⇒ γ₂) ⇃[ σ₂₃ ]⇂) te <<
                >> isTypedℒHM (νs₃ ⊩ (_ , Γ₃ ⇃[ ι₀ ]⇂ᶜ) ⊢ β₃ ⇒ γ₃) te <<
          -}

          -- this shows that we do have the typing instance
          𝑇 : CtxTypingInstance Γ (app te se)
          𝑇 = νs₃ₐ / νs₃ₓ ⊩ Γ₃ , γ₃ , Γ<Γ₃ , (app tp₃ sp₃)

          isInitial:𝑇 : ∀(𝑆 : CtxTypingInstance Γ (app te se)) -> 𝑇 <TI 𝑆
          isInitial:𝑇 (νs₄ₐ / νs₄ₓ ⊩ Ξ , ξ , Γ<Ξ , app {α = ξ₄} {β = ζ₄} Ξ⊢ξ⇒ζ Ξ⊢ξ) =
            record { tiSubₐ = σᵃ₃₄ ; tiSubₓ = σˣ₃₄ ; typProof = lem-32 ; subProof = lem-23 }
            where
              νs₄ : ℒHMTypes
              νs₄ = νs₄ₐ ⊔ νs₄ₓ

              σᵃᵤ₄ : νs ⟶ νs₄ₐ
              σᵃᵤ₄ = fst Γ<Ξ

              ΩR₀ = Ω₀ (νs₄ₐ / νs₄ₓ ⊩ Ξ , ((ξ₄ ⇒ ζ₄)) , Γ<Ξ , Ξ⊢ξ⇒ζ)

              σᵃ₀₄ : νs₀ₐ ⟶ νs₄ₐ
              σᵃ₀₄ = tiSubₐ ΩR₀

              σˣ₀₄ : νs₀ₓ ⟶ νs₄ₐ ⊔ νs₄ₓ
              σˣ₀₄ = tiSubₓ ΩR₀

              Γ₀<Ξ : Γ₀ <Γ Ξ
              Γ₀<Ξ = record { fst = σᵃ₀₄ ; snd = ctxProofTI ΩR₀ }

              ΩR₁ = Ω₁ (νs₄ₐ / νs₄ₓ ⊩ Ξ , ξ₄ , Γ₀<Ξ , Ξ⊢ξ)

              σᵃ₁₄ : νs₁ₐ ⟶ νs₄ₐ
              σᵃ₁₄ = tiSubₐ ΩR₁

              σˣ₁₄ : νs₁ₓ ⟶ νs₄ₐ ⊔ νs₄ₓ
              σˣ₁₄ = tiSubₓ ΩR₁

              -------
              -- we can build a substitution from νs₂ by mapping γ to ζ₄
              -- {}
              σₜ₄ : st ⟶ νs₄
              σₜ₄ = ⧜subst (incl ζ₄)

              σ₂₄ : νs₂ ⟶ νs₄
              σ₂₄ = ⦗ σᵃ₁₄ ◆ ι₀ , ⦗ ⦗ σˣ₀₄ , σˣ₁₄ ⦘ , σₜ₄ ⦘ ⦘ -- ⦗ σ₁₄ , σₜ₄ ⦘
              -- {}
              ------

              -- we know that under this substitution,
              -- u = α₂ and v = β₂ ⇒ γ₂ become both ξ⇒ζ

              postulate lem-11 : u ⇃[ σ₂₄ ]⇂ ≡ ξ₄ ⇒ ζ₄
              {-
              lem-11 = αᵇ₀ ⇃[ σᵃ₀₁ ⇃⊔⇂ ι₀ ]⇂ ⇃[ id ⇃⊔⇂ ι₀ ]⇂ ⇃[ σ₂₄ ]⇂     ⟨ {!!} ⟩-≡
                       αᵇ₀ ⇃[ ⦗ σᵃ₀₁ ◆ σᵃ₁₄ ◆ ι₀ , σˣ₀₄ ⦘ ]⇂             ⟨ {!!} ⟩-≡
                       αᵇ₀ ⇃[ ⦗ σᵃ₀₄ ◆ ι₀ , σˣ₀₄ ⦘ ]⇂                    ⟨ typProof ΩR₀ ⟩-≡
                       ξ₄ ⇒ ζ₄                                         ∎-≡
              -}

              -- we show how β₂ and γ₂ evaluate under σ₂₄
              postulate lem-12a : β₂ ⇃[ σ₂₄ ]⇂ ≡ ξ₄
              {-
              lem-12a = βᵇ₁ ⇃[ id ⇃⊔⇂ ι₁ ]⇂ ⇃[ id ⇃⊔⇂ ι₀ ]⇂ ⇃[ σ₂₄ ]⇂   ⟨ {!!} ⟩-≡
                        βᵇ₁ ⇃[ ⦗ σᵃ₁₄ ◆ ι₀ , σˣ₁₄ ⦘ ]⇂                 ⟨ typProof ΩR₁ ⟩-≡
                        ξ₄                                            ∎-≡
              -}

              postulate lem-12b : γ₂ ⇃[ σ₂₄ ]⇂ ≡ ζ₄
              {-
              lem-12b = γᵇₜ ⇃[ ι₁ ◆ ι₁ ]⇂ ⇃[ σ₂₄ ]⇂           ⟨ {!!} ⟩-≡
                        γᵇₜ ⇃[ σₜ₄ ]⇂                         ∎-≡
              -}


{-
              lem-12 : v ⇃[ σ₂₄ ]⇂ ≡ ξ₄ ⇒ ζ₄
              lem-12 = λ i -> lem-12a i ⇒ lem-12b i

              -- taken together
              lem-13 : (asArr u) ◆ σ₂₄ ∼ (asArr v) ◆ σ₂₄
              lem-13 = ((sym-≣ abstract-◆-⧜𝐒𝐮𝐛𝐬𝐭) ∙-≣ lem-13a) ∙-≣ abstract-◆-⧜𝐒𝐮𝐛𝐬𝐭
                where
                  lem-13a : ((asArr u) ◆-⧜𝐒𝐮𝐛𝐬𝐭 σ₂₄) ∼ ((asArr v) ◆-⧜𝐒𝐮𝐛𝐬𝐭 σ₂₄)
                  lem-13a = cong-Str ⧜subst (cong-Str incl (≡→≡-Str (trans-Path lem-11 (sym-Path lem-12))))
-}

              -- ... thus we can use the universal property
              -- to get ⟨ x ⟩ ⟶ νs₄
              ε : ⟨ x ⟩ ⟶ νs₄
              ε = ⦗ σ₂₄ , {!!} ⦘₌ -- lem-13

              -- using this coequalizer derived hom, we can now build the proper
              -- 3 -> 4 morphisms

              --------------------------------------
              -- i) the "a" version
              σᵃ₃₄ : νs₃ₐ ⟶ νs₄ₐ
              σᵃ₃₄ = ι₀ ◆ ⟨ ϕ ⟩ ◆ ε ◆ ϖ₀

              postulate lem-20 : σᵃ₂₃ ◆ ι₀ ◆ ⟨ ϕ ⟩ ∼ ι₀ ◆ π₌
              {-
              lem-20 = σᵃ₂₃ ◆ ι₀ ◆ ⟨ ϕ ⟩              ⟨ lem-0 ⁻¹ ◈ refl ⟩-∼
                       ι₀ ◆ σ₂₃ ◆ ⟨ ϕ ⟩               ⟨ refl ⟩-∼
                       ι₀ ◆ (π₌ ◆ ⟨ ϕ ⟩⁻¹) ◆ ⟨ ϕ ⟩    ⟨ assoc-l-◆ ∙ (refl ◈ assoc-l-◆) ⟩-∼
                       ι₀ ◆ (π₌ ◆ (⟨ ϕ ⟩⁻¹ ◆ ⟨ ϕ ⟩))  ⟨ refl ◈ (refl ◈ inv-l-◆ (of ϕ)) ⟩-∼
                       ι₀ ◆ (π₌ ◆ id)                ⟨ refl ◈ unit-r-◆ ⟩-∼
                       ι₀ ◆ π₌                       ∎
              -}

              postulate lem-21 : σᵃ₂₃ ◆ ι₀ ◆ ⟨ ϕ ⟩ ◆ ε ∼ σᵃ₁₄ ◆ ι₀
              {-
              lem-21 = σᵃ₂₃ ◆ ι₀ ◆ ⟨ ϕ ⟩ ◆ ε      ⟨ lem-20 ◈ refl ⟩-∼
                       ι₀ ◆ π₌ ◆ ε                ⟨ assoc-l-◆ ⟩-∼
                       ι₀ ◆ (π₌ ◆ ε)              ⟨ refl ◈ reduce-π₌ ⟩-∼
                       ι₀ ◆ σ₂₄                   ⟨ reduce-ι₀ ⟩-∼
                       σᵃ₁₄ ◆ ι₀                  ∎
              -}

              postulate lem-22 : σᵃ₂₃ ◆ σᵃ₃₄ ∼ σᵃ₁₄
              {-
              lem-22 = σᵃ₂₃ ◆ (ι₀ ◆ ⟨ ϕ ⟩ ◆ ε ◆ ϖ₀)    ⟨ assoc-r-◆ ⟩-∼
                       (σᵃ₂₃ ◆ (ι₀ ◆ ⟨ ϕ ⟩ ◆ ε)) ◆ ϖ₀  ⟨ assoc-r-◆ ◈ refl ⟩-∼
                       ((σᵃ₂₃ ◆ (ι₀ ◆ ⟨ ϕ ⟩)) ◆ ε) ◆ ϖ₀ ⟨ assoc-r-◆ ◈ refl ◈ refl ⟩-∼
                       (((σᵃ₂₃ ◆ ι₀) ◆ ⟨ ϕ ⟩) ◆ ε) ◆ ϖ₀ ⟨ lem-21 ◈ refl ⟩-∼
                       σᵃ₁₄ ◆ ι₀ ◆ ϖ₀                  ⟨ assoc-l-◆ ⟩-∼
                       σᵃ₁₄ ◆ (ι₀ ◆ ϖ₀)                ⟨ refl ◈ reduce-ι₀ ⟩-∼
                       σᵃ₁₄ ◆ id                       ⟨ unit-r-◆ ⟩-∼
                       σᵃ₁₄                            ∎
              -}

              postulate lem-22b : σᵃ₂₃ ◆ (ι₀ ◆ ⟨ ϕ ⟩ ◆ ε) ∼ σᵃ₁₄ ◆ ι₀
              {-
              lem-22b = σᵃ₂₃ ◆ (ι₀ ◆ ⟨ ϕ ⟩ ◆ ε)     ⟨ assoc-r-◆ ⟩-∼
                        ((σᵃ₂₃ ◆ (ι₀ ◆ ⟨ ϕ ⟩)) ◆ ε) ⟨ assoc-r-◆ ◈ refl ⟩-∼
                        (((σᵃ₂₃ ◆ ι₀) ◆ ⟨ ϕ ⟩) ◆ ε) ⟨ lem-21 ⟩-∼
                        σᵃ₁₄ ◆ ι₀                  ∎
              -}

              postulate lem-23 : fst Γ<Γ₃ ◆ σᵃ₃₄ ∼ σᵃᵤ₄
              {-
              lem-23 = (σᵃᵤ₀ ◆ σᵃ₀₁) ◆ σᵃ₂₃ ◆ σᵃ₃₄       ⟨ assoc-l-◆ ⟩-∼
                       (σᵃᵤ₀ ◆ σᵃ₀₁) ◆ (σᵃ₂₃ ◆ σᵃ₃₄)     ⟨ refl ◈ lem-22 ⟩-∼
                       (σᵃᵤ₀ ◆ σᵃ₀₁) ◆ σᵃ₁₄              ⟨ assoc-l-◆ ⟩-∼
                       σᵃᵤ₀ ◆ (σᵃ₀₁ ◆ σᵃ₁₄)              ⟨ refl ◈ subProof ΩR₁ ⟩-∼
                       σᵃᵤ₀ ◆ σᵃ₀₄                       ⟨ subProof ΩR₀  ⟩-∼
                       σᵃᵤ₄                              ∎
              -}

              --------------------------------------
              -- i) the "x" version
              σˣ₃₄ : νs₃ₓ ⟶ νs₄
              σˣ₃₄ = ι₁ ◆ ⟨ ϕ ⟩ ◆ ε

              postulate lem-30 : σᵃ₃₄ ◆ ι₀ ∼ ι₀ ◆ ⟨ ϕ ⟩ ◆ ε
              {-
              lem-30 = cancel-epi {{_}} {{isEpi:epiHom factor:f}} lem-30a
                where
                  lem-30a : σᵃ₂₃ ◆ (σᵃ₃₄ ◆ ι₀) ∼ σᵃ₂₃ ◆ (ι₀ ◆ ⟨ ϕ ⟩ ◆ ε)
                  lem-30a = σᵃ₂₃ ◆ (σᵃ₃₄ ◆ ι₀)      ⟨ assoc-r-◆ ⟩-∼
                            (σᵃ₂₃ ◆ σᵃ₃₄) ◆ ι₀      ⟨ lem-22 ◈ refl ⟩-∼
                            σᵃ₁₄ ◆ ι₀               ⟨ lem-22b ⁻¹ ⟩-∼
                            σᵃ₂₃ ◆ (ι₀ ◆ ⟨ ϕ ⟩ ◆ ε) ∎
              -}

              lem-31 : σ₂₃ ◆ ⦗ σᵃ₃₄ ◆ ι₀ , σˣ₃₄ ⦘ ∼ σ₂₄
              lem-31 = σ₂₃ ◆ ⦗ σᵃ₃₄ ◆ ι₀ , σˣ₃₄ ⦘      ⟨ refl ◈ cong-∼ {{isSetoidHom:⦗⦘}} (lem-30 , refl) ⟩-∼
                       σ₂₃ ◆ ⦗ ι₀ ◆ ⟨ ϕ ⟩ ◆ ε , σˣ₃₄ ⦘
                         ⟨ refl ◈ cong-∼ {{isSetoidHom:⦗⦘}} (assoc-l-◆ , assoc-l-◆) ⟩-∼
                       σ₂₃ ◆ ⦗ ι₀ ◆ (⟨ ϕ ⟩ ◆ ε) , (ι₁ ◆ (⟨ ϕ ⟩ ◆ ε)) ⦘
                         ⟨ refl ◈ expand-ι₀,ι₁ ⁻¹ ⟩-∼
                       (π₌ ◆ ⟨ ϕ ⟩⁻¹) ◆ (⟨ ϕ ⟩ ◆ ε)
                         ⟨ assoc-[ab][cd]∼a[bc]d-◆ ⟩-∼
                       π₌ ◆ (⟨ ϕ ⟩⁻¹ ◆ ⟨ ϕ ⟩) ◆ ε
                         ⟨ refl ◈ inv-l-◆ (of ϕ) ◈ refl ⟩-∼
                       π₌ ◆ id ◆ ε
                         ⟨ unit-r-◆ ◈ refl ⟩-∼
                       π₌ ◆ ε
                         ⟨ reduce-π₌ ⟩-∼
                       σ₂₄
                         ∎

              lem-32 : γ₃ ⇃[ ⦗ σᵃ₃₄ ◆ ι₀ , σˣ₃₄ ⦘ ]⇂ ≡ ζ₄
              lem-32 = γ₂ ⇃[ σ₂₃ ]⇂ ⇃[ ⦗ σᵃ₃₄ ◆ ι₀ , σˣ₃₄ ⦘ ]⇂    ⟨ functoriality-◆-⇃[]⇂ {τ = γ₂} {f = σ₂₃} {⦗ σᵃ₃₄ ◆ ι₀ , σˣ₃₄ ⦘} ⟩-≡
                       γ₂ ⇃[ σ₂₃ ◆ ⦗ σᵃ₃₄ ◆ ι₀ , σˣ₃₄ ⦘ ]⇂        ⟨ γ₂ ⇃[≀ lem-31 ≀]⇂ ⟩-≡
                       γ₂ ⇃[ σ₂₄ ]⇂                               ⟨ lem-12b ⟩-≡
                       ζ₄                                         ∎-≡
-}
