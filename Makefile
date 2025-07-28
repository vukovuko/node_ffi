CC = g++
# In order to compile node addons, you need to have node installed or add the path to the node include folder to the environment variable NODE_INCLUDE_PATH
NODE_INCLUDE_PATH := $(shell node -p "require('path').resolve(process.execPath, '..', '..', 'include', 'node')")
CCFLAGS = -std=c++2b -g -O3 -fPIC -shared -fsanitize=undefined -Wall -Wextra -Wpedantic -pedantic-errors -Wno-unused-variable -Wno-unused-parameter -Wfatal-errors -I$(NODE_INCLUDE_PATH)
# The output must be a .node file
TARGET = addon.node

.PHONY: all clean run debug rebuild

all: $(TARGET)

$(TARGET): main.o
	$(CC) $(CCFLAGS) -o $(TARGET) main.o

main.o: main.cpp
	$(CC) $(CCFLAGS) -c main.cpp

run: $(TARGET)
	node index.js

debug: $(TARGET)
	gdb $(TARGET)

rebuild: clean all

clean:
	rm -rf $(TARGET) *.o
