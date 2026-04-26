import VersoManual

open Verso.Genre Manual
open Verso.Doc.Elab

block_extension Block.noindent where
  traverse _ _ _ := pure none
  toHtml :=
    some <| fun _ goB _ _ content => do
      content.mapM goB
  toTeX :=
    some <| fun _ goB _ _ content => do
      pure <| .seq #[.raw "\\par\\noindent ", ← content.mapM goB, .raw "\n"]

/-- Start the contained text flush left in PDF output. -/
@[directive]
def noindent : DirectiveExpanderOf Unit
  | (), stxs => do
    let args ← stxs.mapM elabBlock
    ``(Verso.Doc.Block.other Block.noindent #[ $[ $args ],* ])
