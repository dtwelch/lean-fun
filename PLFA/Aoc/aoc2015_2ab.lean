-- day 2 part1 (apparently I did part 1 of this problem
-- at one point in java)

structure Box where
    mk :: -- ctor name for record Box
    -- fields 1-3:
    l : Nat
    w : Nat
    h : Nat

#eval Std.Iter.toList (String.split "20x3x11\n15x27x5" "\n")

def splitOn : String -> String -> List String :=
    λ s => λ sep =>
        List.map String.Slice.toString $ Std.Iter.toList (String.split s sep)

def read : String -> List Box :=
    λ input => List.map
        (λ ln => match List.map String.toNat! (splitOn ln "x") with
                        | l :: w :: h :: [] => Box.mk l w h
                        | _ => Box.mk 0 0 0
        ) $ splitOn input "\n"

-- produces a pair: (smallestSideArea, totalSurfaceArea)
def wrap : Box -> Nat × Nat :=
    λ b => match (b.l, b.w, b.h) with
        | (l, w, h) => (min (min (l * w) (w * h)) (h * l),
                        (2 * l * w) + (2 * w * h) + (2 * h * l)
                       )

def part1 : List Box -> Nat :=
    λ boxes =>
        List.foldl (λ acc (smlSide, area) => acc + (smlSide + area)) 0 (List.map wrap boxes)

#eval part1 $ read "2x3x4"  -- 58
#eval part1 $ read "1x1x10" -- 43

#eval do
    let input <- IO.FS.readFile "PLFA/Aoc/day2.txt"
    IO.println (part1 (read input)) -- 1606483 (10k lines... so, do block it is)
