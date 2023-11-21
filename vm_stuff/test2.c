#include <stdio.h>
#include <stdint.h>
#include <dlfcn.h>
#include <ffi.h>
#include <x86intrin.h>
#include <assert.h>
#include <stdbool.h>
#include <sys/auxv.h>

typedef struct b {
    uint8_t _;
    uint16_t __;
    int32_t  ___;
    int8_t   ____;
} b_t;

void b_t__print(b_t b) {
    printf("%u, %u, %d, %d\n", b._, b.__, b.___, b.____);
}

bool b_t__eq(b_t a, b_t b) {
    return a._ == b._ && a.__ == b.__ && a.___ == b.___ && a.____ == b.____;
}

typedef struct cache {
    char*    memory;
    uint32_t memory_size;
} cache_t;

void cache__clear(cache_t* cache) {
    for (uint32_t j = 0; j < cache->memory_size; j++) {
        cache->memory[j] = j * j;
    }
}

int main() {
    printf("%lu\n", getauxval(AT_SECURE));

    cache_t cache;
    cache.memory_size = 100 * 1024 * 1024;
    cache.memory = malloc(cache.memory_size);

    void* dll_handle = dlopen("libtest.so", RTLD_LAZY);
    if (!dll_handle) {
        printf("%s\n", dlerror());
        return 1;
    }


    void* fn = dlsym(dll_handle, "fn"); 
    if (!fn) {
        return 2;
    }

    void* fn2 = dlsym(dll_handle, "fn2"); 
    if (!fn2) {
        return 3;
    }
    
    void* fn3 = dlsym(dll_handle, "fact");
    if (!fn3) {
        return 3;
    }
    
    ffi_cif cif;
    ffi_type* args[1];
    ffi_type first_arg;
    first_arg.alignment = 0;
    first_arg.elements = (ffi_type*[]) {
        &ffi_type_uint8,
        &ffi_type_uint16,
        &ffi_type_sint32,
        &ffi_type_sint8,
        NULL
    };
    first_arg.size = 0;
    first_arg.type = FFI_TYPE_STRUCT;
    args[0] = &first_arg;
    ffi_status status = ffi_prep_cif(&cif, FFI_DEFAULT_ABI, 1, &first_arg, args);
    if (status != FFI_OK) {
        return 4;
    }

    /*
        fn
        arg = { 67, 65000, -2836, -81 }
        ffi: 1560
        normal: 42.82

        fn2
        arg = 68
        ffi: 1645
        normal: 103.83

        fact
        arg = 20
        ffi: 902
        normal: 276.5
    */

    const uint32_t number_of_tests = 100;
    uint64_t total_clock_cycles_for_ffi_call = 0;
    uint64_t total_clock_cycles_for_normal_call = 0;
    for (uint32_t test_index = 0; test_index < number_of_tests; ++test_index) {
        printf("Current test index: %u\n", test_index);

        b_t fn_arg = {
            ._ = 67,
            .__ = 65000,
            .___ = -2836,
            .____ = -81
        };

        // normal call
        cache__clear(&cache);
        uint64_t time_start = __rdtsc();
        b_t fn_normal_result = ((b_t(*)(b_t))fn)(fn_arg);
        uint64_t time_end   = __rdtsc();
        total_clock_cycles_for_normal_call += time_end - time_start;

        // ffi call
        cache__clear(&cache);
        time_start = __rdtsc();
        b_t fn_ffi_result = { 0 };
        void*   fn_args[1];
        fn_args[0] = &fn_arg;
        ffi_call(&cif, fn, &fn_ffi_result, fn_args);
        time_end = __rdtsc();
        assert(b_t__eq(fn_normal_result, fn_ffi_result));
        total_clock_cycles_for_ffi_call += time_end - time_start;

        b_t__print(fn_ffi_result);
    }

    printf("Time taken for ffi_call: %.6lfCy\n", (double)total_clock_cycles_for_ffi_call / number_of_tests);
    printf("Time taken for normal call: %.6lfCy\n", (double)total_clock_cycles_for_normal_call / number_of_tests);

    // b_t b = {
    //     ._ = 1,
    //     .__ = 2
    // };
    // b = fn(b);

    // print(b);

    return 0;
}
