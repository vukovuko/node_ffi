CXX = g++
TARGET = build/addon.node
SOURCES = src/main.cpp

RAYLIB_PATH := libs/raylib-5.5_linux_amd64
NODE_INCLUDE_PATH := $(shell node -p "require('path').resolve(process.execPath, '..', '..', 'include', 'node')")

CXXFLAGS = -std=c++23 -g -fPIC -shared \
           -I$(RAYLIB_PATH)/include \
           -I$(NODE_INCLUDE_PATH) \
           -Wall -Wextra

LIBS = $(RAYLIB_PATH)/lib/libraylib.a

.PHONY: all clean run

all: $(TARGET)

$(TARGET): build/main.o
	@mkdir -p build
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LIBS)

build/main.o: $(SOURCES)
	@mkdir -p build
	$(CXX) $(CXXFLAGS) -c $< -o $@

run: all
	node index.js

clean:
	rm -rf build

