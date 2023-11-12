
a.exe:     file format pei-x86-64


Disassembly of section .text:

0000000140001000 <__mingw_invalidParameterHandler> (File Offset: 0x600):
   140001000:	c3                   	ret
   140001001:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   140001008:	00 00 00 00 
   14000100c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000140001010 <pre_c_init> (File Offset: 0x610):
   140001010:	                48 83 ec 28          	sub    $0x28,%rsp
   140001014:	                48 8b 05 95 54 00 00 	mov    0x5495(%rip),%rax        # 1400064b0 <.refptr.__mingw_initltsdrot_force> (File Offset: 0x5ab0)
   14000101b:	                31 c9                	xor    %ecx,%ecx
   14000101d:	                c7 00 01 00 00 00    	movl   $0x1,(%rax)
   140001023:	                48 8b 05 96 54 00 00 	mov    0x5496(%rip),%rax        # 1400064c0 <.refptr.__mingw_initltsdyn_force> (File Offset: 0x5ac0)
   14000102a:	                c7 00 01 00 00 00    	movl   $0x1,(%rax)
   140001030:	                48 8b 05 99 54 00 00 	mov    0x5499(%rip),%rax        # 1400064d0 <.refptr.__mingw_initltssuo_force> (File Offset: 0x5ad0)
   140001037:	                c7 00 01 00 00 00    	movl   $0x1,(%rax)
   14000103d:	                48 8b 05 fc 53 00 00 	mov    0x53fc(%rip),%rax        # 140006440 <.refptr.__image_base__> (File Offset: 0x5a40)
   140001044:	                66 81 38 4d 5a       	cmpw   $0x5a4d,(%rax)
   140001049:	/-------------- 75 0f                	jne    14000105a <pre_c_init+0x4a> (File Offset: 0x65a)
   14000104b:	|               48 63 50 3c          	movslq 0x3c(%rax),%rdx
   14000104f:	|               48 01 d0             	add    %rdx,%rax
   140001052:	|               81 38 50 45 00 00    	cmpl   $0x4550,(%rax)
   140001058:	|  /----------- 74 66                	je     1400010c0 <pre_c_init+0xb0> (File Offset: 0x6c0)
   14000105a:	>--|----------> 48 8b 05 3f 54 00 00 	mov    0x543f(%rip),%rax        # 1400064a0 <.refptr.__mingw_app_type> (File Offset: 0x5aa0)
   140001061:	|  |            89 0d a5 7f 00 00    	mov    %ecx,0x7fa5(%rip)        # 14000900c <managedapp> (File Offset: 0x860c)
   140001067:	|  |            8b 00                	mov    (%rax),%eax
   140001069:	|  |            85 c0                	test   %eax,%eax
   14000106b:	|  |     /----- 74 43                	je     1400010b0 <pre_c_init+0xa0> (File Offset: 0x6b0)
   14000106d:	|  |     |      b9 02 00 00 00       	mov    $0x2,%ecx
   140001072:	|  |     |      e8 f1 1d 00 00       	call   140002e68 <__set_app_type> (File Offset: 0x2468)
   140001077:	|  |     |  /-> e8 74 1d 00 00       	call   140002df0 <__p__fmode> (File Offset: 0x23f0)
   14000107c:	|  |     |  |   48 8b 15 ed 54 00 00 	mov    0x54ed(%rip),%rdx        # 140006570 <.refptr._fmode> (File Offset: 0x5b70)
   140001083:	|  |     |  |   8b 12                	mov    (%rdx),%edx
   140001085:	|  |     |  |   89 10                	mov    %edx,(%rax)
   140001087:	|  |     |  |   e8 74 1d 00 00       	call   140002e00 <__p__commode> (File Offset: 0x2400)
   14000108c:	|  |     |  |   48 8b 15 bd 54 00 00 	mov    0x54bd(%rip),%rdx        # 140006550 <.refptr._commode> (File Offset: 0x5b50)
   140001093:	|  |     |  |   8b 12                	mov    (%rdx),%edx
   140001095:	|  |     |  |   89 10                	mov    %edx,(%rax)
   140001097:	|  |     |  |   e8 54 0d 00 00       	call   140001df0 <_setargv> (File Offset: 0x13f0)
   14000109c:	|  |     |  |   48 8b 05 2d 53 00 00 	mov    0x532d(%rip),%rax        # 1400063d0 <.refptr._MINGW_INSTALL_DEBUG_MATHERR> (File Offset: 0x59d0)
   1400010a3:	|  |     |  |   83 38 01             	cmpl   $0x1,(%rax)
   1400010a6:	|  |  /--|--|-- 74 50                	je     1400010f8 <pre_c_init+0xe8> (File Offset: 0x6f8)
   1400010a8:	|  |  |  |  |   31 c0                	xor    %eax,%eax
   1400010aa:	|  |  |  |  |   48 83 c4 28          	add    $0x28,%rsp
   1400010ae:	|  |  |  |  |   c3                   	ret
   1400010af:	|  |  |  |  |   90                   	nop
   1400010b0:	|  |  |  \--|-> b9 01 00 00 00       	mov    $0x1,%ecx
   1400010b5:	|  |  |     |   e8 ae 1d 00 00       	call   140002e68 <__set_app_type> (File Offset: 0x2468)
   1400010ba:	|  |  |     \-- eb bb                	jmp    140001077 <pre_c_init+0x67> (File Offset: 0x677)
   1400010bc:	|  |  |         0f 1f 40 00          	nopl   0x0(%rax)
   1400010c0:	|  \--|-------> 0f b7 50 18          	movzwl 0x18(%rax),%edx
   1400010c4:	|     |         66 81 fa 0b 01       	cmp    $0x10b,%dx
   1400010c9:	|     |     /-- 74 45                	je     140001110 <pre_c_init+0x100> (File Offset: 0x710)
   1400010cb:	|     |     |   66 81 fa 0b 02       	cmp    $0x20b,%dx
   1400010d0:	+-----|-----|-- 75 88                	jne    14000105a <pre_c_init+0x4a> (File Offset: 0x65a)
   1400010d2:	|     |     |   83 b8 84 00 00 00 0e 	cmpl   $0xe,0x84(%rax)
   1400010d9:	+-----|-----|-- 0f 86 7b ff ff ff    	jbe    14000105a <pre_c_init+0x4a> (File Offset: 0x65a)
   1400010df:	|     |     |   8b 90 f8 00 00 00    	mov    0xf8(%rax),%edx
   1400010e5:	|     |     |   31 c9                	xor    %ecx,%ecx
   1400010e7:	|     |     |   85 d2                	test   %edx,%edx
   1400010e9:	|     |     |   0f 95 c1             	setne  %cl
   1400010ec:	+-----|-----|-- e9 69 ff ff ff       	jmp    14000105a <pre_c_init+0x4a> (File Offset: 0x65a)
   1400010f1:	|     |     |   0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   1400010f8:	|     \-----|-> 48 8b 0d 91 54 00 00 	mov    0x5491(%rip),%rcx        # 140006590 <.refptr._matherr> (File Offset: 0x5b90)
   1400010ff:	|           |   e8 5c 14 00 00       	call   140002560 <__mingw_setusermatherr> (File Offset: 0x1b60)
   140001104:	|           |   31 c0                	xor    %eax,%eax
   140001106:	|           |   48 83 c4 28          	add    $0x28,%rsp
   14000110a:	|           |   c3                   	ret
   14000110b:	|           |   0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140001110:	|           \-> 83 78 74 0e          	cmpl   $0xe,0x74(%rax)
   140001114:	+-------------- 0f 86 40 ff ff ff    	jbe    14000105a <pre_c_init+0x4a> (File Offset: 0x65a)
   14000111a:	|               44 8b 80 e8 00 00 00 	mov    0xe8(%rax),%r8d
   140001121:	|               31 c9                	xor    %ecx,%ecx
   140001123:	|               45 85 c0             	test   %r8d,%r8d
   140001126:	|               0f 95 c1             	setne  %cl
   140001129:	\-------------- e9 2c ff ff ff       	jmp    14000105a <pre_c_init+0x4a> (File Offset: 0x65a)
   14000112e:	                66 90                	xchg   %ax,%ax

0000000140001130 <pre_cpp_init> (File Offset: 0x730):
   140001130:	48 83 ec 38          	sub    $0x38,%rsp
   140001134:	48 8b 05 65 54 00 00 	mov    0x5465(%rip),%rax        # 1400065a0 <.refptr._newmode> (File Offset: 0x5ba0)
   14000113b:	4c 8d 05 d6 7e 00 00 	lea    0x7ed6(%rip),%r8        # 140009018 <envp> (File Offset: 0x8618)
   140001142:	48 8d 15 d7 7e 00 00 	lea    0x7ed7(%rip),%rdx        # 140009020 <argv> (File Offset: 0x8620)
   140001149:	48 8d 0d d8 7e 00 00 	lea    0x7ed8(%rip),%rcx        # 140009028 <argc> (File Offset: 0x8628)
   140001150:	8b 00                	mov    (%rax),%eax
   140001152:	89 05 ac 7e 00 00    	mov    %eax,0x7eac(%rip)        # 140009004 <startinfo> (File Offset: 0x8604)
   140001158:	48 8b 05 01 54 00 00 	mov    0x5401(%rip),%rax        # 140006560 <.refptr._dowildcard> (File Offset: 0x5b60)
   14000115f:	44 8b 08             	mov    (%rax),%r9d
   140001162:	48 8d 05 9b 7e 00 00 	lea    0x7e9b(%rip),%rax        # 140009004 <startinfo> (File Offset: 0x8604)
   140001169:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   14000116e:	e8 e5 1c 00 00       	call   140002e58 <__getmainargs> (File Offset: 0x2458)
   140001173:	90                   	nop
   140001174:	48 83 c4 38          	add    $0x38,%rsp
   140001178:	c3                   	ret
   140001179:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000140001180 <__tmainCRTStartup> (File Offset: 0x780):
   140001180:	                                        41 54                	push   %r12
   140001182:	                                        55                   	push   %rbp
   140001183:	                                        57                   	push   %rdi
   140001184:	                                        56                   	push   %rsi
   140001185:	                                        53                   	push   %rbx
   140001186:	                                        48 83 ec 20          	sub    $0x20,%rsp
   14000118a:	                                        48 8b 1d 5f 53 00 00 	mov    0x535f(%rip),%rbx        # 1400064f0 <.refptr.__native_startup_lock> (File Offset: 0x5af0)
   140001191:	                                        31 ff                	xor    %edi,%edi
   140001193:	                                        65 48 8b 04 25 30 00 	mov    %gs:0x30,%rax
   14000119a:	                                        00 00 
   14000119c:	                                        48 8b 2d f1 90 00 00 	mov    0x90f1(%rip),%rbp        # 14000a294 <__imp_Sleep> (File Offset: 0x9894)
   1400011a3:	                                        48 8b 70 08          	mov    0x8(%rax),%rsi
   1400011a7:	                                    /-- eb 17                	jmp    1400011c0 <__tmainCRTStartup+0x40> (File Offset: 0x7c0)
   1400011a9:	                                    |   0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   1400011b0:	                                 /--|-> 48 39 c6             	cmp    %rax,%rsi
   1400011b3:	      /--------------------------|--|-- 0f 84 67 01 00 00    	je     140001320 <__tmainCRTStartup+0x1a0> (File Offset: 0x920)
   1400011b9:	      |                          |  |   b9 e8 03 00 00       	mov    $0x3e8,%ecx
   1400011be:	      |                          |  |   ff d5                	call   *%rbp
   1400011c0:	      |                          |  \-> 48 89 f8             	mov    %rdi,%rax
   1400011c3:	      |                          |      f0 48 0f b1 33       	lock cmpxchg %rsi,(%rbx)
   1400011c8:	      |                          |      48 85 c0             	test   %rax,%rax
   1400011cb:	      |                          \----- 75 e3                	jne    1400011b0 <__tmainCRTStartup+0x30> (File Offset: 0x7b0)
   1400011cd:	      |                                 48 8b 35 2c 53 00 00 	mov    0x532c(%rip),%rsi        # 140006500 <.refptr.__native_startup_state> (File Offset: 0x5b00)
   1400011d4:	      |                                 31 ff                	xor    %edi,%edi
   1400011d6:	      |                                 8b 06                	mov    (%rsi),%eax
   1400011d8:	      |                                 83 f8 01             	cmp    $0x1,%eax
   1400011db:	      |        /----------------------- 0f 84 56 01 00 00    	je     140001337 <__tmainCRTStartup+0x1b7> (File Offset: 0x937)
   1400011e1:	      |        |     /----------------> 8b 06                	mov    (%rsi),%eax
   1400011e3:	      |        |     |                  85 c0                	test   %eax,%eax
   1400011e5:	   /--|--------|-----|----------------- 0f 84 b5 01 00 00    	je     1400013a0 <__tmainCRTStartup+0x220> (File Offset: 0x9a0)
   1400011eb:	   |  |        |     |                  c7 05 13 7e 00 00 01 	movl   $0x1,0x7e13(%rip)        # 140009008 <has_cctor> (File Offset: 0x8608)
   1400011f2:	   |  |        |     |                  00 00 00 
   1400011f5:	/--|--|--------|-----|----------------> 8b 06                	mov    (%rsi),%eax
   1400011f7:	|  |  |        |     |                  83 f8 01             	cmp    $0x1,%eax
   1400011fa:	|  |  |        |  /--|----------------- 0f 84 4c 01 00 00    	je     14000134c <__tmainCRTStartup+0x1cc> (File Offset: 0x94c)
   140001200:	|  |  |        |  |  |     /----------> 85 ff                	test   %edi,%edi
   140001202:	|  |  |  /-----|--|--|-----|----------- 0f 84 65 01 00 00    	je     14000136d <__tmainCRTStartup+0x1ed> (File Offset: 0x96d)
   140001208:	|  |  |  |  /--|--|--|-----|----------> 48 8b 05 21 52 00 00 	mov    0x5221(%rip),%rax        # 140006430 <.refptr.__dyn_tls_init_callback> (File Offset: 0x5a30)
   14000120f:	|  |  |  |  |  |  |  |     |            48 8b 00             	mov    (%rax),%rax
   140001212:	|  |  |  |  |  |  |  |     |            48 85 c0             	test   %rax,%rax
   140001215:	|  |  |  |  |  |  |  |     |        /-- 74 0c                	je     140001223 <__tmainCRTStartup+0xa3> (File Offset: 0x823)
   140001217:	|  |  |  |  |  |  |  |     |        |   45 31 c0             	xor    %r8d,%r8d
   14000121a:	|  |  |  |  |  |  |  |     |        |   ba 02 00 00 00       	mov    $0x2,%edx
   14000121f:	|  |  |  |  |  |  |  |     |        |   31 c9                	xor    %ecx,%ecx
   140001221:	|  |  |  |  |  |  |  |     |        |   ff d0                	call   *%rax
   140001223:	|  |  |  |  |  |  |  |     |        \-> e8 98 0f 00 00       	call   1400021c0 <_pei386_runtime_relocator> (File Offset: 0x17c0)
   140001228:	|  |  |  |  |  |  |  |     |            48 8b 0d 51 53 00 00 	mov    0x5351(%rip),%rcx        # 140006580 <.refptr._gnu_exception_handler> (File Offset: 0x5b80)
   14000122f:	|  |  |  |  |  |  |  |     |            ff 15 57 90 00 00    	call   *0x9057(%rip)        # 14000a28c <__imp_SetUnhandledExceptionFilter> (File Offset: 0x988c)
   140001235:	|  |  |  |  |  |  |  |     |            48 8b 15 a4 52 00 00 	mov    0x52a4(%rip),%rdx        # 1400064e0 <.refptr.__mingw_oldexcpt_handler> (File Offset: 0x5ae0)
   14000123c:	|  |  |  |  |  |  |  |     |            48 8d 0d bd fd ff ff 	lea    -0x243(%rip),%rcx        # 140001000 <__mingw_invalidParameterHandler> (File Offset: 0x600)
   140001243:	|  |  |  |  |  |  |  |     |            48 89 02             	mov    %rax,(%rdx)
   140001246:	|  |  |  |  |  |  |  |     |            e8 d5 1b 00 00       	call   140002e20 <_set_invalid_parameter_handler> (File Offset: 0x2420)
   14000124b:	|  |  |  |  |  |  |  |     |            e8 80 0d 00 00       	call   140001fd0 <_fpreset> (File Offset: 0x15d0)
   140001250:	|  |  |  |  |  |  |  |     |            8b 1d d2 7d 00 00    	mov    0x7dd2(%rip),%ebx        # 140009028 <argc> (File Offset: 0x8628)
   140001256:	|  |  |  |  |  |  |  |     |            8d 7b 01             	lea    0x1(%rbx),%edi
   140001259:	|  |  |  |  |  |  |  |     |            48 63 ff             	movslq %edi,%rdi
   14000125c:	|  |  |  |  |  |  |  |     |            48 c1 e7 03          	shl    $0x3,%rdi
   140001260:	|  |  |  |  |  |  |  |     |            48 89 f9             	mov    %rdi,%rcx
   140001263:	|  |  |  |  |  |  |  |     |            e8 60 1c 00 00       	call   140002ec8 <malloc> (File Offset: 0x24c8)
   140001268:	|  |  |  |  |  |  |  |     |            85 db                	test   %ebx,%ebx
   14000126a:	|  |  |  |  |  |  |  |     |            48 8b 2d af 7d 00 00 	mov    0x7daf(%rip),%rbp        # 140009020 <argv> (File Offset: 0x8620)
   140001271:	|  |  |  |  |  |  |  |     |            49 89 c4             	mov    %rax,%r12
   140001274:	|  |  |  |  |  |  |  |  /--|----------- 0f 8e 46 01 00 00    	jle    1400013c0 <__tmainCRTStartup+0x240> (File Offset: 0x9c0)
   14000127a:	|  |  |  |  |  |  |  |  |  |            48 83 ef 08          	sub    $0x8,%rdi
   14000127e:	|  |  |  |  |  |  |  |  |  |            31 db                	xor    %ebx,%ebx
   140001280:	|  |  |  |  |  |  |  |  |  |        /-> 48 8b 4c 1d 00       	mov    0x0(%rbp,%rbx,1),%rcx
   140001285:	|  |  |  |  |  |  |  |  |  |        |   e8 66 1c 00 00       	call   140002ef0 <strlen> (File Offset: 0x24f0)
   14000128a:	|  |  |  |  |  |  |  |  |  |        |   48 8d 70 01          	lea    0x1(%rax),%rsi
   14000128e:	|  |  |  |  |  |  |  |  |  |        |   48 89 f1             	mov    %rsi,%rcx
   140001291:	|  |  |  |  |  |  |  |  |  |        |   e8 32 1c 00 00       	call   140002ec8 <malloc> (File Offset: 0x24c8)
   140001296:	|  |  |  |  |  |  |  |  |  |        |   49 89 f0             	mov    %rsi,%r8
   140001299:	|  |  |  |  |  |  |  |  |  |        |   49 89 04 1c          	mov    %rax,(%r12,%rbx,1)
   14000129d:	|  |  |  |  |  |  |  |  |  |        |   48 8b 54 1d 00       	mov    0x0(%rbp,%rbx,1),%rdx
   1400012a2:	|  |  |  |  |  |  |  |  |  |        |   48 89 c1             	mov    %rax,%rcx
   1400012a5:	|  |  |  |  |  |  |  |  |  |        |   48 83 c3 08          	add    $0x8,%rbx
   1400012a9:	|  |  |  |  |  |  |  |  |  |        |   e8 22 1c 00 00       	call   140002ed0 <memcpy> (File Offset: 0x24d0)
   1400012ae:	|  |  |  |  |  |  |  |  |  |        |   48 39 df             	cmp    %rbx,%rdi
   1400012b1:	|  |  |  |  |  |  |  |  |  |        \-- 75 cd                	jne    140001280 <__tmainCRTStartup+0x100> (File Offset: 0x880)
   1400012b3:	|  |  |  |  |  |  |  |  |  |            4c 01 e7             	add    %r12,%rdi
   1400012b6:	|  |  |  |  |  |  |  |  |  |  /-------> 48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
   1400012bd:	|  |  |  |  |  |  |  |  |  |  |         4c 89 25 5c 7d 00 00 	mov    %r12,0x7d5c(%rip)        # 140009020 <argv> (File Offset: 0x8620)
   1400012c4:	|  |  |  |  |  |  |  |  |  |  |         e8 07 0b 00 00       	call   140001dd0 <__main> (File Offset: 0x13d0)
   1400012c9:	|  |  |  |  |  |  |  |  |  |  |         48 8b 05 80 51 00 00 	mov    0x5180(%rip),%rax        # 140006450 <.refptr.__imp___initenv> (File Offset: 0x5a50)
   1400012d0:	|  |  |  |  |  |  |  |  |  |  |         4c 8b 05 41 7d 00 00 	mov    0x7d41(%rip),%r8        # 140009018 <envp> (File Offset: 0x8618)
   1400012d7:	|  |  |  |  |  |  |  |  |  |  |         8b 0d 4b 7d 00 00    	mov    0x7d4b(%rip),%ecx        # 140009028 <argc> (File Offset: 0x8628)
   1400012dd:	|  |  |  |  |  |  |  |  |  |  |         48 8b 00             	mov    (%rax),%rax
   1400012e0:	|  |  |  |  |  |  |  |  |  |  |         4c 89 00             	mov    %r8,(%rax)
   1400012e3:	|  |  |  |  |  |  |  |  |  |  |         48 8b 15 36 7d 00 00 	mov    0x7d36(%rip),%rdx        # 140009020 <argv> (File Offset: 0x8620)
   1400012ea:	|  |  |  |  |  |  |  |  |  |  |         e8 f7 05 00 00       	call   1400018e6 <main> (File Offset: 0xee6)
   1400012ef:	|  |  |  |  |  |  |  |  |  |  |         8b 0d 17 7d 00 00    	mov    0x7d17(%rip),%ecx        # 14000900c <managedapp> (File Offset: 0x860c)
   1400012f5:	|  |  |  |  |  |  |  |  |  |  |         89 05 15 7d 00 00    	mov    %eax,0x7d15(%rip)        # 140009010 <mainret> (File Offset: 0x8610)
   1400012fb:	|  |  |  |  |  |  |  |  |  |  |         85 c9                	test   %ecx,%ecx
   1400012fd:	|  |  |  |  |  |  |  |  |  |  |  /----- 0f 84 c5 00 00 00    	je     1400013c8 <__tmainCRTStartup+0x248> (File Offset: 0x9c8)
   140001303:	|  |  |  |  |  |  |  |  |  |  |  |      8b 15 ff 7c 00 00    	mov    0x7cff(%rip),%edx        # 140009008 <has_cctor> (File Offset: 0x8608)
   140001309:	|  |  |  |  |  |  |  |  |  |  |  |      85 d2                	test   %edx,%edx
   14000130b:	|  |  |  |  |  |  |  |  |  |  |  |  /-- 74 73                	je     140001380 <__tmainCRTStartup+0x200> (File Offset: 0x980)
   14000130d:	|  |  |  |  |  |  |  |  |  |  |  |  |   48 83 c4 20          	add    $0x20,%rsp
   140001311:	|  |  |  |  |  |  |  |  |  |  |  |  |   5b                   	pop    %rbx
   140001312:	|  |  |  |  |  |  |  |  |  |  |  |  |   5e                   	pop    %rsi
   140001313:	|  |  |  |  |  |  |  |  |  |  |  |  |   5f                   	pop    %rdi
   140001314:	|  |  |  |  |  |  |  |  |  |  |  |  |   5d                   	pop    %rbp
   140001315:	|  |  |  |  |  |  |  |  |  |  |  |  |   41 5c                	pop    %r12
   140001317:	|  |  |  |  |  |  |  |  |  |  |  |  |   c3                   	ret
   140001318:	|  |  |  |  |  |  |  |  |  |  |  |  |   0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   14000131f:	|  |  |  |  |  |  |  |  |  |  |  |  |   00 
   140001320:	|  |  \--|--|--|--|--|--|--|--|--|--|-> 48 8b 35 d9 51 00 00 	mov    0x51d9(%rip),%rsi        # 140006500 <.refptr.__native_startup_state> (File Offset: 0x5b00)
   140001327:	|  |     |  |  |  |  |  |  |  |  |  |   bf 01 00 00 00       	mov    $0x1,%edi
   14000132c:	|  |     |  |  |  |  |  |  |  |  |  |   8b 06                	mov    (%rsi),%eax
   14000132e:	|  |     |  |  |  |  |  |  |  |  |  |   83 f8 01             	cmp    $0x1,%eax
   140001331:	|  |     |  |  |  |  \--|--|--|--|--|-- 0f 85 aa fe ff ff    	jne    1400011e1 <__tmainCRTStartup+0x61> (File Offset: 0x7e1)
   140001337:	|  |     |  |  \--|-----|--|--|--|--|-> b9 1f 00 00 00       	mov    $0x1f,%ecx
   14000133c:	|  |     |  |     |     |  |  |  |  |   e8 37 1b 00 00       	call   140002e78 <_amsg_exit> (File Offset: 0x2478)
   140001341:	|  |     |  |     |     |  |  |  |  |   8b 06                	mov    (%rsi),%eax
   140001343:	|  |     |  |     |     |  |  |  |  |   83 f8 01             	cmp    $0x1,%eax
   140001346:	|  |     |  |     |     |  \--|--|--|-- 0f 85 b4 fe ff ff    	jne    140001200 <__tmainCRTStartup+0x80> (File Offset: 0x800)
   14000134c:	|  |     |  |     \-----|-----|--|--|-> 48 8b 15 cd 51 00 00 	mov    0x51cd(%rip),%rdx        # 140006520 <.refptr.__xc_z> (File Offset: 0x5b20)
   140001353:	|  |     |  |           |     |  |  |   48 8b 0d b6 51 00 00 	mov    0x51b6(%rip),%rcx        # 140006510 <.refptr.__xc_a> (File Offset: 0x5b10)
   14000135a:	|  |     |  |           |     |  |  |   e8 31 1b 00 00       	call   140002e90 <_initterm> (File Offset: 0x2490)
   14000135f:	|  |     |  |           |     |  |  |   85 ff                	test   %edi,%edi
   140001361:	|  |     |  |           |     |  |  |   c7 06 02 00 00 00    	movl   $0x2,(%rsi)
   140001367:	|  |     |  +-----------|-----|--|--|-- 0f 85 9b fe ff ff    	jne    140001208 <__tmainCRTStartup+0x88> (File Offset: 0x808)
   14000136d:	|  |     \--|-----------|-----|--|--|-> 31 c0                	xor    %eax,%eax
   14000136f:	|  |        |           |     |  |  |   48 87 03             	xchg   %rax,(%rbx)
   140001372:	|  |        \-----------|-----|--|--|-- e9 91 fe ff ff       	jmp    140001208 <__tmainCRTStartup+0x88> (File Offset: 0x808)
   140001377:	|  |                    |     |  |  |   66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   14000137e:	|  |                    |     |  |  |   00 00 
   140001380:	|  |                    |     |  |  \-> e8 03 1b 00 00       	call   140002e88 <_cexit> (File Offset: 0x2488)
   140001385:	|  |                    |     |  |      8b 05 85 7c 00 00    	mov    0x7c85(%rip),%eax        # 140009010 <mainret> (File Offset: 0x8610)
   14000138b:	|  |                    |     |  |      48 83 c4 20          	add    $0x20,%rsp
   14000138f:	|  |                    |     |  |      5b                   	pop    %rbx
   140001390:	|  |                    |     |  |      5e                   	pop    %rsi
   140001391:	|  |                    |     |  |      5f                   	pop    %rdi
   140001392:	|  |                    |     |  |      5d                   	pop    %rbp
   140001393:	|  |                    |     |  |      41 5c                	pop    %r12
   140001395:	|  |                    |     |  |      c3                   	ret
   140001396:	|  |                    |     |  |      66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   14000139d:	|  |                    |     |  |      00 00 00 
   1400013a0:	|  \--------------------|-----|--|----> 48 8b 15 99 51 00 00 	mov    0x5199(%rip),%rdx        # 140006540 <.refptr.__xi_z> (File Offset: 0x5b40)
   1400013a7:	|                       |     |  |      c7 06 01 00 00 00    	movl   $0x1,(%rsi)
   1400013ad:	|                       |     |  |      48 8b 0d 7c 51 00 00 	mov    0x517c(%rip),%rcx        # 140006530 <.refptr.__xi_a> (File Offset: 0x5b30)
   1400013b4:	|                       |     |  |      e8 d7 1a 00 00       	call   140002e90 <_initterm> (File Offset: 0x2490)
   1400013b9:	\-----------------------|-----|--|----- e9 37 fe ff ff       	jmp    1400011f5 <__tmainCRTStartup+0x75> (File Offset: 0x7f5)
   1400013be:	                        |     |  |      66 90                	xchg   %ax,%ax
   1400013c0:	                        \-----|--|----> 48 89 c7             	mov    %rax,%rdi
   1400013c3:	                              \--|----- e9 ee fe ff ff       	jmp    1400012b6 <__tmainCRTStartup+0x136> (File Offset: 0x8b6)
   1400013c8:	                                 \----> 89 c1                	mov    %eax,%ecx
   1400013ca:	                                        e8 b1 15 00 00       	call   140002980 <exit> (File Offset: 0x1f80)
   1400013cf:	                                        90                   	nop

00000001400013d0 <WinMainCRTStartup> (File Offset: 0x9d0):
   1400013d0:	48 83 ec 28          	sub    $0x28,%rsp

00000001400013d4 <.l_startw> (File Offset: 0x9d4):
   1400013d4:	48 8b 05 c5 50 00 00 	mov    0x50c5(%rip),%rax        # 1400064a0 <.refptr.__mingw_app_type> (File Offset: 0x5aa0)
   1400013db:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   1400013e1:	e8 9a fd ff ff       	call   140001180 <__tmainCRTStartup> (File Offset: 0x780)
   1400013e6:	90                   	nop

00000001400013e7 <.l_endw> (File Offset: 0x9e7):
   1400013e7:	90                   	nop
   1400013e8:	48 83 c4 28          	add    $0x28,%rsp
   1400013ec:	c3                   	ret
   1400013ed:	0f 1f 00             	nopl   (%rax)

00000001400013f0 <mainCRTStartup> (File Offset: 0x9f0):
   1400013f0:	48 83 ec 28          	sub    $0x28,%rsp

00000001400013f4 <.l_start> (File Offset: 0x9f4):
   1400013f4:	48 8b 05 a5 50 00 00 	mov    0x50a5(%rip),%rax        # 1400064a0 <.refptr.__mingw_app_type> (File Offset: 0x5aa0)
   1400013fb:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   140001401:	e8 7a fd ff ff       	call   140001180 <__tmainCRTStartup> (File Offset: 0x780)
   140001406:	90                   	nop

0000000140001407 <.l_end> (File Offset: 0xa07):
   140001407:	90                   	nop
   140001408:	48 83 c4 28          	add    $0x28,%rsp
   14000140c:	c3                   	ret
   14000140d:	0f 1f 00             	nopl   (%rax)

0000000140001410 <atexit> (File Offset: 0xa10):
   140001410:	48 83 ec 28          	sub    $0x28,%rsp
   140001414:	e8 7f 1a 00 00       	call   140002e98 <_onexit> (File Offset: 0x2498)
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

0000000140001430 <__gcc_register_frame> (File Offset: 0xa30):
   140001430:	48 8d 0d 09 00 00 00 	lea    0x9(%rip),%rcx        # 140001440 <__gcc_deregister_frame> (File Offset: 0xa40)
   140001437:	e9 d4 ff ff ff       	jmp    140001410 <atexit> (File Offset: 0xa10)
   14000143c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000140001440 <__gcc_deregister_frame> (File Offset: 0xa40):
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

0000000140001450 <_Z11clear_cacheR9auxiliary> (File Offset: 0xa50):
   140001450:	       55                   	push   %rbp
   140001451:	       48 89 e5             	mov    %rsp,%rbp
   140001454:	       48 83 ec 30          	sub    $0x30,%rsp
   140001458:	       48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000145c:	       c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   140001463:	   /-- eb 24                	jmp    140001489 <_Z11clear_cacheR9auxiliary+0x39> (File Offset: 0xa89)
   140001465:	/--|-> e8 76 1a 00 00       	call   140002ee0 <rand> (File Offset: 0x24e0)
   14000146a:	|  |   8b 55 fc             	mov    -0x4(%rbp),%edx
   14000146d:	|  |   0f af c2             	imul   %edx,%eax
   140001470:	|  |   89 c1                	mov    %eax,%ecx
   140001472:	|  |   48 8b 45 10          	mov    0x10(%rbp),%rax
   140001476:	|  |   48 8b 10             	mov    (%rax),%rdx
   140001479:	|  |   8b 45 fc             	mov    -0x4(%rbp),%eax
   14000147c:	|  |   48 98                	cltq
   14000147e:	|  |   48 01 d0             	add    %rdx,%rax
   140001481:	|  |   89 ca                	mov    %ecx,%edx
   140001483:	|  |   88 10                	mov    %dl,(%rax)
   140001485:	|  |   83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   140001489:	|  \-> 48 8b 45 10          	mov    0x10(%rbp),%rax
   14000148d:	|      8b 40 08             	mov    0x8(%rax),%eax
   140001490:	|      39 45 fc             	cmp    %eax,-0x4(%rbp)
   140001493:	\----- 7c d0                	jl     140001465 <_Z11clear_cacheR9auxiliary+0x15> (File Offset: 0xa65)
   140001495:	       90                   	nop
   140001496:	       90                   	nop
   140001497:	       48 83 c4 30          	add    $0x30,%rsp
   14000149b:	       5d                   	pop    %rbp
   14000149c:	       c3                   	ret

000000014000149d <_Z12push_fact_fnR5state> (File Offset: 0xa9d):
   14000149d:	       55                   	push   %rbp
   14000149e:	       53                   	push   %rbx
   14000149f:	       48 83 ec 48          	sub    $0x48,%rsp
   1400014a3:	       48 8d 6c 24 40       	lea    0x40(%rsp),%rbp
   1400014a8:	       48 89 4d 20          	mov    %rcx,0x20(%rbp)
   1400014ac:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   1400014b0:	       8b 00                	mov    (%rax),%eax
   1400014b2:	       89 45 fc             	mov    %eax,-0x4(%rbp)
   1400014b5:	       8b 45 fc             	mov    -0x4(%rbp),%eax
   1400014b8:	       89 45 f8             	mov    %eax,-0x8(%rbp)
   1400014bb:	       b9 10 00 00 00       	mov    $0x10,%ecx
   1400014c0:	       e8 03 08 00 00       	call   140001cc8 <_Znwy> (File Offset: 0x12c8)
   1400014c5:	       48 89 c3             	mov    %rax,%rbx
   1400014c8:	       ba 00 00 00 00       	mov    $0x0,%edx
   1400014cd:	       48 89 d9             	mov    %rbx,%rcx
   1400014d0:	       e8 7b 1b 00 00       	call   140003050 <_ZN13ins_reg_storeC1Eh> (File Offset: 0x2650)
   1400014d5:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   1400014d9:	       48 83 c0 08          	add    $0x8,%rax
   1400014dd:	       8b 55 fc             	mov    -0x4(%rbp),%edx
   1400014e0:	       8d 4a 01             	lea    0x1(%rdx),%ecx
   1400014e3:	       89 4d fc             	mov    %ecx,-0x4(%rbp)
   1400014e6:	       89 d2                	mov    %edx,%edx
   1400014e8:	       48 89 c1             	mov    %rax,%rcx
   1400014eb:	       e8 70 2b 00 00       	call   140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660)
   1400014f0:	       48 89 18             	mov    %rbx,(%rax)
   1400014f3:	       b9 10 00 00 00       	mov    $0x10,%ecx
   1400014f8:	       e8 cb 07 00 00       	call   140001cc8 <_Znwy> (File Offset: 0x12c8)
   1400014fd:	       48 89 c3             	mov    %rax,%rbx
   140001500:	       ba ff ff ff ff       	mov    $0xffffffff,%edx
   140001505:	       48 89 d9             	mov    %rbx,%rcx
   140001508:	       e8 73 1c 00 00       	call   140003180 <_ZN6ins_jzC1Ej> (File Offset: 0x2780)
   14000150d:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   140001511:	       48 83 c0 08          	add    $0x8,%rax
   140001515:	       8b 55 fc             	mov    -0x4(%rbp),%edx
   140001518:	       8d 4a 01             	lea    0x1(%rdx),%ecx
   14000151b:	       89 4d fc             	mov    %ecx,-0x4(%rbp)
   14000151e:	       89 d2                	mov    %edx,%edx
   140001520:	       48 89 c1             	mov    %rax,%rcx
   140001523:	       e8 38 2b 00 00       	call   140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660)
   140001528:	       48 89 18             	mov    %rbx,(%rax)
   14000152b:	       b9 10 00 00 00       	mov    $0x10,%ecx
   140001530:	       e8 93 07 00 00       	call   140001cc8 <_Znwy> (File Offset: 0x12c8)
   140001535:	       48 89 c3             	mov    %rax,%rbx
   140001538:	       ba 01 00 00 00       	mov    $0x1,%edx
   14000153d:	       48 89 d9             	mov    %rbx,%rcx
   140001540:	       e8 3b 20 00 00       	call   140003580 <_ZN8ins_pushC1Ej> (File Offset: 0x2b80)
   140001545:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   140001549:	       48 83 c0 08          	add    $0x8,%rax
   14000154d:	       8b 55 fc             	mov    -0x4(%rbp),%edx
   140001550:	       8d 4a 01             	lea    0x1(%rdx),%ecx
   140001553:	       89 4d fc             	mov    %ecx,-0x4(%rbp)
   140001556:	       89 d2                	mov    %edx,%edx
   140001558:	       48 89 c1             	mov    %rax,%rcx
   14000155b:	       e8 00 2b 00 00       	call   140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660)
   140001560:	       48 89 18             	mov    %rbx,(%rax)
   140001563:	       8b 45 fc             	mov    -0x4(%rbp),%eax
   140001566:	       89 45 f4             	mov    %eax,-0xc(%rbp)
   140001569:	       b9 08 00 00 00       	mov    $0x8,%ecx
   14000156e:	       e8 55 07 00 00       	call   140001cc8 <_Znwy> (File Offset: 0x12c8)
   140001573:	       48 89 c3             	mov    %rax,%rbx
   140001576:	       48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
   14000157d:	       48 89 d9             	mov    %rbx,%rcx
   140001580:	       e8 eb 1d 00 00       	call   140003370 <_ZN7ins_mulC1Ev> (File Offset: 0x2970)
   140001585:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   140001589:	       48 83 c0 08          	add    $0x8,%rax
   14000158d:	       8b 55 fc             	mov    -0x4(%rbp),%edx
   140001590:	       8d 4a 01             	lea    0x1(%rdx),%ecx
   140001593:	       89 4d fc             	mov    %ecx,-0x4(%rbp)
   140001596:	       89 d2                	mov    %edx,%edx
   140001598:	       48 89 c1             	mov    %rax,%rcx
   14000159b:	       e8 c0 2a 00 00       	call   140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660)
   1400015a0:	       48 89 18             	mov    %rbx,(%rax)
   1400015a3:	       b9 10 00 00 00       	mov    $0x10,%ecx
   1400015a8:	       e8 1b 07 00 00       	call   140001cc8 <_Znwy> (File Offset: 0x12c8)
   1400015ad:	       48 89 c3             	mov    %rax,%rbx
   1400015b0:	       ba 00 00 00 00       	mov    $0x0,%edx
   1400015b5:	       48 89 d9             	mov    %rbx,%rcx
   1400015b8:	       e8 f3 19 00 00       	call   140002fb0 <_ZN12ins_reg_loadC1Eh> (File Offset: 0x25b0)
   1400015bd:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   1400015c1:	       48 83 c0 08          	add    $0x8,%rax
   1400015c5:	       8b 55 fc             	mov    -0x4(%rbp),%edx
   1400015c8:	       8d 4a 01             	lea    0x1(%rdx),%ecx
   1400015cb:	       89 4d fc             	mov    %ecx,-0x4(%rbp)
   1400015ce:	       89 d2                	mov    %edx,%edx
   1400015d0:	       48 89 c1             	mov    %rax,%rcx
   1400015d3:	       e8 88 2a 00 00       	call   140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660)
   1400015d8:	       48 89 18             	mov    %rbx,(%rax)
   1400015db:	       b9 10 00 00 00       	mov    $0x10,%ecx
   1400015e0:	       e8 e3 06 00 00       	call   140001cc8 <_Znwy> (File Offset: 0x12c8)
   1400015e5:	       48 89 c3             	mov    %rax,%rbx
   1400015e8:	       ba ff ff ff ff       	mov    $0xffffffff,%edx
   1400015ed:	       48 89 d9             	mov    %rbx,%rcx
   1400015f0:	       e8 8b 1f 00 00       	call   140003580 <_ZN8ins_pushC1Ej> (File Offset: 0x2b80)
   1400015f5:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   1400015f9:	       48 83 c0 08          	add    $0x8,%rax
   1400015fd:	       8b 55 fc             	mov    -0x4(%rbp),%edx
   140001600:	       8d 4a 01             	lea    0x1(%rdx),%ecx
   140001603:	       89 4d fc             	mov    %ecx,-0x4(%rbp)
   140001606:	       89 d2                	mov    %edx,%edx
   140001608:	       48 89 c1             	mov    %rax,%rcx
   14000160b:	       e8 50 2a 00 00       	call   140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660)
   140001610:	       48 89 18             	mov    %rbx,(%rax)
   140001613:	       b9 08 00 00 00       	mov    $0x8,%ecx
   140001618:	       e8 ab 06 00 00       	call   140001cc8 <_Znwy> (File Offset: 0x12c8)
   14000161d:	       48 89 c3             	mov    %rax,%rbx
   140001620:	       48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
   140001627:	       48 89 d9             	mov    %rbx,%rcx
   14000162a:	       e8 21 1c 00 00       	call   140003250 <_ZN7ins_addC1Ev> (File Offset: 0x2850)
   14000162f:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   140001633:	       48 83 c0 08          	add    $0x8,%rax
   140001637:	       8b 55 fc             	mov    -0x4(%rbp),%edx
   14000163a:	       8d 4a 01             	lea    0x1(%rdx),%ecx
   14000163d:	       89 4d fc             	mov    %ecx,-0x4(%rbp)
   140001640:	       89 d2                	mov    %edx,%edx
   140001642:	       48 89 c1             	mov    %rax,%rcx
   140001645:	       e8 16 2a 00 00       	call   140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660)
   14000164a:	       48 89 18             	mov    %rbx,(%rax)
   14000164d:	       b9 10 00 00 00       	mov    $0x10,%ecx
   140001652:	       e8 71 06 00 00       	call   140001cc8 <_Znwy> (File Offset: 0x12c8)
   140001657:	       48 89 c3             	mov    %rax,%rbx
   14000165a:	       ba 00 00 00 00       	mov    $0x0,%edx
   14000165f:	       48 89 d9             	mov    %rbx,%rcx
   140001662:	       e8 e9 19 00 00       	call   140003050 <_ZN13ins_reg_storeC1Eh> (File Offset: 0x2650)
   140001667:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   14000166b:	       48 83 c0 08          	add    $0x8,%rax
   14000166f:	       8b 55 fc             	mov    -0x4(%rbp),%edx
   140001672:	       8d 4a 01             	lea    0x1(%rdx),%ecx
   140001675:	       89 4d fc             	mov    %ecx,-0x4(%rbp)
   140001678:	       89 d2                	mov    %edx,%edx
   14000167a:	       48 89 c1             	mov    %rax,%rcx
   14000167d:	       e8 de 29 00 00       	call   140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660)
   140001682:	       48 89 18             	mov    %rbx,(%rax)
   140001685:	       b9 10 00 00 00       	mov    $0x10,%ecx
   14000168a:	       e8 39 06 00 00       	call   140001cc8 <_Znwy> (File Offset: 0x12c8)
   14000168f:	       48 89 c3             	mov    %rax,%rbx
   140001692:	       ba ff ff ff ff       	mov    $0xffffffff,%edx
   140001697:	       48 89 d9             	mov    %rbx,%rcx
   14000169a:	       e8 e1 1a 00 00       	call   140003180 <_ZN6ins_jzC1Ej> (File Offset: 0x2780)
   14000169f:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   1400016a3:	       48 83 c0 08          	add    $0x8,%rax
   1400016a7:	       8b 55 fc             	mov    -0x4(%rbp),%edx
   1400016aa:	       8d 4a 01             	lea    0x1(%rdx),%ecx
   1400016ad:	       89 4d fc             	mov    %ecx,-0x4(%rbp)
   1400016b0:	       89 d2                	mov    %edx,%edx
   1400016b2:	       48 89 c1             	mov    %rax,%rcx
   1400016b5:	       e8 a6 29 00 00       	call   140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660)
   1400016ba:	       48 89 18             	mov    %rbx,(%rax)
   1400016bd:	       b9 10 00 00 00       	mov    $0x10,%ecx
   1400016c2:	       e8 01 06 00 00       	call   140001cc8 <_Znwy> (File Offset: 0x12c8)
   1400016c7:	       48 89 c3             	mov    %rax,%rbx
   1400016ca:	       8b 45 f4             	mov    -0xc(%rbp),%eax
   1400016cd:	       89 c2                	mov    %eax,%edx
   1400016cf:	       48 89 d9             	mov    %rbx,%rcx
   1400016d2:	       e8 c9 1b 00 00       	call   1400032a0 <_ZN7ins_jmpC1Ej> (File Offset: 0x28a0)
   1400016d7:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   1400016db:	       48 83 c0 08          	add    $0x8,%rax
   1400016df:	       8b 55 fc             	mov    -0x4(%rbp),%edx
   1400016e2:	       8d 4a 01             	lea    0x1(%rdx),%ecx
   1400016e5:	       89 4d fc             	mov    %ecx,-0x4(%rbp)
   1400016e8:	       89 d2                	mov    %edx,%edx
   1400016ea:	       48 89 c1             	mov    %rax,%rcx
   1400016ed:	       e8 6e 29 00 00       	call   140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660)
   1400016f2:	       48 89 18             	mov    %rbx,(%rax)
   1400016f5:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   1400016f9:	       48 83 c0 08          	add    $0x8,%rax
   1400016fd:	       8b 55 f8             	mov    -0x8(%rbp),%edx
   140001700:	       83 c2 01             	add    $0x1,%edx
   140001703:	       89 d2                	mov    %edx,%edx
   140001705:	       48 89 c1             	mov    %rax,%rcx
   140001708:	       e8 53 29 00 00       	call   140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660)
   14000170d:	       48 8b 00             	mov    (%rax),%rax
   140001710:	       48 85 c0             	test   %rax,%rax
   140001713:	/----- 74 1e                	je     140001733 <_Z12push_fact_fnR5state+0x296> (File Offset: 0xd33)
   140001715:	|      41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000171b:	|      4c 8d 05 de 4e 00 00 	lea    0x4ede(%rip),%r8        # 140006600 <_ZTI6ins_jz> (File Offset: 0x5c00)
   140001722:	|      48 8d 15 c7 4e 00 00 	lea    0x4ec7(%rip),%rdx        # 1400065f0 <_ZTI3ins> (File Offset: 0x5bf0)
   140001729:	|      48 89 c1             	mov    %rax,%rcx
   14000172c:	|      e8 77 05 00 00       	call   140001ca8 <__dynamic_cast> (File Offset: 0x12a8)
   140001731:	|  /-- eb 05                	jmp    140001738 <_Z12push_fact_fnR5state+0x29b> (File Offset: 0xd38)
   140001733:	\--|-> b8 00 00 00 00       	mov    $0x0,%eax
   140001738:	   \-> 48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000173c:	       48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   140001741:	   /-- 75 23                	jne    140001766 <_Z12push_fact_fnR5state+0x2c9> (File Offset: 0xd66)
   140001743:	   |   41 b8 d2 00 00 00    	mov    $0xd2,%r8d
   140001749:	   |   48 8d 05 b0 48 00 00 	lea    0x48b0(%rip),%rax        # 140006000 <.rdata> (File Offset: 0x5600)
   140001750:	   |   48 89 c2             	mov    %rax,%rdx
   140001753:	   |   48 8d 05 ad 48 00 00 	lea    0x48ad(%rip),%rax        # 140006007 <.rdata+0x7> (File Offset: 0x5607)
   14000175a:	   |   48 89 c1             	mov    %rax,%rcx
   14000175d:	   |   48 8b 05 90 8b 00 00 	mov    0x8b90(%rip),%rax        # 14000a2f4 <__imp__assert> (File Offset: 0x98f4)
   140001764:	   |   ff d0                	call   *%rax
   140001766:	   \-> 8b 55 fc             	mov    -0x4(%rbp),%edx
   140001769:	       48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000176d:	       48 89 c1             	mov    %rax,%rcx
   140001770:	       e8 eb 19 00 00       	call   140003160 <_ZN6ins_jz5patchEj> (File Offset: 0x2760)
   140001775:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   140001779:	       48 83 c0 08          	add    $0x8,%rax
   14000177d:	       8b 55 f8             	mov    -0x8(%rbp),%edx
   140001780:	       83 c2 08             	add    $0x8,%edx
   140001783:	       89 d2                	mov    %edx,%edx
   140001785:	       48 89 c1             	mov    %rax,%rcx
   140001788:	       e8 d3 28 00 00       	call   140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660)
   14000178d:	       48 8b 00             	mov    (%rax),%rax
   140001790:	       48 85 c0             	test   %rax,%rax
   140001793:	/----- 74 1e                	je     1400017b3 <_Z12push_fact_fnR5state+0x316> (File Offset: 0xdb3)
   140001795:	|      41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000179b:	|      4c 8d 05 5e 4e 00 00 	lea    0x4e5e(%rip),%r8        # 140006600 <_ZTI6ins_jz> (File Offset: 0x5c00)
   1400017a2:	|      48 8d 15 47 4e 00 00 	lea    0x4e47(%rip),%rdx        # 1400065f0 <_ZTI3ins> (File Offset: 0x5bf0)
   1400017a9:	|      48 89 c1             	mov    %rax,%rcx
   1400017ac:	|      e8 f7 04 00 00       	call   140001ca8 <__dynamic_cast> (File Offset: 0x12a8)
   1400017b1:	|  /-- eb 05                	jmp    1400017b8 <_Z12push_fact_fnR5state+0x31b> (File Offset: 0xdb8)
   1400017b3:	\--|-> b8 00 00 00 00       	mov    $0x0,%eax
   1400017b8:	   \-> 48 89 45 e8          	mov    %rax,-0x18(%rbp)
   1400017bc:	       48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   1400017c1:	   /-- 75 23                	jne    1400017e6 <_Z12push_fact_fnR5state+0x349> (File Offset: 0xde6)
   1400017c3:	   |   41 b8 d5 00 00 00    	mov    $0xd5,%r8d
   1400017c9:	   |   48 8d 05 30 48 00 00 	lea    0x4830(%rip),%rax        # 140006000 <.rdata> (File Offset: 0x5600)
   1400017d0:	   |   48 89 c2             	mov    %rax,%rdx
   1400017d3:	   |   48 8d 05 2d 48 00 00 	lea    0x482d(%rip),%rax        # 140006007 <.rdata+0x7> (File Offset: 0x5607)
   1400017da:	   |   48 89 c1             	mov    %rax,%rcx
   1400017dd:	   |   48 8b 05 10 8b 00 00 	mov    0x8b10(%rip),%rax        # 14000a2f4 <__imp__assert> (File Offset: 0x98f4)
   1400017e4:	   |   ff d0                	call   *%rax
   1400017e6:	   \-> 8b 55 fc             	mov    -0x4(%rbp),%edx
   1400017e9:	       48 8b 45 e8          	mov    -0x18(%rbp),%rax
   1400017ed:	       48 89 c1             	mov    %rax,%rcx
   1400017f0:	       e8 6b 19 00 00       	call   140003160 <_ZN6ins_jz5patchEj> (File Offset: 0x2760)
   1400017f5:	       b9 08 00 00 00       	mov    $0x8,%ecx
   1400017fa:	       e8 c9 04 00 00       	call   140001cc8 <_Znwy> (File Offset: 0x12c8)
   1400017ff:	       48 89 c3             	mov    %rax,%rbx
   140001802:	       48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
   140001809:	       48 89 d9             	mov    %rbx,%rcx
   14000180c:	       e8 bf 1b 00 00       	call   1400033d0 <_ZN7ins_popC1Ev> (File Offset: 0x29d0)
   140001811:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   140001815:	       48 83 c0 08          	add    $0x8,%rax
   140001819:	       8b 55 fc             	mov    -0x4(%rbp),%edx
   14000181c:	       8d 4a 01             	lea    0x1(%rdx),%ecx
   14000181f:	       89 4d fc             	mov    %ecx,-0x4(%rbp)
   140001822:	       89 d2                	mov    %edx,%edx
   140001824:	       48 89 c1             	mov    %rax,%rcx
   140001827:	       e8 34 28 00 00       	call   140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660)
   14000182c:	       48 89 18             	mov    %rbx,(%rax)
   14000182f:	       b9 10 00 00 00       	mov    $0x10,%ecx
   140001834:	       e8 8f 04 00 00       	call   140001cc8 <_Znwy> (File Offset: 0x12c8)
   140001839:	       48 89 c3             	mov    %rax,%rbx
   14000183c:	       ba 00 00 00 00       	mov    $0x0,%edx
   140001841:	       48 89 d9             	mov    %rbx,%rcx
   140001844:	       e8 07 18 00 00       	call   140003050 <_ZN13ins_reg_storeC1Eh> (File Offset: 0x2650)
   140001849:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   14000184d:	       48 83 c0 08          	add    $0x8,%rax
   140001851:	       8b 55 fc             	mov    -0x4(%rbp),%edx
   140001854:	       8d 4a 01             	lea    0x1(%rdx),%ecx
   140001857:	       89 4d fc             	mov    %ecx,-0x4(%rbp)
   14000185a:	       89 d2                	mov    %edx,%edx
   14000185c:	       48 89 c1             	mov    %rax,%rcx
   14000185f:	       e8 fc 27 00 00       	call   140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660)
   140001864:	       48 89 18             	mov    %rbx,(%rax)
   140001867:	       b9 10 00 00 00       	mov    $0x10,%ecx
   14000186c:	       e8 57 04 00 00       	call   140001cc8 <_Znwy> (File Offset: 0x12c8)
   140001871:	       48 89 c3             	mov    %rax,%rbx
   140001874:	       ba 01 00 00 00       	mov    $0x1,%edx
   140001879:	       48 89 d9             	mov    %rbx,%rcx
   14000187c:	       e8 2f 17 00 00       	call   140002fb0 <_ZN12ins_reg_loadC1Eh> (File Offset: 0x25b0)
   140001881:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   140001885:	       48 83 c0 08          	add    $0x8,%rax
   140001889:	       8b 55 fc             	mov    -0x4(%rbp),%edx
   14000188c:	       8d 4a 01             	lea    0x1(%rdx),%ecx
   14000188f:	       89 4d fc             	mov    %ecx,-0x4(%rbp)
   140001892:	       89 d2                	mov    %edx,%edx
   140001894:	       48 89 c1             	mov    %rax,%rcx
   140001897:	       e8 c4 27 00 00       	call   140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660)
   14000189c:	       48 89 18             	mov    %rbx,(%rax)
   14000189f:	       b9 08 00 00 00       	mov    $0x8,%ecx
   1400018a4:	       e8 1f 04 00 00       	call   140001cc8 <_Znwy> (File Offset: 0x12c8)
   1400018a9:	       48 89 c3             	mov    %rax,%rbx
   1400018ac:	       48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
   1400018b3:	       48 89 d9             	mov    %rbx,%rcx
   1400018b6:	       e8 95 1b 00 00       	call   140003450 <_ZN7ins_retC1Ev> (File Offset: 0x2a50)
   1400018bb:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   1400018bf:	       48 83 c0 08          	add    $0x8,%rax
   1400018c3:	       8b 55 fc             	mov    -0x4(%rbp),%edx
   1400018c6:	       8d 4a 01             	lea    0x1(%rdx),%ecx
   1400018c9:	       89 4d fc             	mov    %ecx,-0x4(%rbp)
   1400018cc:	       89 d2                	mov    %edx,%edx
   1400018ce:	       48 89 c1             	mov    %rax,%rcx
   1400018d1:	       e8 8a 27 00 00       	call   140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660)
   1400018d6:	       48 89 18             	mov    %rbx,(%rax)
   1400018d9:	       8b 45 fc             	mov    -0x4(%rbp),%eax
   1400018dc:	       83 c0 01             	add    $0x1,%eax
   1400018df:	       48 83 c4 48          	add    $0x48,%rsp
   1400018e3:	       5b                   	pop    %rbx
   1400018e4:	       5d                   	pop    %rbp
   1400018e5:	       c3                   	ret

00000001400018e6 <main> (File Offset: 0xee6):
   1400018e6:	             55                   	push   %rbp
   1400018e7:	             53                   	push   %rbx
   1400018e8:	             b8 d8 88 00 00       	mov    $0x88d8,%eax
   1400018ed:	             e8 be 14 00 00       	call   140002db0 <___chkstk_ms> (File Offset: 0x23b0)
   1400018f2:	             48 29 c4             	sub    %rax,%rsp
   1400018f5:	             48 8d ac 24 80 00 00 	lea    0x80(%rsp),%rbp
   1400018fc:	             00 
   1400018fd:	             e8 ce 04 00 00       	call   140001dd0 <__main> (File Offset: 0x13d0)
   140001902:	             c7 85 08 88 00 00 00 	movl   $0x1400000,0x8808(%rbp)
   140001909:	             00 40 01 
   14000190c:	             8b 85 08 88 00 00    	mov    0x8808(%rbp),%eax
   140001912:	             48 98                	cltq
   140001914:	             48 89 c1             	mov    %rax,%rcx
   140001917:	             e8 ac 15 00 00       	call   140002ec8 <malloc> (File Offset: 0x24c8)
   14000191c:	             48 89 85 00 88 00 00 	mov    %rax,0x8800(%rbp)
   140001923:	             48 8d 45 a0          	lea    -0x60(%rbp),%rax
   140001927:	             48 89 c1             	mov    %rax,%rcx
   14000192a:	             e8 81 17 00 00       	call   1400030b0 <_ZN5stateC1Ev> (File Offset: 0x26b0)
   14000192f:	             c7 45 a0 00 00 00 00 	movl   $0x0,-0x60(%rbp)
   140001936:	             c6 85 f8 87 00 00 01 	movb   $0x1,0x87f8(%rbp)
   14000193d:	             c7 85 40 88 00 00 00 	movl   $0x0,0x8840(%rbp)
   140001944:	             00 00 00 
   140001947:	             48 8d 45 a0          	lea    -0x60(%rbp),%rax
   14000194b:	             48 89 c1             	mov    %rax,%rcx
   14000194e:	             e8 4a fb ff ff       	call   14000149d <_Z12push_fact_fnR5state> (File Offset: 0xa9d)
   140001953:	             89 85 3c 88 00 00    	mov    %eax,0x883c(%rbp)
   140001959:	             8b 85 3c 88 00 00    	mov    0x883c(%rbp),%eax
   14000195f:	             89 85 38 88 00 00    	mov    %eax,0x8838(%rbp)
   140001965:	             b9 10 00 00 00       	mov    $0x10,%ecx
   14000196a:	             e8 59 03 00 00       	call   140001cc8 <_Znwy> (File Offset: 0x12c8)
   14000196f:	             48 89 c3             	mov    %rax,%rbx
   140001972:	             ba 0a 00 00 00       	mov    $0xa,%edx
   140001977:	             48 89 d9             	mov    %rbx,%rcx
   14000197a:	             e8 01 1c 00 00       	call   140003580 <_ZN8ins_pushC1Ej> (File Offset: 0x2b80)
   14000197f:	             8b 85 3c 88 00 00    	mov    0x883c(%rbp),%eax
   140001985:	             8d 50 01             	lea    0x1(%rax),%edx
   140001988:	             89 95 3c 88 00 00    	mov    %edx,0x883c(%rbp)
   14000198e:	             89 c2                	mov    %eax,%edx
   140001990:	             48 8d 45 a0          	lea    -0x60(%rbp),%rax
   140001994:	             48 83 c0 08          	add    $0x8,%rax
   140001998:	             48 89 c1             	mov    %rax,%rcx
   14000199b:	             e8 c0 26 00 00       	call   140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660)
   1400019a0:	             48 89 18             	mov    %rbx,(%rax)
   1400019a3:	             b9 10 00 00 00       	mov    $0x10,%ecx
   1400019a8:	             e8 1b 03 00 00       	call   140001cc8 <_Znwy> (File Offset: 0x12c8)
   1400019ad:	             48 89 c3             	mov    %rax,%rbx
   1400019b0:	             8b 85 40 88 00 00    	mov    0x8840(%rbp),%eax
   1400019b6:	             89 c2                	mov    %eax,%edx
   1400019b8:	             48 89 d9             	mov    %rbx,%rcx
   1400019bb:	             e8 f0 1a 00 00       	call   1400034b0 <_ZN8ins_callC1Ej> (File Offset: 0x2ab0)
   1400019c0:	             8b 85 3c 88 00 00    	mov    0x883c(%rbp),%eax
   1400019c6:	             8d 50 01             	lea    0x1(%rax),%edx
   1400019c9:	             89 95 3c 88 00 00    	mov    %edx,0x883c(%rbp)
   1400019cf:	             89 c2                	mov    %eax,%edx
   1400019d1:	             48 8d 45 a0          	lea    -0x60(%rbp),%rax
   1400019d5:	             48 83 c0 08          	add    $0x8,%rax
   1400019d9:	             48 89 c1             	mov    %rax,%rcx
   1400019dc:	             e8 7f 26 00 00       	call   140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660)
   1400019e1:	             48 89 18             	mov    %rbx,(%rax)
   1400019e4:	             b9 10 00 00 00       	mov    $0x10,%ecx
   1400019e9:	             e8 da 02 00 00       	call   140001cc8 <_Znwy> (File Offset: 0x12c8)
   1400019ee:	             48 89 c3             	mov    %rax,%rbx
   1400019f1:	             ba 00 00 00 00       	mov    $0x0,%edx
   1400019f6:	             48 89 d9             	mov    %rbx,%rcx
   1400019f9:	             e8 b2 15 00 00       	call   140002fb0 <_ZN12ins_reg_loadC1Eh> (File Offset: 0x25b0)
   1400019fe:	             8b 85 3c 88 00 00    	mov    0x883c(%rbp),%eax
   140001a04:	             8d 50 01             	lea    0x1(%rax),%edx
   140001a07:	             89 95 3c 88 00 00    	mov    %edx,0x883c(%rbp)
   140001a0d:	             89 c2                	mov    %eax,%edx
   140001a0f:	             48 8d 45 a0          	lea    -0x60(%rbp),%rax
   140001a13:	             48 83 c0 08          	add    $0x8,%rax
   140001a17:	             48 89 c1             	mov    %rax,%rcx
   140001a1a:	             e8 41 26 00 00       	call   140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660)
   140001a1f:	             48 89 18             	mov    %rbx,(%rax)
   140001a22:	             b9 08 00 00 00       	mov    $0x8,%ecx
   140001a27:	             e8 9c 02 00 00       	call   140001cc8 <_Znwy> (File Offset: 0x12c8)
   140001a2c:	             48 89 c3             	mov    %rax,%rbx
   140001a2f:	             48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
   140001a36:	             48 89 d9             	mov    %rbx,%rcx
   140001a39:	             e8 d2 1a 00 00       	call   140003510 <_ZN8ins_exitC1Ev> (File Offset: 0x2b10)
   140001a3e:	             8b 85 3c 88 00 00    	mov    0x883c(%rbp),%eax
   140001a44:	             8d 50 01             	lea    0x1(%rax),%edx
   140001a47:	             89 95 3c 88 00 00    	mov    %edx,0x883c(%rbp)
   140001a4d:	             89 c2                	mov    %eax,%edx
   140001a4f:	             48 8d 45 a0          	lea    -0x60(%rbp),%rax
   140001a53:	             48 83 c0 08          	add    $0x8,%rax
   140001a57:	             48 89 c1             	mov    %rax,%rcx
   140001a5a:	             e8 01 26 00 00       	call   140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660)
   140001a5f:	             48 89 18             	mov    %rbx,(%rax)
   140001a62:	             c7 85 34 88 00 00 32 	movl   $0x32,0x8834(%rbp)
   140001a69:	             00 00 00 
   140001a6c:	             48 c7 85 48 88 00 00 	movq   $0x0,0x8848(%rbp)
   140001a73:	             00 00 00 00 
   140001a77:	             c7 85 44 88 00 00 00 	movl   $0x0,0x8844(%rbp)
   140001a7e:	             00 00 00 
   140001a81:	   /-------- e9 08 01 00 00       	jmp    140001b8e <main+0x2a8> (File Offset: 0x118e)
   140001a86:	/--|-------> 8b 85 38 88 00 00    	mov    0x8838(%rbp),%eax
   140001a8c:	|  |         89 45 a0             	mov    %eax,-0x60(%rbp)
   140001a8f:	|  |         c6 85 f8 87 00 00 01 	movb   $0x1,0x87f8(%rbp)
   140001a96:	|  |         48 8d 85 00 88 00 00 	lea    0x8800(%rbp),%rax
   140001a9d:	|  |         48 89 c1             	mov    %rax,%rcx
   140001aa0:	|  |         e8 ab f9 ff ff       	call   140001450 <_Z11clear_cacheR9auxiliary> (File Offset: 0xa50)
   140001aa5:	|  |         0f 31                	rdtsc
   140001aa7:	|  |         48 c1 e2 20          	shl    $0x20,%rdx
   140001aab:	|  |         48 09 d0             	or     %rdx,%rax
   140001aae:	|  |         90                   	nop
   140001aaf:	|  |         48 89 85 28 88 00 00 	mov    %rax,0x8828(%rbp)
   140001ab6:	|  |     /-- eb 38                	jmp    140001af0 <main+0x20a> (File Offset: 0x10f0)
   140001ab8:	|  |  /--|-> 8b 45 a0             	mov    -0x60(%rbp),%eax
   140001abb:	|  |  |  |   8d 50 01             	lea    0x1(%rax),%edx
   140001abe:	|  |  |  |   89 55 a0             	mov    %edx,-0x60(%rbp)
   140001ac1:	|  |  |  |   89 85 1c 88 00 00    	mov    %eax,0x881c(%rbp)
   140001ac7:	|  |  |  |   8b 85 1c 88 00 00    	mov    0x881c(%rbp),%eax
   140001acd:	|  |  |  |   48 8d 55 a0          	lea    -0x60(%rbp),%rdx
   140001ad1:	|  |  |  |   48 8d 4a 08          	lea    0x8(%rdx),%rcx
   140001ad5:	|  |  |  |   48 89 c2             	mov    %rax,%rdx
   140001ad8:	|  |  |  |   e8 83 25 00 00       	call   140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660)
   140001add:	|  |  |  |   48 8b 00             	mov    (%rax),%rax
   140001ae0:	|  |  |  |   48 8b 10             	mov    (%rax),%rdx
   140001ae3:	|  |  |  |   4c 8b 02             	mov    (%rdx),%r8
   140001ae6:	|  |  |  |   48 8d 55 a0          	lea    -0x60(%rbp),%rdx
   140001aea:	|  |  |  |   48 89 c1             	mov    %rax,%rcx
   140001aed:	|  |  |  |   41 ff d0             	call   *%r8
   140001af0:	|  |  |  \-> 0f b6 85 f8 87 00 00 	movzbl 0x87f8(%rbp),%eax
   140001af7:	|  |  |      84 c0                	test   %al,%al
   140001af9:	|  |  \----- 75 bd                	jne    140001ab8 <main+0x1d2> (File Offset: 0x10b8)
   140001afb:	|  |         0f 31                	rdtsc
   140001afd:	|  |         48 c1 e2 20          	shl    $0x20,%rdx
   140001b01:	|  |         48 09 d0             	or     %rdx,%rax
   140001b04:	|  |         90                   	nop
   140001b05:	|  |         48 89 85 20 88 00 00 	mov    %rax,0x8820(%rbp)
   140001b0c:	|  |         48 8d 05 f8 44 00 00 	lea    0x44f8(%rip),%rax        # 14000600b <.rdata+0xb> (File Offset: 0x560b)
   140001b13:	|  |         48 89 c2             	mov    %rax,%rdx
   140001b16:	|  |         48 8b 05 c3 48 00 00 	mov    0x48c3(%rip),%rax        # 1400063e0 <__fu12__ZSt4cout> (File Offset: 0x59e0)
   140001b1d:	|  |         48 89 c1             	mov    %rax,%rcx
   140001b20:	|  |         e8 b3 01 00 00       	call   140001cd8 <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc> (File Offset: 0x12d8)
   140001b25:	|  |         48 89 c1             	mov    %rax,%rcx
   140001b28:	|  |         48 8b 85 20 88 00 00 	mov    0x8820(%rbp),%rax
   140001b2f:	|  |         48 2b 85 28 88 00 00 	sub    0x8828(%rbp),%rax
   140001b36:	|  |         48 89 c2             	mov    %rax,%rdx
   140001b39:	|  |         e8 c2 01 00 00       	call   140001d00 <_ZNSolsEy> (File Offset: 0x1300)
   140001b3e:	|  |         48 89 c1             	mov    %rax,%rcx
   140001b41:	|  |         48 8d 05 ca 44 00 00 	lea    0x44ca(%rip),%rax        # 140006012 <.rdata+0x12> (File Offset: 0x5612)
   140001b48:	|  |         48 89 c2             	mov    %rax,%rdx
   140001b4b:	|  |         e8 88 01 00 00       	call   140001cd8 <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc> (File Offset: 0x12d8)
   140001b50:	|  |         48 89 c1             	mov    %rax,%rcx
   140001b53:	|  |         8b 85 44 88 00 00    	mov    0x8844(%rbp),%eax
   140001b59:	|  |         89 c2                	mov    %eax,%edx
   140001b5b:	|  |         e8 a8 01 00 00       	call   140001d08 <_ZNSolsEj> (File Offset: 0x1308)
   140001b60:	|  |         48 89 c1             	mov    %rax,%rcx
   140001b63:	|  |         48 8b 05 86 48 00 00 	mov    0x4886(%rip),%rax        # 1400063f0 <.refptr._ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_> (File Offset: 0x59f0)
   140001b6a:	|  |         48 89 c2             	mov    %rax,%rdx
   140001b6d:	|  |         e8 a6 01 00 00       	call   140001d18 <_ZNSolsEPFRSoS_E> (File Offset: 0x1318)
   140001b72:	|  |         48 8b 85 20 88 00 00 	mov    0x8820(%rbp),%rax
   140001b79:	|  |         48 2b 85 28 88 00 00 	sub    0x8828(%rbp),%rax
   140001b80:	|  |         48 01 85 48 88 00 00 	add    %rax,0x8848(%rbp)
   140001b87:	|  |         83 85 44 88 00 00 01 	addl   $0x1,0x8844(%rbp)
   140001b8e:	|  \-------> 8b 85 44 88 00 00    	mov    0x8844(%rbp),%eax
   140001b94:	|            3b 85 34 88 00 00    	cmp    0x8834(%rbp),%eax
   140001b9a:	\----------- 0f 82 e6 fe ff ff    	jb     140001a86 <main+0x1a0> (File Offset: 0x1086)
   140001ba0:	             48 8d 05 76 44 00 00 	lea    0x4476(%rip),%rax        # 14000601d <.rdata+0x1d> (File Offset: 0x561d)
   140001ba7:	             48 89 c2             	mov    %rax,%rdx
   140001baa:	             48 8b 05 2f 48 00 00 	mov    0x482f(%rip),%rax        # 1400063e0 <__fu12__ZSt4cout> (File Offset: 0x59e0)
   140001bb1:	             48 89 c1             	mov    %rax,%rcx
   140001bb4:	             e8 1f 01 00 00       	call   140001cd8 <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc> (File Offset: 0x12d8)
   140001bb9:	             48 89 c1             	mov    %rax,%rcx
   140001bbc:	             48 8b 85 48 88 00 00 	mov    0x8848(%rbp),%rax
   140001bc3:	             48 85 c0             	test   %rax,%rax
   140001bc6:	         /-- 78 0b                	js     140001bd3 <main+0x2ed> (File Offset: 0x11d3)
   140001bc8:	         |   66 0f ef c0          	pxor   %xmm0,%xmm0
   140001bcc:	         |   f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
   140001bd1:	      /--|-- eb 19                	jmp    140001bec <main+0x306> (File Offset: 0x11ec)
   140001bd3:	      |  \-> 48 89 c2             	mov    %rax,%rdx
   140001bd6:	      |      48 d1 ea             	shr    %rdx
   140001bd9:	      |      83 e0 01             	and    $0x1,%eax
   140001bdc:	      |      48 09 c2             	or     %rax,%rdx
   140001bdf:	      |      66 0f ef c0          	pxor   %xmm0,%xmm0
   140001be3:	      |      f2 48 0f 2a c2       	cvtsi2sd %rdx,%xmm0
   140001be8:	      |      f2 0f 58 c0          	addsd  %xmm0,%xmm0
   140001bec:	      \----> 8b 85 34 88 00 00    	mov    0x8834(%rbp),%eax
   140001bf2:	             48 85 c0             	test   %rax,%rax
   140001bf5:	         /-- 78 0b                	js     140001c02 <main+0x31c> (File Offset: 0x1202)
   140001bf7:	         |   66 0f ef c9          	pxor   %xmm1,%xmm1
   140001bfb:	         |   f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
   140001c00:	      /--|-- eb 19                	jmp    140001c1b <main+0x335> (File Offset: 0x121b)
   140001c02:	      |  \-> 48 89 c2             	mov    %rax,%rdx
   140001c05:	      |      48 d1 ea             	shr    %rdx
   140001c08:	      |      83 e0 01             	and    $0x1,%eax
   140001c0b:	      |      48 09 c2             	or     %rax,%rdx
   140001c0e:	      |      66 0f ef c9          	pxor   %xmm1,%xmm1
   140001c12:	      |      f2 48 0f 2a ca       	cvtsi2sd %rdx,%xmm1
   140001c17:	      |      f2 0f 58 c9          	addsd  %xmm1,%xmm1
   140001c1b:	      \----> f2 0f 5e c1          	divsd  %xmm1,%xmm0
   140001c1f:	             66 0f 28 c8          	movapd %xmm0,%xmm1
   140001c23:	             e8 e8 00 00 00       	call   140001d10 <_ZNSolsEd> (File Offset: 0x1310)
   140001c28:	             48 89 c1             	mov    %rax,%rcx
   140001c2b:	             48 8d 05 f8 43 00 00 	lea    0x43f8(%rip),%rax        # 14000602a <.rdata+0x2a> (File Offset: 0x562a)
   140001c32:	             48 89 c2             	mov    %rax,%rdx
   140001c35:	             e8 9e 00 00 00       	call   140001cd8 <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc> (File Offset: 0x12d8)
   140001c3a:	             48 89 c1             	mov    %rax,%rcx
   140001c3d:	             48 8b 05 ac 47 00 00 	mov    0x47ac(%rip),%rax        # 1400063f0 <.refptr._ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_> (File Offset: 0x59f0)
   140001c44:	             48 89 c2             	mov    %rax,%rdx
   140001c47:	             e8 cc 00 00 00       	call   140001d18 <_ZNSolsEPFRSoS_E> (File Offset: 0x1318)
   140001c4c:	             48 8b 85 00 88 00 00 	mov    0x8800(%rbp),%rax
   140001c53:	             48 89 c1             	mov    %rax,%rcx
   140001c56:	             e8 5d 12 00 00       	call   140002eb8 <free> (File Offset: 0x24b8)
   140001c5b:	             bb 00 00 00 00       	mov    $0x0,%ebx
   140001c60:	             48 8d 45 a0          	lea    -0x60(%rbp),%rax
   140001c64:	             48 89 c1             	mov    %rax,%rcx
   140001c67:	             e8 74 14 00 00       	call   1400030e0 <_ZN5stateD1Ev> (File Offset: 0x26e0)
   140001c6c:	             89 d8                	mov    %ebx,%eax
   140001c6e:	         /-- eb 1a                	jmp    140001c8a <main+0x3a4> (File Offset: 0x128a)
   140001c70:	         |   48 89 c3             	mov    %rax,%rbx
   140001c73:	         |   48 8d 45 a0          	lea    -0x60(%rbp),%rax
   140001c77:	         |   48 89 c1             	mov    %rax,%rcx
   140001c7a:	         |   e8 61 14 00 00       	call   1400030e0 <_ZN5stateD1Ev> (File Offset: 0x26e0)
   140001c7f:	         |   48 89 d8             	mov    %rbx,%rax
   140001c82:	         |   48 89 c1             	mov    %rax,%rcx
   140001c85:	         |   e8 16 11 00 00       	call   140002da0 <_Unwind_Resume> (File Offset: 0x23a0)
   140001c8a:	         \-> 48 81 c4 d8 88 00 00 	add    $0x88d8,%rsp
   140001c91:	             5b                   	pop    %rbx
   140001c92:	             5d                   	pop    %rbp
   140001c93:	             c3                   	ret
   140001c94:	             90                   	nop
   140001c95:	             90                   	nop
   140001c96:	             90                   	nop
   140001c97:	             90                   	nop
   140001c98:	             90                   	nop
   140001c99:	             90                   	nop
   140001c9a:	             90                   	nop
   140001c9b:	             90                   	nop
   140001c9c:	             90                   	nop
   140001c9d:	             90                   	nop
   140001c9e:	             90                   	nop
   140001c9f:	             90                   	nop

0000000140001ca0 <__gxx_personality_seh0> (File Offset: 0x12a0):
   140001ca0:	ff 25 8e 87 00 00    	jmp    *0x878e(%rip)        # 14000a434 <__imp___gxx_personality_seh0> (File Offset: 0x9a34)
   140001ca6:	90                   	nop
   140001ca7:	90                   	nop

0000000140001ca8 <__dynamic_cast> (File Offset: 0x12a8):
   140001ca8:	ff 25 7e 87 00 00    	jmp    *0x877e(%rip)        # 14000a42c <__imp___dynamic_cast> (File Offset: 0x9a2c)
   140001cae:	90                   	nop
   140001caf:	90                   	nop

0000000140001cb0 <__cxa_rethrow> (File Offset: 0x12b0):
   140001cb0:	ff 25 6e 87 00 00    	jmp    *0x876e(%rip)        # 14000a424 <__imp___cxa_rethrow> (File Offset: 0x9a24)
   140001cb6:	90                   	nop
   140001cb7:	90                   	nop

0000000140001cb8 <__cxa_end_catch> (File Offset: 0x12b8):
   140001cb8:	ff 25 5e 87 00 00    	jmp    *0x875e(%rip)        # 14000a41c <__imp___cxa_end_catch> (File Offset: 0x9a1c)
   140001cbe:	90                   	nop
   140001cbf:	90                   	nop

0000000140001cc0 <__cxa_begin_catch> (File Offset: 0x12c0):
   140001cc0:	ff 25 4e 87 00 00    	jmp    *0x874e(%rip)        # 14000a414 <__imp___cxa_begin_catch> (File Offset: 0x9a14)
   140001cc6:	90                   	nop
   140001cc7:	90                   	nop

0000000140001cc8 <_Znwy> (File Offset: 0x12c8):
   140001cc8:	ff 25 3e 87 00 00    	jmp    *0x873e(%rip)        # 14000a40c <__imp__Znwy> (File Offset: 0x9a0c)
   140001cce:	90                   	nop
   140001ccf:	90                   	nop

0000000140001cd0 <_ZdlPvy> (File Offset: 0x12d0):
   140001cd0:	ff 25 2e 87 00 00    	jmp    *0x872e(%rip)        # 14000a404 <__imp__ZdlPvy> (File Offset: 0x9a04)
   140001cd6:	90                   	nop
   140001cd7:	90                   	nop

0000000140001cd8 <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc> (File Offset: 0x12d8):
   140001cd8:	ff 25 0e 87 00 00    	jmp    *0x870e(%rip)        # 14000a3ec <__imp__ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc> (File Offset: 0x99ec)
   140001cde:	90                   	nop
   140001cdf:	90                   	nop

0000000140001ce0 <_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_> (File Offset: 0x12e0):
   140001ce0:	ff 25 fe 86 00 00    	jmp    *0x86fe(%rip)        # 14000a3e4 <__imp__ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_> (File Offset: 0x99e4)
   140001ce6:	90                   	nop
   140001ce7:	90                   	nop

0000000140001ce8 <_ZSt28__throw_bad_array_new_lengthv> (File Offset: 0x12e8):
   140001ce8:	ff 25 e6 86 00 00    	jmp    *0x86e6(%rip)        # 14000a3d4 <__imp__ZSt28__throw_bad_array_new_lengthv> (File Offset: 0x99d4)
   140001cee:	90                   	nop
   140001cef:	90                   	nop

0000000140001cf0 <_ZSt20__throw_length_errorPKc> (File Offset: 0x12f0):
   140001cf0:	ff 25 d6 86 00 00    	jmp    *0x86d6(%rip)        # 14000a3cc <__imp__ZSt20__throw_length_errorPKc> (File Offset: 0x99cc)
   140001cf6:	90                   	nop
   140001cf7:	90                   	nop

0000000140001cf8 <_ZSt17__throw_bad_allocv> (File Offset: 0x12f8):
   140001cf8:	ff 25 c6 86 00 00    	jmp    *0x86c6(%rip)        # 14000a3c4 <__imp__ZSt17__throw_bad_allocv> (File Offset: 0x99c4)
   140001cfe:	90                   	nop
   140001cff:	90                   	nop

0000000140001d00 <_ZNSolsEy> (File Offset: 0x1300):
   140001d00:	ff 25 b6 86 00 00    	jmp    *0x86b6(%rip)        # 14000a3bc <__imp__ZNSolsEy> (File Offset: 0x99bc)
   140001d06:	90                   	nop
   140001d07:	90                   	nop

0000000140001d08 <_ZNSolsEj> (File Offset: 0x1308):
   140001d08:	ff 25 a6 86 00 00    	jmp    *0x86a6(%rip)        # 14000a3b4 <__imp__ZNSolsEj> (File Offset: 0x99b4)
   140001d0e:	90                   	nop
   140001d0f:	90                   	nop

0000000140001d10 <_ZNSolsEd> (File Offset: 0x1310):
   140001d10:	ff 25 96 86 00 00    	jmp    *0x8696(%rip)        # 14000a3ac <__imp__ZNSolsEd> (File Offset: 0x99ac)
   140001d16:	90                   	nop
   140001d17:	90                   	nop

0000000140001d18 <_ZNSolsEPFRSoS_E> (File Offset: 0x1318):
   140001d18:	ff 25 86 86 00 00    	jmp    *0x8686(%rip)        # 14000a3a4 <__imp__ZNSolsEPFRSoS_E> (File Offset: 0x99a4)
   140001d1e:	90                   	nop
   140001d1f:	90                   	nop

0000000140001d20 <__do_global_dtors> (File Offset: 0x1320):
   140001d20:	       48 83 ec 28          	sub    $0x28,%rsp
   140001d24:	       48 8b 05 d5 32 00 00 	mov    0x32d5(%rip),%rax        # 140005000 <__data_start__> (File Offset: 0x4600)
   140001d2b:	       48 8b 00             	mov    (%rax),%rax
   140001d2e:	       48 85 c0             	test   %rax,%rax
   140001d31:	/----- 74 22                	je     140001d55 <__do_global_dtors+0x35> (File Offset: 0x1355)
   140001d33:	|      0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140001d38:	|  /-> ff d0                	call   *%rax
   140001d3a:	|  |   48 8b 05 bf 32 00 00 	mov    0x32bf(%rip),%rax        # 140005000 <__data_start__> (File Offset: 0x4600)
   140001d41:	|  |   48 8d 50 08          	lea    0x8(%rax),%rdx
   140001d45:	|  |   48 8b 40 08          	mov    0x8(%rax),%rax
   140001d49:	|  |   48 89 15 b0 32 00 00 	mov    %rdx,0x32b0(%rip)        # 140005000 <__data_start__> (File Offset: 0x4600)
   140001d50:	|  |   48 85 c0             	test   %rax,%rax
   140001d53:	|  \-- 75 e3                	jne    140001d38 <__do_global_dtors+0x18> (File Offset: 0x1338)
   140001d55:	\----> 48 83 c4 28          	add    $0x28,%rsp
   140001d59:	       c3                   	ret
   140001d5a:	       66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000140001d60 <__do_global_ctors> (File Offset: 0x1360):
   140001d60:	             56                   	push   %rsi
   140001d61:	             53                   	push   %rbx
   140001d62:	             48 83 ec 28          	sub    $0x28,%rsp
   140001d66:	             48 8b 15 93 46 00 00 	mov    0x4693(%rip),%rdx        # 140006400 <.refptr.__CTOR_LIST__> (File Offset: 0x5a00)
   140001d6d:	             48 8b 02             	mov    (%rdx),%rax
   140001d70:	             83 f8 ff             	cmp    $0xffffffff,%eax
   140001d73:	             89 c1                	mov    %eax,%ecx
   140001d75:	   /-------- 74 39                	je     140001db0 <__do_global_ctors+0x50> (File Offset: 0x13b0)
   140001d77:	/--|-------> 85 c9                	test   %ecx,%ecx
   140001d79:	|  |  /----- 74 20                	je     140001d9b <__do_global_ctors+0x3b> (File Offset: 0x139b)
   140001d7b:	|  |  |      89 c8                	mov    %ecx,%eax
   140001d7d:	|  |  |      83 e9 01             	sub    $0x1,%ecx
   140001d80:	|  |  |      48 8d 1c c2          	lea    (%rdx,%rax,8),%rbx
   140001d84:	|  |  |      48 29 c8             	sub    %rcx,%rax
   140001d87:	|  |  |      48 8d 74 c2 f8       	lea    -0x8(%rdx,%rax,8),%rsi
   140001d8c:	|  |  |      0f 1f 40 00          	nopl   0x0(%rax)
   140001d90:	|  |  |  /-> ff 13                	call   *(%rbx)
   140001d92:	|  |  |  |   48 83 eb 08          	sub    $0x8,%rbx
   140001d96:	|  |  |  |   48 39 f3             	cmp    %rsi,%rbx
   140001d99:	|  |  |  \-- 75 f5                	jne    140001d90 <__do_global_ctors+0x30> (File Offset: 0x1390)
   140001d9b:	|  |  \----> 48 8d 0d 7e ff ff ff 	lea    -0x82(%rip),%rcx        # 140001d20 <__do_global_dtors> (File Offset: 0x1320)
   140001da2:	|  |         48 83 c4 28          	add    $0x28,%rsp
   140001da6:	|  |         5b                   	pop    %rbx
   140001da7:	|  |         5e                   	pop    %rsi
   140001da8:	|  |         e9 63 f6 ff ff       	jmp    140001410 <atexit> (File Offset: 0xa10)
   140001dad:	|  |         0f 1f 00             	nopl   (%rax)
   140001db0:	|  \-------> 31 c0                	xor    %eax,%eax
   140001db2:	|            66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140001db8:	|        /-> 44 8d 40 01          	lea    0x1(%rax),%r8d
   140001dbc:	|        |   89 c1                	mov    %eax,%ecx
   140001dbe:	|        |   4a 83 3c c2 00       	cmpq   $0x0,(%rdx,%r8,8)
   140001dc3:	|        |   4c 89 c0             	mov    %r8,%rax
   140001dc6:	|        \-- 75 f0                	jne    140001db8 <__do_global_ctors+0x58> (File Offset: 0x13b8)
   140001dc8:	\----------- eb ad                	jmp    140001d77 <__do_global_ctors+0x17> (File Offset: 0x1377)
   140001dca:	             66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000140001dd0 <__main> (File Offset: 0x13d0):
   140001dd0:	    8b 05 5a 72 00 00    	mov    0x725a(%rip),%eax        # 140009030 <initialized> (File Offset: 0x8630)
   140001dd6:	    85 c0                	test   %eax,%eax
   140001dd8:	/-- 74 06                	je     140001de0 <__main+0x10> (File Offset: 0x13e0)
   140001dda:	|   c3                   	ret
   140001ddb:	|   0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140001de0:	\-> c7 05 46 72 00 00 01 	movl   $0x1,0x7246(%rip)        # 140009030 <initialized> (File Offset: 0x8630)
   140001de7:	    00 00 00 
   140001dea:	    e9 71 ff ff ff       	jmp    140001d60 <__do_global_ctors> (File Offset: 0x1360)
   140001def:	    90                   	nop

0000000140001df0 <_setargv> (File Offset: 0x13f0):
   140001df0:	31 c0                	xor    %eax,%eax
   140001df2:	c3                   	ret
   140001df3:	90                   	nop
   140001df4:	90                   	nop
   140001df5:	90                   	nop
   140001df6:	90                   	nop
   140001df7:	90                   	nop
   140001df8:	90                   	nop
   140001df9:	90                   	nop
   140001dfa:	90                   	nop
   140001dfb:	90                   	nop
   140001dfc:	90                   	nop
   140001dfd:	90                   	nop
   140001dfe:	90                   	nop
   140001dff:	90                   	nop

0000000140001e00 <__dyn_tls_dtor> (File Offset: 0x1400):
   140001e00:	    48 83 ec 28          	sub    $0x28,%rsp
   140001e04:	    83 fa 03             	cmp    $0x3,%edx
   140001e07:	/-- 74 17                	je     140001e20 <__dyn_tls_dtor+0x20> (File Offset: 0x1420)
   140001e09:	|   85 d2                	test   %edx,%edx
   140001e0b:	+-- 74 13                	je     140001e20 <__dyn_tls_dtor+0x20> (File Offset: 0x1420)
   140001e0d:	|   b8 01 00 00 00       	mov    $0x1,%eax
   140001e12:	|   48 83 c4 28          	add    $0x28,%rsp
   140001e16:	|   c3                   	ret
   140001e17:	|   66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   140001e1e:	|   00 00 
   140001e20:	\-> e8 5b 0a 00 00       	call   140002880 <__mingw_TLScallback> (File Offset: 0x1e80)
   140001e25:	    b8 01 00 00 00       	mov    $0x1,%eax
   140001e2a:	    48 83 c4 28          	add    $0x28,%rsp
   140001e2e:	    c3                   	ret
   140001e2f:	    90                   	nop

0000000140001e30 <__dyn_tls_init> (File Offset: 0x1430):
   140001e30:	          56                   	push   %rsi
   140001e31:	          53                   	push   %rbx
   140001e32:	          48 83 ec 28          	sub    $0x28,%rsp
   140001e36:	          48 8b 05 83 45 00 00 	mov    0x4583(%rip),%rax        # 1400063c0 <.refptr._CRT_MT> (File Offset: 0x59c0)
   140001e3d:	          83 38 02             	cmpl   $0x2,(%rax)
   140001e40:	      /-- 74 06                	je     140001e48 <__dyn_tls_init+0x18> (File Offset: 0x1448)
   140001e42:	      |   c7 00 02 00 00 00    	movl   $0x2,(%rax)
   140001e48:	      \-> 83 fa 02             	cmp    $0x2,%edx
   140001e4b:	      /-- 74 13                	je     140001e60 <__dyn_tls_init+0x30> (File Offset: 0x1460)
   140001e4d:	      |   83 fa 01             	cmp    $0x1,%edx
   140001e50:	/-----|-- 74 4e                	je     140001ea0 <__dyn_tls_init+0x70> (File Offset: 0x14a0)
   140001e52:	|  /--|-> b8 01 00 00 00       	mov    $0x1,%eax
   140001e57:	|  |  |   48 83 c4 28          	add    $0x28,%rsp
   140001e5b:	|  |  |   5b                   	pop    %rbx
   140001e5c:	|  |  |   5e                   	pop    %rsi
   140001e5d:	|  |  |   c3                   	ret
   140001e5e:	|  |  |   66 90                	xchg   %ax,%ax
   140001e60:	|  |  \-> 48 8d 1d f1 91 00 00 	lea    0x91f1(%rip),%rbx        # 14000b058 <__xd_z> (File Offset: 0xa658)
   140001e67:	|  |      48 8d 35 ea 91 00 00 	lea    0x91ea(%rip),%rsi        # 14000b058 <__xd_z> (File Offset: 0xa658)
   140001e6e:	|  |      48 39 de             	cmp    %rbx,%rsi
   140001e71:	|  \----- 74 df                	je     140001e52 <__dyn_tls_init+0x22> (File Offset: 0x1452)
   140001e73:	|         0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140001e78:	|  /----> 48 8b 03             	mov    (%rbx),%rax
   140001e7b:	|  |      48 85 c0             	test   %rax,%rax
   140001e7e:	|  |  /-- 74 02                	je     140001e82 <__dyn_tls_init+0x52> (File Offset: 0x1482)
   140001e80:	|  |  |   ff d0                	call   *%rax
   140001e82:	|  |  \-> 48 83 c3 08          	add    $0x8,%rbx
   140001e86:	|  |      48 39 de             	cmp    %rbx,%rsi
   140001e89:	|  \----- 75 ed                	jne    140001e78 <__dyn_tls_init+0x48> (File Offset: 0x1478)
   140001e8b:	|         b8 01 00 00 00       	mov    $0x1,%eax
   140001e90:	|         48 83 c4 28          	add    $0x28,%rsp
   140001e94:	|         5b                   	pop    %rbx
   140001e95:	|         5e                   	pop    %rsi
   140001e96:	|         c3                   	ret
   140001e97:	|         66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   140001e9e:	|         00 00 
   140001ea0:	\-------> e8 db 09 00 00       	call   140002880 <__mingw_TLScallback> (File Offset: 0x1e80)
   140001ea5:	          b8 01 00 00 00       	mov    $0x1,%eax
   140001eaa:	          48 83 c4 28          	add    $0x28,%rsp
   140001eae:	          5b                   	pop    %rbx
   140001eaf:	          5e                   	pop    %rsi
   140001eb0:	          c3                   	ret
   140001eb1:	          66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   140001eb8:	          00 00 00 00 
   140001ebc:	          0f 1f 40 00          	nopl   0x0(%rax)

0000000140001ec0 <__tlregdtor> (File Offset: 0x14c0):
   140001ec0:	31 c0                	xor    %eax,%eax
   140001ec2:	c3                   	ret
   140001ec3:	90                   	nop
   140001ec4:	90                   	nop
   140001ec5:	90                   	nop
   140001ec6:	90                   	nop
   140001ec7:	90                   	nop
   140001ec8:	90                   	nop
   140001ec9:	90                   	nop
   140001eca:	90                   	nop
   140001ecb:	90                   	nop
   140001ecc:	90                   	nop
   140001ecd:	90                   	nop
   140001ece:	90                   	nop
   140001ecf:	90                   	nop

0000000140001ed0 <_matherr> (File Offset: 0x14d0):
   140001ed0:	       56                   	push   %rsi
   140001ed1:	       53                   	push   %rbx
   140001ed2:	       48 83 ec 78          	sub    $0x78,%rsp
   140001ed6:	       0f 29 74 24 40       	movaps %xmm6,0x40(%rsp)
   140001edb:	       0f 29 7c 24 50       	movaps %xmm7,0x50(%rsp)
   140001ee0:	       44 0f 29 44 24 60    	movaps %xmm8,0x60(%rsp)
   140001ee6:	       83 39 06             	cmpl   $0x6,(%rcx)
   140001ee9:	/----- 0f 87 cd 00 00 00    	ja     140001fbc <_matherr+0xec> (File Offset: 0x15bc)
   140001eef:	|      8b 01                	mov    (%rcx),%eax
   140001ef1:	|      48 8d 15 0c 43 00 00 	lea    0x430c(%rip),%rdx        # 140006204 <.rdata+0x124> (File Offset: 0x5804)
   140001ef8:	|      48 63 04 82          	movslq (%rdx,%rax,4),%rax
   140001efc:	|      48 01 d0             	add    %rdx,%rax
   140001eff:	|      ff e0                	jmp    *%rax
   140001f01:	|      0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140001f08:	|      48 8d 1d f0 41 00 00 	lea    0x41f0(%rip),%rbx        # 1400060ff <.rdata+0x1f> (File Offset: 0x56ff)
   140001f0f:	|  /-> 48 8b 71 08          	mov    0x8(%rcx),%rsi
   140001f13:	|  |   f2 44 0f 10 41 20    	movsd  0x20(%rcx),%xmm8
   140001f19:	|  |   f2 0f 10 79 18       	movsd  0x18(%rcx),%xmm7
   140001f1e:	|  |   f2 0f 10 71 10       	movsd  0x10(%rcx),%xmm6
   140001f23:	|  |   b9 02 00 00 00       	mov    $0x2,%ecx
   140001f28:	|  |   e8 03 0f 00 00       	call   140002e30 <__acrt_iob_func> (File Offset: 0x2430)
   140001f2d:	|  |   f2 44 0f 11 44 24 30 	movsd  %xmm8,0x30(%rsp)
   140001f34:	|  |   49 89 f1             	mov    %rsi,%r9
   140001f37:	|  |   49 89 d8             	mov    %rbx,%r8
   140001f3a:	|  |   f2 0f 11 7c 24 28    	movsd  %xmm7,0x28(%rsp)
   140001f40:	|  |   48 89 c1             	mov    %rax,%rcx
   140001f43:	|  |   f2 0f 11 74 24 20    	movsd  %xmm6,0x20(%rsp)
   140001f49:	|  |   48 8d 15 88 42 00 00 	lea    0x4288(%rip),%rdx        # 1400061d8 <.rdata+0xf8> (File Offset: 0x57d8)
   140001f50:	|  |   e8 5b 0f 00 00       	call   140002eb0 <fprintf> (File Offset: 0x24b0)
   140001f55:	|  |   90                   	nop
   140001f56:	|  |   0f 28 74 24 40       	movaps 0x40(%rsp),%xmm6
   140001f5b:	|  |   31 c0                	xor    %eax,%eax
   140001f5d:	|  |   0f 28 7c 24 50       	movaps 0x50(%rsp),%xmm7
   140001f62:	|  |   44 0f 28 44 24 60    	movaps 0x60(%rsp),%xmm8
   140001f68:	|  |   48 83 c4 78          	add    $0x78,%rsp
   140001f6c:	|  |   5b                   	pop    %rbx
   140001f6d:	|  |   5e                   	pop    %rsi
   140001f6e:	|  |   c3                   	ret
   140001f6f:	|  |   90                   	nop
   140001f70:	|  |   48 8d 1d 69 41 00 00 	lea    0x4169(%rip),%rbx        # 1400060e0 <.rdata> (File Offset: 0x56e0)
   140001f77:	|  +-- eb 96                	jmp    140001f0f <_matherr+0x3f> (File Offset: 0x150f)
   140001f79:	|  |   0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140001f80:	|  |   48 8d 1d b9 41 00 00 	lea    0x41b9(%rip),%rbx        # 140006140 <.rdata+0x60> (File Offset: 0x5740)
   140001f87:	|  +-- eb 86                	jmp    140001f0f <_matherr+0x3f> (File Offset: 0x150f)
   140001f89:	|  |   0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140001f90:	|  |   48 8d 1d 89 41 00 00 	lea    0x4189(%rip),%rbx        # 140006120 <.rdata+0x40> (File Offset: 0x5720)
   140001f97:	|  +-- e9 73 ff ff ff       	jmp    140001f0f <_matherr+0x3f> (File Offset: 0x150f)
   140001f9c:	|  |   0f 1f 40 00          	nopl   0x0(%rax)
   140001fa0:	|  |   48 8d 1d e9 41 00 00 	lea    0x41e9(%rip),%rbx        # 140006190 <.rdata+0xb0> (File Offset: 0x5790)
   140001fa7:	|  +-- e9 63 ff ff ff       	jmp    140001f0f <_matherr+0x3f> (File Offset: 0x150f)
   140001fac:	|  |   0f 1f 40 00          	nopl   0x0(%rax)
   140001fb0:	|  |   48 8d 1d b1 41 00 00 	lea    0x41b1(%rip),%rbx        # 140006168 <.rdata+0x88> (File Offset: 0x5768)
   140001fb7:	|  +-- e9 53 ff ff ff       	jmp    140001f0f <_matherr+0x3f> (File Offset: 0x150f)
   140001fbc:	\--|-> 48 8d 1d 03 42 00 00 	lea    0x4203(%rip),%rbx        # 1400061c6 <.rdata+0xe6> (File Offset: 0x57c6)
   140001fc3:	   \-- e9 47 ff ff ff       	jmp    140001f0f <_matherr+0x3f> (File Offset: 0x150f)
   140001fc8:	       90                   	nop
   140001fc9:	       90                   	nop
   140001fca:	       90                   	nop
   140001fcb:	       90                   	nop
   140001fcc:	       90                   	nop
   140001fcd:	       90                   	nop
   140001fce:	       90                   	nop
   140001fcf:	       90                   	nop

0000000140001fd0 <_fpreset> (File Offset: 0x15d0):
   140001fd0:	db e3                	fninit
   140001fd2:	c3                   	ret
   140001fd3:	90                   	nop
   140001fd4:	90                   	nop
   140001fd5:	90                   	nop
   140001fd6:	90                   	nop
   140001fd7:	90                   	nop
   140001fd8:	90                   	nop
   140001fd9:	90                   	nop
   140001fda:	90                   	nop
   140001fdb:	90                   	nop
   140001fdc:	90                   	nop
   140001fdd:	90                   	nop
   140001fde:	90                   	nop
   140001fdf:	90                   	nop

0000000140001fe0 <__report_error> (File Offset: 0x15e0):
   140001fe0:	56                   	push   %rsi
   140001fe1:	53                   	push   %rbx
   140001fe2:	48 83 ec 38          	sub    $0x38,%rsp
   140001fe6:	48 8d 44 24 58       	lea    0x58(%rsp),%rax
   140001feb:	48 89 cb             	mov    %rcx,%rbx
   140001fee:	b9 02 00 00 00       	mov    $0x2,%ecx
   140001ff3:	48 89 54 24 58       	mov    %rdx,0x58(%rsp)
   140001ff8:	4c 89 44 24 60       	mov    %r8,0x60(%rsp)
   140001ffd:	4c 89 4c 24 68       	mov    %r9,0x68(%rsp)
   140002002:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
   140002007:	e8 24 0e 00 00       	call   140002e30 <__acrt_iob_func> (File Offset: 0x2430)
   14000200c:	41 b8 1b 00 00 00    	mov    $0x1b,%r8d
   140002012:	ba 01 00 00 00       	mov    $0x1,%edx
   140002017:	48 8d 0d 02 42 00 00 	lea    0x4202(%rip),%rcx        # 140006220 <.rdata> (File Offset: 0x5820)
   14000201e:	49 89 c1             	mov    %rax,%r9
   140002021:	e8 9a 0e 00 00       	call   140002ec0 <fwrite> (File Offset: 0x24c0)
   140002026:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
   14000202b:	b9 02 00 00 00       	mov    $0x2,%ecx
   140002030:	e8 fb 0d 00 00       	call   140002e30 <__acrt_iob_func> (File Offset: 0x2430)
   140002035:	48 89 da             	mov    %rbx,%rdx
   140002038:	48 89 c1             	mov    %rax,%rcx
   14000203b:	49 89 f0             	mov    %rsi,%r8
   14000203e:	e8 bd 0e 00 00       	call   140002f00 <vfprintf> (File Offset: 0x2500)
   140002043:	e8 58 0e 00 00       	call   140002ea0 <abort> (File Offset: 0x24a0)
   140002048:	90                   	nop
   140002049:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000140002050 <mark_section_writable> (File Offset: 0x1650):
   140002050:	                      57                   	push   %rdi
   140002051:	                      56                   	push   %rsi
   140002052:	                      53                   	push   %rbx
   140002053:	                      48 83 ec 50          	sub    $0x50,%rsp
   140002057:	                      48 63 35 36 70 00 00 	movslq 0x7036(%rip),%rsi        # 140009094 <maxSections> (File Offset: 0x8694)
   14000205e:	                      85 f6                	test   %esi,%esi
   140002060:	                      48 89 cb             	mov    %rcx,%rbx
   140002063:	/-------------------- 0f 8e 17 01 00 00    	jle    140002180 <mark_section_writable+0x130> (File Offset: 0x1780)
   140002069:	|                     48 8b 05 28 70 00 00 	mov    0x7028(%rip),%rax        # 140009098 <the_secs> (File Offset: 0x8698)
   140002070:	|                     45 31 c9             	xor    %r9d,%r9d
   140002073:	|                     48 83 c0 18          	add    $0x18,%rax
   140002077:	|                     66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   14000207e:	|                     00 00 
   140002080:	|              /----> 4c 8b 00             	mov    (%rax),%r8
   140002083:	|              |      4c 39 c3             	cmp    %r8,%rbx
   140002086:	|              |  /-- 72 13                	jb     14000209b <mark_section_writable+0x4b> (File Offset: 0x169b)
   140002088:	|              |  |   48 8b 50 08          	mov    0x8(%rax),%rdx
   14000208c:	|              |  |   8b 52 08             	mov    0x8(%rdx),%edx
   14000208f:	|              |  |   49 01 d0             	add    %rdx,%r8
   140002092:	|              |  |   4c 39 c3             	cmp    %r8,%rbx
   140002095:	|        /-----|--|-- 0f 82 8a 00 00 00    	jb     140002125 <mark_section_writable+0xd5> (File Offset: 0x1725)
   14000209b:	|        |     |  \-> 41 83 c1 01          	add    $0x1,%r9d
   14000209f:	|        |     |      48 83 c0 28          	add    $0x28,%rax
   1400020a3:	|        |     |      41 39 f1             	cmp    %esi,%r9d
   1400020a6:	|        |     \----- 75 d8                	jne    140002080 <mark_section_writable+0x30> (File Offset: 0x1680)
   1400020a8:	|     /--|----------> 48 89 d9             	mov    %rbx,%rcx
   1400020ab:	|     |  |            e8 10 0a 00 00       	call   140002ac0 <__mingw_GetSectionForAddress> (File Offset: 0x20c0)
   1400020b0:	|     |  |            48 85 c0             	test   %rax,%rax
   1400020b3:	|     |  |            48 89 c7             	mov    %rax,%rdi
   1400020b6:	|  /--|--|----------- 0f 84 e6 00 00 00    	je     1400021a2 <mark_section_writable+0x152> (File Offset: 0x17a2)
   1400020bc:	|  |  |  |            48 8b 05 d5 6f 00 00 	mov    0x6fd5(%rip),%rax        # 140009098 <the_secs> (File Offset: 0x8698)
   1400020c3:	|  |  |  |            48 8d 1c b6          	lea    (%rsi,%rsi,4),%rbx
   1400020c7:	|  |  |  |            48 c1 e3 03          	shl    $0x3,%rbx
   1400020cb:	|  |  |  |            48 01 d8             	add    %rbx,%rax
   1400020ce:	|  |  |  |            48 89 78 20          	mov    %rdi,0x20(%rax)
   1400020d2:	|  |  |  |            c7 00 00 00 00 00    	movl   $0x0,(%rax)
   1400020d8:	|  |  |  |            e8 23 0b 00 00       	call   140002c00 <_GetPEImageBase> (File Offset: 0x2200)
   1400020dd:	|  |  |  |            8b 57 0c             	mov    0xc(%rdi),%edx
   1400020e0:	|  |  |  |            41 b8 30 00 00 00    	mov    $0x30,%r8d
   1400020e6:	|  |  |  |            48 8d 0c 10          	lea    (%rax,%rdx,1),%rcx
   1400020ea:	|  |  |  |            48 8b 05 a7 6f 00 00 	mov    0x6fa7(%rip),%rax        # 140009098 <the_secs> (File Offset: 0x8698)
   1400020f1:	|  |  |  |            48 8d 54 24 20       	lea    0x20(%rsp),%rdx
   1400020f6:	|  |  |  |            48 89 4c 18 18       	mov    %rcx,0x18(%rax,%rbx,1)
   1400020fb:	|  |  |  |            ff 15 ab 81 00 00    	call   *0x81ab(%rip)        # 14000a2ac <__imp_VirtualQuery> (File Offset: 0x98ac)
   140002101:	|  |  |  |            48 85 c0             	test   %rax,%rax
   140002104:	|  |  |  |  /-------- 0f 84 7d 00 00 00    	je     140002187 <mark_section_writable+0x137> (File Offset: 0x1787)
   14000210a:	|  |  |  |  |         8b 44 24 44          	mov    0x44(%rsp),%eax
   14000210e:	|  |  |  |  |         8d 50 c0             	lea    -0x40(%rax),%edx
   140002111:	|  |  |  |  |         83 e2 bf             	and    $0xffffffbf,%edx
   140002114:	|  |  |  |  |  /----- 74 08                	je     14000211e <mark_section_writable+0xce> (File Offset: 0x171e)
   140002116:	|  |  |  |  |  |      8d 50 fc             	lea    -0x4(%rax),%edx
   140002119:	|  |  |  |  |  |      83 e2 fb             	and    $0xfffffffb,%edx
   14000211c:	|  |  |  |  |  |  /-- 75 12                	jne    140002130 <mark_section_writable+0xe0> (File Offset: 0x1730)
   14000211e:	|  |  |  |  |  >--|-> 83 05 6f 6f 00 00 01 	addl   $0x1,0x6f6f(%rip)        # 140009094 <maxSections> (File Offset: 0x8694)
   140002125:	|  |  |  \--|--|--|-> 48 83 c4 50          	add    $0x50,%rsp
   140002129:	|  |  |     |  |  |   5b                   	pop    %rbx
   14000212a:	|  |  |     |  |  |   5e                   	pop    %rsi
   14000212b:	|  |  |     |  |  |   5f                   	pop    %rdi
   14000212c:	|  |  |     |  |  |   c3                   	ret
   14000212d:	|  |  |     |  |  |   0f 1f 00             	nopl   (%rax)
   140002130:	|  |  |     |  |  \-> 83 f8 02             	cmp    $0x2,%eax
   140002133:	|  |  |     |  |      41 b8 40 00 00 00    	mov    $0x40,%r8d
   140002139:	|  |  |     |  |      b8 04 00 00 00       	mov    $0x4,%eax
   14000213e:	|  |  |     |  |      48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
   140002143:	|  |  |     |  |      44 0f 44 c0          	cmove  %eax,%r8d
   140002147:	|  |  |     |  |      48 8b 54 24 38       	mov    0x38(%rsp),%rdx
   14000214c:	|  |  |     |  |      48 03 1d 45 6f 00 00 	add    0x6f45(%rip),%rbx        # 140009098 <the_secs> (File Offset: 0x8698)
   140002153:	|  |  |     |  |      49 89 d9             	mov    %rbx,%r9
   140002156:	|  |  |     |  |      48 89 4b 08          	mov    %rcx,0x8(%rbx)
   14000215a:	|  |  |     |  |      48 89 53 10          	mov    %rdx,0x10(%rbx)
   14000215e:	|  |  |     |  |      ff 15 40 81 00 00    	call   *0x8140(%rip)        # 14000a2a4 <__imp_VirtualProtect> (File Offset: 0x98a4)
   140002164:	|  |  |     |  |      85 c0                	test   %eax,%eax
   140002166:	|  |  |     |  \----- 75 b6                	jne    14000211e <mark_section_writable+0xce> (File Offset: 0x171e)
   140002168:	|  |  |     |         ff 15 06 81 00 00    	call   *0x8106(%rip)        # 14000a274 <__imp_GetLastError> (File Offset: 0x9874)
   14000216e:	|  |  |     |         48 8d 0d 23 41 00 00 	lea    0x4123(%rip),%rcx        # 140006298 <.rdata+0x78> (File Offset: 0x5898)
   140002175:	|  |  |     |         89 c2                	mov    %eax,%edx
   140002177:	|  |  |     |         e8 64 fe ff ff       	call   140001fe0 <__report_error> (File Offset: 0x15e0)
   14000217c:	|  |  |     |         0f 1f 40 00          	nopl   0x0(%rax)
   140002180:	\--|--|-----|-------> 31 f6                	xor    %esi,%esi
   140002182:	   |  \-----|-------- e9 21 ff ff ff       	jmp    1400020a8 <mark_section_writable+0x58> (File Offset: 0x16a8)
   140002187:	   |        \-------> 48 8b 05 0a 6f 00 00 	mov    0x6f0a(%rip),%rax        # 140009098 <the_secs> (File Offset: 0x8698)
   14000218e:	   |                  48 8d 0d cb 40 00 00 	lea    0x40cb(%rip),%rcx        # 140006260 <.rdata+0x40> (File Offset: 0x5860)
   140002195:	   |                  8b 57 08             	mov    0x8(%rdi),%edx
   140002198:	   |                  4c 8b 44 18 18       	mov    0x18(%rax,%rbx,1),%r8
   14000219d:	   |                  e8 3e fe ff ff       	call   140001fe0 <__report_error> (File Offset: 0x15e0)
   1400021a2:	   \----------------> 48 8d 0d 97 40 00 00 	lea    0x4097(%rip),%rcx        # 140006240 <.rdata+0x20> (File Offset: 0x5840)
   1400021a9:	                      48 89 da             	mov    %rbx,%rdx
   1400021ac:	                      e8 2f fe ff ff       	call   140001fe0 <__report_error> (File Offset: 0x15e0)
   1400021b1:	                      90                   	nop
   1400021b2:	                      66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   1400021b9:	                      00 00 00 00 
   1400021bd:	                      0f 1f 00             	nopl   (%rax)

00000001400021c0 <_pei386_runtime_relocator> (File Offset: 0x17c0):
   1400021c0:	                                                             55                   	push   %rbp
   1400021c1:	                                                             41 57                	push   %r15
   1400021c3:	                                                             41 56                	push   %r14
   1400021c5:	                                                             41 55                	push   %r13
   1400021c7:	                                                             41 54                	push   %r12
   1400021c9:	                                                             57                   	push   %rdi
   1400021ca:	                                                             56                   	push   %rsi
   1400021cb:	                                                             53                   	push   %rbx
   1400021cc:	                                                             48 83 ec 48          	sub    $0x48,%rsp
   1400021d0:	                                                             48 8d 6c 24 40       	lea    0x40(%rsp),%rbp
   1400021d5:	                                                             8b 3d b5 6e 00 00    	mov    0x6eb5(%rip),%edi        # 140009090 <was_init.0> (File Offset: 0x8690)
   1400021db:	                                                             85 ff                	test   %edi,%edi
   1400021dd:	                                                         /-- 74 11                	je     1400021f0 <_pei386_runtime_relocator+0x30> (File Offset: 0x17f0)
   1400021df:	/--------------------------------------------------------|-> 48 8d 65 08          	lea    0x8(%rbp),%rsp
   1400021e3:	|                                                        |   5b                   	pop    %rbx
   1400021e4:	|                                                        |   5e                   	pop    %rsi
   1400021e5:	|                                                        |   5f                   	pop    %rdi
   1400021e6:	|                                                        |   41 5c                	pop    %r12
   1400021e8:	|                                                        |   41 5d                	pop    %r13
   1400021ea:	|                                                        |   41 5e                	pop    %r14
   1400021ec:	|                                                        |   41 5f                	pop    %r15
   1400021ee:	|                                                        |   5d                   	pop    %rbp
   1400021ef:	|                                                        |   c3                   	ret
   1400021f0:	|                                                        \-> c7 05 96 6e 00 00 01 	movl   $0x1,0x6e96(%rip)        # 140009090 <was_init.0> (File Offset: 0x8690)
   1400021f7:	|                                                            00 00 00 
   1400021fa:	|                                                            e8 41 09 00 00       	call   140002b40 <__mingw_GetSectionCount> (File Offset: 0x2140)
   1400021ff:	|                                                            48 98                	cltq
   140002201:	|                                                            48 8d 04 80          	lea    (%rax,%rax,4),%rax
   140002205:	|                                                            48 8d 04 c5 0f 00 00 	lea    0xf(,%rax,8),%rax
   14000220c:	|                                                            00 
   14000220d:	|                                                            48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
   140002211:	|                                                            e8 9a 0b 00 00       	call   140002db0 <___chkstk_ms> (File Offset: 0x23b0)
   140002216:	|                                                            4c 8b 2d f3 41 00 00 	mov    0x41f3(%rip),%r13        # 140006410 <.refptr.__RUNTIME_PSEUDO_RELOC_LIST_END__> (File Offset: 0x5a10)
   14000221d:	|                                                            c7 05 6d 6e 00 00 00 	movl   $0x0,0x6e6d(%rip)        # 140009094 <maxSections> (File Offset: 0x8694)
   140002224:	|                                                            00 00 00 
   140002227:	|                                                            48 8b 1d f2 41 00 00 	mov    0x41f2(%rip),%rbx        # 140006420 <.refptr.__RUNTIME_PSEUDO_RELOC_LIST__> (File Offset: 0x5a20)
   14000222e:	|                                                            48 29 c4             	sub    %rax,%rsp
   140002231:	|                                                            48 8d 44 24 30       	lea    0x30(%rsp),%rax
   140002236:	|                                                            48 89 05 5b 6e 00 00 	mov    %rax,0x6e5b(%rip)        # 140009098 <the_secs> (File Offset: 0x8698)
   14000223d:	|                                                            4c 89 e8             	mov    %r13,%rax
   140002240:	|                                                            48 29 d8             	sub    %rbx,%rax
   140002243:	|                                                            48 83 f8 07          	cmp    $0x7,%rax
   140002247:	+----------------------------------------------------------- 7e 96                	jle    1400021df <_pei386_runtime_relocator+0x1f> (File Offset: 0x17df)
   140002249:	|                                                            48 83 f8 0b          	cmp    $0xb,%rax
   14000224d:	|                                                            8b 13                	mov    (%rbx),%edx
   14000224f:	|                                /-------------------------- 0f 8f 83 01 00 00    	jg     1400023d8 <_pei386_runtime_relocator+0x218> (File Offset: 0x19d8)
   140002255:	|                             /--|-------------------------> 8b 03                	mov    (%rbx),%eax
   140002257:	|                             |  |                           85 c0                	test   %eax,%eax
   140002259:	|     /-----------------------|--|-------------------------- 0f 85 71 02 00 00    	jne    1400024d0 <_pei386_runtime_relocator+0x310> (File Offset: 0x1ad0)
   14000225f:	|     |                       |  |                           8b 43 04             	mov    0x4(%rbx),%eax
   140002262:	|     |                       |  |              /----------> 85 c0                	test   %eax,%eax
   140002264:	|     +-----------------------|--|--------------|----------- 0f 85 66 02 00 00    	jne    1400024d0 <_pei386_runtime_relocator+0x310> (File Offset: 0x1ad0)
   14000226a:	|     |                       |  |              |            8b 53 08             	mov    0x8(%rbx),%edx
   14000226d:	|     |                       |  |              |            83 fa 01             	cmp    $0x1,%edx
   140002270:	|  /--|-----------------------|--|--------------|----------- 0f 85 9c 02 00 00    	jne    140002512 <_pei386_runtime_relocator+0x352> (File Offset: 0x1b12)
   140002276:	|  |  |                       |  |              |            48 83 c3 0c          	add    $0xc,%rbx
   14000227a:	|  |  |                       |  |              |            4c 39 eb             	cmp    %r13,%rbx
   14000227d:	+--|--|-----------------------|--|--------------|----------- 0f 83 5c ff ff ff    	jae    1400021df <_pei386_runtime_relocator+0x1f> (File Offset: 0x17df)
   140002283:	|  |  |                       |  |              |            4c 8b 25 b6 41 00 00 	mov    0x41b6(%rip),%r12        # 140006440 <.refptr.__image_base__> (File Offset: 0x5a40)
   14000228a:	|  |  |                       |  |              |            49 bf ff ff ff 7f ff 	movabs $0xffffffff7fffffff,%r15
   140002291:	|  |  |                       |  |              |            ff ff ff 
   140002294:	|  |  |                       |  |              |     /----- eb 5d                	jmp    1400022f3 <_pei386_runtime_relocator+0x133> (File Offset: 0x18f3)
   140002296:	|  |  |                       |  |              |     |      66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   14000229d:	|  |  |                       |  |              |     |      00 00 00 
   1400022a0:	|  |  |                       |  |              |     |  /-> 41 0f b6 36          	movzbl (%r14),%esi
   1400022a4:	|  |  |                       |  |              |     |  |   81 e1 c0 00 00 00    	and    $0xc0,%ecx
   1400022aa:	|  |  |                       |  |              |     |  |   40 84 f6             	test   %sil,%sil
   1400022ad:	|  |  |     /-----------------|--|--------------|-----|--|-- 0f 89 05 02 00 00    	jns    1400024b8 <_pei386_runtime_relocator+0x2f8> (File Offset: 0x1ab8)
   1400022b3:	|  |  |     |                 |  |              |     |  |   48 81 ce 00 ff ff ff 	or     $0xffffffffffffff00,%rsi
   1400022ba:	|  |  |     |                 |  |              |     |  |   48 29 c6             	sub    %rax,%rsi
   1400022bd:	|  |  |     |                 |  |              |     |  |   4c 01 ce             	add    %r9,%rsi
   1400022c0:	|  |  |     |                 |  |              |     |  |   85 c9                	test   %ecx,%ecx
   1400022c2:	|  |  |     |  /--------------|--|--------------|-----|--|-- 75 17                	jne    1400022db <_pei386_runtime_relocator+0x11b> (File Offset: 0x18db)
   1400022c4:	|  |  |     |  |  /-----------|--|--------------|-----|--|-> 48 81 fe ff 00 00 00 	cmp    $0xff,%rsi
   1400022cb:	|  |  |     |  |  |        /--|--|--------------|-----|--|-- 0f 8f 4e 01 00 00    	jg     14000241f <_pei386_runtime_relocator+0x25f> (File Offset: 0x1a1f)
   1400022d1:	|  |  |     |  |  |        |  |  |              |     |  |   48 83 fe 80          	cmp    $0xffffffffffffff80,%rsi
   1400022d5:	|  |  |     |  |  |        +--|--|--------------|-----|--|-- 0f 8c 44 01 00 00    	jl     14000241f <_pei386_runtime_relocator+0x25f> (File Offset: 0x1a1f)
   1400022db:	|  |  |     |  >--|--------|--|--|--------------|-----|--|-> 4c 89 f1             	mov    %r14,%rcx
   1400022de:	|  |  |     |  |  |        |  |  |              |     |  |   e8 6d fd ff ff       	call   140002050 <mark_section_writable> (File Offset: 0x1650)
   1400022e3:	|  |  |     |  |  |        |  |  |              |     |  |   41 88 36             	mov    %sil,(%r14)
   1400022e6:	|  |  |     |  |  |     /--|--|--|--------------|-----|--|-> 48 83 c3 0c          	add    $0xc,%rbx
   1400022ea:	|  |  |     |  |  |     |  |  |  |              |     |  |   4c 39 eb             	cmp    %r13,%rbx
   1400022ed:	|  |  |  /--|--|--|-----|--|--|--|--------------|-----|--|-- 0f 83 8d 00 00 00    	jae    140002380 <_pei386_runtime_relocator+0x1c0> (File Offset: 0x1980)
   1400022f3:	|  |  |  |  |  |  |     |  |  |  |              |     >--|-> 8b 4b 08             	mov    0x8(%rbx),%ecx
   1400022f6:	|  |  |  |  |  |  |     |  |  |  |              |     |  |   8b 03                	mov    (%rbx),%eax
   1400022f8:	|  |  |  |  |  |  |     |  |  |  |              |     |  |   44 8b 43 04          	mov    0x4(%rbx),%r8d
   1400022fc:	|  |  |  |  |  |  |     |  |  |  |              |     |  |   0f b6 d1             	movzbl %cl,%edx
   1400022ff:	|  |  |  |  |  |  |     |  |  |  |              |     |  |   4c 01 e0             	add    %r12,%rax
   140002302:	|  |  |  |  |  |  |     |  |  |  |              |     |  |   83 fa 20             	cmp    $0x20,%edx
   140002305:	|  |  |  |  |  |  |     |  |  |  |              |     |  |   4c 8b 08             	mov    (%rax),%r9
   140002308:	|  |  |  |  |  |  |     |  |  |  |              |     |  |   4f 8d 34 20          	lea    (%r8,%r12,1),%r14
   14000230c:	|  |  |  |  |  |  |     |  |  |  |           /--|-----|--|-- 0f 84 26 01 00 00    	je     140002438 <_pei386_runtime_relocator+0x278> (File Offset: 0x1a38)
   140002312:	|  |  |  |  |  |  |     |  |  |  |           |  |  /--|--|-- 0f 87 e8 00 00 00    	ja     140002400 <_pei386_runtime_relocator+0x240> (File Offset: 0x1a00)
   140002318:	|  |  |  |  |  |  |     |  |  |  |           |  |  |  |  |   83 fa 08             	cmp    $0x8,%edx
   14000231b:	|  |  |  |  |  |  |     |  |  |  |           |  |  |  |  \-- 74 83                	je     1400022a0 <_pei386_runtime_relocator+0xe0> (File Offset: 0x18a0)
   14000231d:	|  |  |  |  |  |  |     |  |  |  |           |  |  |  |      83 fa 10             	cmp    $0x10,%edx
   140002320:	|  |  |  |  |  |  |  /--|--|--|--|-----------|--|--|--|----- 0f 85 e0 01 00 00    	jne    140002506 <_pei386_runtime_relocator+0x346> (File Offset: 0x1b06)
   140002326:	|  |  |  |  |  |  |  |  |  |  |  |           |  |  |  |      41 0f b7 36          	movzwl (%r14),%esi
   14000232a:	|  |  |  |  |  |  |  |  |  |  |  |           |  |  |  |      81 e1 c0 00 00 00    	and    $0xc0,%ecx
   140002330:	|  |  |  |  |  |  |  |  |  |  |  |           |  |  |  |      66 85 f6             	test   %si,%si
   140002333:	|  |  |  |  |  |  |  |  |  |  |  |  /--------|--|--|--|----- 0f 89 67 01 00 00    	jns    1400024a0 <_pei386_runtime_relocator+0x2e0> (File Offset: 0x1aa0)
   140002339:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |  |      48 81 ce 00 00 ff ff 	or     $0xffffffffffff0000,%rsi
   140002340:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |  |      48 29 c6             	sub    %rax,%rsi
   140002343:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |  |      4c 01 ce             	add    %r9,%rsi
   140002346:	|  |  |  |  |  |  |  |  |  |  |  |  |        |  |  |  |      85 c9                	test   %ecx,%ecx
   140002348:	|  |  |  |  |  |  |  |  |  |  |  |  |  /-----|--|--|--|----- 75 1a                	jne    140002364 <_pei386_runtime_relocator+0x1a4> (File Offset: 0x1964)
   14000234a:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  /--|--|--|--|----> 48 81 fe 00 80 ff ff 	cmp    $0xffffffffffff8000,%rsi
   140002351:	|  |  |  |  |  |  |  |  |  +--|--|--|--|--|--|--|--|--|----- 0f 8c c8 00 00 00    	jl     14000241f <_pei386_runtime_relocator+0x25f> (File Offset: 0x1a1f)
   140002357:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      48 81 fe ff ff 00 00 	cmp    $0xffff,%rsi
   14000235e:	|  |  |  |  |  |  |  |  |  +--|--|--|--|--|--|--|--|--|----- 0f 8f bb 00 00 00    	jg     14000241f <_pei386_runtime_relocator+0x25f> (File Offset: 0x1a1f)
   140002364:	|  |  |  |  |  |  |  |  |  |  |  |  |  >--|--|--|--|--|----> 4c 89 f1             	mov    %r14,%rcx
   140002367:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      48 83 c3 0c          	add    $0xc,%rbx
   14000236b:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      e8 e0 fc ff ff       	call   140002050 <mark_section_writable> (File Offset: 0x1650)
   140002370:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      4c 39 eb             	cmp    %r13,%rbx
   140002373:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      66 41 89 36          	mov    %si,(%r14)
   140002377:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  \----- 0f 82 76 ff ff ff    	jb     1400022f3 <_pei386_runtime_relocator+0x133> (File Offset: 0x18f3)
   14000237d:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         0f 1f 00             	nopl   (%rax)
   140002380:	|  |  |  >--|--|--|--|--|--|--|--|--|--|--|--|--|--|-------> 8b 15 0e 6d 00 00    	mov    0x6d0e(%rip),%edx        # 140009094 <maxSections> (File Offset: 0x8694)
   140002386:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         85 d2                	test   %edx,%edx
   140002388:	+--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|-------- 0f 8e 51 fe ff ff    	jle    1400021df <_pei386_runtime_relocator+0x1f> (File Offset: 0x17df)
   14000238e:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         48 8b 35 0f 7f 00 00 	mov    0x7f0f(%rip),%rsi        # 14000a2a4 <__imp_VirtualProtect> (File Offset: 0x98a4)
   140002395:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         4c 8d 65 fc          	lea    -0x4(%rbp),%r12
   140002399:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         31 db                	xor    %ebx,%ebx
   14000239b:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   1400023a0:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  /----> 48 8b 05 f1 6c 00 00 	mov    0x6cf1(%rip),%rax        # 140009098 <the_secs> (File Offset: 0x8698)
   1400023a7:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      48 01 d8             	add    %rbx,%rax
   1400023aa:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      44 8b 00             	mov    (%rax),%r8d
   1400023ad:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      45 85 c0             	test   %r8d,%r8d
   1400023b0:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  /-- 74 0d                	je     1400023bf <_pei386_runtime_relocator+0x1ff> (File Offset: 0x19bf)
   1400023b2:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |   48 8b 50 10          	mov    0x10(%rax),%rdx
   1400023b6:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |   4d 89 e1             	mov    %r12,%r9
   1400023b9:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |   48 8b 48 08          	mov    0x8(%rax),%rcx
   1400023bd:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |   ff d6                	call   *%rsi
   1400023bf:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  \-> 83 c7 01             	add    $0x1,%edi
   1400023c2:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      48 83 c3 28          	add    $0x28,%rbx
   1400023c6:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      3b 3d c8 6c 00 00    	cmp    0x6cc8(%rip),%edi        # 140009094 <maxSections> (File Offset: 0x8694)
   1400023cc:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  \----- 7c d2                	jl     1400023a0 <_pei386_runtime_relocator+0x1e0> (File Offset: 0x19a0)
   1400023ce:	+--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|-------- e9 0c fe ff ff       	jmp    1400021df <_pei386_runtime_relocator+0x1f> (File Offset: 0x17df)
   1400023d3:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   1400023d8:	|  |  |  |  |  |  |  |  |  |  |  \--|--|--|--|--|--|-------> 85 d2                	test   %edx,%edx
   1400023da:	|  |  +--|--|--|--|--|--|--|--|-----|--|--|--|--|--|-------- 0f 85 f0 00 00 00    	jne    1400024d0 <_pei386_runtime_relocator+0x310> (File Offset: 0x1ad0)
   1400023e0:	|  |  |  |  |  |  |  |  |  |  |     |  |  |  |  |  |         8b 43 04             	mov    0x4(%rbx),%eax
   1400023e3:	|  |  |  |  |  |  |  |  |  |  |     |  |  |  |  |  |         89 c2                	mov    %eax,%edx
   1400023e5:	|  |  |  |  |  |  |  |  |  |  |     |  |  |  |  |  |         0b 53 08             	or     0x8(%rbx),%edx
   1400023e8:	|  |  |  |  |  |  |  |  |  |  |     |  |  |  |  \--|-------- 0f 85 74 fe ff ff    	jne    140002262 <_pei386_runtime_relocator+0xa2> (File Offset: 0x1862)
   1400023ee:	|  |  |  |  |  |  |  |  |  |  |     |  |  |  |     |         48 83 c3 0c          	add    $0xc,%rbx
   1400023f2:	|  |  |  |  |  |  |  |  |  |  \-----|--|--|--|-----|-------- e9 5e fe ff ff       	jmp    140002255 <_pei386_runtime_relocator+0x95> (File Offset: 0x1855)
   1400023f7:	|  |  |  |  |  |  |  |  |  |        |  |  |  |     |         66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   1400023fe:	|  |  |  |  |  |  |  |  |  |        |  |  |  |     |         00 00 
   140002400:	|  |  |  |  |  |  |  |  |  |        |  |  |  |     \-------> 83 fa 40             	cmp    $0x40,%edx
   140002403:	|  |  |  |  |  |  |  +--|--|--------|--|--|--|-------------- 0f 85 fd 00 00 00    	jne    140002506 <_pei386_runtime_relocator+0x346> (File Offset: 0x1b06)
   140002409:	|  |  |  |  |  |  |  |  |  |        |  |  |  |               49 8b 36             	mov    (%r14),%rsi
   14000240c:	|  |  |  |  |  |  |  |  |  |        |  |  |  |               48 29 c6             	sub    %rax,%rsi
   14000240f:	|  |  |  |  |  |  |  |  |  |        |  |  |  |               4c 01 ce             	add    %r9,%rsi
   140002412:	|  |  |  |  |  |  |  |  |  |        |  |  |  |               81 e1 c0 00 00 00    	and    $0xc0,%ecx
   140002418:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  /----------- 75 66                	jne    140002480 <_pei386_runtime_relocator+0x2c0> (File Offset: 0x1a80)
   14000241a:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |            48 85 f6             	test   %rsi,%rsi
   14000241d:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  +----------- 78 61                	js     140002480 <_pei386_runtime_relocator+0x2c0> (File Offset: 0x1a80)
   14000241f:	|  |  |  |  |  |  |  |  |  >--------|--|--|--|--|----------> 48 89 74 24 20       	mov    %rsi,0x20(%rsp)
   140002424:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |            48 8d 0d fd 3e 00 00 	lea    0x3efd(%rip),%rcx        # 140006328 <.rdata+0x108> (File Offset: 0x5928)
   14000242b:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |            4d 89 f0             	mov    %r14,%r8
   14000242e:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |            e8 ad fb ff ff       	call   140001fe0 <__report_error> (File Offset: 0x15e0)
   140002433:	|  |  |  |  |  |  |  |  |  |        |  |  |  |  |            0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140002438:	|  |  |  |  |  |  |  |  |  |        |  |  |  \--|----------> 41 8b 36             	mov    (%r14),%esi
   14000243b:	|  |  |  |  |  |  |  |  |  |        |  |  |     |            81 e1 c0 00 00 00    	and    $0xc0,%ecx
   140002441:	|  |  |  |  |  |  |  |  |  |        |  |  |     |            85 f6                	test   %esi,%esi
   140002443:	|  |  |  |  |  |  |  |  |  |        |  |  |     |  /-------- 79 4b                	jns    140002490 <_pei386_runtime_relocator+0x2d0> (File Offset: 0x1a90)
   140002445:	|  |  |  |  |  |  |  |  |  |        |  |  |     |  |         49 bb 00 00 00 00 ff 	movabs $0xffffffff00000000,%r11
   14000244c:	|  |  |  |  |  |  |  |  |  |        |  |  |     |  |         ff ff ff 
   14000244f:	|  |  |  |  |  |  |  |  |  |        |  |  |     |  |         4c 09 de             	or     %r11,%rsi
   140002452:	|  |  |  |  |  |  |  |  |  |        |  |  |     |  |         48 29 c6             	sub    %rax,%rsi
   140002455:	|  |  |  |  |  |  |  |  |  |        |  |  |     |  |         4c 01 ce             	add    %r9,%rsi
   140002458:	|  |  |  |  |  |  |  |  |  |        |  |  |     |  |         85 c9                	test   %ecx,%ecx
   14000245a:	|  |  |  |  |  |  |  |  |  |        |  |  |     |  |  /----- 75 0f                	jne    14000246b <_pei386_runtime_relocator+0x2ab> (File Offset: 0x1a6b)
   14000245c:	|  |  |  |  |  |  |  |  |  |        |  |  |     |  |  |  /-> 4c 39 fe             	cmp    %r15,%rsi
   14000245f:	|  |  |  |  |  |  |  |  |  +--------|--|--|-----|--|--|--|-- 7e be                	jle    14000241f <_pei386_runtime_relocator+0x25f> (File Offset: 0x1a1f)
   140002461:	|  |  |  |  |  |  |  |  |  |        |  |  |     |  |  |  |   b8 ff ff ff ff       	mov    $0xffffffff,%eax
   140002466:	|  |  |  |  |  |  |  |  |  |        |  |  |     |  |  |  |   48 39 c6             	cmp    %rax,%rsi
   140002469:	|  |  |  |  |  |  |  |  |  \--------|--|--|-----|--|--|--|-- 7f b4                	jg     14000241f <_pei386_runtime_relocator+0x25f> (File Offset: 0x1a1f)
   14000246b:	|  |  |  |  |  |  |  |  |           |  |  |     |  |  >--|-> 4c 89 f1             	mov    %r14,%rcx
   14000246e:	|  |  |  |  |  |  |  |  |           |  |  |     |  |  |  |   e8 dd fb ff ff       	call   140002050 <mark_section_writable> (File Offset: 0x1650)
   140002473:	|  |  |  |  |  |  |  |  |           |  |  |     |  |  |  |   41 89 36             	mov    %esi,(%r14)
   140002476:	|  |  |  |  |  |  |  |  +-----------|--|--|-----|--|--|--|-- e9 6b fe ff ff       	jmp    1400022e6 <_pei386_runtime_relocator+0x126> (File Offset: 0x18e6)
   14000247b:	|  |  |  |  |  |  |  |  |           |  |  |     |  |  |  |   0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140002480:	|  |  |  |  |  |  |  |  |           |  |  |     \--|--|--|-> 4c 89 f1             	mov    %r14,%rcx
   140002483:	|  |  |  |  |  |  |  |  |           |  |  |        |  |  |   e8 c8 fb ff ff       	call   140002050 <mark_section_writable> (File Offset: 0x1650)
   140002488:	|  |  |  |  |  |  |  |  |           |  |  |        |  |  |   49 89 36             	mov    %rsi,(%r14)
   14000248b:	|  |  |  |  |  |  |  |  \-----------|--|--|--------|--|--|-- e9 56 fe ff ff       	jmp    1400022e6 <_pei386_runtime_relocator+0x126> (File Offset: 0x18e6)
   140002490:	|  |  |  |  |  |  |  |              |  |  |        \--|--|-> 48 29 c6             	sub    %rax,%rsi
   140002493:	|  |  |  |  |  |  |  |              |  |  |           |  |   4c 01 ce             	add    %r9,%rsi
   140002496:	|  |  |  |  |  |  |  |              |  |  |           |  |   85 c9                	test   %ecx,%ecx
   140002498:	|  |  |  |  |  |  |  |              |  |  |           |  \-- 74 c2                	je     14000245c <_pei386_runtime_relocator+0x29c> (File Offset: 0x1a5c)
   14000249a:	|  |  |  |  |  |  |  |              |  |  |           \----- eb cf                	jmp    14000246b <_pei386_runtime_relocator+0x2ab> (File Offset: 0x1a6b)
   14000249c:	|  |  |  |  |  |  |  |              |  |  |                  0f 1f 40 00          	nopl   0x0(%rax)
   1400024a0:	|  |  |  |  |  |  |  |              \--|--|----------------> 48 29 c6             	sub    %rax,%rsi
   1400024a3:	|  |  |  |  |  |  |  |                 |  |                  4c 01 ce             	add    %r9,%rsi
   1400024a6:	|  |  |  |  |  |  |  |                 |  |                  85 c9                	test   %ecx,%ecx
   1400024a8:	|  |  |  |  |  |  |  |                 |  \----------------- 0f 84 9c fe ff ff    	je     14000234a <_pei386_runtime_relocator+0x18a> (File Offset: 0x194a)
   1400024ae:	|  |  |  |  |  |  |  |                 \-------------------- e9 b1 fe ff ff       	jmp    140002364 <_pei386_runtime_relocator+0x1a4> (File Offset: 0x1964)
   1400024b3:	|  |  |  |  |  |  |  |                                       0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   1400024b8:	|  |  |  |  \--|--|--|-------------------------------------> 48 29 c6             	sub    %rax,%rsi
   1400024bb:	|  |  |  |     |  |  |                                       4c 01 ce             	add    %r9,%rsi
   1400024be:	|  |  |  |     |  |  |                                       85 c9                	test   %ecx,%ecx
   1400024c0:	|  |  |  |     |  \--|-------------------------------------- 0f 84 fe fd ff ff    	je     1400022c4 <_pei386_runtime_relocator+0x104> (File Offset: 0x18c4)
   1400024c6:	|  |  |  |     \-----|-------------------------------------- e9 10 fe ff ff       	jmp    1400022db <_pei386_runtime_relocator+0x11b> (File Offset: 0x18db)
   1400024cb:	|  |  |  |           |                                       0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   1400024d0:	|  |  \--|-----------|-------------------------------------> 4c 39 eb             	cmp    %r13,%rbx
   1400024d3:	\--|-----|-----------|-------------------------------------- 0f 83 06 fd ff ff    	jae    1400021df <_pei386_runtime_relocator+0x1f> (File Offset: 0x17df)
   1400024d9:	   |     |           |                                       4c 8b 35 60 3f 00 00 	mov    0x3f60(%rip),%r14        # 140006440 <.refptr.__image_base__> (File Offset: 0x5a40)
   1400024e0:	   |     |           |                                   /-> 8b 73 04             	mov    0x4(%rbx),%esi
   1400024e3:	   |     |           |                                   |   48 83 c3 08          	add    $0x8,%rbx
   1400024e7:	   |     |           |                                   |   44 8b 63 f8          	mov    -0x8(%rbx),%r12d
   1400024eb:	   |     |           |                                   |   4c 01 f6             	add    %r14,%rsi
   1400024ee:	   |     |           |                                   |   44 03 26             	add    (%rsi),%r12d
   1400024f1:	   |     |           |                                   |   48 89 f1             	mov    %rsi,%rcx
   1400024f4:	   |     |           |                                   |   e8 57 fb ff ff       	call   140002050 <mark_section_writable> (File Offset: 0x1650)
   1400024f9:	   |     |           |                                   |   4c 39 eb             	cmp    %r13,%rbx
   1400024fc:	   |     |           |                                   |   44 89 26             	mov    %r12d,(%rsi)
   1400024ff:	   |     |           |                                   \-- 72 df                	jb     1400024e0 <_pei386_runtime_relocator+0x320> (File Offset: 0x1ae0)
   140002501:	   |     \-----------|-------------------------------------- e9 7a fe ff ff       	jmp    140002380 <_pei386_runtime_relocator+0x1c0> (File Offset: 0x1980)
   140002506:	   |                 \-------------------------------------> 48 8d 0d eb 3d 00 00 	lea    0x3deb(%rip),%rcx        # 1400062f8 <.rdata+0xd8> (File Offset: 0x58f8)
   14000250d:	   |                                                         e8 ce fa ff ff       	call   140001fe0 <__report_error> (File Offset: 0x15e0)
   140002512:	   \-------------------------------------------------------> 48 8d 0d a7 3d 00 00 	lea    0x3da7(%rip),%rcx        # 1400062c0 <.rdata+0xa0> (File Offset: 0x58c0)
   140002519:	                                                             e8 c2 fa ff ff       	call   140001fe0 <__report_error> (File Offset: 0x15e0)
   14000251e:	                                                             90                   	nop
   14000251f:	                                                             90                   	nop

0000000140002520 <__mingw_raise_matherr> (File Offset: 0x1b20):
   140002520:	    48 83 ec 58          	sub    $0x58,%rsp
   140002524:	    48 8b 05 75 6b 00 00 	mov    0x6b75(%rip),%rax        # 1400090a0 <stUserMathErr> (File Offset: 0x86a0)
   14000252b:	    48 85 c0             	test   %rax,%rax
   14000252e:	    66 0f 14 d3          	unpcklpd %xmm3,%xmm2
   140002532:	/-- 74 25                	je     140002559 <__mingw_raise_matherr+0x39> (File Offset: 0x1b59)
   140002534:	|   f2 0f 10 84 24 80 00 	movsd  0x80(%rsp),%xmm0
   14000253b:	|   00 00 
   14000253d:	|   89 4c 24 20          	mov    %ecx,0x20(%rsp)
   140002541:	|   48 8d 4c 24 20       	lea    0x20(%rsp),%rcx
   140002546:	|   48 89 54 24 28       	mov    %rdx,0x28(%rsp)
   14000254b:	|   0f 29 54 24 30       	movaps %xmm2,0x30(%rsp)
   140002550:	|   f2 0f 11 44 24 40    	movsd  %xmm0,0x40(%rsp)
   140002556:	|   ff d0                	call   *%rax
   140002558:	|   90                   	nop
   140002559:	\-> 48 83 c4 58          	add    $0x58,%rsp
   14000255d:	    c3                   	ret
   14000255e:	    66 90                	xchg   %ax,%ax

0000000140002560 <__mingw_setusermatherr> (File Offset: 0x1b60):
   140002560:	48 89 0d 39 6b 00 00 	mov    %rcx,0x6b39(%rip)        # 1400090a0 <stUserMathErr> (File Offset: 0x86a0)
   140002567:	e9 04 09 00 00       	jmp    140002e70 <__setusermatherr> (File Offset: 0x2470)
   14000256c:	90                   	nop
   14000256d:	90                   	nop
   14000256e:	90                   	nop
   14000256f:	90                   	nop

0000000140002570 <_gnu_exception_handler> (File Offset: 0x1b70):
   140002570:	                      53                   	push   %rbx
   140002571:	                      48 83 ec 20          	sub    $0x20,%rsp
   140002575:	                      48 8b 11             	mov    (%rcx),%rdx
   140002578:	                      8b 02                	mov    (%rdx),%eax
   14000257a:	                      48 89 cb             	mov    %rcx,%rbx
   14000257d:	                      89 c1                	mov    %eax,%ecx
   14000257f:	                      81 e1 ff ff ff 20    	and    $0x20ffffff,%ecx
   140002585:	                      81 f9 43 43 47 20    	cmp    $0x20474343,%ecx
   14000258b:	            /-------- 0f 84 9f 00 00 00    	je     140002630 <_gnu_exception_handler+0xc0> (File Offset: 0x1c30)
   140002591:	            |  /----> 3d 96 00 00 c0       	cmp    $0xc0000096,%eax
   140002596:	   /--------|--|----- 77 77                	ja     14000260f <_gnu_exception_handler+0x9f> (File Offset: 0x1c0f)
   140002598:	   |        |  |      3d 8b 00 00 c0       	cmp    $0xc000008b,%eax
   14000259d:	   |        |  |  /-- 76 21                	jbe    1400025c0 <_gnu_exception_handler+0x50> (File Offset: 0x1bc0)
   14000259f:	   |        |  |  |   05 73 ff ff 3f       	add    $0x3fffff73,%eax
   1400025a4:	   |        |  |  |   83 f8 09             	cmp    $0x9,%eax
   1400025a7:	/--|--------|--|--|-- 77 54                	ja     1400025fd <_gnu_exception_handler+0x8d> (File Offset: 0x1bfd)
   1400025a9:	|  |        |  |  |   48 8d 15 d0 3d 00 00 	lea    0x3dd0(%rip),%rdx        # 140006380 <.rdata> (File Offset: 0x5980)
   1400025b0:	|  |        |  |  |   48 63 04 82          	movslq (%rdx,%rax,4),%rax
   1400025b4:	|  |        |  |  |   48 01 d0             	add    %rdx,%rax
   1400025b7:	|  |        |  |  |   ff e0                	jmp    *%rax
   1400025b9:	|  |        |  |  |   0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   1400025c0:	|  |        |  |  \-> 3d 05 00 00 c0       	cmp    $0xc0000005,%eax
   1400025c5:	|  |     /--|--|----- 0f 84 d5 00 00 00    	je     1400026a0 <_gnu_exception_handler+0x130> (File Offset: 0x1ca0)
   1400025cb:	|  |     |  |  |  /-- 76 3b                	jbe    140002608 <_gnu_exception_handler+0x98> (File Offset: 0x1c08)
   1400025cd:	|  |     |  |  |  |   3d 08 00 00 c0       	cmp    $0xc0000008,%eax
   1400025d2:	+--|-----|--|--|--|-- 74 29                	je     1400025fd <_gnu_exception_handler+0x8d> (File Offset: 0x1bfd)
   1400025d4:	|  |     |  |  |  |   3d 1d 00 00 c0       	cmp    $0xc000001d,%eax
   1400025d9:	|  +-----|--|--|--|-- 75 34                	jne    14000260f <_gnu_exception_handler+0x9f> (File Offset: 0x1c0f)
   1400025db:	|  |     |  |  |  |   31 d2                	xor    %edx,%edx
   1400025dd:	|  |     |  |  |  |   b9 04 00 00 00       	mov    $0x4,%ecx
   1400025e2:	|  |     |  |  |  |   e8 01 09 00 00       	call   140002ee8 <signal> (File Offset: 0x24e8)
   1400025e7:	|  |     |  |  |  |   48 83 f8 01          	cmp    $0x1,%rax
   1400025eb:	|  |  /--|--|--|--|-- 0f 84 d6 00 00 00    	je     1400026c7 <_gnu_exception_handler+0x157> (File Offset: 0x1cc7)
   1400025f1:	|  |  |  |  |  |  |   48 85 c0             	test   %rax,%rax
   1400025f4:	|  +--|--|--|--|--|-- 74 19                	je     14000260f <_gnu_exception_handler+0x9f> (File Offset: 0x1c0f)
   1400025f6:	|  |  |  |  |  |  |   b9 04 00 00 00       	mov    $0x4,%ecx
   1400025fb:	|  |  |  |  |  |  |   ff d0                	call   *%rax
   1400025fd:	>--|--|--|--|--|--|-> b8 ff ff ff ff       	mov    $0xffffffff,%eax
   140002602:	|  |  |  |  |  |  |   48 83 c4 20          	add    $0x20,%rsp
   140002606:	|  |  |  |  |  |  |   5b                   	pop    %rbx
   140002607:	|  |  |  |  |  |  |   c3                   	ret
   140002608:	|  |  |  |  |  |  \-> 3d 02 00 00 80       	cmp    $0x80000002,%eax
   14000260d:	+--|--|--|--|--|----- 74 ee                	je     1400025fd <_gnu_exception_handler+0x8d> (File Offset: 0x1bfd)
   14000260f:	|  >--|--|--|--|----> 48 8b 05 aa 6a 00 00 	mov    0x6aaa(%rip),%rax        # 1400090c0 <__mingw_oldexcpt_handler> (File Offset: 0x86c0)
   140002616:	|  |  |  |  |  |      48 85 c0             	test   %rax,%rax
   140002619:	|  |  |  |  |  |  /-- 74 25                	je     140002640 <_gnu_exception_handler+0xd0> (File Offset: 0x1c40)
   14000261b:	|  |  |  |  |  |  |   48 89 d9             	mov    %rbx,%rcx
   14000261e:	|  |  |  |  |  |  |   48 83 c4 20          	add    $0x20,%rsp
   140002622:	|  |  |  |  |  |  |   5b                   	pop    %rbx
   140002623:	|  |  |  |  |  |  |   48 ff e0             	rex.W jmp *%rax
   140002626:	|  |  |  |  |  |  |   66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   14000262d:	|  |  |  |  |  |  |   00 00 00 
   140002630:	|  |  |  |  \--|--|-> f6 42 04 01          	testb  $0x1,0x4(%rdx)
   140002634:	|  |  |  |     \--|-- 0f 85 57 ff ff ff    	jne    140002591 <_gnu_exception_handler+0x21> (File Offset: 0x1b91)
   14000263a:	+--|--|--|--------|-- eb c1                	jmp    1400025fd <_gnu_exception_handler+0x8d> (File Offset: 0x1bfd)
   14000263c:	|  |  |  |        |   0f 1f 40 00          	nopl   0x0(%rax)
   140002640:	|  |  |  |        \-> 31 c0                	xor    %eax,%eax
   140002642:	|  |  |  |            48 83 c4 20          	add    $0x20,%rsp
   140002646:	|  |  |  |            5b                   	pop    %rbx
   140002647:	|  |  |  |            c3                   	ret
   140002648:	|  |  |  |            0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   14000264f:	|  |  |  |            00 
   140002650:	|  |  |  |            31 d2                	xor    %edx,%edx
   140002652:	|  |  |  |            b9 08 00 00 00       	mov    $0x8,%ecx
   140002657:	|  |  |  |            e8 8c 08 00 00       	call   140002ee8 <signal> (File Offset: 0x24e8)
   14000265c:	|  |  |  |            48 83 f8 01          	cmp    $0x1,%rax
   140002660:	|  |  |  |     /----- 0f 84 89 00 00 00    	je     1400026ef <_gnu_exception_handler+0x17f> (File Offset: 0x1cef)
   140002666:	|  |  |  |     |  /-> 48 85 c0             	test   %rax,%rax
   140002669:	|  +--|--|-----|--|-- 74 a4                	je     14000260f <_gnu_exception_handler+0x9f> (File Offset: 0x1c0f)
   14000266b:	|  |  |  |     |  |   b9 08 00 00 00       	mov    $0x8,%ecx
   140002670:	|  |  |  |     |  |   ff d0                	call   *%rax
   140002672:	+--|--|--|-----|--|-- eb 89                	jmp    1400025fd <_gnu_exception_handler+0x8d> (File Offset: 0x1bfd)
   140002674:	|  |  |  |     |  |   0f 1f 40 00          	nopl   0x0(%rax)
   140002678:	|  |  |  |     |  |   31 d2                	xor    %edx,%edx
   14000267a:	|  |  |  |     |  |   b9 08 00 00 00       	mov    $0x8,%ecx
   14000267f:	|  |  |  |     |  |   e8 64 08 00 00       	call   140002ee8 <signal> (File Offset: 0x24e8)
   140002684:	|  |  |  |     |  |   48 83 f8 01          	cmp    $0x1,%rax
   140002688:	|  |  |  |     |  \-- 75 dc                	jne    140002666 <_gnu_exception_handler+0xf6> (File Offset: 0x1c66)
   14000268a:	|  |  |  |     |      ba 01 00 00 00       	mov    $0x1,%edx
   14000268f:	|  |  |  |     |      b9 08 00 00 00       	mov    $0x8,%ecx
   140002694:	|  |  |  |     |      e8 4f 08 00 00       	call   140002ee8 <signal> (File Offset: 0x24e8)
   140002699:	+--|--|--|-----|----- e9 5f ff ff ff       	jmp    1400025fd <_gnu_exception_handler+0x8d> (File Offset: 0x1bfd)
   14000269e:	|  |  |  |     |      66 90                	xchg   %ax,%ax
   1400026a0:	|  |  |  \-----|----> 31 d2                	xor    %edx,%edx
   1400026a2:	|  |  |        |      b9 0b 00 00 00       	mov    $0xb,%ecx
   1400026a7:	|  |  |        |      e8 3c 08 00 00       	call   140002ee8 <signal> (File Offset: 0x24e8)
   1400026ac:	|  |  |        |      48 83 f8 01          	cmp    $0x1,%rax
   1400026b0:	|  |  |        |  /-- 74 29                	je     1400026db <_gnu_exception_handler+0x16b> (File Offset: 0x1cdb)
   1400026b2:	|  |  |        |  |   48 85 c0             	test   %rax,%rax
   1400026b5:	|  \--|--------|--|-- 0f 84 54 ff ff ff    	je     14000260f <_gnu_exception_handler+0x9f> (File Offset: 0x1c0f)
   1400026bb:	|     |        |  |   b9 0b 00 00 00       	mov    $0xb,%ecx
   1400026c0:	|     |        |  |   ff d0                	call   *%rax
   1400026c2:	+-----|--------|--|-- e9 36 ff ff ff       	jmp    1400025fd <_gnu_exception_handler+0x8d> (File Offset: 0x1bfd)
   1400026c7:	|     \--------|--|-> ba 01 00 00 00       	mov    $0x1,%edx
   1400026cc:	|              |  |   b9 04 00 00 00       	mov    $0x4,%ecx
   1400026d1:	|              |  |   e8 12 08 00 00       	call   140002ee8 <signal> (File Offset: 0x24e8)
   1400026d6:	+--------------|--|-- e9 22 ff ff ff       	jmp    1400025fd <_gnu_exception_handler+0x8d> (File Offset: 0x1bfd)
   1400026db:	|              |  \-> ba 01 00 00 00       	mov    $0x1,%edx
   1400026e0:	|              |      b9 0b 00 00 00       	mov    $0xb,%ecx
   1400026e5:	|              |      e8 fe 07 00 00       	call   140002ee8 <signal> (File Offset: 0x24e8)
   1400026ea:	+--------------|----- e9 0e ff ff ff       	jmp    1400025fd <_gnu_exception_handler+0x8d> (File Offset: 0x1bfd)
   1400026ef:	|              \----> ba 01 00 00 00       	mov    $0x1,%edx
   1400026f4:	|                     b9 08 00 00 00       	mov    $0x8,%ecx
   1400026f9:	|                     e8 ea 07 00 00       	call   140002ee8 <signal> (File Offset: 0x24e8)
   1400026fe:	|                     e8 cd f8 ff ff       	call   140001fd0 <_fpreset> (File Offset: 0x15d0)
   140002703:	\-------------------- e9 f5 fe ff ff       	jmp    1400025fd <_gnu_exception_handler+0x8d> (File Offset: 0x1bfd)
   140002708:	                      90                   	nop
   140002709:	                      90                   	nop
   14000270a:	                      90                   	nop
   14000270b:	                      90                   	nop
   14000270c:	                      90                   	nop
   14000270d:	                      90                   	nop
   14000270e:	                      90                   	nop
   14000270f:	                      90                   	nop

0000000140002710 <__mingwthr_run_key_dtors.part.0> (File Offset: 0x1d10):
   140002710:	          41 54                	push   %r12
   140002712:	          55                   	push   %rbp
   140002713:	          57                   	push   %rdi
   140002714:	          56                   	push   %rsi
   140002715:	          53                   	push   %rbx
   140002716:	          48 83 ec 20          	sub    $0x20,%rsp
   14000271a:	          4c 8d 25 df 69 00 00 	lea    0x69df(%rip),%r12        # 140009100 <__mingwthr_cs> (File Offset: 0x8700)
   140002721:	          4c 89 e1             	mov    %r12,%rcx
   140002724:	          ff 15 42 7b 00 00    	call   *0x7b42(%rip)        # 14000a26c <__imp_EnterCriticalSection> (File Offset: 0x986c)
   14000272a:	          48 8b 1d af 69 00 00 	mov    0x69af(%rip),%rbx        # 1400090e0 <key_dtor_list> (File Offset: 0x86e0)
   140002731:	          48 85 db             	test   %rbx,%rbx
   140002734:	/-------- 74 36                	je     14000276c <__mingwthr_run_key_dtors.part.0+0x5c> (File Offset: 0x1d6c)
   140002736:	|         48 8b 2d 5f 7b 00 00 	mov    0x7b5f(%rip),%rbp        # 14000a29c <__imp_TlsGetValue> (File Offset: 0x989c)
   14000273d:	|         48 8b 3d 30 7b 00 00 	mov    0x7b30(%rip),%rdi        # 14000a274 <__imp_GetLastError> (File Offset: 0x9874)
   140002744:	|         0f 1f 40 00          	nopl   0x0(%rax)
   140002748:	|  /----> 8b 0b                	mov    (%rbx),%ecx
   14000274a:	|  |      ff d5                	call   *%rbp
   14000274c:	|  |      48 89 c6             	mov    %rax,%rsi
   14000274f:	|  |      ff d7                	call   *%rdi
   140002751:	|  |      85 c0                	test   %eax,%eax
   140002753:	|  |  /-- 75 0e                	jne    140002763 <__mingwthr_run_key_dtors.part.0+0x53> (File Offset: 0x1d63)
   140002755:	|  |  |   48 85 f6             	test   %rsi,%rsi
   140002758:	|  |  +-- 74 09                	je     140002763 <__mingwthr_run_key_dtors.part.0+0x53> (File Offset: 0x1d63)
   14000275a:	|  |  |   48 8b 43 08          	mov    0x8(%rbx),%rax
   14000275e:	|  |  |   48 89 f1             	mov    %rsi,%rcx
   140002761:	|  |  |   ff d0                	call   *%rax
   140002763:	|  |  \-> 48 8b 5b 10          	mov    0x10(%rbx),%rbx
   140002767:	|  |      48 85 db             	test   %rbx,%rbx
   14000276a:	|  \----- 75 dc                	jne    140002748 <__mingwthr_run_key_dtors.part.0+0x38> (File Offset: 0x1d48)
   14000276c:	\-------> 4c 89 e1             	mov    %r12,%rcx
   14000276f:	          48 83 c4 20          	add    $0x20,%rsp
   140002773:	          5b                   	pop    %rbx
   140002774:	          5e                   	pop    %rsi
   140002775:	          5f                   	pop    %rdi
   140002776:	          5d                   	pop    %rbp
   140002777:	          41 5c                	pop    %r12
   140002779:	          48 ff 25 04 7b 00 00 	rex.W jmp *0x7b04(%rip)        # 14000a284 <__imp_LeaveCriticalSection> (File Offset: 0x9884)

0000000140002780 <___w64_mingwthr_add_key_dtor> (File Offset: 0x1d80):
   140002780:	          57                   	push   %rdi
   140002781:	          56                   	push   %rsi
   140002782:	          53                   	push   %rbx
   140002783:	          48 83 ec 20          	sub    $0x20,%rsp
   140002787:	          8b 05 5b 69 00 00    	mov    0x695b(%rip),%eax        # 1400090e8 <__mingwthr_cs_init> (File Offset: 0x86e8)
   14000278d:	          85 c0                	test   %eax,%eax
   14000278f:	          89 cf                	mov    %ecx,%edi
   140002791:	          48 89 d6             	mov    %rdx,%rsi
   140002794:	      /-- 75 0a                	jne    1400027a0 <___w64_mingwthr_add_key_dtor+0x20> (File Offset: 0x1da0)
   140002796:	   /--|-> 31 c0                	xor    %eax,%eax
   140002798:	/--|--|-> 48 83 c4 20          	add    $0x20,%rsp
   14000279c:	|  |  |   5b                   	pop    %rbx
   14000279d:	|  |  |   5e                   	pop    %rsi
   14000279e:	|  |  |   5f                   	pop    %rdi
   14000279f:	|  |  |   c3                   	ret
   1400027a0:	|  |  \-> ba 18 00 00 00       	mov    $0x18,%edx
   1400027a5:	|  |      b9 01 00 00 00       	mov    $0x1,%ecx
   1400027aa:	|  |      e8 f9 06 00 00       	call   140002ea8 <calloc> (File Offset: 0x24a8)
   1400027af:	|  |      48 85 c0             	test   %rax,%rax
   1400027b2:	|  |      48 89 c3             	mov    %rax,%rbx
   1400027b5:	|  |  /-- 74 33                	je     1400027ea <___w64_mingwthr_add_key_dtor+0x6a> (File Offset: 0x1dea)
   1400027b7:	|  |  |   48 89 70 08          	mov    %rsi,0x8(%rax)
   1400027bb:	|  |  |   48 8d 35 3e 69 00 00 	lea    0x693e(%rip),%rsi        # 140009100 <__mingwthr_cs> (File Offset: 0x8700)
   1400027c2:	|  |  |   89 38                	mov    %edi,(%rax)
   1400027c4:	|  |  |   48 89 f1             	mov    %rsi,%rcx
   1400027c7:	|  |  |   ff 15 9f 7a 00 00    	call   *0x7a9f(%rip)        # 14000a26c <__imp_EnterCriticalSection> (File Offset: 0x986c)
   1400027cd:	|  |  |   48 8b 05 0c 69 00 00 	mov    0x690c(%rip),%rax        # 1400090e0 <key_dtor_list> (File Offset: 0x86e0)
   1400027d4:	|  |  |   48 89 f1             	mov    %rsi,%rcx
   1400027d7:	|  |  |   48 89 1d 02 69 00 00 	mov    %rbx,0x6902(%rip)        # 1400090e0 <key_dtor_list> (File Offset: 0x86e0)
   1400027de:	|  |  |   48 89 43 10          	mov    %rax,0x10(%rbx)
   1400027e2:	|  |  |   ff 15 9c 7a 00 00    	call   *0x7a9c(%rip)        # 14000a284 <__imp_LeaveCriticalSection> (File Offset: 0x9884)
   1400027e8:	|  \--|-- eb ac                	jmp    140002796 <___w64_mingwthr_add_key_dtor+0x16> (File Offset: 0x1d96)
   1400027ea:	|     \-> 83 c8 ff             	or     $0xffffffff,%eax
   1400027ed:	\-------- eb a9                	jmp    140002798 <___w64_mingwthr_add_key_dtor+0x18> (File Offset: 0x1d98)
   1400027ef:	          90                   	nop

00000001400027f0 <___w64_mingwthr_remove_key_dtor> (File Offset: 0x1df0):
   1400027f0:	          56                   	push   %rsi
   1400027f1:	          53                   	push   %rbx
   1400027f2:	          48 83 ec 28          	sub    $0x28,%rsp
   1400027f6:	          8b 05 ec 68 00 00    	mov    0x68ec(%rip),%eax        # 1400090e8 <__mingwthr_cs_init> (File Offset: 0x86e8)
   1400027fc:	          85 c0                	test   %eax,%eax
   1400027fe:	          89 cb                	mov    %ecx,%ebx
   140002800:	      /-- 75 0e                	jne    140002810 <___w64_mingwthr_remove_key_dtor+0x20> (File Offset: 0x1e10)
   140002802:	      |   31 c0                	xor    %eax,%eax
   140002804:	      |   48 83 c4 28          	add    $0x28,%rsp
   140002808:	      |   5b                   	pop    %rbx
   140002809:	      |   5e                   	pop    %rsi
   14000280a:	      |   c3                   	ret
   14000280b:	      |   0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140002810:	      \-> 48 8d 35 e9 68 00 00 	lea    0x68e9(%rip),%rsi        # 140009100 <__mingwthr_cs> (File Offset: 0x8700)
   140002817:	          48 89 f1             	mov    %rsi,%rcx
   14000281a:	          ff 15 4c 7a 00 00    	call   *0x7a4c(%rip)        # 14000a26c <__imp_EnterCriticalSection> (File Offset: 0x986c)
   140002820:	          48 8b 0d b9 68 00 00 	mov    0x68b9(%rip),%rcx        # 1400090e0 <key_dtor_list> (File Offset: 0x86e0)
   140002827:	          48 85 c9             	test   %rcx,%rcx
   14000282a:	/-------- 74 27                	je     140002853 <___w64_mingwthr_remove_key_dtor+0x63> (File Offset: 0x1e53)
   14000282c:	|         31 d2                	xor    %edx,%edx
   14000282e:	|     /-- eb 0b                	jmp    14000283b <___w64_mingwthr_remove_key_dtor+0x4b> (File Offset: 0x1e3b)
   140002830:	|  /--|-> 48 85 c0             	test   %rax,%rax
   140002833:	|  |  |   48 89 ca             	mov    %rcx,%rdx
   140002836:	+--|--|-- 74 1b                	je     140002853 <___w64_mingwthr_remove_key_dtor+0x63> (File Offset: 0x1e53)
   140002838:	|  |  |   48 89 c1             	mov    %rax,%rcx
   14000283b:	|  |  \-> 8b 01                	mov    (%rcx),%eax
   14000283d:	|  |      39 d8                	cmp    %ebx,%eax
   14000283f:	|  |      48 8b 41 10          	mov    0x10(%rcx),%rax
   140002843:	|  \----- 75 eb                	jne    140002830 <___w64_mingwthr_remove_key_dtor+0x40> (File Offset: 0x1e30)
   140002845:	|         48 85 d2             	test   %rdx,%rdx
   140002848:	|     /-- 74 1e                	je     140002868 <___w64_mingwthr_remove_key_dtor+0x78> (File Offset: 0x1e68)
   14000284a:	|     |   48 89 42 10          	mov    %rax,0x10(%rdx)
   14000284e:	|  /--|-> e8 65 06 00 00       	call   140002eb8 <free> (File Offset: 0x24b8)
   140002853:	\--|--|-> 48 89 f1             	mov    %rsi,%rcx
   140002856:	   |  |   ff 15 28 7a 00 00    	call   *0x7a28(%rip)        # 14000a284 <__imp_LeaveCriticalSection> (File Offset: 0x9884)
   14000285c:	   |  |   31 c0                	xor    %eax,%eax
   14000285e:	   |  |   48 83 c4 28          	add    $0x28,%rsp
   140002862:	   |  |   5b                   	pop    %rbx
   140002863:	   |  |   5e                   	pop    %rsi
   140002864:	   |  |   c3                   	ret
   140002865:	   |  |   0f 1f 00             	nopl   (%rax)
   140002868:	   |  \-> 48 89 05 71 68 00 00 	mov    %rax,0x6871(%rip)        # 1400090e0 <key_dtor_list> (File Offset: 0x86e0)
   14000286f:	   \----- eb dd                	jmp    14000284e <___w64_mingwthr_remove_key_dtor+0x5e> (File Offset: 0x1e4e)
   140002871:	          66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   140002878:	          00 00 00 00 
   14000287c:	          0f 1f 40 00          	nopl   0x0(%rax)

0000000140002880 <__mingw_TLScallback> (File Offset: 0x1e80):
   140002880:	                         53                   	push   %rbx
   140002881:	                         48 83 ec 20          	sub    $0x20,%rsp
   140002885:	                         83 fa 02             	cmp    $0x2,%edx
   140002888:	      /----------------- 0f 84 b2 00 00 00    	je     140002940 <__mingw_TLScallback+0xc0> (File Offset: 0x1f40)
   14000288e:	      |              /-- 77 30                	ja     1400028c0 <__mingw_TLScallback+0x40> (File Offset: 0x1ec0)
   140002890:	      |              |   85 d2                	test   %edx,%edx
   140002892:	      |           /--|-- 74 4c                	je     1400028e0 <__mingw_TLScallback+0x60> (File Offset: 0x1ee0)
   140002894:	      |           |  |   8b 05 4e 68 00 00    	mov    0x684e(%rip),%eax        # 1400090e8 <__mingwthr_cs_init> (File Offset: 0x86e8)
   14000289a:	      |           |  |   85 c0                	test   %eax,%eax
   14000289c:	   /--|-----------|--|-- 0f 84 be 00 00 00    	je     140002960 <__mingw_TLScallback+0xe0> (File Offset: 0x1f60)
   1400028a2:	/--|--|-----------|--|-> c7 05 3c 68 00 00 01 	movl   $0x1,0x683c(%rip)        # 1400090e8 <__mingwthr_cs_init> (File Offset: 0x86e8)
   1400028a9:	|  |  |           |  |   00 00 00 
   1400028ac:	|  |  |  /--------|--|-> b8 01 00 00 00       	mov    $0x1,%eax
   1400028b1:	|  |  |  |        |  |   48 83 c4 20          	add    $0x20,%rsp
   1400028b5:	|  |  |  |        |  |   5b                   	pop    %rbx
   1400028b6:	|  |  |  |        |  |   c3                   	ret
   1400028b7:	|  |  |  |        |  |   66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   1400028be:	|  |  |  |        |  |   00 00 
   1400028c0:	|  |  |  |        |  \-> 83 fa 03             	cmp    $0x3,%edx
   1400028c3:	|  |  |  +--------|----- 75 e7                	jne    1400028ac <__mingw_TLScallback+0x2c> (File Offset: 0x1eac)
   1400028c5:	|  |  |  |        |      8b 05 1d 68 00 00    	mov    0x681d(%rip),%eax        # 1400090e8 <__mingwthr_cs_init> (File Offset: 0x86e8)
   1400028cb:	|  |  |  |        |      85 c0                	test   %eax,%eax
   1400028cd:	|  |  |  +--------|----- 74 dd                	je     1400028ac <__mingw_TLScallback+0x2c> (File Offset: 0x1eac)
   1400028cf:	|  |  |  |        |      e8 3c fe ff ff       	call   140002710 <__mingwthr_run_key_dtors.part.0> (File Offset: 0x1d10)
   1400028d4:	|  |  |  +--------|----- eb d6                	jmp    1400028ac <__mingw_TLScallback+0x2c> (File Offset: 0x1eac)
   1400028d6:	|  |  |  |        |      66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   1400028dd:	|  |  |  |        |      00 00 00 
   1400028e0:	|  |  |  |        \----> 8b 05 02 68 00 00    	mov    0x6802(%rip),%eax        # 1400090e8 <__mingwthr_cs_init> (File Offset: 0x86e8)
   1400028e6:	|  |  |  |               85 c0                	test   %eax,%eax
   1400028e8:	|  |  |  |     /-------- 75 66                	jne    140002950 <__mingw_TLScallback+0xd0> (File Offset: 0x1f50)
   1400028ea:	|  |  |  |  /--|-------> 8b 05 f8 67 00 00    	mov    0x67f8(%rip),%eax        # 1400090e8 <__mingwthr_cs_init> (File Offset: 0x86e8)
   1400028f0:	|  |  |  |  |  |         83 f8 01             	cmp    $0x1,%eax
   1400028f3:	|  |  |  +--|--|-------- 75 b7                	jne    1400028ac <__mingw_TLScallback+0x2c> (File Offset: 0x1eac)
   1400028f5:	|  |  |  |  |  |         48 8b 1d e4 67 00 00 	mov    0x67e4(%rip),%rbx        # 1400090e0 <key_dtor_list> (File Offset: 0x86e0)
   1400028fc:	|  |  |  |  |  |         48 85 db             	test   %rbx,%rbx
   1400028ff:	|  |  |  |  |  |  /----- 74 18                	je     140002919 <__mingw_TLScallback+0x99> (File Offset: 0x1f19)
   140002901:	|  |  |  |  |  |  |      0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140002908:	|  |  |  |  |  |  |  /-> 48 89 d9             	mov    %rbx,%rcx
   14000290b:	|  |  |  |  |  |  |  |   48 8b 5b 10          	mov    0x10(%rbx),%rbx
   14000290f:	|  |  |  |  |  |  |  |   e8 a4 05 00 00       	call   140002eb8 <free> (File Offset: 0x24b8)
   140002914:	|  |  |  |  |  |  |  |   48 85 db             	test   %rbx,%rbx
   140002917:	|  |  |  |  |  |  |  \-- 75 ef                	jne    140002908 <__mingw_TLScallback+0x88> (File Offset: 0x1f08)
   140002919:	|  |  |  |  |  |  \----> 48 8d 0d e0 67 00 00 	lea    0x67e0(%rip),%rcx        # 140009100 <__mingwthr_cs> (File Offset: 0x8700)
   140002920:	|  |  |  |  |  |         48 c7 05 b5 67 00 00 	movq   $0x0,0x67b5(%rip)        # 1400090e0 <key_dtor_list> (File Offset: 0x86e0)
   140002927:	|  |  |  |  |  |         00 00 00 00 
   14000292b:	|  |  |  |  |  |         c7 05 b3 67 00 00 00 	movl   $0x0,0x67b3(%rip)        # 1400090e8 <__mingwthr_cs_init> (File Offset: 0x86e8)
   140002932:	|  |  |  |  |  |         00 00 00 
   140002935:	|  |  |  |  |  |         ff 15 29 79 00 00    	call   *0x7929(%rip)        # 14000a264 <__imp_DeleteCriticalSection> (File Offset: 0x9864)
   14000293b:	|  |  |  \--|--|-------- e9 6c ff ff ff       	jmp    1400028ac <__mingw_TLScallback+0x2c> (File Offset: 0x1eac)
   140002940:	|  |  \-----|--|-------> e8 8b f6 ff ff       	call   140001fd0 <_fpreset> (File Offset: 0x15d0)
   140002945:	|  |        |  |         b8 01 00 00 00       	mov    $0x1,%eax
   14000294a:	|  |        |  |         48 83 c4 20          	add    $0x20,%rsp
   14000294e:	|  |        |  |         5b                   	pop    %rbx
   14000294f:	|  |        |  |         c3                   	ret
   140002950:	|  |        |  \-------> e8 bb fd ff ff       	call   140002710 <__mingwthr_run_key_dtors.part.0> (File Offset: 0x1d10)
   140002955:	|  |        \----------- eb 93                	jmp    1400028ea <__mingw_TLScallback+0x6a> (File Offset: 0x1eea)
   140002957:	|  |                     66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   14000295e:	|  |                     00 00 
   140002960:	|  \-------------------> 48 8d 0d 99 67 00 00 	lea    0x6799(%rip),%rcx        # 140009100 <__mingwthr_cs> (File Offset: 0x8700)
   140002967:	|                        ff 15 0f 79 00 00    	call   *0x790f(%rip)        # 14000a27c <__imp_InitializeCriticalSection> (File Offset: 0x987c)
   14000296d:	\----------------------- e9 30 ff ff ff       	jmp    1400028a2 <__mingw_TLScallback+0x22> (File Offset: 0x1ea2)
   140002972:	                         90                   	nop
   140002973:	                         90                   	nop
   140002974:	                         90                   	nop
   140002975:	                         90                   	nop
   140002976:	                         90                   	nop
   140002977:	                         90                   	nop
   140002978:	                         90                   	nop
   140002979:	                         90                   	nop
   14000297a:	                         90                   	nop
   14000297b:	                         90                   	nop
   14000297c:	                         90                   	nop
   14000297d:	                         90                   	nop
   14000297e:	                         90                   	nop
   14000297f:	                         90                   	nop

0000000140002980 <exit> (File Offset: 0x1f80):
   140002980:	48 83 ec 28          	sub    $0x28,%rsp
   140002984:	48 8b 05 05 3b 00 00 	mov    0x3b05(%rip),%rax        # 140006490 <.refptr.__imp_exit> (File Offset: 0x5a90)
   14000298b:	ff 10                	call   *(%rax)
   14000298d:	90                   	nop
   14000298e:	66 90                	xchg   %ax,%ax

0000000140002990 <_exit> (File Offset: 0x1f90):
   140002990:	48 83 ec 28          	sub    $0x28,%rsp
   140002994:	48 8b 05 d5 3a 00 00 	mov    0x3ad5(%rip),%rax        # 140006470 <.refptr.__imp__exit> (File Offset: 0x5a70)
   14000299b:	ff 10                	call   *(%rax)
   14000299d:	90                   	nop
   14000299e:	90                   	nop
   14000299f:	90                   	nop

00000001400029a0 <_ValidateImageBase> (File Offset: 0x1fa0):
   1400029a0:	       31 c0                	xor    %eax,%eax
   1400029a2:	       66 81 39 4d 5a       	cmpw   $0x5a4d,(%rcx)
   1400029a7:	/----- 75 0f                	jne    1400029b8 <_ValidateImageBase+0x18> (File Offset: 0x1fb8)
   1400029a9:	|      48 63 51 3c          	movslq 0x3c(%rcx),%rdx
   1400029ad:	|      48 01 d1             	add    %rdx,%rcx
   1400029b0:	|      81 39 50 45 00 00    	cmpl   $0x4550,(%rcx)
   1400029b6:	|  /-- 74 08                	je     1400029c0 <_ValidateImageBase+0x20> (File Offset: 0x1fc0)
   1400029b8:	\--|-> c3                   	ret
   1400029b9:	   |   0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   1400029c0:	   \-> 31 c0                	xor    %eax,%eax
   1400029c2:	       66 81 79 18 0b 02    	cmpw   $0x20b,0x18(%rcx)
   1400029c8:	       0f 94 c0             	sete   %al
   1400029cb:	       c3                   	ret
   1400029cc:	       0f 1f 40 00          	nopl   0x0(%rax)

00000001400029d0 <_FindPESection> (File Offset: 0x1fd0):
   1400029d0:	             48 63 41 3c          	movslq 0x3c(%rcx),%rax
   1400029d4:	             48 01 c1             	add    %rax,%rcx
   1400029d7:	             44 0f b7 41 06       	movzwl 0x6(%rcx),%r8d
   1400029dc:	             0f b7 41 14          	movzwl 0x14(%rcx),%eax
   1400029e0:	             66 45 85 c0          	test   %r8w,%r8w
   1400029e4:	             48 8d 44 01 18       	lea    0x18(%rcx,%rax,1),%rax
   1400029e9:	/----------- 74 32                	je     140002a1d <_FindPESection+0x4d> (File Offset: 0x201d)
   1400029eb:	|            41 8d 48 ff          	lea    -0x1(%r8),%ecx
   1400029ef:	|            48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
   1400029f3:	|            4c 8d 4c c8 28       	lea    0x28(%rax,%rcx,8),%r9
   1400029f8:	|            0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   1400029ff:	|            00 
   140002a00:	|  /-------> 44 8b 40 0c          	mov    0xc(%rax),%r8d
   140002a04:	|  |         4c 39 c2             	cmp    %r8,%rdx
   140002a07:	|  |         4c 89 c1             	mov    %r8,%rcx
   140002a0a:	|  |     /-- 72 08                	jb     140002a14 <_FindPESection+0x44> (File Offset: 0x2014)
   140002a0c:	|  |     |   03 48 08             	add    0x8(%rax),%ecx
   140002a0f:	|  |     |   48 39 ca             	cmp    %rcx,%rdx
   140002a12:	|  |  /--|-- 72 0b                	jb     140002a1f <_FindPESection+0x4f> (File Offset: 0x201f)
   140002a14:	|  |  |  \-> 48 83 c0 28          	add    $0x28,%rax
   140002a18:	|  |  |      4c 39 c8             	cmp    %r9,%rax
   140002a1b:	|  \--|----- 75 e3                	jne    140002a00 <_FindPESection+0x30> (File Offset: 0x2000)
   140002a1d:	\-----|----> 31 c0                	xor    %eax,%eax
   140002a1f:	      \----> c3                   	ret

0000000140002a20 <_FindPESectionByName> (File Offset: 0x2020):
   140002a20:	             57                   	push   %rdi
   140002a21:	             56                   	push   %rsi
   140002a22:	             53                   	push   %rbx
   140002a23:	             48 83 ec 20          	sub    $0x20,%rsp
   140002a27:	             48 89 ce             	mov    %rcx,%rsi
   140002a2a:	             e8 c1 04 00 00       	call   140002ef0 <strlen> (File Offset: 0x24f0)
   140002a2f:	             48 83 f8 08          	cmp    $0x8,%rax
   140002a33:	/----------- 77 7b                	ja     140002ab0 <_FindPESectionByName+0x90> (File Offset: 0x20b0)
   140002a35:	|            48 8b 15 04 3a 00 00 	mov    0x3a04(%rip),%rdx        # 140006440 <.refptr.__image_base__> (File Offset: 0x5a40)
   140002a3c:	|            31 db                	xor    %ebx,%ebx
   140002a3e:	|            66 81 3a 4d 5a       	cmpw   $0x5a4d,(%rdx)
   140002a43:	|  /-------- 75 59                	jne    140002a9e <_FindPESectionByName+0x7e> (File Offset: 0x209e)
   140002a45:	|  |         48 63 42 3c          	movslq 0x3c(%rdx),%rax
   140002a49:	|  |         48 01 d0             	add    %rdx,%rax
   140002a4c:	|  |         81 38 50 45 00 00    	cmpl   $0x4550,(%rax)
   140002a52:	|  +-------- 75 4a                	jne    140002a9e <_FindPESectionByName+0x7e> (File Offset: 0x209e)
   140002a54:	|  |         66 81 78 18 0b 02    	cmpw   $0x20b,0x18(%rax)
   140002a5a:	|  +-------- 75 42                	jne    140002a9e <_FindPESectionByName+0x7e> (File Offset: 0x209e)
   140002a5c:	|  |         0f b7 50 14          	movzwl 0x14(%rax),%edx
   140002a60:	|  |         48 8d 5c 10 18       	lea    0x18(%rax,%rdx,1),%rbx
   140002a65:	|  |         0f b7 50 06          	movzwl 0x6(%rax),%edx
   140002a69:	|  |         66 85 d2             	test   %dx,%dx
   140002a6c:	+--|-------- 74 42                	je     140002ab0 <_FindPESectionByName+0x90> (File Offset: 0x20b0)
   140002a6e:	|  |         8d 42 ff             	lea    -0x1(%rdx),%eax
   140002a71:	|  |         48 8d 04 80          	lea    (%rax,%rax,4),%rax
   140002a75:	|  |         48 8d 7c c3 28       	lea    0x28(%rbx,%rax,8),%rdi
   140002a7a:	|  |     /-- eb 0d                	jmp    140002a89 <_FindPESectionByName+0x69> (File Offset: 0x2089)
   140002a7c:	|  |     |   0f 1f 40 00          	nopl   0x0(%rax)
   140002a80:	|  |  /--|-> 48 83 c3 28          	add    $0x28,%rbx
   140002a84:	|  |  |  |   48 39 fb             	cmp    %rdi,%rbx
   140002a87:	+--|--|--|-- 74 27                	je     140002ab0 <_FindPESectionByName+0x90> (File Offset: 0x20b0)
   140002a89:	|  |  |  \-> 41 b8 08 00 00 00    	mov    $0x8,%r8d
   140002a8f:	|  |  |      48 89 f2             	mov    %rsi,%rdx
   140002a92:	|  |  |      48 89 d9             	mov    %rbx,%rcx
   140002a95:	|  |  |      e8 5e 04 00 00       	call   140002ef8 <strncmp> (File Offset: 0x24f8)
   140002a9a:	|  |  |      85 c0                	test   %eax,%eax
   140002a9c:	|  |  \----- 75 e2                	jne    140002a80 <_FindPESectionByName+0x60> (File Offset: 0x2080)
   140002a9e:	|  \-------> 48 89 d8             	mov    %rbx,%rax
   140002aa1:	|            48 83 c4 20          	add    $0x20,%rsp
   140002aa5:	|            5b                   	pop    %rbx
   140002aa6:	|            5e                   	pop    %rsi
   140002aa7:	|            5f                   	pop    %rdi
   140002aa8:	|            c3                   	ret
   140002aa9:	|            0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140002ab0:	\----------> 31 db                	xor    %ebx,%ebx
   140002ab2:	             48 89 d8             	mov    %rbx,%rax
   140002ab5:	             48 83 c4 20          	add    $0x20,%rsp
   140002ab9:	             5b                   	pop    %rbx
   140002aba:	             5e                   	pop    %rsi
   140002abb:	             5f                   	pop    %rdi
   140002abc:	             c3                   	ret
   140002abd:	             0f 1f 00             	nopl   (%rax)

0000000140002ac0 <__mingw_GetSectionForAddress> (File Offset: 0x20c0):
   140002ac0:	             48 8b 15 79 39 00 00 	mov    0x3979(%rip),%rdx        # 140006440 <.refptr.__image_base__> (File Offset: 0x5a40)
   140002ac7:	             31 c0                	xor    %eax,%eax
   140002ac9:	             66 81 3a 4d 5a       	cmpw   $0x5a4d,(%rdx)
   140002ace:	/----------- 75 10                	jne    140002ae0 <__mingw_GetSectionForAddress+0x20> (File Offset: 0x20e0)
   140002ad0:	|            4c 63 42 3c          	movslq 0x3c(%rdx),%r8
   140002ad4:	|            49 01 d0             	add    %rdx,%r8
   140002ad7:	|            41 81 38 50 45 00 00 	cmpl   $0x4550,(%r8)
   140002ade:	|        /-- 74 08                	je     140002ae8 <__mingw_GetSectionForAddress+0x28> (File Offset: 0x20e8)
   140002ae0:	>--------|-> c3                   	ret
   140002ae1:	|        |   0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140002ae8:	|        \-> 66 41 81 78 18 0b 02 	cmpw   $0x20b,0x18(%r8)
   140002aef:	+----------- 75 ef                	jne    140002ae0 <__mingw_GetSectionForAddress+0x20> (File Offset: 0x20e0)
   140002af1:	|            41 0f b7 40 14       	movzwl 0x14(%r8),%eax
   140002af6:	|            48 29 d1             	sub    %rdx,%rcx
   140002af9:	|            49 8d 44 00 18       	lea    0x18(%r8,%rax,1),%rax
   140002afe:	|            45 0f b7 40 06       	movzwl 0x6(%r8),%r8d
   140002b03:	|            66 45 85 c0          	test   %r8w,%r8w
   140002b07:	|  /-------- 74 34                	je     140002b3d <__mingw_GetSectionForAddress+0x7d> (File Offset: 0x213d)
   140002b09:	|  |         41 8d 50 ff          	lea    -0x1(%r8),%edx
   140002b0d:	|  |         48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
   140002b11:	|  |         4c 8d 4c d0 28       	lea    0x28(%rax,%rdx,8),%r9
   140002b16:	|  |         66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   140002b1d:	|  |         00 00 00 
   140002b20:	|  |  /----> 44 8b 40 0c          	mov    0xc(%rax),%r8d
   140002b24:	|  |  |      4c 39 c1             	cmp    %r8,%rcx
   140002b27:	|  |  |      4c 89 c2             	mov    %r8,%rdx
   140002b2a:	|  |  |  /-- 72 08                	jb     140002b34 <__mingw_GetSectionForAddress+0x74> (File Offset: 0x2134)
   140002b2c:	|  |  |  |   03 50 08             	add    0x8(%rax),%edx
   140002b2f:	|  |  |  |   48 39 d1             	cmp    %rdx,%rcx
   140002b32:	\--|--|--|-- 72 ac                	jb     140002ae0 <__mingw_GetSectionForAddress+0x20> (File Offset: 0x20e0)
   140002b34:	   |  |  \-> 48 83 c0 28          	add    $0x28,%rax
   140002b38:	   |  |      4c 39 c8             	cmp    %r9,%rax
   140002b3b:	   |  \----- 75 e3                	jne    140002b20 <__mingw_GetSectionForAddress+0x60> (File Offset: 0x2120)
   140002b3d:	   \-------> 31 c0                	xor    %eax,%eax
   140002b3f:	             c3                   	ret

0000000140002b40 <__mingw_GetSectionCount> (File Offset: 0x2140):
   140002b40:	       48 8b 05 f9 38 00 00 	mov    0x38f9(%rip),%rax        # 140006440 <.refptr.__image_base__> (File Offset: 0x5a40)
   140002b47:	       31 c9                	xor    %ecx,%ecx
   140002b49:	       66 81 38 4d 5a       	cmpw   $0x5a4d,(%rax)
   140002b4e:	/----- 75 0f                	jne    140002b5f <__mingw_GetSectionCount+0x1f> (File Offset: 0x215f)
   140002b50:	|      48 63 50 3c          	movslq 0x3c(%rax),%rdx
   140002b54:	|      48 01 d0             	add    %rdx,%rax
   140002b57:	|      81 38 50 45 00 00    	cmpl   $0x4550,(%rax)
   140002b5d:	|  /-- 74 09                	je     140002b68 <__mingw_GetSectionCount+0x28> (File Offset: 0x2168)
   140002b5f:	>--|-> 89 c8                	mov    %ecx,%eax
   140002b61:	|  |   c3                   	ret
   140002b62:	|  |   66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   140002b68:	|  \-> 66 81 78 18 0b 02    	cmpw   $0x20b,0x18(%rax)
   140002b6e:	\----- 75 ef                	jne    140002b5f <__mingw_GetSectionCount+0x1f> (File Offset: 0x215f)
   140002b70:	       0f b7 48 06          	movzwl 0x6(%rax),%ecx
   140002b74:	       89 c8                	mov    %ecx,%eax
   140002b76:	       c3                   	ret
   140002b77:	       66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   140002b7e:	       00 00 

0000000140002b80 <_FindPESectionExec> (File Offset: 0x2180):
   140002b80:	             4c 8b 05 b9 38 00 00 	mov    0x38b9(%rip),%r8        # 140006440 <.refptr.__image_base__> (File Offset: 0x5a40)
   140002b87:	             31 c0                	xor    %eax,%eax
   140002b89:	             66 41 81 38 4d 5a    	cmpw   $0x5a4d,(%r8)
   140002b8f:	/----------- 75 0f                	jne    140002ba0 <_FindPESectionExec+0x20> (File Offset: 0x21a0)
   140002b91:	|            49 63 50 3c          	movslq 0x3c(%r8),%rdx
   140002b95:	|            4c 01 c2             	add    %r8,%rdx
   140002b98:	|            81 3a 50 45 00 00    	cmpl   $0x4550,(%rdx)
   140002b9e:	|        /-- 74 08                	je     140002ba8 <_FindPESectionExec+0x28> (File Offset: 0x21a8)
   140002ba0:	>--------|-> c3                   	ret
   140002ba1:	|        |   0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140002ba8:	|        \-> 66 81 7a 18 0b 02    	cmpw   $0x20b,0x18(%rdx)
   140002bae:	+----------- 75 f0                	jne    140002ba0 <_FindPESectionExec+0x20> (File Offset: 0x21a0)
   140002bb0:	|            44 0f b7 42 06       	movzwl 0x6(%rdx),%r8d
   140002bb5:	|            0f b7 42 14          	movzwl 0x14(%rdx),%eax
   140002bb9:	|            66 45 85 c0          	test   %r8w,%r8w
   140002bbd:	|            48 8d 44 02 18       	lea    0x18(%rdx,%rax,1),%rax
   140002bc2:	|  /-------- 74 2c                	je     140002bf0 <_FindPESectionExec+0x70> (File Offset: 0x21f0)
   140002bc4:	|  |         41 8d 50 ff          	lea    -0x1(%r8),%edx
   140002bc8:	|  |         48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
   140002bcc:	|  |         48 8d 54 d0 28       	lea    0x28(%rax,%rdx,8),%rdx
   140002bd1:	|  |         0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140002bd8:	|  |  /----> f6 40 27 20          	testb  $0x20,0x27(%rax)
   140002bdc:	|  |  |  /-- 74 09                	je     140002be7 <_FindPESectionExec+0x67> (File Offset: 0x21e7)
   140002bde:	|  |  |  |   48 85 c9             	test   %rcx,%rcx
   140002be1:	\--|--|--|-- 74 bd                	je     140002ba0 <_FindPESectionExec+0x20> (File Offset: 0x21a0)
   140002be3:	   |  |  |   48 83 e9 01          	sub    $0x1,%rcx
   140002be7:	   |  |  \-> 48 83 c0 28          	add    $0x28,%rax
   140002beb:	   |  |      48 39 d0             	cmp    %rdx,%rax
   140002bee:	   |  \----- 75 e8                	jne    140002bd8 <_FindPESectionExec+0x58> (File Offset: 0x21d8)
   140002bf0:	   \-------> 31 c0                	xor    %eax,%eax
   140002bf2:	             c3                   	ret
   140002bf3:	             66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   140002bfa:	             00 00 00 00 
   140002bfe:	             66 90                	xchg   %ax,%ax

0000000140002c00 <_GetPEImageBase> (File Offset: 0x2200):
   140002c00:	       48 8b 05 39 38 00 00 	mov    0x3839(%rip),%rax        # 140006440 <.refptr.__image_base__> (File Offset: 0x5a40)
   140002c07:	       31 d2                	xor    %edx,%edx
   140002c09:	       66 81 38 4d 5a       	cmpw   $0x5a4d,(%rax)
   140002c0e:	/----- 75 0f                	jne    140002c1f <_GetPEImageBase+0x1f> (File Offset: 0x221f)
   140002c10:	|      48 63 48 3c          	movslq 0x3c(%rax),%rcx
   140002c14:	|      48 01 c1             	add    %rax,%rcx
   140002c17:	|      81 39 50 45 00 00    	cmpl   $0x4550,(%rcx)
   140002c1d:	|  /-- 74 09                	je     140002c28 <_GetPEImageBase+0x28> (File Offset: 0x2228)
   140002c1f:	\--|-> 48 89 d0             	mov    %rdx,%rax
   140002c22:	   |   c3                   	ret
   140002c23:	   |   0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   140002c28:	   \-> 66 81 79 18 0b 02    	cmpw   $0x20b,0x18(%rcx)
   140002c2e:	       48 0f 44 d0          	cmove  %rax,%rdx
   140002c32:	       48 89 d0             	mov    %rdx,%rax
   140002c35:	       c3                   	ret
   140002c36:	       66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   140002c3d:	       00 00 00 

0000000140002c40 <_IsNonwritableInCurrentImage> (File Offset: 0x2240):
   140002c40:	          48 8b 15 f9 37 00 00 	mov    0x37f9(%rip),%rdx        # 140006440 <.refptr.__image_base__> (File Offset: 0x5a40)
   140002c47:	          31 c0                	xor    %eax,%eax
   140002c49:	          66 81 3a 4d 5a       	cmpw   $0x5a4d,(%rdx)
   140002c4e:	   /----- 75 10                	jne    140002c60 <_IsNonwritableInCurrentImage+0x20> (File Offset: 0x2260)
   140002c50:	   |      4c 63 42 3c          	movslq 0x3c(%rdx),%r8
   140002c54:	   |      49 01 d0             	add    %rdx,%r8
   140002c57:	   |      41 81 38 50 45 00 00 	cmpl   $0x4550,(%r8)
   140002c5e:	   |  /-- 74 08                	je     140002c68 <_IsNonwritableInCurrentImage+0x28> (File Offset: 0x2268)
   140002c60:	   >--|-> c3                   	ret
   140002c61:	   |  |   0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   140002c68:	   |  \-> 66 41 81 78 18 0b 02 	cmpw   $0x20b,0x18(%r8)
   140002c6f:	   +----- 75 ef                	jne    140002c60 <_IsNonwritableInCurrentImage+0x20> (File Offset: 0x2260)
   140002c71:	   |      45 0f b7 48 06       	movzwl 0x6(%r8),%r9d
   140002c76:	   |      48 29 d1             	sub    %rdx,%rcx
   140002c79:	   |      41 0f b7 50 14       	movzwl 0x14(%r8),%edx
   140002c7e:	   |      66 45 85 c9          	test   %r9w,%r9w
   140002c82:	   |      49 8d 54 10 18       	lea    0x18(%r8,%rdx,1),%rdx
   140002c87:	   \----- 74 d7                	je     140002c60 <_IsNonwritableInCurrentImage+0x20> (File Offset: 0x2260)
   140002c89:	          41 8d 41 ff          	lea    -0x1(%r9),%eax
   140002c8d:	          48 8d 04 80          	lea    (%rax,%rax,4),%rax
   140002c91:	          4c 8d 4c c2 28       	lea    0x28(%rdx,%rax,8),%r9
   140002c96:	          66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   140002c9d:	          00 00 00 
   140002ca0:	/-------> 44 8b 42 0c          	mov    0xc(%rdx),%r8d
   140002ca4:	|         4c 39 c1             	cmp    %r8,%rcx
   140002ca7:	|         4c 89 c0             	mov    %r8,%rax
   140002caa:	|     /-- 72 08                	jb     140002cb4 <_IsNonwritableInCurrentImage+0x74> (File Offset: 0x22b4)
   140002cac:	|     |   03 42 08             	add    0x8(%rdx),%eax
   140002caf:	|     |   48 39 c1             	cmp    %rax,%rcx
   140002cb2:	|  /--|-- 72 0c                	jb     140002cc0 <_IsNonwritableInCurrentImage+0x80> (File Offset: 0x22c0)
   140002cb4:	|  |  \-> 48 83 c2 28          	add    $0x28,%rdx
   140002cb8:	|  |      49 39 d1             	cmp    %rdx,%r9
   140002cbb:	\--|----- 75 e3                	jne    140002ca0 <_IsNonwritableInCurrentImage+0x60> (File Offset: 0x22a0)
   140002cbd:	   |      31 c0                	xor    %eax,%eax
   140002cbf:	   |      c3                   	ret
   140002cc0:	   \----> 8b 42 24             	mov    0x24(%rdx),%eax
   140002cc3:	          f7 d0                	not    %eax
   140002cc5:	          c1 e8 1f             	shr    $0x1f,%eax
   140002cc8:	          c3                   	ret
   140002cc9:	          0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000140002cd0 <__mingw_enum_import_library_names> (File Offset: 0x22d0):
   140002cd0:	          4c 8b 1d 69 37 00 00 	mov    0x3769(%rip),%r11        # 140006440 <.refptr.__image_base__> (File Offset: 0x5a40)
   140002cd7:	          45 31 c9             	xor    %r9d,%r9d
   140002cda:	          66 41 81 3b 4d 5a    	cmpw   $0x5a4d,(%r11)
   140002ce0:	   /----- 75 10                	jne    140002cf2 <__mingw_enum_import_library_names+0x22> (File Offset: 0x22f2)
   140002ce2:	   |      4d 63 43 3c          	movslq 0x3c(%r11),%r8
   140002ce6:	   |      4d 01 d8             	add    %r11,%r8
   140002ce9:	   |      41 81 38 50 45 00 00 	cmpl   $0x4550,(%r8)
   140002cf0:	   |  /-- 74 0e                	je     140002d00 <__mingw_enum_import_library_names+0x30> (File Offset: 0x2300)
   140002cf2:	   >--|-> 4c 89 c8             	mov    %r9,%rax
   140002cf5:	   |  |   c3                   	ret
   140002cf6:	   |  |   66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   140002cfd:	   |  |   00 00 00 
   140002d00:	   |  \-> 66 41 81 78 18 0b 02 	cmpw   $0x20b,0x18(%r8)
   140002d07:	   +----- 75 e9                	jne    140002cf2 <__mingw_enum_import_library_names+0x22> (File Offset: 0x22f2)
   140002d09:	   |      41 8b 80 90 00 00 00 	mov    0x90(%r8),%eax
   140002d10:	   |      85 c0                	test   %eax,%eax
   140002d12:	   +----- 74 de                	je     140002cf2 <__mingw_enum_import_library_names+0x22> (File Offset: 0x22f2)
   140002d14:	   |      45 0f b7 50 06       	movzwl 0x6(%r8),%r10d
   140002d19:	   |      41 0f b7 50 14       	movzwl 0x14(%r8),%edx
   140002d1e:	   |      66 45 85 d2          	test   %r10w,%r10w
   140002d22:	   |      49 8d 54 10 18       	lea    0x18(%r8,%rdx,1),%rdx
   140002d27:	   \----- 74 c9                	je     140002cf2 <__mingw_enum_import_library_names+0x22> (File Offset: 0x22f2)
   140002d29:	          45 8d 42 ff          	lea    -0x1(%r10),%r8d
   140002d2d:	          4f 8d 04 80          	lea    (%r8,%r8,4),%r8
   140002d31:	          4e 8d 54 c2 28       	lea    0x28(%rdx,%r8,8),%r10
   140002d36:	          66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   140002d3d:	          00 00 00 
   140002d40:	/-------> 44 8b 4a 0c          	mov    0xc(%rdx),%r9d
   140002d44:	|         4c 39 c8             	cmp    %r9,%rax
   140002d47:	|         4d 89 c8             	mov    %r9,%r8
   140002d4a:	|     /-- 72 09                	jb     140002d55 <__mingw_enum_import_library_names+0x85> (File Offset: 0x2355)
   140002d4c:	|     |   44 03 42 08          	add    0x8(%rdx),%r8d
   140002d50:	|     |   4c 39 c0             	cmp    %r8,%rax
   140002d53:	|  /--|-- 72 13                	jb     140002d68 <__mingw_enum_import_library_names+0x98> (File Offset: 0x2368)
   140002d55:	|  |  \-> 48 83 c2 28          	add    $0x28,%rdx
   140002d59:	|  |      4c 39 d2             	cmp    %r10,%rdx
   140002d5c:	\--|----- 75 e2                	jne    140002d40 <__mingw_enum_import_library_names+0x70> (File Offset: 0x2340)
   140002d5e:	/--|----> 45 31 c9             	xor    %r9d,%r9d
   140002d61:	|  |      4c 89 c8             	mov    %r9,%rax
   140002d64:	|  |      c3                   	ret
   140002d65:	|  |      0f 1f 00             	nopl   (%rax)
   140002d68:	|  \----> 4c 01 d8             	add    %r11,%rax
   140002d6b:	|     /-- eb 0a                	jmp    140002d77 <__mingw_enum_import_library_names+0xa7> (File Offset: 0x2377)
   140002d6d:	|     |   0f 1f 00             	nopl   (%rax)
   140002d70:	|  /--|-> 83 e9 01             	sub    $0x1,%ecx
   140002d73:	|  |  |   48 83 c0 14          	add    $0x14,%rax
   140002d77:	|  |  \-> 44 8b 40 04          	mov    0x4(%rax),%r8d
   140002d7b:	|  |      45 85 c0             	test   %r8d,%r8d
   140002d7e:	|  |  /-- 75 07                	jne    140002d87 <__mingw_enum_import_library_names+0xb7> (File Offset: 0x2387)
   140002d80:	|  |  |   8b 50 0c             	mov    0xc(%rax),%edx
   140002d83:	|  |  |   85 d2                	test   %edx,%edx
   140002d85:	\--|--|-- 74 d7                	je     140002d5e <__mingw_enum_import_library_names+0x8e> (File Offset: 0x235e)
   140002d87:	   |  \-> 85 c9                	test   %ecx,%ecx
   140002d89:	   \----- 7f e5                	jg     140002d70 <__mingw_enum_import_library_names+0xa0> (File Offset: 0x2370)
   140002d8b:	          44 8b 48 0c          	mov    0xc(%rax),%r9d
   140002d8f:	          4d 01 d9             	add    %r11,%r9
   140002d92:	          4c 89 c8             	mov    %r9,%rax
   140002d95:	          c3                   	ret
   140002d96:	          90                   	nop
   140002d97:	          90                   	nop
   140002d98:	          90                   	nop
   140002d99:	          90                   	nop
   140002d9a:	          90                   	nop
   140002d9b:	          90                   	nop
   140002d9c:	          90                   	nop
   140002d9d:	          90                   	nop
   140002d9e:	          90                   	nop
   140002d9f:	          90                   	nop

0000000140002da0 <_Unwind_Resume> (File Offset: 0x23a0):
   140002da0:	ff 25 ae 74 00 00    	jmp    *0x74ae(%rip)        # 14000a254 <__IAT_start__> (File Offset: 0x9854)
   140002da6:	90                   	nop
   140002da7:	90                   	nop
   140002da8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   140002daf:	00 

0000000140002db0 <___chkstk_ms> (File Offset: 0x23b0):
   140002db0:	       51                   	push   %rcx
   140002db1:	       50                   	push   %rax
   140002db2:	       48 3d 00 10 00 00    	cmp    $0x1000,%rax
   140002db8:	       48 8d 4c 24 18       	lea    0x18(%rsp),%rcx
   140002dbd:	/----- 72 19                	jb     140002dd8 <___chkstk_ms+0x28> (File Offset: 0x23d8)
   140002dbf:	|  /-> 48 81 e9 00 10 00 00 	sub    $0x1000,%rcx
   140002dc6:	|  |   48 83 09 00          	orq    $0x0,(%rcx)
   140002dca:	|  |   48 2d 00 10 00 00    	sub    $0x1000,%rax
   140002dd0:	|  |   48 3d 00 10 00 00    	cmp    $0x1000,%rax
   140002dd6:	|  \-- 77 e7                	ja     140002dbf <___chkstk_ms+0xf> (File Offset: 0x23bf)
   140002dd8:	\----> 48 29 c1             	sub    %rax,%rcx
   140002ddb:	       48 83 09 00          	orq    $0x0,(%rcx)
   140002ddf:	       58                   	pop    %rax
   140002de0:	       59                   	pop    %rcx
   140002de1:	       c3                   	ret
   140002de2:	       90                   	nop
   140002de3:	       90                   	nop
   140002de4:	       90                   	nop
   140002de5:	       90                   	nop
   140002de6:	       90                   	nop
   140002de7:	       90                   	nop
   140002de8:	       90                   	nop
   140002de9:	       90                   	nop
   140002dea:	       90                   	nop
   140002deb:	       90                   	nop
   140002dec:	       90                   	nop
   140002ded:	       90                   	nop
   140002dee:	       90                   	nop
   140002def:	       90                   	nop

0000000140002df0 <__p__fmode> (File Offset: 0x23f0):
   140002df0:	48 8b 05 89 36 00 00 	mov    0x3689(%rip),%rax        # 140006480 <.refptr.__imp__fmode> (File Offset: 0x5a80)
   140002df7:	48 8b 00             	mov    (%rax),%rax
   140002dfa:	c3                   	ret
   140002dfb:	90                   	nop
   140002dfc:	90                   	nop
   140002dfd:	90                   	nop
   140002dfe:	90                   	nop
   140002dff:	90                   	nop

0000000140002e00 <__p__commode> (File Offset: 0x2400):
   140002e00:	48 8b 05 59 36 00 00 	mov    0x3659(%rip),%rax        # 140006460 <.refptr.__imp__commode> (File Offset: 0x5a60)
   140002e07:	48 8b 00             	mov    (%rax),%rax
   140002e0a:	c3                   	ret
   140002e0b:	90                   	nop
   140002e0c:	90                   	nop
   140002e0d:	90                   	nop
   140002e0e:	90                   	nop
   140002e0f:	90                   	nop

0000000140002e10 <_get_invalid_parameter_handler> (File Offset: 0x2410):
   140002e10:	48 8b 05 59 63 00 00 	mov    0x6359(%rip),%rax        # 140009170 <handler> (File Offset: 0x8770)
   140002e17:	c3                   	ret
   140002e18:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   140002e1f:	00 

0000000140002e20 <_set_invalid_parameter_handler> (File Offset: 0x2420):
   140002e20:	48 89 c8             	mov    %rcx,%rax
   140002e23:	48 87 05 46 63 00 00 	xchg   %rax,0x6346(%rip)        # 140009170 <handler> (File Offset: 0x8770)
   140002e2a:	c3                   	ret
   140002e2b:	90                   	nop
   140002e2c:	90                   	nop
   140002e2d:	90                   	nop
   140002e2e:	90                   	nop
   140002e2f:	90                   	nop

0000000140002e30 <__acrt_iob_func> (File Offset: 0x2430):
   140002e30:	53                   	push   %rbx
   140002e31:	48 83 ec 20          	sub    $0x20,%rsp
   140002e35:	89 cb                	mov    %ecx,%ebx
   140002e37:	e8 24 00 00 00       	call   140002e60 <__iob_func> (File Offset: 0x2460)
   140002e3c:	89 d9                	mov    %ebx,%ecx
   140002e3e:	48 8d 14 49          	lea    (%rcx,%rcx,2),%rdx
   140002e42:	48 c1 e2 04          	shl    $0x4,%rdx
   140002e46:	48 01 d0             	add    %rdx,%rax
   140002e49:	48 83 c4 20          	add    $0x20,%rsp
   140002e4d:	5b                   	pop    %rbx
   140002e4e:	c3                   	ret
   140002e4f:	90                   	nop

0000000140002e50 <__C_specific_handler> (File Offset: 0x2450):
   140002e50:	ff 25 66 74 00 00    	jmp    *0x7466(%rip)        # 14000a2bc <__imp___C_specific_handler> (File Offset: 0x98bc)
   140002e56:	90                   	nop
   140002e57:	90                   	nop

0000000140002e58 <__getmainargs> (File Offset: 0x2458):
   140002e58:	ff 25 66 74 00 00    	jmp    *0x7466(%rip)        # 14000a2c4 <__imp___getmainargs> (File Offset: 0x98c4)
   140002e5e:	90                   	nop
   140002e5f:	90                   	nop

0000000140002e60 <__iob_func> (File Offset: 0x2460):
   140002e60:	ff 25 6e 74 00 00    	jmp    *0x746e(%rip)        # 14000a2d4 <__imp___iob_func> (File Offset: 0x98d4)
   140002e66:	90                   	nop
   140002e67:	90                   	nop

0000000140002e68 <__set_app_type> (File Offset: 0x2468):
   140002e68:	ff 25 6e 74 00 00    	jmp    *0x746e(%rip)        # 14000a2dc <__imp___set_app_type> (File Offset: 0x98dc)
   140002e6e:	90                   	nop
   140002e6f:	90                   	nop

0000000140002e70 <__setusermatherr> (File Offset: 0x2470):
   140002e70:	ff 25 6e 74 00 00    	jmp    *0x746e(%rip)        # 14000a2e4 <__imp___setusermatherr> (File Offset: 0x98e4)
   140002e76:	90                   	nop
   140002e77:	90                   	nop

0000000140002e78 <_amsg_exit> (File Offset: 0x2478):
   140002e78:	ff 25 6e 74 00 00    	jmp    *0x746e(%rip)        # 14000a2ec <__imp__amsg_exit> (File Offset: 0x98ec)
   140002e7e:	90                   	nop
   140002e7f:	90                   	nop

0000000140002e80 <_assert> (File Offset: 0x2480):
   140002e80:	ff 25 6e 74 00 00    	jmp    *0x746e(%rip)        # 14000a2f4 <__imp__assert> (File Offset: 0x98f4)
   140002e86:	90                   	nop
   140002e87:	90                   	nop

0000000140002e88 <_cexit> (File Offset: 0x2488):
   140002e88:	ff 25 6e 74 00 00    	jmp    *0x746e(%rip)        # 14000a2fc <__imp__cexit> (File Offset: 0x98fc)
   140002e8e:	90                   	nop
   140002e8f:	90                   	nop

0000000140002e90 <_initterm> (File Offset: 0x2490):
   140002e90:	ff 25 86 74 00 00    	jmp    *0x7486(%rip)        # 14000a31c <__imp__initterm> (File Offset: 0x991c)
   140002e96:	90                   	nop
   140002e97:	90                   	nop

0000000140002e98 <_onexit> (File Offset: 0x2498):
   140002e98:	ff 25 86 74 00 00    	jmp    *0x7486(%rip)        # 14000a324 <__imp__onexit> (File Offset: 0x9924)
   140002e9e:	90                   	nop
   140002e9f:	90                   	nop

0000000140002ea0 <abort> (File Offset: 0x24a0):
   140002ea0:	ff 25 86 74 00 00    	jmp    *0x7486(%rip)        # 14000a32c <__imp_abort> (File Offset: 0x992c)
   140002ea6:	90                   	nop
   140002ea7:	90                   	nop

0000000140002ea8 <calloc> (File Offset: 0x24a8):
   140002ea8:	ff 25 86 74 00 00    	jmp    *0x7486(%rip)        # 14000a334 <__imp_calloc> (File Offset: 0x9934)
   140002eae:	90                   	nop
   140002eaf:	90                   	nop

0000000140002eb0 <fprintf> (File Offset: 0x24b0):
   140002eb0:	ff 25 8e 74 00 00    	jmp    *0x748e(%rip)        # 14000a344 <__imp_fprintf> (File Offset: 0x9944)
   140002eb6:	90                   	nop
   140002eb7:	90                   	nop

0000000140002eb8 <free> (File Offset: 0x24b8):
   140002eb8:	ff 25 8e 74 00 00    	jmp    *0x748e(%rip)        # 14000a34c <__imp_free> (File Offset: 0x994c)
   140002ebe:	90                   	nop
   140002ebf:	90                   	nop

0000000140002ec0 <fwrite> (File Offset: 0x24c0):
   140002ec0:	ff 25 8e 74 00 00    	jmp    *0x748e(%rip)        # 14000a354 <__imp_fwrite> (File Offset: 0x9954)
   140002ec6:	90                   	nop
   140002ec7:	90                   	nop

0000000140002ec8 <malloc> (File Offset: 0x24c8):
   140002ec8:	ff 25 8e 74 00 00    	jmp    *0x748e(%rip)        # 14000a35c <__imp_malloc> (File Offset: 0x995c)
   140002ece:	90                   	nop
   140002ecf:	90                   	nop

0000000140002ed0 <memcpy> (File Offset: 0x24d0):
   140002ed0:	ff 25 8e 74 00 00    	jmp    *0x748e(%rip)        # 14000a364 <__imp_memcpy> (File Offset: 0x9964)
   140002ed6:	90                   	nop
   140002ed7:	90                   	nop

0000000140002ed8 <memmove> (File Offset: 0x24d8):
   140002ed8:	ff 25 8e 74 00 00    	jmp    *0x748e(%rip)        # 14000a36c <__imp_memmove> (File Offset: 0x996c)
   140002ede:	90                   	nop
   140002edf:	90                   	nop

0000000140002ee0 <rand> (File Offset: 0x24e0):
   140002ee0:	ff 25 8e 74 00 00    	jmp    *0x748e(%rip)        # 14000a374 <__imp_rand> (File Offset: 0x9974)
   140002ee6:	90                   	nop
   140002ee7:	90                   	nop

0000000140002ee8 <signal> (File Offset: 0x24e8):
   140002ee8:	ff 25 8e 74 00 00    	jmp    *0x748e(%rip)        # 14000a37c <__imp_signal> (File Offset: 0x997c)
   140002eee:	90                   	nop
   140002eef:	90                   	nop

0000000140002ef0 <strlen> (File Offset: 0x24f0):
   140002ef0:	ff 25 8e 74 00 00    	jmp    *0x748e(%rip)        # 14000a384 <__imp_strlen> (File Offset: 0x9984)
   140002ef6:	90                   	nop
   140002ef7:	90                   	nop

0000000140002ef8 <strncmp> (File Offset: 0x24f8):
   140002ef8:	ff 25 8e 74 00 00    	jmp    *0x748e(%rip)        # 14000a38c <__imp_strncmp> (File Offset: 0x998c)
   140002efe:	90                   	nop
   140002eff:	90                   	nop

0000000140002f00 <vfprintf> (File Offset: 0x2500):
   140002f00:	ff 25 8e 74 00 00    	jmp    *0x748e(%rip)        # 14000a394 <__imp_vfprintf> (File Offset: 0x9994)
   140002f06:	90                   	nop
   140002f07:	90                   	nop
   140002f08:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   140002f0f:	00 

0000000140002f10 <VirtualQuery> (File Offset: 0x2510):
   140002f10:	ff 25 96 73 00 00    	jmp    *0x7396(%rip)        # 14000a2ac <__imp_VirtualQuery> (File Offset: 0x98ac)
   140002f16:	90                   	nop
   140002f17:	90                   	nop

0000000140002f18 <VirtualProtect> (File Offset: 0x2518):
   140002f18:	ff 25 86 73 00 00    	jmp    *0x7386(%rip)        # 14000a2a4 <__imp_VirtualProtect> (File Offset: 0x98a4)
   140002f1e:	90                   	nop
   140002f1f:	90                   	nop

0000000140002f20 <TlsGetValue> (File Offset: 0x2520):
   140002f20:	ff 25 76 73 00 00    	jmp    *0x7376(%rip)        # 14000a29c <__imp_TlsGetValue> (File Offset: 0x989c)
   140002f26:	90                   	nop
   140002f27:	90                   	nop

0000000140002f28 <Sleep> (File Offset: 0x2528):
   140002f28:	ff 25 66 73 00 00    	jmp    *0x7366(%rip)        # 14000a294 <__imp_Sleep> (File Offset: 0x9894)
   140002f2e:	90                   	nop
   140002f2f:	90                   	nop

0000000140002f30 <SetUnhandledExceptionFilter> (File Offset: 0x2530):
   140002f30:	ff 25 56 73 00 00    	jmp    *0x7356(%rip)        # 14000a28c <__imp_SetUnhandledExceptionFilter> (File Offset: 0x988c)
   140002f36:	90                   	nop
   140002f37:	90                   	nop

0000000140002f38 <LeaveCriticalSection> (File Offset: 0x2538):
   140002f38:	ff 25 46 73 00 00    	jmp    *0x7346(%rip)        # 14000a284 <__imp_LeaveCriticalSection> (File Offset: 0x9884)
   140002f3e:	90                   	nop
   140002f3f:	90                   	nop

0000000140002f40 <InitializeCriticalSection> (File Offset: 0x2540):
   140002f40:	ff 25 36 73 00 00    	jmp    *0x7336(%rip)        # 14000a27c <__imp_InitializeCriticalSection> (File Offset: 0x987c)
   140002f46:	90                   	nop
   140002f47:	90                   	nop

0000000140002f48 <GetLastError> (File Offset: 0x2548):
   140002f48:	ff 25 26 73 00 00    	jmp    *0x7326(%rip)        # 14000a274 <__imp_GetLastError> (File Offset: 0x9874)
   140002f4e:	90                   	nop
   140002f4f:	90                   	nop

0000000140002f50 <EnterCriticalSection> (File Offset: 0x2550):
   140002f50:	ff 25 16 73 00 00    	jmp    *0x7316(%rip)        # 14000a26c <__imp_EnterCriticalSection> (File Offset: 0x986c)
   140002f56:	90                   	nop
   140002f57:	90                   	nop

0000000140002f58 <DeleteCriticalSection> (File Offset: 0x2558):
   140002f58:	ff 25 06 73 00 00    	jmp    *0x7306(%rip)        # 14000a264 <__imp_DeleteCriticalSection> (File Offset: 0x9864)
   140002f5e:	90                   	nop
   140002f5f:	90                   	nop

0000000140002f60 <_ZN12ins_reg_load4execER5state> (File Offset: 0x2560):
   140002f60:	55                   	push   %rbp
   140002f61:	48 89 e5             	mov    %rsp,%rbp
   140002f64:	48 83 ec 20          	sub    $0x20,%rsp
   140002f68:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002f6c:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140002f70:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140002f74:	48 8d 88 08 80 00 00 	lea    0x8008(%rax),%rcx
   140002f7b:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002f7f:	0f b6 40 08          	movzbl 0x8(%rax),%eax
   140002f83:	0f b6 c0             	movzbl %al,%eax
   140002f86:	48 98                	cltq
   140002f88:	48 05 0a 10 00 00    	add    $0x100a,%rax
   140002f8e:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   140002f95:	00 
   140002f96:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140002f9a:	48 01 d0             	add    %rdx,%rax
   140002f9d:	48 83 c0 08          	add    $0x8,%rax
   140002fa1:	48 89 c2             	mov    %rax,%rdx
   140002fa4:	e8 d7 1a 00 00       	call   140004a80 <_ZNSt5stackIySt5dequeIySaIyEEE4pushERKy> (File Offset: 0x4080)
   140002fa9:	90                   	nop
   140002faa:	48 83 c4 20          	add    $0x20,%rsp
   140002fae:	5d                   	pop    %rbp
   140002faf:	c3                   	ret

0000000140002fb0 <_ZN12ins_reg_loadC1Eh> (File Offset: 0x25b0):
   140002fb0:	55                   	push   %rbp
   140002fb1:	48 89 e5             	mov    %rsp,%rbp
   140002fb4:	48 83 ec 20          	sub    $0x20,%rsp
   140002fb8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002fbc:	89 d0                	mov    %edx,%eax
   140002fbe:	88 45 18             	mov    %al,0x18(%rbp)
   140002fc1:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002fc5:	48 89 c1             	mov    %rax,%rcx
   140002fc8:	e8 c3 00 00 00       	call   140003090 <_ZN3insC2Ev> (File Offset: 0x2690)
   140002fcd:	48 8d 15 1c 38 00 00 	lea    0x381c(%rip),%rdx        # 1400067f0 <_ZTV12ins_reg_load+0x10> (File Offset: 0x5df0)
   140002fd4:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002fd8:	48 89 10             	mov    %rdx,(%rax)
   140002fdb:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   140002fdf:	0f b6 45 18          	movzbl 0x18(%rbp),%eax
   140002fe3:	88 42 08             	mov    %al,0x8(%rdx)
   140002fe6:	90                   	nop
   140002fe7:	48 83 c4 20          	add    $0x20,%rsp
   140002feb:	5d                   	pop    %rbp
   140002fec:	c3                   	ret
   140002fed:	90                   	nop
   140002fee:	90                   	nop
   140002fef:	90                   	nop

0000000140002ff0 <_ZN13ins_reg_store4execER5state> (File Offset: 0x25f0):
   140002ff0:	55                   	push   %rbp
   140002ff1:	48 89 e5             	mov    %rsp,%rbp
   140002ff4:	48 83 ec 30          	sub    $0x30,%rsp
   140002ff8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002ffc:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003000:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003004:	48 05 08 80 00 00    	add    $0x8008,%rax
   14000300a:	48 89 c1             	mov    %rax,%rcx
   14000300d:	e8 0e 1a 00 00       	call   140004a20 <_ZNSt5stackIySt5dequeIySaIyEEE3topEv> (File Offset: 0x4020)
   140003012:	48 8b 00             	mov    (%rax),%rax
   140003015:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140003019:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000301d:	0f b6 40 08          	movzbl 0x8(%rax),%eax
   140003021:	0f b6 d0             	movzbl %al,%edx
   140003024:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003028:	48 63 d2             	movslq %edx,%rdx
   14000302b:	48 81 c2 0a 10 00 00 	add    $0x100a,%rdx
   140003032:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
   140003036:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
   14000303b:	90                   	nop
   14000303c:	48 83 c4 30          	add    $0x30,%rsp
   140003040:	5d                   	pop    %rbp
   140003041:	c3                   	ret
   140003042:	90                   	nop
   140003043:	90                   	nop
   140003044:	90                   	nop
   140003045:	90                   	nop
   140003046:	90                   	nop
   140003047:	90                   	nop
   140003048:	90                   	nop
   140003049:	90                   	nop
   14000304a:	90                   	nop
   14000304b:	90                   	nop
   14000304c:	90                   	nop
   14000304d:	90                   	nop
   14000304e:	90                   	nop
   14000304f:	90                   	nop

0000000140003050 <_ZN13ins_reg_storeC1Eh> (File Offset: 0x2650):
   140003050:	55                   	push   %rbp
   140003051:	48 89 e5             	mov    %rsp,%rbp
   140003054:	48 83 ec 20          	sub    $0x20,%rsp
   140003058:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000305c:	89 d0                	mov    %edx,%eax
   14000305e:	88 45 18             	mov    %al,0x18(%rbp)
   140003061:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003065:	48 89 c1             	mov    %rax,%rcx
   140003068:	e8 23 00 00 00       	call   140003090 <_ZN3insC2Ev> (File Offset: 0x2690)
   14000306d:	48 8d 15 9c 37 00 00 	lea    0x379c(%rip),%rdx        # 140006810 <_ZTV13ins_reg_store+0x10> (File Offset: 0x5e10)
   140003074:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003078:	48 89 10             	mov    %rdx,(%rax)
   14000307b:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   14000307f:	0f b6 45 18          	movzbl 0x18(%rbp),%eax
   140003083:	88 42 08             	mov    %al,0x8(%rdx)
   140003086:	90                   	nop
   140003087:	48 83 c4 20          	add    $0x20,%rsp
   14000308b:	5d                   	pop    %rbp
   14000308c:	c3                   	ret
   14000308d:	90                   	nop
   14000308e:	90                   	nop
   14000308f:	90                   	nop

0000000140003090 <_ZN3insC2Ev> (File Offset: 0x2690):
   140003090:	55                   	push   %rbp
   140003091:	48 89 e5             	mov    %rsp,%rbp
   140003094:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003098:	48 8d 15 91 37 00 00 	lea    0x3791(%rip),%rdx        # 140006830 <_ZTV3ins+0x10> (File Offset: 0x5e30)
   14000309f:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400030a3:	48 89 10             	mov    %rdx,(%rax)
   1400030a6:	90                   	nop
   1400030a7:	5d                   	pop    %rbp
   1400030a8:	c3                   	ret
   1400030a9:	90                   	nop
   1400030aa:	90                   	nop
   1400030ab:	90                   	nop
   1400030ac:	90                   	nop
   1400030ad:	90                   	nop
   1400030ae:	90                   	nop
   1400030af:	90                   	nop

00000001400030b0 <_ZN5stateC1Ev> (File Offset: 0x26b0):
   1400030b0:	55                   	push   %rbp
   1400030b1:	48 89 e5             	mov    %rsp,%rbp
   1400030b4:	48 83 ec 20          	sub    $0x20,%rsp
   1400030b8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400030bc:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400030c0:	48 05 08 80 00 00    	add    $0x8008,%rax
   1400030c6:	48 89 c1             	mov    %rax,%rcx
   1400030c9:	e8 e2 19 00 00       	call   140004ab0 <_ZNSt5stackIySt5dequeIySaIyEEEC1IS2_vEEv> (File Offset: 0x40b0)
   1400030ce:	90                   	nop
   1400030cf:	48 83 c4 20          	add    $0x20,%rsp
   1400030d3:	5d                   	pop    %rbp
   1400030d4:	c3                   	ret
   1400030d5:	90                   	nop
   1400030d6:	90                   	nop
   1400030d7:	90                   	nop
   1400030d8:	90                   	nop
   1400030d9:	90                   	nop
   1400030da:	90                   	nop
   1400030db:	90                   	nop
   1400030dc:	90                   	nop
   1400030dd:	90                   	nop
   1400030de:	90                   	nop
   1400030df:	90                   	nop

00000001400030e0 <_ZN5stateD1Ev> (File Offset: 0x26e0):
   1400030e0:	55                   	push   %rbp
   1400030e1:	48 89 e5             	mov    %rsp,%rbp
   1400030e4:	48 83 ec 20          	sub    $0x20,%rsp
   1400030e8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400030ec:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400030f0:	48 05 08 80 00 00    	add    $0x8008,%rax
   1400030f6:	48 89 c1             	mov    %rax,%rcx
   1400030f9:	e8 f2 19 00 00       	call   140004af0 <_ZNSt5stackIySt5dequeIySaIyEEED1Ev> (File Offset: 0x40f0)
   1400030fe:	90                   	nop
   1400030ff:	48 83 c4 20          	add    $0x20,%rsp
   140003103:	5d                   	pop    %rbp
   140003104:	c3                   	ret
   140003105:	90                   	nop
   140003106:	90                   	nop
   140003107:	90                   	nop
   140003108:	90                   	nop
   140003109:	90                   	nop
   14000310a:	90                   	nop
   14000310b:	90                   	nop
   14000310c:	90                   	nop
   14000310d:	90                   	nop
   14000310e:	90                   	nop
   14000310f:	90                   	nop

0000000140003110 <_ZN6ins_jz4execER5state> (File Offset: 0x2710):
   140003110:	    55                   	push   %rbp
   140003111:	    48 89 e5             	mov    %rsp,%rbp
   140003114:	    48 83 ec 30          	sub    $0x30,%rsp
   140003118:	    48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000311c:	    48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003120:	    48 8b 45 18          	mov    0x18(%rbp),%rax
   140003124:	    48 05 08 80 00 00    	add    $0x8008,%rax
   14000312a:	    48 89 c1             	mov    %rax,%rcx
   14000312d:	    e8 ee 18 00 00       	call   140004a20 <_ZNSt5stackIySt5dequeIySaIyEEE3topEv> (File Offset: 0x4020)
   140003132:	    48 8b 00             	mov    (%rax),%rax
   140003135:	    48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140003139:	    48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   14000313e:	/-- 75 0d                	jne    14000314d <_ZN6ins_jz4execER5state+0x3d> (File Offset: 0x274d)
   140003140:	|   48 8b 45 10          	mov    0x10(%rbp),%rax
   140003144:	|   8b 50 08             	mov    0x8(%rax),%edx
   140003147:	|   48 8b 45 18          	mov    0x18(%rbp),%rax
   14000314b:	|   89 10                	mov    %edx,(%rax)
   14000314d:	\-> 90                   	nop
   14000314e:	    48 83 c4 30          	add    $0x30,%rsp
   140003152:	    5d                   	pop    %rbp
   140003153:	    c3                   	ret
   140003154:	    90                   	nop
   140003155:	    90                   	nop
   140003156:	    90                   	nop
   140003157:	    90                   	nop
   140003158:	    90                   	nop
   140003159:	    90                   	nop
   14000315a:	    90                   	nop
   14000315b:	    90                   	nop
   14000315c:	    90                   	nop
   14000315d:	    90                   	nop
   14000315e:	    90                   	nop
   14000315f:	    90                   	nop

0000000140003160 <_ZN6ins_jz5patchEj> (File Offset: 0x2760):
   140003160:	55                   	push   %rbp
   140003161:	48 89 e5             	mov    %rsp,%rbp
   140003164:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003168:	89 55 18             	mov    %edx,0x18(%rbp)
   14000316b:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000316f:	8b 55 18             	mov    0x18(%rbp),%edx
   140003172:	89 50 08             	mov    %edx,0x8(%rax)
   140003175:	90                   	nop
   140003176:	5d                   	pop    %rbp
   140003177:	c3                   	ret
   140003178:	90                   	nop
   140003179:	90                   	nop
   14000317a:	90                   	nop
   14000317b:	90                   	nop
   14000317c:	90                   	nop
   14000317d:	90                   	nop
   14000317e:	90                   	nop
   14000317f:	90                   	nop

0000000140003180 <_ZN6ins_jzC1Ej> (File Offset: 0x2780):
   140003180:	55                   	push   %rbp
   140003181:	48 89 e5             	mov    %rsp,%rbp
   140003184:	48 83 ec 20          	sub    $0x20,%rsp
   140003188:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000318c:	89 55 18             	mov    %edx,0x18(%rbp)
   14000318f:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003193:	48 89 c1             	mov    %rax,%rcx
   140003196:	e8 f5 fe ff ff       	call   140003090 <_ZN3insC2Ev> (File Offset: 0x2690)
   14000319b:	48 8d 15 ae 36 00 00 	lea    0x36ae(%rip),%rdx        # 140006850 <_ZTV6ins_jz+0x10> (File Offset: 0x5e50)
   1400031a2:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400031a6:	48 89 10             	mov    %rdx,(%rax)
   1400031a9:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400031ad:	8b 55 18             	mov    0x18(%rbp),%edx
   1400031b0:	89 50 08             	mov    %edx,0x8(%rax)
   1400031b3:	90                   	nop
   1400031b4:	48 83 c4 20          	add    $0x20,%rsp
   1400031b8:	5d                   	pop    %rbp
   1400031b9:	c3                   	ret
   1400031ba:	90                   	nop
   1400031bb:	90                   	nop
   1400031bc:	90                   	nop
   1400031bd:	90                   	nop
   1400031be:	90                   	nop
   1400031bf:	90                   	nop

00000001400031c0 <_ZN7ins_add4execER5state> (File Offset: 0x27c0):
   1400031c0:	55                   	push   %rbp
   1400031c1:	48 89 e5             	mov    %rsp,%rbp
   1400031c4:	48 83 ec 30          	sub    $0x30,%rsp
   1400031c8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400031cc:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400031d0:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400031d4:	48 05 08 80 00 00    	add    $0x8008,%rax
   1400031da:	48 89 c1             	mov    %rax,%rcx
   1400031dd:	e8 3e 18 00 00       	call   140004a20 <_ZNSt5stackIySt5dequeIySaIyEEE3topEv> (File Offset: 0x4020)
   1400031e2:	48 8b 00             	mov    (%rax),%rax
   1400031e5:	89 45 fc             	mov    %eax,-0x4(%rbp)
   1400031e8:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400031ec:	48 05 08 80 00 00    	add    $0x8008,%rax
   1400031f2:	48 89 c1             	mov    %rax,%rcx
   1400031f5:	e8 06 18 00 00       	call   140004a00 <_ZNSt5stackIySt5dequeIySaIyEEE3popEv> (File Offset: 0x4000)
   1400031fa:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400031fe:	48 05 08 80 00 00    	add    $0x8008,%rax
   140003204:	48 89 c1             	mov    %rax,%rcx
   140003207:	e8 14 18 00 00       	call   140004a20 <_ZNSt5stackIySt5dequeIySaIyEEE3topEv> (File Offset: 0x4020)
   14000320c:	48 8b 00             	mov    (%rax),%rax
   14000320f:	89 45 f8             	mov    %eax,-0x8(%rbp)
   140003212:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003216:	48 05 08 80 00 00    	add    $0x8008,%rax
   14000321c:	48 89 c1             	mov    %rax,%rcx
   14000321f:	e8 dc 17 00 00       	call   140004a00 <_ZNSt5stackIySt5dequeIySaIyEEE3popEv> (File Offset: 0x4000)
   140003224:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003228:	48 8d 88 08 80 00 00 	lea    0x8008(%rax),%rcx
   14000322f:	8b 55 fc             	mov    -0x4(%rbp),%edx
   140003232:	8b 45 f8             	mov    -0x8(%rbp),%eax
   140003235:	01 d0                	add    %edx,%eax
   140003237:	89 c0                	mov    %eax,%eax
   140003239:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000323d:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   140003241:	48 89 c2             	mov    %rax,%rdx
   140003244:	e8 f7 17 00 00       	call   140004a40 <_ZNSt5stackIySt5dequeIySaIyEEE4pushEOy> (File Offset: 0x4040)
   140003249:	90                   	nop
   14000324a:	48 83 c4 30          	add    $0x30,%rsp
   14000324e:	5d                   	pop    %rbp
   14000324f:	c3                   	ret

0000000140003250 <_ZN7ins_addC1Ev> (File Offset: 0x2850):
   140003250:	55                   	push   %rbp
   140003251:	48 89 e5             	mov    %rsp,%rbp
   140003254:	48 83 ec 20          	sub    $0x20,%rsp
   140003258:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000325c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003260:	48 89 c1             	mov    %rax,%rcx
   140003263:	e8 28 fe ff ff       	call   140003090 <_ZN3insC2Ev> (File Offset: 0x2690)
   140003268:	48 8d 15 01 36 00 00 	lea    0x3601(%rip),%rdx        # 140006870 <_ZTV7ins_add+0x10> (File Offset: 0x5e70)
   14000326f:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003273:	48 89 10             	mov    %rdx,(%rax)
   140003276:	90                   	nop
   140003277:	48 83 c4 20          	add    $0x20,%rsp
   14000327b:	5d                   	pop    %rbp
   14000327c:	c3                   	ret
   14000327d:	90                   	nop
   14000327e:	90                   	nop
   14000327f:	90                   	nop

0000000140003280 <_ZN7ins_jmp4execER5state> (File Offset: 0x2880):
   140003280:	55                   	push   %rbp
   140003281:	48 89 e5             	mov    %rsp,%rbp
   140003284:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003288:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000328c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003290:	8b 50 08             	mov    0x8(%rax),%edx
   140003293:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003297:	89 10                	mov    %edx,(%rax)
   140003299:	90                   	nop
   14000329a:	5d                   	pop    %rbp
   14000329b:	c3                   	ret
   14000329c:	90                   	nop
   14000329d:	90                   	nop
   14000329e:	90                   	nop
   14000329f:	90                   	nop

00000001400032a0 <_ZN7ins_jmpC1Ej> (File Offset: 0x28a0):
   1400032a0:	55                   	push   %rbp
   1400032a1:	48 89 e5             	mov    %rsp,%rbp
   1400032a4:	48 83 ec 20          	sub    $0x20,%rsp
   1400032a8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400032ac:	89 55 18             	mov    %edx,0x18(%rbp)
   1400032af:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400032b3:	48 89 c1             	mov    %rax,%rcx
   1400032b6:	e8 d5 fd ff ff       	call   140003090 <_ZN3insC2Ev> (File Offset: 0x2690)
   1400032bb:	48 8d 15 ce 35 00 00 	lea    0x35ce(%rip),%rdx        # 140006890 <_ZTV7ins_jmp+0x10> (File Offset: 0x5e90)
   1400032c2:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400032c6:	48 89 10             	mov    %rdx,(%rax)
   1400032c9:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400032cd:	8b 55 18             	mov    0x18(%rbp),%edx
   1400032d0:	89 50 08             	mov    %edx,0x8(%rax)
   1400032d3:	90                   	nop
   1400032d4:	48 83 c4 20          	add    $0x20,%rsp
   1400032d8:	5d                   	pop    %rbp
   1400032d9:	c3                   	ret
   1400032da:	90                   	nop
   1400032db:	90                   	nop
   1400032dc:	90                   	nop
   1400032dd:	90                   	nop
   1400032de:	90                   	nop
   1400032df:	90                   	nop

00000001400032e0 <_ZN7ins_mul4execER5state> (File Offset: 0x28e0):
   1400032e0:	55                   	push   %rbp
   1400032e1:	48 89 e5             	mov    %rsp,%rbp
   1400032e4:	48 83 ec 30          	sub    $0x30,%rsp
   1400032e8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400032ec:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400032f0:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400032f4:	48 05 08 80 00 00    	add    $0x8008,%rax
   1400032fa:	48 89 c1             	mov    %rax,%rcx
   1400032fd:	e8 1e 17 00 00       	call   140004a20 <_ZNSt5stackIySt5dequeIySaIyEEE3topEv> (File Offset: 0x4020)
   140003302:	48 8b 00             	mov    (%rax),%rax
   140003305:	89 45 fc             	mov    %eax,-0x4(%rbp)
   140003308:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000330c:	48 05 08 80 00 00    	add    $0x8008,%rax
   140003312:	48 89 c1             	mov    %rax,%rcx
   140003315:	e8 e6 16 00 00       	call   140004a00 <_ZNSt5stackIySt5dequeIySaIyEEE3popEv> (File Offset: 0x4000)
   14000331a:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000331e:	48 05 08 80 00 00    	add    $0x8008,%rax
   140003324:	48 89 c1             	mov    %rax,%rcx
   140003327:	e8 f4 16 00 00       	call   140004a20 <_ZNSt5stackIySt5dequeIySaIyEEE3topEv> (File Offset: 0x4020)
   14000332c:	48 8b 00             	mov    (%rax),%rax
   14000332f:	89 45 f8             	mov    %eax,-0x8(%rbp)
   140003332:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003336:	48 05 08 80 00 00    	add    $0x8008,%rax
   14000333c:	48 89 c1             	mov    %rax,%rcx
   14000333f:	e8 bc 16 00 00       	call   140004a00 <_ZNSt5stackIySt5dequeIySaIyEEE3popEv> (File Offset: 0x4000)
   140003344:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003348:	48 8d 88 08 80 00 00 	lea    0x8008(%rax),%rcx
   14000334f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140003352:	0f af 45 f8          	imul   -0x8(%rbp),%eax
   140003356:	89 c0                	mov    %eax,%eax
   140003358:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000335c:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   140003360:	48 89 c2             	mov    %rax,%rdx
   140003363:	e8 d8 16 00 00       	call   140004a40 <_ZNSt5stackIySt5dequeIySaIyEEE4pushEOy> (File Offset: 0x4040)
   140003368:	90                   	nop
   140003369:	48 83 c4 30          	add    $0x30,%rsp
   14000336d:	5d                   	pop    %rbp
   14000336e:	c3                   	ret
   14000336f:	90                   	nop

0000000140003370 <_ZN7ins_mulC1Ev> (File Offset: 0x2970):
   140003370:	55                   	push   %rbp
   140003371:	48 89 e5             	mov    %rsp,%rbp
   140003374:	48 83 ec 20          	sub    $0x20,%rsp
   140003378:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000337c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003380:	48 89 c1             	mov    %rax,%rcx
   140003383:	e8 08 fd ff ff       	call   140003090 <_ZN3insC2Ev> (File Offset: 0x2690)
   140003388:	48 8d 15 21 35 00 00 	lea    0x3521(%rip),%rdx        # 1400068b0 <_ZTV7ins_mul+0x10> (File Offset: 0x5eb0)
   14000338f:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003393:	48 89 10             	mov    %rdx,(%rax)
   140003396:	90                   	nop
   140003397:	48 83 c4 20          	add    $0x20,%rsp
   14000339b:	5d                   	pop    %rbp
   14000339c:	c3                   	ret
   14000339d:	90                   	nop
   14000339e:	90                   	nop
   14000339f:	90                   	nop

00000001400033a0 <_ZN7ins_pop4execER5state> (File Offset: 0x29a0):
   1400033a0:	55                   	push   %rbp
   1400033a1:	48 89 e5             	mov    %rsp,%rbp
   1400033a4:	48 83 ec 20          	sub    $0x20,%rsp
   1400033a8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400033ac:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400033b0:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400033b4:	48 05 08 80 00 00    	add    $0x8008,%rax
   1400033ba:	48 89 c1             	mov    %rax,%rcx
   1400033bd:	e8 3e 16 00 00       	call   140004a00 <_ZNSt5stackIySt5dequeIySaIyEEE3popEv> (File Offset: 0x4000)
   1400033c2:	90                   	nop
   1400033c3:	48 83 c4 20          	add    $0x20,%rsp
   1400033c7:	5d                   	pop    %rbp
   1400033c8:	c3                   	ret
   1400033c9:	90                   	nop
   1400033ca:	90                   	nop
   1400033cb:	90                   	nop
   1400033cc:	90                   	nop
   1400033cd:	90                   	nop
   1400033ce:	90                   	nop
   1400033cf:	90                   	nop

00000001400033d0 <_ZN7ins_popC1Ev> (File Offset: 0x29d0):
   1400033d0:	55                   	push   %rbp
   1400033d1:	48 89 e5             	mov    %rsp,%rbp
   1400033d4:	48 83 ec 20          	sub    $0x20,%rsp
   1400033d8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400033dc:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400033e0:	48 89 c1             	mov    %rax,%rcx
   1400033e3:	e8 a8 fc ff ff       	call   140003090 <_ZN3insC2Ev> (File Offset: 0x2690)
   1400033e8:	48 8d 15 e1 34 00 00 	lea    0x34e1(%rip),%rdx        # 1400068d0 <_ZTV7ins_pop+0x10> (File Offset: 0x5ed0)
   1400033ef:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400033f3:	48 89 10             	mov    %rdx,(%rax)
   1400033f6:	90                   	nop
   1400033f7:	48 83 c4 20          	add    $0x20,%rsp
   1400033fb:	5d                   	pop    %rbp
   1400033fc:	c3                   	ret
   1400033fd:	90                   	nop
   1400033fe:	90                   	nop
   1400033ff:	90                   	nop

0000000140003400 <_ZN7ins_ret4execER5state> (File Offset: 0x2a00):
   140003400:	55                   	push   %rbp
   140003401:	48 89 e5             	mov    %rsp,%rbp
   140003404:	48 83 ec 20          	sub    $0x20,%rsp
   140003408:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000340c:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003410:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003414:	48 05 08 80 00 00    	add    $0x8008,%rax
   14000341a:	48 89 c1             	mov    %rax,%rcx
   14000341d:	e8 fe 15 00 00       	call   140004a20 <_ZNSt5stackIySt5dequeIySaIyEEE3topEv> (File Offset: 0x4020)
   140003422:	48 8b 00             	mov    (%rax),%rax
   140003425:	89 c2                	mov    %eax,%edx
   140003427:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000342b:	89 10                	mov    %edx,(%rax)
   14000342d:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003431:	48 05 08 80 00 00    	add    $0x8008,%rax
   140003437:	48 89 c1             	mov    %rax,%rcx
   14000343a:	e8 c1 15 00 00       	call   140004a00 <_ZNSt5stackIySt5dequeIySaIyEEE3popEv> (File Offset: 0x4000)
   14000343f:	90                   	nop
   140003440:	48 83 c4 20          	add    $0x20,%rsp
   140003444:	5d                   	pop    %rbp
   140003445:	c3                   	ret
   140003446:	90                   	nop
   140003447:	90                   	nop
   140003448:	90                   	nop
   140003449:	90                   	nop
   14000344a:	90                   	nop
   14000344b:	90                   	nop
   14000344c:	90                   	nop
   14000344d:	90                   	nop
   14000344e:	90                   	nop
   14000344f:	90                   	nop

0000000140003450 <_ZN7ins_retC1Ev> (File Offset: 0x2a50):
   140003450:	55                   	push   %rbp
   140003451:	48 89 e5             	mov    %rsp,%rbp
   140003454:	48 83 ec 20          	sub    $0x20,%rsp
   140003458:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000345c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003460:	48 89 c1             	mov    %rax,%rcx
   140003463:	e8 28 fc ff ff       	call   140003090 <_ZN3insC2Ev> (File Offset: 0x2690)
   140003468:	48 8d 15 81 34 00 00 	lea    0x3481(%rip),%rdx        # 1400068f0 <_ZTV7ins_ret+0x10> (File Offset: 0x5ef0)
   14000346f:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003473:	48 89 10             	mov    %rdx,(%rax)
   140003476:	90                   	nop
   140003477:	48 83 c4 20          	add    $0x20,%rsp
   14000347b:	5d                   	pop    %rbp
   14000347c:	c3                   	ret
   14000347d:	90                   	nop
   14000347e:	90                   	nop
   14000347f:	90                   	nop

0000000140003480 <_ZN8ins_call4execER5state> (File Offset: 0x2a80):
   140003480:	55                   	push   %rbp
   140003481:	48 89 e5             	mov    %rsp,%rbp
   140003484:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003488:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000348c:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003490:	8b 00                	mov    (%rax),%eax
   140003492:	89 c2                	mov    %eax,%edx
   140003494:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003498:	48 89 90 60 80 00 00 	mov    %rdx,0x8060(%rax)
   14000349f:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400034a3:	8b 50 08             	mov    0x8(%rax),%edx
   1400034a6:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400034aa:	89 10                	mov    %edx,(%rax)
   1400034ac:	90                   	nop
   1400034ad:	5d                   	pop    %rbp
   1400034ae:	c3                   	ret
   1400034af:	90                   	nop

00000001400034b0 <_ZN8ins_callC1Ej> (File Offset: 0x2ab0):
   1400034b0:	55                   	push   %rbp
   1400034b1:	48 89 e5             	mov    %rsp,%rbp
   1400034b4:	48 83 ec 20          	sub    $0x20,%rsp
   1400034b8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400034bc:	89 55 18             	mov    %edx,0x18(%rbp)
   1400034bf:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400034c3:	48 89 c1             	mov    %rax,%rcx
   1400034c6:	e8 c5 fb ff ff       	call   140003090 <_ZN3insC2Ev> (File Offset: 0x2690)
   1400034cb:	48 8d 15 3e 34 00 00 	lea    0x343e(%rip),%rdx        # 140006910 <_ZTV8ins_call+0x10> (File Offset: 0x5f10)
   1400034d2:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400034d6:	48 89 10             	mov    %rdx,(%rax)
   1400034d9:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400034dd:	8b 55 18             	mov    0x18(%rbp),%edx
   1400034e0:	89 50 08             	mov    %edx,0x8(%rax)
   1400034e3:	90                   	nop
   1400034e4:	48 83 c4 20          	add    $0x20,%rsp
   1400034e8:	5d                   	pop    %rbp
   1400034e9:	c3                   	ret
   1400034ea:	90                   	nop
   1400034eb:	90                   	nop
   1400034ec:	90                   	nop
   1400034ed:	90                   	nop
   1400034ee:	90                   	nop
   1400034ef:	90                   	nop

00000001400034f0 <_ZN8ins_exit4execER5state> (File Offset: 0x2af0):
   1400034f0:	55                   	push   %rbp
   1400034f1:	48 89 e5             	mov    %rsp,%rbp
   1400034f4:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400034f8:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400034fc:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003500:	c6 80 58 88 00 00 00 	movb   $0x0,0x8858(%rax)
   140003507:	90                   	nop
   140003508:	5d                   	pop    %rbp
   140003509:	c3                   	ret
   14000350a:	90                   	nop
   14000350b:	90                   	nop
   14000350c:	90                   	nop
   14000350d:	90                   	nop
   14000350e:	90                   	nop
   14000350f:	90                   	nop

0000000140003510 <_ZN8ins_exitC1Ev> (File Offset: 0x2b10):
   140003510:	55                   	push   %rbp
   140003511:	48 89 e5             	mov    %rsp,%rbp
   140003514:	48 83 ec 20          	sub    $0x20,%rsp
   140003518:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000351c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003520:	48 89 c1             	mov    %rax,%rcx
   140003523:	e8 68 fb ff ff       	call   140003090 <_ZN3insC2Ev> (File Offset: 0x2690)
   140003528:	48 8d 15 01 34 00 00 	lea    0x3401(%rip),%rdx        # 140006930 <_ZTV8ins_exit+0x10> (File Offset: 0x5f30)
   14000352f:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003533:	48 89 10             	mov    %rdx,(%rax)
   140003536:	90                   	nop
   140003537:	48 83 c4 20          	add    $0x20,%rsp
   14000353b:	5d                   	pop    %rbp
   14000353c:	c3                   	ret
   14000353d:	90                   	nop
   14000353e:	90                   	nop
   14000353f:	90                   	nop

0000000140003540 <_ZN8ins_push4execER5state> (File Offset: 0x2b40):
   140003540:	55                   	push   %rbp
   140003541:	48 89 e5             	mov    %rsp,%rbp
   140003544:	48 83 ec 30          	sub    $0x30,%rsp
   140003548:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000354c:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003550:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003554:	48 8d 88 08 80 00 00 	lea    0x8008(%rax),%rcx
   14000355b:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000355f:	8b 40 08             	mov    0x8(%rax),%eax
   140003562:	89 c0                	mov    %eax,%eax
   140003564:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140003568:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   14000356c:	48 89 c2             	mov    %rax,%rdx
   14000356f:	e8 cc 14 00 00       	call   140004a40 <_ZNSt5stackIySt5dequeIySaIyEEE4pushEOy> (File Offset: 0x4040)
   140003574:	90                   	nop
   140003575:	48 83 c4 30          	add    $0x30,%rsp
   140003579:	5d                   	pop    %rbp
   14000357a:	c3                   	ret
   14000357b:	90                   	nop
   14000357c:	90                   	nop
   14000357d:	90                   	nop
   14000357e:	90                   	nop
   14000357f:	90                   	nop

0000000140003580 <_ZN8ins_pushC1Ej> (File Offset: 0x2b80):
   140003580:	55                   	push   %rbp
   140003581:	48 89 e5             	mov    %rsp,%rbp
   140003584:	48 83 ec 20          	sub    $0x20,%rsp
   140003588:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000358c:	89 55 18             	mov    %edx,0x18(%rbp)
   14000358f:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003593:	48 89 c1             	mov    %rax,%rcx
   140003596:	e8 f5 fa ff ff       	call   140003090 <_ZN3insC2Ev> (File Offset: 0x2690)
   14000359b:	48 8d 15 ae 33 00 00 	lea    0x33ae(%rip),%rdx        # 140006950 <_ZTV8ins_push+0x10> (File Offset: 0x5f50)
   1400035a2:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400035a6:	48 89 10             	mov    %rdx,(%rax)
   1400035a9:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400035ad:	8b 55 18             	mov    0x18(%rbp),%edx
   1400035b0:	89 50 08             	mov    %edx,0x8(%rax)
   1400035b3:	90                   	nop
   1400035b4:	48 83 c4 20          	add    $0x20,%rsp
   1400035b8:	5d                   	pop    %rbp
   1400035b9:	c3                   	ret
   1400035ba:	90                   	nop
   1400035bb:	90                   	nop
   1400035bc:	90                   	nop
   1400035bd:	90                   	nop
   1400035be:	90                   	nop
   1400035bf:	90                   	nop

00000001400035c0 <_ZNKSt11_Deque_baseIySaIyEE19_M_get_Tp_allocatorEv> (File Offset: 0x2bc0):
   1400035c0:	55                   	push   %rbp
   1400035c1:	48 89 e5             	mov    %rsp,%rbp
   1400035c4:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400035c8:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400035cc:	5d                   	pop    %rbp
   1400035cd:	c3                   	ret
   1400035ce:	90                   	nop
   1400035cf:	90                   	nop

00000001400035d0 <_ZNKSt11_Deque_baseIySaIyEE20_M_get_map_allocatorEv> (File Offset: 0x2bd0):
   1400035d0:	55                   	push   %rbp
   1400035d1:	48 89 e5             	mov    %rsp,%rbp
   1400035d4:	48 83 ec 40          	sub    $0x40,%rsp
   1400035d8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400035dc:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400035e0:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400035e4:	48 89 c1             	mov    %rax,%rcx
   1400035e7:	e8 d4 ff ff ff       	call   1400035c0 <_ZNKSt11_Deque_baseIySaIyEE19_M_get_Tp_allocatorEv> (File Offset: 0x2bc0)
   1400035ec:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   1400035f0:	48 89 55 f8          	mov    %rdx,-0x8(%rbp)
   1400035f4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   1400035f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400035fc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   140003600:	90                   	nop
   140003601:	90                   	nop
   140003602:	90                   	nop
   140003603:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003607:	48 83 c4 40          	add    $0x40,%rsp
   14000360b:	5d                   	pop    %rbp
   14000360c:	c3                   	ret
   14000360d:	90                   	nop
   14000360e:	90                   	nop
   14000360f:	90                   	nop

0000000140003610 <_ZNKSt15_Deque_iteratorIyRyPyEdeEv> (File Offset: 0x2c10):
   140003610:	55                   	push   %rbp
   140003611:	48 89 e5             	mov    %rsp,%rbp
   140003614:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003618:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000361c:	48 8b 00             	mov    (%rax),%rax
   14000361f:	5d                   	pop    %rbp
   140003620:	c3                   	ret
   140003621:	90                   	nop
   140003622:	90                   	nop
   140003623:	90                   	nop
   140003624:	90                   	nop
   140003625:	90                   	nop
   140003626:	90                   	nop
   140003627:	90                   	nop
   140003628:	90                   	nop
   140003629:	90                   	nop
   14000362a:	90                   	nop
   14000362b:	90                   	nop
   14000362c:	90                   	nop
   14000362d:	90                   	nop
   14000362e:	90                   	nop
   14000362f:	90                   	nop

0000000140003630 <_ZNKSt5dequeIySaIyEE4sizeEv> (File Offset: 0x2c30):
   140003630:	55                   	push   %rbp
   140003631:	48 89 e5             	mov    %rsp,%rbp
   140003634:	48 83 ec 20          	sub    $0x20,%rsp
   140003638:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000363c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003640:	48 8d 50 10          	lea    0x10(%rax),%rdx
   140003644:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003648:	48 83 c0 30          	add    $0x30,%rax
   14000364c:	48 89 c1             	mov    %rax,%rcx
   14000364f:	e8 3c 18 00 00       	call   140004e90 <_ZStmiRKSt15_Deque_iteratorIyRyPyES4_> (File Offset: 0x4490)
   140003654:	48 83 c4 20          	add    $0x20,%rsp
   140003658:	5d                   	pop    %rbp
   140003659:	c3                   	ret
   14000365a:	90                   	nop
   14000365b:	90                   	nop
   14000365c:	90                   	nop
   14000365d:	90                   	nop
   14000365e:	90                   	nop
   14000365f:	90                   	nop

0000000140003660 <_ZNKSt5dequeIySaIyEE8max_sizeEv> (File Offset: 0x2c60):
   140003660:	55                   	push   %rbp
   140003661:	48 89 e5             	mov    %rsp,%rbp
   140003664:	48 83 ec 20          	sub    $0x20,%rsp
   140003668:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000366c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003670:	48 89 c1             	mov    %rax,%rcx
   140003673:	e8 48 ff ff ff       	call   1400035c0 <_ZNKSt11_Deque_baseIySaIyEE19_M_get_Tp_allocatorEv> (File Offset: 0x2bc0)
   140003678:	48 89 c1             	mov    %rax,%rcx
   14000367b:	e8 10 0a 00 00       	call   140004090 <_ZNSt5dequeIySaIyEE11_S_max_sizeERKS0_> (File Offset: 0x3690)
   140003680:	48 83 c4 20          	add    $0x20,%rsp
   140003684:	5d                   	pop    %rbp
   140003685:	c3                   	ret
   140003686:	90                   	nop
   140003687:	90                   	nop
   140003688:	90                   	nop
   140003689:	90                   	nop
   14000368a:	90                   	nop
   14000368b:	90                   	nop
   14000368c:	90                   	nop
   14000368d:	90                   	nop
   14000368e:	90                   	nop
   14000368f:	90                   	nop

0000000140003690 <_ZNSt11_Deque_baseIySaIyEE11_Deque_implC1Ev> (File Offset: 0x2c90):
   140003690:	55                   	push   %rbp
   140003691:	48 89 e5             	mov    %rsp,%rbp
   140003694:	48 83 ec 30          	sub    $0x30,%rsp
   140003698:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000369c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400036a0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   1400036a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400036a8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   1400036ac:	90                   	nop
   1400036ad:	90                   	nop
   1400036ae:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400036b2:	48 89 c1             	mov    %rax,%rcx
   1400036b5:	e8 56 01 00 00       	call   140003810 <_ZNSt11_Deque_baseIySaIyEE16_Deque_impl_dataC2Ev> (File Offset: 0x2e10)
   1400036ba:	90                   	nop
   1400036bb:	48 83 c4 30          	add    $0x30,%rsp
   1400036bf:	5d                   	pop    %rbp
   1400036c0:	c3                   	ret
   1400036c1:	90                   	nop
   1400036c2:	90                   	nop
   1400036c3:	90                   	nop
   1400036c4:	90                   	nop
   1400036c5:	90                   	nop
   1400036c6:	90                   	nop
   1400036c7:	90                   	nop
   1400036c8:	90                   	nop
   1400036c9:	90                   	nop
   1400036ca:	90                   	nop
   1400036cb:	90                   	nop
   1400036cc:	90                   	nop
   1400036cd:	90                   	nop
   1400036ce:	90                   	nop
   1400036cf:	90                   	nop

00000001400036d0 <_ZNSt11_Deque_baseIySaIyEE11_Deque_implD1Ev> (File Offset: 0x2cd0):
   1400036d0:	55                   	push   %rbp
   1400036d1:	48 89 e5             	mov    %rsp,%rbp
   1400036d4:	48 83 ec 30          	sub    $0x30,%rsp
   1400036d8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400036dc:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400036e0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   1400036e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400036e8:	48 89 c1             	mov    %rax,%rcx
   1400036eb:	e8 c0 08 00 00       	call   140003fb0 <_ZNSt15__new_allocatorIyED2Ev> (File Offset: 0x35b0)
   1400036f0:	90                   	nop
   1400036f1:	90                   	nop
   1400036f2:	48 83 c4 30          	add    $0x30,%rsp
   1400036f6:	5d                   	pop    %rbp
   1400036f7:	c3                   	ret
   1400036f8:	90                   	nop
   1400036f9:	90                   	nop
   1400036fa:	90                   	nop
   1400036fb:	90                   	nop
   1400036fc:	90                   	nop
   1400036fd:	90                   	nop
   1400036fe:	90                   	nop
   1400036ff:	90                   	nop

0000000140003700 <_ZNSt11_Deque_baseIySaIyEE15_M_allocate_mapEy> (File Offset: 0x2d00):
   140003700:	    55                   	push   %rbp
   140003701:	    53                   	push   %rbx
   140003702:	    48 83 ec 38          	sub    $0x38,%rsp
   140003706:	    48 8d 6c 24 30       	lea    0x30(%rsp),%rbp
   14000370b:	    48 89 4d 20          	mov    %rcx,0x20(%rbp)
   14000370f:	    48 89 55 28          	mov    %rdx,0x28(%rbp)
   140003713:	    48 8d 45 f7          	lea    -0x9(%rbp),%rax
   140003717:	    48 8b 55 20          	mov    0x20(%rbp),%rdx
   14000371b:	    48 89 c1             	mov    %rax,%rcx
   14000371e:	    e8 ad fe ff ff       	call   1400035d0 <_ZNKSt11_Deque_baseIySaIyEE20_M_get_map_allocatorEv> (File Offset: 0x2bd0)
   140003723:	    48 8b 45 28          	mov    0x28(%rbp),%rax
   140003727:	    48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000372b:	    48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   14000372f:	    48 8d 45 f7          	lea    -0x9(%rbp),%rax
   140003733:	    41 b8 00 00 00 00    	mov    $0x0,%r8d
   140003739:	    48 89 c1             	mov    %rax,%rcx
   14000373c:	    e8 3f 07 00 00       	call   140003e80 <_ZNSt15__new_allocatorIPyE8allocateEyPKv> (File Offset: 0x3480)
   140003741:	    48 89 c3             	mov    %rax,%rbx
   140003744:	    90                   	nop
   140003745:	    90                   	nop
   140003746:	    48 8d 45 f7          	lea    -0x9(%rbp),%rax
   14000374a:	    48 89 c1             	mov    %rax,%rcx
   14000374d:	    e8 9e 07 00 00       	call   140003ef0 <_ZNSt15__new_allocatorIPyED2Ev> (File Offset: 0x34f0)
   140003752:	    90                   	nop
   140003753:	    48 89 d8             	mov    %rbx,%rax
   140003756:	/-- eb 1b                	jmp    140003773 <_ZNSt11_Deque_baseIySaIyEE15_M_allocate_mapEy+0x73> (File Offset: 0x2d73)
   140003758:	|   48 89 c3             	mov    %rax,%rbx
   14000375b:	|   48 8d 45 f7          	lea    -0x9(%rbp),%rax
   14000375f:	|   48 89 c1             	mov    %rax,%rcx
   140003762:	|   e8 89 07 00 00       	call   140003ef0 <_ZNSt15__new_allocatorIPyED2Ev> (File Offset: 0x34f0)
   140003767:	|   90                   	nop
   140003768:	|   48 89 d8             	mov    %rbx,%rax
   14000376b:	|   48 89 c1             	mov    %rax,%rcx
   14000376e:	|   e8 2d f6 ff ff       	call   140002da0 <_Unwind_Resume> (File Offset: 0x23a0)
   140003773:	\-> 48 83 c4 38          	add    $0x38,%rsp
   140003777:	    5b                   	pop    %rbx
   140003778:	    5d                   	pop    %rbp
   140003779:	    c3                   	ret
   14000377a:	    90                   	nop
   14000377b:	    90                   	nop
   14000377c:	    90                   	nop
   14000377d:	    90                   	nop
   14000377e:	    90                   	nop
   14000377f:	    90                   	nop

0000000140003780 <_ZNSt11_Deque_baseIySaIyEE15_M_create_nodesEPPyS3_> (File Offset: 0x2d80):
   140003780:	       55                   	push   %rbp
   140003781:	       53                   	push   %rbx
   140003782:	       48 83 ec 38          	sub    $0x38,%rsp
   140003786:	       48 8d 6c 24 30       	lea    0x30(%rsp),%rbp
   14000378b:	       48 89 4d 20          	mov    %rcx,0x20(%rbp)
   14000378f:	       48 89 55 28          	mov    %rdx,0x28(%rbp)
   140003793:	       4c 89 45 30          	mov    %r8,0x30(%rbp)
   140003797:	       48 8b 45 28          	mov    0x28(%rbp),%rax
   14000379b:	       48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000379f:	   /-- eb 18                	jmp    1400037b9 <_ZNSt11_Deque_baseIySaIyEE15_M_create_nodesEPPyS3_+0x39> (File Offset: 0x2db9)
   1400037a1:	/--|-> 48 8b 45 20          	mov    0x20(%rbp),%rax
   1400037a5:	|  |   48 89 c1             	mov    %rax,%rcx
   1400037a8:	|  |   e8 b3 00 00 00       	call   140003860 <_ZNSt11_Deque_baseIySaIyEE16_M_allocate_nodeEv> (File Offset: 0x2e60)
   1400037ad:	|  |   48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   1400037b1:	|  |   48 89 02             	mov    %rax,(%rdx)
   1400037b4:	|  |   48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
   1400037b9:	|  \-> 48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400037bd:	|      48 3b 45 30          	cmp    0x30(%rbp),%rax
   1400037c1:	\----- 72 de                	jb     1400037a1 <_ZNSt11_Deque_baseIySaIyEE15_M_create_nodesEPPyS3_+0x21> (File Offset: 0x2da1)
   1400037c3:	   /-- eb 38                	jmp    1400037fd <_ZNSt11_Deque_baseIySaIyEE15_M_create_nodesEPPyS3_+0x7d> (File Offset: 0x2dfd)
   1400037c5:	   |   48 89 c1             	mov    %rax,%rcx
   1400037c8:	   |   e8 f3 e4 ff ff       	call   140001cc0 <__cxa_begin_catch> (File Offset: 0x12c0)
   1400037cd:	   |   48 8b 4d f8          	mov    -0x8(%rbp),%rcx
   1400037d1:	   |   48 8b 55 28          	mov    0x28(%rbp),%rdx
   1400037d5:	   |   48 8b 45 20          	mov    0x20(%rbp),%rax
   1400037d9:	   |   49 89 c8             	mov    %rcx,%r8
   1400037dc:	   |   48 89 c1             	mov    %rax,%rcx
   1400037df:	   |   e8 bc 00 00 00       	call   1400038a0 <_ZNSt11_Deque_baseIySaIyEE16_M_destroy_nodesEPPyS3_> (File Offset: 0x2ea0)
   1400037e4:	   |   e8 c7 e4 ff ff       	call   140001cb0 <__cxa_rethrow> (File Offset: 0x12b0)
   1400037e9:	   |   48 89 c3             	mov    %rax,%rbx
   1400037ec:	   |   e8 c7 e4 ff ff       	call   140001cb8 <__cxa_end_catch> (File Offset: 0x12b8)
   1400037f1:	   |   48 89 d8             	mov    %rbx,%rax
   1400037f4:	   |   48 89 c1             	mov    %rax,%rcx
   1400037f7:	   |   e8 a4 f5 ff ff       	call   140002da0 <_Unwind_Resume> (File Offset: 0x23a0)
   1400037fc:	   |   90                   	nop
   1400037fd:	   \-> 48 83 c4 38          	add    $0x38,%rsp
   140003801:	       5b                   	pop    %rbx
   140003802:	       5d                   	pop    %rbp
   140003803:	       c3                   	ret
   140003804:	       90                   	nop
   140003805:	       90                   	nop
   140003806:	       90                   	nop
   140003807:	       90                   	nop
   140003808:	       90                   	nop
   140003809:	       90                   	nop
   14000380a:	       90                   	nop
   14000380b:	       90                   	nop
   14000380c:	       90                   	nop
   14000380d:	       90                   	nop
   14000380e:	       90                   	nop
   14000380f:	       90                   	nop

0000000140003810 <_ZNSt11_Deque_baseIySaIyEE16_Deque_impl_dataC2Ev> (File Offset: 0x2e10):
   140003810:	55                   	push   %rbp
   140003811:	48 89 e5             	mov    %rsp,%rbp
   140003814:	48 83 ec 20          	sub    $0x20,%rsp
   140003818:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000381c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003820:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   140003827:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000382b:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   140003832:	00 
   140003833:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003837:	48 83 c0 10          	add    $0x10,%rax
   14000383b:	48 89 c1             	mov    %rax,%rcx
   14000383e:	e8 4d 05 00 00       	call   140003d90 <_ZNSt15_Deque_iteratorIyRyPyEC1Ev> (File Offset: 0x3390)
   140003843:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003847:	48 83 c0 30          	add    $0x30,%rax
   14000384b:	48 89 c1             	mov    %rax,%rcx
   14000384e:	e8 3d 05 00 00       	call   140003d90 <_ZNSt15_Deque_iteratorIyRyPyEC1Ev> (File Offset: 0x3390)
   140003853:	90                   	nop
   140003854:	48 83 c4 20          	add    $0x20,%rsp
   140003858:	5d                   	pop    %rbp
   140003859:	c3                   	ret
   14000385a:	90                   	nop
   14000385b:	90                   	nop
   14000385c:	90                   	nop
   14000385d:	90                   	nop
   14000385e:	90                   	nop
   14000385f:	90                   	nop

0000000140003860 <_ZNSt11_Deque_baseIySaIyEE16_M_allocate_nodeEv> (File Offset: 0x2e60):
   140003860:	55                   	push   %rbp
   140003861:	48 89 e5             	mov    %rsp,%rbp
   140003864:	48 83 ec 30          	sub    $0x30,%rsp
   140003868:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000386c:	b9 08 00 00 00       	mov    $0x8,%ecx
   140003871:	e8 1a 14 00 00       	call   140004c90 <_ZSt16__deque_buf_sizey> (File Offset: 0x4290)
   140003876:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   14000387a:	48 89 55 f8          	mov    %rdx,-0x8(%rbp)
   14000387e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140003882:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   140003886:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000388a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   140003890:	48 89 c1             	mov    %rax,%rcx
   140003893:	e8 a8 06 00 00       	call   140003f40 <_ZNSt15__new_allocatorIyE8allocateEyPKv> (File Offset: 0x3540)
   140003898:	90                   	nop
   140003899:	48 83 c4 30          	add    $0x30,%rsp
   14000389d:	5d                   	pop    %rbp
   14000389e:	c3                   	ret
   14000389f:	90                   	nop

00000001400038a0 <_ZNSt11_Deque_baseIySaIyEE16_M_destroy_nodesEPPyS3_> (File Offset: 0x2ea0):
   1400038a0:	       55                   	push   %rbp
   1400038a1:	       48 89 e5             	mov    %rsp,%rbp
   1400038a4:	       48 83 ec 30          	sub    $0x30,%rsp
   1400038a8:	       48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400038ac:	       48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400038b0:	       4c 89 45 20          	mov    %r8,0x20(%rbp)
   1400038b4:	       48 8b 45 18          	mov    0x18(%rbp),%rax
   1400038b8:	       48 89 45 f8          	mov    %rax,-0x8(%rbp)
   1400038bc:	   /-- eb 18                	jmp    1400038d6 <_ZNSt11_Deque_baseIySaIyEE16_M_destroy_nodesEPPyS3_+0x36> (File Offset: 0x2ed6)
   1400038be:	/--|-> 48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400038c2:	|  |   48 8b 10             	mov    (%rax),%rdx
   1400038c5:	|  |   48 8b 45 10          	mov    0x10(%rbp),%rax
   1400038c9:	|  |   48 89 c1             	mov    %rax,%rcx
   1400038cc:	|  |   e8 1f 02 00 00       	call   140003af0 <_ZNSt11_Deque_baseIySaIyEE18_M_deallocate_nodeEPy> (File Offset: 0x30f0)
   1400038d1:	|  |   48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
   1400038d6:	|  \-> 48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400038da:	|      48 3b 45 20          	cmp    0x20(%rbp),%rax
   1400038de:	\----- 72 de                	jb     1400038be <_ZNSt11_Deque_baseIySaIyEE16_M_destroy_nodesEPPyS3_+0x1e> (File Offset: 0x2ebe)
   1400038e0:	       90                   	nop
   1400038e1:	       90                   	nop
   1400038e2:	       48 83 c4 30          	add    $0x30,%rsp
   1400038e6:	       5d                   	pop    %rbp
   1400038e7:	       c3                   	ret
   1400038e8:	       90                   	nop
   1400038e9:	       90                   	nop
   1400038ea:	       90                   	nop
   1400038eb:	       90                   	nop
   1400038ec:	       90                   	nop
   1400038ed:	       90                   	nop
   1400038ee:	       90                   	nop
   1400038ef:	       90                   	nop

00000001400038f0 <_ZNSt11_Deque_baseIySaIyEE17_M_deallocate_mapEPPyy> (File Offset: 0x2ef0):
   1400038f0:	55                   	push   %rbp
   1400038f1:	48 89 e5             	mov    %rsp,%rbp
   1400038f4:	48 83 ec 40          	sub    $0x40,%rsp
   1400038f8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400038fc:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003900:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140003904:	48 8d 45 ef          	lea    -0x11(%rbp),%rax
   140003908:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   14000390c:	48 89 c1             	mov    %rax,%rcx
   14000390f:	e8 bc fc ff ff       	call   1400035d0 <_ZNKSt11_Deque_baseIySaIyEE20_M_get_map_allocatorEv> (File Offset: 0x2bd0)
   140003914:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003918:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000391c:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140003920:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140003924:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
   140003928:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   14000392c:	48 8d 45 ef          	lea    -0x11(%rbp),%rax
   140003930:	49 89 c8             	mov    %rcx,%r8
   140003933:	48 89 c1             	mov    %rax,%rcx
   140003936:	e8 05 05 00 00       	call   140003e40 <_ZNSt15__new_allocatorIPyE10deallocateEPS0_y> (File Offset: 0x3440)
   14000393b:	90                   	nop
   14000393c:	48 8d 45 ef          	lea    -0x11(%rbp),%rax
   140003940:	48 89 c1             	mov    %rax,%rcx
   140003943:	e8 a8 05 00 00       	call   140003ef0 <_ZNSt15__new_allocatorIPyED2Ev> (File Offset: 0x34f0)
   140003948:	90                   	nop
   140003949:	90                   	nop
   14000394a:	48 83 c4 40          	add    $0x40,%rsp
   14000394e:	5d                   	pop    %rbp
   14000394f:	c3                   	ret

0000000140003950 <_ZNSt11_Deque_baseIySaIyEE17_M_initialize_mapEy> (File Offset: 0x2f50):
   140003950:	    55                   	push   %rbp
   140003951:	    53                   	push   %rbx
   140003952:	    48 83 ec 58          	sub    $0x58,%rsp
   140003956:	    48 8d 6c 24 50       	lea    0x50(%rsp),%rbp
   14000395b:	    48 89 4d 20          	mov    %rcx,0x20(%rbp)
   14000395f:	    48 89 55 28          	mov    %rdx,0x28(%rbp)
   140003963:	    b9 08 00 00 00       	mov    $0x8,%ecx
   140003968:	    e8 23 13 00 00       	call   140004c90 <_ZSt16__deque_buf_sizey> (File Offset: 0x4290)
   14000396d:	    48 89 c3             	mov    %rax,%rbx
   140003970:	    48 8b 45 28          	mov    0x28(%rbp),%rax
   140003974:	    ba 00 00 00 00       	mov    $0x0,%edx
   140003979:	    48 f7 f3             	div    %rbx
   14000397c:	    48 83 c0 01          	add    $0x1,%rax
   140003980:	    48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140003984:	    48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140003988:	    48 83 c0 02          	add    $0x2,%rax
   14000398c:	    48 89 45 d8          	mov    %rax,-0x28(%rbp)
   140003990:	    48 c7 45 e0 08 00 00 	movq   $0x8,-0x20(%rbp)
   140003997:	    00 
   140003998:	    48 8d 55 d8          	lea    -0x28(%rbp),%rdx
   14000399c:	    48 8d 45 e0          	lea    -0x20(%rbp),%rax
   1400039a0:	    48 89 c1             	mov    %rax,%rcx
   1400039a3:	    e8 08 14 00 00       	call   140004db0 <_ZSt3maxIyERKT_S2_S2_> (File Offset: 0x43b0)
   1400039a8:	    48 8b 10             	mov    (%rax),%rdx
   1400039ab:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   1400039af:	    48 89 50 08          	mov    %rdx,0x8(%rax)
   1400039b3:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   1400039b7:	    48 8b 50 08          	mov    0x8(%rax),%rdx
   1400039bb:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   1400039bf:	    48 89 c1             	mov    %rax,%rcx
   1400039c2:	    e8 39 fd ff ff       	call   140003700 <_ZNSt11_Deque_baseIySaIyEE15_M_allocate_mapEy> (File Offset: 0x2d00)
   1400039c7:	    48 8b 55 20          	mov    0x20(%rbp),%rdx
   1400039cb:	    48 89 02             	mov    %rax,(%rdx)
   1400039ce:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   1400039d2:	    48 8b 10             	mov    (%rax),%rdx
   1400039d5:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   1400039d9:	    48 8b 40 08          	mov    0x8(%rax),%rax
   1400039dd:	    48 2b 45 f8          	sub    -0x8(%rbp),%rax
   1400039e1:	    48 d1 e8             	shr    %rax
   1400039e4:	    48 c1 e0 03          	shl    $0x3,%rax
   1400039e8:	    48 01 d0             	add    %rdx,%rax
   1400039eb:	    48 89 45 f0          	mov    %rax,-0x10(%rbp)
   1400039ef:	    48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400039f3:	    48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   1400039fa:	    00 
   1400039fb:	    48 8b 45 f0          	mov    -0x10(%rbp),%rax
   1400039ff:	    48 01 d0             	add    %rdx,%rax
   140003a02:	    48 89 45 e8          	mov    %rax,-0x18(%rbp)
   140003a06:	    48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   140003a0a:	    48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   140003a0e:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   140003a12:	    49 89 c8             	mov    %rcx,%r8
   140003a15:	    48 89 c1             	mov    %rax,%rcx
   140003a18:	    e8 63 fd ff ff       	call   140003780 <_ZNSt11_Deque_baseIySaIyEE15_M_create_nodesEPPyS3_> (File Offset: 0x2d80)
   140003a1d:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   140003a21:	    48 83 c0 10          	add    $0x10,%rax
   140003a25:	    48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   140003a29:	    48 89 c1             	mov    %rax,%rcx
   140003a2c:	    e8 8f 02 00 00       	call   140003cc0 <_ZNSt15_Deque_iteratorIyRyPyE11_M_set_nodeEPS1_> (File Offset: 0x32c0)
   140003a31:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   140003a35:	    48 83 c0 30          	add    $0x30,%rax
   140003a39:	    48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   140003a3d:	    48 83 ea 08          	sub    $0x8,%rdx
   140003a41:	    48 89 c1             	mov    %rax,%rcx
   140003a44:	    e8 77 02 00 00       	call   140003cc0 <_ZNSt15_Deque_iteratorIyRyPyE11_M_set_nodeEPS1_> (File Offset: 0x32c0)
   140003a49:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   140003a4d:	    48 8b 50 18          	mov    0x18(%rax),%rdx
   140003a51:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   140003a55:	    48 89 50 10          	mov    %rdx,0x10(%rax)
   140003a59:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   140003a5d:	    48 8b 58 38          	mov    0x38(%rax),%rbx
   140003a61:	    b9 08 00 00 00       	mov    $0x8,%ecx
   140003a66:	    e8 25 12 00 00       	call   140004c90 <_ZSt16__deque_buf_sizey> (File Offset: 0x4290)
   140003a6b:	    48 89 c1             	mov    %rax,%rcx
   140003a6e:	    48 8b 45 28          	mov    0x28(%rbp),%rax
   140003a72:	    ba 00 00 00 00       	mov    $0x0,%edx
   140003a77:	    48 f7 f1             	div    %rcx
   140003a7a:	    48 89 d1             	mov    %rdx,%rcx
   140003a7d:	    48 89 c8             	mov    %rcx,%rax
   140003a80:	    48 c1 e0 03          	shl    $0x3,%rax
   140003a84:	    48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   140003a88:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   140003a8c:	    48 89 50 30          	mov    %rdx,0x30(%rax)
   140003a90:	/-- eb 56                	jmp    140003ae8 <_ZNSt11_Deque_baseIySaIyEE17_M_initialize_mapEy+0x198> (File Offset: 0x30e8)
   140003a92:	|   48 89 c1             	mov    %rax,%rcx
   140003a95:	|   e8 26 e2 ff ff       	call   140001cc0 <__cxa_begin_catch> (File Offset: 0x12c0)
   140003a9a:	|   48 8b 45 20          	mov    0x20(%rbp),%rax
   140003a9e:	|   48 8b 48 08          	mov    0x8(%rax),%rcx
   140003aa2:	|   48 8b 45 20          	mov    0x20(%rbp),%rax
   140003aa6:	|   48 8b 10             	mov    (%rax),%rdx
   140003aa9:	|   48 8b 45 20          	mov    0x20(%rbp),%rax
   140003aad:	|   49 89 c8             	mov    %rcx,%r8
   140003ab0:	|   48 89 c1             	mov    %rax,%rcx
   140003ab3:	|   e8 38 fe ff ff       	call   1400038f0 <_ZNSt11_Deque_baseIySaIyEE17_M_deallocate_mapEPPyy> (File Offset: 0x2ef0)
   140003ab8:	|   48 8b 45 20          	mov    0x20(%rbp),%rax
   140003abc:	|   48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   140003ac3:	|   48 8b 45 20          	mov    0x20(%rbp),%rax
   140003ac7:	|   48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   140003ace:	|   00 
   140003acf:	|   e8 dc e1 ff ff       	call   140001cb0 <__cxa_rethrow> (File Offset: 0x12b0)
   140003ad4:	|   48 89 c3             	mov    %rax,%rbx
   140003ad7:	|   e8 dc e1 ff ff       	call   140001cb8 <__cxa_end_catch> (File Offset: 0x12b8)
   140003adc:	|   48 89 d8             	mov    %rbx,%rax
   140003adf:	|   48 89 c1             	mov    %rax,%rcx
   140003ae2:	|   e8 b9 f2 ff ff       	call   140002da0 <_Unwind_Resume> (File Offset: 0x23a0)
   140003ae7:	|   90                   	nop
   140003ae8:	\-> 48 83 c4 58          	add    $0x58,%rsp
   140003aec:	    5b                   	pop    %rbx
   140003aed:	    5d                   	pop    %rbp
   140003aee:	    c3                   	ret
   140003aef:	    90                   	nop

0000000140003af0 <_ZNSt11_Deque_baseIySaIyEE18_M_deallocate_nodeEPy> (File Offset: 0x30f0):
   140003af0:	55                   	push   %rbp
   140003af1:	48 89 e5             	mov    %rsp,%rbp
   140003af4:	48 83 ec 40          	sub    $0x40,%rsp
   140003af8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003afc:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003b00:	b9 08 00 00 00       	mov    $0x8,%ecx
   140003b05:	e8 86 11 00 00       	call   140004c90 <_ZSt16__deque_buf_sizey> (File Offset: 0x4290)
   140003b0a:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   140003b0e:	48 89 55 f8          	mov    %rdx,-0x8(%rbp)
   140003b12:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140003b16:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
   140003b1a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   140003b1e:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   140003b22:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   140003b26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140003b2a:	49 89 c8             	mov    %rcx,%r8
   140003b2d:	48 89 c1             	mov    %rax,%rcx
   140003b30:	e8 cb 03 00 00       	call   140003f00 <_ZNSt15__new_allocatorIyE10deallocateEPyy> (File Offset: 0x3500)
   140003b35:	90                   	nop
   140003b36:	90                   	nop
   140003b37:	48 83 c4 40          	add    $0x40,%rsp
   140003b3b:	5d                   	pop    %rbp
   140003b3c:	c3                   	ret
   140003b3d:	90                   	nop
   140003b3e:	90                   	nop
   140003b3f:	90                   	nop

0000000140003b40 <_ZNSt11_Deque_baseIySaIyEE19_M_get_Tp_allocatorEv> (File Offset: 0x3140):
   140003b40:	55                   	push   %rbp
   140003b41:	48 89 e5             	mov    %rsp,%rbp
   140003b44:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003b48:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003b4c:	5d                   	pop    %rbp
   140003b4d:	c3                   	ret
   140003b4e:	90                   	nop
   140003b4f:	90                   	nop

0000000140003b50 <_ZNSt11_Deque_baseIySaIyEEC2Ev> (File Offset: 0x3150):
   140003b50:	    55                   	push   %rbp
   140003b51:	    53                   	push   %rbx
   140003b52:	    48 83 ec 28          	sub    $0x28,%rsp
   140003b56:	    48 8d 6c 24 20       	lea    0x20(%rsp),%rbp
   140003b5b:	    48 89 4d 20          	mov    %rcx,0x20(%rbp)
   140003b5f:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   140003b63:	    48 89 c1             	mov    %rax,%rcx
   140003b66:	    e8 25 fb ff ff       	call   140003690 <_ZNSt11_Deque_baseIySaIyEE11_Deque_implC1Ev> (File Offset: 0x2c90)
   140003b6b:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   140003b6f:	    ba 00 00 00 00       	mov    $0x0,%edx
   140003b74:	    48 89 c1             	mov    %rax,%rcx
   140003b77:	    e8 d4 fd ff ff       	call   140003950 <_ZNSt11_Deque_baseIySaIyEE17_M_initialize_mapEy> (File Offset: 0x2f50)
   140003b7c:	/-- eb 1b                	jmp    140003b99 <_ZNSt11_Deque_baseIySaIyEEC2Ev+0x49> (File Offset: 0x3199)
   140003b7e:	|   48 89 c3             	mov    %rax,%rbx
   140003b81:	|   48 8b 45 20          	mov    0x20(%rbp),%rax
   140003b85:	|   48 89 c1             	mov    %rax,%rcx
   140003b88:	|   e8 43 fb ff ff       	call   1400036d0 <_ZNSt11_Deque_baseIySaIyEE11_Deque_implD1Ev> (File Offset: 0x2cd0)
   140003b8d:	|   48 89 d8             	mov    %rbx,%rax
   140003b90:	|   48 89 c1             	mov    %rax,%rcx
   140003b93:	|   e8 08 f2 ff ff       	call   140002da0 <_Unwind_Resume> (File Offset: 0x23a0)
   140003b98:	|   90                   	nop
   140003b99:	\-> 48 83 c4 28          	add    $0x28,%rsp
   140003b9d:	    5b                   	pop    %rbx
   140003b9e:	    5d                   	pop    %rbp
   140003b9f:	    c3                   	ret

0000000140003ba0 <_ZNSt11_Deque_baseIySaIyEED2Ev> (File Offset: 0x31a0):
   140003ba0:	    55                   	push   %rbp
   140003ba1:	    48 89 e5             	mov    %rsp,%rbp
   140003ba4:	    48 83 ec 20          	sub    $0x20,%rsp
   140003ba8:	    48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003bac:	    48 8b 45 10          	mov    0x10(%rbp),%rax
   140003bb0:	    48 8b 00             	mov    (%rax),%rax
   140003bb3:	    48 85 c0             	test   %rax,%rax
   140003bb6:	/-- 74 41                	je     140003bf9 <_ZNSt11_Deque_baseIySaIyEED2Ev+0x59> (File Offset: 0x31f9)
   140003bb8:	|   48 8b 45 10          	mov    0x10(%rbp),%rax
   140003bbc:	|   48 8b 40 48          	mov    0x48(%rax),%rax
   140003bc0:	|   48 8d 48 08          	lea    0x8(%rax),%rcx
   140003bc4:	|   48 8b 45 10          	mov    0x10(%rbp),%rax
   140003bc8:	|   48 8b 50 28          	mov    0x28(%rax),%rdx
   140003bcc:	|   48 8b 45 10          	mov    0x10(%rbp),%rax
   140003bd0:	|   49 89 c8             	mov    %rcx,%r8
   140003bd3:	|   48 89 c1             	mov    %rax,%rcx
   140003bd6:	|   e8 c5 fc ff ff       	call   1400038a0 <_ZNSt11_Deque_baseIySaIyEE16_M_destroy_nodesEPPyS3_> (File Offset: 0x2ea0)
   140003bdb:	|   48 8b 45 10          	mov    0x10(%rbp),%rax
   140003bdf:	|   48 8b 48 08          	mov    0x8(%rax),%rcx
   140003be3:	|   48 8b 45 10          	mov    0x10(%rbp),%rax
   140003be7:	|   48 8b 10             	mov    (%rax),%rdx
   140003bea:	|   48 8b 45 10          	mov    0x10(%rbp),%rax
   140003bee:	|   49 89 c8             	mov    %rcx,%r8
   140003bf1:	|   48 89 c1             	mov    %rax,%rcx
   140003bf4:	|   e8 f7 fc ff ff       	call   1400038f0 <_ZNSt11_Deque_baseIySaIyEE17_M_deallocate_mapEPPyy> (File Offset: 0x2ef0)
   140003bf9:	\-> 48 8b 45 10          	mov    0x10(%rbp),%rax
   140003bfd:	    48 89 c1             	mov    %rax,%rcx
   140003c00:	    e8 cb fa ff ff       	call   1400036d0 <_ZNSt11_Deque_baseIySaIyEE11_Deque_implD1Ev> (File Offset: 0x2cd0)
   140003c05:	    90                   	nop
   140003c06:	    48 83 c4 20          	add    $0x20,%rsp
   140003c0a:	    5d                   	pop    %rbp
   140003c0b:	    c3                   	ret
   140003c0c:	    90                   	nop
   140003c0d:	    90                   	nop
   140003c0e:	    90                   	nop
   140003c0f:	    90                   	nop

0000000140003c10 <_ZNSt11__copy_moveILb0ELb0ESt26random_access_iterator_tagE12__assign_oneIPyS3_EEvPT_PT0_> (File Offset: 0x3210):
   140003c10:	55                   	push   %rbp
   140003c11:	48 89 e5             	mov    %rsp,%rbp
   140003c14:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003c18:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003c1c:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003c20:	48 8b 10             	mov    (%rax),%rdx
   140003c23:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003c27:	48 89 10             	mov    %rdx,(%rax)
   140003c2a:	90                   	nop
   140003c2b:	5d                   	pop    %rbp
   140003c2c:	c3                   	ret
   140003c2d:	90                   	nop
   140003c2e:	90                   	nop
   140003c2f:	90                   	nop

0000000140003c30 <_ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mIPyS3_EEPT0_PT_S7_S5_> (File Offset: 0x3230):
   140003c30:	       55                   	push   %rbp
   140003c31:	       48 89 e5             	mov    %rsp,%rbp
   140003c34:	       48 83 ec 30          	sub    $0x30,%rsp
   140003c38:	       48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003c3c:	       48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003c40:	       4c 89 45 20          	mov    %r8,0x20(%rbp)
   140003c44:	       48 8b 45 18          	mov    0x18(%rbp),%rax
   140003c48:	       48 2b 45 10          	sub    0x10(%rbp),%rax
   140003c4c:	       48 c1 f8 03          	sar    $0x3,%rax
   140003c50:	       48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140003c54:	       48 83 7d f8 01       	cmpq   $0x1,-0x8(%rbp)
   140003c59:	       0f 9f c0             	setg   %al
   140003c5c:	       0f b6 c0             	movzbl %al,%eax
   140003c5f:	       85 c0                	test   %eax,%eax
   140003c61:	/----- 74 21                	je     140003c84 <_ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mIPyS3_EEPT0_PT_S7_S5_+0x54> (File Offset: 0x3284)
   140003c63:	|      48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140003c67:	|      48 8d 0c c5 00 00 00 	lea    0x0(,%rax,8),%rcx
   140003c6e:	|      00 
   140003c6f:	|      48 8b 55 10          	mov    0x10(%rbp),%rdx
   140003c73:	|      48 8b 45 20          	mov    0x20(%rbp),%rax
   140003c77:	|      49 89 c8             	mov    %rcx,%r8
   140003c7a:	|      48 89 c1             	mov    %rax,%rcx
   140003c7d:	|      e8 56 f2 ff ff       	call   140002ed8 <memmove> (File Offset: 0x24d8)
   140003c82:	|  /-- eb 17                	jmp    140003c9b <_ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mIPyS3_EEPT0_PT_S7_S5_+0x6b> (File Offset: 0x329b)
   140003c84:	\--|-> 48 83 7d f8 01       	cmpq   $0x1,-0x8(%rbp)
   140003c89:	   +-- 75 10                	jne    140003c9b <_ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mIPyS3_EEPT0_PT_S7_S5_+0x6b> (File Offset: 0x329b)
   140003c8b:	   |   48 8b 55 10          	mov    0x10(%rbp),%rdx
   140003c8f:	   |   48 8b 45 20          	mov    0x20(%rbp),%rax
   140003c93:	   |   48 89 c1             	mov    %rax,%rcx
   140003c96:	   |   e8 75 ff ff ff       	call   140003c10 <_ZNSt11__copy_moveILb0ELb0ESt26random_access_iterator_tagE12__assign_oneIPyS3_EEvPT_PT0_> (File Offset: 0x3210)
   140003c9b:	   \-> 48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140003c9f:	       48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   140003ca6:	       00 
   140003ca7:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   140003cab:	       48 01 d0             	add    %rdx,%rax
   140003cae:	       48 83 c4 30          	add    $0x30,%rsp
   140003cb2:	       5d                   	pop    %rbp
   140003cb3:	       c3                   	ret
   140003cb4:	       90                   	nop
   140003cb5:	       90                   	nop
   140003cb6:	       90                   	nop
   140003cb7:	       90                   	nop
   140003cb8:	       90                   	nop
   140003cb9:	       90                   	nop
   140003cba:	       90                   	nop
   140003cbb:	       90                   	nop
   140003cbc:	       90                   	nop
   140003cbd:	       90                   	nop
   140003cbe:	       90                   	nop
   140003cbf:	       90                   	nop

0000000140003cc0 <_ZNSt15_Deque_iteratorIyRyPyE11_M_set_nodeEPS1_> (File Offset: 0x32c0):
   140003cc0:	55                   	push   %rbp
   140003cc1:	53                   	push   %rbx
   140003cc2:	48 83 ec 28          	sub    $0x28,%rsp
   140003cc6:	48 8d 6c 24 20       	lea    0x20(%rsp),%rbp
   140003ccb:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   140003ccf:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   140003cd3:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140003cd7:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   140003cdb:	48 89 50 18          	mov    %rdx,0x18(%rax)
   140003cdf:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140003ce3:	48 8b 10             	mov    (%rax),%rdx
   140003ce6:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140003cea:	48 89 50 08          	mov    %rdx,0x8(%rax)
   140003cee:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140003cf2:	48 8b 58 08          	mov    0x8(%rax),%rbx
   140003cf6:	e8 25 00 00 00       	call   140003d20 <_ZNSt15_Deque_iteratorIyRyPyE14_S_buffer_sizeEv> (File Offset: 0x3320)
   140003cfb:	48 c1 e0 03          	shl    $0x3,%rax
   140003cff:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   140003d03:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140003d07:	48 89 50 10          	mov    %rdx,0x10(%rax)
   140003d0b:	90                   	nop
   140003d0c:	48 83 c4 28          	add    $0x28,%rsp
   140003d10:	5b                   	pop    %rbx
   140003d11:	5d                   	pop    %rbp
   140003d12:	c3                   	ret
   140003d13:	90                   	nop
   140003d14:	90                   	nop
   140003d15:	90                   	nop
   140003d16:	90                   	nop
   140003d17:	90                   	nop
   140003d18:	90                   	nop
   140003d19:	90                   	nop
   140003d1a:	90                   	nop
   140003d1b:	90                   	nop
   140003d1c:	90                   	nop
   140003d1d:	90                   	nop
   140003d1e:	90                   	nop
   140003d1f:	90                   	nop

0000000140003d20 <_ZNSt15_Deque_iteratorIyRyPyE14_S_buffer_sizeEv> (File Offset: 0x3320):
   140003d20:	55                   	push   %rbp
   140003d21:	48 89 e5             	mov    %rsp,%rbp
   140003d24:	48 83 ec 20          	sub    $0x20,%rsp
   140003d28:	b9 08 00 00 00       	mov    $0x8,%ecx
   140003d2d:	e8 5e 0f 00 00       	call   140004c90 <_ZSt16__deque_buf_sizey> (File Offset: 0x4290)
   140003d32:	48 83 c4 20          	add    $0x20,%rsp
   140003d36:	5d                   	pop    %rbp
   140003d37:	c3                   	ret
   140003d38:	90                   	nop
   140003d39:	90                   	nop
   140003d3a:	90                   	nop
   140003d3b:	90                   	nop
   140003d3c:	90                   	nop
   140003d3d:	90                   	nop
   140003d3e:	90                   	nop
   140003d3f:	90                   	nop

0000000140003d40 <_ZNSt15_Deque_iteratorIyRyPyEC1ERKS2_> (File Offset: 0x3340):
   140003d40:	55                   	push   %rbp
   140003d41:	48 89 e5             	mov    %rsp,%rbp
   140003d44:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003d48:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003d4c:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003d50:	48 8b 10             	mov    (%rax),%rdx
   140003d53:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003d57:	48 89 10             	mov    %rdx,(%rax)
   140003d5a:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003d5e:	48 8b 50 08          	mov    0x8(%rax),%rdx
   140003d62:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003d66:	48 89 50 08          	mov    %rdx,0x8(%rax)
   140003d6a:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003d6e:	48 8b 50 10          	mov    0x10(%rax),%rdx
   140003d72:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003d76:	48 89 50 10          	mov    %rdx,0x10(%rax)
   140003d7a:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003d7e:	48 8b 50 18          	mov    0x18(%rax),%rdx
   140003d82:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003d86:	48 89 50 18          	mov    %rdx,0x18(%rax)
   140003d8a:	90                   	nop
   140003d8b:	5d                   	pop    %rbp
   140003d8c:	c3                   	ret
   140003d8d:	90                   	nop
   140003d8e:	90                   	nop
   140003d8f:	90                   	nop

0000000140003d90 <_ZNSt15_Deque_iteratorIyRyPyEC1Ev> (File Offset: 0x3390):
   140003d90:	55                   	push   %rbp
   140003d91:	48 89 e5             	mov    %rsp,%rbp
   140003d94:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003d98:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003d9c:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   140003da3:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003da7:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   140003dae:	00 
   140003daf:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003db3:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
   140003dba:	00 
   140003dbb:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003dbf:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
   140003dc6:	00 
   140003dc7:	90                   	nop
   140003dc8:	5d                   	pop    %rbp
   140003dc9:	c3                   	ret
   140003dca:	90                   	nop
   140003dcb:	90                   	nop
   140003dcc:	90                   	nop
   140003dcd:	90                   	nop
   140003dce:	90                   	nop
   140003dcf:	90                   	nop

0000000140003dd0 <_ZNSt15_Deque_iteratorIyRyPyEmmEv> (File Offset: 0x33d0):
   140003dd0:	    55                   	push   %rbp
   140003dd1:	    48 89 e5             	mov    %rsp,%rbp
   140003dd4:	    48 83 ec 20          	sub    $0x20,%rsp
   140003dd8:	    48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003ddc:	    48 8b 45 10          	mov    0x10(%rbp),%rax
   140003de0:	    48 8b 10             	mov    (%rax),%rdx
   140003de3:	    48 8b 45 10          	mov    0x10(%rbp),%rax
   140003de7:	    48 8b 40 08          	mov    0x8(%rax),%rax
   140003deb:	    48 39 c2             	cmp    %rax,%rdx
   140003dee:	/-- 75 27                	jne    140003e17 <_ZNSt15_Deque_iteratorIyRyPyEmmEv+0x47> (File Offset: 0x3417)
   140003df0:	|   48 8b 45 10          	mov    0x10(%rbp),%rax
   140003df4:	|   48 8b 40 18          	mov    0x18(%rax),%rax
   140003df8:	|   48 8d 50 f8          	lea    -0x8(%rax),%rdx
   140003dfc:	|   48 8b 45 10          	mov    0x10(%rbp),%rax
   140003e00:	|   48 89 c1             	mov    %rax,%rcx
   140003e03:	|   e8 b8 fe ff ff       	call   140003cc0 <_ZNSt15_Deque_iteratorIyRyPyE11_M_set_nodeEPS1_> (File Offset: 0x32c0)
   140003e08:	|   48 8b 45 10          	mov    0x10(%rbp),%rax
   140003e0c:	|   48 8b 50 10          	mov    0x10(%rax),%rdx
   140003e10:	|   48 8b 45 10          	mov    0x10(%rbp),%rax
   140003e14:	|   48 89 10             	mov    %rdx,(%rax)
   140003e17:	\-> 48 8b 45 10          	mov    0x10(%rbp),%rax
   140003e1b:	    48 8b 00             	mov    (%rax),%rax
   140003e1e:	    48 8d 50 f8          	lea    -0x8(%rax),%rdx
   140003e22:	    48 8b 45 10          	mov    0x10(%rbp),%rax
   140003e26:	    48 89 10             	mov    %rdx,(%rax)
   140003e29:	    48 8b 45 10          	mov    0x10(%rbp),%rax
   140003e2d:	    48 83 c4 20          	add    $0x20,%rsp
   140003e31:	    5d                   	pop    %rbp
   140003e32:	    c3                   	ret
   140003e33:	    90                   	nop
   140003e34:	    90                   	nop
   140003e35:	    90                   	nop
   140003e36:	    90                   	nop
   140003e37:	    90                   	nop
   140003e38:	    90                   	nop
   140003e39:	    90                   	nop
   140003e3a:	    90                   	nop
   140003e3b:	    90                   	nop
   140003e3c:	    90                   	nop
   140003e3d:	    90                   	nop
   140003e3e:	    90                   	nop
   140003e3f:	    90                   	nop

0000000140003e40 <_ZNSt15__new_allocatorIPyE10deallocateEPS0_y> (File Offset: 0x3440):
   140003e40:	55                   	push   %rbp
   140003e41:	48 89 e5             	mov    %rsp,%rbp
   140003e44:	48 83 ec 20          	sub    $0x20,%rsp
   140003e48:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003e4c:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003e50:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140003e54:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140003e58:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   140003e5f:	00 
   140003e60:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003e64:	48 89 c1             	mov    %rax,%rcx
   140003e67:	e8 64 de ff ff       	call   140001cd0 <_ZdlPvy> (File Offset: 0x12d0)
   140003e6c:	90                   	nop
   140003e6d:	48 83 c4 20          	add    $0x20,%rsp
   140003e71:	5d                   	pop    %rbp
   140003e72:	c3                   	ret
   140003e73:	90                   	nop
   140003e74:	90                   	nop
   140003e75:	90                   	nop
   140003e76:	90                   	nop
   140003e77:	90                   	nop
   140003e78:	90                   	nop
   140003e79:	90                   	nop
   140003e7a:	90                   	nop
   140003e7b:	90                   	nop
   140003e7c:	90                   	nop
   140003e7d:	90                   	nop
   140003e7e:	90                   	nop
   140003e7f:	90                   	nop

0000000140003e80 <_ZNSt15__new_allocatorIPyE8allocateEyPKv> (File Offset: 0x3480):
   140003e80:	       55                   	push   %rbp
   140003e81:	       48 89 e5             	mov    %rsp,%rbp
   140003e84:	       48 83 ec 30          	sub    $0x30,%rsp
   140003e88:	       48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003e8c:	       48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003e90:	       4c 89 45 20          	mov    %r8,0x20(%rbp)
   140003e94:	       48 8b 45 10          	mov    0x10(%rbp),%rax
   140003e98:	       48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140003e9c:	       48 b8 ff ff ff ff ff 	movabs $0xfffffffffffffff,%rax
   140003ea3:	       ff ff 0f 
   140003ea6:	       48 3b 45 18          	cmp    0x18(%rbp),%rax
   140003eaa:	       0f 92 c0             	setb   %al
   140003ead:	       0f b6 c0             	movzbl %al,%eax
   140003eb0:	       85 c0                	test   %eax,%eax
   140003eb2:	       0f 95 c0             	setne  %al
   140003eb5:	       84 c0                	test   %al,%al
   140003eb7:	/----- 74 1a                	je     140003ed3 <_ZNSt15__new_allocatorIPyE8allocateEyPKv+0x53> (File Offset: 0x34d3)
   140003eb9:	|      48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
   140003ec0:	|      ff ff 1f 
   140003ec3:	|      48 3b 45 18          	cmp    0x18(%rbp),%rax
   140003ec7:	|  /-- 73 05                	jae    140003ece <_ZNSt15__new_allocatorIPyE8allocateEyPKv+0x4e> (File Offset: 0x34ce)
   140003ec9:	|  |   e8 1a de ff ff       	call   140001ce8 <_ZSt28__throw_bad_array_new_lengthv> (File Offset: 0x12e8)
   140003ece:	|  \-> e8 25 de ff ff       	call   140001cf8 <_ZSt17__throw_bad_allocv> (File Offset: 0x12f8)
   140003ed3:	\----> 48 8b 45 18          	mov    0x18(%rbp),%rax
   140003ed7:	       48 c1 e0 03          	shl    $0x3,%rax
   140003edb:	       48 89 c1             	mov    %rax,%rcx
   140003ede:	       e8 e5 dd ff ff       	call   140001cc8 <_Znwy> (File Offset: 0x12c8)
   140003ee3:	       90                   	nop
   140003ee4:	       48 83 c4 30          	add    $0x30,%rsp
   140003ee8:	       5d                   	pop    %rbp
   140003ee9:	       c3                   	ret
   140003eea:	       90                   	nop
   140003eeb:	       90                   	nop
   140003eec:	       90                   	nop
   140003eed:	       90                   	nop
   140003eee:	       90                   	nop
   140003eef:	       90                   	nop

0000000140003ef0 <_ZNSt15__new_allocatorIPyED2Ev> (File Offset: 0x34f0):
   140003ef0:	55                   	push   %rbp
   140003ef1:	48 89 e5             	mov    %rsp,%rbp
   140003ef4:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003ef8:	90                   	nop
   140003ef9:	5d                   	pop    %rbp
   140003efa:	c3                   	ret
   140003efb:	90                   	nop
   140003efc:	90                   	nop
   140003efd:	90                   	nop
   140003efe:	90                   	nop
   140003eff:	90                   	nop

0000000140003f00 <_ZNSt15__new_allocatorIyE10deallocateEPyy> (File Offset: 0x3500):
   140003f00:	55                   	push   %rbp
   140003f01:	48 89 e5             	mov    %rsp,%rbp
   140003f04:	48 83 ec 20          	sub    $0x20,%rsp
   140003f08:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003f0c:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003f10:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140003f14:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140003f18:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   140003f1f:	00 
   140003f20:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003f24:	48 89 c1             	mov    %rax,%rcx
   140003f27:	e8 a4 dd ff ff       	call   140001cd0 <_ZdlPvy> (File Offset: 0x12d0)
   140003f2c:	90                   	nop
   140003f2d:	48 83 c4 20          	add    $0x20,%rsp
   140003f31:	5d                   	pop    %rbp
   140003f32:	c3                   	ret
   140003f33:	90                   	nop
   140003f34:	90                   	nop
   140003f35:	90                   	nop
   140003f36:	90                   	nop
   140003f37:	90                   	nop
   140003f38:	90                   	nop
   140003f39:	90                   	nop
   140003f3a:	90                   	nop
   140003f3b:	90                   	nop
   140003f3c:	90                   	nop
   140003f3d:	90                   	nop
   140003f3e:	90                   	nop
   140003f3f:	90                   	nop

0000000140003f40 <_ZNSt15__new_allocatorIyE8allocateEyPKv> (File Offset: 0x3540):
   140003f40:	       55                   	push   %rbp
   140003f41:	       48 89 e5             	mov    %rsp,%rbp
   140003f44:	       48 83 ec 30          	sub    $0x30,%rsp
   140003f48:	       48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003f4c:	       48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003f50:	       4c 89 45 20          	mov    %r8,0x20(%rbp)
   140003f54:	       48 8b 45 10          	mov    0x10(%rbp),%rax
   140003f58:	       48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140003f5c:	       48 b8 ff ff ff ff ff 	movabs $0xfffffffffffffff,%rax
   140003f63:	       ff ff 0f 
   140003f66:	       48 3b 45 18          	cmp    0x18(%rbp),%rax
   140003f6a:	       0f 92 c0             	setb   %al
   140003f6d:	       0f b6 c0             	movzbl %al,%eax
   140003f70:	       85 c0                	test   %eax,%eax
   140003f72:	       0f 95 c0             	setne  %al
   140003f75:	       84 c0                	test   %al,%al
   140003f77:	/----- 74 1a                	je     140003f93 <_ZNSt15__new_allocatorIyE8allocateEyPKv+0x53> (File Offset: 0x3593)
   140003f79:	|      48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
   140003f80:	|      ff ff 1f 
   140003f83:	|      48 3b 45 18          	cmp    0x18(%rbp),%rax
   140003f87:	|  /-- 73 05                	jae    140003f8e <_ZNSt15__new_allocatorIyE8allocateEyPKv+0x4e> (File Offset: 0x358e)
   140003f89:	|  |   e8 5a dd ff ff       	call   140001ce8 <_ZSt28__throw_bad_array_new_lengthv> (File Offset: 0x12e8)
   140003f8e:	|  \-> e8 65 dd ff ff       	call   140001cf8 <_ZSt17__throw_bad_allocv> (File Offset: 0x12f8)
   140003f93:	\----> 48 8b 45 18          	mov    0x18(%rbp),%rax
   140003f97:	       48 c1 e0 03          	shl    $0x3,%rax
   140003f9b:	       48 89 c1             	mov    %rax,%rcx
   140003f9e:	       e8 25 dd ff ff       	call   140001cc8 <_Znwy> (File Offset: 0x12c8)
   140003fa3:	       90                   	nop
   140003fa4:	       48 83 c4 30          	add    $0x30,%rsp
   140003fa8:	       5d                   	pop    %rbp
   140003fa9:	       c3                   	ret
   140003faa:	       90                   	nop
   140003fab:	       90                   	nop
   140003fac:	       90                   	nop
   140003fad:	       90                   	nop
   140003fae:	       90                   	nop
   140003faf:	       90                   	nop

0000000140003fb0 <_ZNSt15__new_allocatorIyED2Ev> (File Offset: 0x35b0):
   140003fb0:	55                   	push   %rbp
   140003fb1:	48 89 e5             	mov    %rsp,%rbp
   140003fb4:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003fb8:	90                   	nop
   140003fb9:	5d                   	pop    %rbp
   140003fba:	c3                   	ret
   140003fbb:	90                   	nop
   140003fbc:	90                   	nop
   140003fbd:	90                   	nop
   140003fbe:	90                   	nop
   140003fbf:	90                   	nop

0000000140003fc0 <_ZNSt20__copy_move_backwardILb0ELb1ESt26random_access_iterator_tagE13__copy_move_bIPyS3_EEPT0_PT_S7_S5_> (File Offset: 0x35c0):
   140003fc0:	       55                   	push   %rbp
   140003fc1:	       48 89 e5             	mov    %rsp,%rbp
   140003fc4:	       48 83 ec 30          	sub    $0x30,%rsp
   140003fc8:	       48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003fcc:	       48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003fd0:	       4c 89 45 20          	mov    %r8,0x20(%rbp)
   140003fd4:	       48 8b 45 18          	mov    0x18(%rbp),%rax
   140003fd8:	       48 2b 45 10          	sub    0x10(%rbp),%rax
   140003fdc:	       48 c1 f8 03          	sar    $0x3,%rax
   140003fe0:	       48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140003fe4:	       48 83 7d f8 01       	cmpq   $0x1,-0x8(%rbp)
   140003fe9:	       0f 9f c0             	setg   %al
   140003fec:	       0f b6 c0             	movzbl %al,%eax
   140003fef:	       85 c0                	test   %eax,%eax
   140003ff1:	/----- 74 32                	je     140004025 <_ZNSt20__copy_move_backwardILb0ELb1ESt26random_access_iterator_tagE13__copy_move_bIPyS3_EEPT0_PT_S7_S5_+0x65> (File Offset: 0x3625)
   140003ff3:	|      48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140003ff7:	|      48 8d 0c c5 00 00 00 	lea    0x0(,%rax,8),%rcx
   140003ffe:	|      00 
   140003fff:	|      48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140004003:	|      48 c1 e0 03          	shl    $0x3,%rax
   140004007:	|      48 f7 d8             	neg    %rax
   14000400a:	|      48 89 c2             	mov    %rax,%rdx
   14000400d:	|      48 8b 45 20          	mov    0x20(%rbp),%rax
   140004011:	|      48 01 d0             	add    %rdx,%rax
   140004014:	|      48 8b 55 10          	mov    0x10(%rbp),%rdx
   140004018:	|      49 89 c8             	mov    %rcx,%r8
   14000401b:	|      48 89 c1             	mov    %rax,%rcx
   14000401e:	|      e8 b5 ee ff ff       	call   140002ed8 <memmove> (File Offset: 0x24d8)
   140004023:	|  /-- eb 1b                	jmp    140004040 <_ZNSt20__copy_move_backwardILb0ELb1ESt26random_access_iterator_tagE13__copy_move_bIPyS3_EEPT0_PT_S7_S5_+0x80> (File Offset: 0x3640)
   140004025:	\--|-> 48 83 7d f8 01       	cmpq   $0x1,-0x8(%rbp)
   14000402a:	   +-- 75 14                	jne    140004040 <_ZNSt20__copy_move_backwardILb0ELb1ESt26random_access_iterator_tagE13__copy_move_bIPyS3_EEPT0_PT_S7_S5_+0x80> (File Offset: 0x3640)
   14000402c:	   |   48 8b 45 20          	mov    0x20(%rbp),%rax
   140004030:	   |   48 83 e8 08          	sub    $0x8,%rax
   140004034:	   |   48 8b 55 10          	mov    0x10(%rbp),%rdx
   140004038:	   |   48 89 c1             	mov    %rax,%rcx
   14000403b:	   |   e8 d0 fb ff ff       	call   140003c10 <_ZNSt11__copy_moveILb0ELb0ESt26random_access_iterator_tagE12__assign_oneIPyS3_EEvPT_PT0_> (File Offset: 0x3210)
   140004040:	   \-> 48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140004044:	       48 c1 e0 03          	shl    $0x3,%rax
   140004048:	       48 f7 d8             	neg    %rax
   14000404b:	       48 89 c2             	mov    %rax,%rdx
   14000404e:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   140004052:	       48 01 d0             	add    %rdx,%rax
   140004055:	       48 83 c4 30          	add    $0x30,%rsp
   140004059:	       5d                   	pop    %rbp
   14000405a:	       c3                   	ret
   14000405b:	       90                   	nop
   14000405c:	       90                   	nop
   14000405d:	       90                   	nop
   14000405e:	       90                   	nop
   14000405f:	       90                   	nop

0000000140004060 <_ZNSt5arrayIP3insLy4096EEixEy> (File Offset: 0x3660):
   140004060:	55                   	push   %rbp
   140004061:	48 89 e5             	mov    %rsp,%rbp
   140004064:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140004068:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000406c:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140004070:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   140004077:	00 
   140004078:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000407c:	48 01 d0             	add    %rdx,%rax
   14000407f:	5d                   	pop    %rbp
   140004080:	c3                   	ret
   140004081:	90                   	nop
   140004082:	90                   	nop
   140004083:	90                   	nop
   140004084:	90                   	nop
   140004085:	90                   	nop
   140004086:	90                   	nop
   140004087:	90                   	nop
   140004088:	90                   	nop
   140004089:	90                   	nop
   14000408a:	90                   	nop
   14000408b:	90                   	nop
   14000408c:	90                   	nop
   14000408d:	90                   	nop
   14000408e:	90                   	nop
   14000408f:	90                   	nop

0000000140004090 <_ZNSt5dequeIySaIyEE11_S_max_sizeERKS0_> (File Offset: 0x3690):
   140004090:	55                   	push   %rbp
   140004091:	48 89 e5             	mov    %rsp,%rbp
   140004094:	48 83 ec 50          	sub    $0x50,%rsp
   140004098:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000409c:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
   1400040a3:	ff ff 7f 
   1400040a6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   1400040aa:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400040ae:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   1400040b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400040b6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   1400040ba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   1400040be:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   1400040c2:	48 b8 ff ff ff ff ff 	movabs $0xfffffffffffffff,%rax
   1400040c9:	ff ff 0f 
   1400040cc:	90                   	nop
   1400040cd:	90                   	nop
   1400040ce:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   1400040d2:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
   1400040d6:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   1400040da:	48 89 c1             	mov    %rax,%rcx
   1400040dd:	e8 fe 0c 00 00       	call   140004de0 <_ZSt3minIyERKT_S2_S2_> (File Offset: 0x43e0)
   1400040e2:	48 8b 00             	mov    (%rax),%rax
   1400040e5:	48 83 c4 50          	add    $0x50,%rsp
   1400040e9:	5d                   	pop    %rbp
   1400040ea:	c3                   	ret
   1400040eb:	90                   	nop
   1400040ec:	90                   	nop
   1400040ed:	90                   	nop
   1400040ee:	90                   	nop
   1400040ef:	90                   	nop

00000001400040f0 <_ZNSt5dequeIySaIyEE12emplace_backIJyEEERyDpOT_> (File Offset: 0x36f0):
   1400040f0:	       55                   	push   %rbp
   1400040f1:	       53                   	push   %rbx
   1400040f2:	       48 83 ec 58          	sub    $0x58,%rsp
   1400040f6:	       48 8d 6c 24 50       	lea    0x50(%rsp),%rbp
   1400040fb:	       48 89 4d 20          	mov    %rcx,0x20(%rbp)
   1400040ff:	       48 89 55 28          	mov    %rdx,0x28(%rbp)
   140004103:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   140004107:	       48 8b 50 30          	mov    0x30(%rax),%rdx
   14000410b:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   14000410f:	       48 8b 40 40          	mov    0x40(%rax),%rax
   140004113:	       48 83 e8 08          	sub    $0x8,%rax
   140004117:	       48 39 c2             	cmp    %rax,%rdx
   14000411a:	/----- 0f 84 82 00 00 00    	je     1400041a2 <_ZNSt5dequeIySaIyEE12emplace_backIJyEEERyDpOT_+0xb2> (File Offset: 0x37a2)
   140004120:	|      48 8b 45 28          	mov    0x28(%rbp),%rax
   140004124:	|      48 89 c1             	mov    %rax,%rcx
   140004127:	|      e8 54 0d 00 00       	call   140004e80 <_ZSt7forwardIyEOT_RNSt16remove_referenceIS0_E4typeE> (File Offset: 0x4480)
   14000412c:	|      48 8b 55 20          	mov    0x20(%rbp),%rdx
   140004130:	|      48 8b 52 30          	mov    0x30(%rdx),%rdx
   140004134:	|      48 8b 4d 20          	mov    0x20(%rbp),%rcx
   140004138:	|      48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   14000413c:	|      48 89 55 f0          	mov    %rdx,-0x10(%rbp)
   140004140:	|      48 89 45 e8          	mov    %rax,-0x18(%rbp)
   140004144:	|      48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140004148:	|      48 89 c1             	mov    %rax,%rcx
   14000414b:	|      e8 30 0d 00 00       	call   140004e80 <_ZSt7forwardIyEOT_RNSt16remove_referenceIS0_E4typeE> (File Offset: 0x4480)
   140004150:	|      48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140004154:	|      48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   140004158:	|      48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   14000415c:	|      48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   140004160:	|      48 89 45 d0          	mov    %rax,-0x30(%rbp)
   140004164:	|      48 8b 45 d8          	mov    -0x28(%rbp),%rax
   140004168:	|      48 89 c2             	mov    %rax,%rdx
   14000416b:	|      b9 08 00 00 00       	mov    $0x8,%ecx
   140004170:	|      e8 ab 0d 00 00       	call   140004f20 <_ZnwyPv> (File Offset: 0x4520)
   140004175:	|      48 89 c3             	mov    %rax,%rbx
   140004178:	|      48 8b 45 d0          	mov    -0x30(%rbp),%rax
   14000417c:	|      48 89 c1             	mov    %rax,%rcx
   14000417f:	|      e8 fc 0c 00 00       	call   140004e80 <_ZSt7forwardIyEOT_RNSt16remove_referenceIS0_E4typeE> (File Offset: 0x4480)
   140004184:	|      48 8b 00             	mov    (%rax),%rax
   140004187:	|      48 89 03             	mov    %rax,(%rbx)
   14000418a:	|      90                   	nop
   14000418b:	|      90                   	nop
   14000418c:	|      48 8b 45 20          	mov    0x20(%rbp),%rax
   140004190:	|      48 8b 40 30          	mov    0x30(%rax),%rax
   140004194:	|      48 8d 50 08          	lea    0x8(%rax),%rdx
   140004198:	|      48 8b 45 20          	mov    0x20(%rbp),%rax
   14000419c:	|      48 89 50 30          	mov    %rdx,0x30(%rax)
   1400041a0:	|  /-- eb 1b                	jmp    1400041bd <_ZNSt5dequeIySaIyEE12emplace_backIJyEEERyDpOT_+0xcd> (File Offset: 0x37bd)
   1400041a2:	\--|-> 48 8b 45 28          	mov    0x28(%rbp),%rax
   1400041a6:	   |   48 89 c1             	mov    %rax,%rcx
   1400041a9:	   |   e8 d2 0c 00 00       	call   140004e80 <_ZSt7forwardIyEOT_RNSt16remove_referenceIS0_E4typeE> (File Offset: 0x4480)
   1400041ae:	   |   48 89 c2             	mov    %rax,%rdx
   1400041b1:	   |   48 8b 45 20          	mov    0x20(%rbp),%rax
   1400041b5:	   |   48 89 c1             	mov    %rax,%rcx
   1400041b8:	   |   e8 e3 01 00 00       	call   1400043a0 <_ZNSt5dequeIySaIyEE16_M_push_back_auxIJyEEEvDpOT_> (File Offset: 0x39a0)
   1400041bd:	   \-> 48 8b 45 20          	mov    0x20(%rbp),%rax
   1400041c1:	       48 89 c1             	mov    %rax,%rcx
   1400041c4:	       e8 b7 05 00 00       	call   140004780 <_ZNSt5dequeIySaIyEE4backEv> (File Offset: 0x3d80)
   1400041c9:	       48 83 c4 58          	add    $0x58,%rsp
   1400041cd:	       5b                   	pop    %rbx
   1400041ce:	       5d                   	pop    %rbp
   1400041cf:	       c3                   	ret

00000001400041d0 <_ZNSt5dequeIySaIyEE15_M_destroy_dataESt15_Deque_iteratorIyRyPyES5_RKS0_> (File Offset: 0x37d0):
   1400041d0:	55                   	push   %rbp
   1400041d1:	48 89 e5             	mov    %rsp,%rbp
   1400041d4:	48 83 ec 40          	sub    $0x40,%rsp
   1400041d8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400041dc:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400041e0:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   1400041e4:	4c 89 4d 28          	mov    %r9,0x28(%rbp)
   1400041e8:	90                   	nop
   1400041e9:	48 83 c4 40          	add    $0x40,%rsp
   1400041ed:	5d                   	pop    %rbp
   1400041ee:	c3                   	ret
   1400041ef:	90                   	nop

00000001400041f0 <_ZNSt5dequeIySaIyEE15_M_pop_back_auxEv> (File Offset: 0x37f0):
   1400041f0:	55                   	push   %rbp
   1400041f1:	53                   	push   %rbx
   1400041f2:	48 83 ec 48          	sub    $0x48,%rsp
   1400041f6:	48 8d 6c 24 40       	lea    0x40(%rsp),%rbp
   1400041fb:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   1400041ff:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140004203:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   140004207:	48 8b 52 38          	mov    0x38(%rdx),%rdx
   14000420b:	48 89 c1             	mov    %rax,%rcx
   14000420e:	e8 dd f8 ff ff       	call   140003af0 <_ZNSt11_Deque_baseIySaIyEE18_M_deallocate_nodeEPy> (File Offset: 0x30f0)
   140004213:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140004217:	48 83 c0 30          	add    $0x30,%rax
   14000421b:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   14000421f:	48 8b 52 48          	mov    0x48(%rdx),%rdx
   140004223:	48 83 ea 08          	sub    $0x8,%rdx
   140004227:	48 89 c1             	mov    %rax,%rcx
   14000422a:	e8 91 fa ff ff       	call   140003cc0 <_ZNSt15_Deque_iteratorIyRyPyE11_M_set_nodeEPS1_> (File Offset: 0x32c0)
   14000422f:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140004233:	48 8b 40 40          	mov    0x40(%rax),%rax
   140004237:	48 8d 50 f8          	lea    -0x8(%rax),%rdx
   14000423b:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000423f:	48 89 50 30          	mov    %rdx,0x30(%rax)
   140004243:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140004247:	48 8b 58 30          	mov    0x30(%rax),%rbx
   14000424b:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000424f:	48 89 c1             	mov    %rax,%rcx
   140004252:	e8 e9 f8 ff ff       	call   140003b40 <_ZNSt11_Deque_baseIySaIyEE19_M_get_Tp_allocatorEv> (File Offset: 0x3140)
   140004257:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000425b:	48 89 5d f0          	mov    %rbx,-0x10(%rbp)
   14000425f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140004263:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   140004267:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000426b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   14000426f:	90                   	nop
   140004270:	90                   	nop
   140004271:	90                   	nop
   140004272:	48 83 c4 48          	add    $0x48,%rsp
   140004276:	5b                   	pop    %rbx
   140004277:	5d                   	pop    %rbp
   140004278:	c3                   	ret
   140004279:	90                   	nop
   14000427a:	90                   	nop
   14000427b:	90                   	nop
   14000427c:	90                   	nop
   14000427d:	90                   	nop
   14000427e:	90                   	nop
   14000427f:	90                   	nop

0000000140004280 <_ZNSt5dequeIySaIyEE16_M_push_back_auxIJRKyEEEvDpOT_> (File Offset: 0x3880):
   140004280:	    55                   	push   %rbp
   140004281:	    53                   	push   %rbx
   140004282:	    48 83 ec 58          	sub    $0x58,%rsp
   140004286:	    48 8d 6c 24 50       	lea    0x50(%rsp),%rbp
   14000428b:	    48 89 4d 20          	mov    %rcx,0x20(%rbp)
   14000428f:	    48 89 55 28          	mov    %rdx,0x28(%rbp)
   140004293:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   140004297:	    48 89 c1             	mov    %rax,%rcx
   14000429a:	    e8 91 f3 ff ff       	call   140003630 <_ZNKSt5dequeIySaIyEE4sizeEv> (File Offset: 0x2c30)
   14000429f:	    48 89 c3             	mov    %rax,%rbx
   1400042a2:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   1400042a6:	    48 89 c1             	mov    %rax,%rcx
   1400042a9:	    e8 b2 f3 ff ff       	call   140003660 <_ZNKSt5dequeIySaIyEE8max_sizeEv> (File Offset: 0x2c60)
   1400042ae:	    48 39 c3             	cmp    %rax,%rbx
   1400042b1:	    0f 94 c0             	sete   %al
   1400042b4:	    84 c0                	test   %al,%al
   1400042b6:	/-- 74 0f                	je     1400042c7 <_ZNSt5dequeIySaIyEE16_M_push_back_auxIJRKyEEEvDpOT_+0x47> (File Offset: 0x38c7)
   1400042b8:	|   48 8d 05 71 1d 00 00 	lea    0x1d71(%rip),%rax        # 140006030 <.rdata+0x30> (File Offset: 0x5630)
   1400042bf:	|   48 89 c1             	mov    %rax,%rcx
   1400042c2:	|   e8 29 da ff ff       	call   140001cf0 <_ZSt20__throw_length_errorPKc> (File Offset: 0x12f0)
   1400042c7:	\-> 48 8b 45 20          	mov    0x20(%rbp),%rax
   1400042cb:	    ba 01 00 00 00       	mov    $0x1,%edx
   1400042d0:	    48 89 c1             	mov    %rax,%rcx
   1400042d3:	    e8 08 04 00 00       	call   1400046e0 <_ZNSt5dequeIySaIyEE22_M_reserve_map_at_backEy> (File Offset: 0x3ce0)
   1400042d8:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   1400042dc:	    48 8b 55 20          	mov    0x20(%rbp),%rdx
   1400042e0:	    48 8b 52 48          	mov    0x48(%rdx),%rdx
   1400042e4:	    48 8d 5a 08          	lea    0x8(%rdx),%rbx
   1400042e8:	    48 89 c1             	mov    %rax,%rcx
   1400042eb:	    e8 70 f5 ff ff       	call   140003860 <_ZNSt11_Deque_baseIySaIyEE16_M_allocate_nodeEv> (File Offset: 0x2e60)
   1400042f0:	    48 89 03             	mov    %rax,(%rbx)
   1400042f3:	    48 8b 45 28          	mov    0x28(%rbp),%rax
   1400042f7:	    48 89 c1             	mov    %rax,%rcx
   1400042fa:	    e8 71 0b 00 00       	call   140004e70 <_ZSt7forwardIRKyEOT_RNSt16remove_referenceIS2_E4typeE> (File Offset: 0x4470)
   1400042ff:	    48 8b 55 20          	mov    0x20(%rbp),%rdx
   140004303:	    48 8b 52 30          	mov    0x30(%rdx),%rdx
   140004307:	    48 8b 4d 20          	mov    0x20(%rbp),%rcx
   14000430b:	    48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   14000430f:	    48 89 55 f0          	mov    %rdx,-0x10(%rbp)
   140004313:	    48 89 45 e8          	mov    %rax,-0x18(%rbp)
   140004317:	    48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000431b:	    48 89 c1             	mov    %rax,%rcx
   14000431e:	    e8 4d 0b 00 00       	call   140004e70 <_ZSt7forwardIRKyEOT_RNSt16remove_referenceIS2_E4typeE> (File Offset: 0x4470)
   140004323:	    48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140004327:	    48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   14000432b:	    48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   14000432f:	    48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   140004333:	    48 89 45 d0          	mov    %rax,-0x30(%rbp)
   140004337:	    48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14000433b:	    48 89 c2             	mov    %rax,%rdx
   14000433e:	    b9 08 00 00 00       	mov    $0x8,%ecx
   140004343:	    e8 d8 0b 00 00       	call   140004f20 <_ZnwyPv> (File Offset: 0x4520)
   140004348:	    48 89 c3             	mov    %rax,%rbx
   14000434b:	    48 8b 45 d0          	mov    -0x30(%rbp),%rax
   14000434f:	    48 89 c1             	mov    %rax,%rcx
   140004352:	    e8 19 0b 00 00       	call   140004e70 <_ZSt7forwardIRKyEOT_RNSt16remove_referenceIS2_E4typeE> (File Offset: 0x4470)
   140004357:	    48 8b 00             	mov    (%rax),%rax
   14000435a:	    48 89 03             	mov    %rax,(%rbx)
   14000435d:	    90                   	nop
   14000435e:	    90                   	nop
   14000435f:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   140004363:	    48 83 c0 30          	add    $0x30,%rax
   140004367:	    48 8b 55 20          	mov    0x20(%rbp),%rdx
   14000436b:	    48 8b 52 48          	mov    0x48(%rdx),%rdx
   14000436f:	    48 83 c2 08          	add    $0x8,%rdx
   140004373:	    48 89 c1             	mov    %rax,%rcx
   140004376:	    e8 45 f9 ff ff       	call   140003cc0 <_ZNSt15_Deque_iteratorIyRyPyE11_M_set_nodeEPS1_> (File Offset: 0x32c0)
   14000437b:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   14000437f:	    48 8b 50 38          	mov    0x38(%rax),%rdx
   140004383:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   140004387:	    48 89 50 30          	mov    %rdx,0x30(%rax)
   14000438b:	    90                   	nop
   14000438c:	    48 83 c4 58          	add    $0x58,%rsp
   140004390:	    5b                   	pop    %rbx
   140004391:	    5d                   	pop    %rbp
   140004392:	    c3                   	ret
   140004393:	    90                   	nop
   140004394:	    90                   	nop
   140004395:	    90                   	nop
   140004396:	    90                   	nop
   140004397:	    90                   	nop
   140004398:	    90                   	nop
   140004399:	    90                   	nop
   14000439a:	    90                   	nop
   14000439b:	    90                   	nop
   14000439c:	    90                   	nop
   14000439d:	    90                   	nop
   14000439e:	    90                   	nop
   14000439f:	    90                   	nop

00000001400043a0 <_ZNSt5dequeIySaIyEE16_M_push_back_auxIJyEEEvDpOT_> (File Offset: 0x39a0):
   1400043a0:	    55                   	push   %rbp
   1400043a1:	    53                   	push   %rbx
   1400043a2:	    48 83 ec 58          	sub    $0x58,%rsp
   1400043a6:	    48 8d 6c 24 50       	lea    0x50(%rsp),%rbp
   1400043ab:	    48 89 4d 20          	mov    %rcx,0x20(%rbp)
   1400043af:	    48 89 55 28          	mov    %rdx,0x28(%rbp)
   1400043b3:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   1400043b7:	    48 89 c1             	mov    %rax,%rcx
   1400043ba:	    e8 71 f2 ff ff       	call   140003630 <_ZNKSt5dequeIySaIyEE4sizeEv> (File Offset: 0x2c30)
   1400043bf:	    48 89 c3             	mov    %rax,%rbx
   1400043c2:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   1400043c6:	    48 89 c1             	mov    %rax,%rcx
   1400043c9:	    e8 92 f2 ff ff       	call   140003660 <_ZNKSt5dequeIySaIyEE8max_sizeEv> (File Offset: 0x2c60)
   1400043ce:	    48 39 c3             	cmp    %rax,%rbx
   1400043d1:	    0f 94 c0             	sete   %al
   1400043d4:	    84 c0                	test   %al,%al
   1400043d6:	/-- 74 0f                	je     1400043e7 <_ZNSt5dequeIySaIyEE16_M_push_back_auxIJyEEEvDpOT_+0x47> (File Offset: 0x39e7)
   1400043d8:	|   48 8d 05 51 1c 00 00 	lea    0x1c51(%rip),%rax        # 140006030 <.rdata+0x30> (File Offset: 0x5630)
   1400043df:	|   48 89 c1             	mov    %rax,%rcx
   1400043e2:	|   e8 09 d9 ff ff       	call   140001cf0 <_ZSt20__throw_length_errorPKc> (File Offset: 0x12f0)
   1400043e7:	\-> 48 8b 45 20          	mov    0x20(%rbp),%rax
   1400043eb:	    ba 01 00 00 00       	mov    $0x1,%edx
   1400043f0:	    48 89 c1             	mov    %rax,%rcx
   1400043f3:	    e8 e8 02 00 00       	call   1400046e0 <_ZNSt5dequeIySaIyEE22_M_reserve_map_at_backEy> (File Offset: 0x3ce0)
   1400043f8:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   1400043fc:	    48 8b 55 20          	mov    0x20(%rbp),%rdx
   140004400:	    48 8b 52 48          	mov    0x48(%rdx),%rdx
   140004404:	    48 8d 5a 08          	lea    0x8(%rdx),%rbx
   140004408:	    48 89 c1             	mov    %rax,%rcx
   14000440b:	    e8 50 f4 ff ff       	call   140003860 <_ZNSt11_Deque_baseIySaIyEE16_M_allocate_nodeEv> (File Offset: 0x2e60)
   140004410:	    48 89 03             	mov    %rax,(%rbx)
   140004413:	    48 8b 45 28          	mov    0x28(%rbp),%rax
   140004417:	    48 89 c1             	mov    %rax,%rcx
   14000441a:	    e8 61 0a 00 00       	call   140004e80 <_ZSt7forwardIyEOT_RNSt16remove_referenceIS0_E4typeE> (File Offset: 0x4480)
   14000441f:	    48 8b 55 20          	mov    0x20(%rbp),%rdx
   140004423:	    48 8b 52 30          	mov    0x30(%rdx),%rdx
   140004427:	    48 8b 4d 20          	mov    0x20(%rbp),%rcx
   14000442b:	    48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   14000442f:	    48 89 55 f0          	mov    %rdx,-0x10(%rbp)
   140004433:	    48 89 45 e8          	mov    %rax,-0x18(%rbp)
   140004437:	    48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000443b:	    48 89 c1             	mov    %rax,%rcx
   14000443e:	    e8 3d 0a 00 00       	call   140004e80 <_ZSt7forwardIyEOT_RNSt16remove_referenceIS0_E4typeE> (File Offset: 0x4480)
   140004443:	    48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140004447:	    48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   14000444b:	    48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   14000444f:	    48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   140004453:	    48 89 45 d0          	mov    %rax,-0x30(%rbp)
   140004457:	    48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14000445b:	    48 89 c2             	mov    %rax,%rdx
   14000445e:	    b9 08 00 00 00       	mov    $0x8,%ecx
   140004463:	    e8 b8 0a 00 00       	call   140004f20 <_ZnwyPv> (File Offset: 0x4520)
   140004468:	    48 89 c3             	mov    %rax,%rbx
   14000446b:	    48 8b 45 d0          	mov    -0x30(%rbp),%rax
   14000446f:	    48 89 c1             	mov    %rax,%rcx
   140004472:	    e8 09 0a 00 00       	call   140004e80 <_ZSt7forwardIyEOT_RNSt16remove_referenceIS0_E4typeE> (File Offset: 0x4480)
   140004477:	    48 8b 00             	mov    (%rax),%rax
   14000447a:	    48 89 03             	mov    %rax,(%rbx)
   14000447d:	    90                   	nop
   14000447e:	    90                   	nop
   14000447f:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   140004483:	    48 83 c0 30          	add    $0x30,%rax
   140004487:	    48 8b 55 20          	mov    0x20(%rbp),%rdx
   14000448b:	    48 8b 52 48          	mov    0x48(%rdx),%rdx
   14000448f:	    48 83 c2 08          	add    $0x8,%rdx
   140004493:	    48 89 c1             	mov    %rax,%rcx
   140004496:	    e8 25 f8 ff ff       	call   140003cc0 <_ZNSt15_Deque_iteratorIyRyPyE11_M_set_nodeEPS1_> (File Offset: 0x32c0)
   14000449b:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   14000449f:	    48 8b 50 38          	mov    0x38(%rax),%rdx
   1400044a3:	    48 8b 45 20          	mov    0x20(%rbp),%rax
   1400044a7:	    48 89 50 30          	mov    %rdx,0x30(%rax)
   1400044ab:	    90                   	nop
   1400044ac:	    48 83 c4 58          	add    $0x58,%rsp
   1400044b0:	    5b                   	pop    %rbx
   1400044b1:	    5d                   	pop    %rbp
   1400044b2:	    c3                   	ret
   1400044b3:	    90                   	nop
   1400044b4:	    90                   	nop
   1400044b5:	    90                   	nop
   1400044b6:	    90                   	nop
   1400044b7:	    90                   	nop
   1400044b8:	    90                   	nop
   1400044b9:	    90                   	nop
   1400044ba:	    90                   	nop
   1400044bb:	    90                   	nop
   1400044bc:	    90                   	nop
   1400044bd:	    90                   	nop
   1400044be:	    90                   	nop
   1400044bf:	    90                   	nop

00000001400044c0 <_ZNSt5dequeIySaIyEE17_M_reallocate_mapEyb> (File Offset: 0x3ac0):
   1400044c0:	             55                   	push   %rbp
   1400044c1:	             53                   	push   %rbx
   1400044c2:	             48 83 ec 58          	sub    $0x58,%rsp
   1400044c6:	             48 8d 6c 24 50       	lea    0x50(%rsp),%rbp
   1400044cb:	             48 89 4d 20          	mov    %rcx,0x20(%rbp)
   1400044cf:	             48 89 55 28          	mov    %rdx,0x28(%rbp)
   1400044d3:	             44 89 c0             	mov    %r8d,%eax
   1400044d6:	             88 45 30             	mov    %al,0x30(%rbp)
   1400044d9:	             48 8b 45 20          	mov    0x20(%rbp),%rax
   1400044dd:	             48 8b 50 48          	mov    0x48(%rax),%rdx
   1400044e1:	             48 8b 45 20          	mov    0x20(%rbp),%rax
   1400044e5:	             48 8b 40 28          	mov    0x28(%rax),%rax
   1400044e9:	             48 29 c2             	sub    %rax,%rdx
   1400044ec:	             48 89 d0             	mov    %rdx,%rax
   1400044ef:	             48 c1 f8 03          	sar    $0x3,%rax
   1400044f3:	             48 83 c0 01          	add    $0x1,%rax
   1400044f7:	             48 89 45 f0          	mov    %rax,-0x10(%rbp)
   1400044fb:	             48 8b 55 28          	mov    0x28(%rbp),%rdx
   1400044ff:	             48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140004503:	             48 01 d0             	add    %rdx,%rax
   140004506:	             48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000450a:	             48 8b 45 20          	mov    0x20(%rbp),%rax
   14000450e:	             48 8b 40 08          	mov    0x8(%rax),%rax
   140004512:	             48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   140004516:	             48 01 d2             	add    %rdx,%rdx
   140004519:	             48 39 c2             	cmp    %rax,%rdx
   14000451c:	   /-------- 0f 83 ab 00 00 00    	jae    1400045cd <_ZNSt5dequeIySaIyEE17_M_reallocate_mapEyb+0x10d> (File Offset: 0x3bcd)
   140004522:	   |         48 8b 45 20          	mov    0x20(%rbp),%rax
   140004526:	   |         48 8b 10             	mov    (%rax),%rdx
   140004529:	   |         48 8b 45 20          	mov    0x20(%rbp),%rax
   14000452d:	   |         48 8b 40 08          	mov    0x8(%rax),%rax
   140004531:	   |         48 2b 45 e8          	sub    -0x18(%rbp),%rax
   140004535:	   |         48 d1 e8             	shr    %rax
   140004538:	   |         48 8d 0c c5 00 00 00 	lea    0x0(,%rax,8),%rcx
   14000453f:	   |         00 
   140004540:	   |         80 7d 30 00          	cmpb   $0x0,0x30(%rbp)
   140004544:	   |  /----- 74 0a                	je     140004550 <_ZNSt5dequeIySaIyEE17_M_reallocate_mapEyb+0x90> (File Offset: 0x3b50)
   140004546:	   |  |      48 8b 45 28          	mov    0x28(%rbp),%rax
   14000454a:	   |  |      48 c1 e0 03          	shl    $0x3,%rax
   14000454e:	   |  |  /-- eb 05                	jmp    140004555 <_ZNSt5dequeIySaIyEE17_M_reallocate_mapEyb+0x95> (File Offset: 0x3b55)
   140004550:	   |  \--|-> b8 00 00 00 00       	mov    $0x0,%eax
   140004555:	   |     \-> 48 01 c8             	add    %rcx,%rax
   140004558:	   |         48 01 d0             	add    %rdx,%rax
   14000455b:	   |         48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000455f:	   |         48 8b 45 20          	mov    0x20(%rbp),%rax
   140004563:	   |         48 8b 40 28          	mov    0x28(%rax),%rax
   140004567:	   |         48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   14000456b:	   |     /-- 73 28                	jae    140004595 <_ZNSt5dequeIySaIyEE17_M_reallocate_mapEyb+0xd5> (File Offset: 0x3b95)
   14000456d:	   |     |   48 8b 45 20          	mov    0x20(%rbp),%rax
   140004571:	   |     |   48 8b 40 48          	mov    0x48(%rax),%rax
   140004575:	   |     |   48 8d 50 08          	lea    0x8(%rax),%rdx
   140004579:	   |     |   48 8b 45 20          	mov    0x20(%rbp),%rax
   14000457d:	   |     |   48 8b 40 28          	mov    0x28(%rax),%rax
   140004581:	   |     |   48 8b 4d f8          	mov    -0x8(%rbp),%rcx
   140004585:	   |     |   49 89 c8             	mov    %rcx,%r8
   140004588:	   |     |   48 89 c1             	mov    %rax,%rcx
   14000458b:	   |     |   e8 80 08 00 00       	call   140004e10 <_ZSt4copyIPPyS1_ET0_T_S3_S2_> (File Offset: 0x4410)
   140004590:	/--|-----|-- e9 04 01 00 00       	jmp    140004699 <_ZNSt5dequeIySaIyEE17_M_reallocate_mapEyb+0x1d9> (File Offset: 0x3c99)
   140004595:	|  |     \-> 48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140004599:	|  |         48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   1400045a0:	|  |         00 
   1400045a1:	|  |         48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400045a5:	|  |         48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
   1400045a9:	|  |         48 8b 45 20          	mov    0x20(%rbp),%rax
   1400045ad:	|  |         48 8b 40 48          	mov    0x48(%rax),%rax
   1400045b1:	|  |         48 8d 50 08          	lea    0x8(%rax),%rdx
   1400045b5:	|  |         48 8b 45 20          	mov    0x20(%rbp),%rax
   1400045b9:	|  |         48 8b 40 28          	mov    0x28(%rax),%rax
   1400045bd:	|  |         49 89 c8             	mov    %rcx,%r8
   1400045c0:	|  |         48 89 c1             	mov    %rax,%rcx
   1400045c3:	|  |         e8 f8 05 00 00       	call   140004bc0 <_ZSt13copy_backwardIPPyS1_ET0_T_S3_S2_> (File Offset: 0x41c0)
   1400045c8:	+--|-------- e9 cc 00 00 00       	jmp    140004699 <_ZNSt5dequeIySaIyEE17_M_reallocate_mapEyb+0x1d9> (File Offset: 0x3c99)
   1400045cd:	|  \-------> 48 8b 45 20          	mov    0x20(%rbp),%rax
   1400045d1:	|            48 8b 58 08          	mov    0x8(%rax),%rbx
   1400045d5:	|            48 8b 45 20          	mov    0x20(%rbp),%rax
   1400045d9:	|            48 8d 48 08          	lea    0x8(%rax),%rcx
   1400045dd:	|            48 8d 45 28          	lea    0x28(%rbp),%rax
   1400045e1:	|            48 89 c2             	mov    %rax,%rdx
   1400045e4:	|            e8 c7 07 00 00       	call   140004db0 <_ZSt3maxIyERKT_S2_S2_> (File Offset: 0x43b0)
   1400045e9:	|            48 8b 00             	mov    (%rax),%rax
   1400045ec:	|            48 01 d8             	add    %rbx,%rax
   1400045ef:	|            48 83 c0 02          	add    $0x2,%rax
   1400045f3:	|            48 89 45 e0          	mov    %rax,-0x20(%rbp)
   1400045f7:	|            48 8b 45 20          	mov    0x20(%rbp),%rax
   1400045fb:	|            48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   1400045ff:	|            48 89 c1             	mov    %rax,%rcx
   140004602:	|            e8 f9 f0 ff ff       	call   140003700 <_ZNSt11_Deque_baseIySaIyEE15_M_allocate_mapEy> (File Offset: 0x2d00)
   140004607:	|            48 89 45 d8          	mov    %rax,-0x28(%rbp)
   14000460b:	|            48 8b 45 e0          	mov    -0x20(%rbp),%rax
   14000460f:	|            48 2b 45 e8          	sub    -0x18(%rbp),%rax
   140004613:	|            48 d1 e8             	shr    %rax
   140004616:	|            48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   14000461d:	|            00 
   14000461e:	|            80 7d 30 00          	cmpb   $0x0,0x30(%rbp)
   140004622:	|     /----- 74 0a                	je     14000462e <_ZNSt5dequeIySaIyEE17_M_reallocate_mapEyb+0x16e> (File Offset: 0x3c2e)
   140004624:	|     |      48 8b 45 28          	mov    0x28(%rbp),%rax
   140004628:	|     |      48 c1 e0 03          	shl    $0x3,%rax
   14000462c:	|     |  /-- eb 05                	jmp    140004633 <_ZNSt5dequeIySaIyEE17_M_reallocate_mapEyb+0x173> (File Offset: 0x3c33)
   14000462e:	|     \--|-> b8 00 00 00 00       	mov    $0x0,%eax
   140004633:	|        \-> 48 01 c2             	add    %rax,%rdx
   140004636:	|            48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14000463a:	|            48 01 d0             	add    %rdx,%rax
   14000463d:	|            48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140004641:	|            48 8b 45 20          	mov    0x20(%rbp),%rax
   140004645:	|            48 8b 40 48          	mov    0x48(%rax),%rax
   140004649:	|            48 8d 50 08          	lea    0x8(%rax),%rdx
   14000464d:	|            48 8b 45 20          	mov    0x20(%rbp),%rax
   140004651:	|            48 8b 40 28          	mov    0x28(%rax),%rax
   140004655:	|            48 8b 4d f8          	mov    -0x8(%rbp),%rcx
   140004659:	|            49 89 c8             	mov    %rcx,%r8
   14000465c:	|            48 89 c1             	mov    %rax,%rcx
   14000465f:	|            e8 ac 07 00 00       	call   140004e10 <_ZSt4copyIPPyS1_ET0_T_S3_S2_> (File Offset: 0x4410)
   140004664:	|            48 8b 45 20          	mov    0x20(%rbp),%rax
   140004668:	|            48 8b 55 20          	mov    0x20(%rbp),%rdx
   14000466c:	|            48 8b 4a 08          	mov    0x8(%rdx),%rcx
   140004670:	|            48 8b 55 20          	mov    0x20(%rbp),%rdx
   140004674:	|            48 8b 12             	mov    (%rdx),%rdx
   140004677:	|            49 89 c8             	mov    %rcx,%r8
   14000467a:	|            48 89 c1             	mov    %rax,%rcx
   14000467d:	|            e8 6e f2 ff ff       	call   1400038f0 <_ZNSt11_Deque_baseIySaIyEE17_M_deallocate_mapEPPyy> (File Offset: 0x2ef0)
   140004682:	|            48 8b 45 20          	mov    0x20(%rbp),%rax
   140004686:	|            48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   14000468a:	|            48 89 10             	mov    %rdx,(%rax)
   14000468d:	|            48 8b 45 20          	mov    0x20(%rbp),%rax
   140004691:	|            48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   140004695:	|            48 89 50 08          	mov    %rdx,0x8(%rax)
   140004699:	\----------> 48 8b 45 20          	mov    0x20(%rbp),%rax
   14000469d:	             48 83 c0 10          	add    $0x10,%rax
   1400046a1:	             48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   1400046a5:	             48 89 c1             	mov    %rax,%rcx
   1400046a8:	             e8 13 f6 ff ff       	call   140003cc0 <_ZNSt15_Deque_iteratorIyRyPyE11_M_set_nodeEPS1_> (File Offset: 0x32c0)
   1400046ad:	             48 8b 45 20          	mov    0x20(%rbp),%rax
   1400046b1:	             48 83 c0 30          	add    $0x30,%rax
   1400046b5:	             48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   1400046b9:	             48 c1 e2 03          	shl    $0x3,%rdx
   1400046bd:	             48 8d 4a f8          	lea    -0x8(%rdx),%rcx
   1400046c1:	             48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   1400046c5:	             48 01 ca             	add    %rcx,%rdx
   1400046c8:	             48 89 c1             	mov    %rax,%rcx
   1400046cb:	             e8 f0 f5 ff ff       	call   140003cc0 <_ZNSt15_Deque_iteratorIyRyPyE11_M_set_nodeEPS1_> (File Offset: 0x32c0)
   1400046d0:	             90                   	nop
   1400046d1:	             48 83 c4 58          	add    $0x58,%rsp
   1400046d5:	             5b                   	pop    %rbx
   1400046d6:	             5d                   	pop    %rbp
   1400046d7:	             c3                   	ret
   1400046d8:	             90                   	nop
   1400046d9:	             90                   	nop
   1400046da:	             90                   	nop
   1400046db:	             90                   	nop
   1400046dc:	             90                   	nop
   1400046dd:	             90                   	nop
   1400046de:	             90                   	nop
   1400046df:	             90                   	nop

00000001400046e0 <_ZNSt5dequeIySaIyEE22_M_reserve_map_at_backEy> (File Offset: 0x3ce0):
   1400046e0:	    55                   	push   %rbp
   1400046e1:	    48 89 e5             	mov    %rsp,%rbp
   1400046e4:	    48 83 ec 20          	sub    $0x20,%rsp
   1400046e8:	    48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400046ec:	    48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400046f0:	    48 8b 45 18          	mov    0x18(%rbp),%rax
   1400046f4:	    48 83 c0 01          	add    $0x1,%rax
   1400046f8:	    48 8b 55 10          	mov    0x10(%rbp),%rdx
   1400046fc:	    48 8b 4a 08          	mov    0x8(%rdx),%rcx
   140004700:	    48 8b 55 10          	mov    0x10(%rbp),%rdx
   140004704:	    4c 8b 42 48          	mov    0x48(%rdx),%r8
   140004708:	    48 8b 55 10          	mov    0x10(%rbp),%rdx
   14000470c:	    48 8b 12             	mov    (%rdx),%rdx
   14000470f:	    49 29 d0             	sub    %rdx,%r8
   140004712:	    4c 89 c2             	mov    %r8,%rdx
   140004715:	    48 c1 fa 03          	sar    $0x3,%rdx
   140004719:	    49 89 d0             	mov    %rdx,%r8
   14000471c:	    4c 29 c1             	sub    %r8,%rcx
   14000471f:	    48 89 ca             	mov    %rcx,%rdx
   140004722:	    48 39 c2             	cmp    %rax,%rdx
   140004725:	/-- 73 16                	jae    14000473d <_ZNSt5dequeIySaIyEE22_M_reserve_map_at_backEy+0x5d> (File Offset: 0x3d3d)
   140004727:	|   48 8b 55 18          	mov    0x18(%rbp),%rdx
   14000472b:	|   48 8b 45 10          	mov    0x10(%rbp),%rax
   14000472f:	|   41 b8 00 00 00 00    	mov    $0x0,%r8d
   140004735:	|   48 89 c1             	mov    %rax,%rcx
   140004738:	|   e8 83 fd ff ff       	call   1400044c0 <_ZNSt5dequeIySaIyEE17_M_reallocate_mapEyb> (File Offset: 0x3ac0)
   14000473d:	\-> 90                   	nop
   14000473e:	    48 83 c4 20          	add    $0x20,%rsp
   140004742:	    5d                   	pop    %rbp
   140004743:	    c3                   	ret
   140004744:	    90                   	nop
   140004745:	    90                   	nop
   140004746:	    90                   	nop
   140004747:	    90                   	nop
   140004748:	    90                   	nop
   140004749:	    90                   	nop
   14000474a:	    90                   	nop
   14000474b:	    90                   	nop
   14000474c:	    90                   	nop
   14000474d:	    90                   	nop
   14000474e:	    90                   	nop
   14000474f:	    90                   	nop

0000000140004750 <_ZNSt5dequeIySaIyEE3endEv> (File Offset: 0x3d50):
   140004750:	55                   	push   %rbp
   140004751:	48 89 e5             	mov    %rsp,%rbp
   140004754:	48 83 ec 20          	sub    $0x20,%rsp
   140004758:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000475c:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140004760:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140004764:	48 8d 50 30          	lea    0x30(%rax),%rdx
   140004768:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000476c:	48 89 c1             	mov    %rax,%rcx
   14000476f:	e8 cc f5 ff ff       	call   140003d40 <_ZNSt15_Deque_iteratorIyRyPyEC1ERKS2_> (File Offset: 0x3340)
   140004774:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140004778:	48 83 c4 20          	add    $0x20,%rsp
   14000477c:	5d                   	pop    %rbp
   14000477d:	c3                   	ret
   14000477e:	90                   	nop
   14000477f:	90                   	nop

0000000140004780 <_ZNSt5dequeIySaIyEE4backEv> (File Offset: 0x3d80):
   140004780:	55                   	push   %rbp
   140004781:	48 89 e5             	mov    %rsp,%rbp
   140004784:	48 83 ec 40          	sub    $0x40,%rsp
   140004788:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000478c:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   140004790:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   140004794:	48 89 c1             	mov    %rax,%rcx
   140004797:	e8 b4 ff ff ff       	call   140004750 <_ZNSt5dequeIySaIyEE3endEv> (File Offset: 0x3d50)
   14000479c:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   1400047a0:	48 89 c1             	mov    %rax,%rcx
   1400047a3:	e8 28 f6 ff ff       	call   140003dd0 <_ZNSt15_Deque_iteratorIyRyPyEmmEv> (File Offset: 0x33d0)
   1400047a8:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   1400047ac:	48 89 c1             	mov    %rax,%rcx
   1400047af:	e8 5c ee ff ff       	call   140003610 <_ZNKSt15_Deque_iteratorIyRyPyEdeEv> (File Offset: 0x2c10)
   1400047b4:	48 83 c4 40          	add    $0x40,%rsp
   1400047b8:	5d                   	pop    %rbp
   1400047b9:	c3                   	ret
   1400047ba:	90                   	nop
   1400047bb:	90                   	nop
   1400047bc:	90                   	nop
   1400047bd:	90                   	nop
   1400047be:	90                   	nop
   1400047bf:	90                   	nop

00000001400047c0 <_ZNSt5dequeIySaIyEE5beginEv> (File Offset: 0x3dc0):
   1400047c0:	55                   	push   %rbp
   1400047c1:	48 89 e5             	mov    %rsp,%rbp
   1400047c4:	48 83 ec 20          	sub    $0x20,%rsp
   1400047c8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400047cc:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400047d0:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400047d4:	48 8d 50 10          	lea    0x10(%rax),%rdx
   1400047d8:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400047dc:	48 89 c1             	mov    %rax,%rcx
   1400047df:	e8 5c f5 ff ff       	call   140003d40 <_ZNSt15_Deque_iteratorIyRyPyEC1ERKS2_> (File Offset: 0x3340)
   1400047e4:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400047e8:	48 83 c4 20          	add    $0x20,%rsp
   1400047ec:	5d                   	pop    %rbp
   1400047ed:	c3                   	ret
   1400047ee:	90                   	nop
   1400047ef:	90                   	nop

00000001400047f0 <_ZNSt5dequeIySaIyEE8pop_backEv> (File Offset: 0x3df0):
   1400047f0:	       55                   	push   %rbp
   1400047f1:	       53                   	push   %rbx
   1400047f2:	       48 83 ec 48          	sub    $0x48,%rsp
   1400047f6:	       48 8d 6c 24 40       	lea    0x40(%rsp),%rbp
   1400047fb:	       48 89 4d 20          	mov    %rcx,0x20(%rbp)
   1400047ff:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   140004803:	       48 8b 50 30          	mov    0x30(%rax),%rdx
   140004807:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   14000480b:	       48 8b 40 38          	mov    0x38(%rax),%rax
   14000480f:	       48 39 c2             	cmp    %rax,%rdx
   140004812:	/----- 74 43                	je     140004857 <_ZNSt5dequeIySaIyEE8pop_backEv+0x67> (File Offset: 0x3e57)
   140004814:	|      48 8b 45 20          	mov    0x20(%rbp),%rax
   140004818:	|      48 8b 40 30          	mov    0x30(%rax),%rax
   14000481c:	|      48 8d 50 f8          	lea    -0x8(%rax),%rdx
   140004820:	|      48 8b 45 20          	mov    0x20(%rbp),%rax
   140004824:	|      48 89 50 30          	mov    %rdx,0x30(%rax)
   140004828:	|      48 8b 45 20          	mov    0x20(%rbp),%rax
   14000482c:	|      48 8b 58 30          	mov    0x30(%rax),%rbx
   140004830:	|      48 8b 45 20          	mov    0x20(%rbp),%rax
   140004834:	|      48 89 c1             	mov    %rax,%rcx
   140004837:	|      e8 04 f3 ff ff       	call   140003b40 <_ZNSt11_Deque_baseIySaIyEE19_M_get_Tp_allocatorEv> (File Offset: 0x3140)
   14000483c:	|      48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140004840:	|      48 89 5d f0          	mov    %rbx,-0x10(%rbp)
   140004844:	|      48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140004848:	|      48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000484c:	|      48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140004850:	|      48 89 45 e0          	mov    %rax,-0x20(%rbp)
   140004854:	|      90                   	nop
   140004855:	|  /-- eb 0d                	jmp    140004864 <_ZNSt5dequeIySaIyEE8pop_backEv+0x74> (File Offset: 0x3e64)
   140004857:	\--|-> 48 8b 45 20          	mov    0x20(%rbp),%rax
   14000485b:	   |   48 89 c1             	mov    %rax,%rcx
   14000485e:	   |   e8 8d f9 ff ff       	call   1400041f0 <_ZNSt5dequeIySaIyEE15_M_pop_back_auxEv> (File Offset: 0x37f0)
   140004863:	   |   90                   	nop
   140004864:	   \-> 90                   	nop
   140004865:	       48 83 c4 48          	add    $0x48,%rsp
   140004869:	       5b                   	pop    %rbx
   14000486a:	       5d                   	pop    %rbp
   14000486b:	       c3                   	ret
   14000486c:	       90                   	nop
   14000486d:	       90                   	nop
   14000486e:	       90                   	nop
   14000486f:	       90                   	nop

0000000140004870 <_ZNSt5dequeIySaIyEE9push_backEOy> (File Offset: 0x3e70):
   140004870:	55                   	push   %rbp
   140004871:	48 89 e5             	mov    %rsp,%rbp
   140004874:	48 83 ec 20          	sub    $0x20,%rsp
   140004878:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000487c:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140004880:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140004884:	48 89 c1             	mov    %rax,%rcx
   140004887:	e8 d4 05 00 00       	call   140004e60 <_ZSt4moveIRyEONSt16remove_referenceIT_E4typeEOS2_> (File Offset: 0x4460)
   14000488c:	48 89 c2             	mov    %rax,%rdx
   14000488f:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140004893:	48 89 c1             	mov    %rax,%rcx
   140004896:	e8 55 f8 ff ff       	call   1400040f0 <_ZNSt5dequeIySaIyEE12emplace_backIJyEEERyDpOT_> (File Offset: 0x36f0)
   14000489b:	90                   	nop
   14000489c:	48 83 c4 20          	add    $0x20,%rsp
   1400048a0:	5d                   	pop    %rbp
   1400048a1:	c3                   	ret
   1400048a2:	90                   	nop
   1400048a3:	90                   	nop
   1400048a4:	90                   	nop
   1400048a5:	90                   	nop
   1400048a6:	90                   	nop
   1400048a7:	90                   	nop
   1400048a8:	90                   	nop
   1400048a9:	90                   	nop
   1400048aa:	90                   	nop
   1400048ab:	90                   	nop
   1400048ac:	90                   	nop
   1400048ad:	90                   	nop
   1400048ae:	90                   	nop
   1400048af:	90                   	nop

00000001400048b0 <_ZNSt5dequeIySaIyEE9push_backERKy> (File Offset: 0x3eb0):
   1400048b0:	       55                   	push   %rbp
   1400048b1:	       53                   	push   %rbx
   1400048b2:	       48 83 ec 58          	sub    $0x58,%rsp
   1400048b6:	       48 8d 6c 24 50       	lea    0x50(%rsp),%rbp
   1400048bb:	       48 89 4d 20          	mov    %rcx,0x20(%rbp)
   1400048bf:	       48 89 55 28          	mov    %rdx,0x28(%rbp)
   1400048c3:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   1400048c7:	       48 8b 50 30          	mov    0x30(%rax),%rdx
   1400048cb:	       48 8b 45 20          	mov    0x20(%rbp),%rax
   1400048cf:	       48 8b 40 40          	mov    0x40(%rax),%rax
   1400048d3:	       48 83 e8 08          	sub    $0x8,%rax
   1400048d7:	       48 39 c2             	cmp    %rax,%rdx
   1400048da:	/----- 74 7a                	je     140004956 <_ZNSt5dequeIySaIyEE9push_backERKy+0xa6> (File Offset: 0x3f56)
   1400048dc:	|      48 8b 45 20          	mov    0x20(%rbp),%rax
   1400048e0:	|      48 8b 40 30          	mov    0x30(%rax),%rax
   1400048e4:	|      48 8b 55 20          	mov    0x20(%rbp),%rdx
   1400048e8:	|      48 89 55 f8          	mov    %rdx,-0x8(%rbp)
   1400048ec:	|      48 89 45 f0          	mov    %rax,-0x10(%rbp)
   1400048f0:	|      48 8b 45 28          	mov    0x28(%rbp),%rax
   1400048f4:	|      48 89 45 e8          	mov    %rax,-0x18(%rbp)
   1400048f8:	|      48 8b 45 e8          	mov    -0x18(%rbp),%rax
   1400048fc:	|      48 89 c1             	mov    %rax,%rcx
   1400048ff:	|      e8 6c 05 00 00       	call   140004e70 <_ZSt7forwardIRKyEOT_RNSt16remove_referenceIS2_E4typeE> (File Offset: 0x4470)
   140004904:	|      48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140004908:	|      48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   14000490c:	|      48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   140004910:	|      48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   140004914:	|      48 89 45 d0          	mov    %rax,-0x30(%rbp)
   140004918:	|      48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14000491c:	|      48 89 c2             	mov    %rax,%rdx
   14000491f:	|      b9 08 00 00 00       	mov    $0x8,%ecx
   140004924:	|      e8 f7 05 00 00       	call   140004f20 <_ZnwyPv> (File Offset: 0x4520)
   140004929:	|      48 89 c3             	mov    %rax,%rbx
   14000492c:	|      48 8b 45 d0          	mov    -0x30(%rbp),%rax
   140004930:	|      48 89 c1             	mov    %rax,%rcx
   140004933:	|      e8 38 05 00 00       	call   140004e70 <_ZSt7forwardIRKyEOT_RNSt16remove_referenceIS2_E4typeE> (File Offset: 0x4470)
   140004938:	|      48 8b 00             	mov    (%rax),%rax
   14000493b:	|      48 89 03             	mov    %rax,(%rbx)
   14000493e:	|      90                   	nop
   14000493f:	|      90                   	nop
   140004940:	|      48 8b 45 20          	mov    0x20(%rbp),%rax
   140004944:	|      48 8b 40 30          	mov    0x30(%rax),%rax
   140004948:	|      48 8d 50 08          	lea    0x8(%rax),%rdx
   14000494c:	|      48 8b 45 20          	mov    0x20(%rbp),%rax
   140004950:	|      48 89 50 30          	mov    %rdx,0x30(%rax)
   140004954:	|  /-- eb 10                	jmp    140004966 <_ZNSt5dequeIySaIyEE9push_backERKy+0xb6> (File Offset: 0x3f66)
   140004956:	\--|-> 48 8b 55 28          	mov    0x28(%rbp),%rdx
   14000495a:	   |   48 8b 45 20          	mov    0x20(%rbp),%rax
   14000495e:	   |   48 89 c1             	mov    %rax,%rcx
   140004961:	   |   e8 1a f9 ff ff       	call   140004280 <_ZNSt5dequeIySaIyEE16_M_push_back_auxIJRKyEEEvDpOT_> (File Offset: 0x3880)
   140004966:	   \-> 90                   	nop
   140004967:	       48 83 c4 58          	add    $0x58,%rsp
   14000496b:	       5b                   	pop    %rbx
   14000496c:	       5d                   	pop    %rbp
   14000496d:	       c3                   	ret
   14000496e:	       90                   	nop
   14000496f:	       90                   	nop

0000000140004970 <_ZNSt5dequeIySaIyEEC1Ev> (File Offset: 0x3f70):
   140004970:	55                   	push   %rbp
   140004971:	48 89 e5             	mov    %rsp,%rbp
   140004974:	48 83 ec 20          	sub    $0x20,%rsp
   140004978:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000497c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140004980:	48 89 c1             	mov    %rax,%rcx
   140004983:	e8 c8 f1 ff ff       	call   140003b50 <_ZNSt11_Deque_baseIySaIyEEC2Ev> (File Offset: 0x3150)
   140004988:	90                   	nop
   140004989:	48 83 c4 20          	add    $0x20,%rsp
   14000498d:	5d                   	pop    %rbp
   14000498e:	c3                   	ret
   14000498f:	90                   	nop

0000000140004990 <_ZNSt5dequeIySaIyEED1Ev> (File Offset: 0x3f90):
   140004990:	55                   	push   %rbp
   140004991:	53                   	push   %rbx
   140004992:	48 83 ec 68          	sub    $0x68,%rsp
   140004996:	48 8d 6c 24 60       	lea    0x60(%rsp),%rbp
   14000499b:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   14000499f:	48 8b 45 20          	mov    0x20(%rbp),%rax
   1400049a3:	48 89 c1             	mov    %rax,%rcx
   1400049a6:	e8 95 f1 ff ff       	call   140003b40 <_ZNSt11_Deque_baseIySaIyEE19_M_get_Tp_allocatorEv> (File Offset: 0x3140)
   1400049ab:	48 89 c3             	mov    %rax,%rbx
   1400049ae:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   1400049b2:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   1400049b6:	48 89 c1             	mov    %rax,%rcx
   1400049b9:	e8 92 fd ff ff       	call   140004750 <_ZNSt5dequeIySaIyEE3endEv> (File Offset: 0x3d50)
   1400049be:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   1400049c2:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   1400049c6:	48 89 c1             	mov    %rax,%rcx
   1400049c9:	e8 f2 fd ff ff       	call   1400047c0 <_ZNSt5dequeIySaIyEE5beginEv> (File Offset: 0x3dc0)
   1400049ce:	48 8d 55 c0          	lea    -0x40(%rbp),%rdx
   1400049d2:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   1400049d6:	48 8b 4d 20          	mov    0x20(%rbp),%rcx
   1400049da:	49 89 d9             	mov    %rbx,%r9
   1400049dd:	49 89 d0             	mov    %rdx,%r8
   1400049e0:	48 89 c2             	mov    %rax,%rdx
   1400049e3:	e8 e8 f7 ff ff       	call   1400041d0 <_ZNSt5dequeIySaIyEE15_M_destroy_dataESt15_Deque_iteratorIyRyPyES5_RKS0_> (File Offset: 0x37d0)
   1400049e8:	48 8b 45 20          	mov    0x20(%rbp),%rax
   1400049ec:	48 89 c1             	mov    %rax,%rcx
   1400049ef:	e8 ac f1 ff ff       	call   140003ba0 <_ZNSt11_Deque_baseIySaIyEED2Ev> (File Offset: 0x31a0)
   1400049f4:	90                   	nop
   1400049f5:	48 83 c4 68          	add    $0x68,%rsp
   1400049f9:	5b                   	pop    %rbx
   1400049fa:	5d                   	pop    %rbp
   1400049fb:	c3                   	ret
   1400049fc:	90                   	nop
   1400049fd:	90                   	nop
   1400049fe:	90                   	nop
   1400049ff:	90                   	nop

0000000140004a00 <_ZNSt5stackIySt5dequeIySaIyEEE3popEv> (File Offset: 0x4000):
   140004a00:	55                   	push   %rbp
   140004a01:	48 89 e5             	mov    %rsp,%rbp
   140004a04:	48 83 ec 20          	sub    $0x20,%rsp
   140004a08:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140004a0c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140004a10:	48 89 c1             	mov    %rax,%rcx
   140004a13:	e8 d8 fd ff ff       	call   1400047f0 <_ZNSt5dequeIySaIyEE8pop_backEv> (File Offset: 0x3df0)
   140004a18:	90                   	nop
   140004a19:	48 83 c4 20          	add    $0x20,%rsp
   140004a1d:	5d                   	pop    %rbp
   140004a1e:	c3                   	ret
   140004a1f:	90                   	nop

0000000140004a20 <_ZNSt5stackIySt5dequeIySaIyEEE3topEv> (File Offset: 0x4020):
   140004a20:	55                   	push   %rbp
   140004a21:	48 89 e5             	mov    %rsp,%rbp
   140004a24:	48 83 ec 20          	sub    $0x20,%rsp
   140004a28:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140004a2c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140004a30:	48 89 c1             	mov    %rax,%rcx
   140004a33:	e8 48 fd ff ff       	call   140004780 <_ZNSt5dequeIySaIyEE4backEv> (File Offset: 0x3d80)
   140004a38:	48 83 c4 20          	add    $0x20,%rsp
   140004a3c:	5d                   	pop    %rbp
   140004a3d:	c3                   	ret
   140004a3e:	90                   	nop
   140004a3f:	90                   	nop

0000000140004a40 <_ZNSt5stackIySt5dequeIySaIyEEE4pushEOy> (File Offset: 0x4040):
   140004a40:	55                   	push   %rbp
   140004a41:	53                   	push   %rbx
   140004a42:	48 83 ec 28          	sub    $0x28,%rsp
   140004a46:	48 8d 6c 24 20       	lea    0x20(%rsp),%rbp
   140004a4b:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   140004a4f:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   140004a53:	48 8b 5d 20          	mov    0x20(%rbp),%rbx
   140004a57:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140004a5b:	48 89 c1             	mov    %rax,%rcx
   140004a5e:	e8 fd 03 00 00       	call   140004e60 <_ZSt4moveIRyEONSt16remove_referenceIT_E4typeEOS2_> (File Offset: 0x4460)
   140004a63:	48 89 c2             	mov    %rax,%rdx
   140004a66:	48 89 d9             	mov    %rbx,%rcx
   140004a69:	e8 02 fe ff ff       	call   140004870 <_ZNSt5dequeIySaIyEE9push_backEOy> (File Offset: 0x3e70)
   140004a6e:	90                   	nop
   140004a6f:	48 83 c4 28          	add    $0x28,%rsp
   140004a73:	5b                   	pop    %rbx
   140004a74:	5d                   	pop    %rbp
   140004a75:	c3                   	ret
   140004a76:	90                   	nop
   140004a77:	90                   	nop
   140004a78:	90                   	nop
   140004a79:	90                   	nop
   140004a7a:	90                   	nop
   140004a7b:	90                   	nop
   140004a7c:	90                   	nop
   140004a7d:	90                   	nop
   140004a7e:	90                   	nop
   140004a7f:	90                   	nop

0000000140004a80 <_ZNSt5stackIySt5dequeIySaIyEEE4pushERKy> (File Offset: 0x4080):
   140004a80:	55                   	push   %rbp
   140004a81:	48 89 e5             	mov    %rsp,%rbp
   140004a84:	48 83 ec 20          	sub    $0x20,%rsp
   140004a88:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140004a8c:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140004a90:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140004a94:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140004a98:	48 89 c1             	mov    %rax,%rcx
   140004a9b:	e8 10 fe ff ff       	call   1400048b0 <_ZNSt5dequeIySaIyEE9push_backERKy> (File Offset: 0x3eb0)
   140004aa0:	90                   	nop
   140004aa1:	48 83 c4 20          	add    $0x20,%rsp
   140004aa5:	5d                   	pop    %rbp
   140004aa6:	c3                   	ret
   140004aa7:	90                   	nop
   140004aa8:	90                   	nop
   140004aa9:	90                   	nop
   140004aaa:	90                   	nop
   140004aab:	90                   	nop
   140004aac:	90                   	nop
   140004aad:	90                   	nop
   140004aae:	90                   	nop
   140004aaf:	90                   	nop

0000000140004ab0 <_ZNSt5stackIySt5dequeIySaIyEEEC1IS2_vEEv> (File Offset: 0x40b0):
   140004ab0:	55                   	push   %rbp
   140004ab1:	57                   	push   %rdi
   140004ab2:	48 83 ec 28          	sub    $0x28,%rsp
   140004ab6:	48 8d 6c 24 20       	lea    0x20(%rsp),%rbp
   140004abb:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   140004abf:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140004ac3:	49 89 c0             	mov    %rax,%r8
   140004ac6:	b8 00 00 00 00       	mov    $0x0,%eax
   140004acb:	ba 0a 00 00 00       	mov    $0xa,%edx
   140004ad0:	4c 89 c7             	mov    %r8,%rdi
   140004ad3:	48 89 d1             	mov    %rdx,%rcx
   140004ad6:	f3 48 ab             	rep stos %rax,%es:(%rdi)
   140004ad9:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140004add:	48 89 c1             	mov    %rax,%rcx
   140004ae0:	e8 8b fe ff ff       	call   140004970 <_ZNSt5dequeIySaIyEEC1Ev> (File Offset: 0x3f70)
   140004ae5:	90                   	nop
   140004ae6:	48 83 c4 28          	add    $0x28,%rsp
   140004aea:	5f                   	pop    %rdi
   140004aeb:	5d                   	pop    %rbp
   140004aec:	c3                   	ret
   140004aed:	90                   	nop
   140004aee:	90                   	nop
   140004aef:	90                   	nop

0000000140004af0 <_ZNSt5stackIySt5dequeIySaIyEEED1Ev> (File Offset: 0x40f0):
   140004af0:	55                   	push   %rbp
   140004af1:	48 89 e5             	mov    %rsp,%rbp
   140004af4:	48 83 ec 20          	sub    $0x20,%rsp
   140004af8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140004afc:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140004b00:	48 89 c1             	mov    %rax,%rcx
   140004b03:	e8 88 fe ff ff       	call   140004990 <_ZNSt5dequeIySaIyEED1Ev> (File Offset: 0x3f90)
   140004b08:	90                   	nop
   140004b09:	48 83 c4 20          	add    $0x20,%rsp
   140004b0d:	5d                   	pop    %rbp
   140004b0e:	c3                   	ret
   140004b0f:	90                   	nop

0000000140004b10 <_ZSt12__miter_baseIPPyET_S2_> (File Offset: 0x4110):
   140004b10:	55                   	push   %rbp
   140004b11:	48 89 e5             	mov    %rsp,%rbp
   140004b14:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140004b18:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140004b1c:	5d                   	pop    %rbp
   140004b1d:	c3                   	ret
   140004b1e:	90                   	nop
   140004b1f:	90                   	nop

0000000140004b20 <_ZSt12__niter_baseIPPyET_S2_> (File Offset: 0x4120):
   140004b20:	55                   	push   %rbp
   140004b21:	48 89 e5             	mov    %rsp,%rbp
   140004b24:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140004b28:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140004b2c:	5d                   	pop    %rbp
   140004b2d:	c3                   	ret
   140004b2e:	90                   	nop
   140004b2f:	90                   	nop

0000000140004b30 <_ZSt12__niter_wrapIPPyET_RKS2_S2_> (File Offset: 0x4130):
   140004b30:	55                   	push   %rbp
   140004b31:	48 89 e5             	mov    %rsp,%rbp
   140004b34:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140004b38:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140004b3c:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140004b40:	5d                   	pop    %rbp
   140004b41:	c3                   	ret
   140004b42:	90                   	nop
   140004b43:	90                   	nop
   140004b44:	90                   	nop
   140004b45:	90                   	nop
   140004b46:	90                   	nop
   140004b47:	90                   	nop
   140004b48:	90                   	nop
   140004b49:	90                   	nop
   140004b4a:	90                   	nop
   140004b4b:	90                   	nop
   140004b4c:	90                   	nop
   140004b4d:	90                   	nop
   140004b4e:	90                   	nop
   140004b4f:	90                   	nop

0000000140004b50 <_ZSt13__copy_move_aILb0EPPyS1_ET1_T0_S3_S2_> (File Offset: 0x4150):
   140004b50:	55                   	push   %rbp
   140004b51:	56                   	push   %rsi
   140004b52:	53                   	push   %rbx
   140004b53:	48 83 ec 20          	sub    $0x20,%rsp
   140004b57:	48 8d 6c 24 20       	lea    0x20(%rsp),%rbp
   140004b5c:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   140004b60:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   140004b64:	4c 89 45 30          	mov    %r8,0x30(%rbp)
   140004b68:	48 8b 45 30          	mov    0x30(%rbp),%rax
   140004b6c:	48 89 c1             	mov    %rax,%rcx
   140004b6f:	e8 ac ff ff ff       	call   140004b20 <_ZSt12__niter_baseIPPyET_S2_> (File Offset: 0x4120)
   140004b74:	48 89 c6             	mov    %rax,%rsi
   140004b77:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140004b7b:	48 89 c1             	mov    %rax,%rcx
   140004b7e:	e8 9d ff ff ff       	call   140004b20 <_ZSt12__niter_baseIPPyET_S2_> (File Offset: 0x4120)
   140004b83:	48 89 c3             	mov    %rax,%rbx
   140004b86:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140004b8a:	48 89 c1             	mov    %rax,%rcx
   140004b8d:	e8 8e ff ff ff       	call   140004b20 <_ZSt12__niter_baseIPPyET_S2_> (File Offset: 0x4120)
   140004b92:	49 89 f0             	mov    %rsi,%r8
   140004b95:	48 89 da             	mov    %rbx,%rdx
   140004b98:	48 89 c1             	mov    %rax,%rcx
   140004b9b:	e8 70 00 00 00       	call   140004c10 <_ZSt14__copy_move_a1ILb0EPPyS1_ET1_T0_S3_S2_> (File Offset: 0x4210)
   140004ba0:	48 89 c2             	mov    %rax,%rdx
   140004ba3:	48 8d 45 30          	lea    0x30(%rbp),%rax
   140004ba7:	48 89 c1             	mov    %rax,%rcx
   140004baa:	e8 81 ff ff ff       	call   140004b30 <_ZSt12__niter_wrapIPPyET_RKS2_S2_> (File Offset: 0x4130)
   140004baf:	48 83 c4 20          	add    $0x20,%rsp
   140004bb3:	5b                   	pop    %rbx
   140004bb4:	5e                   	pop    %rsi
   140004bb5:	5d                   	pop    %rbp
   140004bb6:	c3                   	ret
   140004bb7:	90                   	nop
   140004bb8:	90                   	nop
   140004bb9:	90                   	nop
   140004bba:	90                   	nop
   140004bbb:	90                   	nop
   140004bbc:	90                   	nop
   140004bbd:	90                   	nop
   140004bbe:	90                   	nop
   140004bbf:	90                   	nop

0000000140004bc0 <_ZSt13copy_backwardIPPyS1_ET0_T_S3_S2_> (File Offset: 0x41c0):
   140004bc0:	55                   	push   %rbp
   140004bc1:	53                   	push   %rbx
   140004bc2:	48 83 ec 28          	sub    $0x28,%rsp
   140004bc6:	48 8d 6c 24 20       	lea    0x20(%rsp),%rbp
   140004bcb:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   140004bcf:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   140004bd3:	4c 89 45 30          	mov    %r8,0x30(%rbp)
   140004bd7:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140004bdb:	48 89 c1             	mov    %rax,%rcx
   140004bde:	e8 2d ff ff ff       	call   140004b10 <_ZSt12__miter_baseIPPyET_S2_> (File Offset: 0x4110)
   140004be3:	48 89 c3             	mov    %rax,%rbx
   140004be6:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140004bea:	48 89 c1             	mov    %rax,%rcx
   140004bed:	e8 1e ff ff ff       	call   140004b10 <_ZSt12__miter_baseIPPyET_S2_> (File Offset: 0x4110)
   140004bf2:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   140004bf6:	49 89 d0             	mov    %rdx,%r8
   140004bf9:	48 89 da             	mov    %rbx,%rdx
   140004bfc:	48 89 c1             	mov    %rax,%rcx
   140004bff:	e8 bc 00 00 00       	call   140004cc0 <_ZSt22__copy_move_backward_aILb0EPPyS1_ET1_T0_S3_S2_> (File Offset: 0x42c0)
   140004c04:	48 83 c4 28          	add    $0x28,%rsp
   140004c08:	5b                   	pop    %rbx
   140004c09:	5d                   	pop    %rbp
   140004c0a:	c3                   	ret
   140004c0b:	90                   	nop
   140004c0c:	90                   	nop
   140004c0d:	90                   	nop
   140004c0e:	90                   	nop
   140004c0f:	90                   	nop

0000000140004c10 <_ZSt14__copy_move_a1ILb0EPPyS1_ET1_T0_S3_S2_> (File Offset: 0x4210):
   140004c10:	55                   	push   %rbp
   140004c11:	48 89 e5             	mov    %rsp,%rbp
   140004c14:	48 83 ec 20          	sub    $0x20,%rsp
   140004c18:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140004c1c:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140004c20:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140004c24:	48 8b 4d 20          	mov    0x20(%rbp),%rcx
   140004c28:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140004c2c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140004c30:	49 89 c8             	mov    %rcx,%r8
   140004c33:	48 89 c1             	mov    %rax,%rcx
   140004c36:	e8 15 00 00 00       	call   140004c50 <_ZSt14__copy_move_a2ILb0EPPyS1_ET1_T0_S3_S2_> (File Offset: 0x4250)
   140004c3b:	48 83 c4 20          	add    $0x20,%rsp
   140004c3f:	5d                   	pop    %rbp
   140004c40:	c3                   	ret
   140004c41:	90                   	nop
   140004c42:	90                   	nop
   140004c43:	90                   	nop
   140004c44:	90                   	nop
   140004c45:	90                   	nop
   140004c46:	90                   	nop
   140004c47:	90                   	nop
   140004c48:	90                   	nop
   140004c49:	90                   	nop
   140004c4a:	90                   	nop
   140004c4b:	90                   	nop
   140004c4c:	90                   	nop
   140004c4d:	90                   	nop
   140004c4e:	90                   	nop
   140004c4f:	90                   	nop

0000000140004c50 <_ZSt14__copy_move_a2ILb0EPPyS1_ET1_T0_S3_S2_> (File Offset: 0x4250):
   140004c50:	55                   	push   %rbp
   140004c51:	48 89 e5             	mov    %rsp,%rbp
   140004c54:	48 83 ec 20          	sub    $0x20,%rsp
   140004c58:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140004c5c:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140004c60:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140004c64:	48 8b 4d 20          	mov    0x20(%rbp),%rcx
   140004c68:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140004c6c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140004c70:	49 89 c8             	mov    %rcx,%r8
   140004c73:	48 89 c1             	mov    %rax,%rcx
   140004c76:	e8 b5 ef ff ff       	call   140003c30 <_ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mIPyS3_EEPT0_PT_S7_S5_> (File Offset: 0x3230)
   140004c7b:	48 83 c4 20          	add    $0x20,%rsp
   140004c7f:	5d                   	pop    %rbp
   140004c80:	c3                   	ret
   140004c81:	90                   	nop
   140004c82:	90                   	nop
   140004c83:	90                   	nop
   140004c84:	90                   	nop
   140004c85:	90                   	nop
   140004c86:	90                   	nop
   140004c87:	90                   	nop
   140004c88:	90                   	nop
   140004c89:	90                   	nop
   140004c8a:	90                   	nop
   140004c8b:	90                   	nop
   140004c8c:	90                   	nop
   140004c8d:	90                   	nop
   140004c8e:	90                   	nop
   140004c8f:	90                   	nop

0000000140004c90 <_ZSt16__deque_buf_sizey> (File Offset: 0x4290):
   140004c90:	       55                   	push   %rbp
   140004c91:	       48 89 e5             	mov    %rsp,%rbp
   140004c94:	       48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140004c98:	       48 81 7d 10 ff 01 00 	cmpq   $0x1ff,0x10(%rbp)
   140004c9f:	       00 
   140004ca0:	/----- 77 10                	ja     140004cb2 <_ZSt16__deque_buf_sizey+0x22> (File Offset: 0x42b2)
   140004ca2:	|      b8 00 02 00 00       	mov    $0x200,%eax
   140004ca7:	|      ba 00 00 00 00       	mov    $0x0,%edx
   140004cac:	|      48 f7 75 10          	divq   0x10(%rbp)
   140004cb0:	|  /-- eb 05                	jmp    140004cb7 <_ZSt16__deque_buf_sizey+0x27> (File Offset: 0x42b7)
   140004cb2:	\--|-> b8 01 00 00 00       	mov    $0x1,%eax
   140004cb7:	   \-> 5d                   	pop    %rbp
   140004cb8:	       c3                   	ret
   140004cb9:	       90                   	nop
   140004cba:	       90                   	nop
   140004cbb:	       90                   	nop
   140004cbc:	       90                   	nop
   140004cbd:	       90                   	nop
   140004cbe:	       90                   	nop
   140004cbf:	       90                   	nop

0000000140004cc0 <_ZSt22__copy_move_backward_aILb0EPPyS1_ET1_T0_S3_S2_> (File Offset: 0x42c0):
   140004cc0:	55                   	push   %rbp
   140004cc1:	56                   	push   %rsi
   140004cc2:	53                   	push   %rbx
   140004cc3:	48 83 ec 20          	sub    $0x20,%rsp
   140004cc7:	48 8d 6c 24 20       	lea    0x20(%rsp),%rbp
   140004ccc:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   140004cd0:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   140004cd4:	4c 89 45 30          	mov    %r8,0x30(%rbp)
   140004cd8:	48 8b 45 30          	mov    0x30(%rbp),%rax
   140004cdc:	48 89 c1             	mov    %rax,%rcx
   140004cdf:	e8 3c fe ff ff       	call   140004b20 <_ZSt12__niter_baseIPPyET_S2_> (File Offset: 0x4120)
   140004ce4:	48 89 c6             	mov    %rax,%rsi
   140004ce7:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140004ceb:	48 89 c1             	mov    %rax,%rcx
   140004cee:	e8 2d fe ff ff       	call   140004b20 <_ZSt12__niter_baseIPPyET_S2_> (File Offset: 0x4120)
   140004cf3:	48 89 c3             	mov    %rax,%rbx
   140004cf6:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140004cfa:	48 89 c1             	mov    %rax,%rcx
   140004cfd:	e8 1e fe ff ff       	call   140004b20 <_ZSt12__niter_baseIPPyET_S2_> (File Offset: 0x4120)
   140004d02:	49 89 f0             	mov    %rsi,%r8
   140004d05:	48 89 da             	mov    %rbx,%rdx
   140004d08:	48 89 c1             	mov    %rax,%rcx
   140004d0b:	e8 20 00 00 00       	call   140004d30 <_ZSt23__copy_move_backward_a1ILb0EPPyS1_ET1_T0_S3_S2_> (File Offset: 0x4330)
   140004d10:	48 89 c2             	mov    %rax,%rdx
   140004d13:	48 8d 45 30          	lea    0x30(%rbp),%rax
   140004d17:	48 89 c1             	mov    %rax,%rcx
   140004d1a:	e8 11 fe ff ff       	call   140004b30 <_ZSt12__niter_wrapIPPyET_RKS2_S2_> (File Offset: 0x4130)
   140004d1f:	48 83 c4 20          	add    $0x20,%rsp
   140004d23:	5b                   	pop    %rbx
   140004d24:	5e                   	pop    %rsi
   140004d25:	5d                   	pop    %rbp
   140004d26:	c3                   	ret
   140004d27:	90                   	nop
   140004d28:	90                   	nop
   140004d29:	90                   	nop
   140004d2a:	90                   	nop
   140004d2b:	90                   	nop
   140004d2c:	90                   	nop
   140004d2d:	90                   	nop
   140004d2e:	90                   	nop
   140004d2f:	90                   	nop

0000000140004d30 <_ZSt23__copy_move_backward_a1ILb0EPPyS1_ET1_T0_S3_S2_> (File Offset: 0x4330):
   140004d30:	55                   	push   %rbp
   140004d31:	48 89 e5             	mov    %rsp,%rbp
   140004d34:	48 83 ec 20          	sub    $0x20,%rsp
   140004d38:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140004d3c:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140004d40:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140004d44:	48 8b 4d 20          	mov    0x20(%rbp),%rcx
   140004d48:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140004d4c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140004d50:	49 89 c8             	mov    %rcx,%r8
   140004d53:	48 89 c1             	mov    %rax,%rcx
   140004d56:	e8 15 00 00 00       	call   140004d70 <_ZSt23__copy_move_backward_a2ILb0EPPyS1_ET1_T0_S3_S2_> (File Offset: 0x4370)
   140004d5b:	48 83 c4 20          	add    $0x20,%rsp
   140004d5f:	5d                   	pop    %rbp
   140004d60:	c3                   	ret
   140004d61:	90                   	nop
   140004d62:	90                   	nop
   140004d63:	90                   	nop
   140004d64:	90                   	nop
   140004d65:	90                   	nop
   140004d66:	90                   	nop
   140004d67:	90                   	nop
   140004d68:	90                   	nop
   140004d69:	90                   	nop
   140004d6a:	90                   	nop
   140004d6b:	90                   	nop
   140004d6c:	90                   	nop
   140004d6d:	90                   	nop
   140004d6e:	90                   	nop
   140004d6f:	90                   	nop

0000000140004d70 <_ZSt23__copy_move_backward_a2ILb0EPPyS1_ET1_T0_S3_S2_> (File Offset: 0x4370):
   140004d70:	55                   	push   %rbp
   140004d71:	48 89 e5             	mov    %rsp,%rbp
   140004d74:	48 83 ec 20          	sub    $0x20,%rsp
   140004d78:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140004d7c:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140004d80:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140004d84:	48 8b 4d 20          	mov    0x20(%rbp),%rcx
   140004d88:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140004d8c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140004d90:	49 89 c8             	mov    %rcx,%r8
   140004d93:	48 89 c1             	mov    %rax,%rcx
   140004d96:	e8 25 f2 ff ff       	call   140003fc0 <_ZNSt20__copy_move_backwardILb0ELb1ESt26random_access_iterator_tagE13__copy_move_bIPyS3_EEPT0_PT_S7_S5_> (File Offset: 0x35c0)
   140004d9b:	48 83 c4 20          	add    $0x20,%rsp
   140004d9f:	5d                   	pop    %rbp
   140004da0:	c3                   	ret
   140004da1:	90                   	nop
   140004da2:	90                   	nop
   140004da3:	90                   	nop
   140004da4:	90                   	nop
   140004da5:	90                   	nop
   140004da6:	90                   	nop
   140004da7:	90                   	nop
   140004da8:	90                   	nop
   140004da9:	90                   	nop
   140004daa:	90                   	nop
   140004dab:	90                   	nop
   140004dac:	90                   	nop
   140004dad:	90                   	nop
   140004dae:	90                   	nop
   140004daf:	90                   	nop

0000000140004db0 <_ZSt3maxIyERKT_S2_S2_> (File Offset: 0x43b0):
   140004db0:	       55                   	push   %rbp
   140004db1:	       48 89 e5             	mov    %rsp,%rbp
   140004db4:	       48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140004db8:	       48 89 55 18          	mov    %rdx,0x18(%rbp)
   140004dbc:	       48 8b 45 10          	mov    0x10(%rbp),%rax
   140004dc0:	       48 8b 10             	mov    (%rax),%rdx
   140004dc3:	       48 8b 45 18          	mov    0x18(%rbp),%rax
   140004dc7:	       48 8b 00             	mov    (%rax),%rax
   140004dca:	       48 39 c2             	cmp    %rax,%rdx
   140004dcd:	/----- 73 06                	jae    140004dd5 <_ZSt3maxIyERKT_S2_S2_+0x25> (File Offset: 0x43d5)
   140004dcf:	|      48 8b 45 18          	mov    0x18(%rbp),%rax
   140004dd3:	|  /-- eb 04                	jmp    140004dd9 <_ZSt3maxIyERKT_S2_S2_+0x29> (File Offset: 0x43d9)
   140004dd5:	\--|-> 48 8b 45 10          	mov    0x10(%rbp),%rax
   140004dd9:	   \-> 5d                   	pop    %rbp
   140004dda:	       c3                   	ret
   140004ddb:	       90                   	nop
   140004ddc:	       90                   	nop
   140004ddd:	       90                   	nop
   140004dde:	       90                   	nop
   140004ddf:	       90                   	nop

0000000140004de0 <_ZSt3minIyERKT_S2_S2_> (File Offset: 0x43e0):
   140004de0:	       55                   	push   %rbp
   140004de1:	       48 89 e5             	mov    %rsp,%rbp
   140004de4:	       48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140004de8:	       48 89 55 18          	mov    %rdx,0x18(%rbp)
   140004dec:	       48 8b 45 18          	mov    0x18(%rbp),%rax
   140004df0:	       48 8b 10             	mov    (%rax),%rdx
   140004df3:	       48 8b 45 10          	mov    0x10(%rbp),%rax
   140004df7:	       48 8b 00             	mov    (%rax),%rax
   140004dfa:	       48 39 c2             	cmp    %rax,%rdx
   140004dfd:	/----- 73 06                	jae    140004e05 <_ZSt3minIyERKT_S2_S2_+0x25> (File Offset: 0x4405)
   140004dff:	|      48 8b 45 18          	mov    0x18(%rbp),%rax
   140004e03:	|  /-- eb 04                	jmp    140004e09 <_ZSt3minIyERKT_S2_S2_+0x29> (File Offset: 0x4409)
   140004e05:	\--|-> 48 8b 45 10          	mov    0x10(%rbp),%rax
   140004e09:	   \-> 5d                   	pop    %rbp
   140004e0a:	       c3                   	ret
   140004e0b:	       90                   	nop
   140004e0c:	       90                   	nop
   140004e0d:	       90                   	nop
   140004e0e:	       90                   	nop
   140004e0f:	       90                   	nop

0000000140004e10 <_ZSt4copyIPPyS1_ET0_T_S3_S2_> (File Offset: 0x4410):
   140004e10:	55                   	push   %rbp
   140004e11:	53                   	push   %rbx
   140004e12:	48 83 ec 28          	sub    $0x28,%rsp
   140004e16:	48 8d 6c 24 20       	lea    0x20(%rsp),%rbp
   140004e1b:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   140004e1f:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   140004e23:	4c 89 45 30          	mov    %r8,0x30(%rbp)
   140004e27:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140004e2b:	48 89 c1             	mov    %rax,%rcx
   140004e2e:	e8 dd fc ff ff       	call   140004b10 <_ZSt12__miter_baseIPPyET_S2_> (File Offset: 0x4110)
   140004e33:	48 89 c3             	mov    %rax,%rbx
   140004e36:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140004e3a:	48 89 c1             	mov    %rax,%rcx
   140004e3d:	e8 ce fc ff ff       	call   140004b10 <_ZSt12__miter_baseIPPyET_S2_> (File Offset: 0x4110)
   140004e42:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   140004e46:	49 89 d0             	mov    %rdx,%r8
   140004e49:	48 89 da             	mov    %rbx,%rdx
   140004e4c:	48 89 c1             	mov    %rax,%rcx
   140004e4f:	e8 fc fc ff ff       	call   140004b50 <_ZSt13__copy_move_aILb0EPPyS1_ET1_T0_S3_S2_> (File Offset: 0x4150)
   140004e54:	48 83 c4 28          	add    $0x28,%rsp
   140004e58:	5b                   	pop    %rbx
   140004e59:	5d                   	pop    %rbp
   140004e5a:	c3                   	ret
   140004e5b:	90                   	nop
   140004e5c:	90                   	nop
   140004e5d:	90                   	nop
   140004e5e:	90                   	nop
   140004e5f:	90                   	nop

0000000140004e60 <_ZSt4moveIRyEONSt16remove_referenceIT_E4typeEOS2_> (File Offset: 0x4460):
   140004e60:	55                   	push   %rbp
   140004e61:	48 89 e5             	mov    %rsp,%rbp
   140004e64:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140004e68:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140004e6c:	5d                   	pop    %rbp
   140004e6d:	c3                   	ret
   140004e6e:	90                   	nop
   140004e6f:	90                   	nop

0000000140004e70 <_ZSt7forwardIRKyEOT_RNSt16remove_referenceIS2_E4typeE> (File Offset: 0x4470):
   140004e70:	55                   	push   %rbp
   140004e71:	48 89 e5             	mov    %rsp,%rbp
   140004e74:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140004e78:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140004e7c:	5d                   	pop    %rbp
   140004e7d:	c3                   	ret
   140004e7e:	90                   	nop
   140004e7f:	90                   	nop

0000000140004e80 <_ZSt7forwardIyEOT_RNSt16remove_referenceIS0_E4typeE> (File Offset: 0x4480):
   140004e80:	55                   	push   %rbp
   140004e81:	48 89 e5             	mov    %rsp,%rbp
   140004e84:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140004e88:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140004e8c:	5d                   	pop    %rbp
   140004e8d:	c3                   	ret
   140004e8e:	90                   	nop
   140004e8f:	90                   	nop

0000000140004e90 <_ZStmiRKSt15_Deque_iteratorIyRyPyES4_> (File Offset: 0x4490):
   140004e90:	55                   	push   %rbp
   140004e91:	48 89 e5             	mov    %rsp,%rbp
   140004e94:	48 83 ec 20          	sub    $0x20,%rsp
   140004e98:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140004e9c:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140004ea0:	e8 7b ee ff ff       	call   140003d20 <_ZNSt15_Deque_iteratorIyRyPyE14_S_buffer_sizeEv> (File Offset: 0x3320)
   140004ea5:	48 89 c1             	mov    %rax,%rcx
   140004ea8:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140004eac:	48 8b 50 18          	mov    0x18(%rax),%rdx
   140004eb0:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140004eb4:	48 8b 40 18          	mov    0x18(%rax),%rax
   140004eb8:	48 29 c2             	sub    %rax,%rdx
   140004ebb:	48 89 d0             	mov    %rdx,%rax
   140004ebe:	48 c1 f8 03          	sar    $0x3,%rax
   140004ec2:	48 89 c2             	mov    %rax,%rdx
   140004ec5:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140004ec9:	48 8b 40 18          	mov    0x18(%rax),%rax
   140004ecd:	48 85 c0             	test   %rax,%rax
   140004ed0:	0f 95 c0             	setne  %al
   140004ed3:	0f b6 c0             	movzbl %al,%eax
   140004ed6:	48 29 c2             	sub    %rax,%rdx
   140004ed9:	48 89 c8             	mov    %rcx,%rax
   140004edc:	48 0f af c2          	imul   %rdx,%rax
   140004ee0:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   140004ee4:	48 8b 0a             	mov    (%rdx),%rcx
   140004ee7:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   140004eeb:	48 8b 52 08          	mov    0x8(%rdx),%rdx
   140004eef:	48 29 d1             	sub    %rdx,%rcx
   140004ef2:	48 c1 f9 03          	sar    $0x3,%rcx
   140004ef6:	48 89 ca             	mov    %rcx,%rdx
   140004ef9:	48 01 c2             	add    %rax,%rdx
   140004efc:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140004f00:	48 8b 48 10          	mov    0x10(%rax),%rcx
   140004f04:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140004f08:	48 8b 00             	mov    (%rax),%rax
   140004f0b:	48 29 c1             	sub    %rax,%rcx
   140004f0e:	48 89 c8             	mov    %rcx,%rax
   140004f11:	48 c1 f8 03          	sar    $0x3,%rax
   140004f15:	48 01 d0             	add    %rdx,%rax
   140004f18:	48 83 c4 20          	add    $0x20,%rsp
   140004f1c:	5d                   	pop    %rbp
   140004f1d:	c3                   	ret
   140004f1e:	90                   	nop
   140004f1f:	90                   	nop

0000000140004f20 <_ZnwyPv> (File Offset: 0x4520):
   140004f20:	55                   	push   %rbp
   140004f21:	48 89 e5             	mov    %rsp,%rbp
   140004f24:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140004f28:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140004f2c:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140004f30:	5d                   	pop    %rbp
   140004f31:	c3                   	ret
   140004f32:	90                   	nop
   140004f33:	90                   	nop
   140004f34:	90                   	nop
   140004f35:	90                   	nop
   140004f36:	90                   	nop
   140004f37:	90                   	nop
   140004f38:	90                   	nop
   140004f39:	90                   	nop
   140004f3a:	90                   	nop
   140004f3b:	90                   	nop
   140004f3c:	90                   	nop
   140004f3d:	90                   	nop
   140004f3e:	90                   	nop
   140004f3f:	90                   	nop

0000000140004f40 <register_frame_ctor> (File Offset: 0x4540):
   140004f40:	e9 eb c4 ff ff       	jmp    140001430 <__gcc_register_frame> (File Offset: 0xa30)
   140004f45:	90                   	nop
   140004f46:	90                   	nop
   140004f47:	90                   	nop
   140004f48:	90                   	nop
   140004f49:	90                   	nop
   140004f4a:	90                   	nop
   140004f4b:	90                   	nop
   140004f4c:	90                   	nop
   140004f4d:	90                   	nop
   140004f4e:	90                   	nop
   140004f4f:	90                   	nop

0000000140004f50 <__CTOR_LIST__> (File Offset: 0x4550):
   140004f50:	ff                   	(bad)
   140004f51:	ff                   	(bad)
   140004f52:	ff                   	(bad)
   140004f53:	ff                   	(bad)
   140004f54:	ff                   	(bad)
   140004f55:	ff                   	(bad)
   140004f56:	ff                   	(bad)
   140004f57:	ff                   	.byte 0xff

0000000140004f58 <.ctors.65535> (File Offset: 0x4558):
   140004f58:	40                   	rex
   140004f59:	4f 00 40 01          	rex.WRXB add %r8b,0x1(%r8)
	...

0000000140004f68 <__DTOR_LIST__> (File Offset: 0x4568):
   140004f68:	ff                   	(bad)
   140004f69:	ff                   	(bad)
   140004f6a:	ff                   	(bad)
   140004f6b:	ff                   	(bad)
   140004f6c:	ff                   	(bad)
   140004f6d:	ff                   	(bad)
   140004f6e:	ff                   	(bad)
   140004f6f:	ff 00                	incl   (%rax)
   140004f71:	00 00                	add    %al,(%rax)
   140004f73:	00 00                	add    %al,(%rax)
   140004f75:	00 00                	add    %al,(%rax)
	...
