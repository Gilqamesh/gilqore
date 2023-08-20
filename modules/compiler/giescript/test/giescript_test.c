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

static bool subtest(main_context_t context, const char* script, ...) {
    bool result;

    vm__create(&context.vm, &context.allocator);

    va_list ap;
    va_start(ap, script);
    result = vm__vtest_source(&context.vm, script, ap);
    va_end(ap);

    vm__destroy(&context.vm);

    libc__printf("%s: %s\n", result ? "Passed" : "Did not pass", script);

    return result;
}

static bool test(main_context_t context) {
    bool test_result = true;

    test_result &= subtest(context, "", INS_RETURN);
    test_result &= subtest(context, "nil;", INS_NIL, INS_POP, INS_RETURN);
    test_result &= subtest(context, "true;", INS_TRUE, INS_POP, INS_RETURN);
    test_result &= subtest(context, "false;", INS_FALSE, INS_POP, INS_RETURN);
    test_result &= subtest(context, "2;", INS_IMM, INS_POP, INS_RETURN);
    test_result &= subtest(context, "{ var a; }", INS_NIL, INS_POP, INS_RETURN);
    test_result &= subtest(context, "var a;", INS_NIL, INS_IMM, INS_DEFINE_GLOBAL, INS_RETURN);
    test_result &= subtest(context, "2 < 3;", INS_IMM, INS_IMM, INS_LT, INS_POP, INS_RETURN);
    test_result &= subtest(context, "2 > 3;", INS_IMM, INS_IMM, INS_GT, INS_POP, INS_RETURN);
    test_result &= subtest(context, "2 <= 3;", INS_IMM, INS_IMM, INS_GT, INS_NOT, INS_POP, INS_RETURN);
    test_result &= subtest(context, "2 >= 3;", INS_IMM, INS_IMM, INS_LT, INS_NOT, INS_POP, INS_RETURN);
    test_result &= subtest(context, "2 != 3;", INS_IMM, INS_IMM, INS_EQ, INS_NOT, INS_POP, INS_RETURN);
    test_result &= subtest(context, "2 == 3;", INS_IMM, INS_IMM, INS_EQ, INS_POP, INS_RETURN);
    test_result &= subtest(context, "2 + 3;", INS_IMM, INS_IMM, INS_ADD, INS_POP, INS_RETURN);
    test_result &= subtest(context, "2 - 3;", INS_IMM, INS_IMM, INS_SUB, INS_POP, INS_RETURN);
    test_result &= subtest(context, "2 * 3;", INS_IMM, INS_IMM, INS_MUL, INS_POP, INS_RETURN);
    test_result &= subtest(context, "2 / 3;", INS_IMM, INS_IMM, INS_DIV, INS_POP, INS_RETURN);
    test_result &= subtest(context, "print 2;", INS_IMM, INS_PRINT, INS_RETURN);
    test_result &= subtest(context, "!(2 - 3);", INS_IMM, INS_IMM, INS_SUB, INS_NOT, INS_POP, INS_RETURN);
    test_result &= subtest(context, "-4;", INS_IMM, INS_NEG, INS_POP, INS_RETURN);
    test_result &= subtest(context, "\"hi\";", INS_IMM, INS_POP, INS_RETURN);
    test_result &= subtest(context, "5 == 5;", INS_IMM, INS_IMM, INS_EQ, INS_POP, INS_RETURN);
    test_result &= subtest(context, "var a = 5;", INS_IMM, INS_IMM, INS_DEFINE_GLOBAL, INS_RETURN);
    test_result &= subtest(context, "{ 4; }", INS_IMM, INS_POP, INS_RETURN);
    test_result &= subtest(context, "{ var a = 4; }", INS_IMM, INS_POP, INS_RETURN);
    test_result &= subtest(context, "{var a; var b;}", INS_NIL, INS_NIL, INS_IMM, INS_POPN, INS_RETURN);
    test_result &= subtest(context, "var a; { var a = 2; }", INS_NIL, INS_IMM, INS_DEFINE_GLOBAL, INS_IMM, INS_POP, INS_RETURN);
    test_result &= subtest(context, "{ var a = 2; { var a = 1;} var b = 3;}", INS_IMM, INS_IMM, INS_POP, INS_IMM, INS_IMM, INS_POPN, INS_RETURN);
    test_result &= subtest(
        context, "var a; var b = 3; print a; { var a = 2; print a; a = a * a; print a; } print a;",
        INS_NIL, INS_IMM, INS_DEFINE_GLOBAL,
        INS_IMM, INS_IMM, INS_DEFINE_GLOBAL,
        INS_IMM, INS_GET_GLOBAL, INS_PRINT,
        INS_IMM_LONG,
        INS_IMM_LONG, INS_GET_LOCAL, INS_PRINT,
        INS_IMM_LONG, INS_GET_LOCAL, INS_IMM_LONG, INS_GET_LOCAL, INS_MUL, INS_IMM_LONG, INS_SET_LOCAL, INS_POP,
        INS_IMM_LONG, INS_GET_LOCAL, INS_PRINT,
        INS_POP,
        INS_IMM_LONG, INS_GET_GLOBAL, INS_PRINT,
        INS_RETURN
    );
    test_result &= subtest(
        context, "var a; a = 2;",
        INS_NIL, INS_IMM, INS_DEFINE_GLOBAL,
        INS_IMM, INS_IMM, INS_SET_GLOBAL, INS_POP, INS_RETURN
    );
    test_result &= subtest(context, "var a; a;", INS_NIL, INS_IMM, INS_DEFINE_GLOBAL, INS_IMM, INS_GET_GLOBAL, INS_POP, INS_RETURN);
    test_result &= subtest(
        context, "{ var a; a; }",
        INS_NIL,
        INS_IMM, INS_GET_LOCAL, INS_POP,
        INS_POP,
        INS_RETURN
    );
    test_result &= subtest(
        context, "{ var a = 2; a = 3; }",
        INS_IMM,
        INS_IMM, INS_IMM, INS_SET_LOCAL, INS_POP,
        INS_POP,
        INS_RETURN
    );
    test_result &= subtest(
        context, "if (3) print 2; else print 4;",
        INS_IMM,
        INS_IMM, INS_JUMP_ON_FALSE, INS_POP,
        INS_IMM, INS_PRINT,
        INS_IMM, INS_JUMP, INS_POP,
        INS_IMM_LONG, INS_PRINT,
        INS_RETURN
    );
    test_result &= subtest(
        context, "for (;;) print 2;",
        INS_IMM, INS_PRINT,
        INS_IMM, INS_JUMP,
        INS_RETURN
    );
    test_result &= subtest(
        context, "for (var a = 2; a >= 0; a = a - 1) print a;",
        INS_IMM,
        INS_IMM, INS_GET_LOCAL, INS_IMM, INS_LT, INS_NOT, INS_IMM, INS_JUMP_ON_FALSE, INS_POP,
        INS_IMM_LONG, INS_JUMP, INS_IMM_LONG, INS_GET_LOCAL, INS_IMM_LONG, INS_SUB, INS_IMM_LONG, INS_SET_LOCAL, INS_POP, INS_IMM_LONG, INS_JUMP,
        INS_IMM_LONG, INS_GET_LOCAL, INS_PRINT, INS_IMM_LONG, INS_JUMP,
        INS_POP,
        INS_POP,
        INS_RETURN
    );
    test_result &= subtest(
        context, "var a = 1; for (; a >= 0; ) { print a; a = a - 1; } print a;",
        INS_IMM, INS_IMM, INS_DEFINE_GLOBAL,
        INS_IMM, INS_GET_GLOBAL, INS_IMM, INS_LT, INS_NOT, INS_IMM_LONG, INS_JUMP_ON_FALSE, INS_POP,
        INS_IMM_LONG, INS_GET_GLOBAL, INS_PRINT,
        INS_IMM_LONG, INS_GET_GLOBAL, INS_IMM_LONG, INS_SUB, INS_IMM_LONG, INS_SET_GLOBAL, INS_POP,
        INS_IMM_LONG, INS_JUMP,
        INS_POP,
        INS_IMM_LONG, INS_GET_GLOBAL, INS_PRINT,
        INS_RETURN
    );
    test_result &= subtest(
        context, "switch (2) { case 1: print -5; case 2: print 1; case 3: print 4; default: print 9; }",
        INS_IMM, INS_IMM, INS_JUMP, INS_IMM, INS_JUMP,
        INS_DUP, INS_IMM, INS_EQ, INS_IMM_LONG, INS_JUMP_ON_FALSE, INS_POP, INS_IMM_LONG, INS_NEG, INS_PRINT, INS_IMM_LONG, INS_JUMP, INS_POP,
        INS_DUP, INS_IMM_LONG, INS_EQ, INS_IMM_LONG, INS_JUMP_ON_FALSE, INS_POP, INS_IMM_LONG, INS_PRINT, INS_IMM_LONG, INS_JUMP, INS_POP,
        INS_DUP, INS_IMM_LONG, INS_EQ, INS_IMM_LONG, INS_JUMP_ON_FALSE, INS_POP, INS_IMM_LONG, INS_PRINT, INS_IMM_LONG, INS_JUMP, INS_POP,
        INS_IMM_LONG, INS_PRINT,
        INS_POP,
        INS_RETURN
    );

    return test_result;
}

int main(int argc, char** argv) {
    main_context_t context;
    libc__memset(&context, 0, sizeof(context));

    context.memory_size = KILOBYTES(256);
    context.memory      = libc__mmap((void*) 0x40000000, context.memory_size);
    allocator__create(&context.allocator, memory_slice__create(context.memory, context.memory_size));

    if (argc == 1) {
        if (!vm__create(&context.vm, &context.allocator)) {
            fatal(context, "vm__create failed");
        }
        bool run_repl_result = vm__run_repl(&context.vm);
        if (!run_repl_result) {
            fatal(context, "vm__run_repl failed");
        }
    } else if (argc == 2) {
        if (libc__strcmp(argv[1], "-test") == 0) {
            bool test_result = test(context);
            libc__printf("%s\n", test_result ? "All tests passed.\n" : "Some tests did not pass.\n");
        } else {
            if (!vm__create(&context.vm, &context.allocator)) {
                fatal(context, "vm__create failed");
            }
            bool run_file_result = vm__run_file(&context.vm, argv[1]);
            if (!run_file_result) {
                fatal(context, "vm__run_file failed");
            }
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
