DEMO_PDF = demo/homework.pdf \
		   demo/template.pdf
DEMO_SRC = demo/homework.tex \
		   demo/template.tex

SOURCE_DIR := source
DESTDIR     ?= $(shell kpsewhich -var-value=TEXMFHOME)
INSTALL_DIR = $(DESTDIR)/tex/latex/homework
PACKAGE_STY := $(addprefix $(INSTALL_DIR)/, )
PACKAGE_CLASSES := $(addprefix $(INSTALL_DIR)/, homework.cls)

CACHE_DIR   := $(shell pwd)/.latex-cache
COMPILE_TEX := latexmk -pdf -output-directory=$(CACHE_DIR)

.PHONY: all demo doc install uninstall ctan clean-cache clean

all: demo

clean: clean-cache

clean-cache:
	@rm -rf "$(CACHE_DIR)"

install: $(PACKAGE_CLASSES) $(PACKAGE_STY)

$(INSTALL_DIR)/%.sty: $(SOURCE_DIR)/%.sty | $(INSTALL_DIR)
	@cp $< $@

$(INSTALL_DIR)/%.cls: $(SOURCE_DIR)/%.cls | $(INSTALL_DIR)
	@cp $< $@

$(INSTALL_DIR):
	@mkdir -p $(INSTALL_DIR)

uninstall:
	@rm -f "$(addprefix $(INSTALL_DIR)/, $(PACKAGE_STY))"
	@rm -f "$(addprefix $(INSTALL_DIR)/, $(PACKAGE_CLASSES))"
	@rmdir "$(INSTALL_DIR)"

demo: $(DEMO_PDF)

$(CACHE_DIR):
	@mkdir -p $(CACHE_DIR)

$(DEMO_PDF): $(DEMO_SRC) | clean-cache $(CACHE_DIR)
	@cd $(dir $(DEMO_SRC)) && $(COMPILE_TEX) $(notdir $(DEMO_SRC))
	@cp $(CACHE_DIR)/$(notdir $(DEMO_PDF)) $(DEMO_PDF) 

check: create_build_dir
	find . -name *.tex -exec chktex {} \; | tee "$(CACHE_DIR)/lint.out"

clean:
	rm -rf $(BUILD_DIR)
