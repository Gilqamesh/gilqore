
a.exe:     file format pei-x86-64


Disassembly of section .text:

0000000140001000 <__mingw_invalidParameterHandler>:
   140001000:	c3                   	ret
   140001001:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   140001008:	00 00 00 00 
   14000100c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000140001010 <pre_c_init>:
   140001010:	48 83 ec 28          	sub    $0x28,%rsp
   140001014:	48 8b 05 b5 a8 00 00 	mov    0xa8b5(%rip),%rax        # 14000b8d0 <.refptr.__mingw_initltsdrot_force>
   14000101b:	31 c9                	xor    %ecx,%ecx
   14000101d:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   140001023:	48 8b 05 b6 a8 00 00 	mov    0xa8b6(%rip),%rax        # 14000b8e0 <.refptr.__mingw_initltsdyn_force>
   14000102a:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   140001030:	48 8b 05 b9 a8 00 00 	mov    0xa8b9(%rip),%rax        # 14000b8f0 <.refptr.__mingw_initltssuo_force>
   140001037:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   14000103d:	48 8b 05 1c a8 00 00 	mov    0xa81c(%rip),%rax        # 14000b860 <.refptr.__image_base__>
   140001044:	66 81 38 4d 5a       	cmpw   $0x5a4d,(%rax)
   140001049:	75 0f                	jne    14000105a <pre_c_init+0x4a>
   14000104b:	48 63 50 3c          	movslq 0x3c(%rax),%rdx
   14000104f:	48 01 d0             	add    %rdx,%rax
   140001052:	81 38 50 45 00 00    	cmpl   $0x4550,(%rax)
   140001058:	74 66                	je     1400010c0 <pre_c_init+0xb0>
   14000105a:	48 8b 05 5f a8 00 00 	mov    0xa85f(%rip),%rax        # 14000b8c0 <.refptr.__mingw_app_type>
   140001061:	89 0d a5 cf 00 00    	mov    %ecx,0xcfa5(%rip)        # 14000e00c <managedapp>
   140001067:	8b 00                	mov    (%rax),%eax
   140001069:	85 c0                	test   %eax,%eax
   14000106b:	74 43                	je     1400010b0 <pre_c_init+0xa0>
   14000106d:	b9 02 00 00 00       	mov    $0x2,%ecx
   140001072:	e8 a1 87 00 00       	call   140009818 <__set_app_type>
   140001077:	e8 34 81 00 00       	call   1400091b0 <__p__fmode>
   14000107c:	48 8b 15 1d a9 00 00 	mov    0xa91d(%rip),%rdx        # 14000b9a0 <.refptr._fmode>
   140001083:	8b 12                	mov    (%rdx),%edx
   140001085:	89 10                	mov    %edx,(%rax)
   140001087:	e8 34 81 00 00       	call   1400091c0 <__p__commode>
   14000108c:	48 8b 15 ed a8 00 00 	mov    0xa8ed(%rip),%rdx        # 14000b980 <.refptr._commode>
   140001093:	8b 12                	mov    (%rdx),%edx
   140001095:	89 10                	mov    %edx,(%rax)
   140001097:	e8 b4 22 00 00       	call   140003350 <_setargv>
   14000109c:	48 8b 05 6d a7 00 00 	mov    0xa76d(%rip),%rax        # 14000b810 <.refptr._MINGW_INSTALL_DEBUG_MATHERR>
   1400010a3:	83 38 01             	cmpl   $0x1,(%rax)
   1400010a6:	74 50                	je     1400010f8 <pre_c_init+0xe8>
   1400010a8:	31 c0                	xor    %eax,%eax
   1400010aa:	48 83 c4 28          	add    $0x28,%rsp
   1400010ae:	c3                   	ret
   1400010af:	90                   	nop
   1400010b0:	b9 01 00 00 00       	mov    $0x1,%ecx
   1400010b5:	e8 5e 87 00 00       	call   140009818 <__set_app_type>
   1400010ba:	eb bb                	jmp    140001077 <pre_c_init+0x67>
   1400010bc:	0f 1f 40 00          	nopl   0x0(%rax)
   1400010c0:	0f b7 50 18          	movzwl 0x18(%rax),%edx
   1400010c4:	66 81 fa 0b 01       	cmp    $0x10b,%dx
   1400010c9:	74 45                	je     140001110 <pre_c_init+0x100>
   1400010cb:	66 81 fa 0b 02       	cmp    $0x20b,%dx
   1400010d0:	75 88                	jne    14000105a <pre_c_init+0x4a>
   1400010d2:	83 b8 84 00 00 00 0e 	cmpl   $0xe,0x84(%rax)
   1400010d9:	0f 86 7b ff ff ff    	jbe    14000105a <pre_c_init+0x4a>
   1400010df:	8b 90 f8 00 00 00    	mov    0xf8(%rax),%edx
   1400010e5:	31 c9                	xor    %ecx,%ecx
   1400010e7:	85 d2                	test   %edx,%edx
   1400010e9:	0f 95 c1             	setne  %cl
   1400010ec:	e9 69 ff ff ff       	jmp    14000105a <pre_c_init+0x4a>
   1400010f1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   1400010f8:	48 8b 0d c1 a8 00 00 	mov    0xa8c1(%rip),%rcx        # 14000b9c0 <.refptr._matherr>
   1400010ff:	e8 bc 29 00 00       	call   140003ac0 <__mingw_setusermatherr>
   140001104:	31 c0                	xor    %eax,%eax
   140001106:	48 83 c4 28          	add    $0x28,%rsp
   14000110a:	c3                   	ret
   14000110b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140001110:	83 78 74 0e          	cmpl   $0xe,0x74(%rax)
   140001114:	0f 86 40 ff ff ff    	jbe    14000105a <pre_c_init+0x4a>
   14000111a:	44 8b 80 e8 00 00 00 	mov    0xe8(%rax),%r8d
   140001121:	31 c9                	xor    %ecx,%ecx
   140001123:	45 85 c0             	test   %r8d,%r8d
   140001126:	0f 95 c1             	setne  %cl
   140001129:	e9 2c ff ff ff       	jmp    14000105a <pre_c_init+0x4a>
   14000112e:	66 90                	xchg   %ax,%ax

0000000140001130 <pre_cpp_init>:
   140001130:	48 83 ec 38          	sub    $0x38,%rsp
   140001134:	48 8b 05 95 a8 00 00 	mov    0xa895(%rip),%rax        # 14000b9d0 <.refptr._newmode>
   14000113b:	4c 8d 05 d6 ce 00 00 	lea    0xced6(%rip),%r8        # 14000e018 <envp>
   140001142:	48 8d 15 d7 ce 00 00 	lea    0xced7(%rip),%rdx        # 14000e020 <argv>
   140001149:	48 8d 0d d8 ce 00 00 	lea    0xced8(%rip),%rcx        # 14000e028 <argc>
   140001150:	8b 00                	mov    (%rax),%eax
   140001152:	89 05 ac ce 00 00    	mov    %eax,0xceac(%rip)        # 14000e004 <startinfo>
   140001158:	48 8b 05 31 a8 00 00 	mov    0xa831(%rip),%rax        # 14000b990 <.refptr._dowildcard>
   14000115f:	44 8b 08             	mov    (%rax),%r9d
   140001162:	48 8d 05 9b ce 00 00 	lea    0xce9b(%rip),%rax        # 14000e004 <startinfo>
   140001169:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   14000116e:	e8 95 86 00 00       	call   140009808 <__getmainargs>
   140001173:	90                   	nop
   140001174:	48 83 c4 38          	add    $0x38,%rsp
   140001178:	c3                   	ret
   140001179:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000140001180 <__tmainCRTStartup>:
   140001180:	41 54                	push   %r12
   140001182:	55                   	push   %rbp
   140001183:	57                   	push   %rdi
   140001184:	56                   	push   %rsi
   140001185:	53                   	push   %rbx
   140001186:	48 83 ec 20          	sub    $0x20,%rsp
   14000118a:	48 8b 1d 7f a7 00 00 	mov    0xa77f(%rip),%rbx        # 14000b910 <.refptr.__native_startup_lock>
   140001191:	31 ff                	xor    %edi,%edi
   140001193:	65 48 8b 04 25 30 00 	mov    %gs:0x30,%rax
   14000119a:	00 00 
   14000119c:	48 8b 2d 71 e0 00 00 	mov    0xe071(%rip),%rbp        # 14000f214 <__imp_Sleep>
   1400011a3:	48 8b 70 08          	mov    0x8(%rax),%rsi
   1400011a7:	eb 17                	jmp    1400011c0 <__tmainCRTStartup+0x40>
   1400011a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   1400011b0:	48 39 c6             	cmp    %rax,%rsi
   1400011b3:	0f 84 67 01 00 00    	je     140001320 <__tmainCRTStartup+0x1a0>
   1400011b9:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
   1400011be:	ff d5                	call   *%rbp
   1400011c0:	48 89 f8             	mov    %rdi,%rax
   1400011c3:	f0 48 0f b1 33       	lock cmpxchg %rsi,(%rbx)
   1400011c8:	48 85 c0             	test   %rax,%rax
   1400011cb:	75 e3                	jne    1400011b0 <__tmainCRTStartup+0x30>
   1400011cd:	48 8b 35 4c a7 00 00 	mov    0xa74c(%rip),%rsi        # 14000b920 <.refptr.__native_startup_state>
   1400011d4:	31 ff                	xor    %edi,%edi
   1400011d6:	8b 06                	mov    (%rsi),%eax
   1400011d8:	83 f8 01             	cmp    $0x1,%eax
   1400011db:	0f 84 56 01 00 00    	je     140001337 <__tmainCRTStartup+0x1b7>
   1400011e1:	8b 06                	mov    (%rsi),%eax
   1400011e3:	85 c0                	test   %eax,%eax
   1400011e5:	0f 84 b5 01 00 00    	je     1400013a0 <__tmainCRTStartup+0x220>
   1400011eb:	c7 05 13 ce 00 00 01 	movl   $0x1,0xce13(%rip)        # 14000e008 <has_cctor>
   1400011f2:	00 00 00 
   1400011f5:	8b 06                	mov    (%rsi),%eax
   1400011f7:	83 f8 01             	cmp    $0x1,%eax
   1400011fa:	0f 84 4c 01 00 00    	je     14000134c <__tmainCRTStartup+0x1cc>
   140001200:	85 ff                	test   %edi,%edi
   140001202:	0f 84 65 01 00 00    	je     14000136d <__tmainCRTStartup+0x1ed>
   140001208:	48 8b 05 41 a6 00 00 	mov    0xa641(%rip),%rax        # 14000b850 <.refptr.__dyn_tls_init_callback>
   14000120f:	48 8b 00             	mov    (%rax),%rax
   140001212:	48 85 c0             	test   %rax,%rax
   140001215:	74 0c                	je     140001223 <__tmainCRTStartup+0xa3>
   140001217:	45 31 c0             	xor    %r8d,%r8d
   14000121a:	ba 02 00 00 00       	mov    $0x2,%edx
   14000121f:	31 c9                	xor    %ecx,%ecx
   140001221:	ff d0                	call   *%rax
   140001223:	e8 f8 24 00 00       	call   140003720 <_pei386_runtime_relocator>
   140001228:	48 8b 0d 81 a7 00 00 	mov    0xa781(%rip),%rcx        # 14000b9b0 <.refptr._gnu_exception_handler>
   14000122f:	ff 15 d7 df 00 00    	call   *0xdfd7(%rip)        # 14000f20c <__imp_SetUnhandledExceptionFilter>
   140001235:	48 8b 15 c4 a6 00 00 	mov    0xa6c4(%rip),%rdx        # 14000b900 <.refptr.__mingw_oldexcpt_handler>
   14000123c:	48 8d 0d bd fd ff ff 	lea    -0x243(%rip),%rcx        # 140001000 <__mingw_invalidParameterHandler>
   140001243:	48 89 02             	mov    %rax,(%rdx)
   140001246:	e8 65 80 00 00       	call   1400092b0 <_set_invalid_parameter_handler>
   14000124b:	e8 e0 22 00 00       	call   140003530 <_fpreset>
   140001250:	8b 1d d2 cd 00 00    	mov    0xcdd2(%rip),%ebx        # 14000e028 <argc>
   140001256:	8d 7b 01             	lea    0x1(%rbx),%edi
   140001259:	48 63 ff             	movslq %edi,%rdi
   14000125c:	48 c1 e7 03          	shl    $0x3,%rdi
   140001260:	48 89 f9             	mov    %rdi,%rcx
   140001263:	e8 38 86 00 00       	call   1400098a0 <malloc>
   140001268:	85 db                	test   %ebx,%ebx
   14000126a:	48 8b 2d af cd 00 00 	mov    0xcdaf(%rip),%rbp        # 14000e020 <argv>
   140001271:	49 89 c4             	mov    %rax,%r12
   140001274:	0f 8e 46 01 00 00    	jle    1400013c0 <__tmainCRTStartup+0x240>
   14000127a:	48 83 ef 08          	sub    $0x8,%rdi
   14000127e:	31 db                	xor    %ebx,%ebx
   140001280:	48 8b 4c 1d 00       	mov    0x0(%rbp,%rbx,1),%rcx
   140001285:	e8 3e 86 00 00       	call   1400098c8 <strlen>
   14000128a:	48 8d 70 01          	lea    0x1(%rax),%rsi
   14000128e:	48 89 f1             	mov    %rsi,%rcx
   140001291:	e8 0a 86 00 00       	call   1400098a0 <malloc>
   140001296:	49 89 f0             	mov    %rsi,%r8
   140001299:	49 89 04 1c          	mov    %rax,(%r12,%rbx,1)
   14000129d:	48 8b 54 1d 00       	mov    0x0(%rbp,%rbx,1),%rdx
   1400012a2:	48 89 c1             	mov    %rax,%rcx
   1400012a5:	48 83 c3 08          	add    $0x8,%rbx
   1400012a9:	e8 fa 85 00 00       	call   1400098a8 <memcpy>
   1400012ae:	48 39 df             	cmp    %rbx,%rdi
   1400012b1:	75 cd                	jne    140001280 <__tmainCRTStartup+0x100>
   1400012b3:	4c 01 e7             	add    %r12,%rdi
   1400012b6:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
   1400012bd:	4c 89 25 5c cd 00 00 	mov    %r12,0xcd5c(%rip)        # 14000e020 <argv>
   1400012c4:	e8 67 20 00 00       	call   140003330 <__main>
   1400012c9:	48 8b 05 a0 a5 00 00 	mov    0xa5a0(%rip),%rax        # 14000b870 <.refptr.__imp___initenv>
   1400012d0:	4c 8b 05 41 cd 00 00 	mov    0xcd41(%rip),%r8        # 14000e018 <envp>
   1400012d7:	8b 0d 4b cd 00 00    	mov    0xcd4b(%rip),%ecx        # 14000e028 <argc>
   1400012dd:	48 8b 00             	mov    (%rax),%rax
   1400012e0:	4c 89 00             	mov    %r8,(%rax)
   1400012e3:	48 8b 15 36 cd 00 00 	mov    0xcd36(%rip),%rdx        # 14000e020 <argv>
   1400012ea:	e8 96 0e 00 00       	call   140002185 <main>
   1400012ef:	8b 0d 17 cd 00 00    	mov    0xcd17(%rip),%ecx        # 14000e00c <managedapp>
   1400012f5:	89 05 15 cd 00 00    	mov    %eax,0xcd15(%rip)        # 14000e010 <mainret>
   1400012fb:	85 c9                	test   %ecx,%ecx
   1400012fd:	0f 84 c5 00 00 00    	je     1400013c8 <__tmainCRTStartup+0x248>
   140001303:	8b 15 ff cc 00 00    	mov    0xccff(%rip),%edx        # 14000e008 <has_cctor>
   140001309:	85 d2                	test   %edx,%edx
   14000130b:	74 73                	je     140001380 <__tmainCRTStartup+0x200>
   14000130d:	48 83 c4 20          	add    $0x20,%rsp
   140001311:	5b                   	pop    %rbx
   140001312:	5e                   	pop    %rsi
   140001313:	5f                   	pop    %rdi
   140001314:	5d                   	pop    %rbp
   140001315:	41 5c                	pop    %r12
   140001317:	c3                   	ret
   140001318:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   14000131f:	00 
   140001320:	48 8b 35 f9 a5 00 00 	mov    0xa5f9(%rip),%rsi        # 14000b920 <.refptr.__native_startup_state>
   140001327:	bf 01 00 00 00       	mov    $0x1,%edi
   14000132c:	8b 06                	mov    (%rsi),%eax
   14000132e:	83 f8 01             	cmp    $0x1,%eax
   140001331:	0f 85 aa fe ff ff    	jne    1400011e1 <__tmainCRTStartup+0x61>
   140001337:	b9 1f 00 00 00       	mov    $0x1f,%ecx
   14000133c:	e8 e7 84 00 00       	call   140009828 <_amsg_exit>
   140001341:	8b 06                	mov    (%rsi),%eax
   140001343:	83 f8 01             	cmp    $0x1,%eax
   140001346:	0f 85 b4 fe ff ff    	jne    140001200 <__tmainCRTStartup+0x80>
   14000134c:	48 8b 15 fd a5 00 00 	mov    0xa5fd(%rip),%rdx        # 14000b950 <.refptr.__xc_z>
   140001353:	48 8b 0d e6 a5 00 00 	mov    0xa5e6(%rip),%rcx        # 14000b940 <.refptr.__xc_a>
   14000135a:	e8 e9 84 00 00       	call   140009848 <_initterm>
   14000135f:	85 ff                	test   %edi,%edi
   140001361:	c7 06 02 00 00 00    	movl   $0x2,(%rsi)
   140001367:	0f 85 9b fe ff ff    	jne    140001208 <__tmainCRTStartup+0x88>
   14000136d:	31 c0                	xor    %eax,%eax
   14000136f:	48 87 03             	xchg   %rax,(%rbx)
   140001372:	e9 91 fe ff ff       	jmp    140001208 <__tmainCRTStartup+0x88>
   140001377:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   14000137e:	00 00 
   140001380:	e8 b3 84 00 00       	call   140009838 <_cexit>
   140001385:	8b 05 85 cc 00 00    	mov    0xcc85(%rip),%eax        # 14000e010 <mainret>
   14000138b:	48 83 c4 20          	add    $0x20,%rsp
   14000138f:	5b                   	pop    %rbx
   140001390:	5e                   	pop    %rsi
   140001391:	5f                   	pop    %rdi
   140001392:	5d                   	pop    %rbp
   140001393:	41 5c                	pop    %r12
   140001395:	c3                   	ret
   140001396:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   14000139d:	00 00 00 
   1400013a0:	48 8b 15 c9 a5 00 00 	mov    0xa5c9(%rip),%rdx        # 14000b970 <.refptr.__xi_z>
   1400013a7:	c7 06 01 00 00 00    	movl   $0x1,(%rsi)
   1400013ad:	48 8b 0d ac a5 00 00 	mov    0xa5ac(%rip),%rcx        # 14000b960 <.refptr.__xi_a>
   1400013b4:	e8 8f 84 00 00       	call   140009848 <_initterm>
   1400013b9:	e9 37 fe ff ff       	jmp    1400011f5 <__tmainCRTStartup+0x75>
   1400013be:	66 90                	xchg   %ax,%ax
   1400013c0:	48 89 c7             	mov    %rax,%rdi
   1400013c3:	e9 ee fe ff ff       	jmp    1400012b6 <__tmainCRTStartup+0x136>
   1400013c8:	89 c1                	mov    %eax,%ecx
   1400013ca:	e8 11 2b 00 00       	call   140003ee0 <exit>
   1400013cf:	90                   	nop

00000001400013d0 <WinMainCRTStartup>:
   1400013d0:	48 83 ec 28          	sub    $0x28,%rsp

00000001400013d4 <.l_startw>:
   1400013d4:	48 8b 05 e5 a4 00 00 	mov    0xa4e5(%rip),%rax        # 14000b8c0 <.refptr.__mingw_app_type>
   1400013db:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   1400013e1:	e8 9a fd ff ff       	call   140001180 <__tmainCRTStartup>
   1400013e6:	90                   	nop

00000001400013e7 <.l_endw>:
   1400013e7:	90                   	nop
   1400013e8:	48 83 c4 28          	add    $0x28,%rsp
   1400013ec:	c3                   	ret
   1400013ed:	0f 1f 00             	nopl   (%rax)

00000001400013f0 <mainCRTStartup>:
   1400013f0:	48 83 ec 28          	sub    $0x28,%rsp

00000001400013f4 <.l_start>:
   1400013f4:	48 8b 05 c5 a4 00 00 	mov    0xa4c5(%rip),%rax        # 14000b8c0 <.refptr.__mingw_app_type>
   1400013fb:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   140001401:	e8 7a fd ff ff       	call   140001180 <__tmainCRTStartup>
   140001406:	90                   	nop

0000000140001407 <.l_end>:
   140001407:	90                   	nop
   140001408:	48 83 c4 28          	add    $0x28,%rsp
   14000140c:	c3                   	ret
   14000140d:	0f 1f 00             	nopl   (%rax)

0000000140001410 <atexit>:
   140001410:	48 83 ec 28          	sub    $0x28,%rsp
   140001414:	e8 3f 84 00 00       	call   140009858 <_onexit>
   140001419:	48 83 f8 01          	cmp    $0x1,%rax
   14000141d:	19 c0                	sbb    %eax,%eax
   14000141f:	48 83 c4 28          	add    $0x28,%rsp
   140001423:	c3                   	ret
   140001424:	90                   	nop
   140001425:	90                   	nop
   140001426:	90                   	nop
   140001427:	90                   	nop
   140001428:	90                   	nop
   140001429:	90                   	nop
   14000142a:	90                   	nop
   14000142b:	90                   	nop
   14000142c:	90                   	nop
   14000142d:	90                   	nop
   14000142e:	90                   	nop
   14000142f:	90                   	nop

0000000140001430 <__gcc_register_frame>:
   140001430:	48 8d 0d 09 00 00 00 	lea    0x9(%rip),%rcx        # 140001440 <__gcc_deregister_frame>
   140001437:	e9 d4 ff ff ff       	jmp    140001410 <atexit>
   14000143c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000140001440 <__gcc_deregister_frame>:
   140001440:	c3                   	ret
   140001441:	90                   	nop
   140001442:	90                   	nop
   140001443:	90                   	nop
   140001444:	90                   	nop
   140001445:	90                   	nop
   140001446:	90                   	nop
   140001447:	90                   	nop
   140001448:	90                   	nop
   140001449:	90                   	nop
   14000144a:	90                   	nop
   14000144b:	90                   	nop
   14000144c:	90                   	nop
   14000144d:	90                   	nop
   14000144e:	90                   	nop
   14000144f:	90                   	nop

0000000140001450 <printf>:
   140001450:	55                   	push   %rbp
   140001451:	53                   	push   %rbx
   140001452:	48 83 ec 38          	sub    $0x38,%rsp
   140001456:	48 8d 6c 24 30       	lea    0x30(%rsp),%rbp
   14000145b:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   14000145f:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   140001463:	4c 89 45 30          	mov    %r8,0x30(%rbp)
   140001467:	4c 89 4d 38          	mov    %r9,0x38(%rbp)
   14000146b:	48 8d 45 28          	lea    0x28(%rbp),%rax
   14000146f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140001473:	48 8b 5d f0          	mov    -0x10(%rbp),%rbx
   140001477:	b9 01 00 00 00       	mov    $0x1,%ecx
   14000147c:	48 8b 05 3d 8c 00 00 	mov    0x8c3d(%rip),%rax        # 14000a0c0 <__imp___acrt_iob_func>
   140001483:	ff d0                	call   *%rax
   140001485:	48 89 c1             	mov    %rax,%rcx
   140001488:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000148c:	49 89 d8             	mov    %rbx,%r8
   14000148f:	48 89 c2             	mov    %rax,%rdx
   140001492:	e8 a9 2e 00 00       	call   140004340 <__mingw_vfprintf>
   140001497:	89 45 fc             	mov    %eax,-0x4(%rbp)
   14000149a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   14000149d:	48 83 c4 38          	add    $0x38,%rsp
   1400014a1:	5b                   	pop    %rbx
   1400014a2:	5d                   	pop    %rbp
   1400014a3:	c3                   	ret

00000001400014a4 <state__patch_jmp>:
   1400014a4:	55                   	push   %rbp
   1400014a5:	48 89 e5             	mov    %rsp,%rbp
   1400014a8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400014ac:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400014b0:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   1400014b4:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400014b8:	48 83 c0 01          	add    $0x1,%rax
   1400014bc:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   1400014c0:	48 89 10             	mov    %rdx,(%rax)
   1400014c3:	90                   	nop
   1400014c4:	5d                   	pop    %rbp
   1400014c5:	c3                   	ret

00000001400014c6 <state__add_ins>:
   1400014c6:	55                   	push   %rbp
   1400014c7:	48 89 e5             	mov    %rsp,%rbp
   1400014ca:	48 81 ec a0 00 00 00 	sub    $0xa0,%rsp
   1400014d1:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400014d5:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400014d9:	44 89 45 20          	mov    %r8d,0x20(%rbp)
   1400014dd:	4c 89 4d 28          	mov    %r9,0x28(%rbp)
   1400014e1:	48 8d 45 28          	lea    0x28(%rbp),%rax
   1400014e5:	48 89 45 88          	mov    %rax,-0x78(%rbp)
   1400014e9:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400014ed:	48 8d 50 01          	lea    0x1(%rax),%rdx
   1400014f1:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400014f5:	8b 55 20             	mov    0x20(%rbp),%edx
   1400014f8:	88 10                	mov    %dl,(%rax)
   1400014fa:	83 7d 20 1f          	cmpl   $0x1f,0x20(%rbp)
   1400014fe:	0f 87 88 04 00 00    	ja     14000198c <state__add_ins+0x4c6>
   140001504:	8b 45 20             	mov    0x20(%rbp),%eax
   140001507:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   14000150e:	00 
   14000150f:	48 8d 05 f6 9a 00 00 	lea    0x9af6(%rip),%rax        # 14000b00c <.rdata+0xc>
   140001516:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   140001519:	48 98                	cltq
   14000151b:	48 8d 15 ea 9a 00 00 	lea    0x9aea(%rip),%rdx        # 14000b00c <.rdata+0xc>
   140001522:	48 01 d0             	add    %rdx,%rax
   140001525:	ff e0                	jmp    *%rax
   140001527:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   14000152b:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000152f:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   140001533:	8b 00                	mov    (%rax),%eax
   140001535:	88 45 97             	mov    %al,-0x69(%rbp)
   140001538:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   14000153c:	0f b6 45 97          	movzbl -0x69(%rbp),%eax
   140001540:	88 02                	mov    %al,(%rdx)
   140001542:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   140001547:	e9 64 04 00 00       	jmp    1400019b0 <state__add_ins+0x4ea>
   14000154c:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   140001550:	48 8d 50 08          	lea    0x8(%rax),%rdx
   140001554:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   140001558:	8b 00                	mov    (%rax),%eax
   14000155a:	88 45 9a             	mov    %al,-0x66(%rbp)
   14000155d:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   140001561:	48 8d 50 08          	lea    0x8(%rax),%rdx
   140001565:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   140001569:	8b 00                	mov    (%rax),%eax
   14000156b:	88 45 99             	mov    %al,-0x67(%rbp)
   14000156e:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   140001572:	48 8d 50 08          	lea    0x8(%rax),%rdx
   140001576:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   14000157a:	8b 00                	mov    (%rax),%eax
   14000157c:	88 45 98             	mov    %al,-0x68(%rbp)
   14000157f:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140001583:	0f b6 45 9a          	movzbl -0x66(%rbp),%eax
   140001587:	88 02                	mov    %al,(%rdx)
   140001589:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   14000158e:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140001592:	0f b6 45 99          	movzbl -0x67(%rbp),%eax
   140001596:	88 02                	mov    %al,(%rdx)
   140001598:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   14000159d:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   1400015a1:	0f b6 45 98          	movzbl -0x68(%rbp),%eax
   1400015a5:	88 02                	mov    %al,(%rdx)
   1400015a7:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   1400015ac:	e9 ff 03 00 00       	jmp    1400019b0 <state__add_ins+0x4ea>
   1400015b1:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   1400015b5:	48 8d 50 08          	lea    0x8(%rax),%rdx
   1400015b9:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   1400015bd:	8b 00                	mov    (%rax),%eax
   1400015bf:	88 45 9c             	mov    %al,-0x64(%rbp)
   1400015c2:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   1400015c6:	48 8d 50 08          	lea    0x8(%rax),%rdx
   1400015ca:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   1400015ce:	8b 00                	mov    (%rax),%eax
   1400015d0:	88 45 9b             	mov    %al,-0x65(%rbp)
   1400015d3:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   1400015d7:	0f b6 45 9c          	movzbl -0x64(%rbp),%eax
   1400015db:	88 02                	mov    %al,(%rdx)
   1400015dd:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   1400015e2:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   1400015e6:	0f b6 45 9b          	movzbl -0x65(%rbp),%eax
   1400015ea:	88 02                	mov    %al,(%rdx)
   1400015ec:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   1400015f1:	e9 ba 03 00 00       	jmp    1400019b0 <state__add_ins+0x4ea>
   1400015f6:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   1400015fa:	48 8d 50 08          	lea    0x8(%rax),%rdx
   1400015fe:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   140001602:	8b 00                	mov    (%rax),%eax
   140001604:	88 45 9f             	mov    %al,-0x61(%rbp)
   140001607:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   14000160b:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000160f:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   140001613:	8b 00                	mov    (%rax),%eax
   140001615:	88 45 9e             	mov    %al,-0x62(%rbp)
   140001618:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   14000161c:	48 8d 50 08          	lea    0x8(%rax),%rdx
   140001620:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   140001624:	8b 00                	mov    (%rax),%eax
   140001626:	88 45 9d             	mov    %al,-0x63(%rbp)
   140001629:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   14000162d:	0f b6 45 9f          	movzbl -0x61(%rbp),%eax
   140001631:	88 02                	mov    %al,(%rdx)
   140001633:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   140001638:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   14000163c:	0f b6 45 9e          	movzbl -0x62(%rbp),%eax
   140001640:	88 02                	mov    %al,(%rdx)
   140001642:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   140001647:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   14000164b:	0f b6 45 9d          	movzbl -0x63(%rbp),%eax
   14000164f:	88 02                	mov    %al,(%rdx)
   140001651:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   140001656:	e9 55 03 00 00       	jmp    1400019b0 <state__add_ins+0x4ea>
   14000165b:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   14000165f:	48 8d 50 08          	lea    0x8(%rax),%rdx
   140001663:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   140001667:	48 8b 00             	mov    (%rax),%rax
   14000166a:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   14000166e:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   140001672:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140001676:	48 89 10             	mov    %rdx,(%rax)
   140001679:	48 83 45 18 08       	addq   $0x8,0x18(%rbp)
   14000167e:	e9 2d 03 00 00       	jmp    1400019b0 <state__add_ins+0x4ea>
   140001683:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   140001687:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000168b:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   14000168f:	48 8b 00             	mov    (%rax),%rax
   140001692:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
   140001696:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   14000169a:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000169e:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   1400016a2:	8b 00                	mov    (%rax),%eax
   1400016a4:	88 45 af             	mov    %al,-0x51(%rbp)
   1400016a7:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   1400016ab:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400016af:	48 89 10             	mov    %rdx,(%rax)
   1400016b2:	48 83 45 18 08       	addq   $0x8,0x18(%rbp)
   1400016b7:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   1400016bb:	0f b6 45 af          	movzbl -0x51(%rbp),%eax
   1400016bf:	88 02                	mov    %al,(%rdx)
   1400016c1:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   1400016c6:	e9 e5 02 00 00       	jmp    1400019b0 <state__add_ins+0x4ea>
   1400016cb:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   1400016cf:	48 8d 50 08          	lea    0x8(%rax),%rdx
   1400016d3:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   1400016d7:	48 8b 00             	mov    (%rax),%rax
   1400016da:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   1400016de:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   1400016e2:	48 8d 50 08          	lea    0x8(%rax),%rdx
   1400016e6:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   1400016ea:	8b 00                	mov    (%rax),%eax
   1400016ec:	88 45 bf             	mov    %al,-0x41(%rbp)
   1400016ef:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   1400016f3:	48 8d 50 08          	lea    0x8(%rax),%rdx
   1400016f7:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   1400016fb:	8b 00                	mov    (%rax),%eax
   1400016fd:	88 45 be             	mov    %al,-0x42(%rbp)
   140001700:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   140001704:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140001708:	48 89 10             	mov    %rdx,(%rax)
   14000170b:	48 83 45 18 08       	addq   $0x8,0x18(%rbp)
   140001710:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140001714:	0f b6 45 bf          	movzbl -0x41(%rbp),%eax
   140001718:	88 02                	mov    %al,(%rdx)
   14000171a:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   14000171f:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140001723:	0f b6 45 be          	movzbl -0x42(%rbp),%eax
   140001727:	88 02                	mov    %al,(%rdx)
   140001729:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   14000172e:	e9 7d 02 00 00       	jmp    1400019b0 <state__add_ins+0x4ea>
   140001733:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   140001737:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000173b:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   14000173f:	8b 00                	mov    (%rax),%eax
   140001741:	88 45 cd             	mov    %al,-0x33(%rbp)
   140001744:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   140001748:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000174c:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   140001750:	8b 00                	mov    (%rax),%eax
   140001752:	88 45 cc             	mov    %al,-0x34(%rbp)
   140001755:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140001759:	0f b6 45 cd          	movzbl -0x33(%rbp),%eax
   14000175d:	88 02                	mov    %al,(%rdx)
   14000175f:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   140001764:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140001768:	0f b6 45 cc          	movzbl -0x34(%rbp),%eax
   14000176c:	88 02                	mov    %al,(%rdx)
   14000176e:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   140001773:	e9 38 02 00 00       	jmp    1400019b0 <state__add_ins+0x4ea>
   140001778:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   14000177c:	48 8d 50 08          	lea    0x8(%rax),%rdx
   140001780:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   140001784:	8b 00                	mov    (%rax),%eax
   140001786:	88 45 cf             	mov    %al,-0x31(%rbp)
   140001789:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   14000178d:	48 8d 50 08          	lea    0x8(%rax),%rdx
   140001791:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   140001795:	8b 00                	mov    (%rax),%eax
   140001797:	88 45 ce             	mov    %al,-0x32(%rbp)
   14000179a:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   14000179e:	0f b6 45 cf          	movzbl -0x31(%rbp),%eax
   1400017a2:	88 02                	mov    %al,(%rdx)
   1400017a4:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   1400017a9:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   1400017ad:	0f b6 45 ce          	movzbl -0x32(%rbp),%eax
   1400017b1:	88 02                	mov    %al,(%rdx)
   1400017b3:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   1400017b8:	e9 f3 01 00 00       	jmp    1400019b0 <state__add_ins+0x4ea>
   1400017bd:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   1400017c1:	48 8d 50 08          	lea    0x8(%rax),%rdx
   1400017c5:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   1400017c9:	8b 00                	mov    (%rax),%eax
   1400017cb:	89 45 dc             	mov    %eax,-0x24(%rbp)
   1400017ce:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   1400017d2:	48 8d 50 08          	lea    0x8(%rax),%rdx
   1400017d6:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   1400017da:	48 8b 00             	mov    (%rax),%rax
   1400017dd:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   1400017e1:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400017e5:	8b 55 dc             	mov    -0x24(%rbp),%edx
   1400017e8:	89 10                	mov    %edx,(%rax)
   1400017ea:	48 83 45 18 04       	addq   $0x4,0x18(%rbp)
   1400017ef:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400017f3:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   1400017f7:	48 89 10             	mov    %rdx,(%rax)
   1400017fa:	48 83 45 18 08       	addq   $0x8,0x18(%rbp)
   1400017ff:	e9 ac 01 00 00       	jmp    1400019b0 <state__add_ins+0x4ea>
   140001804:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   140001808:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000180c:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   140001810:	8b 00                	mov    (%rax),%eax
   140001812:	88 45 e1             	mov    %al,-0x1f(%rbp)
   140001815:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140001819:	0f b6 45 e1          	movzbl -0x1f(%rbp),%eax
   14000181d:	88 02                	mov    %al,(%rdx)
   14000181f:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   140001824:	e9 87 01 00 00       	jmp    1400019b0 <state__add_ins+0x4ea>
   140001829:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   14000182d:	48 8d 50 08          	lea    0x8(%rax),%rdx
   140001831:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   140001835:	8b 00                	mov    (%rax),%eax
   140001837:	88 45 e2             	mov    %al,-0x1e(%rbp)
   14000183a:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   14000183e:	0f b6 45 e2          	movzbl -0x1e(%rbp),%eax
   140001842:	88 02                	mov    %al,(%rdx)
   140001844:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   140001849:	e9 62 01 00 00       	jmp    1400019b0 <state__add_ins+0x4ea>
   14000184e:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   140001852:	48 8d 50 08          	lea    0x8(%rax),%rdx
   140001856:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   14000185a:	8b 00                	mov    (%rax),%eax
   14000185c:	88 45 e4             	mov    %al,-0x1c(%rbp)
   14000185f:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   140001863:	48 8d 50 08          	lea    0x8(%rax),%rdx
   140001867:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   14000186b:	8b 00                	mov    (%rax),%eax
   14000186d:	88 45 e3             	mov    %al,-0x1d(%rbp)
   140001870:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140001874:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   140001878:	88 02                	mov    %al,(%rdx)
   14000187a:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   14000187f:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140001883:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   140001887:	88 02                	mov    %al,(%rdx)
   140001889:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   14000188e:	e9 1d 01 00 00       	jmp    1400019b0 <state__add_ins+0x4ea>
   140001893:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   140001897:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000189b:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   14000189f:	8b 00                	mov    (%rax),%eax
   1400018a1:	88 45 e7             	mov    %al,-0x19(%rbp)
   1400018a4:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   1400018a8:	48 8d 50 08          	lea    0x8(%rax),%rdx
   1400018ac:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   1400018b0:	8b 00                	mov    (%rax),%eax
   1400018b2:	88 45 e6             	mov    %al,-0x1a(%rbp)
   1400018b5:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   1400018b9:	48 8d 50 08          	lea    0x8(%rax),%rdx
   1400018bd:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   1400018c1:	8b 00                	mov    (%rax),%eax
   1400018c3:	88 45 e5             	mov    %al,-0x1b(%rbp)
   1400018c6:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   1400018ca:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   1400018ce:	88 02                	mov    %al,(%rdx)
   1400018d0:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   1400018d5:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   1400018d9:	0f b6 45 e6          	movzbl -0x1a(%rbp),%eax
   1400018dd:	88 02                	mov    %al,(%rdx)
   1400018df:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   1400018e4:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   1400018e8:	0f b6 45 e5          	movzbl -0x1b(%rbp),%eax
   1400018ec:	88 02                	mov    %al,(%rdx)
   1400018ee:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   1400018f3:	e9 b8 00 00 00       	jmp    1400019b0 <state__add_ins+0x4ea>
   1400018f8:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   1400018fc:	48 8d 50 08          	lea    0x8(%rax),%rdx
   140001900:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   140001904:	48 8b 00             	mov    (%rax),%rax
   140001907:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000190b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   14000190f:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140001913:	48 89 10             	mov    %rdx,(%rax)
   140001916:	48 83 45 18 08       	addq   $0x8,0x18(%rbp)
   14000191b:	e9 90 00 00 00       	jmp    1400019b0 <state__add_ins+0x4ea>
   140001920:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   140001924:	48 8d 50 08          	lea    0x8(%rax),%rdx
   140001928:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   14000192c:	8b 00                	mov    (%rax),%eax
   14000192e:	66 89 45 f4          	mov    %ax,-0xc(%rbp)
   140001932:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140001936:	0f b7 55 f4          	movzwl -0xc(%rbp),%edx
   14000193a:	66 89 10             	mov    %dx,(%rax)
   14000193d:	48 83 45 18 02       	addq   $0x2,0x18(%rbp)
   140001942:	eb 6c                	jmp    1400019b0 <state__add_ins+0x4ea>
   140001944:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   140001948:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000194c:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   140001950:	8b 00                	mov    (%rax),%eax
   140001952:	88 45 f7             	mov    %al,-0x9(%rbp)
   140001955:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140001959:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   14000195d:	88 02                	mov    %al,(%rdx)
   14000195f:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   140001964:	eb 4a                	jmp    1400019b0 <state__add_ins+0x4ea>
   140001966:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   14000196a:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000196e:	48 89 55 88          	mov    %rdx,-0x78(%rbp)
   140001972:	8b 00                	mov    (%rax),%eax
   140001974:	89 c0                	mov    %eax,%eax
   140001976:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000197a:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000197e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001982:	48 89 10             	mov    %rdx,(%rax)
   140001985:	48 83 45 18 08       	addq   $0x8,0x18(%rbp)
   14000198a:	eb 24                	jmp    1400019b0 <state__add_ins+0x4ea>
   14000198c:	41 b8 0c 01 00 00    	mov    $0x10c,%r8d
   140001992:	48 8d 05 67 96 00 00 	lea    0x9667(%rip),%rax        # 14000b000 <.rdata>
   140001999:	48 89 c2             	mov    %rax,%rdx
   14000199c:	48 8d 05 62 96 00 00 	lea    0x9662(%rip),%rax        # 14000b005 <.rdata+0x5>
   1400019a3:	48 89 c1             	mov    %rax,%rcx
   1400019a6:	48 8b 05 df d8 00 00 	mov    0xd8df(%rip),%rax        # 14000f28c <__imp__assert>
   1400019ad:	ff d0                	call   *%rax
   1400019af:	90                   	nop
   1400019b0:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400019b4:	48 81 c4 a0 00 00 00 	add    $0xa0,%rsp
   1400019bb:	5d                   	pop    %rbp
   1400019bc:	c3                   	ret

00000001400019bd <fn_def__fact>:
   1400019bd:	55                   	push   %rbp
   1400019be:	48 89 e5             	mov    %rsp,%rbp
   1400019c1:	48 83 ec 50          	sub    $0x50,%rsp
   1400019c5:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400019c9:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400019cd:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   1400019d1:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400019d5:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   1400019dc:	00 00 
   1400019de:	41 b9 08 00 00 00    	mov    $0x8,%r9d
   1400019e4:	41 b8 15 00 00 00    	mov    $0x15,%r8d
   1400019ea:	48 89 c1             	mov    %rax,%rcx
   1400019ed:	e8 d4 fa ff ff       	call   1400014c6 <state__add_ins>
   1400019f2:	48 89 45 18          	mov    %rax,0x18(%rbp)
   1400019f6:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   1400019fa:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400019fe:	c7 44 24 20 00 00 00 	movl   $0x0,0x20(%rsp)
   140001a05:	00 
   140001a06:	41 b9 01 00 00 00    	mov    $0x1,%r9d
   140001a0c:	41 b8 14 00 00 00    	mov    $0x14,%r8d
   140001a12:	48 89 c1             	mov    %rax,%rcx
   140001a15:	e8 ac fa ff ff       	call   1400014c6 <state__add_ins>
   140001a1a:	48 89 45 18          	mov    %rax,0x18(%rbp)
   140001a1e:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140001a22:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001a26:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140001a2a:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001a2e:	c7 44 24 20 01 00 00 	movl   $0x1,0x20(%rsp)
   140001a35:	00 
   140001a36:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140001a3c:	41 b8 0d 00 00 00    	mov    $0xd,%r8d
   140001a42:	48 89 c1             	mov    %rax,%rcx
   140001a45:	e8 7c fa ff ff       	call   1400014c6 <state__add_ins>
   140001a4a:	48 89 45 18          	mov    %rax,0x18(%rbp)
   140001a4e:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140001a52:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001a56:	41 b9 01 00 00 00    	mov    $0x1,%r9d
   140001a5c:	41 b8 17 00 00 00    	mov    $0x17,%r8d
   140001a62:	48 89 c1             	mov    %rax,%rcx
   140001a65:	e8 5c fa ff ff       	call   1400014c6 <state__add_ins>
   140001a6a:	48 89 45 18          	mov    %rax,0x18(%rbp)
   140001a6e:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140001a72:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001a76:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140001a7d:	00 00 
   140001a7f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140001a85:	41 b8 15 00 00 00    	mov    $0x15,%r8d
   140001a8b:	48 89 c1             	mov    %rax,%rcx
   140001a8e:	e8 33 fa ff ff       	call   1400014c6 <state__add_ins>
   140001a93:	48 89 45 18          	mov    %rax,0x18(%rbp)
   140001a97:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140001a9b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140001a9f:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140001aa3:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001aa7:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%rsp)
   140001aae:	00 
   140001aaf:	c7 44 24 20 08 00 00 	movl   $0x8,0x20(%rsp)
   140001ab6:	00 
   140001ab7:	41 b9 08 00 00 00    	mov    $0x8,%r9d
   140001abd:	41 b8 04 00 00 00    	mov    $0x4,%r8d
   140001ac3:	48 89 c1             	mov    %rax,%rcx
   140001ac6:	e8 fb f9 ff ff       	call   1400014c6 <state__add_ins>
   140001acb:	48 89 45 18          	mov    %rax,0x18(%rbp)
   140001acf:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140001ad3:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001ad7:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140001add:	41 b8 17 00 00 00    	mov    $0x17,%r8d
   140001ae3:	48 89 c1             	mov    %rax,%rcx
   140001ae6:	e8 db f9 ff ff       	call   1400014c6 <state__add_ins>
   140001aeb:	48 89 45 18          	mov    %rax,0x18(%rbp)
   140001aef:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140001af3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   140001af7:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140001afb:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001aff:	c7 44 24 28 01 00 00 	movl   $0x1,0x28(%rsp)
   140001b06:	00 
   140001b07:	c7 44 24 20 00 00 00 	movl   $0x0,0x20(%rsp)
   140001b0e:	00 
   140001b0f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140001b15:	41 b8 10 00 00 00    	mov    $0x10,%r8d
   140001b1b:	48 89 c1             	mov    %rax,%rcx
   140001b1e:	e8 a3 f9 ff ff       	call   1400014c6 <state__add_ins>
   140001b23:	48 89 45 18          	mov    %rax,0x18(%rbp)
   140001b27:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
   140001b2b:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140001b2f:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001b33:	49 89 c9             	mov    %rcx,%r9
   140001b36:	41 b8 0c 00 00 00    	mov    $0xc,%r8d
   140001b3c:	48 89 c1             	mov    %rax,%rcx
   140001b3f:	e8 82 f9 ff ff       	call   1400014c6 <state__add_ins>
   140001b44:	48 89 45 18          	mov    %rax,0x18(%rbp)
   140001b48:	48 8b 4d 18          	mov    0x18(%rbp),%rcx
   140001b4c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001b50:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001b54:	49 89 c8             	mov    %rcx,%r8
   140001b57:	48 89 c1             	mov    %rax,%rcx
   140001b5a:	e8 45 f9 ff ff       	call   1400014a4 <state__patch_jmp>
   140001b5f:	48 8b 4d 18          	mov    0x18(%rbp),%rcx
   140001b63:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   140001b67:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001b6b:	49 89 c8             	mov    %rcx,%r8
   140001b6e:	48 89 c1             	mov    %rax,%rcx
   140001b71:	e8 2e f9 ff ff       	call   1400014a4 <state__patch_jmp>
   140001b76:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140001b7a:	48 83 c4 50          	add    $0x50,%rsp
   140001b7e:	5d                   	pop    %rbp
   140001b7f:	c3                   	ret

0000000140001b80 <fact>:
   140001b80:	55                   	push   %rbp
   140001b81:	48 89 e5             	mov    %rsp,%rbp
   140001b84:	48 83 ec 10          	sub    $0x10,%rsp
   140001b88:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140001b8c:	48 c7 45 f8 01 00 00 	movq   $0x1,-0x8(%rbp)
   140001b93:	00 
   140001b94:	48 83 7d 10 00       	cmpq   $0x0,0x10(%rbp)
   140001b99:	75 1e                	jne    140001bb9 <fact+0x39>
   140001b9b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001b9f:	eb 23                	jmp    140001bc4 <fact+0x44>
   140001ba1:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001ba5:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   140001ba9:	48 89 55 10          	mov    %rdx,0x10(%rbp)
   140001bad:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001bb1:	48 0f af c2          	imul   %rdx,%rax
   140001bb5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001bb9:	48 83 7d 10 00       	cmpq   $0x0,0x10(%rbp)
   140001bbe:	75 e1                	jne    140001ba1 <fact+0x21>
   140001bc0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001bc4:	48 83 c4 10          	add    $0x10,%rsp
   140001bc8:	5d                   	pop    %rbp
   140001bc9:	c3                   	ret

0000000140001bca <state__add_fn>:
   140001bca:	55                   	push   %rbp
   140001bcb:	48 89 e5             	mov    %rsp,%rbp
   140001bce:	48 83 ec 20          	sub    $0x20,%rsp
   140001bd2:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140001bd6:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140001bda:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140001bde:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140001be2:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001be6:	4c 8b 45 20          	mov    0x20(%rbp),%r8
   140001bea:	48 89 c1             	mov    %rax,%rcx
   140001bed:	41 ff d0             	call   *%r8
   140001bf0:	48 89 45 18          	mov    %rax,0x18(%rbp)
   140001bf4:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140001bf8:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001bfc:	41 b8 1d 00 00 00    	mov    $0x1d,%r8d
   140001c02:	48 89 c1             	mov    %rax,%rcx
   140001c05:	e8 bc f8 ff ff       	call   1400014c6 <state__add_ins>
   140001c0a:	48 89 45 18          	mov    %rax,0x18(%rbp)
   140001c0e:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140001c12:	48 83 c4 20          	add    $0x20,%rsp
   140001c16:	5d                   	pop    %rbp
   140001c17:	c3                   	ret

0000000140001c18 <state__compile>:
   140001c18:	55                   	push   %rbp
   140001c19:	48 89 e5             	mov    %rsp,%rbp
   140001c1c:	48 83 ec 50          	sub    $0x50,%rsp
   140001c20:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140001c24:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001c28:	48 8b 40 08          	mov    0x8(%rax),%rax
   140001c2c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001c30:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   140001c37:	00 
   140001c38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001c3c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140001c40:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001c44:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001c48:	48 c7 44 24 20 0c 00 	movq   $0xc,0x20(%rsp)
   140001c4f:	00 00 
   140001c51:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140001c57:	41 b8 15 00 00 00    	mov    $0x15,%r8d
   140001c5d:	48 89 c1             	mov    %rax,%rcx
   140001c60:	e8 61 f8 ff ff       	call   1400014c6 <state__add_ins>
   140001c65:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001c69:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001c6d:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001c71:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140001c77:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   140001c7d:	48 89 c1             	mov    %rax,%rcx
   140001c80:	e8 41 f8 ff ff       	call   1400014c6 <state__add_ins>
   140001c85:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001c89:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001c8d:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001c91:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140001c97:	41 b8 1c 00 00 00    	mov    $0x1c,%r8d
   140001c9d:	48 89 c1             	mov    %rax,%rcx
   140001ca0:	e8 21 f8 ff ff       	call   1400014c6 <state__add_ins>
   140001ca5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001ca9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001cad:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001cb1:	41 b8 01 00 00 00    	mov    $0x1,%r8d
   140001cb7:	48 89 c1             	mov    %rax,%rcx
   140001cba:	e8 07 f8 ff ff       	call   1400014c6 <state__add_ins>
   140001cbf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001cc3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001cc7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   140001ccb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001ccf:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001cd3:	c7 44 24 20 08 00 00 	movl   $0x8,0x20(%rsp)
   140001cda:	00 
   140001cdb:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140001ce1:	41 b8 0d 00 00 00    	mov    $0xd,%r8d
   140001ce7:	48 89 c1             	mov    %rax,%rcx
   140001cea:	e8 d7 f7 ff ff       	call   1400014c6 <state__add_ins>
   140001cef:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001cf3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001cf7:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001cfb:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140001d02:	00 00 
   140001d04:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140001d0a:	41 b8 15 00 00 00    	mov    $0x15,%r8d
   140001d10:	48 89 c1             	mov    %rax,%rcx
   140001d13:	e8 ae f7 ff ff       	call   1400014c6 <state__add_ins>
   140001d18:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001d1c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001d20:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001d24:	c7 44 24 20 08 00 00 	movl   $0x8,0x20(%rsp)
   140001d2b:	00 
   140001d2c:	41 b9 02 00 00 00    	mov    $0x2,%r9d
   140001d32:	41 b8 13 00 00 00    	mov    $0x13,%r8d
   140001d38:	48 89 c1             	mov    %rax,%rcx
   140001d3b:	e8 86 f7 ff ff       	call   1400014c6 <state__add_ins>
   140001d40:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001d44:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001d48:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001d4c:	48 c7 44 24 28 04 00 	movq   $0x4,0x28(%rsp)
   140001d53:	00 00 
   140001d55:	c7 44 24 20 00 00 00 	movl   $0x0,0x20(%rsp)
   140001d5c:	00 
   140001d5d:	41 b9 02 00 00 00    	mov    $0x2,%r9d
   140001d63:	41 b8 1a 00 00 00    	mov    $0x1a,%r8d
   140001d69:	48 89 c1             	mov    %rax,%rcx
   140001d6c:	e8 55 f7 ff ff       	call   1400014c6 <state__add_ins>
   140001d71:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001d75:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001d79:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001d7d:	48 c7 44 24 28 04 00 	movq   $0x4,0x28(%rsp)
   140001d84:	00 00 
   140001d86:	c7 44 24 20 02 00 00 	movl   $0x2,0x20(%rsp)
   140001d8d:	00 
   140001d8e:	41 b9 01 00 00 00    	mov    $0x1,%r9d
   140001d94:	41 b8 19 00 00 00    	mov    $0x19,%r8d
   140001d9a:	48 89 c1             	mov    %rax,%rcx
   140001d9d:	e8 24 f7 ff ff       	call   1400014c6 <state__add_ins>
   140001da2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001da6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001daa:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001dae:	41 b9 01 00 00 00    	mov    $0x1,%r9d
   140001db4:	41 b8 1e 00 00 00    	mov    $0x1e,%r8d
   140001dba:	48 89 c1             	mov    %rax,%rcx
   140001dbd:	e8 04 f7 ff ff       	call   1400014c6 <state__add_ins>
   140001dc2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001dc6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001dca:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001dce:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   140001dd5:	00 00 
   140001dd7:	41 b9 03 00 00 00    	mov    $0x3,%r9d
   140001ddd:	41 b8 15 00 00 00    	mov    $0x15,%r8d
   140001de3:	48 89 c1             	mov    %rax,%rcx
   140001de6:	e8 db f6 ff ff       	call   1400014c6 <state__add_ins>
   140001deb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001def:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001df3:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001df7:	c7 44 24 28 03 00 00 	movl   $0x3,0x28(%rsp)
   140001dfe:	00 
   140001dff:	c7 44 24 20 02 00 00 	movl   $0x2,0x20(%rsp)
   140001e06:	00 
   140001e07:	41 b9 02 00 00 00    	mov    $0x2,%r9d
   140001e0d:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140001e13:	48 89 c1             	mov    %rax,%rcx
   140001e16:	e8 ab f6 ff ff       	call   1400014c6 <state__add_ins>
   140001e1b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001e1f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001e23:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001e27:	48 c7 44 24 20 02 00 	movq   $0x2,0x20(%rsp)
   140001e2e:	00 00 
   140001e30:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140001e36:	41 b8 15 00 00 00    	mov    $0x15,%r8d
   140001e3c:	48 89 c1             	mov    %rax,%rcx
   140001e3f:	e8 82 f6 ff ff       	call   1400014c6 <state__add_ins>
   140001e44:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001e48:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001e4c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001e50:	48 c7 44 24 28 04 00 	movq   $0x4,0x28(%rsp)
   140001e57:	00 00 
   140001e59:	c7 44 24 20 00 00 00 	movl   $0x0,0x20(%rsp)
   140001e60:	00 
   140001e61:	41 b9 02 00 00 00    	mov    $0x2,%r9d
   140001e67:	41 b8 1a 00 00 00    	mov    $0x1a,%r8d
   140001e6d:	48 89 c1             	mov    %rax,%rcx
   140001e70:	e8 51 f6 ff ff       	call   1400014c6 <state__add_ins>
   140001e75:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001e79:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001e7d:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001e81:	48 c7 44 24 28 04 00 	movq   $0x4,0x28(%rsp)
   140001e88:	00 00 
   140001e8a:	c7 44 24 20 02 00 00 	movl   $0x2,0x20(%rsp)
   140001e91:	00 
   140001e92:	41 b9 01 00 00 00    	mov    $0x1,%r9d
   140001e98:	41 b8 19 00 00 00    	mov    $0x19,%r8d
   140001e9e:	48 89 c1             	mov    %rax,%rcx
   140001ea1:	e8 20 f6 ff ff       	call   1400014c6 <state__add_ins>
   140001ea6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001eaa:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001eae:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001eb2:	41 b9 01 00 00 00    	mov    $0x1,%r9d
   140001eb8:	41 b8 1e 00 00 00    	mov    $0x1e,%r8d
   140001ebe:	48 89 c1             	mov    %rax,%rcx
   140001ec1:	e8 00 f6 ff ff       	call   1400014c6 <state__add_ins>
   140001ec6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001eca:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001ece:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001ed2:	48 c7 44 24 20 03 00 	movq   $0x3,0x20(%rsp)
   140001ed9:	00 00 
   140001edb:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140001ee1:	41 b8 15 00 00 00    	mov    $0x15,%r8d
   140001ee7:	48 89 c1             	mov    %rax,%rcx
   140001eea:	e8 d7 f5 ff ff       	call   1400014c6 <state__add_ins>
   140001eef:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001ef3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001ef7:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001efb:	c7 44 24 28 03 00 00 	movl   $0x3,0x28(%rsp)
   140001f02:	00 
   140001f03:	c7 44 24 20 02 00 00 	movl   $0x2,0x20(%rsp)
   140001f0a:	00 
   140001f0b:	41 b9 02 00 00 00    	mov    $0x2,%r9d
   140001f11:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140001f17:	48 89 c1             	mov    %rax,%rcx
   140001f1a:	e8 a7 f5 ff ff       	call   1400014c6 <state__add_ins>
   140001f1f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001f23:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001f27:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001f2b:	48 c7 44 24 28 04 00 	movq   $0x4,0x28(%rsp)
   140001f32:	00 00 
   140001f34:	c7 44 24 20 00 00 00 	movl   $0x0,0x20(%rsp)
   140001f3b:	00 
   140001f3c:	41 b9 02 00 00 00    	mov    $0x2,%r9d
   140001f42:	41 b8 1a 00 00 00    	mov    $0x1a,%r8d
   140001f48:	48 89 c1             	mov    %rax,%rcx
   140001f4b:	e8 76 f5 ff ff       	call   1400014c6 <state__add_ins>
   140001f50:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001f54:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001f58:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001f5c:	48 c7 44 24 28 04 00 	movq   $0x4,0x28(%rsp)
   140001f63:	00 00 
   140001f65:	c7 44 24 20 02 00 00 	movl   $0x2,0x20(%rsp)
   140001f6c:	00 
   140001f6d:	41 b9 01 00 00 00    	mov    $0x1,%r9d
   140001f73:	41 b8 19 00 00 00    	mov    $0x19,%r8d
   140001f79:	48 89 c1             	mov    %rax,%rcx
   140001f7c:	e8 45 f5 ff ff       	call   1400014c6 <state__add_ins>
   140001f81:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001f85:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001f89:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001f8d:	41 b9 01 00 00 00    	mov    $0x1,%r9d
   140001f93:	41 b8 1e 00 00 00    	mov    $0x1e,%r8d
   140001f99:	48 89 c1             	mov    %rax,%rcx
   140001f9c:	e8 25 f5 ff ff       	call   1400014c6 <state__add_ins>
   140001fa1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001fa5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001fa9:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001fad:	41 b9 08 00 00 00    	mov    $0x8,%r9d
   140001fb3:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   140001fb9:	48 89 c1             	mov    %rax,%rcx
   140001fbc:	e8 05 f5 ff ff       	call   1400014c6 <state__add_ins>
   140001fc1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001fc5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001fc9:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001fcd:	41 b9 01 00 00 00    	mov    $0x1,%r9d
   140001fd3:	41 b8 1c 00 00 00    	mov    $0x1c,%r8d
   140001fd9:	48 89 c1             	mov    %rax,%rcx
   140001fdc:	e8 e5 f4 ff ff       	call   1400014c6 <state__add_ins>
   140001fe1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001fe5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001fe9:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001fed:	41 b8 01 00 00 00    	mov    $0x1,%r8d
   140001ff3:	48 89 c1             	mov    %rax,%rcx
   140001ff6:	e8 cb f4 ff ff       	call   1400014c6 <state__add_ins>
   140001ffb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001fff:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140002003:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002007:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000200d:	41 b8 1f 00 00 00    	mov    $0x1f,%r8d
   140002013:	48 89 c1             	mov    %rax,%rcx
   140002016:	e8 ab f4 ff ff       	call   1400014c6 <state__add_ins>
   14000201b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000201f:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
   140002023:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   140002027:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000202b:	49 89 c8             	mov    %rcx,%r8
   14000202e:	48 89 c1             	mov    %rax,%rcx
   140002031:	e8 6e f4 ff ff       	call   1400014a4 <state__patch_jmp>
   140002036:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   14000203a:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000203e:	41 b9 01 00 00 00    	mov    $0x1,%r9d
   140002044:	41 b8 1f 00 00 00    	mov    $0x1f,%r8d
   14000204a:	48 89 c1             	mov    %rax,%rcx
   14000204d:	e8 74 f4 ff ff       	call   1400014c6 <state__add_ins>
   140002052:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140002056:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000205a:	48 83 c4 50          	add    $0x50,%rsp
   14000205e:	5d                   	pop    %rbp
   14000205f:	c3                   	ret

0000000140002060 <clear_cache>:
   140002060:	55                   	push   %rbp
   140002061:	48 89 e5             	mov    %rsp,%rbp
   140002064:	48 83 ec 10          	sub    $0x10,%rsp
   140002068:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000206c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   140002073:	eb 20                	jmp    140002095 <clear_cache+0x35>
   140002075:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140002078:	8b 55 fc             	mov    -0x4(%rbp),%edx
   14000207b:	0f af c2             	imul   %edx,%eax
   14000207e:	89 c1                	mov    %eax,%ecx
   140002080:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002084:	48 8b 10             	mov    (%rax),%rdx
   140002087:	8b 45 fc             	mov    -0x4(%rbp),%eax
   14000208a:	48 01 d0             	add    %rdx,%rax
   14000208d:	89 ca                	mov    %ecx,%edx
   14000208f:	88 10                	mov    %dl,(%rax)
   140002091:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   140002095:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002099:	8b 40 08             	mov    0x8(%rax),%eax
   14000209c:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   14000209f:	72 d4                	jb     140002075 <clear_cache+0x15>
   1400020a1:	90                   	nop
   1400020a2:	90                   	nop
   1400020a3:	48 83 c4 10          	add    $0x10,%rsp
   1400020a7:	5d                   	pop    %rbp
   1400020a8:	c3                   	ret

00000001400020a9 <state__get_arg>:
   1400020a9:	55                   	push   %rbp
   1400020aa:	48 89 e5             	mov    %rsp,%rbp
   1400020ad:	48 83 ec 10          	sub    $0x10,%rsp
   1400020b1:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400020b5:	89 d0                	mov    %edx,%eax
   1400020b7:	88 45 18             	mov    %al,0x18(%rbp)
   1400020ba:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400020be:	48 8b 48 18          	mov    0x18(%rax),%rcx
   1400020c2:	0f b6 45 18          	movzbl 0x18(%rbp),%eax
   1400020c6:	48 c1 e0 03          	shl    $0x3,%rax
   1400020ca:	48 c7 c2 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rdx
   1400020d1:	48 29 c2             	sub    %rax,%rdx
   1400020d4:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
   1400020d8:	48 8b 00             	mov    (%rax),%rax
   1400020db:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   1400020df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400020e3:	48 83 c4 10          	add    $0x10,%rsp
   1400020e7:	5d                   	pop    %rbp
   1400020e8:	c3                   	ret

00000001400020e9 <builtin__execute>:
   1400020e9:	55                   	push   %rbp
   1400020ea:	48 89 e5             	mov    %rsp,%rbp
   1400020ed:	48 83 ec 30          	sub    $0x30,%rsp
   1400020f1:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400020f5:	89 d0                	mov    %edx,%eax
   1400020f7:	66 89 45 18          	mov    %ax,0x18(%rbp)
   1400020fb:	0f b7 45 18          	movzwl 0x18(%rbp),%eax
   1400020ff:	85 c0                	test   %eax,%eax
   140002101:	74 07                	je     14000210a <builtin__execute+0x21>
   140002103:	83 f8 01             	cmp    $0x1,%eax
   140002106:	74 30                	je     140002138 <builtin__execute+0x4f>
   140002108:	eb 51                	jmp    14000215b <builtin__execute+0x72>
   14000210a:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000210e:	ba 00 00 00 00       	mov    $0x0,%edx
   140002113:	48 89 c1             	mov    %rax,%rcx
   140002116:	e8 8e ff ff ff       	call   1400020a9 <state__get_arg>
   14000211b:	48 89 c1             	mov    %rax,%rcx
   14000211e:	e8 7d 77 00 00       	call   1400098a0 <malloc>
   140002123:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140002127:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   14000212b:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000212f:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
   140002136:	eb 46                	jmp    14000217e <builtin__execute+0x95>
   140002138:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000213c:	ba 00 00 00 00       	mov    $0x0,%edx
   140002141:	48 89 c1             	mov    %rax,%rcx
   140002144:	e8 60 ff ff ff       	call   1400020a9 <state__get_arg>
   140002149:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000214d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002151:	48 89 c1             	mov    %rax,%rcx
   140002154:	e8 2f 77 00 00       	call   140009888 <free>
   140002159:	eb 23                	jmp    14000217e <builtin__execute+0x95>
   14000215b:	41 b8 ce 01 00 00    	mov    $0x1ce,%r8d
   140002161:	48 8d 05 98 8e 00 00 	lea    0x8e98(%rip),%rax        # 14000b000 <.rdata>
   140002168:	48 89 c2             	mov    %rax,%rdx
   14000216b:	48 8d 05 93 8e 00 00 	lea    0x8e93(%rip),%rax        # 14000b005 <.rdata+0x5>
   140002172:	48 89 c1             	mov    %rax,%rcx
   140002175:	48 8b 05 10 d1 00 00 	mov    0xd110(%rip),%rax        # 14000f28c <__imp__assert>
   14000217c:	ff d0                	call   *%rax
   14000217e:	90                   	nop
   14000217f:	48 83 c4 30          	add    $0x30,%rsp
   140002183:	5d                   	pop    %rbp
   140002184:	c3                   	ret

0000000140002185 <main>:
   140002185:	55                   	push   %rbp
   140002186:	53                   	push   %rbx
   140002187:	48 81 ec e8 09 00 00 	sub    $0x9e8,%rsp
   14000218e:	48 8d ac 24 80 00 00 	lea    0x80(%rsp),%rbp
   140002195:	00 
   140002196:	e8 95 11 00 00       	call   140003330 <__main>
   14000219b:	c7 85 08 08 00 00 00 	movl   $0x1400000,0x808(%rbp)
   1400021a2:	00 40 01 
   1400021a5:	8b 85 08 08 00 00    	mov    0x808(%rbp),%eax
   1400021ab:	89 c0                	mov    %eax,%eax
   1400021ad:	48 89 c1             	mov    %rax,%rcx
   1400021b0:	e8 eb 76 00 00       	call   1400098a0 <malloc>
   1400021b5:	48 89 85 00 08 00 00 	mov    %rax,0x800(%rbp)
   1400021bc:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   1400021c0:	ba 60 08 00 00       	mov    $0x860,%edx
   1400021c5:	49 89 d0             	mov    %rdx,%r8
   1400021c8:	ba 00 00 00 00       	mov    $0x0,%edx
   1400021cd:	48 89 c1             	mov    %rax,%rcx
   1400021d0:	e8 db 76 00 00       	call   1400098b0 <memset>
   1400021d5:	c7 45 b0 00 10 00 00 	movl   $0x1000,-0x50(%rbp)
   1400021dc:	c7 45 c8 00 10 00 00 	movl   $0x1000,-0x38(%rbp)
   1400021e3:	c7 45 e0 00 04 00 00 	movl   $0x400,-0x20(%rbp)
   1400021ea:	c6 85 f8 07 00 00 01 	movb   $0x1,0x7f8(%rbp)
   1400021f1:	8b 45 b0             	mov    -0x50(%rbp),%eax
   1400021f4:	89 c0                	mov    %eax,%eax
   1400021f6:	48 89 c1             	mov    %rax,%rcx
   1400021f9:	e8 a2 76 00 00       	call   1400098a0 <malloc>
   1400021fe:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
   140002202:	8b 45 c8             	mov    -0x38(%rbp),%eax
   140002205:	89 c0                	mov    %eax,%eax
   140002207:	48 89 c1             	mov    %rax,%rcx
   14000220a:	e8 91 76 00 00       	call   1400098a0 <malloc>
   14000220f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   140002213:	8b 45 e0             	mov    -0x20(%rbp),%eax
   140002216:	89 c0                	mov    %eax,%eax
   140002218:	48 c1 e0 03          	shl    $0x3,%rax
   14000221c:	48 89 c1             	mov    %rax,%rcx
   14000221f:	e8 7c 76 00 00       	call   1400098a0 <malloc>
   140002224:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   140002228:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   14000222c:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002230:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   140002234:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   140002238:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14000223c:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   140002240:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   140002244:	48 89 c1             	mov    %rax,%rcx
   140002247:	e8 cc f9 ff ff       	call   140001c18 <state__compile>
   14000224c:	48 89 85 50 09 00 00 	mov    %rax,0x950(%rbp)
   140002253:	48 c7 85 48 09 00 00 	movq   $0x0,0x948(%rbp)
   14000225a:	00 00 00 00 
   14000225e:	48 c7 85 40 09 00 00 	movq   $0x0,0x940(%rbp)
   140002265:	00 00 00 00 
   140002269:	c7 85 3c 09 00 00 32 	movl   $0x32,0x93c(%rbp)
   140002270:	00 00 00 
   140002273:	c7 85 5c 09 00 00 00 	movl   $0x0,0x95c(%rbp)
   14000227a:	00 00 00 
   14000227d:	e9 ae 0f 00 00       	jmp    140003230 <main+0x10ab>
   140002282:	c6 85 f8 07 00 00 01 	movb   $0x1,0x7f8(%rbp)
   140002289:	48 8b 85 50 09 00 00 	mov    0x950(%rbp),%rax
   140002290:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002294:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   140002298:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   14000229c:	48 8d 85 00 08 00 00 	lea    0x800(%rbp),%rax
   1400022a3:	48 89 c1             	mov    %rax,%rcx
   1400022a6:	e8 b5 fd ff ff       	call   140002060 <clear_cache>
   1400022ab:	e9 51 0f 00 00       	jmp    140003201 <main+0x107c>
   1400022b0:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400022b4:	48 8d 50 01          	lea    0x1(%rax),%rdx
   1400022b8:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   1400022bc:	0f b6 00             	movzbl (%rax),%eax
   1400022bf:	88 85 3b 09 00 00    	mov    %al,0x93b(%rbp)
   1400022c5:	0f b6 85 3b 09 00 00 	movzbl 0x93b(%rbp),%eax
   1400022cc:	83 f8 1f             	cmp    $0x1f,%eax
   1400022cf:	0f 87 09 0f 00 00    	ja     1400031de <main+0x1059>
   1400022d5:	89 c0                	mov    %eax,%eax
   1400022d7:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   1400022de:	00 
   1400022df:	48 8d 05 c6 8d 00 00 	lea    0x8dc6(%rip),%rax        # 14000b0ac <.rdata+0xac>
   1400022e6:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   1400022e9:	48 98                	cltq
   1400022eb:	48 8d 15 ba 8d 00 00 	lea    0x8dba(%rip),%rdx        # 14000b0ac <.rdata+0xac>
   1400022f2:	48 01 d0             	add    %rdx,%rax
   1400022f5:	ff e0                	jmp    *%rax
   1400022f7:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400022fb:	0f b6 00             	movzbl (%rax),%eax
   1400022fe:	88 85 1f 08 00 00    	mov    %al,0x81f(%rbp)
   140002304:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002308:	48 83 c0 01          	add    $0x1,%rax
   14000230c:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002310:	0f b6 95 1f 08 00 00 	movzbl 0x81f(%rbp),%edx
   140002317:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   14000231b:	48 63 d2             	movslq %edx,%rdx
   14000231e:	48 83 c2 08          	add    $0x8,%rdx
   140002322:	48 8b 54 d5 a8       	mov    -0x58(%rbp,%rdx,8),%rdx
   140002327:	48 89 10             	mov    %rdx,(%rax)
   14000232a:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   14000232e:	48 83 c0 08          	add    $0x8,%rax
   140002332:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   140002336:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   14000233a:	48 89 85 e8 07 00 00 	mov    %rax,0x7e8(%rbp)
   140002341:	e9 bb 0e 00 00       	jmp    140003201 <main+0x107c>
   140002346:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   14000234a:	48 8b 40 f8          	mov    -0x8(%rax),%rax
   14000234e:	48 89 85 20 08 00 00 	mov    %rax,0x820(%rbp)
   140002355:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   140002359:	48 83 e8 08          	sub    $0x8,%rax
   14000235d:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   140002361:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   140002365:	48 89 85 e8 07 00 00 	mov    %rax,0x7e8(%rbp)
   14000236c:	e9 90 0e 00 00       	jmp    140003201 <main+0x107c>
   140002371:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002375:	0f b6 00             	movzbl (%rax),%eax
   140002378:	88 85 37 08 00 00    	mov    %al,0x837(%rbp)
   14000237e:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002382:	48 83 c0 01          	add    $0x1,%rax
   140002386:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   14000238a:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000238e:	0f b6 00             	movzbl (%rax),%eax
   140002391:	88 85 36 08 00 00    	mov    %al,0x836(%rbp)
   140002397:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000239b:	48 83 c0 01          	add    $0x1,%rax
   14000239f:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   1400023a3:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400023a7:	0f b6 00             	movzbl (%rax),%eax
   1400023aa:	88 85 35 08 00 00    	mov    %al,0x835(%rbp)
   1400023b0:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400023b4:	48 83 c0 01          	add    $0x1,%rax
   1400023b8:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   1400023bc:	0f b6 85 36 08 00 00 	movzbl 0x836(%rbp),%eax
   1400023c3:	48 98                	cltq
   1400023c5:	48 83 c0 08          	add    $0x8,%rax
   1400023c9:	48 8b 54 c5 a8       	mov    -0x58(%rbp,%rax,8),%rdx
   1400023ce:	0f b6 85 35 08 00 00 	movzbl 0x835(%rbp),%eax
   1400023d5:	48 98                	cltq
   1400023d7:	48 83 c0 08          	add    $0x8,%rax
   1400023db:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   1400023e0:	48 01 d0             	add    %rdx,%rax
   1400023e3:	48 89 85 28 08 00 00 	mov    %rax,0x828(%rbp)
   1400023ea:	0f b6 85 37 08 00 00 	movzbl 0x837(%rbp),%eax
   1400023f1:	48 98                	cltq
   1400023f3:	48 83 c0 08          	add    $0x8,%rax
   1400023f7:	48 8b 95 28 08 00 00 	mov    0x828(%rbp),%rdx
   1400023fe:	48 89 54 c5 a8       	mov    %rdx,-0x58(%rbp,%rax,8)
   140002403:	e9 f9 0d 00 00       	jmp    140003201 <main+0x107c>
   140002408:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000240c:	0f b6 00             	movzbl (%rax),%eax
   14000240f:	88 85 47 08 00 00    	mov    %al,0x847(%rbp)
   140002415:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002419:	48 83 c0 01          	add    $0x1,%rax
   14000241d:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002421:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002425:	0f b6 00             	movzbl (%rax),%eax
   140002428:	88 85 46 08 00 00    	mov    %al,0x846(%rbp)
   14000242e:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002432:	48 83 c0 01          	add    $0x1,%rax
   140002436:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   14000243a:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000243e:	0f b6 00             	movzbl (%rax),%eax
   140002441:	88 85 45 08 00 00    	mov    %al,0x845(%rbp)
   140002447:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000244b:	48 83 c0 01          	add    $0x1,%rax
   14000244f:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002453:	0f b6 85 46 08 00 00 	movzbl 0x846(%rbp),%eax
   14000245a:	48 98                	cltq
   14000245c:	48 83 c0 08          	add    $0x8,%rax
   140002460:	48 8b 4c c5 a8       	mov    -0x58(%rbp,%rax,8),%rcx
   140002465:	0f b6 85 45 08 00 00 	movzbl 0x845(%rbp),%eax
   14000246c:	48 98                	cltq
   14000246e:	48 83 c0 08          	add    $0x8,%rax
   140002472:	48 8b 54 c5 a8       	mov    -0x58(%rbp,%rax,8),%rdx
   140002477:	48 89 c8             	mov    %rcx,%rax
   14000247a:	48 29 d0             	sub    %rdx,%rax
   14000247d:	48 89 85 38 08 00 00 	mov    %rax,0x838(%rbp)
   140002484:	0f b6 85 47 08 00 00 	movzbl 0x847(%rbp),%eax
   14000248b:	48 98                	cltq
   14000248d:	48 83 c0 08          	add    $0x8,%rax
   140002491:	48 8b 95 38 08 00 00 	mov    0x838(%rbp),%rdx
   140002498:	48 89 54 c5 a8       	mov    %rdx,-0x58(%rbp,%rax,8)
   14000249d:	e9 5f 0d 00 00       	jmp    140003201 <main+0x107c>
   1400024a2:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400024a6:	0f b6 00             	movzbl (%rax),%eax
   1400024a9:	88 85 57 08 00 00    	mov    %al,0x857(%rbp)
   1400024af:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400024b3:	48 83 c0 01          	add    $0x1,%rax
   1400024b7:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   1400024bb:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400024bf:	0f b6 00             	movzbl (%rax),%eax
   1400024c2:	88 85 56 08 00 00    	mov    %al,0x856(%rbp)
   1400024c8:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400024cc:	48 83 c0 01          	add    $0x1,%rax
   1400024d0:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   1400024d4:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400024d8:	0f b6 00             	movzbl (%rax),%eax
   1400024db:	88 85 55 08 00 00    	mov    %al,0x855(%rbp)
   1400024e1:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400024e5:	48 83 c0 01          	add    $0x1,%rax
   1400024e9:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   1400024ed:	0f b6 85 56 08 00 00 	movzbl 0x856(%rbp),%eax
   1400024f4:	48 98                	cltq
   1400024f6:	48 83 c0 08          	add    $0x8,%rax
   1400024fa:	48 8b 54 c5 a8       	mov    -0x58(%rbp,%rax,8),%rdx
   1400024ff:	0f b6 85 55 08 00 00 	movzbl 0x855(%rbp),%eax
   140002506:	48 98                	cltq
   140002508:	48 83 c0 08          	add    $0x8,%rax
   14000250c:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   140002511:	48 0f af c2          	imul   %rdx,%rax
   140002515:	48 89 85 48 08 00 00 	mov    %rax,0x848(%rbp)
   14000251c:	0f b6 85 57 08 00 00 	movzbl 0x857(%rbp),%eax
   140002523:	48 98                	cltq
   140002525:	48 83 c0 08          	add    $0x8,%rax
   140002529:	48 8b 95 48 08 00 00 	mov    0x848(%rbp),%rdx
   140002530:	48 89 54 c5 a8       	mov    %rdx,-0x58(%rbp,%rax,8)
   140002535:	e9 c7 0c 00 00       	jmp    140003201 <main+0x107c>
   14000253a:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000253e:	0f b6 00             	movzbl (%rax),%eax
   140002541:	88 85 67 08 00 00    	mov    %al,0x867(%rbp)
   140002547:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000254b:	48 83 c0 01          	add    $0x1,%rax
   14000254f:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002553:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002557:	0f b6 00             	movzbl (%rax),%eax
   14000255a:	88 85 66 08 00 00    	mov    %al,0x866(%rbp)
   140002560:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002564:	48 83 c0 01          	add    $0x1,%rax
   140002568:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   14000256c:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002570:	0f b6 00             	movzbl (%rax),%eax
   140002573:	88 85 65 08 00 00    	mov    %al,0x865(%rbp)
   140002579:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000257d:	48 83 c0 01          	add    $0x1,%rax
   140002581:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002585:	0f b6 85 66 08 00 00 	movzbl 0x866(%rbp),%eax
   14000258c:	48 98                	cltq
   14000258e:	48 83 c0 08          	add    $0x8,%rax
   140002592:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   140002597:	0f b6 95 65 08 00 00 	movzbl 0x865(%rbp),%edx
   14000259e:	48 63 d2             	movslq %edx,%rdx
   1400025a1:	48 83 c2 08          	add    $0x8,%rdx
   1400025a5:	48 8b 5c d5 a8       	mov    -0x58(%rbp,%rdx,8),%rbx
   1400025aa:	ba 00 00 00 00       	mov    $0x0,%edx
   1400025af:	48 f7 f3             	div    %rbx
   1400025b2:	48 89 85 58 08 00 00 	mov    %rax,0x858(%rbp)
   1400025b9:	0f b6 85 67 08 00 00 	movzbl 0x867(%rbp),%eax
   1400025c0:	48 98                	cltq
   1400025c2:	48 83 c0 08          	add    $0x8,%rax
   1400025c6:	48 8b 95 58 08 00 00 	mov    0x858(%rbp),%rdx
   1400025cd:	48 89 54 c5 a8       	mov    %rdx,-0x58(%rbp,%rax,8)
   1400025d2:	e9 2a 0c 00 00       	jmp    140003201 <main+0x107c>
   1400025d7:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400025db:	0f b6 00             	movzbl (%rax),%eax
   1400025de:	88 85 72 08 00 00    	mov    %al,0x872(%rbp)
   1400025e4:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400025e8:	48 83 c0 01          	add    $0x1,%rax
   1400025ec:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   1400025f0:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400025f4:	0f b6 00             	movzbl (%rax),%eax
   1400025f7:	88 85 71 08 00 00    	mov    %al,0x871(%rbp)
   1400025fd:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002601:	48 83 c0 01          	add    $0x1,%rax
   140002605:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002609:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000260d:	0f b6 00             	movzbl (%rax),%eax
   140002610:	88 85 70 08 00 00    	mov    %al,0x870(%rbp)
   140002616:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000261a:	48 83 c0 01          	add    $0x1,%rax
   14000261e:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002622:	0f b6 85 71 08 00 00 	movzbl 0x871(%rbp),%eax
   140002629:	48 98                	cltq
   14000262b:	48 83 c0 08          	add    $0x8,%rax
   14000262f:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   140002634:	0f b6 95 70 08 00 00 	movzbl 0x870(%rbp),%edx
   14000263b:	48 63 d2             	movslq %edx,%rdx
   14000263e:	48 83 c2 08          	add    $0x8,%rdx
   140002642:	48 8b 4c d5 a8       	mov    -0x58(%rbp,%rdx,8),%rcx
   140002647:	ba 00 00 00 00       	mov    $0x0,%edx
   14000264c:	48 f7 f1             	div    %rcx
   14000264f:	48 89 95 68 08 00 00 	mov    %rdx,0x868(%rbp)
   140002656:	0f b6 85 72 08 00 00 	movzbl 0x872(%rbp),%eax
   14000265d:	48 98                	cltq
   14000265f:	48 83 c0 08          	add    $0x8,%rax
   140002663:	48 8b 95 68 08 00 00 	mov    0x868(%rbp),%rdx
   14000266a:	48 89 54 c5 a8       	mov    %rdx,-0x58(%rbp,%rax,8)
   14000266f:	e9 8d 0b 00 00       	jmp    140003201 <main+0x107c>
   140002674:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002678:	0f b6 00             	movzbl (%rax),%eax
   14000267b:	88 85 74 08 00 00    	mov    %al,0x874(%rbp)
   140002681:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002685:	48 83 c0 01          	add    $0x1,%rax
   140002689:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   14000268d:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002691:	0f b6 00             	movzbl (%rax),%eax
   140002694:	88 85 73 08 00 00    	mov    %al,0x873(%rbp)
   14000269a:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000269e:	48 83 c0 01          	add    $0x1,%rax
   1400026a2:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   1400026a6:	0f b6 85 73 08 00 00 	movzbl 0x873(%rbp),%eax
   1400026ad:	48 98                	cltq
   1400026af:	48 83 c0 08          	add    $0x8,%rax
   1400026b3:	48 8b 54 c5 a8       	mov    -0x58(%rbp,%rax,8),%rdx
   1400026b8:	0f b6 85 74 08 00 00 	movzbl 0x874(%rbp),%eax
   1400026bf:	48 f7 da             	neg    %rdx
   1400026c2:	48 98                	cltq
   1400026c4:	48 83 c0 08          	add    $0x8,%rax
   1400026c8:	48 89 54 c5 a8       	mov    %rdx,-0x58(%rbp,%rax,8)
   1400026cd:	e9 2f 0b 00 00       	jmp    140003201 <main+0x107c>
   1400026d2:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400026d6:	0f b6 00             	movzbl (%rax),%eax
   1400026d9:	88 85 76 08 00 00    	mov    %al,0x876(%rbp)
   1400026df:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400026e3:	48 83 c0 01          	add    $0x1,%rax
   1400026e7:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   1400026eb:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400026ef:	0f b6 00             	movzbl (%rax),%eax
   1400026f2:	88 85 75 08 00 00    	mov    %al,0x875(%rbp)
   1400026f8:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400026fc:	48 83 c0 01          	add    $0x1,%rax
   140002700:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002704:	0f b6 85 75 08 00 00 	movzbl 0x875(%rbp),%eax
   14000270b:	48 98                	cltq
   14000270d:	48 83 c0 08          	add    $0x8,%rax
   140002711:	48 8b 54 c5 a8       	mov    -0x58(%rbp,%rax,8),%rdx
   140002716:	0f b6 85 76 08 00 00 	movzbl 0x876(%rbp),%eax
   14000271d:	48 f7 d2             	not    %rdx
   140002720:	48 98                	cltq
   140002722:	48 83 c0 08          	add    $0x8,%rax
   140002726:	48 89 54 c5 a8       	mov    %rdx,-0x58(%rbp,%rax,8)
   14000272b:	e9 d1 0a 00 00       	jmp    140003201 <main+0x107c>
   140002730:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002734:	0f b6 00             	movzbl (%rax),%eax
   140002737:	88 85 79 08 00 00    	mov    %al,0x879(%rbp)
   14000273d:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002741:	48 83 c0 01          	add    $0x1,%rax
   140002745:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002749:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000274d:	0f b6 00             	movzbl (%rax),%eax
   140002750:	88 85 78 08 00 00    	mov    %al,0x878(%rbp)
   140002756:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000275a:	48 83 c0 01          	add    $0x1,%rax
   14000275e:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002762:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002766:	0f b6 00             	movzbl (%rax),%eax
   140002769:	88 85 77 08 00 00    	mov    %al,0x877(%rbp)
   14000276f:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002773:	48 83 c0 01          	add    $0x1,%rax
   140002777:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   14000277b:	0f b6 85 78 08 00 00 	movzbl 0x878(%rbp),%eax
   140002782:	48 98                	cltq
   140002784:	48 83 c0 08          	add    $0x8,%rax
   140002788:	48 8b 4c c5 a8       	mov    -0x58(%rbp,%rax,8),%rcx
   14000278d:	0f b6 85 77 08 00 00 	movzbl 0x877(%rbp),%eax
   140002794:	48 98                	cltq
   140002796:	48 83 c0 08          	add    $0x8,%rax
   14000279a:	48 8b 54 c5 a8       	mov    -0x58(%rbp,%rax,8),%rdx
   14000279f:	0f b6 85 79 08 00 00 	movzbl 0x879(%rbp),%eax
   1400027a6:	48 31 ca             	xor    %rcx,%rdx
   1400027a9:	48 98                	cltq
   1400027ab:	48 83 c0 08          	add    $0x8,%rax
   1400027af:	48 89 54 c5 a8       	mov    %rdx,-0x58(%rbp,%rax,8)
   1400027b4:	e9 48 0a 00 00       	jmp    140003201 <main+0x107c>
   1400027b9:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400027bd:	0f b6 00             	movzbl (%rax),%eax
   1400027c0:	88 85 7c 08 00 00    	mov    %al,0x87c(%rbp)
   1400027c6:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400027ca:	48 83 c0 01          	add    $0x1,%rax
   1400027ce:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   1400027d2:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400027d6:	0f b6 00             	movzbl (%rax),%eax
   1400027d9:	88 85 7b 08 00 00    	mov    %al,0x87b(%rbp)
   1400027df:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400027e3:	48 83 c0 01          	add    $0x1,%rax
   1400027e7:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   1400027eb:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400027ef:	0f b6 00             	movzbl (%rax),%eax
   1400027f2:	88 85 7a 08 00 00    	mov    %al,0x87a(%rbp)
   1400027f8:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400027fc:	48 83 c0 01          	add    $0x1,%rax
   140002800:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002804:	0f b6 85 7b 08 00 00 	movzbl 0x87b(%rbp),%eax
   14000280b:	48 98                	cltq
   14000280d:	48 83 c0 08          	add    $0x8,%rax
   140002811:	48 8b 4c c5 a8       	mov    -0x58(%rbp,%rax,8),%rcx
   140002816:	0f b6 85 7a 08 00 00 	movzbl 0x87a(%rbp),%eax
   14000281d:	48 98                	cltq
   14000281f:	48 83 c0 08          	add    $0x8,%rax
   140002823:	48 8b 54 c5 a8       	mov    -0x58(%rbp,%rax,8),%rdx
   140002828:	0f b6 85 7c 08 00 00 	movzbl 0x87c(%rbp),%eax
   14000282f:	48 21 ca             	and    %rcx,%rdx
   140002832:	48 98                	cltq
   140002834:	48 83 c0 08          	add    $0x8,%rax
   140002838:	48 89 54 c5 a8       	mov    %rdx,-0x58(%rbp,%rax,8)
   14000283d:	e9 bf 09 00 00       	jmp    140003201 <main+0x107c>
   140002842:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002846:	0f b6 00             	movzbl (%rax),%eax
   140002849:	88 85 7f 08 00 00    	mov    %al,0x87f(%rbp)
   14000284f:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002853:	48 83 c0 01          	add    $0x1,%rax
   140002857:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   14000285b:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000285f:	0f b6 00             	movzbl (%rax),%eax
   140002862:	88 85 7e 08 00 00    	mov    %al,0x87e(%rbp)
   140002868:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000286c:	48 83 c0 01          	add    $0x1,%rax
   140002870:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002874:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002878:	0f b6 00             	movzbl (%rax),%eax
   14000287b:	88 85 7d 08 00 00    	mov    %al,0x87d(%rbp)
   140002881:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002885:	48 83 c0 01          	add    $0x1,%rax
   140002889:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   14000288d:	0f b6 85 7e 08 00 00 	movzbl 0x87e(%rbp),%eax
   140002894:	48 98                	cltq
   140002896:	48 83 c0 08          	add    $0x8,%rax
   14000289a:	48 8b 4c c5 a8       	mov    -0x58(%rbp,%rax,8),%rcx
   14000289f:	0f b6 85 7d 08 00 00 	movzbl 0x87d(%rbp),%eax
   1400028a6:	48 98                	cltq
   1400028a8:	48 83 c0 08          	add    $0x8,%rax
   1400028ac:	48 8b 54 c5 a8       	mov    -0x58(%rbp,%rax,8),%rdx
   1400028b1:	0f b6 85 7f 08 00 00 	movzbl 0x87f(%rbp),%eax
   1400028b8:	48 09 ca             	or     %rcx,%rdx
   1400028bb:	48 98                	cltq
   1400028bd:	48 83 c0 08          	add    $0x8,%rax
   1400028c1:	48 89 54 c5 a8       	mov    %rdx,-0x58(%rbp,%rax,8)
   1400028c6:	e9 36 09 00 00       	jmp    140003201 <main+0x107c>
   1400028cb:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400028cf:	48 8b 00             	mov    (%rax),%rax
   1400028d2:	48 89 85 80 08 00 00 	mov    %rax,0x880(%rbp)
   1400028d9:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400028dd:	48 83 c0 08          	add    $0x8,%rax
   1400028e1:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   1400028e5:	48 8b 85 80 08 00 00 	mov    0x880(%rbp),%rax
   1400028ec:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   1400028f0:	e9 0c 09 00 00       	jmp    140003201 <main+0x107c>
   1400028f5:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400028f9:	48 8b 00             	mov    (%rax),%rax
   1400028fc:	48 89 85 90 08 00 00 	mov    %rax,0x890(%rbp)
   140002903:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002907:	48 83 c0 08          	add    $0x8,%rax
   14000290b:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   14000290f:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002913:	0f b6 00             	movzbl (%rax),%eax
   140002916:	88 85 8f 08 00 00    	mov    %al,0x88f(%rbp)
   14000291c:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002920:	48 83 c0 01          	add    $0x1,%rax
   140002924:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002928:	0f b6 85 8f 08 00 00 	movzbl 0x88f(%rbp),%eax
   14000292f:	48 98                	cltq
   140002931:	48 83 c0 08          	add    $0x8,%rax
   140002935:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   14000293a:	48 85 c0             	test   %rax,%rax
   14000293d:	0f 85 be 08 00 00    	jne    140003201 <main+0x107c>
   140002943:	48 8b 85 90 08 00 00 	mov    0x890(%rbp),%rax
   14000294a:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   14000294e:	e9 ae 08 00 00       	jmp    140003201 <main+0x107c>
   140002953:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002957:	48 8b 00             	mov    (%rax),%rax
   14000295a:	48 89 85 a0 08 00 00 	mov    %rax,0x8a0(%rbp)
   140002961:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002965:	48 83 c0 08          	add    $0x8,%rax
   140002969:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   14000296d:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002971:	0f b6 00             	movzbl (%rax),%eax
   140002974:	88 85 9f 08 00 00    	mov    %al,0x89f(%rbp)
   14000297a:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000297e:	48 83 c0 01          	add    $0x1,%rax
   140002982:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002986:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000298a:	0f b6 00             	movzbl (%rax),%eax
   14000298d:	88 85 9e 08 00 00    	mov    %al,0x89e(%rbp)
   140002993:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002997:	48 83 c0 01          	add    $0x1,%rax
   14000299b:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   14000299f:	0f b6 85 9f 08 00 00 	movzbl 0x89f(%rbp),%eax
   1400029a6:	48 98                	cltq
   1400029a8:	48 83 c0 08          	add    $0x8,%rax
   1400029ac:	48 8b 54 c5 a8       	mov    -0x58(%rbp,%rax,8),%rdx
   1400029b1:	0f b6 85 9e 08 00 00 	movzbl 0x89e(%rbp),%eax
   1400029b8:	48 98                	cltq
   1400029ba:	48 83 c0 08          	add    $0x8,%rax
   1400029be:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   1400029c3:	48 39 c2             	cmp    %rax,%rdx
   1400029c6:	0f 83 35 08 00 00    	jae    140003201 <main+0x107c>
   1400029cc:	48 8b 85 a0 08 00 00 	mov    0x8a0(%rbp),%rax
   1400029d3:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   1400029d7:	e9 25 08 00 00       	jmp    140003201 <main+0x107c>
   1400029dc:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400029e0:	48 8b 00             	mov    (%rax),%rax
   1400029e3:	48 89 85 b0 08 00 00 	mov    %rax,0x8b0(%rbp)
   1400029ea:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400029ee:	48 83 c0 08          	add    $0x8,%rax
   1400029f2:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   1400029f6:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400029fa:	0f b6 00             	movzbl (%rax),%eax
   1400029fd:	88 85 af 08 00 00    	mov    %al,0x8af(%rbp)
   140002a03:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002a07:	48 83 c0 01          	add    $0x1,%rax
   140002a0b:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002a0f:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002a13:	0f b6 00             	movzbl (%rax),%eax
   140002a16:	88 85 ae 08 00 00    	mov    %al,0x8ae(%rbp)
   140002a1c:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002a20:	48 83 c0 01          	add    $0x1,%rax
   140002a24:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002a28:	0f b6 85 af 08 00 00 	movzbl 0x8af(%rbp),%eax
   140002a2f:	48 98                	cltq
   140002a31:	48 83 c0 08          	add    $0x8,%rax
   140002a35:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   140002a3a:	0f b6 95 ae 08 00 00 	movzbl 0x8ae(%rbp),%edx
   140002a41:	48 63 d2             	movslq %edx,%rdx
   140002a44:	48 83 c2 08          	add    $0x8,%rdx
   140002a48:	48 8b 54 d5 a8       	mov    -0x58(%rbp,%rdx,8),%rdx
   140002a4d:	48 39 c2             	cmp    %rax,%rdx
   140002a50:	0f 83 ab 07 00 00    	jae    140003201 <main+0x107c>
   140002a56:	48 8b 85 b0 08 00 00 	mov    0x8b0(%rbp),%rax
   140002a5d:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002a61:	e9 9b 07 00 00       	jmp    140003201 <main+0x107c>
   140002a66:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002a6a:	48 8b 00             	mov    (%rax),%rax
   140002a6d:	48 89 85 c0 08 00 00 	mov    %rax,0x8c0(%rbp)
   140002a74:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002a78:	48 83 c0 08          	add    $0x8,%rax
   140002a7c:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002a80:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002a84:	0f b6 00             	movzbl (%rax),%eax
   140002a87:	88 85 bf 08 00 00    	mov    %al,0x8bf(%rbp)
   140002a8d:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002a91:	48 83 c0 01          	add    $0x1,%rax
   140002a95:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002a99:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002a9d:	0f b6 00             	movzbl (%rax),%eax
   140002aa0:	88 85 be 08 00 00    	mov    %al,0x8be(%rbp)
   140002aa6:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002aaa:	48 83 c0 01          	add    $0x1,%rax
   140002aae:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002ab2:	0f b6 85 bf 08 00 00 	movzbl 0x8bf(%rbp),%eax
   140002ab9:	48 98                	cltq
   140002abb:	48 83 c0 08          	add    $0x8,%rax
   140002abf:	48 8b 54 c5 a8       	mov    -0x58(%rbp,%rax,8),%rdx
   140002ac4:	0f b6 85 be 08 00 00 	movzbl 0x8be(%rbp),%eax
   140002acb:	48 98                	cltq
   140002acd:	48 83 c0 08          	add    $0x8,%rax
   140002ad1:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   140002ad6:	48 39 c2             	cmp    %rax,%rdx
   140002ad9:	0f 85 22 07 00 00    	jne    140003201 <main+0x107c>
   140002adf:	48 8b 85 c0 08 00 00 	mov    0x8c0(%rbp),%rax
   140002ae6:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002aea:	e9 12 07 00 00       	jmp    140003201 <main+0x107c>
   140002aef:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002af3:	48 8b 00             	mov    (%rax),%rax
   140002af6:	48 89 85 e0 08 00 00 	mov    %rax,0x8e0(%rbp)
   140002afd:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002b01:	48 83 c0 08          	add    $0x8,%rax
   140002b05:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002b09:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002b0d:	0f b6 00             	movzbl (%rax),%eax
   140002b10:	88 85 df 08 00 00    	mov    %al,0x8df(%rbp)
   140002b16:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002b1a:	48 83 c0 01          	add    $0x1,%rax
   140002b1e:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002b22:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002b26:	0f b6 00             	movzbl (%rax),%eax
   140002b29:	88 85 de 08 00 00    	mov    %al,0x8de(%rbp)
   140002b2f:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002b33:	48 83 c0 01          	add    $0x1,%rax
   140002b37:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002b3b:	0f b6 85 df 08 00 00 	movzbl 0x8df(%rbp),%eax
   140002b42:	48 98                	cltq
   140002b44:	48 83 c0 08          	add    $0x8,%rax
   140002b48:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   140002b4d:	0f b6 95 de 08 00 00 	movzbl 0x8de(%rbp),%edx
   140002b54:	48 63 d2             	movslq %edx,%rdx
   140002b57:	48 83 c2 08          	add    $0x8,%rdx
   140002b5b:	48 8b 54 d5 a8       	mov    -0x58(%rbp,%rdx,8),%rdx
   140002b60:	48 39 c2             	cmp    %rax,%rdx
   140002b63:	0f 82 98 06 00 00    	jb     140003201 <main+0x107c>
   140002b69:	48 8b 85 e0 08 00 00 	mov    0x8e0(%rbp),%rax
   140002b70:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002b74:	e9 88 06 00 00       	jmp    140003201 <main+0x107c>
   140002b79:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002b7d:	48 8b 00             	mov    (%rax),%rax
   140002b80:	48 89 85 d0 08 00 00 	mov    %rax,0x8d0(%rbp)
   140002b87:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002b8b:	48 83 c0 08          	add    $0x8,%rax
   140002b8f:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002b93:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002b97:	0f b6 00             	movzbl (%rax),%eax
   140002b9a:	88 85 cf 08 00 00    	mov    %al,0x8cf(%rbp)
   140002ba0:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002ba4:	48 83 c0 01          	add    $0x1,%rax
   140002ba8:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002bac:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002bb0:	0f b6 00             	movzbl (%rax),%eax
   140002bb3:	88 85 ce 08 00 00    	mov    %al,0x8ce(%rbp)
   140002bb9:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002bbd:	48 83 c0 01          	add    $0x1,%rax
   140002bc1:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002bc5:	0f b6 85 cf 08 00 00 	movzbl 0x8cf(%rbp),%eax
   140002bcc:	48 98                	cltq
   140002bce:	48 83 c0 08          	add    $0x8,%rax
   140002bd2:	48 8b 54 c5 a8       	mov    -0x58(%rbp,%rax,8),%rdx
   140002bd7:	0f b6 85 ce 08 00 00 	movzbl 0x8ce(%rbp),%eax
   140002bde:	48 98                	cltq
   140002be0:	48 83 c0 08          	add    $0x8,%rax
   140002be4:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   140002be9:	48 39 c2             	cmp    %rax,%rdx
   140002bec:	0f 82 0f 06 00 00    	jb     140003201 <main+0x107c>
   140002bf2:	48 8b 85 d0 08 00 00 	mov    0x8d0(%rbp),%rax
   140002bf9:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002bfd:	e9 ff 05 00 00       	jmp    140003201 <main+0x107c>
   140002c02:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002c06:	0f b6 00             	movzbl (%rax),%eax
   140002c09:	88 85 ed 08 00 00    	mov    %al,0x8ed(%rbp)
   140002c0f:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002c13:	48 83 c0 01          	add    $0x1,%rax
   140002c17:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002c1b:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002c1f:	0f b6 00             	movzbl (%rax),%eax
   140002c22:	88 85 ec 08 00 00    	mov    %al,0x8ec(%rbp)
   140002c28:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002c2c:	48 83 c0 01          	add    $0x1,%rax
   140002c30:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002c34:	0f b6 95 ec 08 00 00 	movzbl 0x8ec(%rbp),%edx
   140002c3b:	0f b6 85 ed 08 00 00 	movzbl 0x8ed(%rbp),%eax
   140002c42:	48 63 d2             	movslq %edx,%rdx
   140002c45:	48 83 c2 08          	add    $0x8,%rdx
   140002c49:	48 8b 54 d5 a8       	mov    -0x58(%rbp,%rdx,8),%rdx
   140002c4e:	48 98                	cltq
   140002c50:	48 83 c0 08          	add    $0x8,%rax
   140002c54:	48 89 54 c5 a8       	mov    %rdx,-0x58(%rbp,%rax,8)
   140002c59:	e9 a3 05 00 00       	jmp    140003201 <main+0x107c>
   140002c5e:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002c62:	0f b6 00             	movzbl (%rax),%eax
   140002c65:	88 85 ef 08 00 00    	mov    %al,0x8ef(%rbp)
   140002c6b:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002c6f:	48 83 c0 01          	add    $0x1,%rax
   140002c73:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002c77:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002c7b:	0f b6 00             	movzbl (%rax),%eax
   140002c7e:	88 85 ee 08 00 00    	mov    %al,0x8ee(%rbp)
   140002c84:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002c88:	48 83 c0 01          	add    $0x1,%rax
   140002c8c:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002c90:	0f b6 95 ee 08 00 00 	movzbl 0x8ee(%rbp),%edx
   140002c97:	0f b6 9d ef 08 00 00 	movzbl 0x8ef(%rbp),%ebx
   140002c9e:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   140002ca2:	48 89 c1             	mov    %rax,%rcx
   140002ca5:	e8 ff f3 ff ff       	call   1400020a9 <state__get_arg>
   140002caa:	48 63 d3             	movslq %ebx,%rdx
   140002cad:	48 83 c2 08          	add    $0x8,%rdx
   140002cb1:	48 89 44 d5 a8       	mov    %rax,-0x58(%rbp,%rdx,8)
   140002cb6:	e9 46 05 00 00       	jmp    140003201 <main+0x107c>
   140002cbb:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002cbf:	8b 00                	mov    (%rax),%eax
   140002cc1:	89 85 fc 08 00 00    	mov    %eax,0x8fc(%rbp)
   140002cc7:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002ccb:	48 83 c0 04          	add    $0x4,%rax
   140002ccf:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002cd3:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002cd7:	48 8b 00             	mov    (%rax),%rax
   140002cda:	48 89 85 f0 08 00 00 	mov    %rax,0x8f0(%rbp)
   140002ce1:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002ce5:	48 83 c0 08          	add    $0x8,%rax
   140002ce9:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002ced:	8b 85 fc 08 00 00    	mov    0x8fc(%rbp),%eax
   140002cf3:	48 83 c0 08          	add    $0x8,%rax
   140002cf7:	48 8b 95 f0 08 00 00 	mov    0x8f0(%rbp),%rdx
   140002cfe:	48 89 54 c5 a8       	mov    %rdx,-0x58(%rbp,%rax,8)
   140002d03:	e9 f9 04 00 00       	jmp    140003201 <main+0x107c>
   140002d08:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002d0c:	0f b6 00             	movzbl (%rax),%eax
   140002d0f:	88 85 0f 09 00 00    	mov    %al,0x90f(%rbp)
   140002d15:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002d19:	48 83 c0 01          	add    $0x1,%rax
   140002d1d:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002d21:	0f b6 85 0f 09 00 00 	movzbl 0x90f(%rbp),%eax
   140002d28:	48 98                	cltq
   140002d2a:	48 83 c0 08          	add    $0x8,%rax
   140002d2e:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   140002d33:	48 83 e8 01          	sub    $0x1,%rax
   140002d37:	48 89 85 00 09 00 00 	mov    %rax,0x900(%rbp)
   140002d3e:	0f b6 85 0f 09 00 00 	movzbl 0x90f(%rbp),%eax
   140002d45:	48 98                	cltq
   140002d47:	48 83 c0 08          	add    $0x8,%rax
   140002d4b:	48 8b 95 00 09 00 00 	mov    0x900(%rbp),%rdx
   140002d52:	48 89 54 c5 a8       	mov    %rdx,-0x58(%rbp,%rax,8)
   140002d57:	e9 a5 04 00 00       	jmp    140003201 <main+0x107c>
   140002d5c:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002d60:	0f b6 00             	movzbl (%rax),%eax
   140002d63:	88 85 1f 09 00 00    	mov    %al,0x91f(%rbp)
   140002d69:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002d6d:	48 83 c0 01          	add    $0x1,%rax
   140002d71:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002d75:	0f b6 85 1f 09 00 00 	movzbl 0x91f(%rbp),%eax
   140002d7c:	48 98                	cltq
   140002d7e:	48 83 c0 08          	add    $0x8,%rax
   140002d82:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   140002d87:	48 83 c0 01          	add    $0x1,%rax
   140002d8b:	48 89 85 10 09 00 00 	mov    %rax,0x910(%rbp)
   140002d92:	0f b6 85 1f 09 00 00 	movzbl 0x91f(%rbp),%eax
   140002d99:	48 98                	cltq
   140002d9b:	48 83 c0 08          	add    $0x8,%rax
   140002d9f:	48 8b 95 10 09 00 00 	mov    0x910(%rbp),%rdx
   140002da6:	48 89 54 c5 a8       	mov    %rdx,-0x58(%rbp,%rax,8)
   140002dab:	e9 51 04 00 00       	jmp    140003201 <main+0x107c>
   140002db0:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002db4:	0f b6 00             	movzbl (%rax),%eax
   140002db7:	88 85 29 09 00 00    	mov    %al,0x929(%rbp)
   140002dbd:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002dc1:	48 83 c0 01          	add    $0x1,%rax
   140002dc5:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002dc9:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002dcd:	0f b6 00             	movzbl (%rax),%eax
   140002dd0:	88 85 28 09 00 00    	mov    %al,0x928(%rbp)
   140002dd6:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002dda:	48 83 c0 01          	add    $0x1,%rax
   140002dde:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002de2:	0f b6 85 29 09 00 00 	movzbl 0x929(%rbp),%eax
   140002de9:	48 98                	cltq
   140002deb:	48 83 c0 08          	add    $0x8,%rax
   140002def:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   140002df4:	48 89 85 20 09 00 00 	mov    %rax,0x920(%rbp)
   140002dfb:	0f b6 95 28 09 00 00 	movzbl 0x928(%rbp),%edx
   140002e02:	0f b6 85 29 09 00 00 	movzbl 0x929(%rbp),%eax
   140002e09:	48 63 d2             	movslq %edx,%rdx
   140002e0c:	48 83 c2 08          	add    $0x8,%rdx
   140002e10:	48 8b 54 d5 a8       	mov    -0x58(%rbp,%rdx,8),%rdx
   140002e15:	48 98                	cltq
   140002e17:	48 83 c0 08          	add    $0x8,%rax
   140002e1b:	48 89 54 c5 a8       	mov    %rdx,-0x58(%rbp,%rax,8)
   140002e20:	0f b6 85 28 09 00 00 	movzbl 0x928(%rbp),%eax
   140002e27:	48 98                	cltq
   140002e29:	48 83 c0 08          	add    $0x8,%rax
   140002e2d:	48 8b 95 20 09 00 00 	mov    0x920(%rbp),%rdx
   140002e34:	48 89 54 c5 a8       	mov    %rdx,-0x58(%rbp,%rax,8)
   140002e39:	e9 c3 03 00 00       	jmp    140003201 <main+0x107c>
   140002e3e:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002e42:	0f b6 00             	movzbl (%rax),%eax
   140002e45:	88 85 2c 09 00 00    	mov    %al,0x92c(%rbp)
   140002e4b:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002e4f:	48 83 c0 01          	add    $0x1,%rax
   140002e53:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002e57:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002e5b:	0f b6 00             	movzbl (%rax),%eax
   140002e5e:	88 85 2b 09 00 00    	mov    %al,0x92b(%rbp)
   140002e64:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002e68:	48 83 c0 01          	add    $0x1,%rax
   140002e6c:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002e70:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002e74:	0f b6 00             	movzbl (%rax),%eax
   140002e77:	88 85 2a 09 00 00    	mov    %al,0x92a(%rbp)
   140002e7d:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002e81:	48 83 c0 01          	add    $0x1,%rax
   140002e85:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002e89:	0f b6 85 2a 09 00 00 	movzbl 0x92a(%rbp),%eax
   140002e90:	83 f8 08             	cmp    $0x8,%eax
   140002e93:	0f 84 ad 00 00 00    	je     140002f46 <main+0xdc1>
   140002e99:	83 f8 08             	cmp    $0x8,%eax
   140002e9c:	0f 8f d0 00 00 00    	jg     140002f72 <main+0xded>
   140002ea2:	83 f8 04             	cmp    $0x4,%eax
   140002ea5:	74 75                	je     140002f1c <main+0xd97>
   140002ea7:	83 f8 04             	cmp    $0x4,%eax
   140002eaa:	0f 8f c2 00 00 00    	jg     140002f72 <main+0xded>
   140002eb0:	83 f8 01             	cmp    $0x1,%eax
   140002eb3:	74 0a                	je     140002ebf <main+0xd3a>
   140002eb5:	83 f8 02             	cmp    $0x2,%eax
   140002eb8:	74 35                	je     140002eef <main+0xd6a>
   140002eba:	e9 b3 00 00 00       	jmp    140002f72 <main+0xded>
   140002ebf:	0f b6 85 2b 09 00 00 	movzbl 0x92b(%rbp),%eax
   140002ec6:	48 98                	cltq
   140002ec8:	48 83 c0 08          	add    $0x8,%rax
   140002ecc:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   140002ed1:	0f b6 00             	movzbl (%rax),%eax
   140002ed4:	0f b6 95 2c 09 00 00 	movzbl 0x92c(%rbp),%edx
   140002edb:	0f b6 c0             	movzbl %al,%eax
   140002ede:	48 63 d2             	movslq %edx,%rdx
   140002ee1:	48 83 c2 08          	add    $0x8,%rdx
   140002ee5:	48 89 44 d5 a8       	mov    %rax,-0x58(%rbp,%rdx,8)
   140002eea:	e9 a6 00 00 00       	jmp    140002f95 <main+0xe10>
   140002eef:	0f b6 85 2b 09 00 00 	movzbl 0x92b(%rbp),%eax
   140002ef6:	48 98                	cltq
   140002ef8:	48 83 c0 08          	add    $0x8,%rax
   140002efc:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   140002f01:	0f b7 00             	movzwl (%rax),%eax
   140002f04:	0f b6 95 2c 09 00 00 	movzbl 0x92c(%rbp),%edx
   140002f0b:	0f b7 c0             	movzwl %ax,%eax
   140002f0e:	48 63 d2             	movslq %edx,%rdx
   140002f11:	48 83 c2 08          	add    $0x8,%rdx
   140002f15:	48 89 44 d5 a8       	mov    %rax,-0x58(%rbp,%rdx,8)
   140002f1a:	eb 79                	jmp    140002f95 <main+0xe10>
   140002f1c:	0f b6 85 2b 09 00 00 	movzbl 0x92b(%rbp),%eax
   140002f23:	48 98                	cltq
   140002f25:	48 83 c0 08          	add    $0x8,%rax
   140002f29:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   140002f2e:	8b 10                	mov    (%rax),%edx
   140002f30:	0f b6 85 2c 09 00 00 	movzbl 0x92c(%rbp),%eax
   140002f37:	89 d2                	mov    %edx,%edx
   140002f39:	48 98                	cltq
   140002f3b:	48 83 c0 08          	add    $0x8,%rax
   140002f3f:	48 89 54 c5 a8       	mov    %rdx,-0x58(%rbp,%rax,8)
   140002f44:	eb 4f                	jmp    140002f95 <main+0xe10>
   140002f46:	0f b6 85 2b 09 00 00 	movzbl 0x92b(%rbp),%eax
   140002f4d:	48 98                	cltq
   140002f4f:	48 83 c0 08          	add    $0x8,%rax
   140002f53:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   140002f58:	48 89 c2             	mov    %rax,%rdx
   140002f5b:	0f b6 85 2c 09 00 00 	movzbl 0x92c(%rbp),%eax
   140002f62:	48 8b 12             	mov    (%rdx),%rdx
   140002f65:	48 98                	cltq
   140002f67:	48 83 c0 08          	add    $0x8,%rax
   140002f6b:	48 89 54 c5 a8       	mov    %rdx,-0x58(%rbp,%rax,8)
   140002f70:	eb 23                	jmp    140002f95 <main+0xe10>
   140002f72:	41 b8 e0 02 00 00    	mov    $0x2e0,%r8d
   140002f78:	48 8d 05 81 80 00 00 	lea    0x8081(%rip),%rax        # 14000b000 <.rdata>
   140002f7f:	48 89 c2             	mov    %rax,%rdx
   140002f82:	48 8d 05 7c 80 00 00 	lea    0x807c(%rip),%rax        # 14000b005 <.rdata+0x5>
   140002f89:	48 89 c1             	mov    %rax,%rcx
   140002f8c:	48 8b 05 f9 c2 00 00 	mov    0xc2f9(%rip),%rax        # 14000f28c <__imp__assert>
   140002f93:	ff d0                	call   *%rax
   140002f95:	e9 67 02 00 00       	jmp    140003201 <main+0x107c>
   140002f9a:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002f9e:	0f b6 00             	movzbl (%rax),%eax
   140002fa1:	88 85 2f 09 00 00    	mov    %al,0x92f(%rbp)
   140002fa7:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002fab:	48 83 c0 01          	add    $0x1,%rax
   140002faf:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002fb3:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002fb7:	0f b6 00             	movzbl (%rax),%eax
   140002fba:	88 85 2e 09 00 00    	mov    %al,0x92e(%rbp)
   140002fc0:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002fc4:	48 83 c0 01          	add    $0x1,%rax
   140002fc8:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002fcc:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002fd0:	0f b6 00             	movzbl (%rax),%eax
   140002fd3:	88 85 2d 09 00 00    	mov    %al,0x92d(%rbp)
   140002fd9:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140002fdd:	48 83 c0 01          	add    $0x1,%rax
   140002fe1:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140002fe5:	0f b6 85 2d 09 00 00 	movzbl 0x92d(%rbp),%eax
   140002fec:	83 f8 08             	cmp    $0x8,%eax
   140002fef:	0f 84 a7 00 00 00    	je     14000309c <main+0xf17>
   140002ff5:	83 f8 08             	cmp    $0x8,%eax
   140002ff8:	0f 8f c8 00 00 00    	jg     1400030c6 <main+0xf41>
   140002ffe:	83 f8 04             	cmp    $0x4,%eax
   140003001:	74 71                	je     140003074 <main+0xeef>
   140003003:	83 f8 04             	cmp    $0x4,%eax
   140003006:	0f 8f ba 00 00 00    	jg     1400030c6 <main+0xf41>
   14000300c:	83 f8 01             	cmp    $0x1,%eax
   14000300f:	74 0a                	je     14000301b <main+0xe96>
   140003011:	83 f8 02             	cmp    $0x2,%eax
   140003014:	74 35                	je     14000304b <main+0xec6>
   140003016:	e9 ab 00 00 00       	jmp    1400030c6 <main+0xf41>
   14000301b:	0f b6 85 2e 09 00 00 	movzbl 0x92e(%rbp),%eax
   140003022:	48 98                	cltq
   140003024:	48 83 c0 08          	add    $0x8,%rax
   140003028:	48 8b 54 c5 a8       	mov    -0x58(%rbp,%rax,8),%rdx
   14000302d:	0f b6 85 2f 09 00 00 	movzbl 0x92f(%rbp),%eax
   140003034:	48 98                	cltq
   140003036:	48 83 c0 08          	add    $0x8,%rax
   14000303a:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   14000303f:	48 89 c1             	mov    %rax,%rcx
   140003042:	89 d0                	mov    %edx,%eax
   140003044:	88 01                	mov    %al,(%rcx)
   140003046:	e9 9e 00 00 00       	jmp    1400030e9 <main+0xf64>
   14000304b:	0f b6 85 2e 09 00 00 	movzbl 0x92e(%rbp),%eax
   140003052:	48 98                	cltq
   140003054:	48 83 c0 08          	add    $0x8,%rax
   140003058:	48 8b 54 c5 a8       	mov    -0x58(%rbp,%rax,8),%rdx
   14000305d:	0f b6 85 2f 09 00 00 	movzbl 0x92f(%rbp),%eax
   140003064:	48 98                	cltq
   140003066:	48 83 c0 08          	add    $0x8,%rax
   14000306a:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   14000306f:	66 89 10             	mov    %dx,(%rax)
   140003072:	eb 75                	jmp    1400030e9 <main+0xf64>
   140003074:	0f b6 85 2e 09 00 00 	movzbl 0x92e(%rbp),%eax
   14000307b:	48 98                	cltq
   14000307d:	48 83 c0 08          	add    $0x8,%rax
   140003081:	48 8b 54 c5 a8       	mov    -0x58(%rbp,%rax,8),%rdx
   140003086:	0f b6 85 2f 09 00 00 	movzbl 0x92f(%rbp),%eax
   14000308d:	48 98                	cltq
   14000308f:	48 83 c0 08          	add    $0x8,%rax
   140003093:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   140003098:	89 10                	mov    %edx,(%rax)
   14000309a:	eb 4d                	jmp    1400030e9 <main+0xf64>
   14000309c:	0f b6 85 2e 09 00 00 	movzbl 0x92e(%rbp),%eax
   1400030a3:	0f b6 95 2f 09 00 00 	movzbl 0x92f(%rbp),%edx
   1400030aa:	48 63 d2             	movslq %edx,%rdx
   1400030ad:	48 83 c2 08          	add    $0x8,%rdx
   1400030b1:	48 8b 54 d5 a8       	mov    -0x58(%rbp,%rdx,8),%rdx
   1400030b6:	48 98                	cltq
   1400030b8:	48 83 c0 08          	add    $0x8,%rax
   1400030bc:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   1400030c1:	48 89 02             	mov    %rax,(%rdx)
   1400030c4:	eb 23                	jmp    1400030e9 <main+0xf64>
   1400030c6:	41 b8 f7 02 00 00    	mov    $0x2f7,%r8d
   1400030cc:	48 8d 05 2d 7f 00 00 	lea    0x7f2d(%rip),%rax        # 14000b000 <.rdata>
   1400030d3:	48 89 c2             	mov    %rax,%rdx
   1400030d6:	48 8d 05 28 7f 00 00 	lea    0x7f28(%rip),%rax        # 14000b005 <.rdata+0x5>
   1400030dd:	48 89 c1             	mov    %rax,%rcx
   1400030e0:	48 8b 05 a5 c1 00 00 	mov    0xc1a5(%rip),%rax        # 14000f28c <__imp__assert>
   1400030e7:	ff d0                	call   *%rax
   1400030e9:	e9 13 01 00 00       	jmp    140003201 <main+0x107c>
   1400030ee:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400030f2:	48 8b 00             	mov    (%rax),%rax
   1400030f5:	48 89 85 30 09 00 00 	mov    %rax,0x930(%rbp)
   1400030fc:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   140003100:	48 83 c0 08          	add    $0x8,%rax
   140003104:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140003108:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   14000310c:	48 8d 50 08          	lea    0x8(%rax),%rdx
   140003110:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   140003114:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   140003118:	48 89 10             	mov    %rdx,(%rax)
   14000311b:	48 8b 85 30 09 00 00 	mov    0x930(%rbp),%rax
   140003122:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140003126:	e9 d6 00 00 00       	jmp    140003201 <main+0x107c>
   14000312b:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000312f:	0f b7 00             	movzwl (%rax),%eax
   140003132:	66 89 85 38 09 00 00 	mov    %ax,0x938(%rbp)
   140003139:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000313d:	48 83 c0 02          	add    $0x2,%rax
   140003141:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140003145:	0f b7 95 38 09 00 00 	movzwl 0x938(%rbp),%edx
   14000314c:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   140003150:	48 89 c1             	mov    %rax,%rcx
   140003153:	e8 91 ef ff ff       	call   1400020e9 <builtin__execute>
   140003158:	e9 a4 00 00 00       	jmp    140003201 <main+0x107c>
   14000315d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   140003161:	48 83 e8 08          	sub    $0x8,%rax
   140003165:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   140003169:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   14000316d:	48 8b 00             	mov    (%rax),%rax
   140003170:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140003174:	e9 88 00 00 00       	jmp    140003201 <main+0x107c>
   140003179:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000317d:	0f b6 00             	movzbl (%rax),%eax
   140003180:	88 85 3a 09 00 00    	mov    %al,0x93a(%rbp)
   140003186:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000318a:	48 83 c0 01          	add    $0x1,%rax
   14000318e:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   140003192:	0f b6 85 3a 09 00 00 	movzbl 0x93a(%rbp),%eax
   140003199:	48 98                	cltq
   14000319b:	48 83 c0 08          	add    $0x8,%rax
   14000319f:	48 8b 44 c5 a8       	mov    -0x58(%rbp,%rax,8),%rax
   1400031a4:	48 89 c2             	mov    %rax,%rdx
   1400031a7:	48 8d 05 de 7e 00 00 	lea    0x7ede(%rip),%rax        # 14000b08c <.rdata+0x8c>
   1400031ae:	48 89 c1             	mov    %rax,%rcx
   1400031b1:	e8 9a e2 ff ff       	call   140001450 <printf>
   1400031b6:	eb 49                	jmp    140003201 <main+0x107c>
   1400031b8:	c6 85 f8 07 00 00 00 	movb   $0x0,0x7f8(%rbp)
   1400031bf:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400031c3:	0f b6 00             	movzbl (%rax),%eax
   1400031c6:	0f b6 c0             	movzbl %al,%eax
   1400031c9:	48 89 85 f0 07 00 00 	mov    %rax,0x7f0(%rbp)
   1400031d0:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   1400031d4:	48 83 c0 01          	add    $0x1,%rax
   1400031d8:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   1400031dc:	eb 23                	jmp    140003201 <main+0x107c>
   1400031de:	41 b8 12 03 00 00    	mov    $0x312,%r8d
   1400031e4:	48 8d 05 15 7e 00 00 	lea    0x7e15(%rip),%rax        # 14000b000 <.rdata>
   1400031eb:	48 89 c2             	mov    %rax,%rdx
   1400031ee:	48 8d 05 10 7e 00 00 	lea    0x7e10(%rip),%rax        # 14000b005 <.rdata+0x5>
   1400031f5:	48 89 c1             	mov    %rax,%rcx
   1400031f8:	48 8b 05 8d c0 00 00 	mov    0xc08d(%rip),%rax        # 14000f28c <__imp__assert>
   1400031ff:	ff d0                	call   *%rax
   140003201:	0f b6 85 f8 07 00 00 	movzbl 0x7f8(%rbp),%eax
   140003208:	84 c0                	test   %al,%al
   14000320a:	0f 85 a0 f0 ff ff    	jne    1400022b0 <main+0x12b>
   140003210:	48 8b 85 f0 07 00 00 	mov    0x7f0(%rbp),%rax
   140003217:	48 89 c2             	mov    %rax,%rdx
   14000321a:	48 8d 05 71 7e 00 00 	lea    0x7e71(%rip),%rax        # 14000b092 <.rdata+0x92>
   140003221:	48 89 c1             	mov    %rax,%rcx
   140003224:	e8 27 e2 ff ff       	call   140001450 <printf>
   140003229:	83 85 5c 09 00 00 01 	addl   $0x1,0x95c(%rbp)
   140003230:	8b 85 5c 09 00 00    	mov    0x95c(%rbp),%eax
   140003236:	3b 85 3c 09 00 00    	cmp    0x93c(%rbp),%eax
   14000323c:	0f 82 40 f0 ff ff    	jb     140002282 <main+0xfd>
   140003242:	48 8b 85 00 08 00 00 	mov    0x800(%rbp),%rax
   140003249:	48 89 c1             	mov    %rax,%rcx
   14000324c:	e8 37 66 00 00       	call   140009888 <free>
   140003251:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   140003255:	48 89 c1             	mov    %rax,%rcx
   140003258:	e8 2b 66 00 00       	call   140009888 <free>
   14000325d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   140003261:	48 89 c1             	mov    %rax,%rcx
   140003264:	e8 1f 66 00 00       	call   140009888 <free>
   140003269:	b8 00 00 00 00       	mov    $0x0,%eax
   14000326e:	48 81 c4 e8 09 00 00 	add    $0x9e8,%rsp
   140003275:	5b                   	pop    %rbx
   140003276:	5d                   	pop    %rbp
   140003277:	c3                   	ret
   140003278:	90                   	nop
   140003279:	90                   	nop
   14000327a:	90                   	nop
   14000327b:	90                   	nop
   14000327c:	90                   	nop
   14000327d:	90                   	nop
   14000327e:	90                   	nop
   14000327f:	90                   	nop

0000000140003280 <__do_global_dtors>:
   140003280:	48 83 ec 28          	sub    $0x28,%rsp
   140003284:	48 8b 05 75 6d 00 00 	mov    0x6d75(%rip),%rax        # 14000a000 <__data_start__>
   14000328b:	48 8b 00             	mov    (%rax),%rax
   14000328e:	48 85 c0             	test   %rax,%rax
   140003291:	74 22                	je     1400032b5 <__do_global_dtors+0x35>
   140003293:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140003298:	ff d0                	call   *%rax
   14000329a:	48 8b 05 5f 6d 00 00 	mov    0x6d5f(%rip),%rax        # 14000a000 <__data_start__>
   1400032a1:	48 8d 50 08          	lea    0x8(%rax),%rdx
   1400032a5:	48 8b 40 08          	mov    0x8(%rax),%rax
   1400032a9:	48 89 15 50 6d 00 00 	mov    %rdx,0x6d50(%rip)        # 14000a000 <__data_start__>
   1400032b0:	48 85 c0             	test   %rax,%rax
   1400032b3:	75 e3                	jne    140003298 <__do_global_dtors+0x18>
   1400032b5:	48 83 c4 28          	add    $0x28,%rsp
   1400032b9:	c3                   	ret
   1400032ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000001400032c0 <__do_global_ctors>:
   1400032c0:	56                   	push   %rsi
   1400032c1:	53                   	push   %rbx
   1400032c2:	48 83 ec 28          	sub    $0x28,%rsp
   1400032c6:	48 8b 15 53 85 00 00 	mov    0x8553(%rip),%rdx        # 14000b820 <.refptr.__CTOR_LIST__>
   1400032cd:	48 8b 02             	mov    (%rdx),%rax
   1400032d0:	83 f8 ff             	cmp    $0xffffffff,%eax
   1400032d3:	89 c1                	mov    %eax,%ecx
   1400032d5:	74 39                	je     140003310 <__do_global_ctors+0x50>
   1400032d7:	85 c9                	test   %ecx,%ecx
   1400032d9:	74 20                	je     1400032fb <__do_global_ctors+0x3b>
   1400032db:	89 c8                	mov    %ecx,%eax
   1400032dd:	83 e9 01             	sub    $0x1,%ecx
   1400032e0:	48 8d 1c c2          	lea    (%rdx,%rax,8),%rbx
   1400032e4:	48 29 c8             	sub    %rcx,%rax
   1400032e7:	48 8d 74 c2 f8       	lea    -0x8(%rdx,%rax,8),%rsi
   1400032ec:	0f 1f 40 00          	nopl   0x0(%rax)
   1400032f0:	ff 13                	call   *(%rbx)
   1400032f2:	48 83 eb 08          	sub    $0x8,%rbx
   1400032f6:	48 39 f3             	cmp    %rsi,%rbx
   1400032f9:	75 f5                	jne    1400032f0 <__do_global_ctors+0x30>
   1400032fb:	48 8d 0d 7e ff ff ff 	lea    -0x82(%rip),%rcx        # 140003280 <__do_global_dtors>
   140003302:	48 83 c4 28          	add    $0x28,%rsp
   140003306:	5b                   	pop    %rbx
   140003307:	5e                   	pop    %rsi
   140003308:	e9 03 e1 ff ff       	jmp    140001410 <atexit>
   14000330d:	0f 1f 00             	nopl   (%rax)
   140003310:	31 c0                	xor    %eax,%eax
   140003312:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140003318:	44 8d 40 01          	lea    0x1(%rax),%r8d
   14000331c:	89 c1                	mov    %eax,%ecx
   14000331e:	4a 83 3c c2 00       	cmpq   $0x0,(%rdx,%r8,8)
   140003323:	4c 89 c0             	mov    %r8,%rax
   140003326:	75 f0                	jne    140003318 <__do_global_ctors+0x58>
   140003328:	eb ad                	jmp    1400032d7 <__do_global_ctors+0x17>
   14000332a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000140003330 <__main>:
   140003330:	8b 05 fa ac 00 00    	mov    0xacfa(%rip),%eax        # 14000e030 <initialized>
   140003336:	85 c0                	test   %eax,%eax
   140003338:	74 06                	je     140003340 <__main+0x10>
   14000333a:	c3                   	ret
   14000333b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140003340:	c7 05 e6 ac 00 00 01 	movl   $0x1,0xace6(%rip)        # 14000e030 <initialized>
   140003347:	00 00 00 
   14000334a:	e9 71 ff ff ff       	jmp    1400032c0 <__do_global_ctors>
   14000334f:	90                   	nop

0000000140003350 <_setargv>:
   140003350:	31 c0                	xor    %eax,%eax
   140003352:	c3                   	ret
   140003353:	90                   	nop
   140003354:	90                   	nop
   140003355:	90                   	nop
   140003356:	90                   	nop
   140003357:	90                   	nop
   140003358:	90                   	nop
   140003359:	90                   	nop
   14000335a:	90                   	nop
   14000335b:	90                   	nop
   14000335c:	90                   	nop
   14000335d:	90                   	nop
   14000335e:	90                   	nop
   14000335f:	90                   	nop

0000000140003360 <__dyn_tls_dtor>:
   140003360:	48 83 ec 28          	sub    $0x28,%rsp
   140003364:	83 fa 03             	cmp    $0x3,%edx
   140003367:	74 17                	je     140003380 <__dyn_tls_dtor+0x20>
   140003369:	85 d2                	test   %edx,%edx
   14000336b:	74 13                	je     140003380 <__dyn_tls_dtor+0x20>
   14000336d:	b8 01 00 00 00       	mov    $0x1,%eax
   140003372:	48 83 c4 28          	add    $0x28,%rsp
   140003376:	c3                   	ret
   140003377:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   14000337e:	00 00 
   140003380:	e8 5b 0a 00 00       	call   140003de0 <__mingw_TLScallback>
   140003385:	b8 01 00 00 00       	mov    $0x1,%eax
   14000338a:	48 83 c4 28          	add    $0x28,%rsp
   14000338e:	c3                   	ret
   14000338f:	90                   	nop

0000000140003390 <__dyn_tls_init>:
   140003390:	56                   	push   %rsi
   140003391:	53                   	push   %rbx
   140003392:	48 83 ec 28          	sub    $0x28,%rsp
   140003396:	48 8b 05 63 84 00 00 	mov    0x8463(%rip),%rax        # 14000b800 <.refptr._CRT_MT>
   14000339d:	83 38 02             	cmpl   $0x2,(%rax)
   1400033a0:	74 06                	je     1400033a8 <__dyn_tls_init+0x18>
   1400033a2:	c7 00 02 00 00 00    	movl   $0x2,(%rax)
   1400033a8:	83 fa 02             	cmp    $0x2,%edx
   1400033ab:	74 13                	je     1400033c0 <__dyn_tls_init+0x30>
   1400033ad:	83 fa 01             	cmp    $0x1,%edx
   1400033b0:	74 4e                	je     140003400 <__dyn_tls_init+0x70>
   1400033b2:	b8 01 00 00 00       	mov    $0x1,%eax
   1400033b7:	48 83 c4 28          	add    $0x28,%rsp
   1400033bb:	5b                   	pop    %rbx
   1400033bc:	5e                   	pop    %rsi
   1400033bd:	c3                   	ret
   1400033be:	66 90                	xchg   %ax,%ax
   1400033c0:	48 8d 1d 91 cc 00 00 	lea    0xcc91(%rip),%rbx        # 140010058 <__xd_z>
   1400033c7:	48 8d 35 8a cc 00 00 	lea    0xcc8a(%rip),%rsi        # 140010058 <__xd_z>
   1400033ce:	48 39 de             	cmp    %rbx,%rsi
   1400033d1:	74 df                	je     1400033b2 <__dyn_tls_init+0x22>
   1400033d3:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   1400033d8:	48 8b 03             	mov    (%rbx),%rax
   1400033db:	48 85 c0             	test   %rax,%rax
   1400033de:	74 02                	je     1400033e2 <__dyn_tls_init+0x52>
   1400033e0:	ff d0                	call   *%rax
   1400033e2:	48 83 c3 08          	add    $0x8,%rbx
   1400033e6:	48 39 de             	cmp    %rbx,%rsi
   1400033e9:	75 ed                	jne    1400033d8 <__dyn_tls_init+0x48>
   1400033eb:	b8 01 00 00 00       	mov    $0x1,%eax
   1400033f0:	48 83 c4 28          	add    $0x28,%rsp
   1400033f4:	5b                   	pop    %rbx
   1400033f5:	5e                   	pop    %rsi
   1400033f6:	c3                   	ret
   1400033f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   1400033fe:	00 00 
   140003400:	e8 db 09 00 00       	call   140003de0 <__mingw_TLScallback>
   140003405:	b8 01 00 00 00       	mov    $0x1,%eax
   14000340a:	48 83 c4 28          	add    $0x28,%rsp
   14000340e:	5b                   	pop    %rbx
   14000340f:	5e                   	pop    %rsi
   140003410:	c3                   	ret
   140003411:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   140003418:	00 00 00 00 
   14000341c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000140003420 <__tlregdtor>:
   140003420:	31 c0                	xor    %eax,%eax
   140003422:	c3                   	ret
   140003423:	90                   	nop
   140003424:	90                   	nop
   140003425:	90                   	nop
   140003426:	90                   	nop
   140003427:	90                   	nop
   140003428:	90                   	nop
   140003429:	90                   	nop
   14000342a:	90                   	nop
   14000342b:	90                   	nop
   14000342c:	90                   	nop
   14000342d:	90                   	nop
   14000342e:	90                   	nop
   14000342f:	90                   	nop

0000000140003430 <_matherr>:
   140003430:	56                   	push   %rsi
   140003431:	53                   	push   %rbx
   140003432:	48 83 ec 78          	sub    $0x78,%rsp
   140003436:	0f 29 74 24 40       	movaps %xmm6,0x40(%rsp)
   14000343b:	0f 29 7c 24 50       	movaps %xmm7,0x50(%rsp)
   140003440:	44 0f 29 44 24 60    	movaps %xmm8,0x60(%rsp)
   140003446:	83 39 06             	cmpl   $0x6,(%rcx)
   140003449:	0f 87 cd 00 00 00    	ja     14000351c <_matherr+0xec>
   14000344f:	8b 01                	mov    (%rcx),%eax
   140003451:	48 8d 15 6c 7e 00 00 	lea    0x7e6c(%rip),%rdx        # 14000b2c4 <.rdata+0x124>
   140003458:	48 63 04 82          	movslq (%rdx,%rax,4),%rax
   14000345c:	48 01 d0             	add    %rdx,%rax
   14000345f:	ff e0                	jmp    *%rax
   140003461:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140003468:	48 8d 1d 50 7d 00 00 	lea    0x7d50(%rip),%rbx        # 14000b1bf <.rdata+0x1f>
   14000346f:	48 8b 71 08          	mov    0x8(%rcx),%rsi
   140003473:	f2 44 0f 10 41 20    	movsd  0x20(%rcx),%xmm8
   140003479:	f2 0f 10 79 18       	movsd  0x18(%rcx),%xmm7
   14000347e:	f2 0f 10 71 10       	movsd  0x10(%rcx),%xmm6
   140003483:	b9 02 00 00 00       	mov    $0x2,%ecx
   140003488:	e8 33 5e 00 00       	call   1400092c0 <__acrt_iob_func>
   14000348d:	f2 44 0f 11 44 24 30 	movsd  %xmm8,0x30(%rsp)
   140003494:	49 89 f1             	mov    %rsi,%r9
   140003497:	49 89 d8             	mov    %rbx,%r8
   14000349a:	f2 0f 11 7c 24 28    	movsd  %xmm7,0x28(%rsp)
   1400034a0:	48 89 c1             	mov    %rax,%rcx
   1400034a3:	f2 0f 11 74 24 20    	movsd  %xmm6,0x20(%rsp)
   1400034a9:	48 8d 15 e8 7d 00 00 	lea    0x7de8(%rip),%rdx        # 14000b298 <.rdata+0xf8>
   1400034b0:	e8 c3 63 00 00       	call   140009878 <fprintf>
   1400034b5:	90                   	nop
   1400034b6:	0f 28 74 24 40       	movaps 0x40(%rsp),%xmm6
   1400034bb:	31 c0                	xor    %eax,%eax
   1400034bd:	0f 28 7c 24 50       	movaps 0x50(%rsp),%xmm7
   1400034c2:	44 0f 28 44 24 60    	movaps 0x60(%rsp),%xmm8
   1400034c8:	48 83 c4 78          	add    $0x78,%rsp
   1400034cc:	5b                   	pop    %rbx
   1400034cd:	5e                   	pop    %rsi
   1400034ce:	c3                   	ret
   1400034cf:	90                   	nop
   1400034d0:	48 8d 1d c9 7c 00 00 	lea    0x7cc9(%rip),%rbx        # 14000b1a0 <.rdata>
   1400034d7:	eb 96                	jmp    14000346f <_matherr+0x3f>
   1400034d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   1400034e0:	48 8d 1d 19 7d 00 00 	lea    0x7d19(%rip),%rbx        # 14000b200 <.rdata+0x60>
   1400034e7:	eb 86                	jmp    14000346f <_matherr+0x3f>
   1400034e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   1400034f0:	48 8d 1d e9 7c 00 00 	lea    0x7ce9(%rip),%rbx        # 14000b1e0 <.rdata+0x40>
   1400034f7:	e9 73 ff ff ff       	jmp    14000346f <_matherr+0x3f>
   1400034fc:	0f 1f 40 00          	nopl   0x0(%rax)
   140003500:	48 8d 1d 49 7d 00 00 	lea    0x7d49(%rip),%rbx        # 14000b250 <.rdata+0xb0>
   140003507:	e9 63 ff ff ff       	jmp    14000346f <_matherr+0x3f>
   14000350c:	0f 1f 40 00          	nopl   0x0(%rax)
   140003510:	48 8d 1d 11 7d 00 00 	lea    0x7d11(%rip),%rbx        # 14000b228 <.rdata+0x88>
   140003517:	e9 53 ff ff ff       	jmp    14000346f <_matherr+0x3f>
   14000351c:	48 8d 1d 63 7d 00 00 	lea    0x7d63(%rip),%rbx        # 14000b286 <.rdata+0xe6>
   140003523:	e9 47 ff ff ff       	jmp    14000346f <_matherr+0x3f>
   140003528:	90                   	nop
   140003529:	90                   	nop
   14000352a:	90                   	nop
   14000352b:	90                   	nop
   14000352c:	90                   	nop
   14000352d:	90                   	nop
   14000352e:	90                   	nop
   14000352f:	90                   	nop

0000000140003530 <_fpreset>:
   140003530:	db e3                	fninit
   140003532:	c3                   	ret
   140003533:	90                   	nop
   140003534:	90                   	nop
   140003535:	90                   	nop
   140003536:	90                   	nop
   140003537:	90                   	nop
   140003538:	90                   	nop
   140003539:	90                   	nop
   14000353a:	90                   	nop
   14000353b:	90                   	nop
   14000353c:	90                   	nop
   14000353d:	90                   	nop
   14000353e:	90                   	nop
   14000353f:	90                   	nop

0000000140003540 <__report_error>:
   140003540:	56                   	push   %rsi
   140003541:	53                   	push   %rbx
   140003542:	48 83 ec 38          	sub    $0x38,%rsp
   140003546:	48 8d 44 24 58       	lea    0x58(%rsp),%rax
   14000354b:	48 89 cb             	mov    %rcx,%rbx
   14000354e:	b9 02 00 00 00       	mov    $0x2,%ecx
   140003553:	48 89 54 24 58       	mov    %rdx,0x58(%rsp)
   140003558:	4c 89 44 24 60       	mov    %r8,0x60(%rsp)
   14000355d:	4c 89 4c 24 68       	mov    %r9,0x68(%rsp)
   140003562:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
   140003567:	e8 54 5d 00 00       	call   1400092c0 <__acrt_iob_func>
   14000356c:	41 b8 1b 00 00 00    	mov    $0x1b,%r8d
   140003572:	ba 01 00 00 00       	mov    $0x1,%edx
   140003577:	48 8d 0d 62 7d 00 00 	lea    0x7d62(%rip),%rcx        # 14000b2e0 <.rdata>
   14000357e:	49 89 c1             	mov    %rax,%r9
   140003581:	e8 0a 63 00 00       	call   140009890 <fwrite>
   140003586:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
   14000358b:	b9 02 00 00 00       	mov    $0x2,%ecx
   140003590:	e8 2b 5d 00 00       	call   1400092c0 <__acrt_iob_func>
   140003595:	48 89 da             	mov    %rbx,%rdx
   140003598:	48 89 c1             	mov    %rax,%rcx
   14000359b:	49 89 f0             	mov    %rsi,%r8
   14000359e:	e8 35 63 00 00       	call   1400098d8 <vfprintf>
   1400035a3:	e8 c0 62 00 00       	call   140009868 <abort>
   1400035a8:	90                   	nop
   1400035a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000001400035b0 <mark_section_writable>:
   1400035b0:	57                   	push   %rdi
   1400035b1:	56                   	push   %rsi
   1400035b2:	53                   	push   %rbx
   1400035b3:	48 83 ec 50          	sub    $0x50,%rsp
   1400035b7:	48 63 35 d6 aa 00 00 	movslq 0xaad6(%rip),%rsi        # 14000e094 <maxSections>
   1400035be:	85 f6                	test   %esi,%esi
   1400035c0:	48 89 cb             	mov    %rcx,%rbx
   1400035c3:	0f 8e 17 01 00 00    	jle    1400036e0 <mark_section_writable+0x130>
   1400035c9:	48 8b 05 c8 aa 00 00 	mov    0xaac8(%rip),%rax        # 14000e098 <the_secs>
   1400035d0:	45 31 c9             	xor    %r9d,%r9d
   1400035d3:	48 83 c0 18          	add    $0x18,%rax
   1400035d7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   1400035de:	00 00 
   1400035e0:	4c 8b 00             	mov    (%rax),%r8
   1400035e3:	4c 39 c3             	cmp    %r8,%rbx
   1400035e6:	72 13                	jb     1400035fb <mark_section_writable+0x4b>
   1400035e8:	48 8b 50 08          	mov    0x8(%rax),%rdx
   1400035ec:	8b 52 08             	mov    0x8(%rdx),%edx
   1400035ef:	49 01 d0             	add    %rdx,%r8
   1400035f2:	4c 39 c3             	cmp    %r8,%rbx
   1400035f5:	0f 82 8a 00 00 00    	jb     140003685 <mark_section_writable+0xd5>
   1400035fb:	41 83 c1 01          	add    $0x1,%r9d
   1400035ff:	48 83 c0 28          	add    $0x28,%rax
   140003603:	41 39 f1             	cmp    %esi,%r9d
   140003606:	75 d8                	jne    1400035e0 <mark_section_writable+0x30>
   140003608:	48 89 d9             	mov    %rbx,%rcx
   14000360b:	e8 10 0a 00 00       	call   140004020 <__mingw_GetSectionForAddress>
   140003610:	48 85 c0             	test   %rax,%rax
   140003613:	48 89 c7             	mov    %rax,%rdi
   140003616:	0f 84 e6 00 00 00    	je     140003702 <mark_section_writable+0x152>
   14000361c:	48 8b 05 75 aa 00 00 	mov    0xaa75(%rip),%rax        # 14000e098 <the_secs>
   140003623:	48 8d 1c b6          	lea    (%rsi,%rsi,4),%rbx
   140003627:	48 c1 e3 03          	shl    $0x3,%rbx
   14000362b:	48 01 d8             	add    %rbx,%rax
   14000362e:	48 89 78 20          	mov    %rdi,0x20(%rax)
   140003632:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   140003638:	e8 23 0b 00 00       	call   140004160 <_GetPEImageBase>
   14000363d:	8b 57 0c             	mov    0xc(%rdi),%edx
   140003640:	41 b8 30 00 00 00    	mov    $0x30,%r8d
   140003646:	48 8d 0c 10          	lea    (%rax,%rdx,1),%rcx
   14000364a:	48 8b 05 47 aa 00 00 	mov    0xaa47(%rip),%rax        # 14000e098 <the_secs>
   140003651:	48 8d 54 24 20       	lea    0x20(%rsp),%rdx
   140003656:	48 89 4c 18 18       	mov    %rcx,0x18(%rax,%rbx,1)
   14000365b:	ff 15 cb bb 00 00    	call   *0xbbcb(%rip)        # 14000f22c <__imp_VirtualQuery>
   140003661:	48 85 c0             	test   %rax,%rax
   140003664:	0f 84 7d 00 00 00    	je     1400036e7 <mark_section_writable+0x137>
   14000366a:	8b 44 24 44          	mov    0x44(%rsp),%eax
   14000366e:	8d 50 c0             	lea    -0x40(%rax),%edx
   140003671:	83 e2 bf             	and    $0xffffffbf,%edx
   140003674:	74 08                	je     14000367e <mark_section_writable+0xce>
   140003676:	8d 50 fc             	lea    -0x4(%rax),%edx
   140003679:	83 e2 fb             	and    $0xfffffffb,%edx
   14000367c:	75 12                	jne    140003690 <mark_section_writable+0xe0>
   14000367e:	83 05 0f aa 00 00 01 	addl   $0x1,0xaa0f(%rip)        # 14000e094 <maxSections>
   140003685:	48 83 c4 50          	add    $0x50,%rsp
   140003689:	5b                   	pop    %rbx
   14000368a:	5e                   	pop    %rsi
   14000368b:	5f                   	pop    %rdi
   14000368c:	c3                   	ret
   14000368d:	0f 1f 00             	nopl   (%rax)
   140003690:	83 f8 02             	cmp    $0x2,%eax
   140003693:	41 b8 40 00 00 00    	mov    $0x40,%r8d
   140003699:	b8 04 00 00 00       	mov    $0x4,%eax
   14000369e:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
   1400036a3:	44 0f 44 c0          	cmove  %eax,%r8d
   1400036a7:	48 8b 54 24 38       	mov    0x38(%rsp),%rdx
   1400036ac:	48 03 1d e5 a9 00 00 	add    0xa9e5(%rip),%rbx        # 14000e098 <the_secs>
   1400036b3:	49 89 d9             	mov    %rbx,%r9
   1400036b6:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
   1400036ba:	48 89 53 10          	mov    %rdx,0x10(%rbx)
   1400036be:	ff 15 60 bb 00 00    	call   *0xbb60(%rip)        # 14000f224 <__imp_VirtualProtect>
   1400036c4:	85 c0                	test   %eax,%eax
   1400036c6:	75 b6                	jne    14000367e <mark_section_writable+0xce>
   1400036c8:	ff 15 16 bb 00 00    	call   *0xbb16(%rip)        # 14000f1e4 <__imp_GetLastError>
   1400036ce:	48 8d 0d 83 7c 00 00 	lea    0x7c83(%rip),%rcx        # 14000b358 <.rdata+0x78>
   1400036d5:	89 c2                	mov    %eax,%edx
   1400036d7:	e8 64 fe ff ff       	call   140003540 <__report_error>
   1400036dc:	0f 1f 40 00          	nopl   0x0(%rax)
   1400036e0:	31 f6                	xor    %esi,%esi
   1400036e2:	e9 21 ff ff ff       	jmp    140003608 <mark_section_writable+0x58>
   1400036e7:	48 8b 05 aa a9 00 00 	mov    0xa9aa(%rip),%rax        # 14000e098 <the_secs>
   1400036ee:	48 8d 0d 2b 7c 00 00 	lea    0x7c2b(%rip),%rcx        # 14000b320 <.rdata+0x40>
   1400036f5:	8b 57 08             	mov    0x8(%rdi),%edx
   1400036f8:	4c 8b 44 18 18       	mov    0x18(%rax,%rbx,1),%r8
   1400036fd:	e8 3e fe ff ff       	call   140003540 <__report_error>
   140003702:	48 8d 0d f7 7b 00 00 	lea    0x7bf7(%rip),%rcx        # 14000b300 <.rdata+0x20>
   140003709:	48 89 da             	mov    %rbx,%rdx
   14000370c:	e8 2f fe ff ff       	call   140003540 <__report_error>
   140003711:	90                   	nop
   140003712:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   140003719:	00 00 00 00 
   14000371d:	0f 1f 00             	nopl   (%rax)

0000000140003720 <_pei386_runtime_relocator>:
   140003720:	55                   	push   %rbp
   140003721:	41 57                	push   %r15
   140003723:	41 56                	push   %r14
   140003725:	41 55                	push   %r13
   140003727:	41 54                	push   %r12
   140003729:	57                   	push   %rdi
   14000372a:	56                   	push   %rsi
   14000372b:	53                   	push   %rbx
   14000372c:	48 83 ec 48          	sub    $0x48,%rsp
   140003730:	48 8d 6c 24 40       	lea    0x40(%rsp),%rbp
   140003735:	8b 3d 55 a9 00 00    	mov    0xa955(%rip),%edi        # 14000e090 <was_init.0>
   14000373b:	85 ff                	test   %edi,%edi
   14000373d:	74 11                	je     140003750 <_pei386_runtime_relocator+0x30>
   14000373f:	48 8d 65 08          	lea    0x8(%rbp),%rsp
   140003743:	5b                   	pop    %rbx
   140003744:	5e                   	pop    %rsi
   140003745:	5f                   	pop    %rdi
   140003746:	41 5c                	pop    %r12
   140003748:	41 5d                	pop    %r13
   14000374a:	41 5e                	pop    %r14
   14000374c:	41 5f                	pop    %r15
   14000374e:	5d                   	pop    %rbp
   14000374f:	c3                   	ret
   140003750:	c7 05 36 a9 00 00 01 	movl   $0x1,0xa936(%rip)        # 14000e090 <was_init.0>
   140003757:	00 00 00 
   14000375a:	e8 41 09 00 00       	call   1400040a0 <__mingw_GetSectionCount>
   14000375f:	48 98                	cltq
   140003761:	48 8d 04 80          	lea    (%rax,%rax,4),%rax
   140003765:	48 8d 04 c5 0f 00 00 	lea    0xf(,%rax,8),%rax
   14000376c:	00 
   14000376d:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
   140003771:	e8 8a 0b 00 00       	call   140004300 <___chkstk_ms>
   140003776:	4c 8b 2d b3 80 00 00 	mov    0x80b3(%rip),%r13        # 14000b830 <.refptr.__RUNTIME_PSEUDO_RELOC_LIST_END__>
   14000377d:	c7 05 0d a9 00 00 00 	movl   $0x0,0xa90d(%rip)        # 14000e094 <maxSections>
   140003784:	00 00 00 
   140003787:	48 8b 1d b2 80 00 00 	mov    0x80b2(%rip),%rbx        # 14000b840 <.refptr.__RUNTIME_PSEUDO_RELOC_LIST__>
   14000378e:	48 29 c4             	sub    %rax,%rsp
   140003791:	48 8d 44 24 30       	lea    0x30(%rsp),%rax
   140003796:	48 89 05 fb a8 00 00 	mov    %rax,0xa8fb(%rip)        # 14000e098 <the_secs>
   14000379d:	4c 89 e8             	mov    %r13,%rax
   1400037a0:	48 29 d8             	sub    %rbx,%rax
   1400037a3:	48 83 f8 07          	cmp    $0x7,%rax
   1400037a7:	7e 96                	jle    14000373f <_pei386_runtime_relocator+0x1f>
   1400037a9:	48 83 f8 0b          	cmp    $0xb,%rax
   1400037ad:	8b 13                	mov    (%rbx),%edx
   1400037af:	0f 8f 83 01 00 00    	jg     140003938 <_pei386_runtime_relocator+0x218>
   1400037b5:	8b 03                	mov    (%rbx),%eax
   1400037b7:	85 c0                	test   %eax,%eax
   1400037b9:	0f 85 71 02 00 00    	jne    140003a30 <_pei386_runtime_relocator+0x310>
   1400037bf:	8b 43 04             	mov    0x4(%rbx),%eax
   1400037c2:	85 c0                	test   %eax,%eax
   1400037c4:	0f 85 66 02 00 00    	jne    140003a30 <_pei386_runtime_relocator+0x310>
   1400037ca:	8b 53 08             	mov    0x8(%rbx),%edx
   1400037cd:	83 fa 01             	cmp    $0x1,%edx
   1400037d0:	0f 85 9c 02 00 00    	jne    140003a72 <_pei386_runtime_relocator+0x352>
   1400037d6:	48 83 c3 0c          	add    $0xc,%rbx
   1400037da:	4c 39 eb             	cmp    %r13,%rbx
   1400037dd:	0f 83 5c ff ff ff    	jae    14000373f <_pei386_runtime_relocator+0x1f>
   1400037e3:	4c 8b 25 76 80 00 00 	mov    0x8076(%rip),%r12        # 14000b860 <.refptr.__image_base__>
   1400037ea:	49 bf ff ff ff 7f ff 	movabs $0xffffffff7fffffff,%r15
   1400037f1:	ff ff ff 
   1400037f4:	eb 5d                	jmp    140003853 <_pei386_runtime_relocator+0x133>
   1400037f6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   1400037fd:	00 00 00 
   140003800:	41 0f b6 36          	movzbl (%r14),%esi
   140003804:	81 e1 c0 00 00 00    	and    $0xc0,%ecx
   14000380a:	40 84 f6             	test   %sil,%sil
   14000380d:	0f 89 05 02 00 00    	jns    140003a18 <_pei386_runtime_relocator+0x2f8>
   140003813:	48 81 ce 00 ff ff ff 	or     $0xffffffffffffff00,%rsi
   14000381a:	48 29 c6             	sub    %rax,%rsi
   14000381d:	4c 01 ce             	add    %r9,%rsi
   140003820:	85 c9                	test   %ecx,%ecx
   140003822:	75 17                	jne    14000383b <_pei386_runtime_relocator+0x11b>
   140003824:	48 81 fe ff 00 00 00 	cmp    $0xff,%rsi
   14000382b:	0f 8f 4e 01 00 00    	jg     14000397f <_pei386_runtime_relocator+0x25f>
   140003831:	48 83 fe 80          	cmp    $0xffffffffffffff80,%rsi
   140003835:	0f 8c 44 01 00 00    	jl     14000397f <_pei386_runtime_relocator+0x25f>
   14000383b:	4c 89 f1             	mov    %r14,%rcx
   14000383e:	e8 6d fd ff ff       	call   1400035b0 <mark_section_writable>
   140003843:	41 88 36             	mov    %sil,(%r14)
   140003846:	48 83 c3 0c          	add    $0xc,%rbx
   14000384a:	4c 39 eb             	cmp    %r13,%rbx
   14000384d:	0f 83 8d 00 00 00    	jae    1400038e0 <_pei386_runtime_relocator+0x1c0>
   140003853:	8b 4b 08             	mov    0x8(%rbx),%ecx
   140003856:	8b 03                	mov    (%rbx),%eax
   140003858:	44 8b 43 04          	mov    0x4(%rbx),%r8d
   14000385c:	0f b6 d1             	movzbl %cl,%edx
   14000385f:	4c 01 e0             	add    %r12,%rax
   140003862:	83 fa 20             	cmp    $0x20,%edx
   140003865:	4c 8b 08             	mov    (%rax),%r9
   140003868:	4f 8d 34 20          	lea    (%r8,%r12,1),%r14
   14000386c:	0f 84 26 01 00 00    	je     140003998 <_pei386_runtime_relocator+0x278>
   140003872:	0f 87 e8 00 00 00    	ja     140003960 <_pei386_runtime_relocator+0x240>
   140003878:	83 fa 08             	cmp    $0x8,%edx
   14000387b:	74 83                	je     140003800 <_pei386_runtime_relocator+0xe0>
   14000387d:	83 fa 10             	cmp    $0x10,%edx
   140003880:	0f 85 e0 01 00 00    	jne    140003a66 <_pei386_runtime_relocator+0x346>
   140003886:	41 0f b7 36          	movzwl (%r14),%esi
   14000388a:	81 e1 c0 00 00 00    	and    $0xc0,%ecx
   140003890:	66 85 f6             	test   %si,%si
   140003893:	0f 89 67 01 00 00    	jns    140003a00 <_pei386_runtime_relocator+0x2e0>
   140003899:	48 81 ce 00 00 ff ff 	or     $0xffffffffffff0000,%rsi
   1400038a0:	48 29 c6             	sub    %rax,%rsi
   1400038a3:	4c 01 ce             	add    %r9,%rsi
   1400038a6:	85 c9                	test   %ecx,%ecx
   1400038a8:	75 1a                	jne    1400038c4 <_pei386_runtime_relocator+0x1a4>
   1400038aa:	48 81 fe 00 80 ff ff 	cmp    $0xffffffffffff8000,%rsi
   1400038b1:	0f 8c c8 00 00 00    	jl     14000397f <_pei386_runtime_relocator+0x25f>
   1400038b7:	48 81 fe ff ff 00 00 	cmp    $0xffff,%rsi
   1400038be:	0f 8f bb 00 00 00    	jg     14000397f <_pei386_runtime_relocator+0x25f>
   1400038c4:	4c 89 f1             	mov    %r14,%rcx
   1400038c7:	48 83 c3 0c          	add    $0xc,%rbx
   1400038cb:	e8 e0 fc ff ff       	call   1400035b0 <mark_section_writable>
   1400038d0:	4c 39 eb             	cmp    %r13,%rbx
   1400038d3:	66 41 89 36          	mov    %si,(%r14)
   1400038d7:	0f 82 76 ff ff ff    	jb     140003853 <_pei386_runtime_relocator+0x133>
   1400038dd:	0f 1f 00             	nopl   (%rax)
   1400038e0:	8b 15 ae a7 00 00    	mov    0xa7ae(%rip),%edx        # 14000e094 <maxSections>
   1400038e6:	85 d2                	test   %edx,%edx
   1400038e8:	0f 8e 51 fe ff ff    	jle    14000373f <_pei386_runtime_relocator+0x1f>
   1400038ee:	48 8b 35 2f b9 00 00 	mov    0xb92f(%rip),%rsi        # 14000f224 <__imp_VirtualProtect>
   1400038f5:	4c 8d 65 fc          	lea    -0x4(%rbp),%r12
   1400038f9:	31 db                	xor    %ebx,%ebx
   1400038fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140003900:	48 8b 05 91 a7 00 00 	mov    0xa791(%rip),%rax        # 14000e098 <the_secs>
   140003907:	48 01 d8             	add    %rbx,%rax
   14000390a:	44 8b 00             	mov    (%rax),%r8d
   14000390d:	45 85 c0             	test   %r8d,%r8d
   140003910:	74 0d                	je     14000391f <_pei386_runtime_relocator+0x1ff>
   140003912:	48 8b 50 10          	mov    0x10(%rax),%rdx
   140003916:	4d 89 e1             	mov    %r12,%r9
   140003919:	48 8b 48 08          	mov    0x8(%rax),%rcx
   14000391d:	ff d6                	call   *%rsi
   14000391f:	83 c7 01             	add    $0x1,%edi
   140003922:	48 83 c3 28          	add    $0x28,%rbx
   140003926:	3b 3d 68 a7 00 00    	cmp    0xa768(%rip),%edi        # 14000e094 <maxSections>
   14000392c:	7c d2                	jl     140003900 <_pei386_runtime_relocator+0x1e0>
   14000392e:	e9 0c fe ff ff       	jmp    14000373f <_pei386_runtime_relocator+0x1f>
   140003933:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140003938:	85 d2                	test   %edx,%edx
   14000393a:	0f 85 f0 00 00 00    	jne    140003a30 <_pei386_runtime_relocator+0x310>
   140003940:	8b 43 04             	mov    0x4(%rbx),%eax
   140003943:	89 c2                	mov    %eax,%edx
   140003945:	0b 53 08             	or     0x8(%rbx),%edx
   140003948:	0f 85 74 fe ff ff    	jne    1400037c2 <_pei386_runtime_relocator+0xa2>
   14000394e:	48 83 c3 0c          	add    $0xc,%rbx
   140003952:	e9 5e fe ff ff       	jmp    1400037b5 <_pei386_runtime_relocator+0x95>
   140003957:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   14000395e:	00 00 
   140003960:	83 fa 40             	cmp    $0x40,%edx
   140003963:	0f 85 fd 00 00 00    	jne    140003a66 <_pei386_runtime_relocator+0x346>
   140003969:	49 8b 36             	mov    (%r14),%rsi
   14000396c:	48 29 c6             	sub    %rax,%rsi
   14000396f:	4c 01 ce             	add    %r9,%rsi
   140003972:	81 e1 c0 00 00 00    	and    $0xc0,%ecx
   140003978:	75 66                	jne    1400039e0 <_pei386_runtime_relocator+0x2c0>
   14000397a:	48 85 f6             	test   %rsi,%rsi
   14000397d:	78 61                	js     1400039e0 <_pei386_runtime_relocator+0x2c0>
   14000397f:	48 89 74 24 20       	mov    %rsi,0x20(%rsp)
   140003984:	48 8d 0d 5d 7a 00 00 	lea    0x7a5d(%rip),%rcx        # 14000b3e8 <.rdata+0x108>
   14000398b:	4d 89 f0             	mov    %r14,%r8
   14000398e:	e8 ad fb ff ff       	call   140003540 <__report_error>
   140003993:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140003998:	41 8b 36             	mov    (%r14),%esi
   14000399b:	81 e1 c0 00 00 00    	and    $0xc0,%ecx
   1400039a1:	85 f6                	test   %esi,%esi
   1400039a3:	79 4b                	jns    1400039f0 <_pei386_runtime_relocator+0x2d0>
   1400039a5:	49 bb 00 00 00 00 ff 	movabs $0xffffffff00000000,%r11
   1400039ac:	ff ff ff 
   1400039af:	4c 09 de             	or     %r11,%rsi
   1400039b2:	48 29 c6             	sub    %rax,%rsi
   1400039b5:	4c 01 ce             	add    %r9,%rsi
   1400039b8:	85 c9                	test   %ecx,%ecx
   1400039ba:	75 0f                	jne    1400039cb <_pei386_runtime_relocator+0x2ab>
   1400039bc:	4c 39 fe             	cmp    %r15,%rsi
   1400039bf:	7e be                	jle    14000397f <_pei386_runtime_relocator+0x25f>
   1400039c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   1400039c6:	48 39 c6             	cmp    %rax,%rsi
   1400039c9:	7f b4                	jg     14000397f <_pei386_runtime_relocator+0x25f>
   1400039cb:	4c 89 f1             	mov    %r14,%rcx
   1400039ce:	e8 dd fb ff ff       	call   1400035b0 <mark_section_writable>
   1400039d3:	41 89 36             	mov    %esi,(%r14)
   1400039d6:	e9 6b fe ff ff       	jmp    140003846 <_pei386_runtime_relocator+0x126>
   1400039db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   1400039e0:	4c 89 f1             	mov    %r14,%rcx
   1400039e3:	e8 c8 fb ff ff       	call   1400035b0 <mark_section_writable>
   1400039e8:	49 89 36             	mov    %rsi,(%r14)
   1400039eb:	e9 56 fe ff ff       	jmp    140003846 <_pei386_runtime_relocator+0x126>
   1400039f0:	48 29 c6             	sub    %rax,%rsi
   1400039f3:	4c 01 ce             	add    %r9,%rsi
   1400039f6:	85 c9                	test   %ecx,%ecx
   1400039f8:	74 c2                	je     1400039bc <_pei386_runtime_relocator+0x29c>
   1400039fa:	eb cf                	jmp    1400039cb <_pei386_runtime_relocator+0x2ab>
   1400039fc:	0f 1f 40 00          	nopl   0x0(%rax)
   140003a00:	48 29 c6             	sub    %rax,%rsi
   140003a03:	4c 01 ce             	add    %r9,%rsi
   140003a06:	85 c9                	test   %ecx,%ecx
   140003a08:	0f 84 9c fe ff ff    	je     1400038aa <_pei386_runtime_relocator+0x18a>
   140003a0e:	e9 b1 fe ff ff       	jmp    1400038c4 <_pei386_runtime_relocator+0x1a4>
   140003a13:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140003a18:	48 29 c6             	sub    %rax,%rsi
   140003a1b:	4c 01 ce             	add    %r9,%rsi
   140003a1e:	85 c9                	test   %ecx,%ecx
   140003a20:	0f 84 fe fd ff ff    	je     140003824 <_pei386_runtime_relocator+0x104>
   140003a26:	e9 10 fe ff ff       	jmp    14000383b <_pei386_runtime_relocator+0x11b>
   140003a2b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140003a30:	4c 39 eb             	cmp    %r13,%rbx
   140003a33:	0f 83 06 fd ff ff    	jae    14000373f <_pei386_runtime_relocator+0x1f>
   140003a39:	4c 8b 35 20 7e 00 00 	mov    0x7e20(%rip),%r14        # 14000b860 <.refptr.__image_base__>
   140003a40:	8b 73 04             	mov    0x4(%rbx),%esi
   140003a43:	48 83 c3 08          	add    $0x8,%rbx
   140003a47:	44 8b 63 f8          	mov    -0x8(%rbx),%r12d
   140003a4b:	4c 01 f6             	add    %r14,%rsi
   140003a4e:	44 03 26             	add    (%rsi),%r12d
   140003a51:	48 89 f1             	mov    %rsi,%rcx
   140003a54:	e8 57 fb ff ff       	call   1400035b0 <mark_section_writable>
   140003a59:	4c 39 eb             	cmp    %r13,%rbx
   140003a5c:	44 89 26             	mov    %r12d,(%rsi)
   140003a5f:	72 df                	jb     140003a40 <_pei386_runtime_relocator+0x320>
   140003a61:	e9 7a fe ff ff       	jmp    1400038e0 <_pei386_runtime_relocator+0x1c0>
   140003a66:	48 8d 0d 4b 79 00 00 	lea    0x794b(%rip),%rcx        # 14000b3b8 <.rdata+0xd8>
   140003a6d:	e8 ce fa ff ff       	call   140003540 <__report_error>
   140003a72:	48 8d 0d 07 79 00 00 	lea    0x7907(%rip),%rcx        # 14000b380 <.rdata+0xa0>
   140003a79:	e8 c2 fa ff ff       	call   140003540 <__report_error>
   140003a7e:	90                   	nop
   140003a7f:	90                   	nop

0000000140003a80 <__mingw_raise_matherr>:
   140003a80:	48 83 ec 58          	sub    $0x58,%rsp
   140003a84:	48 8b 05 15 a6 00 00 	mov    0xa615(%rip),%rax        # 14000e0a0 <stUserMathErr>
   140003a8b:	48 85 c0             	test   %rax,%rax
   140003a8e:	66 0f 14 d3          	unpcklpd %xmm3,%xmm2
   140003a92:	74 25                	je     140003ab9 <__mingw_raise_matherr+0x39>
   140003a94:	f2 0f 10 84 24 80 00 	movsd  0x80(%rsp),%xmm0
   140003a9b:	00 00 
   140003a9d:	89 4c 24 20          	mov    %ecx,0x20(%rsp)
   140003aa1:	48 8d 4c 24 20       	lea    0x20(%rsp),%rcx
   140003aa6:	48 89 54 24 28       	mov    %rdx,0x28(%rsp)
   140003aab:	0f 29 54 24 30       	movaps %xmm2,0x30(%rsp)
   140003ab0:	f2 0f 11 44 24 40    	movsd  %xmm0,0x40(%rsp)
   140003ab6:	ff d0                	call   *%rax
   140003ab8:	90                   	nop
   140003ab9:	48 83 c4 58          	add    $0x58,%rsp
   140003abd:	c3                   	ret
   140003abe:	66 90                	xchg   %ax,%ax

0000000140003ac0 <__mingw_setusermatherr>:
   140003ac0:	48 89 0d d9 a5 00 00 	mov    %rcx,0xa5d9(%rip)        # 14000e0a0 <stUserMathErr>
   140003ac7:	e9 54 5d 00 00       	jmp    140009820 <__setusermatherr>
   140003acc:	90                   	nop
   140003acd:	90                   	nop
   140003ace:	90                   	nop
   140003acf:	90                   	nop

0000000140003ad0 <_gnu_exception_handler>:
   140003ad0:	53                   	push   %rbx
   140003ad1:	48 83 ec 20          	sub    $0x20,%rsp
   140003ad5:	48 8b 11             	mov    (%rcx),%rdx
   140003ad8:	8b 02                	mov    (%rdx),%eax
   140003ada:	48 89 cb             	mov    %rcx,%rbx
   140003add:	89 c1                	mov    %eax,%ecx
   140003adf:	81 e1 ff ff ff 20    	and    $0x20ffffff,%ecx
   140003ae5:	81 f9 43 43 47 20    	cmp    $0x20474343,%ecx
   140003aeb:	0f 84 9f 00 00 00    	je     140003b90 <_gnu_exception_handler+0xc0>
   140003af1:	3d 96 00 00 c0       	cmp    $0xc0000096,%eax
   140003af6:	77 77                	ja     140003b6f <_gnu_exception_handler+0x9f>
   140003af8:	3d 8b 00 00 c0       	cmp    $0xc000008b,%eax
   140003afd:	76 21                	jbe    140003b20 <_gnu_exception_handler+0x50>
   140003aff:	05 73 ff ff 3f       	add    $0x3fffff73,%eax
   140003b04:	83 f8 09             	cmp    $0x9,%eax
   140003b07:	77 54                	ja     140003b5d <_gnu_exception_handler+0x8d>
   140003b09:	48 8d 15 30 79 00 00 	lea    0x7930(%rip),%rdx        # 14000b440 <.rdata>
   140003b10:	48 63 04 82          	movslq (%rdx,%rax,4),%rax
   140003b14:	48 01 d0             	add    %rdx,%rax
   140003b17:	ff e0                	jmp    *%rax
   140003b19:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140003b20:	3d 05 00 00 c0       	cmp    $0xc0000005,%eax
   140003b25:	0f 84 d5 00 00 00    	je     140003c00 <_gnu_exception_handler+0x130>
   140003b2b:	76 3b                	jbe    140003b68 <_gnu_exception_handler+0x98>
   140003b2d:	3d 08 00 00 c0       	cmp    $0xc0000008,%eax
   140003b32:	74 29                	je     140003b5d <_gnu_exception_handler+0x8d>
   140003b34:	3d 1d 00 00 c0       	cmp    $0xc000001d,%eax
   140003b39:	75 34                	jne    140003b6f <_gnu_exception_handler+0x9f>
   140003b3b:	31 d2                	xor    %edx,%edx
   140003b3d:	b9 04 00 00 00       	mov    $0x4,%ecx
   140003b42:	e8 71 5d 00 00       	call   1400098b8 <signal>
   140003b47:	48 83 f8 01          	cmp    $0x1,%rax
   140003b4b:	0f 84 d6 00 00 00    	je     140003c27 <_gnu_exception_handler+0x157>
   140003b51:	48 85 c0             	test   %rax,%rax
   140003b54:	74 19                	je     140003b6f <_gnu_exception_handler+0x9f>
   140003b56:	b9 04 00 00 00       	mov    $0x4,%ecx
   140003b5b:	ff d0                	call   *%rax
   140003b5d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   140003b62:	48 83 c4 20          	add    $0x20,%rsp
   140003b66:	5b                   	pop    %rbx
   140003b67:	c3                   	ret
   140003b68:	3d 02 00 00 80       	cmp    $0x80000002,%eax
   140003b6d:	74 ee                	je     140003b5d <_gnu_exception_handler+0x8d>
   140003b6f:	48 8b 05 4a a5 00 00 	mov    0xa54a(%rip),%rax        # 14000e0c0 <__mingw_oldexcpt_handler>
   140003b76:	48 85 c0             	test   %rax,%rax
   140003b79:	74 25                	je     140003ba0 <_gnu_exception_handler+0xd0>
   140003b7b:	48 89 d9             	mov    %rbx,%rcx
   140003b7e:	48 83 c4 20          	add    $0x20,%rsp
   140003b82:	5b                   	pop    %rbx
   140003b83:	48 ff e0             	rex.W jmp *%rax
   140003b86:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   140003b8d:	00 00 00 
   140003b90:	f6 42 04 01          	testb  $0x1,0x4(%rdx)
   140003b94:	0f 85 57 ff ff ff    	jne    140003af1 <_gnu_exception_handler+0x21>
   140003b9a:	eb c1                	jmp    140003b5d <_gnu_exception_handler+0x8d>
   140003b9c:	0f 1f 40 00          	nopl   0x0(%rax)
   140003ba0:	31 c0                	xor    %eax,%eax
   140003ba2:	48 83 c4 20          	add    $0x20,%rsp
   140003ba6:	5b                   	pop    %rbx
   140003ba7:	c3                   	ret
   140003ba8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   140003baf:	00 
   140003bb0:	31 d2                	xor    %edx,%edx
   140003bb2:	b9 08 00 00 00       	mov    $0x8,%ecx
   140003bb7:	e8 fc 5c 00 00       	call   1400098b8 <signal>
   140003bbc:	48 83 f8 01          	cmp    $0x1,%rax
   140003bc0:	0f 84 89 00 00 00    	je     140003c4f <_gnu_exception_handler+0x17f>
   140003bc6:	48 85 c0             	test   %rax,%rax
   140003bc9:	74 a4                	je     140003b6f <_gnu_exception_handler+0x9f>
   140003bcb:	b9 08 00 00 00       	mov    $0x8,%ecx
   140003bd0:	ff d0                	call   *%rax
   140003bd2:	eb 89                	jmp    140003b5d <_gnu_exception_handler+0x8d>
   140003bd4:	0f 1f 40 00          	nopl   0x0(%rax)
   140003bd8:	31 d2                	xor    %edx,%edx
   140003bda:	b9 08 00 00 00       	mov    $0x8,%ecx
   140003bdf:	e8 d4 5c 00 00       	call   1400098b8 <signal>
   140003be4:	48 83 f8 01          	cmp    $0x1,%rax
   140003be8:	75 dc                	jne    140003bc6 <_gnu_exception_handler+0xf6>
   140003bea:	ba 01 00 00 00       	mov    $0x1,%edx
   140003bef:	b9 08 00 00 00       	mov    $0x8,%ecx
   140003bf4:	e8 bf 5c 00 00       	call   1400098b8 <signal>
   140003bf9:	e9 5f ff ff ff       	jmp    140003b5d <_gnu_exception_handler+0x8d>
   140003bfe:	66 90                	xchg   %ax,%ax
   140003c00:	31 d2                	xor    %edx,%edx
   140003c02:	b9 0b 00 00 00       	mov    $0xb,%ecx
   140003c07:	e8 ac 5c 00 00       	call   1400098b8 <signal>
   140003c0c:	48 83 f8 01          	cmp    $0x1,%rax
   140003c10:	74 29                	je     140003c3b <_gnu_exception_handler+0x16b>
   140003c12:	48 85 c0             	test   %rax,%rax
   140003c15:	0f 84 54 ff ff ff    	je     140003b6f <_gnu_exception_handler+0x9f>
   140003c1b:	b9 0b 00 00 00       	mov    $0xb,%ecx
   140003c20:	ff d0                	call   *%rax
   140003c22:	e9 36 ff ff ff       	jmp    140003b5d <_gnu_exception_handler+0x8d>
   140003c27:	ba 01 00 00 00       	mov    $0x1,%edx
   140003c2c:	b9 04 00 00 00       	mov    $0x4,%ecx
   140003c31:	e8 82 5c 00 00       	call   1400098b8 <signal>
   140003c36:	e9 22 ff ff ff       	jmp    140003b5d <_gnu_exception_handler+0x8d>
   140003c3b:	ba 01 00 00 00       	mov    $0x1,%edx
   140003c40:	b9 0b 00 00 00       	mov    $0xb,%ecx
   140003c45:	e8 6e 5c 00 00       	call   1400098b8 <signal>
   140003c4a:	e9 0e ff ff ff       	jmp    140003b5d <_gnu_exception_handler+0x8d>
   140003c4f:	ba 01 00 00 00       	mov    $0x1,%edx
   140003c54:	b9 08 00 00 00       	mov    $0x8,%ecx
   140003c59:	e8 5a 5c 00 00       	call   1400098b8 <signal>
   140003c5e:	e8 cd f8 ff ff       	call   140003530 <_fpreset>
   140003c63:	e9 f5 fe ff ff       	jmp    140003b5d <_gnu_exception_handler+0x8d>
   140003c68:	90                   	nop
   140003c69:	90                   	nop
   140003c6a:	90                   	nop
   140003c6b:	90                   	nop
   140003c6c:	90                   	nop
   140003c6d:	90                   	nop
   140003c6e:	90                   	nop
   140003c6f:	90                   	nop

0000000140003c70 <__mingwthr_run_key_dtors.part.0>:
   140003c70:	41 54                	push   %r12
   140003c72:	55                   	push   %rbp
   140003c73:	57                   	push   %rdi
   140003c74:	56                   	push   %rsi
   140003c75:	53                   	push   %rbx
   140003c76:	48 83 ec 20          	sub    $0x20,%rsp
   140003c7a:	4c 8d 25 7f a4 00 00 	lea    0xa47f(%rip),%r12        # 14000e100 <__mingwthr_cs>
   140003c81:	4c 89 e1             	mov    %r12,%rcx
   140003c84:	ff 15 52 b5 00 00    	call   *0xb552(%rip)        # 14000f1dc <__imp_EnterCriticalSection>
   140003c8a:	48 8b 1d 4f a4 00 00 	mov    0xa44f(%rip),%rbx        # 14000e0e0 <key_dtor_list>
   140003c91:	48 85 db             	test   %rbx,%rbx
   140003c94:	74 36                	je     140003ccc <__mingwthr_run_key_dtors.part.0+0x5c>
   140003c96:	48 8b 2d 7f b5 00 00 	mov    0xb57f(%rip),%rbp        # 14000f21c <__imp_TlsGetValue>
   140003c9d:	48 8b 3d 40 b5 00 00 	mov    0xb540(%rip),%rdi        # 14000f1e4 <__imp_GetLastError>
   140003ca4:	0f 1f 40 00          	nopl   0x0(%rax)
   140003ca8:	8b 0b                	mov    (%rbx),%ecx
   140003caa:	ff d5                	call   *%rbp
   140003cac:	48 89 c6             	mov    %rax,%rsi
   140003caf:	ff d7                	call   *%rdi
   140003cb1:	85 c0                	test   %eax,%eax
   140003cb3:	75 0e                	jne    140003cc3 <__mingwthr_run_key_dtors.part.0+0x53>
   140003cb5:	48 85 f6             	test   %rsi,%rsi
   140003cb8:	74 09                	je     140003cc3 <__mingwthr_run_key_dtors.part.0+0x53>
   140003cba:	48 8b 43 08          	mov    0x8(%rbx),%rax
   140003cbe:	48 89 f1             	mov    %rsi,%rcx
   140003cc1:	ff d0                	call   *%rax
   140003cc3:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
   140003cc7:	48 85 db             	test   %rbx,%rbx
   140003cca:	75 dc                	jne    140003ca8 <__mingwthr_run_key_dtors.part.0+0x38>
   140003ccc:	4c 89 e1             	mov    %r12,%rcx
   140003ccf:	48 83 c4 20          	add    $0x20,%rsp
   140003cd3:	5b                   	pop    %rbx
   140003cd4:	5e                   	pop    %rsi
   140003cd5:	5f                   	pop    %rdi
   140003cd6:	5d                   	pop    %rbp
   140003cd7:	41 5c                	pop    %r12
   140003cd9:	48 ff 25 1c b5 00 00 	rex.W jmp *0xb51c(%rip)        # 14000f1fc <__imp_LeaveCriticalSection>

0000000140003ce0 <___w64_mingwthr_add_key_dtor>:
   140003ce0:	57                   	push   %rdi
   140003ce1:	56                   	push   %rsi
   140003ce2:	53                   	push   %rbx
   140003ce3:	48 83 ec 20          	sub    $0x20,%rsp
   140003ce7:	8b 05 fb a3 00 00    	mov    0xa3fb(%rip),%eax        # 14000e0e8 <__mingwthr_cs_init>
   140003ced:	85 c0                	test   %eax,%eax
   140003cef:	89 cf                	mov    %ecx,%edi
   140003cf1:	48 89 d6             	mov    %rdx,%rsi
   140003cf4:	75 0a                	jne    140003d00 <___w64_mingwthr_add_key_dtor+0x20>
   140003cf6:	31 c0                	xor    %eax,%eax
   140003cf8:	48 83 c4 20          	add    $0x20,%rsp
   140003cfc:	5b                   	pop    %rbx
   140003cfd:	5e                   	pop    %rsi
   140003cfe:	5f                   	pop    %rdi
   140003cff:	c3                   	ret
   140003d00:	ba 18 00 00 00       	mov    $0x18,%edx
   140003d05:	b9 01 00 00 00       	mov    $0x1,%ecx
   140003d0a:	e8 61 5b 00 00       	call   140009870 <calloc>
   140003d0f:	48 85 c0             	test   %rax,%rax
   140003d12:	48 89 c3             	mov    %rax,%rbx
   140003d15:	74 33                	je     140003d4a <___w64_mingwthr_add_key_dtor+0x6a>
   140003d17:	48 89 70 08          	mov    %rsi,0x8(%rax)
   140003d1b:	48 8d 35 de a3 00 00 	lea    0xa3de(%rip),%rsi        # 14000e100 <__mingwthr_cs>
   140003d22:	89 38                	mov    %edi,(%rax)
   140003d24:	48 89 f1             	mov    %rsi,%rcx
   140003d27:	ff 15 af b4 00 00    	call   *0xb4af(%rip)        # 14000f1dc <__imp_EnterCriticalSection>
   140003d2d:	48 8b 05 ac a3 00 00 	mov    0xa3ac(%rip),%rax        # 14000e0e0 <key_dtor_list>
   140003d34:	48 89 f1             	mov    %rsi,%rcx
   140003d37:	48 89 1d a2 a3 00 00 	mov    %rbx,0xa3a2(%rip)        # 14000e0e0 <key_dtor_list>
   140003d3e:	48 89 43 10          	mov    %rax,0x10(%rbx)
   140003d42:	ff 15 b4 b4 00 00    	call   *0xb4b4(%rip)        # 14000f1fc <__imp_LeaveCriticalSection>
   140003d48:	eb ac                	jmp    140003cf6 <___w64_mingwthr_add_key_dtor+0x16>
   140003d4a:	83 c8 ff             	or     $0xffffffff,%eax
   140003d4d:	eb a9                	jmp    140003cf8 <___w64_mingwthr_add_key_dtor+0x18>
   140003d4f:	90                   	nop

0000000140003d50 <___w64_mingwthr_remove_key_dtor>:
   140003d50:	56                   	push   %rsi
   140003d51:	53                   	push   %rbx
   140003d52:	48 83 ec 28          	sub    $0x28,%rsp
   140003d56:	8b 05 8c a3 00 00    	mov    0xa38c(%rip),%eax        # 14000e0e8 <__mingwthr_cs_init>
   140003d5c:	85 c0                	test   %eax,%eax
   140003d5e:	89 cb                	mov    %ecx,%ebx
   140003d60:	75 0e                	jne    140003d70 <___w64_mingwthr_remove_key_dtor+0x20>
   140003d62:	31 c0                	xor    %eax,%eax
   140003d64:	48 83 c4 28          	add    $0x28,%rsp
   140003d68:	5b                   	pop    %rbx
   140003d69:	5e                   	pop    %rsi
   140003d6a:	c3                   	ret
   140003d6b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140003d70:	48 8d 35 89 a3 00 00 	lea    0xa389(%rip),%rsi        # 14000e100 <__mingwthr_cs>
   140003d77:	48 89 f1             	mov    %rsi,%rcx
   140003d7a:	ff 15 5c b4 00 00    	call   *0xb45c(%rip)        # 14000f1dc <__imp_EnterCriticalSection>
   140003d80:	48 8b 0d 59 a3 00 00 	mov    0xa359(%rip),%rcx        # 14000e0e0 <key_dtor_list>
   140003d87:	48 85 c9             	test   %rcx,%rcx
   140003d8a:	74 27                	je     140003db3 <___w64_mingwthr_remove_key_dtor+0x63>
   140003d8c:	31 d2                	xor    %edx,%edx
   140003d8e:	eb 0b                	jmp    140003d9b <___w64_mingwthr_remove_key_dtor+0x4b>
   140003d90:	48 85 c0             	test   %rax,%rax
   140003d93:	48 89 ca             	mov    %rcx,%rdx
   140003d96:	74 1b                	je     140003db3 <___w64_mingwthr_remove_key_dtor+0x63>
   140003d98:	48 89 c1             	mov    %rax,%rcx
   140003d9b:	8b 01                	mov    (%rcx),%eax
   140003d9d:	39 d8                	cmp    %ebx,%eax
   140003d9f:	48 8b 41 10          	mov    0x10(%rcx),%rax
   140003da3:	75 eb                	jne    140003d90 <___w64_mingwthr_remove_key_dtor+0x40>
   140003da5:	48 85 d2             	test   %rdx,%rdx
   140003da8:	74 1e                	je     140003dc8 <___w64_mingwthr_remove_key_dtor+0x78>
   140003daa:	48 89 42 10          	mov    %rax,0x10(%rdx)
   140003dae:	e8 d5 5a 00 00       	call   140009888 <free>
   140003db3:	48 89 f1             	mov    %rsi,%rcx
   140003db6:	ff 15 40 b4 00 00    	call   *0xb440(%rip)        # 14000f1fc <__imp_LeaveCriticalSection>
   140003dbc:	31 c0                	xor    %eax,%eax
   140003dbe:	48 83 c4 28          	add    $0x28,%rsp
   140003dc2:	5b                   	pop    %rbx
   140003dc3:	5e                   	pop    %rsi
   140003dc4:	c3                   	ret
   140003dc5:	0f 1f 00             	nopl   (%rax)
   140003dc8:	48 89 05 11 a3 00 00 	mov    %rax,0xa311(%rip)        # 14000e0e0 <key_dtor_list>
   140003dcf:	eb dd                	jmp    140003dae <___w64_mingwthr_remove_key_dtor+0x5e>
   140003dd1:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   140003dd8:	00 00 00 00 
   140003ddc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000140003de0 <__mingw_TLScallback>:
   140003de0:	53                   	push   %rbx
   140003de1:	48 83 ec 20          	sub    $0x20,%rsp
   140003de5:	83 fa 02             	cmp    $0x2,%edx
   140003de8:	0f 84 b2 00 00 00    	je     140003ea0 <__mingw_TLScallback+0xc0>
   140003dee:	77 30                	ja     140003e20 <__mingw_TLScallback+0x40>
   140003df0:	85 d2                	test   %edx,%edx
   140003df2:	74 4c                	je     140003e40 <__mingw_TLScallback+0x60>
   140003df4:	8b 05 ee a2 00 00    	mov    0xa2ee(%rip),%eax        # 14000e0e8 <__mingwthr_cs_init>
   140003dfa:	85 c0                	test   %eax,%eax
   140003dfc:	0f 84 be 00 00 00    	je     140003ec0 <__mingw_TLScallback+0xe0>
   140003e02:	c7 05 dc a2 00 00 01 	movl   $0x1,0xa2dc(%rip)        # 14000e0e8 <__mingwthr_cs_init>
   140003e09:	00 00 00 
   140003e0c:	b8 01 00 00 00       	mov    $0x1,%eax
   140003e11:	48 83 c4 20          	add    $0x20,%rsp
   140003e15:	5b                   	pop    %rbx
   140003e16:	c3                   	ret
   140003e17:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   140003e1e:	00 00 
   140003e20:	83 fa 03             	cmp    $0x3,%edx
   140003e23:	75 e7                	jne    140003e0c <__mingw_TLScallback+0x2c>
   140003e25:	8b 05 bd a2 00 00    	mov    0xa2bd(%rip),%eax        # 14000e0e8 <__mingwthr_cs_init>
   140003e2b:	85 c0                	test   %eax,%eax
   140003e2d:	74 dd                	je     140003e0c <__mingw_TLScallback+0x2c>
   140003e2f:	e8 3c fe ff ff       	call   140003c70 <__mingwthr_run_key_dtors.part.0>
   140003e34:	eb d6                	jmp    140003e0c <__mingw_TLScallback+0x2c>
   140003e36:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   140003e3d:	00 00 00 
   140003e40:	8b 05 a2 a2 00 00    	mov    0xa2a2(%rip),%eax        # 14000e0e8 <__mingwthr_cs_init>
   140003e46:	85 c0                	test   %eax,%eax
   140003e48:	75 66                	jne    140003eb0 <__mingw_TLScallback+0xd0>
   140003e4a:	8b 05 98 a2 00 00    	mov    0xa298(%rip),%eax        # 14000e0e8 <__mingwthr_cs_init>
   140003e50:	83 f8 01             	cmp    $0x1,%eax
   140003e53:	75 b7                	jne    140003e0c <__mingw_TLScallback+0x2c>
   140003e55:	48 8b 1d 84 a2 00 00 	mov    0xa284(%rip),%rbx        # 14000e0e0 <key_dtor_list>
   140003e5c:	48 85 db             	test   %rbx,%rbx
   140003e5f:	74 18                	je     140003e79 <__mingw_TLScallback+0x99>
   140003e61:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140003e68:	48 89 d9             	mov    %rbx,%rcx
   140003e6b:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
   140003e6f:	e8 14 5a 00 00       	call   140009888 <free>
   140003e74:	48 85 db             	test   %rbx,%rbx
   140003e77:	75 ef                	jne    140003e68 <__mingw_TLScallback+0x88>
   140003e79:	48 8d 0d 80 a2 00 00 	lea    0xa280(%rip),%rcx        # 14000e100 <__mingwthr_cs>
   140003e80:	48 c7 05 55 a2 00 00 	movq   $0x0,0xa255(%rip)        # 14000e0e0 <key_dtor_list>
   140003e87:	00 00 00 00 
   140003e8b:	c7 05 53 a2 00 00 00 	movl   $0x0,0xa253(%rip)        # 14000e0e8 <__mingwthr_cs_init>
   140003e92:	00 00 00 
   140003e95:	ff 15 39 b3 00 00    	call   *0xb339(%rip)        # 14000f1d4 <__IAT_start__>
   140003e9b:	e9 6c ff ff ff       	jmp    140003e0c <__mingw_TLScallback+0x2c>
   140003ea0:	e8 8b f6 ff ff       	call   140003530 <_fpreset>
   140003ea5:	b8 01 00 00 00       	mov    $0x1,%eax
   140003eaa:	48 83 c4 20          	add    $0x20,%rsp
   140003eae:	5b                   	pop    %rbx
   140003eaf:	c3                   	ret
   140003eb0:	e8 bb fd ff ff       	call   140003c70 <__mingwthr_run_key_dtors.part.0>
   140003eb5:	eb 93                	jmp    140003e4a <__mingw_TLScallback+0x6a>
   140003eb7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   140003ebe:	00 00 
   140003ec0:	48 8d 0d 39 a2 00 00 	lea    0xa239(%rip),%rcx        # 14000e100 <__mingwthr_cs>
   140003ec7:	ff 15 1f b3 00 00    	call   *0xb31f(%rip)        # 14000f1ec <__imp_InitializeCriticalSection>
   140003ecd:	e9 30 ff ff ff       	jmp    140003e02 <__mingw_TLScallback+0x22>
   140003ed2:	90                   	nop
   140003ed3:	90                   	nop
   140003ed4:	90                   	nop
   140003ed5:	90                   	nop
   140003ed6:	90                   	nop
   140003ed7:	90                   	nop
   140003ed8:	90                   	nop
   140003ed9:	90                   	nop
   140003eda:	90                   	nop
   140003edb:	90                   	nop
   140003edc:	90                   	nop
   140003edd:	90                   	nop
   140003ede:	90                   	nop
   140003edf:	90                   	nop

0000000140003ee0 <exit>:
   140003ee0:	48 83 ec 28          	sub    $0x28,%rsp
   140003ee4:	48 8b 05 c5 79 00 00 	mov    0x79c5(%rip),%rax        # 14000b8b0 <.refptr.__imp_exit>
   140003eeb:	ff 10                	call   *(%rax)
   140003eed:	90                   	nop
   140003eee:	66 90                	xchg   %ax,%ax

0000000140003ef0 <_exit>:
   140003ef0:	48 83 ec 28          	sub    $0x28,%rsp
   140003ef4:	48 8b 05 95 79 00 00 	mov    0x7995(%rip),%rax        # 14000b890 <.refptr.__imp__exit>
   140003efb:	ff 10                	call   *(%rax)
   140003efd:	90                   	nop
   140003efe:	90                   	nop
   140003eff:	90                   	nop

0000000140003f00 <_ValidateImageBase>:
   140003f00:	31 c0                	xor    %eax,%eax
   140003f02:	66 81 39 4d 5a       	cmpw   $0x5a4d,(%rcx)
   140003f07:	75 0f                	jne    140003f18 <_ValidateImageBase+0x18>
   140003f09:	48 63 51 3c          	movslq 0x3c(%rcx),%rdx
   140003f0d:	48 01 d1             	add    %rdx,%rcx
   140003f10:	81 39 50 45 00 00    	cmpl   $0x4550,(%rcx)
   140003f16:	74 08                	je     140003f20 <_ValidateImageBase+0x20>
   140003f18:	c3                   	ret
   140003f19:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140003f20:	31 c0                	xor    %eax,%eax
   140003f22:	66 81 79 18 0b 02    	cmpw   $0x20b,0x18(%rcx)
   140003f28:	0f 94 c0             	sete   %al
   140003f2b:	c3                   	ret
   140003f2c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000140003f30 <_FindPESection>:
   140003f30:	48 63 41 3c          	movslq 0x3c(%rcx),%rax
   140003f34:	48 01 c1             	add    %rax,%rcx
   140003f37:	44 0f b7 41 06       	movzwl 0x6(%rcx),%r8d
   140003f3c:	0f b7 41 14          	movzwl 0x14(%rcx),%eax
   140003f40:	66 45 85 c0          	test   %r8w,%r8w
   140003f44:	48 8d 44 01 18       	lea    0x18(%rcx,%rax,1),%rax
   140003f49:	74 32                	je     140003f7d <_FindPESection+0x4d>
   140003f4b:	41 8d 48 ff          	lea    -0x1(%r8),%ecx
   140003f4f:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   140003f53:	4c 8d 4c c8 28       	lea    0x28(%rax,%rcx,8),%r9
   140003f58:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   140003f5f:	00 
   140003f60:	44 8b 40 0c          	mov    0xc(%rax),%r8d
   140003f64:	4c 39 c2             	cmp    %r8,%rdx
   140003f67:	4c 89 c1             	mov    %r8,%rcx
   140003f6a:	72 08                	jb     140003f74 <_FindPESection+0x44>
   140003f6c:	03 48 08             	add    0x8(%rax),%ecx
   140003f6f:	48 39 ca             	cmp    %rcx,%rdx
   140003f72:	72 0b                	jb     140003f7f <_FindPESection+0x4f>
   140003f74:	48 83 c0 28          	add    $0x28,%rax
   140003f78:	4c 39 c8             	cmp    %r9,%rax
   140003f7b:	75 e3                	jne    140003f60 <_FindPESection+0x30>
   140003f7d:	31 c0                	xor    %eax,%eax
   140003f7f:	c3                   	ret

0000000140003f80 <_FindPESectionByName>:
   140003f80:	57                   	push   %rdi
   140003f81:	56                   	push   %rsi
   140003f82:	53                   	push   %rbx
   140003f83:	48 83 ec 20          	sub    $0x20,%rsp
   140003f87:	48 89 ce             	mov    %rcx,%rsi
   140003f8a:	e8 39 59 00 00       	call   1400098c8 <strlen>
   140003f8f:	48 83 f8 08          	cmp    $0x8,%rax
   140003f93:	77 7b                	ja     140004010 <_FindPESectionByName+0x90>
   140003f95:	48 8b 15 c4 78 00 00 	mov    0x78c4(%rip),%rdx        # 14000b860 <.refptr.__image_base__>
   140003f9c:	31 db                	xor    %ebx,%ebx
   140003f9e:	66 81 3a 4d 5a       	cmpw   $0x5a4d,(%rdx)
   140003fa3:	75 59                	jne    140003ffe <_FindPESectionByName+0x7e>
   140003fa5:	48 63 42 3c          	movslq 0x3c(%rdx),%rax
   140003fa9:	48 01 d0             	add    %rdx,%rax
   140003fac:	81 38 50 45 00 00    	cmpl   $0x4550,(%rax)
   140003fb2:	75 4a                	jne    140003ffe <_FindPESectionByName+0x7e>
   140003fb4:	66 81 78 18 0b 02    	cmpw   $0x20b,0x18(%rax)
   140003fba:	75 42                	jne    140003ffe <_FindPESectionByName+0x7e>
   140003fbc:	0f b7 50 14          	movzwl 0x14(%rax),%edx
   140003fc0:	48 8d 5c 10 18       	lea    0x18(%rax,%rdx,1),%rbx
   140003fc5:	0f b7 50 06          	movzwl 0x6(%rax),%edx
   140003fc9:	66 85 d2             	test   %dx,%dx
   140003fcc:	74 42                	je     140004010 <_FindPESectionByName+0x90>
   140003fce:	8d 42 ff             	lea    -0x1(%rdx),%eax
   140003fd1:	48 8d 04 80          	lea    (%rax,%rax,4),%rax
   140003fd5:	48 8d 7c c3 28       	lea    0x28(%rbx,%rax,8),%rdi
   140003fda:	eb 0d                	jmp    140003fe9 <_FindPESectionByName+0x69>
   140003fdc:	0f 1f 40 00          	nopl   0x0(%rax)
   140003fe0:	48 83 c3 28          	add    $0x28,%rbx
   140003fe4:	48 39 fb             	cmp    %rdi,%rbx
   140003fe7:	74 27                	je     140004010 <_FindPESectionByName+0x90>
   140003fe9:	41 b8 08 00 00 00    	mov    $0x8,%r8d
   140003fef:	48 89 f2             	mov    %rsi,%rdx
   140003ff2:	48 89 d9             	mov    %rbx,%rcx
   140003ff5:	e8 d6 58 00 00       	call   1400098d0 <strncmp>
   140003ffa:	85 c0                	test   %eax,%eax
   140003ffc:	75 e2                	jne    140003fe0 <_FindPESectionByName+0x60>
   140003ffe:	48 89 d8             	mov    %rbx,%rax
   140004001:	48 83 c4 20          	add    $0x20,%rsp
   140004005:	5b                   	pop    %rbx
   140004006:	5e                   	pop    %rsi
   140004007:	5f                   	pop    %rdi
   140004008:	c3                   	ret
   140004009:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140004010:	31 db                	xor    %ebx,%ebx
   140004012:	48 89 d8             	mov    %rbx,%rax
   140004015:	48 83 c4 20          	add    $0x20,%rsp
   140004019:	5b                   	pop    %rbx
   14000401a:	5e                   	pop    %rsi
   14000401b:	5f                   	pop    %rdi
   14000401c:	c3                   	ret
   14000401d:	0f 1f 00             	nopl   (%rax)

0000000140004020 <__mingw_GetSectionForAddress>:
   140004020:	48 8b 15 39 78 00 00 	mov    0x7839(%rip),%rdx        # 14000b860 <.refptr.__image_base__>
   140004027:	31 c0                	xor    %eax,%eax
   140004029:	66 81 3a 4d 5a       	cmpw   $0x5a4d,(%rdx)
   14000402e:	75 10                	jne    140004040 <__mingw_GetSectionForAddress+0x20>
   140004030:	4c 63 42 3c          	movslq 0x3c(%rdx),%r8
   140004034:	49 01 d0             	add    %rdx,%r8
   140004037:	41 81 38 50 45 00 00 	cmpl   $0x4550,(%r8)
   14000403e:	74 08                	je     140004048 <__mingw_GetSectionForAddress+0x28>
   140004040:	c3                   	ret
   140004041:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140004048:	66 41 81 78 18 0b 02 	cmpw   $0x20b,0x18(%r8)
   14000404f:	75 ef                	jne    140004040 <__mingw_GetSectionForAddress+0x20>
   140004051:	41 0f b7 40 14       	movzwl 0x14(%r8),%eax
   140004056:	48 29 d1             	sub    %rdx,%rcx
   140004059:	49 8d 44 00 18       	lea    0x18(%r8,%rax,1),%rax
   14000405e:	45 0f b7 40 06       	movzwl 0x6(%r8),%r8d
   140004063:	66 45 85 c0          	test   %r8w,%r8w
   140004067:	74 34                	je     14000409d <__mingw_GetSectionForAddress+0x7d>
   140004069:	41 8d 50 ff          	lea    -0x1(%r8),%edx
   14000406d:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
   140004071:	4c 8d 4c d0 28       	lea    0x28(%rax,%rdx,8),%r9
   140004076:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   14000407d:	00 00 00 
   140004080:	44 8b 40 0c          	mov    0xc(%rax),%r8d
   140004084:	4c 39 c1             	cmp    %r8,%rcx
   140004087:	4c 89 c2             	mov    %r8,%rdx
   14000408a:	72 08                	jb     140004094 <__mingw_GetSectionForAddress+0x74>
   14000408c:	03 50 08             	add    0x8(%rax),%edx
   14000408f:	48 39 d1             	cmp    %rdx,%rcx
   140004092:	72 ac                	jb     140004040 <__mingw_GetSectionForAddress+0x20>
   140004094:	48 83 c0 28          	add    $0x28,%rax
   140004098:	4c 39 c8             	cmp    %r9,%rax
   14000409b:	75 e3                	jne    140004080 <__mingw_GetSectionForAddress+0x60>
   14000409d:	31 c0                	xor    %eax,%eax
   14000409f:	c3                   	ret

00000001400040a0 <__mingw_GetSectionCount>:
   1400040a0:	48 8b 05 b9 77 00 00 	mov    0x77b9(%rip),%rax        # 14000b860 <.refptr.__image_base__>
   1400040a7:	31 c9                	xor    %ecx,%ecx
   1400040a9:	66 81 38 4d 5a       	cmpw   $0x5a4d,(%rax)
   1400040ae:	75 0f                	jne    1400040bf <__mingw_GetSectionCount+0x1f>
   1400040b0:	48 63 50 3c          	movslq 0x3c(%rax),%rdx
   1400040b4:	48 01 d0             	add    %rdx,%rax
   1400040b7:	81 38 50 45 00 00    	cmpl   $0x4550,(%rax)
   1400040bd:	74 09                	je     1400040c8 <__mingw_GetSectionCount+0x28>
   1400040bf:	89 c8                	mov    %ecx,%eax
   1400040c1:	c3                   	ret
   1400040c2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   1400040c8:	66 81 78 18 0b 02    	cmpw   $0x20b,0x18(%rax)
   1400040ce:	75 ef                	jne    1400040bf <__mingw_GetSectionCount+0x1f>
   1400040d0:	0f b7 48 06          	movzwl 0x6(%rax),%ecx
   1400040d4:	89 c8                	mov    %ecx,%eax
   1400040d6:	c3                   	ret
   1400040d7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   1400040de:	00 00 

00000001400040e0 <_FindPESectionExec>:
   1400040e0:	4c 8b 05 79 77 00 00 	mov    0x7779(%rip),%r8        # 14000b860 <.refptr.__image_base__>
   1400040e7:	31 c0                	xor    %eax,%eax
   1400040e9:	66 41 81 38 4d 5a    	cmpw   $0x5a4d,(%r8)
   1400040ef:	75 0f                	jne    140004100 <_FindPESectionExec+0x20>
   1400040f1:	49 63 50 3c          	movslq 0x3c(%r8),%rdx
   1400040f5:	4c 01 c2             	add    %r8,%rdx
   1400040f8:	81 3a 50 45 00 00    	cmpl   $0x4550,(%rdx)
   1400040fe:	74 08                	je     140004108 <_FindPESectionExec+0x28>
   140004100:	c3                   	ret
   140004101:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140004108:	66 81 7a 18 0b 02    	cmpw   $0x20b,0x18(%rdx)
   14000410e:	75 f0                	jne    140004100 <_FindPESectionExec+0x20>
   140004110:	44 0f b7 42 06       	movzwl 0x6(%rdx),%r8d
   140004115:	0f b7 42 14          	movzwl 0x14(%rdx),%eax
   140004119:	66 45 85 c0          	test   %r8w,%r8w
   14000411d:	48 8d 44 02 18       	lea    0x18(%rdx,%rax,1),%rax
   140004122:	74 2c                	je     140004150 <_FindPESectionExec+0x70>
   140004124:	41 8d 50 ff          	lea    -0x1(%r8),%edx
   140004128:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
   14000412c:	48 8d 54 d0 28       	lea    0x28(%rax,%rdx,8),%rdx
   140004131:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140004138:	f6 40 27 20          	testb  $0x20,0x27(%rax)
   14000413c:	74 09                	je     140004147 <_FindPESectionExec+0x67>
   14000413e:	48 85 c9             	test   %rcx,%rcx
   140004141:	74 bd                	je     140004100 <_FindPESectionExec+0x20>
   140004143:	48 83 e9 01          	sub    $0x1,%rcx
   140004147:	48 83 c0 28          	add    $0x28,%rax
   14000414b:	48 39 d0             	cmp    %rdx,%rax
   14000414e:	75 e8                	jne    140004138 <_FindPESectionExec+0x58>
   140004150:	31 c0                	xor    %eax,%eax
   140004152:	c3                   	ret
   140004153:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   14000415a:	00 00 00 00 
   14000415e:	66 90                	xchg   %ax,%ax

0000000140004160 <_GetPEImageBase>:
   140004160:	48 8b 05 f9 76 00 00 	mov    0x76f9(%rip),%rax        # 14000b860 <.refptr.__image_base__>
   140004167:	31 d2                	xor    %edx,%edx
   140004169:	66 81 38 4d 5a       	cmpw   $0x5a4d,(%rax)
   14000416e:	75 0f                	jne    14000417f <_GetPEImageBase+0x1f>
   140004170:	48 63 48 3c          	movslq 0x3c(%rax),%rcx
   140004174:	48 01 c1             	add    %rax,%rcx
   140004177:	81 39 50 45 00 00    	cmpl   $0x4550,(%rcx)
   14000417d:	74 09                	je     140004188 <_GetPEImageBase+0x28>
   14000417f:	48 89 d0             	mov    %rdx,%rax
   140004182:	c3                   	ret
   140004183:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140004188:	66 81 79 18 0b 02    	cmpw   $0x20b,0x18(%rcx)
   14000418e:	48 0f 44 d0          	cmove  %rax,%rdx
   140004192:	48 89 d0             	mov    %rdx,%rax
   140004195:	c3                   	ret
   140004196:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   14000419d:	00 00 00 

00000001400041a0 <_IsNonwritableInCurrentImage>:
   1400041a0:	48 8b 15 b9 76 00 00 	mov    0x76b9(%rip),%rdx        # 14000b860 <.refptr.__image_base__>
   1400041a7:	31 c0                	xor    %eax,%eax
   1400041a9:	66 81 3a 4d 5a       	cmpw   $0x5a4d,(%rdx)
   1400041ae:	75 10                	jne    1400041c0 <_IsNonwritableInCurrentImage+0x20>
   1400041b0:	4c 63 42 3c          	movslq 0x3c(%rdx),%r8
   1400041b4:	49 01 d0             	add    %rdx,%r8
   1400041b7:	41 81 38 50 45 00 00 	cmpl   $0x4550,(%r8)
   1400041be:	74 08                	je     1400041c8 <_IsNonwritableInCurrentImage+0x28>
   1400041c0:	c3                   	ret
   1400041c1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   1400041c8:	66 41 81 78 18 0b 02 	cmpw   $0x20b,0x18(%r8)
   1400041cf:	75 ef                	jne    1400041c0 <_IsNonwritableInCurrentImage+0x20>
   1400041d1:	45 0f b7 48 06       	movzwl 0x6(%r8),%r9d
   1400041d6:	48 29 d1             	sub    %rdx,%rcx
   1400041d9:	41 0f b7 50 14       	movzwl 0x14(%r8),%edx
   1400041de:	66 45 85 c9          	test   %r9w,%r9w
   1400041e2:	49 8d 54 10 18       	lea    0x18(%r8,%rdx,1),%rdx
   1400041e7:	74 d7                	je     1400041c0 <_IsNonwritableInCurrentImage+0x20>
   1400041e9:	41 8d 41 ff          	lea    -0x1(%r9),%eax
   1400041ed:	48 8d 04 80          	lea    (%rax,%rax,4),%rax
   1400041f1:	4c 8d 4c c2 28       	lea    0x28(%rdx,%rax,8),%r9
   1400041f6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   1400041fd:	00 00 00 
   140004200:	44 8b 42 0c          	mov    0xc(%rdx),%r8d
   140004204:	4c 39 c1             	cmp    %r8,%rcx
   140004207:	4c 89 c0             	mov    %r8,%rax
   14000420a:	72 08                	jb     140004214 <_IsNonwritableInCurrentImage+0x74>
   14000420c:	03 42 08             	add    0x8(%rdx),%eax
   14000420f:	48 39 c1             	cmp    %rax,%rcx
   140004212:	72 0c                	jb     140004220 <_IsNonwritableInCurrentImage+0x80>
   140004214:	48 83 c2 28          	add    $0x28,%rdx
   140004218:	49 39 d1             	cmp    %rdx,%r9
   14000421b:	75 e3                	jne    140004200 <_IsNonwritableInCurrentImage+0x60>
   14000421d:	31 c0                	xor    %eax,%eax
   14000421f:	c3                   	ret
   140004220:	8b 42 24             	mov    0x24(%rdx),%eax
   140004223:	f7 d0                	not    %eax
   140004225:	c1 e8 1f             	shr    $0x1f,%eax
   140004228:	c3                   	ret
   140004229:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000140004230 <__mingw_enum_import_library_names>:
   140004230:	4c 8b 1d 29 76 00 00 	mov    0x7629(%rip),%r11        # 14000b860 <.refptr.__image_base__>
   140004237:	45 31 c9             	xor    %r9d,%r9d
   14000423a:	66 41 81 3b 4d 5a    	cmpw   $0x5a4d,(%r11)
   140004240:	75 10                	jne    140004252 <__mingw_enum_import_library_names+0x22>
   140004242:	4d 63 43 3c          	movslq 0x3c(%r11),%r8
   140004246:	4d 01 d8             	add    %r11,%r8
   140004249:	41 81 38 50 45 00 00 	cmpl   $0x4550,(%r8)
   140004250:	74 0e                	je     140004260 <__mingw_enum_import_library_names+0x30>
   140004252:	4c 89 c8             	mov    %r9,%rax
   140004255:	c3                   	ret
   140004256:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   14000425d:	00 00 00 
   140004260:	66 41 81 78 18 0b 02 	cmpw   $0x20b,0x18(%r8)
   140004267:	75 e9                	jne    140004252 <__mingw_enum_import_library_names+0x22>
   140004269:	41 8b 80 90 00 00 00 	mov    0x90(%r8),%eax
   140004270:	85 c0                	test   %eax,%eax
   140004272:	74 de                	je     140004252 <__mingw_enum_import_library_names+0x22>
   140004274:	45 0f b7 50 06       	movzwl 0x6(%r8),%r10d
   140004279:	41 0f b7 50 14       	movzwl 0x14(%r8),%edx
   14000427e:	66 45 85 d2          	test   %r10w,%r10w
   140004282:	49 8d 54 10 18       	lea    0x18(%r8,%rdx,1),%rdx
   140004287:	74 c9                	je     140004252 <__mingw_enum_import_library_names+0x22>
   140004289:	45 8d 42 ff          	lea    -0x1(%r10),%r8d
   14000428d:	4f 8d 04 80          	lea    (%r8,%r8,4),%r8
   140004291:	4e 8d 54 c2 28       	lea    0x28(%rdx,%r8,8),%r10
   140004296:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   14000429d:	00 00 00 
   1400042a0:	44 8b 4a 0c          	mov    0xc(%rdx),%r9d
   1400042a4:	4c 39 c8             	cmp    %r9,%rax
   1400042a7:	4d 89 c8             	mov    %r9,%r8
   1400042aa:	72 09                	jb     1400042b5 <__mingw_enum_import_library_names+0x85>
   1400042ac:	44 03 42 08          	add    0x8(%rdx),%r8d
   1400042b0:	4c 39 c0             	cmp    %r8,%rax
   1400042b3:	72 13                	jb     1400042c8 <__mingw_enum_import_library_names+0x98>
   1400042b5:	48 83 c2 28          	add    $0x28,%rdx
   1400042b9:	4c 39 d2             	cmp    %r10,%rdx
   1400042bc:	75 e2                	jne    1400042a0 <__mingw_enum_import_library_names+0x70>
   1400042be:	45 31 c9             	xor    %r9d,%r9d
   1400042c1:	4c 89 c8             	mov    %r9,%rax
   1400042c4:	c3                   	ret
   1400042c5:	0f 1f 00             	nopl   (%rax)
   1400042c8:	4c 01 d8             	add    %r11,%rax
   1400042cb:	eb 0a                	jmp    1400042d7 <__mingw_enum_import_library_names+0xa7>
   1400042cd:	0f 1f 00             	nopl   (%rax)
   1400042d0:	83 e9 01             	sub    $0x1,%ecx
   1400042d3:	48 83 c0 14          	add    $0x14,%rax
   1400042d7:	44 8b 40 04          	mov    0x4(%rax),%r8d
   1400042db:	45 85 c0             	test   %r8d,%r8d
   1400042de:	75 07                	jne    1400042e7 <__mingw_enum_import_library_names+0xb7>
   1400042e0:	8b 50 0c             	mov    0xc(%rax),%edx
   1400042e3:	85 d2                	test   %edx,%edx
   1400042e5:	74 d7                	je     1400042be <__mingw_enum_import_library_names+0x8e>
   1400042e7:	85 c9                	test   %ecx,%ecx
   1400042e9:	7f e5                	jg     1400042d0 <__mingw_enum_import_library_names+0xa0>
   1400042eb:	44 8b 48 0c          	mov    0xc(%rax),%r9d
   1400042ef:	4d 01 d9             	add    %r11,%r9
   1400042f2:	4c 89 c8             	mov    %r9,%rax
   1400042f5:	c3                   	ret
   1400042f6:	90                   	nop
   1400042f7:	90                   	nop
   1400042f8:	90                   	nop
   1400042f9:	90                   	nop
   1400042fa:	90                   	nop
   1400042fb:	90                   	nop
   1400042fc:	90                   	nop
   1400042fd:	90                   	nop
   1400042fe:	90                   	nop
   1400042ff:	90                   	nop

0000000140004300 <___chkstk_ms>:
   140004300:	51                   	push   %rcx
   140004301:	50                   	push   %rax
   140004302:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
   140004308:	48 8d 4c 24 18       	lea    0x18(%rsp),%rcx
   14000430d:	72 19                	jb     140004328 <___chkstk_ms+0x28>
   14000430f:	48 81 e9 00 10 00 00 	sub    $0x1000,%rcx
   140004316:	48 83 09 00          	orq    $0x0,(%rcx)
   14000431a:	48 2d 00 10 00 00    	sub    $0x1000,%rax
   140004320:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
   140004326:	77 e7                	ja     14000430f <___chkstk_ms+0xf>
   140004328:	48 29 c1             	sub    %rax,%rcx
   14000432b:	48 83 09 00          	orq    $0x0,(%rcx)
   14000432f:	58                   	pop    %rax
   140004330:	59                   	pop    %rcx
   140004331:	c3                   	ret
   140004332:	90                   	nop
   140004333:	90                   	nop
   140004334:	90                   	nop
   140004335:	90                   	nop
   140004336:	90                   	nop
   140004337:	90                   	nop
   140004338:	90                   	nop
   140004339:	90                   	nop
   14000433a:	90                   	nop
   14000433b:	90                   	nop
   14000433c:	90                   	nop
   14000433d:	90                   	nop
   14000433e:	90                   	nop
   14000433f:	90                   	nop

0000000140004340 <__mingw_vfprintf>:
   140004340:	57                   	push   %rdi
   140004341:	56                   	push   %rsi
   140004342:	53                   	push   %rbx
   140004343:	48 83 ec 30          	sub    $0x30,%rsp
   140004347:	48 89 cb             	mov    %rcx,%rbx
   14000434a:	48 89 d6             	mov    %rdx,%rsi
   14000434d:	4c 89 c7             	mov    %r8,%rdi
   140004350:	e8 7b 4e 00 00       	call   1400091d0 <_lock_file>
   140004355:	49 89 f1             	mov    %rsi,%r9
   140004358:	45 31 c0             	xor    %r8d,%r8d
   14000435b:	48 89 da             	mov    %rbx,%rdx
   14000435e:	48 89 7c 24 20       	mov    %rdi,0x20(%rsp)
   140004363:	b9 00 60 00 00       	mov    $0x6000,%ecx
   140004368:	e8 33 1b 00 00       	call   140005ea0 <__mingw_pformat>
   14000436d:	48 89 d9             	mov    %rbx,%rcx
   140004370:	89 c6                	mov    %eax,%esi
   140004372:	e8 c9 4e 00 00       	call   140009240 <_unlock_file>
   140004377:	89 f0                	mov    %esi,%eax
   140004379:	48 83 c4 30          	add    $0x30,%rsp
   14000437d:	5b                   	pop    %rbx
   14000437e:	5e                   	pop    %rsi
   14000437f:	5f                   	pop    %rdi
   140004380:	c3                   	ret
   140004381:	90                   	nop
   140004382:	90                   	nop
   140004383:	90                   	nop
   140004384:	90                   	nop
   140004385:	90                   	nop
   140004386:	90                   	nop
   140004387:	90                   	nop
   140004388:	90                   	nop
   140004389:	90                   	nop
   14000438a:	90                   	nop
   14000438b:	90                   	nop
   14000438c:	90                   	nop
   14000438d:	90                   	nop
   14000438e:	90                   	nop
   14000438f:	90                   	nop

0000000140004390 <__pformat_cvt>:
   140004390:	48 83 ec 68          	sub    $0x68,%rsp
   140004394:	48 8b 02             	mov    (%rdx),%rax
   140004397:	8b 52 08             	mov    0x8(%rdx),%edx
   14000439a:	41 89 cb             	mov    %ecx,%r11d
   14000439d:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
   1400043a2:	41 89 d2             	mov    %edx,%r10d
   1400043a5:	89 54 24 58          	mov    %edx,0x58(%rsp)
   1400043a9:	48 89 d1             	mov    %rdx,%rcx
   1400043ac:	66 41 81 e2 ff 7f    	and    $0x7fff,%r10w
   1400043b2:	75 74                	jne    140004428 <__pformat_cvt+0x98>
   1400043b4:	48 89 c2             	mov    %rax,%rdx
   1400043b7:	48 c1 ea 20          	shr    $0x20,%rdx
   1400043bb:	09 d0                	or     %edx,%eax
   1400043bd:	0f 84 8d 00 00 00    	je     140004450 <__pformat_cvt+0xc0>
   1400043c3:	85 d2                	test   %edx,%edx
   1400043c5:	0f 89 95 00 00 00    	jns    140004460 <__pformat_cvt+0xd0>
   1400043cb:	41 8d 92 c2 bf ff ff 	lea    -0x403e(%r10),%edx
   1400043d2:	b8 01 00 00 00       	mov    $0x1,%eax
   1400043d7:	0f bf d2             	movswl %dx,%edx
   1400043da:	89 44 24 44          	mov    %eax,0x44(%rsp)
   1400043de:	81 e1 00 80 00 00    	and    $0x8000,%ecx
   1400043e4:	48 8b 84 24 90 00 00 	mov    0x90(%rsp),%rax
   1400043eb:	00 
   1400043ec:	89 08                	mov    %ecx,(%rax)
   1400043ee:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
   1400043f3:	4c 89 4c 24 30       	mov    %r9,0x30(%rsp)
   1400043f8:	48 8d 0d 51 5c 00 00 	lea    0x5c51(%rip),%rcx        # 14000a050 <fpi.0>
   1400043ff:	44 89 44 24 28       	mov    %r8d,0x28(%rsp)
   140004404:	4c 8d 4c 24 44       	lea    0x44(%rsp),%r9
   140004409:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
   14000440e:	4c 8d 44 24 50       	lea    0x50(%rsp),%r8
   140004413:	44 89 5c 24 20       	mov    %r11d,0x20(%rsp)
   140004418:	e8 e3 27 00 00       	call   140006c00 <__gdtoa>
   14000441d:	48 83 c4 68          	add    $0x68,%rsp
   140004421:	c3                   	ret
   140004422:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140004428:	66 41 81 fa ff 7f    	cmp    $0x7fff,%r10w
   14000442e:	75 9b                	jne    1400043cb <__pformat_cvt+0x3b>
   140004430:	48 89 c2             	mov    %rax,%rdx
   140004433:	48 c1 ea 20          	shr    $0x20,%rdx
   140004437:	81 e2 ff ff ff 7f    	and    $0x7fffffff,%edx
   14000443d:	09 c2                	or     %eax,%edx
   14000443f:	74 2f                	je     140004470 <__pformat_cvt+0xe0>
   140004441:	c7 44 24 44 04 00 00 	movl   $0x4,0x44(%rsp)
   140004448:	00 
   140004449:	31 d2                	xor    %edx,%edx
   14000444b:	31 c9                	xor    %ecx,%ecx
   14000444d:	eb 95                	jmp    1400043e4 <__pformat_cvt+0x54>
   14000444f:	90                   	nop
   140004450:	31 c0                	xor    %eax,%eax
   140004452:	31 d2                	xor    %edx,%edx
   140004454:	eb 84                	jmp    1400043da <__pformat_cvt+0x4a>
   140004456:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   14000445d:	00 00 00 
   140004460:	b8 02 00 00 00       	mov    $0x2,%eax
   140004465:	ba c3 bf ff ff       	mov    $0xffffbfc3,%edx
   14000446a:	e9 6b ff ff ff       	jmp    1400043da <__pformat_cvt+0x4a>
   14000446f:	90                   	nop
   140004470:	b8 03 00 00 00       	mov    $0x3,%eax
   140004475:	31 d2                	xor    %edx,%edx
   140004477:	e9 5e ff ff ff       	jmp    1400043da <__pformat_cvt+0x4a>
   14000447c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000140004480 <__pformat_putc>:
   140004480:	53                   	push   %rbx
   140004481:	48 83 ec 20          	sub    $0x20,%rsp
   140004485:	48 89 d3             	mov    %rdx,%rbx
   140004488:	8b 52 08             	mov    0x8(%rdx),%edx
   14000448b:	f6 c6 40             	test   $0x40,%dh
   14000448e:	75 08                	jne    140004498 <__pformat_putc+0x18>
   140004490:	8b 43 24             	mov    0x24(%rbx),%eax
   140004493:	39 43 28             	cmp    %eax,0x28(%rbx)
   140004496:	7e 12                	jle    1400044aa <__pformat_putc+0x2a>
   140004498:	80 e6 20             	and    $0x20,%dh
   14000449b:	48 8b 03             	mov    (%rbx),%rax
   14000449e:	75 20                	jne    1400044c0 <__pformat_putc+0x40>
   1400044a0:	48 63 53 24          	movslq 0x24(%rbx),%rdx
   1400044a4:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
   1400044a7:	8b 43 24             	mov    0x24(%rbx),%eax
   1400044aa:	83 c0 01             	add    $0x1,%eax
   1400044ad:	89 43 24             	mov    %eax,0x24(%rbx)
   1400044b0:	48 83 c4 20          	add    $0x20,%rsp
   1400044b4:	5b                   	pop    %rbx
   1400044b5:	c3                   	ret
   1400044b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   1400044bd:	00 00 00 
   1400044c0:	48 89 c2             	mov    %rax,%rdx
   1400044c3:	e8 b8 53 00 00       	call   140009880 <fputc>
   1400044c8:	8b 43 24             	mov    0x24(%rbx),%eax
   1400044cb:	83 c0 01             	add    $0x1,%eax
   1400044ce:	89 43 24             	mov    %eax,0x24(%rbx)
   1400044d1:	48 83 c4 20          	add    $0x20,%rsp
   1400044d5:	5b                   	pop    %rbx
   1400044d6:	c3                   	ret
   1400044d7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   1400044de:	00 00 

00000001400044e0 <__pformat_wputchars>:
   1400044e0:	41 57                	push   %r15
   1400044e2:	41 56                	push   %r14
   1400044e4:	41 55                	push   %r13
   1400044e6:	41 54                	push   %r12
   1400044e8:	55                   	push   %rbp
   1400044e9:	57                   	push   %rdi
   1400044ea:	56                   	push   %rsi
   1400044eb:	53                   	push   %rbx
   1400044ec:	48 83 ec 48          	sub    $0x48,%rsp
   1400044f0:	4c 8d 6c 24 28       	lea    0x28(%rsp),%r13
   1400044f5:	89 d6                	mov    %edx,%esi
   1400044f7:	4c 89 c3             	mov    %r8,%rbx
   1400044fa:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
   1400044ff:	31 d2                	xor    %edx,%edx
   140004501:	48 89 cd             	mov    %rcx,%rbp
   140004504:	4d 89 e8             	mov    %r13,%r8
   140004507:	48 89 f9             	mov    %rdi,%rcx
   14000450a:	e8 61 4e 00 00       	call   140009370 <wcrtomb>
   14000450f:	8b 43 10             	mov    0x10(%rbx),%eax
   140004512:	39 c6                	cmp    %eax,%esi
   140004514:	89 c2                	mov    %eax,%edx
   140004516:	0f 4e d6             	cmovle %esi,%edx
   140004519:	85 c0                	test   %eax,%eax
   14000451b:	8b 43 0c             	mov    0xc(%rbx),%eax
   14000451e:	0f 49 f2             	cmovns %edx,%esi
   140004521:	39 f0                	cmp    %esi,%eax
   140004523:	0f 8f e2 00 00 00    	jg     14000460b <__pformat_wputchars+0x12b>
   140004529:	c7 43 0c ff ff ff ff 	movl   $0xffffffff,0xc(%rbx)
   140004530:	44 8d 66 ff          	lea    -0x1(%rsi),%r12d
   140004534:	85 f6                	test   %esi,%esi
   140004536:	0f 8e 29 01 00 00    	jle    140004665 <__pformat_wputchars+0x185>
   14000453c:	31 f6                	xor    %esi,%esi
   14000453e:	41 83 c4 01          	add    $0x1,%r12d
   140004542:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140004548:	0f b7 54 75 00       	movzwl 0x0(%rbp,%rsi,2),%edx
   14000454d:	4d 89 e8             	mov    %r13,%r8
   140004550:	48 89 f9             	mov    %rdi,%rcx
   140004553:	e8 18 4e 00 00       	call   140009370 <wcrtomb>
   140004558:	85 c0                	test   %eax,%eax
   14000455a:	0f 8e 8d 00 00 00    	jle    1400045ed <__pformat_wputchars+0x10d>
   140004560:	83 e8 01             	sub    $0x1,%eax
   140004563:	49 89 fe             	mov    %rdi,%r14
   140004566:	4c 8d 7c 07 01       	lea    0x1(%rdi,%rax,1),%r15
   14000456b:	eb 18                	jmp    140004585 <__pformat_wputchars+0xa5>
   14000456d:	0f 1f 00             	nopl   (%rax)
   140004570:	48 63 53 24          	movslq 0x24(%rbx),%rdx
   140004574:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
   140004577:	8b 43 24             	mov    0x24(%rbx),%eax
   14000457a:	83 c0 01             	add    $0x1,%eax
   14000457d:	4d 39 fe             	cmp    %r15,%r14
   140004580:	89 43 24             	mov    %eax,0x24(%rbx)
   140004583:	74 37                	je     1400045bc <__pformat_wputchars+0xdc>
   140004585:	8b 53 08             	mov    0x8(%rbx),%edx
   140004588:	49 83 c6 01          	add    $0x1,%r14
   14000458c:	f6 c6 40             	test   $0x40,%dh
   14000458f:	75 08                	jne    140004599 <__pformat_wputchars+0xb9>
   140004591:	8b 43 24             	mov    0x24(%rbx),%eax
   140004594:	39 43 28             	cmp    %eax,0x28(%rbx)
   140004597:	7e e1                	jle    14000457a <__pformat_wputchars+0x9a>
   140004599:	80 e6 20             	and    $0x20,%dh
   14000459c:	41 0f be 4e ff       	movsbl -0x1(%r14),%ecx
   1400045a1:	48 8b 03             	mov    (%rbx),%rax
   1400045a4:	74 ca                	je     140004570 <__pformat_wputchars+0x90>
   1400045a6:	48 89 c2             	mov    %rax,%rdx
   1400045a9:	e8 d2 52 00 00       	call   140009880 <fputc>
   1400045ae:	8b 43 24             	mov    0x24(%rbx),%eax
   1400045b1:	83 c0 01             	add    $0x1,%eax
   1400045b4:	4d 39 fe             	cmp    %r15,%r14
   1400045b7:	89 43 24             	mov    %eax,0x24(%rbx)
   1400045ba:	75 c9                	jne    140004585 <__pformat_wputchars+0xa5>
   1400045bc:	48 83 c6 01          	add    $0x1,%rsi
   1400045c0:	44 89 e0             	mov    %r12d,%eax
   1400045c3:	29 f0                	sub    %esi,%eax
   1400045c5:	85 c0                	test   %eax,%eax
   1400045c7:	0f 8f 7b ff ff ff    	jg     140004548 <__pformat_wputchars+0x68>
   1400045cd:	8b 43 0c             	mov    0xc(%rbx),%eax
   1400045d0:	8d 50 ff             	lea    -0x1(%rax),%edx
   1400045d3:	85 c0                	test   %eax,%eax
   1400045d5:	89 53 0c             	mov    %edx,0xc(%rbx)
   1400045d8:	7e 20                	jle    1400045fa <__pformat_wputchars+0x11a>
   1400045da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   1400045e0:	48 89 da             	mov    %rbx,%rdx
   1400045e3:	b9 20 00 00 00       	mov    $0x20,%ecx
   1400045e8:	e8 93 fe ff ff       	call   140004480 <__pformat_putc>
   1400045ed:	8b 43 0c             	mov    0xc(%rbx),%eax
   1400045f0:	8d 50 ff             	lea    -0x1(%rax),%edx
   1400045f3:	85 c0                	test   %eax,%eax
   1400045f5:	89 53 0c             	mov    %edx,0xc(%rbx)
   1400045f8:	7f e6                	jg     1400045e0 <__pformat_wputchars+0x100>
   1400045fa:	48 83 c4 48          	add    $0x48,%rsp
   1400045fe:	5b                   	pop    %rbx
   1400045ff:	5e                   	pop    %rsi
   140004600:	5f                   	pop    %rdi
   140004601:	5d                   	pop    %rbp
   140004602:	41 5c                	pop    %r12
   140004604:	41 5d                	pop    %r13
   140004606:	41 5e                	pop    %r14
   140004608:	41 5f                	pop    %r15
   14000460a:	c3                   	ret
   14000460b:	29 f0                	sub    %esi,%eax
   14000460d:	f6 43 09 04          	testb  $0x4,0x9(%rbx)
   140004611:	89 43 0c             	mov    %eax,0xc(%rbx)
   140004614:	75 3a                	jne    140004650 <__pformat_wputchars+0x170>
   140004616:	83 e8 01             	sub    $0x1,%eax
   140004619:	89 43 0c             	mov    %eax,0xc(%rbx)
   14000461c:	0f 1f 40 00          	nopl   0x0(%rax)
   140004620:	48 89 da             	mov    %rbx,%rdx
   140004623:	b9 20 00 00 00       	mov    $0x20,%ecx
   140004628:	e8 53 fe ff ff       	call   140004480 <__pformat_putc>
   14000462d:	8b 43 0c             	mov    0xc(%rbx),%eax
   140004630:	8d 50 ff             	lea    -0x1(%rax),%edx
   140004633:	85 c0                	test   %eax,%eax
   140004635:	89 53 0c             	mov    %edx,0xc(%rbx)
   140004638:	75 e6                	jne    140004620 <__pformat_wputchars+0x140>
   14000463a:	44 8d 66 ff          	lea    -0x1(%rsi),%r12d
   14000463e:	85 f6                	test   %esi,%esi
   140004640:	0f 8f f6 fe ff ff    	jg     14000453c <__pformat_wputchars+0x5c>
   140004646:	eb a5                	jmp    1400045ed <__pformat_wputchars+0x10d>
   140004648:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   14000464f:	00 
   140004650:	44 8d 66 ff          	lea    -0x1(%rsi),%r12d
   140004654:	85 f6                	test   %esi,%esi
   140004656:	0f 8f e0 fe ff ff    	jg     14000453c <__pformat_wputchars+0x5c>
   14000465c:	83 6b 0c 01          	subl   $0x1,0xc(%rbx)
   140004660:	e9 7b ff ff ff       	jmp    1400045e0 <__pformat_wputchars+0x100>
   140004665:	c7 43 0c fe ff ff ff 	movl   $0xfffffffe,0xc(%rbx)
   14000466c:	eb 8c                	jmp    1400045fa <__pformat_wputchars+0x11a>
   14000466e:	66 90                	xchg   %ax,%ax

0000000140004670 <__pformat_putchars>:
   140004670:	57                   	push   %rdi
   140004671:	56                   	push   %rsi
   140004672:	53                   	push   %rbx
   140004673:	48 83 ec 20          	sub    $0x20,%rsp
   140004677:	41 8b 40 10          	mov    0x10(%r8),%eax
   14000467b:	89 d7                	mov    %edx,%edi
   14000467d:	39 c2                	cmp    %eax,%edx
   14000467f:	89 c2                	mov    %eax,%edx
   140004681:	0f 4e d7             	cmovle %edi,%edx
   140004684:	85 c0                	test   %eax,%eax
   140004686:	41 8b 40 0c          	mov    0xc(%r8),%eax
   14000468a:	48 89 ce             	mov    %rcx,%rsi
   14000468d:	4c 89 c3             	mov    %r8,%rbx
   140004690:	0f 49 fa             	cmovns %edx,%edi
   140004693:	39 f8                	cmp    %edi,%eax
   140004695:	0f 8f bd 00 00 00    	jg     140004758 <__pformat_putchars+0xe8>
   14000469b:	41 c7 40 0c ff ff ff 	movl   $0xffffffff,0xc(%r8)
   1400046a2:	ff 
   1400046a3:	8d 57 ff             	lea    -0x1(%rdi),%edx
   1400046a6:	85 ff                	test   %edi,%edi
   1400046a8:	0f 84 97 00 00 00    	je     140004745 <__pformat_putchars+0xd5>
   1400046ae:	8b 43 08             	mov    0x8(%rbx),%eax
   1400046b1:	8d 7a 01             	lea    0x1(%rdx),%edi
   1400046b4:	48 01 f7             	add    %rsi,%rdi
   1400046b7:	eb 1f                	jmp    1400046d8 <__pformat_putchars+0x68>
   1400046b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   1400046c0:	48 63 43 24          	movslq 0x24(%rbx),%rax
   1400046c4:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
   1400046c7:	8b 53 24             	mov    0x24(%rbx),%edx
   1400046ca:	83 c2 01             	add    $0x1,%edx
   1400046cd:	48 39 fe             	cmp    %rdi,%rsi
   1400046d0:	89 53 24             	mov    %edx,0x24(%rbx)
   1400046d3:	74 3c                	je     140004711 <__pformat_putchars+0xa1>
   1400046d5:	8b 43 08             	mov    0x8(%rbx),%eax
   1400046d8:	48 83 c6 01          	add    $0x1,%rsi
   1400046dc:	f6 c4 40             	test   $0x40,%ah
   1400046df:	75 08                	jne    1400046e9 <__pformat_putchars+0x79>
   1400046e1:	8b 53 24             	mov    0x24(%rbx),%edx
   1400046e4:	39 53 28             	cmp    %edx,0x28(%rbx)
   1400046e7:	7e e1                	jle    1400046ca <__pformat_putchars+0x5a>
   1400046e9:	f6 c4 20             	test   $0x20,%ah
   1400046ec:	0f be 4e ff          	movsbl -0x1(%rsi),%ecx
   1400046f0:	48 8b 13             	mov    (%rbx),%rdx
   1400046f3:	74 cb                	je     1400046c0 <__pformat_putchars+0x50>
   1400046f5:	e8 86 51 00 00       	call   140009880 <fputc>
   1400046fa:	8b 53 24             	mov    0x24(%rbx),%edx
   1400046fd:	eb cb                	jmp    1400046ca <__pformat_putchars+0x5a>
   1400046ff:	90                   	nop
   140004700:	48 63 43 24          	movslq 0x24(%rbx),%rax
   140004704:	c6 04 02 20          	movb   $0x20,(%rdx,%rax,1)
   140004708:	8b 53 24             	mov    0x24(%rbx),%edx
   14000470b:	83 c2 01             	add    $0x1,%edx
   14000470e:	89 53 24             	mov    %edx,0x24(%rbx)
   140004711:	8b 43 0c             	mov    0xc(%rbx),%eax
   140004714:	8d 50 ff             	lea    -0x1(%rax),%edx
   140004717:	85 c0                	test   %eax,%eax
   140004719:	89 53 0c             	mov    %edx,0xc(%rbx)
   14000471c:	7e 2e                	jle    14000474c <__pformat_putchars+0xdc>
   14000471e:	8b 43 08             	mov    0x8(%rbx),%eax
   140004721:	f6 c4 40             	test   $0x40,%ah
   140004724:	75 08                	jne    14000472e <__pformat_putchars+0xbe>
   140004726:	8b 53 24             	mov    0x24(%rbx),%edx
   140004729:	39 53 28             	cmp    %edx,0x28(%rbx)
   14000472c:	7e dd                	jle    14000470b <__pformat_putchars+0x9b>
   14000472e:	f6 c4 20             	test   $0x20,%ah
   140004731:	48 8b 13             	mov    (%rbx),%rdx
   140004734:	74 ca                	je     140004700 <__pformat_putchars+0x90>
   140004736:	b9 20 00 00 00       	mov    $0x20,%ecx
   14000473b:	e8 40 51 00 00       	call   140009880 <fputc>
   140004740:	8b 53 24             	mov    0x24(%rbx),%edx
   140004743:	eb c6                	jmp    14000470b <__pformat_putchars+0x9b>
   140004745:	c7 43 0c fe ff ff ff 	movl   $0xfffffffe,0xc(%rbx)
   14000474c:	48 83 c4 20          	add    $0x20,%rsp
   140004750:	5b                   	pop    %rbx
   140004751:	5e                   	pop    %rsi
   140004752:	5f                   	pop    %rdi
   140004753:	c3                   	ret
   140004754:	0f 1f 40 00          	nopl   0x0(%rax)
   140004758:	29 f8                	sub    %edi,%eax
   14000475a:	89 c2                	mov    %eax,%edx
   14000475c:	41 89 40 0c          	mov    %eax,0xc(%r8)
   140004760:	41 8b 40 08          	mov    0x8(%r8),%eax
   140004764:	f6 c4 04             	test   $0x4,%ah
   140004767:	75 37                	jne    1400047a0 <__pformat_putchars+0x130>
   140004769:	8d 42 ff             	lea    -0x1(%rdx),%eax
   14000476c:	41 89 40 0c          	mov    %eax,0xc(%r8)
   140004770:	48 89 da             	mov    %rbx,%rdx
   140004773:	b9 20 00 00 00       	mov    $0x20,%ecx
   140004778:	e8 03 fd ff ff       	call   140004480 <__pformat_putc>
   14000477d:	8b 43 0c             	mov    0xc(%rbx),%eax
   140004780:	8d 50 ff             	lea    -0x1(%rax),%edx
   140004783:	85 c0                	test   %eax,%eax
   140004785:	89 53 0c             	mov    %edx,0xc(%rbx)
   140004788:	75 e6                	jne    140004770 <__pformat_putchars+0x100>
   14000478a:	8d 57 ff             	lea    -0x1(%rdi),%edx
   14000478d:	85 ff                	test   %edi,%edi
   14000478f:	0f 85 19 ff ff ff    	jne    1400046ae <__pformat_putchars+0x3e>
   140004795:	e9 77 ff ff ff       	jmp    140004711 <__pformat_putchars+0xa1>
   14000479a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   1400047a0:	8d 57 ff             	lea    -0x1(%rdi),%edx
   1400047a3:	85 ff                	test   %edi,%edi
   1400047a5:	0f 85 06 ff ff ff    	jne    1400046b1 <__pformat_putchars+0x41>
   1400047ab:	83 6b 0c 01          	subl   $0x1,0xc(%rbx)
   1400047af:	e9 6d ff ff ff       	jmp    140004721 <__pformat_putchars+0xb1>
   1400047b4:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   1400047bb:	00 00 00 00 
   1400047bf:	90                   	nop

00000001400047c0 <__pformat_puts>:
   1400047c0:	56                   	push   %rsi
   1400047c1:	53                   	push   %rbx
   1400047c2:	48 83 ec 28          	sub    $0x28,%rsp
   1400047c6:	48 8d 05 a3 6c 00 00 	lea    0x6ca3(%rip),%rax        # 14000b470 <.rdata>
   1400047cd:	48 89 d6             	mov    %rdx,%rsi
   1400047d0:	48 63 52 10          	movslq 0x10(%rdx),%rdx
   1400047d4:	48 85 c9             	test   %rcx,%rcx
   1400047d7:	48 89 cb             	mov    %rcx,%rbx
   1400047da:	48 0f 44 d8          	cmove  %rax,%rbx
   1400047de:	48 89 d9             	mov    %rbx,%rcx
   1400047e1:	85 d2                	test   %edx,%edx
   1400047e3:	78 1b                	js     140004800 <__pformat_puts+0x40>
   1400047e5:	e8 66 49 00 00       	call   140009150 <strnlen>
   1400047ea:	49 89 f0             	mov    %rsi,%r8
   1400047ed:	89 c2                	mov    %eax,%edx
   1400047ef:	48 89 d9             	mov    %rbx,%rcx
   1400047f2:	48 83 c4 28          	add    $0x28,%rsp
   1400047f6:	5b                   	pop    %rbx
   1400047f7:	5e                   	pop    %rsi
   1400047f8:	e9 73 fe ff ff       	jmp    140004670 <__pformat_putchars>
   1400047fd:	0f 1f 00             	nopl   (%rax)
   140004800:	e8 c3 50 00 00       	call   1400098c8 <strlen>
   140004805:	eb e3                	jmp    1400047ea <__pformat_puts+0x2a>
   140004807:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   14000480e:	00 00 

0000000140004810 <__pformat_emit_inf_or_nan>:
   140004810:	48 83 ec 38          	sub    $0x38,%rsp
   140004814:	45 8b 50 08          	mov    0x8(%r8),%r10d
   140004818:	85 c9                	test   %ecx,%ecx
   14000481a:	41 c7 40 10 ff ff ff 	movl   $0xffffffff,0x10(%r8)
   140004821:	ff 
   140004822:	75 5c                	jne    140004880 <__pformat_emit_inf_or_nan+0x70>
   140004824:	41 f7 c2 00 01 00 00 	test   $0x100,%r10d
   14000482b:	b8 2b 00 00 00       	mov    $0x2b,%eax
   140004830:	75 53                	jne    140004885 <__pformat_emit_inf_or_nan+0x75>
   140004832:	41 f6 c2 40          	test   $0x40,%r10b
   140004836:	74 60                	je     140004898 <__pformat_emit_inf_or_nan+0x88>
   140004838:	4c 8d 4c 24 2d       	lea    0x2d(%rsp),%r9
   14000483d:	b8 20 00 00 00       	mov    $0x20,%eax
   140004842:	88 44 24 2c          	mov    %al,0x2c(%rsp)
   140004846:	4c 8d 5c 24 2c       	lea    0x2c(%rsp),%r11
   14000484b:	41 83 e2 20          	and    $0x20,%r10d
   14000484f:	31 c9                	xor    %ecx,%ecx
   140004851:	0f b6 04 0a          	movzbl (%rdx,%rcx,1),%eax
   140004855:	83 e0 df             	and    $0xffffffdf,%eax
   140004858:	44 09 d0             	or     %r10d,%eax
   14000485b:	41 88 04 09          	mov    %al,(%r9,%rcx,1)
   14000485f:	48 83 c1 01          	add    $0x1,%rcx
   140004863:	48 83 f9 03          	cmp    $0x3,%rcx
   140004867:	75 e8                	jne    140004851 <__pformat_emit_inf_or_nan+0x41>
   140004869:	49 8d 51 03          	lea    0x3(%r9),%rdx
   14000486d:	4c 89 d9             	mov    %r11,%rcx
   140004870:	44 29 da             	sub    %r11d,%edx
   140004873:	e8 f8 fd ff ff       	call   140004670 <__pformat_putchars>
   140004878:	90                   	nop
   140004879:	48 83 c4 38          	add    $0x38,%rsp
   14000487d:	c3                   	ret
   14000487e:	66 90                	xchg   %ax,%ax
   140004880:	b8 2d 00 00 00       	mov    $0x2d,%eax
   140004885:	88 44 24 2c          	mov    %al,0x2c(%rsp)
   140004889:	4c 8d 4c 24 2d       	lea    0x2d(%rsp),%r9
   14000488e:	4c 8d 5c 24 2c       	lea    0x2c(%rsp),%r11
   140004893:	eb b6                	jmp    14000484b <__pformat_emit_inf_or_nan+0x3b>
   140004895:	0f 1f 00             	nopl   (%rax)
   140004898:	4c 8d 5c 24 2c       	lea    0x2c(%rsp),%r11
   14000489d:	4d 89 d9             	mov    %r11,%r9
   1400048a0:	eb a9                	jmp    14000484b <__pformat_emit_inf_or_nan+0x3b>
   1400048a2:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   1400048a9:	00 00 00 00 
   1400048ad:	0f 1f 00             	nopl   (%rax)

00000001400048b0 <__pformat_xint.isra.0>:
   1400048b0:	55                   	push   %rbp
   1400048b1:	41 57                	push   %r15
   1400048b3:	41 56                	push   %r14
   1400048b5:	41 55                	push   %r13
   1400048b7:	41 54                	push   %r12
   1400048b9:	57                   	push   %rdi
   1400048ba:	56                   	push   %rsi
   1400048bb:	53                   	push   %rbx
   1400048bc:	48 83 ec 28          	sub    $0x28,%rsp
   1400048c0:	48 8d 6c 24 20       	lea    0x20(%rsp),%rbp
   1400048c5:	83 f9 6f             	cmp    $0x6f,%ecx
   1400048c8:	41 89 ce             	mov    %ecx,%r14d
   1400048cb:	4c 89 c3             	mov    %r8,%rbx
   1400048ce:	0f 84 fc 02 00 00    	je     140004bd0 <__pformat_xint.isra.0+0x320>
   1400048d4:	45 8b 78 10          	mov    0x10(%r8),%r15d
   1400048d8:	31 c0                	xor    %eax,%eax
   1400048da:	41 8b 78 08          	mov    0x8(%r8),%edi
   1400048de:	45 85 ff             	test   %r15d,%r15d
   1400048e1:	41 0f 49 c7          	cmovns %r15d,%eax
   1400048e5:	83 c0 12             	add    $0x12,%eax
   1400048e8:	f7 c7 00 10 00 00    	test   $0x1000,%edi
   1400048ee:	0f 84 9c 00 00 00    	je     140004990 <__pformat_xint.isra.0+0xe0>
   1400048f4:	b9 04 00 00 00       	mov    $0x4,%ecx
   1400048f9:	66 83 7b 20 00       	cmpw   $0x0,0x20(%rbx)
   1400048fe:	74 14                	je     140004914 <__pformat_xint.isra.0+0x64>
   140004900:	41 89 c0             	mov    %eax,%r8d
   140004903:	41 b9 ab aa aa aa    	mov    $0xaaaaaaab,%r9d
   140004909:	4d 0f af c1          	imul   %r9,%r8
   14000490d:	49 c1 e8 21          	shr    $0x21,%r8
   140004911:	44 01 c0             	add    %r8d,%eax
   140004914:	44 8b 63 0c          	mov    0xc(%rbx),%r12d
   140004918:	41 39 c4             	cmp    %eax,%r12d
   14000491b:	41 0f 4d c4          	cmovge %r12d,%eax
   14000491f:	48 98                	cltq
   140004921:	48 83 c0 0f          	add    $0xf,%rax
   140004925:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
   140004929:	e8 d2 f9 ff ff       	call   140004300 <___chkstk_ms>
   14000492e:	45 31 c0             	xor    %r8d,%r8d
   140004931:	48 29 c4             	sub    %rax,%rsp
   140004934:	41 83 fe 6f          	cmp    $0x6f,%r14d
   140004938:	4c 8d 6c 24 20       	lea    0x20(%rsp),%r13
   14000493d:	41 0f 95 c0          	setne  %r8b
   140004941:	48 85 d2             	test   %rdx,%rdx
   140004944:	46 8d 04 c5 07 00 00 	lea    0x7(,%r8,8),%r8d
   14000494b:	00 
   14000494c:	4c 89 ee             	mov    %r13,%rsi
   14000494f:	75 74                	jne    1400049c5 <__pformat_xint.isra.0+0x115>
   140004951:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140004958:	81 e7 ff f7 ff ff    	and    $0xfffff7ff,%edi
   14000495e:	45 85 ff             	test   %r15d,%r15d
   140004961:	89 7b 08             	mov    %edi,0x8(%rbx)
   140004964:	0f 8f a1 00 00 00    	jg     140004a0b <__pformat_xint.isra.0+0x15b>
   14000496a:	41 83 fe 6f          	cmp    $0x6f,%r14d
   14000496e:	0f 85 c2 00 00 00    	jne    140004a36 <__pformat_xint.isra.0+0x186>
   140004974:	f6 43 09 08          	testb  $0x8,0x9(%rbx)
   140004978:	0f 84 b8 00 00 00    	je     140004a36 <__pformat_xint.isra.0+0x186>
   14000497e:	c6 06 30             	movb   $0x30,(%rsi)
   140004981:	48 83 c6 01          	add    $0x1,%rsi
   140004985:	e9 ac 00 00 00       	jmp    140004a36 <__pformat_xint.isra.0+0x186>
   14000498a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140004990:	44 8b 63 0c          	mov    0xc(%rbx),%r12d
   140004994:	41 39 c4             	cmp    %eax,%r12d
   140004997:	41 0f 4d c4          	cmovge %r12d,%eax
   14000499b:	48 98                	cltq
   14000499d:	48 83 c0 0f          	add    $0xf,%rax
   1400049a1:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
   1400049a5:	e8 56 f9 ff ff       	call   140004300 <___chkstk_ms>
   1400049aa:	b9 04 00 00 00       	mov    $0x4,%ecx
   1400049af:	41 b8 0f 00 00 00    	mov    $0xf,%r8d
   1400049b5:	48 29 c4             	sub    %rax,%rsp
   1400049b8:	4c 8d 6c 24 20       	lea    0x20(%rsp),%r13
   1400049bd:	48 85 d2             	test   %rdx,%rdx
   1400049c0:	4c 89 ee             	mov    %r13,%rsi
   1400049c3:	74 93                	je     140004958 <__pformat_xint.isra.0+0xa8>
   1400049c5:	45 89 f1             	mov    %r14d,%r9d
   1400049c8:	41 83 e1 20          	and    $0x20,%r9d
   1400049cc:	0f 1f 40 00          	nopl   0x0(%rax)
   1400049d0:	44 89 c0             	mov    %r8d,%eax
   1400049d3:	48 83 c6 01          	add    $0x1,%rsi
   1400049d7:	21 d0                	and    %edx,%eax
   1400049d9:	44 8d 50 30          	lea    0x30(%rax),%r10d
   1400049dd:	83 c0 37             	add    $0x37,%eax
   1400049e0:	44 09 c8             	or     %r9d,%eax
   1400049e3:	45 89 d3             	mov    %r10d,%r11d
   1400049e6:	41 80 fa 39          	cmp    $0x39,%r10b
   1400049ea:	41 0f 46 c3          	cmovbe %r11d,%eax
   1400049ee:	48 d3 ea             	shr    %cl,%rdx
   1400049f1:	48 85 d2             	test   %rdx,%rdx
   1400049f4:	88 46 ff             	mov    %al,-0x1(%rsi)
   1400049f7:	75 d7                	jne    1400049d0 <__pformat_xint.isra.0+0x120>
   1400049f9:	4c 39 ee             	cmp    %r13,%rsi
   1400049fc:	0f 84 56 ff ff ff    	je     140004958 <__pformat_xint.isra.0+0xa8>
   140004a02:	45 85 ff             	test   %r15d,%r15d
   140004a05:	0f 8e 5f ff ff ff    	jle    14000496a <__pformat_xint.isra.0+0xba>
   140004a0b:	48 89 f0             	mov    %rsi,%rax
   140004a0e:	45 89 f8             	mov    %r15d,%r8d
   140004a11:	4c 29 e8             	sub    %r13,%rax
   140004a14:	41 29 c0             	sub    %eax,%r8d
   140004a17:	45 85 c0             	test   %r8d,%r8d
   140004a1a:	0f 8e f0 01 00 00    	jle    140004c10 <__pformat_xint.isra.0+0x360>
   140004a20:	49 63 f8             	movslq %r8d,%rdi
   140004a23:	48 89 f1             	mov    %rsi,%rcx
   140004a26:	ba 30 00 00 00       	mov    $0x30,%edx
   140004a2b:	49 89 f8             	mov    %rdi,%r8
   140004a2e:	48 01 fe             	add    %rdi,%rsi
   140004a31:	e8 7a 4e 00 00       	call   1400098b0 <memset>
   140004a36:	4c 39 ee             	cmp    %r13,%rsi
   140004a39:	75 09                	jne    140004a44 <__pformat_xint.isra.0+0x194>
   140004a3b:	45 85 ff             	test   %r15d,%r15d
   140004a3e:	0f 85 94 02 00 00    	jne    140004cd8 <__pformat_xint.isra.0+0x428>
   140004a44:	48 89 f0             	mov    %rsi,%rax
   140004a47:	4c 29 e8             	sub    %r13,%rax
   140004a4a:	44 39 e0             	cmp    %r12d,%eax
   140004a4d:	7c 59                	jl     140004aa8 <__pformat_xint.isra.0+0x1f8>
   140004a4f:	41 83 fe 6f          	cmp    $0x6f,%r14d
   140004a53:	c7 43 0c ff ff ff ff 	movl   $0xffffffff,0xc(%rbx)
   140004a5a:	0f 84 90 02 00 00    	je     140004cf0 <__pformat_xint.isra.0+0x440>
   140004a60:	f6 43 09 08          	testb  $0x8,0x9(%rbx)
   140004a64:	74 0b                	je     140004a71 <__pformat_xint.isra.0+0x1c1>
   140004a66:	44 88 36             	mov    %r14b,(%rsi)
   140004a69:	48 83 c6 02          	add    $0x2,%rsi
   140004a6d:	c6 46 ff 30          	movb   $0x30,-0x1(%rsi)
   140004a71:	41 bc ff ff ff ff    	mov    $0xffffffff,%r12d
   140004a77:	49 39 f5             	cmp    %rsi,%r13
   140004a7a:	73 14                	jae    140004a90 <__pformat_xint.isra.0+0x1e0>
   140004a7c:	8b 7b 08             	mov    0x8(%rbx),%edi
   140004a7f:	45 8d 74 24 ff       	lea    -0x1(%r12),%r14d
   140004a84:	e9 b7 00 00 00       	jmp    140004b40 <__pformat_xint.isra.0+0x290>
   140004a89:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140004a90:	48 8d 65 08          	lea    0x8(%rbp),%rsp
   140004a94:	5b                   	pop    %rbx
   140004a95:	5e                   	pop    %rsi
   140004a96:	5f                   	pop    %rdi
   140004a97:	41 5c                	pop    %r12
   140004a99:	41 5d                	pop    %r13
   140004a9b:	41 5e                	pop    %r14
   140004a9d:	41 5f                	pop    %r15
   140004a9f:	5d                   	pop    %rbp
   140004aa0:	c3                   	ret
   140004aa1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140004aa8:	41 29 c4             	sub    %eax,%r12d
   140004aab:	41 83 fe 6f          	cmp    $0x6f,%r14d
   140004aaf:	8b 7b 08             	mov    0x8(%rbx),%edi
   140004ab2:	44 89 63 0c          	mov    %r12d,0xc(%rbx)
   140004ab6:	74 28                	je     140004ae0 <__pformat_xint.isra.0+0x230>
   140004ab8:	f7 c7 00 08 00 00    	test   $0x800,%edi
   140004abe:	74 20                	je     140004ae0 <__pformat_xint.isra.0+0x230>
   140004ac0:	41 83 ec 02          	sub    $0x2,%r12d
   140004ac4:	45 85 e4             	test   %r12d,%r12d
   140004ac7:	0f 8f 4c 02 00 00    	jg     140004d19 <__pformat_xint.isra.0+0x469>
   140004acd:	44 88 36             	mov    %r14b,(%rsi)
   140004ad0:	48 83 c6 02          	add    $0x2,%rsi
   140004ad4:	c6 46 ff 30          	movb   $0x30,-0x1(%rsi)
   140004ad8:	eb 9d                	jmp    140004a77 <__pformat_xint.isra.0+0x1c7>
   140004ada:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140004ae0:	45 85 ff             	test   %r15d,%r15d
   140004ae3:	0f 88 9f 01 00 00    	js     140004c88 <__pformat_xint.isra.0+0x3d8>
   140004ae9:	45 8d 74 24 ff       	lea    -0x1(%r12),%r14d
   140004aee:	f7 c7 00 04 00 00    	test   $0x400,%edi
   140004af4:	0f 85 06 01 00 00    	jne    140004c00 <__pformat_xint.isra.0+0x350>
   140004afa:	45 89 f4             	mov    %r14d,%r12d
   140004afd:	0f 1f 00             	nopl   (%rax)
   140004b00:	48 89 da             	mov    %rbx,%rdx
   140004b03:	b9 20 00 00 00       	mov    $0x20,%ecx
   140004b08:	e8 73 f9 ff ff       	call   140004480 <__pformat_putc>
   140004b0d:	41 83 ec 01          	sub    $0x1,%r12d
   140004b11:	73 ed                	jae    140004b00 <__pformat_xint.isra.0+0x250>
   140004b13:	49 39 f5             	cmp    %rsi,%r13
   140004b16:	41 be fe ff ff ff    	mov    $0xfffffffe,%r14d
   140004b1c:	72 1f                	jb     140004b3d <__pformat_xint.isra.0+0x28d>
   140004b1e:	e9 6d ff ff ff       	jmp    140004a90 <__pformat_xint.isra.0+0x1e0>
   140004b23:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140004b28:	48 63 43 24          	movslq 0x24(%rbx),%rax
   140004b2c:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
   140004b2f:	8b 43 24             	mov    0x24(%rbx),%eax
   140004b32:	83 c0 01             	add    $0x1,%eax
   140004b35:	49 39 f5             	cmp    %rsi,%r13
   140004b38:	89 43 24             	mov    %eax,0x24(%rbx)
   140004b3b:	73 38                	jae    140004b75 <__pformat_xint.isra.0+0x2c5>
   140004b3d:	8b 7b 08             	mov    0x8(%rbx),%edi
   140004b40:	48 83 ee 01          	sub    $0x1,%rsi
   140004b44:	f7 c7 00 40 00 00    	test   $0x4000,%edi
   140004b4a:	75 08                	jne    140004b54 <__pformat_xint.isra.0+0x2a4>
   140004b4c:	8b 43 24             	mov    0x24(%rbx),%eax
   140004b4f:	39 43 28             	cmp    %eax,0x28(%rbx)
   140004b52:	7e de                	jle    140004b32 <__pformat_xint.isra.0+0x282>
   140004b54:	81 e7 00 20 00 00    	and    $0x2000,%edi
   140004b5a:	0f be 0e             	movsbl (%rsi),%ecx
   140004b5d:	48 8b 13             	mov    (%rbx),%rdx
   140004b60:	74 c6                	je     140004b28 <__pformat_xint.isra.0+0x278>
   140004b62:	e8 19 4d 00 00       	call   140009880 <fputc>
   140004b67:	8b 43 24             	mov    0x24(%rbx),%eax
   140004b6a:	83 c0 01             	add    $0x1,%eax
   140004b6d:	49 39 f5             	cmp    %rsi,%r13
   140004b70:	89 43 24             	mov    %eax,0x24(%rbx)
   140004b73:	72 c8                	jb     140004b3d <__pformat_xint.isra.0+0x28d>
   140004b75:	45 85 e4             	test   %r12d,%r12d
   140004b78:	7f 27                	jg     140004ba1 <__pformat_xint.isra.0+0x2f1>
   140004b7a:	e9 11 ff ff ff       	jmp    140004a90 <__pformat_xint.isra.0+0x1e0>
   140004b7f:	90                   	nop
   140004b80:	48 63 43 24          	movslq 0x24(%rbx),%rax
   140004b84:	c6 04 02 20          	movb   $0x20,(%rdx,%rax,1)
   140004b88:	8b 43 24             	mov    0x24(%rbx),%eax
   140004b8b:	83 c0 01             	add    $0x1,%eax
   140004b8e:	45 85 f6             	test   %r14d,%r14d
   140004b91:	89 43 24             	mov    %eax,0x24(%rbx)
   140004b94:	41 8d 46 ff          	lea    -0x1(%r14),%eax
   140004b98:	0f 8e f2 fe ff ff    	jle    140004a90 <__pformat_xint.isra.0+0x1e0>
   140004b9e:	41 89 c6             	mov    %eax,%r14d
   140004ba1:	8b 7b 08             	mov    0x8(%rbx),%edi
   140004ba4:	f7 c7 00 40 00 00    	test   $0x4000,%edi
   140004baa:	75 08                	jne    140004bb4 <__pformat_xint.isra.0+0x304>
   140004bac:	8b 43 24             	mov    0x24(%rbx),%eax
   140004baf:	39 43 28             	cmp    %eax,0x28(%rbx)
   140004bb2:	7e d7                	jle    140004b8b <__pformat_xint.isra.0+0x2db>
   140004bb4:	81 e7 00 20 00 00    	and    $0x2000,%edi
   140004bba:	48 8b 13             	mov    (%rbx),%rdx
   140004bbd:	74 c1                	je     140004b80 <__pformat_xint.isra.0+0x2d0>
   140004bbf:	b9 20 00 00 00       	mov    $0x20,%ecx
   140004bc4:	e8 b7 4c 00 00       	call   140009880 <fputc>
   140004bc9:	8b 43 24             	mov    0x24(%rbx),%eax
   140004bcc:	eb bd                	jmp    140004b8b <__pformat_xint.isra.0+0x2db>
   140004bce:	66 90                	xchg   %ax,%ax
   140004bd0:	45 8b 78 10          	mov    0x10(%r8),%r15d
   140004bd4:	31 c0                	xor    %eax,%eax
   140004bd6:	41 8b 78 08          	mov    0x8(%r8),%edi
   140004bda:	45 85 ff             	test   %r15d,%r15d
   140004bdd:	41 0f 49 c7          	cmovns %r15d,%eax
   140004be1:	83 c0 18             	add    $0x18,%eax
   140004be4:	f7 c7 00 10 00 00    	test   $0x1000,%edi
   140004bea:	74 64                	je     140004c50 <__pformat_xint.isra.0+0x3a0>
   140004bec:	b9 03 00 00 00       	mov    $0x3,%ecx
   140004bf1:	e9 03 fd ff ff       	jmp    1400048f9 <__pformat_xint.isra.0+0x49>
   140004bf6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   140004bfd:	00 00 00 
   140004c00:	49 39 f5             	cmp    %rsi,%r13
   140004c03:	0f 82 37 ff ff ff    	jb     140004b40 <__pformat_xint.isra.0+0x290>
   140004c09:	eb 99                	jmp    140004ba4 <__pformat_xint.isra.0+0x2f4>
   140004c0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140004c10:	41 83 fe 6f          	cmp    $0x6f,%r14d
   140004c14:	0f 84 5a fd ff ff    	je     140004974 <__pformat_xint.isra.0+0xc4>
   140004c1a:	4c 39 ee             	cmp    %r13,%rsi
   140004c1d:	0f 84 b5 00 00 00    	je     140004cd8 <__pformat_xint.isra.0+0x428>
   140004c23:	44 39 e0             	cmp    %r12d,%eax
   140004c26:	0f 8d e1 00 00 00    	jge    140004d0d <__pformat_xint.isra.0+0x45d>
   140004c2c:	8b 7b 08             	mov    0x8(%rbx),%edi
   140004c2f:	41 29 c4             	sub    %eax,%r12d
   140004c32:	44 89 63 0c          	mov    %r12d,0xc(%rbx)
   140004c36:	f7 c7 00 08 00 00    	test   $0x800,%edi
   140004c3c:	0f 85 7e fe ff ff    	jne    140004ac0 <__pformat_xint.isra.0+0x210>
   140004c42:	e9 a2 fe ff ff       	jmp    140004ae9 <__pformat_xint.isra.0+0x239>
   140004c47:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   140004c4e:	00 00 
   140004c50:	44 8b 63 0c          	mov    0xc(%rbx),%r12d
   140004c54:	41 39 c4             	cmp    %eax,%r12d
   140004c57:	41 0f 4d c4          	cmovge %r12d,%eax
   140004c5b:	48 98                	cltq
   140004c5d:	48 83 c0 0f          	add    $0xf,%rax
   140004c61:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
   140004c65:	e8 96 f6 ff ff       	call   140004300 <___chkstk_ms>
   140004c6a:	b9 03 00 00 00       	mov    $0x3,%ecx
   140004c6f:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   140004c75:	48 29 c4             	sub    %rax,%rsp
   140004c78:	4c 8d 6c 24 20       	lea    0x20(%rsp),%r13
   140004c7d:	e9 3b fd ff ff       	jmp    1400049bd <__pformat_xint.isra.0+0x10d>
   140004c82:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140004c88:	89 f8                	mov    %edi,%eax
   140004c8a:	25 00 06 00 00       	and    $0x600,%eax
   140004c8f:	3d 00 02 00 00       	cmp    $0x200,%eax
   140004c94:	0f 85 4f fe ff ff    	jne    140004ae9 <__pformat_xint.isra.0+0x239>
   140004c9a:	4d 63 e4             	movslq %r12d,%r12
   140004c9d:	48 89 f1             	mov    %rsi,%rcx
   140004ca0:	ba 30 00 00 00       	mov    $0x30,%edx
   140004ca5:	4d 89 e0             	mov    %r12,%r8
   140004ca8:	4c 01 e6             	add    %r12,%rsi
   140004cab:	e8 00 4c 00 00       	call   1400098b0 <memset>
   140004cb0:	41 83 fe 6f          	cmp    $0x6f,%r14d
   140004cb4:	0f 84 b7 fd ff ff    	je     140004a71 <__pformat_xint.isra.0+0x1c1>
   140004cba:	81 e7 00 08 00 00    	and    $0x800,%edi
   140004cc0:	41 bc ff ff ff ff    	mov    $0xffffffff,%r12d
   140004cc6:	0f 84 ab fd ff ff    	je     140004a77 <__pformat_xint.isra.0+0x1c7>
   140004ccc:	e9 fc fd ff ff       	jmp    140004acd <__pformat_xint.isra.0+0x21d>
   140004cd1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140004cd8:	48 8d 56 01          	lea    0x1(%rsi),%rdx
   140004cdc:	c6 06 30             	movb   $0x30,(%rsi)
   140004cdf:	48 89 d0             	mov    %rdx,%rax
   140004ce2:	48 89 d6             	mov    %rdx,%rsi
   140004ce5:	4c 29 e8             	sub    %r13,%rax
   140004ce8:	e9 5d fd ff ff       	jmp    140004a4a <__pformat_xint.isra.0+0x19a>
   140004ced:	0f 1f 00             	nopl   (%rax)
   140004cf0:	49 39 f5             	cmp    %rsi,%r13
   140004cf3:	0f 83 97 fd ff ff    	jae    140004a90 <__pformat_xint.isra.0+0x1e0>
   140004cf9:	8b 7b 08             	mov    0x8(%rbx),%edi
   140004cfc:	41 be fe ff ff ff    	mov    $0xfffffffe,%r14d
   140004d02:	41 bc ff ff ff ff    	mov    $0xffffffff,%r12d
   140004d08:	e9 33 fe ff ff       	jmp    140004b40 <__pformat_xint.isra.0+0x290>
   140004d0d:	c7 43 0c ff ff ff ff 	movl   $0xffffffff,0xc(%rbx)
   140004d14:	e9 47 fd ff ff       	jmp    140004a60 <__pformat_xint.isra.0+0x1b0>
   140004d19:	45 85 ff             	test   %r15d,%r15d
   140004d1c:	78 10                	js     140004d2e <__pformat_xint.isra.0+0x47e>
   140004d1e:	44 88 36             	mov    %r14b,(%rsi)
   140004d21:	48 83 c6 02          	add    $0x2,%rsi
   140004d25:	c6 46 ff 30          	movb   $0x30,-0x1(%rsi)
   140004d29:	e9 bb fd ff ff       	jmp    140004ae9 <__pformat_xint.isra.0+0x239>
   140004d2e:	89 f8                	mov    %edi,%eax
   140004d30:	25 00 06 00 00       	and    $0x600,%eax
   140004d35:	3d 00 02 00 00       	cmp    $0x200,%eax
   140004d3a:	75 e2                	jne    140004d1e <__pformat_xint.isra.0+0x46e>
   140004d3c:	4d 63 e4             	movslq %r12d,%r12
   140004d3f:	48 89 f1             	mov    %rsi,%rcx
   140004d42:	ba 30 00 00 00       	mov    $0x30,%edx
   140004d47:	4d 89 e0             	mov    %r12,%r8
   140004d4a:	4c 01 e6             	add    %r12,%rsi
   140004d4d:	e8 5e 4b 00 00       	call   1400098b0 <memset>
   140004d52:	e9 63 ff ff ff       	jmp    140004cba <__pformat_xint.isra.0+0x40a>
   140004d57:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   140004d5e:	00 00 

0000000140004d60 <__pformat_int.isra.0>:
   140004d60:	55                   	push   %rbp
   140004d61:	41 57                	push   %r15
   140004d63:	41 56                	push   %r14
   140004d65:	41 55                	push   %r13
   140004d67:	41 54                	push   %r12
   140004d69:	57                   	push   %rdi
   140004d6a:	56                   	push   %rsi
   140004d6b:	53                   	push   %rbx
   140004d6c:	48 83 ec 28          	sub    $0x28,%rsp
   140004d70:	48 8d 6c 24 20       	lea    0x20(%rsp),%rbp
   140004d75:	31 c0                	xor    %eax,%eax
   140004d77:	44 8b 72 10          	mov    0x10(%rdx),%r14d
   140004d7b:	44 8b 62 08          	mov    0x8(%rdx),%r12d
   140004d7f:	45 85 f6             	test   %r14d,%r14d
   140004d82:	48 89 d3             	mov    %rdx,%rbx
   140004d85:	41 0f 49 c6          	cmovns %r14d,%eax
   140004d89:	83 c0 17             	add    $0x17,%eax
   140004d8c:	41 f7 c4 00 10 00 00 	test   $0x1000,%r12d
   140004d93:	74 0b                	je     140004da0 <__pformat_int.isra.0+0x40>
   140004d95:	66 83 7a 20 00       	cmpw   $0x0,0x20(%rdx)
   140004d9a:	0f 85 48 02 00 00    	jne    140004fe8 <__pformat_int.isra.0+0x288>
   140004da0:	8b 73 0c             	mov    0xc(%rbx),%esi
   140004da3:	39 c6                	cmp    %eax,%esi
   140004da5:	0f 4d c6             	cmovge %esi,%eax
   140004da8:	48 98                	cltq
   140004daa:	48 83 c0 0f          	add    $0xf,%rax
   140004dae:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
   140004db2:	e8 49 f5 ff ff       	call   140004300 <___chkstk_ms>
   140004db7:	48 29 c4             	sub    %rax,%rsp
   140004dba:	41 f6 c4 80          	test   $0x80,%r12b
   140004dbe:	4c 8d 6c 24 20       	lea    0x20(%rsp),%r13
   140004dc3:	74 11                	je     140004dd6 <__pformat_int.isra.0+0x76>
   140004dc5:	48 85 c9             	test   %rcx,%rcx
   140004dc8:	0f 88 72 02 00 00    	js     140005040 <__pformat_int.isra.0+0x2e0>
   140004dce:	41 80 e4 7f          	and    $0x7f,%r12b
   140004dd2:	44 89 63 08          	mov    %r12d,0x8(%rbx)
   140004dd6:	48 85 c9             	test   %rcx,%rcx
   140004dd9:	4c 89 ef             	mov    %r13,%rdi
   140004ddc:	0f 84 8e 00 00 00    	je     140004e70 <__pformat_int.isra.0+0x110>
   140004de2:	49 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r9
   140004de9:	cc cc cc 
   140004dec:	45 89 e2             	mov    %r12d,%r10d
   140004def:	4d 89 e8             	mov    %r13,%r8
   140004df2:	41 81 e2 00 10 00 00 	and    $0x1000,%r10d
   140004df9:	49 bb 03 00 00 00 00 	movabs $0x8000000000000003,%r11
   140004e00:	00 00 80 
   140004e03:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140004e08:	49 8d 78 01          	lea    0x1(%r8),%rdi
   140004e0c:	48 89 c8             	mov    %rcx,%rax
   140004e0f:	49 f7 e1             	mul    %r9
   140004e12:	48 89 c8             	mov    %rcx,%rax
   140004e15:	48 c1 ea 03          	shr    $0x3,%rdx
   140004e19:	4c 8d 3c 92          	lea    (%rdx,%rdx,4),%r15
   140004e1d:	4d 01 ff             	add    %r15,%r15
   140004e20:	4c 29 f8             	sub    %r15,%rax
   140004e23:	83 c0 30             	add    $0x30,%eax
   140004e26:	48 83 f9 09          	cmp    $0x9,%rcx
   140004e2a:	41 88 00             	mov    %al,(%r8)
   140004e2d:	76 41                	jbe    140004e70 <__pformat_int.isra.0+0x110>
   140004e2f:	49 39 fd             	cmp    %rdi,%r13
   140004e32:	74 2c                	je     140004e60 <__pformat_int.isra.0+0x100>
   140004e34:	45 85 d2             	test   %r10d,%r10d
   140004e37:	74 27                	je     140004e60 <__pformat_int.isra.0+0x100>
   140004e39:	66 83 7b 20 00       	cmpw   $0x0,0x20(%rbx)
   140004e3e:	74 20                	je     140004e60 <__pformat_int.isra.0+0x100>
   140004e40:	48 89 f8             	mov    %rdi,%rax
   140004e43:	4c 29 e8             	sub    %r13,%rax
   140004e46:	4c 21 d8             	and    %r11,%rax
   140004e49:	48 83 f8 03          	cmp    $0x3,%rax
   140004e4d:	75 11                	jne    140004e60 <__pformat_int.isra.0+0x100>
   140004e4f:	c6 07 2c             	movb   $0x2c,(%rdi)
   140004e52:	49 8d 78 02          	lea    0x2(%r8),%rdi
   140004e56:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   140004e5d:	00 00 00 
   140004e60:	48 89 d1             	mov    %rdx,%rcx
   140004e63:	49 89 f8             	mov    %rdi,%r8
   140004e66:	eb a0                	jmp    140004e08 <__pformat_int.isra.0+0xa8>
   140004e68:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   140004e6f:	00 
   140004e70:	45 85 f6             	test   %r14d,%r14d
   140004e73:	7e 2b                	jle    140004ea0 <__pformat_int.isra.0+0x140>
   140004e75:	48 89 f8             	mov    %rdi,%rax
   140004e78:	45 89 f0             	mov    %r14d,%r8d
   140004e7b:	4c 29 e8             	sub    %r13,%rax
   140004e7e:	41 29 c0             	sub    %eax,%r8d
   140004e81:	45 85 c0             	test   %r8d,%r8d
   140004e84:	0f 8e 96 01 00 00    	jle    140005020 <__pformat_int.isra.0+0x2c0>
   140004e8a:	4d 63 f8             	movslq %r8d,%r15
   140004e8d:	48 89 f9             	mov    %rdi,%rcx
   140004e90:	ba 30 00 00 00       	mov    $0x30,%edx
   140004e95:	4d 89 f8             	mov    %r15,%r8
   140004e98:	4c 01 ff             	add    %r15,%rdi
   140004e9b:	e8 10 4a 00 00       	call   1400098b0 <memset>
   140004ea0:	49 39 fd             	cmp    %rdi,%r13
   140004ea3:	75 0c                	jne    140004eb1 <__pformat_int.isra.0+0x151>
   140004ea5:	45 85 f6             	test   %r14d,%r14d
   140004ea8:	48 89 f8             	mov    %rdi,%rax
   140004eab:	0f 85 7b 01 00 00    	jne    14000502c <__pformat_int.isra.0+0x2cc>
   140004eb1:	85 f6                	test   %esi,%esi
   140004eb3:	7e 3b                	jle    140004ef0 <__pformat_int.isra.0+0x190>
   140004eb5:	48 89 f8             	mov    %rdi,%rax
   140004eb8:	4c 29 e8             	sub    %r13,%rax
   140004ebb:	29 c6                	sub    %eax,%esi
   140004ebd:	85 f6                	test   %esi,%esi
   140004ebf:	89 73 0c             	mov    %esi,0xc(%rbx)
   140004ec2:	7e 2c                	jle    140004ef0 <__pformat_int.isra.0+0x190>
   140004ec4:	41 f7 c4 c0 01 00 00 	test   $0x1c0,%r12d
   140004ecb:	0f 85 7f 01 00 00    	jne    140005050 <__pformat_int.isra.0+0x2f0>
   140004ed1:	45 85 f6             	test   %r14d,%r14d
   140004ed4:	0f 88 85 01 00 00    	js     14000505f <__pformat_int.isra.0+0x2ff>
   140004eda:	41 f7 c4 00 04 00 00 	test   $0x400,%r12d
   140004ee1:	0f 84 c1 01 00 00    	je     1400050a8 <__pformat_int.isra.0+0x348>
   140004ee7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   140004eee:	00 00 
   140004ef0:	41 f6 c4 80          	test   $0x80,%r12b
   140004ef4:	0f 84 d6 00 00 00    	je     140004fd0 <__pformat_int.isra.0+0x270>
   140004efa:	48 8d 77 01          	lea    0x1(%rdi),%rsi
   140004efe:	c6 07 2d             	movb   $0x2d,(%rdi)
   140004f01:	49 39 f5             	cmp    %rsi,%r13
   140004f04:	72 23                	jb     140004f29 <__pformat_int.isra.0+0x1c9>
   140004f06:	eb 58                	jmp    140004f60 <__pformat_int.isra.0+0x200>
   140004f08:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   140004f0f:	00 
   140004f10:	48 63 43 24          	movslq 0x24(%rbx),%rax
   140004f14:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
   140004f17:	8b 43 24             	mov    0x24(%rbx),%eax
   140004f1a:	83 c0 01             	add    $0x1,%eax
   140004f1d:	49 39 f5             	cmp    %rsi,%r13
   140004f20:	89 43 24             	mov    %eax,0x24(%rbx)
   140004f23:	74 3b                	je     140004f60 <__pformat_int.isra.0+0x200>
   140004f25:	44 8b 63 08          	mov    0x8(%rbx),%r12d
   140004f29:	48 83 ee 01          	sub    $0x1,%rsi
   140004f2d:	41 f7 c4 00 40 00 00 	test   $0x4000,%r12d
   140004f34:	75 08                	jne    140004f3e <__pformat_int.isra.0+0x1de>
   140004f36:	8b 43 24             	mov    0x24(%rbx),%eax
   140004f39:	39 43 28             	cmp    %eax,0x28(%rbx)
   140004f3c:	7e dc                	jle    140004f1a <__pformat_int.isra.0+0x1ba>
   140004f3e:	41 81 e4 00 20 00 00 	and    $0x2000,%r12d
   140004f45:	0f be 0e             	movsbl (%rsi),%ecx
   140004f48:	48 8b 13             	mov    (%rbx),%rdx
   140004f4b:	74 c3                	je     140004f10 <__pformat_int.isra.0+0x1b0>
   140004f4d:	e8 2e 49 00 00       	call   140009880 <fputc>
   140004f52:	8b 43 24             	mov    0x24(%rbx),%eax
   140004f55:	83 c0 01             	add    $0x1,%eax
   140004f58:	49 39 f5             	cmp    %rsi,%r13
   140004f5b:	89 43 24             	mov    %eax,0x24(%rbx)
   140004f5e:	75 c5                	jne    140004f25 <__pformat_int.isra.0+0x1c5>
   140004f60:	8b 43 0c             	mov    0xc(%rbx),%eax
   140004f63:	eb 17                	jmp    140004f7c <__pformat_int.isra.0+0x21c>
   140004f65:	0f 1f 00             	nopl   (%rax)
   140004f68:	48 63 43 24          	movslq 0x24(%rbx),%rax
   140004f6c:	c6 04 02 20          	movb   $0x20,(%rdx,%rax,1)
   140004f70:	8b 53 24             	mov    0x24(%rbx),%edx
   140004f73:	8b 43 0c             	mov    0xc(%rbx),%eax
   140004f76:	83 c2 01             	add    $0x1,%edx
   140004f79:	89 53 24             	mov    %edx,0x24(%rbx)
   140004f7c:	89 c2                	mov    %eax,%edx
   140004f7e:	83 e8 01             	sub    $0x1,%eax
   140004f81:	85 d2                	test   %edx,%edx
   140004f83:	89 43 0c             	mov    %eax,0xc(%rbx)
   140004f86:	7e 30                	jle    140004fb8 <__pformat_int.isra.0+0x258>
   140004f88:	8b 4b 08             	mov    0x8(%rbx),%ecx
   140004f8b:	f6 c5 40             	test   $0x40,%ch
   140004f8e:	75 08                	jne    140004f98 <__pformat_int.isra.0+0x238>
   140004f90:	8b 53 24             	mov    0x24(%rbx),%edx
   140004f93:	39 53 28             	cmp    %edx,0x28(%rbx)
   140004f96:	7e de                	jle    140004f76 <__pformat_int.isra.0+0x216>
   140004f98:	80 e5 20             	and    $0x20,%ch
   140004f9b:	48 8b 13             	mov    (%rbx),%rdx
   140004f9e:	74 c8                	je     140004f68 <__pformat_int.isra.0+0x208>
   140004fa0:	b9 20 00 00 00       	mov    $0x20,%ecx
   140004fa5:	e8 d6 48 00 00       	call   140009880 <fputc>
   140004faa:	8b 53 24             	mov    0x24(%rbx),%edx
   140004fad:	8b 43 0c             	mov    0xc(%rbx),%eax
   140004fb0:	eb c4                	jmp    140004f76 <__pformat_int.isra.0+0x216>
   140004fb2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140004fb8:	48 8d 65 08          	lea    0x8(%rbp),%rsp
   140004fbc:	5b                   	pop    %rbx
   140004fbd:	5e                   	pop    %rsi
   140004fbe:	5f                   	pop    %rdi
   140004fbf:	41 5c                	pop    %r12
   140004fc1:	41 5d                	pop    %r13
   140004fc3:	41 5e                	pop    %r14
   140004fc5:	41 5f                	pop    %r15
   140004fc7:	5d                   	pop    %rbp
   140004fc8:	c3                   	ret
   140004fc9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140004fd0:	41 f7 c4 00 01 00 00 	test   $0x100,%r12d
   140004fd7:	74 27                	je     140005000 <__pformat_int.isra.0+0x2a0>
   140004fd9:	48 8d 77 01          	lea    0x1(%rdi),%rsi
   140004fdd:	c6 07 2b             	movb   $0x2b,(%rdi)
   140004fe0:	e9 1c ff ff ff       	jmp    140004f01 <__pformat_int.isra.0+0x1a1>
   140004fe5:	0f 1f 00             	nopl   (%rax)
   140004fe8:	89 c2                	mov    %eax,%edx
   140004fea:	41 b8 ab aa aa aa    	mov    $0xaaaaaaab,%r8d
   140004ff0:	49 0f af d0          	imul   %r8,%rdx
   140004ff4:	48 c1 ea 21          	shr    $0x21,%rdx
   140004ff8:	01 d0                	add    %edx,%eax
   140004ffa:	e9 a1 fd ff ff       	jmp    140004da0 <__pformat_int.isra.0+0x40>
   140004fff:	90                   	nop
   140005000:	41 f6 c4 40          	test   $0x40,%r12b
   140005004:	48 89 fe             	mov    %rdi,%rsi
   140005007:	0f 84 f4 fe ff ff    	je     140004f01 <__pformat_int.isra.0+0x1a1>
   14000500d:	48 83 c6 01          	add    $0x1,%rsi
   140005011:	c6 07 20             	movb   $0x20,(%rdi)
   140005014:	e9 e8 fe ff ff       	jmp    140004f01 <__pformat_int.isra.0+0x1a1>
   140005019:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140005020:	49 39 fd             	cmp    %rdi,%r13
   140005023:	0f 85 88 fe ff ff    	jne    140004eb1 <__pformat_int.isra.0+0x151>
   140005029:	4c 89 e8             	mov    %r13,%rax
   14000502c:	48 8d 78 01          	lea    0x1(%rax),%rdi
   140005030:	c6 00 30             	movb   $0x30,(%rax)
   140005033:	e9 79 fe ff ff       	jmp    140004eb1 <__pformat_int.isra.0+0x151>
   140005038:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   14000503f:	00 
   140005040:	48 f7 d9             	neg    %rcx
   140005043:	e9 9a fd ff ff       	jmp    140004de2 <__pformat_int.isra.0+0x82>
   140005048:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   14000504f:	00 
   140005050:	83 ee 01             	sub    $0x1,%esi
   140005053:	45 85 f6             	test   %r14d,%r14d
   140005056:	89 73 0c             	mov    %esi,0xc(%rbx)
   140005059:	0f 89 7b fe ff ff    	jns    140004eda <__pformat_int.isra.0+0x17a>
   14000505f:	44 89 e0             	mov    %r12d,%eax
   140005062:	25 00 06 00 00       	and    $0x600,%eax
   140005067:	3d 00 02 00 00       	cmp    $0x200,%eax
   14000506c:	0f 85 68 fe ff ff    	jne    140004eda <__pformat_int.isra.0+0x17a>
   140005072:	8b 43 0c             	mov    0xc(%rbx),%eax
   140005075:	8d 50 ff             	lea    -0x1(%rax),%edx
   140005078:	85 c0                	test   %eax,%eax
   14000507a:	89 53 0c             	mov    %edx,0xc(%rbx)
   14000507d:	0f 8e 6d fe ff ff    	jle    140004ef0 <__pformat_int.isra.0+0x190>
   140005083:	48 63 f0             	movslq %eax,%rsi
   140005086:	48 89 f9             	mov    %rdi,%rcx
   140005089:	ba 30 00 00 00       	mov    $0x30,%edx
   14000508e:	49 89 f0             	mov    %rsi,%r8
   140005091:	48 01 f7             	add    %rsi,%rdi
   140005094:	e8 17 48 00 00       	call   1400098b0 <memset>
   140005099:	c7 43 0c ff ff ff ff 	movl   $0xffffffff,0xc(%rbx)
   1400050a0:	e9 4b fe ff ff       	jmp    140004ef0 <__pformat_int.isra.0+0x190>
   1400050a5:	0f 1f 00             	nopl   (%rax)
   1400050a8:	8b 43 0c             	mov    0xc(%rbx),%eax
   1400050ab:	8d 50 ff             	lea    -0x1(%rax),%edx
   1400050ae:	85 c0                	test   %eax,%eax
   1400050b0:	89 53 0c             	mov    %edx,0xc(%rbx)
   1400050b3:	0f 8e 37 fe ff ff    	jle    140004ef0 <__pformat_int.isra.0+0x190>
   1400050b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   1400050c0:	48 89 da             	mov    %rbx,%rdx
   1400050c3:	b9 20 00 00 00       	mov    $0x20,%ecx
   1400050c8:	e8 b3 f3 ff ff       	call   140004480 <__pformat_putc>
   1400050cd:	8b 43 0c             	mov    0xc(%rbx),%eax
   1400050d0:	8d 50 ff             	lea    -0x1(%rax),%edx
   1400050d3:	85 c0                	test   %eax,%eax
   1400050d5:	89 53 0c             	mov    %edx,0xc(%rbx)
   1400050d8:	7f e6                	jg     1400050c0 <__pformat_int.isra.0+0x360>
   1400050da:	44 8b 63 08          	mov    0x8(%rbx),%r12d
   1400050de:	e9 0d fe ff ff       	jmp    140004ef0 <__pformat_int.isra.0+0x190>
   1400050e3:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   1400050ea:	00 00 00 00 
   1400050ee:	66 90                	xchg   %ax,%ax

00000001400050f0 <__pformat_emit_radix_point>:
   1400050f0:	55                   	push   %rbp
   1400050f1:	41 54                	push   %r12
   1400050f3:	57                   	push   %rdi
   1400050f4:	56                   	push   %rsi
   1400050f5:	53                   	push   %rbx
   1400050f6:	48 83 ec 30          	sub    $0x30,%rsp
   1400050fa:	48 8d 6c 24 30       	lea    0x30(%rsp),%rbp
   1400050ff:	83 79 14 fd          	cmpl   $0xfffffffd,0x14(%rcx)
   140005103:	48 89 cb             	mov    %rcx,%rbx
   140005106:	0f 84 d4 00 00 00    	je     1400051e0 <__pformat_emit_radix_point+0xf0>
   14000510c:	0f b7 51 18          	movzwl 0x18(%rcx),%edx
   140005110:	66 85 d2             	test   %dx,%dx
   140005113:	0f 84 a7 00 00 00    	je     1400051c0 <__pformat_emit_radix_point+0xd0>
   140005119:	48 63 43 14          	movslq 0x14(%rbx),%rax
   14000511d:	48 89 e7             	mov    %rsp,%rdi
   140005120:	48 83 c0 0f          	add    $0xf,%rax
   140005124:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
   140005128:	e8 d3 f1 ff ff       	call   140004300 <___chkstk_ms>
   14000512d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   140005134:	00 
   140005135:	4c 8d 45 f8          	lea    -0x8(%rbp),%r8
   140005139:	48 29 c4             	sub    %rax,%rsp
   14000513c:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
   140005141:	48 89 f1             	mov    %rsi,%rcx
   140005144:	e8 27 42 00 00       	call   140009370 <wcrtomb>
   140005149:	85 c0                	test   %eax,%eax
   14000514b:	0f 8e cf 00 00 00    	jle    140005220 <__pformat_emit_radix_point+0x130>
   140005151:	83 e8 01             	sub    $0x1,%eax
   140005154:	4c 8d 64 06 01       	lea    0x1(%rsi,%rax,1),%r12
   140005159:	eb 1a                	jmp    140005175 <__pformat_emit_radix_point+0x85>
   14000515b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140005160:	48 63 53 24          	movslq 0x24(%rbx),%rdx
   140005164:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
   140005167:	8b 43 24             	mov    0x24(%rbx),%eax
   14000516a:	83 c0 01             	add    $0x1,%eax
   14000516d:	49 39 f4             	cmp    %rsi,%r12
   140005170:	89 43 24             	mov    %eax,0x24(%rbx)
   140005173:	74 36                	je     1400051ab <__pformat_emit_radix_point+0xbb>
   140005175:	8b 53 08             	mov    0x8(%rbx),%edx
   140005178:	48 83 c6 01          	add    $0x1,%rsi
   14000517c:	f6 c6 40             	test   $0x40,%dh
   14000517f:	75 08                	jne    140005189 <__pformat_emit_radix_point+0x99>
   140005181:	8b 43 24             	mov    0x24(%rbx),%eax
   140005184:	39 43 28             	cmp    %eax,0x28(%rbx)
   140005187:	7e e1                	jle    14000516a <__pformat_emit_radix_point+0x7a>
   140005189:	80 e6 20             	and    $0x20,%dh
   14000518c:	0f be 4e ff          	movsbl -0x1(%rsi),%ecx
   140005190:	48 8b 03             	mov    (%rbx),%rax
   140005193:	74 cb                	je     140005160 <__pformat_emit_radix_point+0x70>
   140005195:	48 89 c2             	mov    %rax,%rdx
   140005198:	e8 e3 46 00 00       	call   140009880 <fputc>
   14000519d:	8b 43 24             	mov    0x24(%rbx),%eax
   1400051a0:	83 c0 01             	add    $0x1,%eax
   1400051a3:	49 39 f4             	cmp    %rsi,%r12
   1400051a6:	89 43 24             	mov    %eax,0x24(%rbx)
   1400051a9:	75 ca                	jne    140005175 <__pformat_emit_radix_point+0x85>
   1400051ab:	48 89 fc             	mov    %rdi,%rsp
   1400051ae:	48 89 ec             	mov    %rbp,%rsp
   1400051b1:	5b                   	pop    %rbx
   1400051b2:	5e                   	pop    %rsi
   1400051b3:	5f                   	pop    %rdi
   1400051b4:	41 5c                	pop    %r12
   1400051b6:	5d                   	pop    %rbp
   1400051b7:	c3                   	ret
   1400051b8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   1400051bf:	00 
   1400051c0:	48 89 da             	mov    %rbx,%rdx
   1400051c3:	b9 2e 00 00 00       	mov    $0x2e,%ecx
   1400051c8:	e8 b3 f2 ff ff       	call   140004480 <__pformat_putc>
   1400051cd:	90                   	nop
   1400051ce:	48 89 ec             	mov    %rbp,%rsp
   1400051d1:	5b                   	pop    %rbx
   1400051d2:	5e                   	pop    %rsi
   1400051d3:	5f                   	pop    %rdi
   1400051d4:	41 5c                	pop    %r12
   1400051d6:	5d                   	pop    %rbp
   1400051d7:	c3                   	ret
   1400051d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   1400051df:	00 
   1400051e0:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   1400051e7:	00 
   1400051e8:	48 8d 75 f8          	lea    -0x8(%rbp),%rsi
   1400051ec:	e8 a7 46 00 00       	call   140009898 <localeconv>
   1400051f1:	48 8d 4d f6          	lea    -0xa(%rbp),%rcx
   1400051f5:	49 89 f1             	mov    %rsi,%r9
   1400051f8:	41 b8 10 00 00 00    	mov    $0x10,%r8d
   1400051fe:	48 8b 10             	mov    (%rax),%rdx
   140005201:	e8 0a 44 00 00       	call   140009610 <mbrtowc>
   140005206:	85 c0                	test   %eax,%eax
   140005208:	7e 2e                	jle    140005238 <__pformat_emit_radix_point+0x148>
   14000520a:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   14000520e:	66 89 53 18          	mov    %dx,0x18(%rbx)
   140005212:	89 43 14             	mov    %eax,0x14(%rbx)
   140005215:	e9 f6 fe ff ff       	jmp    140005110 <__pformat_emit_radix_point+0x20>
   14000521a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140005220:	48 89 da             	mov    %rbx,%rdx
   140005223:	b9 2e 00 00 00       	mov    $0x2e,%ecx
   140005228:	e8 53 f2 ff ff       	call   140004480 <__pformat_putc>
   14000522d:	48 89 fc             	mov    %rdi,%rsp
   140005230:	e9 79 ff ff ff       	jmp    1400051ae <__pformat_emit_radix_point+0xbe>
   140005235:	0f 1f 00             	nopl   (%rax)
   140005238:	0f b7 53 18          	movzwl 0x18(%rbx),%edx
   14000523c:	eb d4                	jmp    140005212 <__pformat_emit_radix_point+0x122>
   14000523e:	66 90                	xchg   %ax,%ax

0000000140005240 <__pformat_emit_float>:
   140005240:	55                   	push   %rbp
   140005241:	57                   	push   %rdi
   140005242:	56                   	push   %rsi
   140005243:	53                   	push   %rbx
   140005244:	48 83 ec 28          	sub    $0x28,%rsp
   140005248:	45 85 c0             	test   %r8d,%r8d
   14000524b:	89 cd                	mov    %ecx,%ebp
   14000524d:	48 89 d7             	mov    %rdx,%rdi
   140005250:	41 8b 49 0c          	mov    0xc(%r9),%ecx
   140005254:	44 89 c6             	mov    %r8d,%esi
   140005257:	4c 89 cb             	mov    %r9,%rbx
   14000525a:	0f 8e 30 01 00 00    	jle    140005390 <__pformat_emit_float+0x150>
   140005260:	41 39 c8             	cmp    %ecx,%r8d
   140005263:	7f 63                	jg     1400052c8 <__pformat_emit_float+0x88>
   140005265:	41 8b 41 10          	mov    0x10(%r9),%eax
   140005269:	44 29 c1             	sub    %r8d,%ecx
   14000526c:	39 c1                	cmp    %eax,%ecx
   14000526e:	0f 8e 3c 03 00 00    	jle    1400055b0 <__pformat_emit_float+0x370>
   140005274:	29 c1                	sub    %eax,%ecx
   140005276:	85 c0                	test   %eax,%eax
   140005278:	89 4b 0c             	mov    %ecx,0xc(%rbx)
   14000527b:	0f 8e 47 02 00 00    	jle    1400054c8 <__pformat_emit_float+0x288>
   140005281:	83 e9 01             	sub    $0x1,%ecx
   140005284:	85 f6                	test   %esi,%esi
   140005286:	89 4b 0c             	mov    %ecx,0xc(%rbx)
   140005289:	7e 0a                	jle    140005295 <__pformat_emit_float+0x55>
   14000528b:	f6 43 09 10          	testb  $0x10,0x9(%rbx)
   14000528f:	0f 85 50 02 00 00    	jne    1400054e5 <__pformat_emit_float+0x2a5>
   140005295:	85 c9                	test   %ecx,%ecx
   140005297:	7e 42                	jle    1400052db <__pformat_emit_float+0x9b>
   140005299:	85 ed                	test   %ebp,%ebp
   14000529b:	0f 85 c7 01 00 00    	jne    140005468 <__pformat_emit_float+0x228>
   1400052a1:	8b 43 08             	mov    0x8(%rbx),%eax
   1400052a4:	a9 c0 01 00 00       	test   $0x1c0,%eax
   1400052a9:	0f 84 e9 02 00 00    	je     140005598 <__pformat_emit_float+0x358>
   1400052af:	8d 51 ff             	lea    -0x1(%rcx),%edx
   1400052b2:	85 d2                	test   %edx,%edx
   1400052b4:	89 53 0c             	mov    %edx,0xc(%rbx)
   1400052b7:	74 2d                	je     1400052e6 <__pformat_emit_float+0xa6>
   1400052b9:	f6 c4 06             	test   $0x6,%ah
   1400052bc:	75 28                	jne    1400052e6 <__pformat_emit_float+0xa6>
   1400052be:	e9 c0 01 00 00       	jmp    140005483 <__pformat_emit_float+0x243>
   1400052c3:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   1400052c8:	41 f6 41 09 10       	testb  $0x10,0x9(%r9)
   1400052cd:	41 c7 41 0c ff ff ff 	movl   $0xffffffff,0xc(%r9)
   1400052d4:	ff 
   1400052d5:	0f 85 65 02 00 00    	jne    140005540 <__pformat_emit_float+0x300>
   1400052db:	85 ed                	test   %ebp,%ebp
   1400052dd:	0f 85 dd 00 00 00    	jne    1400053c0 <__pformat_emit_float+0x180>
   1400052e3:	8b 43 08             	mov    0x8(%rbx),%eax
   1400052e6:	f6 c4 01             	test   $0x1,%ah
   1400052e9:	0f 85 09 02 00 00    	jne    1400054f8 <__pformat_emit_float+0x2b8>
   1400052ef:	a8 40                	test   $0x40,%al
   1400052f1:	0f 85 f9 02 00 00    	jne    1400055f0 <__pformat_emit_float+0x3b0>
   1400052f7:	8b 43 0c             	mov    0xc(%rbx),%eax
   1400052fa:	85 c0                	test   %eax,%eax
   1400052fc:	7e 15                	jle    140005313 <__pformat_emit_float+0xd3>
   1400052fe:	8b 53 08             	mov    0x8(%rbx),%edx
   140005301:	81 e2 00 06 00 00    	and    $0x600,%edx
   140005307:	81 fa 00 02 00 00    	cmp    $0x200,%edx
   14000530d:	0f 84 fd 01 00 00    	je     140005510 <__pformat_emit_float+0x2d0>
   140005313:	85 f6                	test   %esi,%esi
   140005315:	0f 8e 05 01 00 00    	jle    140005420 <__pformat_emit_float+0x1e0>
   14000531b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140005320:	0f b6 07             	movzbl (%rdi),%eax
   140005323:	b9 30 00 00 00       	mov    $0x30,%ecx
   140005328:	84 c0                	test   %al,%al
   14000532a:	74 07                	je     140005333 <__pformat_emit_float+0xf3>
   14000532c:	48 83 c7 01          	add    $0x1,%rdi
   140005330:	0f be c8             	movsbl %al,%ecx
   140005333:	48 89 da             	mov    %rbx,%rdx
   140005336:	e8 45 f1 ff ff       	call   140004480 <__pformat_putc>
   14000533b:	83 ee 01             	sub    $0x1,%esi
   14000533e:	74 30                	je     140005370 <__pformat_emit_float+0x130>
   140005340:	f6 43 09 10          	testb  $0x10,0x9(%rbx)
   140005344:	74 da                	je     140005320 <__pformat_emit_float+0xe0>
   140005346:	66 83 7b 20 00       	cmpw   $0x0,0x20(%rbx)
   14000534b:	74 d3                	je     140005320 <__pformat_emit_float+0xe0>
   14000534d:	69 c6 ab aa aa aa    	imul   $0xaaaaaaab,%esi,%eax
   140005353:	3d 55 55 55 55       	cmp    $0x55555555,%eax
   140005358:	77 c6                	ja     140005320 <__pformat_emit_float+0xe0>
   14000535a:	48 8d 4b 20          	lea    0x20(%rbx),%rcx
   14000535e:	49 89 d8             	mov    %rbx,%r8
   140005361:	ba 01 00 00 00       	mov    $0x1,%edx
   140005366:	e8 75 f1 ff ff       	call   1400044e0 <__pformat_wputchars>
   14000536b:	eb b3                	jmp    140005320 <__pformat_emit_float+0xe0>
   14000536d:	0f 1f 00             	nopl   (%rax)
   140005370:	8b 43 10             	mov    0x10(%rbx),%eax
   140005373:	85 c0                	test   %eax,%eax
   140005375:	7f 61                	jg     1400053d8 <__pformat_emit_float+0x198>
   140005377:	f6 43 09 08          	testb  $0x8,0x9(%rbx)
   14000537b:	0f 85 b7 00 00 00    	jne    140005438 <__pformat_emit_float+0x1f8>
   140005381:	83 e8 01             	sub    $0x1,%eax
   140005384:	89 43 10             	mov    %eax,0x10(%rbx)
   140005387:	48 83 c4 28          	add    $0x28,%rsp
   14000538b:	5b                   	pop    %rbx
   14000538c:	5e                   	pop    %rsi
   14000538d:	5f                   	pop    %rdi
   14000538e:	5d                   	pop    %rbp
   14000538f:	c3                   	ret
   140005390:	85 c9                	test   %ecx,%ecx
   140005392:	0f 8e 18 01 00 00    	jle    1400054b0 <__pformat_emit_float+0x270>
   140005398:	41 8b 41 10          	mov    0x10(%r9),%eax
   14000539c:	83 e9 01             	sub    $0x1,%ecx
   14000539f:	39 c1                	cmp    %eax,%ecx
   1400053a1:	0f 8f cd fe ff ff    	jg     140005274 <__pformat_emit_float+0x34>
   1400053a7:	85 ed                	test   %ebp,%ebp
   1400053a9:	c7 43 0c ff ff ff ff 	movl   $0xffffffff,0xc(%rbx)
   1400053b0:	0f 84 2d ff ff ff    	je     1400052e3 <__pformat_emit_float+0xa3>
   1400053b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   1400053bd:	00 00 00 
   1400053c0:	48 89 da             	mov    %rbx,%rdx
   1400053c3:	b9 2d 00 00 00       	mov    $0x2d,%ecx
   1400053c8:	e8 b3 f0 ff ff       	call   140004480 <__pformat_putc>
   1400053cd:	e9 25 ff ff ff       	jmp    1400052f7 <__pformat_emit_float+0xb7>
   1400053d2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   1400053d8:	48 89 d9             	mov    %rbx,%rcx
   1400053db:	e8 10 fd ff ff       	call   1400050f0 <__pformat_emit_radix_point>
   1400053e0:	eb 21                	jmp    140005403 <__pformat_emit_float+0x1c3>
   1400053e2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   1400053e8:	0f b6 07             	movzbl (%rdi),%eax
   1400053eb:	b9 30 00 00 00       	mov    $0x30,%ecx
   1400053f0:	84 c0                	test   %al,%al
   1400053f2:	74 07                	je     1400053fb <__pformat_emit_float+0x1bb>
   1400053f4:	48 83 c7 01          	add    $0x1,%rdi
   1400053f8:	0f be c8             	movsbl %al,%ecx
   1400053fb:	48 89 da             	mov    %rbx,%rdx
   1400053fe:	e8 7d f0 ff ff       	call   140004480 <__pformat_putc>
   140005403:	8b 43 10             	mov    0x10(%rbx),%eax
   140005406:	8d 50 ff             	lea    -0x1(%rax),%edx
   140005409:	85 c0                	test   %eax,%eax
   14000540b:	89 53 10             	mov    %edx,0x10(%rbx)
   14000540e:	7f d8                	jg     1400053e8 <__pformat_emit_float+0x1a8>
   140005410:	48 83 c4 28          	add    $0x28,%rsp
   140005414:	5b                   	pop    %rbx
   140005415:	5e                   	pop    %rsi
   140005416:	5f                   	pop    %rdi
   140005417:	5d                   	pop    %rbp
   140005418:	c3                   	ret
   140005419:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140005420:	48 89 da             	mov    %rbx,%rdx
   140005423:	b9 30 00 00 00       	mov    $0x30,%ecx
   140005428:	e8 53 f0 ff ff       	call   140004480 <__pformat_putc>
   14000542d:	8b 43 10             	mov    0x10(%rbx),%eax
   140005430:	85 c0                	test   %eax,%eax
   140005432:	0f 8e ca 01 00 00    	jle    140005602 <__pformat_emit_float+0x3c2>
   140005438:	48 89 d9             	mov    %rbx,%rcx
   14000543b:	e8 b0 fc ff ff       	call   1400050f0 <__pformat_emit_radix_point>
   140005440:	85 f6                	test   %esi,%esi
   140005442:	74 bf                	je     140005403 <__pformat_emit_float+0x1c3>
   140005444:	8b 43 10             	mov    0x10(%rbx),%eax
   140005447:	01 f0                	add    %esi,%eax
   140005449:	89 43 10             	mov    %eax,0x10(%rbx)
   14000544c:	0f 1f 40 00          	nopl   0x0(%rax)
   140005450:	48 89 da             	mov    %rbx,%rdx
   140005453:	b9 30 00 00 00       	mov    $0x30,%ecx
   140005458:	e8 23 f0 ff ff       	call   140004480 <__pformat_putc>
   14000545d:	83 c6 01             	add    $0x1,%esi
   140005460:	75 ee                	jne    140005450 <__pformat_emit_float+0x210>
   140005462:	eb 9f                	jmp    140005403 <__pformat_emit_float+0x1c3>
   140005464:	0f 1f 40 00          	nopl   0x0(%rax)
   140005468:	8d 41 ff             	lea    -0x1(%rcx),%eax
   14000546b:	85 c0                	test   %eax,%eax
   14000546d:	89 43 0c             	mov    %eax,0xc(%rbx)
   140005470:	0f 84 4a ff ff ff    	je     1400053c0 <__pformat_emit_float+0x180>
   140005476:	f7 43 08 00 06 00 00 	testl  $0x600,0x8(%rbx)
   14000547d:	0f 85 3d ff ff ff    	jne    1400053c0 <__pformat_emit_float+0x180>
   140005483:	83 e9 02             	sub    $0x2,%ecx
   140005486:	89 4b 0c             	mov    %ecx,0xc(%rbx)
   140005489:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140005490:	48 89 da             	mov    %rbx,%rdx
   140005493:	b9 20 00 00 00       	mov    $0x20,%ecx
   140005498:	e8 e3 ef ff ff       	call   140004480 <__pformat_putc>
   14000549d:	8b 43 0c             	mov    0xc(%rbx),%eax
   1400054a0:	8d 50 ff             	lea    -0x1(%rax),%edx
   1400054a3:	85 c0                	test   %eax,%eax
   1400054a5:	89 53 0c             	mov    %edx,0xc(%rbx)
   1400054a8:	7f e6                	jg     140005490 <__pformat_emit_float+0x250>
   1400054aa:	e9 2c fe ff ff       	jmp    1400052db <__pformat_emit_float+0x9b>
   1400054af:	90                   	nop
   1400054b0:	0f 85 f1 fe ff ff    	jne    1400053a7 <__pformat_emit_float+0x167>
   1400054b6:	41 8b 49 10          	mov    0x10(%r9),%ecx
   1400054ba:	85 c9                	test   %ecx,%ecx
   1400054bc:	0f 89 e5 fe ff ff    	jns    1400053a7 <__pformat_emit_float+0x167>
   1400054c2:	f7 d9                	neg    %ecx
   1400054c4:	41 89 49 0c          	mov    %ecx,0xc(%r9)
   1400054c8:	8b 43 08             	mov    0x8(%rbx),%eax
   1400054cb:	f6 c4 08             	test   $0x8,%ah
   1400054ce:	0f 85 ad fd ff ff    	jne    140005281 <__pformat_emit_float+0x41>
   1400054d4:	85 f6                	test   %esi,%esi
   1400054d6:	0f 8e bd fd ff ff    	jle    140005299 <__pformat_emit_float+0x59>
   1400054dc:	f6 c4 10             	test   $0x10,%ah
   1400054df:	0f 84 b4 fd ff ff    	je     140005299 <__pformat_emit_float+0x59>
   1400054e5:	66 83 7b 20 00       	cmpw   $0x0,0x20(%rbx)
   1400054ea:	0f 84 a5 fd ff ff    	je     140005295 <__pformat_emit_float+0x55>
   1400054f0:	e9 dd 00 00 00       	jmp    1400055d2 <__pformat_emit_float+0x392>
   1400054f5:	0f 1f 00             	nopl   (%rax)
   1400054f8:	48 89 da             	mov    %rbx,%rdx
   1400054fb:	b9 2b 00 00 00       	mov    $0x2b,%ecx
   140005500:	e8 7b ef ff ff       	call   140004480 <__pformat_putc>
   140005505:	e9 ed fd ff ff       	jmp    1400052f7 <__pformat_emit_float+0xb7>
   14000550a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140005510:	83 e8 01             	sub    $0x1,%eax
   140005513:	89 43 0c             	mov    %eax,0xc(%rbx)
   140005516:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   14000551d:	00 00 00 
   140005520:	48 89 da             	mov    %rbx,%rdx
   140005523:	b9 30 00 00 00       	mov    $0x30,%ecx
   140005528:	e8 53 ef ff ff       	call   140004480 <__pformat_putc>
   14000552d:	8b 43 0c             	mov    0xc(%rbx),%eax
   140005530:	8d 50 ff             	lea    -0x1(%rax),%edx
   140005533:	85 c0                	test   %eax,%eax
   140005535:	89 53 0c             	mov    %edx,0xc(%rbx)
   140005538:	7f e6                	jg     140005520 <__pformat_emit_float+0x2e0>
   14000553a:	e9 d4 fd ff ff       	jmp    140005313 <__pformat_emit_float+0xd3>
   14000553f:	90                   	nop
   140005540:	66 41 83 79 20 00    	cmpw   $0x0,0x20(%r9)
   140005546:	0f 84 8f fd ff ff    	je     1400052db <__pformat_emit_float+0x9b>
   14000554c:	41 8d 40 02          	lea    0x2(%r8),%eax
   140005550:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
   140005555:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
   14000555a:	48 0f af c2          	imul   %rdx,%rax
   14000555e:	48 c1 e8 21          	shr    $0x21,%rax
   140005562:	83 f8 01             	cmp    $0x1,%eax
   140005565:	0f 84 70 fd ff ff    	je     1400052db <__pformat_emit_float+0x9b>
   14000556b:	83 e8 01             	sub    $0x1,%eax
   14000556e:	29 c8                	sub    %ecx,%eax
   140005570:	eb 16                	jmp    140005588 <__pformat_emit_float+0x348>
   140005572:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140005578:	83 e9 01             	sub    $0x1,%ecx
   14000557b:	89 c2                	mov    %eax,%edx
   14000557d:	01 ca                	add    %ecx,%edx
   14000557f:	89 4b 0c             	mov    %ecx,0xc(%rbx)
   140005582:	0f 84 0d fd ff ff    	je     140005295 <__pformat_emit_float+0x55>
   140005588:	85 c9                	test   %ecx,%ecx
   14000558a:	7f ec                	jg     140005578 <__pformat_emit_float+0x338>
   14000558c:	e9 4a fd ff ff       	jmp    1400052db <__pformat_emit_float+0x9b>
   140005591:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140005598:	83 e9 01             	sub    $0x1,%ecx
   14000559b:	f6 c4 06             	test   $0x6,%ah
   14000559e:	0f 84 e2 fe ff ff    	je     140005486 <__pformat_emit_float+0x246>
   1400055a4:	e9 3d fd ff ff       	jmp    1400052e6 <__pformat_emit_float+0xa6>
   1400055a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   1400055b0:	41 f6 41 09 10       	testb  $0x10,0x9(%r9)
   1400055b5:	41 c7 41 0c ff ff ff 	movl   $0xffffffff,0xc(%r9)
   1400055bc:	ff 
   1400055bd:	0f 84 18 fd ff ff    	je     1400052db <__pformat_emit_float+0x9b>
   1400055c3:	66 41 83 79 20 00    	cmpw   $0x0,0x20(%r9)
   1400055c9:	0f 84 0c fd ff ff    	je     1400052db <__pformat_emit_float+0x9b>
   1400055cf:	83 c9 ff             	or     $0xffffffff,%ecx
   1400055d2:	8d 46 02             	lea    0x2(%rsi),%eax
   1400055d5:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   1400055db:	99                   	cltd
   1400055dc:	41 f7 f8             	idiv   %r8d
   1400055df:	83 f8 01             	cmp    $0x1,%eax
   1400055e2:	75 87                	jne    14000556b <__pformat_emit_float+0x32b>
   1400055e4:	e9 ac fc ff ff       	jmp    140005295 <__pformat_emit_float+0x55>
   1400055e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   1400055f0:	48 89 da             	mov    %rbx,%rdx
   1400055f3:	b9 20 00 00 00       	mov    $0x20,%ecx
   1400055f8:	e8 83 ee ff ff       	call   140004480 <__pformat_putc>
   1400055fd:	e9 f5 fc ff ff       	jmp    1400052f7 <__pformat_emit_float+0xb7>
   140005602:	f6 43 09 08          	testb  $0x8,0x9(%rbx)
   140005606:	0f 85 2c fe ff ff    	jne    140005438 <__pformat_emit_float+0x1f8>
   14000560c:	85 f6                	test   %esi,%esi
   14000560e:	0f 85 33 fe ff ff    	jne    140005447 <__pformat_emit_float+0x207>
   140005614:	e9 68 fd ff ff       	jmp    140005381 <__pformat_emit_float+0x141>
   140005619:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000140005620 <__pformat_emit_efloat>:
   140005620:	57                   	push   %rdi
   140005621:	56                   	push   %rsi
   140005622:	53                   	push   %rbx
   140005623:	48 83 ec 20          	sub    $0x20,%rsp
   140005627:	41 ba 01 00 00 00    	mov    $0x1,%r10d
   14000562d:	41 83 e8 01          	sub    $0x1,%r8d
   140005631:	41 89 cb             	mov    %ecx,%r11d
   140005634:	4c 89 cb             	mov    %r9,%rbx
   140005637:	49 63 f0             	movslq %r8d,%rsi
   14000563a:	41 c1 f8 1f          	sar    $0x1f,%r8d
   14000563e:	48 69 ce 67 66 66 66 	imul   $0x66666667,%rsi,%rcx
   140005645:	48 c1 f9 22          	sar    $0x22,%rcx
   140005649:	44 29 c1             	sub    %r8d,%ecx
   14000564c:	74 1d                	je     14000566b <__pformat_emit_efloat+0x4b>
   14000564e:	66 90                	xchg   %ax,%ax
   140005650:	48 63 c1             	movslq %ecx,%rax
   140005653:	c1 f9 1f             	sar    $0x1f,%ecx
   140005656:	41 83 c2 01          	add    $0x1,%r10d
   14000565a:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   140005661:	48 c1 f8 22          	sar    $0x22,%rax
   140005665:	29 c8                	sub    %ecx,%eax
   140005667:	89 c1                	mov    %eax,%ecx
   140005669:	75 e5                	jne    140005650 <__pformat_emit_efloat+0x30>
   14000566b:	8b 43 2c             	mov    0x2c(%rbx),%eax
   14000566e:	83 f8 ff             	cmp    $0xffffffff,%eax
   140005671:	75 0c                	jne    14000567f <__pformat_emit_efloat+0x5f>
   140005673:	c7 43 2c 02 00 00 00 	movl   $0x2,0x2c(%rbx)
   14000567a:	b8 02 00 00 00       	mov    $0x2,%eax
   14000567f:	44 8b 43 0c          	mov    0xc(%rbx),%r8d
   140005683:	44 39 d0             	cmp    %r10d,%eax
   140005686:	44 89 d7             	mov    %r10d,%edi
   140005689:	49 89 d9             	mov    %rbx,%r9
   14000568c:	0f 4d f8             	cmovge %eax,%edi
   14000568f:	8d 4f 02             	lea    0x2(%rdi),%ecx
   140005692:	44 89 c0             	mov    %r8d,%eax
   140005695:	29 c8                	sub    %ecx,%eax
   140005697:	41 39 c8             	cmp    %ecx,%r8d
   14000569a:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
   14000569f:	0f 4e c1             	cmovle %ecx,%eax
   1400056a2:	41 b8 01 00 00 00    	mov    $0x1,%r8d
   1400056a8:	44 89 d9             	mov    %r11d,%ecx
   1400056ab:	89 43 0c             	mov    %eax,0xc(%rbx)
   1400056ae:	e8 8d fb ff ff       	call   140005240 <__pformat_emit_float>
   1400056b3:	8b 4b 08             	mov    0x8(%rbx),%ecx
   1400056b6:	48 89 da             	mov    %rbx,%rdx
   1400056b9:	8b 43 2c             	mov    0x2c(%rbx),%eax
   1400056bc:	89 43 10             	mov    %eax,0x10(%rbx)
   1400056bf:	89 c8                	mov    %ecx,%eax
   1400056c1:	83 e1 20             	and    $0x20,%ecx
   1400056c4:	0d c0 01 00 00       	or     $0x1c0,%eax
   1400056c9:	83 c9 45             	or     $0x45,%ecx
   1400056cc:	89 43 08             	mov    %eax,0x8(%rbx)
   1400056cf:	e8 ac ed ff ff       	call   140004480 <__pformat_putc>
   1400056d4:	8d 47 01             	lea    0x1(%rdi),%eax
   1400056d7:	48 89 da             	mov    %rbx,%rdx
   1400056da:	48 89 f1             	mov    %rsi,%rcx
   1400056dd:	01 43 0c             	add    %eax,0xc(%rbx)
   1400056e0:	48 83 c4 20          	add    $0x20,%rsp
   1400056e4:	5b                   	pop    %rbx
   1400056e5:	5e                   	pop    %rsi
   1400056e6:	5f                   	pop    %rdi
   1400056e7:	e9 74 f6 ff ff       	jmp    140004d60 <__pformat_int.isra.0>
   1400056ec:	0f 1f 40 00          	nopl   0x0(%rax)

00000001400056f0 <__pformat_efloat>:
   1400056f0:	56                   	push   %rsi
   1400056f1:	53                   	push   %rbx
   1400056f2:	48 83 ec 58          	sub    $0x58,%rsp
   1400056f6:	44 8b 42 10          	mov    0x10(%rdx),%r8d
   1400056fa:	db 29                	fldt   (%rcx)
   1400056fc:	45 85 c0             	test   %r8d,%r8d
   1400056ff:	48 89 d3             	mov    %rdx,%rbx
   140005702:	78 5c                	js     140005760 <__pformat_efloat+0x70>
   140005704:	41 83 c0 01          	add    $0x1,%r8d
   140005708:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
   14000570d:	b9 02 00 00 00       	mov    $0x2,%ecx
   140005712:	48 8d 54 24 30       	lea    0x30(%rsp),%rdx
   140005717:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   14000571c:	db 7c 24 30          	fstpt  0x30(%rsp)
   140005720:	4c 8d 4c 24 4c       	lea    0x4c(%rsp),%r9
   140005725:	e8 66 ec ff ff       	call   140004390 <__pformat_cvt>
   14000572a:	44 8b 44 24 4c       	mov    0x4c(%rsp),%r8d
   14000572f:	48 89 c6             	mov    %rax,%rsi
   140005732:	41 81 f8 00 80 ff ff 	cmp    $0xffff8000,%r8d
   140005739:	74 35                	je     140005770 <__pformat_efloat+0x80>
   14000573b:	8b 4c 24 48          	mov    0x48(%rsp),%ecx
   14000573f:	49 89 d9             	mov    %rbx,%r9
   140005742:	48 89 c2             	mov    %rax,%rdx
   140005745:	e8 d6 fe ff ff       	call   140005620 <__pformat_emit_efloat>
   14000574a:	48 89 f1             	mov    %rsi,%rcx
   14000574d:	e8 fe 12 00 00       	call   140006a50 <__freedtoa>
   140005752:	90                   	nop
   140005753:	48 83 c4 58          	add    $0x58,%rsp
   140005757:	5b                   	pop    %rbx
   140005758:	5e                   	pop    %rsi
   140005759:	c3                   	ret
   14000575a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140005760:	c7 42 10 06 00 00 00 	movl   $0x6,0x10(%rdx)
   140005767:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   14000576d:	eb 99                	jmp    140005708 <__pformat_efloat+0x18>
   14000576f:	90                   	nop
   140005770:	8b 4c 24 48          	mov    0x48(%rsp),%ecx
   140005774:	49 89 d8             	mov    %rbx,%r8
   140005777:	48 89 c2             	mov    %rax,%rdx
   14000577a:	e8 91 f0 ff ff       	call   140004810 <__pformat_emit_inf_or_nan>
   14000577f:	48 89 f1             	mov    %rsi,%rcx
   140005782:	e8 c9 12 00 00       	call   140006a50 <__freedtoa>
   140005787:	90                   	nop
   140005788:	48 83 c4 58          	add    $0x58,%rsp
   14000578c:	5b                   	pop    %rbx
   14000578d:	5e                   	pop    %rsi
   14000578e:	c3                   	ret
   14000578f:	90                   	nop

0000000140005790 <__pformat_float>:
   140005790:	56                   	push   %rsi
   140005791:	53                   	push   %rbx
   140005792:	48 83 ec 58          	sub    $0x58,%rsp
   140005796:	44 8b 42 10          	mov    0x10(%rdx),%r8d
   14000579a:	db 29                	fldt   (%rcx)
   14000579c:	45 85 c0             	test   %r8d,%r8d
   14000579f:	48 89 d3             	mov    %rdx,%rbx
   1400057a2:	79 0d                	jns    1400057b1 <__pformat_float+0x21>
   1400057a4:	c7 42 10 06 00 00 00 	movl   $0x6,0x10(%rdx)
   1400057ab:	41 b8 06 00 00 00    	mov    $0x6,%r8d
   1400057b1:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
   1400057b6:	b9 03 00 00 00       	mov    $0x3,%ecx
   1400057bb:	48 8d 54 24 30       	lea    0x30(%rsp),%rdx
   1400057c0:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   1400057c5:	db 7c 24 30          	fstpt  0x30(%rsp)
   1400057c9:	4c 8d 4c 24 4c       	lea    0x4c(%rsp),%r9
   1400057ce:	e8 bd eb ff ff       	call   140004390 <__pformat_cvt>
   1400057d3:	44 8b 44 24 4c       	mov    0x4c(%rsp),%r8d
   1400057d8:	48 89 c6             	mov    %rax,%rsi
   1400057db:	41 81 f8 00 80 ff ff 	cmp    $0xffff8000,%r8d
   1400057e2:	74 6c                	je     140005850 <__pformat_float+0xc0>
   1400057e4:	8b 4c 24 48          	mov    0x48(%rsp),%ecx
   1400057e8:	48 89 c2             	mov    %rax,%rdx
   1400057eb:	49 89 d9             	mov    %rbx,%r9
   1400057ee:	e8 4d fa ff ff       	call   140005240 <__pformat_emit_float>
   1400057f3:	8b 43 0c             	mov    0xc(%rbx),%eax
   1400057f6:	eb 1c                	jmp    140005814 <__pformat_float+0x84>
   1400057f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   1400057ff:	00 
   140005800:	48 63 43 24          	movslq 0x24(%rbx),%rax
   140005804:	c6 04 02 20          	movb   $0x20,(%rdx,%rax,1)
   140005808:	8b 53 24             	mov    0x24(%rbx),%edx
   14000580b:	8b 43 0c             	mov    0xc(%rbx),%eax
   14000580e:	83 c2 01             	add    $0x1,%edx
   140005811:	89 53 24             	mov    %edx,0x24(%rbx)
   140005814:	89 c2                	mov    %eax,%edx
   140005816:	83 e8 01             	sub    $0x1,%eax
   140005819:	85 d2                	test   %edx,%edx
   14000581b:	89 43 0c             	mov    %eax,0xc(%rbx)
   14000581e:	7e 3f                	jle    14000585f <__pformat_float+0xcf>
   140005820:	8b 4b 08             	mov    0x8(%rbx),%ecx
   140005823:	f6 c5 40             	test   $0x40,%ch
   140005826:	75 08                	jne    140005830 <__pformat_float+0xa0>
   140005828:	8b 53 24             	mov    0x24(%rbx),%edx
   14000582b:	39 53 28             	cmp    %edx,0x28(%rbx)
   14000582e:	7e de                	jle    14000580e <__pformat_float+0x7e>
   140005830:	80 e5 20             	and    $0x20,%ch
   140005833:	48 8b 13             	mov    (%rbx),%rdx
   140005836:	74 c8                	je     140005800 <__pformat_float+0x70>
   140005838:	b9 20 00 00 00       	mov    $0x20,%ecx
   14000583d:	e8 3e 40 00 00       	call   140009880 <fputc>
   140005842:	8b 53 24             	mov    0x24(%rbx),%edx
   140005845:	8b 43 0c             	mov    0xc(%rbx),%eax
   140005848:	eb c4                	jmp    14000580e <__pformat_float+0x7e>
   14000584a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140005850:	8b 4c 24 48          	mov    0x48(%rsp),%ecx
   140005854:	49 89 d8             	mov    %rbx,%r8
   140005857:	48 89 c2             	mov    %rax,%rdx
   14000585a:	e8 b1 ef ff ff       	call   140004810 <__pformat_emit_inf_or_nan>
   14000585f:	48 89 f1             	mov    %rsi,%rcx
   140005862:	e8 e9 11 00 00       	call   140006a50 <__freedtoa>
   140005867:	90                   	nop
   140005868:	48 83 c4 58          	add    $0x58,%rsp
   14000586c:	5b                   	pop    %rbx
   14000586d:	5e                   	pop    %rsi
   14000586e:	c3                   	ret
   14000586f:	90                   	nop

0000000140005870 <__pformat_gfloat>:
   140005870:	57                   	push   %rdi
   140005871:	56                   	push   %rsi
   140005872:	53                   	push   %rbx
   140005873:	48 83 ec 50          	sub    $0x50,%rsp
   140005877:	44 8b 42 10          	mov    0x10(%rdx),%r8d
   14000587b:	db 29                	fldt   (%rcx)
   14000587d:	45 85 c0             	test   %r8d,%r8d
   140005880:	48 89 d3             	mov    %rdx,%rbx
   140005883:	0f 88 ff 00 00 00    	js     140005988 <__pformat_gfloat+0x118>
   140005889:	0f 84 e1 00 00 00    	je     140005970 <__pformat_gfloat+0x100>
   14000588f:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
   140005894:	b9 02 00 00 00       	mov    $0x2,%ecx
   140005899:	48 8d 54 24 30       	lea    0x30(%rsp),%rdx
   14000589e:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   1400058a3:	db 7c 24 30          	fstpt  0x30(%rsp)
   1400058a7:	4c 8d 4c 24 4c       	lea    0x4c(%rsp),%r9
   1400058ac:	e8 df ea ff ff       	call   140004390 <__pformat_cvt>
   1400058b1:	8b 7c 24 4c          	mov    0x4c(%rsp),%edi
   1400058b5:	48 89 c6             	mov    %rax,%rsi
   1400058b8:	81 ff 00 80 ff ff    	cmp    $0xffff8000,%edi
   1400058be:	0f 84 dc 00 00 00    	je     1400059a0 <__pformat_gfloat+0x130>
   1400058c4:	8b 43 08             	mov    0x8(%rbx),%eax
   1400058c7:	25 00 08 00 00       	and    $0x800,%eax
   1400058cc:	83 ff fd             	cmp    $0xfffffffd,%edi
   1400058cf:	7c 5f                	jl     140005930 <__pformat_gfloat+0xc0>
   1400058d1:	8b 53 10             	mov    0x10(%rbx),%edx
   1400058d4:	39 d7                	cmp    %edx,%edi
   1400058d6:	7f 58                	jg     140005930 <__pformat_gfloat+0xc0>
   1400058d8:	85 c0                	test   %eax,%eax
   1400058da:	0f 84 e0 00 00 00    	je     1400059c0 <__pformat_gfloat+0x150>
   1400058e0:	29 fa                	sub    %edi,%edx
   1400058e2:	89 53 10             	mov    %edx,0x10(%rbx)
   1400058e5:	8b 4c 24 48          	mov    0x48(%rsp),%ecx
   1400058e9:	49 89 d9             	mov    %rbx,%r9
   1400058ec:	41 89 f8             	mov    %edi,%r8d
   1400058ef:	48 89 f2             	mov    %rsi,%rdx
   1400058f2:	e8 49 f9 ff ff       	call   140005240 <__pformat_emit_float>
   1400058f7:	eb 14                	jmp    14000590d <__pformat_gfloat+0x9d>
   1400058f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140005900:	48 89 da             	mov    %rbx,%rdx
   140005903:	b9 20 00 00 00       	mov    $0x20,%ecx
   140005908:	e8 73 eb ff ff       	call   140004480 <__pformat_putc>
   14000590d:	8b 43 0c             	mov    0xc(%rbx),%eax
   140005910:	8d 50 ff             	lea    -0x1(%rax),%edx
   140005913:	85 c0                	test   %eax,%eax
   140005915:	89 53 0c             	mov    %edx,0xc(%rbx)
   140005918:	7f e6                	jg     140005900 <__pformat_gfloat+0x90>
   14000591a:	48 89 f1             	mov    %rsi,%rcx
   14000591d:	e8 2e 11 00 00       	call   140006a50 <__freedtoa>
   140005922:	90                   	nop
   140005923:	48 83 c4 50          	add    $0x50,%rsp
   140005927:	5b                   	pop    %rbx
   140005928:	5e                   	pop    %rsi
   140005929:	5f                   	pop    %rdi
   14000592a:	c3                   	ret
   14000592b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140005930:	85 c0                	test   %eax,%eax
   140005932:	75 34                	jne    140005968 <__pformat_gfloat+0xf8>
   140005934:	48 89 f1             	mov    %rsi,%rcx
   140005937:	e8 8c 3f 00 00       	call   1400098c8 <strlen>
   14000593c:	83 e8 01             	sub    $0x1,%eax
   14000593f:	8b 4c 24 48          	mov    0x48(%rsp),%ecx
   140005943:	89 43 10             	mov    %eax,0x10(%rbx)
   140005946:	49 89 d9             	mov    %rbx,%r9
   140005949:	41 89 f8             	mov    %edi,%r8d
   14000594c:	48 89 f2             	mov    %rsi,%rdx
   14000594f:	e8 cc fc ff ff       	call   140005620 <__pformat_emit_efloat>
   140005954:	48 89 f1             	mov    %rsi,%rcx
   140005957:	e8 f4 10 00 00       	call   140006a50 <__freedtoa>
   14000595c:	90                   	nop
   14000595d:	48 83 c4 50          	add    $0x50,%rsp
   140005961:	5b                   	pop    %rbx
   140005962:	5e                   	pop    %rsi
   140005963:	5f                   	pop    %rdi
   140005964:	c3                   	ret
   140005965:	0f 1f 00             	nopl   (%rax)
   140005968:	8b 43 10             	mov    0x10(%rbx),%eax
   14000596b:	83 e8 01             	sub    $0x1,%eax
   14000596e:	eb cf                	jmp    14000593f <__pformat_gfloat+0xcf>
   140005970:	c7 42 10 01 00 00 00 	movl   $0x1,0x10(%rdx)
   140005977:	41 b8 01 00 00 00    	mov    $0x1,%r8d
   14000597d:	e9 0d ff ff ff       	jmp    14000588f <__pformat_gfloat+0x1f>
   140005982:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140005988:	c7 42 10 06 00 00 00 	movl   $0x6,0x10(%rdx)
   14000598f:	41 b8 06 00 00 00    	mov    $0x6,%r8d
   140005995:	e9 f5 fe ff ff       	jmp    14000588f <__pformat_gfloat+0x1f>
   14000599a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   1400059a0:	8b 4c 24 48          	mov    0x48(%rsp),%ecx
   1400059a4:	49 89 d8             	mov    %rbx,%r8
   1400059a7:	48 89 c2             	mov    %rax,%rdx
   1400059aa:	e8 61 ee ff ff       	call   140004810 <__pformat_emit_inf_or_nan>
   1400059af:	48 89 f1             	mov    %rsi,%rcx
   1400059b2:	e8 99 10 00 00       	call   140006a50 <__freedtoa>
   1400059b7:	90                   	nop
   1400059b8:	48 83 c4 50          	add    $0x50,%rsp
   1400059bc:	5b                   	pop    %rbx
   1400059bd:	5e                   	pop    %rsi
   1400059be:	5f                   	pop    %rdi
   1400059bf:	c3                   	ret
   1400059c0:	48 89 f1             	mov    %rsi,%rcx
   1400059c3:	e8 00 3f 00 00       	call   1400098c8 <strlen>
   1400059c8:	29 f8                	sub    %edi,%eax
   1400059ca:	89 43 10             	mov    %eax,0x10(%rbx)
   1400059cd:	0f 89 12 ff ff ff    	jns    1400058e5 <__pformat_gfloat+0x75>
   1400059d3:	8b 53 0c             	mov    0xc(%rbx),%edx
   1400059d6:	85 d2                	test   %edx,%edx
   1400059d8:	0f 8e 07 ff ff ff    	jle    1400058e5 <__pformat_gfloat+0x75>
   1400059de:	01 d0                	add    %edx,%eax
   1400059e0:	89 43 0c             	mov    %eax,0xc(%rbx)
   1400059e3:	e9 fd fe ff ff       	jmp    1400058e5 <__pformat_gfloat+0x75>
   1400059e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   1400059ef:	00 

00000001400059f0 <__pformat_emit_xfloat.isra.0>:
   1400059f0:	41 55                	push   %r13
   1400059f2:	41 54                	push   %r12
   1400059f4:	55                   	push   %rbp
   1400059f5:	57                   	push   %rdi
   1400059f6:	56                   	push   %rsi
   1400059f7:	53                   	push   %rbx
   1400059f8:	48 83 ec 58          	sub    $0x58,%rsp
   1400059fc:	45 8b 50 10          	mov    0x10(%r8),%r10d
   140005a00:	66 85 d2             	test   %dx,%dx
   140005a03:	49 89 c9             	mov    %rcx,%r9
   140005a06:	4c 89 c3             	mov    %r8,%rbx
   140005a09:	75 09                	jne    140005a14 <__pformat_emit_xfloat.isra.0+0x24>
   140005a0b:	48 85 c9             	test   %rcx,%rcx
   140005a0e:	0f 84 a4 00 00 00    	je     140005ab8 <__pformat_emit_xfloat.isra.0+0xc8>
   140005a14:	44 8d 42 fd          	lea    -0x3(%rdx),%r8d
   140005a18:	41 83 fa 0e          	cmp    $0xe,%r10d
   140005a1c:	0f 86 a3 00 00 00    	jbe    140005ac5 <__pformat_emit_xfloat.isra.0+0xd5>
   140005a22:	4d 85 c9             	test   %r9,%r9
   140005a25:	49 0f bf e8          	movswq %r8w,%rbp
   140005a29:	ba 10 00 00 00       	mov    $0x10,%edx
   140005a2e:	0f 84 fc 03 00 00    	je     140005e30 <__pformat_emit_xfloat.isra.0+0x440>
   140005a34:	8b 4b 08             	mov    0x8(%rbx),%ecx
   140005a37:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
   140005a3c:	48 89 fe             	mov    %rdi,%rsi
   140005a3f:	41 89 cb             	mov    %ecx,%r11d
   140005a42:	41 89 cc             	mov    %ecx,%r12d
   140005a45:	41 83 e3 20          	and    $0x20,%r11d
   140005a49:	41 81 e4 00 08 00 00 	and    $0x800,%r12d
   140005a50:	eb 2d                	jmp    140005a7f <__pformat_emit_xfloat.isra.0+0x8f>
   140005a52:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140005a58:	4c 39 d7             	cmp    %r10,%rdi
   140005a5b:	72 0b                	jb     140005a68 <__pformat_emit_xfloat.isra.0+0x78>
   140005a5d:	8b 73 10             	mov    0x10(%rbx),%esi
   140005a60:	85 f6                	test   %esi,%esi
   140005a62:	0f 88 80 03 00 00    	js     140005de8 <__pformat_emit_xfloat.isra.0+0x3f8>
   140005a68:	83 c0 30             	add    $0x30,%eax
   140005a6b:	49 8d 72 01          	lea    0x1(%r10),%rsi
   140005a6f:	41 88 02             	mov    %al,(%r10)
   140005a72:	49 c1 e9 04          	shr    $0x4,%r9
   140005a76:	83 ea 01             	sub    $0x1,%edx
   140005a79:	0f 84 e1 01 00 00    	je     140005c60 <__pformat_emit_xfloat.isra.0+0x270>
   140005a7f:	44 89 c8             	mov    %r9d,%eax
   140005a82:	83 e0 0f             	and    $0xf,%eax
   140005a85:	83 fa 01             	cmp    $0x1,%edx
   140005a88:	0f 84 92 01 00 00    	je     140005c20 <__pformat_emit_xfloat.isra.0+0x230>
   140005a8e:	44 8b 53 10          	mov    0x10(%rbx),%r10d
   140005a92:	45 85 d2             	test   %r10d,%r10d
   140005a95:	7e 08                	jle    140005a9f <__pformat_emit_xfloat.isra.0+0xaf>
   140005a97:	41 83 ea 01          	sub    $0x1,%r10d
   140005a9b:	44 89 53 10          	mov    %r10d,0x10(%rbx)
   140005a9f:	49 89 f2             	mov    %rsi,%r10
   140005aa2:	85 c0                	test   %eax,%eax
   140005aa4:	74 b2                	je     140005a58 <__pformat_emit_xfloat.isra.0+0x68>
   140005aa6:	83 f8 09             	cmp    $0x9,%eax
   140005aa9:	76 bd                	jbe    140005a68 <__pformat_emit_xfloat.isra.0+0x78>
   140005aab:	83 c0 37             	add    $0x37,%eax
   140005aae:	44 09 d8             	or     %r11d,%eax
   140005ab1:	eb b8                	jmp    140005a6b <__pformat_emit_xfloat.isra.0+0x7b>
   140005ab3:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140005ab8:	41 83 fa 0e          	cmp    $0xe,%r10d
   140005abc:	0f 87 56 03 00 00    	ja     140005e18 <__pformat_emit_xfloat.isra.0+0x428>
   140005ac2:	45 31 c0             	xor    %r8d,%r8d
   140005ac5:	b9 0e 00 00 00       	mov    $0xe,%ecx
   140005aca:	b8 04 00 00 00       	mov    $0x4,%eax
   140005acf:	49 d1 e9             	shr    %r9
   140005ad2:	44 29 d1             	sub    %r10d,%ecx
   140005ad5:	c1 e1 02             	shl    $0x2,%ecx
   140005ad8:	48 d3 e0             	shl    %cl,%rax
   140005adb:	b9 0f 00 00 00       	mov    $0xf,%ecx
   140005ae0:	44 29 d1             	sub    %r10d,%ecx
   140005ae3:	c1 e1 02             	shl    $0x2,%ecx
   140005ae6:	4c 01 c8             	add    %r9,%rax
   140005ae9:	0f 88 11 01 00 00    	js     140005c00 <__pformat_emit_xfloat.isra.0+0x210>
   140005aef:	48 01 c0             	add    %rax,%rax
   140005af2:	48 d3 e8             	shr    %cl,%rax
   140005af5:	48 85 c0             	test   %rax,%rax
   140005af8:	49 89 c1             	mov    %rax,%r9
   140005afb:	0f 85 0d 01 00 00    	jne    140005c0e <__pformat_emit_xfloat.isra.0+0x21e>
   140005b01:	45 85 d2             	test   %r10d,%r10d
   140005b04:	0f 85 04 01 00 00    	jne    140005c0e <__pformat_emit_xfloat.isra.0+0x21e>
   140005b0a:	8b 4b 08             	mov    0x8(%rbx),%ecx
   140005b0d:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
   140005b12:	49 0f bf e8          	movswq %r8w,%rbp
   140005b16:	f6 c5 08             	test   $0x8,%ch
   140005b19:	48 89 f8             	mov    %rdi,%rax
   140005b1c:	74 0a                	je     140005b28 <__pformat_emit_xfloat.isra.0+0x138>
   140005b1e:	c6 44 24 30 2e       	movb   $0x2e,0x30(%rsp)
   140005b23:	48 8d 44 24 31       	lea    0x31(%rsp),%rax
   140005b28:	44 8b 53 0c          	mov    0xc(%rbx),%r10d
   140005b2c:	48 8d 70 01          	lea    0x1(%rax),%rsi
   140005b30:	c6 00 30             	movb   $0x30,(%rax)
   140005b33:	41 bc 02 00 00 00    	mov    $0x2,%r12d
   140005b39:	45 85 d2             	test   %r10d,%r10d
   140005b3c:	0f 8f 3a 01 00 00    	jg     140005c7c <__pformat_emit_xfloat.isra.0+0x28c>
   140005b42:	f6 c1 80             	test   $0x80,%cl
   140005b45:	0f 85 f5 01 00 00    	jne    140005d40 <__pformat_emit_xfloat.isra.0+0x350>
   140005b4b:	f6 c5 01             	test   $0x1,%ch
   140005b4e:	0f 85 ac 02 00 00    	jne    140005e00 <__pformat_emit_xfloat.isra.0+0x410>
   140005b54:	83 e1 40             	and    $0x40,%ecx
   140005b57:	0f 85 f3 02 00 00    	jne    140005e50 <__pformat_emit_xfloat.isra.0+0x460>
   140005b5d:	48 89 da             	mov    %rbx,%rdx
   140005b60:	b9 30 00 00 00       	mov    $0x30,%ecx
   140005b65:	e8 16 e9 ff ff       	call   140004480 <__pformat_putc>
   140005b6a:	8b 4b 08             	mov    0x8(%rbx),%ecx
   140005b6d:	48 89 da             	mov    %rbx,%rdx
   140005b70:	83 e1 20             	and    $0x20,%ecx
   140005b73:	83 c9 58             	or     $0x58,%ecx
   140005b76:	e8 05 e9 ff ff       	call   140004480 <__pformat_putc>
   140005b7b:	8b 43 0c             	mov    0xc(%rbx),%eax
   140005b7e:	85 c0                	test   %eax,%eax
   140005b80:	7e 28                	jle    140005baa <__pformat_emit_xfloat.isra.0+0x1ba>
   140005b82:	f6 43 09 02          	testb  $0x2,0x9(%rbx)
   140005b86:	74 22                	je     140005baa <__pformat_emit_xfloat.isra.0+0x1ba>
   140005b88:	83 e8 01             	sub    $0x1,%eax
   140005b8b:	89 43 0c             	mov    %eax,0xc(%rbx)
   140005b8e:	66 90                	xchg   %ax,%ax
   140005b90:	48 89 da             	mov    %rbx,%rdx
   140005b93:	b9 30 00 00 00       	mov    $0x30,%ecx
   140005b98:	e8 e3 e8 ff ff       	call   140004480 <__pformat_putc>
   140005b9d:	8b 43 0c             	mov    0xc(%rbx),%eax
   140005ba0:	8d 50 ff             	lea    -0x1(%rax),%edx
   140005ba3:	85 c0                	test   %eax,%eax
   140005ba5:	89 53 0c             	mov    %edx,0xc(%rbx)
   140005ba8:	7f e6                	jg     140005b90 <__pformat_emit_xfloat.isra.0+0x1a0>
   140005baa:	4c 8d 6c 24 2e       	lea    0x2e(%rsp),%r13
   140005baf:	48 39 f7             	cmp    %rsi,%rdi
   140005bb2:	72 27                	jb     140005bdb <__pformat_emit_xfloat.isra.0+0x1eb>
   140005bb4:	e9 ac 01 00 00       	jmp    140005d65 <__pformat_emit_xfloat.isra.0+0x375>
   140005bb9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140005bc0:	0f b7 43 20          	movzwl 0x20(%rbx),%eax
   140005bc4:	66 85 c0             	test   %ax,%ax
   140005bc7:	66 89 44 24 2e       	mov    %ax,0x2e(%rsp)
   140005bcc:	0f 85 fe 01 00 00    	jne    140005dd0 <__pformat_emit_xfloat.isra.0+0x3e0>
   140005bd2:	48 39 fe             	cmp    %rdi,%rsi
   140005bd5:	0f 84 8a 01 00 00    	je     140005d65 <__pformat_emit_xfloat.isra.0+0x375>
   140005bdb:	0f be 4e ff          	movsbl -0x1(%rsi),%ecx
   140005bdf:	48 83 ee 01          	sub    $0x1,%rsi
   140005be3:	83 f9 2e             	cmp    $0x2e,%ecx
   140005be6:	0f 84 d4 01 00 00    	je     140005dc0 <__pformat_emit_xfloat.isra.0+0x3d0>
   140005bec:	83 f9 2c             	cmp    $0x2c,%ecx
   140005bef:	74 cf                	je     140005bc0 <__pformat_emit_xfloat.isra.0+0x1d0>
   140005bf1:	48 89 da             	mov    %rbx,%rdx
   140005bf4:	e8 87 e8 ff ff       	call   140004480 <__pformat_putc>
   140005bf9:	eb d7                	jmp    140005bd2 <__pformat_emit_xfloat.isra.0+0x1e2>
   140005bfb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140005c00:	48 c1 e8 03          	shr    $0x3,%rax
   140005c04:	41 83 c0 04          	add    $0x4,%r8d
   140005c08:	48 d3 e8             	shr    %cl,%rax
   140005c0b:	49 89 c1             	mov    %rax,%r9
   140005c0e:	41 8d 52 01          	lea    0x1(%r10),%edx
   140005c12:	49 0f bf e8          	movswq %r8w,%rbp
   140005c16:	e9 19 fe ff ff       	jmp    140005a34 <__pformat_emit_xfloat.isra.0+0x44>
   140005c1b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140005c20:	48 39 f7             	cmp    %rsi,%rdi
   140005c23:	72 13                	jb     140005c38 <__pformat_emit_xfloat.isra.0+0x248>
   140005c25:	45 85 e4             	test   %r12d,%r12d
   140005c28:	75 0e                	jne    140005c38 <__pformat_emit_xfloat.isra.0+0x248>
   140005c2a:	44 8b 53 10          	mov    0x10(%rbx),%r10d
   140005c2e:	45 85 d2             	test   %r10d,%r10d
   140005c31:	7e 15                	jle    140005c48 <__pformat_emit_xfloat.isra.0+0x258>
   140005c33:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140005c38:	4c 8d 56 01          	lea    0x1(%rsi),%r10
   140005c3c:	c6 06 2e             	movb   $0x2e,(%rsi)
   140005c3f:	e9 5e fe ff ff       	jmp    140005aa2 <__pformat_emit_xfloat.isra.0+0xb2>
   140005c44:	0f 1f 40 00          	nopl   0x0(%rax)
   140005c48:	85 c0                	test   %eax,%eax
   140005c4a:	0f 85 30 02 00 00    	jne    140005e80 <__pformat_emit_xfloat.isra.0+0x490>
   140005c50:	45 85 d2             	test   %r10d,%r10d
   140005c53:	75 0b                	jne    140005c60 <__pformat_emit_xfloat.isra.0+0x270>
   140005c55:	c6 06 30             	movb   $0x30,(%rsi)
   140005c58:	48 83 c6 01          	add    $0x1,%rsi
   140005c5c:	0f 1f 40 00          	nopl   0x0(%rax)
   140005c60:	48 39 fe             	cmp    %rdi,%rsi
   140005c63:	0f 84 ff 01 00 00    	je     140005e68 <__pformat_emit_xfloat.isra.0+0x478>
   140005c69:	44 8b 53 0c          	mov    0xc(%rbx),%r10d
   140005c6d:	41 bc 02 00 00 00    	mov    $0x2,%r12d
   140005c73:	45 85 d2             	test   %r10d,%r10d
   140005c76:	0f 8e c6 fe ff ff    	jle    140005b42 <__pformat_emit_xfloat.isra.0+0x152>
   140005c7c:	8b 53 10             	mov    0x10(%rbx),%edx
   140005c7f:	49 89 f1             	mov    %rsi,%r9
   140005c82:	41 0f bf c0          	movswl %r8w,%eax
   140005c86:	49 29 f9             	sub    %rdi,%r9
   140005c89:	46 8d 1c 0a          	lea    (%rdx,%r9,1),%r11d
   140005c8d:	85 d2                	test   %edx,%edx
   140005c8f:	89 ca                	mov    %ecx,%edx
   140005c91:	45 0f 4f cb          	cmovg  %r11d,%r9d
   140005c95:	81 e2 c0 01 00 00    	and    $0x1c0,%edx
   140005c9b:	83 fa 01             	cmp    $0x1,%edx
   140005c9e:	49 0f bf d0          	movswq %r8w,%rdx
   140005ca2:	41 83 d9 fa          	sbb    $0xfffffffa,%r9d
   140005ca6:	c1 f8 1f             	sar    $0x1f,%eax
   140005ca9:	48 69 d2 67 66 66 66 	imul   $0x66666667,%rdx,%rdx
   140005cb0:	45 89 cb             	mov    %r9d,%r11d
   140005cb3:	48 c1 fa 22          	sar    $0x22,%rdx
   140005cb7:	29 c2                	sub    %eax,%edx
   140005cb9:	74 2e                	je     140005ce9 <__pformat_emit_xfloat.isra.0+0x2f9>
   140005cbb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140005cc0:	48 63 c2             	movslq %edx,%rax
   140005cc3:	c1 fa 1f             	sar    $0x1f,%edx
   140005cc6:	41 83 c3 01          	add    $0x1,%r11d
   140005cca:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   140005cd1:	48 c1 f8 22          	sar    $0x22,%rax
   140005cd5:	29 d0                	sub    %edx,%eax
   140005cd7:	89 c2                	mov    %eax,%edx
   140005cd9:	75 e5                	jne    140005cc0 <__pformat_emit_xfloat.isra.0+0x2d0>
   140005cdb:	45 89 dc             	mov    %r11d,%r12d
   140005cde:	45 29 cc             	sub    %r9d,%r12d
   140005ce1:	41 83 c4 02          	add    $0x2,%r12d
   140005ce5:	45 0f bf e4          	movswl %r12w,%r12d
   140005ce9:	45 39 da             	cmp    %r11d,%r10d
   140005cec:	0f 8e fe 00 00 00    	jle    140005df0 <__pformat_emit_xfloat.isra.0+0x400>
   140005cf2:	45 29 da             	sub    %r11d,%r10d
   140005cf5:	f6 c5 06             	test   $0x6,%ch
   140005cf8:	0f 85 f8 00 00 00    	jne    140005df6 <__pformat_emit_xfloat.isra.0+0x406>
   140005cfe:	41 83 ea 01          	sub    $0x1,%r10d
   140005d02:	44 89 53 0c          	mov    %r10d,0xc(%rbx)
   140005d06:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   140005d0d:	00 00 00 
   140005d10:	48 89 da             	mov    %rbx,%rdx
   140005d13:	b9 20 00 00 00       	mov    $0x20,%ecx
   140005d18:	e8 63 e7 ff ff       	call   140004480 <__pformat_putc>
   140005d1d:	8b 43 0c             	mov    0xc(%rbx),%eax
   140005d20:	8d 50 ff             	lea    -0x1(%rax),%edx
   140005d23:	85 c0                	test   %eax,%eax
   140005d25:	89 53 0c             	mov    %edx,0xc(%rbx)
   140005d28:	7f e6                	jg     140005d10 <__pformat_emit_xfloat.isra.0+0x320>
   140005d2a:	8b 4b 08             	mov    0x8(%rbx),%ecx
   140005d2d:	f6 c1 80             	test   $0x80,%cl
   140005d30:	0f 84 15 fe ff ff    	je     140005b4b <__pformat_emit_xfloat.isra.0+0x15b>
   140005d36:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   140005d3d:	00 00 00 
   140005d40:	48 89 da             	mov    %rbx,%rdx
   140005d43:	b9 2d 00 00 00       	mov    $0x2d,%ecx
   140005d48:	e8 33 e7 ff ff       	call   140004480 <__pformat_putc>
   140005d4d:	e9 0b fe ff ff       	jmp    140005b5d <__pformat_emit_xfloat.isra.0+0x16d>
   140005d52:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140005d58:	48 89 da             	mov    %rbx,%rdx
   140005d5b:	b9 30 00 00 00       	mov    $0x30,%ecx
   140005d60:	e8 1b e7 ff ff       	call   140004480 <__pformat_putc>
   140005d65:	8b 43 10             	mov    0x10(%rbx),%eax
   140005d68:	8d 50 ff             	lea    -0x1(%rax),%edx
   140005d6b:	85 c0                	test   %eax,%eax
   140005d6d:	89 53 10             	mov    %edx,0x10(%rbx)
   140005d70:	7f e6                	jg     140005d58 <__pformat_emit_xfloat.isra.0+0x368>
   140005d72:	8b 4b 08             	mov    0x8(%rbx),%ecx
   140005d75:	48 89 da             	mov    %rbx,%rdx
   140005d78:	83 e1 20             	and    $0x20,%ecx
   140005d7b:	83 c9 50             	or     $0x50,%ecx
   140005d7e:	e8 fd e6 ff ff       	call   140004480 <__pformat_putc>
   140005d83:	8b 43 08             	mov    0x8(%rbx),%eax
   140005d86:	48 89 da             	mov    %rbx,%rdx
   140005d89:	48 89 e9             	mov    %rbp,%rcx
   140005d8c:	44 03 63 0c          	add    0xc(%rbx),%r12d
   140005d90:	0d c0 01 00 00       	or     $0x1c0,%eax
   140005d95:	66 0f 6e c0          	movd   %eax,%xmm0
   140005d99:	66 41 0f 6e cc       	movd   %r12d,%xmm1
   140005d9e:	66 0f 62 c1          	punpckldq %xmm1,%xmm0
   140005da2:	66 0f d6 43 08       	movq   %xmm0,0x8(%rbx)
   140005da7:	48 83 c4 58          	add    $0x58,%rsp
   140005dab:	5b                   	pop    %rbx
   140005dac:	5e                   	pop    %rsi
   140005dad:	5f                   	pop    %rdi
   140005dae:	5d                   	pop    %rbp
   140005daf:	41 5c                	pop    %r12
   140005db1:	41 5d                	pop    %r13
   140005db3:	e9 a8 ef ff ff       	jmp    140004d60 <__pformat_int.isra.0>
   140005db8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   140005dbf:	00 
   140005dc0:	48 89 d9             	mov    %rbx,%rcx
   140005dc3:	e8 28 f3 ff ff       	call   1400050f0 <__pformat_emit_radix_point>
   140005dc8:	e9 05 fe ff ff       	jmp    140005bd2 <__pformat_emit_xfloat.isra.0+0x1e2>
   140005dcd:	0f 1f 00             	nopl   (%rax)
   140005dd0:	49 89 d8             	mov    %rbx,%r8
   140005dd3:	ba 01 00 00 00       	mov    $0x1,%edx
   140005dd8:	4c 89 e9             	mov    %r13,%rcx
   140005ddb:	e8 00 e7 ff ff       	call   1400044e0 <__pformat_wputchars>
   140005de0:	e9 ed fd ff ff       	jmp    140005bd2 <__pformat_emit_xfloat.isra.0+0x1e2>
   140005de5:	0f 1f 00             	nopl   (%rax)
   140005de8:	4c 89 d6             	mov    %r10,%rsi
   140005deb:	e9 82 fc ff ff       	jmp    140005a72 <__pformat_emit_xfloat.isra.0+0x82>
   140005df0:	41 ba ff ff ff ff    	mov    $0xffffffff,%r10d
   140005df6:	44 89 53 0c          	mov    %r10d,0xc(%rbx)
   140005dfa:	e9 43 fd ff ff       	jmp    140005b42 <__pformat_emit_xfloat.isra.0+0x152>
   140005dff:	90                   	nop
   140005e00:	48 89 da             	mov    %rbx,%rdx
   140005e03:	b9 2b 00 00 00       	mov    $0x2b,%ecx
   140005e08:	e8 73 e6 ff ff       	call   140004480 <__pformat_putc>
   140005e0d:	e9 4b fd ff ff       	jmp    140005b5d <__pformat_emit_xfloat.isra.0+0x16d>
   140005e12:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140005e18:	45 85 d2             	test   %r10d,%r10d
   140005e1b:	7e 6b                	jle    140005e88 <__pformat_emit_xfloat.isra.0+0x498>
   140005e1d:	31 ed                	xor    %ebp,%ebp
   140005e1f:	45 31 c0             	xor    %r8d,%r8d
   140005e22:	ba 10 00 00 00       	mov    $0x10,%edx
   140005e27:	45 31 c9             	xor    %r9d,%r9d
   140005e2a:	e9 05 fc ff ff       	jmp    140005a34 <__pformat_emit_xfloat.isra.0+0x44>
   140005e2f:	90                   	nop
   140005e30:	45 85 d2             	test   %r10d,%r10d
   140005e33:	0f 8f fb fb ff ff    	jg     140005a34 <__pformat_emit_xfloat.isra.0+0x44>
   140005e39:	8b 4b 08             	mov    0x8(%rbx),%ecx
   140005e3c:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
   140005e41:	e9 d0 fc ff ff       	jmp    140005b16 <__pformat_emit_xfloat.isra.0+0x126>
   140005e46:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   140005e4d:	00 00 00 
   140005e50:	48 89 da             	mov    %rbx,%rdx
   140005e53:	b9 20 00 00 00       	mov    $0x20,%ecx
   140005e58:	e8 23 e6 ff ff       	call   140004480 <__pformat_putc>
   140005e5d:	e9 fb fc ff ff       	jmp    140005b5d <__pformat_emit_xfloat.isra.0+0x16d>
   140005e62:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140005e68:	8b 43 10             	mov    0x10(%rbx),%eax
   140005e6b:	85 c0                	test   %eax,%eax
   140005e6d:	0f 8f ab fc ff ff    	jg     140005b1e <__pformat_emit_xfloat.isra.0+0x12e>
   140005e73:	e9 9e fc ff ff       	jmp    140005b16 <__pformat_emit_xfloat.isra.0+0x126>
   140005e78:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   140005e7f:	00 
   140005e80:	49 89 f2             	mov    %rsi,%r10
   140005e83:	e9 1e fc ff ff       	jmp    140005aa6 <__pformat_emit_xfloat.isra.0+0xb6>
   140005e88:	41 8b 48 08          	mov    0x8(%r8),%ecx
   140005e8c:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
   140005e91:	31 ed                	xor    %ebp,%ebp
   140005e93:	45 31 c0             	xor    %r8d,%r8d
   140005e96:	e9 7b fc ff ff       	jmp    140005b16 <__pformat_emit_xfloat.isra.0+0x126>
   140005e9b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000140005ea0 <__mingw_pformat>:
   140005ea0:	41 57                	push   %r15
   140005ea2:	41 56                	push   %r14
   140005ea4:	41 55                	push   %r13
   140005ea6:	41 54                	push   %r12
   140005ea8:	55                   	push   %rbp
   140005ea9:	57                   	push   %rdi
   140005eaa:	56                   	push   %rsi
   140005eab:	53                   	push   %rbx
   140005eac:	48 81 ec a8 00 00 00 	sub    $0xa8,%rsp
   140005eb3:	4c 8b ac 24 10 01 00 	mov    0x110(%rsp),%r13
   140005eba:	00 
   140005ebb:	89 cf                	mov    %ecx,%edi
   140005ebd:	48 89 d5             	mov    %rdx,%rbp
   140005ec0:	44 89 c3             	mov    %r8d,%ebx
   140005ec3:	4c 89 ce             	mov    %r9,%rsi
   140005ec6:	81 e7 00 60 00 00    	and    $0x6000,%edi
   140005ecc:	e8 6f 39 00 00       	call   140009840 <_errno>
   140005ed1:	0f be 0e             	movsbl (%rsi),%ecx
   140005ed4:	31 d2                	xor    %edx,%edx
   140005ed6:	48 89 6c 24 70       	mov    %rbp,0x70(%rsp)
   140005edb:	8b 00                	mov    (%rax),%eax
   140005edd:	89 9c 24 98 00 00 00 	mov    %ebx,0x98(%rsp)
   140005ee4:	48 8d 5e 01          	lea    0x1(%rsi),%rbx
   140005ee8:	89 7c 24 78          	mov    %edi,0x78(%rsp)
   140005eec:	c7 44 24 7c ff ff ff 	movl   $0xffffffff,0x7c(%rsp)
   140005ef3:	ff 
   140005ef4:	c7 84 24 8c 00 00 00 	movl   $0x0,0x8c(%rsp)
   140005efb:	00 00 00 00 
   140005eff:	89 44 24 30          	mov    %eax,0x30(%rsp)
   140005f03:	48 b8 ff ff ff ff fd 	movabs $0xfffffffdffffffff,%rax
   140005f0a:	ff ff ff 
   140005f0d:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
   140005f14:	00 
   140005f15:	31 c0                	xor    %eax,%eax
   140005f17:	85 c9                	test   %ecx,%ecx
   140005f19:	66 89 84 24 88 00 00 	mov    %ax,0x88(%rsp)
   140005f20:	00 
   140005f21:	89 c8                	mov    %ecx,%eax
   140005f23:	66 89 94 24 90 00 00 	mov    %dx,0x90(%rsp)
   140005f2a:	00 
   140005f2b:	c7 84 24 94 00 00 00 	movl   $0x0,0x94(%rsp)
   140005f32:	00 00 00 00 
   140005f36:	c7 84 24 9c 00 00 00 	movl   $0xffffffff,0x9c(%rsp)
   140005f3d:	ff ff ff ff 
   140005f41:	0f 84 10 01 00 00    	je     140006057 <__mingw_pformat+0x1b7>
   140005f47:	4c 8d 7c 24 7c       	lea    0x7c(%rsp),%r15
   140005f4c:	4c 8d 25 3d 55 00 00 	lea    0x553d(%rip),%r12        # 14000b490 <.rdata+0x20>
   140005f53:	eb 49                	jmp    140005f9e <__mingw_pformat+0xfe>
   140005f55:	0f 1f 00             	nopl   (%rax)
   140005f58:	8b 54 24 78          	mov    0x78(%rsp),%edx
   140005f5c:	8b b4 24 94 00 00 00 	mov    0x94(%rsp),%esi
   140005f63:	f6 c6 40             	test   $0x40,%dh
   140005f66:	75 09                	jne    140005f71 <__mingw_pformat+0xd1>
   140005f68:	39 b4 24 98 00 00 00 	cmp    %esi,0x98(%rsp)
   140005f6f:	7e 11                	jle    140005f82 <__mingw_pformat+0xe2>
   140005f71:	80 e6 20             	and    $0x20,%dh
   140005f74:	4c 8b 44 24 70       	mov    0x70(%rsp),%r8
   140005f79:	75 6d                	jne    140005fe8 <__mingw_pformat+0x148>
   140005f7b:	48 63 d6             	movslq %esi,%rdx
   140005f7e:	41 88 04 10          	mov    %al,(%r8,%rdx,1)
   140005f82:	83 c6 01             	add    $0x1,%esi
   140005f85:	89 b4 24 94 00 00 00 	mov    %esi,0x94(%rsp)
   140005f8c:	0f b6 03             	movzbl (%rbx),%eax
   140005f8f:	48 83 c3 01          	add    $0x1,%rbx
   140005f93:	0f be c8             	movsbl %al,%ecx
   140005f96:	85 c9                	test   %ecx,%ecx
   140005f98:	0f 84 b2 00 00 00    	je     140006050 <__mingw_pformat+0x1b0>
   140005f9e:	83 f9 25             	cmp    $0x25,%ecx
   140005fa1:	75 b5                	jne    140005f58 <__mingw_pformat+0xb8>
   140005fa3:	0f b6 03             	movzbl (%rbx),%eax
   140005fa6:	89 7c 24 78          	mov    %edi,0x78(%rsp)
   140005faa:	48 c7 44 24 7c ff ff 	movq   $0xffffffffffffffff,0x7c(%rsp)
   140005fb1:	ff ff 
   140005fb3:	84 c0                	test   %al,%al
   140005fb5:	0f 84 95 00 00 00    	je     140006050 <__mingw_pformat+0x1b0>
   140005fbb:	48 89 de             	mov    %rbx,%rsi
   140005fbe:	4d 89 fb             	mov    %r15,%r11
   140005fc1:	45 31 d2             	xor    %r10d,%r10d
   140005fc4:	45 31 f6             	xor    %r14d,%r14d
   140005fc7:	8d 50 e0             	lea    -0x20(%rax),%edx
   140005fca:	0f be c8             	movsbl %al,%ecx
   140005fcd:	48 8d 6e 01          	lea    0x1(%rsi),%rbp
   140005fd1:	80 fa 5a             	cmp    $0x5a,%dl
   140005fd4:	77 22                	ja     140005ff8 <__mingw_pformat+0x158>
   140005fd6:	0f b6 d2             	movzbl %dl,%edx
   140005fd9:	49 63 14 94          	movslq (%r12,%rdx,4),%rdx
   140005fdd:	4c 01 e2             	add    %r12,%rdx
   140005fe0:	ff e2                	jmp    *%rdx
   140005fe2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140005fe8:	4c 89 c2             	mov    %r8,%rdx
   140005feb:	e8 90 38 00 00       	call   140009880 <fputc>
   140005ff0:	eb 90                	jmp    140005f82 <__mingw_pformat+0xe2>
   140005ff2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140005ff8:	83 e8 30             	sub    $0x30,%eax
   140005ffb:	3c 09                	cmp    $0x9,%al
   140005ffd:	0f 87 14 02 00 00    	ja     140006217 <__mingw_pformat+0x377>
   140006003:	41 83 fe 03          	cmp    $0x3,%r14d
   140006007:	0f 87 0a 02 00 00    	ja     140006217 <__mingw_pformat+0x377>
   14000600d:	45 85 f6             	test   %r14d,%r14d
   140006010:	0f 85 53 07 00 00    	jne    140006769 <__mingw_pformat+0x8c9>
   140006016:	41 be 01 00 00 00    	mov    $0x1,%r14d
   14000601c:	4d 85 db             	test   %r11,%r11
   14000601f:	74 1f                	je     140006040 <__mingw_pformat+0x1a0>
   140006021:	41 8b 03             	mov    (%r11),%eax
   140006024:	85 c0                	test   %eax,%eax
   140006026:	0f 88 f6 07 00 00    	js     140006822 <__mingw_pformat+0x982>
   14000602c:	8d 04 80             	lea    (%rax,%rax,4),%eax
   14000602f:	8d 44 41 d0          	lea    -0x30(%rcx,%rax,2),%eax
   140006033:	41 89 03             	mov    %eax,(%r11)
   140006036:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   14000603d:	00 00 00 
   140006040:	0f b6 46 01          	movzbl 0x1(%rsi),%eax
   140006044:	48 89 ee             	mov    %rbp,%rsi
   140006047:	84 c0                	test   %al,%al
   140006049:	0f 85 78 ff ff ff    	jne    140005fc7 <__mingw_pformat+0x127>
   14000604f:	90                   	nop
   140006050:	8b 8c 24 94 00 00 00 	mov    0x94(%rsp),%ecx
   140006057:	89 c8                	mov    %ecx,%eax
   140006059:	48 81 c4 a8 00 00 00 	add    $0xa8,%rsp
   140006060:	5b                   	pop    %rbx
   140006061:	5e                   	pop    %rsi
   140006062:	5f                   	pop    %rdi
   140006063:	5d                   	pop    %rbp
   140006064:	41 5c                	pop    %r12
   140006066:	41 5d                	pop    %r13
   140006068:	41 5e                	pop    %r14
   14000606a:	41 5f                	pop    %r15
   14000606c:	c3                   	ret
   14000606d:	0f 1f 00             	nopl   (%rax)
   140006070:	81 64 24 78 ff fe ff 	andl   $0xfffffeff,0x78(%rsp)
   140006077:	ff 
   140006078:	41 83 fa 03          	cmp    $0x3,%r10d
   14000607c:	0f 84 e0 07 00 00    	je     140006862 <__mingw_pformat+0x9c2>
   140006082:	41 83 fa 02          	cmp    $0x2,%r10d
   140006086:	0f 84 69 08 00 00    	je     1400068f5 <__mingw_pformat+0xa55>
   14000608c:	41 83 fa 01          	cmp    $0x1,%r10d
   140006090:	41 8b 45 00          	mov    0x0(%r13),%eax
   140006094:	0f 84 78 07 00 00    	je     140006812 <__mingw_pformat+0x972>
   14000609a:	89 c2                	mov    %eax,%edx
   14000609c:	41 83 fa 05          	cmp    $0x5,%r10d
   1400060a0:	0f b6 c0             	movzbl %al,%eax
   1400060a3:	48 0f 45 c2          	cmovne %rdx,%rax
   1400060a7:	83 f9 75             	cmp    $0x75,%ecx
   1400060aa:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
   1400060af:	0f 84 2e 08 00 00    	je     1400068e3 <__mingw_pformat+0xa43>
   1400060b5:	4c 8d 44 24 70       	lea    0x70(%rsp),%r8
   1400060ba:	48 89 c2             	mov    %rax,%rdx
   1400060bd:	e8 ee e7 ff ff       	call   1400048b0 <__pformat_xint.isra.0>
   1400060c2:	e9 b1 02 00 00       	jmp    140006378 <__mingw_pformat+0x4d8>
   1400060c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   1400060ce:	00 00 
   1400060d0:	0f b6 46 01          	movzbl 0x1(%rsi),%eax
   1400060d4:	41 ba 03 00 00 00    	mov    $0x3,%r10d
   1400060da:	48 89 ee             	mov    %rbp,%rsi
   1400060dd:	41 be 04 00 00 00    	mov    $0x4,%r14d
   1400060e3:	e9 5f ff ff ff       	jmp    140006047 <__mingw_pformat+0x1a7>
   1400060e8:	81 4c 24 78 80 00 00 	orl    $0x80,0x78(%rsp)
   1400060ef:	00 
   1400060f0:	49 8d 5d 08          	lea    0x8(%r13),%rbx
   1400060f4:	41 83 fa 03          	cmp    $0x3,%r10d
   1400060f8:	0f 84 5b 07 00 00    	je     140006859 <__mingw_pformat+0x9b9>
   1400060fe:	41 83 fa 02          	cmp    $0x2,%r10d
   140006102:	49 63 4d 00          	movslq 0x0(%r13),%rcx
   140006106:	74 16                	je     14000611e <__mingw_pformat+0x27e>
   140006108:	41 83 fa 01          	cmp    $0x1,%r10d
   14000610c:	0f 84 f7 06 00 00    	je     140006809 <__mingw_pformat+0x969>
   140006112:	48 0f be c1          	movsbq %cl,%rax
   140006116:	41 83 fa 05          	cmp    $0x5,%r10d
   14000611a:	48 0f 44 c8          	cmove  %rax,%rcx
   14000611e:	49 89 dd             	mov    %rbx,%r13
   140006121:	48 89 eb             	mov    %rbp,%rbx
   140006124:	48 8d 54 24 70       	lea    0x70(%rsp),%rdx
   140006129:	e8 32 ec ff ff       	call   140004d60 <__pformat_int.isra.0>
   14000612e:	e9 59 fe ff ff       	jmp    140005f8c <__mingw_pformat+0xec>
   140006133:	45 85 f6             	test   %r14d,%r14d
   140006136:	75 0a                	jne    140006142 <__mingw_pformat+0x2a2>
   140006138:	39 7c 24 78          	cmp    %edi,0x78(%rsp)
   14000613c:	0f 84 95 06 00 00    	je     1400067d7 <__mingw_pformat+0x937>
   140006142:	49 8b 55 00          	mov    0x0(%r13),%rdx
   140006146:	49 8d 5d 08          	lea    0x8(%r13),%rbx
   14000614a:	b9 78 00 00 00       	mov    $0x78,%ecx
   14000614f:	4c 8d 44 24 70       	lea    0x70(%rsp),%r8
   140006154:	49 89 dd             	mov    %rbx,%r13
   140006157:	48 89 eb             	mov    %rbp,%rbx
   14000615a:	e8 51 e7 ff ff       	call   1400048b0 <__pformat_xint.isra.0>
   14000615f:	e9 28 fe ff ff       	jmp    140005f8c <__mingw_pformat+0xec>
   140006164:	0f b6 46 01          	movzbl 0x1(%rsi),%eax
   140006168:	3c 68                	cmp    $0x68,%al
   14000616a:	0f 84 41 07 00 00    	je     1400068b1 <__mingw_pformat+0xa11>
   140006170:	48 89 ee             	mov    %rbp,%rsi
   140006173:	41 ba 01 00 00 00    	mov    $0x1,%r10d
   140006179:	41 be 04 00 00 00    	mov    $0x4,%r14d
   14000617f:	e9 c3 fe ff ff       	jmp    140006047 <__mingw_pformat+0x1a7>
   140006184:	8b 4c 24 30          	mov    0x30(%rsp),%ecx
   140006188:	48 89 eb             	mov    %rbp,%rbx
   14000618b:	e8 30 37 00 00       	call   1400098c0 <strerror>
   140006190:	48 8d 54 24 70       	lea    0x70(%rsp),%rdx
   140006195:	48 89 c1             	mov    %rax,%rcx
   140006198:	e8 23 e6 ff ff       	call   1400047c0 <__pformat_puts>
   14000619d:	e9 ea fd ff ff       	jmp    140005f8c <__mingw_pformat+0xec>
   1400061a2:	41 83 fa 05          	cmp    $0x5,%r10d
   1400061a6:	49 8b 55 00          	mov    0x0(%r13),%rdx
   1400061aa:	48 63 84 24 94 00 00 	movslq 0x94(%rsp),%rax
   1400061b1:	00 
   1400061b2:	0f 84 f2 06 00 00    	je     1400068aa <__mingw_pformat+0xa0a>
   1400061b8:	41 83 fa 01          	cmp    $0x1,%r10d
   1400061bc:	0f 84 3c 07 00 00    	je     1400068fe <__mingw_pformat+0xa5e>
   1400061c2:	41 83 fa 02          	cmp    $0x2,%r10d
   1400061c6:	74 0a                	je     1400061d2 <__mingw_pformat+0x332>
   1400061c8:	41 83 fa 03          	cmp    $0x3,%r10d
   1400061cc:	0f 84 48 06 00 00    	je     14000681a <__mingw_pformat+0x97a>
   1400061d2:	89 02                	mov    %eax,(%rdx)
   1400061d4:	e9 9f 01 00 00       	jmp    140006378 <__mingw_pformat+0x4d8>
   1400061d9:	0f b6 46 01          	movzbl 0x1(%rsi),%eax
   1400061dd:	3c 6c                	cmp    $0x6c,%al
   1400061df:	0f 84 e5 06 00 00    	je     1400068ca <__mingw_pformat+0xa2a>
   1400061e5:	48 89 ee             	mov    %rbp,%rsi
   1400061e8:	41 ba 02 00 00 00    	mov    $0x2,%r10d
   1400061ee:	41 be 04 00 00 00    	mov    $0x4,%r14d
   1400061f4:	e9 4e fe ff ff       	jmp    140006047 <__mingw_pformat+0x1a7>
   1400061f9:	0f b6 46 01          	movzbl 0x1(%rsi),%eax
   1400061fd:	3c 36                	cmp    $0x36,%al
   1400061ff:	0f 84 82 06 00 00    	je     140006887 <__mingw_pformat+0x9e7>
   140006205:	3c 33                	cmp    $0x33,%al
   140006207:	0f 85 ab 05 00 00    	jne    1400067b8 <__mingw_pformat+0x918>
   14000620d:	80 7e 02 32          	cmpb   $0x32,0x2(%rsi)
   140006211:	0f 84 18 07 00 00    	je     14000692f <__mingw_pformat+0xa8f>
   140006217:	48 8d 54 24 70       	lea    0x70(%rsp),%rdx
   14000621c:	b9 25 00 00 00       	mov    $0x25,%ecx
   140006221:	e8 5a e2 ff ff       	call   140004480 <__pformat_putc>
   140006226:	e9 61 fd ff ff       	jmp    140005f8c <__mingw_pformat+0xec>
   14000622b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140006230:	0f b6 46 01          	movzbl 0x1(%rsi),%eax
   140006234:	41 be 04 00 00 00    	mov    $0x4,%r14d
   14000623a:	48 89 ee             	mov    %rbp,%rsi
   14000623d:	83 4c 24 78 04       	orl    $0x4,0x78(%rsp)
   140006242:	e9 00 fe ff ff       	jmp    140006047 <__mingw_pformat+0x1a7>
   140006247:	8b 44 24 78          	mov    0x78(%rsp),%eax
   14000624b:	49 8b 4d 00          	mov    0x0(%r13),%rcx
   14000624f:	83 c8 20             	or     $0x20,%eax
   140006252:	a8 04                	test   $0x4,%al
   140006254:	89 44 24 78          	mov    %eax,0x78(%rsp)
   140006258:	0f 84 02 02 00 00    	je     140006460 <__mingw_pformat+0x5c0>
   14000625e:	8b 59 08             	mov    0x8(%rcx),%ebx
   140006261:	48 8b 09             	mov    (%rcx),%rcx
   140006264:	44 0f bf d3          	movswl %bx,%r10d
   140006268:	48 89 da             	mov    %rbx,%rdx
   14000626b:	47 8d 1c 12          	lea    (%r10,%r10,1),%r11d
   14000626f:	49 89 c9             	mov    %rcx,%r9
   140006272:	49 c1 e9 20          	shr    $0x20,%r9
   140006276:	45 0f b7 db          	movzwl %r11w,%r11d
   14000627a:	41 81 e1 ff ff ff 7f 	and    $0x7fffffff,%r9d
   140006281:	41 09 c9             	or     %ecx,%r9d
   140006284:	45 89 c8             	mov    %r9d,%r8d
   140006287:	41 f7 d8             	neg    %r8d
   14000628a:	45 09 c8             	or     %r9d,%r8d
   14000628d:	41 c1 e8 1f          	shr    $0x1f,%r8d
   140006291:	45 09 d8             	or     %r11d,%r8d
   140006294:	41 bb fe ff 00 00    	mov    $0xfffe,%r11d
   14000629a:	45 29 c3             	sub    %r8d,%r11d
   14000629d:	41 c1 fb 10          	sar    $0x10,%r11d
   1400062a1:	45 85 db             	test   %r11d,%r11d
   1400062a4:	0f 85 d1 04 00 00    	jne    14000677b <__mingw_pformat+0x8db>
   1400062aa:	66 85 db             	test   %bx,%bx
   1400062ad:	0f 88 19 05 00 00    	js     1400067cc <__mingw_pformat+0x92c>
   1400062b3:	66 81 e2 ff 7f       	and    $0x7fff,%dx
   1400062b8:	0f 84 ea 04 00 00    	je     1400067a8 <__mingw_pformat+0x908>
   1400062be:	66 81 fa ff 7f       	cmp    $0x7fff,%dx
   1400062c3:	75 09                	jne    1400062ce <__mingw_pformat+0x42e>
   1400062c5:	45 85 c9             	test   %r9d,%r9d
   1400062c8:	0f 84 9d 06 00 00    	je     14000696b <__mingw_pformat+0xacb>
   1400062ce:	66 81 ea ff 3f       	sub    $0x3fff,%dx
   1400062d3:	e9 2f 04 00 00       	jmp    140006707 <__mingw_pformat+0x867>
   1400062d8:	41 8b 45 00          	mov    0x0(%r13),%eax
   1400062dc:	49 8d 5d 08          	lea    0x8(%r13),%rbx
   1400062e0:	41 83 ea 02          	sub    $0x2,%r10d
   1400062e4:	c7 84 24 80 00 00 00 	movl   $0xffffffff,0x80(%rsp)
   1400062eb:	ff ff ff ff 
   1400062ef:	41 83 fa 01          	cmp    $0x1,%r10d
   1400062f3:	0f 86 16 02 00 00    	jbe    14000650f <__mingw_pformat+0x66f>
   1400062f9:	48 8d 4c 24 60       	lea    0x60(%rsp),%rcx
   1400062fe:	ba 01 00 00 00       	mov    $0x1,%edx
   140006303:	88 44 24 60          	mov    %al,0x60(%rsp)
   140006307:	49 89 dd             	mov    %rbx,%r13
   14000630a:	4c 8d 44 24 70       	lea    0x70(%rsp),%r8
   14000630f:	48 89 eb             	mov    %rbp,%rbx
   140006312:	e8 59 e3 ff ff       	call   140004670 <__pformat_putchars>
   140006317:	e9 70 fc ff ff       	jmp    140005f8c <__mingw_pformat+0xec>
   14000631c:	49 8b 4d 00          	mov    0x0(%r13),%rcx
   140006320:	49 8d 5d 08          	lea    0x8(%r13),%rbx
   140006324:	41 83 ea 02          	sub    $0x2,%r10d
   140006328:	41 83 fa 01          	cmp    $0x1,%r10d
   14000632c:	0f 86 e8 03 00 00    	jbe    14000671a <__mingw_pformat+0x87a>
   140006332:	48 8d 54 24 70       	lea    0x70(%rsp),%rdx
   140006337:	e8 84 e4 ff ff       	call   1400047c0 <__pformat_puts>
   14000633c:	49 89 dd             	mov    %rbx,%r13
   14000633f:	48 89 eb             	mov    %rbp,%rbx
   140006342:	e9 45 fc ff ff       	jmp    140005f8c <__mingw_pformat+0xec>
   140006347:	8b 44 24 78          	mov    0x78(%rsp),%eax
   14000634b:	49 8b 55 00          	mov    0x0(%r13),%rdx
   14000634f:	83 c8 20             	or     $0x20,%eax
   140006352:	a8 04                	test   $0x4,%al
   140006354:	89 44 24 78          	mov    %eax,0x78(%rsp)
   140006358:	0f 84 4b 02 00 00    	je     1400065a9 <__mingw_pformat+0x709>
   14000635e:	db 2a                	fldt   (%rdx)
   140006360:	48 8d 4c 24 40       	lea    0x40(%rsp),%rcx
   140006365:	db 7c 24 40          	fstpt  0x40(%rsp)
   140006369:	48 8d 54 24 70       	lea    0x70(%rsp),%rdx
   14000636e:	e8 fd f4 ff ff       	call   140005870 <__pformat_gfloat>
   140006373:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140006378:	49 83 c5 08          	add    $0x8,%r13
   14000637c:	48 89 eb             	mov    %rbp,%rbx
   14000637f:	e9 08 fc ff ff       	jmp    140005f8c <__mingw_pformat+0xec>
   140006384:	8b 44 24 78          	mov    0x78(%rsp),%eax
   140006388:	49 8b 55 00          	mov    0x0(%r13),%rdx
   14000638c:	83 c8 20             	or     $0x20,%eax
   14000638f:	a8 04                	test   $0x4,%al
   140006391:	89 44 24 78          	mov    %eax,0x78(%rsp)
   140006395:	0f 84 dd 01 00 00    	je     140006578 <__mingw_pformat+0x6d8>
   14000639b:	db 2a                	fldt   (%rdx)
   14000639d:	48 8d 4c 24 40       	lea    0x40(%rsp),%rcx
   1400063a2:	db 7c 24 40          	fstpt  0x40(%rsp)
   1400063a6:	48 8d 54 24 70       	lea    0x70(%rsp),%rdx
   1400063ab:	e8 e0 f3 ff ff       	call   140005790 <__pformat_float>
   1400063b0:	eb c6                	jmp    140006378 <__mingw_pformat+0x4d8>
   1400063b2:	8b 44 24 78          	mov    0x78(%rsp),%eax
   1400063b6:	49 8b 55 00          	mov    0x0(%r13),%rdx
   1400063ba:	83 c8 20             	or     $0x20,%eax
   1400063bd:	a8 04                	test   $0x4,%al
   1400063bf:	89 44 24 78          	mov    %eax,0x78(%rsp)
   1400063c3:	0f 84 7e 01 00 00    	je     140006547 <__mingw_pformat+0x6a7>
   1400063c9:	db 2a                	fldt   (%rdx)
   1400063cb:	48 8d 4c 24 40       	lea    0x40(%rsp),%rcx
   1400063d0:	db 7c 24 40          	fstpt  0x40(%rsp)
   1400063d4:	48 8d 54 24 70       	lea    0x70(%rsp),%rdx
   1400063d9:	e8 12 f3 ff ff       	call   1400056f0 <__pformat_efloat>
   1400063de:	eb 98                	jmp    140006378 <__mingw_pformat+0x4d8>
   1400063e0:	45 85 f6             	test   %r14d,%r14d
   1400063e3:	0f 85 57 fc ff ff    	jne    140006040 <__mingw_pformat+0x1a0>
   1400063e9:	0f b6 46 01          	movzbl 0x1(%rsi),%eax
   1400063ed:	48 89 ee             	mov    %rbp,%rsi
   1400063f0:	83 4c 24 78 40       	orl    $0x40,0x78(%rsp)
   1400063f5:	e9 4d fc ff ff       	jmp    140006047 <__mingw_pformat+0x1a7>
   1400063fa:	45 85 f6             	test   %r14d,%r14d
   1400063fd:	0f 85 3d fc ff ff    	jne    140006040 <__mingw_pformat+0x1a0>
   140006403:	0f b6 46 01          	movzbl 0x1(%rsi),%eax
   140006407:	48 89 ee             	mov    %rbp,%rsi
   14000640a:	81 4c 24 78 00 04 00 	orl    $0x400,0x78(%rsp)
   140006411:	00 
   140006412:	e9 30 fc ff ff       	jmp    140006047 <__mingw_pformat+0x1a7>
   140006417:	41 83 fe 01          	cmp    $0x1,%r14d
   14000641b:	0f 86 13 04 00 00    	jbe    140006834 <__mingw_pformat+0x994>
   140006421:	0f b6 46 01          	movzbl 0x1(%rsi),%eax
   140006425:	41 be 04 00 00 00    	mov    $0x4,%r14d
   14000642b:	48 89 ee             	mov    %rbp,%rsi
   14000642e:	e9 14 fc ff ff       	jmp    140006047 <__mingw_pformat+0x1a7>
   140006433:	45 85 f6             	test   %r14d,%r14d
   140006436:	0f 85 1e 03 00 00    	jne    14000675a <__mingw_pformat+0x8ba>
   14000643c:	0f b6 46 01          	movzbl 0x1(%rsi),%eax
   140006440:	48 89 ee             	mov    %rbp,%rsi
   140006443:	81 4c 24 78 00 02 00 	orl    $0x200,0x78(%rsp)
   14000644a:	00 
   14000644b:	e9 f7 fb ff ff       	jmp    140006047 <__mingw_pformat+0x1a7>
   140006450:	8b 44 24 78          	mov    0x78(%rsp),%eax
   140006454:	49 8b 4d 00          	mov    0x0(%r13),%rcx
   140006458:	a8 04                	test   $0x4,%al
   14000645a:	0f 85 fe fd ff ff    	jne    14000625e <__mingw_pformat+0x3be>
   140006460:	49 89 c8             	mov    %rcx,%r8
   140006463:	89 ca                	mov    %ecx,%edx
   140006465:	49 c1 e8 20          	shr    $0x20,%r8
   140006469:	f7 da                	neg    %edx
   14000646b:	09 ca                	or     %ecx,%edx
   14000646d:	45 89 c1             	mov    %r8d,%r9d
   140006470:	41 81 e1 ff ff ff 7f 	and    $0x7fffffff,%r9d
   140006477:	c1 ea 1f             	shr    $0x1f,%edx
   14000647a:	44 09 ca             	or     %r9d,%edx
   14000647d:	41 b9 00 00 f0 7f    	mov    $0x7ff00000,%r9d
   140006483:	41 39 d1             	cmp    %edx,%r9d
   140006486:	0f 88 ef 02 00 00    	js     14000677b <__mingw_pformat+0x8db>
   14000648c:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   140006491:	dd 44 24 20          	fldl   0x20(%rsp)
   140006495:	db 7c 24 20          	fstpt  0x20(%rsp)
   140006499:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
   14000649e:	66 85 d2             	test   %dx,%dx
   1400064a1:	79 06                	jns    1400064a9 <__mingw_pformat+0x609>
   1400064a3:	0c 80                	or     $0x80,%al
   1400064a5:	89 44 24 78          	mov    %eax,0x78(%rsp)
   1400064a9:	44 89 c0             	mov    %r8d,%eax
   1400064ac:	41 81 e0 00 00 f0 7f 	and    $0x7ff00000,%r8d
   1400064b3:	25 ff ff 0f 00       	and    $0xfffff,%eax
   1400064b8:	09 c8                	or     %ecx,%eax
   1400064ba:	0f 95 c1             	setne  %cl
   1400064bd:	41 81 f8 00 00 f0 7f 	cmp    $0x7ff00000,%r8d
   1400064c4:	41 0f 95 c1          	setne  %r9b
   1400064c8:	44 08 c9             	or     %r9b,%cl
   1400064cb:	0f 85 fe 01 00 00    	jne    1400066cf <__mingw_pformat+0x82f>
   1400064d1:	44 09 c0             	or     %r8d,%eax
   1400064d4:	0f 84 f5 01 00 00    	je     1400066cf <__mingw_pformat+0x82f>
   1400064da:	4c 8d 44 24 70       	lea    0x70(%rsp),%r8
   1400064df:	89 d1                	mov    %edx,%ecx
   1400064e1:	48 8d 15 a2 4f 00 00 	lea    0x4fa2(%rip),%rdx        # 14000b48a <.rdata+0x1a>
   1400064e8:	81 e1 00 80 00 00    	and    $0x8000,%ecx
   1400064ee:	e8 1d e3 ff ff       	call   140004810 <__pformat_emit_inf_or_nan>
   1400064f3:	e9 80 fe ff ff       	jmp    140006378 <__mingw_pformat+0x4d8>
   1400064f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   1400064ff:	00 
   140006500:	c7 84 24 80 00 00 00 	movl   $0xffffffff,0x80(%rsp)
   140006507:	ff ff ff ff 
   14000650b:	49 8d 5d 08          	lea    0x8(%r13),%rbx
   14000650f:	41 8b 45 00          	mov    0x0(%r13),%eax
   140006513:	48 8d 4c 24 60       	lea    0x60(%rsp),%rcx
   140006518:	ba 01 00 00 00       	mov    $0x1,%edx
   14000651d:	49 89 dd             	mov    %rbx,%r13
   140006520:	4c 8d 44 24 70       	lea    0x70(%rsp),%r8
   140006525:	48 89 eb             	mov    %rbp,%rbx
   140006528:	66 89 44 24 60       	mov    %ax,0x60(%rsp)
   14000652d:	e8 ae df ff ff       	call   1400044e0 <__pformat_wputchars>
   140006532:	e9 55 fa ff ff       	jmp    140005f8c <__mingw_pformat+0xec>
   140006537:	8b 44 24 78          	mov    0x78(%rsp),%eax
   14000653b:	49 8b 55 00          	mov    0x0(%r13),%rdx
   14000653f:	a8 04                	test   $0x4,%al
   140006541:	0f 85 82 fe ff ff    	jne    1400063c9 <__mingw_pformat+0x529>
   140006547:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   14000654c:	48 8d 4c 24 40       	lea    0x40(%rsp),%rcx
   140006551:	dd 44 24 20          	fldl   0x20(%rsp)
   140006555:	db 7c 24 40          	fstpt  0x40(%rsp)
   140006559:	48 8d 54 24 70       	lea    0x70(%rsp),%rdx
   14000655e:	e8 8d f1 ff ff       	call   1400056f0 <__pformat_efloat>
   140006563:	e9 10 fe ff ff       	jmp    140006378 <__mingw_pformat+0x4d8>
   140006568:	8b 44 24 78          	mov    0x78(%rsp),%eax
   14000656c:	49 8b 55 00          	mov    0x0(%r13),%rdx
   140006570:	a8 04                	test   $0x4,%al
   140006572:	0f 85 23 fe ff ff    	jne    14000639b <__mingw_pformat+0x4fb>
   140006578:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   14000657d:	48 8d 4c 24 40       	lea    0x40(%rsp),%rcx
   140006582:	dd 44 24 20          	fldl   0x20(%rsp)
   140006586:	db 7c 24 40          	fstpt  0x40(%rsp)
   14000658a:	48 8d 54 24 70       	lea    0x70(%rsp),%rdx
   14000658f:	e8 fc f1 ff ff       	call   140005790 <__pformat_float>
   140006594:	e9 df fd ff ff       	jmp    140006378 <__mingw_pformat+0x4d8>
   140006599:	8b 44 24 78          	mov    0x78(%rsp),%eax
   14000659d:	49 8b 55 00          	mov    0x0(%r13),%rdx
   1400065a1:	a8 04                	test   $0x4,%al
   1400065a3:	0f 85 b5 fd ff ff    	jne    14000635e <__mingw_pformat+0x4be>
   1400065a9:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   1400065ae:	48 8d 4c 24 40       	lea    0x40(%rsp),%rcx
   1400065b3:	dd 44 24 20          	fldl   0x20(%rsp)
   1400065b7:	db 7c 24 40          	fstpt  0x40(%rsp)
   1400065bb:	48 8d 54 24 70       	lea    0x70(%rsp),%rdx
   1400065c0:	e8 ab f2 ff ff       	call   140005870 <__pformat_gfloat>
   1400065c5:	e9 ae fd ff ff       	jmp    140006378 <__mingw_pformat+0x4d8>
   1400065ca:	48 8d 54 24 70       	lea    0x70(%rsp),%rdx
   1400065cf:	b9 25 00 00 00       	mov    $0x25,%ecx
   1400065d4:	48 89 eb             	mov    %rbp,%rbx
   1400065d7:	e8 a4 de ff ff       	call   140004480 <__pformat_putc>
   1400065dc:	e9 ab f9 ff ff       	jmp    140005f8c <__mingw_pformat+0xec>
   1400065e1:	45 85 f6             	test   %r14d,%r14d
   1400065e4:	0f 85 56 fa ff ff    	jne    140006040 <__mingw_pformat+0x1a0>
   1400065ea:	4c 8d 4c 24 60       	lea    0x60(%rsp),%r9
   1400065ef:	4c 89 5c 24 38       	mov    %r11,0x38(%rsp)
   1400065f4:	81 4c 24 78 00 10 00 	orl    $0x1000,0x78(%rsp)
   1400065fb:	00 
   1400065fc:	44 89 54 24 34       	mov    %r10d,0x34(%rsp)
   140006601:	4c 89 4c 24 20       	mov    %r9,0x20(%rsp)
   140006606:	c7 44 24 60 00 00 00 	movl   $0x0,0x60(%rsp)
   14000660d:	00 
   14000660e:	e8 85 32 00 00       	call   140009898 <localeconv>
   140006613:	4c 8b 4c 24 20       	mov    0x20(%rsp),%r9
   140006618:	48 8d 4c 24 5e       	lea    0x5e(%rsp),%rcx
   14000661d:	41 b8 10 00 00 00    	mov    $0x10,%r8d
   140006623:	48 8b 50 08          	mov    0x8(%rax),%rdx
   140006627:	e8 e4 2f 00 00       	call   140009610 <mbrtowc>
   14000662c:	44 8b 54 24 34       	mov    0x34(%rsp),%r10d
   140006631:	85 c0                	test   %eax,%eax
   140006633:	4c 8b 5c 24 38       	mov    0x38(%rsp),%r11
   140006638:	7e 0d                	jle    140006647 <__mingw_pformat+0x7a7>
   14000663a:	0f b7 54 24 5e       	movzwl 0x5e(%rsp),%edx
   14000663f:	66 89 94 24 90 00 00 	mov    %dx,0x90(%rsp)
   140006646:	00 
   140006647:	89 84 24 8c 00 00 00 	mov    %eax,0x8c(%rsp)
   14000664e:	0f b6 46 01          	movzbl 0x1(%rsi),%eax
   140006652:	48 89 ee             	mov    %rbp,%rsi
   140006655:	e9 ed f9 ff ff       	jmp    140006047 <__mingw_pformat+0x1a7>
   14000665a:	4d 85 db             	test   %r11,%r11
   14000665d:	0f 84 be fd ff ff    	je     140006421 <__mingw_pformat+0x581>
   140006663:	41 f7 c6 fd ff ff ff 	test   $0xfffffffd,%r14d
   14000666a:	0f 85 23 01 00 00    	jne    140006793 <__mingw_pformat+0x8f3>
   140006670:	41 8b 45 00          	mov    0x0(%r13),%eax
   140006674:	49 8d 55 08          	lea    0x8(%r13),%rdx
   140006678:	85 c0                	test   %eax,%eax
   14000667a:	41 89 03             	mov    %eax,(%r11)
   14000667d:	0f 88 83 02 00 00    	js     140006906 <__mingw_pformat+0xa66>
   140006683:	0f b6 46 01          	movzbl 0x1(%rsi),%eax
   140006687:	49 89 d5             	mov    %rdx,%r13
   14000668a:	48 89 ee             	mov    %rbp,%rsi
   14000668d:	45 31 db             	xor    %r11d,%r11d
   140006690:	e9 b2 f9 ff ff       	jmp    140006047 <__mingw_pformat+0x1a7>
   140006695:	45 85 f6             	test   %r14d,%r14d
   140006698:	0f 85 a2 f9 ff ff    	jne    140006040 <__mingw_pformat+0x1a0>
   14000669e:	0f b6 46 01          	movzbl 0x1(%rsi),%eax
   1400066a2:	48 89 ee             	mov    %rbp,%rsi
   1400066a5:	81 4c 24 78 00 01 00 	orl    $0x100,0x78(%rsp)
   1400066ac:	00 
   1400066ad:	e9 95 f9 ff ff       	jmp    140006047 <__mingw_pformat+0x1a7>
   1400066b2:	45 85 f6             	test   %r14d,%r14d
   1400066b5:	0f 85 85 f9 ff ff    	jne    140006040 <__mingw_pformat+0x1a0>
   1400066bb:	0f b6 46 01          	movzbl 0x1(%rsi),%eax
   1400066bf:	48 89 ee             	mov    %rbp,%rsi
   1400066c2:	81 4c 24 78 00 08 00 	orl    $0x800,0x78(%rsp)
   1400066c9:	00 
   1400066ca:	e9 78 f9 ff ff       	jmp    140006047 <__mingw_pformat+0x1a7>
   1400066cf:	66 81 e2 ff 7f       	and    $0x7fff,%dx
   1400066d4:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
   1400066d9:	0f 84 1a 01 00 00    	je     1400067f9 <__mingw_pformat+0x959>
   1400066df:	66 81 fa 00 3c       	cmp    $0x3c00,%dx
   1400066e4:	0f 8f 06 01 00 00    	jg     1400067f0 <__mingw_pformat+0x950>
   1400066ea:	44 0f bf c2          	movswl %dx,%r8d
   1400066ee:	b9 01 3c 00 00       	mov    $0x3c01,%ecx
   1400066f3:	44 29 c1             	sub    %r8d,%ecx
   1400066f6:	48 d3 e8             	shr    %cl,%rax
   1400066f9:	01 ca                	add    %ecx,%edx
   1400066fb:	66 81 ea fc 3f       	sub    $0x3ffc,%dx
   140006700:	48 c1 e8 03          	shr    $0x3,%rax
   140006704:	48 89 c1             	mov    %rax,%rcx
   140006707:	4c 8d 44 24 70       	lea    0x70(%rsp),%r8
   14000670c:	e8 df f2 ff ff       	call   1400059f0 <__pformat_emit_xfloat.isra.0>
   140006711:	e9 62 fc ff ff       	jmp    140006378 <__mingw_pformat+0x4d8>
   140006716:	49 8d 5d 08          	lea    0x8(%r13),%rbx
   14000671a:	49 8b 75 00          	mov    0x0(%r13),%rsi
   14000671e:	48 8d 05 53 4d 00 00 	lea    0x4d53(%rip),%rax        # 14000b478 <.rdata+0x8>
   140006725:	48 85 f6             	test   %rsi,%rsi
   140006728:	48 0f 44 f0          	cmove  %rax,%rsi
   14000672c:	8b 84 24 80 00 00 00 	mov    0x80(%rsp),%eax
   140006733:	85 c0                	test   %eax,%eax
   140006735:	0f 88 30 01 00 00    	js     14000686b <__mingw_pformat+0x9cb>
   14000673b:	48 89 f1             	mov    %rsi,%rcx
   14000673e:	48 63 d0             	movslq %eax,%rdx
   140006741:	e8 3a 2a 00 00       	call   140009180 <wcsnlen>
   140006746:	4c 8d 44 24 70       	lea    0x70(%rsp),%r8
   14000674b:	48 89 f1             	mov    %rsi,%rcx
   14000674e:	89 c2                	mov    %eax,%edx
   140006750:	e8 8b dd ff ff       	call   1400044e0 <__pformat_wputchars>
   140006755:	e9 e2 fb ff ff       	jmp    14000633c <__mingw_pformat+0x49c>
   14000675a:	41 83 fe 04          	cmp    $0x4,%r14d
   14000675e:	0f 84 b3 fa ff ff    	je     140006217 <__mingw_pformat+0x377>
   140006764:	b9 30 00 00 00       	mov    $0x30,%ecx
   140006769:	41 83 fe 02          	cmp    $0x2,%r14d
   14000676d:	b8 03 00 00 00       	mov    $0x3,%eax
   140006772:	44 0f 44 f0          	cmove  %eax,%r14d
   140006776:	e9 a1 f8 ff ff       	jmp    14000601c <__mingw_pformat+0x17c>
   14000677b:	4c 8d 44 24 70       	lea    0x70(%rsp),%r8
   140006780:	31 c9                	xor    %ecx,%ecx
   140006782:	48 8d 15 fd 4c 00 00 	lea    0x4cfd(%rip),%rdx        # 14000b486 <.rdata+0x16>
   140006789:	e8 82 e0 ff ff       	call   140004810 <__pformat_emit_inf_or_nan>
   14000678e:	e9 e5 fb ff ff       	jmp    140006378 <__mingw_pformat+0x4d8>
   140006793:	0f b6 46 01          	movzbl 0x1(%rsi),%eax
   140006797:	45 31 db             	xor    %r11d,%r11d
   14000679a:	48 89 ee             	mov    %rbp,%rsi
   14000679d:	41 be 04 00 00 00    	mov    $0x4,%r14d
   1400067a3:	e9 9f f8 ff ff       	jmp    140006047 <__mingw_pformat+0x1a7>
   1400067a8:	48 85 c9             	test   %rcx,%rcx
   1400067ab:	b8 02 c0 ff ff       	mov    $0xffffc002,%eax
   1400067b0:	0f 45 d0             	cmovne %eax,%edx
   1400067b3:	e9 4f ff ff ff       	jmp    140006707 <__mingw_pformat+0x867>
   1400067b8:	48 89 ee             	mov    %rbp,%rsi
   1400067bb:	41 ba 03 00 00 00    	mov    $0x3,%r10d
   1400067c1:	41 be 04 00 00 00    	mov    $0x4,%r14d
   1400067c7:	e9 7b f8 ff ff       	jmp    140006047 <__mingw_pformat+0x1a7>
   1400067cc:	0c 80                	or     $0x80,%al
   1400067ce:	89 44 24 78          	mov    %eax,0x78(%rsp)
   1400067d2:	e9 dc fa ff ff       	jmp    1400062b3 <__mingw_pformat+0x413>
   1400067d7:	c7 84 24 80 00 00 00 	movl   $0x10,0x80(%rsp)
   1400067de:	10 00 00 00 
   1400067e2:	89 f8                	mov    %edi,%eax
   1400067e4:	80 cc 02             	or     $0x2,%ah
   1400067e7:	89 44 24 78          	mov    %eax,0x78(%rsp)
   1400067eb:	e9 52 f9 ff ff       	jmp    140006142 <__mingw_pformat+0x2a2>
   1400067f0:	66 85 d2             	test   %dx,%dx
   1400067f3:	0f 85 02 ff ff ff    	jne    1400066fb <__mingw_pformat+0x85b>
   1400067f9:	48 85 c0             	test   %rax,%rax
   1400067fc:	b9 05 fc ff ff       	mov    $0xfffffc05,%ecx
   140006801:	0f 45 d1             	cmovne %ecx,%edx
   140006804:	e9 f7 fe ff ff       	jmp    140006700 <__mingw_pformat+0x860>
   140006809:	48 0f bf c9          	movswq %cx,%rcx
   14000680d:	e9 0c f9 ff ff       	jmp    14000611e <__mingw_pformat+0x27e>
   140006812:	0f b7 c0             	movzwl %ax,%eax
   140006815:	e9 8d f8 ff ff       	jmp    1400060a7 <__mingw_pformat+0x207>
   14000681a:	48 89 02             	mov    %rax,(%rdx)
   14000681d:	e9 56 fb ff ff       	jmp    140006378 <__mingw_pformat+0x4d8>
   140006822:	83 e9 30             	sub    $0x30,%ecx
   140006825:	0f b6 46 01          	movzbl 0x1(%rsi),%eax
   140006829:	48 89 ee             	mov    %rbp,%rsi
   14000682c:	41 89 0b             	mov    %ecx,(%r11)
   14000682f:	e9 13 f8 ff ff       	jmp    140006047 <__mingw_pformat+0x1a7>
   140006834:	0f b6 46 01          	movzbl 0x1(%rsi),%eax
   140006838:	41 be 02 00 00 00    	mov    $0x2,%r14d
   14000683e:	48 89 ee             	mov    %rbp,%rsi
   140006841:	c7 84 24 80 00 00 00 	movl   $0x0,0x80(%rsp)
   140006848:	00 00 00 00 
   14000684c:	4c 8d 9c 24 80 00 00 	lea    0x80(%rsp),%r11
   140006853:	00 
   140006854:	e9 ee f7 ff ff       	jmp    140006047 <__mingw_pformat+0x1a7>
   140006859:	49 8b 4d 00          	mov    0x0(%r13),%rcx
   14000685d:	e9 bc f8 ff ff       	jmp    14000611e <__mingw_pformat+0x27e>
   140006862:	49 8b 45 00          	mov    0x0(%r13),%rax
   140006866:	e9 3c f8 ff ff       	jmp    1400060a7 <__mingw_pformat+0x207>
   14000686b:	48 89 f1             	mov    %rsi,%rcx
   14000686e:	e8 6d 30 00 00       	call   1400098e0 <wcslen>
   140006873:	4c 8d 44 24 70       	lea    0x70(%rsp),%r8
   140006878:	48 89 f1             	mov    %rsi,%rcx
   14000687b:	89 c2                	mov    %eax,%edx
   14000687d:	e8 5e dc ff ff       	call   1400044e0 <__pformat_wputchars>
   140006882:	e9 b5 fa ff ff       	jmp    14000633c <__mingw_pformat+0x49c>
   140006887:	80 7e 02 34          	cmpb   $0x34,0x2(%rsi)
   14000688b:	0f 85 86 f9 ff ff    	jne    140006217 <__mingw_pformat+0x377>
   140006891:	0f b6 46 03          	movzbl 0x3(%rsi),%eax
   140006895:	41 ba 03 00 00 00    	mov    $0x3,%r10d
   14000689b:	48 83 c6 03          	add    $0x3,%rsi
   14000689f:	41 be 04 00 00 00    	mov    $0x4,%r14d
   1400068a5:	e9 9d f7 ff ff       	jmp    140006047 <__mingw_pformat+0x1a7>
   1400068aa:	88 02                	mov    %al,(%rdx)
   1400068ac:	e9 c7 fa ff ff       	jmp    140006378 <__mingw_pformat+0x4d8>
   1400068b1:	0f b6 46 02          	movzbl 0x2(%rsi),%eax
   1400068b5:	41 ba 05 00 00 00    	mov    $0x5,%r10d
   1400068bb:	48 83 c6 02          	add    $0x2,%rsi
   1400068bf:	41 be 04 00 00 00    	mov    $0x4,%r14d
   1400068c5:	e9 7d f7 ff ff       	jmp    140006047 <__mingw_pformat+0x1a7>
   1400068ca:	0f b6 46 02          	movzbl 0x2(%rsi),%eax
   1400068ce:	41 ba 03 00 00 00    	mov    $0x3,%r10d
   1400068d4:	48 83 c6 02          	add    $0x2,%rsi
   1400068d8:	41 be 04 00 00 00    	mov    $0x4,%r14d
   1400068de:	e9 64 f7 ff ff       	jmp    140006047 <__mingw_pformat+0x1a7>
   1400068e3:	48 8d 54 24 70       	lea    0x70(%rsp),%rdx
   1400068e8:	48 89 c1             	mov    %rax,%rcx
   1400068eb:	e8 70 e4 ff ff       	call   140004d60 <__pformat_int.isra.0>
   1400068f0:	e9 83 fa ff ff       	jmp    140006378 <__mingw_pformat+0x4d8>
   1400068f5:	41 8b 45 00          	mov    0x0(%r13),%eax
   1400068f9:	e9 a9 f7 ff ff       	jmp    1400060a7 <__mingw_pformat+0x207>
   1400068fe:	66 89 02             	mov    %ax,(%rdx)
   140006901:	e9 72 fa ff ff       	jmp    140006378 <__mingw_pformat+0x4d8>
   140006906:	45 85 f6             	test   %r14d,%r14d
   140006909:	75 3d                	jne    140006948 <__mingw_pformat+0xaa8>
   14000690b:	8b 44 24 78          	mov    0x78(%rsp),%eax
   14000690f:	80 cc 04             	or     $0x4,%ah
   140006912:	66 0f 6e c0          	movd   %eax,%xmm0
   140006916:	8b 44 24 7c          	mov    0x7c(%rsp),%eax
   14000691a:	f7 d8                	neg    %eax
   14000691c:	66 0f 6e c8          	movd   %eax,%xmm1
   140006920:	66 0f 62 c1          	punpckldq %xmm1,%xmm0
   140006924:	66 0f d6 44 24 78    	movq   %xmm0,0x78(%rsp)
   14000692a:	e9 54 fd ff ff       	jmp    140006683 <__mingw_pformat+0x7e3>
   14000692f:	0f b6 46 03          	movzbl 0x3(%rsi),%eax
   140006933:	41 ba 02 00 00 00    	mov    $0x2,%r10d
   140006939:	48 83 c6 03          	add    $0x3,%rsi
   14000693d:	41 be 04 00 00 00    	mov    $0x4,%r14d
   140006943:	e9 ff f6 ff ff       	jmp    140006047 <__mingw_pformat+0x1a7>
   140006948:	0f b6 46 01          	movzbl 0x1(%rsi),%eax
   14000694c:	49 89 d5             	mov    %rdx,%r13
   14000694f:	48 89 ee             	mov    %rbp,%rsi
   140006952:	45 31 db             	xor    %r11d,%r11d
   140006955:	c7 84 24 80 00 00 00 	movl   $0xffffffff,0x80(%rsp)
   14000695c:	ff ff ff ff 
   140006960:	41 be 02 00 00 00    	mov    $0x2,%r14d
   140006966:	e9 dc f6 ff ff       	jmp    140006047 <__mingw_pformat+0x1a7>
   14000696b:	4c 8d 44 24 70       	lea    0x70(%rsp),%r8
   140006970:	44 89 d1             	mov    %r10d,%ecx
   140006973:	48 8d 15 10 4b 00 00 	lea    0x4b10(%rip),%rdx        # 14000b48a <.rdata+0x1a>
   14000697a:	81 e1 00 80 00 00    	and    $0x8000,%ecx
   140006980:	e8 8b de ff ff       	call   140004810 <__pformat_emit_inf_or_nan>
   140006985:	e9 ee f9 ff ff       	jmp    140006378 <__mingw_pformat+0x4d8>
   14000698a:	90                   	nop
   14000698b:	90                   	nop
   14000698c:	90                   	nop
   14000698d:	90                   	nop
   14000698e:	90                   	nop
   14000698f:	90                   	nop

0000000140006990 <__rv_alloc_D2A>:
   140006990:	53                   	push   %rbx
   140006991:	48 83 ec 20          	sub    $0x20,%rsp
   140006995:	31 db                	xor    %ebx,%ebx
   140006997:	83 f9 1b             	cmp    $0x1b,%ecx
   14000699a:	7e 18                	jle    1400069b4 <__rv_alloc_D2A+0x24>
   14000699c:	b8 04 00 00 00       	mov    $0x4,%eax
   1400069a1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   1400069a8:	01 c0                	add    %eax,%eax
   1400069aa:	83 c3 01             	add    $0x1,%ebx
   1400069ad:	8d 50 17             	lea    0x17(%rax),%edx
   1400069b0:	39 ca                	cmp    %ecx,%edx
   1400069b2:	7c f4                	jl     1400069a8 <__rv_alloc_D2A+0x18>
   1400069b4:	89 d9                	mov    %ebx,%ecx
   1400069b6:	e8 25 1c 00 00       	call   1400085e0 <__Balloc_D2A>
   1400069bb:	89 18                	mov    %ebx,(%rax)
   1400069bd:	48 83 c0 04          	add    $0x4,%rax
   1400069c1:	48 83 c4 20          	add    $0x20,%rsp
   1400069c5:	5b                   	pop    %rbx
   1400069c6:	c3                   	ret
   1400069c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   1400069ce:	00 00 

00000001400069d0 <__nrv_alloc_D2A>:
   1400069d0:	57                   	push   %rdi
   1400069d1:	56                   	push   %rsi
   1400069d2:	53                   	push   %rbx
   1400069d3:	48 83 ec 20          	sub    $0x20,%rsp
   1400069d7:	41 83 f8 1b          	cmp    $0x1b,%r8d
   1400069db:	48 89 ce             	mov    %rcx,%rsi
   1400069de:	48 89 d7             	mov    %rdx,%rdi
   1400069e1:	7e 65                	jle    140006a48 <__nrv_alloc_D2A+0x78>
   1400069e3:	b8 04 00 00 00       	mov    $0x4,%eax
   1400069e8:	31 db                	xor    %ebx,%ebx
   1400069ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   1400069f0:	01 c0                	add    %eax,%eax
   1400069f2:	83 c3 01             	add    $0x1,%ebx
   1400069f5:	8d 50 17             	lea    0x17(%rax),%edx
   1400069f8:	41 39 d0             	cmp    %edx,%r8d
   1400069fb:	7f f3                	jg     1400069f0 <__nrv_alloc_D2A+0x20>
   1400069fd:	89 d9                	mov    %ebx,%ecx
   1400069ff:	e8 dc 1b 00 00       	call   1400085e0 <__Balloc_D2A>
   140006a04:	48 8d 56 01          	lea    0x1(%rsi),%rdx
   140006a08:	89 18                	mov    %ebx,(%rax)
   140006a0a:	0f b6 0e             	movzbl (%rsi),%ecx
   140006a0d:	4c 8d 40 04          	lea    0x4(%rax),%r8
   140006a11:	84 c9                	test   %cl,%cl
   140006a13:	88 48 04             	mov    %cl,0x4(%rax)
   140006a16:	4c 89 c0             	mov    %r8,%rax
   140006a19:	74 16                	je     140006a31 <__nrv_alloc_D2A+0x61>
   140006a1b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140006a20:	0f b6 0a             	movzbl (%rdx),%ecx
   140006a23:	48 83 c0 01          	add    $0x1,%rax
   140006a27:	48 83 c2 01          	add    $0x1,%rdx
   140006a2b:	84 c9                	test   %cl,%cl
   140006a2d:	88 08                	mov    %cl,(%rax)
   140006a2f:	75 ef                	jne    140006a20 <__nrv_alloc_D2A+0x50>
   140006a31:	48 85 ff             	test   %rdi,%rdi
   140006a34:	74 03                	je     140006a39 <__nrv_alloc_D2A+0x69>
   140006a36:	48 89 07             	mov    %rax,(%rdi)
   140006a39:	4c 89 c0             	mov    %r8,%rax
   140006a3c:	48 83 c4 20          	add    $0x20,%rsp
   140006a40:	5b                   	pop    %rbx
   140006a41:	5e                   	pop    %rsi
   140006a42:	5f                   	pop    %rdi
   140006a43:	c3                   	ret
   140006a44:	0f 1f 40 00          	nopl   0x0(%rax)
   140006a48:	31 db                	xor    %ebx,%ebx
   140006a4a:	eb b1                	jmp    1400069fd <__nrv_alloc_D2A+0x2d>
   140006a4c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000140006a50 <__freedtoa>:
   140006a50:	ba 01 00 00 00       	mov    $0x1,%edx
   140006a55:	48 89 c8             	mov    %rcx,%rax
   140006a58:	8b 49 fc             	mov    -0x4(%rcx),%ecx
   140006a5b:	d3 e2                	shl    %cl,%edx
   140006a5d:	66 0f 6e c1          	movd   %ecx,%xmm0
   140006a61:	48 8d 48 fc          	lea    -0x4(%rax),%rcx
   140006a65:	66 0f 6e ca          	movd   %edx,%xmm1
   140006a69:	66 0f 62 c1          	punpckldq %xmm1,%xmm0
   140006a6d:	66 0f d6 40 04       	movq   %xmm0,0x4(%rax)
   140006a72:	e9 69 1c 00 00       	jmp    1400086e0 <__Bfree_D2A>
   140006a77:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   140006a7e:	00 00 

0000000140006a80 <__quorem_D2A>:
   140006a80:	41 57                	push   %r15
   140006a82:	41 56                	push   %r14
   140006a84:	41 55                	push   %r13
   140006a86:	41 54                	push   %r12
   140006a88:	55                   	push   %rbp
   140006a89:	57                   	push   %rdi
   140006a8a:	56                   	push   %rsi
   140006a8b:	53                   	push   %rbx
   140006a8c:	48 83 ec 38          	sub    $0x38,%rsp
   140006a90:	31 c0                	xor    %eax,%eax
   140006a92:	8b 7a 14             	mov    0x14(%rdx),%edi
   140006a95:	39 79 14             	cmp    %edi,0x14(%rcx)
   140006a98:	49 89 cd             	mov    %rcx,%r13
   140006a9b:	49 89 d6             	mov    %rdx,%r14
   140006a9e:	0f 8c ee 00 00 00    	jl     140006b92 <__quorem_D2A+0x112>
   140006aa4:	48 8d 5a 18          	lea    0x18(%rdx),%rbx
   140006aa8:	83 ef 01             	sub    $0x1,%edi
   140006aab:	31 d2                	xor    %edx,%edx
   140006aad:	4c 8d 61 18          	lea    0x18(%rcx),%r12
   140006ab1:	4c 63 df             	movslq %edi,%r11
   140006ab4:	49 c1 e3 02          	shl    $0x2,%r11
   140006ab8:	4a 8d 2c 1b          	lea    (%rbx,%r11,1),%rbp
   140006abc:	4d 01 e3             	add    %r12,%r11
   140006abf:	45 8b 03             	mov    (%r11),%r8d
   140006ac2:	8b 45 00             	mov    0x0(%rbp),%eax
   140006ac5:	8d 48 01             	lea    0x1(%rax),%ecx
   140006ac8:	44 89 c0             	mov    %r8d,%eax
   140006acb:	f7 f1                	div    %ecx
   140006acd:	41 39 c8             	cmp    %ecx,%r8d
   140006ad0:	89 44 24 2c          	mov    %eax,0x2c(%rsp)
   140006ad4:	89 c6                	mov    %eax,%esi
   140006ad6:	72 5d                	jb     140006b35 <__quorem_D2A+0xb5>
   140006ad8:	41 89 c7             	mov    %eax,%r15d
   140006adb:	49 89 da             	mov    %rbx,%r10
   140006ade:	4d 89 e1             	mov    %r12,%r9
   140006ae1:	31 c0                	xor    %eax,%eax
   140006ae3:	45 31 c0             	xor    %r8d,%r8d
   140006ae6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   140006aed:	00 00 00 
   140006af0:	41 8b 12             	mov    (%r10),%edx
   140006af3:	49 83 c2 04          	add    $0x4,%r10
   140006af7:	49 83 c1 04          	add    $0x4,%r9
   140006afb:	41 8b 49 fc          	mov    -0x4(%r9),%ecx
   140006aff:	49 0f af d7          	imul   %r15,%rdx
   140006b03:	48 01 c2             	add    %rax,%rdx
   140006b06:	48 89 d0             	mov    %rdx,%rax
   140006b09:	89 d2                	mov    %edx,%edx
   140006b0b:	48 29 d1             	sub    %rdx,%rcx
   140006b0e:	48 c1 e8 20          	shr    $0x20,%rax
   140006b12:	4c 29 c1             	sub    %r8,%rcx
   140006b15:	49 89 c8             	mov    %rcx,%r8
   140006b18:	41 89 49 fc          	mov    %ecx,-0x4(%r9)
   140006b1c:	49 c1 e8 20          	shr    $0x20,%r8
   140006b20:	41 83 e0 01          	and    $0x1,%r8d
   140006b24:	4c 39 d5             	cmp    %r10,%rbp
   140006b27:	73 c7                	jae    140006af0 <__quorem_D2A+0x70>
   140006b29:	45 8b 0b             	mov    (%r11),%r9d
   140006b2c:	45 85 c9             	test   %r9d,%r9d
   140006b2f:	0f 84 a6 00 00 00    	je     140006bdb <__quorem_D2A+0x15b>
   140006b35:	4c 89 f2             	mov    %r14,%rdx
   140006b38:	4c 89 e9             	mov    %r13,%rcx
   140006b3b:	e8 90 21 00 00       	call   140008cd0 <__cmp_D2A>
   140006b40:	85 c0                	test   %eax,%eax
   140006b42:	78 4c                	js     140006b90 <__quorem_D2A+0x110>
   140006b44:	4c 89 e1             	mov    %r12,%rcx
   140006b47:	31 d2                	xor    %edx,%edx
   140006b49:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140006b50:	8b 01                	mov    (%rcx),%eax
   140006b52:	48 83 c3 04          	add    $0x4,%rbx
   140006b56:	48 83 c1 04          	add    $0x4,%rcx
   140006b5a:	44 8b 43 fc          	mov    -0x4(%rbx),%r8d
   140006b5e:	4c 29 c0             	sub    %r8,%rax
   140006b61:	48 29 d0             	sub    %rdx,%rax
   140006b64:	48 89 c2             	mov    %rax,%rdx
   140006b67:	89 41 fc             	mov    %eax,-0x4(%rcx)
   140006b6a:	48 c1 ea 20          	shr    $0x20,%rdx
   140006b6e:	83 e2 01             	and    $0x1,%edx
   140006b71:	48 39 dd             	cmp    %rbx,%rbp
   140006b74:	73 da                	jae    140006b50 <__quorem_D2A+0xd0>
   140006b76:	48 63 c7             	movslq %edi,%rax
   140006b79:	49 8d 04 84          	lea    (%r12,%rax,4),%rax
   140006b7d:	8b 08                	mov    (%rax),%ecx
   140006b7f:	85 c9                	test   %ecx,%ecx
   140006b81:	74 2e                	je     140006bb1 <__quorem_D2A+0x131>
   140006b83:	8b 74 24 2c          	mov    0x2c(%rsp),%esi
   140006b87:	83 c6 01             	add    $0x1,%esi
   140006b8a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140006b90:	89 f0                	mov    %esi,%eax
   140006b92:	48 83 c4 38          	add    $0x38,%rsp
   140006b96:	5b                   	pop    %rbx
   140006b97:	5e                   	pop    %rsi
   140006b98:	5f                   	pop    %rdi
   140006b99:	5d                   	pop    %rbp
   140006b9a:	41 5c                	pop    %r12
   140006b9c:	41 5d                	pop    %r13
   140006b9e:	41 5e                	pop    %r14
   140006ba0:	41 5f                	pop    %r15
   140006ba2:	c3                   	ret
   140006ba3:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140006ba8:	8b 10                	mov    (%rax),%edx
   140006baa:	85 d2                	test   %edx,%edx
   140006bac:	75 0c                	jne    140006bba <__quorem_D2A+0x13a>
   140006bae:	83 ef 01             	sub    $0x1,%edi
   140006bb1:	48 83 e8 04          	sub    $0x4,%rax
   140006bb5:	49 39 c4             	cmp    %rax,%r12
   140006bb8:	72 ee                	jb     140006ba8 <__quorem_D2A+0x128>
   140006bba:	8b 74 24 2c          	mov    0x2c(%rsp),%esi
   140006bbe:	41 89 7d 14          	mov    %edi,0x14(%r13)
   140006bc2:	83 c6 01             	add    $0x1,%esi
   140006bc5:	eb c9                	jmp    140006b90 <__quorem_D2A+0x110>
   140006bc7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   140006bce:	00 00 
   140006bd0:	45 8b 03             	mov    (%r11),%r8d
   140006bd3:	45 85 c0             	test   %r8d,%r8d
   140006bd6:	75 0c                	jne    140006be4 <__quorem_D2A+0x164>
   140006bd8:	83 ef 01             	sub    $0x1,%edi
   140006bdb:	49 83 eb 04          	sub    $0x4,%r11
   140006bdf:	4d 39 dc             	cmp    %r11,%r12
   140006be2:	72 ec                	jb     140006bd0 <__quorem_D2A+0x150>
   140006be4:	41 89 7d 14          	mov    %edi,0x14(%r13)
   140006be8:	4c 89 f2             	mov    %r14,%rdx
   140006beb:	4c 89 e9             	mov    %r13,%rcx
   140006bee:	e8 dd 20 00 00       	call   140008cd0 <__cmp_D2A>
   140006bf3:	85 c0                	test   %eax,%eax
   140006bf5:	0f 89 49 ff ff ff    	jns    140006b44 <__quorem_D2A+0xc4>
   140006bfb:	eb 93                	jmp    140006b90 <__quorem_D2A+0x110>
   140006bfd:	90                   	nop
   140006bfe:	90                   	nop
   140006bff:	90                   	nop

0000000140006c00 <__gdtoa>:
   140006c00:	41 57                	push   %r15
   140006c02:	41 56                	push   %r14
   140006c04:	41 55                	push   %r13
   140006c06:	41 54                	push   %r12
   140006c08:	55                   	push   %rbp
   140006c09:	57                   	push   %rdi
   140006c0a:	56                   	push   %rsi
   140006c0b:	53                   	push   %rbx
   140006c0c:	48 81 ec b8 00 00 00 	sub    $0xb8,%rsp
   140006c13:	48 8b 84 24 30 01 00 	mov    0x130(%rsp),%rax
   140006c1a:	00 
   140006c1b:	41 8b 39             	mov    (%r9),%edi
   140006c1e:	44 8b bc 24 20 01 00 	mov    0x120(%rsp),%r15d
   140006c25:	00 
   140006c26:	44 8b b4 24 28 01 00 	mov    0x128(%rsp),%r14d
   140006c2d:	00 
   140006c2e:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   140006c33:	48 8b 84 24 38 01 00 	mov    0x138(%rsp),%rax
   140006c3a:	00 
   140006c3b:	49 89 cc             	mov    %rcx,%r12
   140006c3e:	4c 89 cb             	mov    %r9,%rbx
   140006c41:	89 54 24 38          	mov    %edx,0x38(%rsp)
   140006c45:	4c 89 44 24 30       	mov    %r8,0x30(%rsp)
   140006c4a:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
   140006c4f:	89 f8                	mov    %edi,%eax
   140006c51:	83 e0 cf             	and    $0xffffffcf,%eax
   140006c54:	41 89 01             	mov    %eax,(%r9)
   140006c57:	89 f8                	mov    %edi,%eax
   140006c59:	83 e0 07             	and    $0x7,%eax
   140006c5c:	83 f8 03             	cmp    $0x3,%eax
   140006c5f:	0f 84 d3 02 00 00    	je     140006f38 <__gdtoa+0x338>
   140006c65:	89 fe                	mov    %edi,%esi
   140006c67:	83 e6 04             	and    $0x4,%esi
   140006c6a:	89 74 24 44          	mov    %esi,0x44(%rsp)
   140006c6e:	0f 85 3c 02 00 00    	jne    140006eb0 <__gdtoa+0x2b0>
   140006c74:	85 c0                	test   %eax,%eax
   140006c76:	0f 84 7c 02 00 00    	je     140006ef8 <__gdtoa+0x2f8>
   140006c7c:	8b 29                	mov    (%rcx),%ebp
   140006c7e:	31 c9                	xor    %ecx,%ecx
   140006c80:	b8 20 00 00 00       	mov    $0x20,%eax
   140006c85:	83 fd 20             	cmp    $0x20,%ebp
   140006c88:	7e 09                	jle    140006c93 <__gdtoa+0x93>
   140006c8a:	01 c0                	add    %eax,%eax
   140006c8c:	83 c1 01             	add    $0x1,%ecx
   140006c8f:	39 c5                	cmp    %eax,%ebp
   140006c91:	7f f7                	jg     140006c8a <__gdtoa+0x8a>
   140006c93:	e8 48 19 00 00       	call   1400085e0 <__Balloc_D2A>
   140006c98:	44 8d 45 ff          	lea    -0x1(%rbp),%r8d
   140006c9c:	48 89 c6             	mov    %rax,%rsi
   140006c9f:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
   140006ca4:	41 c1 f8 05          	sar    $0x5,%r8d
   140006ca8:	48 8d 56 18          	lea    0x18(%rsi),%rdx
   140006cac:	4d 63 c0             	movslq %r8d,%r8
   140006caf:	4a 8d 0c 80          	lea    (%rax,%r8,4),%rcx
   140006cb3:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140006cb8:	44 8b 08             	mov    (%rax),%r9d
   140006cbb:	48 83 c0 04          	add    $0x4,%rax
   140006cbf:	48 83 c2 04          	add    $0x4,%rdx
   140006cc3:	48 39 c1             	cmp    %rax,%rcx
   140006cc6:	44 89 4a fc          	mov    %r9d,-0x4(%rdx)
   140006cca:	73 ec                	jae    140006cb8 <__gdtoa+0xb8>
   140006ccc:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
   140006cd1:	48 83 c1 01          	add    $0x1,%rcx
   140006cd5:	4a 8d 04 85 04 00 00 	lea    0x4(,%r8,4),%rax
   140006cdc:	00 
   140006cdd:	48 83 c2 01          	add    $0x1,%rdx
   140006ce1:	48 39 d1             	cmp    %rdx,%rcx
   140006ce4:	ba 04 00 00 00       	mov    $0x4,%edx
   140006ce9:	48 0f 42 c2          	cmovb  %rdx,%rax
   140006ced:	48 c1 f8 02          	sar    $0x2,%rax
   140006cf1:	41 89 c5             	mov    %eax,%r13d
   140006cf4:	48 8d 04 86          	lea    (%rsi,%rax,4),%rax
   140006cf8:	eb 13                	jmp    140006d0d <__gdtoa+0x10d>
   140006cfa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140006d00:	48 83 e8 04          	sub    $0x4,%rax
   140006d04:	45 85 ed             	test   %r13d,%r13d
   140006d07:	0f 84 53 02 00 00    	je     140006f60 <__gdtoa+0x360>
   140006d0d:	8b 48 14             	mov    0x14(%rax),%ecx
   140006d10:	44 89 ea             	mov    %r13d,%edx
   140006d13:	41 83 ed 01          	sub    $0x1,%r13d
   140006d17:	85 c9                	test   %ecx,%ecx
   140006d19:	74 e5                	je     140006d00 <__gdtoa+0x100>
   140006d1b:	4d 63 ed             	movslq %r13d,%r13
   140006d1e:	89 56 14             	mov    %edx,0x14(%rsi)
   140006d21:	c1 e2 05             	shl    $0x5,%edx
   140006d24:	42 0f bd 44 ae 18    	bsr    0x18(%rsi,%r13,4),%eax
   140006d2a:	83 f0 1f             	xor    $0x1f,%eax
   140006d2d:	29 c2                	sub    %eax,%edx
   140006d2f:	41 89 d5             	mov    %edx,%r13d
   140006d32:	48 89 f1             	mov    %rsi,%rcx
   140006d35:	e8 36 17 00 00       	call   140008470 <__trailz_D2A>
   140006d3a:	8b 4c 24 38          	mov    0x38(%rsp),%ecx
   140006d3e:	85 c0                	test   %eax,%eax
   140006d40:	89 84 24 ac 00 00 00 	mov    %eax,0xac(%rsp)
   140006d47:	89 4c 24 50          	mov    %ecx,0x50(%rsp)
   140006d4b:	0f 85 1f 02 00 00    	jne    140006f70 <__gdtoa+0x370>
   140006d51:	8b 46 14             	mov    0x14(%rsi),%eax
   140006d54:	85 c0                	test   %eax,%eax
   140006d56:	0f 84 94 01 00 00    	je     140006ef0 <__gdtoa+0x2f0>
   140006d5c:	48 8d 94 24 ac 00 00 	lea    0xac(%rsp),%rdx
   140006d63:	00 
   140006d64:	48 89 f1             	mov    %rsi,%rcx
   140006d67:	e8 94 21 00 00       	call   140008f00 <__b2d_D2A>
   140006d6c:	8b 44 24 50          	mov    0x50(%rsp),%eax
   140006d70:	66 0f ef c9          	pxor   %xmm1,%xmm1
   140006d74:	66 49 0f 7e c2       	movq   %xmm0,%r10
   140006d79:	4c 89 d2             	mov    %r10,%rdx
   140006d7c:	48 c1 ea 20          	shr    $0x20,%rdx
   140006d80:	46 8d 04 28          	lea    (%rax,%r13,1),%r8d
   140006d84:	81 e2 ff ff 0f 00    	and    $0xfffff,%edx
   140006d8a:	44 89 d0             	mov    %r10d,%eax
   140006d8d:	41 8d 48 ff          	lea    -0x1(%r8),%ecx
   140006d91:	81 ca 00 00 f0 3f    	or     $0x3ff00000,%edx
   140006d97:	f2 0f 2a c9          	cvtsi2sd %ecx,%xmm1
   140006d9b:	49 89 d1             	mov    %rdx,%r9
   140006d9e:	f2 0f 59 0d 82 48 00 	mulsd  0x4882(%rip),%xmm1        # 14000b628 <.rdata+0x28>
   140006da5:	00 
   140006da6:	49 c1 e1 20          	shl    $0x20,%r9
   140006daa:	4c 09 c8             	or     %r9,%rax
   140006dad:	41 b9 01 00 00 00    	mov    $0x1,%r9d
   140006db3:	45 29 c1             	sub    %r8d,%r9d
   140006db6:	85 c9                	test   %ecx,%ecx
   140006db8:	66 48 0f 6e c0       	movq   %rax,%xmm0
   140006dbd:	44 0f 49 c9          	cmovns %ecx,%r9d
   140006dc1:	f2 0f 5c 05 47 48 00 	subsd  0x4847(%rip),%xmm0        # 14000b610 <.rdata+0x10>
   140006dc8:	00 
   140006dc9:	f2 0f 59 05 47 48 00 	mulsd  0x4847(%rip),%xmm0        # 14000b618 <.rdata+0x18>
   140006dd0:	00 
   140006dd1:	41 81 e9 35 04 00 00 	sub    $0x435,%r9d
   140006dd8:	f2 0f 58 05 40 48 00 	addsd  0x4840(%rip),%xmm0        # 14000b620 <.rdata+0x20>
   140006ddf:	00 
   140006de0:	45 85 c9             	test   %r9d,%r9d
   140006de3:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
   140006de7:	7e 15                	jle    140006dfe <__gdtoa+0x1fe>
   140006de9:	66 0f ef c9          	pxor   %xmm1,%xmm1
   140006ded:	f2 41 0f 2a c9       	cvtsi2sd %r9d,%xmm1
   140006df2:	f2 0f 59 0d 36 48 00 	mulsd  0x4836(%rip),%xmm1        # 14000b630 <.rdata+0x30>
   140006df9:	00 
   140006dfa:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
   140006dfe:	f2 44 0f 2c d0       	cvttsd2si %xmm0,%r10d
   140006e03:	66 0f ef c9          	pxor   %xmm1,%xmm1
   140006e07:	66 0f 2f c8          	comisd %xmm0,%xmm1
   140006e0b:	44 89 54 24 4c       	mov    %r10d,0x4c(%rsp)
   140006e10:	0f 87 ea 04 00 00    	ja     140007300 <__gdtoa+0x700>
   140006e16:	41 89 c9             	mov    %ecx,%r9d
   140006e19:	89 c0                	mov    %eax,%eax
   140006e1b:	41 c1 e1 14          	shl    $0x14,%r9d
   140006e1f:	44 01 ca             	add    %r9d,%edx
   140006e22:	89 d2                	mov    %edx,%edx
   140006e24:	48 c1 e2 20          	shl    $0x20,%rdx
   140006e28:	48 09 d0             	or     %rdx,%rax
   140006e2b:	48 63 54 24 4c       	movslq 0x4c(%rsp),%rdx
   140006e30:	49 89 c3             	mov    %rax,%r11
   140006e33:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
   140006e3a:	00 
   140006e3b:	49 89 c2             	mov    %rax,%r10
   140006e3e:	44 89 e8             	mov    %r13d,%eax
   140006e41:	29 c8                	sub    %ecx,%eax
   140006e43:	44 8d 48 ff          	lea    -0x1(%rax),%r9d
   140006e47:	83 fa 16             	cmp    $0x16,%edx
   140006e4a:	0f 87 48 01 00 00    	ja     140006f98 <__gdtoa+0x398>
   140006e50:	48 8b 0d d9 4a 00 00 	mov    0x4ad9(%rip),%rcx        # 14000b930 <.refptr.__tens_D2A>
   140006e57:	66 49 0f 6e eb       	movq   %r11,%xmm5
   140006e5c:	f2 0f 10 04 d1       	movsd  (%rcx,%rdx,8),%xmm0
   140006e61:	66 0f 2f c5          	comisd %xmm5,%xmm0
   140006e65:	0f 87 25 05 00 00    	ja     140007390 <__gdtoa+0x790>
   140006e6b:	85 c0                	test   %eax,%eax
   140006e6d:	c7 44 24 60 00 00 00 	movl   $0x0,0x60(%rsp)
   140006e74:	00 
   140006e75:	c7 84 24 80 00 00 00 	movl   $0x0,0x80(%rsp)
   140006e7c:	00 00 00 00 
   140006e80:	7f 0e                	jg     140006e90 <__gdtoa+0x290>
   140006e82:	ba 01 00 00 00       	mov    $0x1,%edx
   140006e87:	45 31 c9             	xor    %r9d,%r9d
   140006e8a:	29 c2                	sub    %eax,%edx
   140006e8c:	89 54 24 60          	mov    %edx,0x60(%rsp)
   140006e90:	8b 44 24 4c          	mov    0x4c(%rsp),%eax
   140006e94:	c7 44 24 7c 00 00 00 	movl   $0x0,0x7c(%rsp)
   140006e9b:	00 
   140006e9c:	41 01 c1             	add    %eax,%r9d
   140006e9f:	89 44 24 68          	mov    %eax,0x68(%rsp)
   140006ea3:	e9 40 01 00 00       	jmp    140006fe8 <__gdtoa+0x3e8>
   140006ea8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   140006eaf:	00 
   140006eb0:	45 31 e4             	xor    %r12d,%r12d
   140006eb3:	83 f8 04             	cmp    $0x4,%eax
   140006eb6:	75 65                	jne    140006f1d <__gdtoa+0x31d>
   140006eb8:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
   140006ebd:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   140006ec3:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
   140006ec8:	48 8d 0d 3a 47 00 00 	lea    0x473a(%rip),%rcx        # 14000b609 <.rdata+0x9>
   140006ecf:	c7 00 00 80 ff ff    	movl   $0xffff8000,(%rax)
   140006ed5:	48 81 c4 b8 00 00 00 	add    $0xb8,%rsp
   140006edc:	5b                   	pop    %rbx
   140006edd:	5e                   	pop    %rsi
   140006ede:	5f                   	pop    %rdi
   140006edf:	5d                   	pop    %rbp
   140006ee0:	41 5c                	pop    %r12
   140006ee2:	41 5d                	pop    %r13
   140006ee4:	41 5e                	pop    %r14
   140006ee6:	41 5f                	pop    %r15
   140006ee8:	e9 e3 fa ff ff       	jmp    1400069d0 <__nrv_alloc_D2A>
   140006eed:	0f 1f 00             	nopl   (%rax)
   140006ef0:	48 89 f1             	mov    %rsi,%rcx
   140006ef3:	e8 e8 17 00 00       	call   1400086e0 <__Bfree_D2A>
   140006ef8:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
   140006efd:	41 b8 01 00 00 00    	mov    $0x1,%r8d
   140006f03:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
   140006f08:	48 8d 0d fe 46 00 00 	lea    0x46fe(%rip),%rcx        # 14000b60d <.rdata+0xd>
   140006f0f:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   140006f15:	e8 b6 fa ff ff       	call   1400069d0 <__nrv_alloc_D2A>
   140006f1a:	49 89 c4             	mov    %rax,%r12
   140006f1d:	4c 89 e0             	mov    %r12,%rax
   140006f20:	48 81 c4 b8 00 00 00 	add    $0xb8,%rsp
   140006f27:	5b                   	pop    %rbx
   140006f28:	5e                   	pop    %rsi
   140006f29:	5f                   	pop    %rdi
   140006f2a:	5d                   	pop    %rbp
   140006f2b:	41 5c                	pop    %r12
   140006f2d:	41 5d                	pop    %r13
   140006f2f:	41 5e                	pop    %r14
   140006f31:	41 5f                	pop    %r15
   140006f33:	c3                   	ret
   140006f34:	0f 1f 40 00          	nopl   0x0(%rax)
   140006f38:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
   140006f3d:	41 b8 08 00 00 00    	mov    $0x8,%r8d
   140006f43:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
   140006f48:	48 8d 0d b1 46 00 00 	lea    0x46b1(%rip),%rcx        # 14000b600 <.rdata>
   140006f4f:	c7 00 00 80 ff ff    	movl   $0xffff8000,(%rax)
   140006f55:	e9 7b ff ff ff       	jmp    140006ed5 <__gdtoa+0x2d5>
   140006f5a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140006f60:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%rsi)
   140006f67:	e9 c6 fd ff ff       	jmp    140006d32 <__gdtoa+0x132>
   140006f6c:	0f 1f 40 00          	nopl   0x0(%rax)
   140006f70:	89 c2                	mov    %eax,%edx
   140006f72:	48 89 f1             	mov    %rsi,%rcx
   140006f75:	e8 f6 13 00 00       	call   140008370 <__rshift_D2A>
   140006f7a:	8b 84 24 ac 00 00 00 	mov    0xac(%rsp),%eax
   140006f81:	8b 4c 24 38          	mov    0x38(%rsp),%ecx
   140006f85:	41 29 c5             	sub    %eax,%r13d
   140006f88:	8d 14 08             	lea    (%rax,%rcx,1),%edx
   140006f8b:	89 54 24 50          	mov    %edx,0x50(%rsp)
   140006f8f:	e9 bd fd ff ff       	jmp    140006d51 <__gdtoa+0x151>
   140006f94:	0f 1f 40 00          	nopl   0x0(%rax)
   140006f98:	c7 84 24 80 00 00 00 	movl   $0x1,0x80(%rsp)
   140006f9f:	01 00 00 00 
   140006fa3:	45 85 c9             	test   %r9d,%r9d
   140006fa6:	c7 44 24 60 00 00 00 	movl   $0x0,0x60(%rsp)
   140006fad:	00 
   140006fae:	79 0e                	jns    140006fbe <__gdtoa+0x3be>
   140006fb0:	ba 01 00 00 00       	mov    $0x1,%edx
   140006fb5:	45 31 c9             	xor    %r9d,%r9d
   140006fb8:	29 c2                	sub    %eax,%edx
   140006fba:	89 54 24 60          	mov    %edx,0x60(%rsp)
   140006fbe:	44 8b 5c 24 4c       	mov    0x4c(%rsp),%r11d
   140006fc3:	45 85 db             	test   %r11d,%r11d
   140006fc6:	0f 89 c4 fe ff ff    	jns    140006e90 <__gdtoa+0x290>
   140006fcc:	8b 44 24 4c          	mov    0x4c(%rsp),%eax
   140006fd0:	c7 44 24 4c 00 00 00 	movl   $0x0,0x4c(%rsp)
   140006fd7:	00 
   140006fd8:	29 44 24 60          	sub    %eax,0x60(%rsp)
   140006fdc:	89 c1                	mov    %eax,%ecx
   140006fde:	89 44 24 68          	mov    %eax,0x68(%rsp)
   140006fe2:	f7 d9                	neg    %ecx
   140006fe4:	89 4c 24 7c          	mov    %ecx,0x7c(%rsp)
   140006fe8:	41 83 ff 09          	cmp    $0x9,%r15d
   140006fec:	0f 87 7e 02 00 00    	ja     140007270 <__gdtoa+0x670>
   140006ff2:	41 83 ff 05          	cmp    $0x5,%r15d
   140006ff6:	0f 8f 24 03 00 00    	jg     140007320 <__gdtoa+0x720>
   140006ffc:	41 81 c0 fd 03 00 00 	add    $0x3fd,%r8d
   140007003:	31 c0                	xor    %eax,%eax
   140007005:	41 81 f8 f7 07 00 00 	cmp    $0x7f7,%r8d
   14000700c:	0f 96 c0             	setbe  %al
   14000700f:	41 83 ff 04          	cmp    $0x4,%r15d
   140007013:	89 84 24 98 00 00 00 	mov    %eax,0x98(%rsp)
   14000701a:	0f 84 1c 0d 00 00    	je     140007d3c <__gdtoa+0x113c>
   140007020:	41 83 ff 05          	cmp    $0x5,%r15d
   140007024:	0f 84 8e 0b 00 00    	je     140007bb8 <__gdtoa+0xfb8>
   14000702a:	41 83 ff 02          	cmp    $0x2,%r15d
   14000702e:	0f 85 cc 06 00 00    	jne    140007700 <__gdtoa+0xb00>
   140007034:	c7 44 24 70 00 00 00 	movl   $0x0,0x70(%rsp)
   14000703b:	00 
   14000703c:	45 85 f6             	test   %r14d,%r14d
   14000703f:	b9 01 00 00 00       	mov    $0x1,%ecx
   140007044:	41 0f 4f ce          	cmovg  %r14d,%ecx
   140007048:	89 c8                	mov    %ecx,%eax
   14000704a:	89 8c 24 9c 00 00 00 	mov    %ecx,0x9c(%rsp)
   140007051:	41 89 ce             	mov    %ecx,%r14d
   140007054:	89 4c 24 48          	mov    %ecx,0x48(%rsp)
   140007058:	4c 89 94 24 88 00 00 	mov    %r10,0x88(%rsp)
   14000705f:	00 
   140007060:	44 89 8c 24 84 00 00 	mov    %r9d,0x84(%rsp)
   140007067:	00 
   140007068:	89 84 24 ac 00 00 00 	mov    %eax,0xac(%rsp)
   14000706f:	e8 1c f9 ff ff       	call   140006990 <__rv_alloc_D2A>
   140007074:	44 8b 8c 24 84 00 00 	mov    0x84(%rsp),%r9d
   14000707b:	00 
   14000707c:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
   140007081:	41 8b 44 24 0c       	mov    0xc(%r12),%eax
   140007086:	4c 8b 94 24 88 00 00 	mov    0x88(%rsp),%r10
   14000708d:	00 
   14000708e:	83 e8 01             	sub    $0x1,%eax
   140007091:	89 44 24 78          	mov    %eax,0x78(%rsp)
   140007095:	74 28                	je     1400070bf <__gdtoa+0x4bf>
   140007097:	8b 4c 24 78          	mov    0x78(%rsp),%ecx
   14000709b:	b8 02 00 00 00       	mov    $0x2,%eax
   1400070a0:	85 c9                	test   %ecx,%ecx
   1400070a2:	0f 49 c1             	cmovns %ecx,%eax
   1400070a5:	83 e7 08             	and    $0x8,%edi
   1400070a8:	89 c1                	mov    %eax,%ecx
   1400070aa:	89 44 24 78          	mov    %eax,0x78(%rsp)
   1400070ae:	0f 84 3c 04 00 00    	je     1400074f0 <__gdtoa+0x8f0>
   1400070b4:	b8 03 00 00 00       	mov    $0x3,%eax
   1400070b9:	29 c8                	sub    %ecx,%eax
   1400070bb:	89 44 24 78          	mov    %eax,0x78(%rsp)
   1400070bf:	8b 44 24 48          	mov    0x48(%rsp),%eax
   1400070c3:	83 f8 0e             	cmp    $0xe,%eax
   1400070c6:	41 0f 96 c0          	setbe  %r8b
   1400070ca:	44 22 84 24 98 00 00 	and    0x98(%rsp),%r8b
   1400070d1:	00 
   1400070d2:	0f 84 18 04 00 00    	je     1400074f0 <__gdtoa+0x8f0>
   1400070d8:	8b 7c 24 68          	mov    0x68(%rsp),%edi
   1400070dc:	0b 7c 24 78          	or     0x78(%rsp),%edi
   1400070e0:	0f 85 0a 04 00 00    	jne    1400074f0 <__gdtoa+0x8f0>
   1400070e6:	8b 8c 24 80 00 00 00 	mov    0x80(%rsp),%ecx
   1400070ed:	c7 84 24 ac 00 00 00 	movl   $0x0,0xac(%rsp)
   1400070f4:	00 00 00 00 
   1400070f8:	f2 0f 10 84 24 90 00 	movsd  0x90(%rsp),%xmm0
   1400070ff:	00 00 
   140007101:	85 c9                	test   %ecx,%ecx
   140007103:	74 12                	je     140007117 <__gdtoa+0x517>
   140007105:	f2 0f 10 25 33 45 00 	movsd  0x4533(%rip),%xmm4        # 14000b640 <.rdata+0x40>
   14000710c:	00 
   14000710d:	66 0f 2f e0          	comisd %xmm0,%xmm4
   140007111:	0f 87 74 0e 00 00    	ja     140007f8b <__gdtoa+0x138b>
   140007117:	66 0f 28 c8          	movapd %xmm0,%xmm1
   14000711b:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
   14000711f:	f2 0f 58 0d 31 45 00 	addsd  0x4531(%rip),%xmm1        # 14000b658 <.rdata+0x58>
   140007126:	00 
   140007127:	66 48 0f 7e c8       	movq   %xmm1,%rax
   14000712c:	48 89 c2             	mov    %rax,%rdx
   14000712f:	89 c0                	mov    %eax,%eax
   140007131:	48 c1 ea 20          	shr    $0x20,%rdx
   140007135:	81 ea 00 00 40 03    	sub    $0x3400000,%edx
   14000713b:	48 c1 e2 20          	shl    $0x20,%rdx
   14000713f:	48 09 d0             	or     %rdx,%rax
   140007142:	8b 54 24 48          	mov    0x48(%rsp),%edx
   140007146:	85 d2                	test   %edx,%edx
   140007148:	0f 84 6e 03 00 00    	je     1400074bc <__gdtoa+0x8bc>
   14000714e:	44 8b 5c 24 48       	mov    0x48(%rsp),%r11d
   140007153:	31 ff                	xor    %edi,%edi
   140007155:	48 8b 0d d4 47 00 00 	mov    0x47d4(%rip),%rcx        # 14000b930 <.refptr.__tens_D2A>
   14000715c:	66 48 0f 6e d0       	movq   %rax,%xmm2
   140007161:	41 8d 43 ff          	lea    -0x1(%r11),%eax
   140007165:	48 98                	cltq
   140007167:	f2 0f 10 1c c1       	movsd  (%rcx,%rax,8),%xmm3
   14000716c:	8b 44 24 70          	mov    0x70(%rsp),%eax
   140007170:	85 c0                	test   %eax,%eax
   140007172:	0f 84 be 05 00 00    	je     140007736 <__gdtoa+0xb36>
   140007178:	f2 0f 2c d0          	cvttsd2si %xmm0,%edx
   14000717c:	f2 0f 10 0d fc 44 00 	movsd  0x44fc(%rip),%xmm1        # 14000b680 <.rdata+0x80>
   140007183:	00 
   140007184:	48 8b 4c 24 58       	mov    0x58(%rsp),%rcx
   140007189:	f2 0f 5e cb          	divsd  %xmm3,%xmm1
   14000718d:	48 8d 41 01          	lea    0x1(%rcx),%rax
   140007191:	f2 0f 5c ca          	subsd  %xmm2,%xmm1
   140007195:	66 0f ef d2          	pxor   %xmm2,%xmm2
   140007199:	f2 0f 2a d2          	cvtsi2sd %edx,%xmm2
   14000719d:	83 c2 30             	add    $0x30,%edx
   1400071a0:	88 11                	mov    %dl,(%rcx)
   1400071a2:	f2 0f 5c c2          	subsd  %xmm2,%xmm0
   1400071a6:	66 0f 2f c8          	comisd %xmm0,%xmm1
   1400071aa:	0f 87 ee 0f 00 00    	ja     14000819e <__gdtoa+0x159e>
   1400071b0:	f2 0f 10 25 88 44 00 	movsd  0x4488(%rip),%xmm4        # 14000b640 <.rdata+0x40>
   1400071b7:	00 
   1400071b8:	f2 0f 10 1d 88 44 00 	movsd  0x4488(%rip),%xmm3        # 14000b648 <.rdata+0x48>
   1400071bf:	00 
   1400071c0:	eb 4c                	jmp    14000720e <__gdtoa+0x60e>
   1400071c2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   1400071c8:	8b 94 24 ac 00 00 00 	mov    0xac(%rsp),%edx
   1400071cf:	83 c2 01             	add    $0x1,%edx
   1400071d2:	44 39 da             	cmp    %r11d,%edx
   1400071d5:	89 94 24 ac 00 00 00 	mov    %edx,0xac(%rsp)
   1400071dc:	0f 8d 03 03 00 00    	jge    1400074e5 <__gdtoa+0x8e5>
   1400071e2:	f2 0f 59 c3          	mulsd  %xmm3,%xmm0
   1400071e6:	66 0f ef d2          	pxor   %xmm2,%xmm2
   1400071ea:	48 83 c0 01          	add    $0x1,%rax
   1400071ee:	f2 0f 59 cb          	mulsd  %xmm3,%xmm1
   1400071f2:	f2 0f 2c d0          	cvttsd2si %xmm0,%edx
   1400071f6:	f2 0f 2a d2          	cvtsi2sd %edx,%xmm2
   1400071fa:	83 c2 30             	add    $0x30,%edx
   1400071fd:	88 50 ff             	mov    %dl,-0x1(%rax)
   140007200:	f2 0f 5c c2          	subsd  %xmm2,%xmm0
   140007204:	66 0f 2f c8          	comisd %xmm0,%xmm1
   140007208:	0f 87 90 0f 00 00    	ja     14000819e <__gdtoa+0x159e>
   14000720e:	66 0f 28 d4          	movapd %xmm4,%xmm2
   140007212:	f2 0f 5c d0          	subsd  %xmm0,%xmm2
   140007216:	66 0f 2f ca          	comisd %xmm2,%xmm1
   14000721a:	76 ac                	jbe    1400071c8 <__gdtoa+0x5c8>
   14000721c:	0f b6 50 ff          	movzbl -0x1(%rax),%edx
   140007220:	48 89 c1             	mov    %rax,%rcx
   140007223:	4c 8b 64 24 58       	mov    0x58(%rsp),%r12
   140007228:	eb 16                	jmp    140007240 <__gdtoa+0x640>
   14000722a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140007230:	49 39 c4             	cmp    %rax,%r12
   140007233:	0f 84 51 0e 00 00    	je     14000808a <__gdtoa+0x148a>
   140007239:	0f b6 50 ff          	movzbl -0x1(%rax),%edx
   14000723d:	48 89 c1             	mov    %rax,%rcx
   140007240:	48 8d 41 ff          	lea    -0x1(%rcx),%rax
   140007244:	80 fa 39             	cmp    $0x39,%dl
   140007247:	74 e7                	je     140007230 <__gdtoa+0x630>
   140007249:	48 89 4c 24 58       	mov    %rcx,0x58(%rsp)
   14000724e:	83 c2 01             	add    $0x1,%edx
   140007251:	88 10                	mov    %dl,(%rax)
   140007253:	8d 47 01             	lea    0x1(%rdi),%eax
   140007256:	89 44 24 50          	mov    %eax,0x50(%rsp)
   14000725a:	c7 44 24 44 20 00 00 	movl   $0x20,0x44(%rsp)
   140007261:	00 
   140007262:	e9 f7 01 00 00       	jmp    14000745e <__gdtoa+0x85e>
   140007267:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   14000726e:	00 00 
   140007270:	41 81 c0 fd 03 00 00 	add    $0x3fd,%r8d
   140007277:	31 c0                	xor    %eax,%eax
   140007279:	41 81 f8 f7 07 00 00 	cmp    $0x7f7,%r8d
   140007280:	0f 96 c0             	setbe  %al
   140007283:	45 31 ff             	xor    %r15d,%r15d
   140007286:	89 84 24 98 00 00 00 	mov    %eax,0x98(%rsp)
   14000728d:	66 0f ef c0          	pxor   %xmm0,%xmm0
   140007291:	f2 0f 2a c5          	cvtsi2sd %ebp,%xmm0
   140007295:	4c 89 54 24 70       	mov    %r10,0x70(%rsp)
   14000729a:	f2 0f 59 05 96 43 00 	mulsd  0x4396(%rip),%xmm0        # 14000b638 <.rdata+0x38>
   1400072a1:	00 
   1400072a2:	44 89 4c 24 48       	mov    %r9d,0x48(%rsp)
   1400072a7:	f2 0f 2c c8          	cvttsd2si %xmm0,%ecx
   1400072ab:	83 c1 03             	add    $0x3,%ecx
   1400072ae:	89 8c 24 ac 00 00 00 	mov    %ecx,0xac(%rsp)
   1400072b5:	e8 d6 f6 ff ff       	call   140006990 <__rv_alloc_D2A>
   1400072ba:	44 8b 4c 24 48       	mov    0x48(%rsp),%r9d
   1400072bf:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
   1400072c4:	41 8b 44 24 0c       	mov    0xc(%r12),%eax
   1400072c9:	4c 8b 54 24 70       	mov    0x70(%rsp),%r10
   1400072ce:	83 e8 01             	sub    $0x1,%eax
   1400072d1:	89 44 24 78          	mov    %eax,0x78(%rsp)
   1400072d5:	0f 84 ca 00 00 00    	je     1400073a5 <__gdtoa+0x7a5>
   1400072db:	45 31 f6             	xor    %r14d,%r14d
   1400072de:	c7 44 24 70 01 00 00 	movl   $0x1,0x70(%rsp)
   1400072e5:	00 
   1400072e6:	c7 84 24 9c 00 00 00 	movl   $0xffffffff,0x9c(%rsp)
   1400072ed:	ff ff ff ff 
   1400072f1:	c7 44 24 48 ff ff ff 	movl   $0xffffffff,0x48(%rsp)
   1400072f8:	ff 
   1400072f9:	e9 99 fd ff ff       	jmp    140007097 <__gdtoa+0x497>
   1400072fe:	66 90                	xchg   %ax,%ax
   140007300:	66 0f ef c9          	pxor   %xmm1,%xmm1
   140007304:	f2 41 0f 2a ca       	cvtsi2sd %r10d,%xmm1
   140007309:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
   14000730d:	7a 06                	jp     140007315 <__gdtoa+0x715>
   14000730f:	0f 84 01 fb ff ff    	je     140006e16 <__gdtoa+0x216>
   140007315:	83 6c 24 4c 01       	subl   $0x1,0x4c(%rsp)
   14000731a:	e9 f7 fa ff ff       	jmp    140006e16 <__gdtoa+0x216>
   14000731f:	90                   	nop
   140007320:	c7 84 24 98 00 00 00 	movl   $0x0,0x98(%rsp)
   140007327:	00 00 00 00 
   14000732b:	41 83 ef 04          	sub    $0x4,%r15d
   14000732f:	41 83 ff 04          	cmp    $0x4,%r15d
   140007333:	0f 84 03 0a 00 00    	je     140007d3c <__gdtoa+0x113c>
   140007339:	41 83 ff 05          	cmp    $0x5,%r15d
   14000733d:	0f 84 75 08 00 00    	je     140007bb8 <__gdtoa+0xfb8>
   140007343:	41 83 ff 02          	cmp    $0x2,%r15d
   140007347:	c7 44 24 70 00 00 00 	movl   $0x0,0x70(%rsp)
   14000734e:	00 
   14000734f:	0f 84 e7 fc ff ff    	je     14000703c <__gdtoa+0x43c>
   140007355:	41 bf 03 00 00 00    	mov    $0x3,%r15d
   14000735b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140007360:	8b 44 24 68          	mov    0x68(%rsp),%eax
   140007364:	44 01 f0             	add    %r14d,%eax
   140007367:	8d 48 01             	lea    0x1(%rax),%ecx
   14000736a:	89 84 24 9c 00 00 00 	mov    %eax,0x9c(%rsp)
   140007371:	b8 01 00 00 00       	mov    $0x1,%eax
   140007376:	85 c9                	test   %ecx,%ecx
   140007378:	89 4c 24 48          	mov    %ecx,0x48(%rsp)
   14000737c:	0f 4f c1             	cmovg  %ecx,%eax
   14000737f:	89 c1                	mov    %eax,%ecx
   140007381:	e9 d2 fc ff ff       	jmp    140007058 <__gdtoa+0x458>
   140007386:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   14000738d:	00 00 00 
   140007390:	83 6c 24 4c 01       	subl   $0x1,0x4c(%rsp)
   140007395:	c7 84 24 80 00 00 00 	movl   $0x0,0x80(%rsp)
   14000739c:	00 00 00 00 
   1400073a0:	e9 fe fb ff ff       	jmp    140006fa3 <__gdtoa+0x3a3>
   1400073a5:	8b 44 24 50          	mov    0x50(%rsp),%eax
   1400073a9:	45 31 f6             	xor    %r14d,%r14d
   1400073ac:	c7 44 24 48 ff ff ff 	movl   $0xffffffff,0x48(%rsp)
   1400073b3:	ff 
   1400073b4:	85 c0                	test   %eax,%eax
   1400073b6:	0f 88 6b 0d 00 00    	js     140008127 <__gdtoa+0x1527>
   1400073bc:	c7 44 24 70 01 00 00 	movl   $0x1,0x70(%rsp)
   1400073c3:	00 
   1400073c4:	c7 84 24 9c 00 00 00 	movl   $0xffffffff,0x9c(%rsp)
   1400073cb:	ff ff ff ff 
   1400073cf:	90                   	nop
   1400073d0:	8b 44 24 68          	mov    0x68(%rsp),%eax
   1400073d4:	41 3b 44 24 14       	cmp    0x14(%r12),%eax
   1400073d9:	0f 8f 1f 01 00 00    	jg     1400074fe <__gdtoa+0x8fe>
   1400073df:	48 8b 0d 4a 45 00 00 	mov    0x454a(%rip),%rcx        # 14000b930 <.refptr.__tens_D2A>
   1400073e6:	48 63 44 24 68       	movslq 0x68(%rsp),%rax
   1400073eb:	45 85 f6             	test   %r14d,%r14d
   1400073ee:	f2 0f 10 14 c1       	movsd  (%rcx,%rax,8),%xmm2
   1400073f3:	48 89 c7             	mov    %rax,%rdi
   1400073f6:	0f 89 4e 08 00 00    	jns    140007c4a <__gdtoa+0x104a>
   1400073fc:	8b 44 24 48          	mov    0x48(%rsp),%eax
   140007400:	85 c0                	test   %eax,%eax
   140007402:	0f 8f 42 08 00 00    	jg     140007c4a <__gdtoa+0x104a>
   140007408:	0f 85 09 03 00 00    	jne    140007717 <__gdtoa+0xb17>
   14000740e:	f2 0f 59 15 4a 42 00 	mulsd  0x424a(%rip),%xmm2        # 14000b660 <.rdata+0x60>
   140007415:	00 
   140007416:	66 0f 2f 94 24 90 00 	comisd 0x90(%rsp),%xmm2
   14000741d:	00 00 
   14000741f:	0f 83 f2 02 00 00    	jae    140007717 <__gdtoa+0xb17>
   140007425:	4c 8b 64 24 58       	mov    0x58(%rsp),%r12
   14000742a:	83 c7 02             	add    $0x2,%edi
   14000742d:	45 31 db             	xor    %r11d,%r11d
   140007430:	89 7c 24 50          	mov    %edi,0x50(%rsp)
   140007434:	31 ff                	xor    %edi,%edi
   140007436:	48 83 44 24 58 01    	addq   $0x1,0x58(%rsp)
   14000743c:	41 c6 04 24 31       	movb   $0x31,(%r12)
   140007441:	c7 44 24 44 20 00 00 	movl   $0x20,0x44(%rsp)
   140007448:	00 
   140007449:	4c 89 d9             	mov    %r11,%rcx
   14000744c:	e8 8f 12 00 00       	call   1400086e0 <__Bfree_D2A>
   140007451:	48 85 ff             	test   %rdi,%rdi
   140007454:	74 08                	je     14000745e <__gdtoa+0x85e>
   140007456:	48 89 f9             	mov    %rdi,%rcx
   140007459:	e8 82 12 00 00       	call   1400086e0 <__Bfree_D2A>
   14000745e:	48 89 f1             	mov    %rsi,%rcx
   140007461:	e8 7a 12 00 00       	call   1400086e0 <__Bfree_D2A>
   140007466:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
   14000746b:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
   140007470:	8b 7c 24 50          	mov    0x50(%rsp),%edi
   140007474:	c6 00 00             	movb   $0x0,(%rax)
   140007477:	89 3e                	mov    %edi,(%rsi)
   140007479:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
   14000747e:	48 85 f6             	test   %rsi,%rsi
   140007481:	74 03                	je     140007486 <__gdtoa+0x886>
   140007483:	48 89 06             	mov    %rax,(%rsi)
   140007486:	8b 44 24 44          	mov    0x44(%rsp),%eax
   14000748a:	09 03                	or     %eax,(%rbx)
   14000748c:	e9 8c fa ff ff       	jmp    140006f1d <__gdtoa+0x31d>
   140007491:	66 0f 28 c8          	movapd %xmm0,%xmm1
   140007495:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
   140007499:	f2 0f 58 0d b7 41 00 	addsd  0x41b7(%rip),%xmm1        # 14000b658 <.rdata+0x58>
   1400074a0:	00 
   1400074a1:	66 48 0f 7e c8       	movq   %xmm1,%rax
   1400074a6:	48 89 c2             	mov    %rax,%rdx
   1400074a9:	89 c0                	mov    %eax,%eax
   1400074ab:	48 c1 ea 20          	shr    $0x20,%rdx
   1400074af:	81 ea 00 00 40 03    	sub    $0x3400000,%edx
   1400074b5:	48 c1 e2 20          	shl    $0x20,%rdx
   1400074b9:	48 09 d0             	or     %rdx,%rax
   1400074bc:	f2 0f 5c 05 9c 41 00 	subsd  0x419c(%rip),%xmm0        # 14000b660 <.rdata+0x60>
   1400074c3:	00 
   1400074c4:	66 48 0f 6e c8       	movq   %rax,%xmm1
   1400074c9:	66 0f 2f c1          	comisd %xmm1,%xmm0
   1400074cd:	0f 87 5a 0b 00 00    	ja     14000802d <__gdtoa+0x142d>
   1400074d3:	66 0f 57 0d 95 41 00 	xorpd  0x4195(%rip),%xmm1        # 14000b670 <.rdata+0x70>
   1400074da:	00 
   1400074db:	66 0f 2f c8          	comisd %xmm0,%xmm1
   1400074df:	0f 87 32 02 00 00    	ja     140007717 <__gdtoa+0xb17>
   1400074e5:	c7 44 24 78 00 00 00 	movl   $0x0,0x78(%rsp)
   1400074ec:	00 
   1400074ed:	0f 1f 00             	nopl   (%rax)
   1400074f0:	44 8b 54 24 50       	mov    0x50(%rsp),%r10d
   1400074f5:	45 85 d2             	test   %r10d,%r10d
   1400074f8:	0f 89 d2 fe ff ff    	jns    1400073d0 <__gdtoa+0x7d0>
   1400074fe:	44 8b 44 24 70       	mov    0x70(%rsp),%r8d
   140007503:	45 85 c0             	test   %r8d,%r8d
   140007506:	0f 84 f4 02 00 00    	je     140007800 <__gdtoa+0xc00>
   14000750c:	8b 7c 24 50          	mov    0x50(%rsp),%edi
   140007510:	44 29 ed             	sub    %r13d,%ebp
   140007513:	41 8b 54 24 04       	mov    0x4(%r12),%edx
   140007518:	8d 45 01             	lea    0x1(%rbp),%eax
   14000751b:	89 84 24 ac 00 00 00 	mov    %eax,0xac(%rsp)
   140007522:	89 f9                	mov    %edi,%ecx
   140007524:	29 e9                	sub    %ebp,%ecx
   140007526:	39 d1                	cmp    %edx,%ecx
   140007528:	0f 8d d2 06 00 00    	jge    140007c00 <__gdtoa+0x1000>
   14000752e:	41 8d 47 fd          	lea    -0x3(%r15),%eax
   140007532:	83 e0 fd             	and    $0xfffffffd,%eax
   140007535:	0f 84 cf 06 00 00    	je     140007c0a <__gdtoa+0x100a>
   14000753b:	89 f8                	mov    %edi,%eax
   14000753d:	8b 7c 24 48          	mov    0x48(%rsp),%edi
   140007541:	29 d0                	sub    %edx,%eax
   140007543:	83 c0 01             	add    $0x1,%eax
   140007546:	41 83 ff 01          	cmp    $0x1,%r15d
   14000754a:	0f 9f c1             	setg   %cl
   14000754d:	89 84 24 ac 00 00 00 	mov    %eax,0xac(%rsp)
   140007554:	85 ff                	test   %edi,%edi
   140007556:	0f 9f c2             	setg   %dl
   140007559:	84 d1                	test   %dl,%cl
   14000755b:	74 08                	je     140007565 <__gdtoa+0x965>
   14000755d:	39 f8                	cmp    %edi,%eax
   14000755f:	0f 8f 39 0d 00 00    	jg     14000829e <__gdtoa+0x169e>
   140007565:	8b 7c 24 60          	mov    0x60(%rsp),%edi
   140007569:	41 01 c1             	add    %eax,%r9d
   14000756c:	8b 6c 24 7c          	mov    0x7c(%rsp),%ebp
   140007570:	01 f8                	add    %edi,%eax
   140007572:	89 bc 24 84 00 00 00 	mov    %edi,0x84(%rsp)
   140007579:	89 44 24 60          	mov    %eax,0x60(%rsp)
   14000757d:	b9 01 00 00 00       	mov    $0x1,%ecx
   140007582:	44 89 4c 24 50       	mov    %r9d,0x50(%rsp)
   140007587:	e8 84 12 00 00       	call   140008810 <__i2b_D2A>
   14000758c:	44 8b 4c 24 50       	mov    0x50(%rsp),%r9d
   140007591:	c7 44 24 70 01 00 00 	movl   $0x1,0x70(%rsp)
   140007598:	00 
   140007599:	48 89 c7             	mov    %rax,%rdi
   14000759c:	8b 8c 24 84 00 00 00 	mov    0x84(%rsp),%ecx
   1400075a3:	85 c9                	test   %ecx,%ecx
   1400075a5:	7e 25                	jle    1400075cc <__gdtoa+0x9cc>
   1400075a7:	45 85 c9             	test   %r9d,%r9d
   1400075aa:	7e 20                	jle    1400075cc <__gdtoa+0x9cc>
   1400075ac:	44 39 c9             	cmp    %r9d,%ecx
   1400075af:	89 c8                	mov    %ecx,%eax
   1400075b1:	41 0f 4f c1          	cmovg  %r9d,%eax
   1400075b5:	29 44 24 60          	sub    %eax,0x60(%rsp)
   1400075b9:	29 c1                	sub    %eax,%ecx
   1400075bb:	89 84 24 ac 00 00 00 	mov    %eax,0xac(%rsp)
   1400075c2:	41 29 c1             	sub    %eax,%r9d
   1400075c5:	89 8c 24 84 00 00 00 	mov    %ecx,0x84(%rsp)
   1400075cc:	8b 4c 24 7c          	mov    0x7c(%rsp),%ecx
   1400075d0:	85 c9                	test   %ecx,%ecx
   1400075d2:	74 29                	je     1400075fd <__gdtoa+0x9fd>
   1400075d4:	8b 54 24 70          	mov    0x70(%rsp),%edx
   1400075d8:	85 d2                	test   %edx,%edx
   1400075da:	74 08                	je     1400075e4 <__gdtoa+0x9e4>
   1400075dc:	85 ed                	test   %ebp,%ebp
   1400075de:	0f 85 2e 08 00 00    	jne    140007e12 <__gdtoa+0x1212>
   1400075e4:	8b 54 24 7c          	mov    0x7c(%rsp),%edx
   1400075e8:	48 89 f1             	mov    %rsi,%rcx
   1400075eb:	44 89 4c 24 50       	mov    %r9d,0x50(%rsp)
   1400075f0:	e8 3b 14 00 00       	call   140008a30 <__pow5mult_D2A>
   1400075f5:	44 8b 4c 24 50       	mov    0x50(%rsp),%r9d
   1400075fa:	48 89 c6             	mov    %rax,%rsi
   1400075fd:	b9 01 00 00 00       	mov    $0x1,%ecx
   140007602:	44 89 4c 24 50       	mov    %r9d,0x50(%rsp)
   140007607:	e8 04 12 00 00       	call   140008810 <__i2b_D2A>
   14000760c:	44 8b 4c 24 50       	mov    0x50(%rsp),%r9d
   140007611:	49 89 c3             	mov    %rax,%r11
   140007614:	8b 44 24 4c          	mov    0x4c(%rsp),%eax
   140007618:	85 c0                	test   %eax,%eax
   14000761a:	0f 85 58 05 00 00    	jne    140007b78 <__gdtoa+0xf78>
   140007620:	41 83 ff 01          	cmp    $0x1,%r15d
   140007624:	0f 8e 9e 05 00 00    	jle    140007bc8 <__gdtoa+0xfc8>
   14000762a:	bd 1f 00 00 00       	mov    $0x1f,%ebp
   14000762f:	8b 44 24 60          	mov    0x60(%rsp),%eax
   140007633:	44 29 cd             	sub    %r9d,%ebp
   140007636:	83 ed 04             	sub    $0x4,%ebp
   140007639:	83 e5 1f             	and    $0x1f,%ebp
   14000763c:	89 ac 24 ac 00 00 00 	mov    %ebp,0xac(%rsp)
   140007643:	89 ea                	mov    %ebp,%edx
   140007645:	01 e8                	add    %ebp,%eax
   140007647:	85 c0                	test   %eax,%eax
   140007649:	7e 28                	jle    140007673 <__gdtoa+0xa73>
   14000764b:	89 c2                	mov    %eax,%edx
   14000764d:	48 89 f1             	mov    %rsi,%rcx
   140007650:	4c 89 5c 24 50       	mov    %r11,0x50(%rsp)
   140007655:	44 89 4c 24 38       	mov    %r9d,0x38(%rsp)
   14000765a:	e8 61 15 00 00       	call   140008bc0 <__lshift_D2A>
   14000765f:	8b 94 24 ac 00 00 00 	mov    0xac(%rsp),%edx
   140007666:	4c 8b 5c 24 50       	mov    0x50(%rsp),%r11
   14000766b:	48 89 c6             	mov    %rax,%rsi
   14000766e:	44 8b 4c 24 38       	mov    0x38(%rsp),%r9d
   140007673:	44 01 ca             	add    %r9d,%edx
   140007676:	85 d2                	test   %edx,%edx
   140007678:	7e 0b                	jle    140007685 <__gdtoa+0xa85>
   14000767a:	4c 89 d9             	mov    %r11,%rcx
   14000767d:	e8 3e 15 00 00       	call   140008bc0 <__lshift_D2A>
   140007682:	49 89 c3             	mov    %rax,%r11
   140007685:	8b 84 24 80 00 00 00 	mov    0x80(%rsp),%eax
   14000768c:	41 83 ff 02          	cmp    $0x2,%r15d
   140007690:	41 0f 9f c4          	setg   %r12b
   140007694:	85 c0                	test   %eax,%eax
   140007696:	0f 85 a4 03 00 00    	jne    140007a40 <__gdtoa+0xe40>
   14000769c:	8b 44 24 48          	mov    0x48(%rsp),%eax
   1400076a0:	85 c0                	test   %eax,%eax
   1400076a2:	0f 8f 78 01 00 00    	jg     140007820 <__gdtoa+0xc20>
   1400076a8:	45 84 e4             	test   %r12b,%r12b
   1400076ab:	0f 84 6f 01 00 00    	je     140007820 <__gdtoa+0xc20>
   1400076b1:	44 8b 6c 24 48       	mov    0x48(%rsp),%r13d
   1400076b6:	45 85 ed             	test   %r13d,%r13d
   1400076b9:	75 61                	jne    14000771c <__gdtoa+0xb1c>
   1400076bb:	4c 89 d9             	mov    %r11,%rcx
   1400076be:	45 31 c0             	xor    %r8d,%r8d
   1400076c1:	ba 05 00 00 00       	mov    $0x5,%edx
   1400076c6:	e8 85 10 00 00       	call   140008750 <__multadd_D2A>
   1400076cb:	48 89 f1             	mov    %rsi,%rcx
   1400076ce:	48 89 c2             	mov    %rax,%rdx
   1400076d1:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
   1400076d6:	e8 f5 15 00 00       	call   140008cd0 <__cmp_D2A>
   1400076db:	4c 8b 5c 24 30       	mov    0x30(%rsp),%r11
   1400076e0:	85 c0                	test   %eax,%eax
   1400076e2:	7e 38                	jle    14000771c <__gdtoa+0xb1c>
   1400076e4:	8b 44 24 68          	mov    0x68(%rsp),%eax
   1400076e8:	4c 8b 64 24 58       	mov    0x58(%rsp),%r12
   1400076ed:	83 c0 02             	add    $0x2,%eax
   1400076f0:	89 44 24 50          	mov    %eax,0x50(%rsp)
   1400076f4:	e9 3d fd ff ff       	jmp    140007436 <__gdtoa+0x836>
   1400076f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140007700:	41 83 ff 03          	cmp    $0x3,%r15d
   140007704:	0f 85 83 fb ff ff    	jne    14000728d <__gdtoa+0x68d>
   14000770a:	c7 44 24 70 00 00 00 	movl   $0x0,0x70(%rsp)
   140007711:	00 
   140007712:	e9 49 fc ff ff       	jmp    140007360 <__gdtoa+0x760>
   140007717:	45 31 db             	xor    %r11d,%r11d
   14000771a:	31 ff                	xor    %edi,%edi
   14000771c:	41 f7 de             	neg    %r14d
   14000771f:	4c 8b 64 24 58       	mov    0x58(%rsp),%r12
   140007724:	c7 44 24 44 10 00 00 	movl   $0x10,0x44(%rsp)
   14000772b:	00 
   14000772c:	44 89 74 24 50       	mov    %r14d,0x50(%rsp)
   140007731:	e9 13 fd ff ff       	jmp    140007449 <__gdtoa+0x849>
   140007736:	66 0f 28 e2          	movapd %xmm2,%xmm4
   14000773a:	66 49 0f 6e c2       	movq   %r10,%xmm0
   14000773f:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
   140007744:	c7 84 24 ac 00 00 00 	movl   $0x1,0xac(%rsp)
   14000774b:	01 00 00 00 
   14000774f:	f2 0f 59 e3          	mulsd  %xmm3,%xmm4
   140007753:	f2 0f 10 15 ed 3e 00 	movsd  0x3eed(%rip),%xmm2        # 14000b648 <.rdata+0x48>
   14000775a:	00 
   14000775b:	66 0f 28 c8          	movapd %xmm0,%xmm1
   14000775f:	45 31 d2             	xor    %r10d,%r10d
   140007762:	eb 15                	jmp    140007779 <__gdtoa+0xb79>
   140007764:	0f 1f 40 00          	nopl   0x0(%rax)
   140007768:	f2 0f 59 ca          	mulsd  %xmm2,%xmm1
   14000776c:	45 89 c2             	mov    %r8d,%r10d
   14000776f:	8d 55 01             	lea    0x1(%rbp),%edx
   140007772:	89 94 24 ac 00 00 00 	mov    %edx,0xac(%rsp)
   140007779:	f2 0f 2c d1          	cvttsd2si %xmm1,%edx
   14000777d:	85 d2                	test   %edx,%edx
   14000777f:	74 0f                	je     140007790 <__gdtoa+0xb90>
   140007781:	66 0f ef db          	pxor   %xmm3,%xmm3
   140007785:	f2 0f 2a da          	cvtsi2sd %edx,%xmm3
   140007789:	45 89 c2             	mov    %r8d,%r10d
   14000778c:	f2 0f 5c cb          	subsd  %xmm3,%xmm1
   140007790:	48 83 c0 01          	add    $0x1,%rax
   140007794:	83 c2 30             	add    $0x30,%edx
   140007797:	88 50 ff             	mov    %dl,-0x1(%rax)
   14000779a:	8b ac 24 ac 00 00 00 	mov    0xac(%rsp),%ebp
   1400077a1:	44 39 dd             	cmp    %r11d,%ebp
   1400077a4:	75 c2                	jne    140007768 <__gdtoa+0xb68>
   1400077a6:	45 84 d2             	test   %r10b,%r10b
   1400077a9:	0f 84 2e 0a 00 00    	je     1400081dd <__gdtoa+0x15dd>
   1400077af:	f2 0f 10 05 c9 3e 00 	movsd  0x3ec9(%rip),%xmm0        # 14000b680 <.rdata+0x80>
   1400077b6:	00 
   1400077b7:	66 0f 28 d4          	movapd %xmm4,%xmm2
   1400077bb:	f2 0f 58 d0          	addsd  %xmm0,%xmm2
   1400077bf:	66 0f 2f ca          	comisd %xmm2,%xmm1
   1400077c3:	0f 87 07 0a 00 00    	ja     1400081d0 <__gdtoa+0x15d0>
   1400077c9:	f2 0f 5c c4          	subsd  %xmm4,%xmm0
   1400077cd:	66 0f 2f c1          	comisd %xmm1,%xmm0
   1400077d1:	0f 87 6a 0a 00 00    	ja     140008241 <__gdtoa+0x1641>
   1400077d7:	8b 7c 24 50          	mov    0x50(%rsp),%edi
   1400077db:	85 ff                	test   %edi,%edi
   1400077dd:	0f 88 f4 0a 00 00    	js     1400082d7 <__gdtoa+0x16d7>
   1400077e3:	45 8b 5c 24 14       	mov    0x14(%r12),%r11d
   1400077e8:	c7 44 24 78 00 00 00 	movl   $0x0,0x78(%rsp)
   1400077ef:	00 
   1400077f0:	45 85 db             	test   %r11d,%r11d
   1400077f3:	0f 89 ed fb ff ff    	jns    1400073e6 <__gdtoa+0x7e6>
   1400077f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140007800:	8b 44 24 60          	mov    0x60(%rsp),%eax
   140007804:	31 ff                	xor    %edi,%edi
   140007806:	8b 6c 24 7c          	mov    0x7c(%rsp),%ebp
   14000780a:	89 84 24 84 00 00 00 	mov    %eax,0x84(%rsp)
   140007811:	e9 86 fd ff ff       	jmp    14000759c <__gdtoa+0x99c>
   140007816:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   14000781d:	00 00 00 
   140007820:	8b 44 24 68          	mov    0x68(%rsp),%eax
   140007824:	44 8b 64 24 70       	mov    0x70(%rsp),%r12d
   140007829:	83 c0 01             	add    $0x1,%eax
   14000782c:	45 85 e4             	test   %r12d,%r12d
   14000782f:	89 44 24 50          	mov    %eax,0x50(%rsp)
   140007833:	0f 84 7f 02 00 00    	je     140007ab8 <__gdtoa+0xeb8>
   140007839:	8b 94 24 84 00 00 00 	mov    0x84(%rsp),%edx
   140007840:	01 ea                	add    %ebp,%edx
   140007842:	85 d2                	test   %edx,%edx
   140007844:	7e 15                	jle    14000785b <__gdtoa+0xc5b>
   140007846:	48 89 f9             	mov    %rdi,%rcx
   140007849:	4c 89 5c 24 38       	mov    %r11,0x38(%rsp)
   14000784e:	e8 6d 13 00 00       	call   140008bc0 <__lshift_D2A>
   140007853:	4c 8b 5c 24 38       	mov    0x38(%rsp),%r11
   140007858:	48 89 c7             	mov    %rax,%rdi
   14000785b:	44 8b 54 24 4c       	mov    0x4c(%rsp),%r10d
   140007860:	49 89 fc             	mov    %rdi,%r12
   140007863:	45 85 d2             	test   %r10d,%r10d
   140007866:	0f 85 7e 07 00 00    	jne    140007fea <__gdtoa+0x13ea>
   14000786c:	4c 8b 54 24 58       	mov    0x58(%rsp),%r10
   140007871:	48 89 5c 24 68       	mov    %rbx,0x68(%rsp)
   140007876:	b8 01 00 00 00       	mov    $0x1,%eax
   14000787b:	44 89 7c 24 4c       	mov    %r15d,0x4c(%rsp)
   140007880:	4c 8b 7c 24 30       	mov    0x30(%rsp),%r15
   140007885:	4c 89 5c 24 38       	mov    %r11,0x38(%rsp)
   14000788a:	4c 89 d3             	mov    %r10,%rbx
   14000788d:	e9 a5 00 00 00       	jmp    140007937 <__gdtoa+0xd37>
   140007892:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140007898:	48 89 c1             	mov    %rax,%rcx
   14000789b:	e8 40 0e 00 00       	call   1400086e0 <__Bfree_D2A>
   1400078a0:	ba 01 00 00 00       	mov    $0x1,%edx
   1400078a5:	85 ed                	test   %ebp,%ebp
   1400078a7:	0f 88 13 06 00 00    	js     140007ec0 <__gdtoa+0x12c0>
   1400078ad:	0b 6c 24 4c          	or     0x4c(%rsp),%ebp
   1400078b1:	75 0a                	jne    1400078bd <__gdtoa+0xcbd>
   1400078b3:	41 f6 07 01          	testb  $0x1,(%r15)
   1400078b7:	0f 84 03 06 00 00    	je     140007ec0 <__gdtoa+0x12c0>
   1400078bd:	48 8d 6b 01          	lea    0x1(%rbx),%rbp
   1400078c1:	85 d2                	test   %edx,%edx
   1400078c3:	49 89 ee             	mov    %rbp,%r14
   1400078c6:	7e 0b                	jle    1400078d3 <__gdtoa+0xcd3>
   1400078c8:	83 7c 24 78 02       	cmpl   $0x2,0x78(%rsp)
   1400078cd:	0f 85 71 07 00 00    	jne    140008044 <__gdtoa+0x1444>
   1400078d3:	8b 44 24 48          	mov    0x48(%rsp),%eax
   1400078d7:	44 88 6d ff          	mov    %r13b,-0x1(%rbp)
   1400078db:	39 84 24 ac 00 00 00 	cmp    %eax,0xac(%rsp)
   1400078e2:	0f 84 8d 07 00 00    	je     140008075 <__gdtoa+0x1475>
   1400078e8:	45 31 c0             	xor    %r8d,%r8d
   1400078eb:	48 89 f1             	mov    %rsi,%rcx
   1400078ee:	ba 0a 00 00 00       	mov    $0xa,%edx
   1400078f3:	e8 58 0e 00 00       	call   140008750 <__multadd_D2A>
   1400078f8:	45 31 c0             	xor    %r8d,%r8d
   1400078fb:	4c 39 e7             	cmp    %r12,%rdi
   1400078fe:	ba 0a 00 00 00       	mov    $0xa,%edx
   140007903:	48 89 c6             	mov    %rax,%rsi
   140007906:	48 89 f9             	mov    %rdi,%rcx
   140007909:	0f 84 19 01 00 00    	je     140007a28 <__gdtoa+0xe28>
   14000790f:	e8 3c 0e 00 00       	call   140008750 <__multadd_D2A>
   140007914:	4c 89 e1             	mov    %r12,%rcx
   140007917:	45 31 c0             	xor    %r8d,%r8d
   14000791a:	ba 0a 00 00 00       	mov    $0xa,%edx
   14000791f:	48 89 c7             	mov    %rax,%rdi
   140007922:	e8 29 0e 00 00       	call   140008750 <__multadd_D2A>
   140007927:	49 89 c4             	mov    %rax,%r12
   14000792a:	8b 84 24 ac 00 00 00 	mov    0xac(%rsp),%eax
   140007931:	48 89 eb             	mov    %rbp,%rbx
   140007934:	83 c0 01             	add    $0x1,%eax
   140007937:	48 8b 54 24 38       	mov    0x38(%rsp),%rdx
   14000793c:	48 89 f1             	mov    %rsi,%rcx
   14000793f:	89 84 24 ac 00 00 00 	mov    %eax,0xac(%rsp)
   140007946:	e8 35 f1 ff ff       	call   140006a80 <__quorem_D2A>
   14000794b:	48 89 fa             	mov    %rdi,%rdx
   14000794e:	48 89 f1             	mov    %rsi,%rcx
   140007951:	44 8d 68 30          	lea    0x30(%rax),%r13d
   140007955:	41 89 c6             	mov    %eax,%r14d
   140007958:	e8 73 13 00 00       	call   140008cd0 <__cmp_D2A>
   14000795d:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
   140007962:	4c 89 e2             	mov    %r12,%rdx
   140007965:	89 c5                	mov    %eax,%ebp
   140007967:	e8 b4 13 00 00       	call   140008d20 <__diff_D2A>
   14000796c:	44 8b 48 10          	mov    0x10(%rax),%r9d
   140007970:	48 89 c2             	mov    %rax,%rdx
   140007973:	45 85 c9             	test   %r9d,%r9d
   140007976:	0f 85 1c ff ff ff    	jne    140007898 <__gdtoa+0xc98>
   14000797c:	48 89 f1             	mov    %rsi,%rcx
   14000797f:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
   140007984:	e8 47 13 00 00       	call   140008cd0 <__cmp_D2A>
   140007989:	48 8b 4c 24 60       	mov    0x60(%rsp),%rcx
   14000798e:	89 44 24 30          	mov    %eax,0x30(%rsp)
   140007992:	e8 49 0d 00 00       	call   1400086e0 <__Bfree_D2A>
   140007997:	8b 54 24 30          	mov    0x30(%rsp),%edx
   14000799b:	8b 44 24 4c          	mov    0x4c(%rsp),%eax
   14000799f:	09 c2                	or     %eax,%edx
   1400079a1:	0f 85 8c 03 00 00    	jne    140007d33 <__gdtoa+0x1133>
   1400079a7:	41 8b 07             	mov    (%r15),%eax
   1400079aa:	83 e0 01             	and    $0x1,%eax
   1400079ad:	0b 44 24 78          	or     0x78(%rsp),%eax
   1400079b1:	0f 85 ee fe ff ff    	jne    1400078a5 <__gdtoa+0xca5>
   1400079b7:	41 83 fd 39          	cmp    $0x39,%r13d
   1400079bb:	49 89 da             	mov    %rbx,%r10
   1400079be:	4c 8b 5c 24 38       	mov    0x38(%rsp),%r11
   1400079c3:	48 8b 5c 24 68       	mov    0x68(%rsp),%rbx
   1400079c8:	0f 84 3e 07 00 00    	je     14000810c <__gdtoa+0x150c>
   1400079ce:	85 ed                	test   %ebp,%ebp
   1400079d0:	0f 8e 6b 09 00 00    	jle    140008341 <__gdtoa+0x1741>
   1400079d6:	45 8d 6e 31          	lea    0x31(%r14),%r13d
   1400079da:	c7 44 24 44 20 00 00 	movl   $0x20,0x44(%rsp)
   1400079e1:	00 
   1400079e2:	49 8d 6a 01          	lea    0x1(%r10),%rbp
   1400079e6:	49 89 ff             	mov    %rdi,%r15
   1400079e9:	45 88 2a             	mov    %r13b,(%r10)
   1400079ec:	4c 89 e7             	mov    %r12,%rdi
   1400079ef:	90                   	nop
   1400079f0:	4c 89 d9             	mov    %r11,%rcx
   1400079f3:	e8 e8 0c 00 00       	call   1400086e0 <__Bfree_D2A>
   1400079f8:	48 85 ff             	test   %rdi,%rdi
   1400079fb:	0f 84 7a 03 00 00    	je     140007d7b <__gdtoa+0x117b>
   140007a01:	4d 85 ff             	test   %r15,%r15
   140007a04:	74 0d                	je     140007a13 <__gdtoa+0xe13>
   140007a06:	49 39 ff             	cmp    %rdi,%r15
   140007a09:	74 08                	je     140007a13 <__gdtoa+0xe13>
   140007a0b:	4c 89 f9             	mov    %r15,%rcx
   140007a0e:	e8 cd 0c 00 00       	call   1400086e0 <__Bfree_D2A>
   140007a13:	4c 8b 64 24 58       	mov    0x58(%rsp),%r12
   140007a18:	48 89 6c 24 58       	mov    %rbp,0x58(%rsp)
   140007a1d:	e9 34 fa ff ff       	jmp    140007456 <__gdtoa+0x856>
   140007a22:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140007a28:	e8 23 0d 00 00       	call   140008750 <__multadd_D2A>
   140007a2d:	48 89 c7             	mov    %rax,%rdi
   140007a30:	49 89 c4             	mov    %rax,%r12
   140007a33:	e9 f2 fe ff ff       	jmp    14000792a <__gdtoa+0xd2a>
   140007a38:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   140007a3f:	00 
   140007a40:	4c 89 da             	mov    %r11,%rdx
   140007a43:	48 89 f1             	mov    %rsi,%rcx
   140007a46:	4c 89 5c 24 38       	mov    %r11,0x38(%rsp)
   140007a4b:	e8 80 12 00 00       	call   140008cd0 <__cmp_D2A>
   140007a50:	4c 8b 5c 24 38       	mov    0x38(%rsp),%r11
   140007a55:	85 c0                	test   %eax,%eax
   140007a57:	0f 89 3f fc ff ff    	jns    14000769c <__gdtoa+0xa9c>
   140007a5d:	8b 44 24 68          	mov    0x68(%rsp),%eax
   140007a61:	45 31 c0             	xor    %r8d,%r8d
   140007a64:	48 89 f1             	mov    %rsi,%rcx
   140007a67:	ba 0a 00 00 00       	mov    $0xa,%edx
   140007a6c:	44 8d 68 ff          	lea    -0x1(%rax),%r13d
   140007a70:	e8 db 0c 00 00       	call   140008750 <__multadd_D2A>
   140007a75:	4c 8b 5c 24 38       	mov    0x38(%rsp),%r11
   140007a7a:	48 89 c6             	mov    %rax,%rsi
   140007a7d:	8b 84 24 9c 00 00 00 	mov    0x9c(%rsp),%eax
   140007a84:	85 c0                	test   %eax,%eax
   140007a86:	0f 9e c0             	setle  %al
   140007a89:	41 21 c4             	and    %eax,%r12d
   140007a8c:	8b 44 24 70          	mov    0x70(%rsp),%eax
   140007a90:	85 c0                	test   %eax,%eax
   140007a92:	0f 85 70 07 00 00    	jne    140008208 <__gdtoa+0x1608>
   140007a98:	45 84 e4             	test   %r12b,%r12b
   140007a9b:	0f 85 96 06 00 00    	jne    140008137 <__gdtoa+0x1537>
   140007aa1:	8b 44 24 68          	mov    0x68(%rsp),%eax
   140007aa5:	89 44 24 50          	mov    %eax,0x50(%rsp)
   140007aa9:	8b 84 24 9c 00 00 00 	mov    0x9c(%rsp),%eax
   140007ab0:	89 44 24 48          	mov    %eax,0x48(%rsp)
   140007ab4:	0f 1f 40 00          	nopl   0x0(%rax)
   140007ab8:	4c 8b 74 24 58       	mov    0x58(%rsp),%r14
   140007abd:	b8 01 00 00 00       	mov    $0x1,%eax
   140007ac2:	4c 89 dd             	mov    %r11,%rbp
   140007ac5:	44 8b 64 24 48       	mov    0x48(%rsp),%r12d
   140007aca:	eb 21                	jmp    140007aed <__gdtoa+0xeed>
   140007acc:	0f 1f 40 00          	nopl   0x0(%rax)
   140007ad0:	48 89 f1             	mov    %rsi,%rcx
   140007ad3:	45 31 c0             	xor    %r8d,%r8d
   140007ad6:	ba 0a 00 00 00       	mov    $0xa,%edx
   140007adb:	e8 70 0c 00 00       	call   140008750 <__multadd_D2A>
   140007ae0:	48 89 c6             	mov    %rax,%rsi
   140007ae3:	8b 84 24 ac 00 00 00 	mov    0xac(%rsp),%eax
   140007aea:	83 c0 01             	add    $0x1,%eax
   140007aed:	48 89 ea             	mov    %rbp,%rdx
   140007af0:	48 89 f1             	mov    %rsi,%rcx
   140007af3:	89 84 24 ac 00 00 00 	mov    %eax,0xac(%rsp)
   140007afa:	49 83 c6 01          	add    $0x1,%r14
   140007afe:	e8 7d ef ff ff       	call   140006a80 <__quorem_D2A>
   140007b03:	44 8d 68 30          	lea    0x30(%rax),%r13d
   140007b07:	45 88 6e ff          	mov    %r13b,-0x1(%r14)
   140007b0b:	44 39 a4 24 ac 00 00 	cmp    %r12d,0xac(%rsp)
   140007b12:	00 
   140007b13:	7c bb                	jl     140007ad0 <__gdtoa+0xed0>
   140007b15:	49 89 eb             	mov    %rbp,%r11
   140007b18:	45 31 ff             	xor    %r15d,%r15d
   140007b1b:	8b 4c 24 78          	mov    0x78(%rsp),%ecx
   140007b1f:	85 c9                	test   %ecx,%ecx
   140007b21:	0f 84 43 03 00 00    	je     140007e6a <__gdtoa+0x126a>
   140007b27:	83 f9 02             	cmp    $0x2,%ecx
   140007b2a:	8b 46 14             	mov    0x14(%rsi),%eax
   140007b2d:	0f 84 72 03 00 00    	je     140007ea5 <__gdtoa+0x12a5>
   140007b33:	83 f8 01             	cmp    $0x1,%eax
   140007b36:	0f 8f 0d 02 00 00    	jg     140007d49 <__gdtoa+0x1149>
   140007b3c:	8b 46 18             	mov    0x18(%rsi),%eax
   140007b3f:	85 c0                	test   %eax,%eax
   140007b41:	0f 85 02 02 00 00    	jne    140007d49 <__gdtoa+0x1149>
   140007b47:	85 c0                	test   %eax,%eax
   140007b49:	0f 95 c0             	setne  %al
   140007b4c:	0f b6 c0             	movzbl %al,%eax
   140007b4f:	c1 e0 04             	shl    $0x4,%eax
   140007b52:	89 44 24 44          	mov    %eax,0x44(%rsp)
   140007b56:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   140007b5d:	00 00 00 
   140007b60:	4c 89 f5             	mov    %r14,%rbp
   140007b63:	49 83 ee 01          	sub    $0x1,%r14
   140007b67:	41 80 3e 30          	cmpb   $0x30,(%r14)
   140007b6b:	74 f3                	je     140007b60 <__gdtoa+0xf60>
   140007b6d:	e9 7e fe ff ff       	jmp    1400079f0 <__gdtoa+0xdf0>
   140007b72:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140007b78:	8b 54 24 4c          	mov    0x4c(%rsp),%edx
   140007b7c:	4c 89 d9             	mov    %r11,%rcx
   140007b7f:	e8 ac 0e 00 00       	call   140008a30 <__pow5mult_D2A>
   140007b84:	41 83 ff 01          	cmp    $0x1,%r15d
   140007b88:	44 8b 4c 24 50       	mov    0x50(%rsp),%r9d
   140007b8d:	49 89 c3             	mov    %rax,%r11
   140007b90:	0f 8e 2a 02 00 00    	jle    140007dc0 <__gdtoa+0x11c0>
   140007b96:	c7 44 24 4c 00 00 00 	movl   $0x0,0x4c(%rsp)
   140007b9d:	00 
   140007b9e:	41 8b 43 14          	mov    0x14(%r11),%eax
   140007ba2:	83 e8 01             	sub    $0x1,%eax
   140007ba5:	48 98                	cltq
   140007ba7:	41 0f bd 6c 83 18    	bsr    0x18(%r11,%rax,4),%ebp
   140007bad:	83 f5 1f             	xor    $0x1f,%ebp
   140007bb0:	e9 7a fa ff ff       	jmp    14000762f <__gdtoa+0xa2f>
   140007bb5:	0f 1f 00             	nopl   (%rax)
   140007bb8:	c7 44 24 70 01 00 00 	movl   $0x1,0x70(%rsp)
   140007bbf:	00 
   140007bc0:	e9 9b f7 ff ff       	jmp    140007360 <__gdtoa+0x760>
   140007bc5:	0f 1f 00             	nopl   (%rax)
   140007bc8:	41 83 fd 01          	cmp    $0x1,%r13d
   140007bcc:	0f 85 58 fa ff ff    	jne    14000762a <__gdtoa+0xa2a>
   140007bd2:	41 8b 44 24 04       	mov    0x4(%r12),%eax
   140007bd7:	83 c0 01             	add    $0x1,%eax
   140007bda:	39 44 24 38          	cmp    %eax,0x38(%rsp)
   140007bde:	0f 8e 46 fa ff ff    	jle    14000762a <__gdtoa+0xa2a>
   140007be4:	83 44 24 60 01       	addl   $0x1,0x60(%rsp)
   140007be9:	41 83 c1 01          	add    $0x1,%r9d
   140007bed:	c7 44 24 4c 01 00 00 	movl   $0x1,0x4c(%rsp)
   140007bf4:	00 
   140007bf5:	e9 30 fa ff ff       	jmp    14000762a <__gdtoa+0xa2a>
   140007bfa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140007c00:	41 83 ff 01          	cmp    $0x1,%r15d
   140007c04:	0f 8e 5b f9 ff ff    	jle    140007565 <__gdtoa+0x965>
   140007c0a:	8b 54 24 48          	mov    0x48(%rsp),%edx
   140007c0e:	8b 7c 24 7c          	mov    0x7c(%rsp),%edi
   140007c12:	8d 42 ff             	lea    -0x1(%rdx),%eax
   140007c15:	39 c7                	cmp    %eax,%edi
   140007c17:	0f 8c 6d 01 00 00    	jl     140007d8a <__gdtoa+0x118a>
   140007c1d:	89 fd                	mov    %edi,%ebp
   140007c1f:	29 c5                	sub    %eax,%ebp
   140007c21:	85 d2                	test   %edx,%edx
   140007c23:	0f 89 bd 05 00 00    	jns    1400081e6 <__gdtoa+0x15e6>
   140007c29:	c7 84 24 ac 00 00 00 	movl   $0x0,0xac(%rsp)
   140007c30:	00 00 00 00 
   140007c34:	8b 44 24 60          	mov    0x60(%rsp),%eax
   140007c38:	8b 7c 24 48          	mov    0x48(%rsp),%edi
   140007c3c:	29 f8                	sub    %edi,%eax
   140007c3e:	89 84 24 84 00 00 00 	mov    %eax,0x84(%rsp)
   140007c45:	e9 33 f9 ff ff       	jmp    14000757d <__gdtoa+0x97d>
   140007c4a:	c7 84 24 ac 00 00 00 	movl   $0x1,0xac(%rsp)
   140007c51:	01 00 00 00 
   140007c55:	48 8b 7c 24 58       	mov    0x58(%rsp),%rdi
   140007c5a:	f2 0f 10 84 24 90 00 	movsd  0x90(%rsp),%xmm0
   140007c61:	00 00 
   140007c63:	66 0f 28 c8          	movapd %xmm0,%xmm1
   140007c67:	f2 0f 5e ca          	divsd  %xmm2,%xmm1
   140007c6b:	48 8d 47 01          	lea    0x1(%rdi),%rax
   140007c6f:	f2 0f 2c c9          	cvttsd2si %xmm1,%ecx
   140007c73:	66 0f ef c9          	pxor   %xmm1,%xmm1
   140007c77:	f2 0f 2a c9          	cvtsi2sd %ecx,%xmm1
   140007c7b:	8d 51 30             	lea    0x30(%rcx),%edx
   140007c7e:	88 17                	mov    %dl,(%rdi)
   140007c80:	8b 7c 24 68          	mov    0x68(%rsp),%edi
   140007c84:	f2 0f 59 ca          	mulsd  %xmm2,%xmm1
   140007c88:	83 c7 01             	add    $0x1,%edi
   140007c8b:	89 7c 24 50          	mov    %edi,0x50(%rsp)
   140007c8f:	f2 0f 5c c1          	subsd  %xmm1,%xmm0
   140007c93:	66 0f ef c9          	pxor   %xmm1,%xmm1
   140007c97:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
   140007c9b:	7a 06                	jp     140007ca3 <__gdtoa+0x10a3>
   140007c9d:	0f 84 b8 01 00 00    	je     140007e5b <__gdtoa+0x125b>
   140007ca3:	f2 0f 10 25 9d 39 00 	movsd  0x399d(%rip),%xmm4        # 14000b648 <.rdata+0x48>
   140007caa:	00 
   140007cab:	66 0f ef db          	pxor   %xmm3,%xmm3
   140007caf:	eb 47                	jmp    140007cf8 <__gdtoa+0x10f8>
   140007cb1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140007cb8:	f2 0f 59 c4          	mulsd  %xmm4,%xmm0
   140007cbc:	83 c2 01             	add    $0x1,%edx
   140007cbf:	48 83 c0 01          	add    $0x1,%rax
   140007cc3:	89 94 24 ac 00 00 00 	mov    %edx,0xac(%rsp)
   140007cca:	66 0f 28 c8          	movapd %xmm0,%xmm1
   140007cce:	f2 0f 5e ca          	divsd  %xmm2,%xmm1
   140007cd2:	f2 0f 2c c9          	cvttsd2si %xmm1,%ecx
   140007cd6:	66 0f ef c9          	pxor   %xmm1,%xmm1
   140007cda:	f2 0f 2a c9          	cvtsi2sd %ecx,%xmm1
   140007cde:	8d 51 30             	lea    0x30(%rcx),%edx
   140007ce1:	88 50 ff             	mov    %dl,-0x1(%rax)
   140007ce4:	f2 0f 59 ca          	mulsd  %xmm2,%xmm1
   140007ce8:	f2 0f 5c c1          	subsd  %xmm1,%xmm0
   140007cec:	66 0f 2e c3          	ucomisd %xmm3,%xmm0
   140007cf0:	7a 06                	jp     140007cf8 <__gdtoa+0x10f8>
   140007cf2:	0f 84 63 01 00 00    	je     140007e5b <__gdtoa+0x125b>
   140007cf8:	8b 94 24 ac 00 00 00 	mov    0xac(%rsp),%edx
   140007cff:	8b 7c 24 48          	mov    0x48(%rsp),%edi
   140007d03:	39 fa                	cmp    %edi,%edx
   140007d05:	75 b1                	jne    140007cb8 <__gdtoa+0x10b8>
   140007d07:	8b 7c 24 78          	mov    0x78(%rsp),%edi
   140007d0b:	85 ff                	test   %edi,%edi
   140007d0d:	0f 84 39 04 00 00    	je     14000814c <__gdtoa+0x154c>
   140007d13:	83 ff 01             	cmp    $0x1,%edi
   140007d16:	0f 84 4b 05 00 00    	je     140008267 <__gdtoa+0x1667>
   140007d1c:	4c 8b 64 24 58       	mov    0x58(%rsp),%r12
   140007d21:	c7 44 24 44 10 00 00 	movl   $0x10,0x44(%rsp)
   140007d28:	00 
   140007d29:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
   140007d2e:	e9 2b f7 ff ff       	jmp    14000745e <__gdtoa+0x85e>
   140007d33:	8b 54 24 30          	mov    0x30(%rsp),%edx
   140007d37:	e9 69 fb ff ff       	jmp    1400078a5 <__gdtoa+0xca5>
   140007d3c:	c7 44 24 70 01 00 00 	movl   $0x1,0x70(%rsp)
   140007d43:	00 
   140007d44:	e9 f3 f2 ff ff       	jmp    14000703c <__gdtoa+0x43c>
   140007d49:	48 8b 54 24 58       	mov    0x58(%rsp),%rdx
   140007d4e:	eb 09                	jmp    140007d59 <__gdtoa+0x1159>
   140007d50:	4c 39 f2             	cmp    %r14,%rdx
   140007d53:	0f 84 9f 00 00 00    	je     140007df8 <__gdtoa+0x11f8>
   140007d59:	4c 89 f5             	mov    %r14,%rbp
   140007d5c:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
   140007d60:	4d 8d 76 ff          	lea    -0x1(%r14),%r14
   140007d64:	3c 39                	cmp    $0x39,%al
   140007d66:	74 e8                	je     140007d50 <__gdtoa+0x1150>
   140007d68:	83 c0 01             	add    $0x1,%eax
   140007d6b:	c7 44 24 44 20 00 00 	movl   $0x20,0x44(%rsp)
   140007d72:	00 
   140007d73:	41 88 06             	mov    %al,(%r14)
   140007d76:	e9 75 fc ff ff       	jmp    1400079f0 <__gdtoa+0xdf0>
   140007d7b:	4c 8b 64 24 58       	mov    0x58(%rsp),%r12
   140007d80:	48 89 6c 24 58       	mov    %rbp,0x58(%rsp)
   140007d85:	e9 d4 f6 ff ff       	jmp    14000745e <__gdtoa+0x85e>
   140007d8a:	8b 7c 24 7c          	mov    0x7c(%rsp),%edi
   140007d8e:	89 c2                	mov    %eax,%edx
   140007d90:	31 ed                	xor    %ebp,%ebp
   140007d92:	89 44 24 7c          	mov    %eax,0x7c(%rsp)
   140007d96:	8b 4c 24 60          	mov    0x60(%rsp),%ecx
   140007d9a:	29 fa                	sub    %edi,%edx
   140007d9c:	8b 7c 24 48          	mov    0x48(%rsp),%edi
   140007da0:	01 54 24 4c          	add    %edx,0x4c(%rsp)
   140007da4:	89 8c 24 84 00 00 00 	mov    %ecx,0x84(%rsp)
   140007dab:	89 bc 24 ac 00 00 00 	mov    %edi,0xac(%rsp)
   140007db2:	41 01 f9             	add    %edi,%r9d
   140007db5:	01 cf                	add    %ecx,%edi
   140007db7:	89 7c 24 60          	mov    %edi,0x60(%rsp)
   140007dbb:	e9 bd f7 ff ff       	jmp    14000757d <__gdtoa+0x97d>
   140007dc0:	41 83 fd 01          	cmp    $0x1,%r13d
   140007dc4:	0f 85 cc fd ff ff    	jne    140007b96 <__gdtoa+0xf96>
   140007dca:	41 8b 44 24 04       	mov    0x4(%r12),%eax
   140007dcf:	83 c0 01             	add    $0x1,%eax
   140007dd2:	39 44 24 38          	cmp    %eax,0x38(%rsp)
   140007dd6:	0f 8e ba fd ff ff    	jle    140007b96 <__gdtoa+0xf96>
   140007ddc:	83 44 24 60 01       	addl   $0x1,0x60(%rsp)
   140007de1:	41 83 c1 01          	add    $0x1,%r9d
   140007de5:	c7 44 24 4c 01 00 00 	movl   $0x1,0x4c(%rsp)
   140007dec:	00 
   140007ded:	e9 ac fd ff ff       	jmp    140007b9e <__gdtoa+0xf9e>
   140007df2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140007df8:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
   140007dfd:	c7 44 24 44 20 00 00 	movl   $0x20,0x44(%rsp)
   140007e04:	00 
   140007e05:	83 44 24 50 01       	addl   $0x1,0x50(%rsp)
   140007e0a:	c6 00 31             	movb   $0x31,(%rax)
   140007e0d:	e9 de fb ff ff       	jmp    1400079f0 <__gdtoa+0xdf0>
   140007e12:	48 89 f9             	mov    %rdi,%rcx
   140007e15:	89 ea                	mov    %ebp,%edx
   140007e17:	44 89 8c 24 88 00 00 	mov    %r9d,0x88(%rsp)
   140007e1e:	00 
   140007e1f:	e8 0c 0c 00 00       	call   140008a30 <__pow5mult_D2A>
   140007e24:	48 89 f2             	mov    %rsi,%rdx
   140007e27:	48 89 c1             	mov    %rax,%rcx
   140007e2a:	48 89 c7             	mov    %rax,%rdi
   140007e2d:	e8 9e 0a 00 00       	call   1400088d0 <__mult_D2A>
   140007e32:	48 89 f1             	mov    %rsi,%rcx
   140007e35:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
   140007e3a:	e8 a1 08 00 00       	call   1400086e0 <__Bfree_D2A>
   140007e3f:	48 8b 74 24 50       	mov    0x50(%rsp),%rsi
   140007e44:	29 6c 24 7c          	sub    %ebp,0x7c(%rsp)
   140007e48:	44 8b 8c 24 88 00 00 	mov    0x88(%rsp),%r9d
   140007e4f:	00 
   140007e50:	0f 84 a7 f7 ff ff    	je     1400075fd <__gdtoa+0x9fd>
   140007e56:	e9 89 f7 ff ff       	jmp    1400075e4 <__gdtoa+0x9e4>
   140007e5b:	4c 8b 64 24 58       	mov    0x58(%rsp),%r12
   140007e60:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
   140007e65:	e9 f4 f5 ff ff       	jmp    14000745e <__gdtoa+0x85e>
   140007e6a:	48 89 f1             	mov    %rsi,%rcx
   140007e6d:	ba 01 00 00 00       	mov    $0x1,%edx
   140007e72:	4c 89 5c 24 30       	mov    %r11,0x30(%rsp)
   140007e77:	e8 44 0d 00 00       	call   140008bc0 <__lshift_D2A>
   140007e7c:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
   140007e81:	48 89 c1             	mov    %rax,%rcx
   140007e84:	48 89 c6             	mov    %rax,%rsi
   140007e87:	e8 44 0e 00 00       	call   140008cd0 <__cmp_D2A>
   140007e8c:	4c 8b 5c 24 30       	mov    0x30(%rsp),%r11
   140007e91:	85 c0                	test   %eax,%eax
   140007e93:	0f 8f b0 fe ff ff    	jg     140007d49 <__gdtoa+0x1149>
   140007e99:	75 0a                	jne    140007ea5 <__gdtoa+0x12a5>
   140007e9b:	41 83 e5 01          	and    $0x1,%r13d
   140007e9f:	0f 85 a4 fe ff ff    	jne    140007d49 <__gdtoa+0x1149>
   140007ea5:	83 7e 14 01          	cmpl   $0x1,0x14(%rsi)
   140007ea9:	c7 44 24 44 10 00 00 	movl   $0x10,0x44(%rsp)
   140007eb0:	00 
   140007eb1:	0f 8f a9 fc ff ff    	jg     140007b60 <__gdtoa+0xf60>
   140007eb7:	8b 46 18             	mov    0x18(%rsi),%eax
   140007eba:	e9 88 fc ff ff       	jmp    140007b47 <__gdtoa+0xf47>
   140007ebf:	90                   	nop
   140007ec0:	44 8b 44 24 78       	mov    0x78(%rsp),%r8d
   140007ec5:	49 89 da             	mov    %rbx,%r10
   140007ec8:	4c 8b 5c 24 38       	mov    0x38(%rsp),%r11
   140007ecd:	48 8b 5c 24 68       	mov    0x68(%rsp),%rbx
   140007ed2:	45 85 c0             	test   %r8d,%r8d
   140007ed5:	0f 84 c1 01 00 00    	je     14000809c <__gdtoa+0x149c>
   140007edb:	83 7e 14 01          	cmpl   $0x1,0x14(%rsi)
   140007edf:	0f 8e 97 03 00 00    	jle    14000827c <__gdtoa+0x167c>
   140007ee5:	83 7c 24 78 02       	cmpl   $0x2,0x78(%rsp)
   140007eea:	0f 84 05 02 00 00    	je     1400080f5 <__gdtoa+0x14f5>
   140007ef0:	4c 89 d5             	mov    %r10,%rbp
   140007ef3:	4d 89 df             	mov    %r11,%r15
   140007ef6:	48 89 5c 24 30       	mov    %rbx,0x30(%rsp)
   140007efb:	eb 49                	jmp    140007f46 <__gdtoa+0x1346>
   140007efd:	0f 1f 00             	nopl   (%rax)
   140007f00:	45 31 c0             	xor    %r8d,%r8d
   140007f03:	4c 89 e1             	mov    %r12,%rcx
   140007f06:	44 88 6b ff          	mov    %r13b,-0x1(%rbx)
   140007f0a:	ba 0a 00 00 00       	mov    $0xa,%edx
   140007f0f:	e8 3c 08 00 00       	call   140008750 <__multadd_D2A>
   140007f14:	4c 39 e7             	cmp    %r12,%rdi
   140007f17:	48 89 f1             	mov    %rsi,%rcx
   140007f1a:	ba 0a 00 00 00       	mov    $0xa,%edx
   140007f1f:	48 0f 44 f8          	cmove  %rax,%rdi
   140007f23:	45 31 c0             	xor    %r8d,%r8d
   140007f26:	49 89 c6             	mov    %rax,%r14
   140007f29:	e8 22 08 00 00       	call   140008750 <__multadd_D2A>
   140007f2e:	4c 89 fa             	mov    %r15,%rdx
   140007f31:	48 89 dd             	mov    %rbx,%rbp
   140007f34:	48 89 c1             	mov    %rax,%rcx
   140007f37:	48 89 c6             	mov    %rax,%rsi
   140007f3a:	4d 89 f4             	mov    %r14,%r12
   140007f3d:	e8 3e eb ff ff       	call   140006a80 <__quorem_D2A>
   140007f42:	44 8d 68 30          	lea    0x30(%rax),%r13d
   140007f46:	48 8d 5d 01          	lea    0x1(%rbp),%rbx
   140007f4a:	4c 89 e2             	mov    %r12,%rdx
   140007f4d:	4c 89 f9             	mov    %r15,%rcx
   140007f50:	e8 7b 0d 00 00       	call   140008cd0 <__cmp_D2A>
   140007f55:	85 c0                	test   %eax,%eax
   140007f57:	7f a7                	jg     140007f00 <__gdtoa+0x1300>
   140007f59:	41 83 fd 39          	cmp    $0x39,%r13d
   140007f5d:	49 89 ea             	mov    %rbp,%r10
   140007f60:	4d 89 fb             	mov    %r15,%r11
   140007f63:	48 89 dd             	mov    %rbx,%rbp
   140007f66:	48 8b 5c 24 30       	mov    0x30(%rsp),%rbx
   140007f6b:	0f 84 9f 01 00 00    	je     140008110 <__gdtoa+0x1510>
   140007f71:	49 89 ff             	mov    %rdi,%r15
   140007f74:	41 83 c5 01          	add    $0x1,%r13d
   140007f78:	4c 89 e7             	mov    %r12,%rdi
   140007f7b:	c7 44 24 44 20 00 00 	movl   $0x20,0x44(%rsp)
   140007f82:	00 
   140007f83:	45 88 2a             	mov    %r13b,(%r10)
   140007f86:	e9 65 fa ff ff       	jmp    1400079f0 <__gdtoa+0xdf0>
   140007f8b:	85 c0                	test   %eax,%eax
   140007f8d:	0f 84 fe f4 ff ff    	je     140007491 <__gdtoa+0x891>
   140007f93:	44 8b 9c 24 9c 00 00 	mov    0x9c(%rsp),%r11d
   140007f9a:	00 
   140007f9b:	45 85 db             	test   %r11d,%r11d
   140007f9e:	0f 8e 41 f5 ff ff    	jle    1400074e5 <__gdtoa+0x8e5>
   140007fa4:	f2 0f 59 05 9c 36 00 	mulsd  0x369c(%rip),%xmm0        # 14000b648 <.rdata+0x48>
   140007fab:	00 
   140007fac:	bf ff ff ff ff       	mov    $0xffffffff,%edi
   140007fb1:	f2 0f 10 0d 97 36 00 	movsd  0x3697(%rip),%xmm1        # 14000b650 <.rdata+0x50>
   140007fb8:	00 
   140007fb9:	f2 0f 59 c8          	mulsd  %xmm0,%xmm1
   140007fbd:	66 49 0f 7e c2       	movq   %xmm0,%r10
   140007fc2:	f2 0f 58 0d 8e 36 00 	addsd  0x368e(%rip),%xmm1        # 14000b658 <.rdata+0x58>
   140007fc9:	00 
   140007fca:	66 48 0f 7e c8       	movq   %xmm1,%rax
   140007fcf:	48 89 c2             	mov    %rax,%rdx
   140007fd2:	89 c0                	mov    %eax,%eax
   140007fd4:	48 c1 ea 20          	shr    $0x20,%rdx
   140007fd8:	81 ea 00 00 40 03    	sub    $0x3400000,%edx
   140007fde:	48 c1 e2 20          	shl    $0x20,%rdx
   140007fe2:	48 09 d0             	or     %rdx,%rax
   140007fe5:	e9 6b f1 ff ff       	jmp    140007155 <__gdtoa+0x555>
   140007fea:	8b 4f 08             	mov    0x8(%rdi),%ecx
   140007fed:	4c 89 5c 24 38       	mov    %r11,0x38(%rsp)
   140007ff2:	e8 e9 05 00 00       	call   1400085e0 <__Balloc_D2A>
   140007ff7:	48 8d 57 10          	lea    0x10(%rdi),%rdx
   140007ffb:	48 8d 48 10          	lea    0x10(%rax),%rcx
   140007fff:	48 89 c5             	mov    %rax,%rbp
   140008002:	48 63 47 14          	movslq 0x14(%rdi),%rax
   140008006:	4c 8d 04 85 08 00 00 	lea    0x8(,%rax,4),%r8
   14000800d:	00 
   14000800e:	e8 95 18 00 00       	call   1400098a8 <memcpy>
   140008013:	ba 01 00 00 00       	mov    $0x1,%edx
   140008018:	48 89 e9             	mov    %rbp,%rcx
   14000801b:	e8 a0 0b 00 00       	call   140008bc0 <__lshift_D2A>
   140008020:	4c 8b 5c 24 38       	mov    0x38(%rsp),%r11
   140008025:	49 89 c4             	mov    %rax,%r12
   140008028:	e9 3f f8 ff ff       	jmp    14000786c <__gdtoa+0xc6c>
   14000802d:	4c 8b 64 24 58       	mov    0x58(%rsp),%r12
   140008032:	c7 44 24 50 02 00 00 	movl   $0x2,0x50(%rsp)
   140008039:	00 
   14000803a:	45 31 db             	xor    %r11d,%r11d
   14000803d:	31 ff                	xor    %edi,%edi
   14000803f:	e9 f2 f3 ff ff       	jmp    140007436 <__gdtoa+0x836>
   140008044:	41 83 fd 39          	cmp    $0x39,%r13d
   140008048:	49 89 da             	mov    %rbx,%r10
   14000804b:	4c 8b 5c 24 38       	mov    0x38(%rsp),%r11
   140008050:	48 8b 5c 24 68       	mov    0x68(%rsp),%rbx
   140008055:	0f 84 b5 00 00 00    	je     140008110 <__gdtoa+0x1510>
   14000805b:	45 8d 45 01          	lea    0x1(%r13),%r8d
   14000805f:	49 89 ff             	mov    %rdi,%r15
   140008062:	c7 44 24 44 20 00 00 	movl   $0x20,0x44(%rsp)
   140008069:	00 
   14000806a:	4c 89 e7             	mov    %r12,%rdi
   14000806d:	45 88 02             	mov    %r8b,(%r10)
   140008070:	e9 7b f9 ff ff       	jmp    1400079f0 <__gdtoa+0xdf0>
   140008075:	49 89 ff             	mov    %rdi,%r15
   140008078:	4c 8b 5c 24 38       	mov    0x38(%rsp),%r11
   14000807d:	4c 89 e7             	mov    %r12,%rdi
   140008080:	48 8b 5c 24 68       	mov    0x68(%rsp),%rbx
   140008085:	e9 91 fa ff ff       	jmp    140007b1b <__gdtoa+0xf1b>
   14000808a:	48 89 4c 24 58       	mov    %rcx,0x58(%rsp)
   14000808f:	83 c7 01             	add    $0x1,%edi
   140008092:	ba 31 00 00 00       	mov    $0x31,%edx
   140008097:	e9 b5 f1 ff ff       	jmp    140007251 <__gdtoa+0x651>
   14000809c:	85 d2                	test   %edx,%edx
   14000809e:	7e 4b                	jle    1400080eb <__gdtoa+0x14eb>
   1400080a0:	48 89 f1             	mov    %rsi,%rcx
   1400080a3:	ba 01 00 00 00       	mov    $0x1,%edx
   1400080a8:	4c 89 5c 24 30       	mov    %r11,0x30(%rsp)
   1400080ad:	4c 89 54 24 38       	mov    %r10,0x38(%rsp)
   1400080b2:	e8 09 0b 00 00       	call   140008bc0 <__lshift_D2A>
   1400080b7:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
   1400080bc:	48 89 c1             	mov    %rax,%rcx
   1400080bf:	48 89 c6             	mov    %rax,%rsi
   1400080c2:	e8 09 0c 00 00       	call   140008cd0 <__cmp_D2A>
   1400080c7:	4c 8b 5c 24 30       	mov    0x30(%rsp),%r11
   1400080cc:	85 c0                	test   %eax,%eax
   1400080ce:	4c 8b 54 24 38       	mov    0x38(%rsp),%r10
   1400080d3:	0f 8e 4f 02 00 00    	jle    140008328 <__gdtoa+0x1728>
   1400080d9:	41 83 fd 39          	cmp    $0x39,%r13d
   1400080dd:	74 2d                	je     14000810c <__gdtoa+0x150c>
   1400080df:	45 8d 6e 31          	lea    0x31(%r14),%r13d
   1400080e3:	c7 44 24 78 20 00 00 	movl   $0x20,0x78(%rsp)
   1400080ea:	00 
   1400080eb:	83 7e 14 01          	cmpl   $0x1,0x14(%rsi)
   1400080ef:	0f 8e 11 02 00 00    	jle    140008306 <__gdtoa+0x1706>
   1400080f5:	49 89 ff             	mov    %rdi,%r15
   1400080f8:	4c 89 e7             	mov    %r12,%rdi
   1400080fb:	c7 44 24 44 10 00 00 	movl   $0x10,0x44(%rsp)
   140008102:	00 
   140008103:	49 8d 6a 01          	lea    0x1(%r10),%rbp
   140008107:	e9 77 fe ff ff       	jmp    140007f83 <__gdtoa+0x1383>
   14000810c:	49 8d 6a 01          	lea    0x1(%r10),%rbp
   140008110:	49 89 ff             	mov    %rdi,%r15
   140008113:	48 8b 54 24 58       	mov    0x58(%rsp),%rdx
   140008118:	49 89 ee             	mov    %rbp,%r14
   14000811b:	41 c6 02 39          	movb   $0x39,(%r10)
   14000811f:	4c 89 e7             	mov    %r12,%rdi
   140008122:	e9 32 fc ff ff       	jmp    140007d59 <__gdtoa+0x1159>
   140008127:	c7 84 24 9c 00 00 00 	movl   $0xffffffff,0x9c(%rsp)
   14000812e:	ff ff ff ff 
   140008132:	e9 d5 f3 ff ff       	jmp    14000750c <__gdtoa+0x90c>
   140008137:	8b 84 24 9c 00 00 00 	mov    0x9c(%rsp),%eax
   14000813e:	44 89 6c 24 68       	mov    %r13d,0x68(%rsp)
   140008143:	89 44 24 48          	mov    %eax,0x48(%rsp)
   140008147:	e9 65 f5 ff ff       	jmp    1400076b1 <__gdtoa+0xab1>
   14000814c:	f2 0f 58 c0          	addsd  %xmm0,%xmm0
   140008150:	0f b6 50 ff          	movzbl -0x1(%rax),%edx
   140008154:	66 0f 2f c2          	comisd %xmm2,%xmm0
   140008158:	0f 87 97 01 00 00    	ja     1400082f5 <__gdtoa+0x16f5>
   14000815e:	66 0f 2e c2          	ucomisd %xmm2,%xmm0
   140008162:	4c 8b 64 24 58       	mov    0x58(%rsp),%r12
   140008167:	8b 7c 24 68          	mov    0x68(%rsp),%edi
   14000816b:	7a 0b                	jp     140008178 <__gdtoa+0x1578>
   14000816d:	75 09                	jne    140008178 <__gdtoa+0x1578>
   14000816f:	80 e1 01             	and    $0x1,%cl
   140008172:	0f 85 c5 f0 ff ff    	jne    14000723d <__gdtoa+0x63d>
   140008178:	c7 44 24 44 10 00 00 	movl   $0x10,0x44(%rsp)
   14000817f:	00 
   140008180:	48 89 c2             	mov    %rax,%rdx
   140008183:	80 7a ff 30          	cmpb   $0x30,-0x1(%rdx)
   140008187:	48 8d 40 ff          	lea    -0x1(%rax),%rax
   14000818b:	74 f3                	je     140008180 <__gdtoa+0x1580>
   14000818d:	8d 47 01             	lea    0x1(%rdi),%eax
   140008190:	48 89 54 24 58       	mov    %rdx,0x58(%rsp)
   140008195:	89 44 24 50          	mov    %eax,0x50(%rsp)
   140008199:	e9 c0 f2 ff ff       	jmp    14000745e <__gdtoa+0x85e>
   14000819e:	31 d2                	xor    %edx,%edx
   1400081a0:	66 0f ef c9          	pxor   %xmm1,%xmm1
   1400081a4:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
   1400081a8:	b9 01 00 00 00       	mov    $0x1,%ecx
   1400081ad:	4c 8b 64 24 58       	mov    0x58(%rsp),%r12
   1400081b2:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
   1400081b7:	0f 9a c2             	setp   %dl
   1400081ba:	0f 45 d1             	cmovne %ecx,%edx
   1400081bd:	83 c7 01             	add    $0x1,%edi
   1400081c0:	89 7c 24 50          	mov    %edi,0x50(%rsp)
   1400081c4:	c1 e2 04             	shl    $0x4,%edx
   1400081c7:	89 54 24 44          	mov    %edx,0x44(%rsp)
   1400081cb:	e9 8e f2 ff ff       	jmp    14000745e <__gdtoa+0x85e>
   1400081d0:	4c 8b 64 24 58       	mov    0x58(%rsp),%r12
   1400081d5:	48 89 c1             	mov    %rax,%rcx
   1400081d8:	e9 63 f0 ff ff       	jmp    140007240 <__gdtoa+0x640>
   1400081dd:	66 0f 28 c8          	movapd %xmm0,%xmm1
   1400081e1:	e9 c9 f5 ff ff       	jmp    1400077af <__gdtoa+0xbaf>
   1400081e6:	8b 7c 24 60          	mov    0x60(%rsp),%edi
   1400081ea:	89 d0                	mov    %edx,%eax
   1400081ec:	89 94 24 ac 00 00 00 	mov    %edx,0xac(%rsp)
   1400081f3:	41 01 d1             	add    %edx,%r9d
   1400081f6:	01 f8                	add    %edi,%eax
   1400081f8:	89 bc 24 84 00 00 00 	mov    %edi,0x84(%rsp)
   1400081ff:	89 44 24 60          	mov    %eax,0x60(%rsp)
   140008203:	e9 75 f3 ff ff       	jmp    14000757d <__gdtoa+0x97d>
   140008208:	45 31 c0             	xor    %r8d,%r8d
   14000820b:	48 89 f9             	mov    %rdi,%rcx
   14000820e:	ba 0a 00 00 00       	mov    $0xa,%edx
   140008213:	e8 38 05 00 00       	call   140008750 <__multadd_D2A>
   140008218:	45 84 e4             	test   %r12b,%r12b
   14000821b:	4c 8b 5c 24 38       	mov    0x38(%rsp),%r11
   140008220:	48 89 c7             	mov    %rax,%rdi
   140008223:	0f 85 0e ff ff ff    	jne    140008137 <__gdtoa+0x1537>
   140008229:	8b 44 24 68          	mov    0x68(%rsp),%eax
   14000822d:	89 44 24 50          	mov    %eax,0x50(%rsp)
   140008231:	8b 84 24 9c 00 00 00 	mov    0x9c(%rsp),%eax
   140008238:	89 44 24 48          	mov    %eax,0x48(%rsp)
   14000823c:	e9 f8 f5 ff ff       	jmp    140007839 <__gdtoa+0xc39>
   140008241:	31 d2                	xor    %edx,%edx
   140008243:	66 0f ef c0          	pxor   %xmm0,%xmm0
   140008247:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
   14000824b:	b9 01 00 00 00       	mov    $0x1,%ecx
   140008250:	4c 8b 64 24 58       	mov    0x58(%rsp),%r12
   140008255:	0f 9a c2             	setp   %dl
   140008258:	0f 45 d1             	cmovne %ecx,%edx
   14000825b:	c1 e2 04             	shl    $0x4,%edx
   14000825e:	89 54 24 44          	mov    %edx,0x44(%rsp)
   140008262:	e9 19 ff ff ff       	jmp    140008180 <__gdtoa+0x1580>
   140008267:	0f b6 50 ff          	movzbl -0x1(%rax),%edx
   14000826b:	48 89 c1             	mov    %rax,%rcx
   14000826e:	4c 8b 64 24 58       	mov    0x58(%rsp),%r12
   140008273:	8b 7c 24 68          	mov    0x68(%rsp),%edi
   140008277:	e9 c4 ef ff ff       	jmp    140007240 <__gdtoa+0x640>
   14000827c:	8b 4e 18             	mov    0x18(%rsi),%ecx
   14000827f:	85 c9                	test   %ecx,%ecx
   140008281:	0f 85 5e fc ff ff    	jne    140007ee5 <__gdtoa+0x12e5>
   140008287:	85 d2                	test   %edx,%edx
   140008289:	0f 8f 11 fe ff ff    	jg     1400080a0 <__gdtoa+0x14a0>
   14000828f:	49 8d 6a 01          	lea    0x1(%r10),%rbp
   140008293:	49 89 ff             	mov    %rdi,%r15
   140008296:	4c 89 e7             	mov    %r12,%rdi
   140008299:	e9 e5 fc ff ff       	jmp    140007f83 <__gdtoa+0x1383>
   14000829e:	8b 7c 24 48          	mov    0x48(%rsp),%edi
   1400082a2:	8b 4c 24 7c          	mov    0x7c(%rsp),%ecx
   1400082a6:	8d 47 ff             	lea    -0x1(%rdi),%eax
   1400082a9:	39 c1                	cmp    %eax,%ecx
   1400082ab:	0f 8c d9 fa ff ff    	jl     140007d8a <__gdtoa+0x118a>
   1400082b1:	29 c1                	sub    %eax,%ecx
   1400082b3:	41 01 f9             	add    %edi,%r9d
   1400082b6:	89 f8                	mov    %edi,%eax
   1400082b8:	89 bc 24 ac 00 00 00 	mov    %edi,0xac(%rsp)
   1400082bf:	8b 7c 24 60          	mov    0x60(%rsp),%edi
   1400082c3:	89 cd                	mov    %ecx,%ebp
   1400082c5:	01 f8                	add    %edi,%eax
   1400082c7:	89 bc 24 84 00 00 00 	mov    %edi,0x84(%rsp)
   1400082ce:	89 44 24 60          	mov    %eax,0x60(%rsp)
   1400082d2:	e9 a6 f2 ff ff       	jmp    14000757d <__gdtoa+0x97d>
   1400082d7:	8b 44 24 60          	mov    0x60(%rsp),%eax
   1400082db:	c7 44 24 78 00 00 00 	movl   $0x0,0x78(%rsp)
   1400082e2:	00 
   1400082e3:	31 ff                	xor    %edi,%edi
   1400082e5:	8b 6c 24 7c          	mov    0x7c(%rsp),%ebp
   1400082e9:	89 84 24 84 00 00 00 	mov    %eax,0x84(%rsp)
   1400082f0:	e9 a7 f2 ff ff       	jmp    14000759c <__gdtoa+0x99c>
   1400082f5:	4c 8b 64 24 58       	mov    0x58(%rsp),%r12
   1400082fa:	48 89 c1             	mov    %rax,%rcx
   1400082fd:	8b 7c 24 68          	mov    0x68(%rsp),%edi
   140008301:	e9 3a ef ff ff       	jmp    140007240 <__gdtoa+0x640>
   140008306:	8b 56 18             	mov    0x18(%rsi),%edx
   140008309:	49 89 ff             	mov    %rdi,%r15
   14000830c:	4c 89 e7             	mov    %r12,%rdi
   14000830f:	85 d2                	test   %edx,%edx
   140008311:	0f 85 e4 fd ff ff    	jne    1400080fb <__gdtoa+0x14fb>
   140008317:	8b 44 24 78          	mov    0x78(%rsp),%eax
   14000831b:	49 8d 6a 01          	lea    0x1(%r10),%rbp
   14000831f:	89 44 24 44          	mov    %eax,0x44(%rsp)
   140008323:	e9 5b fc ff ff       	jmp    140007f83 <__gdtoa+0x1383>
   140008328:	75 0a                	jne    140008334 <__gdtoa+0x1734>
   14000832a:	41 f6 c5 01          	test   $0x1,%r13b
   14000832e:	0f 85 a5 fd ff ff    	jne    1400080d9 <__gdtoa+0x14d9>
   140008334:	c7 44 24 78 20 00 00 	movl   $0x20,0x78(%rsp)
   14000833b:	00 
   14000833c:	e9 aa fd ff ff       	jmp    1400080eb <__gdtoa+0x14eb>
   140008341:	83 7e 14 01          	cmpl   $0x1,0x14(%rsi)
   140008345:	c7 44 24 44 10 00 00 	movl   $0x10,0x44(%rsp)
   14000834c:	00 
   14000834d:	0f 8f 8f f6 ff ff    	jg     1400079e2 <__gdtoa+0xde2>
   140008353:	31 c0                	xor    %eax,%eax
   140008355:	83 7e 18 00          	cmpl   $0x0,0x18(%rsi)
   140008359:	0f 95 c0             	setne  %al
   14000835c:	c1 e0 04             	shl    $0x4,%eax
   14000835f:	89 44 24 44          	mov    %eax,0x44(%rsp)
   140008363:	e9 7a f6 ff ff       	jmp    1400079e2 <__gdtoa+0xde2>
   140008368:	90                   	nop
   140008369:	90                   	nop
   14000836a:	90                   	nop
   14000836b:	90                   	nop
   14000836c:	90                   	nop
   14000836d:	90                   	nop
   14000836e:	90                   	nop
   14000836f:	90                   	nop

0000000140008370 <__rshift_D2A>:
   140008370:	41 54                	push   %r12
   140008372:	55                   	push   %rbp
   140008373:	57                   	push   %rdi
   140008374:	56                   	push   %rsi
   140008375:	53                   	push   %rbx
   140008376:	48 63 59 14          	movslq 0x14(%rcx),%rbx
   14000837a:	89 d5                	mov    %edx,%ebp
   14000837c:	49 89 ca             	mov    %rcx,%r10
   14000837f:	c1 fd 05             	sar    $0x5,%ebp
   140008382:	39 eb                	cmp    %ebp,%ebx
   140008384:	7f 1a                	jg     1400083a0 <__rshift_D2A+0x30>
   140008386:	41 c7 42 14 00 00 00 	movl   $0x0,0x14(%r10)
   14000838d:	00 
   14000838e:	41 c7 42 18 00 00 00 	movl   $0x0,0x18(%r10)
   140008395:	00 
   140008396:	5b                   	pop    %rbx
   140008397:	5e                   	pop    %rsi
   140008398:	5f                   	pop    %rdi
   140008399:	5d                   	pop    %rbp
   14000839a:	41 5c                	pop    %r12
   14000839c:	c3                   	ret
   14000839d:	0f 1f 00             	nopl   (%rax)
   1400083a0:	4c 8d 61 18          	lea    0x18(%rcx),%r12
   1400083a4:	48 63 ed             	movslq %ebp,%rbp
   1400083a7:	83 e2 1f             	and    $0x1f,%edx
   1400083aa:	4d 8d 1c 9c          	lea    (%r12,%rbx,4),%r11
   1400083ae:	49 8d 34 ac          	lea    (%r12,%rbp,4),%rsi
   1400083b2:	74 64                	je     140008418 <__rshift_D2A+0xa8>
   1400083b4:	44 8b 0e             	mov    (%rsi),%r9d
   1400083b7:	4c 8d 46 04          	lea    0x4(%rsi),%r8
   1400083bb:	bf 20 00 00 00       	mov    $0x20,%edi
   1400083c0:	89 d1                	mov    %edx,%ecx
   1400083c2:	29 d7                	sub    %edx,%edi
   1400083c4:	41 d3 e9             	shr    %cl,%r9d
   1400083c7:	4d 39 d8             	cmp    %r11,%r8
   1400083ca:	0f 83 80 00 00 00    	jae    140008450 <__rshift_D2A+0xe0>
   1400083d0:	4c 89 e6             	mov    %r12,%rsi
   1400083d3:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   1400083d8:	41 8b 00             	mov    (%r8),%eax
   1400083db:	89 f9                	mov    %edi,%ecx
   1400083dd:	48 83 c6 04          	add    $0x4,%rsi
   1400083e1:	49 83 c0 04          	add    $0x4,%r8
   1400083e5:	d3 e0                	shl    %cl,%eax
   1400083e7:	89 d1                	mov    %edx,%ecx
   1400083e9:	44 09 c8             	or     %r9d,%eax
   1400083ec:	89 46 fc             	mov    %eax,-0x4(%rsi)
   1400083ef:	45 8b 48 fc          	mov    -0x4(%r8),%r9d
   1400083f3:	41 d3 e9             	shr    %cl,%r9d
   1400083f6:	4d 39 d8             	cmp    %r11,%r8
   1400083f9:	72 dd                	jb     1400083d8 <__rshift_D2A+0x68>
   1400083fb:	48 29 eb             	sub    %rbp,%rbx
   1400083fe:	45 85 c9             	test   %r9d,%r9d
   140008401:	49 8d 44 9c fc       	lea    -0x4(%r12,%rbx,4),%rax
   140008406:	44 89 08             	mov    %r9d,(%rax)
   140008409:	74 2a                	je     140008435 <__rshift_D2A+0xc5>
   14000840b:	48 83 c0 04          	add    $0x4,%rax
   14000840f:	eb 24                	jmp    140008435 <__rshift_D2A+0xc5>
   140008411:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140008418:	4c 39 de             	cmp    %r11,%rsi
   14000841b:	4c 89 e7             	mov    %r12,%rdi
   14000841e:	0f 83 62 ff ff ff    	jae    140008386 <__rshift_D2A+0x16>
   140008424:	0f 1f 40 00          	nopl   0x0(%rax)
   140008428:	a5                   	movsl  %ds:(%rsi),%es:(%rdi)
   140008429:	4c 39 de             	cmp    %r11,%rsi
   14000842c:	72 fa                	jb     140008428 <__rshift_D2A+0xb8>
   14000842e:	48 29 eb             	sub    %rbp,%rbx
   140008431:	49 8d 04 9c          	lea    (%r12,%rbx,4),%rax
   140008435:	4c 29 e0             	sub    %r12,%rax
   140008438:	48 c1 f8 02          	sar    $0x2,%rax
   14000843c:	85 c0                	test   %eax,%eax
   14000843e:	41 89 42 14          	mov    %eax,0x14(%r10)
   140008442:	0f 84 46 ff ff ff    	je     14000838e <__rshift_D2A+0x1e>
   140008448:	5b                   	pop    %rbx
   140008449:	5e                   	pop    %rsi
   14000844a:	5f                   	pop    %rdi
   14000844b:	5d                   	pop    %rbp
   14000844c:	41 5c                	pop    %r12
   14000844e:	c3                   	ret
   14000844f:	90                   	nop
   140008450:	45 85 c9             	test   %r9d,%r9d
   140008453:	45 89 4a 18          	mov    %r9d,0x18(%r10)
   140008457:	0f 84 29 ff ff ff    	je     140008386 <__rshift_D2A+0x16>
   14000845d:	4c 89 e0             	mov    %r12,%rax
   140008460:	eb a9                	jmp    14000840b <__rshift_D2A+0x9b>
   140008462:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   140008469:	00 00 00 00 
   14000846d:	0f 1f 00             	nopl   (%rax)

0000000140008470 <__trailz_D2A>:
   140008470:	48 63 51 14          	movslq 0x14(%rcx),%rdx
   140008474:	48 8d 41 18          	lea    0x18(%rcx),%rax
   140008478:	48 8d 0c 90          	lea    (%rax,%rdx,4),%rcx
   14000847c:	31 d2                	xor    %edx,%edx
   14000847e:	48 39 c8             	cmp    %rcx,%rax
   140008481:	72 11                	jb     140008494 <__trailz_D2A+0x24>
   140008483:	eb 21                	jmp    1400084a6 <__trailz_D2A+0x36>
   140008485:	0f 1f 00             	nopl   (%rax)
   140008488:	48 83 c0 04          	add    $0x4,%rax
   14000848c:	83 c2 20             	add    $0x20,%edx
   14000848f:	48 39 c8             	cmp    %rcx,%rax
   140008492:	73 12                	jae    1400084a6 <__trailz_D2A+0x36>
   140008494:	44 8b 00             	mov    (%rax),%r8d
   140008497:	45 85 c0             	test   %r8d,%r8d
   14000849a:	74 ec                	je     140008488 <__trailz_D2A+0x18>
   14000849c:	48 39 c8             	cmp    %rcx,%rax
   14000849f:	73 05                	jae    1400084a6 <__trailz_D2A+0x36>
   1400084a1:	0f bc 00             	bsf    (%rax),%eax
   1400084a4:	01 c2                	add    %eax,%edx
   1400084a6:	89 d0                	mov    %edx,%eax
   1400084a8:	c3                   	ret
   1400084a9:	90                   	nop
   1400084aa:	90                   	nop
   1400084ab:	90                   	nop
   1400084ac:	90                   	nop
   1400084ad:	90                   	nop
   1400084ae:	90                   	nop
   1400084af:	90                   	nop

00000001400084b0 <dtoa_lock>:
   1400084b0:	57                   	push   %rdi
   1400084b1:	56                   	push   %rsi
   1400084b2:	53                   	push   %rbx
   1400084b3:	48 83 ec 20          	sub    $0x20,%rsp
   1400084b7:	8b 05 33 66 00 00    	mov    0x6633(%rip),%eax        # 14000eaf0 <dtoa_CS_init>
   1400084bd:	83 f8 02             	cmp    $0x2,%eax
   1400084c0:	89 ce                	mov    %ecx,%esi
   1400084c2:	0f 84 b8 00 00 00    	je     140008580 <dtoa_lock+0xd0>
   1400084c8:	85 c0                	test   %eax,%eax
   1400084ca:	74 3c                	je     140008508 <dtoa_lock+0x58>
   1400084cc:	83 f8 01             	cmp    $0x1,%eax
   1400084cf:	75 2a                	jne    1400084fb <dtoa_lock+0x4b>
   1400084d1:	48 8b 1d 3c 6d 00 00 	mov    0x6d3c(%rip),%rbx        # 14000f214 <__imp_Sleep>
   1400084d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   1400084df:	00 
   1400084e0:	b9 01 00 00 00       	mov    $0x1,%ecx
   1400084e5:	ff d3                	call   *%rbx
   1400084e7:	8b 05 03 66 00 00    	mov    0x6603(%rip),%eax        # 14000eaf0 <dtoa_CS_init>
   1400084ed:	83 f8 01             	cmp    $0x1,%eax
   1400084f0:	74 ee                	je     1400084e0 <dtoa_lock+0x30>
   1400084f2:	83 f8 02             	cmp    $0x2,%eax
   1400084f5:	0f 84 85 00 00 00    	je     140008580 <dtoa_lock+0xd0>
   1400084fb:	48 83 c4 20          	add    $0x20,%rsp
   1400084ff:	5b                   	pop    %rbx
   140008500:	5e                   	pop    %rsi
   140008501:	5f                   	pop    %rdi
   140008502:	c3                   	ret
   140008503:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140008508:	b8 01 00 00 00       	mov    $0x1,%eax
   14000850d:	87 05 dd 65 00 00    	xchg   %eax,0x65dd(%rip)        # 14000eaf0 <dtoa_CS_init>
   140008513:	85 c0                	test   %eax,%eax
   140008515:	75 49                	jne    140008560 <dtoa_lock+0xb0>
   140008517:	48 8d 1d e2 65 00 00 	lea    0x65e2(%rip),%rbx        # 14000eb00 <dtoa_CritSec>
   14000851e:	48 8b 3d c7 6c 00 00 	mov    0x6cc7(%rip),%rdi        # 14000f1ec <__imp_InitializeCriticalSection>
   140008525:	48 89 d9             	mov    %rbx,%rcx
   140008528:	ff d7                	call   *%rdi
   14000852a:	48 8d 4b 28          	lea    0x28(%rbx),%rcx
   14000852e:	ff d7                	call   *%rdi
   140008530:	48 8d 0d 59 00 00 00 	lea    0x59(%rip),%rcx        # 140008590 <dtoa_lock_cleanup>
   140008537:	e8 d4 8e ff ff       	call   140001410 <atexit>
   14000853c:	c7 05 aa 65 00 00 02 	movl   $0x2,0x65aa(%rip)        # 14000eaf0 <dtoa_CS_init>
   140008543:	00 00 00 
   140008546:	48 63 ce             	movslq %esi,%rcx
   140008549:	48 8d 04 89          	lea    (%rcx,%rcx,4),%rax
   14000854d:	48 8d 0c c3          	lea    (%rbx,%rax,8),%rcx
   140008551:	48 83 c4 20          	add    $0x20,%rsp
   140008555:	5b                   	pop    %rbx
   140008556:	5e                   	pop    %rsi
   140008557:	5f                   	pop    %rdi
   140008558:	48 ff 25 7d 6c 00 00 	rex.W jmp *0x6c7d(%rip)        # 14000f1dc <__imp_EnterCriticalSection>
   14000855f:	90                   	nop
   140008560:	48 8d 1d 99 65 00 00 	lea    0x6599(%rip),%rbx        # 14000eb00 <dtoa_CritSec>
   140008567:	83 f8 02             	cmp    $0x2,%eax
   14000856a:	74 d0                	je     14000853c <dtoa_lock+0x8c>
   14000856c:	8b 05 7e 65 00 00    	mov    0x657e(%rip),%eax        # 14000eaf0 <dtoa_CS_init>
   140008572:	83 f8 01             	cmp    $0x1,%eax
   140008575:	0f 84 56 ff ff ff    	je     1400084d1 <dtoa_lock+0x21>
   14000857b:	e9 72 ff ff ff       	jmp    1400084f2 <dtoa_lock+0x42>
   140008580:	48 8d 1d 79 65 00 00 	lea    0x6579(%rip),%rbx        # 14000eb00 <dtoa_CritSec>
   140008587:	eb bd                	jmp    140008546 <dtoa_lock+0x96>
   140008589:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000140008590 <dtoa_lock_cleanup>:
   140008590:	53                   	push   %rbx
   140008591:	48 83 ec 20          	sub    $0x20,%rsp
   140008595:	b8 03 00 00 00       	mov    $0x3,%eax
   14000859a:	87 05 50 65 00 00    	xchg   %eax,0x6550(%rip)        # 14000eaf0 <dtoa_CS_init>
   1400085a0:	83 f8 02             	cmp    $0x2,%eax
   1400085a3:	74 0b                	je     1400085b0 <dtoa_lock_cleanup+0x20>
   1400085a5:	48 83 c4 20          	add    $0x20,%rsp
   1400085a9:	5b                   	pop    %rbx
   1400085aa:	c3                   	ret
   1400085ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   1400085b0:	48 8b 1d 1d 6c 00 00 	mov    0x6c1d(%rip),%rbx        # 14000f1d4 <__IAT_start__>
   1400085b7:	48 8d 0d 42 65 00 00 	lea    0x6542(%rip),%rcx        # 14000eb00 <dtoa_CritSec>
   1400085be:	ff d3                	call   *%rbx
   1400085c0:	48 8d 0d 61 65 00 00 	lea    0x6561(%rip),%rcx        # 14000eb28 <dtoa_CritSec+0x28>
   1400085c7:	48 89 d8             	mov    %rbx,%rax
   1400085ca:	48 83 c4 20          	add    $0x20,%rsp
   1400085ce:	5b                   	pop    %rbx
   1400085cf:	48 ff e0             	rex.W jmp *%rax
   1400085d2:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   1400085d9:	00 00 00 00 
   1400085dd:	0f 1f 00             	nopl   (%rax)

00000001400085e0 <__Balloc_D2A>:
   1400085e0:	56                   	push   %rsi
   1400085e1:	53                   	push   %rbx
   1400085e2:	48 83 ec 38          	sub    $0x38,%rsp
   1400085e6:	89 cb                	mov    %ecx,%ebx
   1400085e8:	31 c9                	xor    %ecx,%ecx
   1400085ea:	e8 c1 fe ff ff       	call   1400084b0 <dtoa_lock>
   1400085ef:	83 fb 09             	cmp    $0x9,%ebx
   1400085f2:	7f 44                	jg     140008638 <__Balloc_D2A+0x58>
   1400085f4:	48 8d 15 a5 64 00 00 	lea    0x64a5(%rip),%rdx        # 14000eaa0 <freelist>
   1400085fb:	48 63 cb             	movslq %ebx,%rcx
   1400085fe:	48 8b 04 ca          	mov    (%rdx,%rcx,8),%rax
   140008602:	48 85 c0             	test   %rax,%rax
   140008605:	0f 84 85 00 00 00    	je     140008690 <__Balloc_D2A+0xb0>
   14000860b:	4c 8b 00             	mov    (%rax),%r8
   14000860e:	83 3d db 64 00 00 02 	cmpl   $0x2,0x64db(%rip)        # 14000eaf0 <dtoa_CS_init>
   140008615:	4c 89 04 ca          	mov    %r8,(%rdx,%rcx,8)
   140008619:	75 5f                	jne    14000867a <__Balloc_D2A+0x9a>
   14000861b:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
   140008620:	48 8d 0d d9 64 00 00 	lea    0x64d9(%rip),%rcx        # 14000eb00 <dtoa_CritSec>
   140008627:	ff 15 cf 6b 00 00    	call   *0x6bcf(%rip)        # 14000f1fc <__imp_LeaveCriticalSection>
   14000862d:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
   140008632:	eb 46                	jmp    14000867a <__Balloc_D2A+0x9a>
   140008634:	0f 1f 40 00          	nopl   0x0(%rax)
   140008638:	89 d9                	mov    %ebx,%ecx
   14000863a:	be 01 00 00 00       	mov    $0x1,%esi
   14000863f:	d3 e6                	shl    %cl,%esi
   140008641:	48 63 c6             	movslq %esi,%rax
   140008644:	48 8d 0c 85 23 00 00 	lea    0x23(,%rax,4),%rcx
   14000864b:	00 
   14000864c:	48 c1 e9 03          	shr    $0x3,%rcx
   140008650:	89 c9                	mov    %ecx,%ecx
   140008652:	48 c1 e1 03          	shl    $0x3,%rcx
   140008656:	e8 45 12 00 00       	call   1400098a0 <malloc>
   14000865b:	48 85 c0             	test   %rax,%rax
   14000865e:	74 22                	je     140008682 <__Balloc_D2A+0xa2>
   140008660:	83 3d 89 64 00 00 02 	cmpl   $0x2,0x6489(%rip)        # 14000eaf0 <dtoa_CS_init>
   140008667:	66 0f 6e c3          	movd   %ebx,%xmm0
   14000866b:	66 0f 6e ce          	movd   %esi,%xmm1
   14000866f:	66 0f 62 c1          	punpckldq %xmm1,%xmm0
   140008673:	66 0f d6 40 08       	movq   %xmm0,0x8(%rax)
   140008678:	74 a1                	je     14000861b <__Balloc_D2A+0x3b>
   14000867a:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
   140008681:	00 
   140008682:	48 83 c4 38          	add    $0x38,%rsp
   140008686:	5b                   	pop    %rbx
   140008687:	5e                   	pop    %rsi
   140008688:	c3                   	ret
   140008689:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140008690:	4c 8d 05 09 5b 00 00 	lea    0x5b09(%rip),%r8        # 14000e1a0 <private_mem>
   140008697:	89 d9                	mov    %ebx,%ecx
   140008699:	be 01 00 00 00       	mov    $0x1,%esi
   14000869e:	d3 e6                	shl    %cl,%esi
   1400086a0:	8d 46 09             	lea    0x9(%rsi),%eax
   1400086a3:	48 98                	cltq
   1400086a5:	48 8d 0c 85 ff ff ff 	lea    -0x1(,%rax,4),%rcx
   1400086ac:	ff 
   1400086ad:	48 8b 05 bc 19 00 00 	mov    0x19bc(%rip),%rax        # 14000a070 <pmem_next>
   1400086b4:	48 c1 e9 03          	shr    $0x3,%rcx
   1400086b8:	48 89 c2             	mov    %rax,%rdx
   1400086bb:	4c 29 c2             	sub    %r8,%rdx
   1400086be:	48 c1 fa 03          	sar    $0x3,%rdx
   1400086c2:	48 01 ca             	add    %rcx,%rdx
   1400086c5:	48 81 fa 20 01 00 00 	cmp    $0x120,%rdx
   1400086cc:	77 84                	ja     140008652 <__Balloc_D2A+0x72>
   1400086ce:	48 8d 14 c8          	lea    (%rax,%rcx,8),%rdx
   1400086d2:	48 89 15 97 19 00 00 	mov    %rdx,0x1997(%rip)        # 14000a070 <pmem_next>
   1400086d9:	eb 85                	jmp    140008660 <__Balloc_D2A+0x80>
   1400086db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000001400086e0 <__Bfree_D2A>:
   1400086e0:	53                   	push   %rbx
   1400086e1:	48 83 ec 20          	sub    $0x20,%rsp
   1400086e5:	48 85 c9             	test   %rcx,%rcx
   1400086e8:	48 89 cb             	mov    %rcx,%rbx
   1400086eb:	74 39                	je     140008726 <__Bfree_D2A+0x46>
   1400086ed:	83 79 08 09          	cmpl   $0x9,0x8(%rcx)
   1400086f1:	7e 0d                	jle    140008700 <__Bfree_D2A+0x20>
   1400086f3:	48 83 c4 20          	add    $0x20,%rsp
   1400086f7:	5b                   	pop    %rbx
   1400086f8:	e9 8b 11 00 00       	jmp    140009888 <free>
   1400086fd:	0f 1f 00             	nopl   (%rax)
   140008700:	31 c9                	xor    %ecx,%ecx
   140008702:	e8 a9 fd ff ff       	call   1400084b0 <dtoa_lock>
   140008707:	48 63 53 08          	movslq 0x8(%rbx),%rdx
   14000870b:	48 8d 05 8e 63 00 00 	lea    0x638e(%rip),%rax        # 14000eaa0 <freelist>
   140008712:	83 3d d7 63 00 00 02 	cmpl   $0x2,0x63d7(%rip)        # 14000eaf0 <dtoa_CS_init>
   140008719:	48 8b 0c d0          	mov    (%rax,%rdx,8),%rcx
   14000871d:	48 89 1c d0          	mov    %rbx,(%rax,%rdx,8)
   140008721:	48 89 0b             	mov    %rcx,(%rbx)
   140008724:	74 0a                	je     140008730 <__Bfree_D2A+0x50>
   140008726:	48 83 c4 20          	add    $0x20,%rsp
   14000872a:	5b                   	pop    %rbx
   14000872b:	c3                   	ret
   14000872c:	0f 1f 40 00          	nopl   0x0(%rax)
   140008730:	48 8d 0d c9 63 00 00 	lea    0x63c9(%rip),%rcx        # 14000eb00 <dtoa_CritSec>
   140008737:	48 83 c4 20          	add    $0x20,%rsp
   14000873b:	5b                   	pop    %rbx
   14000873c:	48 ff 25 b9 6a 00 00 	rex.W jmp *0x6ab9(%rip)        # 14000f1fc <__imp_LeaveCriticalSection>
   140008743:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   14000874a:	00 00 00 00 
   14000874e:	66 90                	xchg   %ax,%ax

0000000140008750 <__multadd_D2A>:
   140008750:	55                   	push   %rbp
   140008751:	57                   	push   %rdi
   140008752:	56                   	push   %rsi
   140008753:	53                   	push   %rbx
   140008754:	48 83 ec 28          	sub    $0x28,%rsp
   140008758:	8b 79 14             	mov    0x14(%rcx),%edi
   14000875b:	48 89 cb             	mov    %rcx,%rbx
   14000875e:	49 63 f0             	movslq %r8d,%rsi
   140008761:	48 63 d2             	movslq %edx,%rdx
   140008764:	31 c9                	xor    %ecx,%ecx
   140008766:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   14000876d:	00 00 00 
   140008770:	8b 44 8b 18          	mov    0x18(%rbx,%rcx,4),%eax
   140008774:	48 0f af c2          	imul   %rdx,%rax
   140008778:	48 01 f0             	add    %rsi,%rax
   14000877b:	48 89 c6             	mov    %rax,%rsi
   14000877e:	89 44 8b 18          	mov    %eax,0x18(%rbx,%rcx,4)
   140008782:	48 83 c1 01          	add    $0x1,%rcx
   140008786:	48 c1 ee 20          	shr    $0x20,%rsi
   14000878a:	39 cf                	cmp    %ecx,%edi
   14000878c:	7f e2                	jg     140008770 <__multadd_D2A+0x20>
   14000878e:	48 85 f6             	test   %rsi,%rsi
   140008791:	48 89 dd             	mov    %rbx,%rbp
   140008794:	74 15                	je     1400087ab <__multadd_D2A+0x5b>
   140008796:	39 7b 0c             	cmp    %edi,0xc(%rbx)
   140008799:	7e 25                	jle    1400087c0 <__multadd_D2A+0x70>
   14000879b:	48 63 c7             	movslq %edi,%rax
   14000879e:	83 c7 01             	add    $0x1,%edi
   1400087a1:	48 89 dd             	mov    %rbx,%rbp
   1400087a4:	89 74 83 18          	mov    %esi,0x18(%rbx,%rax,4)
   1400087a8:	89 7b 14             	mov    %edi,0x14(%rbx)
   1400087ab:	48 89 e8             	mov    %rbp,%rax
   1400087ae:	48 83 c4 28          	add    $0x28,%rsp
   1400087b2:	5b                   	pop    %rbx
   1400087b3:	5e                   	pop    %rsi
   1400087b4:	5f                   	pop    %rdi
   1400087b5:	5d                   	pop    %rbp
   1400087b6:	c3                   	ret
   1400087b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   1400087be:	00 00 
   1400087c0:	8b 43 08             	mov    0x8(%rbx),%eax
   1400087c3:	8d 48 01             	lea    0x1(%rax),%ecx
   1400087c6:	e8 15 fe ff ff       	call   1400085e0 <__Balloc_D2A>
   1400087cb:	48 85 c0             	test   %rax,%rax
   1400087ce:	48 89 c5             	mov    %rax,%rbp
   1400087d1:	74 d8                	je     1400087ab <__multadd_D2A+0x5b>
   1400087d3:	48 8d 48 10          	lea    0x10(%rax),%rcx
   1400087d7:	48 63 43 14          	movslq 0x14(%rbx),%rax
   1400087db:	48 8d 53 10          	lea    0x10(%rbx),%rdx
   1400087df:	4c 8d 04 85 08 00 00 	lea    0x8(,%rax,4),%r8
   1400087e6:	00 
   1400087e7:	e8 bc 10 00 00       	call   1400098a8 <memcpy>
   1400087ec:	48 89 d9             	mov    %rbx,%rcx
   1400087ef:	48 89 eb             	mov    %rbp,%rbx
   1400087f2:	e8 e9 fe ff ff       	call   1400086e0 <__Bfree_D2A>
   1400087f7:	48 63 c7             	movslq %edi,%rax
   1400087fa:	83 c7 01             	add    $0x1,%edi
   1400087fd:	48 89 dd             	mov    %rbx,%rbp
   140008800:	89 74 83 18          	mov    %esi,0x18(%rbx,%rax,4)
   140008804:	89 7b 14             	mov    %edi,0x14(%rbx)
   140008807:	eb a2                	jmp    1400087ab <__multadd_D2A+0x5b>
   140008809:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000140008810 <__i2b_D2A>:
   140008810:	53                   	push   %rbx
   140008811:	48 83 ec 30          	sub    $0x30,%rsp
   140008815:	89 cb                	mov    %ecx,%ebx
   140008817:	31 c9                	xor    %ecx,%ecx
   140008819:	e8 92 fc ff ff       	call   1400084b0 <dtoa_lock>
   14000881e:	48 8b 05 83 62 00 00 	mov    0x6283(%rip),%rax        # 14000eaa8 <freelist+0x8>
   140008825:	48 85 c0             	test   %rax,%rax
   140008828:	74 2e                	je     140008858 <__i2b_D2A+0x48>
   14000882a:	48 8b 10             	mov    (%rax),%rdx
   14000882d:	83 3d bc 62 00 00 02 	cmpl   $0x2,0x62bc(%rip)        # 14000eaf0 <dtoa_CS_init>
   140008834:	48 89 15 6d 62 00 00 	mov    %rdx,0x626d(%rip)        # 14000eaa8 <freelist+0x8>
   14000883b:	74 63                	je     1400088a0 <__i2b_D2A+0x90>
   14000883d:	48 8b 15 ac 2f 00 00 	mov    0x2fac(%rip),%rdx        # 14000b7f0 <__bigtens_D2A+0x30>
   140008844:	89 58 18             	mov    %ebx,0x18(%rax)
   140008847:	48 89 50 10          	mov    %rdx,0x10(%rax)
   14000884b:	48 83 c4 30          	add    $0x30,%rsp
   14000884f:	5b                   	pop    %rbx
   140008850:	c3                   	ret
   140008851:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140008858:	48 8b 05 11 18 00 00 	mov    0x1811(%rip),%rax        # 14000a070 <pmem_next>
   14000885f:	48 8d 0d 3a 59 00 00 	lea    0x593a(%rip),%rcx        # 14000e1a0 <private_mem>
   140008866:	48 89 c2             	mov    %rax,%rdx
   140008869:	48 29 ca             	sub    %rcx,%rdx
   14000886c:	48 c1 fa 03          	sar    $0x3,%rdx
   140008870:	48 83 c2 05          	add    $0x5,%rdx
   140008874:	48 81 fa 20 01 00 00 	cmp    $0x120,%rdx
   14000887b:	76 43                	jbe    1400088c0 <__i2b_D2A+0xb0>
   14000887d:	b9 28 00 00 00       	mov    $0x28,%ecx
   140008882:	e8 19 10 00 00       	call   1400098a0 <malloc>
   140008887:	48 85 c0             	test   %rax,%rax
   14000888a:	74 bf                	je     14000884b <__i2b_D2A+0x3b>
   14000888c:	48 8b 15 55 2f 00 00 	mov    0x2f55(%rip),%rdx        # 14000b7e8 <__bigtens_D2A+0x28>
   140008893:	83 3d 56 62 00 00 02 	cmpl   $0x2,0x6256(%rip)        # 14000eaf0 <dtoa_CS_init>
   14000889a:	48 89 50 08          	mov    %rdx,0x8(%rax)
   14000889e:	75 9d                	jne    14000883d <__i2b_D2A+0x2d>
   1400088a0:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
   1400088a5:	48 8d 0d 54 62 00 00 	lea    0x6254(%rip),%rcx        # 14000eb00 <dtoa_CritSec>
   1400088ac:	ff 15 4a 69 00 00    	call   *0x694a(%rip)        # 14000f1fc <__imp_LeaveCriticalSection>
   1400088b2:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
   1400088b7:	eb 84                	jmp    14000883d <__i2b_D2A+0x2d>
   1400088b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   1400088c0:	48 8d 50 28          	lea    0x28(%rax),%rdx
   1400088c4:	48 89 15 a5 17 00 00 	mov    %rdx,0x17a5(%rip)        # 14000a070 <pmem_next>
   1400088cb:	eb bf                	jmp    14000888c <__i2b_D2A+0x7c>
   1400088cd:	0f 1f 00             	nopl   (%rax)

00000001400088d0 <__mult_D2A>:
   1400088d0:	41 57                	push   %r15
   1400088d2:	41 56                	push   %r14
   1400088d4:	41 55                	push   %r13
   1400088d6:	41 54                	push   %r12
   1400088d8:	55                   	push   %rbp
   1400088d9:	57                   	push   %rdi
   1400088da:	56                   	push   %rsi
   1400088db:	53                   	push   %rbx
   1400088dc:	48 83 ec 28          	sub    $0x28,%rsp
   1400088e0:	4c 63 69 14          	movslq 0x14(%rcx),%r13
   1400088e4:	48 63 6a 14          	movslq 0x14(%rdx),%rbp
   1400088e8:	49 89 cc             	mov    %rcx,%r12
   1400088eb:	49 89 d7             	mov    %rdx,%r15
   1400088ee:	41 39 ed             	cmp    %ebp,%r13d
   1400088f1:	7c 0e                	jl     140008901 <__mult_D2A+0x31>
   1400088f3:	89 e8                	mov    %ebp,%eax
   1400088f5:	49 89 cf             	mov    %rcx,%r15
   1400088f8:	49 63 ed             	movslq %r13d,%rbp
   1400088fb:	49 89 d4             	mov    %rdx,%r12
   1400088fe:	4c 63 e8             	movslq %eax,%r13
   140008901:	42 8d 5c 2d 00       	lea    0x0(%rbp,%r13,1),%ebx
   140008906:	41 39 5f 0c          	cmp    %ebx,0xc(%r15)
   14000890a:	41 8b 4f 08          	mov    0x8(%r15),%ecx
   14000890e:	7d 03                	jge    140008913 <__mult_D2A+0x43>
   140008910:	83 c1 01             	add    $0x1,%ecx
   140008913:	e8 c8 fc ff ff       	call   1400085e0 <__Balloc_D2A>
   140008918:	48 85 c0             	test   %rax,%rax
   14000891b:	48 89 c7             	mov    %rax,%rdi
   14000891e:	0f 84 ef 00 00 00    	je     140008a13 <__mult_D2A+0x143>
   140008924:	4c 8d 58 18          	lea    0x18(%rax),%r11
   140008928:	48 63 c3             	movslq %ebx,%rax
   14000892b:	49 8d 34 83          	lea    (%r11,%rax,4),%rsi
   14000892f:	49 39 f3             	cmp    %rsi,%r11
   140008932:	73 23                	jae    140008957 <__mult_D2A+0x87>
   140008934:	48 89 f0             	mov    %rsi,%rax
   140008937:	4c 89 d9             	mov    %r11,%rcx
   14000893a:	31 d2                	xor    %edx,%edx
   14000893c:	48 29 f8             	sub    %rdi,%rax
   14000893f:	48 83 e8 19          	sub    $0x19,%rax
   140008943:	48 c1 e8 02          	shr    $0x2,%rax
   140008947:	4c 8d 04 85 04 00 00 	lea    0x4(,%rax,4),%r8
   14000894e:	00 
   14000894f:	e8 5c 0f 00 00       	call   1400098b0 <memset>
   140008954:	49 89 c3             	mov    %rax,%r11
   140008957:	4d 8d 4c 24 18       	lea    0x18(%r12),%r9
   14000895c:	4f 8d 24 a9          	lea    (%r9,%r13,4),%r12
   140008960:	4d 8d 77 18          	lea    0x18(%r15),%r14
   140008964:	4d 39 e1             	cmp    %r12,%r9
   140008967:	49 8d 2c ae          	lea    (%r14,%rbp,4),%rbp
   14000896b:	0f 83 83 00 00 00    	jae    1400089f4 <__mult_D2A+0x124>
   140008971:	48 89 e8             	mov    %rbp,%rax
   140008974:	4c 29 f8             	sub    %r15,%rax
   140008977:	49 83 c7 19          	add    $0x19,%r15
   14000897b:	48 83 e8 19          	sub    $0x19,%rax
   14000897f:	48 c1 e8 02          	shr    $0x2,%rax
   140008983:	4c 39 fd             	cmp    %r15,%rbp
   140008986:	4c 8d 2c 85 04 00 00 	lea    0x4(,%rax,4),%r13
   14000898d:	00 
   14000898e:	b8 04 00 00 00       	mov    $0x4,%eax
   140008993:	4c 0f 42 e8          	cmovb  %rax,%r13
   140008997:	eb 10                	jmp    1400089a9 <__mult_D2A+0xd9>
   140008999:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   1400089a0:	49 83 c3 04          	add    $0x4,%r11
   1400089a4:	4d 39 e1             	cmp    %r12,%r9
   1400089a7:	73 4b                	jae    1400089f4 <__mult_D2A+0x124>
   1400089a9:	45 8b 11             	mov    (%r9),%r10d
   1400089ac:	49 83 c1 04          	add    $0x4,%r9
   1400089b0:	45 85 d2             	test   %r10d,%r10d
   1400089b3:	74 eb                	je     1400089a0 <__mult_D2A+0xd0>
   1400089b5:	4c 89 d9             	mov    %r11,%rcx
   1400089b8:	4c 89 f2             	mov    %r14,%rdx
   1400089bb:	45 31 c0             	xor    %r8d,%r8d
   1400089be:	66 90                	xchg   %ax,%ax
   1400089c0:	8b 02                	mov    (%rdx),%eax
   1400089c2:	48 83 c2 04          	add    $0x4,%rdx
   1400089c6:	48 83 c1 04          	add    $0x4,%rcx
   1400089ca:	44 8b 79 fc          	mov    -0x4(%rcx),%r15d
   1400089ce:	49 0f af c2          	imul   %r10,%rax
   1400089d2:	4c 01 f8             	add    %r15,%rax
   1400089d5:	4c 01 c0             	add    %r8,%rax
   1400089d8:	49 89 c0             	mov    %rax,%r8
   1400089db:	89 41 fc             	mov    %eax,-0x4(%rcx)
   1400089de:	49 c1 e8 20          	shr    $0x20,%r8
   1400089e2:	48 39 ea             	cmp    %rbp,%rdx
   1400089e5:	72 d9                	jb     1400089c0 <__mult_D2A+0xf0>
   1400089e7:	47 89 04 2b          	mov    %r8d,(%r11,%r13,1)
   1400089eb:	49 83 c3 04          	add    $0x4,%r11
   1400089ef:	4d 39 e1             	cmp    %r12,%r9
   1400089f2:	72 b5                	jb     1400089a9 <__mult_D2A+0xd9>
   1400089f4:	85 db                	test   %ebx,%ebx
   1400089f6:	7f 0d                	jg     140008a05 <__mult_D2A+0x135>
   1400089f8:	eb 16                	jmp    140008a10 <__mult_D2A+0x140>
   1400089fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140008a00:	83 eb 01             	sub    $0x1,%ebx
   140008a03:	74 0b                	je     140008a10 <__mult_D2A+0x140>
   140008a05:	8b 46 fc             	mov    -0x4(%rsi),%eax
   140008a08:	48 83 ee 04          	sub    $0x4,%rsi
   140008a0c:	85 c0                	test   %eax,%eax
   140008a0e:	74 f0                	je     140008a00 <__mult_D2A+0x130>
   140008a10:	89 5f 14             	mov    %ebx,0x14(%rdi)
   140008a13:	48 89 f8             	mov    %rdi,%rax
   140008a16:	48 83 c4 28          	add    $0x28,%rsp
   140008a1a:	5b                   	pop    %rbx
   140008a1b:	5e                   	pop    %rsi
   140008a1c:	5f                   	pop    %rdi
   140008a1d:	5d                   	pop    %rbp
   140008a1e:	41 5c                	pop    %r12
   140008a20:	41 5d                	pop    %r13
   140008a22:	41 5e                	pop    %r14
   140008a24:	41 5f                	pop    %r15
   140008a26:	c3                   	ret
   140008a27:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   140008a2e:	00 00 

0000000140008a30 <__pow5mult_D2A>:
   140008a30:	55                   	push   %rbp
   140008a31:	57                   	push   %rdi
   140008a32:	56                   	push   %rsi
   140008a33:	53                   	push   %rbx
   140008a34:	48 83 ec 28          	sub    $0x28,%rsp
   140008a38:	89 d0                	mov    %edx,%eax
   140008a3a:	48 89 ce             	mov    %rcx,%rsi
   140008a3d:	89 d3                	mov    %edx,%ebx
   140008a3f:	83 e0 03             	and    $0x3,%eax
   140008a42:	0f 85 c8 00 00 00    	jne    140008b10 <__pow5mult_D2A+0xe0>
   140008a48:	c1 fb 02             	sar    $0x2,%ebx
   140008a4b:	48 89 f5             	mov    %rsi,%rbp
   140008a4e:	85 db                	test   %ebx,%ebx
   140008a50:	74 58                	je     140008aaa <__pow5mult_D2A+0x7a>
   140008a52:	48 8b 3d 27 57 00 00 	mov    0x5727(%rip),%rdi        # 14000e180 <p5s>
   140008a59:	48 85 ff             	test   %rdi,%rdi
   140008a5c:	0f 84 de 00 00 00    	je     140008b40 <__pow5mult_D2A+0x110>
   140008a62:	48 89 f5             	mov    %rsi,%rbp
   140008a65:	eb 18                	jmp    140008a7f <__pow5mult_D2A+0x4f>
   140008a67:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   140008a6e:	00 00 
   140008a70:	d1 fb                	sar    %ebx
   140008a72:	74 36                	je     140008aaa <__pow5mult_D2A+0x7a>
   140008a74:	48 8b 37             	mov    (%rdi),%rsi
   140008a77:	48 85 f6             	test   %rsi,%rsi
   140008a7a:	74 44                	je     140008ac0 <__pow5mult_D2A+0x90>
   140008a7c:	48 89 f7             	mov    %rsi,%rdi
   140008a7f:	f6 c3 01             	test   $0x1,%bl
   140008a82:	74 ec                	je     140008a70 <__pow5mult_D2A+0x40>
   140008a84:	48 89 fa             	mov    %rdi,%rdx
   140008a87:	48 89 e9             	mov    %rbp,%rcx
   140008a8a:	e8 41 fe ff ff       	call   1400088d0 <__mult_D2A>
   140008a8f:	48 85 c0             	test   %rax,%rax
   140008a92:	48 89 c6             	mov    %rax,%rsi
   140008a95:	0f 84 98 00 00 00    	je     140008b33 <__pow5mult_D2A+0x103>
   140008a9b:	48 89 e9             	mov    %rbp,%rcx
   140008a9e:	48 89 f5             	mov    %rsi,%rbp
   140008aa1:	e8 3a fc ff ff       	call   1400086e0 <__Bfree_D2A>
   140008aa6:	d1 fb                	sar    %ebx
   140008aa8:	75 ca                	jne    140008a74 <__pow5mult_D2A+0x44>
   140008aaa:	48 89 e8             	mov    %rbp,%rax
   140008aad:	48 83 c4 28          	add    $0x28,%rsp
   140008ab1:	5b                   	pop    %rbx
   140008ab2:	5e                   	pop    %rsi
   140008ab3:	5f                   	pop    %rdi
   140008ab4:	5d                   	pop    %rbp
   140008ab5:	c3                   	ret
   140008ab6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   140008abd:	00 00 00 
   140008ac0:	b9 01 00 00 00       	mov    $0x1,%ecx
   140008ac5:	e8 e6 f9 ff ff       	call   1400084b0 <dtoa_lock>
   140008aca:	48 8b 37             	mov    (%rdi),%rsi
   140008acd:	48 85 f6             	test   %rsi,%rsi
   140008ad0:	74 1e                	je     140008af0 <__pow5mult_D2A+0xc0>
   140008ad2:	83 3d 17 60 00 00 02 	cmpl   $0x2,0x6017(%rip)        # 14000eaf0 <dtoa_CS_init>
   140008ad9:	75 a1                	jne    140008a7c <__pow5mult_D2A+0x4c>
   140008adb:	48 8d 0d 46 60 00 00 	lea    0x6046(%rip),%rcx        # 14000eb28 <dtoa_CritSec+0x28>
   140008ae2:	ff 15 14 67 00 00    	call   *0x6714(%rip)        # 14000f1fc <__imp_LeaveCriticalSection>
   140008ae8:	eb 92                	jmp    140008a7c <__pow5mult_D2A+0x4c>
   140008aea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140008af0:	48 89 fa             	mov    %rdi,%rdx
   140008af3:	48 89 f9             	mov    %rdi,%rcx
   140008af6:	e8 d5 fd ff ff       	call   1400088d0 <__mult_D2A>
   140008afb:	48 85 c0             	test   %rax,%rax
   140008afe:	48 89 c6             	mov    %rax,%rsi
   140008b01:	48 89 07             	mov    %rax,(%rdi)
   140008b04:	74 2d                	je     140008b33 <__pow5mult_D2A+0x103>
   140008b06:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   140008b0d:	eb c3                	jmp    140008ad2 <__pow5mult_D2A+0xa2>
   140008b0f:	90                   	nop
   140008b10:	48 8d 15 89 2b 00 00 	lea    0x2b89(%rip),%rdx        # 14000b6a0 <p05.0>
   140008b17:	83 e8 01             	sub    $0x1,%eax
   140008b1a:	45 31 c0             	xor    %r8d,%r8d
   140008b1d:	48 98                	cltq
   140008b1f:	8b 14 82             	mov    (%rdx,%rax,4),%edx
   140008b22:	e8 29 fc ff ff       	call   140008750 <__multadd_D2A>
   140008b27:	48 85 c0             	test   %rax,%rax
   140008b2a:	48 89 c6             	mov    %rax,%rsi
   140008b2d:	0f 85 15 ff ff ff    	jne    140008a48 <__pow5mult_D2A+0x18>
   140008b33:	31 ed                	xor    %ebp,%ebp
   140008b35:	e9 70 ff ff ff       	jmp    140008aaa <__pow5mult_D2A+0x7a>
   140008b3a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140008b40:	b9 01 00 00 00       	mov    $0x1,%ecx
   140008b45:	e8 66 f9 ff ff       	call   1400084b0 <dtoa_lock>
   140008b4a:	48 8b 3d 2f 56 00 00 	mov    0x562f(%rip),%rdi        # 14000e180 <p5s>
   140008b51:	48 85 ff             	test   %rdi,%rdi
   140008b54:	74 1f                	je     140008b75 <__pow5mult_D2A+0x145>
   140008b56:	83 3d 93 5f 00 00 02 	cmpl   $0x2,0x5f93(%rip)        # 14000eaf0 <dtoa_CS_init>
   140008b5d:	0f 85 ff fe ff ff    	jne    140008a62 <__pow5mult_D2A+0x32>
   140008b63:	48 8d 0d be 5f 00 00 	lea    0x5fbe(%rip),%rcx        # 14000eb28 <dtoa_CritSec+0x28>
   140008b6a:	ff 15 8c 66 00 00    	call   *0x668c(%rip)        # 14000f1fc <__imp_LeaveCriticalSection>
   140008b70:	e9 ed fe ff ff       	jmp    140008a62 <__pow5mult_D2A+0x32>
   140008b75:	b9 01 00 00 00       	mov    $0x1,%ecx
   140008b7a:	e8 61 fa ff ff       	call   1400085e0 <__Balloc_D2A>
   140008b7f:	48 85 c0             	test   %rax,%rax
   140008b82:	48 89 c7             	mov    %rax,%rdi
   140008b85:	74 1e                	je     140008ba5 <__pow5mult_D2A+0x175>
   140008b87:	48 b8 01 00 00 00 71 	movabs $0x27100000001,%rax
   140008b8e:	02 00 00 
   140008b91:	48 89 3d e8 55 00 00 	mov    %rdi,0x55e8(%rip)        # 14000e180 <p5s>
   140008b98:	48 89 47 14          	mov    %rax,0x14(%rdi)
   140008b9c:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
   140008ba3:	eb b1                	jmp    140008b56 <__pow5mult_D2A+0x126>
   140008ba5:	48 c7 05 d0 55 00 00 	movq   $0x0,0x55d0(%rip)        # 14000e180 <p5s>
   140008bac:	00 00 00 00 
   140008bb0:	31 ed                	xor    %ebp,%ebp
   140008bb2:	e9 f3 fe ff ff       	jmp    140008aaa <__pow5mult_D2A+0x7a>
   140008bb7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   140008bbe:	00 00 

0000000140008bc0 <__lshift_D2A>:
   140008bc0:	41 56                	push   %r14
   140008bc2:	41 55                	push   %r13
   140008bc4:	41 54                	push   %r12
   140008bc6:	55                   	push   %rbp
   140008bc7:	57                   	push   %rdi
   140008bc8:	56                   	push   %rsi
   140008bc9:	53                   	push   %rbx
   140008bca:	48 83 ec 20          	sub    $0x20,%rsp
   140008bce:	49 89 cc             	mov    %rcx,%r12
   140008bd1:	89 d6                	mov    %edx,%esi
   140008bd3:	8b 49 08             	mov    0x8(%rcx),%ecx
   140008bd6:	89 d5                	mov    %edx,%ebp
   140008bd8:	41 8b 5c 24 14       	mov    0x14(%r12),%ebx
   140008bdd:	c1 fe 05             	sar    $0x5,%esi
   140008be0:	41 8b 44 24 0c       	mov    0xc(%r12),%eax
   140008be5:	01 f3                	add    %esi,%ebx
   140008be7:	44 8d 6b 01          	lea    0x1(%rbx),%r13d
   140008beb:	41 39 c5             	cmp    %eax,%r13d
   140008bee:	7e 0a                	jle    140008bfa <__lshift_D2A+0x3a>
   140008bf0:	01 c0                	add    %eax,%eax
   140008bf2:	83 c1 01             	add    $0x1,%ecx
   140008bf5:	41 39 c5             	cmp    %eax,%r13d
   140008bf8:	7f f6                	jg     140008bf0 <__lshift_D2A+0x30>
   140008bfa:	e8 e1 f9 ff ff       	call   1400085e0 <__Balloc_D2A>
   140008bff:	48 85 c0             	test   %rax,%rax
   140008c02:	49 89 c6             	mov    %rax,%r14
   140008c05:	0f 84 a3 00 00 00    	je     140008cae <__lshift_D2A+0xee>
   140008c0b:	48 8d 78 18          	lea    0x18(%rax),%rdi
   140008c0f:	85 f6                	test   %esi,%esi
   140008c11:	7e 14                	jle    140008c27 <__lshift_D2A+0x67>
   140008c13:	48 c1 e6 02          	shl    $0x2,%rsi
   140008c17:	48 89 f9             	mov    %rdi,%rcx
   140008c1a:	31 d2                	xor    %edx,%edx
   140008c1c:	49 89 f0             	mov    %rsi,%r8
   140008c1f:	48 01 f7             	add    %rsi,%rdi
   140008c22:	e8 89 0c 00 00       	call   1400098b0 <memset>
   140008c27:	49 63 44 24 14       	movslq 0x14(%r12),%rax
   140008c2c:	49 8d 74 24 18       	lea    0x18(%r12),%rsi
   140008c31:	83 e5 1f             	and    $0x1f,%ebp
   140008c34:	4c 8d 0c 86          	lea    (%rsi,%rax,4),%r9
   140008c38:	0f 84 82 00 00 00    	je     140008cc0 <__lshift_D2A+0x100>
   140008c3e:	41 ba 20 00 00 00    	mov    $0x20,%r10d
   140008c44:	49 89 f8             	mov    %rdi,%r8
   140008c47:	31 d2                	xor    %edx,%edx
   140008c49:	41 29 ea             	sub    %ebp,%r10d
   140008c4c:	0f 1f 40 00          	nopl   0x0(%rax)
   140008c50:	8b 06                	mov    (%rsi),%eax
   140008c52:	89 e9                	mov    %ebp,%ecx
   140008c54:	49 83 c0 04          	add    $0x4,%r8
   140008c58:	48 83 c6 04          	add    $0x4,%rsi
   140008c5c:	d3 e0                	shl    %cl,%eax
   140008c5e:	44 89 d1             	mov    %r10d,%ecx
   140008c61:	09 d0                	or     %edx,%eax
   140008c63:	41 89 40 fc          	mov    %eax,-0x4(%r8)
   140008c67:	8b 56 fc             	mov    -0x4(%rsi),%edx
   140008c6a:	d3 ea                	shr    %cl,%edx
   140008c6c:	4c 39 ce             	cmp    %r9,%rsi
   140008c6f:	72 df                	jb     140008c50 <__lshift_D2A+0x90>
   140008c71:	49 8d 4c 24 19       	lea    0x19(%r12),%rcx
   140008c76:	4c 89 c8             	mov    %r9,%rax
   140008c79:	4c 29 e0             	sub    %r12,%rax
   140008c7c:	48 83 e8 19          	sub    $0x19,%rax
   140008c80:	48 c1 e8 02          	shr    $0x2,%rax
   140008c84:	49 39 c9             	cmp    %rcx,%r9
   140008c87:	b9 04 00 00 00       	mov    $0x4,%ecx
   140008c8c:	48 8d 04 85 04 00 00 	lea    0x4(,%rax,4),%rax
   140008c93:	00 
   140008c94:	48 0f 42 c1          	cmovb  %rcx,%rax
   140008c98:	85 d2                	test   %edx,%edx
   140008c9a:	89 14 07             	mov    %edx,(%rdi,%rax,1)
   140008c9d:	75 03                	jne    140008ca2 <__lshift_D2A+0xe2>
   140008c9f:	41 89 dd             	mov    %ebx,%r13d
   140008ca2:	45 89 6e 14          	mov    %r13d,0x14(%r14)
   140008ca6:	4c 89 e1             	mov    %r12,%rcx
   140008ca9:	e8 32 fa ff ff       	call   1400086e0 <__Bfree_D2A>
   140008cae:	4c 89 f0             	mov    %r14,%rax
   140008cb1:	48 83 c4 20          	add    $0x20,%rsp
   140008cb5:	5b                   	pop    %rbx
   140008cb6:	5e                   	pop    %rsi
   140008cb7:	5f                   	pop    %rdi
   140008cb8:	5d                   	pop    %rbp
   140008cb9:	41 5c                	pop    %r12
   140008cbb:	41 5d                	pop    %r13
   140008cbd:	41 5e                	pop    %r14
   140008cbf:	c3                   	ret
   140008cc0:	a5                   	movsl  %ds:(%rsi),%es:(%rdi)
   140008cc1:	4c 39 ce             	cmp    %r9,%rsi
   140008cc4:	73 d9                	jae    140008c9f <__lshift_D2A+0xdf>
   140008cc6:	a5                   	movsl  %ds:(%rsi),%es:(%rdi)
   140008cc7:	4c 39 ce             	cmp    %r9,%rsi
   140008cca:	72 f4                	jb     140008cc0 <__lshift_D2A+0x100>
   140008ccc:	eb d1                	jmp    140008c9f <__lshift_D2A+0xdf>
   140008cce:	66 90                	xchg   %ax,%ax

0000000140008cd0 <__cmp_D2A>:
   140008cd0:	48 63 42 14          	movslq 0x14(%rdx),%rax
   140008cd4:	44 8b 49 14          	mov    0x14(%rcx),%r9d
   140008cd8:	41 29 c1             	sub    %eax,%r9d
   140008cdb:	75 37                	jne    140008d14 <__cmp_D2A+0x44>
   140008cdd:	4c 8d 04 85 00 00 00 	lea    0x0(,%rax,4),%r8
   140008ce4:	00 
   140008ce5:	48 83 c1 18          	add    $0x18,%rcx
   140008ce9:	4a 8d 04 01          	lea    (%rcx,%r8,1),%rax
   140008ced:	4a 8d 54 02 18       	lea    0x18(%rdx,%r8,1),%rdx
   140008cf2:	eb 09                	jmp    140008cfd <__cmp_D2A+0x2d>
   140008cf4:	0f 1f 40 00          	nopl   0x0(%rax)
   140008cf8:	48 39 c1             	cmp    %rax,%rcx
   140008cfb:	73 17                	jae    140008d14 <__cmp_D2A+0x44>
   140008cfd:	48 83 e8 04          	sub    $0x4,%rax
   140008d01:	48 83 ea 04          	sub    $0x4,%rdx
   140008d05:	44 8b 12             	mov    (%rdx),%r10d
   140008d08:	44 39 10             	cmp    %r10d,(%rax)
   140008d0b:	74 eb                	je     140008cf8 <__cmp_D2A+0x28>
   140008d0d:	45 19 c9             	sbb    %r9d,%r9d
   140008d10:	41 83 c9 01          	or     $0x1,%r9d
   140008d14:	44 89 c8             	mov    %r9d,%eax
   140008d17:	c3                   	ret
   140008d18:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   140008d1f:	00 

0000000140008d20 <__diff_D2A>:
   140008d20:	41 56                	push   %r14
   140008d22:	41 55                	push   %r13
   140008d24:	41 54                	push   %r12
   140008d26:	55                   	push   %rbp
   140008d27:	57                   	push   %rdi
   140008d28:	56                   	push   %rsi
   140008d29:	53                   	push   %rbx
   140008d2a:	48 83 ec 20          	sub    $0x20,%rsp
   140008d2e:	48 63 42 14          	movslq 0x14(%rdx),%rax
   140008d32:	8b 79 14             	mov    0x14(%rcx),%edi
   140008d35:	48 89 ce             	mov    %rcx,%rsi
   140008d38:	48 89 d3             	mov    %rdx,%rbx
   140008d3b:	29 c7                	sub    %eax,%edi
   140008d3d:	0f 85 55 01 00 00    	jne    140008e98 <__diff_D2A+0x178>
   140008d43:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   140008d4a:	00 
   140008d4b:	48 8d 49 18          	lea    0x18(%rcx),%rcx
   140008d4f:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
   140008d53:	48 8d 54 13 18       	lea    0x18(%rbx,%rdx,1),%rdx
   140008d58:	eb 0f                	jmp    140008d69 <__diff_D2A+0x49>
   140008d5a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140008d60:	48 39 c1             	cmp    %rax,%rcx
   140008d63:	0f 83 57 01 00 00    	jae    140008ec0 <__diff_D2A+0x1a0>
   140008d69:	48 83 e8 04          	sub    $0x4,%rax
   140008d6d:	48 83 ea 04          	sub    $0x4,%rdx
   140008d71:	44 8b 32             	mov    (%rdx),%r14d
   140008d74:	44 39 30             	cmp    %r14d,(%rax)
   140008d77:	74 e7                	je     140008d60 <__diff_D2A+0x40>
   140008d79:	0f 82 24 01 00 00    	jb     140008ea3 <__diff_D2A+0x183>
   140008d7f:	90                   	nop
   140008d80:	8b 4e 08             	mov    0x8(%rsi),%ecx
   140008d83:	e8 58 f8 ff ff       	call   1400085e0 <__Balloc_D2A>
   140008d88:	48 85 c0             	test   %rax,%rax
   140008d8b:	49 89 c1             	mov    %rax,%r9
   140008d8e:	0f 84 ef 00 00 00    	je     140008e83 <__diff_D2A+0x163>
   140008d94:	89 78 10             	mov    %edi,0x10(%rax)
   140008d97:	48 63 46 14          	movslq 0x14(%rsi),%rax
   140008d9b:	4c 8d 6e 18          	lea    0x18(%rsi),%r13
   140008d9f:	b9 18 00 00 00       	mov    $0x18,%ecx
   140008da4:	4d 8d 61 18          	lea    0x18(%r9),%r12
   140008da8:	31 d2                	xor    %edx,%edx
   140008daa:	49 8d 7c 85 00       	lea    0x0(%r13,%rax,4),%rdi
   140008daf:	49 89 c2             	mov    %rax,%r10
   140008db2:	48 63 43 14          	movslq 0x14(%rbx),%rax
   140008db6:	48 8d 6c 83 18       	lea    0x18(%rbx,%rax,4),%rbp
   140008dbb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140008dc0:	8b 04 0e             	mov    (%rsi,%rcx,1),%eax
   140008dc3:	44 8b 04 0b          	mov    (%rbx,%rcx,1),%r8d
   140008dc7:	4c 29 c0             	sub    %r8,%rax
   140008dca:	48 29 d0             	sub    %rdx,%rax
   140008dcd:	48 89 c2             	mov    %rax,%rdx
   140008dd0:	41 89 04 09          	mov    %eax,(%r9,%rcx,1)
   140008dd4:	48 83 c1 04          	add    $0x4,%rcx
   140008dd8:	41 89 c3             	mov    %eax,%r11d
   140008ddb:	48 8d 04 19          	lea    (%rcx,%rbx,1),%rax
   140008ddf:	48 c1 ea 20          	shr    $0x20,%rdx
   140008de3:	83 e2 01             	and    $0x1,%edx
   140008de6:	48 39 e8             	cmp    %rbp,%rax
   140008de9:	72 d5                	jb     140008dc0 <__diff_D2A+0xa0>
   140008deb:	48 8d 73 19          	lea    0x19(%rbx),%rsi
   140008def:	48 89 e8             	mov    %rbp,%rax
   140008df2:	b9 04 00 00 00       	mov    $0x4,%ecx
   140008df7:	48 29 d8             	sub    %rbx,%rax
   140008dfa:	4c 8d 70 e7          	lea    -0x19(%rax),%r14
   140008dfe:	49 c1 ee 02          	shr    $0x2,%r14
   140008e02:	48 39 f5             	cmp    %rsi,%rbp
   140008e05:	4a 8d 04 b5 04 00 00 	lea    0x4(,%r14,4),%rax
   140008e0c:	00 
   140008e0d:	48 0f 42 c1          	cmovb  %rcx,%rax
   140008e11:	4d 8d 04 04          	lea    (%r12,%rax,1),%r8
   140008e15:	49 01 c5             	add    %rax,%r13
   140008e18:	49 39 fd             	cmp    %rdi,%r13
   140008e1b:	4c 89 c3             	mov    %r8,%rbx
   140008e1e:	4c 89 e9             	mov    %r13,%rcx
   140008e21:	0f 83 b9 00 00 00    	jae    140008ee0 <__diff_D2A+0x1c0>
   140008e27:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   140008e2e:	00 00 
   140008e30:	8b 01                	mov    (%rcx),%eax
   140008e32:	48 83 c1 04          	add    $0x4,%rcx
   140008e36:	48 83 c3 04          	add    $0x4,%rbx
   140008e3a:	48 29 d0             	sub    %rdx,%rax
   140008e3d:	48 89 c2             	mov    %rax,%rdx
   140008e40:	41 89 c3             	mov    %eax,%r11d
   140008e43:	89 43 fc             	mov    %eax,-0x4(%rbx)
   140008e46:	48 c1 ea 20          	shr    $0x20,%rdx
   140008e4a:	83 e2 01             	and    $0x1,%edx
   140008e4d:	48 39 f9             	cmp    %rdi,%rcx
   140008e50:	72 de                	jb     140008e30 <__diff_D2A+0x110>
   140008e52:	48 83 ef 01          	sub    $0x1,%rdi
   140008e56:	4c 29 ef             	sub    %r13,%rdi
   140008e59:	48 83 e7 fc          	and    $0xfffffffffffffffc,%rdi
   140008e5d:	49 8d 04 38          	lea    (%r8,%rdi,1),%rax
   140008e61:	45 85 db             	test   %r11d,%r11d
   140008e64:	75 19                	jne    140008e7f <__diff_D2A+0x15f>
   140008e66:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   140008e6d:	00 00 00 
   140008e70:	8b 50 fc             	mov    -0x4(%rax),%edx
   140008e73:	48 83 e8 04          	sub    $0x4,%rax
   140008e77:	41 83 ea 01          	sub    $0x1,%r10d
   140008e7b:	85 d2                	test   %edx,%edx
   140008e7d:	74 f1                	je     140008e70 <__diff_D2A+0x150>
   140008e7f:	45 89 51 14          	mov    %r10d,0x14(%r9)
   140008e83:	4c 89 c8             	mov    %r9,%rax
   140008e86:	48 83 c4 20          	add    $0x20,%rsp
   140008e8a:	5b                   	pop    %rbx
   140008e8b:	5e                   	pop    %rsi
   140008e8c:	5f                   	pop    %rdi
   140008e8d:	5d                   	pop    %rbp
   140008e8e:	41 5c                	pop    %r12
   140008e90:	41 5d                	pop    %r13
   140008e92:	41 5e                	pop    %r14
   140008e94:	c3                   	ret
   140008e95:	0f 1f 00             	nopl   (%rax)
   140008e98:	bf 00 00 00 00       	mov    $0x0,%edi
   140008e9d:	0f 89 dd fe ff ff    	jns    140008d80 <__diff_D2A+0x60>
   140008ea3:	48 89 f0             	mov    %rsi,%rax
   140008ea6:	bf 01 00 00 00       	mov    $0x1,%edi
   140008eab:	48 89 de             	mov    %rbx,%rsi
   140008eae:	48 89 c3             	mov    %rax,%rbx
   140008eb1:	e9 ca fe ff ff       	jmp    140008d80 <__diff_D2A+0x60>
   140008eb6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   140008ebd:	00 00 00 
   140008ec0:	31 c9                	xor    %ecx,%ecx
   140008ec2:	e8 19 f7 ff ff       	call   1400085e0 <__Balloc_D2A>
   140008ec7:	48 85 c0             	test   %rax,%rax
   140008eca:	49 89 c1             	mov    %rax,%r9
   140008ecd:	74 b4                	je     140008e83 <__diff_D2A+0x163>
   140008ecf:	48 c7 40 14 01 00 00 	movq   $0x1,0x14(%rax)
   140008ed6:	00 
   140008ed7:	eb aa                	jmp    140008e83 <__diff_D2A+0x163>
   140008ed9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140008ee0:	31 c0                	xor    %eax,%eax
   140008ee2:	49 c1 e6 02          	shl    $0x2,%r14
   140008ee6:	48 39 f5             	cmp    %rsi,%rbp
   140008ee9:	4c 0f 42 f0          	cmovb  %rax,%r14
   140008eed:	4b 8d 04 34          	lea    (%r12,%r14,1),%rax
   140008ef1:	e9 6b ff ff ff       	jmp    140008e61 <__diff_D2A+0x141>
   140008ef6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   140008efd:	00 00 00 

0000000140008f00 <__b2d_D2A>:
   140008f00:	57                   	push   %rdi
   140008f01:	56                   	push   %rsi
   140008f02:	53                   	push   %rbx
   140008f03:	48 63 41 14          	movslq 0x14(%rcx),%rax
   140008f07:	4c 8d 51 18          	lea    0x18(%rcx),%r10
   140008f0b:	49 8d 1c 82          	lea    (%r10,%rax,4),%rbx
   140008f0f:	44 8b 5b fc          	mov    -0x4(%rbx),%r11d
   140008f13:	48 8d 73 fc          	lea    -0x4(%rbx),%rsi
   140008f17:	41 0f bd cb          	bsr    %r11d,%ecx
   140008f1b:	89 cf                	mov    %ecx,%edi
   140008f1d:	b9 20 00 00 00       	mov    $0x20,%ecx
   140008f22:	83 f7 1f             	xor    $0x1f,%edi
   140008f25:	41 89 c8             	mov    %ecx,%r8d
   140008f28:	41 29 f8             	sub    %edi,%r8d
   140008f2b:	83 ff 0a             	cmp    $0xa,%edi
   140008f2e:	44 89 02             	mov    %r8d,(%rdx)
   140008f31:	7e 7d                	jle    140008fb0 <__b2d_D2A+0xb0>
   140008f33:	44 8d 4f f5          	lea    -0xb(%rdi),%r9d
   140008f37:	49 39 f2             	cmp    %rsi,%r10
   140008f3a:	73 54                	jae    140008f90 <__b2d_D2A+0x90>
   140008f3c:	45 85 c9             	test   %r9d,%r9d
   140008f3f:	8b 53 f8             	mov    -0x8(%rbx),%edx
   140008f42:	74 53                	je     140008f97 <__b2d_D2A+0x97>
   140008f44:	44 29 c9             	sub    %r9d,%ecx
   140008f47:	44 89 d8             	mov    %r11d,%eax
   140008f4a:	89 d6                	mov    %edx,%esi
   140008f4c:	41 89 c8             	mov    %ecx,%r8d
   140008f4f:	44 89 c9             	mov    %r9d,%ecx
   140008f52:	d3 e0                	shl    %cl,%eax
   140008f54:	44 89 c1             	mov    %r8d,%ecx
   140008f57:	d3 ee                	shr    %cl,%esi
   140008f59:	44 89 c9             	mov    %r9d,%ecx
   140008f5c:	09 f0                	or     %esi,%eax
   140008f5e:	d3 e2                	shl    %cl,%edx
   140008f60:	48 8d 4b f8          	lea    -0x8(%rbx),%rcx
   140008f64:	0d 00 00 f0 3f       	or     $0x3ff00000,%eax
   140008f69:	48 c1 e0 20          	shl    $0x20,%rax
   140008f6d:	49 39 ca             	cmp    %rcx,%r10
   140008f70:	73 31                	jae    140008fa3 <__b2d_D2A+0xa3>
   140008f72:	44 8b 4b f4          	mov    -0xc(%rbx),%r9d
   140008f76:	44 89 c1             	mov    %r8d,%ecx
   140008f79:	41 d3 e9             	shr    %cl,%r9d
   140008f7c:	44 09 ca             	or     %r9d,%edx
   140008f7f:	48 09 d0             	or     %rdx,%rax
   140008f82:	66 48 0f 6e c0       	movq   %rax,%xmm0
   140008f87:	5b                   	pop    %rbx
   140008f88:	5e                   	pop    %rsi
   140008f89:	5f                   	pop    %rdi
   140008f8a:	c3                   	ret
   140008f8b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140008f90:	31 d2                	xor    %edx,%edx
   140008f92:	83 ff 0b             	cmp    $0xb,%edi
   140008f95:	75 59                	jne    140008ff0 <__b2d_D2A+0xf0>
   140008f97:	44 89 d8             	mov    %r11d,%eax
   140008f9a:	0d 00 00 f0 3f       	or     $0x3ff00000,%eax
   140008f9f:	48 c1 e0 20          	shl    $0x20,%rax
   140008fa3:	48 09 d0             	or     %rdx,%rax
   140008fa6:	66 48 0f 6e c0       	movq   %rax,%xmm0
   140008fab:	5b                   	pop    %rbx
   140008fac:	5e                   	pop    %rsi
   140008fad:	5f                   	pop    %rdi
   140008fae:	c3                   	ret
   140008faf:	90                   	nop
   140008fb0:	b9 0b 00 00 00       	mov    $0xb,%ecx
   140008fb5:	44 89 d8             	mov    %r11d,%eax
   140008fb8:	45 31 c0             	xor    %r8d,%r8d
   140008fbb:	29 f9                	sub    %edi,%ecx
   140008fbd:	d3 e8                	shr    %cl,%eax
   140008fbf:	0d 00 00 f0 3f       	or     $0x3ff00000,%eax
   140008fc4:	48 c1 e0 20          	shl    $0x20,%rax
   140008fc8:	49 39 f2             	cmp    %rsi,%r10
   140008fcb:	73 07                	jae    140008fd4 <__b2d_D2A+0xd4>
   140008fcd:	44 8b 43 f8          	mov    -0x8(%rbx),%r8d
   140008fd1:	41 d3 e8             	shr    %cl,%r8d
   140008fd4:	8d 4f 15             	lea    0x15(%rdi),%ecx
   140008fd7:	44 89 da             	mov    %r11d,%edx
   140008fda:	d3 e2                	shl    %cl,%edx
   140008fdc:	44 09 c2             	or     %r8d,%edx
   140008fdf:	48 09 d0             	or     %rdx,%rax
   140008fe2:	66 48 0f 6e c0       	movq   %rax,%xmm0
   140008fe7:	5b                   	pop    %rbx
   140008fe8:	5e                   	pop    %rsi
   140008fe9:	5f                   	pop    %rdi
   140008fea:	c3                   	ret
   140008feb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140008ff0:	44 89 d8             	mov    %r11d,%eax
   140008ff3:	44 89 c9             	mov    %r9d,%ecx
   140008ff6:	31 d2                	xor    %edx,%edx
   140008ff8:	d3 e0                	shl    %cl,%eax
   140008ffa:	0d 00 00 f0 3f       	or     $0x3ff00000,%eax
   140008fff:	48 c1 e0 20          	shl    $0x20,%rax
   140009003:	48 09 d0             	or     %rdx,%rax
   140009006:	66 48 0f 6e c0       	movq   %rax,%xmm0
   14000900b:	5b                   	pop    %rbx
   14000900c:	5e                   	pop    %rsi
   14000900d:	5f                   	pop    %rdi
   14000900e:	c3                   	ret
   14000900f:	90                   	nop

0000000140009010 <__d2b_D2A>:
   140009010:	57                   	push   %rdi
   140009011:	56                   	push   %rsi
   140009012:	53                   	push   %rbx
   140009013:	48 83 ec 20          	sub    $0x20,%rsp
   140009017:	b9 01 00 00 00       	mov    $0x1,%ecx
   14000901c:	48 89 d6             	mov    %rdx,%rsi
   14000901f:	66 48 0f 7e c3       	movq   %xmm0,%rbx
   140009024:	4c 89 c7             	mov    %r8,%rdi
   140009027:	e8 b4 f5 ff ff       	call   1400085e0 <__Balloc_D2A>
   14000902c:	48 85 c0             	test   %rax,%rax
   14000902f:	48 89 c2             	mov    %rax,%rdx
   140009032:	0f 84 97 00 00 00    	je     1400090cf <__d2b_D2A+0xbf>
   140009038:	48 89 d9             	mov    %rbx,%rcx
   14000903b:	48 89 d8             	mov    %rbx,%rax
   14000903e:	48 c1 e9 20          	shr    $0x20,%rcx
   140009042:	41 89 c9             	mov    %ecx,%r9d
   140009045:	c1 e9 14             	shr    $0x14,%ecx
   140009048:	41 81 e1 ff ff 0f 00 	and    $0xfffff,%r9d
   14000904f:	45 89 c8             	mov    %r9d,%r8d
   140009052:	41 81 c8 00 00 10 00 	or     $0x100000,%r8d
   140009059:	81 e1 ff 07 00 00    	and    $0x7ff,%ecx
   14000905f:	45 0f 45 c8          	cmovne %r8d,%r9d
   140009063:	85 db                	test   %ebx,%ebx
   140009065:	41 89 ca             	mov    %ecx,%r10d
   140009068:	74 76                	je     1400090e0 <__d2b_D2A+0xd0>
   14000906a:	44 0f bc c3          	bsf    %ebx,%r8d
   14000906e:	44 89 c1             	mov    %r8d,%ecx
   140009071:	d3 e8                	shr    %cl,%eax
   140009073:	45 85 c0             	test   %r8d,%r8d
   140009076:	74 15                	je     14000908d <__d2b_D2A+0x7d>
   140009078:	b9 20 00 00 00       	mov    $0x20,%ecx
   14000907d:	44 89 cb             	mov    %r9d,%ebx
   140009080:	44 29 c1             	sub    %r8d,%ecx
   140009083:	d3 e3                	shl    %cl,%ebx
   140009085:	44 89 c1             	mov    %r8d,%ecx
   140009088:	09 d8                	or     %ebx,%eax
   14000908a:	41 d3 e9             	shr    %cl,%r9d
   14000908d:	66 0f 6e c0          	movd   %eax,%xmm0
   140009091:	41 83 f9 01          	cmp    $0x1,%r9d
   140009095:	b8 01 00 00 00       	mov    $0x1,%eax
   14000909a:	83 d8 ff             	sbb    $0xffffffff,%eax
   14000909d:	66 41 0f 6e c9       	movd   %r9d,%xmm1
   1400090a2:	45 85 d2             	test   %r10d,%r10d
   1400090a5:	66 0f 62 c1          	punpckldq %xmm1,%xmm0
   1400090a9:	89 42 14             	mov    %eax,0x14(%rdx)
   1400090ac:	66 0f d6 42 18       	movq   %xmm0,0x18(%rdx)
   1400090b1:	75 49                	jne    1400090fc <__d2b_D2A+0xec>
   1400090b3:	48 63 c8             	movslq %eax,%rcx
   1400090b6:	41 81 e8 32 04 00 00 	sub    $0x432,%r8d
   1400090bd:	0f bd 4c 8a 14       	bsr    0x14(%rdx,%rcx,4),%ecx
   1400090c2:	c1 e0 05             	shl    $0x5,%eax
   1400090c5:	44 89 06             	mov    %r8d,(%rsi)
   1400090c8:	83 f1 1f             	xor    $0x1f,%ecx
   1400090cb:	29 c8                	sub    %ecx,%eax
   1400090cd:	89 07                	mov    %eax,(%rdi)
   1400090cf:	48 89 d0             	mov    %rdx,%rax
   1400090d2:	48 83 c4 20          	add    $0x20,%rsp
   1400090d6:	5b                   	pop    %rbx
   1400090d7:	5e                   	pop    %rsi
   1400090d8:	5f                   	pop    %rdi
   1400090d9:	c3                   	ret
   1400090da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   1400090e0:	41 0f bc c9          	bsf    %r9d,%ecx
   1400090e4:	b8 01 00 00 00       	mov    $0x1,%eax
   1400090e9:	44 8d 41 20          	lea    0x20(%rcx),%r8d
   1400090ed:	41 d3 e9             	shr    %cl,%r9d
   1400090f0:	45 85 d2             	test   %r10d,%r10d
   1400090f3:	89 42 14             	mov    %eax,0x14(%rdx)
   1400090f6:	44 89 4a 18          	mov    %r9d,0x18(%rdx)
   1400090fa:	74 b7                	je     1400090b3 <__d2b_D2A+0xa3>
   1400090fc:	43 8d 84 02 cd fb ff 	lea    -0x433(%r10,%r8,1),%eax
   140009103:	ff 
   140009104:	89 06                	mov    %eax,(%rsi)
   140009106:	b8 35 00 00 00       	mov    $0x35,%eax
   14000910b:	44 29 c0             	sub    %r8d,%eax
   14000910e:	89 07                	mov    %eax,(%rdi)
   140009110:	eb bd                	jmp    1400090cf <__d2b_D2A+0xbf>
   140009112:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   140009119:	00 00 00 00 
   14000911d:	0f 1f 00             	nopl   (%rax)

0000000140009120 <__strcp_D2A>:
   140009120:	48 89 c8             	mov    %rcx,%rax
   140009123:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
   140009127:	0f b6 12             	movzbl (%rdx),%edx
   14000912a:	84 d2                	test   %dl,%dl
   14000912c:	88 10                	mov    %dl,(%rax)
   14000912e:	74 11                	je     140009141 <__strcp_D2A+0x21>
   140009130:	0f b6 11             	movzbl (%rcx),%edx
   140009133:	48 83 c0 01          	add    $0x1,%rax
   140009137:	48 83 c1 01          	add    $0x1,%rcx
   14000913b:	84 d2                	test   %dl,%dl
   14000913d:	88 10                	mov    %dl,(%rax)
   14000913f:	75 ef                	jne    140009130 <__strcp_D2A+0x10>
   140009141:	c3                   	ret
   140009142:	90                   	nop
   140009143:	90                   	nop
   140009144:	90                   	nop
   140009145:	90                   	nop
   140009146:	90                   	nop
   140009147:	90                   	nop
   140009148:	90                   	nop
   140009149:	90                   	nop
   14000914a:	90                   	nop
   14000914b:	90                   	nop
   14000914c:	90                   	nop
   14000914d:	90                   	nop
   14000914e:	90                   	nop
   14000914f:	90                   	nop

0000000140009150 <strnlen>:
   140009150:	45 31 c0             	xor    %r8d,%r8d
   140009153:	48 85 d2             	test   %rdx,%rdx
   140009156:	48 89 c8             	mov    %rcx,%rax
   140009159:	75 14                	jne    14000916f <strnlen+0x1f>
   14000915b:	eb 17                	jmp    140009174 <strnlen+0x24>
   14000915d:	0f 1f 00             	nopl   (%rax)
   140009160:	48 83 c0 01          	add    $0x1,%rax
   140009164:	49 89 c0             	mov    %rax,%r8
   140009167:	49 29 c8             	sub    %rcx,%r8
   14000916a:	49 39 d0             	cmp    %rdx,%r8
   14000916d:	73 05                	jae    140009174 <strnlen+0x24>
   14000916f:	80 38 00             	cmpb   $0x0,(%rax)
   140009172:	75 ec                	jne    140009160 <strnlen+0x10>
   140009174:	4c 89 c0             	mov    %r8,%rax
   140009177:	c3                   	ret
   140009178:	90                   	nop
   140009179:	90                   	nop
   14000917a:	90                   	nop
   14000917b:	90                   	nop
   14000917c:	90                   	nop
   14000917d:	90                   	nop
   14000917e:	90                   	nop
   14000917f:	90                   	nop

0000000140009180 <wcsnlen>:
   140009180:	45 31 c0             	xor    %r8d,%r8d
   140009183:	48 85 d2             	test   %rdx,%rdx
   140009186:	48 89 d0             	mov    %rdx,%rax
   140009189:	75 0e                	jne    140009199 <wcsnlen+0x19>
   14000918b:	eb 17                	jmp    1400091a4 <wcsnlen+0x24>
   14000918d:	0f 1f 00             	nopl   (%rax)
   140009190:	49 83 c0 01          	add    $0x1,%r8
   140009194:	4c 39 c0             	cmp    %r8,%rax
   140009197:	74 0b                	je     1400091a4 <wcsnlen+0x24>
   140009199:	66 42 83 3c 41 00    	cmpw   $0x0,(%rcx,%r8,2)
   14000919f:	75 ef                	jne    140009190 <wcsnlen+0x10>
   1400091a1:	4c 89 c0             	mov    %r8,%rax
   1400091a4:	c3                   	ret
   1400091a5:	90                   	nop
   1400091a6:	90                   	nop
   1400091a7:	90                   	nop
   1400091a8:	90                   	nop
   1400091a9:	90                   	nop
   1400091aa:	90                   	nop
   1400091ab:	90                   	nop
   1400091ac:	90                   	nop
   1400091ad:	90                   	nop
   1400091ae:	90                   	nop
   1400091af:	90                   	nop

00000001400091b0 <__p__fmode>:
   1400091b0:	48 8b 05 e9 26 00 00 	mov    0x26e9(%rip),%rax        # 14000b8a0 <.refptr.__imp__fmode>
   1400091b7:	48 8b 00             	mov    (%rax),%rax
   1400091ba:	c3                   	ret
   1400091bb:	90                   	nop
   1400091bc:	90                   	nop
   1400091bd:	90                   	nop
   1400091be:	90                   	nop
   1400091bf:	90                   	nop

00000001400091c0 <__p__commode>:
   1400091c0:	48 8b 05 b9 26 00 00 	mov    0x26b9(%rip),%rax        # 14000b880 <.refptr.__imp__commode>
   1400091c7:	48 8b 00             	mov    (%rax),%rax
   1400091ca:	c3                   	ret
   1400091cb:	90                   	nop
   1400091cc:	90                   	nop
   1400091cd:	90                   	nop
   1400091ce:	90                   	nop
   1400091cf:	90                   	nop

00000001400091d0 <_lock_file>:
   1400091d0:	53                   	push   %rbx
   1400091d1:	48 83 ec 20          	sub    $0x20,%rsp
   1400091d5:	48 89 cb             	mov    %rcx,%rbx
   1400091d8:	31 c9                	xor    %ecx,%ecx
   1400091da:	e8 e1 00 00 00       	call   1400092c0 <__acrt_iob_func>
   1400091df:	48 39 c3             	cmp    %rax,%rbx
   1400091e2:	72 0f                	jb     1400091f3 <_lock_file+0x23>
   1400091e4:	b9 13 00 00 00       	mov    $0x13,%ecx
   1400091e9:	e8 d2 00 00 00       	call   1400092c0 <__acrt_iob_func>
   1400091ee:	48 39 c3             	cmp    %rax,%rbx
   1400091f1:	76 15                	jbe    140009208 <_lock_file+0x38>
   1400091f3:	48 8d 4b 30          	lea    0x30(%rbx),%rcx
   1400091f7:	48 83 c4 20          	add    $0x20,%rsp
   1400091fb:	5b                   	pop    %rbx
   1400091fc:	48 ff 25 d9 5f 00 00 	rex.W jmp *0x5fd9(%rip)        # 14000f1dc <__imp_EnterCriticalSection>
   140009203:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140009208:	31 c9                	xor    %ecx,%ecx
   14000920a:	e8 b1 00 00 00       	call   1400092c0 <__acrt_iob_func>
   14000920f:	48 89 c2             	mov    %rax,%rdx
   140009212:	48 89 d8             	mov    %rbx,%rax
   140009215:	48 29 d0             	sub    %rdx,%rax
   140009218:	48 c1 f8 04          	sar    $0x4,%rax
   14000921c:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
   140009222:	8d 48 10             	lea    0x10(%rax),%ecx
   140009225:	e8 26 06 00 00       	call   140009850 <_lock>
   14000922a:	81 4b 18 00 80 00 00 	orl    $0x8000,0x18(%rbx)
   140009231:	48 83 c4 20          	add    $0x20,%rsp
   140009235:	5b                   	pop    %rbx
   140009236:	c3                   	ret
   140009237:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   14000923e:	00 00 

0000000140009240 <_unlock_file>:
   140009240:	53                   	push   %rbx
   140009241:	48 83 ec 20          	sub    $0x20,%rsp
   140009245:	48 89 cb             	mov    %rcx,%rbx
   140009248:	31 c9                	xor    %ecx,%ecx
   14000924a:	e8 71 00 00 00       	call   1400092c0 <__acrt_iob_func>
   14000924f:	48 39 c3             	cmp    %rax,%rbx
   140009252:	72 0f                	jb     140009263 <_unlock_file+0x23>
   140009254:	b9 13 00 00 00       	mov    $0x13,%ecx
   140009259:	e8 62 00 00 00       	call   1400092c0 <__acrt_iob_func>
   14000925e:	48 39 c3             	cmp    %rax,%rbx
   140009261:	76 15                	jbe    140009278 <_unlock_file+0x38>
   140009263:	48 8d 4b 30          	lea    0x30(%rbx),%rcx
   140009267:	48 83 c4 20          	add    $0x20,%rsp
   14000926b:	5b                   	pop    %rbx
   14000926c:	48 ff 25 89 5f 00 00 	rex.W jmp *0x5f89(%rip)        # 14000f1fc <__imp_LeaveCriticalSection>
   140009273:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140009278:	81 63 18 ff 7f ff ff 	andl   $0xffff7fff,0x18(%rbx)
   14000927f:	31 c9                	xor    %ecx,%ecx
   140009281:	e8 3a 00 00 00       	call   1400092c0 <__acrt_iob_func>
   140009286:	48 29 c3             	sub    %rax,%rbx
   140009289:	48 c1 fb 04          	sar    $0x4,%rbx
   14000928d:	69 db ab aa aa aa    	imul   $0xaaaaaaab,%ebx,%ebx
   140009293:	8d 4b 10             	lea    0x10(%rbx),%ecx
   140009296:	48 83 c4 20          	add    $0x20,%rsp
   14000929a:	5b                   	pop    %rbx
   14000929b:	e9 c0 05 00 00       	jmp    140009860 <_unlock>

00000001400092a0 <_get_invalid_parameter_handler>:
   1400092a0:	48 8b 05 b9 58 00 00 	mov    0x58b9(%rip),%rax        # 14000eb60 <handler>
   1400092a7:	c3                   	ret
   1400092a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   1400092af:	00 

00000001400092b0 <_set_invalid_parameter_handler>:
   1400092b0:	48 89 c8             	mov    %rcx,%rax
   1400092b3:	48 87 05 a6 58 00 00 	xchg   %rax,0x58a6(%rip)        # 14000eb60 <handler>
   1400092ba:	c3                   	ret
   1400092bb:	90                   	nop
   1400092bc:	90                   	nop
   1400092bd:	90                   	nop
   1400092be:	90                   	nop
   1400092bf:	90                   	nop

00000001400092c0 <__acrt_iob_func>:
   1400092c0:	53                   	push   %rbx
   1400092c1:	48 83 ec 20          	sub    $0x20,%rsp
   1400092c5:	89 cb                	mov    %ecx,%ebx
   1400092c7:	e8 44 05 00 00       	call   140009810 <__iob_func>
   1400092cc:	89 d9                	mov    %ebx,%ecx
   1400092ce:	48 8d 14 49          	lea    (%rcx,%rcx,2),%rdx
   1400092d2:	48 c1 e2 04          	shl    $0x4,%rdx
   1400092d6:	48 01 d0             	add    %rdx,%rax
   1400092d9:	48 83 c4 20          	add    $0x20,%rsp
   1400092dd:	5b                   	pop    %rbx
   1400092de:	c3                   	ret
   1400092df:	90                   	nop

00000001400092e0 <__wcrtomb_cp>:
   1400092e0:	48 83 ec 58          	sub    $0x58,%rsp
   1400092e4:	45 85 c0             	test   %r8d,%r8d
   1400092e7:	48 89 c8             	mov    %rcx,%rax
   1400092ea:	66 89 54 24 68       	mov    %dx,0x68(%rsp)
   1400092ef:	44 89 c1             	mov    %r8d,%ecx
   1400092f2:	75 1c                	jne    140009310 <__wcrtomb_cp+0x30>
   1400092f4:	66 81 fa ff 00       	cmp    $0xff,%dx
   1400092f9:	77 59                	ja     140009354 <__wcrtomb_cp+0x74>
   1400092fb:	88 10                	mov    %dl,(%rax)
   1400092fd:	b8 01 00 00 00       	mov    $0x1,%eax
   140009302:	48 83 c4 58          	add    $0x58,%rsp
   140009306:	c3                   	ret
   140009307:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   14000930e:	00 00 
   140009310:	48 8d 54 24 4c       	lea    0x4c(%rsp),%rdx
   140009315:	44 89 4c 24 28       	mov    %r9d,0x28(%rsp)
   14000931a:	41 b9 01 00 00 00    	mov    $0x1,%r9d
   140009320:	48 89 54 24 38       	mov    %rdx,0x38(%rsp)
   140009325:	4c 8d 44 24 68       	lea    0x68(%rsp),%r8
   14000932a:	31 d2                	xor    %edx,%edx
   14000932c:	c7 44 24 4c 00 00 00 	movl   $0x0,0x4c(%rsp)
   140009333:	00 
   140009334:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
   14000933b:	00 00 
   14000933d:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   140009342:	ff 15 ec 5e 00 00    	call   *0x5eec(%rip)        # 14000f234 <__imp_WideCharToMultiByte>
   140009348:	85 c0                	test   %eax,%eax
   14000934a:	74 08                	je     140009354 <__wcrtomb_cp+0x74>
   14000934c:	8b 54 24 4c          	mov    0x4c(%rsp),%edx
   140009350:	85 d2                	test   %edx,%edx
   140009352:	74 ae                	je     140009302 <__wcrtomb_cp+0x22>
   140009354:	e8 e7 04 00 00       	call   140009840 <_errno>
   140009359:	c7 00 2a 00 00 00    	movl   $0x2a,(%rax)
   14000935f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   140009364:	48 83 c4 58          	add    $0x58,%rsp
   140009368:	c3                   	ret
   140009369:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000140009370 <wcrtomb>:
   140009370:	57                   	push   %rdi
   140009371:	56                   	push   %rsi
   140009372:	53                   	push   %rbx
   140009373:	48 83 ec 30          	sub    $0x30,%rsp
   140009377:	48 85 c9             	test   %rcx,%rcx
   14000937a:	48 89 cb             	mov    %rcx,%rbx
   14000937d:	89 d6                	mov    %edx,%esi
   14000937f:	48 8d 44 24 2b       	lea    0x2b(%rsp),%rax
   140009384:	48 0f 44 d8          	cmove  %rax,%rbx
   140009388:	e8 73 04 00 00       	call   140009800 <___mb_cur_max_func>
   14000938d:	89 c7                	mov    %eax,%edi
   14000938f:	e8 64 04 00 00       	call   1400097f8 <___lc_codepage_func>
   140009394:	0f b7 d6             	movzwl %si,%edx
   140009397:	41 89 f9             	mov    %edi,%r9d
   14000939a:	48 89 d9             	mov    %rbx,%rcx
   14000939d:	41 89 c0             	mov    %eax,%r8d
   1400093a0:	e8 3b ff ff ff       	call   1400092e0 <__wcrtomb_cp>
   1400093a5:	48 98                	cltq
   1400093a7:	48 83 c4 30          	add    $0x30,%rsp
   1400093ab:	5b                   	pop    %rbx
   1400093ac:	5e                   	pop    %rsi
   1400093ad:	5f                   	pop    %rdi
   1400093ae:	c3                   	ret
   1400093af:	90                   	nop

00000001400093b0 <wcsrtombs>:
   1400093b0:	41 56                	push   %r14
   1400093b2:	41 55                	push   %r13
   1400093b4:	41 54                	push   %r12
   1400093b6:	55                   	push   %rbp
   1400093b7:	57                   	push   %rdi
   1400093b8:	56                   	push   %rsi
   1400093b9:	53                   	push   %rbx
   1400093ba:	48 83 ec 30          	sub    $0x30,%rsp
   1400093be:	45 31 f6             	xor    %r14d,%r14d
   1400093c1:	49 89 d4             	mov    %rdx,%r12
   1400093c4:	48 89 cb             	mov    %rcx,%rbx
   1400093c7:	4c 89 c5             	mov    %r8,%rbp
   1400093ca:	e8 29 04 00 00       	call   1400097f8 <___lc_codepage_func>
   1400093cf:	89 c6                	mov    %eax,%esi
   1400093d1:	e8 2a 04 00 00       	call   140009800 <___mb_cur_max_func>
   1400093d6:	4d 8b 2c 24          	mov    (%r12),%r13
   1400093da:	89 c7                	mov    %eax,%edi
   1400093dc:	4d 85 ed             	test   %r13,%r13
   1400093df:	74 48                	je     140009429 <wcsrtombs+0x79>
   1400093e1:	48 85 db             	test   %rbx,%rbx
   1400093e4:	74 5a                	je     140009440 <wcsrtombs+0x90>
   1400093e6:	48 85 ed             	test   %rbp,%rbp
   1400093e9:	75 20                	jne    14000940b <wcsrtombs+0x5b>
   1400093eb:	e9 90 00 00 00       	jmp    140009480 <wcsrtombs+0xd0>
   1400093f0:	48 98                	cltq
   1400093f2:	48 01 c3             	add    %rax,%rbx
   1400093f5:	49 01 c6             	add    %rax,%r14
   1400093f8:	80 7b ff 00          	cmpb   $0x0,-0x1(%rbx)
   1400093fc:	0f 84 8e 00 00 00    	je     140009490 <wcsrtombs+0xe0>
   140009402:	49 83 c5 02          	add    $0x2,%r13
   140009406:	49 39 ee             	cmp    %rbp,%r14
   140009409:	73 75                	jae    140009480 <wcsrtombs+0xd0>
   14000940b:	41 0f b7 55 00       	movzwl 0x0(%r13),%edx
   140009410:	41 89 f9             	mov    %edi,%r9d
   140009413:	41 89 f0             	mov    %esi,%r8d
   140009416:	48 89 d9             	mov    %rbx,%rcx
   140009419:	e8 c2 fe ff ff       	call   1400092e0 <__wcrtomb_cp>
   14000941e:	85 c0                	test   %eax,%eax
   140009420:	7f ce                	jg     1400093f0 <wcsrtombs+0x40>
   140009422:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
   140009429:	4c 89 f0             	mov    %r14,%rax
   14000942c:	48 83 c4 30          	add    $0x30,%rsp
   140009430:	5b                   	pop    %rbx
   140009431:	5e                   	pop    %rsi
   140009432:	5f                   	pop    %rdi
   140009433:	5d                   	pop    %rbp
   140009434:	41 5c                	pop    %r12
   140009436:	41 5d                	pop    %r13
   140009438:	41 5e                	pop    %r14
   14000943a:	c3                   	ret
   14000943b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140009440:	48 8d 6c 24 2b       	lea    0x2b(%rsp),%rbp
   140009445:	eb 1f                	jmp    140009466 <wcsrtombs+0xb6>
   140009447:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   14000944e:	00 00 
   140009450:	48 63 d0             	movslq %eax,%rdx
   140009453:	83 e8 01             	sub    $0x1,%eax
   140009456:	48 98                	cltq
   140009458:	49 01 d6             	add    %rdx,%r14
   14000945b:	80 7c 04 2b 00       	cmpb   $0x0,0x2b(%rsp,%rax,1)
   140009460:	74 3e                	je     1400094a0 <wcsrtombs+0xf0>
   140009462:	49 83 c5 02          	add    $0x2,%r13
   140009466:	41 0f b7 55 00       	movzwl 0x0(%r13),%edx
   14000946b:	41 89 f9             	mov    %edi,%r9d
   14000946e:	41 89 f0             	mov    %esi,%r8d
   140009471:	48 89 e9             	mov    %rbp,%rcx
   140009474:	e8 67 fe ff ff       	call   1400092e0 <__wcrtomb_cp>
   140009479:	85 c0                	test   %eax,%eax
   14000947b:	7f d3                	jg     140009450 <wcsrtombs+0xa0>
   14000947d:	eb a3                	jmp    140009422 <wcsrtombs+0x72>
   14000947f:	90                   	nop
   140009480:	4d 89 2c 24          	mov    %r13,(%r12)
   140009484:	eb a3                	jmp    140009429 <wcsrtombs+0x79>
   140009486:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   14000948d:	00 00 00 
   140009490:	49 c7 04 24 00 00 00 	movq   $0x0,(%r12)
   140009497:	00 
   140009498:	49 83 ee 01          	sub    $0x1,%r14
   14000949c:	eb 8b                	jmp    140009429 <wcsrtombs+0x79>
   14000949e:	66 90                	xchg   %ax,%ax
   1400094a0:	49 83 ee 01          	sub    $0x1,%r14
   1400094a4:	eb 83                	jmp    140009429 <wcsrtombs+0x79>
   1400094a6:	90                   	nop
   1400094a7:	90                   	nop
   1400094a8:	90                   	nop
   1400094a9:	90                   	nop
   1400094aa:	90                   	nop
   1400094ab:	90                   	nop
   1400094ac:	90                   	nop
   1400094ad:	90                   	nop
   1400094ae:	90                   	nop
   1400094af:	90                   	nop

00000001400094b0 <__mbrtowc_cp>:
   1400094b0:	57                   	push   %rdi
   1400094b1:	53                   	push   %rbx
   1400094b2:	48 83 ec 48          	sub    $0x48,%rsp
   1400094b6:	48 85 d2             	test   %rdx,%rdx
   1400094b9:	48 89 cf             	mov    %rcx,%rdi
   1400094bc:	48 89 d3             	mov    %rdx,%rbx
   1400094bf:	0f 84 c8 00 00 00    	je     14000958d <__mbrtowc_cp+0xdd>
   1400094c5:	4d 85 c0             	test   %r8,%r8
   1400094c8:	0f 84 36 01 00 00    	je     140009604 <__mbrtowc_cp+0x154>
   1400094ce:	0f b6 12             	movzbl (%rdx),%edx
   1400094d1:	41 8b 01             	mov    (%r9),%eax
   1400094d4:	41 c7 01 00 00 00 00 	movl   $0x0,(%r9)
   1400094db:	84 d2                	test   %dl,%dl
   1400094dd:	89 44 24 3c          	mov    %eax,0x3c(%rsp)
   1400094e1:	0f 84 a1 00 00 00    	je     140009588 <__mbrtowc_cp+0xd8>
   1400094e7:	83 bc 24 88 00 00 00 	cmpl   $0x1,0x88(%rsp)
   1400094ee:	01 
   1400094ef:	76 77                	jbe    140009568 <__mbrtowc_cp+0xb8>
   1400094f1:	84 c0                	test   %al,%al
   1400094f3:	0f 85 a7 00 00 00    	jne    1400095a0 <__mbrtowc_cp+0xf0>
   1400094f9:	8b 8c 24 80 00 00 00 	mov    0x80(%rsp),%ecx
   140009500:	4c 89 4c 24 78       	mov    %r9,0x78(%rsp)
   140009505:	4c 89 44 24 70       	mov    %r8,0x70(%rsp)
   14000950a:	ff 15 e4 5c 00 00    	call   *0x5ce4(%rip)        # 14000f1f4 <__imp_IsDBCSLeadByteEx>
   140009510:	85 c0                	test   %eax,%eax
   140009512:	74 54                	je     140009568 <__mbrtowc_cp+0xb8>
   140009514:	4c 8b 44 24 70       	mov    0x70(%rsp),%r8
   140009519:	4c 8b 4c 24 78       	mov    0x78(%rsp),%r9
   14000951e:	49 83 f8 01          	cmp    $0x1,%r8
   140009522:	0f 84 d6 00 00 00    	je     1400095fe <__mbrtowc_cp+0x14e>
   140009528:	48 89 7c 24 20       	mov    %rdi,0x20(%rsp)
   14000952d:	41 b9 02 00 00 00    	mov    $0x2,%r9d
   140009533:	49 89 d8             	mov    %rbx,%r8
   140009536:	c7 44 24 28 01 00 00 	movl   $0x1,0x28(%rsp)
   14000953d:	00 
   14000953e:	8b 8c 24 80 00 00 00 	mov    0x80(%rsp),%ecx
   140009545:	ba 08 00 00 00       	mov    $0x8,%edx
   14000954a:	ff 15 b4 5c 00 00    	call   *0x5cb4(%rip)        # 14000f204 <__imp_MultiByteToWideChar>
   140009550:	85 c0                	test   %eax,%eax
   140009552:	0f 84 94 00 00 00    	je     1400095ec <__mbrtowc_cp+0x13c>
   140009558:	b8 02 00 00 00       	mov    $0x2,%eax
   14000955d:	48 83 c4 48          	add    $0x48,%rsp
   140009561:	5b                   	pop    %rbx
   140009562:	5f                   	pop    %rdi
   140009563:	c3                   	ret
   140009564:	0f 1f 40 00          	nopl   0x0(%rax)
   140009568:	8b 84 24 80 00 00 00 	mov    0x80(%rsp),%eax
   14000956f:	85 c0                	test   %eax,%eax
   140009571:	75 4d                	jne    1400095c0 <__mbrtowc_cp+0x110>
   140009573:	0f b6 03             	movzbl (%rbx),%eax
   140009576:	66 89 07             	mov    %ax,(%rdi)
   140009579:	b8 01 00 00 00       	mov    $0x1,%eax
   14000957e:	48 83 c4 48          	add    $0x48,%rsp
   140009582:	5b                   	pop    %rbx
   140009583:	5f                   	pop    %rdi
   140009584:	c3                   	ret
   140009585:	0f 1f 00             	nopl   (%rax)
   140009588:	31 d2                	xor    %edx,%edx
   14000958a:	66 89 11             	mov    %dx,(%rcx)
   14000958d:	31 c0                	xor    %eax,%eax
   14000958f:	48 83 c4 48          	add    $0x48,%rsp
   140009593:	5b                   	pop    %rbx
   140009594:	5f                   	pop    %rdi
   140009595:	c3                   	ret
   140009596:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   14000959d:	00 00 00 
   1400095a0:	88 54 24 3d          	mov    %dl,0x3d(%rsp)
   1400095a4:	41 b9 02 00 00 00    	mov    $0x2,%r9d
   1400095aa:	c7 44 24 28 01 00 00 	movl   $0x1,0x28(%rsp)
   1400095b1:	00 
   1400095b2:	4c 8d 44 24 3c       	lea    0x3c(%rsp),%r8
   1400095b7:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   1400095bc:	eb 80                	jmp    14000953e <__mbrtowc_cp+0x8e>
   1400095be:	66 90                	xchg   %ax,%ax
   1400095c0:	8b 8c 24 80 00 00 00 	mov    0x80(%rsp),%ecx
   1400095c7:	48 89 7c 24 20       	mov    %rdi,0x20(%rsp)
   1400095cc:	41 b9 01 00 00 00    	mov    $0x1,%r9d
   1400095d2:	49 89 d8             	mov    %rbx,%r8
   1400095d5:	c7 44 24 28 01 00 00 	movl   $0x1,0x28(%rsp)
   1400095dc:	00 
   1400095dd:	ba 08 00 00 00       	mov    $0x8,%edx
   1400095e2:	ff 15 1c 5c 00 00    	call   *0x5c1c(%rip)        # 14000f204 <__imp_MultiByteToWideChar>
   1400095e8:	85 c0                	test   %eax,%eax
   1400095ea:	75 8d                	jne    140009579 <__mbrtowc_cp+0xc9>
   1400095ec:	e8 4f 02 00 00       	call   140009840 <_errno>
   1400095f1:	c7 00 2a 00 00 00    	movl   $0x2a,(%rax)
   1400095f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   1400095fc:	eb 91                	jmp    14000958f <__mbrtowc_cp+0xdf>
   1400095fe:	0f b6 03             	movzbl (%rbx),%eax
   140009601:	41 88 01             	mov    %al,(%r9)
   140009604:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
   140009609:	eb 84                	jmp    14000958f <__mbrtowc_cp+0xdf>
   14000960b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000140009610 <mbrtowc>:
   140009610:	41 54                	push   %r12
   140009612:	55                   	push   %rbp
   140009613:	57                   	push   %rdi
   140009614:	56                   	push   %rsi
   140009615:	53                   	push   %rbx
   140009616:	48 83 ec 40          	sub    $0x40,%rsp
   14000961a:	31 c0                	xor    %eax,%eax
   14000961c:	48 89 cb             	mov    %rcx,%rbx
   14000961f:	48 85 c9             	test   %rcx,%rcx
   140009622:	66 89 44 24 3e       	mov    %ax,0x3e(%rsp)
   140009627:	4c 89 ce             	mov    %r9,%rsi
   14000962a:	48 8d 44 24 3e       	lea    0x3e(%rsp),%rax
   14000962f:	48 89 d7             	mov    %rdx,%rdi
   140009632:	4c 89 c5             	mov    %r8,%rbp
   140009635:	48 0f 44 d8          	cmove  %rax,%rbx
   140009639:	e8 c2 01 00 00       	call   140009800 <___mb_cur_max_func>
   14000963e:	41 89 c4             	mov    %eax,%r12d
   140009641:	e8 b2 01 00 00       	call   1400097f8 <___lc_codepage_func>
   140009646:	48 85 f6             	test   %rsi,%rsi
   140009649:	44 89 64 24 28       	mov    %r12d,0x28(%rsp)
   14000964e:	49 89 e8             	mov    %rbp,%r8
   140009651:	4c 8d 0d 20 55 00 00 	lea    0x5520(%rip),%r9        # 14000eb78 <internal_mbstate.2>
   140009658:	89 44 24 20          	mov    %eax,0x20(%rsp)
   14000965c:	48 89 fa             	mov    %rdi,%rdx
   14000965f:	48 89 d9             	mov    %rbx,%rcx
   140009662:	4c 0f 45 ce          	cmovne %rsi,%r9
   140009666:	e8 45 fe ff ff       	call   1400094b0 <__mbrtowc_cp>
   14000966b:	48 98                	cltq
   14000966d:	48 83 c4 40          	add    $0x40,%rsp
   140009671:	5b                   	pop    %rbx
   140009672:	5e                   	pop    %rsi
   140009673:	5f                   	pop    %rdi
   140009674:	5d                   	pop    %rbp
   140009675:	41 5c                	pop    %r12
   140009677:	c3                   	ret
   140009678:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   14000967f:	00 

0000000140009680 <mbsrtowcs>:
   140009680:	41 56                	push   %r14
   140009682:	41 55                	push   %r13
   140009684:	41 54                	push   %r12
   140009686:	55                   	push   %rbp
   140009687:	57                   	push   %rdi
   140009688:	56                   	push   %rsi
   140009689:	53                   	push   %rbx
   14000968a:	48 83 ec 40          	sub    $0x40,%rsp
   14000968e:	48 8d 05 df 54 00 00 	lea    0x54df(%rip),%rax        # 14000eb74 <internal_mbstate.1>
   140009695:	4d 85 c9             	test   %r9,%r9
   140009698:	4c 89 cf             	mov    %r9,%rdi
   14000969b:	48 89 d6             	mov    %rdx,%rsi
   14000969e:	48 0f 44 f8          	cmove  %rax,%rdi
   1400096a2:	48 89 cb             	mov    %rcx,%rbx
   1400096a5:	4c 89 c5             	mov    %r8,%rbp
   1400096a8:	e8 4b 01 00 00       	call   1400097f8 <___lc_codepage_func>
   1400096ad:	41 89 c5             	mov    %eax,%r13d
   1400096b0:	e8 4b 01 00 00       	call   140009800 <___mb_cur_max_func>
   1400096b5:	48 85 f6             	test   %rsi,%rsi
   1400096b8:	41 89 c4             	mov    %eax,%r12d
   1400096bb:	0f 84 c7 00 00 00    	je     140009788 <mbsrtowcs+0x108>
   1400096c1:	48 8b 16             	mov    (%rsi),%rdx
   1400096c4:	48 85 d2             	test   %rdx,%rdx
   1400096c7:	0f 84 bb 00 00 00    	je     140009788 <mbsrtowcs+0x108>
   1400096cd:	48 85 db             	test   %rbx,%rbx
   1400096d0:	74 6e                	je     140009740 <mbsrtowcs+0xc0>
   1400096d2:	45 31 f6             	xor    %r14d,%r14d
   1400096d5:	48 85 ed             	test   %rbp,%rbp
   1400096d8:	75 1d                	jne    1400096f7 <mbsrtowcs+0x77>
   1400096da:	eb 4a                	jmp    140009726 <mbsrtowcs+0xa6>
   1400096dc:	0f 1f 40 00          	nopl   0x0(%rax)
   1400096e0:	48 8b 16             	mov    (%rsi),%rdx
   1400096e3:	48 98                	cltq
   1400096e5:	48 83 c3 02          	add    $0x2,%rbx
   1400096e9:	49 01 c6             	add    %rax,%r14
   1400096ec:	48 01 c2             	add    %rax,%rdx
   1400096ef:	49 39 ee             	cmp    %rbp,%r14
   1400096f2:	48 89 16             	mov    %rdx,(%rsi)
   1400096f5:	73 2f                	jae    140009726 <mbsrtowcs+0xa6>
   1400096f7:	49 89 e8             	mov    %rbp,%r8
   1400096fa:	44 89 64 24 28       	mov    %r12d,0x28(%rsp)
   1400096ff:	49 89 f9             	mov    %rdi,%r9
   140009702:	48 89 d9             	mov    %rbx,%rcx
   140009705:	4d 29 f0             	sub    %r14,%r8
   140009708:	44 89 6c 24 20       	mov    %r13d,0x20(%rsp)
   14000970d:	e8 9e fd ff ff       	call   1400094b0 <__mbrtowc_cp>
   140009712:	85 c0                	test   %eax,%eax
   140009714:	7f ca                	jg     1400096e0 <mbsrtowcs+0x60>
   140009716:	49 39 ee             	cmp    %rbp,%r14
   140009719:	73 0b                	jae    140009726 <mbsrtowcs+0xa6>
   14000971b:	85 c0                	test   %eax,%eax
   14000971d:	75 07                	jne    140009726 <mbsrtowcs+0xa6>
   14000971f:	48 c7 06 00 00 00 00 	movq   $0x0,(%rsi)
   140009726:	4c 89 f0             	mov    %r14,%rax
   140009729:	48 83 c4 40          	add    $0x40,%rsp
   14000972d:	5b                   	pop    %rbx
   14000972e:	5e                   	pop    %rsi
   14000972f:	5f                   	pop    %rdi
   140009730:	5d                   	pop    %rbp
   140009731:	41 5c                	pop    %r12
   140009733:	41 5d                	pop    %r13
   140009735:	41 5e                	pop    %r14
   140009737:	c3                   	ret
   140009738:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   14000973f:	00 
   140009740:	31 c0                	xor    %eax,%eax
   140009742:	44 89 e5             	mov    %r12d,%ebp
   140009745:	45 31 f6             	xor    %r14d,%r14d
   140009748:	66 89 44 24 3e       	mov    %ax,0x3e(%rsp)
   14000974d:	48 8d 5c 24 3e       	lea    0x3e(%rsp),%rbx
   140009752:	eb 0c                	jmp    140009760 <mbsrtowcs+0xe0>
   140009754:	0f 1f 40 00          	nopl   0x0(%rax)
   140009758:	48 8b 16             	mov    (%rsi),%rdx
   14000975b:	48 98                	cltq
   14000975d:	49 01 c6             	add    %rax,%r14
   140009760:	4c 01 f2             	add    %r14,%rdx
   140009763:	44 89 64 24 28       	mov    %r12d,0x28(%rsp)
   140009768:	49 89 f9             	mov    %rdi,%r9
   14000976b:	49 89 e8             	mov    %rbp,%r8
   14000976e:	44 89 6c 24 20       	mov    %r13d,0x20(%rsp)
   140009773:	48 89 d9             	mov    %rbx,%rcx
   140009776:	e8 35 fd ff ff       	call   1400094b0 <__mbrtowc_cp>
   14000977b:	85 c0                	test   %eax,%eax
   14000977d:	7f d9                	jg     140009758 <mbsrtowcs+0xd8>
   14000977f:	eb a5                	jmp    140009726 <mbsrtowcs+0xa6>
   140009781:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140009788:	45 31 f6             	xor    %r14d,%r14d
   14000978b:	eb 99                	jmp    140009726 <mbsrtowcs+0xa6>
   14000978d:	0f 1f 00             	nopl   (%rax)

0000000140009790 <mbrlen>:
   140009790:	55                   	push   %rbp
   140009791:	57                   	push   %rdi
   140009792:	56                   	push   %rsi
   140009793:	53                   	push   %rbx
   140009794:	48 83 ec 48          	sub    $0x48,%rsp
   140009798:	31 c0                	xor    %eax,%eax
   14000979a:	48 89 ce             	mov    %rcx,%rsi
   14000979d:	48 89 d7             	mov    %rdx,%rdi
   1400097a0:	4c 89 c3             	mov    %r8,%rbx
   1400097a3:	66 89 44 24 3e       	mov    %ax,0x3e(%rsp)
   1400097a8:	e8 53 00 00 00       	call   140009800 <___mb_cur_max_func>
   1400097ad:	89 c5                	mov    %eax,%ebp
   1400097af:	e8 44 00 00 00       	call   1400097f8 <___lc_codepage_func>
   1400097b4:	48 85 db             	test   %rbx,%rbx
   1400097b7:	89 6c 24 28          	mov    %ebp,0x28(%rsp)
   1400097bb:	49 89 f8             	mov    %rdi,%r8
   1400097be:	48 8d 15 ab 53 00 00 	lea    0x53ab(%rip),%rdx        # 14000eb70 <s_mbstate.0>
   1400097c5:	89 44 24 20          	mov    %eax,0x20(%rsp)
   1400097c9:	48 0f 44 da          	cmove  %rdx,%rbx
   1400097cd:	48 89 f2             	mov    %rsi,%rdx
   1400097d0:	48 8d 4c 24 3e       	lea    0x3e(%rsp),%rcx
   1400097d5:	49 89 d9             	mov    %rbx,%r9
   1400097d8:	e8 d3 fc ff ff       	call   1400094b0 <__mbrtowc_cp>
   1400097dd:	48 98                	cltq
   1400097df:	48 83 c4 48          	add    $0x48,%rsp
   1400097e3:	5b                   	pop    %rbx
   1400097e4:	5e                   	pop    %rsi
   1400097e5:	5f                   	pop    %rdi
   1400097e6:	5d                   	pop    %rbp
   1400097e7:	c3                   	ret
   1400097e8:	90                   	nop
   1400097e9:	90                   	nop
   1400097ea:	90                   	nop
   1400097eb:	90                   	nop
   1400097ec:	90                   	nop
   1400097ed:	90                   	nop
   1400097ee:	90                   	nop
   1400097ef:	90                   	nop

00000001400097f0 <__C_specific_handler>:
   1400097f0:	ff 25 4e 5a 00 00    	jmp    *0x5a4e(%rip)        # 14000f244 <__imp___C_specific_handler>
   1400097f6:	90                   	nop
   1400097f7:	90                   	nop

00000001400097f8 <___lc_codepage_func>:
   1400097f8:	ff 25 4e 5a 00 00    	jmp    *0x5a4e(%rip)        # 14000f24c <__imp____lc_codepage_func>
   1400097fe:	90                   	nop
   1400097ff:	90                   	nop

0000000140009800 <___mb_cur_max_func>:
   140009800:	ff 25 4e 5a 00 00    	jmp    *0x5a4e(%rip)        # 14000f254 <__imp____mb_cur_max_func>
   140009806:	90                   	nop
   140009807:	90                   	nop

0000000140009808 <__getmainargs>:
   140009808:	ff 25 4e 5a 00 00    	jmp    *0x5a4e(%rip)        # 14000f25c <__imp___getmainargs>
   14000980e:	90                   	nop
   14000980f:	90                   	nop

0000000140009810 <__iob_func>:
   140009810:	ff 25 56 5a 00 00    	jmp    *0x5a56(%rip)        # 14000f26c <__imp___iob_func>
   140009816:	90                   	nop
   140009817:	90                   	nop

0000000140009818 <__set_app_type>:
   140009818:	ff 25 56 5a 00 00    	jmp    *0x5a56(%rip)        # 14000f274 <__imp___set_app_type>
   14000981e:	90                   	nop
   14000981f:	90                   	nop

0000000140009820 <__setusermatherr>:
   140009820:	ff 25 56 5a 00 00    	jmp    *0x5a56(%rip)        # 14000f27c <__imp___setusermatherr>
   140009826:	90                   	nop
   140009827:	90                   	nop

0000000140009828 <_amsg_exit>:
   140009828:	ff 25 56 5a 00 00    	jmp    *0x5a56(%rip)        # 14000f284 <__imp__amsg_exit>
   14000982e:	90                   	nop
   14000982f:	90                   	nop

0000000140009830 <_assert>:
   140009830:	ff 25 56 5a 00 00    	jmp    *0x5a56(%rip)        # 14000f28c <__imp__assert>
   140009836:	90                   	nop
   140009837:	90                   	nop

0000000140009838 <_cexit>:
   140009838:	ff 25 56 5a 00 00    	jmp    *0x5a56(%rip)        # 14000f294 <__imp__cexit>
   14000983e:	90                   	nop
   14000983f:	90                   	nop

0000000140009840 <_errno>:
   140009840:	ff 25 5e 5a 00 00    	jmp    *0x5a5e(%rip)        # 14000f2a4 <__imp__errno>
   140009846:	90                   	nop
   140009847:	90                   	nop

0000000140009848 <_initterm>:
   140009848:	ff 25 6e 5a 00 00    	jmp    *0x5a6e(%rip)        # 14000f2bc <__imp__initterm>
   14000984e:	90                   	nop
   14000984f:	90                   	nop

0000000140009850 <_lock>:
   140009850:	ff 25 6e 5a 00 00    	jmp    *0x5a6e(%rip)        # 14000f2c4 <__imp__lock>
   140009856:	90                   	nop
   140009857:	90                   	nop

0000000140009858 <_onexit>:
   140009858:	ff 25 6e 5a 00 00    	jmp    *0x5a6e(%rip)        # 14000f2cc <__imp__onexit>
   14000985e:	90                   	nop
   14000985f:	90                   	nop

0000000140009860 <_unlock>:
   140009860:	ff 25 6e 5a 00 00    	jmp    *0x5a6e(%rip)        # 14000f2d4 <__imp__unlock>
   140009866:	90                   	nop
   140009867:	90                   	nop

0000000140009868 <abort>:
   140009868:	ff 25 6e 5a 00 00    	jmp    *0x5a6e(%rip)        # 14000f2dc <__imp_abort>
   14000986e:	90                   	nop
   14000986f:	90                   	nop

0000000140009870 <calloc>:
   140009870:	ff 25 6e 5a 00 00    	jmp    *0x5a6e(%rip)        # 14000f2e4 <__imp_calloc>
   140009876:	90                   	nop
   140009877:	90                   	nop

0000000140009878 <fprintf>:
   140009878:	ff 25 76 5a 00 00    	jmp    *0x5a76(%rip)        # 14000f2f4 <__imp_fprintf>
   14000987e:	90                   	nop
   14000987f:	90                   	nop

0000000140009880 <fputc>:
   140009880:	ff 25 76 5a 00 00    	jmp    *0x5a76(%rip)        # 14000f2fc <__imp_fputc>
   140009886:	90                   	nop
   140009887:	90                   	nop

0000000140009888 <free>:
   140009888:	ff 25 76 5a 00 00    	jmp    *0x5a76(%rip)        # 14000f304 <__imp_free>
   14000988e:	90                   	nop
   14000988f:	90                   	nop

0000000140009890 <fwrite>:
   140009890:	ff 25 76 5a 00 00    	jmp    *0x5a76(%rip)        # 14000f30c <__imp_fwrite>
   140009896:	90                   	nop
   140009897:	90                   	nop

0000000140009898 <localeconv>:
   140009898:	ff 25 76 5a 00 00    	jmp    *0x5a76(%rip)        # 14000f314 <__imp_localeconv>
   14000989e:	90                   	nop
   14000989f:	90                   	nop

00000001400098a0 <malloc>:
   1400098a0:	ff 25 76 5a 00 00    	jmp    *0x5a76(%rip)        # 14000f31c <__imp_malloc>
   1400098a6:	90                   	nop
   1400098a7:	90                   	nop

00000001400098a8 <memcpy>:
   1400098a8:	ff 25 76 5a 00 00    	jmp    *0x5a76(%rip)        # 14000f324 <__imp_memcpy>
   1400098ae:	90                   	nop
   1400098af:	90                   	nop

00000001400098b0 <memset>:
   1400098b0:	ff 25 76 5a 00 00    	jmp    *0x5a76(%rip)        # 14000f32c <__imp_memset>
   1400098b6:	90                   	nop
   1400098b7:	90                   	nop

00000001400098b8 <signal>:
   1400098b8:	ff 25 76 5a 00 00    	jmp    *0x5a76(%rip)        # 14000f334 <__imp_signal>
   1400098be:	90                   	nop
   1400098bf:	90                   	nop

00000001400098c0 <strerror>:
   1400098c0:	ff 25 76 5a 00 00    	jmp    *0x5a76(%rip)        # 14000f33c <__imp_strerror>
   1400098c6:	90                   	nop
   1400098c7:	90                   	nop

00000001400098c8 <strlen>:
   1400098c8:	ff 25 76 5a 00 00    	jmp    *0x5a76(%rip)        # 14000f344 <__imp_strlen>
   1400098ce:	90                   	nop
   1400098cf:	90                   	nop

00000001400098d0 <strncmp>:
   1400098d0:	ff 25 76 5a 00 00    	jmp    *0x5a76(%rip)        # 14000f34c <__imp_strncmp>
   1400098d6:	90                   	nop
   1400098d7:	90                   	nop

00000001400098d8 <vfprintf>:
   1400098d8:	ff 25 76 5a 00 00    	jmp    *0x5a76(%rip)        # 14000f354 <__imp_vfprintf>
   1400098de:	90                   	nop
   1400098df:	90                   	nop

00000001400098e0 <wcslen>:
   1400098e0:	ff 25 76 5a 00 00    	jmp    *0x5a76(%rip)        # 14000f35c <__imp_wcslen>
   1400098e6:	90                   	nop
   1400098e7:	90                   	nop
   1400098e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   1400098ef:	00 

00000001400098f0 <WideCharToMultiByte>:
   1400098f0:	ff 25 3e 59 00 00    	jmp    *0x593e(%rip)        # 14000f234 <__imp_WideCharToMultiByte>
   1400098f6:	90                   	nop
   1400098f7:	90                   	nop

00000001400098f8 <VirtualQuery>:
   1400098f8:	ff 25 2e 59 00 00    	jmp    *0x592e(%rip)        # 14000f22c <__imp_VirtualQuery>
   1400098fe:	90                   	nop
   1400098ff:	90                   	nop

0000000140009900 <VirtualProtect>:
   140009900:	ff 25 1e 59 00 00    	jmp    *0x591e(%rip)        # 14000f224 <__imp_VirtualProtect>
   140009906:	90                   	nop
   140009907:	90                   	nop

0000000140009908 <TlsGetValue>:
   140009908:	ff 25 0e 59 00 00    	jmp    *0x590e(%rip)        # 14000f21c <__imp_TlsGetValue>
   14000990e:	90                   	nop
   14000990f:	90                   	nop

0000000140009910 <Sleep>:
   140009910:	ff 25 fe 58 00 00    	jmp    *0x58fe(%rip)        # 14000f214 <__imp_Sleep>
   140009916:	90                   	nop
   140009917:	90                   	nop

0000000140009918 <SetUnhandledExceptionFilter>:
   140009918:	ff 25 ee 58 00 00    	jmp    *0x58ee(%rip)        # 14000f20c <__imp_SetUnhandledExceptionFilter>
   14000991e:	90                   	nop
   14000991f:	90                   	nop

0000000140009920 <MultiByteToWideChar>:
   140009920:	ff 25 de 58 00 00    	jmp    *0x58de(%rip)        # 14000f204 <__imp_MultiByteToWideChar>
   140009926:	90                   	nop
   140009927:	90                   	nop

0000000140009928 <LeaveCriticalSection>:
   140009928:	ff 25 ce 58 00 00    	jmp    *0x58ce(%rip)        # 14000f1fc <__imp_LeaveCriticalSection>
   14000992e:	90                   	nop
   14000992f:	90                   	nop

0000000140009930 <IsDBCSLeadByteEx>:
   140009930:	ff 25 be 58 00 00    	jmp    *0x58be(%rip)        # 14000f1f4 <__imp_IsDBCSLeadByteEx>
   140009936:	90                   	nop
   140009937:	90                   	nop

0000000140009938 <InitializeCriticalSection>:
   140009938:	ff 25 ae 58 00 00    	jmp    *0x58ae(%rip)        # 14000f1ec <__imp_InitializeCriticalSection>
   14000993e:	90                   	nop
   14000993f:	90                   	nop

0000000140009940 <GetLastError>:
   140009940:	ff 25 9e 58 00 00    	jmp    *0x589e(%rip)        # 14000f1e4 <__imp_GetLastError>
   140009946:	90                   	nop
   140009947:	90                   	nop

0000000140009948 <EnterCriticalSection>:
   140009948:	ff 25 8e 58 00 00    	jmp    *0x588e(%rip)        # 14000f1dc <__imp_EnterCriticalSection>
   14000994e:	90                   	nop
   14000994f:	90                   	nop

0000000140009950 <DeleteCriticalSection>:
   140009950:	ff 25 7e 58 00 00    	jmp    *0x587e(%rip)        # 14000f1d4 <__IAT_start__>
   140009956:	90                   	nop
   140009957:	90                   	nop
   140009958:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   14000995f:	00 

0000000140009960 <register_frame_ctor>:
   140009960:	e9 cb 7a ff ff       	jmp    140001430 <__gcc_register_frame>
   140009965:	90                   	nop
   140009966:	90                   	nop
   140009967:	90                   	nop
   140009968:	90                   	nop
   140009969:	90                   	nop
   14000996a:	90                   	nop
   14000996b:	90                   	nop
   14000996c:	90                   	nop
   14000996d:	90                   	nop
   14000996e:	90                   	nop
   14000996f:	90                   	nop

0000000140009970 <__CTOR_LIST__>:
   140009970:	ff                   	(bad)
   140009971:	ff                   	(bad)
   140009972:	ff                   	(bad)
   140009973:	ff                   	(bad)
   140009974:	ff                   	(bad)
   140009975:	ff                   	(bad)
   140009976:	ff                   	(bad)
   140009977:	ff                   	.byte 0xff

0000000140009978 <.ctors.65535>:
   140009978:	60                   	(bad)
   140009979:	99                   	cltd
   14000997a:	00 40 01             	add    %al,0x1(%rax)
	...

0000000140009988 <__DTOR_LIST__>:
   140009988:	ff                   	(bad)
   140009989:	ff                   	(bad)
   14000998a:	ff                   	(bad)
   14000998b:	ff                   	(bad)
   14000998c:	ff                   	(bad)
   14000998d:	ff                   	(bad)
   14000998e:	ff                   	(bad)
   14000998f:	ff 00                	incl   (%rax)
   140009991:	00 00                	add    %al,(%rax)
   140009993:	00 00                	add    %al,(%rax)
   140009995:	00 00                	add    %al,(%rax)
	...
