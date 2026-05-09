import VersoManual
import PLFA.VersoExtensions

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean

#doc (Manual) "Induction: Proof by Induction" =>

:::noindent
Now that we've defined the naturals and operations on them, our next step is to
learn how to prove properties that they satisfy. As hinted by their name,
properties of _inductive datatypes_ are proved by _induction_.
:::

# Properties of operators

:::noindent
Operations pop up all the time, and mathematicians have agreed on names for some
of the most common properties.
:::

* _Identity_. Operator `+` has left identity `0` if `0 + n = n`, and right
identity if `n + 0 = n`, for all `n`. A value that is both a left and right
identity is just called an identity. Identity is also sometimes called _unit_.

* _Associativity_. Operator `+` is associative if the location of the parentheses
does not matter: `(m + n) + p = m + (n + p)`

* _Commutativity_. Operator `+` is commutative if the order of arguments does not
matter: `m + n = n + m`, for all `m` and `n`.

* _Distributivity_. Operator `*` distributes over operator `+` from the left if
`m * (p + q) = (m * p) + (m * q)` for all `m`, `p`, and `q`, and from the right
if `(m + n) * p = (m * p) + (n * p)` for all `m`, `n`, and `p`.

Addition has identity `0` and multiplication has identity `1`; addition and
multiplication are both associative and commutative; and multiplication
distributes over addition.

# Associativity

One property of addition is that it is associative, that is, that the location
of the parentheses does not matter:
```
(m + n) + p ≡ m + (n + p)
```
Here `m`, `n`, and `p` are variables that range over all natural numbers.

We can test the proposition by choosing specific numbers for the three variables:

```
example : (3 + 4) + 5 = 3 + (4 + 5) := by
  calc
    (3 + 4) + 5 = 7 + 5 := by rfl
    _ = 12 := by rfl
    _ = 3 + 9 := by rfl
    _ = 3 + (4 + 5) := by rfl
```

Here we have displayed the computation as a chain of equations, one term to a
line. It is often easiest to read such chains from the top down until one
reaches the simplest term (in this case, `12`), and then from the bottom up
until one reaches the same term.

The test reveals that associativity is perhaps not as obvious as it first
appears. Why should `7 + 5` be the same as `3 + 9`? We might want to gather
more evidence by testing the proposition with other numbers. But since there
are infinitely many naturals, testing can never be complete. Is there any way
we can be sure that associativity holds for all the natural numbers?

The answer is yes! We can prove a property holds for all naturals using proof by induction.

# Proof by induction

Recall that the definition of natural numbers consists of a base case which
tells us that `zero` is a natural, and an inductive case which tells us that if
`m` is a natural then `suc m` is also a natural.

Proof by induction follows the structure of this definition. To prove a property
of natural numbers by induction, we need to prove two cases. First is the base
case, where we show the property holds for `zero`. Second is the inductive case,
where we assume the property holds for an arbitrary natural `m` (we call this
the inductive hypothesis), and then show that the property must also hold for
`suc m`.

If we write `P m` for a property of `m`, then what we need to demonstrate are
the following two inference rules:

```
------
P zero

P m
---------
P (suc m)
```

Let’s unpack these rules. The first rule is the base case, and requires us to
show that property `P` holds for `zero`. The second rule is the inductive case,
and requires us to show that if we assume the inductive hypothesis, namely that
`P` holds for `m`, then it follows that `P` also holds for `suc m`.

Why does this work? Again, it can be explained by a creation story. To start
with, we know no properties:

```
-- in the beginning, no properties are known
```

Now, we apply the two rules to all the properties we know about. The base case
tells us that `P zero` holds, so we add it to the set of known properties. The
inductive case tells us that if `P m` holds on the day before today, then
`P (suc m)` also holds today. We didn’t know about any properties before today,
so the inductive case doesn’t apply:

```
-- on the first day, one property is known
P zero
```

Then we repeat the process, so on the next day we know about all the properties
from the day before, plus any properties added by the rules. The base case
tells us that `P zero` holds, but we already knew that. Now the inductive case
tells us that since `P zero` held yesterday, then `P (suc zero)` holds today:

```
-- on the second day, two properties are known
P zero
P (suc zero)
```

And we repeat the process again. Now the inductive case tells us that since
`P zero` and `P (suc zero)` both hold, then `P (suc zero)` and
`P (suc (suc zero))` also hold. We already knew about the first of these, but
the second is new:

```
-- on the third day, three properties are known
P zero
P (suc zero)
P (suc (suc zero))
```

You’ve got the hang of it by now:

```
-- on the fourth day, four properties are known
P zero
P (suc zero)
P (suc (suc zero))
P (suc (suc (suc zero)))
```

The process continues. On the `n`-th day there will be `n` distinct properties
that hold. The property of every natural number will appear on some given day.
In particular, the property `P n` first appears on day `n + 1`.

# Our first proof: associativity

To prove associativity, we take `P m` to be the property:

`(m + n) + p ≡ m + (n + p)`

Here `n` and `p` are arbitrary natural numbers, so if we can show the equation
holds for all `m` it will also hold for all `n` and `p`. The appropriate
instances of the inference rules are:

```
-------------------------------
(zero + n) + p = zero + (n + p)

(m + n) + p = m + (n + p)
---------------------------------
(suc m + n) + p = suc m + (n + p)
```

If we can demonstrate both of these, then associativity of addition follows by
induction.

Here is the proposition's statement:

```lean4
theorem plus-assoc : ∀ (m n p : ℕ), (m + n) + p = m + (n + p)
```
