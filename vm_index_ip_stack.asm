; 347  :         while (state.alive) {

	movzx	eax, BYTE PTR state$[rsp+10248]
	test	eax, eax
	je	$LN6@main

; 348  :             uint8_t ins = state.code[state.ip++];

	mov	eax, DWORD PTR state$[rsp]
	movzx	eax, BYTE PTR state$[rsp+rax+4]
	mov	BYTE PTR ins$4[rsp], al
	mov	eax, DWORD PTR state$[rsp]
	inc	eax
	mov	DWORD PTR state$[rsp], eax

; 349  :             switch (ins) {

	movzx	eax, BYTE PTR ins$4[rsp]
	mov	DWORD PTR tv136[rsp], eax
	cmp	DWORD PTR tv136[rsp], 16
	ja	$LN125@main
	movsxd	rax, DWORD PTR tv136[rsp]
	lea	rcx, OFFSET FLAT:__ImageBase
	mov	eax, DWORD PTR $LN133@main[rcx+rax*4]
	add	rax, rcx
	jmp	rax
$LN101@main:
$LN11@main:

; 350  :                 case INS_PUSH: {
; 351  :                     uint64_t a;
; 352  :                     CODE_POP(&state, uint64_t, a);

	mov	eax, DWORD PTR state$[rsp]
	mov	rax, QWORD PTR state$[rsp+rax+4]
	mov	QWORD PTR a$37[rsp], rax
	mov	eax, DWORD PTR state$[rsp]
	add	rax, 8
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN11@main
$LN14@main:

; 353  :                     STACK_PUSH(&state, uint64_t, a);

	mov	eax, DWORD PTR state$[rsp+4100]
	mov	rcx, QWORD PTR a$37[rsp]
	mov	QWORD PTR state$[rsp+rax+4104], rcx
	mov	eax, DWORD PTR state$[rsp+4100]
	add	rax, 8
	mov	DWORD PTR state$[rsp+4100], eax
	mov	eax, 8
	imul	rax, rax, 9
	mov	ecx, DWORD PTR state$[rsp+4100]
	mov	QWORD PTR state$[rsp+rax+8200], rcx
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN14@main

; 354  :                 } break ;

	jmp	$LN7@main
$LN102@main:
$LN17@main:

; 355  :                 case INS_POP: {
; 356  :                     uint8_t a;
; 357  :                     CODE_POP(&state, uint8_t, a);

	mov	eax, DWORD PTR state$[rsp]
	movzx	eax, BYTE PTR state$[rsp+rax+4]
	mov	BYTE PTR a$5[rsp], al
	mov	eax, DWORD PTR state$[rsp]
	inc	rax
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN17@main

; 358  :                     switch (a) {

	movzx	eax, BYTE PTR a$5[rsp]
	mov	BYTE PTR tv159[rsp], al
	cmp	BYTE PTR tv159[rsp], 1
	je	SHORT $LN103@main
	cmp	BYTE PTR tv159[rsp], 2
	je	SHORT $LN104@main
	cmp	BYTE PTR tv159[rsp], 4
	je	$LN105@main
	cmp	BYTE PTR tv159[rsp], 8
	je	$LN106@main
	jmp	$LN107@main
$LN103@main:
$LN22@main:

; 359  :                         case 1: {
; 360  :                             uint8_t b;
; 361  :                             STACK_POP(&state, uint8_t, b);

	mov	eax, DWORD PTR state$[rsp+4100]
	movzx	eax, BYTE PTR state$[rsp+rax+4103]
	mov	BYTE PTR b$20[rsp], al
	mov	eax, DWORD PTR state$[rsp+4100]
	dec	rax
	mov	DWORD PTR state$[rsp+4100], eax
	mov	eax, 8
	imul	rax, rax, 9
	mov	ecx, DWORD PTR state$[rsp+4100]
	mov	QWORD PTR state$[rsp+rax+8200], rcx
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN22@main

; 362  :                         } break ;

	jmp	$LN18@main
$LN104@main:
$LN25@main:

; 363  :                         case 2: {
; 364  :                             uint16_t b;
; 365  :                             STACK_POP(&state, uint16_t, b);

	mov	eax, DWORD PTR state$[rsp+4100]
	movzx	eax, WORD PTR state$[rsp+rax+4102]
	mov	WORD PTR b$23[rsp], ax
	mov	eax, DWORD PTR state$[rsp+4100]
	sub	rax, 2
	mov	DWORD PTR state$[rsp+4100], eax
	mov	eax, 8
	imul	rax, rax, 9
	mov	ecx, DWORD PTR state$[rsp+4100]
	mov	QWORD PTR state$[rsp+rax+8200], rcx
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN25@main

; 366  :                         } break ;

	jmp	$LN18@main
$LN105@main:
$LN28@main:

; 367  :                         case 4: {
; 368  :                             uint32_t b;
; 369  :                             STACK_POP(&state, uint32_t, b);

	mov	eax, DWORD PTR state$[rsp+4100]
	mov	eax, DWORD PTR state$[rsp+rax+4100]
	mov	DWORD PTR b$36[rsp], eax
	mov	eax, DWORD PTR state$[rsp+4100]
	sub	rax, 4
	mov	DWORD PTR state$[rsp+4100], eax
	mov	eax, 8
	imul	rax, rax, 9
	mov	ecx, DWORD PTR state$[rsp+4100]
	mov	QWORD PTR state$[rsp+rax+8200], rcx
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN28@main

; 370  :                         } break ;

	jmp	SHORT $LN18@main
$LN106@main:
$LN31@main:

; 371  :                         case 8: {
; 372  :                             uint64_t b;
; 373  :                             STACK_POP(&state, uint64_t, b);

	mov	eax, DWORD PTR state$[rsp+4100]
	mov	rax, QWORD PTR state$[rsp+rax+4096]
	mov	QWORD PTR b$38[rsp], rax
	mov	eax, DWORD PTR state$[rsp+4100]
	sub	rax, 8
	mov	DWORD PTR state$[rsp+4100], eax
	mov	eax, 8
	imul	rax, rax, 9
	mov	ecx, DWORD PTR state$[rsp+4100]
	mov	QWORD PTR state$[rsp+rax+8200], rcx
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN31@main

; 374  :                         } break ;

	jmp	SHORT $LN18@main
$LN107@main:

; 375  :                         default: assert(false);

	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN127@main
	mov	r8d, 375				; 00000177H
	lea	rdx, OFFSET FLAT:$SG75199
	lea	rcx, OFFSET FLAT:$SG75200
	call	_wassert
	xor	eax, eax
$LN127@main:
$LN18@main:

; 376  :                     }
; 377  :                 } break ;

	jmp	$LN7@main
$LN108@main:
$LN34@main:

; 378  :                 case INS_ADD: {
; 379  :                     uint8_t dst_reg;
; 380  :                     uint8_t reg_a;
; 381  :                     uint8_t reg_b;
; 382  :                     CODE_POP(&state, uint8_t, dst_reg);

	mov	eax, DWORD PTR state$[rsp]
	movzx	eax, BYTE PTR state$[rsp+rax+4]
	mov	BYTE PTR dst_reg$8[rsp], al
	mov	eax, DWORD PTR state$[rsp]
	inc	rax
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN34@main
$LN37@main:

; 383  :                     CODE_POP(&state, uint8_t, reg_a);

	mov	eax, DWORD PTR state$[rsp]
	movzx	eax, BYTE PTR state$[rsp+rax+4]
	mov	BYTE PTR reg_a$6[rsp], al
	mov	eax, DWORD PTR state$[rsp]
	inc	rax
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN37@main
$LN40@main:

; 384  :                     CODE_POP(&state, uint8_t, reg_b);

	mov	eax, DWORD PTR state$[rsp]
	movzx	eax, BYTE PTR state$[rsp+rax+4]
	mov	BYTE PTR reg_b$7[rsp], al
	mov	eax, DWORD PTR state$[rsp]
	inc	rax
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN40@main

; 385  :                     uint64_t result = state.registers[reg_a] + state.registers[reg_b];

	movzx	eax, BYTE PTR reg_a$6[rsp]
	movzx	ecx, BYTE PTR reg_b$7[rsp]
	mov	rax, QWORD PTR state$[rsp+rax*8+8200]
	add	rax, QWORD PTR state$[rsp+rcx*8+8200]
	mov	QWORD PTR result$29[rsp], rax

; 386  :                     state.registers[REG_ZF] = result;

	mov	eax, 8
	imul	rax, rax, 11
	mov	rcx, QWORD PTR result$29[rsp]
	mov	QWORD PTR state$[rsp+rax+8200], rcx

; 387  :                     state.registers[dst_reg] = result;

	movzx	eax, BYTE PTR dst_reg$8[rsp]
	mov	rcx, QWORD PTR result$29[rsp]
	mov	QWORD PTR state$[rsp+rax*8+8200], rcx

; 388  :                 } break ;

	jmp	$LN7@main
$LN109@main:
$LN43@main:

; 389  :                 case INS_MUL: {
; 390  :                     uint8_t dst_reg;
; 391  :                     uint8_t reg_a;
; 392  :                     uint8_t reg_b;
; 393  :                     CODE_POP(&state, uint8_t, dst_reg);

	mov	eax, DWORD PTR state$[rsp]
	movzx	eax, BYTE PTR state$[rsp+rax+4]
	mov	BYTE PTR dst_reg$11[rsp], al
	mov	eax, DWORD PTR state$[rsp]
	inc	rax
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN43@main
$LN46@main:

; 394  :                     CODE_POP(&state, uint8_t, reg_a);

	mov	eax, DWORD PTR state$[rsp]
	movzx	eax, BYTE PTR state$[rsp+rax+4]
	mov	BYTE PTR reg_a$9[rsp], al
	mov	eax, DWORD PTR state$[rsp]
	inc	rax
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN46@main
$LN49@main:

; 395  :                     CODE_POP(&state, uint8_t, reg_b);

	mov	eax, DWORD PTR state$[rsp]
	movzx	eax, BYTE PTR state$[rsp+rax+4]
	mov	BYTE PTR reg_b$10[rsp], al
	mov	eax, DWORD PTR state$[rsp]
	inc	rax
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN49@main

; 396  :                     uint64_t result = state.registers[reg_a] * state.registers[reg_b];

	movzx	eax, BYTE PTR reg_a$9[rsp]
	movzx	ecx, BYTE PTR reg_b$10[rsp]
	mov	rax, QWORD PTR state$[rsp+rax*8+8200]
	imul	rax, QWORD PTR state$[rsp+rcx*8+8200]
	mov	QWORD PTR result$30[rsp], rax

; 397  :                     state.registers[REG_ZF] = result;

	mov	eax, 8
	imul	rax, rax, 11
	mov	rcx, QWORD PTR result$30[rsp]
	mov	QWORD PTR state$[rsp+rax+8200], rcx

; 398  :                     state.registers[dst_reg] = result;

	movzx	eax, BYTE PTR dst_reg$11[rsp]
	mov	rcx, QWORD PTR result$30[rsp]
	mov	QWORD PTR state$[rsp+rax*8+8200], rcx

; 399  :                 } break ;

	jmp	$LN7@main
$LN110@main:
$LN52@main:

; 400  :                 case INS_JMP: {
; 401  :                     uint32_t ip;
; 402  :                     CODE_POP(&state, uint32_t, ip);

	mov	eax, DWORD PTR state$[rsp]
	mov	eax, DWORD PTR state$[rsp+rax+4]
	mov	DWORD PTR ip$28[rsp], eax
	mov	eax, DWORD PTR state$[rsp]
	add	rax, 4
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN52@main

; 403  :                     state.ip = ip;

	mov	eax, DWORD PTR ip$28[rsp]
	mov	DWORD PTR state$[rsp], eax

; 404  :                 } break ;

	jmp	$LN7@main
$LN111@main:
$LN55@main:

; 405  :                 case INS_JZ: {
; 406  :                     uint32_t ip;
; 407  :                     CODE_POP(&state, uint32_t, ip);

	mov	eax, DWORD PTR state$[rsp]
	mov	eax, DWORD PTR state$[rsp+rax+4]
	mov	DWORD PTR ip$24[rsp], eax
	mov	eax, DWORD PTR state$[rsp]
	add	rax, 4
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN55@main

; 408  :                     if (state.registers[REG_ZF] == 0) {

	mov	eax, 8
	imul	rax, rax, 11
	cmp	QWORD PTR state$[rsp+rax+8200], 0
	jne	SHORT $LN112@main

; 409  :                         state.ip = ip;

	mov	eax, DWORD PTR ip$24[rsp]
	mov	DWORD PTR state$[rsp], eax
$LN112@main:

; 410  :                     }
; 411  :                 } break ;

	jmp	$LN7@main
$LN113@main:
$LN58@main:

; 412  :                 case INS_JE: {
; 413  :                     uint32_t ip;
; 414  :                     CODE_POP(&state, uint32_t, ip);

	mov	eax, DWORD PTR state$[rsp]
	mov	eax, DWORD PTR state$[rsp+rax+4]
	mov	DWORD PTR ip$25[rsp], eax
	mov	eax, DWORD PTR state$[rsp]
	add	rax, 4
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN58@main

; 415  :                     if (state.registers[REG_ZF] == 0) {

	mov	eax, 8
	imul	rax, rax, 11
	cmp	QWORD PTR state$[rsp+rax+8200], 0
	jne	SHORT $LN114@main

; 416  :                         state.ip = ip;

	mov	eax, DWORD PTR ip$25[rsp]
	mov	DWORD PTR state$[rsp], eax
$LN114@main:

; 417  :                     }
; 418  :                 } break ;

	jmp	$LN7@main
$LN115@main:
$LN61@main:

; 419  :                 case INS_REG_MOV: {
; 420  :                     uint8_t dst_reg;
; 421  :                     uint8_t src_reg;
; 422  :                     CODE_POP(&state, uint8_t, dst_reg);

	mov	eax, DWORD PTR state$[rsp]
	movzx	eax, BYTE PTR state$[rsp+rax+4]
	mov	BYTE PTR dst_reg$1[rsp], al
	mov	eax, DWORD PTR state$[rsp]
	inc	rax
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN61@main
$LN64@main:

; 423  :                     CODE_POP(&state, uint8_t, src_reg);

	mov	eax, DWORD PTR state$[rsp]
	movzx	eax, BYTE PTR state$[rsp+rax+4]
	mov	BYTE PTR src_reg$12[rsp], al
	mov	eax, DWORD PTR state$[rsp]
	inc	rax
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN64@main

; 424  :                     state.registers[dst_reg] = state.registers[src_reg];

	movzx	eax, BYTE PTR src_reg$12[rsp]
	movzx	ecx, BYTE PTR dst_reg$1[rsp]
	mov	rax, QWORD PTR state$[rsp+rax*8+8200]
	mov	QWORD PTR state$[rsp+rcx*8+8200], rax

; 425  :                     state.registers[REG_ZF] = state.registers[dst_reg];

	movzx	eax, BYTE PTR dst_reg$1[rsp]
	mov	ecx, 8
	imul	rcx, rcx, 11
	mov	rax, QWORD PTR state$[rsp+rax*8+8200]
	mov	QWORD PTR state$[rsp+rcx+8200], rax

; 426  :                 } break ;

	jmp	$LN7@main
$LN116@main:
$LN67@main:

; 427  :                 case INS_REG_MOV_ARG: {
; 428  :                     uint8_t reg;
; 429  :                     uint8_t arg_index;
; 430  :                     CODE_POP(&state, uint8_t, reg);

	mov	eax, DWORD PTR state$[rsp]
	movzx	eax, BYTE PTR state$[rsp+rax+4]
	mov	BYTE PTR reg$14[rsp], al
	mov	eax, DWORD PTR state$[rsp]
	inc	rax
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN67@main
$LN70@main:

; 431  :                     CODE_POP(&state, uint8_t, arg_index);

	mov	eax, DWORD PTR state$[rsp]
	movzx	eax, BYTE PTR state$[rsp+rax+4]
	mov	BYTE PTR arg_index$13[rsp], al
	mov	eax, DWORD PTR state$[rsp]
	inc	rax
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN70@main

; 432  :                     uint64_t n = STACK_TOP(

	mov	eax, DWORD PTR state$[rsp+4100]
	lea	rax, QWORD PTR state$[rsp+rax+4104]
	movzx	ecx, BYTE PTR arg_index$13[rsp]
	mov	rax, QWORD PTR [rax+rcx*8-12]
	mov	QWORD PTR n$31[rsp], rax

; 433  :                         &state,
; 434  :                         uint64_t,
; 435  :                         sizeof(uint32_t) /* size of return addr that sits on top of the stack currently */
; 436  :                         + arg_index * sizeof(uint64_t) /* size of each argument currently */
; 437  :                     );
; 438  :                     state.registers[reg] = n;

	movzx	eax, BYTE PTR reg$14[rsp]
	mov	rcx, QWORD PTR n$31[rsp]
	mov	QWORD PTR state$[rsp+rax*8+8200], rcx

; 439  :                     state.registers[REG_ZF] = n;

	mov	eax, 8
	imul	rax, rax, 11
	mov	rcx, QWORD PTR n$31[rsp]
	mov	QWORD PTR state$[rsp+rax+8200], rcx

; 440  :                 } break ;

	jmp	$LN7@main
$LN117@main:
$LN73@main:

; 441  :                 case INS_REG_MOV_IMM: {
; 442  :                     uint8_t reg;
; 443  :                     uint64_t n;
; 444  :                     CODE_POP(&state, uint8_t, reg);

	mov	eax, DWORD PTR state$[rsp]
	movzx	eax, BYTE PTR state$[rsp+rax+4]
	mov	BYTE PTR reg$15[rsp], al
	mov	eax, DWORD PTR state$[rsp]
	inc	rax
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN73@main
$LN76@main:

; 445  :                     CODE_POP(&state, uint64_t, n);

	mov	eax, DWORD PTR state$[rsp]
	mov	rax, QWORD PTR state$[rsp+rax+4]
	mov	QWORD PTR n$32[rsp], rax
	mov	eax, DWORD PTR state$[rsp]
	add	rax, 8
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN76@main

; 446  :                     state.registers[reg] = n;

	movzx	eax, BYTE PTR reg$15[rsp]
	mov	rcx, QWORD PTR n$32[rsp]
	mov	QWORD PTR state$[rsp+rax*8+8200], rcx

; 447  :                     state.registers[REG_ZF] = n;

	mov	eax, 8
	imul	rax, rax, 11
	mov	rcx, QWORD PTR n$32[rsp]
	mov	QWORD PTR state$[rsp+rax+8200], rcx

; 448  :                 } break ;

	jmp	$LN7@main
$LN118@main:
$LN79@main:

; 449  :                 case INS_REG_CMP: {
; 450  :                     uint8_t reg_a;
; 451  :                     uint8_t reg_b;
; 452  :                     CODE_POP(&state, uint8_t, reg_a);

	mov	eax, DWORD PTR state$[rsp]
	movzx	eax, BYTE PTR state$[rsp+rax+4]
	mov	BYTE PTR reg_a$16[rsp], al
	mov	eax, DWORD PTR state$[rsp]
	inc	rax
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN79@main
$LN82@main:

; 453  :                     CODE_POP(&state, uint8_t, reg_b);

	mov	eax, DWORD PTR state$[rsp]
	movzx	eax, BYTE PTR state$[rsp+rax+4]
	mov	BYTE PTR reg_b$17[rsp], al
	mov	eax, DWORD PTR state$[rsp]
	inc	rax
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN82@main

; 454  : 
; 455  :                     int64_t result = state.registers[reg_a] - state.registers[reg_b];

	movzx	eax, BYTE PTR reg_a$16[rsp]
	movzx	ecx, BYTE PTR reg_b$17[rsp]
	mov	rcx, QWORD PTR state$[rsp+rcx*8+8200]
	mov	rax, QWORD PTR state$[rsp+rax*8+8200]
	sub	rax, rcx
	mov	QWORD PTR result$33[rsp], rax

; 456  :                     state.registers[REG_SF] = result;

	mov	eax, 8
	imul	rax, rax, 10
	mov	rcx, QWORD PTR result$33[rsp]
	mov	QWORD PTR state$[rsp+rax+8200], rcx

; 457  :                     state.registers[REG_ZF] = result;

	mov	eax, 8
	imul	rax, rax, 11
	mov	rcx, QWORD PTR result$33[rsp]
	mov	QWORD PTR state$[rsp+rax+8200], rcx

; 458  :                 } break ;

	jmp	$LN7@main
$LN119@main:
$LN85@main:

; 459  :                 case INS_REG_DEC: {
; 460  :                     uint8_t reg;
; 461  :                     CODE_POP(&state, uint8_t, reg);

	mov	eax, DWORD PTR state$[rsp]
	movzx	eax, BYTE PTR state$[rsp+rax+4]
	mov	BYTE PTR reg$2[rsp], al
	mov	eax, DWORD PTR state$[rsp]
	inc	rax
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN85@main

; 462  :                     uint64_t n = state.registers[reg] - 1;

	movzx	eax, BYTE PTR reg$2[rsp]
	mov	rax, QWORD PTR state$[rsp+rax*8+8200]
	dec	rax
	mov	QWORD PTR n$34[rsp], rax

; 463  :                     state.registers[reg] = n;

	movzx	eax, BYTE PTR reg$2[rsp]
	mov	rcx, QWORD PTR n$34[rsp]
	mov	QWORD PTR state$[rsp+rax*8+8200], rcx

; 464  :                     state.registers[REG_ZF] = n;

	mov	eax, 8
	imul	rax, rax, 11
	mov	rcx, QWORD PTR n$34[rsp]
	mov	QWORD PTR state$[rsp+rax+8200], rcx

; 465  :                 } break ;

	jmp	$LN7@main
$LN120@main:
$LN88@main:

; 466  :                 case INS_REG_INC: {
; 467  :                     uint8_t reg;
; 468  :                     CODE_POP(&state, uint8_t, reg);

	mov	eax, DWORD PTR state$[rsp]
	movzx	eax, BYTE PTR state$[rsp+rax+4]
	mov	BYTE PTR reg$3[rsp], al
	mov	eax, DWORD PTR state$[rsp]
	inc	rax
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN88@main

; 469  :                     uint64_t n = state.registers[reg] + 1;

	movzx	eax, BYTE PTR reg$3[rsp]
	mov	rax, QWORD PTR state$[rsp+rax*8+8200]
	inc	rax
	mov	QWORD PTR n$35[rsp], rax

; 470  :                     state.registers[reg] = n;

	movzx	eax, BYTE PTR reg$3[rsp]
	mov	rcx, QWORD PTR n$35[rsp]
	mov	QWORD PTR state$[rsp+rax*8+8200], rcx

; 471  :                     state.registers[REG_ZF] = n;

	mov	eax, 8
	imul	rax, rax, 11
	mov	rcx, QWORD PTR n$35[rsp]
	mov	QWORD PTR state$[rsp+rax+8200], rcx

; 472  :                 } break ;

	jmp	$LN7@main
$LN121@main:
$LN91@main:

; 473  :                 case INS_CALL: {
; 474  :                     uint32_t ip;
; 475  :                     CODE_POP(&state, uint32_t, ip);

	mov	eax, DWORD PTR state$[rsp]
	mov	eax, DWORD PTR state$[rsp+rax+4]
	mov	DWORD PTR ip$26[rsp], eax
	mov	eax, DWORD PTR state$[rsp]
	add	rax, 4
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN91@main
$LN94@main:

; 476  :                     STACK_PUSH(&state, uint32_t, state.ip);

	mov	eax, DWORD PTR state$[rsp+4100]
	mov	ecx, DWORD PTR state$[rsp]
	mov	DWORD PTR state$[rsp+rax+4104], ecx
	mov	eax, DWORD PTR state$[rsp+4100]
	add	rax, 4
	mov	DWORD PTR state$[rsp+4100], eax
	mov	eax, 8
	imul	rax, rax, 9
	mov	ecx, DWORD PTR state$[rsp+4100]
	mov	QWORD PTR state$[rsp+rax+8200], rcx
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN94@main

; 477  :                     state.ip = ip;

	mov	eax, DWORD PTR ip$26[rsp]
	mov	DWORD PTR state$[rsp], eax

; 478  :                 } break ;

	jmp	$LN7@main
$LN122@main:
$LN97@main:

; 479  :                 case INS_RET: {
; 480  :                     uint32_t ip;
; 481  :                     STACK_POP(&state, uint32_t, ip);

	mov	eax, DWORD PTR state$[rsp+4100]
	mov	eax, DWORD PTR state$[rsp+rax+4100]
	mov	DWORD PTR ip$27[rsp], eax
	mov	eax, DWORD PTR state$[rsp+4100]
	sub	rax, 4
	mov	DWORD PTR state$[rsp+4100], eax
	mov	eax, 8
	imul	rax, rax, 9
	mov	ecx, DWORD PTR state$[rsp+4100]
	mov	QWORD PTR state$[rsp+rax+8200], rcx
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN97@main

; 482  :                     state.ip = ip;

	mov	eax, DWORD PTR ip$27[rsp]
	mov	DWORD PTR state$[rsp], eax

; 483  :                 } break ;

	jmp	SHORT $LN7@main
$LN123@main:
$LN100@main:

; 484  :                 case INS_PRINT: {
; 485  :                     uint8_t reg;
; 486  :                     CODE_POP(&state, uint8_t, reg);

	mov	eax, DWORD PTR state$[rsp]
	movzx	eax, BYTE PTR state$[rsp+rax+4]
	mov	BYTE PTR reg$18[rsp], al
	mov	eax, DWORD PTR state$[rsp]
	inc	rax
	mov	DWORD PTR state$[rsp], eax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN100@main

; 487  :                     printf("%llu\n", state.registers[reg]);

	movzx	eax, BYTE PTR reg$18[rsp]
	mov	rdx, QWORD PTR state$[rsp+rax*8+8200]
	lea	rcx, OFFSET FLAT:$SG75217
	call	printf

; 488  :                 } break ;

	jmp	SHORT $LN7@main
$LN124@main:

; 489  :                 case INS_EXIT: {
; 490  :                     state.alive = false;

	mov	BYTE PTR state$[rsp+10248], 0

; 491  :                 } break ;

	jmp	SHORT $LN7@main
$LN125@main:

; 492  :                 default: assert(false);

	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN128@main
	mov	r8d, 492				; 000001ecH
	lea	rdx, OFFSET FLAT:$SG75220
	lea	rcx, OFFSET FLAT:$SG75221
	call	_wassert
	xor	eax, eax
$LN128@main:
$LN7@main:

; 493  :             }
; 494  :         }
