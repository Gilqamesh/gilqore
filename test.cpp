#include <iostream>

int main() {
    const auto makeMultipliers = [](int n) {
        return [n](int x) {
            return [x, n](int y) {
                return x * y * n;
            };
        };
    };

    auto multiplier2 = makeMultipliers(2);
    auto multiplier3 = makeMultipliers(3);

    std::cout << multiplier2(10)(5) << std::endl;
    std::cout << multiplier3(10)(5) << std::endl;

    return 0;
}
