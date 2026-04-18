# lean-fun

Small Lean 4 workspace for translating bits of Part 1 of _Programming Language Foundations in Agda_.

## Layout

- `PLFA.lean` is the library root.
- `PLFA/Part1.lean` is the entry point for the first part of the book.
- `PLFA/Part1/Naturals.lean` is the first scratch module.

## Usage

```bash
lake build
lake env lean PLFA/Part1/Naturals.lean
```

Add more chapter files under `PLFA/Part1/` and import them from `PLFA/Part1.lean` as you go.
