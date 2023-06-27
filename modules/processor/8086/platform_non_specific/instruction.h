#ifndef INSTRUCTION_H
# define INSTRUCTION_H

struct instruction_operand {
    enum type {
        REGISTER,
        MEMORY,
        IMMEDIATE,
        RELATIVE_IMMEDIATE
    };
};

struct instruction {
};

#endif // INSTRUCTION_H
