#ifndef GIES_SCANNER_H
# define GIES_SCANNER_H

# include "compiler/giescript/giescript_defs.h"

# include "common.h"

struct scanner {
    const char*  start;
    const char*  top;
    u32          line_s;
    u32          line_e;
    u32          col_s;
    u32          col_e;
};

void scanner__init(scanner_t* self, const char* source);

typedef enum {
    // Single-character
    TOKEN_LEFT_PAREN, TOKEN_RIGHT_PAREN, TOKEN_LEFT_BRACE, TOKEN_RIGHT_BRACE,     /*  (  )  {  }  */
    TOKEN_COMMA,      TOKEN_DOT,         TOKEN_MINUS,      TOKEN_PLUS,            /*  ,  .  -  +  */
    TOKEN_SEMICOLON,  TOKEN_SLASH,       TOKEN_STAR,       TOKEN_QUESTION_MARK,   /*  ;  /  *  ?  */
    TOKEN_COLON,      TOKEN_PERCENTAGE,  TOKEN_EXCLAM,     TOKEN_EQUAL,           /*  :  %  !  =  */
    TOKEN_GREATER,    TOKEN_LESS,                                                 /*  >  <        */

    // Two or more characters
    TOKEN_EXCLAM_EQUAL, TOKEN_EQUAL_EQUAL, TOKEN_GREATER_EQUAL, TOKEN_LESS_EQUAL, /*  !=  ==  >=  <=  */
    TOKEN_COLON_COLON,                                                            /*  ::              */

    // Literals
    TOKEN_IDENTIFIER,                                                             /*  apple  */
    TOKEN_STRING,                                                                 /*  "this is a string"  */
    TOKEN_NUMBER,                                                                 /*  2  2.3  .3          */

    // Keywords
    TOKEN_AND,      TOKEN_CLASS,  TOKEN_ELSE,  TOKEN_FALSE,                       /*  and       class   else   false  */
    TOKEN_FUN,      TOKEN_FOR,    TOKEN_IF,    TOKEN_NIL,                         /*  fun       for     if     nil    */
    TOKEN_PRINT,    TOKEN_RETURN, TOKEN_SUPER, TOKEN_THIS,                        /*  print     return  super  this   */
    TOKEN_TRUE,     TOKEN_VAR,    TOKEN_WHILE, TOKEN_BREAK,                       /*  true      var     while  break  */
    TOKEN_CONTINUE, TOKEN_OR,     TOKEN_CONST, TOKEN_SWITCH,                      /*  continue  or      const  switch */

    // Tokens with special meaning
    TOKEN_ERROR,                    /*  encountered an error  */
    TOKEN_COMMENT,                  /*  c-like comment  */
    TOKEN_EOF,                      /*  marks the end of the token stream for the compiler  */
} token_type;

struct token {
    const char*  lexeme; // not null-terminated
    u32          lexeme_len;
    u32          type;
    u32          line_s;
    u32          line_e;
    u32          col_s;
    u32          col_e;
};

token_t scanner__scan_token(scanner_t* self);

#endif // GIES_SCANNER_H
