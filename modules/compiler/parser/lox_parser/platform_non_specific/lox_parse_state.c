#include "lox_parse_state.h"

#include "compiler/tokenizer/tokenizer.h"
#include "compiler/parser/parser.h"
#include "compiler/parser/lox_parser/lox_parser.h"

#include "libc/libc.h"

bool lox_parser__is_finished(struct parser* self) {
    return lox_parser__is_finished_parsing(self);
}

struct lox_expressions_table* lox_parser__get_expressions_table(struct parser* self) {
    char* memory = memory_slice__memory(&self->internal_buffer);
    u64 memory_size = memory_slice__size(&self->internal_buffer);
    u64 table_size = memory_size / 3;
    if (table_size < sizeof(struct lox_expressions_table)) {
        error_code__exit(12321);
    }

    struct lox_expressions_table* table = (struct lox_expressions_table*) memory;
    table->table_memory_size = table_size;

    return table;
}

struct lox_literal_table* lox_parser__get_literal_table(struct parser* self) {
    char* memory = memory_slice__memory(&self->internal_buffer);
    u64 memory_size = memory_slice__size(&self->internal_buffer);
    u64 table_size = memory_size / 3;
    if (table_size < sizeof(struct lox_literal_table)) {
        error_code__exit(12321);
    }

    struct lox_literal_table* table = (struct lox_literal_table*) (memory + table_size);
    table->table_memory_size = table_size;

    return table;
}

struct lox_statements_table* lox_parser__get_statements_table(struct parser* self) {
    char* memory = memory_slice__memory(&self->internal_buffer);
    u64 memory_size = memory_slice__size(&self->internal_buffer);
    u64 table_size = memory_size / 3;
    if (table_size < sizeof(struct lox_statements_table)) {
        error_code__exit(12321);
    }

    struct lox_statements_table* table = (struct lox_statements_table*) (memory + 2 * table_size);
    table->table_memory_size = table_size;

    return table;
}

bool lox_parser_clear_tables(struct parser* self) {
    // todo: need data from the tokenizer on how much tokens it has for each token type
    // todo: determine the kinds of expressions we have

    // expressions table
    {
        struct lox_expressions_table* expression_table = lox_parser__get_expressions_table(self);
        u64 expression_table_size = expression_table->table_memory_size;
        u64 memory_offset = sizeof(*expression_table);
        ASSERT(expression_table_size >= memory_offset);
        expression_table_size -= memory_offset;
        u64 expression_subtable_memory_size = expression_table_size / 9;

        expression_table->op_unary_arr = (void*) ((char*) expression_table + memory_offset);
        expression_table->op_unary_arr_fill = 0;
        expression_table->op_unary_arr_size = expression_subtable_memory_size / sizeof(*expression_table->op_unary_arr);
        memory_offset += expression_subtable_memory_size;

        expression_table->op_binary_arr = (void*) ((char*) expression_table + memory_offset);
        expression_table->op_binary_arr_fill = 0;
        expression_table->op_binary_arr_size = expression_subtable_memory_size / sizeof(*expression_table->op_binary_arr);
        memory_offset += expression_subtable_memory_size;

        expression_table->grouping_arr = (void*) ((char*) expression_table + memory_offset);
        expression_table->grouping_arr_fill = 0;
        expression_table->grouping_arr_size = expression_subtable_memory_size / sizeof(*expression_table->grouping_arr);
        memory_offset += expression_subtable_memory_size;

        expression_table->literal_arr = (void*) ((char*) expression_table + memory_offset);
        expression_table->literal_arr_fill = 0;
        expression_table->literal_arr_size = expression_subtable_memory_size / sizeof(*expression_table->literal_arr);
        memory_offset += expression_subtable_memory_size;

        expression_table->logical_arr = (void*) ((char*) expression_table + memory_offset);
        expression_table->logical_arr_fill = 0;
        expression_table->logical_arr_size = expression_subtable_memory_size / sizeof(*expression_table->logical_arr);
        memory_offset += expression_subtable_memory_size;

        expression_table->node_arr = (void*) ((char*) expression_table + memory_offset);
        expression_table->node_arr_fill = 0;
        expression_table->node_arr_size = expression_subtable_memory_size / sizeof(*expression_table->node_arr);
        memory_offset += expression_subtable_memory_size;

        expression_table->call_arr = (void*) ((char*) expression_table + memory_offset);
        expression_table->call_arr_fill = 0;
        expression_table->call_arr_size = expression_subtable_memory_size / sizeof(*expression_table->call_arr);
        memory_offset += expression_subtable_memory_size;

        expression_table->var_arr = (void*) ((char*) expression_table + memory_offset);
        expression_table->var_arr_fill = 0;
        expression_table->var_arr_size = expression_subtable_memory_size / sizeof(*expression_table->var_arr);
        memory_offset += expression_subtable_memory_size;

        expression_table->lambda_arr = (void*) ((char*) expression_table + memory_offset);
        expression_table->lambda_arr_fill = 0;
        expression_table->lambda_arr_size = expression_subtable_memory_size / sizeof(*expression_table->lambda_arr);
        memory_offset += expression_subtable_memory_size;
    }

    // literals table
    {
        struct lox_literal_table* literals_table = lox_parser__get_literal_table(self);
        u64 literals_table_size = literals_table->table_memory_size;
        u64 memory_offset = sizeof(*literals_table);
        ASSERT(literals_table_size >= memory_offset);
        literals_table_size -= memory_offset;
        u64 literals_subtable_memory_size = literals_table_size / 5;

        literals_table->object_arr = (void*) ((char*) literals_table + memory_offset);
        literals_table->object_arr_fill = 0;
        literals_table->object_arr_size = literals_subtable_memory_size;
        memory_offset += literals_subtable_memory_size;

        literals_table->nil_literal = (void*) ((char*) literals_table + memory_offset);
        literals_table->nil_literal->base.type = LOX_LITERAL_TYPE_NIL;
        memory_offset += sizeof(*literals_table->nil_literal);

        literals_table->boolean_literal_true = (void*) ((char*) literals_table + memory_offset);
        literals_table->boolean_literal_true->base.type = LOX_LITERAL_TYPE_BOOLEAN;
        literals_table->boolean_literal_true->data = true;
        memory_offset += sizeof(*literals_table->boolean_literal_true);

        literals_table->boolean_literal_false = (void*) ((char*) literals_table + memory_offset);
        literals_table->boolean_literal_false->base.type = LOX_LITERAL_TYPE_BOOLEAN;
        literals_table->boolean_literal_false->data = false;
        memory_offset += sizeof(*literals_table->boolean_literal_false);

        literals_table->number_arr = (void*) ((char*) literals_table + memory_offset);
        literals_table->number_arr_fill = 0;
        literals_table->number_arr_size = literals_subtable_memory_size / sizeof(*literals_table->number_arr);
        memory_offset += literals_subtable_memory_size;

        literals_table->string_arr = (void*) ((char*) literals_table + memory_offset);
        literals_table->string_arr_fill = 0;
        literals_table->string_arr_size = literals_subtable_memory_size;
        memory_offset += literals_subtable_memory_size;
    }

    // statements table
    {
        struct lox_statements_table* statements_table = lox_parser__get_statements_table(self);
        u64 statements_table_size = statements_table->table_memory_size;
        u64 memory_offset = sizeof(*statements_table);
        ASSERT(statements_table_size >= memory_offset);
        statements_table_size -= memory_offset;
        u64 statements_subtable_memory_size = statements_table_size / 12;

        statements_table->print_statements_arr = (void*) ((char*) statements_table + memory_offset);
        statements_table->print_statements_arr_fill = 0;
        statements_table->print_statements_arr_size = statements_subtable_memory_size / sizeof(*statements_table->print_statements_arr);
        memory_offset += statements_subtable_memory_size;

        statements_table->expression_statements_arr = (void*) ((char*) statements_table + memory_offset);
        statements_table->expression_statements_arr_fill = 0;
        statements_table->expression_statements_arr_size = statements_subtable_memory_size / sizeof(*statements_table->expression_statements_arr);
        memory_offset += statements_subtable_memory_size;
        
        statements_table->var_decl_statements_arr = (void*) ((char*) statements_table + memory_offset);
        statements_table->var_decl_statements_arr_fill = 0;
        statements_table->var_decl_statements_arr_size = statements_subtable_memory_size / sizeof(*statements_table->var_decl_statements_arr);
        memory_offset += statements_subtable_memory_size;
        
        statements_table->lox_parser_statement_node_arr = (void*) ((char*) statements_table + memory_offset);
        statements_table->lox_parser_statement_node_arr_fill = 0;
        statements_table->lox_parser_statement_node_arr_size = statements_subtable_memory_size / sizeof(*statements_table->lox_parser_statement_node_arr);
        memory_offset += statements_subtable_memory_size;
        
        statements_table->block_statements_arr = (void*) ((char*) statements_table + memory_offset);
        statements_table->block_statements_arr_fill = 0;
        statements_table->block_statements_arr_size = statements_subtable_memory_size / sizeof(*statements_table->block_statements_arr);
        memory_offset += statements_subtable_memory_size;

        statements_table->if_statements_arr = (void*) ((char*) statements_table + memory_offset);
        statements_table->if_statements_arr_fill = 0;
        statements_table->if_statements_arr_size = statements_subtable_memory_size / sizeof(*statements_table->if_statements_arr);
        memory_offset += statements_subtable_memory_size;

        statements_table->while_statements_arr = (void*) ((char*) statements_table + memory_offset);
        statements_table->while_statements_arr_fill = 0;
        statements_table->while_statements_arr_size = statements_subtable_memory_size / sizeof(*statements_table->while_statements_arr);
        memory_offset += statements_subtable_memory_size;

        statements_table->break_statement = (void*) ((char*) statements_table + memory_offset);
        statements_table->break_statement->base.type = LOX_PARSER_STATEMENT_TYPE_BREAK;
        memory_offset += statements_subtable_memory_size;

        statements_table->continue_statement = (void*) ((char*) statements_table + memory_offset);
        statements_table->continue_statement->base.type = LOX_PARSER_STATEMENT_TYPE_CONTINUE;
        memory_offset += statements_subtable_memory_size;

        statements_table->fun_params_arr = (void*) ((char*) statements_table + memory_offset);
        statements_table->fun_params_arr_fill = 0;
        statements_table->fun_params_arr_size = statements_subtable_memory_size / sizeof(*statements_table->fun_params_arr);
        memory_offset += statements_subtable_memory_size;

        statements_table->fun_arr = (void*) ((char*) statements_table + memory_offset);
        statements_table->fun_arr_fill = 0;
        statements_table->fun_arr_size = statements_subtable_memory_size / sizeof(*statements_table->fun_arr);
        memory_offset += statements_subtable_memory_size;

        statements_table->return_arr = (void*) ((char*) statements_table + memory_offset);
        statements_table->return_arr_fill = 0;
        statements_table->return_arr_size = statements_subtable_memory_size / sizeof(*statements_table->return_arr);
        memory_offset += statements_subtable_memory_size;
    }

    return true;
}

static void lox_parser__skip_comments(struct parser* self) {
    while (
        lox_parser__is_finished(self) == false &&
        self->tokenizer->tokens[self->token_index].type == LOX_TOKEN_COMMENT
    ) {
        ++self->token_index;
    }
}

enum lox_token_type lox_parser__peek(struct parser* self) {
    lox_parser__skip_comments(self);
    return self->tokenizer->tokens[self->token_index].type;
}

struct token* lox_parser__advance(struct parser* self) {
    if (lox_parser__is_finished(self) == true) {
        return NULL;
    }
    lox_parser__skip_comments(self);
    return &self->tokenizer->tokens[self->token_index++];
}

struct token* lox_parser__advance_if(struct parser* self, enum lox_token_type token_type) {
    return lox_parser__peek(self) == token_type ? lox_parser__advance(self) : NULL;
}

struct token* lox_parser__advance_err(
    struct parser* self,
    enum lox_token_type token_type,
    const char* format, ...
) {
    struct token* token = lox_parser__advance(self);
    if (token == NULL || token->type != token_type) {
        va_list ap;

        va_start(ap, format);
        parser__syntax_verror(self, format, ap);
        va_end(ap);

        return NULL;
    }

    return token;
}

struct token* lox_parser__get_previous(struct parser* self) {
    if (self->token_index == 0) {
        return NULL;
    }

    struct token* result = NULL;
    u32 index = self->token_index - 1;
    while (1) {
        result = &self->tokenizer->tokens[index];
        if (result->type != LOX_TOKEN_COMMENT) {
            break ;
        }
        if (index-- == 0) {
            result = NULL;
            break ;
        }
    }

    return result;
}

void lox_parser__advance_till_next_statement(struct parser* self) {
    while (lox_parser__is_finished_parsing(self) == false ) {
        switch (lox_parser__peek(self)) {
            case LOX_TOKEN_CLASS:
            case LOX_TOKEN_FUN:
            case LOX_TOKEN_VAR:
            case LOX_TOKEN_FOR:
            case LOX_TOKEN_IF:
            case LOX_TOKEN_WHILE:
            case LOX_TOKEN_PRINT:
            case LOX_TOKEN_RETURN: {
                return ;
            } break ;
            default:
        }

        (void) lox_parser__advance(self);
    }
}
