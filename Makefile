LATEX_BIN ?= /Library/TeX/texbin/lualatex
OUT_DIR ?= _out/book
TEX_CACHE_DIR ?= /tmp/lean-fun-texmf-cache
LEAN_SOURCES := $(shell find PLFA -type f -name '*.lean' | sort)
BOOK_DEPS := Makefile lakefile.lean lake-manifest.json lean-toolchain $(LEAN_SOURCES)

.PHONY: all build tex book pdf clean

all: build

build:
	@lake -q build

$(OUT_DIR)/tex/main.tex: $(BOOK_DEPS)
	@mkdir -p "$(OUT_DIR)"
	@lake -q exe plfaBook --output "$(OUT_DIR)" --with-tex --without-html-single --without-html-multi

tex: $(OUT_DIR)/tex/main.tex

$(OUT_DIR)/tex/main.pdf: $(OUT_DIR)/tex/main.tex
	@PATH="$(dir $(LATEX_BIN)):$$PATH" ; \
	mkdir -p "$(TEX_CACHE_DIR)" ; \
	cd "$(OUT_DIR)/tex" && \
	TEXMFCACHE="$(TEX_CACHE_DIR)" TEXMFVAR="$(TEX_CACHE_DIR)" TEXMFSYSVAR="$(TEX_CACHE_DIR)" \
	"$(LATEX_BIN)" -interaction=batchmode -halt-on-error main.tex >/dev/null 2>&1 && \
	TEXMFCACHE="$(TEX_CACHE_DIR)" TEXMFVAR="$(TEX_CACHE_DIR)" TEXMFSYSVAR="$(TEX_CACHE_DIR)" \
	"$(LATEX_BIN)" -interaction=batchmode -halt-on-error main.tex >/dev/null 2>&1 && \
	TEXMFCACHE="$(TEX_CACHE_DIR)" TEXMFVAR="$(TEX_CACHE_DIR)" TEXMFSYSVAR="$(TEX_CACHE_DIR)" \
	"$(LATEX_BIN)" -interaction=batchmode -halt-on-error main.tex >/dev/null 2>&1 || { \
		printf 'latex failed; see %s/tex/main.log\n' "$(OUT_DIR)" ; \
		exit 1 ; \
	}

book: $(OUT_DIR)/tex/main.pdf
	printf 'pdf: %s/tex/main.pdf\n' "$(OUT_DIR)"

pdf: book

clean:
	@lake clean
	@rm -rf _out
