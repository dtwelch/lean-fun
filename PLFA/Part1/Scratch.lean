inductive Bin : Type where
    | empty  : Bin
    | t_zero : Bin -> Bin
    | t_one  : Bin -> Bin
    deriving Repr

syntax:80 (priority := high) "⟨⟩" : term
syntax:81 term:80 "O" : term
syntax:81 term:80 "I" : term
macro_rules
  | `(⟨⟩) => `(Bin.empty)
  | `($a:term O) => `(Bin.t_zero $a)
  | `($a:term I) => `(Bin.t_one $a)
#eval ⟨⟩ I O I I
