#ifndef COMMENT_TOKENIZER_H
# define COMMENT_TOKENIZER_H

# include "comment_tokenizer_defs.h"

struct tokenizer;
struct tokenizer_token;

PUBLIC_API bool tokenizer__tokenize_comments(struct tokenizer* tokenizer, const char* source);
PUBLIC_API const char* token__type_name_comment(struct tokenizer_token* token);

enum comment_token_type {
    COMMENT_TOKEN_TYPE_TOKEN
};

#endif // COMMENT_TOKENIZER_H
