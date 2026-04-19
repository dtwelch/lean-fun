import VersoManual

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean

#doc (Manual) "Naturals" =>

This is the first scratch chapter: a unary natural number type and a recursive
definition of addition (the `suc`essor function).

```lean
inductive ℕ : Type where
  | zero : ℕ
  | suc  : ℕ -> ℕ
```
The set of natural numbers `ℕ` is inifite and we say that `0`, `1`, `2`, `3`,
and are values of type `ℕ` (otherwise written: `0 : ℕ`, `1 : ℕ`, etc.).

Although there are infinitely many naturals, yet we can write down its
definition in just a few lines. Here it is as a pair of inference rules:
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
