
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
        | x :: xs   => subs xs ++ List.map (λ xs' => x :: xs') (subs xs)

#eval subs [0, 1] -- [ [] , [1] , [0] , [0, 1] ]
#eval subs $ String.toList "abc" -- [[], ['c'], ['b'], ['b', 'c'], ['a'], ['a', 'c'], ['a', 'b'], ['a', 'b', 'c']]

-- cartesian product:

def cpair
    /-∀-/ {α : Type}
    /-∀-/ {β : Type} :
        List α -> List β -> List (α × β)
            --:= λ xs ys => match (xs, ys) with -- <-- the λ messes
            --                          with the termination proof for some reason
            | [], _             => []
            | _, []             => []
            | x :: xs, y :: ys  => (x, y) :: (cpair xs ys)
        termination_by xs _ => List.length xs

def cartProdList
    /-∀-/ {α : Type} : (List (List α)) -> List (List α)
        | []                => [[]]
        | xs :: xss  =>
            -- List.map (λ ys => List.cons y ys) (cartProdList xss)
            let ys := cartProdList xss
            List.flatMap
                (λ y => List.map (List.cons y) ys) xs

def permscp /-∀-/ {α : Type} [BEq α] : List α -> List (List α) := sorry


#eval cartProdList [ [1, 2], [3, 4] ]

#eval cpair [1, 2, 3] ["a", "b", "c"]

def part1 : String -> Bool := λ input => sorry
