namespace PLFA.Part1.Naturals

inductive ℕ : Type where
    | zero : ℕ
    | suc  : ℕ -> ℕ

-- exercise 1
def seven : ℕ := .suc $ .suc $ .suc $ .suc $ .suc $ .suc $ .suc .zero

def plus : ℕ -> ℕ -> ℕ
| .zero, n => n
| .suc m, n => .suc (plus m n)

end PLFA.Part1.Naturals
