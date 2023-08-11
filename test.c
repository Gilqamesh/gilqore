#include <stdio.h>

typedef enum {
    yoo
} idk;

typedef struct asd {
    idk a;
    int b;
    char c[];
} asd_t;

int main() {
    printf("%zu\n", sizeof(asd_t));

    return 0;
}
