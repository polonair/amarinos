.PHONY: all run src rootfs clean

all: build/amarin.img

dist: build/amarin.img
	cd build; zip -9 ../amarin_os-v0.0.1.zip amarin.img

run: build/amarin.img
	qemu-system-x86_64 \
		-bios OVMF.fd \
		-drive if=none,id=uas-disk1,file=$<,format=raw \
		-device usb-storage,drive=uas-disk1 \
		-usb \
		-net none \
		-nographic

build/amarin.img: build/boot.part build/root.part
	dd if=/dev/zero of=$@ bs=512 count=262144
	parted $@ -s -a minimal mklabel gpt
	parted $@ -s -a minimal mkpart EFI FAT16 2048s 18432s
	parted $@ -s -a minimal mkpart ext2 18433s 262110s
	parted $@ -s -a minimal toggle 1 boot
	dd if=build/boot.part of=$@ bs=512 count=16384 seek=2048 conv=notrunc
	dd if=build/root.part of=$@ bs=512 count=243678 seek=18433 conv=notrunc

build/boot.part: build/ src
	dd if=/dev/zero of=$@ bs=512 count=16384
	mformat -i $@ -h 32 -t 32 -n 64 -c 1
	mmd -i $@ ::/EFI
	mmd -i $@ ::/EFI/Boot
	mcopy -i $@ src/build/bootloader.efi ::/EFI/Boot/BootX64.efi

build/root.part: build/ rootfs
	dd if=/dev/zero of=$@ bs=512 count=243712
	mkfs.ext2 $@
	e2cp rootfs/* $@:/

rootfs: build/ src
	cp src/build/amarin.elf rootfs/bin/amarin

src:
	cd src; make

build/:
	mkdir build

clean:
	rm -rf rootfs/bin/*
	rm -rf build
	rm -rf ./*.zip
	touch rootfs/bin/.gitkeep
	cd src; make clean
