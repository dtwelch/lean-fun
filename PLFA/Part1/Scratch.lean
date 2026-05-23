import PLFA.Part1.Naturals

-- makes it so it doesn't do m.suc but rather .suc m (it's not a field..)
set_option pp.fieldNotation false

theorem plusAssoc : ∀ (m n p : ℕ), plus (plus m n) p = plus m (plus n p) := by
    intro m n p
    induction m with
    | zero =>
        calc
            plus (plus .zero n) p = (plus n p)  := by rfl
            _ = plus .zero (plus n p)           := by rfl
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

theorem plusIdentityRight : ∀ (m : ℕ),  plus m .zero = m := by
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

theorem plusSuc : ∀ (m n : ℕ), plus m (.suc n) = .suc (plus m n) := by
    intro m n
    induction m with
    -- goal: plus ℕ.zero (ℕ.suc n) = ℕ.suc (plus ℕ.zero n)
    | zero =>
        calc
            plus ℕ.zero (ℕ.suc n)
            = .suc n                  := by rfl
          _ = .suc (plus .zero n)     := by rfl -- rewrite using first defining eq of plus
    -- goal: plus (ℕ.suc m) (ℕ.suc n) = ℕ.suc (plus (ℕ.suc m) n)
    -- ih  : plus m (ℕ.suc n) = ℕ.suc (plus m n)
    | suc m ih =>
        calc
            plus (.suc m) (.suc n)
            = .suc (plus m (.suc n))    := by rfl
          _ = ℕ.suc (ℕ.suc (plus m n))  := by
                -- h : ℕ.suc (plus m (ℕ.suc n)) = ℕ.suc (ℕ.suc (plus m n))
                have h := congrArg ℕ.suc ih
                exact h


theorem plusComm : ∀ (m n : ℕ), plus m n = plus n m := by
    intro m n
    induction n with
    -- goal: plus m ℕ.zero = plus ℕ.zero m
    | zero =>
        calc
            plus m .zero
          = m            := by exact (plusIdentityRight m)
        _ = plus .zero m := by rfl
    | suc n ih =>
        -- plus m (ℕ.suc n) = plus (ℕ.suc n) m
        -- ih : plus m n = plus n m
        calc
            plus m (ℕ.suc n)
          = .suc (plus m n) := by exact plusSuc m n
        _ = .suc (plus n m) := by
            -- h : ℕ.suc (plus m n) = ℕ.suc (plus n m)
            have h := congrArg ℕ.suc ih
            exact h
        _ = plus (.suc n) m := by rfl


theorem plusRearrange : ∀ (m n p q : ℕ),
    plus (plus m n) (plus p q) = plus (plus m (plus n p)) q := by
    intro m n p q
    calc
        plus (plus m n) (plus p q)
        = plus (plus (plus m n) p) q := by
          symm
          have h := plusAssoc (plus m n) p q
          exact h
      _ = plus (plus m (plus n p)) q := by
          have h  := plusAssoc m n p
          -- tacks a plus σ q onto the rhs of whatever shape σ is
          have h' := congrArg (λ σ => plus σ q) h
          exact h'

theorem timesAssoc : ∀ (m n p : ℕ)

/-
theorem plusAssoc : ∀ (m n p : ℕ), plus (plus m n) p = plus m (plus n p)

def plus : ℕ -> ℕ -> ℕ
    | .zero , n    => n
    | (.suc m) , n => .suc (plus m n)
-/
