ASM=nasm

SRC_DIR=src
BUILD_DIR=build
IMG=main_floppy.img

.PHONY: all floppy_image kernel bootloader clean always


floppy_image: $(BUILD_DIR)/$(IMG)

$(BUILD_DIR)/$(IMG): bootloader kernel
	dd if=/dev/zero of=$(BUILD_DIR)/$(IMG) bs=512 count=2880
	mkfs.fat -F 12 -n "NBOS" $(BUILD_DIR)/$(IMG)
	dd if=$(BUILD_DIR)/bootloader.bin of=$(BUILD_DIR)/$(IMG) conv=notrunc
	mcopy -i $(BUILD_DIR)/$(IMG) $(BUILD_DIR)/kernel.bin "::kernel.bin"

bootloader: $(BUILD_DIR)/bootloader.bin

$(BUILD_DIR)/bootloader.bin: always
	$(ASM) $(SRC_DIR)/bootloader/boot.asm -f bin -o $(BUILD_DIR)/bootloader.bin

kernel: $(BUILD_DIR)/kernel.bin

$(BUILD_DIR)/kernel.bin: always
	$(ASM) $(SRC_DIR)/kernel/main.asm -f bin -o $(BUILD_DIR)/kernel.bin

always:
	mkdir -p $(BUILD_DIR)

clear:
	rm -rf $(BUILD_DIR)
