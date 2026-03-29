CSS				:= https://cdn.simplecss.org/simple.min.css

SRC_DIR			:= src
OUT_DIR			:= out

LOWDOWN			:= lowdown
LOWDOWNFLAGS	:= -s -Thtml -M css=$(CSS)

SRCS			:= $(shell find $(SRC_DIR) -name '*.md' 2>/dev/null)
TARGETS			:= $(patsubst $(SRC_DIR)/%.md, $(OUT_DIR)/%/index.html, $(filter-out $(SRC_DIR)/index.md, $(SRCS)))

EXISTING		:= $(shell find $(OUT_DIR) -name '*.html' 2>/dev/null)
STALE			:= $(filter-out $(TARGETS) $(OUT_DIR)/index.html, $(EXISTING))

.PHONY: all prune clean re example

all: prune $(OUT_DIR)/index.html $(TARGETS)

# We never prune the root index.html
prune:
	@$(foreach f, $(STALE), echo "✗ removed $(dir $f)"; rm -rf "$(dir $f)";)

$(OUT_DIR)/index.html: $(SRC_DIR)/index.md
	@mkdir -p $(dir $@)
	@$(LOWDOWN) $(LOWDOWNFLAGS) $< -o $@
	@echo "✓ $< → $@"

$(OUT_DIR)/%/index.html: $(SRC_DIR)/%.md
	@mkdir -p $(dir $@)
	@$(LOWDOWN) $(LOWDOWNFLAGS) $< -o $@
ifdef BACK
	@sed 's|<body>|<body><nav><a href="../index.html">← Back</a></nav>|' $@ > $@.tmp && mv $@.tmp $@
endif
	@echo "✓ $< → $@"

clean:
	rm -rf $(OUT_DIR)

re: clean all

example:
	@cp -r example src
	@$(MAKE) all BACK=1
	@xdg-open $(CURDIR)/out/index.html 2>/dev/null || open $(CURDIR)/out/index.html 2>/dev/null
