namespace Aoc.Day1

-- day 1a
inductive Paren where
| lparen : Paren
| rparen : Paren
deriving Repr, DecidableEq

def floor : List Paren -> Int := λ parens0 =>
    let rec loop : List Paren -> Int -> Int :=
        λ parens => λ floor =>
            match parens with
            | []            => floor
            | .rparen :: ps => loop ps (floor - 1)
            | .lparen :: ps => loop ps (floor + 1)
    loop parens0 0

-- day 1b:
abbrev Pos : Type := Int

def floor' : List Paren -> Int := λ parens0 =>
    let rec loop : List Paren -> Int -> Pos -> Int :=
        λ parens => λ floor => λ pos =>
            match parens with
            | []            => pos
            | .rparen :: ps =>
                if floor < 0 then pos else loop ps (floor - 1) pos + 1
            | .lparen :: ps =>
                if floor < 0 then pos else loop ps (floor + 1) pos + 1
    loop parens0 0 0

#check Paren

def readParen : Char -> (Except String Paren) :=
    λ ch =>
        match ch with
        | '(' => Except.ok .lparen
        | ')' => Except.ok .rparen
        | e   => Except.error ("unexpected: " ++ String.singleton e)

def read : String -> List Paren :=
    λ input => String.foldr (λ ch => λ acc =>
        match readParen ch with
         | Except.ok v      => v :: acc
         | Except.error _   => acc
        ) [] input

---------------------- tests:
-- day 1a:
-- #eval floor $ read "))((((("

-- day 1b:
-- #eval floor' $ read ")"
-- eval floor' $ read "()())"
end Aoc.Day1
