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
Operations popup all the time, and mathematicians have agreed on names for some
of the most common properties:
:::
* _Identity_. Operator `+` has left identity `0` if `0 + n = n`, and right
identity if `n + 0 = n`, for all `n`. A value that is both a left and right
identity is just called an identity. Identity is also sometimes called _unit_.

* _Associativity_. Operator `+` is associative if the location of the parentheses
does not matter: `(m + n) + p = m + (n + p)`


