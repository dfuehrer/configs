
# create the completion files to source if the programs get updated

COMPLETION_PROGS := starship rustup code-minimap arduino-cli
COMPLETIONS_SH   := $(addsuffix .sh,$(COMPLETION_PROGS))
#$(foreach prog,$(COMPLETION_PROGS),vpath $(prog) $(PATH))
#vpath % $(PATH)
VPATH := $(PATH)

.PHONY: all
all: $(COMPLETIONS_SH)

$(addsuffix .sh,starship rustup):          COMPLETION := completions
$(addsuffix .sh,code-minimap arduino-cli): COMPLETION := completion
$(COMPLETIONS_SH): %.sh: %
	$< $(COMPLETION) bash > $@

.PHONY: clean
clean:
	rm -f *.sh
