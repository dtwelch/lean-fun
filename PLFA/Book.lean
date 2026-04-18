import Verso.Doc.ArgParse
import Verso.Doc.Elab.Monad
import VersoManual
import VersoManual.Markdown

open Lean
open Verso ArgParse
open Verso Doc Elab
open Verso.Genre Manual
open Verso.Genre.Manual.Markdown

structure SourceFileConfig where
  path : String

section
variable {m} [Monad m] [Lean.MonadError m]

def SourceFileConfig.parse : ArgParse m SourceFileConfig :=
  SourceFileConfig.mk <$> .positional `path .string

instance : FromArgs SourceFileConfig m := ⟨SourceFileConfig.parse⟩

end

private def dropLeadingBlankLines : List String → List String
  | [] => []
  | line :: rest =>
      if line.trimAscii.isEmpty then
        dropLeadingBlankLines rest
      else
        line :: rest

private def stripLeadingTitleLine (doc : String) : String :=
  match dropLeadingBlankLines (doc.splitOn "\n") with
  | line :: rest =>
      if line.startsWith "# " then
        String.intercalate "\n" (dropLeadingBlankLines rest)
      else
        String.intercalate "\n" (line :: rest)
  | [] => ""

private def gatherModuleDoc (acc : List String) : List String → Option (String × String)
  | [] => none
  | line :: rest =>
      if line.trimAscii.toString == "-/" then
        let doc := String.intercalate "\n" acc.reverse
        let code := String.intercalate "\n" (dropLeadingBlankLines rest)
        some (doc, code)
      else
        gatherModuleDoc (line :: acc) rest

private def splitChapterSource (contents : String) : String × String := Id.run do
  let mut lines := dropLeadingBlankLines (contents.splitOn "\n")
  if lines.head? == some "set_option doc.verso true" then
    lines := dropLeadingBlankLines lines.tail!
  match lines with
  | first :: rest =>
      if first.startsWith "/-!" then
        let opening := first.drop 3
        let acc :=
          if opening.trimAscii.isEmpty then
            []
          else
            [opening.trimAscii.copy]
        match gatherModuleDoc acc rest with
        | some parts => parts
        | none => ("", String.intercalate "\n" lines)
      else
        ("", String.intercalate "\n" lines)
  | [] => ("", "")

@[block_command]
public meta def sourceFile : BlockCommandOf SourceFileConfig
  | ⟨path⟩ => do
      let contents ← IO.FS.readFile path
      let (doc, code) := splitChapterSource contents
      let proseBlocks ←
        if doc.trimAscii.isEmpty then
          pure #[]
        else
          let renderedDoc := stripLeadingTitleLine doc
          if renderedDoc.trimAscii.isEmpty then
            pure #[]
          else
            let some ast := MD4Lean.parse renderedDoc
              | throwError "Failed to parse module doc from {path}"
            ast.blocks.mapM fun block =>
              Verso.Genre.Manual.Markdown.blockFromMarkdown block
                (handleHeaders := Verso.Genre.Manual.Markdown.strongEmphHeaders)
      let mut blocks := proseBlocks
      if !code.trimAscii.isEmpty then
        let codeBlock ← ``(Verso.Doc.Block.code $(quote code))
        blocks := blocks.push codeBlock
      ``(Verso.Doc.Block.concat #[$blocks,*])

#doc (Manual) "PLFA in Lean" =>
%%%
authors := ["Daniel"]
%%%

# Part 1

## Naturals

{sourceFile "PLFA/Part1/Naturals.lean"}
