ASM?=nasm

.PHONY: all kernel clear

all: kernel

kernel: $(BUILD_DIR)/kernel.bin

$(BUILD_DIR)/kernel.bin:
	$(ASM) main.asm -f bin -o $(BUILD_DIR)/kernel.bin

clear:
	rm -rf $(BUILD_DIR)/kernel.bin
