-- countEvens

def countEvens : List Int -> Int :=
    λ nums => List.foldl (λ acc x => if x % 2 == 0 then 1 + acc else acc) 0 nums

#eval countEvens [2, 1, 2, 3, 4]
#eval countEvens [2, 2, 0]
#eval countEvens [1, 3, 5]

-- problem 2 (issue with HSub typeclass on min, max apps)
/- def bigDiff : List Int -> Option Int :=
 -     λ nums => match nums with
 -       | []      => Option.none
 -       | x :: xs => Option.some (List.max (x :: xs) - List.min (x :: xs)) -/

-- problem 3
def sum13 : List Int -> Int :=
    λ nums => List.foldl (λ acc x => if x == 13 then 1 + acc else acc) 0 nums

-- problem 4
-- (todo)

-- problem 5
def afterNext7 : List Int -> List Int :=
    λ nums => match nums with
                | [] => []
                | 7 :: xs => xs
                | _ :: xs => afterNext7 xs

theorem skippingShortens :
    ∀ (xs : List Int), List.length (afterNext7 xs) ≤ List.length xs := by
        intro xs
        induction xs with
        | nil =>
            -- goal: List.length (afterNext7 []) ≤ List.length []
            calc
            List.length (afterNext7 [])
            = List.length []   := by rfl
            _ = 0              := by rfl
            _ ≤ List.length [] := by simp
        | cons x xs ih =>
            -- goal: List.length (afterNext7 (ih :: tail')) ≤ List.length (ih :: tail')
            -- ih: List.length (afterNext7 xs) ≤ List.length xs
            sorry

def sum67 : List Int -> Int := λ nums0 =>
    match nums0 with
        | []        => 0
        | 6 :: xs   => sum67 (afterNext7 xs)
        | x :: xs   => x + sum67 xs
    termination_by nums0 => List.length nums0
    decreasing_by
        trace_state
        apply Nat.lt_succ_of_le
        exact (skippingShortens _)
        sorry
