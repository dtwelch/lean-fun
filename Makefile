LATEX_BIN ?= /Library/TeX/texbin/lualatex
OUT_DIR ?= _out/book
TEX_CACHE_DIR ?= /tmp/lean-fun-texmf-cache

.PHONY: all build tex book pdf clean

all: build

build:
	@lake -q build

tex: build
	@lake -q exe plfaBook --output "$(OUT_DIR)" --with-tex --without-html-single --without-html-multi

book: build
	@rm -rf "$(OUT_DIR)"
	@PATH="$(dir $(LATEX_BIN)):$$PATH" ; \
	lake -q exe plfaBook --output "$(OUT_DIR)" --with-tex --without-html-single --without-html-multi ; \
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
	printf 'pdf: %s/tex/main.pdf\n' "$(OUT_DIR)"

pdf: book

clean:
	@lake clean
	@rm -rf _out
