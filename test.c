#include <stdio.h>

typedef struct asd {
    int a;
    int b;
    char c;
} asd_t;

int main() {
    printf("%zu\n", sizeof(asd_t));

    return 0;
}
