Example using a native module:


Step 1: Compile the native module:

cd example
make


Step 4: Run low.js script:

low index.js



To see what is happening, take a look at index.js. It loads native.so which
is compiled from native.cpp by the Makefile.
