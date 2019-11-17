UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
error:
	@echo "Cannot compile on Mac OS X as Mac OS X cannot build ELF files. Please compile on Linux."
	@echo "The resulting native modules can then be used under Mac OS X, too!"
endif

all: native.so
esp32: native.so

C = gcc
CXX = g++
LD = ld

FLAGS = -O3 -fPIC -fvisibility=hidden -fno-stack-protector -fno-builtin

CFLAGS = $(FLAGS) -I../include
CXXFLAGS = $(FLAGS) -I../include
LDFLAGS = $(FLAGS) -shared -T ../ld/`uname -s`-`uname -m`.ld

esp32: C = ~/esp/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc
esp32: CXX = ~/esp/xtensa-esp32-elf/bin/xtensa-esp32-elf-g++
esp32: LD = ~/esp/xtensa-esp32-elf/bin/xtensa-esp32-elf-ld

esp32: CFLAGS = $(FLAGS) -I../include -DDUK_F_32BIT_PTRS -mlongcalls -mfix-esp32-psram-cache-issue
esp32: CXXFLAGS = $(FLAGS) -I../include -DDUK_F_32BIT_PTRS -mlongcalls -mfix-esp32-psram-cache-issue
esp32: LDFLAGS = $(FLAGS) -shared -T ../ld/esp32.ld

OBJECTS =	\
	native.o

clean:
	rm -f native.so *.o *.d

native.so: $(OBJECTS) Makefile
	$(LD) -o native.so $(OBJECTS) $(LDFLAGS)

%.o : %.c Makefile
	$(C) $(CFLAGS) -MMD -o $@ -c $<

%.o : %.cpp Makefile
	$(CXX) $(CXXFLAGS) -MMD -o $@ -c $<

-include $(OBJECTS:.o=.d) $(OBJECTS_LOW:.o=.d)
