import PLFA.Part1.Naturals

theorem plus_assoc : ∀ (m n p : ℕ), (m + n) + p = m + (n + p) := by
    intro m n p
    induction m with
    --goal: ∀ m n p : ℕ, ⊢ plus (plus m n) p = plus m (plus n p)
    | zero =>
        calc
            (.zero + n) + p = (n + p)   := by rfl
            _ = .zero + (n + p)         := by rfl
    | suc m ih =>
        -- ih : plus (plus m n) p = plus m (plus n p)
        calc
            plus (plus (.suc m) n) p
              = plus (.suc (plus m n)) p := by rfl
            _ = .suc (plus m (plus n p)) := by
              exact congrArg ℕ.suc (ih)
            _ = .suc (plus m (plus n p)) := by rfl