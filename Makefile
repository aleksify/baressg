# **************************************************************************** #
#                                   BARESSG                                    #
# **************************************************************************** #

# -------------------------------- Directories ------------------------------- #

SRC_DIR			:= src
OUT_DIR			:= out

# --------------------------------- Config ----------------------------------- #

CSS				:= https://cdn.simplecss.org/simple.min.css
LOWDOWN			:= lowdown
LOWDOWNFLAGS	:= -s -Thtml -M css=$(CSS)

# --------------------------------- Sources ---------------------------------- #

SRCS			:= $(shell find $(SRC_DIR) -name '*.md' 2>/dev/null)
TARGETS			:= $(patsubst $(SRC_DIR)/%.md, $(OUT_DIR)/%/index.html, \
				   $(filter-out $(SRC_DIR)/index.md, $(SRCS)))
EXISTING		:= $(shell find $(OUT_DIR) -name '*.html' 2>/dev/null)
STALE			:= $(filter-out $(TARGETS) $(OUT_DIR)/index.html, $(EXISTING))

# --------------------------------- Rules ------------------------------------ #

.PHONY: all prune clean re example

all: prune $(OUT_DIR)/index.html $(TARGETS)

prune:											# We never prune the root index.html
	@$(foreach f, $(STALE), echo "✗ removed $(dir $f)"; rm -rf "$(dir $f)";)

$(OUT_DIR)/index.html: $(SRC_DIR)/index.md		# build root index
	@mkdir -p $(dir $@)
	@$(LOWDOWN) $(LOWDOWNFLAGS) $< -o $@
	@echo "✓ $< → $@"

$(OUT_DIR)/%/index.html: $(SRC_DIR)/%.md		# build each page into its own subdirectory
	@mkdir -p $(dir $@)
	@$(LOWDOWN) $(LOWDOWNFLAGS) $< -o $@
ifdef BACK
	@sed 's|<body>|<body><nav><a href="../index.html">← Back</a></nav>|' $@ > $@.tmp && mv $@.tmp $@
endif
	@echo "✓ $< → $@"

# --------------------------------- Clean ------------------------------------ #

clean:
	find $(OUT_DIR) -name "*.html" -delete
	find $(OUT_DIR) -mindepth 1 -type d -empty -delete

re: clean
	$(MAKE) all

# --------------------------------- Example ---------------------------------- #

example:
	@if [ ! -d src ]; then \
		cp -r example src; \
		$(MAKE) all BACK=1; \
	else \
		mv src src-temp; \
		cp -r example src; \
		$(MAKE) all BACK=1; \
		rm -rf src; \
		mv src-temp src; \
	fi
	@xdg-open $(CURDIR)/out/index.html 2>/dev/null || open $(CURDIR)/out/index.html 2>/dev/null

# **************************************************************************** #
