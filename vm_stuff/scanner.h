#ifndef SCANNER_H
# define SCANNER_H

# include <stdint.h>

typedef struct scanner {
    const char*  start;
    const char*  cur;
    const char*  end;
    uint32_t     line_s;
    uint32_t     line_e;
    uint32_t     col_s;
    uint32_t     col_e;
} scanner_t;

void scanner__init(scanner_t* self, const char* source, uint64_t source_len);

typedef enum token_type {
    // Single-character
    TOKEN_LEFT_PAREN,   TOKEN_RIGHT_PAREN,   TOKEN_LEFT_CURLY,      TOKEN_RIGHT_CURLY,     /*  (  )  {  }  */
    TOKEN_COMMA,        TOKEN_DOT,           TOKEN_MINUS,           TOKEN_PLUS,            /*  ,  .  -  +  */
    TOKEN_SEMICOLON,    TOKEN_FORWARD_SLASH, TOKEN_STAR,            TOKEN_QUESTION_MARK,   /*  ;  /  *  ?  */
    TOKEN_COLON,        TOKEN_PERCENTAGE,    TOKEN_LOGICAL_NOT,     TOKEN_EQUAL,           /*  :  %  !  =  */
    TOKEN_GREATER,      TOKEN_LESS,          TOKEN_BITWISE_XOR,     TOKEN_BITWISE_AND,     /*  >  <  ^  &  */
    TOKEN_BITWISE_OR,   TOKEN_BITWISE_NOT,   TOKEN_HASH,                                   /*  |  ~  '  #  */
    TOKEN_LEFT_SQUARE,  TOKEN_RIGHT_SQUARE,  TOKEN_BACKWARD_SLASH,                         /*  [  ]  \     */

    // Two or more characters
    TOKEN_EXCLAM_EQUAL, TOKEN_EQUAL_EQUAL, TOKEN_GREATER_EQUAL, TOKEN_LESS_EQUAL,  /*  !=  ==  >=  <=  */
    TOKEN_COLON_COLON,  TOKEN_LOGICAL_OR,  TOKEN_LOGICAL_AND,                      /*  ::  ||  &&      */

    // Literals
    TOKEN_IDENTIFIER,                                                              /*  apple               */
    TOKEN_STRING_LITERAL,                                                          /*  "this is a string"  */
    TOKEN_CHARACTER_LITERAL,                                                       /*  'c' 'd'             */
    TOKEN_INTEGRAL_LITERAL,                                                        /*  2  -32              */
    TOKEN_FLOATING_LITERAL,                                                        /*  2.3  .3  3.         */

    // Keywords
    TOKEN_ELSE,     TOKEN_FALSE,    TOKEN_PRINT,                                   /*  class     else     false          */
    TOKEN_FN,       TOKEN_FOR,      TOKEN_IF,                                      /*  fn        for      if             */
    TOKEN_RETURN,   TOKEN_THIS,     TOKEN_ENUM,                                    /*  return    this     enum           */
    TOKEN_TRUE,     TOKEN_WHILE,    TOKEN_BREAK,                                   /*  true      var      while   break  */
    TOKEN_CONTINUE, TOKEN_CONST,    TOKEN_SWITCH,                                  /*  continue  const    switch         */
    TOKEN_CASE,     TOKEN_DEFAULT,  TOKEN_STRUCT,                                  /*  case      default  struct         */
    TOKEN_VOID,                                                                    /*  void                              */
    TOKEN_U8,       TOKEN_U16,      TOKEN_U32,      TOKEN_U64,                     /*  u8        u16      u32     u64    */
    TOKEN_S8,       TOKEN_S16,      TOKEN_S32,      TOKEN_S64,                     /*  s8        s16      s32     s64    */
    TOKEN_R32,      TOKEN_R64,                                                     /*  r32       r64                     */

    // Tokens with special meaning
    TOKEN_ERROR,                    /*  encountered an error  */
    TOKEN_COMMENT,                  /*  c-like comment  */
    TOKEN_EOF,                      /*  marks the end of the token stream for the compiler  */
} token_type_t;
const char* token_type__to_str(token_type_t type);

typedef struct token {
    const char*  lexeme; // not null-terminated
    uint32_t     lexeme_len;
    token_type_t type;
    uint32_t     line_s;
    uint32_t     line_e;
    uint32_t     col_s;
    uint32_t     col_e;
} token_t;

token_t scanner__scan_token(scanner_t* self);

#endif // SCANNER_H
