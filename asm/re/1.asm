What does this code do? The function has 4 arguments and it is compiled by GCC for Linux x64 ABI (i.e., arguments are passed in registers).
Solution: Divides each 64-bit element in the array, store the result in another array, returns 0 at the end.
    Function prototype: int f(uint64_t* in, uint64_t* out, u64 divisor, u64 array_size);

<f>:
   0:                   mov    r8,rdi  ; 1st param in r8
   3:                   push   rbx     ; save rbx, irrelevant
   4:                   mov    rdi,rsi ; 2nd param in rdi
   7:                   mov    rbx,rdx ; 3rd param in rbx
   a:                   mov    rsi,r8  ; 1st param in rsi
   d:                   xor    rdx,rdx ; rdx 0

/*
    r8  - 1st param
    rsi - 1st param
    rdi - 2nd param
    rbx - 3rd param
    rcx - 4th param
    rdx - 0
*/

begin:
  10:                   lods   rax,QWORD PTR ds:[rsi]   ; load 8 byte of the content at the address stored in rsi into rax, advance rsi by 8 byte
  12:                   div    rbx                      ; do an unsigned divide, rax /= rbx
  15:                   stos   QWORD PTR es:[rdi],rax   ; store 8 byte of rax into the address of rdi
  17:                   loop   begin                    ; decrement rcx and compare with 0, if not 0, go to begin
  19:                   pop    rbx                      ; restore rbx
  1a:                   mov    rax,rdx                  ; return whatever is in rdx
  1d:                   ret
