# lean4-fun

meager stab at working through some Programming Foundations in Agda (only here in Lean)
original text: https://plfa.github.io/

> This repo's Lean 4-checked PDF rendering of the above book and some exercises is here:
> [lean-fun/_out/tex/main.pdf](lean-fun/_out/tex/main.pdf)

NOTE: most of the chapter text proper is pulled verbatim from the PLFA book 
(all credit goes to the original PLFA book authors); 

main bits:

```bash
make
lake env lean PLFA/Part1/Naturals.lean
```

book/pdf:

```bash
make book
```

pdf ends up at:

```text
_out/book/tex/main.pdf
```

no separate Verso install is needed; Lake fetches it as a dependency. `make book` does require a working LaTeX install.

if `make book` succeeds but the PDF looks unchanged, it is probably viewer caching.

macOS: close and reopen `_out/book/tex/main.pdf` in Preview. If needed, quit Preview first.

Windows: reload or reopen the PDF in Edge, Chrome, or Adobe Reader. If needed, close the viewer before rebuilding.

clean:

```bash
make clean
```

chapter stuff lives under `PLFA/Part1/`; the little book wrapper is `PLFA/Book.lean`.
