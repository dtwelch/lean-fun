#!/usr/bin/env bash

set -euo pipefail

LATEX_BIN="${LATEX_BIN:-/Library/TeX/texbin/lualatex}"
OUT_DIR="${OUT_DIR:-_out/book}"
TEX_CACHE_DIR="${TEX_CACHE_DIR:-$OUT_DIR/texmf-cache}"

lake build PLFA:literate
lake exe plfaBook --output "$OUT_DIR" --with-tex --without-html-single --without-html-multi

mkdir -p "$TEX_CACHE_DIR"

pushd "$OUT_DIR/tex" >/dev/null
TEXMFCACHE="$TEX_CACHE_DIR" "$LATEX_BIN" -interaction=nonstopmode -halt-on-error main.tex
TEXMFCACHE="$TEX_CACHE_DIR" "$LATEX_BIN" -interaction=nonstopmode -halt-on-error main.tex
TEXMFCACHE="$TEX_CACHE_DIR" "$LATEX_BIN" -interaction=nonstopmode -halt-on-error main.tex
popd >/dev/null

echo "$OUT_DIR/tex/main.pdf"
