import Std.Data.HashSet.Basic

namespace Aoc.Day2

inductive Move where
| up    : Move
| down  : Move
| left  : Move
| right : Move
deriving Repr, DecidableEq, Hashable

-- adjusted to just return the raw set (for reuse in part 2 ... we'll see..)
def trace : List Move -> Std.HashSet (Int × Int) := λ moves0 =>
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
            | []       => Std.HashSet.insert seen currCoord
            | m :: mvs =>
                loop mvs (translate currCoord m) $ Std.HashSet.insert seen currCoord

    loop moves0 (0, 0) $ Std.HashSet.ofList [ (0, 0) ]

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

def part1 : String -> Nat := λ input => Std.HashSet.size $ trace (read input)

#eval part1 ">"          -- 2
#eval part1 "^>v<"       -- 4
#eval part1 "^v^v^v^v^v" -- 2

-- part 2:

-- (s₁ , s₂) moves for both santas... then just run the usual trace function
--- and union the resulting sets
def split : List Move -> (List Move × List Move) :=
    λ moves =>
        match moves with
            | mᵢ :: mⱼ :: []  => ([mᵢ], [mⱼ])
            | mᵢ :: mⱼ :: mvs => (mᵢ :: (Prod.fst $ split mvs), mⱼ :: (Prod.snd $ split mvs))
            | _               => ([], [])

def part2 : String -> Nat := λ input =>
    Std.HashSet.size $
        match (split $ (read input)) with
            | (mvs₁, mvs₂) => Std.HashSet.union $ trace mvs₁ $ trace mvs₂


end Aoc.Day2