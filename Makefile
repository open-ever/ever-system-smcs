CONTRACTS 	:= elector
BOCS 		:= $(CONTRACTS:%=build/%.boc)

.PHONY: all hashes clean

all: hashes

build/%.boc: contracts/%.fc
	@mkdir -p build
	func -S -W $@ -o build/$*.fif $<
	@echo bye >> build/$*.fif
	fift build/$*.fif

hashes: $(BOCS)
	@for c in $(CONTRACTS); do \
		printf '%s: ' $$c; \
		fift -s scripts/print-hash.fif build/$$c.boc || exit 1; \
	done

clean:
	rm -rf build
