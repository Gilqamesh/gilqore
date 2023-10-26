bits 64
default rel

segment .data
    format db "factorial of %d is: %d", 0x0d, 0x0a, 0

segment .text
global main
extern fn
extern factorial
extern ExitProcess
extern _CRT_INIT

extern printf

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32

    call    _CRT_INIT

    mov     rcx, 5
    call    factorial

    lea     rcx, [format]
    mov     rdx, 5
    mov     r8, rax
    call    printf

    xor     rax, rax
    call    ExitProcess
