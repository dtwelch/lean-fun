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
    _ = 12              := by rfl
    _ = 3 + 9           := by rfl
    _ = 3 + (4 + 5)     := by rfl
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
          _ = .zero + (n + p)           := by rfl
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
            = ℕ.zero            := by rfl
    -- goal: plus (ℕ.suc m) ℕ.zero = ℕ.suc m
    --       ih : plus m ℕ.zero = m
    | suc m ih =>
        calc
            plus (ℕ.suc m) ℕ.zero
            = .suc (plus m .zero) := by rfl
          _ = .suc m              := by exact congrArg ℕ.suc ih
```
The signature states that we are defining the identifier `plusIdentityRight`
which provides evidence for the proposition:
```
∀ (m : ℕ),  m + .zero = m
```
evidence for the proposition is a function that accepts a natural number, binds
it to `m`, and returns evidence for the corresponding instance of the equation.
The proof uses lean4's induction tactic on `m`.
:::

For the base case, we must show:
:::noindent
```
plus .zero .zero = .zero
```
simplifying with the base case of addition, this is straightforward.
:::

For the inductive case, we must show:
:::noindent
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
for congruence arg function `congArg`:
```
congArg: ∀ {α β : Sort} ->
         ∀ {a1 a2 : α} ->
         ∀ (f : α -> β) ->
         ∀ (h : a1 = a2) -> f a1 = f a2 := ...
```
:::

## The second lemma

The inductive case of the definition of addition pushes `.suc` on the first
argument to the outside:
:::noindent
```
plus (.suc m) n = .suc (plus m n)
```
Our second lemma does the same for `.suc` on the second argument:
```
plus m (.suc n) = .suc (plus m n)
```
Here is the lemma's statement and proof:
```lean
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
            = .suc (plus m (.suc n)) := by
                rfl
          _ = ℕ.suc (ℕ.suc (plus m n)) := by
                -- useful trick w/ hover on h for
                -- examining type shape ("what if"?)
                have h := congrArg ℕ.suc ih
                exact h
          _ = ℕ.suc (plus (.suc m) n) := by
                rfl
```
The signature states that we are defining the theorem `plusSuc`, which provides
evidence for the proposition:
```
∀ (m n : ℕ), plus m (.suc n) = .suc (plus m n)
```
Evidence for this proposition is a function that accepts two natural numbers,
binds them to m and n, and returns evidence for the corresponding instance of
the equation.
:::

:::noindent
The proof is by induction on m. For the base case, we must show:
```
plus .zero (.suc n) = .suc (plus .zero n)
```
Simplifying both sides with the base case of addition, this is straightforward:
```
| zero =>
    calc
        plus ℕ.zero (ℕ.suc n)
        = .suc n              := by rfl
      _ = .suc (plus .zero n) := by rfl
```
:::

:::noindent
For the inductive case, we must show:
```
plus (.suc m) (.suc n) = .suc (plus (.suc m) n)
```
Simplifying the left-hand side with the inductive case of addition gives:
```
.suc (plus m (.suc n))
```
Simplifying the desired right-hand side also exposes:
```
.suc (.suc (plus m n))
```
So the proof passes through the middle expression:
```
.suc (.suc (plus m n))
```
The induction hypothesis is:
```
ih : plus m (.suc n) = .suc (plus m n)
```
Prefacing `.suc` to both sides of the induction hypothesis gives:
```
congrArg ℕ.suc ih :
  ℕ.suc (plus m (.suc n)) = ℕ.suc (ℕ.suc (plus m n))
```
This is the central step of the calculation. Reading the chain from the
top down and from the bottom up takes us to the simplified equation in the
middle:

```
| suc m ih =>
    calc
        plus (.suc m) (.suc n)
        = .suc (plus m (.suc n)) := by rfl
      _ = ℕ.suc (ℕ.suc (plus m n)) := by
            exact congrArg ℕ.suc ih
      _ = ℕ.suc (plus (.suc m) n) := by rfl
```
Here, `ih` is the induction hypothesis, and `congrArg ℕ.suc ih` is the Lean
analogue of applying congruence with suc: it places `ℕ.suc` around both sides
of the equality supplied by `ih`.
:::

The first and last steps are justified by `rfl`, because both are definitional
equalities following from the recursive definition of `plus`.

## The proposition
:::noindent
Finally, here is our proposition's statement and proof:
```lean
theorem plusComm : ∀ (m n : ℕ), m + n = n + m := by
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
```

The first line states that we are defining the identifier `plusComm` which
provides evidence for the proposition:
```
∀ (m n : ℕ), plus m n = plus n m
```

Evidence for the proposition is a function that accepts two natural numbers,
binds them to `m` and `n`, and returns evidence for the corresponding instance
of the equation. The proof is by `induction` on `n`. (Not on `m` this time!)
:::
For the base case, we must show:
:::noindent
```
plus m zero = plus zero m
```
Simplifying both sides with the base case of addition yields the equation:

```
plus m .zero = m
```
The remaining equation has the justification `(plusIdentityRight m)`, which
invokes the first lemma.

For the inductive case, we must show:

```
plus m (.suc n) = plus (.suc n) m
```
Simplifying both sides with the inductive case of addition yields the equation:
```
plus m (.suc n) = .suc (plus n m)
```
We show this in two steps. First, we have:
```
plus m (.suc n) = .suc (plus m n)
```
which is justified by the second lemma, `(plusSuc m n)`. Then we have
```
.suc (plus m n) = .suc (plus n m)
```
which is justified by congruence and the induction hypothesis,
`congrArg ℕ.suc ih`. This completes the proof.
Lean4 requires that identifiers are defined before they are used, so we must
present the lemmas before the main proposition, as we have done above.
In practice, one will often attempt to prove the main proposition first, and
the equations required to do so will suggest what lemmas to prove.
:::

## Our first corollary: rearranging

We can apply associativity to rearrange parentheses however we like. Here is an
example:
```
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
```

:::noindent
No induction is required, we simply apply associativity twice.
A few points are worthy of note.

First, addition associates to the left, so m + (n + p) + q stands for (m + (n + p)) + q.
Second, we use sym to interchange the sides of an equation. Proposition +-assoc (m + n) p q shifts parentheses from left to right:
```
plus ((plus m n) p) q = plus (plus m n) (plus p q)
```
To shift them the other way, we use sym (`plusAssoc (plus m n) p q`):
```
(m + n) + (p + q) ≡ ((m + n) + p) + q
```
In general, if `e` provides evidence for `x = y` then `symm` tactic
(which must be invoked on its own line in a `by` block) provides evidence for
`y = x`.

Third, Lean4 allows us to "tack" a term onto the rhs of both sides of an
equality by writing `congrArg (λ σ => plus σ q) h`.. so this:
```
plus (plus m n) p  =  plus m (plus n p)
```
can be rewritten into the equation:
```
plus (plus (plus m n) p) q  =  plus (plus m (plus n p)) q
```
:::

## Creation, one last time

Returning to the proof of associativity, it may be helpful to view the
inductive proof (or, equivalently, the recursive definition) as a creation
story. This time we are concerned with judgments asserting associativity:

:::noindent
```
-- in the beginning, we know nothing about associativity
```
Now, we apply the rules to all the judgments we know about. The base case tells us that (zero + n) + p ≡ zero + (n + p) for every natural n and p. The inductive case tells us that if (m + n) + p ≡ m + (n + p) (on the day before today) then (suc m + n) + p ≡ suc m + (n + p) (today). We didn’t know any judgments about associativity before today, so that rule doesn’t give us any new judgments:

```
-- on the first day, we know about associativity of 0
plus (plus 0 0) 0 = plus 0 (plus 0 0) ... plus (plus 0 4) 5 = plus 0 (plus 4 5)
```
Then we repeat the process, so on the next day we know about all the judgments
from the day before, plus any judgments added by the rules. The base case tells
us nothing new, but now the inductive case adds more judgments:

```
-- on the second day, we know about associativity of 0 and 1
plus (plus 0 0) 0 = plus 0 (plus 0 0) ... plus (plus 0 4) 5 = plus 0 (plus 4 5)
plus (plus 1 0) 0 = plus 1 (plus 0 0) ... plus (plus 1 4) 5 = plus 1 (plus 4 5)   ...
```
And we repeat the process again:
```
-- on the third day, we know about associativity of 0, 1, and 2
plus (plus 0 0) 0 = plus 0 (plus 0 0) ... plus (plus 0 4) 5 = plus 0 (plus 4 5)
plus (plus 1 0) 0 = plus 1 (plus 0 0) ... plus (plus 1 4) 5 = plus 1 (plus 4 5)   ...
plus (plus 2 0) 0 = plus 2 (plus 0 0) ... plus (plus 2 4) 5 = plus 2 (plus 4 5)   ...
```
You've got the hang of it by now:

```
-- On the fourth day, we know about associativity of 0, 1, 2, and 3.
plus (plus 0 0) 0 = plus 0 (plus 0 0) ... plus (plus 0 4) 5 = plus 0 (plus 4 5)
plus (plus 1 0) 0 = plus 1 (plus 0 0) ... plus (plus 1 4) 5 = plus 1 (plus 4 5)   ...
plus (plus 2 0) 0 = plus 2 (plus 0 0) ... plus (plus 2 4) 5 = plus 2 (plus 4 5)   ...
plus (plus 3 0) 0 = plus 3 (plus 0 0) ... plus (plus 3 4) 5 = plus 3 (plus 4 5)   ...
```
The process continues. On the m'th day we will know all the judgments where the
first number is less than m.

There is also a completely finite approach to generating the same equations,
which is left as an exercise for the reader.
:::

## Exercise `plusSwap` (recommended)
:::noindent
Show that
```
plus m (plus n p) = plus n (plus m p)
```
for all naturals `m`, `n`, and `p`. No induction is needed, just apply the
previous results which show addition is associative and commutative.

*potential sol.*

todo
:::
