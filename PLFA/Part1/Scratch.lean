import PLFA.Part1.Naturals

theorem plus_assoc : ∀ (m n p : ℕ), (m + n) + p = m + (n + p) := by
    intro m n p
    induction m
    | zero =>
        calc
            (.zero + n) + p = (n + p) := by rfl
            _ = .zero + (n + p) := by rfl
    | succ m ih => sorry