; 354  :         while (state.alive) {

	movzx	eax, BYTE PTR state$[rsp+10256]
	test	eax, eax
	je	$LN6@main

; 355  :             uint8_t ins = *state.ipp++;

	mov	rax, QWORD PTR state$[rsp]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR ins$4[rsp], al
	mov	rax, QWORD PTR state$[rsp]
	inc	rax
	mov	QWORD PTR state$[rsp], rax

; 356  :             switch (ins) {

	movzx	eax, BYTE PTR ins$4[rsp]
	mov	DWORD PTR tv133[rsp], eax
	cmp	DWORD PTR tv133[rsp], 16
	ja	$LN125@main
	movsxd	rax, DWORD PTR tv133[rsp]
	lea	rcx, OFFSET FLAT:__ImageBase
	mov	eax, DWORD PTR $LN133@main[rcx+rax*4]
	add	rax, rcx
	jmp	rax
$LN101@main:
$LN11@main:

; 357  :                 case INS_PUSH: {
; 358  :                     uint64_t a;
; 359  :                     CODE_POP(&state, uint64_t, a);

	mov	rax, QWORD PTR state$[rsp]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR a$32[rsp], rax
	mov	rax, QWORD PTR state$[rsp]
	add	rax, 8
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN11@main
$LN14@main:

; 360  :                     STACK_PUSH(&state, uint64_t, a);

	mov	rax, QWORD PTR state$[rsp+4104]
	mov	rcx, QWORD PTR a$32[rsp]
	mov	QWORD PTR [rax], rcx
	mov	rax, QWORD PTR state$[rsp+4104]
	add	rax, 8
	mov	QWORD PTR state$[rsp+4104], rax
	mov	eax, 8
	imul	rax, rax, 9
	mov	rcx, QWORD PTR state$[rsp+4104]
	mov	QWORD PTR state$[rsp+rax+8208], rcx
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN14@main

; 361  :                 } break ;

	jmp	$LN7@main
$LN102@main:
$LN17@main:

; 362  :                 case INS_POP: {
; 363  :                     uint8_t a;
; 364  :                     CODE_POP(&state, uint8_t, a);

	mov	rax, QWORD PTR state$[rsp]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR a$5[rsp], al
	mov	rax, QWORD PTR state$[rsp]
	inc	rax
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN17@main

; 365  :                     switch (a) {

	movzx	eax, BYTE PTR a$5[rsp]
	mov	BYTE PTR tv143[rsp], al
	cmp	BYTE PTR tv143[rsp], 1
	je	SHORT $LN103@main
	cmp	BYTE PTR tv143[rsp], 2
	je	SHORT $LN104@main
	cmp	BYTE PTR tv143[rsp], 4
	je	$LN105@main
	cmp	BYTE PTR tv143[rsp], 8
	je	$LN106@main
	jmp	$LN107@main
$LN103@main:
$LN22@main:

; 366  :                         case 1: {
; 367  :                             uint8_t b;
; 368  :                             STACK_POP(&state, uint8_t, b);

	mov	rax, QWORD PTR state$[rsp+4104]
	movzx	eax, BYTE PTR [rax-1]
	mov	BYTE PTR b$20[rsp], al
	mov	rax, QWORD PTR state$[rsp+4104]
	dec	rax
	mov	QWORD PTR state$[rsp+4104], rax
	mov	eax, 8
	imul	rax, rax, 9
	mov	rcx, QWORD PTR state$[rsp+4104]
	mov	QWORD PTR state$[rsp+rax+8208], rcx
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN22@main

; 369  :                         } break ;

	jmp	$LN18@main
$LN104@main:
$LN25@main:

; 370  :                         case 2: {
; 371  :                             uint16_t b;
; 372  :                             STACK_POP(&state, uint16_t, b);

	mov	rax, QWORD PTR state$[rsp+4104]
	movzx	eax, WORD PTR [rax-2]
	mov	WORD PTR b$23[rsp], ax
	mov	rax, QWORD PTR state$[rsp+4104]
	sub	rax, 2
	mov	QWORD PTR state$[rsp+4104], rax
	mov	eax, 8
	imul	rax, rax, 9
	mov	rcx, QWORD PTR state$[rsp+4104]
	mov	QWORD PTR state$[rsp+rax+8208], rcx
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN25@main

; 373  :                         } break ;

	jmp	$LN18@main
$LN105@main:
$LN28@main:

; 374  :                         case 4: {
; 375  :                             uint32_t b;
; 376  :                             STACK_POP(&state, uint32_t, b);

	mov	rax, QWORD PTR state$[rsp+4104]
	mov	eax, DWORD PTR [rax-4]
	mov	DWORD PTR b$31[rsp], eax
	mov	rax, QWORD PTR state$[rsp+4104]
	sub	rax, 4
	mov	QWORD PTR state$[rsp+4104], rax
	mov	eax, 8
	imul	rax, rax, 9
	mov	rcx, QWORD PTR state$[rsp+4104]
	mov	QWORD PTR state$[rsp+rax+8208], rcx
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN28@main

; 377  :                         } break ;

	jmp	SHORT $LN18@main
$LN106@main:
$LN31@main:

; 378  :                         case 8: {
; 379  :                             uint64_t b;
; 380  :                             STACK_POP(&state, uint64_t, b);

	mov	rax, QWORD PTR state$[rsp+4104]
	mov	rax, QWORD PTR [rax-8]
	mov	QWORD PTR b$38[rsp], rax
	mov	rax, QWORD PTR state$[rsp+4104]
	sub	rax, 8
	mov	QWORD PTR state$[rsp+4104], rax
	mov	eax, 8
	imul	rax, rax, 9
	mov	rcx, QWORD PTR state$[rsp+4104]
	mov	QWORD PTR state$[rsp+rax+8208], rcx
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN31@main

; 381  :                         } break ;

	jmp	SHORT $LN18@main
$LN107@main:

; 382  :                         default: assert(false);

	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN127@main
	mov	r8d, 382				; 0000017eH
	lea	rdx, OFFSET FLAT:$SG75200
	lea	rcx, OFFSET FLAT:$SG75201
	call	_wassert
	xor	eax, eax
$LN127@main:
$LN18@main:

; 383  :                     }
; 384  :                 } break ;

	jmp	$LN7@main
$LN108@main:
$LN34@main:

; 385  :                 case INS_ADD: {
; 386  :                     uint8_t dst_reg;
; 387  :                     uint8_t reg_a;
; 388  :                     uint8_t reg_b;
; 389  :                     CODE_POP(&state, uint8_t, dst_reg);

	mov	rax, QWORD PTR state$[rsp]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR dst_reg$8[rsp], al
	mov	rax, QWORD PTR state$[rsp]
	inc	rax
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN34@main
$LN37@main:

; 390  :                     CODE_POP(&state, uint8_t, reg_a);

	mov	rax, QWORD PTR state$[rsp]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR reg_a$6[rsp], al
	mov	rax, QWORD PTR state$[rsp]
	inc	rax
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN37@main
$LN40@main:

; 391  :                     CODE_POP(&state, uint8_t, reg_b);

	mov	rax, QWORD PTR state$[rsp]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR reg_b$7[rsp], al
	mov	rax, QWORD PTR state$[rsp]
	inc	rax
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN40@main

; 392  :                     uint64_t result = state.registers[reg_a] + state.registers[reg_b];

	movzx	eax, BYTE PTR reg_a$6[rsp]
	movzx	ecx, BYTE PTR reg_b$7[rsp]
	mov	rax, QWORD PTR state$[rsp+rax*8+8208]
	add	rax, QWORD PTR state$[rsp+rcx*8+8208]
	mov	QWORD PTR result$24[rsp], rax

; 393  :                     state.registers[REG_ZF] = result;

	mov	eax, 8
	imul	rax, rax, 11
	mov	rcx, QWORD PTR result$24[rsp]
	mov	QWORD PTR state$[rsp+rax+8208], rcx

; 394  :                     state.registers[dst_reg] = result;

	movzx	eax, BYTE PTR dst_reg$8[rsp]
	mov	rcx, QWORD PTR result$24[rsp]
	mov	QWORD PTR state$[rsp+rax*8+8208], rcx

; 395  :                 } break ;

	jmp	$LN7@main
$LN109@main:
$LN43@main:

; 396  :                 case INS_MUL: {
; 397  :                     uint8_t dst_reg;
; 398  :                     uint8_t reg_a;
; 399  :                     uint8_t reg_b;
; 400  :                     CODE_POP(&state, uint8_t, dst_reg);

	mov	rax, QWORD PTR state$[rsp]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR dst_reg$11[rsp], al
	mov	rax, QWORD PTR state$[rsp]
	inc	rax
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN43@main
$LN46@main:

; 401  :                     CODE_POP(&state, uint8_t, reg_a);

	mov	rax, QWORD PTR state$[rsp]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR reg_a$9[rsp], al
	mov	rax, QWORD PTR state$[rsp]
	inc	rax
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN46@main
$LN49@main:

; 402  :                     CODE_POP(&state, uint8_t, reg_b);

	mov	rax, QWORD PTR state$[rsp]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR reg_b$10[rsp], al
	mov	rax, QWORD PTR state$[rsp]
	inc	rax
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN49@main

; 403  :                     uint64_t result = state.registers[reg_a] * state.registers[reg_b];

	movzx	eax, BYTE PTR reg_a$9[rsp]
	movzx	ecx, BYTE PTR reg_b$10[rsp]
	mov	rax, QWORD PTR state$[rsp+rax*8+8208]
	imul	rax, QWORD PTR state$[rsp+rcx*8+8208]
	mov	QWORD PTR result$25[rsp], rax

; 404  :                     state.registers[REG_ZF] = result;

	mov	eax, 8
	imul	rax, rax, 11
	mov	rcx, QWORD PTR result$25[rsp]
	mov	QWORD PTR state$[rsp+rax+8208], rcx

; 405  :                     state.registers[dst_reg] = result;

	movzx	eax, BYTE PTR dst_reg$11[rsp]
	mov	rcx, QWORD PTR result$25[rsp]
	mov	QWORD PTR state$[rsp+rax*8+8208], rcx

; 406  :                 } break ;

	jmp	$LN7@main
$LN110@main:
$LN52@main:

; 407  :                 case INS_JMP: {
; 408  :                     uint8_t* ip;
; 409  :                     CODE_POP(&state, uint64_t, ip);

	mov	rax, QWORD PTR state$[rsp]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR ip$33[rsp], rax
	mov	rax, QWORD PTR state$[rsp]
	add	rax, 8
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN52@main

; 410  :                     state.ipp = ip;

	mov	rax, QWORD PTR ip$33[rsp]
	mov	QWORD PTR state$[rsp], rax

; 411  :                 } break ;

	jmp	$LN7@main
$LN111@main:
$LN55@main:

; 412  :                 case INS_JZ: {
; 413  :                     uint8_t* ip;
; 414  :                     CODE_POP(&state, uint64_t, ip);

	mov	rax, QWORD PTR state$[rsp]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR ip$34[rsp], rax
	mov	rax, QWORD PTR state$[rsp]
	add	rax, 8
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN55@main

; 415  :                     if (state.registers[REG_ZF] == 0) {

	mov	eax, 8
	imul	rax, rax, 11
	cmp	QWORD PTR state$[rsp+rax+8208], 0
	jne	SHORT $LN112@main

; 416  :                         state.ipp = ip;

	mov	rax, QWORD PTR ip$34[rsp]
	mov	QWORD PTR state$[rsp], rax
$LN112@main:

; 417  :                     }
; 418  :                 } break ;

	jmp	$LN7@main
$LN113@main:
$LN58@main:

; 419  :                 case INS_JE: {
; 420  :                     uint8_t* ip;
; 421  :                     CODE_POP(&state, uint64_t, ip);

	mov	rax, QWORD PTR state$[rsp]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR ip$35[rsp], rax
	mov	rax, QWORD PTR state$[rsp]
	add	rax, 8
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN58@main

; 422  :                     if (state.registers[REG_ZF] == 0) {

	mov	eax, 8
	imul	rax, rax, 11
	cmp	QWORD PTR state$[rsp+rax+8208], 0
	jne	SHORT $LN114@main

; 423  :                         state.ipp = ip;

	mov	rax, QWORD PTR ip$35[rsp]
	mov	QWORD PTR state$[rsp], rax
$LN114@main:

; 424  :                     }
; 425  :                 } break ;

	jmp	$LN7@main
$LN115@main:
$LN61@main:

; 426  :                 case INS_REG_MOV: {
; 427  :                     uint8_t dst_reg;
; 428  :                     uint8_t src_reg;
; 429  :                     CODE_POP(&state, uint8_t, dst_reg);

	mov	rax, QWORD PTR state$[rsp]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR dst_reg$1[rsp], al
	mov	rax, QWORD PTR state$[rsp]
	inc	rax
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN61@main
$LN64@main:

; 430  :                     CODE_POP(&state, uint8_t, src_reg);

	mov	rax, QWORD PTR state$[rsp]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR src_reg$12[rsp], al
	mov	rax, QWORD PTR state$[rsp]
	inc	rax
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN64@main

; 431  :                     state.registers[dst_reg] = state.registers[src_reg];

	movzx	eax, BYTE PTR src_reg$12[rsp]
	movzx	ecx, BYTE PTR dst_reg$1[rsp]
	mov	rax, QWORD PTR state$[rsp+rax*8+8208]
	mov	QWORD PTR state$[rsp+rcx*8+8208], rax

; 432  :                     state.registers[REG_ZF] = state.registers[dst_reg];

	movzx	eax, BYTE PTR dst_reg$1[rsp]
	mov	ecx, 8
	imul	rcx, rcx, 11
	mov	rax, QWORD PTR state$[rsp+rax*8+8208]
	mov	QWORD PTR state$[rsp+rcx+8208], rax

; 433  :                 } break ;

	jmp	$LN7@main
$LN116@main:
$LN67@main:

; 434  :                 case INS_REG_MOV_ARG: {
; 435  :                     uint8_t reg;
; 436  :                     uint8_t arg_index;
; 437  :                     CODE_POP(&state, uint8_t, reg);

	mov	rax, QWORD PTR state$[rsp]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR reg$14[rsp], al
	mov	rax, QWORD PTR state$[rsp]
	inc	rax
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN67@main
$LN70@main:

; 438  :                     CODE_POP(&state, uint8_t, arg_index);

	mov	rax, QWORD PTR state$[rsp]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR arg_index$13[rsp], al
	mov	rax, QWORD PTR state$[rsp]
	inc	rax
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN70@main

; 439  :                     uint64_t n = STACK_TOP(

	movzx	eax, BYTE PTR arg_index$13[rsp]
	mov	rcx, QWORD PTR state$[rsp+4104]
	mov	rax, QWORD PTR [rcx+rax*8-12]
	mov	QWORD PTR n$26[rsp], rax

; 440  :                         &state,
; 441  :                         uint64_t,
; 442  :                         sizeof(uint32_t) /* size of return addr that sits on top of the stack currently */
; 443  :                         + arg_index * sizeof(uint64_t) /* size of each argument currently */
; 444  :                     );
; 445  :                     state.registers[reg] = n;

	movzx	eax, BYTE PTR reg$14[rsp]
	mov	rcx, QWORD PTR n$26[rsp]
	mov	QWORD PTR state$[rsp+rax*8+8208], rcx

; 446  :                     state.registers[REG_ZF] = n;

	mov	eax, 8
	imul	rax, rax, 11
	mov	rcx, QWORD PTR n$26[rsp]
	mov	QWORD PTR state$[rsp+rax+8208], rcx

; 447  :                 } break ;

	jmp	$LN7@main
$LN117@main:
$LN73@main:

; 448  :                 case INS_REG_MOV_IMM: {
; 449  :                     uint8_t reg;
; 450  :                     uint64_t n;
; 451  :                     CODE_POP(&state, uint8_t, reg);

	mov	rax, QWORD PTR state$[rsp]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR reg$15[rsp], al
	mov	rax, QWORD PTR state$[rsp]
	inc	rax
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN73@main
$LN76@main:

; 452  :                     CODE_POP(&state, uint64_t, n);

	mov	rax, QWORD PTR state$[rsp]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR n$27[rsp], rax
	mov	rax, QWORD PTR state$[rsp]
	add	rax, 8
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN76@main

; 453  :                     state.registers[reg] = n;

	movzx	eax, BYTE PTR reg$15[rsp]
	mov	rcx, QWORD PTR n$27[rsp]
	mov	QWORD PTR state$[rsp+rax*8+8208], rcx

; 454  :                     state.registers[REG_ZF] = n;

	mov	eax, 8
	imul	rax, rax, 11
	mov	rcx, QWORD PTR n$27[rsp]
	mov	QWORD PTR state$[rsp+rax+8208], rcx

; 455  :                 } break ;

	jmp	$LN7@main
$LN118@main:
$LN79@main:

; 456  :                 case INS_REG_CMP: {
; 457  :                     uint8_t reg_a;
; 458  :                     uint8_t reg_b;
; 459  :                     CODE_POP(&state, uint8_t, reg_a);

	mov	rax, QWORD PTR state$[rsp]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR reg_a$16[rsp], al
	mov	rax, QWORD PTR state$[rsp]
	inc	rax
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN79@main
$LN82@main:

; 460  :                     CODE_POP(&state, uint8_t, reg_b);

	mov	rax, QWORD PTR state$[rsp]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR reg_b$17[rsp], al
	mov	rax, QWORD PTR state$[rsp]
	inc	rax
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN82@main

; 461  : 
; 462  :                     int64_t result = state.registers[reg_a] - state.registers[reg_b];

	movzx	eax, BYTE PTR reg_a$16[rsp]
	movzx	ecx, BYTE PTR reg_b$17[rsp]
	mov	rcx, QWORD PTR state$[rsp+rcx*8+8208]
	mov	rax, QWORD PTR state$[rsp+rax*8+8208]
	sub	rax, rcx
	mov	QWORD PTR result$28[rsp], rax

; 463  :                     state.registers[REG_SF] = result;

	mov	eax, 8
	imul	rax, rax, 10
	mov	rcx, QWORD PTR result$28[rsp]
	mov	QWORD PTR state$[rsp+rax+8208], rcx

; 464  :                     state.registers[REG_ZF] = result;

	mov	eax, 8
	imul	rax, rax, 11
	mov	rcx, QWORD PTR result$28[rsp]
	mov	QWORD PTR state$[rsp+rax+8208], rcx

; 465  :                 } break ;

	jmp	$LN7@main
$LN119@main:
$LN85@main:

; 466  :                 case INS_REG_DEC: {
; 467  :                     uint8_t reg;
; 468  :                     CODE_POP(&state, uint8_t, reg);

	mov	rax, QWORD PTR state$[rsp]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR reg$2[rsp], al
	mov	rax, QWORD PTR state$[rsp]
	inc	rax
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN85@main

; 469  :                     uint64_t n = state.registers[reg] - 1;

	movzx	eax, BYTE PTR reg$2[rsp]
	mov	rax, QWORD PTR state$[rsp+rax*8+8208]
	dec	rax
	mov	QWORD PTR n$29[rsp], rax

; 470  :                     state.registers[reg] = n;

	movzx	eax, BYTE PTR reg$2[rsp]
	mov	rcx, QWORD PTR n$29[rsp]
	mov	QWORD PTR state$[rsp+rax*8+8208], rcx

; 471  :                     state.registers[REG_ZF] = n;

	mov	eax, 8
	imul	rax, rax, 11
	mov	rcx, QWORD PTR n$29[rsp]
	mov	QWORD PTR state$[rsp+rax+8208], rcx

; 472  :                 } break ;

	jmp	$LN7@main
$LN120@main:
$LN88@main:

; 473  :                 case INS_REG_INC: {
; 474  :                     uint8_t reg;
; 475  :                     CODE_POP(&state, uint8_t, reg);

	mov	rax, QWORD PTR state$[rsp]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR reg$3[rsp], al
	mov	rax, QWORD PTR state$[rsp]
	inc	rax
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN88@main

; 476  :                     uint64_t n = state.registers[reg] + 1;

	movzx	eax, BYTE PTR reg$3[rsp]
	mov	rax, QWORD PTR state$[rsp+rax*8+8208]
	inc	rax
	mov	QWORD PTR n$30[rsp], rax

; 477  :                     state.registers[reg] = n;

	movzx	eax, BYTE PTR reg$3[rsp]
	mov	rcx, QWORD PTR n$30[rsp]
	mov	QWORD PTR state$[rsp+rax*8+8208], rcx

; 478  :                     state.registers[REG_ZF] = n;

	mov	eax, 8
	imul	rax, rax, 11
	mov	rcx, QWORD PTR n$30[rsp]
	mov	QWORD PTR state$[rsp+rax+8208], rcx

; 479  :                 } break ;

	jmp	$LN7@main
$LN121@main:
$LN91@main:

; 480  :                 case INS_CALL: {
; 481  :                     uint8_t* ip;
; 482  :                     CODE_POP(&state, uint64_t, ip);

	mov	rax, QWORD PTR state$[rsp]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR ip$36[rsp], rax
	mov	rax, QWORD PTR state$[rsp]
	add	rax, 8
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN91@main
$LN94@main:

; 483  :                     STACK_PUSH(&state, uint8_t*, state.ipp);

	mov	rax, QWORD PTR state$[rsp+4104]
	mov	rcx, QWORD PTR state$[rsp]
	mov	QWORD PTR [rax], rcx
	mov	rax, QWORD PTR state$[rsp+4104]
	add	rax, 8
	mov	QWORD PTR state$[rsp+4104], rax
	mov	eax, 8
	imul	rax, rax, 9
	mov	rcx, QWORD PTR state$[rsp+4104]
	mov	QWORD PTR state$[rsp+rax+8208], rcx
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN94@main

; 484  :                     state.ipp = ip;

	mov	rax, QWORD PTR ip$36[rsp]
	mov	QWORD PTR state$[rsp], rax

; 485  :                 } break ;

	jmp	$LN7@main
$LN122@main:
$LN97@main:

; 486  :                 case INS_RET: {
; 487  :                     uint8_t* ip;
; 488  :                     STACK_POP(&state, uint8_t*, ip);

	mov	rax, QWORD PTR state$[rsp+4104]
	mov	rax, QWORD PTR [rax-8]
	mov	QWORD PTR ip$37[rsp], rax
	mov	rax, QWORD PTR state$[rsp+4104]
	sub	rax, 8
	mov	QWORD PTR state$[rsp+4104], rax
	mov	eax, 8
	imul	rax, rax, 9
	mov	rcx, QWORD PTR state$[rsp+4104]
	mov	QWORD PTR state$[rsp+rax+8208], rcx
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN97@main

; 489  :                     state.ipp = ip;

	mov	rax, QWORD PTR ip$37[rsp]
	mov	QWORD PTR state$[rsp], rax

; 490  :                 } break ;

	jmp	SHORT $LN7@main
$LN123@main:
$LN100@main:

; 491  :                 case INS_PRINT: {
; 492  :                     uint8_t reg;
; 493  :                     CODE_POP(&state, uint8_t, reg);

	mov	rax, QWORD PTR state$[rsp]
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR reg$18[rsp], al
	mov	rax, QWORD PTR state$[rsp]
	inc	rax
	mov	QWORD PTR state$[rsp], rax
	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN100@main

; 494  :                     printf("%llu\n", state.registers[reg]);

	movzx	eax, BYTE PTR reg$18[rsp]
	mov	rdx, QWORD PTR state$[rsp+rax*8+8208]
	lea	rcx, OFFSET FLAT:$SG75218
	call	printf

; 495  :                 } break ;

	jmp	SHORT $LN7@main
$LN124@main:

; 496  :                 case INS_EXIT: {
; 497  :                     state.alive = false;

	mov	BYTE PTR state$[rsp+10256], 0

; 498  :                 } break ;

	jmp	SHORT $LN7@main
$LN125@main:

; 499  :                 default: assert(false);

	xor	eax, eax
	test	eax, eax
	jne	SHORT $LN128@main
	mov	r8d, 499				; 000001f3H
	lea	rdx, OFFSET FLAT:$SG75221
	lea	rcx, OFFSET FLAT:$SG75222
	call	_wassert
	xor	eax, eax
$LN128@main:
$LN7@main:

; 500  :             }
; 501  :         }