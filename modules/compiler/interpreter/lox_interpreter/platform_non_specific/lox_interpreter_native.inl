#include "time/time.h"
#include "system/system.h"

struct literal* lox_interpreter__native_clock(struct interpreter* interpreter, struct lox_expr_call* call) {
    struct lox_expr_node* parameters = call->parameters;

    (void) interpreter;
    ASSERT(parameters == NULL);
    char buffer[256];
    struct memory_slice buffer_memory = memory_slice__create(buffer, ARRAY_SIZE(buffer));
    time__to_str(time__get(), buffer_memory);
    libc__printf("Time: %s\n", memory_slice__memory(&buffer_memory));

    return NULL;
}

struct literal* lox_interpreter__native_usleep(struct interpreter* interpreter, struct lox_expr_call* call) {
    struct lox_expr_node* parameters = call->parameters;

    ASSERT(parameters != NULL);
    ASSERT(parameters->expression != NULL);
    ASSERT(parameters->next == NULL);

    char buffer[512];
    u32 buffer_size = ARRAY_SIZE(buffer);

    struct literal* literal = lox_interpreter__interpret_expression(interpreter, parameters->expression);
    if (literal == NULL) {
        return NULL;
    }
    if (literal->type != LOX_LITERAL_TYPE_NUMBER) {
        // maybe do implicit conversion and have a literal_to_number helper
        lox_parser__expression_to_str(parameters->expression, buffer, &buffer_size);
        interpreter__runtime_error(
            interpreter, "Expected argument '%s' to be of type '%s' for native usleep callable, but it was of type '%s'.",
            buffer, lox_parser__literal_type_to_str(LOX_LITERAL_TYPE_NUMBER), lox_parser__literal_type_to_str(literal->type)
        );
        return NULL;
    }

    struct lox_literal_number* literal_number = (struct lox_literal_number*) literal;
    system__usleep((u32) literal_number->data);
    
    return NULL;
}

struct literal* lox_interpreter__native_sleep(struct interpreter* interpreter, struct lox_expr_call* call) {
    struct lox_expr_node* parameters = call->parameters;

    ASSERT(parameters != NULL);
    ASSERT(parameters->expression != NULL);
    ASSERT(parameters->next == NULL);

    char buffer[512];
    u32 buffer_size = ARRAY_SIZE(buffer);

    struct literal* literal = lox_interpreter__interpret_expression(interpreter, parameters->expression);
    if (literal == NULL) {
        return NULL;
    }
    if (literal->type != LOX_LITERAL_TYPE_NUMBER) {
        // maybe do implicit conversion and have a literal_to_number helper
        lox_parser__expression_to_str(parameters->expression, buffer, &buffer_size);
        interpreter__runtime_error(
            interpreter, "Expected argument '%s' to be of type '%s' for native sleep callable, but it was of type '%s'.",
            buffer, lox_parser__literal_type_to_str(LOX_LITERAL_TYPE_NUMBER), lox_parser__literal_type_to_str(literal->type)
        );
        return NULL;
    }

    struct lox_literal_number* literal_number = (struct lox_literal_number*) literal;
    system__sleep((u32) literal_number->data);
    
    return NULL;
}