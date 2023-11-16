
a.exe:     file format pei-x86-64


Disassembly of section .text:

0000000140001000 <__mingw_invalidParameterHandler>:
   140001000:	55                   	push   %rbp
   140001001:	48 89 e5             	mov    %rsp,%rbp
   140001004:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140001008:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000100c:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140001010:	44 89 4d 28          	mov    %r9d,0x28(%rbp)
   140001014:	90                   	nop
   140001015:	5d                   	pop    %rbp
   140001016:	c3                   	ret

0000000140001017 <pre_c_init>:
   140001017:	55                   	push   %rbp
   140001018:	48 89 e5             	mov    %rsp,%rbp
   14000101b:	48 83 ec 20          	sub    $0x20,%rsp
   14000101f:	e8 54 03 00 00       	call   140001378 <check_managed_app>
   140001024:	89 05 f6 7f 00 00    	mov    %eax,0x7ff6(%rip)        # 140009020 <managedapp>
   14000102a:	48 8b 05 ff 43 00 00 	mov    0x43ff(%rip),%rax        # 140005430 <.refptr.__mingw_app_type>
   140001031:	8b 00                	mov    (%rax),%eax
   140001033:	85 c0                	test   %eax,%eax
   140001035:	74 0c                	je     140001043 <pre_c_init+0x2c>
   140001037:	b9 02 00 00 00       	mov    $0x2,%ecx
   14000103c:	e8 3f 22 00 00       	call   140003280 <__set_app_type>
   140001041:	eb 0a                	jmp    14000104d <pre_c_init+0x36>
   140001043:	b9 01 00 00 00       	mov    $0x1,%ecx
   140001048:	e8 33 22 00 00       	call   140003280 <__set_app_type>
   14000104d:	e8 ae 21 00 00       	call   140003200 <__p__fmode>
   140001052:	48 8b 15 b7 44 00 00 	mov    0x44b7(%rip),%rdx        # 140005510 <.refptr._fmode>
   140001059:	8b 12                	mov    (%rdx),%edx
   14000105b:	89 10                	mov    %edx,(%rax)
   14000105d:	e8 8e 21 00 00       	call   1400031f0 <__p__commode>
   140001062:	48 8b 15 87 44 00 00 	mov    0x4487(%rip),%rdx        # 1400054f0 <.refptr._commode>
   140001069:	8b 12                	mov    (%rdx),%edx
   14000106b:	89 10                	mov    %edx,(%rax)
   14000106d:	e8 3e 08 00 00       	call   1400018b0 <_setargv>
   140001072:	48 8b 05 27 43 00 00 	mov    0x4327(%rip),%rax        # 1400053a0 <.refptr._MINGW_INSTALL_DEBUG_MATHERR>
   140001079:	8b 00                	mov    (%rax),%eax
   14000107b:	83 f8 01             	cmp    $0x1,%eax
   14000107e:	75 0f                	jne    14000108f <pre_c_init+0x78>
   140001080:	48 8b 05 a9 44 00 00 	mov    0x44a9(%rip),%rax        # 140005530 <.refptr._matherr>
   140001087:	48 89 c1             	mov    %rax,%rcx
   14000108a:	e8 7b 13 00 00       	call   14000240a <__mingw_setusermatherr>
   14000108f:	b8 00 00 00 00       	mov    $0x0,%eax
   140001094:	48 83 c4 20          	add    $0x20,%rsp
   140001098:	5d                   	pop    %rbp
   140001099:	c3                   	ret

000000014000109a <pre_cpp_init>:
   14000109a:	55                   	push   %rbp
   14000109b:	48 89 e5             	mov    %rsp,%rbp
   14000109e:	48 83 ec 30          	sub    $0x30,%rsp
   1400010a2:	48 8b 05 97 44 00 00 	mov    0x4497(%rip),%rax        # 140005540 <.refptr._newmode>
   1400010a9:	8b 00                	mov    (%rax),%eax
   1400010ab:	89 05 77 7f 00 00    	mov    %eax,0x7f77(%rip)        # 140009028 <startinfo>
   1400010b1:	48 8b 05 48 44 00 00 	mov    0x4448(%rip),%rax        # 140005500 <.refptr._dowildcard>
   1400010b8:	8b 10                	mov    (%rax),%edx
   1400010ba:	48 8d 05 67 7f 00 00 	lea    0x7f67(%rip),%rax        # 140009028 <startinfo>
   1400010c1:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   1400010c6:	41 89 d1             	mov    %edx,%r9d
   1400010c9:	4c 8d 05 40 7f 00 00 	lea    0x7f40(%rip),%r8        # 140009010 <envp>
   1400010d0:	48 8d 05 31 7f 00 00 	lea    0x7f31(%rip),%rax        # 140009008 <argv>
   1400010d7:	48 89 c2             	mov    %rax,%rdx
   1400010da:	48 8d 05 23 7f 00 00 	lea    0x7f23(%rip),%rax        # 140009004 <argc>
   1400010e1:	48 89 c1             	mov    %rax,%rcx
   1400010e4:	e8 87 1e 00 00       	call   140002f70 <__getmainargs>
   1400010e9:	89 05 29 7f 00 00    	mov    %eax,0x7f29(%rip)        # 140009018 <argret>
   1400010ef:	90                   	nop
   1400010f0:	48 83 c4 30          	add    $0x30,%rsp
   1400010f4:	5d                   	pop    %rbp
   1400010f5:	c3                   	ret

00000001400010f6 <WinMainCRTStartup>:
   1400010f6:	55                   	push   %rbp
   1400010f7:	48 89 e5             	mov    %rsp,%rbp
   1400010fa:	48 83 ec 30          	sub    $0x30,%rsp
   1400010fe:	c7 45 fc ff 00 00 00 	movl   $0xff,-0x4(%rbp)

0000000140001105 <.l_startw>:
   140001105:	48 8b 05 24 43 00 00 	mov    0x4324(%rip),%rax        # 140005430 <.refptr.__mingw_app_type>
   14000110c:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   140001112:	e8 3d 00 00 00       	call   140001154 <__tmainCRTStartup>
   140001117:	89 45 fc             	mov    %eax,-0x4(%rbp)
   14000111a:	90                   	nop

000000014000111b <.l_endw>:
   14000111b:	90                   	nop
   14000111c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   14000111f:	48 83 c4 30          	add    $0x30,%rsp
   140001123:	5d                   	pop    %rbp
   140001124:	c3                   	ret

0000000140001125 <mainCRTStartup>:
   140001125:	55                   	push   %rbp
   140001126:	48 89 e5             	mov    %rsp,%rbp
   140001129:	48 83 ec 30          	sub    $0x30,%rsp
   14000112d:	c7 45 fc ff 00 00 00 	movl   $0xff,-0x4(%rbp)

0000000140001134 <.l_start>:
   140001134:	48 8b 05 f5 42 00 00 	mov    0x42f5(%rip),%rax        # 140005430 <.refptr.__mingw_app_type>
   14000113b:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   140001141:	e8 0e 00 00 00       	call   140001154 <__tmainCRTStartup>
   140001146:	89 45 fc             	mov    %eax,-0x4(%rbp)
   140001149:	90                   	nop

000000014000114a <.l_end>:
   14000114a:	90                   	nop
   14000114b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   14000114e:	48 83 c4 30          	add    $0x30,%rsp
   140001152:	5d                   	pop    %rbp
   140001153:	c3                   	ret

0000000140001154 <__tmainCRTStartup>:
   140001154:	55                   	push   %rbp
   140001155:	48 89 e5             	mov    %rsp,%rbp
   140001158:	48 83 ec 70          	sub    $0x70,%rsp
   14000115c:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   140001163:	00 
   140001164:	c7 45 e4 30 00 00 00 	movl   $0x30,-0x1c(%rbp)
   14000116b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   14000116e:	65 48 8b 00          	mov    %gs:(%rax),%rax
   140001172:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   140001176:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14000117a:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000117e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   140001182:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   140001189:	eb 21                	jmp    1400011ac <__tmainCRTStartup+0x58>
   14000118b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000118f:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
   140001193:	75 09                	jne    14000119e <__tmainCRTStartup+0x4a>
   140001195:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   14000119c:	eb 45                	jmp    1400011e3 <__tmainCRTStartup+0x8f>
   14000119e:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
   1400011a3:	48 8b 05 96 90 00 00 	mov    0x9096(%rip),%rax        # 14000a240 <__imp_Sleep>
   1400011aa:	ff d0                	call   *%rax
   1400011ac:	48 8b 05 dd 42 00 00 	mov    0x42dd(%rip),%rax        # 140005490 <.refptr.__native_startup_lock>
   1400011b3:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   1400011b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   1400011bb:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   1400011bf:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
   1400011c6:	00 
   1400011c7:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   1400011cb:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   1400011cf:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   1400011d3:	f0 48 0f b1 0a       	lock cmpxchg %rcx,(%rdx)
   1400011d8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   1400011dc:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   1400011e1:	75 a8                	jne    14000118b <__tmainCRTStartup+0x37>
   1400011e3:	48 8b 05 b6 42 00 00 	mov    0x42b6(%rip),%rax        # 1400054a0 <.refptr.__native_startup_state>
   1400011ea:	8b 00                	mov    (%rax),%eax
   1400011ec:	83 f8 01             	cmp    $0x1,%eax
   1400011ef:	75 0c                	jne    1400011fd <__tmainCRTStartup+0xa9>
   1400011f1:	b9 1f 00 00 00       	mov    $0x1f,%ecx
   1400011f6:	e8 d5 1e 00 00       	call   1400030d0 <_amsg_exit>
   1400011fb:	eb 3f                	jmp    14000123c <__tmainCRTStartup+0xe8>
   1400011fd:	48 8b 05 9c 42 00 00 	mov    0x429c(%rip),%rax        # 1400054a0 <.refptr.__native_startup_state>
   140001204:	8b 00                	mov    (%rax),%eax
   140001206:	85 c0                	test   %eax,%eax
   140001208:	75 28                	jne    140001232 <__tmainCRTStartup+0xde>
   14000120a:	48 8b 05 8f 42 00 00 	mov    0x428f(%rip),%rax        # 1400054a0 <.refptr.__native_startup_state>
   140001211:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   140001217:	48 8b 05 c2 42 00 00 	mov    0x42c2(%rip),%rax        # 1400054e0 <.refptr.__xi_z>
   14000121e:	48 89 c2             	mov    %rax,%rdx
   140001221:	48 8b 05 a8 42 00 00 	mov    0x42a8(%rip),%rax        # 1400054d0 <.refptr.__xi_a>
   140001228:	48 89 c1             	mov    %rax,%rcx
   14000122b:	e8 48 20 00 00       	call   140003278 <_initterm>
   140001230:	eb 0a                	jmp    14000123c <__tmainCRTStartup+0xe8>
   140001232:	c7 05 e8 7d 00 00 01 	movl   $0x1,0x7de8(%rip)        # 140009024 <has_cctor>
   140001239:	00 00 00 
   14000123c:	48 8b 05 5d 42 00 00 	mov    0x425d(%rip),%rax        # 1400054a0 <.refptr.__native_startup_state>
   140001243:	8b 00                	mov    (%rax),%eax
   140001245:	83 f8 01             	cmp    $0x1,%eax
   140001248:	75 26                	jne    140001270 <__tmainCRTStartup+0x11c>
   14000124a:	48 8b 05 6f 42 00 00 	mov    0x426f(%rip),%rax        # 1400054c0 <.refptr.__xc_z>
   140001251:	48 89 c2             	mov    %rax,%rdx
   140001254:	48 8b 05 55 42 00 00 	mov    0x4255(%rip),%rax        # 1400054b0 <.refptr.__xc_a>
   14000125b:	48 89 c1             	mov    %rax,%rcx
   14000125e:	e8 15 20 00 00       	call   140003278 <_initterm>
   140001263:	48 8b 05 36 42 00 00 	mov    0x4236(%rip),%rax        # 1400054a0 <.refptr.__native_startup_state>
   14000126a:	c7 00 02 00 00 00    	movl   $0x2,(%rax)
   140001270:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   140001274:	75 1e                	jne    140001294 <__tmainCRTStartup+0x140>
   140001276:	48 8b 05 13 42 00 00 	mov    0x4213(%rip),%rax        # 140005490 <.refptr.__native_startup_lock>
   14000127d:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   140001281:	48 c7 45 b0 00 00 00 	movq   $0x0,-0x50(%rbp)
   140001288:	00 
   140001289:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   14000128d:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   140001291:	48 87 10             	xchg   %rdx,(%rax)
   140001294:	48 8b 05 45 41 00 00 	mov    0x4145(%rip),%rax        # 1400053e0 <.refptr.__dyn_tls_init_callback>
   14000129b:	48 8b 00             	mov    (%rax),%rax
   14000129e:	48 85 c0             	test   %rax,%rax
   1400012a1:	74 1c                	je     1400012bf <__tmainCRTStartup+0x16b>
   1400012a3:	48 8b 05 36 41 00 00 	mov    0x4136(%rip),%rax        # 1400053e0 <.refptr.__dyn_tls_init_callback>
   1400012aa:	48 8b 00             	mov    (%rax),%rax
   1400012ad:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   1400012b3:	ba 02 00 00 00       	mov    $0x2,%edx
   1400012b8:	b9 00 00 00 00       	mov    $0x0,%ecx
   1400012bd:	ff d0                	call   *%rax
   1400012bf:	e8 34 10 00 00       	call   1400022f8 <_pei386_runtime_relocator>
   1400012c4:	48 8b 05 55 42 00 00 	mov    0x4255(%rip),%rax        # 140005520 <.refptr._gnu_exception_handler>
   1400012cb:	48 89 c1             	mov    %rax,%rcx
   1400012ce:	48 8b 05 63 8f 00 00 	mov    0x8f63(%rip),%rax        # 14000a238 <__imp_SetUnhandledExceptionFilter>
   1400012d5:	ff d0                	call   *%rax
   1400012d7:	48 8b 15 a2 41 00 00 	mov    0x41a2(%rip),%rdx        # 140005480 <.refptr.__mingw_oldexcpt_handler>
   1400012de:	48 89 02             	mov    %rax,(%rdx)
   1400012e1:	48 8d 05 18 fd ff ff 	lea    -0x2e8(%rip),%rax        # 140001000 <__mingw_invalidParameterHandler>
   1400012e8:	48 89 c1             	mov    %rax,%rcx
   1400012eb:	e8 98 1f 00 00       	call   140003288 <_set_invalid_parameter_handler>
   1400012f0:	e8 fb 07 00 00       	call   140001af0 <_fpreset>
   1400012f5:	8b 05 09 7d 00 00    	mov    0x7d09(%rip),%eax        # 140009004 <argc>
   1400012fb:	48 8d 15 06 7d 00 00 	lea    0x7d06(%rip),%rdx        # 140009008 <argv>
   140001302:	89 c1                	mov    %eax,%ecx
   140001304:	e8 73 01 00 00       	call   14000147c <duplicate_ppstrings>
   140001309:	e8 79 05 00 00       	call   140001887 <__main>
   14000130e:	48 8b 05 fb 40 00 00 	mov    0x40fb(%rip),%rax        # 140005410 <.refptr.__imp___initenv>
   140001315:	48 8b 00             	mov    (%rax),%rax
   140001318:	48 8b 15 f1 7c 00 00 	mov    0x7cf1(%rip),%rdx        # 140009010 <envp>
   14000131f:	48 89 10             	mov    %rdx,(%rax)
   140001322:	48 8b 0d e7 7c 00 00 	mov    0x7ce7(%rip),%rcx        # 140009010 <envp>
   140001329:	48 8b 15 d8 7c 00 00 	mov    0x7cd8(%rip),%rdx        # 140009008 <argv>
   140001330:	8b 05 ce 7c 00 00    	mov    0x7cce(%rip),%eax        # 140009004 <argc>
   140001336:	49 89 c8             	mov    %rcx,%r8
   140001339:	89 c1                	mov    %eax,%ecx
   14000133b:	e8 52 04 00 00       	call   140001792 <main>
   140001340:	89 05 d6 7c 00 00    	mov    %eax,0x7cd6(%rip)        # 14000901c <mainret>
   140001346:	8b 05 d4 7c 00 00    	mov    0x7cd4(%rip),%eax        # 140009020 <managedapp>
   14000134c:	85 c0                	test   %eax,%eax
   14000134e:	75 0d                	jne    14000135d <__tmainCRTStartup+0x209>
   140001350:	8b 05 c6 7c 00 00    	mov    0x7cc6(%rip),%eax        # 14000901c <mainret>
   140001356:	89 c1                	mov    %eax,%ecx
   140001358:	e8 4b 1f 00 00       	call   1400032a8 <exit>
   14000135d:	8b 05 c1 7c 00 00    	mov    0x7cc1(%rip),%eax        # 140009024 <has_cctor>
   140001363:	85 c0                	test   %eax,%eax
   140001365:	75 05                	jne    14000136c <__tmainCRTStartup+0x218>
   140001367:	e8 cc 1e 00 00       	call   140003238 <_cexit>
   14000136c:	8b 05 aa 7c 00 00    	mov    0x7caa(%rip),%eax        # 14000901c <mainret>
   140001372:	48 83 c4 70          	add    $0x70,%rsp
   140001376:	5d                   	pop    %rbp
   140001377:	c3                   	ret

0000000140001378 <check_managed_app>:
   140001378:	55                   	push   %rbp
   140001379:	48 89 e5             	mov    %rsp,%rbp
   14000137c:	48 83 ec 20          	sub    $0x20,%rsp
   140001380:	48 8b 05 b9 40 00 00 	mov    0x40b9(%rip),%rax        # 140005440 <.refptr.__mingw_initltsdrot_force>
   140001387:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   14000138d:	48 8b 05 bc 40 00 00 	mov    0x40bc(%rip),%rax        # 140005450 <.refptr.__mingw_initltsdyn_force>
   140001394:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   14000139a:	48 8b 05 bf 40 00 00 	mov    0x40bf(%rip),%rax        # 140005460 <.refptr.__mingw_initltssuo_force>
   1400013a1:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   1400013a7:	48 8b 05 52 40 00 00 	mov    0x4052(%rip),%rax        # 140005400 <.refptr.__image_base__>
   1400013ae:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   1400013b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400013b6:	0f b7 00             	movzwl (%rax),%eax
   1400013b9:	66 3d 4d 5a          	cmp    $0x5a4d,%ax
   1400013bd:	74 0a                	je     1400013c9 <check_managed_app+0x51>
   1400013bf:	b8 00 00 00 00       	mov    $0x0,%eax
   1400013c4:	e9 ad 00 00 00       	jmp    140001476 <check_managed_app+0xfe>
   1400013c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400013cd:	8b 40 3c             	mov    0x3c(%rax),%eax
   1400013d0:	48 63 d0             	movslq %eax,%rdx
   1400013d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400013d7:	48 01 d0             	add    %rdx,%rax
   1400013da:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   1400013de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   1400013e2:	8b 00                	mov    (%rax),%eax
   1400013e4:	3d 50 45 00 00       	cmp    $0x4550,%eax
   1400013e9:	74 0a                	je     1400013f5 <check_managed_app+0x7d>
   1400013eb:	b8 00 00 00 00       	mov    $0x0,%eax
   1400013f0:	e9 81 00 00 00       	jmp    140001476 <check_managed_app+0xfe>
   1400013f5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   1400013f9:	48 83 c0 18          	add    $0x18,%rax
   1400013fd:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   140001401:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140001405:	0f b7 00             	movzwl (%rax),%eax
   140001408:	0f b7 c0             	movzwl %ax,%eax
   14000140b:	3d 0b 01 00 00       	cmp    $0x10b,%eax
   140001410:	74 09                	je     14000141b <check_managed_app+0xa3>
   140001412:	3d 0b 02 00 00       	cmp    $0x20b,%eax
   140001417:	74 29                	je     140001442 <check_managed_app+0xca>
   140001419:	eb 56                	jmp    140001471 <check_managed_app+0xf9>
   14000141b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000141f:	8b 40 5c             	mov    0x5c(%rax),%eax
   140001422:	83 f8 0e             	cmp    $0xe,%eax
   140001425:	77 07                	ja     14000142e <check_managed_app+0xb6>
   140001427:	b8 00 00 00 00       	mov    $0x0,%eax
   14000142c:	eb 48                	jmp    140001476 <check_managed_app+0xfe>
   14000142e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140001432:	8b 80 d0 00 00 00    	mov    0xd0(%rax),%eax
   140001438:	85 c0                	test   %eax,%eax
   14000143a:	0f 95 c0             	setne  %al
   14000143d:	0f b6 c0             	movzbl %al,%eax
   140001440:	eb 34                	jmp    140001476 <check_managed_app+0xfe>
   140001442:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140001446:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   14000144a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   14000144e:	8b 40 6c             	mov    0x6c(%rax),%eax
   140001451:	83 f8 0e             	cmp    $0xe,%eax
   140001454:	77 07                	ja     14000145d <check_managed_app+0xe5>
   140001456:	b8 00 00 00 00       	mov    $0x0,%eax
   14000145b:	eb 19                	jmp    140001476 <check_managed_app+0xfe>
   14000145d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   140001461:	8b 80 e0 00 00 00    	mov    0xe0(%rax),%eax
   140001467:	85 c0                	test   %eax,%eax
   140001469:	0f 95 c0             	setne  %al
   14000146c:	0f b6 c0             	movzbl %al,%eax
   14000146f:	eb 05                	jmp    140001476 <check_managed_app+0xfe>
   140001471:	b8 00 00 00 00       	mov    $0x0,%eax
   140001476:	48 83 c4 20          	add    $0x20,%rsp
   14000147a:	5d                   	pop    %rbp
   14000147b:	c3                   	ret

000000014000147c <duplicate_ppstrings>:
   14000147c:	55                   	push   %rbp
   14000147d:	53                   	push   %rbx
   14000147e:	48 83 ec 48          	sub    $0x48,%rsp
   140001482:	48 8d 6c 24 40       	lea    0x40(%rsp),%rbp
   140001487:	89 4d 20             	mov    %ecx,0x20(%rbp)
   14000148a:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   14000148e:	8b 45 20             	mov    0x20(%rbp),%eax
   140001491:	83 c0 01             	add    $0x1,%eax
   140001494:	48 98                	cltq
   140001496:	48 c1 e0 03          	shl    $0x3,%rax
   14000149a:	48 89 c1             	mov    %rax,%rcx
   14000149d:	e8 1e 1e 00 00       	call   1400032c0 <malloc>
   1400014a2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   1400014a6:	48 8b 45 28          	mov    0x28(%rbp),%rax
   1400014aa:	48 8b 00             	mov    (%rax),%rax
   1400014ad:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   1400014b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   1400014b8:	e9 8c 00 00 00       	jmp    140001549 <duplicate_ppstrings+0xcd>
   1400014bd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   1400014c0:	48 98                	cltq
   1400014c2:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   1400014c9:	00 
   1400014ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   1400014ce:	48 01 d0             	add    %rdx,%rax
   1400014d1:	48 8b 00             	mov    (%rax),%rax
   1400014d4:	48 89 c1             	mov    %rax,%rcx
   1400014d7:	e8 fc 1d 00 00       	call   1400032d8 <strlen>
   1400014dc:	48 83 c0 01          	add    $0x1,%rax
   1400014e0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   1400014e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   1400014e7:	48 98                	cltq
   1400014e9:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   1400014f0:	00 
   1400014f1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   1400014f5:	48 8d 1c 02          	lea    (%rdx,%rax,1),%rbx
   1400014f9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   1400014fd:	48 89 c1             	mov    %rax,%rcx
   140001500:	e8 bb 1d 00 00       	call   1400032c0 <malloc>
   140001505:	48 89 03             	mov    %rax,(%rbx)
   140001508:	8b 45 fc             	mov    -0x4(%rbp),%eax
   14000150b:	48 98                	cltq
   14000150d:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   140001514:	00 
   140001515:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140001519:	48 01 d0             	add    %rdx,%rax
   14000151c:	48 8b 10             	mov    (%rax),%rdx
   14000151f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140001522:	48 98                	cltq
   140001524:	48 8d 0c c5 00 00 00 	lea    0x0(,%rax,8),%rcx
   14000152b:	00 
   14000152c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140001530:	48 01 c8             	add    %rcx,%rax
   140001533:	48 8b 00             	mov    (%rax),%rax
   140001536:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   14000153a:	49 89 c8             	mov    %rcx,%r8
   14000153d:	48 89 c1             	mov    %rax,%rcx
   140001540:	e8 83 1d 00 00       	call   1400032c8 <memcpy>
   140001545:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   140001549:	8b 45 fc             	mov    -0x4(%rbp),%eax
   14000154c:	3b 45 20             	cmp    0x20(%rbp),%eax
   14000154f:	0f 8c 68 ff ff ff    	jl     1400014bd <duplicate_ppstrings+0x41>
   140001555:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140001558:	48 98                	cltq
   14000155a:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   140001561:	00 
   140001562:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140001566:	48 01 d0             	add    %rdx,%rax
   140001569:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   140001570:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140001574:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   140001578:	48 89 10             	mov    %rdx,(%rax)
   14000157b:	90                   	nop
   14000157c:	48 83 c4 48          	add    $0x48,%rsp
   140001580:	5b                   	pop    %rbx
   140001581:	5d                   	pop    %rbp
   140001582:	c3                   	ret

0000000140001583 <atexit>:
   140001583:	55                   	push   %rbp
   140001584:	48 89 e5             	mov    %rsp,%rbp
   140001587:	48 83 ec 20          	sub    $0x20,%rsp
   14000158b:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000158f:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001593:	48 89 c1             	mov    %rax,%rcx
   140001596:	e8 d5 1a 00 00       	call   140003070 <_onexit>
   14000159b:	48 85 c0             	test   %rax,%rax
   14000159e:	74 07                	je     1400015a7 <atexit+0x24>
   1400015a0:	b8 00 00 00 00       	mov    $0x0,%eax
   1400015a5:	eb 05                	jmp    1400015ac <atexit+0x29>
   1400015a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   1400015ac:	48 83 c4 20          	add    $0x20,%rsp
   1400015b0:	5d                   	pop    %rbp
   1400015b1:	c3                   	ret
   1400015b2:	90                   	nop
   1400015b3:	90                   	nop
   1400015b4:	90                   	nop
   1400015b5:	90                   	nop
   1400015b6:	90                   	nop
   1400015b7:	90                   	nop
   1400015b8:	90                   	nop
   1400015b9:	90                   	nop
   1400015ba:	90                   	nop
   1400015bb:	90                   	nop
   1400015bc:	90                   	nop
   1400015bd:	90                   	nop
   1400015be:	90                   	nop
   1400015bf:	90                   	nop

00000001400015c0 <.weak.__register_frame_info.hmod_libgcc>:
   1400015c0:	c3                   	ret
   1400015c1:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   1400015c8:	00 00 00 00 
   1400015cc:	0f 1f 40 00          	nopl   0x0(%rax)

00000001400015d0 <.weak.__deregister_frame_info.hmod_libgcc>:
   1400015d0:	31 c0                	xor    %eax,%eax
   1400015d2:	c3                   	ret
   1400015d3:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   1400015da:	00 00 00 00 
   1400015de:	66 90                	xchg   %ax,%ax

00000001400015e0 <__gcc_register_frame>:
   1400015e0:	55                   	push   %rbp
   1400015e1:	57                   	push   %rdi
   1400015e2:	56                   	push   %rsi
   1400015e3:	53                   	push   %rbx
   1400015e4:	48 83 ec 28          	sub    $0x28,%rsp
   1400015e8:	48 8d 6c 24 20       	lea    0x20(%rsp),%rbp
   1400015ed:	48 8d 35 0c 3a 00 00 	lea    0x3a0c(%rip),%rsi        # 140005000 <.rdata>
   1400015f4:	48 89 f1             	mov    %rsi,%rcx
   1400015f7:	ff 15 13 8c 00 00    	call   *0x8c13(%rip)        # 14000a210 <__imp_GetModuleHandleA>
   1400015fd:	48 89 c3             	mov    %rax,%rbx
   140001600:	48 85 c0             	test   %rax,%rax
   140001603:	74 6b                	je     140001670 <__gcc_register_frame+0x90>
   140001605:	48 89 f1             	mov    %rsi,%rcx
   140001608:	ff 15 22 8c 00 00    	call   *0x8c22(%rip)        # 14000a230 <__imp_LoadLibraryA>
   14000160e:	48 8b 3d 03 8c 00 00 	mov    0x8c03(%rip),%rdi        # 14000a218 <__imp_GetProcAddress>
   140001615:	48 8d 15 f7 39 00 00 	lea    0x39f7(%rip),%rdx        # 140005013 <.rdata+0x13>
   14000161c:	48 89 d9             	mov    %rbx,%rcx
   14000161f:	48 89 05 1a 7a 00 00 	mov    %rax,0x7a1a(%rip)        # 140009040 <hmod_libgcc>
   140001626:	ff d7                	call   *%rdi
   140001628:	48 8d 15 fa 39 00 00 	lea    0x39fa(%rip),%rdx        # 140005029 <.rdata+0x29>
   14000162f:	48 89 d9             	mov    %rbx,%rcx
   140001632:	48 89 c6             	mov    %rax,%rsi
   140001635:	ff d7                	call   *%rdi
   140001637:	48 89 05 c2 29 00 00 	mov    %rax,0x29c2(%rip)        # 140004000 <__data_start__>
   14000163e:	48 85 f6             	test   %rsi,%rsi
   140001641:	74 10                	je     140001653 <__gcc_register_frame+0x73>
   140001643:	48 8d 15 16 7a 00 00 	lea    0x7a16(%rip),%rdx        # 140009060 <obj>
   14000164a:	48 8d 0d af 49 00 00 	lea    0x49af(%rip),%rcx        # 140006000 <__EH_FRAME_BEGIN__>
   140001651:	ff d6                	call   *%rsi
   140001653:	48 8d 0d 36 00 00 00 	lea    0x36(%rip),%rcx        # 140001690 <__gcc_deregister_frame>
   14000165a:	48 83 c4 28          	add    $0x28,%rsp
   14000165e:	5b                   	pop    %rbx
   14000165f:	5e                   	pop    %rsi
   140001660:	5f                   	pop    %rdi
   140001661:	5d                   	pop    %rbp
   140001662:	e9 1c ff ff ff       	jmp    140001583 <atexit>
   140001667:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   14000166e:	00 00 
   140001670:	48 8d 05 59 ff ff ff 	lea    -0xa7(%rip),%rax        # 1400015d0 <.weak.__deregister_frame_info.hmod_libgcc>
   140001677:	48 8d 35 42 ff ff ff 	lea    -0xbe(%rip),%rsi        # 1400015c0 <.weak.__register_frame_info.hmod_libgcc>
   14000167e:	48 89 05 7b 29 00 00 	mov    %rax,0x297b(%rip)        # 140004000 <__data_start__>
   140001685:	eb bc                	jmp    140001643 <__gcc_register_frame+0x63>
   140001687:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   14000168e:	00 00 

0000000140001690 <__gcc_deregister_frame>:
   140001690:	55                   	push   %rbp
   140001691:	48 89 e5             	mov    %rsp,%rbp
   140001694:	48 83 ec 20          	sub    $0x20,%rsp
   140001698:	48 8b 05 61 29 00 00 	mov    0x2961(%rip),%rax        # 140004000 <__data_start__>
   14000169f:	48 85 c0             	test   %rax,%rax
   1400016a2:	74 09                	je     1400016ad <__gcc_deregister_frame+0x1d>
   1400016a4:	48 8d 0d 55 49 00 00 	lea    0x4955(%rip),%rcx        # 140006000 <__EH_FRAME_BEGIN__>
   1400016ab:	ff d0                	call   *%rax
   1400016ad:	48 8b 0d 8c 79 00 00 	mov    0x798c(%rip),%rcx        # 140009040 <hmod_libgcc>
   1400016b4:	48 85 c9             	test   %rcx,%rcx
   1400016b7:	74 0f                	je     1400016c8 <__gcc_deregister_frame+0x38>
   1400016b9:	48 83 c4 20          	add    $0x20,%rsp
   1400016bd:	5d                   	pop    %rbp
   1400016be:	48 ff 25 3b 8b 00 00 	rex.W jmp *0x8b3b(%rip)        # 14000a200 <__imp_FreeLibrary>
   1400016c5:	0f 1f 00             	nopl   (%rax)
   1400016c8:	48 83 c4 20          	add    $0x20,%rsp
   1400016cc:	5d                   	pop    %rbp
   1400016cd:	c3                   	ret
   1400016ce:	90                   	nop
   1400016cf:	90                   	nop

00000001400016d0 <a__print>:
   1400016d0:	55                   	push   %rbp
   1400016d1:	48 89 e5             	mov    %rsp,%rbp
   1400016d4:	48 83 ec 20          	sub    $0x20,%rsp
   1400016d8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400016dc:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400016e0:	48 8b 00             	mov    (%rax),%rax
   1400016e3:	48 89 c2             	mov    %rax,%rdx
   1400016e6:	48 8d 05 63 39 00 00 	lea    0x3963(%rip),%rax        # 140005050 <.rdata>
   1400016ed:	48 89 c1             	mov    %rax,%rcx
   1400016f0:	e8 bb 17 00 00       	call   140002eb0 <printf>
   1400016f5:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400016f9:	48 8b 40 08          	mov    0x8(%rax),%rax
   1400016fd:	48 89 c2             	mov    %rax,%rdx
   140001700:	48 8d 05 49 39 00 00 	lea    0x3949(%rip),%rax        # 140005050 <.rdata>
   140001707:	48 89 c1             	mov    %rax,%rcx
   14000170a:	e8 a1 17 00 00       	call   140002eb0 <printf>
   14000170f:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001713:	48 8b 40 08          	mov    0x8(%rax),%rax
   140001717:	48 89 c2             	mov    %rax,%rdx
   14000171a:	48 8d 05 2f 39 00 00 	lea    0x392f(%rip),%rax        # 140005050 <.rdata>
   140001721:	48 89 c1             	mov    %rax,%rcx
   140001724:	e8 87 17 00 00       	call   140002eb0 <printf>
   140001729:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000172d:	48 8b 40 10          	mov    0x10(%rax),%rax
   140001731:	48 89 c2             	mov    %rax,%rdx
   140001734:	48 8d 05 15 39 00 00 	lea    0x3915(%rip),%rax        # 140005050 <.rdata>
   14000173b:	48 89 c1             	mov    %rax,%rcx
   14000173e:	e8 6d 17 00 00       	call   140002eb0 <printf>
   140001743:	90                   	nop
   140001744:	48 83 c4 20          	add    $0x20,%rsp
   140001748:	5d                   	pop    %rbp
   140001749:	c3                   	ret

000000014000174a <fn>:
   14000174a:	55                   	push   %rbp
   14000174b:	48 89 e5             	mov    %rsp,%rbp
   14000174e:	48 83 ec 20          	sub    $0x20,%rsp
   140001752:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140001756:	89 55 18             	mov    %edx,0x18(%rbp)
   140001759:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000175d:	48 c7 00 e9 ff ff ff 	movq   $0xffffffffffffffe9,(%rax)
   140001764:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001768:	48 c7 40 08 4e 61 bc 	movq   $0xbc614e,0x8(%rax)
   14000176f:	00 
   140001770:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001774:	48 c7 40 10 5d 3b 88 	movq   $0xffffffffff883b5d,0x10(%rax)
   14000177b:	ff 
   14000177c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001780:	48 c7 40 18 5c 00 00 	movq   $0x5c,0x18(%rax)
   140001787:	00 
   140001788:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000178c:	48 83 c4 20          	add    $0x20,%rsp
   140001790:	5d                   	pop    %rbp
   140001791:	c3                   	ret

0000000140001792 <main>:
   140001792:	55                   	push   %rbp
   140001793:	48 89 e5             	mov    %rsp,%rbp
   140001796:	48 83 ec 30          	sub    $0x30,%rsp
   14000179a:	e8 e8 00 00 00       	call   140001887 <__main>
   14000179f:	48 8d 05 a4 ff ff ff 	lea    -0x5c(%rip),%rax        # 14000174a <fn>
   1400017a6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   1400017aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400017ae:	b9 02 00 00 00       	mov    $0x2,%ecx
   1400017b3:	ff d0                	call   *%rax
   1400017b5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   1400017b9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   1400017bd:	48 89 c1             	mov    %rax,%rcx
   1400017c0:	e8 0b ff ff ff       	call   1400016d0 <a__print>
   1400017c5:	b8 00 00 00 00       	mov    $0x0,%eax
   1400017ca:	48 83 c4 30          	add    $0x30,%rsp
   1400017ce:	5d                   	pop    %rbp
   1400017cf:	c3                   	ret

00000001400017d0 <__do_global_dtors>:
   1400017d0:	55                   	push   %rbp
   1400017d1:	48 89 e5             	mov    %rsp,%rbp
   1400017d4:	48 83 ec 20          	sub    $0x20,%rsp
   1400017d8:	eb 1e                	jmp    1400017f8 <__do_global_dtors+0x28>
   1400017da:	48 8b 05 2f 28 00 00 	mov    0x282f(%rip),%rax        # 140004010 <p.0>
   1400017e1:	48 8b 00             	mov    (%rax),%rax
   1400017e4:	ff d0                	call   *%rax
   1400017e6:	48 8b 05 23 28 00 00 	mov    0x2823(%rip),%rax        # 140004010 <p.0>
   1400017ed:	48 83 c0 08          	add    $0x8,%rax
   1400017f1:	48 89 05 18 28 00 00 	mov    %rax,0x2818(%rip)        # 140004010 <p.0>
   1400017f8:	48 8b 05 11 28 00 00 	mov    0x2811(%rip),%rax        # 140004010 <p.0>
   1400017ff:	48 8b 00             	mov    (%rax),%rax
   140001802:	48 85 c0             	test   %rax,%rax
   140001805:	75 d3                	jne    1400017da <__do_global_dtors+0xa>
   140001807:	90                   	nop
   140001808:	90                   	nop
   140001809:	48 83 c4 20          	add    $0x20,%rsp
   14000180d:	5d                   	pop    %rbp
   14000180e:	c3                   	ret

000000014000180f <__do_global_ctors>:
   14000180f:	55                   	push   %rbp
   140001810:	48 89 e5             	mov    %rsp,%rbp
   140001813:	48 83 ec 30          	sub    $0x30,%rsp
   140001817:	48 8b 05 92 3b 00 00 	mov    0x3b92(%rip),%rax        # 1400053b0 <.refptr.__CTOR_LIST__>
   14000181e:	48 8b 00             	mov    (%rax),%rax
   140001821:	89 45 fc             	mov    %eax,-0x4(%rbp)
   140001824:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%rbp)
   140001828:	75 25                	jne    14000184f <__do_global_ctors+0x40>
   14000182a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   140001831:	eb 04                	jmp    140001837 <__do_global_ctors+0x28>
   140001833:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   140001837:	8b 45 fc             	mov    -0x4(%rbp),%eax
   14000183a:	8d 50 01             	lea    0x1(%rax),%edx
   14000183d:	48 8b 05 6c 3b 00 00 	mov    0x3b6c(%rip),%rax        # 1400053b0 <.refptr.__CTOR_LIST__>
   140001844:	89 d2                	mov    %edx,%edx
   140001846:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   14000184a:	48 85 c0             	test   %rax,%rax
   14000184d:	75 e4                	jne    140001833 <__do_global_ctors+0x24>
   14000184f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140001852:	89 45 f8             	mov    %eax,-0x8(%rbp)
   140001855:	eb 14                	jmp    14000186b <__do_global_ctors+0x5c>
   140001857:	48 8b 05 52 3b 00 00 	mov    0x3b52(%rip),%rax        # 1400053b0 <.refptr.__CTOR_LIST__>
   14000185e:	8b 55 f8             	mov    -0x8(%rbp),%edx
   140001861:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   140001865:	ff d0                	call   *%rax
   140001867:	83 6d f8 01          	subl   $0x1,-0x8(%rbp)
   14000186b:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
   14000186f:	75 e6                	jne    140001857 <__do_global_ctors+0x48>
   140001871:	48 8d 05 58 ff ff ff 	lea    -0xa8(%rip),%rax        # 1400017d0 <__do_global_dtors>
   140001878:	48 89 c1             	mov    %rax,%rcx
   14000187b:	e8 03 fd ff ff       	call   140001583 <atexit>
   140001880:	90                   	nop
   140001881:	48 83 c4 30          	add    $0x30,%rsp
   140001885:	5d                   	pop    %rbp
   140001886:	c3                   	ret

0000000140001887 <__main>:
   140001887:	55                   	push   %rbp
   140001888:	48 89 e5             	mov    %rsp,%rbp
   14000188b:	48 83 ec 20          	sub    $0x20,%rsp
   14000188f:	8b 05 0b 78 00 00    	mov    0x780b(%rip),%eax        # 1400090a0 <initialized>
   140001895:	85 c0                	test   %eax,%eax
   140001897:	75 0f                	jne    1400018a8 <__main+0x21>
   140001899:	c7 05 fd 77 00 00 01 	movl   $0x1,0x77fd(%rip)        # 1400090a0 <initialized>
   1400018a0:	00 00 00 
   1400018a3:	e8 67 ff ff ff       	call   14000180f <__do_global_ctors>
   1400018a8:	90                   	nop
   1400018a9:	48 83 c4 20          	add    $0x20,%rsp
   1400018ad:	5d                   	pop    %rbp
   1400018ae:	c3                   	ret
   1400018af:	90                   	nop

00000001400018b0 <_setargv>:
   1400018b0:	55                   	push   %rbp
   1400018b1:	48 89 e5             	mov    %rsp,%rbp
   1400018b4:	b8 00 00 00 00       	mov    $0x0,%eax
   1400018b9:	5d                   	pop    %rbp
   1400018ba:	c3                   	ret
   1400018bb:	90                   	nop
   1400018bc:	90                   	nop
   1400018bd:	90                   	nop
   1400018be:	90                   	nop
   1400018bf:	90                   	nop

00000001400018c0 <__dyn_tls_init>:
   1400018c0:	55                   	push   %rbp
   1400018c1:	48 89 e5             	mov    %rsp,%rbp
   1400018c4:	48 83 ec 30          	sub    $0x30,%rsp
   1400018c8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400018cc:	89 55 18             	mov    %edx,0x18(%rbp)
   1400018cf:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   1400018d3:	48 8b 05 b6 3a 00 00 	mov    0x3ab6(%rip),%rax        # 140005390 <.refptr._CRT_MT>
   1400018da:	8b 00                	mov    (%rax),%eax
   1400018dc:	83 f8 02             	cmp    $0x2,%eax
   1400018df:	74 0d                	je     1400018ee <__dyn_tls_init+0x2e>
   1400018e1:	48 8b 05 a8 3a 00 00 	mov    0x3aa8(%rip),%rax        # 140005390 <.refptr._CRT_MT>
   1400018e8:	c7 00 02 00 00 00    	movl   $0x2,(%rax)
   1400018ee:	83 7d 18 02          	cmpl   $0x2,0x18(%rbp)
   1400018f2:	74 23                	je     140001917 <__dyn_tls_init+0x57>
   1400018f4:	83 7d 18 01          	cmpl   $0x1,0x18(%rbp)
   1400018f8:	75 16                	jne    140001910 <__dyn_tls_init+0x50>
   1400018fa:	48 8b 4d 20          	mov    0x20(%rbp),%rcx
   1400018fe:	8b 55 18             	mov    0x18(%rbp),%edx
   140001901:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001905:	49 89 c8             	mov    %rcx,%r8
   140001908:	48 89 c1             	mov    %rax,%rcx
   14000190b:	e8 61 0f 00 00       	call   140002871 <__mingw_TLScallback>
   140001910:	b8 01 00 00 00       	mov    $0x1,%eax
   140001915:	eb 46                	jmp    14000195d <__dyn_tls_init+0x9d>
   140001917:	48 8d 05 32 97 00 00 	lea    0x9732(%rip),%rax        # 14000b050 <___crt_xp_end__>
   14000191e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001922:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
   140001927:	eb 22                	jmp    14000194b <__dyn_tls_init+0x8b>
   140001929:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000192d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140001931:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140001935:	48 8b 00             	mov    (%rax),%rax
   140001938:	48 85 c0             	test   %rax,%rax
   14000193b:	74 09                	je     140001946 <__dyn_tls_init+0x86>
   14000193d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140001941:	48 8b 00             	mov    (%rax),%rax
   140001944:	ff d0                	call   *%rax
   140001946:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
   14000194b:	48 8d 05 06 97 00 00 	lea    0x9706(%rip),%rax        # 14000b058 <__xd_z>
   140001952:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   140001956:	75 d1                	jne    140001929 <__dyn_tls_init+0x69>
   140001958:	b8 01 00 00 00       	mov    $0x1,%eax
   14000195d:	48 83 c4 30          	add    $0x30,%rsp
   140001961:	5d                   	pop    %rbp
   140001962:	c3                   	ret

0000000140001963 <__tlregdtor>:
   140001963:	55                   	push   %rbp
   140001964:	48 89 e5             	mov    %rsp,%rbp
   140001967:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000196b:	48 83 7d 10 00       	cmpq   $0x0,0x10(%rbp)
   140001970:	75 07                	jne    140001979 <__tlregdtor+0x16>
   140001972:	b8 00 00 00 00       	mov    $0x0,%eax
   140001977:	eb 05                	jmp    14000197e <__tlregdtor+0x1b>
   140001979:	b8 00 00 00 00       	mov    $0x0,%eax
   14000197e:	5d                   	pop    %rbp
   14000197f:	c3                   	ret

0000000140001980 <__dyn_tls_dtor>:
   140001980:	55                   	push   %rbp
   140001981:	48 89 e5             	mov    %rsp,%rbp
   140001984:	48 83 ec 20          	sub    $0x20,%rsp
   140001988:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000198c:	89 55 18             	mov    %edx,0x18(%rbp)
   14000198f:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140001993:	83 7d 18 03          	cmpl   $0x3,0x18(%rbp)
   140001997:	74 0d                	je     1400019a6 <__dyn_tls_dtor+0x26>
   140001999:	83 7d 18 00          	cmpl   $0x0,0x18(%rbp)
   14000199d:	74 07                	je     1400019a6 <__dyn_tls_dtor+0x26>
   14000199f:	b8 01 00 00 00       	mov    $0x1,%eax
   1400019a4:	eb 1b                	jmp    1400019c1 <__dyn_tls_dtor+0x41>
   1400019a6:	48 8b 4d 20          	mov    0x20(%rbp),%rcx
   1400019aa:	8b 55 18             	mov    0x18(%rbp),%edx
   1400019ad:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400019b1:	49 89 c8             	mov    %rcx,%r8
   1400019b4:	48 89 c1             	mov    %rax,%rcx
   1400019b7:	e8 b5 0e 00 00       	call   140002871 <__mingw_TLScallback>
   1400019bc:	b8 01 00 00 00       	mov    $0x1,%eax
   1400019c1:	48 83 c4 20          	add    $0x20,%rsp
   1400019c5:	5d                   	pop    %rbp
   1400019c6:	c3                   	ret
   1400019c7:	90                   	nop
   1400019c8:	90                   	nop
   1400019c9:	90                   	nop
   1400019ca:	90                   	nop
   1400019cb:	90                   	nop
   1400019cc:	90                   	nop
   1400019cd:	90                   	nop
   1400019ce:	90                   	nop
   1400019cf:	90                   	nop

00000001400019d0 <_matherr>:
   1400019d0:	55                   	push   %rbp
   1400019d1:	53                   	push   %rbx
   1400019d2:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
   1400019d9:	48 8d 6c 24 50       	lea    0x50(%rsp),%rbp
   1400019de:	0f 29 75 00          	movaps %xmm6,0x0(%rbp)
   1400019e2:	0f 29 7d 10          	movaps %xmm7,0x10(%rbp)
   1400019e6:	44 0f 29 45 20       	movaps %xmm8,0x20(%rbp)
   1400019eb:	48 89 4d 50          	mov    %rcx,0x50(%rbp)
   1400019ef:	48 8b 45 50          	mov    0x50(%rbp),%rax
   1400019f3:	8b 00                	mov    (%rax),%eax
   1400019f5:	83 f8 06             	cmp    $0x6,%eax
   1400019f8:	77 70                	ja     140001a6a <_matherr+0x9a>
   1400019fa:	89 c0                	mov    %eax,%eax
   1400019fc:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   140001a03:	00 
   140001a04:	48 8d 05 b9 37 00 00 	lea    0x37b9(%rip),%rax        # 1400051c4 <.rdata+0x124>
   140001a0b:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   140001a0e:	48 98                	cltq
   140001a10:	48 8d 15 ad 37 00 00 	lea    0x37ad(%rip),%rdx        # 1400051c4 <.rdata+0x124>
   140001a17:	48 01 d0             	add    %rdx,%rax
   140001a1a:	ff e0                	jmp    *%rax
   140001a1c:	48 8d 05 7d 36 00 00 	lea    0x367d(%rip),%rax        # 1400050a0 <.rdata>
   140001a23:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001a27:	eb 4d                	jmp    140001a76 <_matherr+0xa6>
   140001a29:	48 8d 05 8f 36 00 00 	lea    0x368f(%rip),%rax        # 1400050bf <.rdata+0x1f>
   140001a30:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001a34:	eb 40                	jmp    140001a76 <_matherr+0xa6>
   140001a36:	48 8d 05 a3 36 00 00 	lea    0x36a3(%rip),%rax        # 1400050e0 <.rdata+0x40>
   140001a3d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001a41:	eb 33                	jmp    140001a76 <_matherr+0xa6>
   140001a43:	48 8d 05 b6 36 00 00 	lea    0x36b6(%rip),%rax        # 140005100 <.rdata+0x60>
   140001a4a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001a4e:	eb 26                	jmp    140001a76 <_matherr+0xa6>
   140001a50:	48 8d 05 d1 36 00 00 	lea    0x36d1(%rip),%rax        # 140005128 <.rdata+0x88>
   140001a57:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001a5b:	eb 19                	jmp    140001a76 <_matherr+0xa6>
   140001a5d:	48 8d 05 ec 36 00 00 	lea    0x36ec(%rip),%rax        # 140005150 <.rdata+0xb0>
   140001a64:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001a68:	eb 0c                	jmp    140001a76 <_matherr+0xa6>
   140001a6a:	48 8d 05 15 37 00 00 	lea    0x3715(%rip),%rax        # 140005186 <.rdata+0xe6>
   140001a71:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001a75:	90                   	nop
   140001a76:	48 8b 45 50          	mov    0x50(%rbp),%rax
   140001a7a:	f2 44 0f 10 40 20    	movsd  0x20(%rax),%xmm8
   140001a80:	48 8b 45 50          	mov    0x50(%rbp),%rax
   140001a84:	f2 0f 10 78 18       	movsd  0x18(%rax),%xmm7
   140001a89:	48 8b 45 50          	mov    0x50(%rbp),%rax
   140001a8d:	f2 0f 10 70 10       	movsd  0x10(%rax),%xmm6
   140001a92:	48 8b 45 50          	mov    0x50(%rbp),%rax
   140001a96:	48 8b 58 08          	mov    0x8(%rax),%rbx
   140001a9a:	b9 02 00 00 00       	mov    $0x2,%ecx
   140001a9f:	e8 24 17 00 00       	call   1400031c8 <__acrt_iob_func>
   140001aa4:	48 89 c1             	mov    %rax,%rcx
   140001aa7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001aab:	f2 44 0f 11 44 24 30 	movsd  %xmm8,0x30(%rsp)
   140001ab2:	f2 0f 11 7c 24 28    	movsd  %xmm7,0x28(%rsp)
   140001ab8:	f2 0f 11 74 24 20    	movsd  %xmm6,0x20(%rsp)
   140001abe:	49 89 d9             	mov    %rbx,%r9
   140001ac1:	49 89 c0             	mov    %rax,%r8
   140001ac4:	48 8d 05 cd 36 00 00 	lea    0x36cd(%rip),%rax        # 140005198 <.rdata+0xf8>
   140001acb:	48 89 c2             	mov    %rax,%rdx
   140001ace:	e8 3d 14 00 00       	call   140002f10 <fprintf>
   140001ad3:	b8 00 00 00 00       	mov    $0x0,%eax
   140001ad8:	0f 28 75 00          	movaps 0x0(%rbp),%xmm6
   140001adc:	0f 28 7d 10          	movaps 0x10(%rbp),%xmm7
   140001ae0:	44 0f 28 45 20       	movaps 0x20(%rbp),%xmm8
   140001ae5:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
   140001aec:	5b                   	pop    %rbx
   140001aed:	5d                   	pop    %rbp
   140001aee:	c3                   	ret
   140001aef:	90                   	nop

0000000140001af0 <_fpreset>:
   140001af0:	55                   	push   %rbp
   140001af1:	48 89 e5             	mov    %rsp,%rbp
   140001af4:	db e3                	fninit
   140001af6:	90                   	nop
   140001af7:	5d                   	pop    %rbp
   140001af8:	c3                   	ret
   140001af9:	90                   	nop
   140001afa:	90                   	nop
   140001afb:	90                   	nop
   140001afc:	90                   	nop
   140001afd:	90                   	nop
   140001afe:	90                   	nop
   140001aff:	90                   	nop

0000000140001b00 <__report_error>:
   140001b00:	55                   	push   %rbp
   140001b01:	53                   	push   %rbx
   140001b02:	48 83 ec 38          	sub    $0x38,%rsp
   140001b06:	48 8d 6c 24 30       	lea    0x30(%rsp),%rbp
   140001b0b:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   140001b0f:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   140001b13:	4c 89 45 30          	mov    %r8,0x30(%rbp)
   140001b17:	4c 89 4d 38          	mov    %r9,0x38(%rbp)
   140001b1b:	48 8d 45 28          	lea    0x28(%rbp),%rax
   140001b1f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001b23:	b9 02 00 00 00       	mov    $0x2,%ecx
   140001b28:	e8 9b 16 00 00       	call   1400031c8 <__acrt_iob_func>
   140001b2d:	49 89 c1             	mov    %rax,%r9
   140001b30:	41 b8 1b 00 00 00    	mov    $0x1b,%r8d
   140001b36:	ba 01 00 00 00       	mov    $0x1,%edx
   140001b3b:	48 8d 05 9e 36 00 00 	lea    0x369e(%rip),%rax        # 1400051e0 <.rdata>
   140001b42:	48 89 c1             	mov    %rax,%rcx
   140001b45:	e8 6e 17 00 00       	call   1400032b8 <fwrite>
   140001b4a:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   140001b4e:	b9 02 00 00 00       	mov    $0x2,%ecx
   140001b53:	e8 70 16 00 00       	call   1400031c8 <__acrt_iob_func>
   140001b58:	48 89 c1             	mov    %rax,%rcx
   140001b5b:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140001b5f:	49 89 d8             	mov    %rbx,%r8
   140001b62:	48 89 c2             	mov    %rax,%rdx
   140001b65:	e8 f6 12 00 00       	call   140002e60 <vfprintf>
   140001b6a:	e8 29 17 00 00       	call   140003298 <abort>
   140001b6f:	90                   	nop

0000000140001b70 <mark_section_writable>:
   140001b70:	55                   	push   %rbp
   140001b71:	48 89 e5             	mov    %rsp,%rbp
   140001b74:	48 83 ec 60          	sub    $0x60,%rsp
   140001b78:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140001b7c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   140001b83:	e9 82 00 00 00       	jmp    140001c0a <mark_section_writable+0x9a>
   140001b88:	48 8b 0d 61 75 00 00 	mov    0x7561(%rip),%rcx        # 1400090f0 <the_secs>
   140001b8f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140001b92:	48 63 d0             	movslq %eax,%rdx
   140001b95:	48 89 d0             	mov    %rdx,%rax
   140001b98:	48 c1 e0 02          	shl    $0x2,%rax
   140001b9c:	48 01 d0             	add    %rdx,%rax
   140001b9f:	48 c1 e0 03          	shl    $0x3,%rax
   140001ba3:	48 01 c8             	add    %rcx,%rax
   140001ba6:	48 8b 40 18          	mov    0x18(%rax),%rax
   140001baa:	48 39 45 10          	cmp    %rax,0x10(%rbp)
   140001bae:	72 56                	jb     140001c06 <mark_section_writable+0x96>
   140001bb0:	48 8b 0d 39 75 00 00 	mov    0x7539(%rip),%rcx        # 1400090f0 <the_secs>
   140001bb7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140001bba:	48 63 d0             	movslq %eax,%rdx
   140001bbd:	48 89 d0             	mov    %rdx,%rax
   140001bc0:	48 c1 e0 02          	shl    $0x2,%rax
   140001bc4:	48 01 d0             	add    %rdx,%rax
   140001bc7:	48 c1 e0 03          	shl    $0x3,%rax
   140001bcb:	48 01 c8             	add    %rcx,%rax
   140001bce:	48 8b 48 18          	mov    0x18(%rax),%rcx
   140001bd2:	4c 8b 05 17 75 00 00 	mov    0x7517(%rip),%r8        # 1400090f0 <the_secs>
   140001bd9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140001bdc:	48 63 d0             	movslq %eax,%rdx
   140001bdf:	48 89 d0             	mov    %rdx,%rax
   140001be2:	48 c1 e0 02          	shl    $0x2,%rax
   140001be6:	48 01 d0             	add    %rdx,%rax
   140001be9:	48 c1 e0 03          	shl    $0x3,%rax
   140001bed:	4c 01 c0             	add    %r8,%rax
   140001bf0:	48 8b 40 20          	mov    0x20(%rax),%rax
   140001bf4:	8b 40 08             	mov    0x8(%rax),%eax
   140001bf7:	89 c0                	mov    %eax,%eax
   140001bf9:	48 01 c8             	add    %rcx,%rax
   140001bfc:	48 39 45 10          	cmp    %rax,0x10(%rbp)
   140001c00:	0f 82 42 02 00 00    	jb     140001e48 <mark_section_writable+0x2d8>
   140001c06:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   140001c0a:	8b 05 e8 74 00 00    	mov    0x74e8(%rip),%eax        # 1400090f8 <maxSections>
   140001c10:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   140001c13:	0f 8c 6f ff ff ff    	jl     140001b88 <mark_section_writable+0x18>
   140001c19:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001c1d:	48 89 c1             	mov    %rax,%rcx
   140001c20:	e8 26 0f 00 00       	call   140002b4b <__mingw_GetSectionForAddress>
   140001c25:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140001c29:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   140001c2e:	75 16                	jne    140001c46 <mark_section_writable+0xd6>
   140001c30:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001c34:	48 89 c2             	mov    %rax,%rdx
   140001c37:	48 8d 05 c2 35 00 00 	lea    0x35c2(%rip),%rax        # 140005200 <.rdata+0x20>
   140001c3e:	48 89 c1             	mov    %rax,%rcx
   140001c41:	e8 ba fe ff ff       	call   140001b00 <__report_error>
   140001c46:	48 8b 0d a3 74 00 00 	mov    0x74a3(%rip),%rcx        # 1400090f0 <the_secs>
   140001c4d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140001c50:	48 63 d0             	movslq %eax,%rdx
   140001c53:	48 89 d0             	mov    %rdx,%rax
   140001c56:	48 c1 e0 02          	shl    $0x2,%rax
   140001c5a:	48 01 d0             	add    %rdx,%rax
   140001c5d:	48 c1 e0 03          	shl    $0x3,%rax
   140001c61:	48 8d 14 01          	lea    (%rcx,%rax,1),%rdx
   140001c65:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140001c69:	48 89 42 20          	mov    %rax,0x20(%rdx)
   140001c6d:	48 8b 0d 7c 74 00 00 	mov    0x747c(%rip),%rcx        # 1400090f0 <the_secs>
   140001c74:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140001c77:	48 63 d0             	movslq %eax,%rdx
   140001c7a:	48 89 d0             	mov    %rdx,%rax
   140001c7d:	48 c1 e0 02          	shl    $0x2,%rax
   140001c81:	48 01 d0             	add    %rdx,%rax
   140001c84:	48 c1 e0 03          	shl    $0x3,%rax
   140001c88:	48 01 c8             	add    %rcx,%rax
   140001c8b:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   140001c91:	e8 01 10 00 00       	call   140002c97 <_GetPEImageBase>
   140001c96:	48 89 c1             	mov    %rax,%rcx
   140001c99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140001c9d:	8b 40 0c             	mov    0xc(%rax),%eax
   140001ca0:	41 89 c1             	mov    %eax,%r9d
   140001ca3:	4c 8b 05 46 74 00 00 	mov    0x7446(%rip),%r8        # 1400090f0 <the_secs>
   140001caa:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140001cad:	48 63 d0             	movslq %eax,%rdx
   140001cb0:	48 89 d0             	mov    %rdx,%rax
   140001cb3:	48 c1 e0 02          	shl    $0x2,%rax
   140001cb7:	48 01 d0             	add    %rdx,%rax
   140001cba:	48 c1 e0 03          	shl    $0x3,%rax
   140001cbe:	4c 01 c0             	add    %r8,%rax
   140001cc1:	4a 8d 14 09          	lea    (%rcx,%r9,1),%rdx
   140001cc5:	48 89 50 18          	mov    %rdx,0x18(%rax)
   140001cc9:	48 8b 0d 20 74 00 00 	mov    0x7420(%rip),%rcx        # 1400090f0 <the_secs>
   140001cd0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140001cd3:	48 63 d0             	movslq %eax,%rdx
   140001cd6:	48 89 d0             	mov    %rdx,%rax
   140001cd9:	48 c1 e0 02          	shl    $0x2,%rax
   140001cdd:	48 01 d0             	add    %rdx,%rax
   140001ce0:	48 c1 e0 03          	shl    $0x3,%rax
   140001ce4:	48 01 c8             	add    %rcx,%rax
   140001ce7:	48 8b 40 18          	mov    0x18(%rax),%rax
   140001ceb:	48 8d 55 c0          	lea    -0x40(%rbp),%rdx
   140001cef:	41 b8 30 00 00 00    	mov    $0x30,%r8d
   140001cf5:	48 89 c1             	mov    %rax,%rcx
   140001cf8:	48 8b 05 59 85 00 00 	mov    0x8559(%rip),%rax        # 14000a258 <__imp_VirtualQuery>
   140001cff:	ff d0                	call   *%rax
   140001d01:	48 85 c0             	test   %rax,%rax
   140001d04:	75 3d                	jne    140001d43 <mark_section_writable+0x1d3>
   140001d06:	48 8b 0d e3 73 00 00 	mov    0x73e3(%rip),%rcx        # 1400090f0 <the_secs>
   140001d0d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140001d10:	48 63 d0             	movslq %eax,%rdx
   140001d13:	48 89 d0             	mov    %rdx,%rax
   140001d16:	48 c1 e0 02          	shl    $0x2,%rax
   140001d1a:	48 01 d0             	add    %rdx,%rax
   140001d1d:	48 c1 e0 03          	shl    $0x3,%rax
   140001d21:	48 01 c8             	add    %rcx,%rax
   140001d24:	48 8b 50 18          	mov    0x18(%rax),%rdx
   140001d28:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140001d2c:	8b 40 08             	mov    0x8(%rax),%eax
   140001d2f:	49 89 d0             	mov    %rdx,%r8
   140001d32:	89 c2                	mov    %eax,%edx
   140001d34:	48 8d 05 e5 34 00 00 	lea    0x34e5(%rip),%rax        # 140005220 <.rdata+0x40>
   140001d3b:	48 89 c1             	mov    %rax,%rcx
   140001d3e:	e8 bd fd ff ff       	call   140001b00 <__report_error>
   140001d43:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   140001d46:	83 f8 40             	cmp    $0x40,%eax
   140001d49:	0f 84 e8 00 00 00    	je     140001e37 <mark_section_writable+0x2c7>
   140001d4f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   140001d52:	83 f8 04             	cmp    $0x4,%eax
   140001d55:	0f 84 dc 00 00 00    	je     140001e37 <mark_section_writable+0x2c7>
   140001d5b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   140001d5e:	3d 80 00 00 00       	cmp    $0x80,%eax
   140001d63:	0f 84 ce 00 00 00    	je     140001e37 <mark_section_writable+0x2c7>
   140001d69:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   140001d6c:	83 f8 08             	cmp    $0x8,%eax
   140001d6f:	0f 84 c2 00 00 00    	je     140001e37 <mark_section_writable+0x2c7>
   140001d75:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   140001d78:	83 f8 02             	cmp    $0x2,%eax
   140001d7b:	75 09                	jne    140001d86 <mark_section_writable+0x216>
   140001d7d:	c7 45 f8 04 00 00 00 	movl   $0x4,-0x8(%rbp)
   140001d84:	eb 07                	jmp    140001d8d <mark_section_writable+0x21d>
   140001d86:	c7 45 f8 40 00 00 00 	movl   $0x40,-0x8(%rbp)
   140001d8d:	48 8b 0d 5c 73 00 00 	mov    0x735c(%rip),%rcx        # 1400090f0 <the_secs>
   140001d94:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140001d97:	48 63 d0             	movslq %eax,%rdx
   140001d9a:	48 89 d0             	mov    %rdx,%rax
   140001d9d:	48 c1 e0 02          	shl    $0x2,%rax
   140001da1:	48 01 d0             	add    %rdx,%rax
   140001da4:	48 c1 e0 03          	shl    $0x3,%rax
   140001da8:	48 8d 14 01          	lea    (%rcx,%rax,1),%rdx
   140001dac:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   140001db0:	48 89 42 08          	mov    %rax,0x8(%rdx)
   140001db4:	48 8b 0d 35 73 00 00 	mov    0x7335(%rip),%rcx        # 1400090f0 <the_secs>
   140001dbb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140001dbe:	48 63 d0             	movslq %eax,%rdx
   140001dc1:	48 89 d0             	mov    %rdx,%rax
   140001dc4:	48 c1 e0 02          	shl    $0x2,%rax
   140001dc8:	48 01 d0             	add    %rdx,%rax
   140001dcb:	48 c1 e0 03          	shl    $0x3,%rax
   140001dcf:	48 8d 14 01          	lea    (%rcx,%rax,1),%rdx
   140001dd3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   140001dd7:	48 89 42 10          	mov    %rax,0x10(%rdx)
   140001ddb:	48 8b 0d 0e 73 00 00 	mov    0x730e(%rip),%rcx        # 1400090f0 <the_secs>
   140001de2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140001de5:	48 63 d0             	movslq %eax,%rdx
   140001de8:	48 89 d0             	mov    %rdx,%rax
   140001deb:	48 c1 e0 02          	shl    $0x2,%rax
   140001def:	48 01 d0             	add    %rdx,%rax
   140001df2:	48 c1 e0 03          	shl    $0x3,%rax
   140001df6:	48 01 c8             	add    %rcx,%rax
   140001df9:	49 89 c0             	mov    %rax,%r8
   140001dfc:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   140001e00:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   140001e04:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   140001e07:	4d 89 c1             	mov    %r8,%r9
   140001e0a:	41 89 c8             	mov    %ecx,%r8d
   140001e0d:	48 89 c1             	mov    %rax,%rcx
   140001e10:	48 8b 05 39 84 00 00 	mov    0x8439(%rip),%rax        # 14000a250 <__imp_VirtualProtect>
   140001e17:	ff d0                	call   *%rax
   140001e19:	85 c0                	test   %eax,%eax
   140001e1b:	75 1a                	jne    140001e37 <mark_section_writable+0x2c7>
   140001e1d:	48 8b 05 e4 83 00 00 	mov    0x83e4(%rip),%rax        # 14000a208 <__imp_GetLastError>
   140001e24:	ff d0                	call   *%rax
   140001e26:	89 c2                	mov    %eax,%edx
   140001e28:	48 8d 05 29 34 00 00 	lea    0x3429(%rip),%rax        # 140005258 <.rdata+0x78>
   140001e2f:	48 89 c1             	mov    %rax,%rcx
   140001e32:	e8 c9 fc ff ff       	call   140001b00 <__report_error>
   140001e37:	8b 05 bb 72 00 00    	mov    0x72bb(%rip),%eax        # 1400090f8 <maxSections>
   140001e3d:	83 c0 01             	add    $0x1,%eax
   140001e40:	89 05 b2 72 00 00    	mov    %eax,0x72b2(%rip)        # 1400090f8 <maxSections>
   140001e46:	eb 01                	jmp    140001e49 <mark_section_writable+0x2d9>
   140001e48:	90                   	nop
   140001e49:	48 83 c4 60          	add    $0x60,%rsp
   140001e4d:	5d                   	pop    %rbp
   140001e4e:	c3                   	ret

0000000140001e4f <restore_modified_sections>:
   140001e4f:	55                   	push   %rbp
   140001e50:	48 89 e5             	mov    %rsp,%rbp
   140001e53:	48 83 ec 30          	sub    $0x30,%rsp
   140001e57:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   140001e5e:	e9 ad 00 00 00       	jmp    140001f10 <restore_modified_sections+0xc1>
   140001e63:	48 8b 0d 86 72 00 00 	mov    0x7286(%rip),%rcx        # 1400090f0 <the_secs>
   140001e6a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140001e6d:	48 63 d0             	movslq %eax,%rdx
   140001e70:	48 89 d0             	mov    %rdx,%rax
   140001e73:	48 c1 e0 02          	shl    $0x2,%rax
   140001e77:	48 01 d0             	add    %rdx,%rax
   140001e7a:	48 c1 e0 03          	shl    $0x3,%rax
   140001e7e:	48 01 c8             	add    %rcx,%rax
   140001e81:	8b 00                	mov    (%rax),%eax
   140001e83:	85 c0                	test   %eax,%eax
   140001e85:	0f 84 80 00 00 00    	je     140001f0b <restore_modified_sections+0xbc>
   140001e8b:	48 8b 0d 5e 72 00 00 	mov    0x725e(%rip),%rcx        # 1400090f0 <the_secs>
   140001e92:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140001e95:	48 63 d0             	movslq %eax,%rdx
   140001e98:	48 89 d0             	mov    %rdx,%rax
   140001e9b:	48 c1 e0 02          	shl    $0x2,%rax
   140001e9f:	48 01 d0             	add    %rdx,%rax
   140001ea2:	48 c1 e0 03          	shl    $0x3,%rax
   140001ea6:	48 01 c8             	add    %rcx,%rax
   140001ea9:	44 8b 10             	mov    (%rax),%r10d
   140001eac:	48 8b 0d 3d 72 00 00 	mov    0x723d(%rip),%rcx        # 1400090f0 <the_secs>
   140001eb3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140001eb6:	48 63 d0             	movslq %eax,%rdx
   140001eb9:	48 89 d0             	mov    %rdx,%rax
   140001ebc:	48 c1 e0 02          	shl    $0x2,%rax
   140001ec0:	48 01 d0             	add    %rdx,%rax
   140001ec3:	48 c1 e0 03          	shl    $0x3,%rax
   140001ec7:	48 01 c8             	add    %rcx,%rax
   140001eca:	48 8b 48 10          	mov    0x10(%rax),%rcx
   140001ece:	4c 8b 05 1b 72 00 00 	mov    0x721b(%rip),%r8        # 1400090f0 <the_secs>
   140001ed5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140001ed8:	48 63 d0             	movslq %eax,%rdx
   140001edb:	48 89 d0             	mov    %rdx,%rax
   140001ede:	48 c1 e0 02          	shl    $0x2,%rax
   140001ee2:	48 01 d0             	add    %rdx,%rax
   140001ee5:	48 c1 e0 03          	shl    $0x3,%rax
   140001ee9:	4c 01 c0             	add    %r8,%rax
   140001eec:	48 8b 40 08          	mov    0x8(%rax),%rax
   140001ef0:	48 8d 55 f8          	lea    -0x8(%rbp),%rdx
   140001ef4:	49 89 d1             	mov    %rdx,%r9
   140001ef7:	45 89 d0             	mov    %r10d,%r8d
   140001efa:	48 89 ca             	mov    %rcx,%rdx
   140001efd:	48 89 c1             	mov    %rax,%rcx
   140001f00:	48 8b 05 49 83 00 00 	mov    0x8349(%rip),%rax        # 14000a250 <__imp_VirtualProtect>
   140001f07:	ff d0                	call   *%rax
   140001f09:	eb 01                	jmp    140001f0c <restore_modified_sections+0xbd>
   140001f0b:	90                   	nop
   140001f0c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   140001f10:	8b 05 e2 71 00 00    	mov    0x71e2(%rip),%eax        # 1400090f8 <maxSections>
   140001f16:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   140001f19:	0f 8c 44 ff ff ff    	jl     140001e63 <restore_modified_sections+0x14>
   140001f1f:	90                   	nop
   140001f20:	90                   	nop
   140001f21:	48 83 c4 30          	add    $0x30,%rsp
   140001f25:	5d                   	pop    %rbp
   140001f26:	c3                   	ret

0000000140001f27 <__write_memory>:
   140001f27:	55                   	push   %rbp
   140001f28:	48 89 e5             	mov    %rsp,%rbp
   140001f2b:	48 83 ec 20          	sub    $0x20,%rsp
   140001f2f:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140001f33:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140001f37:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140001f3b:	48 83 7d 20 00       	cmpq   $0x0,0x20(%rbp)
   140001f40:	74 25                	je     140001f67 <__write_memory+0x40>
   140001f42:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001f46:	48 89 c1             	mov    %rax,%rcx
   140001f49:	e8 22 fc ff ff       	call   140001b70 <mark_section_writable>
   140001f4e:	48 8b 4d 20          	mov    0x20(%rbp),%rcx
   140001f52:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140001f56:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001f5a:	49 89 c8             	mov    %rcx,%r8
   140001f5d:	48 89 c1             	mov    %rax,%rcx
   140001f60:	e8 63 13 00 00       	call   1400032c8 <memcpy>
   140001f65:	eb 01                	jmp    140001f68 <__write_memory+0x41>
   140001f67:	90                   	nop
   140001f68:	48 83 c4 20          	add    $0x20,%rsp
   140001f6c:	5d                   	pop    %rbp
   140001f6d:	c3                   	ret

0000000140001f6e <do_pseudo_reloc>:
   140001f6e:	55                   	push   %rbp
   140001f6f:	48 89 e5             	mov    %rsp,%rbp
   140001f72:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   140001f76:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140001f7a:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140001f7e:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140001f82:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140001f86:	48 2b 45 10          	sub    0x10(%rbp),%rax
   140001f8a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   140001f8e:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001f92:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001f96:	48 83 7d e0 07       	cmpq   $0x7,-0x20(%rbp)
   140001f9b:	0f 8e 50 03 00 00    	jle    1400022f1 <do_pseudo_reloc+0x383>
   140001fa1:	48 83 7d e0 0b       	cmpq   $0xb,-0x20(%rbp)
   140001fa6:	7e 25                	jle    140001fcd <do_pseudo_reloc+0x5f>
   140001fa8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001fac:	8b 00                	mov    (%rax),%eax
   140001fae:	85 c0                	test   %eax,%eax
   140001fb0:	75 1b                	jne    140001fcd <do_pseudo_reloc+0x5f>
   140001fb2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001fb6:	8b 40 04             	mov    0x4(%rax),%eax
   140001fb9:	85 c0                	test   %eax,%eax
   140001fbb:	75 10                	jne    140001fcd <do_pseudo_reloc+0x5f>
   140001fbd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001fc1:	8b 40 08             	mov    0x8(%rax),%eax
   140001fc4:	85 c0                	test   %eax,%eax
   140001fc6:	75 05                	jne    140001fcd <do_pseudo_reloc+0x5f>
   140001fc8:	48 83 45 f8 0c       	addq   $0xc,-0x8(%rbp)
   140001fcd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001fd1:	8b 00                	mov    (%rax),%eax
   140001fd3:	85 c0                	test   %eax,%eax
   140001fd5:	75 0b                	jne    140001fe2 <do_pseudo_reloc+0x74>
   140001fd7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001fdb:	8b 40 04             	mov    0x4(%rax),%eax
   140001fde:	85 c0                	test   %eax,%eax
   140001fe0:	74 59                	je     14000203b <do_pseudo_reloc+0xcd>
   140001fe2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001fe6:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   140001fea:	eb 40                	jmp    14000202c <do_pseudo_reloc+0xbe>
   140001fec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140001ff0:	8b 40 04             	mov    0x4(%rax),%eax
   140001ff3:	89 c2                	mov    %eax,%edx
   140001ff5:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140001ff9:	48 01 d0             	add    %rdx,%rax
   140001ffc:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   140002000:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   140002004:	8b 10                	mov    (%rax),%edx
   140002006:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000200a:	8b 00                	mov    (%rax),%eax
   14000200c:	01 d0                	add    %edx,%eax
   14000200e:	89 45 b4             	mov    %eax,-0x4c(%rbp)
   140002011:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   140002015:	48 8d 55 b4          	lea    -0x4c(%rbp),%rdx
   140002019:	41 b8 04 00 00 00    	mov    $0x4,%r8d
   14000201f:	48 89 c1             	mov    %rax,%rcx
   140002022:	e8 00 ff ff ff       	call   140001f27 <__write_memory>
   140002027:	48 83 45 e8 08       	addq   $0x8,-0x18(%rbp)
   14000202c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140002030:	48 3b 45 18          	cmp    0x18(%rbp),%rax
   140002034:	72 b6                	jb     140001fec <do_pseudo_reloc+0x7e>
   140002036:	e9 b7 02 00 00       	jmp    1400022f2 <do_pseudo_reloc+0x384>
   14000203b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000203f:	8b 40 08             	mov    0x8(%rax),%eax
   140002042:	83 f8 01             	cmp    $0x1,%eax
   140002045:	74 18                	je     14000205f <do_pseudo_reloc+0xf1>
   140002047:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000204b:	8b 40 08             	mov    0x8(%rax),%eax
   14000204e:	89 c2                	mov    %eax,%edx
   140002050:	48 8d 05 29 32 00 00 	lea    0x3229(%rip),%rax        # 140005280 <.rdata+0xa0>
   140002057:	48 89 c1             	mov    %rax,%rcx
   14000205a:	e8 a1 fa ff ff       	call   140001b00 <__report_error>
   14000205f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002063:	48 83 c0 0c          	add    $0xc,%rax
   140002067:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000206b:	e9 71 02 00 00       	jmp    1400022e1 <do_pseudo_reloc+0x373>
   140002070:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140002074:	8b 40 04             	mov    0x4(%rax),%eax
   140002077:	89 c2                	mov    %eax,%edx
   140002079:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000207d:	48 01 d0             	add    %rdx,%rax
   140002080:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   140002084:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140002088:	8b 00                	mov    (%rax),%eax
   14000208a:	89 c2                	mov    %eax,%edx
   14000208c:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140002090:	48 01 d0             	add    %rdx,%rax
   140002093:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   140002097:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14000209b:	48 8b 00             	mov    (%rax),%rax
   14000209e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   1400020a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   1400020a6:	8b 40 08             	mov    0x8(%rax),%eax
   1400020a9:	0f b6 c0             	movzbl %al,%eax
   1400020ac:	83 f8 40             	cmp    $0x40,%eax
   1400020af:	0f 84 b6 00 00 00    	je     14000216b <do_pseudo_reloc+0x1fd>
   1400020b5:	83 f8 40             	cmp    $0x40,%eax
   1400020b8:	0f 87 ba 00 00 00    	ja     140002178 <do_pseudo_reloc+0x20a>
   1400020be:	83 f8 20             	cmp    $0x20,%eax
   1400020c1:	74 77                	je     14000213a <do_pseudo_reloc+0x1cc>
   1400020c3:	83 f8 20             	cmp    $0x20,%eax
   1400020c6:	0f 87 ac 00 00 00    	ja     140002178 <do_pseudo_reloc+0x20a>
   1400020cc:	83 f8 08             	cmp    $0x8,%eax
   1400020cf:	74 0a                	je     1400020db <do_pseudo_reloc+0x16d>
   1400020d1:	83 f8 10             	cmp    $0x10,%eax
   1400020d4:	74 38                	je     14000210e <do_pseudo_reloc+0x1a0>
   1400020d6:	e9 9d 00 00 00       	jmp    140002178 <do_pseudo_reloc+0x20a>
   1400020db:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   1400020df:	0f b6 00             	movzbl (%rax),%eax
   1400020e2:	0f b6 c0             	movzbl %al,%eax
   1400020e5:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   1400020e9:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   1400020ed:	25 80 00 00 00       	and    $0x80,%eax
   1400020f2:	48 85 c0             	test   %rax,%rax
   1400020f5:	0f 84 a0 00 00 00    	je     14000219b <do_pseudo_reloc+0x22d>
   1400020fb:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   1400020ff:	48 0d 00 ff ff ff    	or     $0xffffffffffffff00,%rax
   140002105:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   140002109:	e9 8d 00 00 00       	jmp    14000219b <do_pseudo_reloc+0x22d>
   14000210e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   140002112:	0f b7 00             	movzwl (%rax),%eax
   140002115:	0f b7 c0             	movzwl %ax,%eax
   140002118:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   14000211c:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   140002120:	25 00 80 00 00       	and    $0x8000,%eax
   140002125:	48 85 c0             	test   %rax,%rax
   140002128:	74 74                	je     14000219e <do_pseudo_reloc+0x230>
   14000212a:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   14000212e:	48 0d 00 00 ff ff    	or     $0xffffffffffff0000,%rax
   140002134:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   140002138:	eb 64                	jmp    14000219e <do_pseudo_reloc+0x230>
   14000213a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   14000213e:	8b 00                	mov    (%rax),%eax
   140002140:	89 c0                	mov    %eax,%eax
   140002142:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   140002146:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   14000214a:	25 00 00 00 80       	and    $0x80000000,%eax
   14000214f:	48 85 c0             	test   %rax,%rax
   140002152:	74 4d                	je     1400021a1 <do_pseudo_reloc+0x233>
   140002154:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   140002158:	48 ba 00 00 00 00 ff 	movabs $0xffffffff00000000,%rdx
   14000215f:	ff ff ff 
   140002162:	48 09 d0             	or     %rdx,%rax
   140002165:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   140002169:	eb 36                	jmp    1400021a1 <do_pseudo_reloc+0x233>
   14000216b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   14000216f:	48 8b 00             	mov    (%rax),%rax
   140002172:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   140002176:	eb 2a                	jmp    1400021a2 <do_pseudo_reloc+0x234>
   140002178:	48 c7 45 b8 00 00 00 	movq   $0x0,-0x48(%rbp)
   14000217f:	00 
   140002180:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140002184:	8b 40 08             	mov    0x8(%rax),%eax
   140002187:	0f b6 c0             	movzbl %al,%eax
   14000218a:	89 c2                	mov    %eax,%edx
   14000218c:	48 8d 05 25 31 00 00 	lea    0x3125(%rip),%rax        # 1400052b8 <.rdata+0xd8>
   140002193:	48 89 c1             	mov    %rax,%rcx
   140002196:	e8 65 f9 ff ff       	call   140001b00 <__report_error>
   14000219b:	90                   	nop
   14000219c:	eb 04                	jmp    1400021a2 <do_pseudo_reloc+0x234>
   14000219e:	90                   	nop
   14000219f:	eb 01                	jmp    1400021a2 <do_pseudo_reloc+0x234>
   1400021a1:	90                   	nop
   1400021a2:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   1400021a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   1400021aa:	8b 00                	mov    (%rax),%eax
   1400021ac:	89 c2                	mov    %eax,%edx
   1400021ae:	48 8b 45 20          	mov    0x20(%rbp),%rax
   1400021b2:	48 01 c2             	add    %rax,%rdx
   1400021b5:	48 89 c8             	mov    %rcx,%rax
   1400021b8:	48 29 d0             	sub    %rdx,%rax
   1400021bb:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   1400021bf:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   1400021c3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   1400021c7:	48 01 d0             	add    %rdx,%rax
   1400021ca:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   1400021ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   1400021d2:	8b 40 08             	mov    0x8(%rax),%eax
   1400021d5:	25 ff 00 00 00       	and    $0xff,%eax
   1400021da:	89 45 d4             	mov    %eax,-0x2c(%rbp)
   1400021dd:	83 7d d4 3f          	cmpl   $0x3f,-0x2c(%rbp)
   1400021e1:	77 70                	ja     140002253 <do_pseudo_reloc+0x2e5>
   1400021e3:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   1400021e6:	ba 01 00 00 00       	mov    $0x1,%edx
   1400021eb:	89 c1                	mov    %eax,%ecx
   1400021ed:	48 d3 e2             	shl    %cl,%rdx
   1400021f0:	48 89 d0             	mov    %rdx,%rax
   1400021f3:	48 83 e8 01          	sub    $0x1,%rax
   1400021f7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   1400021fb:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   1400021fe:	83 e8 01             	sub    $0x1,%eax
   140002201:	48 c7 c2 ff ff ff ff 	mov    $0xffffffffffffffff,%rdx
   140002208:	89 c1                	mov    %eax,%ecx
   14000220a:	48 d3 e2             	shl    %cl,%rdx
   14000220d:	48 89 d0             	mov    %rdx,%rax
   140002210:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   140002214:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   140002218:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
   14000221c:	7c 0a                	jl     140002228 <do_pseudo_reloc+0x2ba>
   14000221e:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   140002222:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
   140002226:	7e 2b                	jle    140002253 <do_pseudo_reloc+0x2e5>
   140002228:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   14000222c:	4c 8b 45 d8          	mov    -0x28(%rbp),%r8
   140002230:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   140002234:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   140002237:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   14000223c:	4d 89 c1             	mov    %r8,%r9
   14000223f:	49 89 c8             	mov    %rcx,%r8
   140002242:	89 c2                	mov    %eax,%edx
   140002244:	48 8d 05 9d 30 00 00 	lea    0x309d(%rip),%rax        # 1400052e8 <.rdata+0x108>
   14000224b:	48 89 c1             	mov    %rax,%rcx
   14000224e:	e8 ad f8 ff ff       	call   140001b00 <__report_error>
   140002253:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140002257:	8b 40 08             	mov    0x8(%rax),%eax
   14000225a:	0f b6 c0             	movzbl %al,%eax
   14000225d:	83 f8 40             	cmp    $0x40,%eax
   140002260:	74 63                	je     1400022c5 <do_pseudo_reloc+0x357>
   140002262:	83 f8 40             	cmp    $0x40,%eax
   140002265:	77 75                	ja     1400022dc <do_pseudo_reloc+0x36e>
   140002267:	83 f8 20             	cmp    $0x20,%eax
   14000226a:	74 41                	je     1400022ad <do_pseudo_reloc+0x33f>
   14000226c:	83 f8 20             	cmp    $0x20,%eax
   14000226f:	77 6b                	ja     1400022dc <do_pseudo_reloc+0x36e>
   140002271:	83 f8 08             	cmp    $0x8,%eax
   140002274:	74 07                	je     14000227d <do_pseudo_reloc+0x30f>
   140002276:	83 f8 10             	cmp    $0x10,%eax
   140002279:	74 1a                	je     140002295 <do_pseudo_reloc+0x327>
   14000227b:	eb 5f                	jmp    1400022dc <do_pseudo_reloc+0x36e>
   14000227d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   140002281:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   140002285:	41 b8 01 00 00 00    	mov    $0x1,%r8d
   14000228b:	48 89 c1             	mov    %rax,%rcx
   14000228e:	e8 94 fc ff ff       	call   140001f27 <__write_memory>
   140002293:	eb 47                	jmp    1400022dc <do_pseudo_reloc+0x36e>
   140002295:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   140002299:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   14000229d:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   1400022a3:	48 89 c1             	mov    %rax,%rcx
   1400022a6:	e8 7c fc ff ff       	call   140001f27 <__write_memory>
   1400022ab:	eb 2f                	jmp    1400022dc <do_pseudo_reloc+0x36e>
   1400022ad:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   1400022b1:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   1400022b5:	41 b8 04 00 00 00    	mov    $0x4,%r8d
   1400022bb:	48 89 c1             	mov    %rax,%rcx
   1400022be:	e8 64 fc ff ff       	call   140001f27 <__write_memory>
   1400022c3:	eb 17                	jmp    1400022dc <do_pseudo_reloc+0x36e>
   1400022c5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   1400022c9:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   1400022cd:	41 b8 08 00 00 00    	mov    $0x8,%r8d
   1400022d3:	48 89 c1             	mov    %rax,%rcx
   1400022d6:	e8 4c fc ff ff       	call   140001f27 <__write_memory>
   1400022db:	90                   	nop
   1400022dc:	48 83 45 f0 0c       	addq   $0xc,-0x10(%rbp)
   1400022e1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   1400022e5:	48 3b 45 18          	cmp    0x18(%rbp),%rax
   1400022e9:	0f 82 81 fd ff ff    	jb     140002070 <do_pseudo_reloc+0x102>
   1400022ef:	eb 01                	jmp    1400022f2 <do_pseudo_reloc+0x384>
   1400022f1:	90                   	nop
   1400022f2:	48 83 ec 80          	sub    $0xffffffffffffff80,%rsp
   1400022f6:	5d                   	pop    %rbp
   1400022f7:	c3                   	ret

00000001400022f8 <_pei386_runtime_relocator>:
   1400022f8:	55                   	push   %rbp
   1400022f9:	48 89 e5             	mov    %rsp,%rbp
   1400022fc:	48 83 ec 30          	sub    $0x30,%rsp
   140002300:	8b 05 f6 6d 00 00    	mov    0x6df6(%rip),%eax        # 1400090fc <was_init.0>
   140002306:	85 c0                	test   %eax,%eax
   140002308:	0f 85 88 00 00 00    	jne    140002396 <_pei386_runtime_relocator+0x9e>
   14000230e:	8b 05 e8 6d 00 00    	mov    0x6de8(%rip),%eax        # 1400090fc <was_init.0>
   140002314:	83 c0 01             	add    $0x1,%eax
   140002317:	89 05 df 6d 00 00    	mov    %eax,0x6ddf(%rip)        # 1400090fc <was_init.0>
   14000231d:	e8 79 08 00 00       	call   140002b9b <__mingw_GetSectionCount>
   140002322:	89 45 fc             	mov    %eax,-0x4(%rbp)
   140002325:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140002328:	48 63 d0             	movslq %eax,%rdx
   14000232b:	48 89 d0             	mov    %rdx,%rax
   14000232e:	48 c1 e0 02          	shl    $0x2,%rax
   140002332:	48 01 d0             	add    %rdx,%rax
   140002335:	48 c1 e0 03          	shl    $0x3,%rax
   140002339:	48 83 c0 0f          	add    $0xf,%rax
   14000233d:	48 c1 e8 04          	shr    $0x4,%rax
   140002341:	48 c1 e0 04          	shl    $0x4,%rax
   140002345:	e8 d6 0a 00 00       	call   140002e20 <___chkstk_ms>
   14000234a:	48 29 c4             	sub    %rax,%rsp
   14000234d:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
   140002352:	48 83 c0 0f          	add    $0xf,%rax
   140002356:	48 c1 e8 04          	shr    $0x4,%rax
   14000235a:	48 c1 e0 04          	shl    $0x4,%rax
   14000235e:	48 89 05 8b 6d 00 00 	mov    %rax,0x6d8b(%rip)        # 1400090f0 <the_secs>
   140002365:	c7 05 89 6d 00 00 00 	movl   $0x0,0x6d89(%rip)        # 1400090f8 <maxSections>
   14000236c:	00 00 00 
   14000236f:	4c 8b 05 8a 30 00 00 	mov    0x308a(%rip),%r8        # 140005400 <.refptr.__image_base__>
   140002376:	48 8b 05 43 30 00 00 	mov    0x3043(%rip),%rax        # 1400053c0 <.refptr.__RUNTIME_PSEUDO_RELOC_LIST_END__>
   14000237d:	48 89 c2             	mov    %rax,%rdx
   140002380:	48 8b 05 49 30 00 00 	mov    0x3049(%rip),%rax        # 1400053d0 <.refptr.__RUNTIME_PSEUDO_RELOC_LIST__>
   140002387:	48 89 c1             	mov    %rax,%rcx
   14000238a:	e8 df fb ff ff       	call   140001f6e <do_pseudo_reloc>
   14000238f:	e8 bb fa ff ff       	call   140001e4f <restore_modified_sections>
   140002394:	eb 01                	jmp    140002397 <_pei386_runtime_relocator+0x9f>
   140002396:	90                   	nop
   140002397:	48 89 ec             	mov    %rbp,%rsp
   14000239a:	5d                   	pop    %rbp
   14000239b:	c3                   	ret
   14000239c:	90                   	nop
   14000239d:	90                   	nop
   14000239e:	90                   	nop
   14000239f:	90                   	nop

00000001400023a0 <__mingw_raise_matherr>:
   1400023a0:	55                   	push   %rbp
   1400023a1:	48 89 e5             	mov    %rsp,%rbp
   1400023a4:	48 83 ec 50          	sub    $0x50,%rsp
   1400023a8:	89 4d 10             	mov    %ecx,0x10(%rbp)
   1400023ab:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400023af:	f2 0f 11 55 20       	movsd  %xmm2,0x20(%rbp)
   1400023b4:	f2 0f 11 5d 28       	movsd  %xmm3,0x28(%rbp)
   1400023b9:	48 8b 05 40 6d 00 00 	mov    0x6d40(%rip),%rax        # 140009100 <stUserMathErr>
   1400023c0:	48 85 c0             	test   %rax,%rax
   1400023c3:	74 3e                	je     140002403 <__mingw_raise_matherr+0x63>
   1400023c5:	8b 45 10             	mov    0x10(%rbp),%eax
   1400023c8:	89 45 d0             	mov    %eax,-0x30(%rbp)
   1400023cb:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400023cf:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   1400023d3:	f2 0f 10 45 20       	movsd  0x20(%rbp),%xmm0
   1400023d8:	f2 0f 11 45 e0       	movsd  %xmm0,-0x20(%rbp)
   1400023dd:	f2 0f 10 45 28       	movsd  0x28(%rbp),%xmm0
   1400023e2:	f2 0f 11 45 e8       	movsd  %xmm0,-0x18(%rbp)
   1400023e7:	f2 0f 10 45 30       	movsd  0x30(%rbp),%xmm0
   1400023ec:	f2 0f 11 45 f0       	movsd  %xmm0,-0x10(%rbp)
   1400023f1:	48 8b 15 08 6d 00 00 	mov    0x6d08(%rip),%rdx        # 140009100 <stUserMathErr>
   1400023f8:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   1400023fc:	48 89 c1             	mov    %rax,%rcx
   1400023ff:	ff d2                	call   *%rdx
   140002401:	eb 01                	jmp    140002404 <__mingw_raise_matherr+0x64>
   140002403:	90                   	nop
   140002404:	48 83 c4 50          	add    $0x50,%rsp
   140002408:	5d                   	pop    %rbp
   140002409:	c3                   	ret

000000014000240a <__mingw_setusermatherr>:
   14000240a:	55                   	push   %rbp
   14000240b:	48 89 e5             	mov    %rsp,%rbp
   14000240e:	48 83 ec 20          	sub    $0x20,%rsp
   140002412:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002416:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000241a:	48 89 05 df 6c 00 00 	mov    %rax,0x6cdf(%rip)        # 140009100 <stUserMathErr>
   140002421:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002425:	48 89 c1             	mov    %rax,%rcx
   140002428:	e8 e3 0d 00 00       	call   140003210 <__setusermatherr>
   14000242d:	90                   	nop
   14000242e:	48 83 c4 20          	add    $0x20,%rsp
   140002432:	5d                   	pop    %rbp
   140002433:	c3                   	ret
   140002434:	90                   	nop
   140002435:	90                   	nop
   140002436:	90                   	nop
   140002437:	90                   	nop
   140002438:	90                   	nop
   140002439:	90                   	nop
   14000243a:	90                   	nop
   14000243b:	90                   	nop
   14000243c:	90                   	nop
   14000243d:	90                   	nop
   14000243e:	90                   	nop
   14000243f:	90                   	nop

0000000140002440 <_gnu_exception_handler>:
   140002440:	55                   	push   %rbp
   140002441:	48 89 e5             	mov    %rsp,%rbp
   140002444:	48 83 ec 30          	sub    $0x30,%rsp
   140002448:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000244c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   140002453:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   14000245a:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000245e:	48 8b 00             	mov    (%rax),%rax
   140002461:	8b 00                	mov    (%rax),%eax
   140002463:	25 ff ff ff 20       	and    $0x20ffffff,%eax
   140002468:	3d 43 43 47 20       	cmp    $0x20474343,%eax
   14000246d:	75 1b                	jne    14000248a <_gnu_exception_handler+0x4a>
   14000246f:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002473:	48 8b 00             	mov    (%rax),%rax
   140002476:	8b 40 04             	mov    0x4(%rax),%eax
   140002479:	83 e0 01             	and    $0x1,%eax
   14000247c:	85 c0                	test   %eax,%eax
   14000247e:	75 0a                	jne    14000248a <_gnu_exception_handler+0x4a>
   140002480:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   140002485:	e9 d3 01 00 00       	jmp    14000265d <_gnu_exception_handler+0x21d>
   14000248a:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000248e:	48 8b 00             	mov    (%rax),%rax
   140002491:	8b 00                	mov    (%rax),%eax
   140002493:	3d 96 00 00 c0       	cmp    $0xc0000096,%eax
   140002498:	0f 87 8d 01 00 00    	ja     14000262b <_gnu_exception_handler+0x1eb>
   14000249e:	3d 8c 00 00 c0       	cmp    $0xc000008c,%eax
   1400024a3:	73 43                	jae    1400024e8 <_gnu_exception_handler+0xa8>
   1400024a5:	3d 1d 00 00 c0       	cmp    $0xc000001d,%eax
   1400024aa:	0f 84 bf 00 00 00    	je     14000256f <_gnu_exception_handler+0x12f>
   1400024b0:	3d 1d 00 00 c0       	cmp    $0xc000001d,%eax
   1400024b5:	0f 87 70 01 00 00    	ja     14000262b <_gnu_exception_handler+0x1eb>
   1400024bb:	3d 08 00 00 c0       	cmp    $0xc0000008,%eax
   1400024c0:	0f 84 5c 01 00 00    	je     140002622 <_gnu_exception_handler+0x1e2>
   1400024c6:	3d 08 00 00 c0       	cmp    $0xc0000008,%eax
   1400024cb:	0f 87 5a 01 00 00    	ja     14000262b <_gnu_exception_handler+0x1eb>
   1400024d1:	3d 02 00 00 80       	cmp    $0x80000002,%eax
   1400024d6:	0f 84 46 01 00 00    	je     140002622 <_gnu_exception_handler+0x1e2>
   1400024dc:	3d 05 00 00 c0       	cmp    $0xc0000005,%eax
   1400024e1:	74 35                	je     140002518 <_gnu_exception_handler+0xd8>
   1400024e3:	e9 43 01 00 00       	jmp    14000262b <_gnu_exception_handler+0x1eb>
   1400024e8:	05 74 ff ff 3f       	add    $0x3fffff74,%eax
   1400024ed:	83 f8 0a             	cmp    $0xa,%eax
   1400024f0:	0f 87 35 01 00 00    	ja     14000262b <_gnu_exception_handler+0x1eb>
   1400024f6:	89 c0                	mov    %eax,%eax
   1400024f8:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   1400024ff:	00 
   140002500:	48 8d 05 39 2e 00 00 	lea    0x2e39(%rip),%rax        # 140005340 <.rdata>
   140002507:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   14000250a:	48 98                	cltq
   14000250c:	48 8d 15 2d 2e 00 00 	lea    0x2e2d(%rip),%rdx        # 140005340 <.rdata>
   140002513:	48 01 d0             	add    %rdx,%rax
   140002516:	ff e0                	jmp    *%rax
   140002518:	ba 00 00 00 00       	mov    $0x0,%edx
   14000251d:	b9 0b 00 00 00       	mov    $0xb,%ecx
   140002522:	e8 a9 0d 00 00       	call   1400032d0 <signal>
   140002527:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000252b:	48 83 7d f0 01       	cmpq   $0x1,-0x10(%rbp)
   140002530:	75 1b                	jne    14000254d <_gnu_exception_handler+0x10d>
   140002532:	ba 01 00 00 00       	mov    $0x1,%edx
   140002537:	b9 0b 00 00 00       	mov    $0xb,%ecx
   14000253c:	e8 8f 0d 00 00       	call   1400032d0 <signal>
   140002541:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   140002548:	e9 e1 00 00 00       	jmp    14000262e <_gnu_exception_handler+0x1ee>
   14000254d:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   140002552:	0f 84 d6 00 00 00    	je     14000262e <_gnu_exception_handler+0x1ee>
   140002558:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000255c:	b9 0b 00 00 00       	mov    $0xb,%ecx
   140002561:	ff d0                	call   *%rax
   140002563:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   14000256a:	e9 bf 00 00 00       	jmp    14000262e <_gnu_exception_handler+0x1ee>
   14000256f:	ba 00 00 00 00       	mov    $0x0,%edx
   140002574:	b9 04 00 00 00       	mov    $0x4,%ecx
   140002579:	e8 52 0d 00 00       	call   1400032d0 <signal>
   14000257e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140002582:	48 83 7d f0 01       	cmpq   $0x1,-0x10(%rbp)
   140002587:	75 1b                	jne    1400025a4 <_gnu_exception_handler+0x164>
   140002589:	ba 01 00 00 00       	mov    $0x1,%edx
   14000258e:	b9 04 00 00 00       	mov    $0x4,%ecx
   140002593:	e8 38 0d 00 00       	call   1400032d0 <signal>
   140002598:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   14000259f:	e9 8d 00 00 00       	jmp    140002631 <_gnu_exception_handler+0x1f1>
   1400025a4:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   1400025a9:	0f 84 82 00 00 00    	je     140002631 <_gnu_exception_handler+0x1f1>
   1400025af:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   1400025b3:	b9 04 00 00 00       	mov    $0x4,%ecx
   1400025b8:	ff d0                	call   *%rax
   1400025ba:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   1400025c1:	eb 6e                	jmp    140002631 <_gnu_exception_handler+0x1f1>
   1400025c3:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   1400025ca:	ba 00 00 00 00       	mov    $0x0,%edx
   1400025cf:	b9 08 00 00 00       	mov    $0x8,%ecx
   1400025d4:	e8 f7 0c 00 00       	call   1400032d0 <signal>
   1400025d9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   1400025dd:	48 83 7d f0 01       	cmpq   $0x1,-0x10(%rbp)
   1400025e2:	75 23                	jne    140002607 <_gnu_exception_handler+0x1c7>
   1400025e4:	ba 01 00 00 00       	mov    $0x1,%edx
   1400025e9:	b9 08 00 00 00       	mov    $0x8,%ecx
   1400025ee:	e8 dd 0c 00 00       	call   1400032d0 <signal>
   1400025f3:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
   1400025f7:	74 05                	je     1400025fe <_gnu_exception_handler+0x1be>
   1400025f9:	e8 f2 f4 ff ff       	call   140001af0 <_fpreset>
   1400025fe:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   140002605:	eb 2d                	jmp    140002634 <_gnu_exception_handler+0x1f4>
   140002607:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   14000260c:	74 26                	je     140002634 <_gnu_exception_handler+0x1f4>
   14000260e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140002612:	b9 08 00 00 00       	mov    $0x8,%ecx
   140002617:	ff d0                	call   *%rax
   140002619:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   140002620:	eb 12                	jmp    140002634 <_gnu_exception_handler+0x1f4>
   140002622:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   140002629:	eb 0a                	jmp    140002635 <_gnu_exception_handler+0x1f5>
   14000262b:	90                   	nop
   14000262c:	eb 07                	jmp    140002635 <_gnu_exception_handler+0x1f5>
   14000262e:	90                   	nop
   14000262f:	eb 04                	jmp    140002635 <_gnu_exception_handler+0x1f5>
   140002631:	90                   	nop
   140002632:	eb 01                	jmp    140002635 <_gnu_exception_handler+0x1f5>
   140002634:	90                   	nop
   140002635:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   140002639:	75 1f                	jne    14000265a <_gnu_exception_handler+0x21a>
   14000263b:	48 8b 05 de 6a 00 00 	mov    0x6ade(%rip),%rax        # 140009120 <__mingw_oldexcpt_handler>
   140002642:	48 85 c0             	test   %rax,%rax
   140002645:	74 13                	je     14000265a <_gnu_exception_handler+0x21a>
   140002647:	48 8b 15 d2 6a 00 00 	mov    0x6ad2(%rip),%rdx        # 140009120 <__mingw_oldexcpt_handler>
   14000264e:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002652:	48 89 c1             	mov    %rax,%rcx
   140002655:	ff d2                	call   *%rdx
   140002657:	89 45 fc             	mov    %eax,-0x4(%rbp)
   14000265a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   14000265d:	48 83 c4 30          	add    $0x30,%rsp
   140002661:	5d                   	pop    %rbp
   140002662:	c3                   	ret
   140002663:	90                   	nop
   140002664:	90                   	nop
   140002665:	90                   	nop
   140002666:	90                   	nop
   140002667:	90                   	nop
   140002668:	90                   	nop
   140002669:	90                   	nop
   14000266a:	90                   	nop
   14000266b:	90                   	nop
   14000266c:	90                   	nop
   14000266d:	90                   	nop
   14000266e:	90                   	nop
   14000266f:	90                   	nop

0000000140002670 <___w64_mingwthr_add_key_dtor>:
   140002670:	55                   	push   %rbp
   140002671:	48 89 e5             	mov    %rsp,%rbp
   140002674:	48 83 ec 30          	sub    $0x30,%rsp
   140002678:	89 4d 10             	mov    %ecx,0x10(%rbp)
   14000267b:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000267f:	8b 05 e3 6a 00 00    	mov    0x6ae3(%rip),%eax        # 140009168 <__mingwthr_cs_init>
   140002685:	85 c0                	test   %eax,%eax
   140002687:	75 07                	jne    140002690 <___w64_mingwthr_add_key_dtor+0x20>
   140002689:	b8 00 00 00 00       	mov    $0x0,%eax
   14000268e:	eb 7b                	jmp    14000270b <___w64_mingwthr_add_key_dtor+0x9b>
   140002690:	ba 18 00 00 00       	mov    $0x18,%edx
   140002695:	b9 01 00 00 00       	mov    $0x1,%ecx
   14000269a:	e8 01 0c 00 00       	call   1400032a0 <calloc>
   14000269f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   1400026a3:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   1400026a8:	75 07                	jne    1400026b1 <___w64_mingwthr_add_key_dtor+0x41>
   1400026aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   1400026af:	eb 5a                	jmp    14000270b <___w64_mingwthr_add_key_dtor+0x9b>
   1400026b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400026b5:	8b 55 10             	mov    0x10(%rbp),%edx
   1400026b8:	89 10                	mov    %edx,(%rax)
   1400026ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400026be:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   1400026c2:	48 89 50 08          	mov    %rdx,0x8(%rax)
   1400026c6:	48 8d 05 73 6a 00 00 	lea    0x6a73(%rip),%rax        # 140009140 <__mingwthr_cs>
   1400026cd:	48 89 c1             	mov    %rax,%rcx
   1400026d0:	48 8b 05 21 7b 00 00 	mov    0x7b21(%rip),%rax        # 14000a1f8 <__imp_EnterCriticalSection>
   1400026d7:	ff d0                	call   *%rax
   1400026d9:	48 8b 15 90 6a 00 00 	mov    0x6a90(%rip),%rdx        # 140009170 <key_dtor_list>
   1400026e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400026e4:	48 89 50 10          	mov    %rdx,0x10(%rax)
   1400026e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400026ec:	48 89 05 7d 6a 00 00 	mov    %rax,0x6a7d(%rip)        # 140009170 <key_dtor_list>
   1400026f3:	48 8d 05 46 6a 00 00 	lea    0x6a46(%rip),%rax        # 140009140 <__mingwthr_cs>
   1400026fa:	48 89 c1             	mov    %rax,%rcx
   1400026fd:	48 8b 05 24 7b 00 00 	mov    0x7b24(%rip),%rax        # 14000a228 <__imp_LeaveCriticalSection>
   140002704:	ff d0                	call   *%rax
   140002706:	b8 00 00 00 00       	mov    $0x0,%eax
   14000270b:	48 83 c4 30          	add    $0x30,%rsp
   14000270f:	5d                   	pop    %rbp
   140002710:	c3                   	ret

0000000140002711 <___w64_mingwthr_remove_key_dtor>:
   140002711:	55                   	push   %rbp
   140002712:	48 89 e5             	mov    %rsp,%rbp
   140002715:	48 83 ec 30          	sub    $0x30,%rsp
   140002719:	89 4d 10             	mov    %ecx,0x10(%rbp)
   14000271c:	8b 05 46 6a 00 00    	mov    0x6a46(%rip),%eax        # 140009168 <__mingwthr_cs_init>
   140002722:	85 c0                	test   %eax,%eax
   140002724:	75 0a                	jne    140002730 <___w64_mingwthr_remove_key_dtor+0x1f>
   140002726:	b8 00 00 00 00       	mov    $0x0,%eax
   14000272b:	e9 9c 00 00 00       	jmp    1400027cc <___w64_mingwthr_remove_key_dtor+0xbb>
   140002730:	48 8d 05 09 6a 00 00 	lea    0x6a09(%rip),%rax        # 140009140 <__mingwthr_cs>
   140002737:	48 89 c1             	mov    %rax,%rcx
   14000273a:	48 8b 05 b7 7a 00 00 	mov    0x7ab7(%rip),%rax        # 14000a1f8 <__imp_EnterCriticalSection>
   140002741:	ff d0                	call   *%rax
   140002743:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   14000274a:	00 
   14000274b:	48 8b 05 1e 6a 00 00 	mov    0x6a1e(%rip),%rax        # 140009170 <key_dtor_list>
   140002752:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140002756:	eb 55                	jmp    1400027ad <___w64_mingwthr_remove_key_dtor+0x9c>
   140002758:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000275c:	8b 00                	mov    (%rax),%eax
   14000275e:	39 45 10             	cmp    %eax,0x10(%rbp)
   140002761:	75 36                	jne    140002799 <___w64_mingwthr_remove_key_dtor+0x88>
   140002763:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   140002768:	75 11                	jne    14000277b <___w64_mingwthr_remove_key_dtor+0x6a>
   14000276a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000276e:	48 8b 40 10          	mov    0x10(%rax),%rax
   140002772:	48 89 05 f7 69 00 00 	mov    %rax,0x69f7(%rip)        # 140009170 <key_dtor_list>
   140002779:	eb 10                	jmp    14000278b <___w64_mingwthr_remove_key_dtor+0x7a>
   14000277b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000277f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   140002783:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002787:	48 89 50 10          	mov    %rdx,0x10(%rax)
   14000278b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000278f:	48 89 c1             	mov    %rax,%rcx
   140002792:	e8 19 0b 00 00       	call   1400032b0 <free>
   140002797:	eb 1b                	jmp    1400027b4 <___w64_mingwthr_remove_key_dtor+0xa3>
   140002799:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000279d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   1400027a1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   1400027a5:	48 8b 40 10          	mov    0x10(%rax),%rax
   1400027a9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   1400027ad:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   1400027b2:	75 a4                	jne    140002758 <___w64_mingwthr_remove_key_dtor+0x47>
   1400027b4:	48 8d 05 85 69 00 00 	lea    0x6985(%rip),%rax        # 140009140 <__mingwthr_cs>
   1400027bb:	48 89 c1             	mov    %rax,%rcx
   1400027be:	48 8b 05 63 7a 00 00 	mov    0x7a63(%rip),%rax        # 14000a228 <__imp_LeaveCriticalSection>
   1400027c5:	ff d0                	call   *%rax
   1400027c7:	b8 00 00 00 00       	mov    $0x0,%eax
   1400027cc:	48 83 c4 30          	add    $0x30,%rsp
   1400027d0:	5d                   	pop    %rbp
   1400027d1:	c3                   	ret

00000001400027d2 <__mingwthr_run_key_dtors>:
   1400027d2:	55                   	push   %rbp
   1400027d3:	48 89 e5             	mov    %rsp,%rbp
   1400027d6:	48 83 ec 30          	sub    $0x30,%rsp
   1400027da:	8b 05 88 69 00 00    	mov    0x6988(%rip),%eax        # 140009168 <__mingwthr_cs_init>
   1400027e0:	85 c0                	test   %eax,%eax
   1400027e2:	0f 84 82 00 00 00    	je     14000286a <__mingwthr_run_key_dtors+0x98>
   1400027e8:	48 8d 05 51 69 00 00 	lea    0x6951(%rip),%rax        # 140009140 <__mingwthr_cs>
   1400027ef:	48 89 c1             	mov    %rax,%rcx
   1400027f2:	48 8b 05 ff 79 00 00 	mov    0x79ff(%rip),%rax        # 14000a1f8 <__imp_EnterCriticalSection>
   1400027f9:	ff d0                	call   *%rax
   1400027fb:	48 8b 05 6e 69 00 00 	mov    0x696e(%rip),%rax        # 140009170 <key_dtor_list>
   140002802:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140002806:	eb 46                	jmp    14000284e <__mingwthr_run_key_dtors+0x7c>
   140002808:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000280c:	8b 00                	mov    (%rax),%eax
   14000280e:	89 c1                	mov    %eax,%ecx
   140002810:	48 8b 05 31 7a 00 00 	mov    0x7a31(%rip),%rax        # 14000a248 <__imp_TlsGetValue>
   140002817:	ff d0                	call   *%rax
   140002819:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000281d:	48 8b 05 e4 79 00 00 	mov    0x79e4(%rip),%rax        # 14000a208 <__imp_GetLastError>
   140002824:	ff d0                	call   *%rax
   140002826:	85 c0                	test   %eax,%eax
   140002828:	75 18                	jne    140002842 <__mingwthr_run_key_dtors+0x70>
   14000282a:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   14000282f:	74 11                	je     140002842 <__mingwthr_run_key_dtors+0x70>
   140002831:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002835:	48 8b 50 08          	mov    0x8(%rax),%rdx
   140002839:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000283d:	48 89 c1             	mov    %rax,%rcx
   140002840:	ff d2                	call   *%rdx
   140002842:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002846:	48 8b 40 10          	mov    0x10(%rax),%rax
   14000284a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000284e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   140002853:	75 b3                	jne    140002808 <__mingwthr_run_key_dtors+0x36>
   140002855:	48 8d 05 e4 68 00 00 	lea    0x68e4(%rip),%rax        # 140009140 <__mingwthr_cs>
   14000285c:	48 89 c1             	mov    %rax,%rcx
   14000285f:	48 8b 05 c2 79 00 00 	mov    0x79c2(%rip),%rax        # 14000a228 <__imp_LeaveCriticalSection>
   140002866:	ff d0                	call   *%rax
   140002868:	eb 01                	jmp    14000286b <__mingwthr_run_key_dtors+0x99>
   14000286a:	90                   	nop
   14000286b:	48 83 c4 30          	add    $0x30,%rsp
   14000286f:	5d                   	pop    %rbp
   140002870:	c3                   	ret

0000000140002871 <__mingw_TLScallback>:
   140002871:	55                   	push   %rbp
   140002872:	48 89 e5             	mov    %rsp,%rbp
   140002875:	48 83 ec 30          	sub    $0x30,%rsp
   140002879:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000287d:	89 55 18             	mov    %edx,0x18(%rbp)
   140002880:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140002884:	83 7d 18 03          	cmpl   $0x3,0x18(%rbp)
   140002888:	0f 84 cc 00 00 00    	je     14000295a <__mingw_TLScallback+0xe9>
   14000288e:	83 7d 18 03          	cmpl   $0x3,0x18(%rbp)
   140002892:	0f 87 ca 00 00 00    	ja     140002962 <__mingw_TLScallback+0xf1>
   140002898:	83 7d 18 02          	cmpl   $0x2,0x18(%rbp)
   14000289c:	0f 84 b1 00 00 00    	je     140002953 <__mingw_TLScallback+0xe2>
   1400028a2:	83 7d 18 02          	cmpl   $0x2,0x18(%rbp)
   1400028a6:	0f 87 b6 00 00 00    	ja     140002962 <__mingw_TLScallback+0xf1>
   1400028ac:	83 7d 18 00          	cmpl   $0x0,0x18(%rbp)
   1400028b0:	74 33                	je     1400028e5 <__mingw_TLScallback+0x74>
   1400028b2:	83 7d 18 01          	cmpl   $0x1,0x18(%rbp)
   1400028b6:	0f 85 a6 00 00 00    	jne    140002962 <__mingw_TLScallback+0xf1>
   1400028bc:	8b 05 a6 68 00 00    	mov    0x68a6(%rip),%eax        # 140009168 <__mingwthr_cs_init>
   1400028c2:	85 c0                	test   %eax,%eax
   1400028c4:	75 13                	jne    1400028d9 <__mingw_TLScallback+0x68>
   1400028c6:	48 8d 05 73 68 00 00 	lea    0x6873(%rip),%rax        # 140009140 <__mingwthr_cs>
   1400028cd:	48 89 c1             	mov    %rax,%rcx
   1400028d0:	48 8b 05 49 79 00 00 	mov    0x7949(%rip),%rax        # 14000a220 <__imp_InitializeCriticalSection>
   1400028d7:	ff d0                	call   *%rax
   1400028d9:	c7 05 85 68 00 00 01 	movl   $0x1,0x6885(%rip)        # 140009168 <__mingwthr_cs_init>
   1400028e0:	00 00 00 
   1400028e3:	eb 7d                	jmp    140002962 <__mingw_TLScallback+0xf1>
   1400028e5:	e8 e8 fe ff ff       	call   1400027d2 <__mingwthr_run_key_dtors>
   1400028ea:	8b 05 78 68 00 00    	mov    0x6878(%rip),%eax        # 140009168 <__mingwthr_cs_init>
   1400028f0:	83 f8 01             	cmp    $0x1,%eax
   1400028f3:	75 6c                	jne    140002961 <__mingw_TLScallback+0xf0>
   1400028f5:	48 8b 05 74 68 00 00 	mov    0x6874(%rip),%rax        # 140009170 <key_dtor_list>
   1400028fc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140002900:	eb 20                	jmp    140002922 <__mingw_TLScallback+0xb1>
   140002902:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002906:	48 8b 40 10          	mov    0x10(%rax),%rax
   14000290a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000290e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002912:	48 89 c1             	mov    %rax,%rcx
   140002915:	e8 96 09 00 00       	call   1400032b0 <free>
   14000291a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000291e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140002922:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   140002927:	75 d9                	jne    140002902 <__mingw_TLScallback+0x91>
   140002929:	48 c7 05 3c 68 00 00 	movq   $0x0,0x683c(%rip)        # 140009170 <key_dtor_list>
   140002930:	00 00 00 00 
   140002934:	c7 05 2a 68 00 00 00 	movl   $0x0,0x682a(%rip)        # 140009168 <__mingwthr_cs_init>
   14000293b:	00 00 00 
   14000293e:	48 8d 05 fb 67 00 00 	lea    0x67fb(%rip),%rax        # 140009140 <__mingwthr_cs>
   140002945:	48 89 c1             	mov    %rax,%rcx
   140002948:	48 8b 05 a1 78 00 00 	mov    0x78a1(%rip),%rax        # 14000a1f0 <__IAT_start__>
   14000294f:	ff d0                	call   *%rax
   140002951:	eb 0e                	jmp    140002961 <__mingw_TLScallback+0xf0>
   140002953:	e8 98 f1 ff ff       	call   140001af0 <_fpreset>
   140002958:	eb 08                	jmp    140002962 <__mingw_TLScallback+0xf1>
   14000295a:	e8 73 fe ff ff       	call   1400027d2 <__mingwthr_run_key_dtors>
   14000295f:	eb 01                	jmp    140002962 <__mingw_TLScallback+0xf1>
   140002961:	90                   	nop
   140002962:	b8 01 00 00 00       	mov    $0x1,%eax
   140002967:	48 83 c4 30          	add    $0x30,%rsp
   14000296b:	5d                   	pop    %rbp
   14000296c:	c3                   	ret
   14000296d:	90                   	nop
   14000296e:	90                   	nop
   14000296f:	90                   	nop

0000000140002970 <_ValidateImageBase>:
   140002970:	55                   	push   %rbp
   140002971:	48 89 e5             	mov    %rsp,%rbp
   140002974:	48 83 ec 20          	sub    $0x20,%rsp
   140002978:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000297c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002980:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140002984:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002988:	0f b7 00             	movzwl (%rax),%eax
   14000298b:	66 3d 4d 5a          	cmp    $0x5a4d,%ax
   14000298f:	74 07                	je     140002998 <_ValidateImageBase+0x28>
   140002991:	b8 00 00 00 00       	mov    $0x0,%eax
   140002996:	eb 4e                	jmp    1400029e6 <_ValidateImageBase+0x76>
   140002998:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000299c:	8b 40 3c             	mov    0x3c(%rax),%eax
   14000299f:	48 63 d0             	movslq %eax,%rdx
   1400029a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400029a6:	48 01 d0             	add    %rdx,%rax
   1400029a9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   1400029ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   1400029b1:	8b 00                	mov    (%rax),%eax
   1400029b3:	3d 50 45 00 00       	cmp    $0x4550,%eax
   1400029b8:	74 07                	je     1400029c1 <_ValidateImageBase+0x51>
   1400029ba:	b8 00 00 00 00       	mov    $0x0,%eax
   1400029bf:	eb 25                	jmp    1400029e6 <_ValidateImageBase+0x76>
   1400029c1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   1400029c5:	48 83 c0 18          	add    $0x18,%rax
   1400029c9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   1400029cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   1400029d1:	0f b7 00             	movzwl (%rax),%eax
   1400029d4:	66 3d 0b 02          	cmp    $0x20b,%ax
   1400029d8:	74 07                	je     1400029e1 <_ValidateImageBase+0x71>
   1400029da:	b8 00 00 00 00       	mov    $0x0,%eax
   1400029df:	eb 05                	jmp    1400029e6 <_ValidateImageBase+0x76>
   1400029e1:	b8 01 00 00 00       	mov    $0x1,%eax
   1400029e6:	48 83 c4 20          	add    $0x20,%rsp
   1400029ea:	5d                   	pop    %rbp
   1400029eb:	c3                   	ret

00000001400029ec <_FindPESection>:
   1400029ec:	55                   	push   %rbp
   1400029ed:	48 89 e5             	mov    %rsp,%rbp
   1400029f0:	48 83 ec 20          	sub    $0x20,%rsp
   1400029f4:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400029f8:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400029fc:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002a00:	8b 40 3c             	mov    0x3c(%rax),%eax
   140002a03:	48 63 d0             	movslq %eax,%rdx
   140002a06:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002a0a:	48 01 d0             	add    %rdx,%rax
   140002a0d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   140002a11:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   140002a18:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140002a1c:	0f b7 40 14          	movzwl 0x14(%rax),%eax
   140002a20:	0f b7 d0             	movzwl %ax,%edx
   140002a23:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140002a27:	48 01 d0             	add    %rdx,%rax
   140002a2a:	48 83 c0 18          	add    $0x18,%rax
   140002a2e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140002a32:	eb 36                	jmp    140002a6a <_FindPESection+0x7e>
   140002a34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002a38:	8b 40 0c             	mov    0xc(%rax),%eax
   140002a3b:	89 c0                	mov    %eax,%eax
   140002a3d:	48 39 45 18          	cmp    %rax,0x18(%rbp)
   140002a41:	72 1e                	jb     140002a61 <_FindPESection+0x75>
   140002a43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002a47:	8b 50 0c             	mov    0xc(%rax),%edx
   140002a4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002a4e:	8b 40 08             	mov    0x8(%rax),%eax
   140002a51:	01 d0                	add    %edx,%eax
   140002a53:	89 c0                	mov    %eax,%eax
   140002a55:	48 39 45 18          	cmp    %rax,0x18(%rbp)
   140002a59:	73 06                	jae    140002a61 <_FindPESection+0x75>
   140002a5b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002a5f:	eb 1e                	jmp    140002a7f <_FindPESection+0x93>
   140002a61:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   140002a65:	48 83 45 f8 28       	addq   $0x28,-0x8(%rbp)
   140002a6a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140002a6e:	0f b7 40 06          	movzwl 0x6(%rax),%eax
   140002a72:	0f b7 c0             	movzwl %ax,%eax
   140002a75:	39 45 f4             	cmp    %eax,-0xc(%rbp)
   140002a78:	72 ba                	jb     140002a34 <_FindPESection+0x48>
   140002a7a:	b8 00 00 00 00       	mov    $0x0,%eax
   140002a7f:	48 83 c4 20          	add    $0x20,%rsp
   140002a83:	5d                   	pop    %rbp
   140002a84:	c3                   	ret

0000000140002a85 <_FindPESectionByName>:
   140002a85:	55                   	push   %rbp
   140002a86:	48 89 e5             	mov    %rsp,%rbp
   140002a89:	48 83 ec 40          	sub    $0x40,%rsp
   140002a8d:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002a91:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002a95:	48 89 c1             	mov    %rax,%rcx
   140002a98:	e8 3b 08 00 00       	call   1400032d8 <strlen>
   140002a9d:	48 83 f8 08          	cmp    $0x8,%rax
   140002aa1:	76 0a                	jbe    140002aad <_FindPESectionByName+0x28>
   140002aa3:	b8 00 00 00 00       	mov    $0x0,%eax
   140002aa8:	e9 98 00 00 00       	jmp    140002b45 <_FindPESectionByName+0xc0>
   140002aad:	48 8b 05 4c 29 00 00 	mov    0x294c(%rip),%rax        # 140005400 <.refptr.__image_base__>
   140002ab4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   140002ab8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140002abc:	48 89 c1             	mov    %rax,%rcx
   140002abf:	e8 ac fe ff ff       	call   140002970 <_ValidateImageBase>
   140002ac4:	85 c0                	test   %eax,%eax
   140002ac6:	75 07                	jne    140002acf <_FindPESectionByName+0x4a>
   140002ac8:	b8 00 00 00 00       	mov    $0x0,%eax
   140002acd:	eb 76                	jmp    140002b45 <_FindPESectionByName+0xc0>
   140002acf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140002ad3:	8b 40 3c             	mov    0x3c(%rax),%eax
   140002ad6:	48 63 d0             	movslq %eax,%rdx
   140002ad9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140002add:	48 01 d0             	add    %rdx,%rax
   140002ae0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   140002ae4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   140002aeb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   140002aef:	0f b7 40 14          	movzwl 0x14(%rax),%eax
   140002af3:	0f b7 d0             	movzwl %ax,%edx
   140002af6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   140002afa:	48 01 d0             	add    %rdx,%rax
   140002afd:	48 83 c0 18          	add    $0x18,%rax
   140002b01:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140002b05:	eb 29                	jmp    140002b30 <_FindPESectionByName+0xab>
   140002b07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002b0b:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   140002b0f:	41 b8 08 00 00 00    	mov    $0x8,%r8d
   140002b15:	48 89 c1             	mov    %rax,%rcx
   140002b18:	e8 c3 07 00 00       	call   1400032e0 <strncmp>
   140002b1d:	85 c0                	test   %eax,%eax
   140002b1f:	75 06                	jne    140002b27 <_FindPESectionByName+0xa2>
   140002b21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002b25:	eb 1e                	jmp    140002b45 <_FindPESectionByName+0xc0>
   140002b27:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   140002b2b:	48 83 45 f8 28       	addq   $0x28,-0x8(%rbp)
   140002b30:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   140002b34:	0f b7 40 06          	movzwl 0x6(%rax),%eax
   140002b38:	0f b7 c0             	movzwl %ax,%eax
   140002b3b:	39 45 f4             	cmp    %eax,-0xc(%rbp)
   140002b3e:	72 c7                	jb     140002b07 <_FindPESectionByName+0x82>
   140002b40:	b8 00 00 00 00       	mov    $0x0,%eax
   140002b45:	48 83 c4 40          	add    $0x40,%rsp
   140002b49:	5d                   	pop    %rbp
   140002b4a:	c3                   	ret

0000000140002b4b <__mingw_GetSectionForAddress>:
   140002b4b:	55                   	push   %rbp
   140002b4c:	48 89 e5             	mov    %rsp,%rbp
   140002b4f:	48 83 ec 30          	sub    $0x30,%rsp
   140002b53:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002b57:	48 8b 05 a2 28 00 00 	mov    0x28a2(%rip),%rax        # 140005400 <.refptr.__image_base__>
   140002b5e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140002b62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002b66:	48 89 c1             	mov    %rax,%rcx
   140002b69:	e8 02 fe ff ff       	call   140002970 <_ValidateImageBase>
   140002b6e:	85 c0                	test   %eax,%eax
   140002b70:	75 07                	jne    140002b79 <__mingw_GetSectionForAddress+0x2e>
   140002b72:	b8 00 00 00 00       	mov    $0x0,%eax
   140002b77:	eb 1c                	jmp    140002b95 <__mingw_GetSectionForAddress+0x4a>
   140002b79:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002b7d:	48 2b 45 f8          	sub    -0x8(%rbp),%rax
   140002b81:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140002b85:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   140002b89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002b8d:	48 89 c1             	mov    %rax,%rcx
   140002b90:	e8 57 fe ff ff       	call   1400029ec <_FindPESection>
   140002b95:	48 83 c4 30          	add    $0x30,%rsp
   140002b99:	5d                   	pop    %rbp
   140002b9a:	c3                   	ret

0000000140002b9b <__mingw_GetSectionCount>:
   140002b9b:	55                   	push   %rbp
   140002b9c:	48 89 e5             	mov    %rsp,%rbp
   140002b9f:	48 83 ec 30          	sub    $0x30,%rsp
   140002ba3:	48 8b 05 56 28 00 00 	mov    0x2856(%rip),%rax        # 140005400 <.refptr.__image_base__>
   140002baa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140002bae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002bb2:	48 89 c1             	mov    %rax,%rcx
   140002bb5:	e8 b6 fd ff ff       	call   140002970 <_ValidateImageBase>
   140002bba:	85 c0                	test   %eax,%eax
   140002bbc:	75 07                	jne    140002bc5 <__mingw_GetSectionCount+0x2a>
   140002bbe:	b8 00 00 00 00       	mov    $0x0,%eax
   140002bc3:	eb 20                	jmp    140002be5 <__mingw_GetSectionCount+0x4a>
   140002bc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002bc9:	8b 40 3c             	mov    0x3c(%rax),%eax
   140002bcc:	48 63 d0             	movslq %eax,%rdx
   140002bcf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002bd3:	48 01 d0             	add    %rdx,%rax
   140002bd6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140002bda:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140002bde:	0f b7 40 06          	movzwl 0x6(%rax),%eax
   140002be2:	0f b7 c0             	movzwl %ax,%eax
   140002be5:	48 83 c4 30          	add    $0x30,%rsp
   140002be9:	5d                   	pop    %rbp
   140002bea:	c3                   	ret

0000000140002beb <_FindPESectionExec>:
   140002beb:	55                   	push   %rbp
   140002bec:	48 89 e5             	mov    %rsp,%rbp
   140002bef:	48 83 ec 40          	sub    $0x40,%rsp
   140002bf3:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002bf7:	48 8b 05 02 28 00 00 	mov    0x2802(%rip),%rax        # 140005400 <.refptr.__image_base__>
   140002bfe:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   140002c02:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140002c06:	48 89 c1             	mov    %rax,%rcx
   140002c09:	e8 62 fd ff ff       	call   140002970 <_ValidateImageBase>
   140002c0e:	85 c0                	test   %eax,%eax
   140002c10:	75 07                	jne    140002c19 <_FindPESectionExec+0x2e>
   140002c12:	b8 00 00 00 00       	mov    $0x0,%eax
   140002c17:	eb 78                	jmp    140002c91 <_FindPESectionExec+0xa6>
   140002c19:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140002c1d:	8b 40 3c             	mov    0x3c(%rax),%eax
   140002c20:	48 63 d0             	movslq %eax,%rdx
   140002c23:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140002c27:	48 01 d0             	add    %rdx,%rax
   140002c2a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   140002c2e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   140002c35:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   140002c39:	0f b7 40 14          	movzwl 0x14(%rax),%eax
   140002c3d:	0f b7 d0             	movzwl %ax,%edx
   140002c40:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   140002c44:	48 01 d0             	add    %rdx,%rax
   140002c47:	48 83 c0 18          	add    $0x18,%rax
   140002c4b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140002c4f:	eb 2b                	jmp    140002c7c <_FindPESectionExec+0x91>
   140002c51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002c55:	8b 40 24             	mov    0x24(%rax),%eax
   140002c58:	25 00 00 00 20       	and    $0x20000000,%eax
   140002c5d:	85 c0                	test   %eax,%eax
   140002c5f:	74 12                	je     140002c73 <_FindPESectionExec+0x88>
   140002c61:	48 83 7d 10 00       	cmpq   $0x0,0x10(%rbp)
   140002c66:	75 06                	jne    140002c6e <_FindPESectionExec+0x83>
   140002c68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002c6c:	eb 23                	jmp    140002c91 <_FindPESectionExec+0xa6>
   140002c6e:	48 83 6d 10 01       	subq   $0x1,0x10(%rbp)
   140002c73:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   140002c77:	48 83 45 f8 28       	addq   $0x28,-0x8(%rbp)
   140002c7c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   140002c80:	0f b7 40 06          	movzwl 0x6(%rax),%eax
   140002c84:	0f b7 c0             	movzwl %ax,%eax
   140002c87:	39 45 f4             	cmp    %eax,-0xc(%rbp)
   140002c8a:	72 c5                	jb     140002c51 <_FindPESectionExec+0x66>
   140002c8c:	b8 00 00 00 00       	mov    $0x0,%eax
   140002c91:	48 83 c4 40          	add    $0x40,%rsp
   140002c95:	5d                   	pop    %rbp
   140002c96:	c3                   	ret

0000000140002c97 <_GetPEImageBase>:
   140002c97:	55                   	push   %rbp
   140002c98:	48 89 e5             	mov    %rsp,%rbp
   140002c9b:	48 83 ec 30          	sub    $0x30,%rsp
   140002c9f:	48 8b 05 5a 27 00 00 	mov    0x275a(%rip),%rax        # 140005400 <.refptr.__image_base__>
   140002ca6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140002caa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002cae:	48 89 c1             	mov    %rax,%rcx
   140002cb1:	e8 ba fc ff ff       	call   140002970 <_ValidateImageBase>
   140002cb6:	85 c0                	test   %eax,%eax
   140002cb8:	75 07                	jne    140002cc1 <_GetPEImageBase+0x2a>
   140002cba:	b8 00 00 00 00       	mov    $0x0,%eax
   140002cbf:	eb 04                	jmp    140002cc5 <_GetPEImageBase+0x2e>
   140002cc1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002cc5:	48 83 c4 30          	add    $0x30,%rsp
   140002cc9:	5d                   	pop    %rbp
   140002cca:	c3                   	ret

0000000140002ccb <_IsNonwritableInCurrentImage>:
   140002ccb:	55                   	push   %rbp
   140002ccc:	48 89 e5             	mov    %rsp,%rbp
   140002ccf:	48 83 ec 40          	sub    $0x40,%rsp
   140002cd3:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002cd7:	48 8b 05 22 27 00 00 	mov    0x2722(%rip),%rax        # 140005400 <.refptr.__image_base__>
   140002cde:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140002ce2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002ce6:	48 89 c1             	mov    %rax,%rcx
   140002ce9:	e8 82 fc ff ff       	call   140002970 <_ValidateImageBase>
   140002cee:	85 c0                	test   %eax,%eax
   140002cf0:	75 07                	jne    140002cf9 <_IsNonwritableInCurrentImage+0x2e>
   140002cf2:	b8 00 00 00 00       	mov    $0x0,%eax
   140002cf7:	eb 3d                	jmp    140002d36 <_IsNonwritableInCurrentImage+0x6b>
   140002cf9:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002cfd:	48 2b 45 f8          	sub    -0x8(%rbp),%rax
   140002d01:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140002d05:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   140002d09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002d0d:	48 89 c1             	mov    %rax,%rcx
   140002d10:	e8 d7 fc ff ff       	call   1400029ec <_FindPESection>
   140002d15:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   140002d19:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   140002d1e:	75 07                	jne    140002d27 <_IsNonwritableInCurrentImage+0x5c>
   140002d20:	b8 00 00 00 00       	mov    $0x0,%eax
   140002d25:	eb 0f                	jmp    140002d36 <_IsNonwritableInCurrentImage+0x6b>
   140002d27:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140002d2b:	8b 40 24             	mov    0x24(%rax),%eax
   140002d2e:	f7 d0                	not    %eax
   140002d30:	c1 e8 1f             	shr    $0x1f,%eax
   140002d33:	0f b6 c0             	movzbl %al,%eax
   140002d36:	48 83 c4 40          	add    $0x40,%rsp
   140002d3a:	5d                   	pop    %rbp
   140002d3b:	c3                   	ret

0000000140002d3c <__mingw_enum_import_library_names>:
   140002d3c:	55                   	push   %rbp
   140002d3d:	48 89 e5             	mov    %rsp,%rbp
   140002d40:	48 83 ec 50          	sub    $0x50,%rsp
   140002d44:	89 4d 10             	mov    %ecx,0x10(%rbp)
   140002d47:	48 8b 05 b2 26 00 00 	mov    0x26b2(%rip),%rax        # 140005400 <.refptr.__image_base__>
   140002d4e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140002d52:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140002d56:	48 89 c1             	mov    %rax,%rcx
   140002d59:	e8 12 fc ff ff       	call   140002970 <_ValidateImageBase>
   140002d5e:	85 c0                	test   %eax,%eax
   140002d60:	75 0a                	jne    140002d6c <__mingw_enum_import_library_names+0x30>
   140002d62:	b8 00 00 00 00       	mov    $0x0,%eax
   140002d67:	e9 ab 00 00 00       	jmp    140002e17 <__mingw_enum_import_library_names+0xdb>
   140002d6c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140002d70:	8b 40 3c             	mov    0x3c(%rax),%eax
   140002d73:	48 63 d0             	movslq %eax,%rdx
   140002d76:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140002d7a:	48 01 d0             	add    %rdx,%rax
   140002d7d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   140002d81:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140002d85:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
   140002d8b:	89 45 e4             	mov    %eax,-0x1c(%rbp)
   140002d8e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   140002d92:	75 07                	jne    140002d9b <__mingw_enum_import_library_names+0x5f>
   140002d94:	b8 00 00 00 00       	mov    $0x0,%eax
   140002d99:	eb 7c                	jmp    140002e17 <__mingw_enum_import_library_names+0xdb>
   140002d9b:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   140002d9e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140002da2:	48 89 c1             	mov    %rax,%rcx
   140002da5:	e8 42 fc ff ff       	call   1400029ec <_FindPESection>
   140002daa:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   140002dae:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   140002db3:	75 07                	jne    140002dbc <__mingw_enum_import_library_names+0x80>
   140002db5:	b8 00 00 00 00       	mov    $0x0,%eax
   140002dba:	eb 5b                	jmp    140002e17 <__mingw_enum_import_library_names+0xdb>
   140002dbc:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   140002dbf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140002dc3:	48 01 d0             	add    %rdx,%rax
   140002dc6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140002dca:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   140002dcf:	75 07                	jne    140002dd8 <__mingw_enum_import_library_names+0x9c>
   140002dd1:	b8 00 00 00 00       	mov    $0x0,%eax
   140002dd6:	eb 3f                	jmp    140002e17 <__mingw_enum_import_library_names+0xdb>
   140002dd8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002ddc:	8b 40 04             	mov    0x4(%rax),%eax
   140002ddf:	85 c0                	test   %eax,%eax
   140002de1:	75 0b                	jne    140002dee <__mingw_enum_import_library_names+0xb2>
   140002de3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002de7:	8b 40 0c             	mov    0xc(%rax),%eax
   140002dea:	85 c0                	test   %eax,%eax
   140002dec:	74 23                	je     140002e11 <__mingw_enum_import_library_names+0xd5>
   140002dee:	83 7d 10 00          	cmpl   $0x0,0x10(%rbp)
   140002df2:	7f 12                	jg     140002e06 <__mingw_enum_import_library_names+0xca>
   140002df4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002df8:	8b 40 0c             	mov    0xc(%rax),%eax
   140002dfb:	89 c2                	mov    %eax,%edx
   140002dfd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140002e01:	48 01 d0             	add    %rdx,%rax
   140002e04:	eb 11                	jmp    140002e17 <__mingw_enum_import_library_names+0xdb>
   140002e06:	83 6d 10 01          	subl   $0x1,0x10(%rbp)
   140002e0a:	48 83 45 f8 14       	addq   $0x14,-0x8(%rbp)
   140002e0f:	eb c7                	jmp    140002dd8 <__mingw_enum_import_library_names+0x9c>
   140002e11:	90                   	nop
   140002e12:	b8 00 00 00 00       	mov    $0x0,%eax
   140002e17:	48 83 c4 50          	add    $0x50,%rsp
   140002e1b:	5d                   	pop    %rbp
   140002e1c:	c3                   	ret
   140002e1d:	90                   	nop
   140002e1e:	90                   	nop
   140002e1f:	90                   	nop

0000000140002e20 <___chkstk_ms>:
   140002e20:	51                   	push   %rcx
   140002e21:	50                   	push   %rax
   140002e22:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
   140002e28:	48 8d 4c 24 18       	lea    0x18(%rsp),%rcx
   140002e2d:	72 19                	jb     140002e48 <___chkstk_ms+0x28>
   140002e2f:	48 81 e9 00 10 00 00 	sub    $0x1000,%rcx
   140002e36:	48 83 09 00          	orq    $0x0,(%rcx)
   140002e3a:	48 2d 00 10 00 00    	sub    $0x1000,%rax
   140002e40:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
   140002e46:	77 e7                	ja     140002e2f <___chkstk_ms+0xf>
   140002e48:	48 29 c1             	sub    %rax,%rcx
   140002e4b:	48 83 09 00          	orq    $0x0,(%rcx)
   140002e4f:	58                   	pop    %rax
   140002e50:	59                   	pop    %rcx
   140002e51:	c3                   	ret
   140002e52:	90                   	nop
   140002e53:	90                   	nop
   140002e54:	90                   	nop
   140002e55:	90                   	nop
   140002e56:	90                   	nop
   140002e57:	90                   	nop
   140002e58:	90                   	nop
   140002e59:	90                   	nop
   140002e5a:	90                   	nop
   140002e5b:	90                   	nop
   140002e5c:	90                   	nop
   140002e5d:	90                   	nop
   140002e5e:	90                   	nop
   140002e5f:	90                   	nop

0000000140002e60 <vfprintf>:
   140002e60:	55                   	push   %rbp
   140002e61:	48 89 e5             	mov    %rsp,%rbp
   140002e64:	48 83 ec 30          	sub    $0x30,%rsp
   140002e68:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002e6c:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140002e70:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140002e74:	48 8b 4d 18          	mov    0x18(%rbp),%rcx
   140002e78:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002e7c:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   140002e80:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   140002e85:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140002e8b:	49 89 c8             	mov    %rcx,%r8
   140002e8e:	48 89 c2             	mov    %rax,%rdx
   140002e91:	b9 00 00 00 00       	mov    $0x0,%ecx
   140002e96:	e8 7d 03 00 00       	call   140003218 <__stdio_common_vfprintf>
   140002e9b:	48 83 c4 30          	add    $0x30,%rsp
   140002e9f:	5d                   	pop    %rbp
   140002ea0:	c3                   	ret
   140002ea1:	90                   	nop
   140002ea2:	90                   	nop
   140002ea3:	90                   	nop
   140002ea4:	90                   	nop
   140002ea5:	90                   	nop
   140002ea6:	90                   	nop
   140002ea7:	90                   	nop
   140002ea8:	90                   	nop
   140002ea9:	90                   	nop
   140002eaa:	90                   	nop
   140002eab:	90                   	nop
   140002eac:	90                   	nop
   140002ead:	90                   	nop
   140002eae:	90                   	nop
   140002eaf:	90                   	nop

0000000140002eb0 <printf>:
   140002eb0:	55                   	push   %rbp
   140002eb1:	53                   	push   %rbx
   140002eb2:	48 83 ec 48          	sub    $0x48,%rsp
   140002eb6:	48 8d 6c 24 40       	lea    0x40(%rsp),%rbp
   140002ebb:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   140002ebf:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   140002ec3:	4c 89 45 30          	mov    %r8,0x30(%rbp)
   140002ec7:	4c 89 4d 38          	mov    %r9,0x38(%rbp)
   140002ecb:	48 8d 45 28          	lea    0x28(%rbp),%rax
   140002ecf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140002ed3:	48 8b 5d f0          	mov    -0x10(%rbp),%rbx
   140002ed7:	b9 01 00 00 00       	mov    $0x1,%ecx
   140002edc:	e8 e7 02 00 00       	call   1400031c8 <__acrt_iob_func>
   140002ee1:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   140002ee5:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
   140002eea:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140002ef0:	49 89 d0             	mov    %rdx,%r8
   140002ef3:	48 89 c2             	mov    %rax,%rdx
   140002ef6:	b9 00 00 00 00       	mov    $0x0,%ecx
   140002efb:	e8 18 03 00 00       	call   140003218 <__stdio_common_vfprintf>
   140002f00:	89 45 fc             	mov    %eax,-0x4(%rbp)
   140002f03:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140002f06:	48 83 c4 48          	add    $0x48,%rsp
   140002f0a:	5b                   	pop    %rbx
   140002f0b:	5d                   	pop    %rbp
   140002f0c:	c3                   	ret
   140002f0d:	90                   	nop
   140002f0e:	90                   	nop
   140002f0f:	90                   	nop

0000000140002f10 <fprintf>:
   140002f10:	55                   	push   %rbp
   140002f11:	48 89 e5             	mov    %rsp,%rbp
   140002f14:	48 83 ec 40          	sub    $0x40,%rsp
   140002f18:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002f1c:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140002f20:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140002f24:	4c 89 4d 28          	mov    %r9,0x28(%rbp)
   140002f28:	48 8d 45 20          	lea    0x20(%rbp),%rax
   140002f2c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140002f30:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   140002f34:	48 8b 4d 18          	mov    0x18(%rbp),%rcx
   140002f38:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002f3c:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   140002f41:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140002f47:	49 89 c8             	mov    %rcx,%r8
   140002f4a:	48 89 c2             	mov    %rax,%rdx
   140002f4d:	b9 00 00 00 00       	mov    $0x0,%ecx
   140002f52:	e8 c1 02 00 00       	call   140003218 <__stdio_common_vfprintf>
   140002f57:	89 45 fc             	mov    %eax,-0x4(%rbp)
   140002f5a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140002f5d:	48 83 c4 40          	add    $0x40,%rsp
   140002f61:	5d                   	pop    %rbp
   140002f62:	c3                   	ret
   140002f63:	90                   	nop
   140002f64:	90                   	nop
   140002f65:	90                   	nop
   140002f66:	90                   	nop
   140002f67:	90                   	nop
   140002f68:	90                   	nop
   140002f69:	90                   	nop
   140002f6a:	90                   	nop
   140002f6b:	90                   	nop
   140002f6c:	90                   	nop
   140002f6d:	90                   	nop
   140002f6e:	90                   	nop
   140002f6f:	90                   	nop

0000000140002f70 <__getmainargs>:
   140002f70:	55                   	push   %rbp
   140002f71:	48 89 e5             	mov    %rsp,%rbp
   140002f74:	48 83 ec 20          	sub    $0x20,%rsp
   140002f78:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002f7c:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140002f80:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140002f84:	44 89 4d 28          	mov    %r9d,0x28(%rbp)
   140002f88:	e8 db 02 00 00       	call   140003268 <_initialize_narrow_environment>
   140002f8d:	83 7d 28 00          	cmpl   $0x0,0x28(%rbp)
   140002f91:	74 07                	je     140002f9a <__getmainargs+0x2a>
   140002f93:	b8 02 00 00 00       	mov    $0x2,%eax
   140002f98:	eb 05                	jmp    140002f9f <__getmainargs+0x2f>
   140002f9a:	b8 01 00 00 00       	mov    $0x1,%eax
   140002f9f:	89 c1                	mov    %eax,%ecx
   140002fa1:	e8 9a 02 00 00       	call   140003240 <_configure_narrow_argv>
   140002fa6:	e8 2d 02 00 00       	call   1400031d8 <__p___argc>
   140002fab:	8b 10                	mov    (%rax),%edx
   140002fad:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002fb1:	89 10                	mov    %edx,(%rax)
   140002fb3:	e8 28 02 00 00       	call   1400031e0 <__p___argv>
   140002fb8:	48 8b 10             	mov    (%rax),%rdx
   140002fbb:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140002fbf:	48 89 10             	mov    %rdx,(%rax)
   140002fc2:	e8 31 02 00 00       	call   1400031f8 <__p__environ>
   140002fc7:	48 8b 10             	mov    (%rax),%rdx
   140002fca:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140002fce:	48 89 10             	mov    %rdx,(%rax)
   140002fd1:	48 83 7d 30 00       	cmpq   $0x0,0x30(%rbp)
   140002fd6:	74 0d                	je     140002fe5 <__getmainargs+0x75>
   140002fd8:	48 8b 45 30          	mov    0x30(%rbp),%rax
   140002fdc:	8b 00                	mov    (%rax),%eax
   140002fde:	89 c1                	mov    %eax,%ecx
   140002fe0:	e8 ab 02 00 00       	call   140003290 <_set_new_mode>
   140002fe5:	b8 00 00 00 00       	mov    $0x0,%eax
   140002fea:	48 83 c4 20          	add    $0x20,%rsp
   140002fee:	5d                   	pop    %rbp
   140002fef:	c3                   	ret

0000000140002ff0 <__wgetmainargs>:
   140002ff0:	55                   	push   %rbp
   140002ff1:	48 89 e5             	mov    %rsp,%rbp
   140002ff4:	48 83 ec 20          	sub    $0x20,%rsp
   140002ff8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002ffc:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003000:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140003004:	44 89 4d 28          	mov    %r9d,0x28(%rbp)
   140003008:	e8 63 02 00 00       	call   140003270 <_initialize_wide_environment>
   14000300d:	83 7d 28 00          	cmpl   $0x0,0x28(%rbp)
   140003011:	74 07                	je     14000301a <__wgetmainargs+0x2a>
   140003013:	b8 02 00 00 00       	mov    $0x2,%eax
   140003018:	eb 05                	jmp    14000301f <__wgetmainargs+0x2f>
   14000301a:	b8 01 00 00 00       	mov    $0x1,%eax
   14000301f:	89 c1                	mov    %eax,%ecx
   140003021:	e8 22 02 00 00       	call   140003248 <_configure_wide_argv>
   140003026:	e8 ad 01 00 00       	call   1400031d8 <__p___argc>
   14000302b:	8b 10                	mov    (%rax),%edx
   14000302d:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003031:	89 10                	mov    %edx,(%rax)
   140003033:	e8 b0 01 00 00       	call   1400031e8 <__p___wargv>
   140003038:	48 8b 10             	mov    (%rax),%rdx
   14000303b:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000303f:	48 89 10             	mov    %rdx,(%rax)
   140003042:	e8 c1 01 00 00       	call   140003208 <__p__wenviron>
   140003047:	48 8b 10             	mov    (%rax),%rdx
   14000304a:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000304e:	48 89 10             	mov    %rdx,(%rax)
   140003051:	48 83 7d 30 00       	cmpq   $0x0,0x30(%rbp)
   140003056:	74 0d                	je     140003065 <__wgetmainargs+0x75>
   140003058:	48 8b 45 30          	mov    0x30(%rbp),%rax
   14000305c:	8b 00                	mov    (%rax),%eax
   14000305e:	89 c1                	mov    %eax,%ecx
   140003060:	e8 2b 02 00 00       	call   140003290 <_set_new_mode>
   140003065:	b8 00 00 00 00       	mov    $0x0,%eax
   14000306a:	48 83 c4 20          	add    $0x20,%rsp
   14000306e:	5d                   	pop    %rbp
   14000306f:	c3                   	ret

0000000140003070 <_onexit>:
   140003070:	55                   	push   %rbp
   140003071:	48 89 e5             	mov    %rsp,%rbp
   140003074:	48 83 ec 20          	sub    $0x20,%rsp
   140003078:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000307c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003080:	48 89 c1             	mov    %rax,%rcx
   140003083:	e8 d0 01 00 00       	call   140003258 <_crt_atexit>
   140003088:	85 c0                	test   %eax,%eax
   14000308a:	75 06                	jne    140003092 <_onexit+0x22>
   14000308c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003090:	eb 05                	jmp    140003097 <_onexit+0x27>
   140003092:	b8 00 00 00 00       	mov    $0x0,%eax
   140003097:	48 83 c4 20          	add    $0x20,%rsp
   14000309b:	5d                   	pop    %rbp
   14000309c:	c3                   	ret

000000014000309d <at_quick_exit>:
   14000309d:	55                   	push   %rbp
   14000309e:	48 89 e5             	mov    %rsp,%rbp
   1400030a1:	48 83 ec 20          	sub    $0x20,%rsp
   1400030a5:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400030a9:	48 8b 05 c0 23 00 00 	mov    0x23c0(%rip),%rax        # 140005470 <.refptr.__mingw_module_is_dll>
   1400030b0:	0f b6 00             	movzbl (%rax),%eax
   1400030b3:	84 c0                	test   %al,%al
   1400030b5:	74 07                	je     1400030be <at_quick_exit+0x21>
   1400030b7:	b8 00 00 00 00       	mov    $0x0,%eax
   1400030bc:	eb 0c                	jmp    1400030ca <at_quick_exit+0x2d>
   1400030be:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400030c2:	48 89 c1             	mov    %rax,%rcx
   1400030c5:	e8 86 01 00 00       	call   140003250 <_crt_at_quick_exit>
   1400030ca:	48 83 c4 20          	add    $0x20,%rsp
   1400030ce:	5d                   	pop    %rbp
   1400030cf:	c3                   	ret

00000001400030d0 <_amsg_exit>:
   1400030d0:	55                   	push   %rbp
   1400030d1:	48 89 e5             	mov    %rsp,%rbp
   1400030d4:	48 83 ec 20          	sub    $0x20,%rsp
   1400030d8:	89 4d 10             	mov    %ecx,0x10(%rbp)
   1400030db:	b9 02 00 00 00       	mov    $0x2,%ecx
   1400030e0:	e8 e3 00 00 00       	call   1400031c8 <__acrt_iob_func>
   1400030e5:	48 89 c1             	mov    %rax,%rcx
   1400030e8:	8b 45 10             	mov    0x10(%rbp),%eax
   1400030eb:	41 89 c0             	mov    %eax,%r8d
   1400030ee:	48 8d 05 7b 22 00 00 	lea    0x227b(%rip),%rax        # 140005370 <.rdata>
   1400030f5:	48 89 c2             	mov    %rax,%rdx
   1400030f8:	e8 13 fe ff ff       	call   140002f10 <fprintf>
   1400030fd:	b9 ff 00 00 00       	mov    $0xff,%ecx
   140003102:	e8 59 01 00 00       	call   140003260 <_exit>
   140003107:	90                   	nop

0000000140003108 <_get_output_format>:
   140003108:	55                   	push   %rbp
   140003109:	48 89 e5             	mov    %rsp,%rbp
   14000310c:	b8 00 00 00 00       	mov    $0x0,%eax
   140003111:	5d                   	pop    %rbp
   140003112:	c3                   	ret

0000000140003113 <_tzset>:
   140003113:	55                   	push   %rbp
   140003114:	48 89 e5             	mov    %rsp,%rbp
   140003117:	48 83 ec 20          	sub    $0x20,%rsp
   14000311b:	48 8b 05 fe 22 00 00 	mov    0x22fe(%rip),%rax        # 140005420 <.refptr.__imp__tzset>
   140003122:	48 8b 00             	mov    (%rax),%rax
   140003125:	ff d0                	call   *%rax
   140003127:	e8 04 01 00 00       	call   140003230 <__tzname>
   14000312c:	48 89 05 b5 0f 00 00 	mov    %rax,0xfb5(%rip)        # 1400040e8 <__imp_tzname>
   140003133:	e8 f0 00 00 00       	call   140003228 <__timezone>
   140003138:	48 89 05 b1 0f 00 00 	mov    %rax,0xfb1(%rip)        # 1400040f0 <__imp_timezone>
   14000313f:	e8 8c 00 00 00       	call   1400031d0 <__daylight>
   140003144:	48 89 05 ad 0f 00 00 	mov    %rax,0xfad(%rip)        # 1400040f8 <__imp_daylight>
   14000314b:	90                   	nop
   14000314c:	48 83 c4 20          	add    $0x20,%rsp
   140003150:	5d                   	pop    %rbp
   140003151:	c3                   	ret

0000000140003152 <tzset>:
   140003152:	55                   	push   %rbp
   140003153:	48 89 e5             	mov    %rsp,%rbp
   140003156:	48 83 ec 20          	sub    $0x20,%rsp
   14000315a:	e8 b4 ff ff ff       	call   140003113 <_tzset>
   14000315f:	90                   	nop
   140003160:	48 83 c4 20          	add    $0x20,%rsp
   140003164:	5d                   	pop    %rbp
   140003165:	c3                   	ret

0000000140003166 <__ms_fwprintf>:
   140003166:	55                   	push   %rbp
   140003167:	48 89 e5             	mov    %rsp,%rbp
   14000316a:	48 83 ec 40          	sub    $0x40,%rsp
   14000316e:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003172:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003176:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   14000317a:	4c 89 4d 28          	mov    %r9,0x28(%rbp)
   14000317e:	48 8d 45 20          	lea    0x20(%rbp),%rax
   140003182:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140003186:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   14000318a:	48 8b 4d 18          	mov    0x18(%rbp),%rcx
   14000318e:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003192:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   140003197:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000319d:	49 89 c8             	mov    %rcx,%r8
   1400031a0:	48 89 c2             	mov    %rax,%rdx
   1400031a3:	b9 04 00 00 00       	mov    $0x4,%ecx
   1400031a8:	e8 73 00 00 00       	call   140003220 <__stdio_common_vfwprintf>
   1400031ad:	89 45 fc             	mov    %eax,-0x4(%rbp)
   1400031b0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   1400031b3:	48 83 c4 40          	add    $0x40,%rsp
   1400031b7:	5d                   	pop    %rbp
   1400031b8:	c3                   	ret
   1400031b9:	90                   	nop
   1400031ba:	90                   	nop
   1400031bb:	90                   	nop
   1400031bc:	90                   	nop
   1400031bd:	90                   	nop
   1400031be:	90                   	nop
   1400031bf:	90                   	nop

00000001400031c0 <__C_specific_handler>:
   1400031c0:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a268 <__imp___C_specific_handler>
   1400031c6:	90                   	nop
   1400031c7:	90                   	nop

00000001400031c8 <__acrt_iob_func>:
   1400031c8:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a270 <__imp___acrt_iob_func>
   1400031ce:	90                   	nop
   1400031cf:	90                   	nop

00000001400031d0 <__daylight>:
   1400031d0:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a278 <__imp___daylight>
   1400031d6:	90                   	nop
   1400031d7:	90                   	nop

00000001400031d8 <__p___argc>:
   1400031d8:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a280 <__imp___p___argc>
   1400031de:	90                   	nop
   1400031df:	90                   	nop

00000001400031e0 <__p___argv>:
   1400031e0:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a288 <__imp___p___argv>
   1400031e6:	90                   	nop
   1400031e7:	90                   	nop

00000001400031e8 <__p___wargv>:
   1400031e8:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a290 <__imp___p___wargv>
   1400031ee:	90                   	nop
   1400031ef:	90                   	nop

00000001400031f0 <__p__commode>:
   1400031f0:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a298 <__imp___p__commode>
   1400031f6:	90                   	nop
   1400031f7:	90                   	nop

00000001400031f8 <__p__environ>:
   1400031f8:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a2a0 <__imp___p__environ>
   1400031fe:	90                   	nop
   1400031ff:	90                   	nop

0000000140003200 <__p__fmode>:
   140003200:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a2a8 <__imp___p__fmode>
   140003206:	90                   	nop
   140003207:	90                   	nop

0000000140003208 <__p__wenviron>:
   140003208:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a2b0 <__imp___p__wenviron>
   14000320e:	90                   	nop
   14000320f:	90                   	nop

0000000140003210 <__setusermatherr>:
   140003210:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a2b8 <__imp___setusermatherr>
   140003216:	90                   	nop
   140003217:	90                   	nop

0000000140003218 <__stdio_common_vfprintf>:
   140003218:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a2c0 <__imp___stdio_common_vfprintf>
   14000321e:	90                   	nop
   14000321f:	90                   	nop

0000000140003220 <__stdio_common_vfwprintf>:
   140003220:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a2c8 <__imp___stdio_common_vfwprintf>
   140003226:	90                   	nop
   140003227:	90                   	nop

0000000140003228 <__timezone>:
   140003228:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a2d0 <__imp___timezone>
   14000322e:	90                   	nop
   14000322f:	90                   	nop

0000000140003230 <__tzname>:
   140003230:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a2d8 <__imp___tzname>
   140003236:	90                   	nop
   140003237:	90                   	nop

0000000140003238 <_cexit>:
   140003238:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a2e0 <__imp__cexit>
   14000323e:	90                   	nop
   14000323f:	90                   	nop

0000000140003240 <_configure_narrow_argv>:
   140003240:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a2e8 <__imp__configure_narrow_argv>
   140003246:	90                   	nop
   140003247:	90                   	nop

0000000140003248 <_configure_wide_argv>:
   140003248:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a2f0 <__imp__configure_wide_argv>
   14000324e:	90                   	nop
   14000324f:	90                   	nop

0000000140003250 <_crt_at_quick_exit>:
   140003250:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a2f8 <__imp__crt_at_quick_exit>
   140003256:	90                   	nop
   140003257:	90                   	nop

0000000140003258 <_crt_atexit>:
   140003258:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a300 <__imp__crt_atexit>
   14000325e:	90                   	nop
   14000325f:	90                   	nop

0000000140003260 <_exit>:
   140003260:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a308 <__imp__exit>
   140003266:	90                   	nop
   140003267:	90                   	nop

0000000140003268 <_initialize_narrow_environment>:
   140003268:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a310 <__imp__initialize_narrow_environment>
   14000326e:	90                   	nop
   14000326f:	90                   	nop

0000000140003270 <_initialize_wide_environment>:
   140003270:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a318 <__imp__initialize_wide_environment>
   140003276:	90                   	nop
   140003277:	90                   	nop

0000000140003278 <_initterm>:
   140003278:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a320 <__imp__initterm>
   14000327e:	90                   	nop
   14000327f:	90                   	nop

0000000140003280 <__set_app_type>:
   140003280:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a328 <__imp___set_app_type>
   140003286:	90                   	nop
   140003287:	90                   	nop

0000000140003288 <_set_invalid_parameter_handler>:
   140003288:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a330 <__imp__set_invalid_parameter_handler>
   14000328e:	90                   	nop
   14000328f:	90                   	nop

0000000140003290 <_set_new_mode>:
   140003290:	ff 25 a2 70 00 00    	jmp    *0x70a2(%rip)        # 14000a338 <__imp__set_new_mode>
   140003296:	90                   	nop
   140003297:	90                   	nop

0000000140003298 <abort>:
   140003298:	ff 25 aa 70 00 00    	jmp    *0x70aa(%rip)        # 14000a348 <__imp_abort>
   14000329e:	90                   	nop
   14000329f:	90                   	nop

00000001400032a0 <calloc>:
   1400032a0:	ff 25 aa 70 00 00    	jmp    *0x70aa(%rip)        # 14000a350 <__imp_calloc>
   1400032a6:	90                   	nop
   1400032a7:	90                   	nop

00000001400032a8 <exit>:
   1400032a8:	ff 25 aa 70 00 00    	jmp    *0x70aa(%rip)        # 14000a358 <__imp_exit>
   1400032ae:	90                   	nop
   1400032af:	90                   	nop

00000001400032b0 <free>:
   1400032b0:	ff 25 aa 70 00 00    	jmp    *0x70aa(%rip)        # 14000a360 <__imp_free>
   1400032b6:	90                   	nop
   1400032b7:	90                   	nop

00000001400032b8 <fwrite>:
   1400032b8:	ff 25 aa 70 00 00    	jmp    *0x70aa(%rip)        # 14000a368 <__imp_fwrite>
   1400032be:	90                   	nop
   1400032bf:	90                   	nop

00000001400032c0 <malloc>:
   1400032c0:	ff 25 aa 70 00 00    	jmp    *0x70aa(%rip)        # 14000a370 <__imp_malloc>
   1400032c6:	90                   	nop
   1400032c7:	90                   	nop

00000001400032c8 <memcpy>:
   1400032c8:	ff 25 aa 70 00 00    	jmp    *0x70aa(%rip)        # 14000a378 <__imp_memcpy>
   1400032ce:	90                   	nop
   1400032cf:	90                   	nop

00000001400032d0 <signal>:
   1400032d0:	ff 25 aa 70 00 00    	jmp    *0x70aa(%rip)        # 14000a380 <__imp_signal>
   1400032d6:	90                   	nop
   1400032d7:	90                   	nop

00000001400032d8 <strlen>:
   1400032d8:	ff 25 aa 70 00 00    	jmp    *0x70aa(%rip)        # 14000a388 <__imp_strlen>
   1400032de:	90                   	nop
   1400032df:	90                   	nop

00000001400032e0 <strncmp>:
   1400032e0:	ff 25 aa 70 00 00    	jmp    *0x70aa(%rip)        # 14000a390 <__imp_strncmp>
   1400032e6:	90                   	nop
   1400032e7:	90                   	nop
   1400032e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   1400032ef:	00 

00000001400032f0 <VirtualQuery>:
   1400032f0:	ff 25 62 6f 00 00    	jmp    *0x6f62(%rip)        # 14000a258 <__imp_VirtualQuery>
   1400032f6:	90                   	nop
   1400032f7:	90                   	nop

00000001400032f8 <VirtualProtect>:
   1400032f8:	ff 25 52 6f 00 00    	jmp    *0x6f52(%rip)        # 14000a250 <__imp_VirtualProtect>
   1400032fe:	90                   	nop
   1400032ff:	90                   	nop

0000000140003300 <TlsGetValue>:
   140003300:	ff 25 42 6f 00 00    	jmp    *0x6f42(%rip)        # 14000a248 <__imp_TlsGetValue>
   140003306:	90                   	nop
   140003307:	90                   	nop

0000000140003308 <Sleep>:
   140003308:	ff 25 32 6f 00 00    	jmp    *0x6f32(%rip)        # 14000a240 <__imp_Sleep>
   14000330e:	90                   	nop
   14000330f:	90                   	nop

0000000140003310 <SetUnhandledExceptionFilter>:
   140003310:	ff 25 22 6f 00 00    	jmp    *0x6f22(%rip)        # 14000a238 <__imp_SetUnhandledExceptionFilter>
   140003316:	90                   	nop
   140003317:	90                   	nop

0000000140003318 <LoadLibraryA>:
   140003318:	ff 25 12 6f 00 00    	jmp    *0x6f12(%rip)        # 14000a230 <__imp_LoadLibraryA>
   14000331e:	90                   	nop
   14000331f:	90                   	nop

0000000140003320 <LeaveCriticalSection>:
   140003320:	ff 25 02 6f 00 00    	jmp    *0x6f02(%rip)        # 14000a228 <__imp_LeaveCriticalSection>
   140003326:	90                   	nop
   140003327:	90                   	nop

0000000140003328 <InitializeCriticalSection>:
   140003328:	ff 25 f2 6e 00 00    	jmp    *0x6ef2(%rip)        # 14000a220 <__imp_InitializeCriticalSection>
   14000332e:	90                   	nop
   14000332f:	90                   	nop

0000000140003330 <GetProcAddress>:
   140003330:	ff 25 e2 6e 00 00    	jmp    *0x6ee2(%rip)        # 14000a218 <__imp_GetProcAddress>
   140003336:	90                   	nop
   140003337:	90                   	nop

0000000140003338 <GetModuleHandleA>:
   140003338:	ff 25 d2 6e 00 00    	jmp    *0x6ed2(%rip)        # 14000a210 <__imp_GetModuleHandleA>
   14000333e:	90                   	nop
   14000333f:	90                   	nop

0000000140003340 <GetLastError>:
   140003340:	ff 25 c2 6e 00 00    	jmp    *0x6ec2(%rip)        # 14000a208 <__imp_GetLastError>
   140003346:	90                   	nop
   140003347:	90                   	nop

0000000140003348 <FreeLibrary>:
   140003348:	ff 25 b2 6e 00 00    	jmp    *0x6eb2(%rip)        # 14000a200 <__imp_FreeLibrary>
   14000334e:	90                   	nop
   14000334f:	90                   	nop

0000000140003350 <EnterCriticalSection>:
   140003350:	ff 25 a2 6e 00 00    	jmp    *0x6ea2(%rip)        # 14000a1f8 <__imp_EnterCriticalSection>
   140003356:	90                   	nop
   140003357:	90                   	nop

0000000140003358 <DeleteCriticalSection>:
   140003358:	ff 25 92 6e 00 00    	jmp    *0x6e92(%rip)        # 14000a1f0 <__IAT_start__>
   14000335e:	90                   	nop
   14000335f:	90                   	nop

0000000140003360 <register_frame_ctor>:
   140003360:	e9 7b e2 ff ff       	jmp    1400015e0 <__gcc_register_frame>
   140003365:	90                   	nop
   140003366:	90                   	nop
   140003367:	90                   	nop
   140003368:	90                   	nop
   140003369:	90                   	nop
   14000336a:	90                   	nop
   14000336b:	90                   	nop
   14000336c:	90                   	nop
   14000336d:	90                   	nop
   14000336e:	90                   	nop
   14000336f:	90                   	nop

0000000140003370 <__CTOR_LIST__>:
   140003370:	ff                   	(bad)
   140003371:	ff                   	(bad)
   140003372:	ff                   	(bad)
   140003373:	ff                   	(bad)
   140003374:	ff                   	(bad)
   140003375:	ff                   	(bad)
   140003376:	ff                   	(bad)
   140003377:	ff                   	.byte 0xff

0000000140003378 <.ctors.65535>:
   140003378:	60                   	(bad)
   140003379:	33 00                	xor    (%rax),%eax
   14000337b:	40 01 00             	rex add %eax,(%rax)
	...

0000000140003388 <__DTOR_LIST__>:
   140003388:	ff                   	(bad)
   140003389:	ff                   	(bad)
   14000338a:	ff                   	(bad)
   14000338b:	ff                   	(bad)
   14000338c:	ff                   	(bad)
   14000338d:	ff                   	(bad)
   14000338e:	ff                   	(bad)
   14000338f:	ff 00                	incl   (%rax)
   140003391:	00 00                	add    %al,(%rax)
   140003393:	00 00                	add    %al,(%rax)
   140003395:	00 00                	add    %al,(%rax)
	...
