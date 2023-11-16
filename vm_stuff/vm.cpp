#include <iostream>
#include <stack>
#include <array>
#include <windows.h>
#include <cassert>
#include <intrin.h>
#include "types2.cpp"

class ins;

struct state {
    uint32_t ip;
    std::array<ins*, 4096> instructions;
    std::stack<uint64_t> stack;
    uint64_t registers[256];
    bool alive;
};

class ins {
public:
    virtual void exec(state& s) = 0;
};

class ins_print: public ins {
public:
    void exec(state &s) {
        std::cout << s.stack.top() << std::endl;
    }
};

class ins_push: public ins {
    uint32_t _n;
public:
    ins_push(uint32_t n): _n(n) {}
    void exec(state& s) {
        s.stack.push(_n);
    }
};

class ins_pop: public ins {
public:
    void exec(state& s) {
        s.stack.pop();
    }
};

class ins_add: public ins {
public:
    void exec(state& s) {
        uint32_t a = s.stack.top();
        s.stack.pop();
        uint32_t b = s.stack.top();
        s.stack.pop();
        s.stack.push(a + b);
    }
};

class ins_mul: public ins {
public:
    void exec(state& s) {
        uint32_t a = s.stack.top();
        s.stack.pop();
        uint32_t b = s.stack.top();
        s.stack.pop();
        s.stack.push(a * b);
    }
};

class ins_jmp: public ins {
    uint32_t _ip;
public:
    ins_jmp(uint32_t ip): _ip(ip) {}
    void exec(state& s) {
        s.ip = _ip;
    }
};

class ins_dup: public ins {
public:
    void exec(state &s) {
        s.stack.push(s.stack.top());
    }
};

class ins_malloc: public ins {
    uint32_t _size;
public:
    ins_malloc(uint32_t size): _size(size) {}
    void exec(state& s) {
        void* addr = std::malloc(_size);
        std::cout << "Allocating " << std::hex << addr << std::dec << std::endl;
        s.stack.push((uint64_t) addr);
    }
};

class ins_free: public ins {
public:
    void exec(state& s) {
        void* addr = (void*) s.stack.top();
        std::cout << "Freeing " << std::hex << addr << std::dec << std::endl;
        std::free(addr);
    }
};

class ins_store: public ins {
    uint64_t _n;
public:
    ins_store(uint64_t n): _n(n) {}
    void exec(state& s) {
        void* addr = (void*) s.stack.top();
        *(uint64_t*) addr = _n;
    }
};

class ins_load: public ins {
public:
    void exec(state& s) {
        void* addr = (void*) s.stack.top();
        s.stack.push(*(uint64_t*) addr);
    }
};

class ins_reg_store: public ins {
    uint8_t _reg;
public:
    ins_reg_store(uint8_t reg): _reg(reg) {}
    void exec(state& s) {
        uint64_t what = s.stack.top();
        s.registers[_reg] = what;
    }
};

class ins_reg_load: public ins {
    uint8_t _reg;
public:
    ins_reg_load(uint8_t reg): _reg(reg) {}
    void exec(state &s) {
        s.stack.push(s.registers[_reg]);
    }
};

class ins_call: public ins {
    uint32_t _ip;
public:
    ins_call(uint32_t ip): _ip(ip) {}
    void exec(state &s) {
        s.registers[1] = s.ip;
        s.ip = _ip;
    }
};

class ins_ret: public ins {
public:
    void exec(state& s) {
        s.ip = s.stack.top();
        s.stack.pop();
    }
};

class ins_jz: public ins {
    uint32_t _ip;
public:
    ins_jz(uint32_t ip) : _ip(ip) {}
    void patch(uint32_t ip) { _ip = ip; }
    void exec(state& s) {
        uint64_t a = s.stack.top();
        if (a == 0) {
            s.ip = _ip;
        }
    }
};

class ins_exit: public ins {
public:
    void exec(state& s) {
        s.alive = false;
    }
};

struct auxiliary {
    char* memory;
    int memory_size;
};

void clear_cache(auxiliary& a) {
    for (int j = 0; j < a.memory_size; j++) {
        a.memory[j] = std::rand() * j;
    }
}

uint32_t push_fact_fn(state& s) {
    uint32_t ip = s.ip;
    uint32_t start_ip = ip;

    s.instructions[ip++] = new ins_reg_store(0);
    s.instructions[ip++] = new ins_jz(-1); // need to be patched

    s.instructions[ip++] = new ins_push(1);
    uint32_t loop_start = ip;
    s.instructions[ip++] = new ins_mul();
    s.instructions[ip++] = new ins_reg_load(0);
    s.instructions[ip++] = new ins_push(-1);
    s.instructions[ip++] = new ins_add();
    s.instructions[ip++] = new ins_reg_store(0);
    s.instructions[ip++] = new ins_jz(-1);
    s.instructions[ip++] = new ins_jmp(loop_start);

    // patch the jump
    ins_jz* jmp = dynamic_cast<ins_jz*>(s.instructions[start_ip + 1]);
    assert(jmp);
    jmp->patch(ip);
    jmp = dynamic_cast<ins_jz*>(s.instructions[start_ip + 8]);
    assert(jmp);
    jmp->patch(ip);
    s.instructions[ip++] = new ins_pop();
    s.instructions[ip++] = new ins_reg_store(0);
    s.instructions[ip++] = new ins_reg_load(1);
    s.instructions[ip++] = new ins_ret();

    return ip + 1;
}

int main() {
    auxiliary aux;
    aux.memory_size = 20*1024*1024; // Allocate 20M. Set much larger then L2
    aux.memory = (char *) std::malloc(aux.memory_size);

    state s;
    s.ip = 0;
    s.alive = true;

    // counter
    // s.instructions.push_back(new ins_push(1)); // 0
    // s.instructions.push_back(new ins_dup());   // 1
    // s.instructions.push_back(new ins_add());   // 2
    // s.instructions.push_back(new ins_print()); // 3
    // s.instructions.push_back(new ins_jmp(1));  // 4
    // s.instructions.push_back(new ins_exit());  // 5

    // allocate & free
    // s.instructions[ip++] = new ins_malloc(1024); // 0x120
    // s.instructions[ip++] = new ins_store(2);     // 0x120
    // s.instructions[ip++] = new ins_push(8);      // 0x120 8
    // s.instructions[ip++] = new ins_add();        // 0x128
    // s.instructions[ip++] = new ins_store(4);     // 0x128
    // s.instructions[ip++] = new ins_load();       // 0x128 4
    // s.instructions[ip++] = new ins_print();      // 0x128 4
    // s.instructions[ip++] = new ins_pop();        // 0x128
    // s.instructions[ip++] = new ins_push(-8);     // 0x1; -1
    // s.instructions[ip++] = new ins_add();        // 0x120
    // s.instructions[ip++] = new ins_load();       // 0x120 2
    // s.instructions[ip++] = new ins_print();      // 0x120 2
    // s.instructions[ip++] = new ins_pop();        // 0x120
    // s.instructions[ip++] = new ins_free();       // 0x120
    // s.instructions[ip++] = new ins_exit();       // 0x120

    // call
    uint32_t fact_ip = 0;
    uint32_t ip = push_fact_fn(s);
    uint32_t entry_ip = ip;
    s.instructions[ip++] = new ins_push(10);
    s.instructions[ip++] = new ins_call(fact_ip);
    s.instructions[ip++] = new ins_reg_load(0);
    // s.instructions[ip++] = new ins_print();
    s.instructions[ip++] = new ins_exit();

    uint32_t number_of_runs = 50;
    uint64_t total_time = 0;
    for (uint32_t i = 0; i < number_of_runs; ++i) {
        s.ip = entry_ip;
        s.alive = true;
        clear_cache(aux);
        uint64_t time_start = __rdtsc();
        while (s.alive) {
            uint32_t old_ip = s.ip++;
            s.instructions[old_ip]->exec(s);

            // Sleep(10);
        }
        uint64_t time_end = __rdtsc();
        std::cout << "Time: " << time_end - time_start << "cy, iter: " << i << std::endl;
        total_time += time_end - time_start;
    }

    std::cout << "Time taken: " << (double) total_time / (double) number_of_runs << "cy" << std::endl;

    std::free(aux.memory);

    return 0;
}
