# Makefile for Perceptron in NASM Assembly

# Default target
all: linux

# Linux build (32-bit ELF)
linux: main.asm
	nasm -f elf32 main.asm -o perceptron.o
	gcc -m32 -o perceptron perceptron.o
	@echo "Build successful. Run with ./perceptron"

# Windows build (32-bit COFF)
# Assumes MinGW/GCC is available
win: main.asm
	nasm -f win32 -dWIN32 main.asm -o perceptron.obj
	gcc -m32 -o perceptron.exe perceptron.obj
	@echo "Build successful. Run with perceptron.exe"

# Clean build artifacts
clean:
	rm -f *.o *.obj perceptron perceptron.exe
