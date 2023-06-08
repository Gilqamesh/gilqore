#include "string.h"

#include <iostream>

int main() {
    char str[] = "stuff";

    string__to_upper(str);
    std::cout << str << std::endl;

    return 0;
}
