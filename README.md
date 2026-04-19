# lean4-fun

meager stab at working through some Programming Foundations in Agda (only here in Lean)
original text: https://plfa.github.io/
NOTE: in certain cases some of the surrounding text is pulled from the PLFA book verbatim 
(all credit goes to the original PLFA book authors)

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

clean:

```bash
make clean
```

chapter stuff lives under `PLFA/Part1/`; the little book wrapper is `PLFA/Book.lean`.
