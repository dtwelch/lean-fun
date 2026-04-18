import VersoManual
import PLFA.Book

open Verso.Genre Manual

def main := manualMain (%doc PLFA.Book) (config := { destination := "_out/book" })
