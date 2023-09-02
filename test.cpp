#include <iostream>

#define LOG(x) (std::cout << x << std::endl)

/*

fun a() {

    fun b() {
        c();
    }

    fun c() {
        b();
    }

}

*/

int fact(int a) {
    if (a == 0) {
        return 1;
    }

    auto lamb = [a]() -> int {

        auto inner_lamb = []() -> int {
            fact(0);

            return fact(0);
        };

        LOG(fact(a - 1));
        return fact(a - 1) + inner_lamb();
    };

    return a * lamb();
}

int main() {
    LOG(fact(5));
}
