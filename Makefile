CSS				:= https://cdn.simplecss.org/simple.min.css

SRC_DIR			:= src
OUT_DIR			:= out

LOWDOWN			:= lowdown
LOWDOWNFLAGS	:= -s -Thtml -M css=$(CSS)

SRCS			:= $(shell find $(SRC_DIR) -name '*.md' 2>/dev/null)
TARGETS			:= $(patsubst $(SRC_DIR)/%.md, $(OUT_DIR)/%/index.html, $(filter-out $(SRC_DIR)/index.md, $(SRCS)))

EXISTING		:= $(shell find $(OUT_DIR) -name '*.html' 2>/dev/null)
STALE			:= $(filter-out $(TARGETS) $(OUT_DIR)/index.html, $(EXISTING))

.PHONY: all prune clean re

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
	@echo "✓ $< → $@"

clean:
	rm -rf $(OUT_DIR)

re: clean all
