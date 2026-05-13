import Std.Data.HashSet.Basic

namespace Aoc.Day2

inductive Move where
| up    : Move
| down  : Move
| left  : Move
| right : Move
deriving Repr, DecidableEq, Hashable

def trace : List Move -> Nat := λ moves0 =>
    let move : (Int × Int) -> Move -> (Int × Int) :=
        λ (x, y) => λ dir =>
            match dir with
            | .left  => (x - 1, y)
            | .right => (x + 1, y)
            | .up    => (x, y - 1)
            | .down  => (x, y + 1)

    let rec loop : List Move -> Int × Int -> Std.HashSet (Int × Int) :=
        λ moves => λ currCoord =>
            match moves with
            | []         => Std.HashSet.emptyWithCapacity
            | m :: moves => Std.HashSet.union (Std.HashSet.ofList [ currCoord ]) $ loop moves (move currCoord m)
    Std.HashSet.size $ loop moves0 (0, 0)

def parseMove : Char -> (Except String Move) :=
    λ ch =>
        match ch with
        | '^' => Except.ok .up
        | 'v' => Except.ok .down
        | '>' => Except.ok .right
        | '<' => Except.ok .left
        | e   => Except.error ("unexpected: " ++ String.singleton e)

def read : String -> List Move :=
    λ input => String.foldr (λ ch => λ acc =>
        match parseMove ch with
         | Except.ok v      => v :: acc
         | Except.error _   => acc
        ) [] input

end Aoc.Day2