
GCCPARAMS = -O2 -g -Wall -Wextra -Werror -Wno-unused-parameter -Wno-unused-but-set-parameter \
		-Wimplicit-fallthrough=0

ARCH_FAMILY=x86
ARCH=i386

ARCH_FAMILY_S = "x86"
ARCH_S = "i386"

NASM_PARAMS = -f elf32
LDPARAMS = -melf_i386

i686 = i686-elf-
VB=virtualbox
VBM=VBoxManage

objects = ../../main/i386/kernel.o ../../boot/i386/boot.o \
		../../libc/i386/stdio/printf/printf.o \
		../../libc/i386/stdio/putchar/putchar.o \
		../../libc/i386/stdio/itoa/itoa.o \
		../../libasm/cpu/gdt/i386/gdt_flush.o \
		../../cpu/gdt/i386/gdt.o
		
export GCCPARAMS
export NASM_PARAMS
export objects
export LDPARAMS
export ARCH
export ARCH_FAMILY

q_c:
	make compile -B
	make WivOS.bin -B
	make WivOS.iso -B
	make qemu-compile -B
	
compile:
	cd boot;make
	cd libc;make
	cd libasm;make
	cd cpu;make
	cd main;make

WivOS.bin:
	cd linkage;make
	
WivOS.iso:
	cp WivOS.bin boot/boot/WivOS.bin
	grub-mkrescue --output=WivOS.iso boot
	
gdb_q:
	qemu-system-i386  -kernel  WivOS.bin -display sdl -s -S
	
qemu-compile:
	qemu-system-i386 -kernel WivOS.bin -display sdl