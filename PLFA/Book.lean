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
\definecolor{codecomment}{rgb}{0.497495, 0.497587, 0.497464}
\usepackage[a4paper,margin=1in]{geometry}
\usepackage{parskip}
\usepackage{amsfonts}
\AtBeginDocument{\color{textgray}}
\renewcommand*{\chaptitlefont}{\sffamily\HUGE\color{textgray}}
\renewcommand*{\chapnumfont}{\chaptitlefont}
\setsecheadstyle{\sffamily\bfseries\Large\color{textgray}}
\setsubsecheadstyle{\sffamily\bfseries\large\color{textgray}}
\setsubsubsecheadstyle{\sffamily\bfseries\color{textgray}}
\setmonofont{CMU Typewriter Text}
\newfontfamily{\PLFASymbolFont}{DejaVu Sans Mono}[Scale=0.6]
\newcommand{\PLFANat}{\ensuremath{\mathbb{N}}}
\newcommand{\PLFAForall}{\ensuremath{\forall}}
\newcommand{\PLFATo}{\ensuremath{\to}}
\newcommand{\PLFAEquiv}{\ensuremath{\equiv}}
\newcommand{\PLFATurnstile}{\ensuremath{\vdash}}
\newcommand{\PLFASymbol}[1]{{\PLFASymbolFont #1}}

% Keep the PDF viewer layout book-like, but stop memoir from alternating
% recto/verso headers and blank-page behavior.
\makeatletter
\@twosidefalse
\@mparswitchfalse
\makeatother
\let\cleardoublepage\clearpage
\makeevenhead{headings}{\slshape\color{textgray}\rightmark}{}{\color{textgray}\thepage}
\makeoddhead{headings}{\slshape\color{textgray}\rightmark}{}{\color{textgray}\thepage}

% Verso emits fenced blocks as verbatim/LeanVerbatim. Tighten the display
% spacing so code blocks do not leave a large hole before the next paragraph.
\newcommand{\PLFACodeSize}{\normalsize}
\newcommand{\PLFAFirstOfOne}[1]{#1}
\newcommand{\PLFAComment}[1]{\textcolor{codecomment}{#1}}
\RecustomVerbatimEnvironment{verbatim}{Verbatim}
  {commandchars=\\\{\},formatcom=\ttfamily,fontsize=\PLFACodeSize,breaklines=true,baselinestretch=0.92,
   listparameters={\setlength{\topsep}{0.25\baselineskip}\setlength{\partopsep}{0pt}\setlength{\parsep}{0pt}}}
\RecustomVerbatimEnvironment{LeanVerbatim}{Verbatim}
  {commandchars=\\\{\},formatcom=\ttfamily\let\textit\PLFAFirstOfOne,fontsize=\PLFACodeSize,breaklines=true,baselinestretch=0.92,
   listparameters={\setlength{\topsep}{0.25\baselineskip}\setlength{\partopsep}{0pt}\setlength{\parsep}{0pt}}}
"#
  ]

#doc (Manual) "PLFA in Lean" =>
%%%
authors := ["Daniel"]
%%%
:::pagebreak
:::
# Part 1

This part collects the early material on natural numbers and induction.

{include 2 PLFA.Part1.Naturals}
{include 2 PLFA.Part1.Induction}
