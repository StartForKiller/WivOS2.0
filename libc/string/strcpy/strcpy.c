#include <include/libc/string/strcpy/strcpy.h>

char *strcpy(char *dest, char const *src)
{
    char *result = dest;
    while ((*dest++ = *src++));
    return result;
}