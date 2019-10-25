UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
error:
	@echo "Cannot compile on Mac OS X as Mac OS X cannot build ELF files. Please compile on Linux."
	@echo "The resulting native modules can then be used under Mac OS X, too!"
endif

all: lib/liblow_native.so

esp32: lib/liblow_native.esp32.so

clean:
	rm -f lib/liblow_native.so lib/liblow_native.dylib lib/liblow_native.esp32.so

lib/liblow_native.so: src/stub.c Makefile
	gcc -shared -fPIC -o lib/liblow_native.so src/stub.c -fno-builtin -nostdlib -fno-stack-protector

lib/liblow_native.esp32.so: src/stub.c Makefile
	~/esp/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc -shared -fPIC -o lib/liblow_native.esp32.so src/stub.c -fno-builtin -nostdlib -fno-stack-protector
