# lean-fun

meager stab at working through some Programming Foundations in Agda (only here in Lean)

## Layout

- `PLFA.lean` is the library root.
- `PLFA/Part1.lean` is the entry point for the first part of the book.
- `PLFA/Part1/Naturals.lean` is the first scratch module.
- `PLFA/Book.lean` is the tiny Verso wrapper for rendering a printable chapter view.

## Work

```bash
make
lake env lean PLFA/Part1/Naturals.lean
```

Add more chapter files under `PLFA/Part1/` and import them from `PLFA/Part1.lean` as you go.

## Book / PDF

Rebuild the little book wrapper and the PDF with:

```bash
make book
```

That writes the PDF to:

```text
_out/book/tex/main.pdf
```

## Clean

Clean Lake build outputs:

```bash
make clean
```
