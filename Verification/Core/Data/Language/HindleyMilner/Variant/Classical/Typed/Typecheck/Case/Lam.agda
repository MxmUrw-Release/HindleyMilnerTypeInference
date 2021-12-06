{-
  where
    -- create a new metavariable
    μs₀ = μs ⊔ st

    αᵘ : ℒHMType ⟨ st ⟩
    αᵘ = var incl

    α₀ : ℒHMType ⟨ μs₀ ⊔ ⊥ ⟩
    α₀ = αᵘ ⇃[ ι₁ ◆ ι₀ ]⇂

    -- create the context which contains this new variable
    Γ₀ : ℒHMCtxFor Q μs₀
    Γ₀ = Γ ⇃[ ι₀ ]⇂ᶜ

    σ₀ : μs ⟶ μs ⊔ st
    σ₀ = ι₀

    Γ<Γ₀ : Γ <Γ Γ₀
    Γ<Γ₀ = record { fst = ι₀ ; snd = refl-≡ }

    -- call typechecking recursively on `te`
    res = γ (α₀ ∷ Γ₀) te

    -- computing the initial typing instance
    -- assuming we have one for te
    success : InitialCtxTypingInstance (α₀ ∷ Γ₀) te -> InitialCtxTypingInstance Γ (lam te)
    success ((μs₁ₐ / μs₁ₓ ⊩ (α₁ ∷ Γ₁) , β₁ , α₀Γ₀<α₁Γ₁ , α₁Γ₁⊢β₁) , Ω) = {!!} , {!!} -- 𝑇 , isInitial:𝑇
      where
        σᵃ₀₁ : μs₀ ⟶ μs₁ₐ
        σᵃ₀₁ = α₀Γ₀<α₁Γ₁ .fst

        Γ₀<Γ₁ : Γ₀ <Γ Γ₁
        Γ₀<Γ₁ = tail-SomeℒHMCtx (α₀Γ₀<α₁Γ₁)

        f : μs ⟶ μs₁ₐ
        f = ι₀ ◆ σᵃ₀₁

        factor:f = factorize f

        μs₂ₐ = image factor:f
        μs₂ₓ = rest factor:f
        μs₂ = μs₂ₐ ⊔ μs₂ₓ

        σᵃᵤ₂ : μs ⟶ μs₂ₐ
        σᵃᵤ₂ = epiHom factor:f

        ϕ : μs₂ ≅ μs₁ₐ
        ϕ = splitting factor:f

        lem-0 : ι₀ ◆ σᵃ₀₁ ◆ ⟨ ϕ ⟩⁻¹ ∼ σᵃᵤ₂ ◆ ι₀
        lem-0 = factors factor:f


        -- σᵤ₁ : μs ⟶ μs₁
        -- σᵤ₁ = σ₀ ◆ σ₀₁

        -- Γ<Γ₁ : Γ <Γ Γ₁
        -- Γ<Γ₁ = Γ<Γ₀ ⟡ tail-SomeℒHMCtx α₀Γ₀<α₁Γ₁

        Γ₂ = Γ ⇃[ σᵃᵤ₂ ]⇂ᶜ

        あ : (μs₂ₐ ⊔ μs₂ₓ) ⊔ μs₁ₓ ≅ μs₂ₐ ⊔ (μs₂ₓ ⊔ μs₁ₓ)
        あ = assoc-l-⊔-ℒHMTypes

        ψ⁻¹ : (μs₁ₐ ⊔ μs₁ₓ) ⟶ μs₂ₐ ⊔ (μs₂ₓ ⊔ μs₁ₓ)
        ψ⁻¹ = (⟨ ϕ ⟩⁻¹ ⇃⊔⇂ id) ◆ ⟨ あ ⟩

        α₂ : ℒHMType ⟨ μs₂ₐ ⊔ (μs₂ₓ ⊔ μs₁ₓ) ⟩
        α₂ = α₁ ⇃[ ⦗ ι₀ ◆ ψ⁻¹ , elim-⊥ ⦘ ]⇂


        β₂ : ℒHMType ⟨ μs₂ₐ ⊔ (μs₂ₓ ⊔ μs₁ₓ) ⟩
        β₂ = β₁ ⇃[ ψ⁻¹ ]⇂

        postulate lem-03 : ι₀ ◆ (σᵃ₀₁ ◆ (ι₀ ◆ ψ⁻¹)) ∼ σᵃᵤ₂ ◆ ι₀
        {-
        lem-03 = ι₀ ◆ (σᵃ₀₁ ◆ (ι₀ ◆ ((⟨ ϕ ⟩⁻¹ ⇃⊔⇂ id) ◆ ⟨ あ ⟩)))

                 ⟨ refl ◈ (refl ◈ assoc-r-◆ ) ⟩-∼

                 ι₀ ◆ (σᵃ₀₁ ◆ (ι₀ ◆ (⟨ ϕ ⟩⁻¹ ⇃⊔⇂ id) ◆ ⟨ あ ⟩))

                 ⟨ refl ◈ (refl ◈ (reduce-ι₀ ◈ refl) ) ⟩-∼

                 ι₀ ◆ (σᵃ₀₁ ◆ (⟨ ϕ ⟩⁻¹ ◆ ι₀ ◆ ⟨ あ ⟩))

                 ⟨ refl ◈ (refl ◈ (assoc-l-◆) ) ⟩-∼

                 ι₀ ◆ (σᵃ₀₁ ◆ (⟨ ϕ ⟩⁻¹ ◆ (ι₀ ◆ ⟨ あ ⟩)))

                 ⟨ refl ◈ (assoc-r-◆) ⟩-∼

                 ι₀ ◆ ((σᵃ₀₁ ◆ ⟨ ϕ ⟩⁻¹) ◆ (ι₀ ◆ ⟨ あ ⟩))

                 ⟨ (assoc-r-◆) ⟩-∼

                 (ι₀ ◆ (σᵃ₀₁ ◆ ⟨ ϕ ⟩⁻¹)) ◆ (ι₀ ◆ ⟨ あ ⟩)

                 ⟨ (assoc-r-◆) ◈ refl ⟩-∼

                 ((ι₀ ◆ σᵃ₀₁) ◆ ⟨ ϕ ⟩⁻¹) ◆ (ι₀ ◆ ⟨ あ ⟩)

                 ⟨ lem-0 ◈ refl ⟩-∼

                 (σᵃᵤ₂ ◆ ι₀) ◆ (ι₀ ◆ ⟨ あ ⟩)

                 ⟨ assoc-l-◆ ⟩-∼

                 σᵃᵤ₂ ◆ (ι₀ ◆ (ι₀ ◆ ⟨ あ ⟩))

                 ⟨ refl ◈ assoc-r-◆ ⟩-∼

                 σᵃᵤ₂ ◆ ((ι₀ ◆ ι₀) ◆ ⟨ あ ⟩)

                 ⟨ refl ◈ {!!} ⟩-∼

                 σᵃᵤ₂ ◆ ι₀

                 ∎
        -}

        postulate lem-04a : Γ₁ ⇃[ ι₀ ]⇂ᶜ ⇃[ ψ⁻¹ ]⇂ᶜ ≡ Γ ⇃[ σᵃᵤ₂ ]⇂ᶜ ⇃[ ι₀ ]⇂ᶜ
        {-
        lem-04a = Γ₁ ⇃[ ι₀ ]⇂ᶜ ⇃[ ψ⁻¹ ]⇂ᶜ      ⟨ functoriality-◆-⇃[]⇂-CtxFor {Γ = Γ₁} {f = ι₀} {ψ⁻¹} ⟩-≡
                  Γ₁ ⇃[ ι₀ ◆ ψ⁻¹ ]⇂ᶜ           ⟨ cong _⇃[ ι₀ ◆ ψ⁻¹ ]⇂ᶜ (sym-Path (snd Γ₀<Γ₁)) ⟩-≡
                  Γ ⇃[ ι₀ ]⇂ᶜ ⇃[ σᵃ₀₁ ]⇂ᶜ ⇃[ ι₀ ◆ ψ⁻¹ ]⇂ᶜ   ⟨ functoriality-◆-⇃[]⇂-CtxFor ⟩-≡
                  Γ ⇃[ ι₀ ]⇂ᶜ ⇃[ σᵃ₀₁ ◆ (ι₀ ◆ ψ⁻¹) ]⇂ᶜ   ⟨ functoriality-◆-⇃[]⇂-CtxFor ⟩-≡
                  Γ ⇃[ ι₀ ◆ (σᵃ₀₁ ◆ (ι₀ ◆ ψ⁻¹)) ]⇂ᶜ       ⟨ Γ ⇃[≀ lem-03 ≀]⇂ᶜ ⟩-≡
                  Γ ⇃[ σᵃᵤ₂ ◆ ι₀ ]⇂ᶜ           ⟨ sym-Path functoriality-◆-⇃[]⇂-CtxFor ⟩-≡
                  Γ ⇃[ σᵃᵤ₂ ]⇂ᶜ ⇃[ ι₀ ]⇂ᶜ      ∎-≡
        -}

        postulate lem-04b : α₁ ⇃[ ι₀ ⇃⊔⇂ id ]⇂ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂ ⇃[ ψ⁻¹ ]⇂ ≡ α₂
        {-
        lem-04b = α₁ ⇃[ ι₀ ⇃⊔⇂ id ]⇂ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂ ⇃[ ψ⁻¹ ]⇂

                  ⟨ cong _⇃[ ψ⁻¹ ]⇂ (functoriality-◆-⇃[]⇂ {τ = α₁} {f = (ι₀ ⇃⊔⇂ id)} {⦗ id , elim-⊥ ⦘}) ⟩-≡

                  α₁ ⇃[ (ι₀ ⇃⊔⇂ id) ◆ ⦗ id , elim-⊥ ⦘ ]⇂ ⇃[ ψ⁻¹ ]⇂

                  ⟨ functoriality-◆-⇃[]⇂ {τ = α₁} {f = (ι₀ ⇃⊔⇂ id) ◆ ⦗ id , elim-⊥ ⦘} {g = ψ⁻¹} ⟩-≡

                  α₁ ⇃[ (ι₀ ⇃⊔⇂ id) ◆ ⦗ id , elim-⊥ ⦘ ◆ ψ⁻¹ ]⇂

                  ⟨ α₁ ⇃[≀ lem-04bi ≀]⇂ ⟩-≡

                  α₂

                  ∎-≡

          where
            lem-04bi : (ι₀ ⇃⊔⇂ id) ◆ ⦗ id , elim-⊥ ⦘ ◆ ψ⁻¹ ∼ ⦗ ι₀ ◆ ψ⁻¹ , elim-⊥ ⦘
            lem-04bi = (ι₀ ⇃⊔⇂ id) ◆ ⦗ id , elim-⊥ ⦘ ◆ ψ⁻¹  ⟨ append-⇃⊔⇂ ◈ refl ⟩-∼
                       ⦗ (ι₀ ◆ id , id ◆ elim-⊥) ⦘ ◆ ψ⁻¹    ⟨ cong-∼ {{isSetoidHom:⦗⦘}} (unit-r-◆ , unit-l-◆)◈ refl ⟩-∼
                       ⦗ (ι₀ , elim-⊥) ⦘ ◆ ψ⁻¹              ⟨ append-⦗⦘ ⟩-∼
                       ⦗ ι₀ ◆ ψ⁻¹ , elim-⊥ ◆ ψ⁻¹ ⦘          ⟨ cong-∼ {{isSetoidHom:⦗⦘}} (refl , expand-⊥) ⟩-∼
                       ⦗ ι₀ ◆ ψ⁻¹ , elim-⊥ ⦘                ∎
        -}


        postulate lem-05 : isTypedℒHM (μs₂ₐ ⊔ (μs₂ₓ ⊔ μs₁ₓ) ⊩ (_ , Γ₂ ⇃[ ι₀ ]⇂ᶜ) ⊢ α₂ ⇒ β₂) (lam te)
        {-
        lem-05 = lam α₁Γ₁⊢β₁
                 ⟪ §-isTypedℒHM.prop-2 ψ⁻¹ ⟫
                 >> isTypedℒHM ((μs₂ₐ ⊔ (μs₂ₓ ⊔ μs₁ₓ)) ⊩ (Q) , (Γ₁ ⇃[ ι₀ ]⇂ᶜ ⇃[ ψ⁻¹ ]⇂ᶜ) ⊢ _ ⇒ β₂) (lam te) <<

                 ⟪ transp-isTypedℒHM lem-04a (λ i -> lem-04b i ⇒ β₂) ⟫
        -}


        Γ<Γ₂ : Γ <Γ Γ₂
        Γ<Γ₂ = record { fst = σᵃᵤ₂ ; snd = refl-≡ }

        𝑇 : CtxTypingInstance Γ (lam te)
        𝑇 = μs₂ₐ / (μs₂ₓ ⊔ μs₁ₓ) ⊩ Γ₂ , α₂ ⇒ β₂ , Γ<Γ₂ , (lem-05)


        isInitial:𝑇 : (𝑆 : CtxTypingInstance Γ (lam te)) -> 𝑇 <TI 𝑆
        isInitial:𝑇 (μs₃ₐ / μs₃ₓ ⊩ Γ₃ , .(_ ⇒ _) , Γ<Γ₃ , lam {α = α₃} {β = β₃} Γ₃α₃⊢β₃) =
          record { tiSubₐ = σᵃ₂₃ ; tiSubₓ = σˣ₂₃ ; typProof = lem-50 ; subProof = lem-20 }

          where
            σᵃᵤ₃ : μs ⟶ μs₃ₐ
            σᵃᵤ₃ = Γ<Γ₃ .fst

            β₃' : ℒHMType ⟨(μs₃ₐ ⊔ μs₃ₓ ⊔ ⊥)⟩
            β₃' = β₃ ⇃[ ι₀ ]⇂

            Γ₃' : ℒHMCtxFor _ (μs₃ₐ ⊔ μs₃ₓ)
            Γ₃' = Γ₃ ⇃[ ι₀ ]⇂ᶜ

            lem-9 : isTypedℒHM (μs₃ₐ ⊔ μs₃ₓ ⊔ ⊥ ⊩ (_ , (α₃ ∷ Γ₃') ⇃[ ι₀ ]⇂ᶜ) ⊢ β₃') te
            lem-9 = Γ₃α₃⊢β₃
                    ⟪ §-isTypedℒHM.prop-2 ι₀ ⟫

            α₃' : ℒHMType ⟨ μs₃ₐ ⊔ μs₃ₓ ⟩
            α₃' = α₃ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂

            σα₃ : st ⟶ μs₃ₐ ⊔ μs₃ₓ
            σα₃ = ⧜subst (incl α₃')

            σᵃ₀₃' : μs₀ ⟶ μs₃ₐ ⊔ μs₃ₓ
            σᵃ₀₃' = ⦗ σᵃᵤ₃ ◆ ι₀ , σα₃ ⦘

            postulate lem-10a : α₀ ⇃[ σᵃ₀₃' ⇃⊔⇂ id ]⇂ ≡ α₃
            {-
            lem-10a = αᵘ ⇃[ ι₁ ◆ ι₀ ]⇂ ⇃[ σᵃ₀₃' ⇃⊔⇂ id ]⇂     ⟨ functoriality-◆-⇃[]⇂ {τ = αᵘ} {f = ι₁ ◆ ι₀} {σᵃ₀₃' ⇃⊔⇂ id} ⟩-≡
                      αᵘ ⇃[ ι₁ ◆ ι₀ ◆ (σᵃ₀₃' ⇃⊔⇂ id) ]⇂       ⟨ αᵘ ⇃[≀ lem-10ai ≀]⇂ ⟩-≡
                      αᵘ ⇃[ σα₃ ◆ ι₀ ]⇂                       ⟨ sym-Path (functoriality-◆-⇃[]⇂ {τ = αᵘ} {f = σα₃} {ι₀}) ⟩-≡
                      αᵘ ⇃[ σα₃ ]⇂ ⇃[ ι₀ ]⇂                   ⟨ refl-≡ ⟩-≡
                      α₃ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂ ⇃[ ι₀ ]⇂       ⟨ functoriality-◆-⇃[]⇂ {τ = α₃} {f = ⦗ id , elim-⊥ ⦘} {ι₀} ⟩-≡
                      α₃ ⇃[ ⦗ id , elim-⊥ ⦘ ◆ ι₀ ]⇂           ⟨ α₃ ⇃[≀ §-ϖ.prop-1  ≀]⇂ ⟩-≡
                      α₃ ⇃[ id ]⇂                             ⟨ functoriality-id-⇃[]⇂ ⟩-≡
                      α₃                                      ∎-≡
              where
                postulate lem-10ai : ι₁ ◆ ι₀ ◆ (σᵃ₀₃' ⇃⊔⇂ id) ∼ σα₃ ◆ ι₀
                {-
                lem-10ai = ι₁ ◆ ι₀ ◆ (σᵃ₀₃' ⇃⊔⇂ id)     ⟨ assoc-l-◆ ⟩-∼
                           ι₁ ◆ (ι₀ ◆ (σᵃ₀₃' ⇃⊔⇂ id))   ⟨ refl ◈ reduce-ι₀ ⟩-∼
                           ι₁ ◆ (σᵃ₀₃' ◆ ι₀)            ⟨ assoc-r-◆ ⟩-∼
                           (ι₁ ◆ σᵃ₀₃') ◆ ι₀            ⟨ reduce-ι₁ ◈ refl ⟩-∼
                           (σα₃) ◆ ι₀                   ∎
                -}
            -}

            postulate lem-10b : Γ₀ ⇃[ σᵃ₀₃' ]⇂ᶜ ≡ Γ₃'
            {-
            lem-10b = Γ ⇃[ ι₀ ]⇂ᶜ ⇃[ σᵃ₀₃' ]⇂ᶜ  ⟨ functoriality-◆-⇃[]⇂-CtxFor ⟩-≡
                      Γ ⇃[ ι₀ ◆ σᵃ₀₃' ]⇂ᶜ       ⟨ Γ ⇃[≀ reduce-ι₀ ≀]⇂ᶜ ⟩-≡
                      Γ ⇃[ σᵃᵤ₃ ◆ ι₀ ]⇂ᶜ        ⟨ sym-Path functoriality-◆-⇃[]⇂-CtxFor ⟩-≡
                      Γ ⇃[ σᵃᵤ₃ ]⇂ᶜ ⇃[ ι₀ ]⇂ᶜ   ⟨ cong _⇃[ ι₀ ]⇂ᶜ (snd Γ<Γ₃) ⟩-≡
                      Γ₃ ⇃[ ι₀ ]⇂ᶜ              ∎-≡
            -}

            α₀Γ₀<α₃Γ₃' : (α₀ ∷ Γ₀) <Γ (α₃ ∷ Γ₃')
            α₀Γ₀<α₃Γ₃' = record { fst = σᵃ₀₃' ; snd = λ i → lem-10a i ∷ lem-10b i }

            ΩR = Ω ((μs₃ₐ ⊔ μs₃ₓ) / ⊥ ⊩ α₃ ∷ Γ₃' , β₃' , α₀Γ₀<α₃Γ₃' , lem-9)

            σᵃ₁₃ : μs₁ₐ ⟶ μs₃ₐ ⊔ μs₃ₓ
            σᵃ₁₃ = tiSubₐ ΩR

            σˣ₁₃ : μs₁ₓ ⟶ (μs₃ₐ ⊔ μs₃ₓ) ⊔ ⊥
            σˣ₁₃ = tiSubₓ ΩR

            σᵃ₂₃ : μs₂ₐ ⟶ μs₃ₐ
            σᵃ₂₃ = ι₀ ◆ ⟨ ϕ ⟩ ◆ σᵃ₁₃ ◆ ϖ₀
            -- σ₂₃ ◆ ϖ₀

            σˣ₂₃ : (μs₂ₓ ⊔ μs₁ₓ) ⟶ μs₃ₐ ⊔ μs₃ₓ
            σˣ₂₃ = ⦗ ι₁ ◆ ⟨ ϕ ⟩ ◆ σᵃ₁₃ , σˣ₁₃ ◆ ϖ₀ ⦘

            postulate lem-15 : σᵃᵤ₂ ◆ (ι₀ ◆ ⟨ ϕ ⟩) ∼ ι₀ ◆ σᵃ₀₁
            {-
            lem-15 = σᵃᵤ₂ ◆ (ι₀ ◆ ⟨ ϕ ⟩)             ⟨ assoc-r-◆ ⟩-∼
                     (σᵃᵤ₂ ◆ ι₀) ◆ ⟨ ϕ ⟩             ⟨ lem-0 ◈ refl ⟩-∼
                     ι₀ ◆ σᵃ₀₁ ◆ ⟨ ϕ ⟩⁻¹ ◆ ⟨ ϕ ⟩     ⟨ assoc-l-◆ ⟩-∼
                     ι₀ ◆ σᵃ₀₁ ◆ (⟨ ϕ ⟩⁻¹ ◆ ⟨ ϕ ⟩)   ⟨ refl ◈ inv-l-◆ (of ϕ) ⟩-∼
                     ι₀ ◆ σᵃ₀₁ ◆ id                 ⟨ unit-r-◆ ⟩-∼
                     ι₀ ◆ σᵃ₀₁                      ∎
            -}

            postulate lem-16 : σᵃᵤ₂ ◆ (ι₀ ◆ ⟨ ϕ ⟩ ◆ σᵃ₁₃) ∼ σᵃᵤ₃ ◆ ι₀
            {-
            lem-16 = σᵃᵤ₂ ◆ (ι₀ ◆ ⟨ ϕ ⟩ ◆ σᵃ₁₃)     ⟨ assoc-r-◆ ⟩-∼
                     σᵃᵤ₂ ◆ (ι₀ ◆ ⟨ ϕ ⟩) ◆ σᵃ₁₃     ⟨ lem-15 ◈ refl ⟩-∼
                     ι₀ ◆ σᵃ₀₁ ◆ σᵃ₁₃               ⟨ assoc-l-◆ ⟩-∼
                     ι₀ ◆ (σᵃ₀₁ ◆ σᵃ₁₃)             ⟨ refl ◈ subProof ΩR ⟩-∼
                     ι₀ ◆ (σᵃ₀₃')                   ⟨ reduce-ι₀ ⟩-∼
                     (σᵃᵤ₃ ◆ ι₀)                    ∎
            -}

            postulate lem-20 : σᵃᵤ₂ ◆ σᵃ₂₃ ∼ σᵃᵤ₃
            {-
            lem-20 = σᵃᵤ₂ ◆ (ι₀ ◆ ⟨ ϕ ⟩ ◆ σᵃ₁₃ ◆ ϖ₀)  ⟨ assoc-r-◆ ⟩-∼
                     σᵃᵤ₂ ◆ (ι₀ ◆ ⟨ ϕ ⟩ ◆ σᵃ₁₃) ◆ ϖ₀  ⟨ lem-16 ◈ refl ⟩-∼
                     σᵃᵤ₃ ◆ ι₀ ◆ ϖ₀                   ⟨ assoc-l-◆ ⟩-∼
                     σᵃᵤ₃ ◆ (ι₀ ◆ ϖ₀)                 ⟨ refl ◈ reduce-ι₀ ⟩-∼
                     σᵃᵤ₃ ◆ id                        ⟨ unit-r-◆ ⟩-∼
                     σᵃᵤ₃                             ∎
            -}

            postulate lem-30 : σᵃ₂₃ ◆ ι₀ ∼ ι₀ ◆ ⟨ ϕ ⟩ ◆ σᵃ₁₃
            {-
            lem-30 = cancel-epi {{_}} {{isEpi:epiHom factor:f}} lem-30a
              where
                lem-30a : σᵃᵤ₂ ◆ (σᵃ₂₃ ◆ ι₀) ∼ σᵃᵤ₂ ◆ (ι₀ ◆ ⟨ ϕ ⟩ ◆ σᵃ₁₃)
                lem-30a = σᵃᵤ₂ ◆ (σᵃ₂₃ ◆ ι₀)           ⟨ assoc-r-◆ ⟩-∼
                          (σᵃᵤ₂ ◆ σᵃ₂₃) ◆ ι₀           ⟨ lem-20 ◈ refl ⟩-∼
                          σᵃᵤ₃ ◆ ι₀                    ⟨ lem-16 ⁻¹ ⟩-∼
                          σᵃᵤ₂ ◆ (ι₀ ◆ ⟨ ϕ ⟩ ◆ σᵃ₁₃)   ∎
            -}

            -------------------------------------------------
            -- these lemmas are needed for the α₂ ⇃[ "σ₂₃" ]⇂ ≡ α₃ proof
            postulate lem-31 : ⦗ σᵃ₂₃ ◆ ι₀ , σˣ₂₃ ⦘ ∼ ⟨ あ ⟩⁻¹ ◆ ⦗ ⟨ ϕ ⟩ ◆ σᵃ₁₃ , σˣ₁₃ ◆ ϖ₀ ⦘
            {-
            lem-31 = ⦗ σᵃ₂₃ ◆ ι₀ , ⦗ ι₁ ◆ ⟨ ϕ ⟩ ◆ σᵃ₁₃ , σˣ₁₃ ◆ ϖ₀ ⦘ ⦘

                     ⟨ cong-∼ {{isSetoidHom:⦗⦘}} (lem-30 , refl) ⟩-∼

                     ⦗ ι₀ ◆ ⟨ ϕ ⟩ ◆ σᵃ₁₃ , ⦗ ι₁ ◆ ⟨ ϕ ⟩ ◆ σᵃ₁₃ , σˣ₁₃ ◆ ϖ₀ ⦘ ⦘

                     ⟨ {!!} ⟩-∼

                     ⟨ あ ⟩⁻¹ ◆ ⦗ ⦗ ι₀ ◆ ⟨ ϕ ⟩ ◆ σᵃ₁₃ , ι₁ ◆ ⟨ ϕ ⟩ ◆ σᵃ₁₃ ⦘ , σˣ₁₃ ◆ ϖ₀ ⦘

                     ⟨ refl ◈ ⦗≀ ⦗≀ assoc-l-◆ , assoc-l-◆ ≀⦘ , refl ≀⦘ ⟩-∼

                     ⟨ あ ⟩⁻¹ ◆ ⦗ ⦗ ι₀ ◆ (⟨ ϕ ⟩ ◆ σᵃ₁₃) , ι₁ ◆ (⟨ ϕ ⟩ ◆ σᵃ₁₃) ⦘ , σˣ₁₃ ◆ ϖ₀ ⦘

                     ⟨ refl ◈ ⦗≀ expand-ι₀,ι₁ ⁻¹ , refl ≀⦘ ⟩-∼

                     ⟨ あ ⟩⁻¹ ◆ ⦗ ⟨ ϕ ⟩ ◆ σᵃ₁₃ , σˣ₁₃ ◆ ϖ₀ ⦘

                     ∎
            -}

            postulate lem-32 : ψ⁻¹ ◆ (⟨ あ ⟩⁻¹ ◆ ⦗ ⟨ ϕ ⟩ ◆ σᵃ₁₃ , σˣ₁₃ ◆ ϖ₀ ⦘) ∼ ⦗ σᵃ₁₃ , (σˣ₁₃ ◆ ϖ₀) ⦘
            {-
            lem-32 = (⟨ ϕ ⟩⁻¹ ⇃⊔⇂ id) ◆ ⟨ あ ⟩ ◆ (⟨ あ ⟩⁻¹ ◆ _)

                     ⟨ assoc-r-◆ ⟩-∼

                     (⟨ ϕ ⟩⁻¹ ⇃⊔⇂ id) ◆ ⟨ あ ⟩ ◆ ⟨ あ ⟩⁻¹ ◆ _

                     ⟨ assoc-l-◆ ◈ refl ⟩-∼

                     (⟨ ϕ ⟩⁻¹ ⇃⊔⇂ id) ◆ (⟨ あ ⟩ ◆ ⟨ あ ⟩⁻¹) ◆ _

                     ⟨ refl ◈ (inv-r-◆ (of あ)) ◈ refl ⟩-∼

                     (⟨ ϕ ⟩⁻¹ ⇃⊔⇂ id) ◆ id ◆ _

                     ⟨ unit-r-◆ ◈ refl ⟩-∼

                     (⟨ ϕ ⟩⁻¹ ⇃⊔⇂ id) ◆ ⦗ ⟨ ϕ ⟩ ◆ σᵃ₁₃ , σˣ₁₃ ◆ ϖ₀ ⦘

                     ⟨ append-⇃⊔⇂ ⟩-∼

                     ⦗ ⟨ ϕ ⟩⁻¹ ◆ (⟨ ϕ ⟩ ◆ σᵃ₁₃) , id ◆ (σˣ₁₃ ◆ ϖ₀) ⦘

                     ⟨ ⦗≀ assoc-r-◆ ∙ (inv-l-◆ (of ϕ) ◈ refl) ∙ unit-l-◆ , unit-l-◆ ≀⦘ ⟩-∼

                     ⦗ σᵃ₁₃ , (σˣ₁₃ ◆ ϖ₀) ⦘

                     ∎
            -}

            postulate lem-33 : ι₀ ◆ ⦗ ι₀ ◆ ψ⁻¹ , elim-⊥ ⦘ ◆ (⟨ あ ⟩⁻¹ ◆ ⦗ ⟨ ϕ ⟩ ◆ σᵃ₁₃ , σˣ₁₃ ◆ ϖ₀ ⦘) ∼ σᵃ₁₃
            {-
            lem-33 = ι₀ ◆ ⦗ ι₀ ◆ ψ⁻¹ , elim-⊥ ⦘ ◆ _

                     ⟨ reduce-ι₀ ◈ refl ⟩-∼

                     ι₀ ◆ ψ⁻¹ ◆ _

                     ⟨ assoc-l-◆ ⟩-∼

                     ι₀ ◆ (ψ⁻¹ ◆ _)

                     ⟨ refl ◈ lem-32 ⟩-∼

                     ι₀ ◆ ⦗ σᵃ₁₃ , (σˣ₁₃ ◆ ϖ₀) ⦘

                     ⟨ reduce-ι₀ ⟩-∼

                     σᵃ₁₃

                     ∎
            -}


            postulate lem-34 : ⦗ ι₀ ◆ ψ⁻¹ , elim-⊥ ⦘ ◆ (⦗ σᵃ₂₃ ◆ ι₀ , σˣ₂₃ ⦘) ∼ (σᵃ₁₃ ⇃⊔⇂ id) ◆ ⦗ id , elim-⊥ ⦘
            {-
            lem-34 = §-ϖ.prop-2 lem-34a
              where
                lem-34a : ι₀ ◆ (⦗ ι₀ ◆ ψ⁻¹ , elim-⊥ ⦘ ◆ (⦗ σᵃ₂₃ ◆ ι₀ , σˣ₂₃ ⦘)) ∼ ι₀ ◆ ((σᵃ₁₃ ⇃⊔⇂ id) ◆ ⦗ id , elim-⊥ ⦘)
                lem-34a = ι₀ ◆ (⦗ ι₀ ◆ ψ⁻¹ , elim-⊥ ⦘ ◆ (⦗ σᵃ₂₃ ◆ ι₀ , σˣ₂₃ ⦘))

                          ⟨ refl ◈ (refl ◈ lem-31 ) ⟩-∼

                          ι₀ ◆ (⦗ ι₀ ◆ ψ⁻¹ , elim-⊥ ⦘ ◆ (⟨ あ ⟩⁻¹ ◆ ⦗ ⟨ ϕ ⟩ ◆ σᵃ₁₃ , σˣ₁₃ ◆ ϖ₀ ⦘))

                          ⟨ assoc-r-◆ ⟩-∼

                          (ι₀ ◆ ⦗ ι₀ ◆ ψ⁻¹ , elim-⊥ ⦘) ◆ (⟨ あ ⟩⁻¹ ◆ ⦗ ⟨ ϕ ⟩ ◆ σᵃ₁₃ , σˣ₁₃ ◆ ϖ₀ ⦘)

                          ⟨ lem-33 ⟩-∼

                          σᵃ₁₃

                          ⟨ unit-r-◆ ⁻¹ ⟩-∼

                          σᵃ₁₃ ◆ id

                          ⟨ refl ◈ reduce-ι₀ ⁻¹ ⟩-∼

                          σᵃ₁₃ ◆ (ι₀  ◆ ⦗ id , elim-⊥ ⦘)

                          ⟨ assoc-r-◆ ⟩-∼

                          (σᵃ₁₃ ◆ ι₀ ) ◆ ⦗ id , elim-⊥ ⦘

                          ⟨ reduce-ι₀ ⁻¹ ◈ refl ⟩-∼

                          (ι₀ ◆ (σᵃ₁₃ ⇃⊔⇂ id)) ◆ ⦗ id , elim-⊥ ⦘

                          ⟨ assoc-l-◆ ⟩-∼

                          ι₀ ◆ ((σᵃ₁₃ ⇃⊔⇂ id) ◆ ⦗ id , elim-⊥ ⦘)

                          ∎
            -}

            postulate lem-35 : α₁ ⇃[ (σᵃ₁₃ ⇃⊔⇂ id) ]⇂ ≡ α₀ ⇃[ σᵃ₀₃' ⇃⊔⇂ id ]⇂
            {-
            lem-35 = α₁ ⇃[ (σᵃ₁₃ ⇃⊔⇂ id) ]⇂                         ⟨ sym-Path (cong _⇃[ (σᵃ₁₃ ⇃⊔⇂ id) ]⇂ (λ i -> split-Listᴰ² (α₀Γ₀<α₁Γ₁ .snd i) .fst)) ⟩-≡
                     α₀ ⇃[ (σᵃ₀₁ ⇃⊔⇂ id) ]⇂ ⇃[ (σᵃ₁₃ ⇃⊔⇂ id) ]⇂     ⟨ functoriality-◆-⇃[]⇂ {τ = α₀} {f = (σᵃ₀₁ ⇃⊔⇂ id)} {(σᵃ₁₃ ⇃⊔⇂ id)} ⟩-≡
                     α₀ ⇃[ (σᵃ₀₁ ⇃⊔⇂ id) ◆ (σᵃ₁₃ ⇃⊔⇂ id) ]⇂         ⟨ α₀ ⇃[≀ functoriality-◆-⊔ ⁻¹ ≀]⇂ ⟩-≡
                     α₀ ⇃[ ((σᵃ₀₁ ◆ σᵃ₁₃) ⇃⊔⇂ (id ◆ id)) ]⇂             ⟨ α₀ ⇃[≀ subProof ΩR ≀⇃⊔⇂≀ unit-2-◆ ≀]⇂ ⟩-≡
                     α₀ ⇃[ (σᵃ₀₃' ⇃⊔⇂ id) ]⇂                        ∎-≡
            -}

            postulate lem-40 : α₂ ⇃[ ⦗ σᵃ₂₃ ◆ ι₀ , σˣ₂₃ ⦘ ]⇂ ≡ α₃'
            {-
            lem-40 = α₁ ⇃[ ⦗ ι₀ ◆ ψ⁻¹ , elim-⊥ ⦘ ]⇂ ⇃[ ⦗ σᵃ₂₃ ◆ ι₀ , σˣ₂₃ ⦘ ]⇂

                     ⟨ functoriality-◆-⇃[]⇂ {τ = α₁} {f = ⦗ ι₀ ◆ ψ⁻¹ , elim-⊥ ⦘} {⦗ σᵃ₂₃ ◆ ι₀ , σˣ₂₃ ⦘} ⟩-≡

                     α₁ ⇃[ ⦗ ι₀ ◆ ψ⁻¹ , elim-⊥ ⦘ ◆ ⦗ σᵃ₂₃ ◆ ι₀ , σˣ₂₃ ⦘ ]⇂

                     ⟨ α₁ ⇃[≀ lem-34 ≀]⇂ ⟩-≡

                     α₁ ⇃[ (σᵃ₁₃ ⇃⊔⇂ id) ◆ ⦗ id , elim-⊥ ⦘ ]⇂

                     ⟨ sym-Path (functoriality-◆-⇃[]⇂ {τ = α₁} {f = (σᵃ₁₃ ⇃⊔⇂ id)} {⦗ id , elim-⊥ ⦘}) ⟩-≡

                     α₁ ⇃[ (σᵃ₁₃ ⇃⊔⇂ id) ]⇂ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂

                     ⟨ cong _⇃[ ⦗ id , elim-⊥ ⦘ ]⇂ lem-35 ⟩-≡

                     α₀ ⇃[ (σᵃ₀₃' ⇃⊔⇂ id) ]⇂ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂

                     ⟨ cong _⇃[ ⦗ id , elim-⊥ ⦘ ]⇂ (λ i -> split-Listᴰ² (α₀Γ₀<α₃Γ₃' .snd i) .fst) ⟩-≡

                     α₃ ⇃[ ⦗ id , elim-⊥ ⦘ ]⇂

                     ⟨ refl-≡ ⟩-≡

                     α₃'

                     ∎-≡
            -}

            -------------------------------------------------------
            -- now the lemmas for β₂ ⇃[ "σ₂₃" ]⇂ ≡ β₃ proof

            postulate lem-41 : β₁ ⇃[ ψ⁻¹ ]⇂ ⇃[ ⦗ σᵃ₂₃ ◆ ι₀ , σˣ₂₃ ⦘ ◆ ι₀ ]⇂ ≡ β₃'
            {-
            lem-41 = β₁ ⇃[ ψ⁻¹ ]⇂ ⇃[ ⦗ σᵃ₂₃ ◆ ι₀ , σˣ₂₃ ⦘ ◆ ι₀ ]⇂

                     ⟨ (functoriality-◆-⇃[]⇂ {τ = β₁} {f = ψ⁻¹} {⦗ σᵃ₂₃ ◆ ι₀ , σˣ₂₃ ⦘ ◆ ι₀}) ⟩-≡

                     β₁ ⇃[ ψ⁻¹ ◆ (⦗ σᵃ₂₃ ◆ ι₀ , σˣ₂₃ ⦘ ◆ ι₀) ]⇂

                     ⟨ β₁ ⇃[≀ lem-41a ≀]⇂ ⟩-≡

                     β₁ ⇃[ ⦗ σᵃ₁₃ ◆ ι₀ , σˣ₁₃ ⦘ ]⇂

                     ⟨ typProof ΩR ⟩-≡

                     β₃'

                     ∎-≡

              where
                postulate lem-41a : ψ⁻¹ ◆ (⦗ σᵃ₂₃ ◆ ι₀ , σˣ₂₃ ⦘ ◆ ι₀) ∼ ⦗ σᵃ₁₃ ◆ ι₀ , σˣ₁₃ ⦘
                {-
                lem-41a = ψ⁻¹ ◆ (⦗ σᵃ₂₃ ◆ ι₀ , σˣ₂₃ ⦘ ◆ ι₀)

                      ⟨ assoc-r-◆ ⟩-∼

                      (ψ⁻¹ ◆ ⦗ σᵃ₂₃ ◆ ι₀ , σˣ₂₃ ⦘) ◆ ι₀

                      ⟨ (refl ◈ lem-31) ◈ refl ⟩-∼

                      ψ⁻¹ ◆ (⟨ あ ⟩⁻¹ ◆ ⦗ ⟨ ϕ ⟩ ◆ σᵃ₁₃ , σˣ₁₃ ◆ ϖ₀ ⦘) ◆ ι₀

                      ⟨ lem-32 ◈ refl ⟩-∼

                      ⦗ σᵃ₁₃ , (σˣ₁₃ ◆ ϖ₀) ⦘ ◆ ι₀

                      ⟨ append-⦗⦘ ⟩-∼

                      ⦗ σᵃ₁₃ ◆ ι₀ , (σˣ₁₃ ◆ ϖ₀) ◆ ι₀ ⦘

                      ⟨ ⦗≀ refl , assoc-l-◆ ≀⦘ ⟩-∼

                      ⦗ σᵃ₁₃ ◆ ι₀ , σˣ₁₃ ◆ (ϖ₀ ◆ ι₀) ⦘

                      ⟨ ⦗≀ refl , ((refl ◈ §-ϖ.prop-1) ∙ unit-r-◆) ≀⦘ ⟩-∼

                      ⦗ σᵃ₁₃ ◆ ι₀ , σˣ₁₃ ⦘

                      ∎
                -}
            -}

            postulate lem-42 : β₁ ⇃[ ψ⁻¹ ]⇂ ⇃[ ⦗ σᵃ₂₃ ◆ ι₀ , σˣ₂₃ ⦘ ]⇂ ≡ β₃
            {-
            lem-42 = β₁ ⇃[ ψ⁻¹ ]⇂ ⇃[ ⦗ σᵃ₂₃ ◆ ι₀ , σˣ₂₃ ⦘ ]⇂

                     ⟨ β₁ ⇃[ ψ⁻¹ ]⇂ ⇃[≀ unit-r-◆ ⁻¹ ∙ (refl ◈ reduce-ι₀ ⁻¹) ∙ assoc-r-◆ ≀]⇂ ⟩-≡

                     β₁ ⇃[ ψ⁻¹ ]⇂ ⇃[ (⦗ σᵃ₂₃ ◆ ι₀ , σˣ₂₃ ⦘ ◆ ι₀) ◆ ϖ₀ ]⇂

                     ⟨ sym-Path (functoriality-◆-⇃[]⇂ {τ = β₁ ⇃[ ψ⁻¹ ]⇂} {f = (⦗ σᵃ₂₃ ◆ ι₀ , σˣ₂₃ ⦘ ◆ ι₀)} {ϖ₀}) ⟩-≡

                     β₁ ⇃[ ψ⁻¹ ]⇂ ⇃[ (⦗ σᵃ₂₃ ◆ ι₀ , σˣ₂₃ ⦘ ◆ ι₀) ]⇂ ⇃[ ϖ₀ ]⇂

                     ⟨ cong _⇃[ ϖ₀ ]⇂ lem-41 ⟩-≡

                     β₃ ⇃[ ι₀ ]⇂ ⇃[ ϖ₀ ]⇂

                     ⟨ functoriality-◆-⇃[]⇂ {τ = β₃} {f = ι₀} {ϖ₀} ⟩-≡

                     β₃ ⇃[ ι₀ ◆ ϖ₀ ]⇂

                     ⟨ β₃ ⇃[≀ reduce-ι₀ ≀]⇂ ⟩-≡

                     β₃ ⇃[ id ]⇂

                     ⟨ functoriality-id-⇃[]⇂ ⟩-≡

                     β₃

                     ∎-≡
            -}


            lem-50 : (α₂ ⇒ β₂) ⇃[ ⦗ σᵃ₂₃ ◆ ι₀ , σˣ₂₃ ⦘ ]⇂ ≡ α₃' ⇒ β₃
            lem-50 = λ i -> lem-40 i ⇒ lem-42 i
-}

{-
    -------------------------------------------------
    -- putting it together

    -- distinguish between failure and not
    resn = case res of
      -- if there was a failure,
      -- we also have to fail
      (λ ¬typing → left
         -- assume we have a typing for lambda
         -- this means that we also have a typing for te
         -- which we know is impossible
         λ {(νs ⊩ Δ , τ , Γ₀<Δ , hastyp)
                → let νs' , Δ' , τ' , hastyp' = §-isTypedℒHM.prop-1 te hastyp
                  in {!!} -- ¬typing (νs' ⊩ Δ' , τ' , {!!} , hastyp')
                  })
      (right ∘ success)
-}
