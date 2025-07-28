CC = g++
# In order to compile node addons, you need to have node installed
NODE_INCLUDE_PATH := $(shell node -p "require('path').resolve(process.execPath, '..', '..', 'include', 'node')")
CCFLAGS = -std=c++2b -g -O3 -fsanitize=undefined -fsanitize=address -Wall -Wextra -Wpedantic -pedantic-errors -Wno-unused-variable -Wno-unused-parameter -Wfatal-errors -I$(NODE_INCLUDE_PATH)
TARGET = a.out

.PHONY: all clean run debug rebuild

all: $(TARGET)

$(TARGET): main.o
	$(CC) $(CCFLAGS) -o $(TARGET) main.o

main.o: main.cpp
	$(CC) $(CCFLAGS) -c main.cpp

run: $(TARGET)
	./$(TARGET)

debug: $(TARGET)
	gdb $(TARGET)

rebuild: clean all

clean:
	rm -rf $(TARGET) *.o


