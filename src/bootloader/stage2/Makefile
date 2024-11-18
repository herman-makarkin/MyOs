ASMFLAGS?= -f obj
CFLAGS16?= -zq -s -ms -zl -d3
ASM?=nasm

C_FILES=$(wildcard *.c)
ASM_FILES=$(wildcard *.asm)
C_OBJECTS=$(patsubst %.c, $(BUILD_DIR)/stage2/c/%.o, $(C_FILES))
ASM_OBJECTS=$(patsubst %.asm, $(BUILD_DIR)/stage2/asm/%.o, $(ASM_FILES))

.PHONY: all  stage2 clear

all: stage2

stage2: $(BUILD_DIR)/stage2.bin

$(BUILD_DIR)/stage2.bin: $(ASM_OBJECTS) $(C_OBJECTS)
	$(LD16) NAME $(BUILD_DIR)/stage2.bin FILE \{$(ASM_OBJECTS) $(C_OBJECTS) \} OPTION MAP=$(BUILD_DIR)/stage2.map @linker.lnk

$(BUILD_DIR)/stage2/c/%.o: %.c always
	$(CC16) $(CFLAGS16) -fo=$@ $<

$(BUILD_DIR)/stage2/asm/%.o: %.asm always
	$(ASM) $(ASMFLAGS) -o $@ $<
always:
	mkdir -p $(BUILD_DIR)/stage2/c
	mkdir -p $(BUILD_DIR)/stage2/asm

clear:
	rm -rf $(BUILD_DIR)/stage1.bin
