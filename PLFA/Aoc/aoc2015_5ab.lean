
def nub /-∀-/ {α : Type} [BEq α] : List α -> List α := λ input =>
    match input with
    | []        => []
    | x :: xs   => x :: nub (List.filter (λ y => x != y) xs)
    termination_by input => input.length
    decreasing_by
        simp
        exact Nat.lt_succ_of_le (List.length_filter_le (fun y => x != y) xs)

def distinct /-∀-/ {α : Type} [BEq α] : List α -> Bool :=
    λ input => input == nub input

#eval distinct $ String.toList "avocado"
#eval distinct $ String.toList "peach"

def subs /-∀-/ {α : Type} : List α -> List (List α) :=
    λ input => match input with
        | []        => [[]] --or: List.map (List.cons x)    (subs xs) -- (cons partially applied)
        | x :: xs   => subs xs ++ List.map (λ _ => x :: xs) (subs xs)

def part1 : String -> Bool := λ input => sorry



