import PLFA.Part1.Naturals

-- makes it so it doesn't do m.suc but rather .suc m (it's not a field..)
set_option pp.fieldNotation false

theorem plus_assoc : ∀ (m n p : ℕ), (m + n) + p = m + (n + p) := by
    intro m n p
    induction m with
    | zero =>
        calc
            (.zero + n) + p = (n + p)   := by rfl
            _ = .zero + (n + p)         := by rfl
    | suc m ih =>
        -- goal: plus (plus (ℕ.suc m) n) p = plus (ℕ.suc m) (plus n p)
        -- ih : plus (plus m n) p = plus m (plus n p)
        calc
            plus (plus (.suc m) n) p
              = plus (.suc (plus m n)) p := by rfl
            _ = .suc (plus m (plus n p)) := by
              exact congrArg ℕ.suc (ih)
            _ = .suc (plus m (plus n p)) := by rfl
/-
def plus : ℕ -> ℕ -> ℕ
    | .zero , n    => n
    | (.suc m) , n => .suc (plus m n)
-/

theorem plusIdentityRight : ∀ (m : ℕ),  m + .zero = m := by
    intro m
    induction m with
    -- goal: plus ℕ.zero ℕ.zero = ℕ.zero
    | zero =>
        calc
            plus ℕ.zero ℕ.zero
            = ℕ.zero := by rfl
    -- goal: plus (ℕ.suc m) ℕ.zero = ℕ.suc m
    --       ih : plus m ℕ.zero = m
    | suc m ih =>
        calc
            plus (ℕ.suc m) ℕ.zero
            = .suc (plus m .zero) := by rfl
          _ = .suc m              := by exact congrArg ℕ.suc ih

-- theorem plusSuc : ∀ (m n : ℕ), plus m (.suc n) = .suc (plus m n) := by
    -- intro m n
    -- induction m with
    -- -- goal: plus ℕ.zero (ℕ.suc n) = ℕ.suc (plus ℕ.zero n)
    -- | zero =>
        -- calc
            -- plus ℕ.zero (ℕ.suc n)
            -- = .suc n                  := by rfl
          -- _ = .suc (plus .zero n)     := by rfl -- rewrite using first defining eq of plus
    -- -- goal: plus (ℕ.suc m) (ℕ.suc n) = ℕ.suc (plus (ℕ.suc m) n)
    -- -- ih  : plus m (ℕ.suc n) = ℕ.suc (plus m n)
    -- | suc m ih =>
        -- calc
            -- plus (.suc m) (.suc n)
            -- = .suc (plus (.suc m) n) := by rfl
/-
def plus : ℕ -> ℕ -> ℕ
    | .zero , n    => n
    | (.suc m) , n => .suc (plus m n)
-/
