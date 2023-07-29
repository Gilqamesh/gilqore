#include "time/time.h"
#include "system/system.h"

struct parser_literal* lox_interpreter__native_clock(struct interpreter* interpreter, struct lox_parser_expr_call* call) {
    struct lox_parser_expr_call_node* arguments = call->arguments;
    struct lox_var_environment* env = call->env;
    (void) env;

    (void) interpreter;
    ASSERT(arguments == NULL);
    char buffer[256];
    struct memory_slice buffer_memory = memory_slice__create(buffer, ARRAY_SIZE(buffer));
    time__to_str(time__get(), buffer_memory);
    libc__printf("Time: %s\n", memory_slice__memory(&buffer_memory));

    return NULL;
}

struct parser_literal* lox_interpreter__native_usleep(struct interpreter* interpreter, struct lox_parser_expr_call* call) {
    struct lox_parser_expr_call_node* arguments = call->arguments;
    struct lox_var_environment* env = call->env;

    ASSERT(arguments != NULL);
    ASSERT(arguments->expression != NULL);
    ASSERT(arguments->next == NULL);

    char buffer[512];

    struct parser_literal* literal = lox_interpreter__interpret_expression(interpreter, env, arguments->expression);
    if (literal == NULL) {
        return NULL;
    }
    if (literal->type != LOX_LITERAL_TYPE_NUMBER) {
        // maybe do implicit conversion and have a literal_to_number helper
        struct memory_slice buffer_memory_slice = memory_slice__create(buffer, ARRAY_SIZE(buffer));
        lox_parser__convert_expr_to_string(arguments->expression, buffer_memory_slice);
        interpreter__runtime_error(
            interpreter, "Expected argument '%s' to be of type '%s' for native usleep callable, but it was of type '%s'.",
            memory_slice__memory(&buffer_memory_slice), lox_parser__literal_type_to_str(LOX_LITERAL_TYPE_NUMBER), lox_parser__literal_type_to_str(literal->type)
        );
        return NULL;
    }

    struct lox_literal_number* literal_number = (struct lox_literal_number*) literal;
    system__usleep((u32) literal_number->data);
    
    return NULL;
}

struct parser_literal* lox_interpreter__native_sleep(struct interpreter* interpreter, struct lox_parser_expr_call* call) {
    struct lox_parser_expr_call_node* arguments = call->arguments;
    struct lox_var_environment* env = call->env;

    ASSERT(arguments != NULL);
    ASSERT(arguments->expression != NULL);
    ASSERT(arguments->next == NULL);

    char buffer[512];

    struct parser_literal* literal = lox_interpreter__interpret_expression(interpreter, env, arguments->expression);
    if (literal == NULL) {
        return NULL;
    }
    if (literal->type != LOX_LITERAL_TYPE_NUMBER) {
        // maybe do implicit conversion and have a literal_to_number helper
        struct memory_slice buffer_memory_slice = memory_slice__create(buffer, ARRAY_SIZE(buffer));
        lox_parser__convert_expr_to_string(arguments->expression, buffer_memory_slice);
        interpreter__runtime_error(
            interpreter, "Expected argument '%s' to be of type '%s' for native usleep callable, but it was of type '%s'.",
            memory_slice__memory(&buffer_memory_slice), lox_parser__literal_type_to_str(LOX_LITERAL_TYPE_NUMBER), lox_parser__literal_type_to_str(literal->type)
        );
        return NULL;
    }

    struct lox_literal_number* literal_number = (struct lox_literal_number*) literal;
    system__sleep((u32) literal_number->data);
    
    return NULL;
}