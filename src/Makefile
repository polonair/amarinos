.PHONY: all clean


all: build/
	cd amarin; make; cp amarin.elf ../build/amarin.elf
	cd bootloader; make; cp bootloader.efi ../build/bootloader.efi

build/:
	mkdir $@

clean:
	cd amarin; make clean
	cd bootloader; make clean
	rm -rf build
