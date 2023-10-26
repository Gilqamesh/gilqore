	.text
	.def	@feat.00;
	.scl	3;
	.type	0;
	.endef
	.globl	@feat.00
.set @feat.00, 0
	.file	"ispcmodule.ispc"
	.def	ispc__get_version___vy_3C_uni_3E_vy_3C_uni_3E_;
	.scl	2;
	.type	32;
	.endef
	.globl	__real@00000001                 # -- Begin function ispc__get_version___vy_3C_uni_3E_vy_3C_uni_3E_
	.section	.rdata,"dr",discard,__real@00000001
	.p2align	2
__real@00000001:
	.long	1                               # 0x1
	.globl	__real@00000015
	.section	.rdata,"dr",discard,__real@00000015
	.p2align	2
__real@00000015:
	.long	21                              # 0x15
	.text
	.globl	ispc__get_version___vy_3C_uni_3E_vy_3C_uni_3E_
	.p2align	4, 0x90
ispc__get_version___vy_3C_uni_3E_vy_3C_uni_3E_: # @ispc__get_version___vy_3C_uni_3E_vy_3C_uni_3E_
# %bb.0:
	vmovdqa64	(%r9), %zmm0
	vmovdqa64	(%r8), %zmm1
	vmovdqa64	(%rdx), %zmm2
	vmovdqa64	(%rcx), %zmm3
	movq	40(%rsp), %rax
	vpsllw	$7, (%rax), %xmm4
	vpmovb2m	%xmm4, %k1
	kshiftrw	$8, %k1, %k2
	vpbroadcastd	__real@00000001(%rip), %ymm4 # ymm4 = [1,1,1,1,1,1,1,1]
	kmovq	%k1, %k3
	vpscatterqd	%ymm4, (,%zmm3) {%k3}
	kmovq	%k2, %k3
	vpscatterqd	%ymm4, (,%zmm2) {%k3}
	vpbroadcastd	__real@00000015(%rip), %ymm2 # ymm2 = [21,21,21,21,21,21,21,21]
	vpscatterqd	%ymm2, (,%zmm1) {%k1}
	vpscatterqd	%ymm2, (,%zmm0) {%k2}
	vzeroupper
	retq
                                        # -- End function
	.section	.drectve,"yn"
	.ascii	" /FAILIFMISMATCH:\"_CRT_STDIO_ISO_WIDE_SPECIFIERS=0\""
