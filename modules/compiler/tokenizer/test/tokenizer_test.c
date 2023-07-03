#include "test_framework/test_framework.h"

#include "algorithms/tokenizer/tokenizer.h"
#include "memory/memory.h"
#include "libc/libc.h"
#include "io/file/file.h"

void test_tokenizer__comments(struct tokenizer* tokenizer) {    
    const char* text =
    "/* The code below will print the words Hello World\n"
    "to the screen, and it is amazing */\n"
    "#include <stdio.h>\n"
    "int main() {\n"
    "    // printf() displays the string inside quotation\n"
    "    printf(\"Hello, World!\");\n"
    "    printf(\"shhh this isn't a comment\");\n"
    "    return 0;\n"
    "}\n"
    "/* this block comment has a * in it */\n";

    tokenizer__clear(tokenizer);
    TEST_FRAMEWORK_ASSERT(tokenizer__tokenize_comments(tokenizer, text));

    for (u32 token_index = 0; token_index < tokenizer__fill(tokenizer); ++token_index) {
        libc__printf("Token: [%.*s]\n", tokenizer->tokens[token_index].len, tokenizer->tokens[token_index].lexeme);
    }
}

int main() {
    u64 memory_size = MEGABYTES(64);
    void* memory = libc__malloc(memory_size);

    struct tokenizer tokenizer;
    TEST_FRAMEWORK_ASSERT(tokenizer__create(&tokenizer, memory_slice__create(memory, memory_size)));

    test_tokenizer__comments(&tokenizer);

    tokenizer__destroy(&tokenizer);

    libc__free(memory);

    return 0;
}
