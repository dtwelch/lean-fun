import VersoManual
import PLFA.Book

open Verso.Genre Manual

def main : List String -> IO UInt32 := manualMain (%doc PLFA.Book) (config := { destination := "_out/book" })
