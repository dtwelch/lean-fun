import Std.Data.HashSet.Basic

namespace Aoc.Day2

inductive Move where
| up    : Move
| down  : Move
| left  : Move
| right : Move
deriving Repr, DecidableEq, Hashable

def trace : List Move -> Nat := λ moves0 =>
    let translate : (Int × Int) -> Move -> (Int × Int) :=
        λ (x, y) => λ dir =>
            match dir with
            | .left  => (x - 1, y)
            | .right => (x + 1, y)
            | .up    => (x, y - 1)
            | .down  => (x, y + 1)

    let rec loop : List Move -> Int × Int -> Std.HashSet (Int × Int) -> Std.HashSet (Int × Int) :=
        λ moves => λ currCoord => λ seen =>
            match moves with
            | []       => Std.HashSet.emptyWithCapacity
            | m :: mvs =>
                let currSet := Std.HashSet.union seen $ Std.HashSet.ofList [ currCoord ]
                loop mvs (translate currCoord m) currSet

    Std.HashSet.size $ loop moves0 (0, 0) $ Std.HashSet.emptyWithCapacity

def parseMove : Char -> (Except String Move) :=
    λ ch =>
        match ch with
        | '^' => Except.ok .up
        | 'v'  => Except.ok .down
        | '>' => Except.ok .right
        | '<' => Except.ok .left
        | e   => Except.error ("unexpected: " ++ String.singleton e)

def read : String -> List Move :=
    λ input => String.foldr (λ ch => λ acc =>
        match parseMove ch with
         | Except.ok v      => v :: acc
         | Except.error _   => acc
        ) [] input

#eval trace $ read ">"          -- 2
#eval trace $ read "^>v<"       -- 4
#eval trace $ read "^v^v^v^v^v" -- 2

end Aoc.Day2