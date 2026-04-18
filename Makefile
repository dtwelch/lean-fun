LATEX_BIN ?= /Library/TeX/texbin/lualatex
OUT_DIR ?= _out/book
TEX_CACHE_DIR ?= /tmp/lean-fun-texmf-cache

.PHONY: all build tex book pdf clean

all: build

build:
	lake build

tex:
	lake build PLFA:literate
	lake exe plfaBook --output "$(OUT_DIR)" --with-tex --without-html-single --without-html-multi

book:
	rm -rf "$(OUT_DIR)"
	PATH="$(dir $(LATEX_BIN)):$$PATH" ; \
	lake build PLFA:literate ; \
	lake exe plfaBook --output "$(OUT_DIR)" --with-tex --without-html-single --without-html-multi ; \
	mkdir -p "$(TEX_CACHE_DIR)" ; \
	cd "$(OUT_DIR)/tex" && \
	TEXMFCACHE="$(TEX_CACHE_DIR)" TEXMFVAR="$(TEX_CACHE_DIR)" TEXMFSYSVAR="$(TEX_CACHE_DIR)" \
	"$(LATEX_BIN)" -interaction=nonstopmode -halt-on-error main.tex && \
	TEXMFCACHE="$(TEX_CACHE_DIR)" TEXMFVAR="$(TEX_CACHE_DIR)" TEXMFSYSVAR="$(TEX_CACHE_DIR)" \
	"$(LATEX_BIN)" -interaction=nonstopmode -halt-on-error main.tex && \
	TEXMFCACHE="$(TEX_CACHE_DIR)" TEXMFVAR="$(TEX_CACHE_DIR)" TEXMFSYSVAR="$(TEX_CACHE_DIR)" \
	"$(LATEX_BIN)" -interaction=nonstopmode -halt-on-error main.tex

pdf: book

clean:
	lake clean
	rm -rf _out
