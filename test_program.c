#include <stdio.h>
#include <Windows.h>

int main() {
    printf("start mining\n");
    for (int i = 0; i < 20; ++i) {
        printf(".");
        Sleep(250);
    }
    printf("\n");
    printf("finished mining\n");

    return 5;
}
