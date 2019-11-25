# low_native_api

Support library for native modules for low.js writting in C/C++. These modules can be loaded by low.js programs, allowing the programs to be written in a mixture of JavaScript and C/C++.


## Documentation

The full documentation can be found here:
https://www.neonious.com/lowjs/documentation/lowjs-native-api.html


## Example using a native module:

### ON ESP32 MICROCONTROLLER

Step 1: Compile the native module:

cd example
make clean
make esp32


Step 2:

Copy index.js and native.so (compiled in Step 1) to microcontroller
via lowsync or neonious IDE and run!


### ON PC

Step 1: Compile the native module:

cd example
make clean
make


Step 2: Run low.js script:

low index.js

To see what is happening, take a look at index.js. It loads native.so which
is compiled from native.cpp by the Makefile.
