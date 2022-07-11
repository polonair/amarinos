.PHONY: all clean


all: build/
	cd amarin; make; cp build/* ../build/
	cd bootloader; make; cp build/* ../build/

build/:
	mkdir $@

clean:
	cd amarin; make clean
	cd bootloader; make clean
	rm -rf build
