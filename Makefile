CSS				:= https://cdn.simplecss.org/simple.min.css

SRC_DIR			:= src
OUT_DIR			:= out

LOWDOWN			:= lowdown
LOWDOWNFLAGS	:= -s -Thtml -M css=$(CSS)

SRCS			:= $(shell find $(SRC_DIR) -name '*.md')
TARGETS			:= $(patsubst $(SRC_DIR)/%.md, $(OUT_DIR)/%.html, $(SRCS))

.PHONY: all clean

all: $(TARGETS)

$(OUT_DIR)/%.html: $(SRC_DIR)/%.md
	mkdir -p $(dir $@)
	$(LOWDOWN) $(LOWDOWNFLAGS) $< -o $@
	@echo "✓ $< → $@"

clean:
	rm -rf $(OUT_DIR)
