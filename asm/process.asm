bits 64
default rel

segment .text

global DllMain

DllMain:
    push    rbp
    mov     rbp, rsp

    pop     rbp
    ret

global factorial

factorial: ; u64 factorial(s32)
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32

    test    ecx, ecx
    jz      return_one

    inc     rcx    ; end condition
    mov     rbx, 1 ; counter & used for mul, so this should not be eax
    mov     rax, 1 ; result

    jmp     factorial_for

return_one:
    mov     eax, 1

    leave
    ret

factorial_for:
    cmp     rcx, rbx
    je      factorial_end
    mul     rbx ; rax *= rbx
    inc     rbx
    jmp     factorial_for

factorial_end:
    leave
    ret

idk:
    push  rbp
    mov   rbp, rsp

    pop   rbp
    ret
