ASM=nasm
CC=clang
CPP=clang++
CC16=/usr/bin/watcom/binl64/wcc
LD16=/usr/bin/watcom/binl64/wlink

SRC_DIR=src
BUILD_DIR=build
IMG=main_floppy.img

.PHONY: all floppy_image kernel bootloader clean always


floppy_image: $(BUILD_DIR)/$(IMG)

$(BUILD_DIR)/$(IMG): bootloader kernel
	dd if=/dev/zero of=$(BUILD_DIR)/$(IMG) bs=512 count=2880
	mkfs.fat -F 12 -n "NBOS" $(BUILD_DIR)/$(IMG)
	dd if=$(BUILD_DIR)/stage1.bin of=$(BUILD_DIR)/$(IMG) conv=notrunc
	mcopy -i $(BUILD_DIR)/$(IMG) $(BUILD_DIR)/stage2.bin "::stage2.bin"
	mcopy -i $(BUILD_DIR)/$(IMG) $(BUILD_DIR)/kernel.bin "::kernel.bin"

bootloader: stage1 stage2

stage1: $(BUILD_DIR)/stage1.bin

$(BUILD_DIR)/stage1.bin: always
	$(MAKE) -C $(SRC_DIR)/bootloader/stage1 BUILD_DIR=$(abspath $(BUILD_DIR))

stage2: $(BUILD_DIR)/stage2.bin

$(BUILD_DIR)/stage2.bin: always
	$(MAKE) -C $(SRC_DIR)/bootloader/stage2 BUILD_DIR=$(abspath $(BUILD_DIR)) CC16=$(CC16) LD16=$(LD16)


kernel: $(BUILD_DIR)/kernel.bin

$(BUILD_DIR)/kernel.bin: always
	$(MAKE) -C $(SRC_DIR)/kernel BUILD_DIR=$(abspath $(BUILD_DIR))

always:
	mkdir -p $(BUILD_DIR)

clear:
	rm -rf $(BUILD_DIR)
