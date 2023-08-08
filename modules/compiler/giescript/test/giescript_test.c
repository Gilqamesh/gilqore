#include "test_framework/test_framework.h"

#include "compiler/giescript/giescript.h"

#include "libc/libc.h"
#include "memory/memory.h"

#include "compiler/giescript/platform_non_specific/allocator.h"
#include "compiler/giescript/platform_non_specific/vm.h"

typedef struct main_context {
    size_t memory_size;
    void* memory;
    allocator_t allocator;
    vm_t vm;
} main_context_t;

static void cleanup(main_context_t main_context) {
    libc__munmap(main_context.memory);
}

static void fatal(main_context_t main_context, const char* format, ...) {
    va_list ap;

    va_start(ap, format);
    libc__vprintf(format, ap);
    va_end(ap);
    libc__printf("\n");

    cleanup(main_context);

    error_code__exit(123);
}

int main(int argc, char** argv) {
    main_context_t context;
    libc__memset(&context, 0, sizeof(context));

    context.memory_size = KILOBYTES(32);
    context.memory      = libc__mmap((void*) 0x40000000, context.memory_size);
    allocator__create(&context.allocator, memory_slice__create(context.memory, context.memory_size));

    if (!vm__create(&context.vm, &context.allocator)) {
        error_code__exit(123);
    }

    if (argc == 1) {
        if (!vm__run_repl(&context.vm, &context.allocator)) {
            fatal(context, "vm__run_repl failed");
        }
    } else if (argc == 2) {
        if (!vm__run_file(&context.vm, &context.allocator, argv[1])) {
            fatal(context, "vm__run_file failed");
        }
        error_code__exit(125);
    } else {
        fatal(context, "Usage: giescript [path]");
    }

    cleanup(context);
//
//
    // chunk_t chunk;
    // chunk__create(&chunk, &memory);

    // for (u32 i = 0; i < 1; ++i) {
    //     u32 line = i * 12;
    //     chunk__push_imm_long(&chunk, &memory, 1.2, line);
    //     chunk__push_imm(&chunk, &memory, 1.2, line);
    //     chunk__push_ins(&chunk, &memory, INS_NEG, line);
    //     chunk__push_ins(&chunk, &memory, INS_DIV, line);
    // }
    // chunk__push_ins(&chunk, &memory, INS_RETURN, 123);

    // chunk__disasm(&chunk, "test chunk");

    // vm__interpret(&vm, &memory, &chunk);

    // vm__destroy(&vm, &memory);

    // memory__destroy(&memory);


    return 0;
}
