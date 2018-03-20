#include <include/libc/string/memset/memset.h>
#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>

void *memset(void *dst, int c, size_t n)
{
   char* d = dst;	
   while(n--)
   {
   	*d++=(char)c;
   }
   *d++=(char)c;
   return dst;    
}