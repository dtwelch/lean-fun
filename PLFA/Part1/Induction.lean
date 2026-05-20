import VersoManual
import PLFA.VersoExtensions
import PLFA.Part1.Naturals

open Verso.Genre Manual
open Verso.Genre.Manual.InlineLean

#doc (Manual) "Induction: Proof by Induction" =>

Now that we've defined the naturals and operations on them, our next step is to
learn how to prove properties that they satisfy. As hinted by their name,
properties of _inductive datatypes_ are proved by _induction_.

# Properties of operators

Operations pop up all the time, and mathematicians have agreed on names for some
of the most common properties.
:::noindent
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

:::
# Associativity

One property of addition is that it is associative, that is, that the location
of the parentheses does not matter:
:::noindent
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
:::
:::noindent
The answer is yes! We can prove a property holds for all naturals using proof by induction.

:::
# Proof by induction

Recall that the definition of natural numbers consists of a base case which
tells us that `zero` is a natural, and an inductive case which tells us that if
`m` is a natural then `suc m` is also a natural.

:::noindent
Proof by induction follows the structure of this definition. To prove a property
of natural numbers by induction, we need to prove two cases. First is the base
case, where we show the property holds for `zero`. Second is the inductive case,
where we assume the property holds for an arbitrary natural `m` (we call this
the inductive hypothesis), and then show that the property must also hold for
`suc m`.
:::
If we write `P m` for a property of `m`, then what we need to demonstrate are
the following two inference rules:
:::noindent
```
------
P .zero

P m
---------
P (.suc m)
```
:::
Let's unpack these rules. The first rule is the base case, and requires us to
show that property `P` holds for `zero`. The second rule is the inductive case,
and requires us to show that if we assume the inductive hypothesis, namely that
`P` holds for `m`, then it follows that `P` also holds for `suc m`.

Why does this work? Again, it can be explained by a creation story. To start
with, we know no properties:
:::noindent
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
P .zero
```

Then we repeat the process, so on the next day we know about all the properties
from the day before, plus any properties added by the rules. The base case
tells us that `P zero` holds, but we already knew that. Now the inductive case
tells us that since `P zero` held yesterday, then `P (suc zero)` holds today:

```
-- on the second day, two properties are known
P .zero
P (.suc .zero)
```

And we repeat the process again. Now the inductive case tells us that since
`P zero` and `P (suc zero)` both hold, then `P (suc zero)` and
`P (suc (suc zero))` also hold. We already knew about the first of these, but
the second is new:

```
-- on the third day, three properties are known
P .zero
P (.suc .zero)
P (.suc (.suc .zero))
```

You've got the hang of it by now:

```
-- on the fourth day, four properties are known
P  .zero
P (.suc .zero)
P (.suc (.suc .zero))
P (.suc (.suc (.suc .zero)))
```

The process continues. On the `n`-th day there will be `n` distinct properties
that hold. The property of every natural number will appear on some given day.
In particular, the property `P n` first appears on day `n + 1`.
:::
# Our first proof: associativity

:::noindent
To prove associativity, we take `P m` to be the property:
```
plus (plus m n) p = plus m (plus n p)`
```
Here `n` and `p` are arbitrary natural numbers, so if we can show the equation
holds for all `m` it will also hold for all `n` and `p`. The appropriate
instances of the inference rules are:

```
-------------------------------
plus (plus .zero n) p = plus .zero (plus n p)

plus (plus m n) p = plus m (plus n p)
---------------------------------
(.suc (plus (plus m n) p) = .suc (plus m (plus n p))
```

If we can demonstrate both of these, then associativity of addition follows by
induction.

Here is the proposition's statement and proof:

```lean
theorem plus_assoc :
  ∀ (m n p : ℕ), (m + n) + p = m + (n + p) := by
    intro m n p
    induction m with
    --goal: ∀ m n p : ℕ,
    --      ⊢ plus (plus m n) p = plus m (plus n p)
    | zero =>
        calc
            (.zero + n) + p = (n + p)   := by rfl
            _ = .zero + (n + p)         := by rfl
    | suc m ih =>
        -- ih : plus (plus m n) p = plus m (plus n p)
        -- ind. case goal:
        --  ⊢ plus (plus m.suc n) p = plus m.suc (plus n p)
        calc
            plus (plus (.suc m) n) p
              = plus (.suc (plus m n)) p := by rfl
            _ = .suc (plus m (plus n p)) := by
              exact congrArg ℕ.suc (ih)
            _ = .suc (plus m (plus n p)) := by rfl
            _ = plus (.suc m) (plus n p) := by rfl
```
Let's unpack this code. The signature states that we are defining a theorem,
`plus_assoc`, which states a proposition:
```
∀ (m n p : ℕ) -> (m + n) + p = m + (n + p)
```
The upside down A is pronounced "for all", and the proposition asserts that for
all natural numbers `m`, `n`, and `p` the equation `(m + n) + p = m + (n + p)`
holds. Evidence for the proposition is a function that accepts three natural
numbers, binds them to `m`, `n`, and `p`, and returns evidence for the
corresponding instance of the equation.

For the base case, we must show:
```
plus (plus .zero n) p = plus .zero (plus n p)
```
Simplifying both sides with the base case of addition yields the equation:
```
plus n p = plus n p
```
This holds trivially. Reading the chain of equations in the base case of the
proof, the top and bottom of the chain match the two sides of the equation to
be shown, and reading down from the top and up from the bottom takes us to
`n + p` in the middle. No justification other than simplification is required.
:::

# More on rewriting

*NOTE:* The last step may look a little backwards at first. Right before the end
of the inductive case (after rewriting using the inductive hypothesis `ih`)
we are left with the term:
:::noindent
```
.suc (plus m (plus n p))
```
but the right-hand side of the theorem wants to look like:
```
plus (.suc m) (plus n p)
```
The important point is that the defining equation for `plus` goes the other
way when it computes:
```
plus (.suc m) k  -->  .suc (plus m k)
```
Here is the definition of `plus` recalled:
```
def plus : ℕ -> ℕ -> ℕ
    | .zero , n    => n
    | (.suc m) , n => .suc (plus m n)
```
So the term that directly matches the second clause of plus is not
`.suc (plus m (plus n p))`. The term that directly matches is:
```
plus (.suc m) (plus n p)
```
and computing it gives:
```
.suc (plus m (plus n p))
```
So in the written proof, when we move from:
```
.suc (plus m (plus n p))
```
to:
```
plus (.suc m) (plus n p)
```
we are visually moving from the computed/unfolded form back to the folded-up
form. From a human reader point of view, it is fine to think of this as
"folding the definition of plus back up". But `rfl` is not really doing a
directional rewrite here. It is checking that both sides compute to the same
expression:
```
plus (.suc m) (plus n p)
-- computes to
.suc (plus m (plus n p))
```
In other words, both sides have the same normal form, so Lean accepts the step
by `rfl`. This is the same kind of silent definitional-equality step that Agda
writes explicitly as `≡⟨⟩`.
:::

# Second proof: commutativity

Another import property of addition is that it is _commutative_, that is, that
the the order of the operands does not matter:
`plus m n = plus n m`
:::noindent
The proof requires that we first demonstrate two lemmas.
:::

## The first lemma

The base case of the definition of addition states that zero is a left identity.

:::noindent
```
plus .zero n = n
```
Our first lemma states that zero is also a right identity:
```
plus m .zero = m
```
Here is the lemma's statement and proof:
```lean
theorem plusIdentityRight : ∀ (m : ℕ),  m + .zero = m := by
    intro m
    induction m with
    -- goal: plus ℕ.zero ℕ.zero = ℕ.zero
    | zero =>
        calc
                plus ℕ.zero ℕ.zero
            =   ℕ.zero := by rfl
    -- goal: plus (ℕ.suc m) ℕ.zero = ℕ.suc m
    --       ih : plus m ℕ.zero = m
    | suc m ih =>
        calc
            plus (ℕ.suc m) ℕ.zero
          = .suc (plus m .zero) := by rfl
        _ = .suc m             := by exact congrArg ℕ.suc ih
```
The signature states that we are defining the identifier `plusIdentityRight`
which provides evidence for the proposition:
```
∀ (m : ℕ),  m + .zero = m
```
evidence for the proposition is a function that accepts a natural number, binds
it to `m`, and returns evidence for the corresponding instance of the equation.
The proof uses lean4's induction tactic on `m`.

For the base case, we must show:
```
plus .zero .zero = .zero
```
simplifying with the base case of addition, this is straightforward.

For the inductive case, we must show:
```
plus (.suc m) .zero = .suc m
```
Simplifying both sides with the inductive case of addition yields the equation:
```
.suc (.plus m zero) = .suc m
```
This in turn follows by prefacing `.suc` to both sides of the induction hypothesis:
```
plus m .zero = m
```
Reading the chain of equations down from the top and up from the bottom takes us to
the simplified equation above. The remaining equation has the justification:
```
exact congrArg ℕ.suc ih
```
where `exact` is a tactic that automatically closes the goal in the event that the
shape of the equation that results from `congrArg N.suc ih` is automatically dischargeable...
`congArg N.suc ih` has the effect of tacking the successor (`.suc`) on both the
left hand side and right hand side of the inductive hypothesis arg... here is the sig
for `congArg`:
```
∀ {α β : Sort} ->
∀ {a1 a2 : α} ->
∀ (f : α -> β) ->
∀ (h : a1 = a2) -> f a1 = f a2
```
:::
