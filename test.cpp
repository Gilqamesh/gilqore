#include <iostream>
#include <cstring>

#define LOG(x) std::cout << x << std::endl

class A
{
public:
    int _breh = 3;
    int _breh2 = 4;

    const int& GetBreh() { return _breh; }
};

int main()
{
    A objA;

    LOG("Before");
    LOG(objA._breh);
    LOG(objA._breh2);

    const int& breh = objA.GetBreh();
    memset((void*)((const int*) &breh + 1), 0, sizeof(int));

    LOG("After");
    LOG(objA._breh);
    LOG(objA._breh2);
}
