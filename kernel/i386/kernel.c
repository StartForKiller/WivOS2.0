#include <stdarg.h>
#include <stdint.h>
#include <stddef.h>
#include <include/GlobalD.h>
#include <include/libc/stdio/stdio.h>
#include <include/multiboot/i386/multiboot.h>
#include <include/cpu/gdt/i386/gdt.h>
#include <include/libc/string/string.h>

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

void kernelMain(multiboot_info_t* multiboot_structure, uint32_t magicnumber)
{
   char str[] = "Hello Woorrrlld"; // Works ;)
   memset(str,'$',7);
   printf("\n%s\n", (str));
     
   printf("\n%d\n", (int)strlen(str));

   strcpy(str, "Bye, world!");
   printf("%s\n", str);
  
   printf("%s\n", strchr(str,'e'));
    install_gdt();
    __asm__ __volatile__ ("cli");
    __asm__ __volatile__ ("hlt");
}