#include <stdio.h>

#define IDK "IDK"
#define ARRAY_SIZE(arr) (sizeof(arr)/sizeof((arr)[0]))

int main() {
    printf("%d\n", ARRAY_SIZE(IDK));
    /* this is a comment // \n to see
    if I can parse it :)
    */

// hi
    return 0;
}
