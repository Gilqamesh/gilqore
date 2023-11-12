What does this code do? The function has array of 64 32-bit integers, I removed it in each assembly code snippet to save space. The array is:
Answer: returns the index of the first 1-bit from the left in a 32-bit integer
int f(int a)

int v[64]= { -1,31, 8,30, -1, 7,-1,-1, 29,-1,26, 6, -1,-1, 2,-1,
             -1,28,-1,-1, -1,19,25,-1, 5, -1,17,-1, 23,14, 1,-1,
              9,-1,-1,-1, 27,-1, 3,-1, -1,-1,20,-1, 18,24,15,10,
             -1,-1, 4,-1, 21,-1,16,11, -1,22,-1,12, 13,-1, 0,-1
};
The algorithm is well-known, but I've changed constant so it wouldn't be googleable.

Optimizing GCC 4.8.2:
f: ; int fn(int a)
	mov	edx, edi    ; int b = a; edx: b, edi: a
	shr	edx         ; b >>= 1;
	or	edx, edi    ; b |= a;
	mov	eax, edx    ; int c = b; eax: c
	shr	eax, 2      ; c >>= 2;
	or	eax, edx    ; c |= b;
	mov	edx, eax    ; b = c;
	shr	edx, 4      ; b >>= 4;
	or	edx, eax    ; b |= c;
	mov	eax, edx    ; c = b;
	shr	eax, 8      ; c >>= 8;
	or	eax, edx    ; c |= b;
	mov	edx, eax    ; b = c;
	shr	edx, 16     ; b >>= 16;
	or	edx, eax    ; b |= c;
	imul	eax, edx, 79355661 ; 0x4badf0d  ; c = b * 0x4badf0d;
	shr	eax, 26     ; c >>= 26;
	mov	eax, DWORD PTR v[0+rax*4]           ; return v[c];
	ret

    // a = (a >> 1)  | a;
    // a = (a >> 2)  | a;
    // a = (a >> 4)  | a;
    // a = (a >> 8)  | a;
    // a = (a >> 16) | a;
    // v[(a * 0x4badf0d) >> 26];
