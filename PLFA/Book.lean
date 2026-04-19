import VersoManual
import PLFA.Part1

open Verso.Genre Manual

block_extension Block.grayPdfText where
  traverse _ _ _ _ := pure none
  toHtml := some <| fun _ _ _ _ _ => pure .empty
  toTeX := some <| fun _ _ _ _ _ => pure .empty
  preamble := [
r#"
\definecolor{textgray}{HTML}{2C2C2C}
\AtBeginDocument{\color{textgray}}
\renewcommand*{\chaptitlefont}{\sffamily\HUGE\color{textgray}}
\renewcommand*{\chapnumfont}{\chaptitlefont}
\setsecheadstyle{\sffamily\bfseries\Large\color{textgray}}
\setsubsecheadstyle{\sffamily\bfseries\large\color{textgray}}
\setsubsubsecheadstyle{\sffamily\bfseries\color{textgray}}
\makeevenhead{headings}{\color{textgray}\thepage}{}{\slshape\color{textgray}\leftmark}
\makeoddhead{headings}{\slshape\color{textgray}\rightmark}{}{\color{textgray}\thepage}
"#
  ]

#doc (Manual) "PLFA in Lean" =>
%%%
authors := ["Daniel"]
%%%

# Part 1

{include 2 PLFA.Part1.Naturals}
