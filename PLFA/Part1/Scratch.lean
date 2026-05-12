import PLFA.Part1.Naturals

-- theorem plus_assoc : ∀ (m n p : ℕ), (m + n) + p = m + (n + p) := by
    -- intro m n p
    -- induction m with
    -- | zero =>
        -- calc
            -- (.zero + n) + p = (n + p)   := by rfl
            -- _ = .zero + (n + p)         := by rfl
    -- | suc m ih =>
        -- calc
            -- plus (plus (.suc m) n) p
              -- = plus (.suc (plus m n)) p := by rfl
            -- _ = .suc (plus (plus m n) p) := by rfl
            -- _ =  := by sorry