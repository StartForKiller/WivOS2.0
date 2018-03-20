#include <stdarg.h>
#include <stdint.h>
#include <stddef.h>
#include <include/GlobalD.h>
#include <include/libc/i386/stdio/stdio.h>
#include <include/multiboot/i386/multiboot.h>

typedef void (*constructor)();
extern constructor start_ctors;
extern constructor end_ctors;

extern void callConstructors()
{
    for(constructor* i = &start_ctors; i != &end_ctors; i++)
	(*i)();
}

extern void printf(const char* fmt, ...);
extern void putchar(char c);

extern void kernelMain(multiboot_info_t* multiboot_structure, uint32_t magicnumber)
{
    printf(" : %d Yes! Hex: %x yup. Char : %c And a string : %s" , 42, 0x332, 'w', "Stringty String");
    __asm__ __volatile__ ("cli");
    __asm__ __volatile__ ("hlt");
}