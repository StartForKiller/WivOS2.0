
GCCPARAMS = -O2 -g -Wall -Wextra -Werror -Wno-unused-parameter -Wno-unused-but-set-parameter \
		-Wimplicit-fallthrough=0 -Wpedantic -g -nostdlib

ARCH_FAMILY=x86
ARCH=i386

ARCH_FAMILY_S = "x86"
ARCH_S = "i386"

NASM_PARAMS = -f elf32
LDPARAMS = -melf_i386

i686 = i686-elf-
VB=virtualbox
VBM=VBoxManage

objects = ../../kernel/i386/kernel.o ../../boot/i386/boot.o \
		../../libc/stdio/printf/printf.o \
		../../screen/i386/putch/putch.o \
		../../libc/stdio/itoa/itoa.o \
		../../arch/i386/cpu/gdt/gdt_flush.o \
		../../cpu/i386/gdt/gdt.o \
		../../io/i386/io_asm.o
		
libraries = --start-group \
			 ../../cpu/i386/cpu.a \
			 ../../libc/stdio/stdio.a \
			 ../../libc/string/string.a \
			 --end-group 
		
export GCCPARAMS
export NASM_PARAMS
export objects
export LDPARAMS
export ARCH
export ARCH_FAMILY
export libraries

q_c:
	make compile -B
	make WivOS.bin -B
	make WivOS.iso -B
	make qemu-compile -B
	
compile:
	cd boot;make
	cd io;make
	cd libc;make
	cd arch;make
	cd cpu;make
	cd screen;make
	cd kernel;make

WivOS.bin:
	cd link;make
	
WivOS.iso:
	cp WivOS.bin boot/boot/WivOS.bin
	grub-mkrescue --output=WivOS.iso boot
	
gdb_q:
	qemu-system-i386  -kernel  WivOS.bin -display sdl -s -S
	
qemu-compile:
	qemu-system-i386 -kernel WivOS.bin -display sdl