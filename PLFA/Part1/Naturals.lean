import VersoManual

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean

#doc (Manual) "Naturals" =>

Most are familiar with the natural numbers:
```
0
1
2
3
...
```
and so on. The set of natural numbers `ℕ` is inifite and we say that `0`, `1`, `2`, `3`,
and are *values* of type `ℕ` (otherwise indicated with: `0 : ℕ`,  `1 : ℕ`,  etc.).

Although there are infinitely many naturals, yet we can write down its
definition in just a few lines. Here it is as a pair of inference rules:
```
--------
zero : ℕ

m : ℕ
--------
suc m : ℕ
```
And here is the definition in Lean:

```lean
inductive ℕ : Type where
| zero : ℕ
| suc  : ℕ -> ℕ
```
Here `ℕ` is the name of the datatype we are defining, and `zero` and `suc`
(short for successor) are the *constructors* of the datatype.

Both definitions above tell us two things:

1. base case: `zero` is a natural number
2. inductive case: if `m` is a natural number, then `suc m` is also a natural
number.

Further, these two rules give the *only* ways of creating natural numbers.
Hence, the possible natural numbers are:
```
.zero
.suc .zero
.suc (.suc .zero)
...
```
We write `0` as the shorthand for the `zero` constructor and `1` as shorthand
for `suc zero`, the successor of zero, that is the number that comes after `0`.

# Exercise: `seven` (practice)

Write out `7` in longhand.

*potential sol:*
```lean
def seven : ℕ :=
  .suc $ .suc $ .suc $ .suc $ .suc $ .suc $ .suc .zero
```
# Unpacking the inference rules

Let's unpack the Lean definition. the keyword `inductive` tells us this is an
inductive definition, that is, we are defining a new datatype with constructors.
The phrase:
```
ℕ : Type
```
tells us that ℕ is the name of the new data, type and that it is a `Type`, which
is the way in Lean of saying that it is a type

hello.
