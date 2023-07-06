#include "test_framework/test_framework.h"

#include "compiler/interpreter/interpreter.h"

#include "libc/libc.h"
#include "memory/memory.h"

struct interpreter_context {
    struct interpreter interpreter;
    struct memory_slice interpreter_memory;
};

static bool interpreter_context__create(struct interpreter_context* context) {
    const u32 interpreter_memory_size = MEGABYTES(16);
    context->interpreter_memory = memory_slice__create(
        libc__malloc(interpreter_memory_size),
        interpreter_memory_size
    );
    if (memory_slice__memory(&context->interpreter_memory) == NULL) {
        return false;
    }
    TEST_FRAMEWORK_ASSERT(
        interpreter__create(
            &context->interpreter,
            INTERPRETER_TYPE_LOX,
            context->interpreter_memory
        )
    );

    return true;
}

static void interpreter_context__destroy(struct interpreter_context* self) {
    interpreter__destroy(&self->interpreter);
    libc__free(memory_slice__memory(&self->interpreter_memory));
}

int main(int argc, char** argv) {
    struct interpreter_context context;
    if (argc == 1) {
        TEST_FRAMEWORK_ASSERT(interpreter_context__create(&context));
        interpreter__run_prompt(&context.interpreter);
        interpreter_context__destroy(&context);
    } else if (argc == 2) {
        TEST_FRAMEWORK_ASSERT(interpreter_context__create(&context));
        if (interpreter__run_file(&context.interpreter, argv[1]) == false) {
            libc__printf("interpreter__run_file failed parsing file: [%s]\n", argv[1]);
        }
        interpreter_context__destroy(&context);
    } else {
        libc__printf("Usage: interpreter [script]\n");
        // error_code__exit(WRONG_USAGE);
        error_code__exit(3245);
    }
    return 0;
}
