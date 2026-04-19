import VersoManual

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean

#doc (Manual) "Naturals" =>

This is the first scratch chapter: a unary natural number type and a recursive
definition of addition (the `suc`essor function).

```lean
inductive ℕ : Type where
  | zero : ℕ
  | suc  : ℕ → ℕ
```

```lean
def seven : ℕ :=
  .suc $ .suc $ .suc $ .suc $ .suc $ .suc $ .suc .zero
```

```lean
def plus : ℕ → ℕ → ℕ
| .zero, n => n
| .suc m, n => .suc (plus m n)
```

hello.
