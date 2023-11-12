bits 64
default rel

segment .data
    array dd -1, 31, 8, 30, -1, 7, -1, -1, 29, -1, 26, 6, -1, -1, 2, -1, -1, 28, -1, -1, -1, 19, 25, -1, 5, -1, 17, -1, 23, 14, 1, -1, 9, -1, -1, -1, 27, -1, 3, -1, -1, -1, 20, -1, 18, 24, 15, 10, -1, -1, 4, -1, 21, -1, 16, 11, -1, 22, -1, 12, 13, -1, 0, -1

segment .text

DllMain:
    push rbp
    mov  rbp, rsp

    pop  rbp
    ret

global f

f:
    push    rbp
    mov     rbp, rsp

	mov	    edx, ecx
	shr	    edx, 1
	or	    edx, edi
	mov	    eax, edx
	shr	    eax, 2
	or	    eax, edx
	mov	    edx, eax
	shr	    edx, 4
	or	    edx, eax
	mov	    eax, edx
	shr	    eax, 8
	or	    eax, edx
	mov	    edx, eax
	shr	    edx, 16
	or	    edx, eax
	imul    eax, edx, 79355661
	shr	    eax, 26
	mov	    eax, [array + eax * 4]

    leave
	ret
