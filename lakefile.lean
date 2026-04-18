import Lake
open Lake DSL

package plfa where

require verso from git
  "https://github.com/leanprover/verso.git" @ "v4.29.0"

@[default_target]
lean_lib PLFA

lean_lib PLFA.Book

lean_exe plfaBook where
  root := `PLFA.BookMain
