#include <stddef.h>
#include <include/libc/string/strlen/strlen.h>

size_t strlen(char* str)
{
    size_t len=0;
    while(*str++)len++;
    return len;    
}