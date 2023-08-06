#include "test_framework/test_framework.h"

#include "compiler/giescript/giescript.h"

#include "libc/libc.h"
#include "memory/memory.h"

#include "compiler/giescript/platform_non_specific/chunk.h"
#include "compiler/giescript/platform_non_specific/memory.h"
#include "compiler/giescript/platform_non_specific/debug.h"
#include "compiler/giescript/platform_non_specific/segment.h"

int main(int argc, char** argv) {
    u64 gies_memory_size = KILOBYTES(1);
    void* gies_memory = libc__mmalloc((void*) 0x40000000, gies_memory_size);

    memory_t memory;
    memory__create(&memory, memory_slice__create(gies_memory, gies_memory_size));

    chunk_t chunk;
    chunk__create(&chunk, &memory);

    for (u32 i = 0; i < 100; ++i) {
        u32 line = i * 12;
        chunk__push_imm_long(&chunk, &memory, 1.2, line);

        chunk__push_op(&chunk, &memory, OP_RETURN, line);
    }

    chunk__disasm(&chunk, "test chunk");

    seg__print(memory.main_memory);

    chunk__destroy(&chunk, &memory);

    memory__destroy(&memory);

    (void) argc;
    (void) argv;
    // if (argc == 1) {
    //     TEST_FRAMEWORK_ASSERT(interpreter_context__create(&context));
    //     interpreter__run_prompt(&context.interpreter);
    //     interpreter_context__destroy(&context);
    // } else if (argc == 2) {
    //     TEST_FRAMEWORK_ASSERT(interpreter_context__create(&context));
    //     if (interpreter__run_file(&context.interpreter, argv[1]) == false) {
    //         libc__printf("interpreter__run_file failed parsing file: [%s]\n", argv[1]);
    //     }
    //     interpreter_context__destroy(&context);
    // } else {
    //     libc__printf("Usage: giescript <script path>\n");
    //     // error_code__exit(WRONG_USAGE);
    //     error_code__exit(3245);
    // }

    libc__free(gies_memory);

    return 0;
}
