#include <include/libc/string/strchr/strchr.h>

char *strchr(const char *str, int c) 
{
    for (; *str; str++)
        if (*str == c) return (char*)++str;
    return (char*)0;
}