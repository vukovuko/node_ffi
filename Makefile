CXX = g++
TARGET = addon.node
SOURCES = main.cpp

RAYLIB_PATH := $(HOME)/vuko/projects/raylib-5.5_linux_amd64
NODE_INCLUDE_PATH := $(shell node -p "require('path').resolve(process.execPath, '..', '..', 'include', 'node')")

CXXFLAGS = -std=c++23 -g -fPIC -shared \
           -I$(RAYLIB_PATH)/include \
           -I$(NODE_INCLUDE_PATH) \
           -Wall -Wextra

LIBS = $(RAYLIB_PATH)/lib/libraylib.a \

.PHONY: all clean run

all: $(TARGET)

$(TARGET): $(SOURCES)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LIBS)

run: all
	node index.js

clean:
	rm -f $(TARGET)

