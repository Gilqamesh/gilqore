
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
   140001024:	89 05 f6 8f 01 00    	mov    %eax,0x18ff6(%rip)        # 14001a020 <managedapp>
   14000102a:	48 8b 05 bf 4e 01 00 	mov    0x14ebf(%rip),%rax        # 140015ef0 <.refptr.__mingw_app_type>
   140001031:	8b 00                	mov    (%rax),%eax
   140001033:	85 c0                	test   %eax,%eax
   140001035:	74 0c                	je     140001043 <pre_c_init+0x2c>
   140001037:	b9 02 00 00 00       	mov    $0x2,%ecx
   14000103c:	e8 cf 09 01 00       	call   140011a10 <__set_app_type>
   140001041:	eb 0a                	jmp    14000104d <pre_c_init+0x36>
   140001043:	b9 01 00 00 00       	mov    $0x1,%ecx
   140001048:	e8 c3 09 01 00       	call   140011a10 <__set_app_type>
   14000104d:	e8 2e 09 01 00       	call   140011980 <__p__fmode>
   140001052:	48 8b 15 77 4f 01 00 	mov    0x14f77(%rip),%rdx        # 140015fd0 <.refptr._fmode>
   140001059:	8b 12                	mov    (%rdx),%edx
   14000105b:	89 10                	mov    %edx,(%rax)
   14000105d:	e8 0e 09 01 00       	call   140011970 <__p__commode>
   140001062:	48 8b 15 47 4f 01 00 	mov    0x14f47(%rip),%rdx        # 140015fb0 <.refptr._commode>
   140001069:	8b 12                	mov    (%rdx),%edx
   14000106b:	89 10                	mov    %edx,(%rax)
   14000106d:	e8 fe ee 00 00       	call   14000ff70 <_setargv>
   140001072:	48 8b 05 e7 4d 01 00 	mov    0x14de7(%rip),%rax        # 140015e60 <.refptr._MINGW_INSTALL_DEBUG_MATHERR>
   140001079:	8b 00                	mov    (%rax),%eax
   14000107b:	83 f8 01             	cmp    $0x1,%eax
   14000107e:	75 0f                	jne    14000108f <pre_c_init+0x78>
   140001080:	48 8b 05 69 4f 01 00 	mov    0x14f69(%rip),%rax        # 140015ff0 <.refptr._matherr>
   140001087:	48 89 c1             	mov    %rax,%rcx
   14000108a:	e8 3b fa 00 00       	call   140010aca <__mingw_setusermatherr>
   14000108f:	b8 00 00 00 00       	mov    $0x0,%eax
   140001094:	48 83 c4 20          	add    $0x20,%rsp
   140001098:	5d                   	pop    %rbp
   140001099:	c3                   	ret

000000014000109a <pre_cpp_init>:
   14000109a:	55                   	push   %rbp
   14000109b:	48 89 e5             	mov    %rsp,%rbp
   14000109e:	48 83 ec 30          	sub    $0x30,%rsp
   1400010a2:	48 8b 05 57 4f 01 00 	mov    0x14f57(%rip),%rax        # 140016000 <.refptr._newmode>
   1400010a9:	8b 00                	mov    (%rax),%eax
   1400010ab:	89 05 77 8f 01 00    	mov    %eax,0x18f77(%rip)        # 14001a028 <startinfo>
   1400010b1:	48 8b 05 08 4f 01 00 	mov    0x14f08(%rip),%rax        # 140015fc0 <.refptr._dowildcard>
   1400010b8:	8b 10                	mov    (%rax),%edx
   1400010ba:	48 8d 05 67 8f 01 00 	lea    0x18f67(%rip),%rax        # 14001a028 <startinfo>
   1400010c1:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   1400010c6:	41 89 d1             	mov    %edx,%r9d
   1400010c9:	4c 8d 05 40 8f 01 00 	lea    0x18f40(%rip),%r8        # 14001a010 <envp>
   1400010d0:	48 8d 05 31 8f 01 00 	lea    0x18f31(%rip),%rax        # 14001a008 <argv>
   1400010d7:	48 89 c2             	mov    %rax,%rdx
   1400010da:	48 8d 05 23 8f 01 00 	lea    0x18f23(%rip),%rax        # 14001a004 <argc>
   1400010e1:	48 89 c1             	mov    %rax,%rcx
   1400010e4:	e8 07 06 01 00       	call   1400116f0 <__getmainargs>
   1400010e9:	89 05 29 8f 01 00    	mov    %eax,0x18f29(%rip)        # 14001a018 <argret>
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
   140001105:	48 8b 05 e4 4d 01 00 	mov    0x14de4(%rip),%rax        # 140015ef0 <.refptr.__mingw_app_type>
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
   140001134:	48 8b 05 b5 4d 01 00 	mov    0x14db5(%rip),%rax        # 140015ef0 <.refptr.__mingw_app_type>
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
   1400011a3:	48 8b 05 ee a0 01 00 	mov    0x1a0ee(%rip),%rax        # 14001b298 <__imp_Sleep>
   1400011aa:	ff d0                	call   *%rax
   1400011ac:	48 8b 05 9d 4d 01 00 	mov    0x14d9d(%rip),%rax        # 140015f50 <.refptr.__native_startup_lock>
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
   1400011e3:	48 8b 05 76 4d 01 00 	mov    0x14d76(%rip),%rax        # 140015f60 <.refptr.__native_startup_state>
   1400011ea:	8b 00                	mov    (%rax),%eax
   1400011ec:	83 f8 01             	cmp    $0x1,%eax
   1400011ef:	75 0c                	jne    1400011fd <__tmainCRTStartup+0xa9>
   1400011f1:	b9 1f 00 00 00       	mov    $0x1f,%ecx
   1400011f6:	e8 55 06 01 00       	call   140011850 <_amsg_exit>
   1400011fb:	eb 3f                	jmp    14000123c <__tmainCRTStartup+0xe8>
   1400011fd:	48 8b 05 5c 4d 01 00 	mov    0x14d5c(%rip),%rax        # 140015f60 <.refptr.__native_startup_state>
   140001204:	8b 00                	mov    (%rax),%eax
   140001206:	85 c0                	test   %eax,%eax
   140001208:	75 28                	jne    140001232 <__tmainCRTStartup+0xde>
   14000120a:	48 8b 05 4f 4d 01 00 	mov    0x14d4f(%rip),%rax        # 140015f60 <.refptr.__native_startup_state>
   140001211:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   140001217:	48 8b 05 82 4d 01 00 	mov    0x14d82(%rip),%rax        # 140015fa0 <.refptr.__xi_z>
   14000121e:	48 89 c2             	mov    %rax,%rdx
   140001221:	48 8b 05 68 4d 01 00 	mov    0x14d68(%rip),%rax        # 140015f90 <.refptr.__xi_a>
   140001228:	48 89 c1             	mov    %rax,%rcx
   14000122b:	e8 d8 07 01 00       	call   140011a08 <_initterm>
   140001230:	eb 0a                	jmp    14000123c <__tmainCRTStartup+0xe8>
   140001232:	c7 05 e8 8d 01 00 01 	movl   $0x1,0x18de8(%rip)        # 14001a024 <has_cctor>
   140001239:	00 00 00 
   14000123c:	48 8b 05 1d 4d 01 00 	mov    0x14d1d(%rip),%rax        # 140015f60 <.refptr.__native_startup_state>
   140001243:	8b 00                	mov    (%rax),%eax
   140001245:	83 f8 01             	cmp    $0x1,%eax
   140001248:	75 26                	jne    140001270 <__tmainCRTStartup+0x11c>
   14000124a:	48 8b 05 2f 4d 01 00 	mov    0x14d2f(%rip),%rax        # 140015f80 <.refptr.__xc_z>
   140001251:	48 89 c2             	mov    %rax,%rdx
   140001254:	48 8b 05 15 4d 01 00 	mov    0x14d15(%rip),%rax        # 140015f70 <.refptr.__xc_a>
   14000125b:	48 89 c1             	mov    %rax,%rcx
   14000125e:	e8 a5 07 01 00       	call   140011a08 <_initterm>
   140001263:	48 8b 05 f6 4c 01 00 	mov    0x14cf6(%rip),%rax        # 140015f60 <.refptr.__native_startup_state>
   14000126a:	c7 00 02 00 00 00    	movl   $0x2,(%rax)
   140001270:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   140001274:	75 1e                	jne    140001294 <__tmainCRTStartup+0x140>
   140001276:	48 8b 05 d3 4c 01 00 	mov    0x14cd3(%rip),%rax        # 140015f50 <.refptr.__native_startup_lock>
   14000127d:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   140001281:	48 c7 45 b0 00 00 00 	movq   $0x0,-0x50(%rbp)
   140001288:	00 
   140001289:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   14000128d:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   140001291:	48 87 10             	xchg   %rdx,(%rax)
   140001294:	48 8b 05 05 4c 01 00 	mov    0x14c05(%rip),%rax        # 140015ea0 <.refptr.__dyn_tls_init_callback>
   14000129b:	48 8b 00             	mov    (%rax),%rax
   14000129e:	48 85 c0             	test   %rax,%rax
   1400012a1:	74 1c                	je     1400012bf <__tmainCRTStartup+0x16b>
   1400012a3:	48 8b 05 f6 4b 01 00 	mov    0x14bf6(%rip),%rax        # 140015ea0 <.refptr.__dyn_tls_init_callback>
   1400012aa:	48 8b 00             	mov    (%rax),%rax
   1400012ad:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   1400012b3:	ba 02 00 00 00       	mov    $0x2,%edx
   1400012b8:	b9 00 00 00 00       	mov    $0x0,%ecx
   1400012bd:	ff d0                	call   *%rax
   1400012bf:	e8 f4 f6 00 00       	call   1400109b8 <_pei386_runtime_relocator>
   1400012c4:	48 8b 05 15 4d 01 00 	mov    0x14d15(%rip),%rax        # 140015fe0 <.refptr._gnu_exception_handler>
   1400012cb:	48 89 c1             	mov    %rax,%rcx
   1400012ce:	48 8b 05 bb 9f 01 00 	mov    0x19fbb(%rip),%rax        # 14001b290 <__imp_SetUnhandledExceptionFilter>
   1400012d5:	ff d0                	call   *%rax
   1400012d7:	48 8b 15 62 4c 01 00 	mov    0x14c62(%rip),%rdx        # 140015f40 <.refptr.__mingw_oldexcpt_handler>
   1400012de:	48 89 02             	mov    %rax,(%rdx)
   1400012e1:	48 8d 05 18 fd ff ff 	lea    -0x2e8(%rip),%rax        # 140001000 <__mingw_invalidParameterHandler>
   1400012e8:	48 89 c1             	mov    %rax,%rcx
   1400012eb:	e8 28 07 01 00       	call   140011a18 <_set_invalid_parameter_handler>
   1400012f0:	e8 bb ee 00 00       	call   1400101b0 <_fpreset>
   1400012f5:	8b 05 09 8d 01 00    	mov    0x18d09(%rip),%eax        # 14001a004 <argc>
   1400012fb:	48 8d 15 06 8d 01 00 	lea    0x18d06(%rip),%rdx        # 14001a008 <argv>
   140001302:	89 c1                	mov    %eax,%ecx
   140001304:	e8 73 01 00 00       	call   14000147c <duplicate_ppstrings>
   140001309:	e8 39 ec 00 00       	call   14000ff47 <__main>
   14000130e:	48 8b 05 bb 4b 01 00 	mov    0x14bbb(%rip),%rax        # 140015ed0 <.refptr.__imp___initenv>
   140001315:	48 8b 00             	mov    (%rax),%rax
   140001318:	48 8b 15 f1 8c 01 00 	mov    0x18cf1(%rip),%rdx        # 14001a010 <envp>
   14000131f:	48 89 10             	mov    %rdx,(%rax)
   140001322:	48 8b 0d e7 8c 01 00 	mov    0x18ce7(%rip),%rcx        # 14001a010 <envp>
   140001329:	48 8b 15 d8 8c 01 00 	mov    0x18cd8(%rip),%rdx        # 14001a008 <argv>
   140001330:	8b 05 ce 8c 01 00    	mov    0x18cce(%rip),%eax        # 14001a004 <argc>
   140001336:	49 89 c8             	mov    %rcx,%r8
   140001339:	89 c1                	mov    %eax,%ecx
   14000133b:	e8 34 bd 00 00       	call   14000d074 <main>
   140001340:	89 05 d6 8c 01 00    	mov    %eax,0x18cd6(%rip)        # 14001a01c <mainret>
   140001346:	8b 05 d4 8c 01 00    	mov    0x18cd4(%rip),%eax        # 14001a020 <managedapp>
   14000134c:	85 c0                	test   %eax,%eax
   14000134e:	75 0d                	jne    14000135d <__tmainCRTStartup+0x209>
   140001350:	8b 05 c6 8c 01 00    	mov    0x18cc6(%rip),%eax        # 14001a01c <mainret>
   140001356:	89 c1                	mov    %eax,%ecx
   140001358:	e8 db 06 01 00       	call   140011a38 <exit>
   14000135d:	8b 05 c1 8c 01 00    	mov    0x18cc1(%rip),%eax        # 14001a024 <has_cctor>
   140001363:	85 c0                	test   %eax,%eax
   140001365:	75 05                	jne    14000136c <__tmainCRTStartup+0x218>
   140001367:	e8 5c 06 01 00       	call   1400119c8 <_cexit>
   14000136c:	8b 05 aa 8c 01 00    	mov    0x18caa(%rip),%eax        # 14001a01c <mainret>
   140001372:	48 83 c4 70          	add    $0x70,%rsp
   140001376:	5d                   	pop    %rbp
   140001377:	c3                   	ret

0000000140001378 <check_managed_app>:
   140001378:	55                   	push   %rbp
   140001379:	48 89 e5             	mov    %rsp,%rbp
   14000137c:	48 83 ec 20          	sub    $0x20,%rsp
   140001380:	48 8b 05 79 4b 01 00 	mov    0x14b79(%rip),%rax        # 140015f00 <.refptr.__mingw_initltsdrot_force>
   140001387:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   14000138d:	48 8b 05 7c 4b 01 00 	mov    0x14b7c(%rip),%rax        # 140015f10 <.refptr.__mingw_initltsdyn_force>
   140001394:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   14000139a:	48 8b 05 7f 4b 01 00 	mov    0x14b7f(%rip),%rax        # 140015f20 <.refptr.__mingw_initltssuo_force>
   1400013a1:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   1400013a7:	48 8b 05 12 4b 01 00 	mov    0x14b12(%rip),%rax        # 140015ec0 <.refptr.__image_base__>
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
   14000149d:	e8 ce 05 01 00       	call   140011a70 <malloc>
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
   1400014d7:	e8 d4 05 01 00       	call   140011ab0 <strlen>
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
   140001500:	e8 6b 05 01 00       	call   140011a70 <malloc>
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
   140001540:	e8 33 05 01 00       	call   140011a78 <memcpy>
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
   140001596:	e8 55 02 01 00       	call   1400117f0 <_onexit>
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
   1400015ed:	48 8d 35 0c 1a 01 00 	lea    0x11a0c(%rip),%rsi        # 140013000 <.rdata>
   1400015f4:	48 89 f1             	mov    %rsi,%rcx
   1400015f7:	ff 15 6b 9c 01 00    	call   *0x19c6b(%rip)        # 14001b268 <__imp_GetModuleHandleA>
   1400015fd:	48 89 c3             	mov    %rax,%rbx
   140001600:	48 85 c0             	test   %rax,%rax
   140001603:	74 6b                	je     140001670 <__gcc_register_frame+0x90>
   140001605:	48 89 f1             	mov    %rsi,%rcx
   140001608:	ff 15 7a 9c 01 00    	call   *0x19c7a(%rip)        # 14001b288 <__imp_LoadLibraryA>
   14000160e:	48 8b 3d 5b 9c 01 00 	mov    0x19c5b(%rip),%rdi        # 14001b270 <__imp_GetProcAddress>
   140001615:	48 8d 15 f7 19 01 00 	lea    0x119f7(%rip),%rdx        # 140013013 <.rdata+0x13>
   14000161c:	48 89 d9             	mov    %rbx,%rcx
   14000161f:	48 89 05 1a 8a 01 00 	mov    %rax,0x18a1a(%rip)        # 14001a040 <hmod_libgcc>
   140001626:	ff d7                	call   *%rdi
   140001628:	48 8d 15 fa 19 01 00 	lea    0x119fa(%rip),%rdx        # 140013029 <.rdata+0x29>
   14000162f:	48 89 d9             	mov    %rbx,%rcx
   140001632:	48 89 c6             	mov    %rax,%rsi
   140001635:	ff d7                	call   *%rdi
   140001637:	48 89 05 c2 09 01 00 	mov    %rax,0x109c2(%rip)        # 140012000 <__data_start__>
   14000163e:	48 85 f6             	test   %rsi,%rsi
   140001641:	74 10                	je     140001653 <__gcc_register_frame+0x73>
   140001643:	48 8d 15 16 8a 01 00 	lea    0x18a16(%rip),%rdx        # 14001a060 <obj>
   14000164a:	48 8d 0d af 59 01 00 	lea    0x159af(%rip),%rcx        # 140017000 <__EH_FRAME_BEGIN__>
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
   14000167e:	48 89 05 7b 09 01 00 	mov    %rax,0x1097b(%rip)        # 140012000 <__data_start__>
   140001685:	eb bc                	jmp    140001643 <__gcc_register_frame+0x63>
   140001687:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   14000168e:	00 00 

0000000140001690 <__gcc_deregister_frame>:
   140001690:	55                   	push   %rbp
   140001691:	48 89 e5             	mov    %rsp,%rbp
   140001694:	48 83 ec 20          	sub    $0x20,%rsp
   140001698:	48 8b 05 61 09 01 00 	mov    0x10961(%rip),%rax        # 140012000 <__data_start__>
   14000169f:	48 85 c0             	test   %rax,%rax
   1400016a2:	74 09                	je     1400016ad <__gcc_deregister_frame+0x1d>
   1400016a4:	48 8d 0d 55 59 01 00 	lea    0x15955(%rip),%rcx        # 140017000 <__EH_FRAME_BEGIN__>
   1400016ab:	ff d0                	call   *%rax
   1400016ad:	48 8b 0d 8c 89 01 00 	mov    0x1898c(%rip),%rcx        # 14001a040 <hmod_libgcc>
   1400016b4:	48 85 c9             	test   %rcx,%rcx
   1400016b7:	74 0f                	je     1400016c8 <__gcc_deregister_frame+0x38>
   1400016b9:	48 83 c4 20          	add    $0x20,%rsp
   1400016bd:	5d                   	pop    %rbp
   1400016be:	48 ff 25 93 9b 01 00 	rex.W jmp *0x19b93(%rip)        # 14001b258 <__imp_FreeLibrary>
   1400016c5:	0f 1f 00             	nopl   (%rax)
   1400016c8:	48 83 c4 20          	add    $0x20,%rsp
   1400016cc:	5d                   	pop    %rbp
   1400016cd:	c3                   	ret
   1400016ce:	90                   	nop
   1400016cf:	90                   	nop

00000001400016d0 <is_pow_of_two>:
   1400016d0:	55                   	push   %rbp
   1400016d1:	48 89 e5             	mov    %rsp,%rbp
   1400016d4:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400016d8:	48 83 7d 10 00       	cmpq   $0x0,0x10(%rbp)
   1400016dd:	75 07                	jne    1400016e6 <is_pow_of_two+0x16>
   1400016df:	b8 00 00 00 00       	mov    $0x0,%eax
   1400016e4:	eb 12                	jmp    1400016f8 <is_pow_of_two+0x28>
   1400016e6:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400016ea:	48 83 e8 01          	sub    $0x1,%rax
   1400016ee:	48 23 45 10          	and    0x10(%rbp),%rax
   1400016f2:	48 85 c0             	test   %rax,%rax
   1400016f5:	0f 94 c0             	sete   %al
   1400016f8:	5d                   	pop    %rbp
   1400016f9:	c3                   	ret

00000001400016fa <_type__print_value>:
   1400016fa:	55                   	push   %rbp
   1400016fb:	53                   	push   %rbx
   1400016fc:	48 83 ec 78          	sub    $0x78,%rsp
   140001700:	48 8d 6c 24 70       	lea    0x70(%rsp),%rbp
   140001705:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   140001709:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   14000170d:	44 89 45 30          	mov    %r8d,0x30(%rbp)
   140001711:	4c 89 4d 38          	mov    %r9,0x38(%rbp)
   140001715:	83 7d 30 00          	cmpl   $0x0,0x30(%rbp)
   140001719:	75 31                	jne    14000174c <_type__print_value+0x52>
   14000171b:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000171f:	8b 00                	mov    (%rax),%eax
   140001721:	85 c0                	test   %eax,%eax
   140001723:	0f 85 d7 04 00 00    	jne    140001c00 <_type__print_value+0x506>
   140001729:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000172d:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
   140001731:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   140001735:	4c 8b 40 30          	mov    0x30(%rax),%r8
   140001739:	48 8b 55 38          	mov    0x38(%rbp),%rdx
   14000173d:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140001741:	48 89 c1             	mov    %rax,%rcx
   140001744:	41 ff d0             	call   *%r8
   140001747:	e9 b4 04 00 00       	jmp    140001c00 <_type__print_value+0x506>
   14000174c:	48 8b 5d 38          	mov    0x38(%rbp),%rbx
   140001750:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140001754:	48 89 c1             	mov    %rax,%rcx
   140001757:	e8 fd 09 00 00       	call   140002159 <type__alignment>
   14000175c:	48 89 c1             	mov    %rax,%rcx
   14000175f:	48 89 d8             	mov    %rbx,%rax
   140001762:	ba 00 00 00 00       	mov    $0x0,%edx
   140001767:	48 f7 f1             	div    %rcx
   14000176a:	48 89 d1             	mov    %rdx,%rcx
   14000176d:	48 89 c8             	mov    %rcx,%rax
   140001770:	48 85 c0             	test   %rax,%rax
   140001773:	74 4c                	je     1400017c1 <_type__print_value+0xc7>
   140001775:	48 8b 5d 38          	mov    0x38(%rbp),%rbx
   140001779:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000177d:	48 89 c1             	mov    %rax,%rcx
   140001780:	e8 82 14 00 00       	call   140002c07 <type__max_alignment>
   140001785:	48 89 c1             	mov    %rax,%rcx
   140001788:	48 89 d8             	mov    %rbx,%rax
   14000178b:	ba 00 00 00 00       	mov    $0x0,%edx
   140001790:	48 f7 f1             	div    %rcx
   140001793:	48 89 d1             	mov    %rdx,%rcx
   140001796:	48 89 c8             	mov    %rcx,%rax
   140001799:	48 85 c0             	test   %rax,%rax
   14000179c:	74 23                	je     1400017c1 <_type__print_value+0xc7>
   14000179e:	41 b8 4a 00 00 00    	mov    $0x4a,%r8d
   1400017a4:	48 8d 05 a5 18 01 00 	lea    0x118a5(%rip),%rax        # 140013050 <.rdata>
   1400017ab:	48 89 c2             	mov    %rax,%rdx
   1400017ae:	48 8d 05 a3 18 01 00 	lea    0x118a3(%rip),%rax        # 140013058 <.rdata+0x8>
   1400017b5:	48 89 c1             	mov    %rax,%rcx
   1400017b8:	48 8b 05 81 9b 01 00 	mov    0x19b81(%rip),%rax        # 14001b340 <__imp__assert>
   1400017bf:	ff d0                	call   *%rax
   1400017c1:	48 8b 45 20          	mov    0x20(%rbp),%rax
   1400017c5:	8b 00                	mov    (%rax),%eax
   1400017c7:	83 f8 05             	cmp    $0x5,%eax
   1400017ca:	0f 87 0d 04 00 00    	ja     140001bdd <_type__print_value+0x4e3>
   1400017d0:	89 c0                	mov    %eax,%eax
   1400017d2:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   1400017d9:	00 
   1400017da:	48 8d 05 93 19 01 00 	lea    0x11993(%rip),%rax        # 140013174 <.rdata+0x124>
   1400017e1:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   1400017e4:	48 98                	cltq
   1400017e6:	48 8d 15 87 19 01 00 	lea    0x11987(%rip),%rdx        # 140013174 <.rdata+0x124>
   1400017ed:	48 01 d0             	add    %rdx,%rax
   1400017f0:	ff e0                	jmp    *%rax
   1400017f2:	48 8b 45 20          	mov    0x20(%rbp),%rax
   1400017f6:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   1400017fa:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   1400017fe:	4c 8b 40 30          	mov    0x30(%rax),%r8
   140001802:	48 8b 55 38          	mov    0x38(%rbp),%rdx
   140001806:	48 8b 45 28          	mov    0x28(%rbp),%rax
   14000180a:	48 89 c1             	mov    %rax,%rcx
   14000180d:	41 ff d0             	call   *%r8
   140001810:	e9 ec 03 00 00       	jmp    140001c01 <_type__print_value+0x507>
   140001815:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140001819:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   14000181d:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140001821:	48 89 c2             	mov    %rax,%rdx
   140001824:	b9 7b 00 00 00       	mov    $0x7b,%ecx
   140001829:	e8 22 02 01 00       	call   140011a50 <fputc>
   14000182e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   140001835:	e9 4a 01 00 00       	jmp    140001984 <_type__print_value+0x28a>
   14000183a:	48 8b 5d 38          	mov    0x38(%rbp),%rbx
   14000183e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   140001842:	48 8b 48 30          	mov    0x30(%rax),%rcx
   140001846:	8b 55 fc             	mov    -0x4(%rbp),%edx
   140001849:	48 89 d0             	mov    %rdx,%rax
   14000184c:	48 01 c0             	add    %rax,%rax
   14000184f:	48 01 d0             	add    %rdx,%rax
   140001852:	48 c1 e0 03          	shl    $0x3,%rax
   140001856:	48 01 c8             	add    %rcx,%rax
   140001859:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000185d:	48 89 c1             	mov    %rax,%rcx
   140001860:	e8 f4 08 00 00       	call   140002159 <type__alignment>
   140001865:	48 89 c1             	mov    %rax,%rcx
   140001868:	48 89 d8             	mov    %rbx,%rax
   14000186b:	ba 00 00 00 00       	mov    $0x0,%edx
   140001870:	48 f7 f1             	div    %rcx
   140001873:	48 89 d1             	mov    %rdx,%rcx
   140001876:	48 89 c8             	mov    %rcx,%rax
   140001879:	48 85 c0             	test   %rax,%rax
   14000187c:	74 4c                	je     1400018ca <_type__print_value+0x1d0>
   14000187e:	48 8b 5d 38          	mov    0x38(%rbp),%rbx
   140001882:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140001886:	48 89 c1             	mov    %rax,%rcx
   140001889:	e8 79 13 00 00       	call   140002c07 <type__max_alignment>
   14000188e:	48 89 c1             	mov    %rax,%rcx
   140001891:	48 89 d8             	mov    %rbx,%rax
   140001894:	ba 00 00 00 00       	mov    $0x0,%edx
   140001899:	48 f7 f1             	div    %rcx
   14000189c:	48 89 d1             	mov    %rdx,%rcx
   14000189f:	48 89 c8             	mov    %rcx,%rax
   1400018a2:	48 85 c0             	test   %rax,%rax
   1400018a5:	74 23                	je     1400018ca <_type__print_value+0x1d0>
   1400018a7:	41 b8 58 00 00 00    	mov    $0x58,%r8d
   1400018ad:	48 8d 05 9c 17 01 00 	lea    0x1179c(%rip),%rax        # 140013050 <.rdata>
   1400018b4:	48 89 c2             	mov    %rax,%rdx
   1400018b7:	48 8d 05 0a 18 01 00 	lea    0x1180a(%rip),%rax        # 1400130c8 <.rdata+0x78>
   1400018be:	48 89 c1             	mov    %rax,%rcx
   1400018c1:	48 8b 05 78 9a 01 00 	mov    0x19a78(%rip),%rax        # 14001b340 <__imp__assert>
   1400018c8:	ff d0                	call   *%rax
   1400018ca:	8b 45 30             	mov    0x30(%rbp),%eax
   1400018cd:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
   1400018d1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   1400018d5:	48 8b 48 30          	mov    0x30(%rax),%rcx
   1400018d9:	8b 55 fc             	mov    -0x4(%rbp),%edx
   1400018dc:	48 89 d0             	mov    %rdx,%rax
   1400018df:	48 01 c0             	add    %rax,%rax
   1400018e2:	48 01 d0             	add    %rdx,%rax
   1400018e5:	48 c1 e0 03          	shl    $0x3,%rax
   1400018e9:	48 01 c8             	add    %rcx,%rax
   1400018ec:	48 8b 40 08          	mov    0x8(%rax),%rax
   1400018f0:	48 8b 4d 38          	mov    0x38(%rbp),%rcx
   1400018f4:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   1400018f8:	49 89 c9             	mov    %rcx,%r9
   1400018fb:	48 89 c1             	mov    %rax,%rcx
   1400018fe:	e8 f7 fd ff ff       	call   1400016fa <_type__print_value>
   140001903:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   140001907:	8b 40 3c             	mov    0x3c(%rax),%eax
   14000190a:	83 e8 01             	sub    $0x1,%eax
   14000190d:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   140001910:	73 6e                	jae    140001980 <_type__print_value+0x286>
   140001912:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140001916:	49 89 c1             	mov    %rax,%r9
   140001919:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000191f:	ba 01 00 00 00       	mov    $0x1,%edx
   140001924:	48 8d 05 2b 18 01 00 	lea    0x1182b(%rip),%rax        # 140013156 <.rdata+0x106>
   14000192b:	48 89 c1             	mov    %rax,%rcx
   14000192e:	e8 35 01 01 00       	call   140011a68 <fwrite>
   140001933:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   140001937:	48 8b 50 30          	mov    0x30(%rax),%rdx
   14000193b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   14000193e:	83 c0 01             	add    $0x1,%eax
   140001941:	89 c1                	mov    %eax,%ecx
   140001943:	48 89 c8             	mov    %rcx,%rax
   140001946:	48 01 c0             	add    %rax,%rax
   140001949:	48 01 c8             	add    %rcx,%rax
   14000194c:	48 c1 e0 03          	shl    $0x3,%rax
   140001950:	48 01 d0             	add    %rdx,%rax
   140001953:	48 8b 48 10          	mov    0x10(%rax),%rcx
   140001957:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   14000195b:	4c 8b 40 30          	mov    0x30(%rax),%r8
   14000195f:	8b 55 fc             	mov    -0x4(%rbp),%edx
   140001962:	48 89 d0             	mov    %rdx,%rax
   140001965:	48 01 c0             	add    %rax,%rax
   140001968:	48 01 d0             	add    %rdx,%rax
   14000196b:	48 c1 e0 03          	shl    $0x3,%rax
   14000196f:	4c 01 c0             	add    %r8,%rax
   140001972:	48 8b 40 10          	mov    0x10(%rax),%rax
   140001976:	48 29 c1             	sub    %rax,%rcx
   140001979:	48 89 ca             	mov    %rcx,%rdx
   14000197c:	48 01 55 38          	add    %rdx,0x38(%rbp)
   140001980:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   140001984:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   140001988:	8b 40 3c             	mov    0x3c(%rax),%eax
   14000198b:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   14000198e:	0f 82 a6 fe ff ff    	jb     14000183a <_type__print_value+0x140>
   140001994:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140001998:	48 89 c2             	mov    %rax,%rdx
   14000199b:	b9 7d 00 00 00       	mov    $0x7d,%ecx
   1400019a0:	e8 ab 00 01 00       	call   140011a50 <fputc>
   1400019a5:	e9 57 02 00 00       	jmp    140001c01 <_type__print_value+0x507>
   1400019aa:	48 8b 45 20          	mov    0x20(%rbp),%rax
   1400019ae:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   1400019b2:	48 8b 45 28          	mov    0x28(%rbp),%rax
   1400019b6:	48 89 c2             	mov    %rax,%rdx
   1400019b9:	b9 7c 00 00 00       	mov    $0x7c,%ecx
   1400019be:	e8 8d 00 01 00       	call   140011a50 <fputc>
   1400019c3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   1400019ca:	eb 6d                	jmp    140001a39 <_type__print_value+0x33f>
   1400019cc:	8b 45 30             	mov    0x30(%rbp),%eax
   1400019cf:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
   1400019d3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   1400019d7:	48 8b 48 40          	mov    0x40(%rax),%rcx
   1400019db:	8b 55 f8             	mov    -0x8(%rbp),%edx
   1400019de:	48 89 d0             	mov    %rdx,%rax
   1400019e1:	48 01 c0             	add    %rax,%rax
   1400019e4:	48 01 d0             	add    %rdx,%rax
   1400019e7:	48 c1 e0 03          	shl    $0x3,%rax
   1400019eb:	48 01 c8             	add    %rcx,%rax
   1400019ee:	48 8b 40 08          	mov    0x8(%rax),%rax
   1400019f2:	48 8b 4d 38          	mov    0x38(%rbp),%rcx
   1400019f6:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   1400019fa:	49 89 c9             	mov    %rcx,%r9
   1400019fd:	48 89 c1             	mov    %rax,%rcx
   140001a00:	e8 f5 fc ff ff       	call   1400016fa <_type__print_value>
   140001a05:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   140001a09:	8b 40 4c             	mov    0x4c(%rax),%eax
   140001a0c:	83 e8 01             	sub    $0x1,%eax
   140001a0f:	39 45 f8             	cmp    %eax,-0x8(%rbp)
   140001a12:	73 21                	jae    140001a35 <_type__print_value+0x33b>
   140001a14:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140001a18:	49 89 c1             	mov    %rax,%r9
   140001a1b:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140001a21:	ba 01 00 00 00       	mov    $0x1,%edx
   140001a26:	48 8d 05 29 17 01 00 	lea    0x11729(%rip),%rax        # 140013156 <.rdata+0x106>
   140001a2d:	48 89 c1             	mov    %rax,%rcx
   140001a30:	e8 33 00 01 00       	call   140011a68 <fwrite>
   140001a35:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   140001a39:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   140001a3d:	8b 40 4c             	mov    0x4c(%rax),%eax
   140001a40:	39 45 f8             	cmp    %eax,-0x8(%rbp)
   140001a43:	72 87                	jb     1400019cc <_type__print_value+0x2d2>
   140001a45:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140001a49:	49 89 c1             	mov    %rax,%r9
   140001a4c:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   140001a52:	ba 01 00 00 00       	mov    $0x1,%edx
   140001a57:	48 8d 05 fb 16 01 00 	lea    0x116fb(%rip),%rax        # 140013159 <.rdata+0x109>
   140001a5e:	48 89 c1             	mov    %rax,%rcx
   140001a61:	e8 02 00 01 00       	call   140011a68 <fwrite>
   140001a66:	8b 45 30             	mov    0x30(%rbp),%eax
   140001a69:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
   140001a6d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   140001a71:	48 8b 40 38          	mov    0x38(%rax),%rax
   140001a75:	48 8b 40 08          	mov    0x8(%rax),%rax
   140001a79:	48 8b 4d 38          	mov    0x38(%rbp),%rcx
   140001a7d:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   140001a81:	49 89 c9             	mov    %rcx,%r9
   140001a84:	48 89 c1             	mov    %rax,%rcx
   140001a87:	e8 6e fc ff ff       	call   1400016fa <_type__print_value>
   140001a8c:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140001a90:	48 89 c2             	mov    %rax,%rdx
   140001a93:	b9 7c 00 00 00       	mov    $0x7c,%ecx
   140001a98:	e8 b3 ff 00 00       	call   140011a50 <fputc>
   140001a9d:	e9 5f 01 00 00       	jmp    140001c01 <_type__print_value+0x507>
   140001aa2:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140001aa6:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   140001aaa:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   140001aae:	48 8b 50 38          	mov    0x38(%rax),%rdx
   140001ab2:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140001ab6:	49 89 d0             	mov    %rdx,%r8
   140001ab9:	48 8d 15 9f 16 01 00 	lea    0x1169f(%rip),%rdx        # 14001315f <.rdata+0x10f>
   140001ac0:	48 89 c1             	mov    %rax,%rcx
   140001ac3:	e8 c8 fb 00 00       	call   140011690 <fprintf>
   140001ac8:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   140001acf:	00 
   140001ad0:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
   140001ad7:	00 
   140001ad8:	eb 78                	jmp    140001b52 <_type__print_value+0x458>
   140001ada:	48 8b 55 38          	mov    0x38(%rbp),%rdx
   140001ade:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140001ae2:	4c 8d 04 02          	lea    (%rdx,%rax,1),%r8
   140001ae6:	8b 45 30             	mov    0x30(%rbp),%eax
   140001ae9:	8d 48 ff             	lea    -0x1(%rax),%ecx
   140001aec:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   140001af0:	48 8b 40 30          	mov    0x30(%rax),%rax
   140001af4:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   140001af8:	4d 89 c1             	mov    %r8,%r9
   140001afb:	41 89 c8             	mov    %ecx,%r8d
   140001afe:	48 89 c1             	mov    %rax,%rcx
   140001b01:	e8 f4 fb ff ff       	call   1400016fa <_type__print_value>
   140001b06:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   140001b0a:	48 8b 40 30          	mov    0x30(%rax),%rax
   140001b0e:	48 89 c1             	mov    %rax,%rcx
   140001b11:	e8 55 06 00 00       	call   14000216b <type__size>
   140001b16:	48 01 45 f0          	add    %rax,-0x10(%rbp)
   140001b1a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   140001b1e:	48 8b 40 38          	mov    0x38(%rax),%rax
   140001b22:	48 83 e8 01          	sub    $0x1,%rax
   140001b26:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   140001b2a:	73 21                	jae    140001b4d <_type__print_value+0x453>
   140001b2c:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140001b30:	49 89 c1             	mov    %rax,%r9
   140001b33:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140001b39:	ba 01 00 00 00       	mov    $0x1,%edx
   140001b3e:	48 8d 05 11 16 01 00 	lea    0x11611(%rip),%rax        # 140013156 <.rdata+0x106>
   140001b45:	48 89 c1             	mov    %rax,%rcx
   140001b48:	e8 1b ff 00 00       	call   140011a68 <fwrite>
   140001b4d:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   140001b52:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   140001b56:	48 8b 40 38          	mov    0x38(%rax),%rax
   140001b5a:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   140001b5e:	0f 82 76 ff ff ff    	jb     140001ada <_type__print_value+0x3e0>
   140001b64:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140001b68:	48 89 c2             	mov    %rax,%rdx
   140001b6b:	b9 5d 00 00 00       	mov    $0x5d,%ecx
   140001b70:	e8 db fe 00 00       	call   140011a50 <fputc>
   140001b75:	e9 87 00 00 00       	jmp    140001c01 <_type__print_value+0x507>
   140001b7a:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140001b7e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   140001b82:	8b 45 30             	mov    0x30(%rbp),%eax
   140001b85:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
   140001b89:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   140001b8d:	48 8b 40 30          	mov    0x30(%rax),%rax
   140001b91:	48 8b 4d 38          	mov    0x38(%rbp),%rcx
   140001b95:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   140001b99:	49 89 c9             	mov    %rcx,%r9
   140001b9c:	48 89 c1             	mov    %rax,%rcx
   140001b9f:	e8 56 fb ff ff       	call   1400016fa <_type__print_value>
   140001ba4:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140001ba8:	48 89 c2             	mov    %rax,%rdx
   140001bab:	b9 2a 00 00 00       	mov    $0x2a,%ecx
   140001bb0:	e8 9b fe 00 00       	call   140011a50 <fputc>
   140001bb5:	eb 4a                	jmp    140001c01 <_type__print_value+0x507>
   140001bb7:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140001bbb:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   140001bbf:	48 8b 45 38          	mov    0x38(%rbp),%rax
   140001bc3:	8b 10                	mov    (%rax),%edx
   140001bc5:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140001bc9:	41 89 d0             	mov    %edx,%r8d
   140001bcc:	48 8d 15 94 15 01 00 	lea    0x11594(%rip),%rdx        # 140013167 <.rdata+0x117>
   140001bd3:	48 89 c1             	mov    %rax,%rcx
   140001bd6:	e8 b5 fa 00 00       	call   140011690 <fprintf>
   140001bdb:	eb 24                	jmp    140001c01 <_type__print_value+0x507>
   140001bdd:	41 b8 88 00 00 00    	mov    $0x88,%r8d
   140001be3:	48 8d 05 66 14 01 00 	lea    0x11466(%rip),%rax        # 140013050 <.rdata>
   140001bea:	48 89 c2             	mov    %rax,%rdx
   140001bed:	48 8d 05 78 15 01 00 	lea    0x11578(%rip),%rax        # 14001316c <.rdata+0x11c>
   140001bf4:	48 89 c1             	mov    %rax,%rcx
   140001bf7:	48 8b 05 42 97 01 00 	mov    0x19742(%rip),%rax        # 14001b340 <__imp__assert>
   140001bfe:	ff d0                	call   *%rax
   140001c00:	90                   	nop
   140001c01:	48 83 c4 78          	add    $0x78,%rsp
   140001c05:	5b                   	pop    %rbx
   140001c06:	5d                   	pop    %rbp
   140001c07:	c3                   	ret

0000000140001c08 <_type__create_hash>:
   140001c08:	55                   	push   %rbp
   140001c09:	48 89 e5             	mov    %rsp,%rbp
   140001c0c:	48 83 ec 10          	sub    $0x10,%rsp
   140001c10:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140001c14:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   140001c1b:	00 
   140001c1c:	eb 17                	jmp    140001c35 <_type__create_hash+0x2d>
   140001c1e:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001c22:	48 8d 50 01          	lea    0x1(%rax),%rdx
   140001c26:	48 89 55 10          	mov    %rdx,0x10(%rbp)
   140001c2a:	0f b6 00             	movzbl (%rax),%eax
   140001c2d:	48 0f be c0          	movsbq %al,%rax
   140001c31:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   140001c35:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001c39:	0f b6 00             	movzbl (%rax),%eax
   140001c3c:	84 c0                	test   %al,%al
   140001c3e:	75 de                	jne    140001c1e <_type__create_hash+0x16>
   140001c40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001c44:	48 83 c4 10          	add    $0x10,%rsp
   140001c48:	5d                   	pop    %rbp
   140001c49:	c3                   	ret

0000000140001c4a <_type__create>:
   140001c4a:	55                   	push   %rbp
   140001c4b:	48 89 e5             	mov    %rsp,%rbp
   140001c4e:	48 83 ec 30          	sub    $0x30,%rsp
   140001c52:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140001c56:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140001c5a:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140001c5e:	48 89 c2             	mov    %rax,%rdx
   140001c61:	b9 01 00 00 00       	mov    $0x1,%ecx
   140001c66:	e8 c5 fd 00 00       	call   140011a30 <calloc>
   140001c6b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001c6f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001c73:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   140001c77:	48 89 50 08          	mov    %rdx,0x8(%rax)
   140001c7b:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001c7f:	48 89 c1             	mov    %rax,%rcx
   140001c82:	e8 81 ff ff ff       	call   140001c08 <_type__create_hash>
   140001c87:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001c8b:	48 89 42 28          	mov    %rax,0x28(%rdx)
   140001c8f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001c93:	48 83 c4 30          	add    $0x30,%rsp
   140001c97:	5d                   	pop    %rbp
   140001c98:	c3                   	ret

0000000140001c99 <_type_struct__update_member>:
   140001c99:	55                   	push   %rbp
   140001c9a:	48 89 e5             	mov    %rsp,%rbp
   140001c9d:	48 83 ec 50          	sub    $0x50,%rsp
   140001ca1:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140001ca5:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140001ca9:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001cad:	8b 00                	mov    (%rax),%eax
   140001caf:	83 f8 02             	cmp    $0x2,%eax
   140001cb2:	74 2e                	je     140001ce2 <_type_struct__update_member+0x49>
   140001cb4:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001cb8:	8b 00                	mov    (%rax),%eax
   140001cba:	83 f8 01             	cmp    $0x1,%eax
   140001cbd:	74 23                	je     140001ce2 <_type_struct__update_member+0x49>
   140001cbf:	41 b8 a1 00 00 00    	mov    $0xa1,%r8d
   140001cc5:	48 8d 05 84 13 01 00 	lea    0x11384(%rip),%rax        # 140013050 <.rdata>
   140001ccc:	48 89 c2             	mov    %rax,%rdx
   140001ccf:	48 8d 05 96 14 01 00 	lea    0x11496(%rip),%rax        # 14001316c <.rdata+0x11c>
   140001cd6:	48 89 c1             	mov    %rax,%rcx
   140001cd9:	48 8b 05 60 96 01 00 	mov    0x19660(%rip),%rax        # 14001b340 <__imp__assert>
   140001ce0:	ff d0                	call   *%rax
   140001ce2:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001ce6:	48 8b 50 10          	mov    0x10(%rax),%rdx
   140001cea:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140001cee:	48 8b 40 08          	mov    0x8(%rax),%rax
   140001cf2:	48 8b 40 10          	mov    0x10(%rax),%rax
   140001cf6:	48 39 c2             	cmp    %rax,%rdx
   140001cf9:	48 0f 42 d0          	cmovb  %rax,%rdx
   140001cfd:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001d01:	48 8b 40 18          	mov    0x18(%rax),%rax
   140001d05:	48 39 c2             	cmp    %rax,%rdx
   140001d08:	48 0f 47 d0          	cmova  %rax,%rdx
   140001d0c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001d10:	48 89 50 10          	mov    %rdx,0x10(%rax)
   140001d14:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001d18:	48 8b 40 20          	mov    0x20(%rax),%rax
   140001d1c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140001d20:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   140001d27:	00 
   140001d28:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140001d2c:	48 8b 40 08          	mov    0x8(%rax),%rax
   140001d30:	48 8b 48 10          	mov    0x10(%rax),%rcx
   140001d34:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140001d38:	ba 00 00 00 00       	mov    $0x0,%edx
   140001d3d:	48 f7 f1             	div    %rcx
   140001d40:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
   140001d44:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   140001d49:	74 1c                	je     140001d67 <_type_struct__update_member+0xce>
   140001d4b:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140001d4f:	48 8b 40 08          	mov    0x8(%rax),%rax
   140001d53:	48 8b 40 10          	mov    0x10(%rax),%rax
   140001d57:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   140001d5b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   140001d5f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   140001d63:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001d67:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001d6b:	48 8b 48 10          	mov    0x10(%rax),%rcx
   140001d6f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140001d73:	ba 00 00 00 00       	mov    $0x0,%edx
   140001d78:	48 f7 f1             	div    %rcx
   140001d7b:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
   140001d7f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   140001d84:	74 25                	je     140001dab <_type_struct__update_member+0x112>
   140001d86:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001d8a:	48 8b 40 10          	mov    0x10(%rax),%rax
   140001d8e:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   140001d92:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   140001d96:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140001d9a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   140001d9e:	48 39 c2             	cmp    %rax,%rdx
   140001da1:	48 0f 46 c2          	cmovbe %rdx,%rax
   140001da5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001da9:	eb 08                	jmp    140001db3 <_type_struct__update_member+0x11a>
   140001dab:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   140001db2:	00 
   140001db3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001db7:	48 01 45 f0          	add    %rax,-0x10(%rbp)
   140001dbb:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140001dbf:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   140001dc3:	48 89 50 10          	mov    %rdx,0x10(%rax)
   140001dc7:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140001dcb:	48 8b 40 08          	mov    0x8(%rax),%rax
   140001dcf:	48 89 c1             	mov    %rax,%rcx
   140001dd2:	e8 94 03 00 00       	call   14000216b <type__size>
   140001dd7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   140001ddb:	48 01 c2             	add    %rax,%rdx
   140001dde:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001de2:	48 89 50 20          	mov    %rdx,0x20(%rax)
   140001de6:	90                   	nop
   140001de7:	48 83 c4 50          	add    $0x50,%rsp
   140001deb:	5d                   	pop    %rbp
   140001dec:	c3                   	ret

0000000140001ded <_type_union__update_member>:
   140001ded:	55                   	push   %rbp
   140001dee:	53                   	push   %rbx
   140001def:	48 83 ec 28          	sub    $0x28,%rsp
   140001df3:	48 8d 6c 24 20       	lea    0x20(%rsp),%rbp
   140001df8:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   140001dfc:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   140001e00:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140001e04:	48 8b 40 38          	mov    0x38(%rax),%rax
   140001e08:	48 85 c0             	test   %rax,%rax
   140001e0b:	75 4a                	jne    140001e57 <_type_union__update_member+0x6a>
   140001e0d:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140001e11:	48 8b 40 30          	mov    0x30(%rax),%rax
   140001e15:	48 85 c0             	test   %rax,%rax
   140001e18:	74 23                	je     140001e3d <_type_union__update_member+0x50>
   140001e1a:	41 b8 bf 00 00 00    	mov    $0xbf,%r8d
   140001e20:	48 8d 05 29 12 01 00 	lea    0x11229(%rip),%rax        # 140013050 <.rdata>
   140001e27:	48 89 c2             	mov    %rax,%rdx
   140001e2a:	48 8d 05 5f 13 01 00 	lea    0x1135f(%rip),%rax        # 140013190 <.rdata+0x140>
   140001e31:	48 89 c1             	mov    %rax,%rcx
   140001e34:	48 8b 05 05 95 01 00 	mov    0x19505(%rip),%rax        # 14001b340 <__imp__assert>
   140001e3b:	ff d0                	call   *%rax
   140001e3d:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140001e41:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   140001e45:	48 89 50 38          	mov    %rdx,0x38(%rax)
   140001e49:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140001e4d:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   140001e51:	48 89 50 30          	mov    %rdx,0x30(%rax)
   140001e55:	eb 65                	jmp    140001ebc <_type_union__update_member+0xcf>
   140001e57:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140001e5b:	48 8b 40 08          	mov    0x8(%rax),%rax
   140001e5f:	48 89 c1             	mov    %rax,%rcx
   140001e62:	e8 04 03 00 00       	call   14000216b <type__size>
   140001e67:	48 89 c3             	mov    %rax,%rbx
   140001e6a:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140001e6e:	48 8b 40 38          	mov    0x38(%rax),%rax
   140001e72:	48 8b 40 08          	mov    0x8(%rax),%rax
   140001e76:	48 89 c1             	mov    %rax,%rcx
   140001e79:	e8 ed 02 00 00       	call   14000216b <type__size>
   140001e7e:	48 39 d8             	cmp    %rbx,%rax
   140001e81:	73 0c                	jae    140001e8f <_type_union__update_member+0xa2>
   140001e83:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140001e87:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   140001e8b:	48 89 50 38          	mov    %rdx,0x38(%rax)
   140001e8f:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140001e93:	48 8b 40 08          	mov    0x8(%rax),%rax
   140001e97:	48 8b 40 10          	mov    0x10(%rax),%rax
   140001e9b:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   140001e9f:	48 8b 52 30          	mov    0x30(%rdx),%rdx
   140001ea3:	48 8b 52 08          	mov    0x8(%rdx),%rdx
   140001ea7:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   140001eab:	48 39 c2             	cmp    %rax,%rdx
   140001eae:	73 0c                	jae    140001ebc <_type_union__update_member+0xcf>
   140001eb0:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140001eb4:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   140001eb8:	48 89 50 30          	mov    %rdx,0x30(%rax)
   140001ebc:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140001ec0:	48 8b 40 38          	mov    0x38(%rax),%rax
   140001ec4:	48 8b 40 08          	mov    0x8(%rax),%rax
   140001ec8:	48 89 c1             	mov    %rax,%rcx
   140001ecb:	e8 9b 02 00 00       	call   14000216b <type__size>
   140001ed0:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   140001ed4:	48 89 42 20          	mov    %rax,0x20(%rdx)
   140001ed8:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140001edc:	48 8b 40 30          	mov    0x30(%rax),%rax
   140001ee0:	48 8b 40 08          	mov    0x8(%rax),%rax
   140001ee4:	48 8b 50 10          	mov    0x10(%rax),%rdx
   140001ee8:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140001eec:	48 8b 40 18          	mov    0x18(%rax),%rax
   140001ef0:	48 39 c2             	cmp    %rax,%rdx
   140001ef3:	48 0f 47 d0          	cmova  %rax,%rdx
   140001ef7:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140001efb:	48 89 50 10          	mov    %rdx,0x10(%rax)
   140001eff:	90                   	nop
   140001f00:	48 83 c4 28          	add    $0x28,%rsp
   140001f04:	5b                   	pop    %rbx
   140001f05:	5d                   	pop    %rbp
   140001f06:	c3                   	ret

0000000140001f07 <type_atom__create>:
   140001f07:	55                   	push   %rbp
   140001f08:	48 89 e5             	mov    %rsp,%rbp
   140001f0b:	48 83 ec 30          	sub    $0x30,%rsp
   140001f0f:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140001f13:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140001f17:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140001f1b:	4c 89 4d 28          	mov    %r9,0x28(%rbp)
   140001f1f:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001f23:	ba 40 00 00 00       	mov    $0x40,%edx
   140001f28:	48 89 c1             	mov    %rax,%rcx
   140001f2b:	e8 1a fd ff ff       	call   140001c4a <_type__create>
   140001f30:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140001f34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001f38:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   140001f3e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001f42:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   140001f46:	48 89 50 10          	mov    %rdx,0x10(%rax)
   140001f4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001f4e:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   140001f55:	ff 
   140001f56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001f5a:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   140001f5e:	48 89 50 20          	mov    %rdx,0x20(%rax)
   140001f62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001f66:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140001f6a:	48 89 50 38          	mov    %rdx,0x38(%rax)
   140001f6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001f72:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   140001f76:	48 89 50 30          	mov    %rdx,0x30(%rax)
   140001f7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140001f7e:	48 83 c4 30          	add    $0x30,%rsp
   140001f82:	5d                   	pop    %rbp
   140001f83:	c3                   	ret

0000000140001f84 <type__set_max_alignment>:
   140001f84:	55                   	push   %rbp
   140001f85:	48 89 e5             	mov    %rsp,%rbp
   140001f88:	48 83 ec 40          	sub    $0x40,%rsp
   140001f8c:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140001f90:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140001f94:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001f98:	8b 00                	mov    (%rax),%eax
   140001f9a:	83 f8 01             	cmp    $0x1,%eax
   140001f9d:	74 0f                	je     140001fae <type__set_max_alignment+0x2a>
   140001f9f:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140001fa3:	8b 00                	mov    (%rax),%eax
   140001fa5:	83 f8 02             	cmp    $0x2,%eax
   140001fa8:	0f 85 34 01 00 00    	jne    1400020e2 <type__set_max_alignment+0x15e>
   140001fae:	48 83 7d 18 ff       	cmpq   $0xffffffffffffffff,0x18(%rbp)
   140001fb3:	74 5d                	je     140002012 <type__set_max_alignment+0x8e>
   140001fb5:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140001fb9:	48 89 c1             	mov    %rax,%rcx
   140001fbc:	e8 0f f7 ff ff       	call   1400016d0 <is_pow_of_two>
   140001fc1:	84 c0                	test   %al,%al
   140001fc3:	75 23                	jne    140001fe8 <type__set_max_alignment+0x64>
   140001fc5:	41 b8 e5 00 00 00    	mov    $0xe5,%r8d
   140001fcb:	48 8d 05 7e 10 01 00 	lea    0x1107e(%rip),%rax        # 140013050 <.rdata>
   140001fd2:	48 89 c2             	mov    %rax,%rdx
   140001fd5:	48 8d 05 d9 11 01 00 	lea    0x111d9(%rip),%rax        # 1400131b5 <.rdata+0x165>
   140001fdc:	48 89 c1             	mov    %rax,%rcx
   140001fdf:	48 8b 05 5a 93 01 00 	mov    0x1935a(%rip),%rax        # 14001b340 <__imp__assert>
   140001fe6:	ff d0                	call   *%rax
   140001fe8:	48 83 7d 18 10       	cmpq   $0x10,0x18(%rbp)
   140001fed:	76 23                	jbe    140002012 <type__set_max_alignment+0x8e>
   140001fef:	41 b8 e6 00 00 00    	mov    $0xe6,%r8d
   140001ff5:	48 8d 05 54 10 01 00 	lea    0x11054(%rip),%rax        # 140013050 <.rdata>
   140001ffc:	48 89 c2             	mov    %rax,%rdx
   140001fff:	48 8d 05 cc 11 01 00 	lea    0x111cc(%rip),%rax        # 1400131d2 <.rdata+0x182>
   140002006:	48 89 c1             	mov    %rax,%rcx
   140002009:	48 8b 05 30 93 01 00 	mov    0x19330(%rip),%rax        # 14001b340 <__imp__assert>
   140002010:	ff d0                	call   *%rax
   140002012:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002016:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   14000201a:	48 89 50 18          	mov    %rdx,0x18(%rax)
   14000201e:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002022:	8b 00                	mov    (%rax),%eax
   140002024:	83 f8 01             	cmp    $0x1,%eax
   140002027:	75 57                	jne    140002080 <type__set_max_alignment+0xfc>
   140002029:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000202d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   140002031:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002035:	48 c7 40 20 00 00 00 	movq   $0x0,0x20(%rax)
   14000203c:	00 
   14000203d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   140002044:	eb 2c                	jmp    140002072 <type__set_max_alignment+0xee>
   140002046:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000204a:	48 8b 48 30          	mov    0x30(%rax),%rcx
   14000204e:	8b 55 fc             	mov    -0x4(%rbp),%edx
   140002051:	48 89 d0             	mov    %rdx,%rax
   140002054:	48 01 c0             	add    %rax,%rax
   140002057:	48 01 d0             	add    %rdx,%rax
   14000205a:	48 c1 e0 03          	shl    $0x3,%rax
   14000205e:	48 8d 14 01          	lea    (%rcx,%rax,1),%rdx
   140002062:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140002066:	48 89 c1             	mov    %rax,%rcx
   140002069:	e8 2b fc ff ff       	call   140001c99 <_type_struct__update_member>
   14000206e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   140002072:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140002076:	8b 40 3c             	mov    0x3c(%rax),%eax
   140002079:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   14000207c:	72 c8                	jb     140002046 <type__set_max_alignment+0xc2>
   14000207e:	eb 63                	jmp    1400020e3 <type__set_max_alignment+0x15f>
   140002080:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002084:	8b 00                	mov    (%rax),%eax
   140002086:	83 f8 02             	cmp    $0x2,%eax
   140002089:	75 58                	jne    1400020e3 <type__set_max_alignment+0x15f>
   14000208b:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000208f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140002093:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002097:	48 c7 40 20 00 00 00 	movq   $0x0,0x20(%rax)
   14000209e:	00 
   14000209f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   1400020a6:	eb 2c                	jmp    1400020d4 <type__set_max_alignment+0x150>
   1400020a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   1400020ac:	48 8b 48 40          	mov    0x40(%rax),%rcx
   1400020b0:	8b 55 f8             	mov    -0x8(%rbp),%edx
   1400020b3:	48 89 d0             	mov    %rdx,%rax
   1400020b6:	48 01 c0             	add    %rax,%rax
   1400020b9:	48 01 d0             	add    %rdx,%rax
   1400020bc:	48 c1 e0 03          	shl    $0x3,%rax
   1400020c0:	48 8d 14 01          	lea    (%rcx,%rax,1),%rdx
   1400020c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   1400020c8:	48 89 c1             	mov    %rax,%rcx
   1400020cb:	e8 1d fd ff ff       	call   140001ded <_type_union__update_member>
   1400020d0:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   1400020d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   1400020d8:	8b 40 4c             	mov    0x4c(%rax),%eax
   1400020db:	39 45 f8             	cmp    %eax,-0x8(%rbp)
   1400020de:	72 c8                	jb     1400020a8 <type__set_max_alignment+0x124>
   1400020e0:	eb 01                	jmp    1400020e3 <type__set_max_alignment+0x15f>
   1400020e2:	90                   	nop
   1400020e3:	48 83 c4 40          	add    $0x40,%rsp
   1400020e7:	5d                   	pop    %rbp
   1400020e8:	c3                   	ret

00000001400020e9 <type__set_alignment>:
   1400020e9:	55                   	push   %rbp
   1400020ea:	48 89 e5             	mov    %rsp,%rbp
   1400020ed:	48 83 ec 20          	sub    $0x20,%rsp
   1400020f1:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400020f5:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400020f9:	48 83 7d 18 ff       	cmpq   $0xffffffffffffffff,0x18(%rbp)
   1400020fe:	74 33                	je     140002133 <type__set_alignment+0x4a>
   140002100:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140002104:	48 89 c1             	mov    %rax,%rcx
   140002107:	e8 c4 f5 ff ff       	call   1400016d0 <is_pow_of_two>
   14000210c:	84 c0                	test   %al,%al
   14000210e:	75 23                	jne    140002133 <type__set_alignment+0x4a>
   140002110:	41 b8 00 01 00 00    	mov    $0x100,%r8d
   140002116:	48 8d 05 33 0f 01 00 	lea    0x10f33(%rip),%rax        # 140013050 <.rdata>
   14000211d:	48 89 c2             	mov    %rax,%rdx
   140002120:	48 8d 05 bf 10 01 00 	lea    0x110bf(%rip),%rax        # 1400131e6 <.rdata+0x196>
   140002127:	48 89 c1             	mov    %rax,%rcx
   14000212a:	48 8b 05 0f 92 01 00 	mov    0x1920f(%rip),%rax        # 14001b340 <__imp__assert>
   140002131:	ff d0                	call   *%rax
   140002133:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002137:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   14000213b:	48 89 50 10          	mov    %rdx,0x10(%rax)
   14000213f:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002143:	48 c7 c2 ff ff ff ff 	mov    $0xffffffffffffffff,%rdx
   14000214a:	48 89 c1             	mov    %rax,%rcx
   14000214d:	e8 32 fe ff ff       	call   140001f84 <type__set_max_alignment>
   140002152:	90                   	nop
   140002153:	48 83 c4 20          	add    $0x20,%rsp
   140002157:	5d                   	pop    %rbp
   140002158:	c3                   	ret

0000000140002159 <type__alignment>:
   140002159:	55                   	push   %rbp
   14000215a:	48 89 e5             	mov    %rsp,%rbp
   14000215d:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002161:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002165:	48 8b 40 10          	mov    0x10(%rax),%rax
   140002169:	5d                   	pop    %rbp
   14000216a:	c3                   	ret

000000014000216b <type__size>:
   14000216b:	55                   	push   %rbp
   14000216c:	48 89 e5             	mov    %rsp,%rbp
   14000216f:	48 83 ec 10          	sub    $0x10,%rsp
   140002173:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002177:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000217b:	8b 00                	mov    (%rax),%eax
   14000217d:	83 f8 02             	cmp    $0x2,%eax
   140002180:	74 0b                	je     14000218d <type__size+0x22>
   140002182:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002186:	8b 00                	mov    (%rax),%eax
   140002188:	83 f8 01             	cmp    $0x1,%eax
   14000218b:	75 46                	jne    1400021d3 <type__size+0x68>
   14000218d:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002191:	48 8b 40 20          	mov    0x20(%rax),%rax
   140002195:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   140002199:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
   14000219d:	ba 00 00 00 00       	mov    $0x0,%edx
   1400021a2:	48 f7 f1             	div    %rcx
   1400021a5:	48 89 55 f8          	mov    %rdx,-0x8(%rbp)
   1400021a9:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   1400021ae:	74 19                	je     1400021c9 <type__size+0x5e>
   1400021b0:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400021b4:	48 8b 50 20          	mov    0x20(%rax),%rdx
   1400021b8:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400021bc:	48 8b 40 10          	mov    0x10(%rax),%rax
   1400021c0:	48 2b 45 f8          	sub    -0x8(%rbp),%rax
   1400021c4:	48 01 d0             	add    %rdx,%rax
   1400021c7:	eb 12                	jmp    1400021db <type__size+0x70>
   1400021c9:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400021cd:	48 8b 40 20          	mov    0x20(%rax),%rax
   1400021d1:	eb 08                	jmp    1400021db <type__size+0x70>
   1400021d3:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400021d7:	48 8b 40 20          	mov    0x20(%rax),%rax
   1400021db:	48 83 c4 10          	add    $0x10,%rsp
   1400021df:	5d                   	pop    %rbp
   1400021e0:	c3                   	ret

00000001400021e1 <type__abbreviated_name>:
   1400021e1:	55                   	push   %rbp
   1400021e2:	48 89 e5             	mov    %rsp,%rbp
   1400021e5:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400021e9:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400021ed:	48 8b 40 08          	mov    0x8(%rax),%rax
   1400021f1:	5d                   	pop    %rbp
   1400021f2:	c3                   	ret

00000001400021f3 <type__address>:
   1400021f3:	55                   	push   %rbp
   1400021f4:	48 89 e5             	mov    %rsp,%rbp
   1400021f7:	48 83 ec 30          	sub    $0x30,%rsp
   1400021fb:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400021ff:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140002203:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002207:	48 89 c1             	mov    %rax,%rcx
   14000220a:	e8 4a ff ff ff       	call   140002159 <type__alignment>
   14000220f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140002213:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   140002218:	75 23                	jne    14000223d <type__address+0x4a>
   14000221a:	41 b8 23 01 00 00    	mov    $0x123,%r8d
   140002220:	48 8d 05 29 0e 01 00 	lea    0x10e29(%rip),%rax        # 140013050 <.rdata>
   140002227:	48 89 c2             	mov    %rax,%rdx
   14000222a:	48 8d 05 ce 0f 01 00 	lea    0x10fce(%rip),%rax        # 1400131ff <.rdata+0x1af>
   140002231:	48 89 c1             	mov    %rax,%rcx
   140002234:	48 8b 05 05 91 01 00 	mov    0x19105(%rip),%rax        # 14001b340 <__imp__assert>
   14000223b:	ff d0                	call   *%rax
   14000223d:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140002241:	ba 00 00 00 00       	mov    $0x0,%edx
   140002246:	48 f7 75 f8          	divq   -0x8(%rbp)
   14000224a:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
   14000224e:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   140002253:	74 0c                	je     140002261 <type__address+0x6e>
   140002255:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002259:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
   14000225d:	48 01 45 18          	add    %rax,0x18(%rbp)
   140002261:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140002265:	ba 00 00 00 00       	mov    $0x0,%edx
   14000226a:	48 f7 75 f8          	divq   -0x8(%rbp)
   14000226e:	48 89 d0             	mov    %rdx,%rax
   140002271:	48 85 c0             	test   %rax,%rax
   140002274:	74 23                	je     140002299 <type__address+0xa6>
   140002276:	41 b8 28 01 00 00    	mov    $0x128,%r8d
   14000227c:	48 8d 05 cd 0d 01 00 	lea    0x10dcd(%rip),%rax        # 140013050 <.rdata>
   140002283:	48 89 c2             	mov    %rax,%rdx
   140002286:	48 8d 05 83 0f 01 00 	lea    0x10f83(%rip),%rax        # 140013210 <.rdata+0x1c0>
   14000228d:	48 89 c1             	mov    %rax,%rcx
   140002290:	48 8b 05 a9 90 01 00 	mov    0x190a9(%rip),%rax        # 14001b340 <__imp__assert>
   140002297:	ff d0                	call   *%rax
   140002299:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000229d:	48 83 c4 30          	add    $0x30,%rsp
   1400022a1:	5d                   	pop    %rbp
   1400022a2:	c3                   	ret

00000001400022a3 <type_struct__member>:
   1400022a3:	55                   	push   %rbp
   1400022a4:	48 89 e5             	mov    %rsp,%rbp
   1400022a7:	48 83 ec 30          	sub    $0x30,%rsp
   1400022ab:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400022af:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400022b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   1400022ba:	eb 4f                	jmp    14000230b <type_struct__member+0x68>
   1400022bc:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400022c0:	48 8b 48 30          	mov    0x30(%rax),%rcx
   1400022c4:	8b 55 fc             	mov    -0x4(%rbp),%edx
   1400022c7:	48 89 d0             	mov    %rdx,%rax
   1400022ca:	48 01 c0             	add    %rax,%rax
   1400022cd:	48 01 d0             	add    %rdx,%rax
   1400022d0:	48 c1 e0 03          	shl    $0x3,%rax
   1400022d4:	48 01 c8             	add    %rcx,%rax
   1400022d7:	48 8b 00             	mov    (%rax),%rax
   1400022da:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   1400022de:	48 89 c1             	mov    %rax,%rcx
   1400022e1:	e8 c2 f7 00 00       	call   140011aa8 <strcmp>
   1400022e6:	85 c0                	test   %eax,%eax
   1400022e8:	75 1d                	jne    140002307 <type_struct__member+0x64>
   1400022ea:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400022ee:	48 8b 48 30          	mov    0x30(%rax),%rcx
   1400022f2:	8b 55 fc             	mov    -0x4(%rbp),%edx
   1400022f5:	48 89 d0             	mov    %rdx,%rax
   1400022f8:	48 01 c0             	add    %rax,%rax
   1400022fb:	48 01 d0             	add    %rdx,%rax
   1400022fe:	48 c1 e0 03          	shl    $0x3,%rax
   140002302:	48 01 c8             	add    %rcx,%rax
   140002305:	eb 15                	jmp    14000231c <type_struct__member+0x79>
   140002307:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   14000230b:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000230f:	8b 40 3c             	mov    0x3c(%rax),%eax
   140002312:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   140002315:	72 a5                	jb     1400022bc <type_struct__member+0x19>
   140002317:	b8 00 00 00 00       	mov    $0x0,%eax
   14000231c:	48 83 c4 30          	add    $0x30,%rsp
   140002320:	5d                   	pop    %rbp
   140002321:	c3                   	ret

0000000140002322 <type_union__member>:
   140002322:	55                   	push   %rbp
   140002323:	48 89 e5             	mov    %rsp,%rbp
   140002326:	48 83 ec 30          	sub    $0x30,%rsp
   14000232a:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000232e:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140002332:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   140002339:	eb 4f                	jmp    14000238a <type_union__member+0x68>
   14000233b:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000233f:	48 8b 48 40          	mov    0x40(%rax),%rcx
   140002343:	8b 55 fc             	mov    -0x4(%rbp),%edx
   140002346:	48 89 d0             	mov    %rdx,%rax
   140002349:	48 01 c0             	add    %rax,%rax
   14000234c:	48 01 d0             	add    %rdx,%rax
   14000234f:	48 c1 e0 03          	shl    $0x3,%rax
   140002353:	48 01 c8             	add    %rcx,%rax
   140002356:	48 8b 00             	mov    (%rax),%rax
   140002359:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   14000235d:	48 89 c1             	mov    %rax,%rcx
   140002360:	e8 43 f7 00 00       	call   140011aa8 <strcmp>
   140002365:	85 c0                	test   %eax,%eax
   140002367:	75 1d                	jne    140002386 <type_union__member+0x64>
   140002369:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000236d:	48 8b 48 40          	mov    0x40(%rax),%rcx
   140002371:	8b 55 fc             	mov    -0x4(%rbp),%edx
   140002374:	48 89 d0             	mov    %rdx,%rax
   140002377:	48 01 c0             	add    %rax,%rax
   14000237a:	48 01 d0             	add    %rdx,%rax
   14000237d:	48 c1 e0 03          	shl    $0x3,%rax
   140002381:	48 01 c8             	add    %rcx,%rax
   140002384:	eb 15                	jmp    14000239b <type_union__member+0x79>
   140002386:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   14000238a:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000238e:	8b 40 4c             	mov    0x4c(%rax),%eax
   140002391:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   140002394:	72 a5                	jb     14000233b <type_union__member+0x19>
   140002396:	b8 00 00 00 00       	mov    $0x0,%eax
   14000239b:	48 83 c4 30          	add    $0x30,%rsp
   14000239f:	5d                   	pop    %rbp
   1400023a0:	c3                   	ret

00000001400023a1 <member__print>:
   1400023a1:	55                   	push   %rbp
   1400023a2:	48 89 e5             	mov    %rsp,%rbp
   1400023a5:	48 83 ec 30          	sub    $0x30,%rsp
   1400023a9:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400023ad:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400023b1:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400023b5:	48 8b 10             	mov    (%rax),%rdx
   1400023b8:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400023bc:	48 89 54 24 28       	mov    %rdx,0x28(%rsp)
   1400023c1:	48 8d 15 82 0e 01 00 	lea    0x10e82(%rip),%rdx        # 14001324a <.rdata+0x1fa>
   1400023c8:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   1400023cd:	41 b9 16 00 00 00    	mov    $0x16,%r9d
   1400023d3:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400023d9:	48 8d 15 60 0e 01 00 	lea    0x10e60(%rip),%rdx        # 140013240 <.rdata+0x1f0>
   1400023e0:	48 89 c1             	mov    %rax,%rcx
   1400023e3:	e8 a8 f2 00 00       	call   140011690 <fprintf>
   1400023e8:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400023ec:	48 8b 50 10          	mov    0x10(%rax),%rdx
   1400023f0:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400023f4:	48 89 54 24 28       	mov    %rdx,0x28(%rsp)
   1400023f9:	48 8d 15 5d 0e 01 00 	lea    0x10e5d(%rip),%rdx        # 14001325d <.rdata+0x20d>
   140002400:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   140002405:	41 b9 16 00 00 00    	mov    $0x16,%r9d
   14000240b:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140002411:	48 8d 15 39 0e 01 00 	lea    0x10e39(%rip),%rdx        # 140013251 <.rdata+0x201>
   140002418:	48 89 c1             	mov    %rax,%rcx
   14000241b:	e8 70 f2 00 00       	call   140011690 <fprintf>
   140002420:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002424:	48 8b 40 08          	mov    0x8(%rax),%rax
   140002428:	48 89 c1             	mov    %rax,%rcx
   14000242b:	e8 b1 fd ff ff       	call   1400021e1 <type__abbreviated_name>
   140002430:	48 89 c2             	mov    %rax,%rdx
   140002433:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140002437:	48 89 54 24 28       	mov    %rdx,0x28(%rsp)
   14000243c:	48 8d 15 23 0e 01 00 	lea    0x10e23(%rip),%rdx        # 140013266 <.rdata+0x216>
   140002443:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   140002448:	41 b9 16 00 00 00    	mov    $0x16,%r9d
   14000244e:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140002454:	48 8d 15 e5 0d 01 00 	lea    0x10de5(%rip),%rdx        # 140013240 <.rdata+0x1f0>
   14000245b:	48 89 c1             	mov    %rax,%rcx
   14000245e:	e8 2d f2 00 00       	call   140011690 <fprintf>
   140002463:	90                   	nop
   140002464:	48 83 c4 30          	add    $0x30,%rsp
   140002468:	5d                   	pop    %rbp
   140002469:	c3                   	ret

000000014000246a <member__name>:
   14000246a:	55                   	push   %rbp
   14000246b:	48 89 e5             	mov    %rsp,%rbp
   14000246e:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002472:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002476:	48 8b 00             	mov    (%rax),%rax
   140002479:	5d                   	pop    %rbp
   14000247a:	c3                   	ret

000000014000247b <type_struct__create>:
   14000247b:	55                   	push   %rbp
   14000247c:	48 89 e5             	mov    %rsp,%rbp
   14000247f:	48 83 ec 30          	sub    $0x30,%rsp
   140002483:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002487:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000248b:	ba 40 00 00 00       	mov    $0x40,%edx
   140002490:	48 89 c1             	mov    %rax,%rcx
   140002493:	e8 b2 f7 ff ff       	call   140001c4a <_type__create>
   140002498:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000249c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400024a0:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   1400024a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400024aa:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
   1400024b1:	00 
   1400024b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400024b6:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   1400024bd:	ff 
   1400024be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400024c2:	48 c7 40 20 00 00 00 	movq   $0x0,0x20(%rax)
   1400024c9:	00 
   1400024ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400024ce:	48 83 c4 30          	add    $0x30,%rsp
   1400024d2:	5d                   	pop    %rbp
   1400024d3:	c3                   	ret

00000001400024d4 <type_struct__add>:
   1400024d4:	55                   	push   %rbp
   1400024d5:	48 89 e5             	mov    %rsp,%rbp
   1400024d8:	48 83 ec 30          	sub    $0x30,%rsp
   1400024dc:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400024e0:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400024e4:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   1400024e8:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   1400024ef:	00 
   1400024f0:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400024f4:	8b 50 3c             	mov    0x3c(%rax),%edx
   1400024f7:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400024fb:	8b 40 38             	mov    0x38(%rax),%eax
   1400024fe:	39 c2                	cmp    %eax,%edx
   140002500:	0f 85 83 00 00 00    	jne    140002589 <type_struct__add+0xb5>
   140002506:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000250a:	8b 40 3c             	mov    0x3c(%rax),%eax
   14000250d:	85 c0                	test   %eax,%eax
   14000250f:	75 36                	jne    140002547 <type_struct__add+0x73>
   140002511:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002515:	c7 40 38 08 00 00 00 	movl   $0x8,0x38(%rax)
   14000251c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002520:	8b 40 38             	mov    0x38(%rax),%eax
   140002523:	89 c2                	mov    %eax,%edx
   140002525:	48 89 d0             	mov    %rdx,%rax
   140002528:	48 01 c0             	add    %rax,%rax
   14000252b:	48 01 d0             	add    %rdx,%rax
   14000252e:	48 c1 e0 03          	shl    $0x3,%rax
   140002532:	48 89 c1             	mov    %rax,%rcx
   140002535:	e8 36 f5 00 00       	call   140011a70 <malloc>
   14000253a:	48 89 c2             	mov    %rax,%rdx
   14000253d:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002541:	48 89 50 30          	mov    %rdx,0x30(%rax)
   140002545:	eb 42                	jmp    140002589 <type_struct__add+0xb5>
   140002547:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000254b:	8b 40 38             	mov    0x38(%rax),%eax
   14000254e:	8d 14 00             	lea    (%rax,%rax,1),%edx
   140002551:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002555:	89 50 38             	mov    %edx,0x38(%rax)
   140002558:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000255c:	8b 40 38             	mov    0x38(%rax),%eax
   14000255f:	89 c2                	mov    %eax,%edx
   140002561:	48 89 d0             	mov    %rdx,%rax
   140002564:	48 01 c0             	add    %rax,%rax
   140002567:	48 01 d0             	add    %rdx,%rax
   14000256a:	48 c1 e0 03          	shl    $0x3,%rax
   14000256e:	48 89 c2             	mov    %rax,%rdx
   140002571:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002575:	48 8b 40 30          	mov    0x30(%rax),%rax
   140002579:	48 89 c1             	mov    %rax,%rcx
   14000257c:	e8 17 f5 00 00       	call   140011a98 <realloc>
   140002581:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   140002585:	48 89 42 30          	mov    %rax,0x30(%rdx)
   140002589:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000258d:	8b 50 3c             	mov    0x3c(%rax),%edx
   140002590:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002594:	8b 40 38             	mov    0x38(%rax),%eax
   140002597:	39 c2                	cmp    %eax,%edx
   140002599:	75 23                	jne    1400025be <type_struct__add+0xea>
   14000259b:	41 b8 65 01 00 00    	mov    $0x165,%r8d
   1400025a1:	48 8d 05 a8 0a 01 00 	lea    0x10aa8(%rip),%rax        # 140013050 <.rdata>
   1400025a8:	48 89 c2             	mov    %rax,%rdx
   1400025ab:	48 8d 05 be 0c 01 00 	lea    0x10cbe(%rip),%rax        # 140013270 <.rdata+0x220>
   1400025b2:	48 89 c1             	mov    %rax,%rcx
   1400025b5:	48 8b 05 84 8d 01 00 	mov    0x18d84(%rip),%rax        # 14001b340 <__imp__assert>
   1400025bc:	ff d0                	call   *%rax
   1400025be:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400025c2:	4c 8b 40 30          	mov    0x30(%rax),%r8
   1400025c6:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400025ca:	8b 40 3c             	mov    0x3c(%rax),%eax
   1400025cd:	8d 48 01             	lea    0x1(%rax),%ecx
   1400025d0:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   1400025d4:	89 4a 3c             	mov    %ecx,0x3c(%rdx)
   1400025d7:	89 c2                	mov    %eax,%edx
   1400025d9:	48 89 d0             	mov    %rdx,%rax
   1400025dc:	48 01 c0             	add    %rax,%rax
   1400025df:	48 01 d0             	add    %rdx,%rax
   1400025e2:	48 c1 e0 03          	shl    $0x3,%rax
   1400025e6:	4c 01 c0             	add    %r8,%rax
   1400025e9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   1400025ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400025f1:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   1400025f5:	48 89 10             	mov    %rdx,(%rax)
   1400025f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400025fc:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140002600:	48 89 50 08          	mov    %rdx,0x8(%rax)
   140002604:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002608:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
   14000260f:	00 
   140002610:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   140002615:	75 23                	jne    14000263a <type_struct__add+0x166>
   140002617:	41 b8 6a 01 00 00    	mov    $0x16a,%r8d
   14000261d:	48 8d 05 2c 0a 01 00 	lea    0x10a2c(%rip),%rax        # 140013050 <.rdata>
   140002624:	48 89 c2             	mov    %rax,%rdx
   140002627:	48 8d 05 6a 0c 01 00 	lea    0x10c6a(%rip),%rax        # 140013298 <.rdata+0x248>
   14000262e:	48 89 c1             	mov    %rax,%rcx
   140002631:	48 8b 05 08 8d 01 00 	mov    0x18d08(%rip),%rax        # 14001b340 <__imp__assert>
   140002638:	ff d0                	call   *%rax
   14000263a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   14000263e:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002642:	48 89 c1             	mov    %rax,%rcx
   140002645:	e8 4f f6 ff ff       	call   140001c99 <_type_struct__update_member>
   14000264a:	90                   	nop
   14000264b:	48 83 c4 30          	add    $0x30,%rsp
   14000264f:	5d                   	pop    %rbp
   140002650:	c3                   	ret

0000000140002651 <type_union__create>:
   140002651:	55                   	push   %rbp
   140002652:	48 89 e5             	mov    %rsp,%rbp
   140002655:	48 83 ec 30          	sub    $0x30,%rsp
   140002659:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000265d:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002661:	ba 50 00 00 00       	mov    $0x50,%edx
   140002666:	48 89 c1             	mov    %rax,%rcx
   140002669:	e8 dc f5 ff ff       	call   140001c4a <_type__create>
   14000266e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140002672:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002676:	c7 00 02 00 00 00    	movl   $0x2,(%rax)
   14000267c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002680:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
   140002687:	00 
   140002688:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000268c:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   140002693:	ff 
   140002694:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002698:	48 c7 40 20 00 00 00 	movq   $0x0,0x20(%rax)
   14000269f:	00 
   1400026a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400026a4:	48 83 c4 30          	add    $0x30,%rsp
   1400026a8:	5d                   	pop    %rbp
   1400026a9:	c3                   	ret

00000001400026aa <type_union__add>:
   1400026aa:	55                   	push   %rbp
   1400026ab:	48 89 e5             	mov    %rsp,%rbp
   1400026ae:	48 83 ec 30          	sub    $0x30,%rsp
   1400026b2:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400026b6:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400026ba:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   1400026be:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   1400026c5:	00 
   1400026c6:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400026ca:	8b 50 4c             	mov    0x4c(%rax),%edx
   1400026cd:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400026d1:	8b 40 48             	mov    0x48(%rax),%eax
   1400026d4:	39 c2                	cmp    %eax,%edx
   1400026d6:	0f 85 83 00 00 00    	jne    14000275f <type_union__add+0xb5>
   1400026dc:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400026e0:	8b 40 4c             	mov    0x4c(%rax),%eax
   1400026e3:	85 c0                	test   %eax,%eax
   1400026e5:	75 36                	jne    14000271d <type_union__add+0x73>
   1400026e7:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400026eb:	c7 40 48 08 00 00 00 	movl   $0x8,0x48(%rax)
   1400026f2:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400026f6:	8b 40 48             	mov    0x48(%rax),%eax
   1400026f9:	89 c2                	mov    %eax,%edx
   1400026fb:	48 89 d0             	mov    %rdx,%rax
   1400026fe:	48 01 c0             	add    %rax,%rax
   140002701:	48 01 d0             	add    %rdx,%rax
   140002704:	48 c1 e0 03          	shl    $0x3,%rax
   140002708:	48 89 c1             	mov    %rax,%rcx
   14000270b:	e8 60 f3 00 00       	call   140011a70 <malloc>
   140002710:	48 89 c2             	mov    %rax,%rdx
   140002713:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002717:	48 89 50 40          	mov    %rdx,0x40(%rax)
   14000271b:	eb 42                	jmp    14000275f <type_union__add+0xb5>
   14000271d:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002721:	8b 40 48             	mov    0x48(%rax),%eax
   140002724:	8d 14 00             	lea    (%rax,%rax,1),%edx
   140002727:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000272b:	89 50 48             	mov    %edx,0x48(%rax)
   14000272e:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002732:	8b 40 48             	mov    0x48(%rax),%eax
   140002735:	89 c2                	mov    %eax,%edx
   140002737:	48 89 d0             	mov    %rdx,%rax
   14000273a:	48 01 c0             	add    %rax,%rax
   14000273d:	48 01 d0             	add    %rdx,%rax
   140002740:	48 c1 e0 03          	shl    $0x3,%rax
   140002744:	48 89 c2             	mov    %rax,%rdx
   140002747:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000274b:	48 8b 40 40          	mov    0x40(%rax),%rax
   14000274f:	48 89 c1             	mov    %rax,%rcx
   140002752:	e8 41 f3 00 00       	call   140011a98 <realloc>
   140002757:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   14000275b:	48 89 42 40          	mov    %rax,0x40(%rdx)
   14000275f:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002763:	8b 50 4c             	mov    0x4c(%rax),%edx
   140002766:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000276a:	8b 40 48             	mov    0x48(%rax),%eax
   14000276d:	39 c2                	cmp    %eax,%edx
   14000276f:	75 23                	jne    140002794 <type_union__add+0xea>
   140002771:	41 b8 87 01 00 00    	mov    $0x187,%r8d
   140002777:	48 8d 05 d2 08 01 00 	lea    0x108d2(%rip),%rax        # 140013050 <.rdata>
   14000277e:	48 89 c2             	mov    %rax,%rdx
   140002781:	48 8d 05 e8 0a 01 00 	lea    0x10ae8(%rip),%rax        # 140013270 <.rdata+0x220>
   140002788:	48 89 c1             	mov    %rax,%rcx
   14000278b:	48 8b 05 ae 8b 01 00 	mov    0x18bae(%rip),%rax        # 14001b340 <__imp__assert>
   140002792:	ff d0                	call   *%rax
   140002794:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002798:	4c 8b 40 40          	mov    0x40(%rax),%r8
   14000279c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400027a0:	8b 40 4c             	mov    0x4c(%rax),%eax
   1400027a3:	8d 48 01             	lea    0x1(%rax),%ecx
   1400027a6:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   1400027aa:	89 4a 4c             	mov    %ecx,0x4c(%rdx)
   1400027ad:	89 c2                	mov    %eax,%edx
   1400027af:	48 89 d0             	mov    %rdx,%rax
   1400027b2:	48 01 c0             	add    %rax,%rax
   1400027b5:	48 01 d0             	add    %rdx,%rax
   1400027b8:	48 c1 e0 03          	shl    $0x3,%rax
   1400027bc:	4c 01 c0             	add    %r8,%rax
   1400027bf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   1400027c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400027c7:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   1400027cb:	48 89 10             	mov    %rdx,(%rax)
   1400027ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400027d2:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   1400027d6:	48 89 50 08          	mov    %rdx,0x8(%rax)
   1400027da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400027de:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
   1400027e5:	00 
   1400027e6:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   1400027eb:	75 23                	jne    140002810 <type_union__add+0x166>
   1400027ed:	41 b8 8c 01 00 00    	mov    $0x18c,%r8d
   1400027f3:	48 8d 05 56 08 01 00 	lea    0x10856(%rip),%rax        # 140013050 <.rdata>
   1400027fa:	48 89 c2             	mov    %rax,%rdx
   1400027fd:	48 8d 05 94 0a 01 00 	lea    0x10a94(%rip),%rax        # 140013298 <.rdata+0x248>
   140002804:	48 89 c1             	mov    %rax,%rcx
   140002807:	48 8b 05 32 8b 01 00 	mov    0x18b32(%rip),%rax        # 14001b340 <__imp__assert>
   14000280e:	ff d0                	call   *%rax
   140002810:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   140002814:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002818:	48 89 c1             	mov    %rax,%rcx
   14000281b:	e8 cd f5 ff ff       	call   140001ded <_type_union__update_member>
   140002820:	90                   	nop
   140002821:	48 83 c4 30          	add    $0x30,%rsp
   140002825:	5d                   	pop    %rbp
   140002826:	c3                   	ret

0000000140002827 <type_array__create>:
   140002827:	55                   	push   %rbp
   140002828:	48 89 e5             	mov    %rsp,%rbp
   14000282b:	48 83 ec 30          	sub    $0x30,%rsp
   14000282f:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002833:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140002837:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   14000283b:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000283f:	48 89 c1             	mov    %rax,%rcx
   140002842:	e8 12 f9 ff ff       	call   140002159 <type__alignment>
   140002847:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   14000284b:	48 8b 52 20          	mov    0x20(%rdx),%rdx
   14000284f:	48 39 c2             	cmp    %rax,%rdx
   140002852:	73 23                	jae    140002877 <type_array__create+0x50>
   140002854:	41 b8 93 01 00 00    	mov    $0x193,%r8d
   14000285a:	48 8d 05 ef 07 01 00 	lea    0x107ef(%rip),%rax        # 140013050 <.rdata>
   140002861:	48 89 c2             	mov    %rax,%rdx
   140002864:	48 8d 05 3d 0a 01 00 	lea    0x10a3d(%rip),%rax        # 1400132a8 <.rdata+0x258>
   14000286b:	48 89 c1             	mov    %rax,%rcx
   14000286e:	48 8b 05 cb 8a 01 00 	mov    0x18acb(%rip),%rax        # 14001b340 <__imp__assert>
   140002875:	ff d0                	call   *%rax
   140002877:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000287b:	ba 40 00 00 00       	mov    $0x40,%edx
   140002880:	48 89 c1             	mov    %rax,%rcx
   140002883:	e8 c2 f3 ff ff       	call   140001c4a <_type__create>
   140002888:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000288c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002890:	c7 00 03 00 00 00    	movl   $0x3,(%rax)
   140002896:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000289a:	48 8b 50 10          	mov    0x10(%rax),%rdx
   14000289e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400028a2:	48 89 50 10          	mov    %rdx,0x10(%rax)
   1400028a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400028aa:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   1400028b1:	ff 
   1400028b2:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400028b6:	48 89 c1             	mov    %rax,%rcx
   1400028b9:	e8 ad f8 ff ff       	call   14000216b <type__size>
   1400028be:	48 0f af 45 20       	imul   0x20(%rbp),%rax
   1400028c3:	48 89 c2             	mov    %rax,%rdx
   1400028c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400028ca:	48 89 50 20          	mov    %rdx,0x20(%rax)
   1400028ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400028d2:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   1400028d6:	48 89 50 30          	mov    %rdx,0x30(%rax)
   1400028da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400028de:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   1400028e2:	48 89 50 38          	mov    %rdx,0x38(%rax)
   1400028e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400028ea:	48 83 c4 30          	add    $0x30,%rsp
   1400028ee:	5d                   	pop    %rbp
   1400028ef:	c3                   	ret

00000001400028f0 <type_pointer__create>:
   1400028f0:	55                   	push   %rbp
   1400028f1:	48 89 e5             	mov    %rsp,%rbp
   1400028f4:	48 83 ec 30          	sub    $0x30,%rsp
   1400028f8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400028fc:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140002900:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002904:	ba 38 00 00 00       	mov    $0x38,%edx
   140002909:	48 89 c1             	mov    %rax,%rcx
   14000290c:	e8 39 f3 ff ff       	call   140001c4a <_type__create>
   140002911:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140002915:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002919:	c7 00 04 00 00 00    	movl   $0x4,(%rax)
   14000291f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002923:	48 c7 40 10 08 00 00 	movq   $0x8,0x10(%rax)
   14000292a:	00 
   14000292b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000292f:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   140002936:	ff 
   140002937:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000293b:	48 c7 40 20 08 00 00 	movq   $0x8,0x20(%rax)
   140002942:	00 
   140002943:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002947:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   14000294b:	48 89 50 30          	mov    %rdx,0x30(%rax)
   14000294f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002953:	48 83 c4 30          	add    $0x30,%rsp
   140002957:	5d                   	pop    %rbp
   140002958:	c3                   	ret

0000000140002959 <type_enum__create>:
   140002959:	55                   	push   %rbp
   14000295a:	48 89 e5             	mov    %rsp,%rbp
   14000295d:	48 83 ec 30          	sub    $0x30,%rsp
   140002961:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002965:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002969:	ba 40 00 00 00       	mov    $0x40,%edx
   14000296e:	48 89 c1             	mov    %rax,%rcx
   140002971:	e8 d4 f2 ff ff       	call   140001c4a <_type__create>
   140002976:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000297a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000297e:	c7 00 05 00 00 00    	movl   $0x5,(%rax)
   140002984:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002988:	48 c7 40 10 04 00 00 	movq   $0x4,0x10(%rax)
   14000298f:	00 
   140002990:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140002994:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   14000299b:	ff 
   14000299c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400029a0:	48 c7 40 20 04 00 00 	movq   $0x4,0x20(%rax)
   1400029a7:	00 
   1400029a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400029ac:	48 83 c4 30          	add    $0x30,%rsp
   1400029b0:	5d                   	pop    %rbp
   1400029b1:	c3                   	ret

00000001400029b2 <_type_enum__add>:
   1400029b2:	55                   	push   %rbp
   1400029b3:	48 89 e5             	mov    %rsp,%rbp
   1400029b6:	48 83 ec 20          	sub    $0x20,%rsp
   1400029ba:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400029be:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400029c2:	44 89 45 20          	mov    %r8d,0x20(%rbp)
   1400029c6:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400029ca:	8b 50 3c             	mov    0x3c(%rax),%edx
   1400029cd:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400029d1:	8b 40 38             	mov    0x38(%rax),%eax
   1400029d4:	39 c2                	cmp    %eax,%edx
   1400029d6:	75 71                	jne    140002a49 <_type_enum__add+0x97>
   1400029d8:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400029dc:	8b 40 38             	mov    0x38(%rax),%eax
   1400029df:	85 c0                	test   %eax,%eax
   1400029e1:	75 2d                	jne    140002a10 <_type_enum__add+0x5e>
   1400029e3:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400029e7:	c7 40 38 08 00 00 00 	movl   $0x8,0x38(%rax)
   1400029ee:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400029f2:	8b 40 38             	mov    0x38(%rax),%eax
   1400029f5:	89 c0                	mov    %eax,%eax
   1400029f7:	48 c1 e0 04          	shl    $0x4,%rax
   1400029fb:	48 89 c1             	mov    %rax,%rcx
   1400029fe:	e8 6d f0 00 00       	call   140011a70 <malloc>
   140002a03:	48 89 c2             	mov    %rax,%rdx
   140002a06:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002a0a:	48 89 50 30          	mov    %rdx,0x30(%rax)
   140002a0e:	eb 39                	jmp    140002a49 <_type_enum__add+0x97>
   140002a10:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002a14:	8b 40 38             	mov    0x38(%rax),%eax
   140002a17:	8d 14 00             	lea    (%rax,%rax,1),%edx
   140002a1a:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002a1e:	89 50 38             	mov    %edx,0x38(%rax)
   140002a21:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002a25:	8b 40 38             	mov    0x38(%rax),%eax
   140002a28:	89 c0                	mov    %eax,%eax
   140002a2a:	48 c1 e0 04          	shl    $0x4,%rax
   140002a2e:	48 89 c2             	mov    %rax,%rdx
   140002a31:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002a35:	48 8b 40 30          	mov    0x30(%rax),%rax
   140002a39:	48 89 c1             	mov    %rax,%rcx
   140002a3c:	e8 57 f0 00 00       	call   140011a98 <realloc>
   140002a41:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   140002a45:	48 89 42 30          	mov    %rax,0x30(%rdx)
   140002a49:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002a4d:	8b 50 3c             	mov    0x3c(%rax),%edx
   140002a50:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002a54:	8b 40 38             	mov    0x38(%rax),%eax
   140002a57:	39 c2                	cmp    %eax,%edx
   140002a59:	72 23                	jb     140002a7e <_type_enum__add+0xcc>
   140002a5b:	41 b8 c6 01 00 00    	mov    $0x1c6,%r8d
   140002a61:	48 8d 05 e8 05 01 00 	lea    0x105e8(%rip),%rax        # 140013050 <.rdata>
   140002a68:	48 89 c2             	mov    %rax,%rdx
   140002a6b:	48 8d 05 86 08 01 00 	lea    0x10886(%rip),%rax        # 1400132f8 <.rdata+0x2a8>
   140002a72:	48 89 c1             	mov    %rax,%rcx
   140002a75:	48 8b 05 c4 88 01 00 	mov    0x188c4(%rip),%rax        # 14001b340 <__imp__assert>
   140002a7c:	ff d0                	call   *%rax
   140002a7e:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002a82:	48 8b 50 30          	mov    0x30(%rax),%rdx
   140002a86:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002a8a:	8b 40 3c             	mov    0x3c(%rax),%eax
   140002a8d:	89 c0                	mov    %eax,%eax
   140002a8f:	48 c1 e0 04          	shl    $0x4,%rax
   140002a93:	48 01 c2             	add    %rax,%rdx
   140002a96:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140002a9a:	48 89 02             	mov    %rax,(%rdx)
   140002a9d:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002aa1:	48 8b 50 30          	mov    0x30(%rax),%rdx
   140002aa5:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002aa9:	8b 40 3c             	mov    0x3c(%rax),%eax
   140002aac:	89 c0                	mov    %eax,%eax
   140002aae:	48 c1 e0 04          	shl    $0x4,%rax
   140002ab2:	48 01 c2             	add    %rax,%rdx
   140002ab5:	8b 45 20             	mov    0x20(%rbp),%eax
   140002ab8:	89 42 08             	mov    %eax,0x8(%rdx)
   140002abb:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002abf:	8b 40 3c             	mov    0x3c(%rax),%eax
   140002ac2:	8d 50 01             	lea    0x1(%rax),%edx
   140002ac5:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002ac9:	89 50 3c             	mov    %edx,0x3c(%rax)
   140002acc:	90                   	nop
   140002acd:	48 83 c4 20          	add    $0x20,%rsp
   140002ad1:	5d                   	pop    %rbp
   140002ad2:	c3                   	ret

0000000140002ad3 <type_enum__add>:
   140002ad3:	55                   	push   %rbp
   140002ad4:	48 89 e5             	mov    %rsp,%rbp
   140002ad7:	48 83 ec 20          	sub    $0x20,%rsp
   140002adb:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002adf:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140002ae3:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002ae7:	8b 40 38             	mov    0x38(%rax),%eax
   140002aea:	85 c0                	test   %eax,%eax
   140002aec:	75 18                	jne    140002b06 <type_enum__add+0x33>
   140002aee:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140002af2:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002af6:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   140002afc:	48 89 c1             	mov    %rax,%rcx
   140002aff:	e8 ae fe ff ff       	call   1400029b2 <_type_enum__add>
   140002b04:	eb 62                	jmp    140002b68 <type_enum__add+0x95>
   140002b06:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002b0a:	8b 40 3c             	mov    0x3c(%rax),%eax
   140002b0d:	85 c0                	test   %eax,%eax
   140002b0f:	75 23                	jne    140002b34 <type_enum__add+0x61>
   140002b11:	41 b8 d0 01 00 00    	mov    $0x1d0,%r8d
   140002b17:	48 8d 05 32 05 01 00 	lea    0x10532(%rip),%rax        # 140013050 <.rdata>
   140002b1e:	48 89 c2             	mov    %rax,%rdx
   140002b21:	48 8d 05 f5 07 01 00 	lea    0x107f5(%rip),%rax        # 14001331d <.rdata+0x2cd>
   140002b28:	48 89 c1             	mov    %rax,%rcx
   140002b2b:	48 8b 05 0e 88 01 00 	mov    0x1880e(%rip),%rax        # 14001b340 <__imp__assert>
   140002b32:	ff d0                	call   *%rax
   140002b34:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002b38:	48 8b 50 30          	mov    0x30(%rax),%rdx
   140002b3c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002b40:	8b 40 3c             	mov    0x3c(%rax),%eax
   140002b43:	83 e8 01             	sub    $0x1,%eax
   140002b46:	89 c0                	mov    %eax,%eax
   140002b48:	48 c1 e0 04          	shl    $0x4,%rax
   140002b4c:	48 01 d0             	add    %rdx,%rax
   140002b4f:	8b 40 08             	mov    0x8(%rax),%eax
   140002b52:	8d 48 01             	lea    0x1(%rax),%ecx
   140002b55:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140002b59:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002b5d:	41 89 c8             	mov    %ecx,%r8d
   140002b60:	48 89 c1             	mov    %rax,%rcx
   140002b63:	e8 4a fe ff ff       	call   1400029b2 <_type_enum__add>
   140002b68:	90                   	nop
   140002b69:	48 83 c4 20          	add    $0x20,%rsp
   140002b6d:	5d                   	pop    %rbp
   140002b6e:	c3                   	ret

0000000140002b6f <type_enum__add_with_value>:
   140002b6f:	55                   	push   %rbp
   140002b70:	48 89 e5             	mov    %rsp,%rbp
   140002b73:	48 83 ec 20          	sub    $0x20,%rsp
   140002b77:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002b7b:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140002b7f:	44 89 45 20          	mov    %r8d,0x20(%rbp)
   140002b83:	8b 4d 20             	mov    0x20(%rbp),%ecx
   140002b86:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140002b8a:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002b8e:	41 89 c8             	mov    %ecx,%r8d
   140002b91:	48 89 c1             	mov    %rax,%rcx
   140002b94:	e8 19 fe ff ff       	call   1400029b2 <_type_enum__add>
   140002b99:	90                   	nop
   140002b9a:	48 83 c4 20          	add    $0x20,%rsp
   140002b9e:	5d                   	pop    %rbp
   140002b9f:	c3                   	ret

0000000140002ba0 <type__member>:
   140002ba0:	55                   	push   %rbp
   140002ba1:	48 89 e5             	mov    %rsp,%rbp
   140002ba4:	48 83 ec 20          	sub    $0x20,%rsp
   140002ba8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002bac:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140002bb0:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002bb4:	8b 00                	mov    (%rax),%eax
   140002bb6:	83 f8 02             	cmp    $0x2,%eax
   140002bb9:	75 12                	jne    140002bcd <type__member+0x2d>
   140002bbb:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140002bbf:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002bc3:	48 89 c1             	mov    %rax,%rcx
   140002bc6:	e8 57 f7 ff ff       	call   140002322 <type_union__member>
   140002bcb:	eb 22                	jmp    140002bef <type__member+0x4f>
   140002bcd:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002bd1:	8b 00                	mov    (%rax),%eax
   140002bd3:	83 f8 01             	cmp    $0x1,%eax
   140002bd6:	75 12                	jne    140002bea <type__member+0x4a>
   140002bd8:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140002bdc:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002be0:	48 89 c1             	mov    %rax,%rcx
   140002be3:	e8 bb f6 ff ff       	call   1400022a3 <type_struct__member>
   140002be8:	eb 05                	jmp    140002bef <type__member+0x4f>
   140002bea:	b8 00 00 00 00       	mov    $0x0,%eax
   140002bef:	48 83 c4 20          	add    $0x20,%rsp
   140002bf3:	5d                   	pop    %rbp
   140002bf4:	c3                   	ret

0000000140002bf5 <type__hash>:
   140002bf5:	55                   	push   %rbp
   140002bf6:	48 89 e5             	mov    %rsp,%rbp
   140002bf9:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002bfd:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002c01:	48 8b 40 28          	mov    0x28(%rax),%rax
   140002c05:	5d                   	pop    %rbp
   140002c06:	c3                   	ret

0000000140002c07 <type__max_alignment>:
   140002c07:	55                   	push   %rbp
   140002c08:	48 89 e5             	mov    %rsp,%rbp
   140002c0b:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002c0f:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002c13:	48 8b 40 18          	mov    0x18(%rax),%rax
   140002c17:	5d                   	pop    %rbp
   140002c18:	c3                   	ret

0000000140002c19 <_type__print_name>:
   140002c19:	55                   	push   %rbp
   140002c1a:	48 89 e5             	mov    %rsp,%rbp
   140002c1d:	48 83 ec 60          	sub    $0x60,%rsp
   140002c21:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140002c25:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140002c29:	44 89 45 20          	mov    %r8d,0x20(%rbp)
   140002c2d:	4c 89 4d 28          	mov    %r9,0x28(%rbp)
   140002c31:	83 7d 20 00          	cmpl   $0x0,0x20(%rbp)
   140002c35:	75 2a                	jne    140002c61 <_type__print_name+0x48>
   140002c37:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002c3b:	48 8b 50 08          	mov    0x8(%rax),%rdx
   140002c3f:	48 8b 4d 28          	mov    0x28(%rbp),%rcx
   140002c43:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140002c47:	49 89 c9             	mov    %rcx,%r9
   140002c4a:	49 89 d0             	mov    %rdx,%r8
   140002c4d:	48 8d 15 de 06 01 00 	lea    0x106de(%rip),%rdx        # 140013332 <.rdata+0x2e2>
   140002c54:	48 89 c1             	mov    %rax,%rcx
   140002c57:	e8 34 ea 00 00       	call   140011690 <fprintf>
   140002c5c:	e9 b0 05 00 00       	jmp    140003211 <_type__print_name+0x5f8>
   140002c61:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002c65:	48 89 c1             	mov    %rax,%rcx
   140002c68:	e8 ec f4 ff ff       	call   140002159 <type__alignment>
   140002c6d:	48 89 c1             	mov    %rax,%rcx
   140002c70:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140002c74:	ba 00 00 00 00       	mov    $0x0,%edx
   140002c79:	48 f7 f1             	div    %rcx
   140002c7c:	48 89 d1             	mov    %rdx,%rcx
   140002c7f:	48 89 c8             	mov    %rcx,%rax
   140002c82:	48 85 c0             	test   %rax,%rax
   140002c85:	74 49                	je     140002cd0 <_type__print_name+0xb7>
   140002c87:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002c8b:	48 89 c1             	mov    %rax,%rcx
   140002c8e:	e8 74 ff ff ff       	call   140002c07 <type__max_alignment>
   140002c93:	48 89 c1             	mov    %rax,%rcx
   140002c96:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140002c9a:	ba 00 00 00 00       	mov    $0x0,%edx
   140002c9f:	48 f7 f1             	div    %rcx
   140002ca2:	48 89 d1             	mov    %rdx,%rcx
   140002ca5:	48 89 c8             	mov    %rcx,%rax
   140002ca8:	48 85 c0             	test   %rax,%rax
   140002cab:	74 23                	je     140002cd0 <_type__print_name+0xb7>
   140002cad:	41 b8 f1 01 00 00    	mov    $0x1f1,%r8d
   140002cb3:	48 8d 05 96 03 01 00 	lea    0x10396(%rip),%rax        # 140013050 <.rdata>
   140002cba:	48 89 c2             	mov    %rax,%rdx
   140002cbd:	48 8d 05 74 06 01 00 	lea    0x10674(%rip),%rax        # 140013338 <.rdata+0x2e8>
   140002cc4:	48 89 c1             	mov    %rax,%rcx
   140002cc7:	48 8b 05 72 86 01 00 	mov    0x18672(%rip),%rax        # 14001b340 <__imp__assert>
   140002cce:	ff d0                	call   *%rax
   140002cd0:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002cd4:	8b 00                	mov    (%rax),%eax
   140002cd6:	83 f8 05             	cmp    $0x5,%eax
   140002cd9:	0f 87 0e 05 00 00    	ja     1400031ed <_type__print_name+0x5d4>
   140002cdf:	89 c0                	mov    %eax,%eax
   140002ce1:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   140002ce8:	00 
   140002ce9:	48 8d 05 28 07 01 00 	lea    0x10728(%rip),%rax        # 140013418 <.rdata+0x3c8>
   140002cf0:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   140002cf3:	48 98                	cltq
   140002cf5:	48 8d 15 1c 07 01 00 	lea    0x1071c(%rip),%rdx        # 140013418 <.rdata+0x3c8>
   140002cfc:	48 01 d0             	add    %rdx,%rax
   140002cff:	ff e0                	jmp    *%rax
   140002d01:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002d05:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   140002d09:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   140002d0d:	48 8b 40 38          	mov    0x38(%rax),%rax
   140002d11:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140002d15:	48 89 c1             	mov    %rax,%rcx
   140002d18:	e8 3b ed 00 00       	call   140011a58 <fputs>
   140002d1d:	e9 ef 04 00 00       	jmp    140003211 <_type__print_name+0x5f8>
   140002d22:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002d26:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   140002d2a:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140002d2e:	48 89 c2             	mov    %rax,%rdx
   140002d31:	b9 7b 00 00 00       	mov    $0x7b,%ecx
   140002d36:	e8 15 ed 00 00       	call   140011a50 <fputc>
   140002d3b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   140002d42:	e9 92 01 00 00       	jmp    140002ed9 <_type__print_name+0x2c0>
   140002d47:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   140002d4b:	48 8b 48 30          	mov    0x30(%rax),%rcx
   140002d4f:	8b 55 fc             	mov    -0x4(%rbp),%edx
   140002d52:	48 89 d0             	mov    %rdx,%rax
   140002d55:	48 01 c0             	add    %rax,%rax
   140002d58:	48 01 d0             	add    %rdx,%rax
   140002d5b:	48 c1 e0 03          	shl    $0x3,%rax
   140002d5f:	48 01 c8             	add    %rcx,%rax
   140002d62:	48 8b 40 08          	mov    0x8(%rax),%rax
   140002d66:	48 89 c1             	mov    %rax,%rcx
   140002d69:	e8 eb f3 ff ff       	call   140002159 <type__alignment>
   140002d6e:	48 89 c1             	mov    %rax,%rcx
   140002d71:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140002d75:	ba 00 00 00 00       	mov    $0x0,%edx
   140002d7a:	48 f7 f1             	div    %rcx
   140002d7d:	48 89 d1             	mov    %rdx,%rcx
   140002d80:	48 89 c8             	mov    %rcx,%rax
   140002d83:	48 85 c0             	test   %rax,%rax
   140002d86:	74 49                	je     140002dd1 <_type__print_name+0x1b8>
   140002d88:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002d8c:	48 89 c1             	mov    %rax,%rcx
   140002d8f:	e8 73 fe ff ff       	call   140002c07 <type__max_alignment>
   140002d94:	48 89 c1             	mov    %rax,%rcx
   140002d97:	48 8b 45 28          	mov    0x28(%rbp),%rax
   140002d9b:	ba 00 00 00 00       	mov    $0x0,%edx
   140002da0:	48 f7 f1             	div    %rcx
   140002da3:	48 89 d1             	mov    %rdx,%rcx
   140002da6:	48 89 c8             	mov    %rcx,%rax
   140002da9:	48 85 c0             	test   %rax,%rax
   140002dac:	74 23                	je     140002dd1 <_type__print_name+0x1b8>
   140002dae:	41 b8 ff 01 00 00    	mov    $0x1ff,%r8d
   140002db4:	48 8d 05 95 02 01 00 	lea    0x10295(%rip),%rax        # 140013050 <.rdata>
   140002dbb:	48 89 c2             	mov    %rax,%rdx
   140002dbe:	48 8d 05 c3 05 01 00 	lea    0x105c3(%rip),%rax        # 140013388 <.rdata+0x338>
   140002dc5:	48 89 c1             	mov    %rax,%rcx
   140002dc8:	48 8b 05 71 85 01 00 	mov    0x18571(%rip),%rax        # 14001b340 <__imp__assert>
   140002dcf:	ff d0                	call   *%rax
   140002dd1:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   140002dd5:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140002dd9:	49 89 d0             	mov    %rdx,%r8
   140002ddc:	48 8d 15 17 06 01 00 	lea    0x10617(%rip),%rdx        # 1400133fa <.rdata+0x3aa>
   140002de3:	48 89 c1             	mov    %rax,%rcx
   140002de6:	e8 a5 e8 00 00       	call   140011690 <fprintf>
   140002deb:	8b 45 20             	mov    0x20(%rbp),%eax
   140002dee:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
   140002df2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   140002df6:	48 8b 48 30          	mov    0x30(%rax),%rcx
   140002dfa:	8b 55 fc             	mov    -0x4(%rbp),%edx
   140002dfd:	48 89 d0             	mov    %rdx,%rax
   140002e00:	48 01 c0             	add    %rax,%rax
   140002e03:	48 01 d0             	add    %rdx,%rax
   140002e06:	48 c1 e0 03          	shl    $0x3,%rax
   140002e0a:	48 01 c8             	add    %rcx,%rax
   140002e0d:	48 8b 40 08          	mov    0x8(%rax),%rax
   140002e11:	48 8b 4d 28          	mov    0x28(%rbp),%rcx
   140002e15:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140002e19:	49 89 c9             	mov    %rcx,%r9
   140002e1c:	48 89 c1             	mov    %rax,%rcx
   140002e1f:	e8 f5 fd ff ff       	call   140002c19 <_type__print_name>
   140002e24:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   140002e28:	48 8b 48 30          	mov    0x30(%rax),%rcx
   140002e2c:	8b 55 fc             	mov    -0x4(%rbp),%edx
   140002e2f:	48 89 d0             	mov    %rdx,%rax
   140002e32:	48 01 c0             	add    %rax,%rax
   140002e35:	48 01 d0             	add    %rdx,%rax
   140002e38:	48 c1 e0 03          	shl    $0x3,%rax
   140002e3c:	48 01 c8             	add    %rcx,%rax
   140002e3f:	48 8b 10             	mov    (%rax),%rdx
   140002e42:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140002e46:	49 89 d0             	mov    %rdx,%r8
   140002e49:	48 8d 15 b1 05 01 00 	lea    0x105b1(%rip),%rdx        # 140013401 <.rdata+0x3b1>
   140002e50:	48 89 c1             	mov    %rax,%rcx
   140002e53:	e8 38 e8 00 00       	call   140011690 <fprintf>
   140002e58:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   140002e5c:	8b 40 3c             	mov    0x3c(%rax),%eax
   140002e5f:	83 e8 01             	sub    $0x1,%eax
   140002e62:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   140002e65:	73 6e                	jae    140002ed5 <_type__print_name+0x2bc>
   140002e67:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140002e6b:	49 89 c1             	mov    %rax,%r9
   140002e6e:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140002e74:	ba 01 00 00 00       	mov    $0x1,%edx
   140002e79:	48 8d 05 d6 02 01 00 	lea    0x102d6(%rip),%rax        # 140013156 <.rdata+0x106>
   140002e80:	48 89 c1             	mov    %rax,%rcx
   140002e83:	e8 e0 eb 00 00       	call   140011a68 <fwrite>
   140002e88:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   140002e8c:	48 8b 50 30          	mov    0x30(%rax),%rdx
   140002e90:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140002e93:	83 c0 01             	add    $0x1,%eax
   140002e96:	89 c1                	mov    %eax,%ecx
   140002e98:	48 89 c8             	mov    %rcx,%rax
   140002e9b:	48 01 c0             	add    %rax,%rax
   140002e9e:	48 01 c8             	add    %rcx,%rax
   140002ea1:	48 c1 e0 03          	shl    $0x3,%rax
   140002ea5:	48 01 d0             	add    %rdx,%rax
   140002ea8:	48 8b 48 10          	mov    0x10(%rax),%rcx
   140002eac:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   140002eb0:	4c 8b 40 30          	mov    0x30(%rax),%r8
   140002eb4:	8b 55 fc             	mov    -0x4(%rbp),%edx
   140002eb7:	48 89 d0             	mov    %rdx,%rax
   140002eba:	48 01 c0             	add    %rax,%rax
   140002ebd:	48 01 d0             	add    %rdx,%rax
   140002ec0:	48 c1 e0 03          	shl    $0x3,%rax
   140002ec4:	4c 01 c0             	add    %r8,%rax
   140002ec7:	48 8b 40 10          	mov    0x10(%rax),%rax
   140002ecb:	48 29 c1             	sub    %rax,%rcx
   140002ece:	48 89 ca             	mov    %rcx,%rdx
   140002ed1:	48 01 55 28          	add    %rdx,0x28(%rbp)
   140002ed5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   140002ed9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   140002edd:	8b 40 3c             	mov    0x3c(%rax),%eax
   140002ee0:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   140002ee3:	0f 82 5e fe ff ff    	jb     140002d47 <_type__print_name+0x12e>
   140002ee9:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140002eed:	48 89 c2             	mov    %rax,%rdx
   140002ef0:	b9 7d 00 00 00       	mov    $0x7d,%ecx
   140002ef5:	e8 56 eb 00 00       	call   140011a50 <fputc>
   140002efa:	e9 12 03 00 00       	jmp    140003211 <_type__print_name+0x5f8>
   140002eff:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140002f03:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   140002f07:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140002f0b:	48 89 c2             	mov    %rax,%rdx
   140002f0e:	b9 7c 00 00 00       	mov    $0x7c,%ecx
   140002f13:	e8 38 eb 00 00       	call   140011a50 <fputc>
   140002f18:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   140002f1f:	e9 bb 00 00 00       	jmp    140002fdf <_type__print_name+0x3c6>
   140002f24:	8b 45 20             	mov    0x20(%rbp),%eax
   140002f27:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
   140002f2b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   140002f2f:	48 8b 48 40          	mov    0x40(%rax),%rcx
   140002f33:	8b 55 f8             	mov    -0x8(%rbp),%edx
   140002f36:	48 89 d0             	mov    %rdx,%rax
   140002f39:	48 01 c0             	add    %rax,%rax
   140002f3c:	48 01 d0             	add    %rdx,%rax
   140002f3f:	48 c1 e0 03          	shl    $0x3,%rax
   140002f43:	48 01 c8             	add    %rcx,%rax
   140002f46:	48 8b 40 08          	mov    0x8(%rax),%rax
   140002f4a:	48 8b 4d 28          	mov    0x28(%rbp),%rcx
   140002f4e:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140002f52:	49 89 c9             	mov    %rcx,%r9
   140002f55:	48 89 c1             	mov    %rax,%rcx
   140002f58:	e8 bc fc ff ff       	call   140002c19 <_type__print_name>
   140002f5d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   140002f61:	48 8b 48 40          	mov    0x40(%rax),%rcx
   140002f65:	8b 55 f8             	mov    -0x8(%rbp),%edx
   140002f68:	48 89 d0             	mov    %rdx,%rax
   140002f6b:	48 01 c0             	add    %rax,%rax
   140002f6e:	48 01 d0             	add    %rdx,%rax
   140002f71:	48 c1 e0 03          	shl    $0x3,%rax
   140002f75:	48 01 c8             	add    %rcx,%rax
   140002f78:	48 8b 10             	mov    (%rax),%rdx
   140002f7b:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140002f7f:	49 89 d0             	mov    %rdx,%r8
   140002f82:	48 8d 15 78 04 01 00 	lea    0x10478(%rip),%rdx        # 140013401 <.rdata+0x3b1>
   140002f89:	48 89 c1             	mov    %rax,%rcx
   140002f8c:	e8 ff e6 00 00       	call   140011690 <fprintf>
   140002f91:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   140002f95:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140002f99:	49 89 d0             	mov    %rdx,%r8
   140002f9c:	48 8d 15 62 04 01 00 	lea    0x10462(%rip),%rdx        # 140013405 <.rdata+0x3b5>
   140002fa3:	48 89 c1             	mov    %rax,%rcx
   140002fa6:	e8 e5 e6 00 00       	call   140011690 <fprintf>
   140002fab:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   140002faf:	8b 40 4c             	mov    0x4c(%rax),%eax
   140002fb2:	83 e8 01             	sub    $0x1,%eax
   140002fb5:	39 45 f8             	cmp    %eax,-0x8(%rbp)
   140002fb8:	73 21                	jae    140002fdb <_type__print_name+0x3c2>
   140002fba:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140002fbe:	49 89 c1             	mov    %rax,%r9
   140002fc1:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140002fc7:	ba 01 00 00 00       	mov    $0x1,%edx
   140002fcc:	48 8d 05 83 01 01 00 	lea    0x10183(%rip),%rax        # 140013156 <.rdata+0x106>
   140002fd3:	48 89 c1             	mov    %rax,%rcx
   140002fd6:	e8 8d ea 00 00       	call   140011a68 <fwrite>
   140002fdb:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   140002fdf:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   140002fe3:	8b 40 4c             	mov    0x4c(%rax),%eax
   140002fe6:	39 45 f8             	cmp    %eax,-0x8(%rbp)
   140002fe9:	0f 82 35 ff ff ff    	jb     140002f24 <_type__print_name+0x30b>
   140002fef:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140002ff3:	49 89 c1             	mov    %rax,%r9
   140002ff6:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   140002ffc:	ba 01 00 00 00       	mov    $0x1,%edx
   140003001:	48 8d 05 51 01 01 00 	lea    0x10151(%rip),%rax        # 140013159 <.rdata+0x109>
   140003008:	48 89 c1             	mov    %rax,%rcx
   14000300b:	e8 58 ea 00 00       	call   140011a68 <fwrite>
   140003010:	8b 45 20             	mov    0x20(%rbp),%eax
   140003013:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
   140003017:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   14000301b:	48 8b 40 38          	mov    0x38(%rax),%rax
   14000301f:	48 8b 40 08          	mov    0x8(%rax),%rax
   140003023:	48 8b 4d 28          	mov    0x28(%rbp),%rcx
   140003027:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   14000302b:	49 89 c9             	mov    %rcx,%r9
   14000302e:	48 89 c1             	mov    %rax,%rcx
   140003031:	e8 e3 fb ff ff       	call   140002c19 <_type__print_name>
   140003036:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   14000303a:	48 8b 40 38          	mov    0x38(%rax),%rax
   14000303e:	48 8b 10             	mov    (%rax),%rdx
   140003041:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003045:	49 89 d0             	mov    %rdx,%r8
   140003048:	48 8d 15 b2 03 01 00 	lea    0x103b2(%rip),%rdx        # 140013401 <.rdata+0x3b1>
   14000304f:	48 89 c1             	mov    %rax,%rcx
   140003052:	e8 39 e6 00 00       	call   140011690 <fprintf>
   140003057:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   14000305b:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000305f:	49 89 d0             	mov    %rdx,%r8
   140003062:	48 8d 15 9c 03 01 00 	lea    0x1039c(%rip),%rdx        # 140013405 <.rdata+0x3b5>
   140003069:	48 89 c1             	mov    %rax,%rcx
   14000306c:	e8 1f e6 00 00       	call   140011690 <fprintf>
   140003071:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003075:	48 89 c2             	mov    %rax,%rdx
   140003078:	b9 7c 00 00 00       	mov    $0x7c,%ecx
   14000307d:	e8 ce e9 00 00       	call   140011a50 <fputc>
   140003082:	e9 8a 01 00 00       	jmp    140003211 <_type__print_name+0x5f8>
   140003087:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000308b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   14000308f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   140003093:	48 8b 50 38          	mov    0x38(%rax),%rdx
   140003097:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000309b:	49 89 d0             	mov    %rdx,%r8
   14000309e:	48 8d 15 66 03 01 00 	lea    0x10366(%rip),%rdx        # 14001340b <.rdata+0x3bb>
   1400030a5:	48 89 c1             	mov    %rax,%rcx
   1400030a8:	e8 e3 e5 00 00       	call   140011690 <fprintf>
   1400030ad:	8b 45 20             	mov    0x20(%rbp),%eax
   1400030b0:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
   1400030b4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   1400030b8:	48 8b 40 30          	mov    0x30(%rax),%rax
   1400030bc:	48 8b 4d 28          	mov    0x28(%rbp),%rcx
   1400030c0:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   1400030c4:	49 89 c9             	mov    %rcx,%r9
   1400030c7:	48 89 c1             	mov    %rax,%rcx
   1400030ca:	e8 4a fb ff ff       	call   140002c19 <_type__print_name>
   1400030cf:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400030d3:	48 89 c2             	mov    %rax,%rdx
   1400030d6:	b9 5d 00 00 00       	mov    $0x5d,%ecx
   1400030db:	e8 70 e9 00 00       	call   140011a50 <fputc>
   1400030e0:	e9 2c 01 00 00       	jmp    140003211 <_type__print_name+0x5f8>
   1400030e5:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400030e9:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   1400030ed:	8b 45 20             	mov    0x20(%rbp),%eax
   1400030f0:	44 8d 40 ff          	lea    -0x1(%rax),%r8d
   1400030f4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   1400030f8:	48 8b 40 30          	mov    0x30(%rax),%rax
   1400030fc:	48 8b 4d 28          	mov    0x28(%rbp),%rcx
   140003100:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140003104:	49 89 c9             	mov    %rcx,%r9
   140003107:	48 89 c1             	mov    %rax,%rcx
   14000310a:	e8 0a fb ff ff       	call   140002c19 <_type__print_name>
   14000310f:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003113:	48 89 c2             	mov    %rax,%rdx
   140003116:	b9 2a 00 00 00       	mov    $0x2a,%ecx
   14000311b:	e8 30 e9 00 00       	call   140011a50 <fputc>
   140003120:	e9 ec 00 00 00       	jmp    140003211 <_type__print_name+0x5f8>
   140003125:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003129:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000312d:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003131:	48 89 c2             	mov    %rax,%rdx
   140003134:	b9 3c 00 00 00       	mov    $0x3c,%ecx
   140003139:	e8 12 e9 00 00       	call   140011a50 <fputc>
   14000313e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   140003145:	e9 80 00 00 00       	jmp    1400031ca <_type__print_name+0x5b1>
   14000314a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000314e:	48 8b 40 30          	mov    0x30(%rax),%rax
   140003152:	8b 55 f4             	mov    -0xc(%rbp),%edx
   140003155:	48 c1 e2 04          	shl    $0x4,%rdx
   140003159:	48 01 d0             	add    %rdx,%rax
   14000315c:	48 8b 00             	mov    (%rax),%rax
   14000315f:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140003163:	48 89 c1             	mov    %rax,%rcx
   140003166:	e8 ed e8 00 00       	call   140011a58 <fputs>
   14000316b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000316f:	48 8b 40 30          	mov    0x30(%rax),%rax
   140003173:	8b 55 f4             	mov    -0xc(%rbp),%edx
   140003176:	48 c1 e2 04          	shl    $0x4,%rdx
   14000317a:	48 01 d0             	add    %rdx,%rax
   14000317d:	8b 50 08             	mov    0x8(%rax),%edx
   140003180:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003184:	41 89 d0             	mov    %edx,%r8d
   140003187:	48 8d 15 85 02 01 00 	lea    0x10285(%rip),%rdx        # 140013413 <.rdata+0x3c3>
   14000318e:	48 89 c1             	mov    %rax,%rcx
   140003191:	e8 fa e4 00 00       	call   140011690 <fprintf>
   140003196:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000319a:	8b 40 3c             	mov    0x3c(%rax),%eax
   14000319d:	83 e8 01             	sub    $0x1,%eax
   1400031a0:	39 45 f4             	cmp    %eax,-0xc(%rbp)
   1400031a3:	73 21                	jae    1400031c6 <_type__print_name+0x5ad>
   1400031a5:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400031a9:	49 89 c1             	mov    %rax,%r9
   1400031ac:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   1400031b2:	ba 01 00 00 00       	mov    $0x1,%edx
   1400031b7:	48 8d 05 98 ff 00 00 	lea    0xff98(%rip),%rax        # 140013156 <.rdata+0x106>
   1400031be:	48 89 c1             	mov    %rax,%rcx
   1400031c1:	e8 a2 e8 00 00       	call   140011a68 <fwrite>
   1400031c6:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   1400031ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   1400031ce:	8b 40 3c             	mov    0x3c(%rax),%eax
   1400031d1:	39 45 f4             	cmp    %eax,-0xc(%rbp)
   1400031d4:	0f 82 70 ff ff ff    	jb     14000314a <_type__print_name+0x531>
   1400031da:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400031de:	48 89 c2             	mov    %rax,%rdx
   1400031e1:	b9 3e 00 00 00       	mov    $0x3e,%ecx
   1400031e6:	e8 65 e8 00 00       	call   140011a50 <fputc>
   1400031eb:	eb 24                	jmp    140003211 <_type__print_name+0x5f8>
   1400031ed:	41 b8 36 02 00 00    	mov    $0x236,%r8d
   1400031f3:	48 8d 05 56 fe 00 00 	lea    0xfe56(%rip),%rax        # 140013050 <.rdata>
   1400031fa:	48 89 c2             	mov    %rax,%rdx
   1400031fd:	48 8d 05 68 ff 00 00 	lea    0xff68(%rip),%rax        # 14001316c <.rdata+0x11c>
   140003204:	48 89 c1             	mov    %rax,%rcx
   140003207:	48 8b 05 32 81 01 00 	mov    0x18132(%rip),%rax        # 14001b340 <__imp__assert>
   14000320e:	ff d0                	call   *%rax
   140003210:	90                   	nop
   140003211:	48 83 c4 60          	add    $0x60,%rsp
   140003215:	5d                   	pop    %rbp
   140003216:	c3                   	ret

0000000140003217 <_type__print_size>:
   140003217:	55                   	push   %rbp
   140003218:	48 89 e5             	mov    %rsp,%rbp
   14000321b:	48 83 ec 20          	sub    $0x20,%rsp
   14000321f:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003223:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003227:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000322b:	48 89 c1             	mov    %rax,%rcx
   14000322e:	e8 38 ef ff ff       	call   14000216b <type__size>
   140003233:	48 89 c2             	mov    %rax,%rdx
   140003236:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000323a:	49 89 d0             	mov    %rdx,%r8
   14000323d:	48 8d 15 ec 01 01 00 	lea    0x101ec(%rip),%rdx        # 140013430 <.rdata+0x3e0>
   140003244:	48 89 c1             	mov    %rax,%rcx
   140003247:	e8 44 e4 00 00       	call   140011690 <fprintf>
   14000324c:	90                   	nop
   14000324d:	48 83 c4 20          	add    $0x20,%rsp
   140003251:	5d                   	pop    %rbp
   140003252:	c3                   	ret

0000000140003253 <_type__print_alignment>:
   140003253:	55                   	push   %rbp
   140003254:	48 89 e5             	mov    %rsp,%rbp
   140003257:	48 83 ec 20          	sub    $0x20,%rsp
   14000325b:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000325f:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003263:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003267:	48 8b 50 10          	mov    0x10(%rax),%rdx
   14000326b:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000326f:	49 89 d0             	mov    %rdx,%r8
   140003272:	48 8d 15 b7 01 01 00 	lea    0x101b7(%rip),%rdx        # 140013430 <.rdata+0x3e0>
   140003279:	48 89 c1             	mov    %rax,%rcx
   14000327c:	e8 0f e4 00 00       	call   140011690 <fprintf>
   140003281:	90                   	nop
   140003282:	48 83 c4 20          	add    $0x20,%rsp
   140003286:	5d                   	pop    %rbp
   140003287:	c3                   	ret

0000000140003288 <_type__print_max_alignment>:
   140003288:	55                   	push   %rbp
   140003289:	48 89 e5             	mov    %rsp,%rbp
   14000328c:	48 83 ec 20          	sub    $0x20,%rsp
   140003290:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003294:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003298:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000329c:	48 8b 40 18          	mov    0x18(%rax),%rax
   1400032a0:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
   1400032a4:	75 13                	jne    1400032b9 <_type__print_max_alignment+0x31>
   1400032a6:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400032aa:	48 89 c2             	mov    %rax,%rdx
   1400032ad:	b9 2d 00 00 00       	mov    $0x2d,%ecx
   1400032b2:	e8 99 e7 00 00       	call   140011a50 <fputc>
   1400032b7:	eb 1e                	jmp    1400032d7 <_type__print_max_alignment+0x4f>
   1400032b9:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400032bd:	48 8b 50 18          	mov    0x18(%rax),%rdx
   1400032c1:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400032c5:	49 89 d0             	mov    %rdx,%r8
   1400032c8:	48 8d 15 61 01 01 00 	lea    0x10161(%rip),%rdx        # 140013430 <.rdata+0x3e0>
   1400032cf:	48 89 c1             	mov    %rax,%rcx
   1400032d2:	e8 b9 e3 00 00       	call   140011690 <fprintf>
   1400032d7:	90                   	nop
   1400032d8:	48 83 c4 20          	add    $0x20,%rsp
   1400032dc:	5d                   	pop    %rbp
   1400032dd:	c3                   	ret

00000001400032de <type__print>:
   1400032de:	55                   	push   %rbp
   1400032df:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
   1400032e6:	48 8d ac 24 80 00 00 	lea    0x80(%rsp),%rbp
   1400032ed:	00 
   1400032ee:	48 89 8d d0 00 00 00 	mov    %rcx,0xd0(%rbp)
   1400032f5:	48 89 95 d8 00 00 00 	mov    %rdx,0xd8(%rbp)
   1400032fc:	44 89 85 e0 00 00 00 	mov    %r8d,0xe0(%rbp)
   140003303:	44 89 8d e8 00 00 00 	mov    %r9d,0xe8(%rbp)
   14000330a:	c7 85 bc 00 00 00 00 	movl   $0x0,0xbc(%rbp)
   140003311:	00 00 00 
   140003314:	e9 8c 00 00 00       	jmp    1400033a5 <type__print+0xc7>
   140003319:	8b 95 bc 00 00 00    	mov    0xbc(%rbp),%edx
   14000331f:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   140003323:	41 89 d1             	mov    %edx,%r9d
   140003326:	4c 8d 05 08 01 01 00 	lea    0x10108(%rip),%r8        # 140013435 <.rdata+0x3e5>
   14000332d:	ba 00 01 00 00       	mov    $0x100,%edx
   140003332:	48 89 c1             	mov    %rax,%rcx
   140003335:	e8 96 e2 00 00       	call   1400115d0 <snprintf>
   14000333a:	48 8b 85 d8 00 00 00 	mov    0xd8(%rbp),%rax
   140003341:	48 8d 55 b0          	lea    -0x50(%rbp),%rdx
   140003345:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   14000334a:	41 b9 16 00 00 00    	mov    $0x16,%r9d
   140003350:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140003356:	48 8d 15 f1 00 01 00 	lea    0x100f1(%rip),%rdx        # 14001344e <.rdata+0x3fe>
   14000335d:	48 89 c1             	mov    %rax,%rcx
   140003360:	e8 2b e3 00 00       	call   140011690 <fprintf>
   140003365:	8b 8d bc 00 00 00    	mov    0xbc(%rbp),%ecx
   14000336b:	48 8b 95 d8 00 00 00 	mov    0xd8(%rbp),%rdx
   140003372:	48 8b 85 d0 00 00 00 	mov    0xd0(%rbp),%rax
   140003379:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000337f:	41 89 c8             	mov    %ecx,%r8d
   140003382:	48 89 c1             	mov    %rax,%rcx
   140003385:	e8 8f f8 ff ff       	call   140002c19 <_type__print_name>
   14000338a:	48 8b 85 d8 00 00 00 	mov    0xd8(%rbp),%rax
   140003391:	48 89 c2             	mov    %rax,%rdx
   140003394:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140003399:	e8 b2 e6 00 00       	call   140011a50 <fputc>
   14000339e:	83 85 bc 00 00 00 01 	addl   $0x1,0xbc(%rbp)
   1400033a5:	8b 85 bc 00 00 00    	mov    0xbc(%rbp),%eax
   1400033ab:	39 85 e0 00 00 00    	cmp    %eax,0xe0(%rbp)
   1400033b1:	0f 83 62 ff ff ff    	jae    140003319 <type__print+0x3b>
   1400033b7:	48 8b 85 d8 00 00 00 	mov    0xd8(%rbp),%rax
   1400033be:	48 8d 15 90 00 01 00 	lea    0x10090(%rip),%rdx        # 140013455 <.rdata+0x405>
   1400033c5:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   1400033ca:	41 b9 16 00 00 00    	mov    $0x16,%r9d
   1400033d0:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400033d6:	48 8d 15 71 00 01 00 	lea    0x10071(%rip),%rdx        # 14001344e <.rdata+0x3fe>
   1400033dd:	48 89 c1             	mov    %rax,%rcx
   1400033e0:	e8 ab e2 00 00       	call   140011690 <fprintf>
   1400033e5:	48 8b 95 d8 00 00 00 	mov    0xd8(%rbp),%rdx
   1400033ec:	48 8b 85 d0 00 00 00 	mov    0xd0(%rbp),%rax
   1400033f3:	48 89 c1             	mov    %rax,%rcx
   1400033f6:	e8 1c fe ff ff       	call   140003217 <_type__print_size>
   1400033fb:	48 8b 85 d8 00 00 00 	mov    0xd8(%rbp),%rax
   140003402:	48 89 c2             	mov    %rax,%rdx
   140003405:	b9 0a 00 00 00       	mov    $0xa,%ecx
   14000340a:	e8 41 e6 00 00       	call   140011a50 <fputc>
   14000340f:	48 8b 85 d8 00 00 00 	mov    0xd8(%rbp),%rax
   140003416:	48 8d 15 3f 00 01 00 	lea    0x1003f(%rip),%rdx        # 14001345c <.rdata+0x40c>
   14000341d:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   140003422:	41 b9 16 00 00 00    	mov    $0x16,%r9d
   140003428:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000342e:	48 8d 15 19 00 01 00 	lea    0x10019(%rip),%rdx        # 14001344e <.rdata+0x3fe>
   140003435:	48 89 c1             	mov    %rax,%rcx
   140003438:	e8 53 e2 00 00       	call   140011690 <fprintf>
   14000343d:	48 8b 95 d8 00 00 00 	mov    0xd8(%rbp),%rdx
   140003444:	48 8b 85 d0 00 00 00 	mov    0xd0(%rbp),%rax
   14000344b:	48 89 c1             	mov    %rax,%rcx
   14000344e:	e8 00 fe ff ff       	call   140003253 <_type__print_alignment>
   140003453:	48 8b 85 d8 00 00 00 	mov    0xd8(%rbp),%rax
   14000345a:	48 89 c2             	mov    %rax,%rdx
   14000345d:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140003462:	e8 e9 e5 00 00       	call   140011a50 <fputc>
   140003467:	48 8b 85 d8 00 00 00 	mov    0xd8(%rbp),%rax
   14000346e:	48 8d 15 f3 ff 00 00 	lea    0xfff3(%rip),%rdx        # 140013468 <.rdata+0x418>
   140003475:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   14000347a:	41 b9 16 00 00 00    	mov    $0x16,%r9d
   140003480:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140003486:	48 8d 15 c1 ff 00 00 	lea    0xffc1(%rip),%rdx        # 14001344e <.rdata+0x3fe>
   14000348d:	48 89 c1             	mov    %rax,%rcx
   140003490:	e8 fb e1 00 00       	call   140011690 <fprintf>
   140003495:	48 8b 95 d8 00 00 00 	mov    0xd8(%rbp),%rdx
   14000349c:	48 8b 85 d0 00 00 00 	mov    0xd0(%rbp),%rax
   1400034a3:	48 89 c1             	mov    %rax,%rcx
   1400034a6:	e8 dd fd ff ff       	call   140003288 <_type__print_max_alignment>
   1400034ab:	48 8b 85 d8 00 00 00 	mov    0xd8(%rbp),%rax
   1400034b2:	48 89 c2             	mov    %rax,%rdx
   1400034b5:	b9 0a 00 00 00       	mov    $0xa,%ecx
   1400034ba:	e8 91 e5 00 00       	call   140011a50 <fputc>
   1400034bf:	48 83 bd f0 00 00 00 	cmpq   $0x0,0xf0(%rbp)
   1400034c6:	00 
   1400034c7:	0f 84 a2 00 00 00    	je     14000356f <type__print+0x291>
   1400034cd:	48 8b 85 d8 00 00 00 	mov    0xd8(%rbp),%rax
   1400034d4:	48 8d 15 9d ff 00 00 	lea    0xff9d(%rip),%rdx        # 140013478 <.rdata+0x428>
   1400034db:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   1400034e0:	41 b9 16 00 00 00    	mov    $0x16,%r9d
   1400034e6:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400034ec:	48 8d 15 5b ff 00 00 	lea    0xff5b(%rip),%rdx        # 14001344e <.rdata+0x3fe>
   1400034f3:	48 89 c1             	mov    %rax,%rcx
   1400034f6:	e8 95 e1 00 00       	call   140011690 <fprintf>
   1400034fb:	48 8b 8d f0 00 00 00 	mov    0xf0(%rbp),%rcx
   140003502:	48 8b 95 d8 00 00 00 	mov    0xd8(%rbp),%rdx
   140003509:	48 8b 85 d0 00 00 00 	mov    0xd0(%rbp),%rax
   140003510:	49 89 c9             	mov    %rcx,%r9
   140003513:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   140003519:	48 89 c1             	mov    %rax,%rcx
   14000351c:	e8 d9 e1 ff ff       	call   1400016fa <_type__print_value>
   140003521:	48 8b 85 d8 00 00 00 	mov    0xd8(%rbp),%rax
   140003528:	48 89 c2             	mov    %rax,%rdx
   14000352b:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140003530:	e8 1b e5 00 00       	call   140011a50 <fputc>
   140003535:	48 8b 85 d8 00 00 00 	mov    0xd8(%rbp),%rax
   14000353c:	48 8b 95 f0 00 00 00 	mov    0xf0(%rbp),%rdx
   140003543:	48 89 54 24 28       	mov    %rdx,0x28(%rsp)
   140003548:	48 8d 15 3b ff 00 00 	lea    0xff3b(%rip),%rdx        # 14001348a <.rdata+0x43a>
   14000354f:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   140003554:	41 b9 16 00 00 00    	mov    $0x16,%r9d
   14000355a:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140003560:	48 8d 15 19 ff 00 00 	lea    0xff19(%rip),%rdx        # 140013480 <.rdata+0x430>
   140003567:	48 89 c1             	mov    %rax,%rcx
   14000356a:	e8 21 e1 00 00       	call   140011690 <fprintf>
   14000356f:	90                   	nop
   140003570:	48 81 c4 40 01 00 00 	add    $0x140,%rsp
   140003577:	5d                   	pop    %rbp
   140003578:	c3                   	ret

0000000140003579 <_type_struct__add_multiple>:
   140003579:	55                   	push   %rbp
   14000357a:	48 89 e5             	mov    %rsp,%rbp
   14000357d:	48 83 ec 40          	sub    $0x40,%rsp
   140003581:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003585:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003589:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   14000358d:	4c 89 4d 28          	mov    %r9,0x28(%rbp)
   140003591:	48 8d 45 18          	lea    0x18(%rbp),%rax
   140003595:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   140003599:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000359d:	48 8d 50 08          	lea    0x8(%rax),%rdx
   1400035a1:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
   1400035a5:	48 8b 00             	mov    (%rax),%rax
   1400035a8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   1400035ac:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   1400035b1:	75 23                	jne    1400035d6 <_type_struct__add_multiple+0x5d>
   1400035b3:	41 b8 a0 02 00 00    	mov    $0x2a0,%r8d
   1400035b9:	48 8d 05 90 fa 00 00 	lea    0xfa90(%rip),%rax        # 140013050 <.rdata>
   1400035c0:	48 89 c2             	mov    %rax,%rdx
   1400035c3:	48 8d 05 ca fe 00 00 	lea    0xfeca(%rip),%rax        # 140013494 <.rdata+0x444>
   1400035ca:	48 89 c1             	mov    %rax,%rcx
   1400035cd:	48 8b 05 6c 7d 01 00 	mov    0x17d6c(%rip),%rax        # 14001b340 <__imp__assert>
   1400035d4:	ff d0                	call   *%rax
   1400035d6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   1400035da:	48 8d 50 08          	lea    0x8(%rax),%rdx
   1400035de:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
   1400035e2:	48 8b 00             	mov    (%rax),%rax
   1400035e5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   1400035e9:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   1400035ee:	75 23                	jne    140003613 <_type_struct__add_multiple+0x9a>
   1400035f0:	41 b8 a2 02 00 00    	mov    $0x2a2,%r8d
   1400035f6:	48 8d 05 53 fa 00 00 	lea    0xfa53(%rip),%rax        # 140013050 <.rdata>
   1400035fd:	48 89 c2             	mov    %rax,%rdx
   140003600:	48 8d 05 92 fe 00 00 	lea    0xfe92(%rip),%rax        # 140013499 <.rdata+0x449>
   140003607:	48 89 c1             	mov    %rax,%rcx
   14000360a:	48 8b 05 2f 7d 01 00 	mov    0x17d2f(%rip),%rax        # 14001b340 <__imp__assert>
   140003611:	ff d0                	call   *%rax
   140003613:	90                   	nop
   140003614:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
   140003618:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   14000361c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003620:	49 89 c8             	mov    %rcx,%r8
   140003623:	48 89 c1             	mov    %rax,%rcx
   140003626:	e8 a9 ee ff ff       	call   1400024d4 <type_struct__add>
   14000362b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000362f:	48 8d 50 08          	lea    0x8(%rax),%rdx
   140003633:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
   140003637:	48 8b 00             	mov    (%rax),%rax
   14000363a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000363e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   140003643:	74 3f                	je     140003684 <_type_struct__add_multiple+0x10b>
   140003645:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140003649:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000364d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
   140003651:	48 8b 00             	mov    (%rax),%rax
   140003654:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140003658:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   14000365d:	75 23                	jne    140003682 <_type_struct__add_multiple+0x109>
   14000365f:	41 b8 aa 02 00 00    	mov    $0x2aa,%r8d
   140003665:	48 8d 05 e4 f9 00 00 	lea    0xf9e4(%rip),%rax        # 140013050 <.rdata>
   14000366c:	48 89 c2             	mov    %rax,%rdx
   14000366f:	48 8d 05 23 fe 00 00 	lea    0xfe23(%rip),%rax        # 140013499 <.rdata+0x449>
   140003676:	48 89 c1             	mov    %rax,%rcx
   140003679:	48 8b 05 c0 7c 01 00 	mov    0x17cc0(%rip),%rax        # 14001b340 <__imp__assert>
   140003680:	ff d0                	call   *%rax
   140003682:	eb 90                	jmp    140003614 <_type_struct__add_multiple+0x9b>
   140003684:	90                   	nop
   140003685:	90                   	nop
   140003686:	48 83 c4 40          	add    $0x40,%rsp
   14000368a:	5d                   	pop    %rbp
   14000368b:	c3                   	ret

000000014000368c <_type_union__add_multiple>:
   14000368c:	55                   	push   %rbp
   14000368d:	48 89 e5             	mov    %rsp,%rbp
   140003690:	48 83 ec 40          	sub    $0x40,%rsp
   140003694:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003698:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000369c:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   1400036a0:	4c 89 4d 28          	mov    %r9,0x28(%rbp)
   1400036a4:	48 8d 45 18          	lea    0x18(%rbp),%rax
   1400036a8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   1400036ac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   1400036b0:	48 8d 50 08          	lea    0x8(%rax),%rdx
   1400036b4:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
   1400036b8:	48 8b 00             	mov    (%rax),%rax
   1400036bb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   1400036bf:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   1400036c4:	75 23                	jne    1400036e9 <_type_union__add_multiple+0x5d>
   1400036c6:	41 b8 b5 02 00 00    	mov    $0x2b5,%r8d
   1400036cc:	48 8d 05 7d f9 00 00 	lea    0xf97d(%rip),%rax        # 140013050 <.rdata>
   1400036d3:	48 89 c2             	mov    %rax,%rdx
   1400036d6:	48 8d 05 b7 fd 00 00 	lea    0xfdb7(%rip),%rax        # 140013494 <.rdata+0x444>
   1400036dd:	48 89 c1             	mov    %rax,%rcx
   1400036e0:	48 8b 05 59 7c 01 00 	mov    0x17c59(%rip),%rax        # 14001b340 <__imp__assert>
   1400036e7:	ff d0                	call   *%rax
   1400036e9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   1400036ed:	48 8d 50 08          	lea    0x8(%rax),%rdx
   1400036f1:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
   1400036f5:	48 8b 00             	mov    (%rax),%rax
   1400036f8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   1400036fc:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   140003701:	75 23                	jne    140003726 <_type_union__add_multiple+0x9a>
   140003703:	41 b8 b7 02 00 00    	mov    $0x2b7,%r8d
   140003709:	48 8d 05 40 f9 00 00 	lea    0xf940(%rip),%rax        # 140013050 <.rdata>
   140003710:	48 89 c2             	mov    %rax,%rdx
   140003713:	48 8d 05 7f fd 00 00 	lea    0xfd7f(%rip),%rax        # 140013499 <.rdata+0x449>
   14000371a:	48 89 c1             	mov    %rax,%rcx
   14000371d:	48 8b 05 1c 7c 01 00 	mov    0x17c1c(%rip),%rax        # 14001b340 <__imp__assert>
   140003724:	ff d0                	call   *%rax
   140003726:	90                   	nop
   140003727:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
   14000372b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   14000372f:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003733:	49 89 c8             	mov    %rcx,%r8
   140003736:	48 89 c1             	mov    %rax,%rcx
   140003739:	e8 6c ef ff ff       	call   1400026aa <type_union__add>
   14000373e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140003742:	48 8d 50 08          	lea    0x8(%rax),%rdx
   140003746:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
   14000374a:	48 8b 00             	mov    (%rax),%rax
   14000374d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140003751:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   140003756:	74 3f                	je     140003797 <_type_union__add_multiple+0x10b>
   140003758:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000375c:	48 8d 50 08          	lea    0x8(%rax),%rdx
   140003760:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
   140003764:	48 8b 00             	mov    (%rax),%rax
   140003767:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000376b:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   140003770:	75 23                	jne    140003795 <_type_union__add_multiple+0x109>
   140003772:	41 b8 bf 02 00 00    	mov    $0x2bf,%r8d
   140003778:	48 8d 05 d1 f8 00 00 	lea    0xf8d1(%rip),%rax        # 140013050 <.rdata>
   14000377f:	48 89 c2             	mov    %rax,%rdx
   140003782:	48 8d 05 10 fd 00 00 	lea    0xfd10(%rip),%rax        # 140013499 <.rdata+0x449>
   140003789:	48 89 c1             	mov    %rax,%rcx
   14000378c:	48 8b 05 ad 7b 01 00 	mov    0x17bad(%rip),%rax        # 14001b340 <__imp__assert>
   140003793:	ff d0                	call   *%rax
   140003795:	eb 90                	jmp    140003727 <_type_union__add_multiple+0x9b>
   140003797:	90                   	nop
   140003798:	90                   	nop
   140003799:	48 83 c4 40          	add    $0x40,%rsp
   14000379d:	5d                   	pop    %rbp
   14000379e:	c3                   	ret

000000014000379f <_type__print_value_s8>:
   14000379f:	55                   	push   %rbp
   1400037a0:	48 89 e5             	mov    %rsp,%rbp
   1400037a3:	48 83 ec 20          	sub    $0x20,%rsp
   1400037a7:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400037ab:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400037af:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400037b3:	0f b6 00             	movzbl (%rax),%eax
   1400037b6:	0f be d0             	movsbl %al,%edx
   1400037b9:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400037bd:	41 89 d0             	mov    %edx,%r8d
   1400037c0:	48 8d 15 d7 fc 00 00 	lea    0xfcd7(%rip),%rdx        # 14001349e <.rdata+0x44e>
   1400037c7:	48 89 c1             	mov    %rax,%rcx
   1400037ca:	e8 c1 de 00 00       	call   140011690 <fprintf>
   1400037cf:	90                   	nop
   1400037d0:	48 83 c4 20          	add    $0x20,%rsp
   1400037d4:	5d                   	pop    %rbp
   1400037d5:	c3                   	ret

00000001400037d6 <_type__print_value_s16>:
   1400037d6:	55                   	push   %rbp
   1400037d7:	48 89 e5             	mov    %rsp,%rbp
   1400037da:	48 83 ec 20          	sub    $0x20,%rsp
   1400037de:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400037e2:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400037e6:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400037ea:	0f b7 00             	movzwl (%rax),%eax
   1400037ed:	0f bf d0             	movswl %ax,%edx
   1400037f0:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400037f4:	41 89 d0             	mov    %edx,%r8d
   1400037f7:	48 8d 15 a0 fc 00 00 	lea    0xfca0(%rip),%rdx        # 14001349e <.rdata+0x44e>
   1400037fe:	48 89 c1             	mov    %rax,%rcx
   140003801:	e8 8a de 00 00       	call   140011690 <fprintf>
   140003806:	90                   	nop
   140003807:	48 83 c4 20          	add    $0x20,%rsp
   14000380b:	5d                   	pop    %rbp
   14000380c:	c3                   	ret

000000014000380d <_type__print_value_s32>:
   14000380d:	55                   	push   %rbp
   14000380e:	48 89 e5             	mov    %rsp,%rbp
   140003811:	48 83 ec 20          	sub    $0x20,%rsp
   140003815:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003819:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000381d:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003821:	8b 10                	mov    (%rax),%edx
   140003823:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003827:	41 89 d0             	mov    %edx,%r8d
   14000382a:	48 8d 15 6d fc 00 00 	lea    0xfc6d(%rip),%rdx        # 14001349e <.rdata+0x44e>
   140003831:	48 89 c1             	mov    %rax,%rcx
   140003834:	e8 57 de 00 00       	call   140011690 <fprintf>
   140003839:	90                   	nop
   14000383a:	48 83 c4 20          	add    $0x20,%rsp
   14000383e:	5d                   	pop    %rbp
   14000383f:	c3                   	ret

0000000140003840 <_type__print_value_s64>:
   140003840:	55                   	push   %rbp
   140003841:	48 89 e5             	mov    %rsp,%rbp
   140003844:	48 83 ec 20          	sub    $0x20,%rsp
   140003848:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000384c:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003850:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003854:	48 8b 10             	mov    (%rax),%rdx
   140003857:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000385b:	49 89 d0             	mov    %rdx,%r8
   14000385e:	48 8d 15 3c fc 00 00 	lea    0xfc3c(%rip),%rdx        # 1400134a1 <.rdata+0x451>
   140003865:	48 89 c1             	mov    %rax,%rcx
   140003868:	e8 23 de 00 00       	call   140011690 <fprintf>
   14000386d:	90                   	nop
   14000386e:	48 83 c4 20          	add    $0x20,%rsp
   140003872:	5d                   	pop    %rbp
   140003873:	c3                   	ret

0000000140003874 <_type__print_value_u8>:
   140003874:	55                   	push   %rbp
   140003875:	48 89 e5             	mov    %rsp,%rbp
   140003878:	48 83 ec 20          	sub    $0x20,%rsp
   14000387c:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003880:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003884:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003888:	0f b6 00             	movzbl (%rax),%eax
   14000388b:	0f b6 d0             	movzbl %al,%edx
   14000388e:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003892:	41 89 d0             	mov    %edx,%r8d
   140003895:	48 8d 15 0a fc 00 00 	lea    0xfc0a(%rip),%rdx        # 1400134a6 <.rdata+0x456>
   14000389c:	48 89 c1             	mov    %rax,%rcx
   14000389f:	e8 ec dd 00 00       	call   140011690 <fprintf>
   1400038a4:	90                   	nop
   1400038a5:	48 83 c4 20          	add    $0x20,%rsp
   1400038a9:	5d                   	pop    %rbp
   1400038aa:	c3                   	ret

00000001400038ab <_type__print_value_u16>:
   1400038ab:	55                   	push   %rbp
   1400038ac:	48 89 e5             	mov    %rsp,%rbp
   1400038af:	48 83 ec 20          	sub    $0x20,%rsp
   1400038b3:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400038b7:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400038bb:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400038bf:	0f b7 00             	movzwl (%rax),%eax
   1400038c2:	0f b7 d0             	movzwl %ax,%edx
   1400038c5:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400038c9:	41 89 d0             	mov    %edx,%r8d
   1400038cc:	48 8d 15 d3 fb 00 00 	lea    0xfbd3(%rip),%rdx        # 1400134a6 <.rdata+0x456>
   1400038d3:	48 89 c1             	mov    %rax,%rcx
   1400038d6:	e8 b5 dd 00 00       	call   140011690 <fprintf>
   1400038db:	90                   	nop
   1400038dc:	48 83 c4 20          	add    $0x20,%rsp
   1400038e0:	5d                   	pop    %rbp
   1400038e1:	c3                   	ret

00000001400038e2 <_type__print_value_u32>:
   1400038e2:	55                   	push   %rbp
   1400038e3:	48 89 e5             	mov    %rsp,%rbp
   1400038e6:	48 83 ec 20          	sub    $0x20,%rsp
   1400038ea:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400038ee:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400038f2:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400038f6:	8b 10                	mov    (%rax),%edx
   1400038f8:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400038fc:	41 89 d0             	mov    %edx,%r8d
   1400038ff:	48 8d 15 a0 fb 00 00 	lea    0xfba0(%rip),%rdx        # 1400134a6 <.rdata+0x456>
   140003906:	48 89 c1             	mov    %rax,%rcx
   140003909:	e8 82 dd 00 00       	call   140011690 <fprintf>
   14000390e:	90                   	nop
   14000390f:	48 83 c4 20          	add    $0x20,%rsp
   140003913:	5d                   	pop    %rbp
   140003914:	c3                   	ret

0000000140003915 <_type__print_value_u64>:
   140003915:	55                   	push   %rbp
   140003916:	48 89 e5             	mov    %rsp,%rbp
   140003919:	48 83 ec 20          	sub    $0x20,%rsp
   14000391d:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003921:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003925:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140003929:	48 8b 10             	mov    (%rax),%rdx
   14000392c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003930:	49 89 d0             	mov    %rdx,%r8
   140003933:	48 8d 15 f6 fa 00 00 	lea    0xfaf6(%rip),%rdx        # 140013430 <.rdata+0x3e0>
   14000393a:	48 89 c1             	mov    %rax,%rcx
   14000393d:	e8 4e dd 00 00       	call   140011690 <fprintf>
   140003942:	90                   	nop
   140003943:	48 83 c4 20          	add    $0x20,%rsp
   140003947:	5d                   	pop    %rbp
   140003948:	c3                   	ret

0000000140003949 <_type__print_value_r32>:
   140003949:	55                   	push   %rbp
   14000394a:	48 89 e5             	mov    %rsp,%rbp
   14000394d:	48 83 ec 20          	sub    $0x20,%rsp
   140003951:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140003955:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140003959:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000395d:	f3 0f 10 00          	movss  (%rax),%xmm0
   140003961:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
   140003965:	66 48 0f 7e c0       	movq   %xmm0,%rax
   14000396a:	48 89 c2             	mov    %rax,%rdx
   14000396d:	66 48 0f 6e c2       	movq   %rdx,%xmm0
   140003972:	48 89 c2             	mov    %rax,%rdx
   140003975:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140003979:	66 0f 28 d0          	movapd %xmm0,%xmm2
   14000397d:	49 89 d0             	mov    %rdx,%r8
   140003980:	48 8d 15 22 fb 00 00 	lea    0xfb22(%rip),%rdx        # 1400134a9 <.rdata+0x459>
   140003987:	48 89 c1             	mov    %rax,%rcx
   14000398a:	e8 01 dd 00 00       	call   140011690 <fprintf>
   14000398f:	90                   	nop
   140003990:	48 83 c4 20          	add    $0x20,%rsp
   140003994:	5d                   	pop    %rbp
   140003995:	c3                   	ret

0000000140003996 <_type__print_value_r64>:
   140003996:	55                   	push   %rbp
   140003997:	48 89 e5             	mov    %rsp,%rbp
   14000399a:	48 83 ec 20          	sub    $0x20,%rsp
   14000399e:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400039a2:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400039a6:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400039aa:	f2 0f 10 00          	movsd  (%rax),%xmm0
   1400039ae:	66 48 0f 7e c0       	movq   %xmm0,%rax
   1400039b3:	48 89 c2             	mov    %rax,%rdx
   1400039b6:	66 48 0f 6e c2       	movq   %rdx,%xmm0
   1400039bb:	48 89 c2             	mov    %rax,%rdx
   1400039be:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400039c2:	66 0f 28 d0          	movapd %xmm0,%xmm2
   1400039c6:	49 89 d0             	mov    %rdx,%r8
   1400039c9:	48 8d 15 dc fa 00 00 	lea    0xfadc(%rip),%rdx        # 1400134ac <.rdata+0x45c>
   1400039d0:	48 89 c1             	mov    %rax,%rcx
   1400039d3:	e8 b8 dc 00 00       	call   140011690 <fprintf>
   1400039d8:	90                   	nop
   1400039d9:	48 83 c4 20          	add    $0x20,%rsp
   1400039dd:	5d                   	pop    %rbp
   1400039de:	c3                   	ret

00000001400039df <main2>:
   1400039df:	55                   	push   %rbp
   1400039e0:	48 81 ec 40 04 00 00 	sub    $0x440,%rsp
   1400039e7:	48 8d ac 24 80 00 00 	lea    0x80(%rsp),%rbp
   1400039ee:	00 
   1400039ef:	4c 8d 0d a9 fd ff ff 	lea    -0x257(%rip),%r9        # 14000379f <_type__print_value_s8>
   1400039f6:	41 b8 01 00 00 00    	mov    $0x1,%r8d
   1400039fc:	48 8d 05 ad fa 00 00 	lea    0xfaad(%rip),%rax        # 1400134b0 <.rdata+0x460>
   140003a03:	48 89 c2             	mov    %rax,%rdx
   140003a06:	48 8d 05 a3 fa 00 00 	lea    0xfaa3(%rip),%rax        # 1400134b0 <.rdata+0x460>
   140003a0d:	48 89 c1             	mov    %rax,%rcx
   140003a10:	e8 f2 e4 ff ff       	call   140001f07 <type_atom__create>
   140003a15:	48 89 85 b8 03 00 00 	mov    %rax,0x3b8(%rbp)
   140003a1c:	4c 8d 0d b3 fd ff ff 	lea    -0x24d(%rip),%r9        # 1400037d6 <_type__print_value_s16>
   140003a23:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140003a29:	48 8d 05 83 fa 00 00 	lea    0xfa83(%rip),%rax        # 1400134b3 <.rdata+0x463>
   140003a30:	48 89 c2             	mov    %rax,%rdx
   140003a33:	48 8d 05 79 fa 00 00 	lea    0xfa79(%rip),%rax        # 1400134b3 <.rdata+0x463>
   140003a3a:	48 89 c1             	mov    %rax,%rcx
   140003a3d:	e8 c5 e4 ff ff       	call   140001f07 <type_atom__create>
   140003a42:	48 89 85 b0 03 00 00 	mov    %rax,0x3b0(%rbp)
   140003a49:	4c 8d 0d bd fd ff ff 	lea    -0x243(%rip),%r9        # 14000380d <_type__print_value_s32>
   140003a50:	41 b8 04 00 00 00    	mov    $0x4,%r8d
   140003a56:	48 8d 05 5a fa 00 00 	lea    0xfa5a(%rip),%rax        # 1400134b7 <.rdata+0x467>
   140003a5d:	48 89 c2             	mov    %rax,%rdx
   140003a60:	48 8d 05 50 fa 00 00 	lea    0xfa50(%rip),%rax        # 1400134b7 <.rdata+0x467>
   140003a67:	48 89 c1             	mov    %rax,%rcx
   140003a6a:	e8 98 e4 ff ff       	call   140001f07 <type_atom__create>
   140003a6f:	48 89 85 a8 03 00 00 	mov    %rax,0x3a8(%rbp)
   140003a76:	4c 8d 0d c3 fd ff ff 	lea    -0x23d(%rip),%r9        # 140003840 <_type__print_value_s64>
   140003a7d:	41 b8 08 00 00 00    	mov    $0x8,%r8d
   140003a83:	48 8d 05 31 fa 00 00 	lea    0xfa31(%rip),%rax        # 1400134bb <.rdata+0x46b>
   140003a8a:	48 89 c2             	mov    %rax,%rdx
   140003a8d:	48 8d 05 27 fa 00 00 	lea    0xfa27(%rip),%rax        # 1400134bb <.rdata+0x46b>
   140003a94:	48 89 c1             	mov    %rax,%rcx
   140003a97:	e8 6b e4 ff ff       	call   140001f07 <type_atom__create>
   140003a9c:	48 89 85 a0 03 00 00 	mov    %rax,0x3a0(%rbp)
   140003aa3:	4c 8d 0d ca fd ff ff 	lea    -0x236(%rip),%r9        # 140003874 <_type__print_value_u8>
   140003aaa:	41 b8 01 00 00 00    	mov    $0x1,%r8d
   140003ab0:	48 8d 05 08 fa 00 00 	lea    0xfa08(%rip),%rax        # 1400134bf <.rdata+0x46f>
   140003ab7:	48 89 c2             	mov    %rax,%rdx
   140003aba:	48 8d 05 fe f9 00 00 	lea    0xf9fe(%rip),%rax        # 1400134bf <.rdata+0x46f>
   140003ac1:	48 89 c1             	mov    %rax,%rcx
   140003ac4:	e8 3e e4 ff ff       	call   140001f07 <type_atom__create>
   140003ac9:	48 89 85 98 03 00 00 	mov    %rax,0x398(%rbp)
   140003ad0:	4c 8d 0d d4 fd ff ff 	lea    -0x22c(%rip),%r9        # 1400038ab <_type__print_value_u16>
   140003ad7:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140003add:	48 8d 05 de f9 00 00 	lea    0xf9de(%rip),%rax        # 1400134c2 <.rdata+0x472>
   140003ae4:	48 89 c2             	mov    %rax,%rdx
   140003ae7:	48 8d 05 d4 f9 00 00 	lea    0xf9d4(%rip),%rax        # 1400134c2 <.rdata+0x472>
   140003aee:	48 89 c1             	mov    %rax,%rcx
   140003af1:	e8 11 e4 ff ff       	call   140001f07 <type_atom__create>
   140003af6:	48 89 85 90 03 00 00 	mov    %rax,0x390(%rbp)
   140003afd:	4c 8d 0d de fd ff ff 	lea    -0x222(%rip),%r9        # 1400038e2 <_type__print_value_u32>
   140003b04:	41 b8 04 00 00 00    	mov    $0x4,%r8d
   140003b0a:	48 8d 05 b5 f9 00 00 	lea    0xf9b5(%rip),%rax        # 1400134c6 <.rdata+0x476>
   140003b11:	48 89 c2             	mov    %rax,%rdx
   140003b14:	48 8d 05 ab f9 00 00 	lea    0xf9ab(%rip),%rax        # 1400134c6 <.rdata+0x476>
   140003b1b:	48 89 c1             	mov    %rax,%rcx
   140003b1e:	e8 e4 e3 ff ff       	call   140001f07 <type_atom__create>
   140003b23:	48 89 85 88 03 00 00 	mov    %rax,0x388(%rbp)
   140003b2a:	4c 8d 0d e4 fd ff ff 	lea    -0x21c(%rip),%r9        # 140003915 <_type__print_value_u64>
   140003b31:	41 b8 08 00 00 00    	mov    $0x8,%r8d
   140003b37:	48 8d 05 8c f9 00 00 	lea    0xf98c(%rip),%rax        # 1400134ca <.rdata+0x47a>
   140003b3e:	48 89 c2             	mov    %rax,%rdx
   140003b41:	48 8d 05 82 f9 00 00 	lea    0xf982(%rip),%rax        # 1400134ca <.rdata+0x47a>
   140003b48:	48 89 c1             	mov    %rax,%rcx
   140003b4b:	e8 b7 e3 ff ff       	call   140001f07 <type_atom__create>
   140003b50:	48 89 85 80 03 00 00 	mov    %rax,0x380(%rbp)
   140003b57:	4c 8d 0d eb fd ff ff 	lea    -0x215(%rip),%r9        # 140003949 <_type__print_value_r32>
   140003b5e:	41 b8 04 00 00 00    	mov    $0x4,%r8d
   140003b64:	48 8d 05 63 f9 00 00 	lea    0xf963(%rip),%rax        # 1400134ce <.rdata+0x47e>
   140003b6b:	48 89 c2             	mov    %rax,%rdx
   140003b6e:	48 8d 05 59 f9 00 00 	lea    0xf959(%rip),%rax        # 1400134ce <.rdata+0x47e>
   140003b75:	48 89 c1             	mov    %rax,%rcx
   140003b78:	e8 8a e3 ff ff       	call   140001f07 <type_atom__create>
   140003b7d:	48 89 85 78 03 00 00 	mov    %rax,0x378(%rbp)
   140003b84:	4c 8d 0d 0b fe ff ff 	lea    -0x1f5(%rip),%r9        # 140003996 <_type__print_value_r64>
   140003b8b:	41 b8 08 00 00 00    	mov    $0x8,%r8d
   140003b91:	48 8d 05 3a f9 00 00 	lea    0xf93a(%rip),%rax        # 1400134d2 <.rdata+0x482>
   140003b98:	48 89 c2             	mov    %rax,%rdx
   140003b9b:	48 8d 05 30 f9 00 00 	lea    0xf930(%rip),%rax        # 1400134d2 <.rdata+0x482>
   140003ba2:	48 89 c1             	mov    %rax,%rcx
   140003ba5:	e8 5d e3 ff ff       	call   140001f07 <type_atom__create>
   140003baa:	48 89 85 70 03 00 00 	mov    %rax,0x370(%rbp)
   140003bb1:	48 8d 05 1e f9 00 00 	lea    0xf91e(%rip),%rax        # 1400134d6 <.rdata+0x486>
   140003bb8:	48 89 c1             	mov    %rax,%rcx
   140003bbb:	e8 bb e8 ff ff       	call   14000247b <type_struct__create>
   140003bc0:	48 89 85 68 03 00 00 	mov    %rax,0x368(%rbp)
   140003bc7:	48 8b 95 b8 03 00 00 	mov    0x3b8(%rbp),%rdx
   140003bce:	48 8b 85 68 03 00 00 	mov    0x368(%rbp),%rax
   140003bd5:	4c 8d 05 fc f8 00 00 	lea    0xf8fc(%rip),%r8        # 1400134d8 <.rdata+0x488>
   140003bdc:	48 89 c1             	mov    %rax,%rcx
   140003bdf:	e8 f0 e8 ff ff       	call   1400024d4 <type_struct__add>
   140003be4:	48 8d 05 ef f8 00 00 	lea    0xf8ef(%rip),%rax        # 1400134da <.rdata+0x48a>
   140003beb:	48 89 c1             	mov    %rax,%rcx
   140003bee:	e8 88 e8 ff ff       	call   14000247b <type_struct__create>
   140003bf3:	48 89 85 60 03 00 00 	mov    %rax,0x360(%rbp)
   140003bfa:	48 8b 95 b8 03 00 00 	mov    0x3b8(%rbp),%rdx
   140003c01:	48 8b 85 60 03 00 00 	mov    0x360(%rbp),%rax
   140003c08:	4c 8d 05 c9 f8 00 00 	lea    0xf8c9(%rip),%r8        # 1400134d8 <.rdata+0x488>
   140003c0f:	48 89 c1             	mov    %rax,%rcx
   140003c12:	e8 bd e8 ff ff       	call   1400024d4 <type_struct__add>
   140003c17:	48 8b 95 a8 03 00 00 	mov    0x3a8(%rbp),%rdx
   140003c1e:	48 8b 85 60 03 00 00 	mov    0x360(%rbp),%rax
   140003c25:	4c 8d 05 b0 f8 00 00 	lea    0xf8b0(%rip),%r8        # 1400134dc <.rdata+0x48c>
   140003c2c:	48 89 c1             	mov    %rax,%rcx
   140003c2f:	e8 a0 e8 ff ff       	call   1400024d4 <type_struct__add>
   140003c34:	48 8d 05 a4 f8 00 00 	lea    0xf8a4(%rip),%rax        # 1400134df <.rdata+0x48f>
   140003c3b:	48 89 c1             	mov    %rax,%rcx
   140003c3e:	e8 38 e8 ff ff       	call   14000247b <type_struct__create>
   140003c43:	48 89 85 58 03 00 00 	mov    %rax,0x358(%rbp)
   140003c4a:	4c 8b 85 b8 03 00 00 	mov    0x3b8(%rbp),%r8
   140003c51:	48 8b 95 a8 03 00 00 	mov    0x3a8(%rbp),%rdx
   140003c58:	48 8b 85 58 03 00 00 	mov    0x358(%rbp),%rax
   140003c5f:	48 c7 44 24 28 00 00 	movq   $0x0,0x28(%rsp)
   140003c66:	00 00 
   140003c68:	48 8d 0d 6d f8 00 00 	lea    0xf86d(%rip),%rcx        # 1400134dc <.rdata+0x48c>
   140003c6f:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   140003c74:	4d 89 c1             	mov    %r8,%r9
   140003c77:	4c 8d 05 5a f8 00 00 	lea    0xf85a(%rip),%r8        # 1400134d8 <.rdata+0x488>
   140003c7e:	48 89 c1             	mov    %rax,%rcx
   140003c81:	e8 f3 f8 ff ff       	call   140003579 <_type_struct__add_multiple>
   140003c86:	48 8b 85 b8 03 00 00 	mov    0x3b8(%rbp),%rax
   140003c8d:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   140003c93:	48 89 c2             	mov    %rax,%rdx
   140003c96:	48 8d 05 44 f8 00 00 	lea    0xf844(%rip),%rax        # 1400134e1 <.rdata+0x491>
   140003c9d:	48 89 c1             	mov    %rax,%rcx
   140003ca0:	e8 82 eb ff ff       	call   140002827 <type_array__create>
   140003ca5:	48 89 85 50 03 00 00 	mov    %rax,0x350(%rbp)
   140003cac:	48 8d 05 30 f8 00 00 	lea    0xf830(%rip),%rax        # 1400134e3 <.rdata+0x493>
   140003cb3:	48 89 c1             	mov    %rax,%rcx
   140003cb6:	e8 96 e9 ff ff       	call   140002651 <type_union__create>
   140003cbb:	48 89 85 48 03 00 00 	mov    %rax,0x348(%rbp)
   140003cc2:	4c 8b 85 b8 03 00 00 	mov    0x3b8(%rbp),%r8
   140003cc9:	48 8b 95 a8 03 00 00 	mov    0x3a8(%rbp),%rdx
   140003cd0:	48 8b 85 48 03 00 00 	mov    0x348(%rbp),%rax
   140003cd7:	48 c7 44 24 38 00 00 	movq   $0x0,0x38(%rsp)
   140003cde:	00 00 
   140003ce0:	48 8d 0d fe f7 00 00 	lea    0xf7fe(%rip),%rcx        # 1400134e5 <.rdata+0x495>
   140003ce7:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
   140003cec:	48 8b 8d a0 03 00 00 	mov    0x3a0(%rbp),%rcx
   140003cf3:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
   140003cf8:	48 8d 0d dd f7 00 00 	lea    0xf7dd(%rip),%rcx        # 1400134dc <.rdata+0x48c>
   140003cff:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   140003d04:	4d 89 c1             	mov    %r8,%r9
   140003d07:	4c 8d 05 ca f7 00 00 	lea    0xf7ca(%rip),%r8        # 1400134d8 <.rdata+0x488>
   140003d0e:	48 89 c1             	mov    %rax,%rcx
   140003d11:	e8 76 f9 ff ff       	call   14000368c <_type_union__add_multiple>
   140003d16:	48 8b 85 48 03 00 00 	mov    0x348(%rbp),%rax
   140003d1d:	48 89 c2             	mov    %rax,%rdx
   140003d20:	48 8d 05 c2 f7 00 00 	lea    0xf7c2(%rip),%rax        # 1400134e9 <.rdata+0x499>
   140003d27:	48 89 c1             	mov    %rax,%rcx
   140003d2a:	e8 c1 eb ff ff       	call   1400028f0 <type_pointer__create>
   140003d2f:	48 89 85 40 03 00 00 	mov    %rax,0x340(%rbp)
   140003d36:	48 8d 05 ae f7 00 00 	lea    0xf7ae(%rip),%rax        # 1400134eb <.rdata+0x49b>
   140003d3d:	48 89 c1             	mov    %rax,%rcx
   140003d40:	e8 36 e7 ff ff       	call   14000247b <type_struct__create>
   140003d45:	48 89 85 38 03 00 00 	mov    %rax,0x338(%rbp)
   140003d4c:	4c 8b 85 78 03 00 00 	mov    0x378(%rbp),%r8
   140003d53:	48 8b 95 40 03 00 00 	mov    0x340(%rbp),%rdx
   140003d5a:	48 8b 85 38 03 00 00 	mov    0x338(%rbp),%rax
   140003d61:	48 c7 44 24 48 00 00 	movq   $0x0,0x48(%rsp)
   140003d68:	00 00 
   140003d6a:	48 8d 0d 7c f7 00 00 	lea    0xf77c(%rip),%rcx        # 1400134ed <.rdata+0x49d>
   140003d71:	48 89 4c 24 40       	mov    %rcx,0x40(%rsp)
   140003d76:	48 8b 8d 58 03 00 00 	mov    0x358(%rbp),%rcx
   140003d7d:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
   140003d82:	48 8d 0d 5c f7 00 00 	lea    0xf75c(%rip),%rcx        # 1400134e5 <.rdata+0x495>
   140003d89:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
   140003d8e:	48 8b 8d 48 03 00 00 	mov    0x348(%rbp),%rcx
   140003d95:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
   140003d9a:	48 8d 0d 3b f7 00 00 	lea    0xf73b(%rip),%rcx        # 1400134dc <.rdata+0x48c>
   140003da1:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   140003da6:	4d 89 c1             	mov    %r8,%r9
   140003da9:	4c 8d 05 28 f7 00 00 	lea    0xf728(%rip),%r8        # 1400134d8 <.rdata+0x488>
   140003db0:	48 89 c1             	mov    %rax,%rcx
   140003db3:	e8 c1 f7 ff ff       	call   140003579 <_type_struct__add_multiple>
   140003db8:	48 8b 85 48 03 00 00 	mov    0x348(%rbp),%rax
   140003dbf:	41 b8 25 00 00 00    	mov    $0x25,%r8d
   140003dc5:	48 89 c2             	mov    %rax,%rdx
   140003dc8:	48 8d 05 23 f7 00 00 	lea    0xf723(%rip),%rax        # 1400134f2 <.rdata+0x4a2>
   140003dcf:	48 89 c1             	mov    %rax,%rcx
   140003dd2:	e8 50 ea ff ff       	call   140002827 <type_array__create>
   140003dd7:	48 89 85 30 03 00 00 	mov    %rax,0x330(%rbp)
   140003dde:	48 8d 05 0f f7 00 00 	lea    0xf70f(%rip),%rax        # 1400134f4 <.rdata+0x4a4>
   140003de5:	48 89 c1             	mov    %rax,%rcx
   140003de8:	e8 64 e8 ff ff       	call   140002651 <type_union__create>
   140003ded:	48 89 85 28 03 00 00 	mov    %rax,0x328(%rbp)
   140003df4:	4c 8b 85 40 03 00 00 	mov    0x340(%rbp),%r8
   140003dfb:	48 8b 95 30 03 00 00 	mov    0x330(%rbp),%rdx
   140003e02:	48 8b 85 28 03 00 00 	mov    0x328(%rbp),%rax
   140003e09:	48 c7 44 24 28 00 00 	movq   $0x0,0x28(%rsp)
   140003e10:	00 00 
   140003e12:	48 8d 0d c3 f6 00 00 	lea    0xf6c3(%rip),%rcx        # 1400134dc <.rdata+0x48c>
   140003e19:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   140003e1e:	4d 89 c1             	mov    %r8,%r9
   140003e21:	4c 8d 05 b0 f6 00 00 	lea    0xf6b0(%rip),%r8        # 1400134d8 <.rdata+0x488>
   140003e28:	48 89 c1             	mov    %rax,%rcx
   140003e2b:	e8 5c f8 ff ff       	call   14000368c <_type_union__add_multiple>
   140003e30:	48 8d 05 bf f6 00 00 	lea    0xf6bf(%rip),%rax        # 1400134f6 <.rdata+0x4a6>
   140003e37:	48 89 c1             	mov    %rax,%rcx
   140003e3a:	e8 3c e6 ff ff       	call   14000247b <type_struct__create>
   140003e3f:	48 89 85 20 03 00 00 	mov    %rax,0x320(%rbp)
   140003e46:	4c 8b 85 b8 03 00 00 	mov    0x3b8(%rbp),%r8
   140003e4d:	48 8b 95 a8 03 00 00 	mov    0x3a8(%rbp),%rdx
   140003e54:	48 8b 85 20 03 00 00 	mov    0x320(%rbp),%rax
   140003e5b:	48 c7 44 24 28 00 00 	movq   $0x0,0x28(%rsp)
   140003e62:	00 00 
   140003e64:	48 8d 0d 71 f6 00 00 	lea    0xf671(%rip),%rcx        # 1400134dc <.rdata+0x48c>
   140003e6b:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   140003e70:	4d 89 c1             	mov    %r8,%r9
   140003e73:	4c 8d 05 5e f6 00 00 	lea    0xf65e(%rip),%r8        # 1400134d8 <.rdata+0x488>
   140003e7a:	48 89 c1             	mov    %rax,%rcx
   140003e7d:	e8 f7 f6 ff ff       	call   140003579 <_type_struct__add_multiple>
   140003e82:	48 8b 85 20 03 00 00 	mov    0x320(%rbp),%rax
   140003e89:	ba 01 00 00 00       	mov    $0x1,%edx
   140003e8e:	48 89 c1             	mov    %rax,%rcx
   140003e91:	e8 ee e0 ff ff       	call   140001f84 <type__set_max_alignment>
   140003e96:	48 8d 05 5b f6 00 00 	lea    0xf65b(%rip),%rax        # 1400134f8 <.rdata+0x4a8>
   140003e9d:	48 89 c1             	mov    %rax,%rcx
   140003ea0:	e8 d6 e5 ff ff       	call   14000247b <type_struct__create>
   140003ea5:	48 89 85 18 03 00 00 	mov    %rax,0x318(%rbp)
   140003eac:	4c 8b 85 28 03 00 00 	mov    0x328(%rbp),%r8
   140003eb3:	48 8b 95 20 03 00 00 	mov    0x320(%rbp),%rdx
   140003eba:	48 8b 85 18 03 00 00 	mov    0x318(%rbp),%rax
   140003ec1:	48 c7 44 24 28 00 00 	movq   $0x0,0x28(%rsp)
   140003ec8:	00 00 
   140003eca:	48 8d 0d 0b f6 00 00 	lea    0xf60b(%rip),%rcx        # 1400134dc <.rdata+0x48c>
   140003ed1:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   140003ed6:	4d 89 c1             	mov    %r8,%r9
   140003ed9:	4c 8d 05 f8 f5 00 00 	lea    0xf5f8(%rip),%r8        # 1400134d8 <.rdata+0x488>
   140003ee0:	48 89 c1             	mov    %rax,%rcx
   140003ee3:	e8 91 f6 ff ff       	call   140003579 <_type_struct__add_multiple>
   140003ee8:	48 8b 85 18 03 00 00 	mov    0x318(%rbp),%rax
   140003eef:	ba 00 04 00 00       	mov    $0x400,%edx
   140003ef4:	48 89 c1             	mov    %rax,%rcx
   140003ef7:	e8 ed e1 ff ff       	call   1400020e9 <type__set_alignment>
   140003efc:	48 8d 05 f7 f5 00 00 	lea    0xf5f7(%rip),%rax        # 1400134fa <.rdata+0x4aa>
   140003f03:	48 89 c1             	mov    %rax,%rcx
   140003f06:	e8 70 e5 ff ff       	call   14000247b <type_struct__create>
   140003f0b:	48 89 85 10 03 00 00 	mov    %rax,0x310(%rbp)
   140003f12:	4c 8b 85 28 03 00 00 	mov    0x328(%rbp),%r8
   140003f19:	48 8b 95 18 03 00 00 	mov    0x318(%rbp),%rdx
   140003f20:	48 8b 85 10 03 00 00 	mov    0x310(%rbp),%rax
   140003f27:	48 c7 44 24 28 00 00 	movq   $0x0,0x28(%rsp)
   140003f2e:	00 00 
   140003f30:	48 8d 0d a5 f5 00 00 	lea    0xf5a5(%rip),%rcx        # 1400134dc <.rdata+0x48c>
   140003f37:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   140003f3c:	4d 89 c1             	mov    %r8,%r9
   140003f3f:	4c 8d 05 92 f5 00 00 	lea    0xf592(%rip),%r8        # 1400134d8 <.rdata+0x488>
   140003f46:	48 89 c1             	mov    %rax,%rcx
   140003f49:	e8 2b f6 ff ff       	call   140003579 <_type_struct__add_multiple>
   140003f4e:	48 8b 85 10 03 00 00 	mov    0x310(%rbp),%rax
   140003f55:	ba 01 00 00 00       	mov    $0x1,%edx
   140003f5a:	48 89 c1             	mov    %rax,%rcx
   140003f5d:	e8 22 e0 ff ff       	call   140001f84 <type__set_max_alignment>
   140003f62:	48 8d 05 93 f5 00 00 	lea    0xf593(%rip),%rax        # 1400134fc <.rdata+0x4ac>
   140003f69:	48 89 c1             	mov    %rax,%rcx
   140003f6c:	e8 0a e5 ff ff       	call   14000247b <type_struct__create>
   140003f71:	48 89 85 08 03 00 00 	mov    %rax,0x308(%rbp)
   140003f78:	4c 8b 85 20 03 00 00 	mov    0x320(%rbp),%r8
   140003f7f:	48 8b 95 b8 03 00 00 	mov    0x3b8(%rbp),%rdx
   140003f86:	48 8b 85 08 03 00 00 	mov    0x308(%rbp),%rax
   140003f8d:	48 c7 44 24 28 00 00 	movq   $0x0,0x28(%rsp)
   140003f94:	00 00 
   140003f96:	48 8d 0d 3f f5 00 00 	lea    0xf53f(%rip),%rcx        # 1400134dc <.rdata+0x48c>
   140003f9d:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   140003fa2:	4d 89 c1             	mov    %r8,%r9
   140003fa5:	4c 8d 05 2c f5 00 00 	lea    0xf52c(%rip),%r8        # 1400134d8 <.rdata+0x488>
   140003fac:	48 89 c1             	mov    %rax,%rcx
   140003faf:	e8 c5 f5 ff ff       	call   140003579 <_type_struct__add_multiple>
   140003fb4:	48 8b 85 b8 03 00 00 	mov    0x3b8(%rbp),%rax
   140003fbb:	41 b8 49 00 00 00    	mov    $0x49,%r8d
   140003fc1:	48 89 c2             	mov    %rax,%rdx
   140003fc4:	48 8d 05 33 f5 00 00 	lea    0xf533(%rip),%rax        # 1400134fe <.rdata+0x4ae>
   140003fcb:	48 89 c1             	mov    %rax,%rcx
   140003fce:	e8 54 e8 ff ff       	call   140002827 <type_array__create>
   140003fd3:	48 89 85 00 03 00 00 	mov    %rax,0x300(%rbp)
   140003fda:	48 8d 05 1f f5 00 00 	lea    0xf51f(%rip),%rax        # 140013500 <.rdata+0x4b0>
   140003fe1:	48 89 c1             	mov    %rax,%rcx
   140003fe4:	e8 92 e4 ff ff       	call   14000247b <type_struct__create>
   140003fe9:	48 89 85 f8 02 00 00 	mov    %rax,0x2f8(%rbp)
   140003ff0:	48 8b 95 00 03 00 00 	mov    0x300(%rbp),%rdx
   140003ff7:	48 8b 85 f8 02 00 00 	mov    0x2f8(%rbp),%rax
   140003ffe:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140004004:	4c 8d 05 cd f4 00 00 	lea    0xf4cd(%rip),%r8        # 1400134d8 <.rdata+0x488>
   14000400b:	48 89 c1             	mov    %rax,%rcx
   14000400e:	e8 66 f5 ff ff       	call   140003579 <_type_struct__add_multiple>
   140004013:	48 8d 05 e8 f4 00 00 	lea    0xf4e8(%rip),%rax        # 140013502 <.rdata+0x4b2>
   14000401a:	48 89 c1             	mov    %rax,%rcx
   14000401d:	e8 59 e4 ff ff       	call   14000247b <type_struct__create>
   140004022:	48 89 85 f0 02 00 00 	mov    %rax,0x2f0(%rbp)
   140004029:	4c 8b 85 20 03 00 00 	mov    0x320(%rbp),%r8
   140004030:	48 8b 95 f8 02 00 00 	mov    0x2f8(%rbp),%rdx
   140004037:	48 8b 85 f0 02 00 00 	mov    0x2f0(%rbp),%rax
   14000403e:	48 c7 44 24 38 00 00 	movq   $0x0,0x38(%rsp)
   140004045:	00 00 
   140004047:	48 8d 0d 97 f4 00 00 	lea    0xf497(%rip),%rcx        # 1400134e5 <.rdata+0x495>
   14000404e:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
   140004053:	48 8b 8d 08 03 00 00 	mov    0x308(%rbp),%rcx
   14000405a:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
   14000405f:	48 8d 0d 76 f4 00 00 	lea    0xf476(%rip),%rcx        # 1400134dc <.rdata+0x48c>
   140004066:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   14000406b:	4d 89 c1             	mov    %r8,%r9
   14000406e:	4c 8d 05 63 f4 00 00 	lea    0xf463(%rip),%r8        # 1400134d8 <.rdata+0x488>
   140004075:	48 89 c1             	mov    %rax,%rcx
   140004078:	e8 fc f4 ff ff       	call   140003579 <_type_struct__add_multiple>
   14000407d:	48 8b 85 f0 02 00 00 	mov    0x2f0(%rbp),%rax
   140004084:	41 b8 0d 00 00 00    	mov    $0xd,%r8d
   14000408a:	48 89 c2             	mov    %rax,%rdx
   14000408d:	48 8d 05 70 f4 00 00 	lea    0xf470(%rip),%rax        # 140013504 <.rdata+0x4b4>
   140004094:	48 89 c1             	mov    %rax,%rcx
   140004097:	e8 8b e7 ff ff       	call   140002827 <type_array__create>
   14000409c:	48 89 85 e8 02 00 00 	mov    %rax,0x2e8(%rbp)
   1400040a3:	48 8d 05 5c f4 00 00 	lea    0xf45c(%rip),%rax        # 140013506 <.rdata+0x4b6>
   1400040aa:	48 89 c1             	mov    %rax,%rcx
   1400040ad:	e8 c9 e3 ff ff       	call   14000247b <type_struct__create>
   1400040b2:	48 89 85 e0 02 00 00 	mov    %rax,0x2e0(%rbp)
   1400040b9:	4c 8b 85 e8 02 00 00 	mov    0x2e8(%rbp),%r8
   1400040c0:	48 8b 95 b8 03 00 00 	mov    0x3b8(%rbp),%rdx
   1400040c7:	48 8b 85 e0 02 00 00 	mov    0x2e0(%rbp),%rax
   1400040ce:	48 c7 44 24 58 00 00 	movq   $0x0,0x58(%rsp)
   1400040d5:	00 00 
   1400040d7:	48 8d 0d 2a f4 00 00 	lea    0xf42a(%rip),%rcx        # 140013508 <.rdata+0x4b8>
   1400040de:	48 89 4c 24 50       	mov    %rcx,0x50(%rsp)
   1400040e3:	48 8b 8d f8 02 00 00 	mov    0x2f8(%rbp),%rcx
   1400040ea:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
   1400040ef:	48 8d 0d f7 f3 00 00 	lea    0xf3f7(%rip),%rcx        # 1400134ed <.rdata+0x49d>
   1400040f6:	48 89 4c 24 40       	mov    %rcx,0x40(%rsp)
   1400040fb:	48 8b 8d f0 02 00 00 	mov    0x2f0(%rbp),%rcx
   140004102:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
   140004107:	48 8d 0d d7 f3 00 00 	lea    0xf3d7(%rip),%rcx        # 1400134e5 <.rdata+0x495>
   14000410e:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
   140004113:	48 8b 8d a8 03 00 00 	mov    0x3a8(%rbp),%rcx
   14000411a:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
   14000411f:	48 8d 0d b6 f3 00 00 	lea    0xf3b6(%rip),%rcx        # 1400134dc <.rdata+0x48c>
   140004126:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   14000412b:	4d 89 c1             	mov    %r8,%r9
   14000412e:	4c 8d 05 a3 f3 00 00 	lea    0xf3a3(%rip),%r8        # 1400134d8 <.rdata+0x488>
   140004135:	48 89 c1             	mov    %rax,%rcx
   140004138:	e8 3c f4 ff ff       	call   140003579 <_type_struct__add_multiple>
   14000413d:	48 8b 85 f0 02 00 00 	mov    0x2f0(%rbp),%rax
   140004144:	41 b8 27 00 00 00    	mov    $0x27,%r8d
   14000414a:	48 89 c2             	mov    %rax,%rdx
   14000414d:	48 8d 05 ba f3 00 00 	lea    0xf3ba(%rip),%rax        # 14001350e <.rdata+0x4be>
   140004154:	48 89 c1             	mov    %rax,%rcx
   140004157:	e8 cb e6 ff ff       	call   140002827 <type_array__create>
   14000415c:	48 89 85 d8 02 00 00 	mov    %rax,0x2d8(%rbp)
   140004163:	48 8b 85 b8 03 00 00 	mov    0x3b8(%rbp),%rax
   14000416a:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   140004170:	48 89 c2             	mov    %rax,%rdx
   140004173:	48 8d 05 96 f3 00 00 	lea    0xf396(%rip),%rax        # 140013510 <.rdata+0x4c0>
   14000417a:	48 89 c1             	mov    %rax,%rcx
   14000417d:	e8 a5 e6 ff ff       	call   140002827 <type_array__create>
   140004182:	48 89 85 d0 02 00 00 	mov    %rax,0x2d0(%rbp)
   140004189:	48 8b 85 d0 02 00 00 	mov    0x2d0(%rbp),%rax
   140004190:	41 b8 27 00 00 00    	mov    $0x27,%r8d
   140004196:	48 89 c2             	mov    %rax,%rdx
   140004199:	48 8d 05 72 f3 00 00 	lea    0xf372(%rip),%rax        # 140013512 <.rdata+0x4c2>
   1400041a0:	48 89 c1             	mov    %rax,%rcx
   1400041a3:	e8 7f e6 ff ff       	call   140002827 <type_array__create>
   1400041a8:	48 89 85 c8 02 00 00 	mov    %rax,0x2c8(%rbp)
   1400041af:	48 8d 05 5e f3 00 00 	lea    0xf35e(%rip),%rax        # 140013514 <.rdata+0x4c4>
   1400041b6:	48 89 c1             	mov    %rax,%rcx
   1400041b9:	e8 bd e2 ff ff       	call   14000247b <type_struct__create>
   1400041be:	48 89 85 c0 02 00 00 	mov    %rax,0x2c0(%rbp)
   1400041c5:	4c 8b 85 c8 02 00 00 	mov    0x2c8(%rbp),%r8
   1400041cc:	48 8b 95 d8 02 00 00 	mov    0x2d8(%rbp),%rdx
   1400041d3:	48 8b 85 c0 02 00 00 	mov    0x2c0(%rbp),%rax
   1400041da:	48 c7 44 24 28 00 00 	movq   $0x0,0x28(%rsp)
   1400041e1:	00 00 
   1400041e3:	48 8d 0d fb f2 00 00 	lea    0xf2fb(%rip),%rcx        # 1400134e5 <.rdata+0x495>
   1400041ea:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   1400041ef:	4d 89 c1             	mov    %r8,%r9
   1400041f2:	4c 8d 05 e3 f2 00 00 	lea    0xf2e3(%rip),%r8        # 1400134dc <.rdata+0x48c>
   1400041f9:	48 89 c1             	mov    %rax,%rcx
   1400041fc:	e8 78 f3 ff ff       	call   140003579 <_type_struct__add_multiple>
   140004201:	48 8b 85 e0 02 00 00 	mov    0x2e0(%rbp),%rax
   140004208:	41 b8 49 00 00 00    	mov    $0x49,%r8d
   14000420e:	48 89 c2             	mov    %rax,%rdx
   140004211:	48 8d 05 fe f2 00 00 	lea    0xf2fe(%rip),%rax        # 140013516 <.rdata+0x4c6>
   140004218:	48 89 c1             	mov    %rax,%rcx
   14000421b:	e8 07 e6 ff ff       	call   140002827 <type_array__create>
   140004220:	48 89 85 b8 02 00 00 	mov    %rax,0x2b8(%rbp)
   140004227:	48 8d 05 ea f2 00 00 	lea    0xf2ea(%rip),%rax        # 140013518 <.rdata+0x4c8>
   14000422e:	48 89 c1             	mov    %rax,%rcx
   140004231:	e8 45 e2 ff ff       	call   14000247b <type_struct__create>
   140004236:	48 89 85 b0 02 00 00 	mov    %rax,0x2b0(%rbp)
   14000423d:	4c 8b 85 b0 03 00 00 	mov    0x3b0(%rbp),%r8
   140004244:	48 8b 95 d0 02 00 00 	mov    0x2d0(%rbp),%rdx
   14000424b:	48 8b 85 b0 02 00 00 	mov    0x2b0(%rbp),%rax
   140004252:	48 c7 44 24 28 00 00 	movq   $0x0,0x28(%rsp)
   140004259:	00 00 
   14000425b:	48 8d 0d 83 f2 00 00 	lea    0xf283(%rip),%rcx        # 1400134e5 <.rdata+0x495>
   140004262:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   140004267:	4d 89 c1             	mov    %r8,%r9
   14000426a:	4c 8d 05 6b f2 00 00 	lea    0xf26b(%rip),%r8        # 1400134dc <.rdata+0x48c>
   140004271:	48 89 c1             	mov    %rax,%rcx
   140004274:	e8 00 f3 ff ff       	call   140003579 <_type_struct__add_multiple>
   140004279:	48 8b 85 b0 02 00 00 	mov    0x2b0(%rbp),%rax
   140004280:	41 b8 27 00 00 00    	mov    $0x27,%r8d
   140004286:	48 89 c2             	mov    %rax,%rdx
   140004289:	48 8d 05 8a f2 00 00 	lea    0xf28a(%rip),%rax        # 14001351a <.rdata+0x4ca>
   140004290:	48 89 c1             	mov    %rax,%rcx
   140004293:	e8 8f e5 ff ff       	call   140002827 <type_array__create>
   140004298:	48 89 85 a8 02 00 00 	mov    %rax,0x2a8(%rbp)
   14000429f:	48 8d 05 76 f2 00 00 	lea    0xf276(%rip),%rax        # 14001351c <.rdata+0x4cc>
   1400042a6:	48 89 c1             	mov    %rax,%rcx
   1400042a9:	e8 cd e1 ff ff       	call   14000247b <type_struct__create>
   1400042ae:	48 89 85 a0 02 00 00 	mov    %rax,0x2a0(%rbp)
   1400042b5:	4c 8b 85 e0 02 00 00 	mov    0x2e0(%rbp),%r8
   1400042bc:	48 8b 95 c0 02 00 00 	mov    0x2c0(%rbp),%rdx
   1400042c3:	48 8b 85 a0 02 00 00 	mov    0x2a0(%rbp),%rax
   1400042ca:	48 c7 44 24 38 00 00 	movq   $0x0,0x38(%rsp)
   1400042d1:	00 00 
   1400042d3:	48 8d 0d 13 f2 00 00 	lea    0xf213(%rip),%rcx        # 1400134ed <.rdata+0x49d>
   1400042da:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
   1400042df:	48 8b 8d a8 02 00 00 	mov    0x2a8(%rbp),%rcx
   1400042e6:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
   1400042eb:	48 8d 0d f3 f1 00 00 	lea    0xf1f3(%rip),%rcx        # 1400134e5 <.rdata+0x495>
   1400042f2:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   1400042f7:	4d 89 c1             	mov    %r8,%r9
   1400042fa:	4c 8d 05 db f1 00 00 	lea    0xf1db(%rip),%r8        # 1400134dc <.rdata+0x48c>
   140004301:	48 89 c1             	mov    %rax,%rcx
   140004304:	e8 70 f2 ff ff       	call   140003579 <_type_struct__add_multiple>
   140004309:	48 8d 05 0e f2 00 00 	lea    0xf20e(%rip),%rax        # 14001351e <.rdata+0x4ce>
   140004310:	48 89 c1             	mov    %rax,%rcx
   140004313:	e8 39 e3 ff ff       	call   140002651 <type_union__create>
   140004318:	48 89 85 98 02 00 00 	mov    %rax,0x298(%rbp)
   14000431f:	4c 8b 85 70 03 00 00 	mov    0x370(%rbp),%r8
   140004326:	48 8b 95 a8 03 00 00 	mov    0x3a8(%rbp),%rdx
   14000432d:	48 8b 85 98 02 00 00 	mov    0x298(%rbp),%rax
   140004334:	48 c7 44 24 38 00 00 	movq   $0x0,0x38(%rsp)
   14000433b:	00 00 
   14000433d:	48 8d 0d a9 f1 00 00 	lea    0xf1a9(%rip),%rcx        # 1400134ed <.rdata+0x49d>
   140004344:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
   140004349:	48 8b 8d a0 02 00 00 	mov    0x2a0(%rbp),%rcx
   140004350:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
   140004355:	48 8d 0d 89 f1 00 00 	lea    0xf189(%rip),%rcx        # 1400134e5 <.rdata+0x495>
   14000435c:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   140004361:	4d 89 c1             	mov    %r8,%r9
   140004364:	4c 8d 05 71 f1 00 00 	lea    0xf171(%rip),%r8        # 1400134dc <.rdata+0x48c>
   14000436b:	48 89 c1             	mov    %rax,%rcx
   14000436e:	e8 19 f3 ff ff       	call   14000368c <_type_union__add_multiple>
   140004373:	48 8d 05 a6 f1 00 00 	lea    0xf1a6(%rip),%rax        # 140013520 <.rdata+0x4d0>
   14000437a:	48 89 c1             	mov    %rax,%rcx
   14000437d:	e8 f9 e0 ff ff       	call   14000247b <type_struct__create>
   140004382:	48 89 85 90 02 00 00 	mov    %rax,0x290(%rbp)
   140004389:	48 8b 95 98 02 00 00 	mov    0x298(%rbp),%rdx
   140004390:	48 8b 85 90 02 00 00 	mov    0x290(%rbp),%rax
   140004397:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000439d:	4c 8d 05 34 f1 00 00 	lea    0xf134(%rip),%r8        # 1400134d8 <.rdata+0x488>
   1400043a4:	48 89 c1             	mov    %rax,%rcx
   1400043a7:	e8 cd f1 ff ff       	call   140003579 <_type_struct__add_multiple>
   1400043ac:	48 8d 05 6f f1 00 00 	lea    0xf16f(%rip),%rax        # 140013522 <.rdata+0x4d2>
   1400043b3:	48 89 c1             	mov    %rax,%rcx
   1400043b6:	e8 c0 e0 ff ff       	call   14000247b <type_struct__create>
   1400043bb:	48 89 85 88 02 00 00 	mov    %rax,0x288(%rbp)
   1400043c2:	4c 8b 85 20 03 00 00 	mov    0x320(%rbp),%r8
   1400043c9:	48 8b 95 f8 02 00 00 	mov    0x2f8(%rbp),%rdx
   1400043d0:	48 8b 85 88 02 00 00 	mov    0x288(%rbp),%rax
   1400043d7:	48 c7 44 24 38 00 00 	movq   $0x0,0x38(%rsp)
   1400043de:	00 00 
   1400043e0:	48 8d 0d fe f0 00 00 	lea    0xf0fe(%rip),%rcx        # 1400134e5 <.rdata+0x495>
   1400043e7:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
   1400043ec:	48 8b 8d e0 02 00 00 	mov    0x2e0(%rbp),%rcx
   1400043f3:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
   1400043f8:	48 8d 0d dd f0 00 00 	lea    0xf0dd(%rip),%rcx        # 1400134dc <.rdata+0x48c>
   1400043ff:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   140004404:	4d 89 c1             	mov    %r8,%r9
   140004407:	4c 8d 05 ca f0 00 00 	lea    0xf0ca(%rip),%r8        # 1400134d8 <.rdata+0x488>
   14000440e:	48 89 c1             	mov    %rax,%rcx
   140004411:	e8 63 f1 ff ff       	call   140003579 <_type_struct__add_multiple>
   140004416:	48 8d 05 07 f1 00 00 	lea    0xf107(%rip),%rax        # 140013524 <.rdata+0x4d4>
   14000441d:	48 89 c1             	mov    %rax,%rcx
   140004420:	e8 2c e2 ff ff       	call   140002651 <type_union__create>
   140004425:	48 89 85 80 02 00 00 	mov    %rax,0x280(%rbp)
   14000442c:	4c 8b 85 88 02 00 00 	mov    0x288(%rbp),%r8
   140004433:	48 8b 95 08 03 00 00 	mov    0x308(%rbp),%rdx
   14000443a:	48 8b 85 80 02 00 00 	mov    0x280(%rbp),%rax
   140004441:	48 c7 44 24 58 00 00 	movq   $0x0,0x58(%rsp)
   140004448:	00 00 
   14000444a:	48 8d 0d b7 f0 00 00 	lea    0xf0b7(%rip),%rcx        # 140013508 <.rdata+0x4b8>
   140004451:	48 89 4c 24 50       	mov    %rcx,0x50(%rsp)
   140004456:	48 8b 8d a0 02 00 00 	mov    0x2a0(%rbp),%rcx
   14000445d:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
   140004462:	48 8d 0d 84 f0 00 00 	lea    0xf084(%rip),%rcx        # 1400134ed <.rdata+0x49d>
   140004469:	48 89 4c 24 40       	mov    %rcx,0x40(%rsp)
   14000446e:	48 8b 8d e0 02 00 00 	mov    0x2e0(%rbp),%rcx
   140004475:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
   14000447a:	48 8d 0d 64 f0 00 00 	lea    0xf064(%rip),%rcx        # 1400134e5 <.rdata+0x495>
   140004481:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
   140004486:	48 8b 8d f0 02 00 00 	mov    0x2f0(%rbp),%rcx
   14000448d:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
   140004492:	48 8d 0d 43 f0 00 00 	lea    0xf043(%rip),%rcx        # 1400134dc <.rdata+0x48c>
   140004499:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   14000449e:	4d 89 c1             	mov    %r8,%r9
   1400044a1:	4c 8d 05 30 f0 00 00 	lea    0xf030(%rip),%r8        # 1400134d8 <.rdata+0x488>
   1400044a8:	48 89 c1             	mov    %rax,%rcx
   1400044ab:	e8 dc f1 ff ff       	call   14000368c <_type_union__add_multiple>
   1400044b0:	48 8d 05 6f f0 00 00 	lea    0xf06f(%rip),%rax        # 140013526 <.rdata+0x4d6>
   1400044b7:	48 89 c1             	mov    %rax,%rcx
   1400044ba:	e8 bc df ff ff       	call   14000247b <type_struct__create>
   1400044bf:	48 89 85 78 02 00 00 	mov    %rax,0x278(%rbp)
   1400044c6:	4c 8b 85 f8 02 00 00 	mov    0x2f8(%rbp),%r8
   1400044cd:	48 8b 95 80 02 00 00 	mov    0x280(%rbp),%rdx
   1400044d4:	48 8b 85 78 02 00 00 	mov    0x278(%rbp),%rax
   1400044db:	48 c7 44 24 58 00 00 	movq   $0x0,0x58(%rsp)
   1400044e2:	00 00 
   1400044e4:	48 8d 0d 02 f0 00 00 	lea    0xf002(%rip),%rcx        # 1400134ed <.rdata+0x49d>
   1400044eb:	48 89 4c 24 50       	mov    %rcx,0x50(%rsp)
   1400044f0:	48 8b 8d 90 02 00 00 	mov    0x290(%rbp),%rcx
   1400044f7:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
   1400044fc:	48 8d 0d ea ef 00 00 	lea    0xefea(%rip),%rcx        # 1400134ed <.rdata+0x49d>
   140004503:	48 89 4c 24 40       	mov    %rcx,0x40(%rsp)
   140004508:	48 8b 8d e0 02 00 00 	mov    0x2e0(%rbp),%rcx
   14000450f:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
   140004514:	48 8d 0d ca ef 00 00 	lea    0xefca(%rip),%rcx        # 1400134e5 <.rdata+0x495>
   14000451b:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
   140004520:	48 8b 8d f0 02 00 00 	mov    0x2f0(%rbp),%rcx
   140004527:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
   14000452c:	48 8d 0d a9 ef 00 00 	lea    0xefa9(%rip),%rcx        # 1400134dc <.rdata+0x48c>
   140004533:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   140004538:	4d 89 c1             	mov    %r8,%r9
   14000453b:	4c 8d 05 96 ef 00 00 	lea    0xef96(%rip),%r8        # 1400134d8 <.rdata+0x488>
   140004542:	48 89 c1             	mov    %rax,%rcx
   140004545:	e8 2f f0 ff ff       	call   140003579 <_type_struct__add_multiple>
   14000454a:	48 8b 85 f8 02 00 00 	mov    0x2f8(%rbp),%rax
   140004551:	41 b8 86 03 00 00    	mov    $0x386,%r8d
   140004557:	48 89 c2             	mov    %rax,%rdx
   14000455a:	48 8d 05 c7 ef 00 00 	lea    0xefc7(%rip),%rax        # 140013528 <.rdata+0x4d8>
   140004561:	48 89 c1             	mov    %rax,%rcx
   140004564:	e8 be e2 ff ff       	call   140002827 <type_array__create>
   140004569:	48 89 85 70 02 00 00 	mov    %rax,0x270(%rbp)
   140004570:	48 8d 05 b3 ef 00 00 	lea    0xefb3(%rip),%rax        # 14001352a <.rdata+0x4da>
   140004577:	48 89 c1             	mov    %rax,%rcx
   14000457a:	e8 d2 e0 ff ff       	call   140002651 <type_union__create>
   14000457f:	48 89 85 68 02 00 00 	mov    %rax,0x268(%rbp)
   140004586:	4c 8b 85 70 02 00 00 	mov    0x270(%rbp),%r8
   14000458d:	48 8b 95 20 03 00 00 	mov    0x320(%rbp),%rdx
   140004594:	48 8b 85 68 02 00 00 	mov    0x268(%rbp),%rax
   14000459b:	48 c7 44 24 38 00 00 	movq   $0x0,0x38(%rsp)
   1400045a2:	00 00 
   1400045a4:	48 8d 0d 3a ef 00 00 	lea    0xef3a(%rip),%rcx        # 1400134e5 <.rdata+0x495>
   1400045ab:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
   1400045b0:	48 8b 8d e0 02 00 00 	mov    0x2e0(%rbp),%rcx
   1400045b7:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
   1400045bc:	48 8d 0d 19 ef 00 00 	lea    0xef19(%rip),%rcx        # 1400134dc <.rdata+0x48c>
   1400045c3:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   1400045c8:	4d 89 c1             	mov    %r8,%r9
   1400045cb:	4c 8d 05 06 ef 00 00 	lea    0xef06(%rip),%r8        # 1400134d8 <.rdata+0x488>
   1400045d2:	48 89 c1             	mov    %rax,%rcx
   1400045d5:	e8 b2 f0 ff ff       	call   14000368c <_type_union__add_multiple>
   1400045da:	48 8b 85 f0 02 00 00 	mov    0x2f0(%rbp),%rax
   1400045e1:	41 b8 27 00 00 00    	mov    $0x27,%r8d
   1400045e7:	48 89 c2             	mov    %rax,%rdx
   1400045ea:	48 8d 05 3b ef 00 00 	lea    0xef3b(%rip),%rax        # 14001352c <.rdata+0x4dc>
   1400045f1:	48 89 c1             	mov    %rax,%rcx
   1400045f4:	e8 2e e2 ff ff       	call   140002827 <type_array__create>
   1400045f9:	48 89 85 60 02 00 00 	mov    %rax,0x260(%rbp)
   140004600:	48 8d 05 27 ef 00 00 	lea    0xef27(%rip),%rax        # 14001352e <.rdata+0x4de>
   140004607:	48 89 c1             	mov    %rax,%rcx
   14000460a:	e8 6c de ff ff       	call   14000247b <type_struct__create>
   14000460f:	48 89 85 58 02 00 00 	mov    %rax,0x258(%rbp)
   140004616:	4c 8b 85 60 02 00 00 	mov    0x260(%rbp),%r8
   14000461d:	48 8b 95 78 02 00 00 	mov    0x278(%rbp),%rdx
   140004624:	48 8b 85 58 02 00 00 	mov    0x258(%rbp),%rax
   14000462b:	48 c7 44 24 38 00 00 	movq   $0x0,0x38(%rsp)
   140004632:	00 00 
   140004634:	48 8d 0d aa ee 00 00 	lea    0xeeaa(%rip),%rcx        # 1400134e5 <.rdata+0x495>
   14000463b:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
   140004640:	48 8b 8d 68 02 00 00 	mov    0x268(%rbp),%rcx
   140004647:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
   14000464c:	48 8d 0d 89 ee 00 00 	lea    0xee89(%rip),%rcx        # 1400134dc <.rdata+0x48c>
   140004653:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   140004658:	4d 89 c1             	mov    %r8,%r9
   14000465b:	4c 8d 05 76 ee 00 00 	lea    0xee76(%rip),%r8        # 1400134d8 <.rdata+0x488>
   140004662:	48 89 c1             	mov    %rax,%rcx
   140004665:	e8 0f ef ff ff       	call   140003579 <_type_struct__add_multiple>
   14000466a:	48 8b 85 68 02 00 00 	mov    0x268(%rbp),%rax
   140004671:	41 b8 20 00 00 00    	mov    $0x20,%r8d
   140004677:	48 89 c2             	mov    %rax,%rdx
   14000467a:	48 8d 05 af ee 00 00 	lea    0xeeaf(%rip),%rax        # 140013530 <.rdata+0x4e0>
   140004681:	48 89 c1             	mov    %rax,%rcx
   140004684:	e8 9e e1 ff ff       	call   140002827 <type_array__create>
   140004689:	48 89 85 50 02 00 00 	mov    %rax,0x250(%rbp)
   140004690:	48 8b 85 58 02 00 00 	mov    0x258(%rbp),%rax
   140004697:	41 b8 32 00 00 00    	mov    $0x32,%r8d
   14000469d:	48 89 c2             	mov    %rax,%rdx
   1400046a0:	48 8d 05 8c ee 00 00 	lea    0xee8c(%rip),%rax        # 140013533 <.rdata+0x4e3>
   1400046a7:	48 89 c1             	mov    %rax,%rcx
   1400046aa:	e8 78 e1 ff ff       	call   140002827 <type_array__create>
   1400046af:	48 89 85 48 02 00 00 	mov    %rax,0x248(%rbp)
   1400046b6:	48 8b 85 68 02 00 00 	mov    0x268(%rbp),%rax
   1400046bd:	41 b8 27 00 00 00    	mov    $0x27,%r8d
   1400046c3:	48 89 c2             	mov    %rax,%rdx
   1400046c6:	48 8d 05 69 ee 00 00 	lea    0xee69(%rip),%rax        # 140013536 <.rdata+0x4e6>
   1400046cd:	48 89 c1             	mov    %rax,%rcx
   1400046d0:	e8 52 e1 ff ff       	call   140002827 <type_array__create>
   1400046d5:	48 89 85 40 02 00 00 	mov    %rax,0x240(%rbp)
   1400046dc:	48 8d 05 56 ee 00 00 	lea    0xee56(%rip),%rax        # 140013539 <.rdata+0x4e9>
   1400046e3:	48 89 c1             	mov    %rax,%rcx
   1400046e6:	e8 66 df ff ff       	call   140002651 <type_union__create>
   1400046eb:	48 89 85 38 02 00 00 	mov    %rax,0x238(%rbp)
   1400046f2:	4c 8b 85 40 02 00 00 	mov    0x240(%rbp),%r8
   1400046f9:	48 8b 95 48 02 00 00 	mov    0x248(%rbp),%rdx
   140004700:	48 8b 85 38 02 00 00 	mov    0x238(%rbp),%rax
   140004707:	48 c7 44 24 28 00 00 	movq   $0x0,0x28(%rsp)
   14000470e:	00 00 
   140004710:	48 8d 0d c5 ed 00 00 	lea    0xedc5(%rip),%rcx        # 1400134dc <.rdata+0x48c>
   140004717:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   14000471c:	4d 89 c1             	mov    %r8,%r9
   14000471f:	4c 8d 05 b2 ed 00 00 	lea    0xedb2(%rip),%r8        # 1400134d8 <.rdata+0x488>
   140004726:	48 89 c1             	mov    %rax,%rcx
   140004729:	e8 5e ef ff ff       	call   14000368c <_type_union__add_multiple>
   14000472e:	48 8b 85 38 02 00 00 	mov    0x238(%rbp),%rax
   140004735:	ba 01 00 00 00       	mov    $0x1,%edx
   14000473a:	48 89 c1             	mov    %rax,%rcx
   14000473d:	e8 42 d8 ff ff       	call   140001f84 <type__set_max_alignment>
   140004742:	48 8d 05 f3 ed 00 00 	lea    0xedf3(%rip),%rax        # 14001353c <.rdata+0x4ec>
   140004749:	48 89 c1             	mov    %rax,%rcx
   14000474c:	e8 2a dd ff ff       	call   14000247b <type_struct__create>
   140004751:	48 89 85 30 02 00 00 	mov    %rax,0x230(%rbp)
   140004758:	4c 8b 85 38 02 00 00 	mov    0x238(%rbp),%r8
   14000475f:	48 8b 95 50 02 00 00 	mov    0x250(%rbp),%rdx
   140004766:	48 8b 85 30 02 00 00 	mov    0x230(%rbp),%rax
   14000476d:	48 c7 44 24 28 00 00 	movq   $0x0,0x28(%rsp)
   140004774:	00 00 
   140004776:	48 8d 0d 5f ed 00 00 	lea    0xed5f(%rip),%rcx        # 1400134dc <.rdata+0x48c>
   14000477d:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   140004782:	4d 89 c1             	mov    %r8,%r9
   140004785:	4c 8d 05 4c ed 00 00 	lea    0xed4c(%rip),%r8        # 1400134d8 <.rdata+0x488>
   14000478c:	48 89 c1             	mov    %rax,%rcx
   14000478f:	e8 e5 ed ff ff       	call   140003579 <_type_struct__add_multiple>
   140004794:	48 8b 85 30 02 00 00 	mov    0x230(%rbp),%rax
   14000479b:	ba 00 04 00 00       	mov    $0x400,%edx
   1400047a0:	48 89 c1             	mov    %rax,%rcx
   1400047a3:	e8 41 d9 ff ff       	call   1400020e9 <type__set_alignment>
   1400047a8:	4c 8d 0d f0 ef ff ff 	lea    -0x1010(%rip),%r9        # 14000379f <_type__print_value_s8>
   1400047af:	41 b8 01 00 00 00    	mov    $0x1,%r8d
   1400047b5:	48 8d 05 83 ed 00 00 	lea    0xed83(%rip),%rax        # 14001353f <.rdata+0x4ef>
   1400047bc:	48 89 c2             	mov    %rax,%rdx
   1400047bf:	48 8d 05 79 ed 00 00 	lea    0xed79(%rip),%rax        # 14001353f <.rdata+0x4ef>
   1400047c6:	48 89 c1             	mov    %rax,%rcx
   1400047c9:	e8 39 d7 ff ff       	call   140001f07 <type_atom__create>
   1400047ce:	48 89 85 28 02 00 00 	mov    %rax,0x228(%rbp)
   1400047d5:	48 8b 85 20 03 00 00 	mov    0x320(%rbp),%rax
   1400047dc:	41 b8 01 00 00 00    	mov    $0x1,%r8d
   1400047e2:	48 89 c2             	mov    %rax,%rdx
   1400047e5:	48 8d 05 56 ed 00 00 	lea    0xed56(%rip),%rax        # 140013542 <.rdata+0x4f2>
   1400047ec:	48 89 c1             	mov    %rax,%rcx
   1400047ef:	e8 33 e0 ff ff       	call   140002827 <type_array__create>
   1400047f4:	48 89 85 20 02 00 00 	mov    %rax,0x220(%rbp)
   1400047fb:	48 8b 85 08 03 00 00 	mov    0x308(%rbp),%rax
   140004802:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140004808:	48 89 c2             	mov    %rax,%rdx
   14000480b:	48 8d 05 33 ed 00 00 	lea    0xed33(%rip),%rax        # 140013545 <.rdata+0x4f5>
   140004812:	48 89 c1             	mov    %rax,%rcx
   140004815:	e8 0d e0 ff ff       	call   140002827 <type_array__create>
   14000481a:	48 89 85 18 02 00 00 	mov    %rax,0x218(%rbp)
   140004821:	48 8b 85 f8 02 00 00 	mov    0x2f8(%rbp),%rax
   140004828:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   14000482e:	48 89 c2             	mov    %rax,%rdx
   140004831:	48 8d 05 10 ed 00 00 	lea    0xed10(%rip),%rax        # 140013548 <.rdata+0x4f8>
   140004838:	48 89 c1             	mov    %rax,%rcx
   14000483b:	e8 e7 df ff ff       	call   140002827 <type_array__create>
   140004840:	48 89 85 10 02 00 00 	mov    %rax,0x210(%rbp)
   140004847:	48 8b 85 f0 02 00 00 	mov    0x2f0(%rbp),%rax
   14000484e:	41 b8 04 00 00 00    	mov    $0x4,%r8d
   140004854:	48 89 c2             	mov    %rax,%rdx
   140004857:	48 8d 05 ed ec 00 00 	lea    0xeced(%rip),%rax        # 14001354b <.rdata+0x4fb>
   14000485e:	48 89 c1             	mov    %rax,%rcx
   140004861:	e8 c1 df ff ff       	call   140002827 <type_array__create>
   140004866:	48 89 85 08 02 00 00 	mov    %rax,0x208(%rbp)
   14000486d:	48 8b 85 e0 02 00 00 	mov    0x2e0(%rbp),%rax
   140004874:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   14000487a:	48 89 c2             	mov    %rax,%rdx
   14000487d:	48 8d 05 ca ec 00 00 	lea    0xecca(%rip),%rax        # 14001354e <.rdata+0x4fe>
   140004884:	48 89 c1             	mov    %rax,%rcx
   140004887:	e8 9b df ff ff       	call   140002827 <type_array__create>
   14000488c:	48 89 85 00 02 00 00 	mov    %rax,0x200(%rbp)
   140004893:	48 8b 85 a0 02 00 00 	mov    0x2a0(%rbp),%rax
   14000489a:	41 b8 06 00 00 00    	mov    $0x6,%r8d
   1400048a0:	48 89 c2             	mov    %rax,%rdx
   1400048a3:	48 8d 05 a7 ec 00 00 	lea    0xeca7(%rip),%rax        # 140013551 <.rdata+0x501>
   1400048aa:	48 89 c1             	mov    %rax,%rcx
   1400048ad:	e8 75 df ff ff       	call   140002827 <type_array__create>
   1400048b2:	48 89 85 f8 01 00 00 	mov    %rax,0x1f8(%rbp)
   1400048b9:	48 8b 85 90 02 00 00 	mov    0x290(%rbp),%rax
   1400048c0:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   1400048c6:	48 89 c2             	mov    %rax,%rdx
   1400048c9:	48 8d 05 84 ec 00 00 	lea    0xec84(%rip),%rax        # 140013554 <.rdata+0x504>
   1400048d0:	48 89 c1             	mov    %rax,%rcx
   1400048d3:	e8 4f df ff ff       	call   140002827 <type_array__create>
   1400048d8:	48 89 85 f0 01 00 00 	mov    %rax,0x1f0(%rbp)
   1400048df:	48 8b 85 80 02 00 00 	mov    0x280(%rbp),%rax
   1400048e6:	41 b8 08 00 00 00    	mov    $0x8,%r8d
   1400048ec:	48 89 c2             	mov    %rax,%rdx
   1400048ef:	48 8d 05 61 ec 00 00 	lea    0xec61(%rip),%rax        # 140013557 <.rdata+0x507>
   1400048f6:	48 89 c1             	mov    %rax,%rcx
   1400048f9:	e8 29 df ff ff       	call   140002827 <type_array__create>
   1400048fe:	48 89 85 e8 01 00 00 	mov    %rax,0x1e8(%rbp)
   140004905:	48 8b 85 78 02 00 00 	mov    0x278(%rbp),%rax
   14000490c:	41 b8 09 00 00 00    	mov    $0x9,%r8d
   140004912:	48 89 c2             	mov    %rax,%rdx
   140004915:	48 8d 05 3e ec 00 00 	lea    0xec3e(%rip),%rax        # 14001355a <.rdata+0x50a>
   14000491c:	48 89 c1             	mov    %rax,%rcx
   14000491f:	e8 03 df ff ff       	call   140002827 <type_array__create>
   140004924:	48 89 85 e0 01 00 00 	mov    %rax,0x1e0(%rbp)
   14000492b:	48 8b 85 68 02 00 00 	mov    0x268(%rbp),%rax
   140004932:	41 b8 0a 00 00 00    	mov    $0xa,%r8d
   140004938:	48 89 c2             	mov    %rax,%rdx
   14000493b:	48 8d 05 1b ec 00 00 	lea    0xec1b(%rip),%rax        # 14001355d <.rdata+0x50d>
   140004942:	48 89 c1             	mov    %rax,%rcx
   140004945:	e8 dd de ff ff       	call   140002827 <type_array__create>
   14000494a:	48 89 85 d8 01 00 00 	mov    %rax,0x1d8(%rbp)
   140004951:	48 8b 85 58 02 00 00 	mov    0x258(%rbp),%rax
   140004958:	41 b8 0b 00 00 00    	mov    $0xb,%r8d
   14000495e:	48 89 c2             	mov    %rax,%rdx
   140004961:	48 8d 05 f8 eb 00 00 	lea    0xebf8(%rip),%rax        # 140013560 <.rdata+0x510>
   140004968:	48 89 c1             	mov    %rax,%rcx
   14000496b:	e8 b7 de ff ff       	call   140002827 <type_array__create>
   140004970:	48 89 85 d0 01 00 00 	mov    %rax,0x1d0(%rbp)
   140004977:	48 8b 85 30 02 00 00 	mov    0x230(%rbp),%rax
   14000497e:	41 b8 0c 00 00 00    	mov    $0xc,%r8d
   140004984:	48 89 c2             	mov    %rax,%rdx
   140004987:	48 8d 05 d5 eb 00 00 	lea    0xebd5(%rip),%rax        # 140013563 <.rdata+0x513>
   14000498e:	48 89 c1             	mov    %rax,%rcx
   140004991:	e8 91 de ff ff       	call   140002827 <type_array__create>
   140004996:	48 89 85 c8 01 00 00 	mov    %rax,0x1c8(%rbp)
   14000499d:	48 8d 05 c2 eb 00 00 	lea    0xebc2(%rip),%rax        # 140013566 <.rdata+0x516>
   1400049a4:	48 89 c1             	mov    %rax,%rcx
   1400049a7:	e8 cf da ff ff       	call   14000247b <type_struct__create>
   1400049ac:	48 89 85 c0 01 00 00 	mov    %rax,0x1c0(%rbp)
   1400049b3:	4c 8b 85 18 02 00 00 	mov    0x218(%rbp),%r8
   1400049ba:	48 8b 95 20 02 00 00 	mov    0x220(%rbp),%rdx
   1400049c1:	48 8b 85 c0 01 00 00 	mov    0x1c0(%rbp),%rax
   1400049c8:	48 c7 84 24 c8 00 00 	movq   $0x0,0xc8(%rsp)
   1400049cf:	00 00 00 00 00 
   1400049d4:	48 8d 0d 8e eb 00 00 	lea    0xeb8e(%rip),%rcx        # 140013569 <.rdata+0x519>
   1400049db:	48 89 8c 24 c0 00 00 	mov    %rcx,0xc0(%rsp)
   1400049e2:	00 
   1400049e3:	48 8b 8d c8 01 00 00 	mov    0x1c8(%rbp),%rcx
   1400049ea:	48 89 8c 24 b8 00 00 	mov    %rcx,0xb8(%rsp)
   1400049f1:	00 
   1400049f2:	48 8d 0d 7d eb 00 00 	lea    0xeb7d(%rip),%rcx        # 140013576 <.rdata+0x526>
   1400049f9:	48 89 8c 24 b0 00 00 	mov    %rcx,0xb0(%rsp)
   140004a00:	00 
   140004a01:	48 8b 8d d0 01 00 00 	mov    0x1d0(%rbp),%rcx
   140004a08:	48 89 8c 24 a8 00 00 	mov    %rcx,0xa8(%rsp)
   140004a0f:	00 
   140004a10:	48 8d 0d 6b eb 00 00 	lea    0xeb6b(%rip),%rcx        # 140013582 <.rdata+0x532>
   140004a17:	48 89 8c 24 a0 00 00 	mov    %rcx,0xa0(%rsp)
   140004a1e:	00 
   140004a1f:	48 8b 8d d8 01 00 00 	mov    0x1d8(%rbp),%rcx
   140004a26:	48 89 8c 24 98 00 00 	mov    %rcx,0x98(%rsp)
   140004a2d:	00 
   140004a2e:	48 8d 0d 58 eb 00 00 	lea    0xeb58(%rip),%rcx        # 14001358d <.rdata+0x53d>
   140004a35:	48 89 8c 24 90 00 00 	mov    %rcx,0x90(%rsp)
   140004a3c:	00 
   140004a3d:	48 8b 8d e0 01 00 00 	mov    0x1e0(%rbp),%rcx
   140004a44:	48 89 8c 24 88 00 00 	mov    %rcx,0x88(%rsp)
   140004a4b:	00 
   140004a4c:	48 8d 0d 44 eb 00 00 	lea    0xeb44(%rip),%rcx        # 140013597 <.rdata+0x547>
   140004a53:	48 89 8c 24 80 00 00 	mov    %rcx,0x80(%rsp)
   140004a5a:	00 
   140004a5b:	48 8b 8d e8 01 00 00 	mov    0x1e8(%rbp),%rcx
   140004a62:	48 89 4c 24 78       	mov    %rcx,0x78(%rsp)
   140004a67:	48 8d 0d 32 eb 00 00 	lea    0xeb32(%rip),%rcx        # 1400135a0 <.rdata+0x550>
   140004a6e:	48 89 4c 24 70       	mov    %rcx,0x70(%rsp)
   140004a73:	48 8b 8d f0 01 00 00 	mov    0x1f0(%rbp),%rcx
   140004a7a:	48 89 4c 24 68       	mov    %rcx,0x68(%rsp)
   140004a7f:	48 8d 0d 22 eb 00 00 	lea    0xeb22(%rip),%rcx        # 1400135a8 <.rdata+0x558>
   140004a86:	48 89 4c 24 60       	mov    %rcx,0x60(%rsp)
   140004a8b:	48 8b 8d f8 01 00 00 	mov    0x1f8(%rbp),%rcx
   140004a92:	48 89 4c 24 58       	mov    %rcx,0x58(%rsp)
   140004a97:	48 8d 0d 6a ea 00 00 	lea    0xea6a(%rip),%rcx        # 140013508 <.rdata+0x4b8>
   140004a9e:	48 89 4c 24 50       	mov    %rcx,0x50(%rsp)
   140004aa3:	48 8b 8d 00 02 00 00 	mov    0x200(%rbp),%rcx
   140004aaa:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
   140004aaf:	48 8d 0d 37 ea 00 00 	lea    0xea37(%rip),%rcx        # 1400134ed <.rdata+0x49d>
   140004ab6:	48 89 4c 24 40       	mov    %rcx,0x40(%rsp)
   140004abb:	48 8b 8d 08 02 00 00 	mov    0x208(%rbp),%rcx
   140004ac2:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
   140004ac7:	48 8d 0d 17 ea 00 00 	lea    0xea17(%rip),%rcx        # 1400134e5 <.rdata+0x495>
   140004ace:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
   140004ad3:	48 8b 8d 10 02 00 00 	mov    0x210(%rbp),%rcx
   140004ada:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
   140004adf:	48 8d 0d f6 e9 00 00 	lea    0xe9f6(%rip),%rcx        # 1400134dc <.rdata+0x48c>
   140004ae6:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   140004aeb:	4d 89 c1             	mov    %r8,%r9
   140004aee:	4c 8d 05 e3 e9 00 00 	lea    0xe9e3(%rip),%r8        # 1400134d8 <.rdata+0x488>
   140004af5:	48 89 c1             	mov    %rax,%rcx
   140004af8:	e8 7c ea ff ff       	call   140003579 <_type_struct__add_multiple>
   140004afd:	48 8b 85 c0 01 00 00 	mov    0x1c0(%rbp),%rax
   140004b04:	ba 01 00 00 00       	mov    $0x1,%edx
   140004b09:	48 89 c1             	mov    %rax,%rcx
   140004b0c:	e8 73 d4 ff ff       	call   140001f84 <type__set_max_alignment>
   140004b11:	48 8b 85 c0 01 00 00 	mov    0x1c0(%rbp),%rax
   140004b18:	ba 00 10 00 00       	mov    $0x1000,%edx
   140004b1d:	48 89 c1             	mov    %rax,%rcx
   140004b20:	e8 c4 d5 ff ff       	call   1400020e9 <type__set_alignment>
   140004b25:	4c 8d 0d e1 ec ff ff 	lea    -0x131f(%rip),%r9        # 14000380d <_type__print_value_s32>
   140004b2c:	41 b8 04 00 00 00    	mov    $0x4,%r8d
   140004b32:	48 8d 05 76 ea 00 00 	lea    0xea76(%rip),%rax        # 1400135af <.rdata+0x55f>
   140004b39:	48 89 c2             	mov    %rax,%rdx
   140004b3c:	48 8d 05 6c ea 00 00 	lea    0xea6c(%rip),%rax        # 1400135af <.rdata+0x55f>
   140004b43:	48 89 c1             	mov    %rax,%rcx
   140004b46:	e8 bc d3 ff ff       	call   140001f07 <type_atom__create>
   140004b4b:	48 89 85 b8 01 00 00 	mov    %rax,0x1b8(%rbp)
   140004b52:	48 8b 85 b8 01 00 00 	mov    0x1b8(%rbp),%rax
   140004b59:	ba 04 00 00 00       	mov    $0x4,%edx
   140004b5e:	48 89 c1             	mov    %rax,%rcx
   140004b61:	e8 83 d5 ff ff       	call   1400020e9 <type__set_alignment>
   140004b66:	48 8b 85 b8 01 00 00 	mov    0x1b8(%rbp),%rax
   140004b6d:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   140004b73:	48 89 c2             	mov    %rax,%rdx
   140004b76:	48 8d 05 35 ea 00 00 	lea    0xea35(%rip),%rax        # 1400135b2 <.rdata+0x562>
   140004b7d:	48 89 c1             	mov    %rax,%rcx
   140004b80:	e8 a2 dc ff ff       	call   140002827 <type_array__create>
   140004b85:	48 89 85 b0 01 00 00 	mov    %rax,0x1b0(%rbp)
   140004b8c:	48 8d 05 22 ea 00 00 	lea    0xea22(%rip),%rax        # 1400135b5 <.rdata+0x565>
   140004b93:	48 89 c1             	mov    %rax,%rcx
   140004b96:	e8 e0 d8 ff ff       	call   14000247b <type_struct__create>
   140004b9b:	48 89 85 a8 01 00 00 	mov    %rax,0x1a8(%rbp)
   140004ba2:	48 8b 95 b0 01 00 00 	mov    0x1b0(%rbp),%rdx
   140004ba9:	48 8b 85 a8 01 00 00 	mov    0x1a8(%rbp),%rax
   140004bb0:	4c 8d 05 21 e9 00 00 	lea    0xe921(%rip),%r8        # 1400134d8 <.rdata+0x488>
   140004bb7:	48 89 c1             	mov    %rax,%rcx
   140004bba:	e8 15 d9 ff ff       	call   1400024d4 <type_struct__add>
   140004bbf:	48 8b 85 a8 01 00 00 	mov    0x1a8(%rbp),%rax
   140004bc6:	ba 01 00 00 00       	mov    $0x1,%edx
   140004bcb:	48 89 c1             	mov    %rax,%rcx
   140004bce:	e8 b1 d3 ff ff       	call   140001f84 <type__set_max_alignment>
   140004bd3:	48 8d 05 de e9 00 00 	lea    0xe9de(%rip),%rax        # 1400135b8 <.rdata+0x568>
   140004bda:	48 89 c1             	mov    %rax,%rcx
   140004bdd:	e8 99 d8 ff ff       	call   14000247b <type_struct__create>
   140004be2:	48 89 85 a0 01 00 00 	mov    %rax,0x1a0(%rbp)
   140004be9:	48 8b 95 b8 03 00 00 	mov    0x3b8(%rbp),%rdx
   140004bf0:	48 8b 85 a0 01 00 00 	mov    0x1a0(%rbp),%rax
   140004bf7:	4c 8d 05 da e8 00 00 	lea    0xe8da(%rip),%r8        # 1400134d8 <.rdata+0x488>
   140004bfe:	48 89 c1             	mov    %rax,%rcx
   140004c01:	e8 ce d8 ff ff       	call   1400024d4 <type_struct__add>
   140004c06:	48 8b 85 a0 01 00 00 	mov    0x1a0(%rbp),%rax
   140004c0d:	ba 00 08 00 00       	mov    $0x800,%edx
   140004c12:	48 89 c1             	mov    %rax,%rcx
   140004c15:	e8 cf d4 ff ff       	call   1400020e9 <type__set_alignment>
   140004c1a:	4c 8d 0d 7e eb ff ff 	lea    -0x1482(%rip),%r9        # 14000379f <_type__print_value_s8>
   140004c21:	41 b8 01 00 00 00    	mov    $0x1,%r8d
   140004c27:	48 8d 05 8d e9 00 00 	lea    0xe98d(%rip),%rax        # 1400135bb <.rdata+0x56b>
   140004c2e:	48 89 c2             	mov    %rax,%rdx
   140004c31:	48 8d 05 83 e9 00 00 	lea    0xe983(%rip),%rax        # 1400135bb <.rdata+0x56b>
   140004c38:	48 89 c1             	mov    %rax,%rcx
   140004c3b:	e8 c7 d2 ff ff       	call   140001f07 <type_atom__create>
   140004c40:	48 89 85 98 01 00 00 	mov    %rax,0x198(%rbp)
   140004c47:	48 8b 85 98 01 00 00 	mov    0x198(%rbp),%rax
   140004c4e:	ba 04 00 00 00       	mov    $0x4,%edx
   140004c53:	48 89 c1             	mov    %rax,%rcx
   140004c56:	e8 8e d4 ff ff       	call   1400020e9 <type__set_alignment>
   140004c5b:	48 8d 05 5c e9 00 00 	lea    0xe95c(%rip),%rax        # 1400135be <.rdata+0x56e>
   140004c62:	48 89 c1             	mov    %rax,%rcx
   140004c65:	e8 ef dc ff ff       	call   140002959 <type_enum__create>
   140004c6a:	48 89 85 90 01 00 00 	mov    %rax,0x190(%rbp)
   140004c71:	48 8b 85 90 01 00 00 	mov    0x190(%rbp),%rax
   140004c78:	48 8d 15 42 e9 00 00 	lea    0xe942(%rip),%rdx        # 1400135c1 <.rdata+0x571>
   140004c7f:	48 89 c1             	mov    %rax,%rcx
   140004c82:	e8 4c de ff ff       	call   140002ad3 <type_enum__add>
   140004c87:	48 8b 85 90 01 00 00 	mov    0x190(%rbp),%rax
   140004c8e:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
   140004c94:	48 8d 15 2d e9 00 00 	lea    0xe92d(%rip),%rdx        # 1400135c8 <.rdata+0x578>
   140004c9b:	48 89 c1             	mov    %rax,%rcx
   140004c9e:	e8 cc de ff ff       	call   140002b6f <type_enum__add_with_value>
   140004ca3:	48 8b 85 90 01 00 00 	mov    0x190(%rbp),%rax
   140004caa:	48 8d 15 1f e9 00 00 	lea    0xe91f(%rip),%rdx        # 1400135d0 <.rdata+0x580>
   140004cb1:	48 89 c1             	mov    %rax,%rcx
   140004cb4:	e8 1a de ff ff       	call   140002ad3 <type_enum__add>
   140004cb9:	48 8b 85 90 01 00 00 	mov    0x190(%rbp),%rax
   140004cc0:	48 8d 15 11 e9 00 00 	lea    0xe911(%rip),%rdx        # 1400135d8 <.rdata+0x588>
   140004cc7:	48 89 c1             	mov    %rax,%rcx
   140004cca:	e8 04 de ff ff       	call   140002ad3 <type_enum__add>
   140004ccf:	48 8d 05 0b e9 00 00 	lea    0xe90b(%rip),%rax        # 1400135e1 <.rdata+0x591>
   140004cd6:	48 89 c1             	mov    %rax,%rcx
   140004cd9:	e8 7b dc ff ff       	call   140002959 <type_enum__create>
   140004cde:	48 89 85 88 01 00 00 	mov    %rax,0x188(%rbp)
   140004ce5:	48 8b 85 88 01 00 00 	mov    0x188(%rbp),%rax
   140004cec:	41 b8 f6 ff ff ff    	mov    $0xfffffff6,%r8d
   140004cf2:	48 8d 15 eb e8 00 00 	lea    0xe8eb(%rip),%rdx        # 1400135e4 <.rdata+0x594>
   140004cf9:	48 89 c1             	mov    %rax,%rcx
   140004cfc:	e8 6e de ff ff       	call   140002b6f <type_enum__add_with_value>
   140004d01:	48 8b 85 88 01 00 00 	mov    0x188(%rbp),%rax
   140004d08:	48 8d 15 db e8 00 00 	lea    0xe8db(%rip),%rdx        # 1400135ea <.rdata+0x59a>
   140004d0f:	48 89 c1             	mov    %rax,%rcx
   140004d12:	e8 bc dd ff ff       	call   140002ad3 <type_enum__add>
   140004d17:	48 8b 85 88 01 00 00 	mov    0x188(%rbp),%rax
   140004d1e:	48 8d 15 cb e8 00 00 	lea    0xe8cb(%rip),%rdx        # 1400135f0 <.rdata+0x5a0>
   140004d25:	48 89 c1             	mov    %rax,%rcx
   140004d28:	e8 a6 dd ff ff       	call   140002ad3 <type_enum__add>
   140004d2d:	48 8b 85 88 01 00 00 	mov    0x188(%rbp),%rax
   140004d34:	48 8d 15 bb e8 00 00 	lea    0xe8bb(%rip),%rdx        # 1400135f6 <.rdata+0x5a6>
   140004d3b:	48 89 c1             	mov    %rax,%rcx
   140004d3e:	e8 90 dd ff ff       	call   140002ad3 <type_enum__add>
   140004d43:	48 8b 85 88 01 00 00 	mov    0x188(%rbp),%rax
   140004d4a:	ba 00 10 00 00       	mov    $0x1000,%edx
   140004d4f:	48 89 c1             	mov    %rax,%rcx
   140004d52:	e8 92 d3 ff ff       	call   1400020e9 <type__set_alignment>
   140004d57:	b9 01 00 00 00       	mov    $0x1,%ecx
   140004d5c:	48 8b 05 65 65 01 00 	mov    0x16565(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140004d63:	ff d0                	call   *%rax
   140004d65:	48 89 c2             	mov    %rax,%rdx
   140004d68:	48 8b 85 b8 03 00 00 	mov    0x3b8(%rbp),%rax
   140004d6f:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140004d76:	00 00 
   140004d78:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140004d7e:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140004d84:	48 89 c1             	mov    %rax,%rcx
   140004d87:	e8 52 e5 ff ff       	call   1400032de <type__print>
   140004d8c:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140004d90:	4c 8d 0d 19 e7 00 00 	lea    0xe719(%rip),%r9        # 1400134b0 <.rdata+0x460>
   140004d97:	4c 8d 05 5e e8 00 00 	lea    0xe85e(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140004d9e:	ba 00 01 00 00       	mov    $0x100,%edx
   140004da3:	48 89 c1             	mov    %rax,%rcx
   140004da6:	e8 25 c8 00 00       	call   1400115d0 <snprintf>
   140004dab:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140004daf:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140004db6:	00 00 
   140004db8:	49 89 c1             	mov    %rax,%r9
   140004dbb:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140004dc1:	ba 16 00 00 00       	mov    $0x16,%edx
   140004dc6:	48 8d 05 84 e4 00 00 	lea    0xe484(%rip),%rax        # 140013251 <.rdata+0x201>
   140004dcd:	48 89 c1             	mov    %rax,%rcx
   140004dd0:	e8 5b c8 00 00       	call   140011630 <printf>
   140004dd5:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140004dd9:	4c 8d 0d d0 e6 00 00 	lea    0xe6d0(%rip),%r9        # 1400134b0 <.rdata+0x460>
   140004de0:	4c 8d 05 22 e8 00 00 	lea    0xe822(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140004de7:	ba 00 01 00 00       	mov    $0x100,%edx
   140004dec:	48 89 c1             	mov    %rax,%rcx
   140004def:	e8 dc c7 00 00       	call   1400115d0 <snprintf>
   140004df4:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140004df8:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140004dff:	00 00 
   140004e01:	49 89 c1             	mov    %rax,%r9
   140004e04:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140004e0a:	ba 16 00 00 00       	mov    $0x16,%edx
   140004e0f:	48 8d 05 3b e4 00 00 	lea    0xe43b(%rip),%rax        # 140013251 <.rdata+0x201>
   140004e16:	48 89 c1             	mov    %rax,%rcx
   140004e19:	e8 12 c8 00 00       	call   140011630 <printf>
   140004e1e:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140004e23:	e8 68 cc 00 00       	call   140011a90 <putchar>
   140004e28:	48 8b 85 b8 03 00 00 	mov    0x3b8(%rbp),%rax
   140004e2f:	48 89 c1             	mov    %rax,%rcx
   140004e32:	e8 34 d3 ff ff       	call   14000216b <type__size>
   140004e37:	48 83 f8 01          	cmp    $0x1,%rax
   140004e3b:	74 23                	je     140004e60 <main2+0x1481>
   140004e3d:	41 b8 83 04 00 00    	mov    $0x483,%r8d
   140004e43:	48 8d 05 06 e2 00 00 	lea    0xe206(%rip),%rax        # 140013050 <.rdata>
   140004e4a:	48 89 c2             	mov    %rax,%rdx
   140004e4d:	48 8d 05 c4 e7 00 00 	lea    0xe7c4(%rip),%rax        # 140013618 <.rdata+0x5c8>
   140004e54:	48 89 c1             	mov    %rax,%rcx
   140004e57:	48 8b 05 e2 64 01 00 	mov    0x164e2(%rip),%rax        # 14001b340 <__imp__assert>
   140004e5e:	ff d0                	call   *%rax
   140004e60:	48 8b 85 b8 03 00 00 	mov    0x3b8(%rbp),%rax
   140004e67:	48 8b 40 10          	mov    0x10(%rax),%rax
   140004e6b:	48 83 f8 01          	cmp    $0x1,%rax
   140004e6f:	74 23                	je     140004e94 <main2+0x14b5>
   140004e71:	41 b8 83 04 00 00    	mov    $0x483,%r8d
   140004e77:	48 8d 05 d2 e1 00 00 	lea    0xe1d2(%rip),%rax        # 140013050 <.rdata>
   140004e7e:	48 89 c2             	mov    %rax,%rdx
   140004e81:	48 8d 05 c0 e7 00 00 	lea    0xe7c0(%rip),%rax        # 140013648 <.rdata+0x5f8>
   140004e88:	48 89 c1             	mov    %rax,%rcx
   140004e8b:	48 8b 05 ae 64 01 00 	mov    0x164ae(%rip),%rax        # 14001b340 <__imp__assert>
   140004e92:	ff d0                	call   *%rax
   140004e94:	b9 01 00 00 00       	mov    $0x1,%ecx
   140004e99:	48 8b 05 28 64 01 00 	mov    0x16428(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140004ea0:	ff d0                	call   *%rax
   140004ea2:	48 89 c2             	mov    %rax,%rdx
   140004ea5:	48 8b 85 b0 03 00 00 	mov    0x3b0(%rbp),%rax
   140004eac:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140004eb3:	00 00 
   140004eb5:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140004ebb:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140004ec1:	48 89 c1             	mov    %rax,%rcx
   140004ec4:	e8 15 e4 ff ff       	call   1400032de <type__print>
   140004ec9:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140004ecd:	4c 8d 0d df e5 00 00 	lea    0xe5df(%rip),%r9        # 1400134b3 <.rdata+0x463>
   140004ed4:	4c 8d 05 21 e7 00 00 	lea    0xe721(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140004edb:	ba 00 01 00 00       	mov    $0x100,%edx
   140004ee0:	48 89 c1             	mov    %rax,%rcx
   140004ee3:	e8 e8 c6 00 00       	call   1400115d0 <snprintf>
   140004ee8:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140004eec:	48 c7 44 24 20 02 00 	movq   $0x2,0x20(%rsp)
   140004ef3:	00 00 
   140004ef5:	49 89 c1             	mov    %rax,%r9
   140004ef8:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140004efe:	ba 16 00 00 00       	mov    $0x16,%edx
   140004f03:	48 8d 05 47 e3 00 00 	lea    0xe347(%rip),%rax        # 140013251 <.rdata+0x201>
   140004f0a:	48 89 c1             	mov    %rax,%rcx
   140004f0d:	e8 1e c7 00 00       	call   140011630 <printf>
   140004f12:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140004f16:	4c 8d 0d 96 e5 00 00 	lea    0xe596(%rip),%r9        # 1400134b3 <.rdata+0x463>
   140004f1d:	4c 8d 05 e5 e6 00 00 	lea    0xe6e5(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140004f24:	ba 00 01 00 00       	mov    $0x100,%edx
   140004f29:	48 89 c1             	mov    %rax,%rcx
   140004f2c:	e8 9f c6 00 00       	call   1400115d0 <snprintf>
   140004f31:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140004f35:	48 c7 44 24 20 02 00 	movq   $0x2,0x20(%rsp)
   140004f3c:	00 00 
   140004f3e:	49 89 c1             	mov    %rax,%r9
   140004f41:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140004f47:	ba 16 00 00 00       	mov    $0x16,%edx
   140004f4c:	48 8d 05 fe e2 00 00 	lea    0xe2fe(%rip),%rax        # 140013251 <.rdata+0x201>
   140004f53:	48 89 c1             	mov    %rax,%rcx
   140004f56:	e8 d5 c6 00 00       	call   140011630 <printf>
   140004f5b:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140004f60:	e8 2b cb 00 00       	call   140011a90 <putchar>
   140004f65:	48 8b 85 b0 03 00 00 	mov    0x3b0(%rbp),%rax
   140004f6c:	48 89 c1             	mov    %rax,%rcx
   140004f6f:	e8 f7 d1 ff ff       	call   14000216b <type__size>
   140004f74:	48 83 f8 02          	cmp    $0x2,%rax
   140004f78:	74 23                	je     140004f9d <main2+0x15be>
   140004f7a:	41 b8 84 04 00 00    	mov    $0x484,%r8d
   140004f80:	48 8d 05 c9 e0 00 00 	lea    0xe0c9(%rip),%rax        # 140013050 <.rdata>
   140004f87:	48 89 c2             	mov    %rax,%rdx
   140004f8a:	48 8d 05 df e6 00 00 	lea    0xe6df(%rip),%rax        # 140013670 <.rdata+0x620>
   140004f91:	48 89 c1             	mov    %rax,%rcx
   140004f94:	48 8b 05 a5 63 01 00 	mov    0x163a5(%rip),%rax        # 14001b340 <__imp__assert>
   140004f9b:	ff d0                	call   *%rax
   140004f9d:	48 8b 85 b0 03 00 00 	mov    0x3b0(%rbp),%rax
   140004fa4:	48 8b 40 10          	mov    0x10(%rax),%rax
   140004fa8:	48 83 f8 02          	cmp    $0x2,%rax
   140004fac:	74 23                	je     140004fd1 <main2+0x15f2>
   140004fae:	41 b8 84 04 00 00    	mov    $0x484,%r8d
   140004fb4:	48 8d 05 95 e0 00 00 	lea    0xe095(%rip),%rax        # 140013050 <.rdata>
   140004fbb:	48 89 c2             	mov    %rax,%rdx
   140004fbe:	48 8d 05 db e6 00 00 	lea    0xe6db(%rip),%rax        # 1400136a0 <.rdata+0x650>
   140004fc5:	48 89 c1             	mov    %rax,%rcx
   140004fc8:	48 8b 05 71 63 01 00 	mov    0x16371(%rip),%rax        # 14001b340 <__imp__assert>
   140004fcf:	ff d0                	call   *%rax
   140004fd1:	b9 01 00 00 00       	mov    $0x1,%ecx
   140004fd6:	48 8b 05 eb 62 01 00 	mov    0x162eb(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140004fdd:	ff d0                	call   *%rax
   140004fdf:	48 89 c2             	mov    %rax,%rdx
   140004fe2:	48 8b 85 a8 03 00 00 	mov    0x3a8(%rbp),%rax
   140004fe9:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140004ff0:	00 00 
   140004ff2:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140004ff8:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140004ffe:	48 89 c1             	mov    %rax,%rcx
   140005001:	e8 d8 e2 ff ff       	call   1400032de <type__print>
   140005006:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000500a:	4c 8d 0d a6 e4 00 00 	lea    0xe4a6(%rip),%r9        # 1400134b7 <.rdata+0x467>
   140005011:	4c 8d 05 e4 e5 00 00 	lea    0xe5e4(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140005018:	ba 00 01 00 00       	mov    $0x100,%edx
   14000501d:	48 89 c1             	mov    %rax,%rcx
   140005020:	e8 ab c5 00 00       	call   1400115d0 <snprintf>
   140005025:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005029:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   140005030:	00 00 
   140005032:	49 89 c1             	mov    %rax,%r9
   140005035:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000503b:	ba 16 00 00 00       	mov    $0x16,%edx
   140005040:	48 8d 05 0a e2 00 00 	lea    0xe20a(%rip),%rax        # 140013251 <.rdata+0x201>
   140005047:	48 89 c1             	mov    %rax,%rcx
   14000504a:	e8 e1 c5 00 00       	call   140011630 <printf>
   14000504f:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005053:	4c 8d 0d 5d e4 00 00 	lea    0xe45d(%rip),%r9        # 1400134b7 <.rdata+0x467>
   14000505a:	4c 8d 05 a8 e5 00 00 	lea    0xe5a8(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140005061:	ba 00 01 00 00       	mov    $0x100,%edx
   140005066:	48 89 c1             	mov    %rax,%rcx
   140005069:	e8 62 c5 00 00       	call   1400115d0 <snprintf>
   14000506e:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005072:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   140005079:	00 00 
   14000507b:	49 89 c1             	mov    %rax,%r9
   14000507e:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140005084:	ba 16 00 00 00       	mov    $0x16,%edx
   140005089:	48 8d 05 c1 e1 00 00 	lea    0xe1c1(%rip),%rax        # 140013251 <.rdata+0x201>
   140005090:	48 89 c1             	mov    %rax,%rcx
   140005093:	e8 98 c5 00 00       	call   140011630 <printf>
   140005098:	b9 0a 00 00 00       	mov    $0xa,%ecx
   14000509d:	e8 ee c9 00 00       	call   140011a90 <putchar>
   1400050a2:	48 8b 85 a8 03 00 00 	mov    0x3a8(%rbp),%rax
   1400050a9:	48 89 c1             	mov    %rax,%rcx
   1400050ac:	e8 ba d0 ff ff       	call   14000216b <type__size>
   1400050b1:	48 83 f8 04          	cmp    $0x4,%rax
   1400050b5:	74 23                	je     1400050da <main2+0x16fb>
   1400050b7:	41 b8 85 04 00 00    	mov    $0x485,%r8d
   1400050bd:	48 8d 05 8c df 00 00 	lea    0xdf8c(%rip),%rax        # 140013050 <.rdata>
   1400050c4:	48 89 c2             	mov    %rax,%rdx
   1400050c7:	48 8d 05 02 e6 00 00 	lea    0xe602(%rip),%rax        # 1400136d0 <.rdata+0x680>
   1400050ce:	48 89 c1             	mov    %rax,%rcx
   1400050d1:	48 8b 05 68 62 01 00 	mov    0x16268(%rip),%rax        # 14001b340 <__imp__assert>
   1400050d8:	ff d0                	call   *%rax
   1400050da:	48 8b 85 a8 03 00 00 	mov    0x3a8(%rbp),%rax
   1400050e1:	48 8b 40 10          	mov    0x10(%rax),%rax
   1400050e5:	48 83 f8 04          	cmp    $0x4,%rax
   1400050e9:	74 23                	je     14000510e <main2+0x172f>
   1400050eb:	41 b8 85 04 00 00    	mov    $0x485,%r8d
   1400050f1:	48 8d 05 58 df 00 00 	lea    0xdf58(%rip),%rax        # 140013050 <.rdata>
   1400050f8:	48 89 c2             	mov    %rax,%rdx
   1400050fb:	48 8d 05 fe e5 00 00 	lea    0xe5fe(%rip),%rax        # 140013700 <.rdata+0x6b0>
   140005102:	48 89 c1             	mov    %rax,%rcx
   140005105:	48 8b 05 34 62 01 00 	mov    0x16234(%rip),%rax        # 14001b340 <__imp__assert>
   14000510c:	ff d0                	call   *%rax
   14000510e:	b9 01 00 00 00       	mov    $0x1,%ecx
   140005113:	48 8b 05 ae 61 01 00 	mov    0x161ae(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   14000511a:	ff d0                	call   *%rax
   14000511c:	48 89 c2             	mov    %rax,%rdx
   14000511f:	48 8b 85 a0 03 00 00 	mov    0x3a0(%rbp),%rax
   140005126:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000512d:	00 00 
   14000512f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140005135:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000513b:	48 89 c1             	mov    %rax,%rcx
   14000513e:	e8 9b e1 ff ff       	call   1400032de <type__print>
   140005143:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005147:	4c 8d 0d 6d e3 00 00 	lea    0xe36d(%rip),%r9        # 1400134bb <.rdata+0x46b>
   14000514e:	4c 8d 05 a7 e4 00 00 	lea    0xe4a7(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140005155:	ba 00 01 00 00       	mov    $0x100,%edx
   14000515a:	48 89 c1             	mov    %rax,%rcx
   14000515d:	e8 6e c4 00 00       	call   1400115d0 <snprintf>
   140005162:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005166:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   14000516d:	00 00 
   14000516f:	49 89 c1             	mov    %rax,%r9
   140005172:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140005178:	ba 16 00 00 00       	mov    $0x16,%edx
   14000517d:	48 8d 05 cd e0 00 00 	lea    0xe0cd(%rip),%rax        # 140013251 <.rdata+0x201>
   140005184:	48 89 c1             	mov    %rax,%rcx
   140005187:	e8 a4 c4 00 00       	call   140011630 <printf>
   14000518c:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005190:	4c 8d 0d 24 e3 00 00 	lea    0xe324(%rip),%r9        # 1400134bb <.rdata+0x46b>
   140005197:	4c 8d 05 6b e4 00 00 	lea    0xe46b(%rip),%r8        # 140013609 <.rdata+0x5b9>
   14000519e:	ba 00 01 00 00       	mov    $0x100,%edx
   1400051a3:	48 89 c1             	mov    %rax,%rcx
   1400051a6:	e8 25 c4 00 00       	call   1400115d0 <snprintf>
   1400051ab:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400051af:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   1400051b6:	00 00 
   1400051b8:	49 89 c1             	mov    %rax,%r9
   1400051bb:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400051c1:	ba 16 00 00 00       	mov    $0x16,%edx
   1400051c6:	48 8d 05 84 e0 00 00 	lea    0xe084(%rip),%rax        # 140013251 <.rdata+0x201>
   1400051cd:	48 89 c1             	mov    %rax,%rcx
   1400051d0:	e8 5b c4 00 00       	call   140011630 <printf>
   1400051d5:	b9 0a 00 00 00       	mov    $0xa,%ecx
   1400051da:	e8 b1 c8 00 00       	call   140011a90 <putchar>
   1400051df:	48 8b 85 a0 03 00 00 	mov    0x3a0(%rbp),%rax
   1400051e6:	48 89 c1             	mov    %rax,%rcx
   1400051e9:	e8 7d cf ff ff       	call   14000216b <type__size>
   1400051ee:	48 83 f8 08          	cmp    $0x8,%rax
   1400051f2:	74 23                	je     140005217 <main2+0x1838>
   1400051f4:	41 b8 86 04 00 00    	mov    $0x486,%r8d
   1400051fa:	48 8d 05 4f de 00 00 	lea    0xde4f(%rip),%rax        # 140013050 <.rdata>
   140005201:	48 89 c2             	mov    %rax,%rdx
   140005204:	48 8d 05 25 e5 00 00 	lea    0xe525(%rip),%rax        # 140013730 <.rdata+0x6e0>
   14000520b:	48 89 c1             	mov    %rax,%rcx
   14000520e:	48 8b 05 2b 61 01 00 	mov    0x1612b(%rip),%rax        # 14001b340 <__imp__assert>
   140005215:	ff d0                	call   *%rax
   140005217:	48 8b 85 a0 03 00 00 	mov    0x3a0(%rbp),%rax
   14000521e:	48 8b 40 10          	mov    0x10(%rax),%rax
   140005222:	48 83 f8 08          	cmp    $0x8,%rax
   140005226:	74 23                	je     14000524b <main2+0x186c>
   140005228:	41 b8 86 04 00 00    	mov    $0x486,%r8d
   14000522e:	48 8d 05 1b de 00 00 	lea    0xde1b(%rip),%rax        # 140013050 <.rdata>
   140005235:	48 89 c2             	mov    %rax,%rdx
   140005238:	48 8d 05 21 e5 00 00 	lea    0xe521(%rip),%rax        # 140013760 <.rdata+0x710>
   14000523f:	48 89 c1             	mov    %rax,%rcx
   140005242:	48 8b 05 f7 60 01 00 	mov    0x160f7(%rip),%rax        # 14001b340 <__imp__assert>
   140005249:	ff d0                	call   *%rax
   14000524b:	b9 01 00 00 00       	mov    $0x1,%ecx
   140005250:	48 8b 05 71 60 01 00 	mov    0x16071(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140005257:	ff d0                	call   *%rax
   140005259:	48 89 c2             	mov    %rax,%rdx
   14000525c:	48 8b 85 98 03 00 00 	mov    0x398(%rbp),%rax
   140005263:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000526a:	00 00 
   14000526c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140005272:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140005278:	48 89 c1             	mov    %rax,%rcx
   14000527b:	e8 5e e0 ff ff       	call   1400032de <type__print>
   140005280:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005284:	4c 8d 0d 34 e2 00 00 	lea    0xe234(%rip),%r9        # 1400134bf <.rdata+0x46f>
   14000528b:	4c 8d 05 6a e3 00 00 	lea    0xe36a(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140005292:	ba 00 01 00 00       	mov    $0x100,%edx
   140005297:	48 89 c1             	mov    %rax,%rcx
   14000529a:	e8 31 c3 00 00       	call   1400115d0 <snprintf>
   14000529f:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400052a3:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   1400052aa:	00 00 
   1400052ac:	49 89 c1             	mov    %rax,%r9
   1400052af:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400052b5:	ba 16 00 00 00       	mov    $0x16,%edx
   1400052ba:	48 8d 05 90 df 00 00 	lea    0xdf90(%rip),%rax        # 140013251 <.rdata+0x201>
   1400052c1:	48 89 c1             	mov    %rax,%rcx
   1400052c4:	e8 67 c3 00 00       	call   140011630 <printf>
   1400052c9:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400052cd:	4c 8d 0d eb e1 00 00 	lea    0xe1eb(%rip),%r9        # 1400134bf <.rdata+0x46f>
   1400052d4:	4c 8d 05 2e e3 00 00 	lea    0xe32e(%rip),%r8        # 140013609 <.rdata+0x5b9>
   1400052db:	ba 00 01 00 00       	mov    $0x100,%edx
   1400052e0:	48 89 c1             	mov    %rax,%rcx
   1400052e3:	e8 e8 c2 00 00       	call   1400115d0 <snprintf>
   1400052e8:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400052ec:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   1400052f3:	00 00 
   1400052f5:	49 89 c1             	mov    %rax,%r9
   1400052f8:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400052fe:	ba 16 00 00 00       	mov    $0x16,%edx
   140005303:	48 8d 05 47 df 00 00 	lea    0xdf47(%rip),%rax        # 140013251 <.rdata+0x201>
   14000530a:	48 89 c1             	mov    %rax,%rcx
   14000530d:	e8 1e c3 00 00       	call   140011630 <printf>
   140005312:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140005317:	e8 74 c7 00 00       	call   140011a90 <putchar>
   14000531c:	48 8b 85 98 03 00 00 	mov    0x398(%rbp),%rax
   140005323:	48 89 c1             	mov    %rax,%rcx
   140005326:	e8 40 ce ff ff       	call   14000216b <type__size>
   14000532b:	48 83 f8 01          	cmp    $0x1,%rax
   14000532f:	74 23                	je     140005354 <main2+0x1975>
   140005331:	41 b8 87 04 00 00    	mov    $0x487,%r8d
   140005337:	48 8d 05 12 dd 00 00 	lea    0xdd12(%rip),%rax        # 140013050 <.rdata>
   14000533e:	48 89 c2             	mov    %rax,%rdx
   140005341:	48 8d 05 48 e4 00 00 	lea    0xe448(%rip),%rax        # 140013790 <.rdata+0x740>
   140005348:	48 89 c1             	mov    %rax,%rcx
   14000534b:	48 8b 05 ee 5f 01 00 	mov    0x15fee(%rip),%rax        # 14001b340 <__imp__assert>
   140005352:	ff d0                	call   *%rax
   140005354:	48 8b 85 98 03 00 00 	mov    0x398(%rbp),%rax
   14000535b:	48 8b 40 10          	mov    0x10(%rax),%rax
   14000535f:	48 83 f8 01          	cmp    $0x1,%rax
   140005363:	74 23                	je     140005388 <main2+0x19a9>
   140005365:	41 b8 87 04 00 00    	mov    $0x487,%r8d
   14000536b:	48 8d 05 de dc 00 00 	lea    0xdcde(%rip),%rax        # 140013050 <.rdata>
   140005372:	48 89 c2             	mov    %rax,%rdx
   140005375:	48 8d 05 44 e4 00 00 	lea    0xe444(%rip),%rax        # 1400137c0 <.rdata+0x770>
   14000537c:	48 89 c1             	mov    %rax,%rcx
   14000537f:	48 8b 05 ba 5f 01 00 	mov    0x15fba(%rip),%rax        # 14001b340 <__imp__assert>
   140005386:	ff d0                	call   *%rax
   140005388:	b9 01 00 00 00       	mov    $0x1,%ecx
   14000538d:	48 8b 05 34 5f 01 00 	mov    0x15f34(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140005394:	ff d0                	call   *%rax
   140005396:	48 89 c2             	mov    %rax,%rdx
   140005399:	48 8b 85 90 03 00 00 	mov    0x390(%rbp),%rax
   1400053a0:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   1400053a7:	00 00 
   1400053a9:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   1400053af:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   1400053b5:	48 89 c1             	mov    %rax,%rcx
   1400053b8:	e8 21 df ff ff       	call   1400032de <type__print>
   1400053bd:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400053c1:	4c 8d 0d fa e0 00 00 	lea    0xe0fa(%rip),%r9        # 1400134c2 <.rdata+0x472>
   1400053c8:	4c 8d 05 2d e2 00 00 	lea    0xe22d(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   1400053cf:	ba 00 01 00 00       	mov    $0x100,%edx
   1400053d4:	48 89 c1             	mov    %rax,%rcx
   1400053d7:	e8 f4 c1 00 00       	call   1400115d0 <snprintf>
   1400053dc:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400053e0:	48 c7 44 24 20 02 00 	movq   $0x2,0x20(%rsp)
   1400053e7:	00 00 
   1400053e9:	49 89 c1             	mov    %rax,%r9
   1400053ec:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400053f2:	ba 16 00 00 00       	mov    $0x16,%edx
   1400053f7:	48 8d 05 53 de 00 00 	lea    0xde53(%rip),%rax        # 140013251 <.rdata+0x201>
   1400053fe:	48 89 c1             	mov    %rax,%rcx
   140005401:	e8 2a c2 00 00       	call   140011630 <printf>
   140005406:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000540a:	4c 8d 0d b1 e0 00 00 	lea    0xe0b1(%rip),%r9        # 1400134c2 <.rdata+0x472>
   140005411:	4c 8d 05 f1 e1 00 00 	lea    0xe1f1(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140005418:	ba 00 01 00 00       	mov    $0x100,%edx
   14000541d:	48 89 c1             	mov    %rax,%rcx
   140005420:	e8 ab c1 00 00       	call   1400115d0 <snprintf>
   140005425:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005429:	48 c7 44 24 20 02 00 	movq   $0x2,0x20(%rsp)
   140005430:	00 00 
   140005432:	49 89 c1             	mov    %rax,%r9
   140005435:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000543b:	ba 16 00 00 00       	mov    $0x16,%edx
   140005440:	48 8d 05 0a de 00 00 	lea    0xde0a(%rip),%rax        # 140013251 <.rdata+0x201>
   140005447:	48 89 c1             	mov    %rax,%rcx
   14000544a:	e8 e1 c1 00 00       	call   140011630 <printf>
   14000544f:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140005454:	e8 37 c6 00 00       	call   140011a90 <putchar>
   140005459:	48 8b 85 90 03 00 00 	mov    0x390(%rbp),%rax
   140005460:	48 89 c1             	mov    %rax,%rcx
   140005463:	e8 03 cd ff ff       	call   14000216b <type__size>
   140005468:	48 83 f8 02          	cmp    $0x2,%rax
   14000546c:	74 23                	je     140005491 <main2+0x1ab2>
   14000546e:	41 b8 88 04 00 00    	mov    $0x488,%r8d
   140005474:	48 8d 05 d5 db 00 00 	lea    0xdbd5(%rip),%rax        # 140013050 <.rdata>
   14000547b:	48 89 c2             	mov    %rax,%rdx
   14000547e:	48 8d 05 63 e3 00 00 	lea    0xe363(%rip),%rax        # 1400137e8 <.rdata+0x798>
   140005485:	48 89 c1             	mov    %rax,%rcx
   140005488:	48 8b 05 b1 5e 01 00 	mov    0x15eb1(%rip),%rax        # 14001b340 <__imp__assert>
   14000548f:	ff d0                	call   *%rax
   140005491:	48 8b 85 90 03 00 00 	mov    0x390(%rbp),%rax
   140005498:	48 8b 40 10          	mov    0x10(%rax),%rax
   14000549c:	48 83 f8 02          	cmp    $0x2,%rax
   1400054a0:	74 23                	je     1400054c5 <main2+0x1ae6>
   1400054a2:	41 b8 88 04 00 00    	mov    $0x488,%r8d
   1400054a8:	48 8d 05 a1 db 00 00 	lea    0xdba1(%rip),%rax        # 140013050 <.rdata>
   1400054af:	48 89 c2             	mov    %rax,%rdx
   1400054b2:	48 8d 05 5f e3 00 00 	lea    0xe35f(%rip),%rax        # 140013818 <.rdata+0x7c8>
   1400054b9:	48 89 c1             	mov    %rax,%rcx
   1400054bc:	48 8b 05 7d 5e 01 00 	mov    0x15e7d(%rip),%rax        # 14001b340 <__imp__assert>
   1400054c3:	ff d0                	call   *%rax
   1400054c5:	b9 01 00 00 00       	mov    $0x1,%ecx
   1400054ca:	48 8b 05 f7 5d 01 00 	mov    0x15df7(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   1400054d1:	ff d0                	call   *%rax
   1400054d3:	48 89 c2             	mov    %rax,%rdx
   1400054d6:	48 8b 85 88 03 00 00 	mov    0x388(%rbp),%rax
   1400054dd:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   1400054e4:	00 00 
   1400054e6:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   1400054ec:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   1400054f2:	48 89 c1             	mov    %rax,%rcx
   1400054f5:	e8 e4 dd ff ff       	call   1400032de <type__print>
   1400054fa:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400054fe:	4c 8d 0d c1 df 00 00 	lea    0xdfc1(%rip),%r9        # 1400134c6 <.rdata+0x476>
   140005505:	4c 8d 05 f0 e0 00 00 	lea    0xe0f0(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   14000550c:	ba 00 01 00 00       	mov    $0x100,%edx
   140005511:	48 89 c1             	mov    %rax,%rcx
   140005514:	e8 b7 c0 00 00       	call   1400115d0 <snprintf>
   140005519:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000551d:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   140005524:	00 00 
   140005526:	49 89 c1             	mov    %rax,%r9
   140005529:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000552f:	ba 16 00 00 00       	mov    $0x16,%edx
   140005534:	48 8d 05 16 dd 00 00 	lea    0xdd16(%rip),%rax        # 140013251 <.rdata+0x201>
   14000553b:	48 89 c1             	mov    %rax,%rcx
   14000553e:	e8 ed c0 00 00       	call   140011630 <printf>
   140005543:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005547:	4c 8d 0d 78 df 00 00 	lea    0xdf78(%rip),%r9        # 1400134c6 <.rdata+0x476>
   14000554e:	4c 8d 05 b4 e0 00 00 	lea    0xe0b4(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140005555:	ba 00 01 00 00       	mov    $0x100,%edx
   14000555a:	48 89 c1             	mov    %rax,%rcx
   14000555d:	e8 6e c0 00 00       	call   1400115d0 <snprintf>
   140005562:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005566:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   14000556d:	00 00 
   14000556f:	49 89 c1             	mov    %rax,%r9
   140005572:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140005578:	ba 16 00 00 00       	mov    $0x16,%edx
   14000557d:	48 8d 05 cd dc 00 00 	lea    0xdccd(%rip),%rax        # 140013251 <.rdata+0x201>
   140005584:	48 89 c1             	mov    %rax,%rcx
   140005587:	e8 a4 c0 00 00       	call   140011630 <printf>
   14000558c:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140005591:	e8 fa c4 00 00       	call   140011a90 <putchar>
   140005596:	48 8b 85 88 03 00 00 	mov    0x388(%rbp),%rax
   14000559d:	48 89 c1             	mov    %rax,%rcx
   1400055a0:	e8 c6 cb ff ff       	call   14000216b <type__size>
   1400055a5:	48 83 f8 04          	cmp    $0x4,%rax
   1400055a9:	74 23                	je     1400055ce <main2+0x1bef>
   1400055ab:	41 b8 89 04 00 00    	mov    $0x489,%r8d
   1400055b1:	48 8d 05 98 da 00 00 	lea    0xda98(%rip),%rax        # 140013050 <.rdata>
   1400055b8:	48 89 c2             	mov    %rax,%rdx
   1400055bb:	48 8d 05 86 e2 00 00 	lea    0xe286(%rip),%rax        # 140013848 <.rdata+0x7f8>
   1400055c2:	48 89 c1             	mov    %rax,%rcx
   1400055c5:	48 8b 05 74 5d 01 00 	mov    0x15d74(%rip),%rax        # 14001b340 <__imp__assert>
   1400055cc:	ff d0                	call   *%rax
   1400055ce:	48 8b 85 88 03 00 00 	mov    0x388(%rbp),%rax
   1400055d5:	48 8b 40 10          	mov    0x10(%rax),%rax
   1400055d9:	48 83 f8 04          	cmp    $0x4,%rax
   1400055dd:	74 23                	je     140005602 <main2+0x1c23>
   1400055df:	41 b8 89 04 00 00    	mov    $0x489,%r8d
   1400055e5:	48 8d 05 64 da 00 00 	lea    0xda64(%rip),%rax        # 140013050 <.rdata>
   1400055ec:	48 89 c2             	mov    %rax,%rdx
   1400055ef:	48 8d 05 82 e2 00 00 	lea    0xe282(%rip),%rax        # 140013878 <.rdata+0x828>
   1400055f6:	48 89 c1             	mov    %rax,%rcx
   1400055f9:	48 8b 05 40 5d 01 00 	mov    0x15d40(%rip),%rax        # 14001b340 <__imp__assert>
   140005600:	ff d0                	call   *%rax
   140005602:	b9 01 00 00 00       	mov    $0x1,%ecx
   140005607:	48 8b 05 ba 5c 01 00 	mov    0x15cba(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   14000560e:	ff d0                	call   *%rax
   140005610:	48 89 c2             	mov    %rax,%rdx
   140005613:	48 8b 85 80 03 00 00 	mov    0x380(%rbp),%rax
   14000561a:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140005621:	00 00 
   140005623:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140005629:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000562f:	48 89 c1             	mov    %rax,%rcx
   140005632:	e8 a7 dc ff ff       	call   1400032de <type__print>
   140005637:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000563b:	4c 8d 0d 88 de 00 00 	lea    0xde88(%rip),%r9        # 1400134ca <.rdata+0x47a>
   140005642:	4c 8d 05 b3 df 00 00 	lea    0xdfb3(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140005649:	ba 00 01 00 00       	mov    $0x100,%edx
   14000564e:	48 89 c1             	mov    %rax,%rcx
   140005651:	e8 7a bf 00 00       	call   1400115d0 <snprintf>
   140005656:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000565a:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   140005661:	00 00 
   140005663:	49 89 c1             	mov    %rax,%r9
   140005666:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000566c:	ba 16 00 00 00       	mov    $0x16,%edx
   140005671:	48 8d 05 d9 db 00 00 	lea    0xdbd9(%rip),%rax        # 140013251 <.rdata+0x201>
   140005678:	48 89 c1             	mov    %rax,%rcx
   14000567b:	e8 b0 bf 00 00       	call   140011630 <printf>
   140005680:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005684:	4c 8d 0d 3f de 00 00 	lea    0xde3f(%rip),%r9        # 1400134ca <.rdata+0x47a>
   14000568b:	4c 8d 05 77 df 00 00 	lea    0xdf77(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140005692:	ba 00 01 00 00       	mov    $0x100,%edx
   140005697:	48 89 c1             	mov    %rax,%rcx
   14000569a:	e8 31 bf 00 00       	call   1400115d0 <snprintf>
   14000569f:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400056a3:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   1400056aa:	00 00 
   1400056ac:	49 89 c1             	mov    %rax,%r9
   1400056af:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400056b5:	ba 16 00 00 00       	mov    $0x16,%edx
   1400056ba:	48 8d 05 90 db 00 00 	lea    0xdb90(%rip),%rax        # 140013251 <.rdata+0x201>
   1400056c1:	48 89 c1             	mov    %rax,%rcx
   1400056c4:	e8 67 bf 00 00       	call   140011630 <printf>
   1400056c9:	b9 0a 00 00 00       	mov    $0xa,%ecx
   1400056ce:	e8 bd c3 00 00       	call   140011a90 <putchar>
   1400056d3:	48 8b 85 80 03 00 00 	mov    0x380(%rbp),%rax
   1400056da:	48 89 c1             	mov    %rax,%rcx
   1400056dd:	e8 89 ca ff ff       	call   14000216b <type__size>
   1400056e2:	48 83 f8 08          	cmp    $0x8,%rax
   1400056e6:	74 23                	je     14000570b <main2+0x1d2c>
   1400056e8:	41 b8 8a 04 00 00    	mov    $0x48a,%r8d
   1400056ee:	48 8d 05 5b d9 00 00 	lea    0xd95b(%rip),%rax        # 140013050 <.rdata>
   1400056f5:	48 89 c2             	mov    %rax,%rdx
   1400056f8:	48 8d 05 a9 e1 00 00 	lea    0xe1a9(%rip),%rax        # 1400138a8 <.rdata+0x858>
   1400056ff:	48 89 c1             	mov    %rax,%rcx
   140005702:	48 8b 05 37 5c 01 00 	mov    0x15c37(%rip),%rax        # 14001b340 <__imp__assert>
   140005709:	ff d0                	call   *%rax
   14000570b:	48 8b 85 80 03 00 00 	mov    0x380(%rbp),%rax
   140005712:	48 8b 40 10          	mov    0x10(%rax),%rax
   140005716:	48 83 f8 08          	cmp    $0x8,%rax
   14000571a:	74 23                	je     14000573f <main2+0x1d60>
   14000571c:	41 b8 8a 04 00 00    	mov    $0x48a,%r8d
   140005722:	48 8d 05 27 d9 00 00 	lea    0xd927(%rip),%rax        # 140013050 <.rdata>
   140005729:	48 89 c2             	mov    %rax,%rdx
   14000572c:	48 8d 05 a5 e1 00 00 	lea    0xe1a5(%rip),%rax        # 1400138d8 <.rdata+0x888>
   140005733:	48 89 c1             	mov    %rax,%rcx
   140005736:	48 8b 05 03 5c 01 00 	mov    0x15c03(%rip),%rax        # 14001b340 <__imp__assert>
   14000573d:	ff d0                	call   *%rax
   14000573f:	b9 01 00 00 00       	mov    $0x1,%ecx
   140005744:	48 8b 05 7d 5b 01 00 	mov    0x15b7d(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   14000574b:	ff d0                	call   *%rax
   14000574d:	48 89 c2             	mov    %rax,%rdx
   140005750:	48 8b 85 78 03 00 00 	mov    0x378(%rbp),%rax
   140005757:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000575e:	00 00 
   140005760:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140005766:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000576c:	48 89 c1             	mov    %rax,%rcx
   14000576f:	e8 6a db ff ff       	call   1400032de <type__print>
   140005774:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005778:	4c 8d 0d 4f dd 00 00 	lea    0xdd4f(%rip),%r9        # 1400134ce <.rdata+0x47e>
   14000577f:	4c 8d 05 76 de 00 00 	lea    0xde76(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140005786:	ba 00 01 00 00       	mov    $0x100,%edx
   14000578b:	48 89 c1             	mov    %rax,%rcx
   14000578e:	e8 3d be 00 00       	call   1400115d0 <snprintf>
   140005793:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005797:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   14000579e:	00 00 
   1400057a0:	49 89 c1             	mov    %rax,%r9
   1400057a3:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400057a9:	ba 16 00 00 00       	mov    $0x16,%edx
   1400057ae:	48 8d 05 9c da 00 00 	lea    0xda9c(%rip),%rax        # 140013251 <.rdata+0x201>
   1400057b5:	48 89 c1             	mov    %rax,%rcx
   1400057b8:	e8 73 be 00 00       	call   140011630 <printf>
   1400057bd:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400057c1:	4c 8d 0d 06 dd 00 00 	lea    0xdd06(%rip),%r9        # 1400134ce <.rdata+0x47e>
   1400057c8:	4c 8d 05 3a de 00 00 	lea    0xde3a(%rip),%r8        # 140013609 <.rdata+0x5b9>
   1400057cf:	ba 00 01 00 00       	mov    $0x100,%edx
   1400057d4:	48 89 c1             	mov    %rax,%rcx
   1400057d7:	e8 f4 bd 00 00       	call   1400115d0 <snprintf>
   1400057dc:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400057e0:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   1400057e7:	00 00 
   1400057e9:	49 89 c1             	mov    %rax,%r9
   1400057ec:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400057f2:	ba 16 00 00 00       	mov    $0x16,%edx
   1400057f7:	48 8d 05 53 da 00 00 	lea    0xda53(%rip),%rax        # 140013251 <.rdata+0x201>
   1400057fe:	48 89 c1             	mov    %rax,%rcx
   140005801:	e8 2a be 00 00       	call   140011630 <printf>
   140005806:	b9 0a 00 00 00       	mov    $0xa,%ecx
   14000580b:	e8 80 c2 00 00       	call   140011a90 <putchar>
   140005810:	48 8b 85 78 03 00 00 	mov    0x378(%rbp),%rax
   140005817:	48 89 c1             	mov    %rax,%rcx
   14000581a:	e8 4c c9 ff ff       	call   14000216b <type__size>
   14000581f:	48 83 f8 04          	cmp    $0x4,%rax
   140005823:	74 23                	je     140005848 <main2+0x1e69>
   140005825:	41 b8 8b 04 00 00    	mov    $0x48b,%r8d
   14000582b:	48 8d 05 1e d8 00 00 	lea    0xd81e(%rip),%rax        # 140013050 <.rdata>
   140005832:	48 89 c2             	mov    %rax,%rdx
   140005835:	48 8d 05 cc e0 00 00 	lea    0xe0cc(%rip),%rax        # 140013908 <.rdata+0x8b8>
   14000583c:	48 89 c1             	mov    %rax,%rcx
   14000583f:	48 8b 05 fa 5a 01 00 	mov    0x15afa(%rip),%rax        # 14001b340 <__imp__assert>
   140005846:	ff d0                	call   *%rax
   140005848:	48 8b 85 78 03 00 00 	mov    0x378(%rbp),%rax
   14000584f:	48 8b 40 10          	mov    0x10(%rax),%rax
   140005853:	48 83 f8 04          	cmp    $0x4,%rax
   140005857:	74 23                	je     14000587c <main2+0x1e9d>
   140005859:	41 b8 8b 04 00 00    	mov    $0x48b,%r8d
   14000585f:	48 8d 05 ea d7 00 00 	lea    0xd7ea(%rip),%rax        # 140013050 <.rdata>
   140005866:	48 89 c2             	mov    %rax,%rdx
   140005869:	48 8d 05 c8 e0 00 00 	lea    0xe0c8(%rip),%rax        # 140013938 <.rdata+0x8e8>
   140005870:	48 89 c1             	mov    %rax,%rcx
   140005873:	48 8b 05 c6 5a 01 00 	mov    0x15ac6(%rip),%rax        # 14001b340 <__imp__assert>
   14000587a:	ff d0                	call   *%rax
   14000587c:	b9 01 00 00 00       	mov    $0x1,%ecx
   140005881:	48 8b 05 40 5a 01 00 	mov    0x15a40(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140005888:	ff d0                	call   *%rax
   14000588a:	48 89 c2             	mov    %rax,%rdx
   14000588d:	48 8b 85 70 03 00 00 	mov    0x370(%rbp),%rax
   140005894:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000589b:	00 00 
   14000589d:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   1400058a3:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   1400058a9:	48 89 c1             	mov    %rax,%rcx
   1400058ac:	e8 2d da ff ff       	call   1400032de <type__print>
   1400058b1:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400058b5:	4c 8d 0d 16 dc 00 00 	lea    0xdc16(%rip),%r9        # 1400134d2 <.rdata+0x482>
   1400058bc:	4c 8d 05 39 dd 00 00 	lea    0xdd39(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   1400058c3:	ba 00 01 00 00       	mov    $0x100,%edx
   1400058c8:	48 89 c1             	mov    %rax,%rcx
   1400058cb:	e8 00 bd 00 00       	call   1400115d0 <snprintf>
   1400058d0:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400058d4:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   1400058db:	00 00 
   1400058dd:	49 89 c1             	mov    %rax,%r9
   1400058e0:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400058e6:	ba 16 00 00 00       	mov    $0x16,%edx
   1400058eb:	48 8d 05 5f d9 00 00 	lea    0xd95f(%rip),%rax        # 140013251 <.rdata+0x201>
   1400058f2:	48 89 c1             	mov    %rax,%rcx
   1400058f5:	e8 36 bd 00 00       	call   140011630 <printf>
   1400058fa:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400058fe:	4c 8d 0d cd db 00 00 	lea    0xdbcd(%rip),%r9        # 1400134d2 <.rdata+0x482>
   140005905:	4c 8d 05 fd dc 00 00 	lea    0xdcfd(%rip),%r8        # 140013609 <.rdata+0x5b9>
   14000590c:	ba 00 01 00 00       	mov    $0x100,%edx
   140005911:	48 89 c1             	mov    %rax,%rcx
   140005914:	e8 b7 bc 00 00       	call   1400115d0 <snprintf>
   140005919:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000591d:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   140005924:	00 00 
   140005926:	49 89 c1             	mov    %rax,%r9
   140005929:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000592f:	ba 16 00 00 00       	mov    $0x16,%edx
   140005934:	48 8d 05 16 d9 00 00 	lea    0xd916(%rip),%rax        # 140013251 <.rdata+0x201>
   14000593b:	48 89 c1             	mov    %rax,%rcx
   14000593e:	e8 ed bc 00 00       	call   140011630 <printf>
   140005943:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140005948:	e8 43 c1 00 00       	call   140011a90 <putchar>
   14000594d:	48 8b 85 70 03 00 00 	mov    0x370(%rbp),%rax
   140005954:	48 89 c1             	mov    %rax,%rcx
   140005957:	e8 0f c8 ff ff       	call   14000216b <type__size>
   14000595c:	48 83 f8 08          	cmp    $0x8,%rax
   140005960:	74 23                	je     140005985 <main2+0x1fa6>
   140005962:	41 b8 8c 04 00 00    	mov    $0x48c,%r8d
   140005968:	48 8d 05 e1 d6 00 00 	lea    0xd6e1(%rip),%rax        # 140013050 <.rdata>
   14000596f:	48 89 c2             	mov    %rax,%rdx
   140005972:	48 8d 05 ef df 00 00 	lea    0xdfef(%rip),%rax        # 140013968 <.rdata+0x918>
   140005979:	48 89 c1             	mov    %rax,%rcx
   14000597c:	48 8b 05 bd 59 01 00 	mov    0x159bd(%rip),%rax        # 14001b340 <__imp__assert>
   140005983:	ff d0                	call   *%rax
   140005985:	48 8b 85 70 03 00 00 	mov    0x370(%rbp),%rax
   14000598c:	48 8b 40 10          	mov    0x10(%rax),%rax
   140005990:	48 83 f8 08          	cmp    $0x8,%rax
   140005994:	74 23                	je     1400059b9 <main2+0x1fda>
   140005996:	41 b8 8c 04 00 00    	mov    $0x48c,%r8d
   14000599c:	48 8d 05 ad d6 00 00 	lea    0xd6ad(%rip),%rax        # 140013050 <.rdata>
   1400059a3:	48 89 c2             	mov    %rax,%rdx
   1400059a6:	48 8d 05 eb df 00 00 	lea    0xdfeb(%rip),%rax        # 140013998 <.rdata+0x948>
   1400059ad:	48 89 c1             	mov    %rax,%rcx
   1400059b0:	48 8b 05 89 59 01 00 	mov    0x15989(%rip),%rax        # 14001b340 <__imp__assert>
   1400059b7:	ff d0                	call   *%rax
   1400059b9:	b9 01 00 00 00       	mov    $0x1,%ecx
   1400059be:	48 8b 05 03 59 01 00 	mov    0x15903(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   1400059c5:	ff d0                	call   *%rax
   1400059c7:	48 89 c2             	mov    %rax,%rdx
   1400059ca:	48 8b 85 68 03 00 00 	mov    0x368(%rbp),%rax
   1400059d1:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   1400059d8:	00 00 
   1400059da:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   1400059e0:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   1400059e6:	48 89 c1             	mov    %rax,%rcx
   1400059e9:	e8 f0 d8 ff ff       	call   1400032de <type__print>
   1400059ee:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400059f2:	4c 8d 0d dd da 00 00 	lea    0xdadd(%rip),%r9        # 1400134d6 <.rdata+0x486>
   1400059f9:	4c 8d 05 fc db 00 00 	lea    0xdbfc(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140005a00:	ba 00 01 00 00       	mov    $0x100,%edx
   140005a05:	48 89 c1             	mov    %rax,%rcx
   140005a08:	e8 c3 bb 00 00       	call   1400115d0 <snprintf>
   140005a0d:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005a11:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140005a18:	00 00 
   140005a1a:	49 89 c1             	mov    %rax,%r9
   140005a1d:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140005a23:	ba 16 00 00 00       	mov    $0x16,%edx
   140005a28:	48 8d 05 22 d8 00 00 	lea    0xd822(%rip),%rax        # 140013251 <.rdata+0x201>
   140005a2f:	48 89 c1             	mov    %rax,%rcx
   140005a32:	e8 f9 bb 00 00       	call   140011630 <printf>
   140005a37:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005a3b:	4c 8d 0d 94 da 00 00 	lea    0xda94(%rip),%r9        # 1400134d6 <.rdata+0x486>
   140005a42:	4c 8d 05 c0 db 00 00 	lea    0xdbc0(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140005a49:	ba 00 01 00 00       	mov    $0x100,%edx
   140005a4e:	48 89 c1             	mov    %rax,%rcx
   140005a51:	e8 7a bb 00 00       	call   1400115d0 <snprintf>
   140005a56:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005a5a:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140005a61:	00 00 
   140005a63:	49 89 c1             	mov    %rax,%r9
   140005a66:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140005a6c:	ba 16 00 00 00       	mov    $0x16,%edx
   140005a71:	48 8d 05 d9 d7 00 00 	lea    0xd7d9(%rip),%rax        # 140013251 <.rdata+0x201>
   140005a78:	48 89 c1             	mov    %rax,%rcx
   140005a7b:	e8 b0 bb 00 00       	call   140011630 <printf>
   140005a80:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140005a85:	e8 06 c0 00 00       	call   140011a90 <putchar>
   140005a8a:	48 8b 85 68 03 00 00 	mov    0x368(%rbp),%rax
   140005a91:	48 89 c1             	mov    %rax,%rcx
   140005a94:	e8 d2 c6 ff ff       	call   14000216b <type__size>
   140005a99:	48 83 f8 01          	cmp    $0x1,%rax
   140005a9d:	74 23                	je     140005ac2 <main2+0x20e3>
   140005a9f:	41 b8 8d 04 00 00    	mov    $0x48d,%r8d
   140005aa5:	48 8d 05 a4 d5 00 00 	lea    0xd5a4(%rip),%rax        # 140013050 <.rdata>
   140005aac:	48 89 c2             	mov    %rax,%rdx
   140005aaf:	48 8d 05 12 df 00 00 	lea    0xdf12(%rip),%rax        # 1400139c8 <.rdata+0x978>
   140005ab6:	48 89 c1             	mov    %rax,%rcx
   140005ab9:	48 8b 05 80 58 01 00 	mov    0x15880(%rip),%rax        # 14001b340 <__imp__assert>
   140005ac0:	ff d0                	call   *%rax
   140005ac2:	48 8b 85 68 03 00 00 	mov    0x368(%rbp),%rax
   140005ac9:	48 8b 40 10          	mov    0x10(%rax),%rax
   140005acd:	48 83 f8 01          	cmp    $0x1,%rax
   140005ad1:	74 23                	je     140005af6 <main2+0x2117>
   140005ad3:	41 b8 8d 04 00 00    	mov    $0x48d,%r8d
   140005ad9:	48 8d 05 70 d5 00 00 	lea    0xd570(%rip),%rax        # 140013050 <.rdata>
   140005ae0:	48 89 c2             	mov    %rax,%rdx
   140005ae3:	48 8d 05 0e df 00 00 	lea    0xdf0e(%rip),%rax        # 1400139f8 <.rdata+0x9a8>
   140005aea:	48 89 c1             	mov    %rax,%rcx
   140005aed:	48 8b 05 4c 58 01 00 	mov    0x1584c(%rip),%rax        # 14001b340 <__imp__assert>
   140005af4:	ff d0                	call   *%rax
   140005af6:	b9 01 00 00 00       	mov    $0x1,%ecx
   140005afb:	48 8b 05 c6 57 01 00 	mov    0x157c6(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140005b02:	ff d0                	call   *%rax
   140005b04:	48 89 c2             	mov    %rax,%rdx
   140005b07:	48 8b 85 60 03 00 00 	mov    0x360(%rbp),%rax
   140005b0e:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140005b15:	00 00 
   140005b17:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140005b1d:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140005b23:	48 89 c1             	mov    %rax,%rcx
   140005b26:	e8 b3 d7 ff ff       	call   1400032de <type__print>
   140005b2b:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005b2f:	4c 8d 0d a4 d9 00 00 	lea    0xd9a4(%rip),%r9        # 1400134da <.rdata+0x48a>
   140005b36:	4c 8d 05 bf da 00 00 	lea    0xdabf(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140005b3d:	ba 00 01 00 00       	mov    $0x100,%edx
   140005b42:	48 89 c1             	mov    %rax,%rcx
   140005b45:	e8 86 ba 00 00       	call   1400115d0 <snprintf>
   140005b4a:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005b4e:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   140005b55:	00 00 
   140005b57:	49 89 c1             	mov    %rax,%r9
   140005b5a:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140005b60:	ba 16 00 00 00       	mov    $0x16,%edx
   140005b65:	48 8d 05 e5 d6 00 00 	lea    0xd6e5(%rip),%rax        # 140013251 <.rdata+0x201>
   140005b6c:	48 89 c1             	mov    %rax,%rcx
   140005b6f:	e8 bc ba 00 00       	call   140011630 <printf>
   140005b74:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005b78:	4c 8d 0d 5b d9 00 00 	lea    0xd95b(%rip),%r9        # 1400134da <.rdata+0x48a>
   140005b7f:	4c 8d 05 83 da 00 00 	lea    0xda83(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140005b86:	ba 00 01 00 00       	mov    $0x100,%edx
   140005b8b:	48 89 c1             	mov    %rax,%rcx
   140005b8e:	e8 3d ba 00 00       	call   1400115d0 <snprintf>
   140005b93:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005b97:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   140005b9e:	00 00 
   140005ba0:	49 89 c1             	mov    %rax,%r9
   140005ba3:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140005ba9:	ba 16 00 00 00       	mov    $0x16,%edx
   140005bae:	48 8d 05 9c d6 00 00 	lea    0xd69c(%rip),%rax        # 140013251 <.rdata+0x201>
   140005bb5:	48 89 c1             	mov    %rax,%rcx
   140005bb8:	e8 73 ba 00 00       	call   140011630 <printf>
   140005bbd:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140005bc2:	e8 c9 be 00 00       	call   140011a90 <putchar>
   140005bc7:	48 8b 85 60 03 00 00 	mov    0x360(%rbp),%rax
   140005bce:	48 89 c1             	mov    %rax,%rcx
   140005bd1:	e8 95 c5 ff ff       	call   14000216b <type__size>
   140005bd6:	48 83 f8 08          	cmp    $0x8,%rax
   140005bda:	74 23                	je     140005bff <main2+0x2220>
   140005bdc:	41 b8 8e 04 00 00    	mov    $0x48e,%r8d
   140005be2:	48 8d 05 67 d4 00 00 	lea    0xd467(%rip),%rax        # 140013050 <.rdata>
   140005be9:	48 89 c2             	mov    %rax,%rdx
   140005bec:	48 8d 05 2d de 00 00 	lea    0xde2d(%rip),%rax        # 140013a20 <.rdata+0x9d0>
   140005bf3:	48 89 c1             	mov    %rax,%rcx
   140005bf6:	48 8b 05 43 57 01 00 	mov    0x15743(%rip),%rax        # 14001b340 <__imp__assert>
   140005bfd:	ff d0                	call   *%rax
   140005bff:	48 8b 85 60 03 00 00 	mov    0x360(%rbp),%rax
   140005c06:	48 8b 40 10          	mov    0x10(%rax),%rax
   140005c0a:	48 83 f8 04          	cmp    $0x4,%rax
   140005c0e:	74 23                	je     140005c33 <main2+0x2254>
   140005c10:	41 b8 8e 04 00 00    	mov    $0x48e,%r8d
   140005c16:	48 8d 05 33 d4 00 00 	lea    0xd433(%rip),%rax        # 140013050 <.rdata>
   140005c1d:	48 89 c2             	mov    %rax,%rdx
   140005c20:	48 8d 05 29 de 00 00 	lea    0xde29(%rip),%rax        # 140013a50 <.rdata+0xa00>
   140005c27:	48 89 c1             	mov    %rax,%rcx
   140005c2a:	48 8b 05 0f 57 01 00 	mov    0x1570f(%rip),%rax        # 14001b340 <__imp__assert>
   140005c31:	ff d0                	call   *%rax
   140005c33:	b9 01 00 00 00       	mov    $0x1,%ecx
   140005c38:	48 8b 05 89 56 01 00 	mov    0x15689(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140005c3f:	ff d0                	call   *%rax
   140005c41:	48 89 c2             	mov    %rax,%rdx
   140005c44:	48 8b 85 58 03 00 00 	mov    0x358(%rbp),%rax
   140005c4b:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140005c52:	00 00 
   140005c54:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140005c5a:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140005c60:	48 89 c1             	mov    %rax,%rcx
   140005c63:	e8 76 d6 ff ff       	call   1400032de <type__print>
   140005c68:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005c6c:	4c 8d 0d 6c d8 00 00 	lea    0xd86c(%rip),%r9        # 1400134df <.rdata+0x48f>
   140005c73:	4c 8d 05 82 d9 00 00 	lea    0xd982(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140005c7a:	ba 00 01 00 00       	mov    $0x100,%edx
   140005c7f:	48 89 c1             	mov    %rax,%rcx
   140005c82:	e8 49 b9 00 00       	call   1400115d0 <snprintf>
   140005c87:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005c8b:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   140005c92:	00 00 
   140005c94:	49 89 c1             	mov    %rax,%r9
   140005c97:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140005c9d:	ba 16 00 00 00       	mov    $0x16,%edx
   140005ca2:	48 8d 05 a8 d5 00 00 	lea    0xd5a8(%rip),%rax        # 140013251 <.rdata+0x201>
   140005ca9:	48 89 c1             	mov    %rax,%rcx
   140005cac:	e8 7f b9 00 00       	call   140011630 <printf>
   140005cb1:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005cb5:	4c 8d 0d 23 d8 00 00 	lea    0xd823(%rip),%r9        # 1400134df <.rdata+0x48f>
   140005cbc:	4c 8d 05 46 d9 00 00 	lea    0xd946(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140005cc3:	ba 00 01 00 00       	mov    $0x100,%edx
   140005cc8:	48 89 c1             	mov    %rax,%rcx
   140005ccb:	e8 00 b9 00 00       	call   1400115d0 <snprintf>
   140005cd0:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005cd4:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   140005cdb:	00 00 
   140005cdd:	49 89 c1             	mov    %rax,%r9
   140005ce0:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140005ce6:	ba 16 00 00 00       	mov    $0x16,%edx
   140005ceb:	48 8d 05 5f d5 00 00 	lea    0xd55f(%rip),%rax        # 140013251 <.rdata+0x201>
   140005cf2:	48 89 c1             	mov    %rax,%rcx
   140005cf5:	e8 36 b9 00 00       	call   140011630 <printf>
   140005cfa:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140005cff:	e8 8c bd 00 00       	call   140011a90 <putchar>
   140005d04:	48 8b 85 58 03 00 00 	mov    0x358(%rbp),%rax
   140005d0b:	48 89 c1             	mov    %rax,%rcx
   140005d0e:	e8 58 c4 ff ff       	call   14000216b <type__size>
   140005d13:	48 83 f8 08          	cmp    $0x8,%rax
   140005d17:	74 23                	je     140005d3c <main2+0x235d>
   140005d19:	41 b8 8f 04 00 00    	mov    $0x48f,%r8d
   140005d1f:	48 8d 05 2a d3 00 00 	lea    0xd32a(%rip),%rax        # 140013050 <.rdata>
   140005d26:	48 89 c2             	mov    %rax,%rdx
   140005d29:	48 8d 05 48 dd 00 00 	lea    0xdd48(%rip),%rax        # 140013a78 <.rdata+0xa28>
   140005d30:	48 89 c1             	mov    %rax,%rcx
   140005d33:	48 8b 05 06 56 01 00 	mov    0x15606(%rip),%rax        # 14001b340 <__imp__assert>
   140005d3a:	ff d0                	call   *%rax
   140005d3c:	48 8b 85 58 03 00 00 	mov    0x358(%rbp),%rax
   140005d43:	48 8b 40 10          	mov    0x10(%rax),%rax
   140005d47:	48 83 f8 04          	cmp    $0x4,%rax
   140005d4b:	74 23                	je     140005d70 <main2+0x2391>
   140005d4d:	41 b8 8f 04 00 00    	mov    $0x48f,%r8d
   140005d53:	48 8d 05 f6 d2 00 00 	lea    0xd2f6(%rip),%rax        # 140013050 <.rdata>
   140005d5a:	48 89 c2             	mov    %rax,%rdx
   140005d5d:	48 8d 05 44 dd 00 00 	lea    0xdd44(%rip),%rax        # 140013aa8 <.rdata+0xa58>
   140005d64:	48 89 c1             	mov    %rax,%rcx
   140005d67:	48 8b 05 d2 55 01 00 	mov    0x155d2(%rip),%rax        # 14001b340 <__imp__assert>
   140005d6e:	ff d0                	call   *%rax
   140005d70:	b9 01 00 00 00       	mov    $0x1,%ecx
   140005d75:	48 8b 05 4c 55 01 00 	mov    0x1554c(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140005d7c:	ff d0                	call   *%rax
   140005d7e:	48 89 c2             	mov    %rax,%rdx
   140005d81:	48 8b 85 50 03 00 00 	mov    0x350(%rbp),%rax
   140005d88:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140005d8f:	00 00 
   140005d91:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140005d97:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140005d9d:	48 89 c1             	mov    %rax,%rcx
   140005da0:	e8 39 d5 ff ff       	call   1400032de <type__print>
   140005da5:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005da9:	4c 8d 0d 31 d7 00 00 	lea    0xd731(%rip),%r9        # 1400134e1 <.rdata+0x491>
   140005db0:	4c 8d 05 45 d8 00 00 	lea    0xd845(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140005db7:	ba 00 01 00 00       	mov    $0x100,%edx
   140005dbc:	48 89 c1             	mov    %rax,%rcx
   140005dbf:	e8 0c b8 00 00       	call   1400115d0 <snprintf>
   140005dc4:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005dc8:	48 c7 44 24 20 03 00 	movq   $0x3,0x20(%rsp)
   140005dcf:	00 00 
   140005dd1:	49 89 c1             	mov    %rax,%r9
   140005dd4:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140005dda:	ba 16 00 00 00       	mov    $0x16,%edx
   140005ddf:	48 8d 05 6b d4 00 00 	lea    0xd46b(%rip),%rax        # 140013251 <.rdata+0x201>
   140005de6:	48 89 c1             	mov    %rax,%rcx
   140005de9:	e8 42 b8 00 00       	call   140011630 <printf>
   140005dee:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005df2:	4c 8d 0d e8 d6 00 00 	lea    0xd6e8(%rip),%r9        # 1400134e1 <.rdata+0x491>
   140005df9:	4c 8d 05 09 d8 00 00 	lea    0xd809(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140005e00:	ba 00 01 00 00       	mov    $0x100,%edx
   140005e05:	48 89 c1             	mov    %rax,%rcx
   140005e08:	e8 c3 b7 00 00       	call   1400115d0 <snprintf>
   140005e0d:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005e11:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140005e18:	00 00 
   140005e1a:	49 89 c1             	mov    %rax,%r9
   140005e1d:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140005e23:	ba 16 00 00 00       	mov    $0x16,%edx
   140005e28:	48 8d 05 22 d4 00 00 	lea    0xd422(%rip),%rax        # 140013251 <.rdata+0x201>
   140005e2f:	48 89 c1             	mov    %rax,%rcx
   140005e32:	e8 f9 b7 00 00       	call   140011630 <printf>
   140005e37:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140005e3c:	e8 4f bc 00 00       	call   140011a90 <putchar>
   140005e41:	48 8b 85 50 03 00 00 	mov    0x350(%rbp),%rax
   140005e48:	48 89 c1             	mov    %rax,%rcx
   140005e4b:	e8 1b c3 ff ff       	call   14000216b <type__size>
   140005e50:	48 83 f8 03          	cmp    $0x3,%rax
   140005e54:	74 23                	je     140005e79 <main2+0x249a>
   140005e56:	41 b8 90 04 00 00    	mov    $0x490,%r8d
   140005e5c:	48 8d 05 ed d1 00 00 	lea    0xd1ed(%rip),%rax        # 140013050 <.rdata>
   140005e63:	48 89 c2             	mov    %rax,%rdx
   140005e66:	48 8d 05 63 dc 00 00 	lea    0xdc63(%rip),%rax        # 140013ad0 <.rdata+0xa80>
   140005e6d:	48 89 c1             	mov    %rax,%rcx
   140005e70:	48 8b 05 c9 54 01 00 	mov    0x154c9(%rip),%rax        # 14001b340 <__imp__assert>
   140005e77:	ff d0                	call   *%rax
   140005e79:	48 8b 85 50 03 00 00 	mov    0x350(%rbp),%rax
   140005e80:	48 8b 40 10          	mov    0x10(%rax),%rax
   140005e84:	48 83 f8 01          	cmp    $0x1,%rax
   140005e88:	74 23                	je     140005ead <main2+0x24ce>
   140005e8a:	41 b8 90 04 00 00    	mov    $0x490,%r8d
   140005e90:	48 8d 05 b9 d1 00 00 	lea    0xd1b9(%rip),%rax        # 140013050 <.rdata>
   140005e97:	48 89 c2             	mov    %rax,%rdx
   140005e9a:	48 8d 05 5f dc 00 00 	lea    0xdc5f(%rip),%rax        # 140013b00 <.rdata+0xab0>
   140005ea1:	48 89 c1             	mov    %rax,%rcx
   140005ea4:	48 8b 05 95 54 01 00 	mov    0x15495(%rip),%rax        # 14001b340 <__imp__assert>
   140005eab:	ff d0                	call   *%rax
   140005ead:	b9 01 00 00 00       	mov    $0x1,%ecx
   140005eb2:	48 8b 05 0f 54 01 00 	mov    0x1540f(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140005eb9:	ff d0                	call   *%rax
   140005ebb:	48 89 c2             	mov    %rax,%rdx
   140005ebe:	48 8b 85 48 03 00 00 	mov    0x348(%rbp),%rax
   140005ec5:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140005ecc:	00 00 
   140005ece:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140005ed4:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140005eda:	48 89 c1             	mov    %rax,%rcx
   140005edd:	e8 fc d3 ff ff       	call   1400032de <type__print>
   140005ee2:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005ee6:	4c 8d 0d f6 d5 00 00 	lea    0xd5f6(%rip),%r9        # 1400134e3 <.rdata+0x493>
   140005eed:	4c 8d 05 08 d7 00 00 	lea    0xd708(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140005ef4:	ba 00 01 00 00       	mov    $0x100,%edx
   140005ef9:	48 89 c1             	mov    %rax,%rcx
   140005efc:	e8 cf b6 00 00       	call   1400115d0 <snprintf>
   140005f01:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005f05:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   140005f0c:	00 00 
   140005f0e:	49 89 c1             	mov    %rax,%r9
   140005f11:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140005f17:	ba 16 00 00 00       	mov    $0x16,%edx
   140005f1c:	48 8d 05 2e d3 00 00 	lea    0xd32e(%rip),%rax        # 140013251 <.rdata+0x201>
   140005f23:	48 89 c1             	mov    %rax,%rcx
   140005f26:	e8 05 b7 00 00       	call   140011630 <printf>
   140005f2b:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005f2f:	4c 8d 0d ad d5 00 00 	lea    0xd5ad(%rip),%r9        # 1400134e3 <.rdata+0x493>
   140005f36:	4c 8d 05 cc d6 00 00 	lea    0xd6cc(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140005f3d:	ba 00 01 00 00       	mov    $0x100,%edx
   140005f42:	48 89 c1             	mov    %rax,%rcx
   140005f45:	e8 86 b6 00 00       	call   1400115d0 <snprintf>
   140005f4a:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140005f4e:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   140005f55:	00 00 
   140005f57:	49 89 c1             	mov    %rax,%r9
   140005f5a:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140005f60:	ba 16 00 00 00       	mov    $0x16,%edx
   140005f65:	48 8d 05 e5 d2 00 00 	lea    0xd2e5(%rip),%rax        # 140013251 <.rdata+0x201>
   140005f6c:	48 89 c1             	mov    %rax,%rcx
   140005f6f:	e8 bc b6 00 00       	call   140011630 <printf>
   140005f74:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140005f79:	e8 12 bb 00 00       	call   140011a90 <putchar>
   140005f7e:	48 8b 85 48 03 00 00 	mov    0x348(%rbp),%rax
   140005f85:	48 89 c1             	mov    %rax,%rcx
   140005f88:	e8 de c1 ff ff       	call   14000216b <type__size>
   140005f8d:	48 83 f8 08          	cmp    $0x8,%rax
   140005f91:	74 23                	je     140005fb6 <main2+0x25d7>
   140005f93:	41 b8 91 04 00 00    	mov    $0x491,%r8d
   140005f99:	48 8d 05 b0 d0 00 00 	lea    0xd0b0(%rip),%rax        # 140013050 <.rdata>
   140005fa0:	48 89 c2             	mov    %rax,%rdx
   140005fa3:	48 8d 05 7e db 00 00 	lea    0xdb7e(%rip),%rax        # 140013b28 <.rdata+0xad8>
   140005faa:	48 89 c1             	mov    %rax,%rcx
   140005fad:	48 8b 05 8c 53 01 00 	mov    0x1538c(%rip),%rax        # 14001b340 <__imp__assert>
   140005fb4:	ff d0                	call   *%rax
   140005fb6:	48 8b 85 48 03 00 00 	mov    0x348(%rbp),%rax
   140005fbd:	48 8b 40 10          	mov    0x10(%rax),%rax
   140005fc1:	48 83 f8 08          	cmp    $0x8,%rax
   140005fc5:	74 23                	je     140005fea <main2+0x260b>
   140005fc7:	41 b8 91 04 00 00    	mov    $0x491,%r8d
   140005fcd:	48 8d 05 7c d0 00 00 	lea    0xd07c(%rip),%rax        # 140013050 <.rdata>
   140005fd4:	48 89 c2             	mov    %rax,%rdx
   140005fd7:	48 8d 05 7a db 00 00 	lea    0xdb7a(%rip),%rax        # 140013b58 <.rdata+0xb08>
   140005fde:	48 89 c1             	mov    %rax,%rcx
   140005fe1:	48 8b 05 58 53 01 00 	mov    0x15358(%rip),%rax        # 14001b340 <__imp__assert>
   140005fe8:	ff d0                	call   *%rax
   140005fea:	b9 01 00 00 00       	mov    $0x1,%ecx
   140005fef:	48 8b 05 d2 52 01 00 	mov    0x152d2(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140005ff6:	ff d0                	call   *%rax
   140005ff8:	48 89 c2             	mov    %rax,%rdx
   140005ffb:	48 8b 85 40 03 00 00 	mov    0x340(%rbp),%rax
   140006002:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140006009:	00 00 
   14000600b:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140006011:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140006017:	48 89 c1             	mov    %rax,%rcx
   14000601a:	e8 bf d2 ff ff       	call   1400032de <type__print>
   14000601f:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006023:	4c 8d 0d bf d4 00 00 	lea    0xd4bf(%rip),%r9        # 1400134e9 <.rdata+0x499>
   14000602a:	4c 8d 05 cb d5 00 00 	lea    0xd5cb(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140006031:	ba 00 01 00 00       	mov    $0x100,%edx
   140006036:	48 89 c1             	mov    %rax,%rcx
   140006039:	e8 92 b5 00 00       	call   1400115d0 <snprintf>
   14000603e:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006042:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   140006049:	00 00 
   14000604b:	49 89 c1             	mov    %rax,%r9
   14000604e:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140006054:	ba 16 00 00 00       	mov    $0x16,%edx
   140006059:	48 8d 05 f1 d1 00 00 	lea    0xd1f1(%rip),%rax        # 140013251 <.rdata+0x201>
   140006060:	48 89 c1             	mov    %rax,%rcx
   140006063:	e8 c8 b5 00 00       	call   140011630 <printf>
   140006068:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000606c:	4c 8d 0d 76 d4 00 00 	lea    0xd476(%rip),%r9        # 1400134e9 <.rdata+0x499>
   140006073:	4c 8d 05 8f d5 00 00 	lea    0xd58f(%rip),%r8        # 140013609 <.rdata+0x5b9>
   14000607a:	ba 00 01 00 00       	mov    $0x100,%edx
   14000607f:	48 89 c1             	mov    %rax,%rcx
   140006082:	e8 49 b5 00 00       	call   1400115d0 <snprintf>
   140006087:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000608b:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   140006092:	00 00 
   140006094:	49 89 c1             	mov    %rax,%r9
   140006097:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000609d:	ba 16 00 00 00       	mov    $0x16,%edx
   1400060a2:	48 8d 05 a8 d1 00 00 	lea    0xd1a8(%rip),%rax        # 140013251 <.rdata+0x201>
   1400060a9:	48 89 c1             	mov    %rax,%rcx
   1400060ac:	e8 7f b5 00 00       	call   140011630 <printf>
   1400060b1:	b9 0a 00 00 00       	mov    $0xa,%ecx
   1400060b6:	e8 d5 b9 00 00       	call   140011a90 <putchar>
   1400060bb:	48 8b 85 40 03 00 00 	mov    0x340(%rbp),%rax
   1400060c2:	48 89 c1             	mov    %rax,%rcx
   1400060c5:	e8 a1 c0 ff ff       	call   14000216b <type__size>
   1400060ca:	48 83 f8 08          	cmp    $0x8,%rax
   1400060ce:	74 23                	je     1400060f3 <main2+0x2714>
   1400060d0:	41 b8 92 04 00 00    	mov    $0x492,%r8d
   1400060d6:	48 8d 05 73 cf 00 00 	lea    0xcf73(%rip),%rax        # 140013050 <.rdata>
   1400060dd:	48 89 c2             	mov    %rax,%rdx
   1400060e0:	48 8d 05 99 da 00 00 	lea    0xda99(%rip),%rax        # 140013b80 <.rdata+0xb30>
   1400060e7:	48 89 c1             	mov    %rax,%rcx
   1400060ea:	48 8b 05 4f 52 01 00 	mov    0x1524f(%rip),%rax        # 14001b340 <__imp__assert>
   1400060f1:	ff d0                	call   *%rax
   1400060f3:	48 8b 85 40 03 00 00 	mov    0x340(%rbp),%rax
   1400060fa:	48 8b 40 10          	mov    0x10(%rax),%rax
   1400060fe:	48 83 f8 08          	cmp    $0x8,%rax
   140006102:	74 23                	je     140006127 <main2+0x2748>
   140006104:	41 b8 92 04 00 00    	mov    $0x492,%r8d
   14000610a:	48 8d 05 3f cf 00 00 	lea    0xcf3f(%rip),%rax        # 140013050 <.rdata>
   140006111:	48 89 c2             	mov    %rax,%rdx
   140006114:	48 8d 05 95 da 00 00 	lea    0xda95(%rip),%rax        # 140013bb0 <.rdata+0xb60>
   14000611b:	48 89 c1             	mov    %rax,%rcx
   14000611e:	48 8b 05 1b 52 01 00 	mov    0x1521b(%rip),%rax        # 14001b340 <__imp__assert>
   140006125:	ff d0                	call   *%rax
   140006127:	b9 01 00 00 00       	mov    $0x1,%ecx
   14000612c:	48 8b 05 95 51 01 00 	mov    0x15195(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140006133:	ff d0                	call   *%rax
   140006135:	48 89 c2             	mov    %rax,%rdx
   140006138:	48 8b 85 38 03 00 00 	mov    0x338(%rbp),%rax
   14000613f:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140006146:	00 00 
   140006148:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000614e:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140006154:	48 89 c1             	mov    %rax,%rcx
   140006157:	e8 82 d1 ff ff       	call   1400032de <type__print>
   14000615c:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006160:	4c 8d 0d 84 d3 00 00 	lea    0xd384(%rip),%r9        # 1400134eb <.rdata+0x49b>
   140006167:	4c 8d 05 8e d4 00 00 	lea    0xd48e(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   14000616e:	ba 00 01 00 00       	mov    $0x100,%edx
   140006173:	48 89 c1             	mov    %rax,%rcx
   140006176:	e8 55 b4 00 00       	call   1400115d0 <snprintf>
   14000617b:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000617f:	48 c7 44 24 20 20 00 	movq   $0x20,0x20(%rsp)
   140006186:	00 00 
   140006188:	49 89 c1             	mov    %rax,%r9
   14000618b:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140006191:	ba 16 00 00 00       	mov    $0x16,%edx
   140006196:	48 8d 05 b4 d0 00 00 	lea    0xd0b4(%rip),%rax        # 140013251 <.rdata+0x201>
   14000619d:	48 89 c1             	mov    %rax,%rcx
   1400061a0:	e8 8b b4 00 00       	call   140011630 <printf>
   1400061a5:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400061a9:	4c 8d 0d 3b d3 00 00 	lea    0xd33b(%rip),%r9        # 1400134eb <.rdata+0x49b>
   1400061b0:	4c 8d 05 52 d4 00 00 	lea    0xd452(%rip),%r8        # 140013609 <.rdata+0x5b9>
   1400061b7:	ba 00 01 00 00       	mov    $0x100,%edx
   1400061bc:	48 89 c1             	mov    %rax,%rcx
   1400061bf:	e8 0c b4 00 00       	call   1400115d0 <snprintf>
   1400061c4:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400061c8:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   1400061cf:	00 00 
   1400061d1:	49 89 c1             	mov    %rax,%r9
   1400061d4:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400061da:	ba 16 00 00 00       	mov    $0x16,%edx
   1400061df:	48 8d 05 6b d0 00 00 	lea    0xd06b(%rip),%rax        # 140013251 <.rdata+0x201>
   1400061e6:	48 89 c1             	mov    %rax,%rcx
   1400061e9:	e8 42 b4 00 00       	call   140011630 <printf>
   1400061ee:	b9 0a 00 00 00       	mov    $0xa,%ecx
   1400061f3:	e8 98 b8 00 00       	call   140011a90 <putchar>
   1400061f8:	48 8b 85 38 03 00 00 	mov    0x338(%rbp),%rax
   1400061ff:	48 89 c1             	mov    %rax,%rcx
   140006202:	e8 64 bf ff ff       	call   14000216b <type__size>
   140006207:	48 83 f8 20          	cmp    $0x20,%rax
   14000620b:	74 23                	je     140006230 <main2+0x2851>
   14000620d:	41 b8 93 04 00 00    	mov    $0x493,%r8d
   140006213:	48 8d 05 36 ce 00 00 	lea    0xce36(%rip),%rax        # 140013050 <.rdata>
   14000621a:	48 89 c2             	mov    %rax,%rdx
   14000621d:	48 8d 05 b4 d9 00 00 	lea    0xd9b4(%rip),%rax        # 140013bd8 <.rdata+0xb88>
   140006224:	48 89 c1             	mov    %rax,%rcx
   140006227:	48 8b 05 12 51 01 00 	mov    0x15112(%rip),%rax        # 14001b340 <__imp__assert>
   14000622e:	ff d0                	call   *%rax
   140006230:	48 8b 85 38 03 00 00 	mov    0x338(%rbp),%rax
   140006237:	48 8b 40 10          	mov    0x10(%rax),%rax
   14000623b:	48 83 f8 08          	cmp    $0x8,%rax
   14000623f:	74 23                	je     140006264 <main2+0x2885>
   140006241:	41 b8 93 04 00 00    	mov    $0x493,%r8d
   140006247:	48 8d 05 02 ce 00 00 	lea    0xce02(%rip),%rax        # 140013050 <.rdata>
   14000624e:	48 89 c2             	mov    %rax,%rdx
   140006251:	48 8d 05 b0 d9 00 00 	lea    0xd9b0(%rip),%rax        # 140013c08 <.rdata+0xbb8>
   140006258:	48 89 c1             	mov    %rax,%rcx
   14000625b:	48 8b 05 de 50 01 00 	mov    0x150de(%rip),%rax        # 14001b340 <__imp__assert>
   140006262:	ff d0                	call   *%rax
   140006264:	b9 01 00 00 00       	mov    $0x1,%ecx
   140006269:	48 8b 05 58 50 01 00 	mov    0x15058(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140006270:	ff d0                	call   *%rax
   140006272:	48 89 c2             	mov    %rax,%rdx
   140006275:	48 8b 85 30 03 00 00 	mov    0x330(%rbp),%rax
   14000627c:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140006283:	00 00 
   140006285:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000628b:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140006291:	48 89 c1             	mov    %rax,%rcx
   140006294:	e8 45 d0 ff ff       	call   1400032de <type__print>
   140006299:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000629d:	4c 8d 0d 4e d2 00 00 	lea    0xd24e(%rip),%r9        # 1400134f2 <.rdata+0x4a2>
   1400062a4:	4c 8d 05 51 d3 00 00 	lea    0xd351(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   1400062ab:	ba 00 01 00 00       	mov    $0x100,%edx
   1400062b0:	48 89 c1             	mov    %rax,%rcx
   1400062b3:	e8 18 b3 00 00       	call   1400115d0 <snprintf>
   1400062b8:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400062bc:	48 c7 44 24 20 28 01 	movq   $0x128,0x20(%rsp)
   1400062c3:	00 00 
   1400062c5:	49 89 c1             	mov    %rax,%r9
   1400062c8:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400062ce:	ba 16 00 00 00       	mov    $0x16,%edx
   1400062d3:	48 8d 05 77 cf 00 00 	lea    0xcf77(%rip),%rax        # 140013251 <.rdata+0x201>
   1400062da:	48 89 c1             	mov    %rax,%rcx
   1400062dd:	e8 4e b3 00 00       	call   140011630 <printf>
   1400062e2:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400062e6:	4c 8d 0d 05 d2 00 00 	lea    0xd205(%rip),%r9        # 1400134f2 <.rdata+0x4a2>
   1400062ed:	4c 8d 05 15 d3 00 00 	lea    0xd315(%rip),%r8        # 140013609 <.rdata+0x5b9>
   1400062f4:	ba 00 01 00 00       	mov    $0x100,%edx
   1400062f9:	48 89 c1             	mov    %rax,%rcx
   1400062fc:	e8 cf b2 00 00       	call   1400115d0 <snprintf>
   140006301:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006305:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   14000630c:	00 00 
   14000630e:	49 89 c1             	mov    %rax,%r9
   140006311:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140006317:	ba 16 00 00 00       	mov    $0x16,%edx
   14000631c:	48 8d 05 2e cf 00 00 	lea    0xcf2e(%rip),%rax        # 140013251 <.rdata+0x201>
   140006323:	48 89 c1             	mov    %rax,%rcx
   140006326:	e8 05 b3 00 00       	call   140011630 <printf>
   14000632b:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140006330:	e8 5b b7 00 00       	call   140011a90 <putchar>
   140006335:	48 8b 85 30 03 00 00 	mov    0x330(%rbp),%rax
   14000633c:	48 89 c1             	mov    %rax,%rcx
   14000633f:	e8 27 be ff ff       	call   14000216b <type__size>
   140006344:	48 3d 28 01 00 00    	cmp    $0x128,%rax
   14000634a:	74 23                	je     14000636f <main2+0x2990>
   14000634c:	41 b8 94 04 00 00    	mov    $0x494,%r8d
   140006352:	48 8d 05 f7 cc 00 00 	lea    0xccf7(%rip),%rax        # 140013050 <.rdata>
   140006359:	48 89 c2             	mov    %rax,%rdx
   14000635c:	48 8d 05 cd d8 00 00 	lea    0xd8cd(%rip),%rax        # 140013c30 <.rdata+0xbe0>
   140006363:	48 89 c1             	mov    %rax,%rcx
   140006366:	48 8b 05 d3 4f 01 00 	mov    0x14fd3(%rip),%rax        # 14001b340 <__imp__assert>
   14000636d:	ff d0                	call   *%rax
   14000636f:	48 8b 85 30 03 00 00 	mov    0x330(%rbp),%rax
   140006376:	48 8b 40 10          	mov    0x10(%rax),%rax
   14000637a:	48 83 f8 08          	cmp    $0x8,%rax
   14000637e:	74 23                	je     1400063a3 <main2+0x29c4>
   140006380:	41 b8 94 04 00 00    	mov    $0x494,%r8d
   140006386:	48 8d 05 c3 cc 00 00 	lea    0xccc3(%rip),%rax        # 140013050 <.rdata>
   14000638d:	48 89 c2             	mov    %rax,%rdx
   140006390:	48 8d 05 c9 d8 00 00 	lea    0xd8c9(%rip),%rax        # 140013c60 <.rdata+0xc10>
   140006397:	48 89 c1             	mov    %rax,%rcx
   14000639a:	48 8b 05 9f 4f 01 00 	mov    0x14f9f(%rip),%rax        # 14001b340 <__imp__assert>
   1400063a1:	ff d0                	call   *%rax
   1400063a3:	b9 01 00 00 00       	mov    $0x1,%ecx
   1400063a8:	48 8b 05 19 4f 01 00 	mov    0x14f19(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   1400063af:	ff d0                	call   *%rax
   1400063b1:	48 89 c2             	mov    %rax,%rdx
   1400063b4:	48 8b 85 28 03 00 00 	mov    0x328(%rbp),%rax
   1400063bb:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   1400063c2:	00 00 
   1400063c4:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   1400063ca:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   1400063d0:	48 89 c1             	mov    %rax,%rcx
   1400063d3:	e8 06 cf ff ff       	call   1400032de <type__print>
   1400063d8:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400063dc:	4c 8d 0d 11 d1 00 00 	lea    0xd111(%rip),%r9        # 1400134f4 <.rdata+0x4a4>
   1400063e3:	4c 8d 05 12 d2 00 00 	lea    0xd212(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   1400063ea:	ba 00 01 00 00       	mov    $0x100,%edx
   1400063ef:	48 89 c1             	mov    %rax,%rcx
   1400063f2:	e8 d9 b1 00 00       	call   1400115d0 <snprintf>
   1400063f7:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400063fb:	48 c7 44 24 20 28 01 	movq   $0x128,0x20(%rsp)
   140006402:	00 00 
   140006404:	49 89 c1             	mov    %rax,%r9
   140006407:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000640d:	ba 16 00 00 00       	mov    $0x16,%edx
   140006412:	48 8d 05 38 ce 00 00 	lea    0xce38(%rip),%rax        # 140013251 <.rdata+0x201>
   140006419:	48 89 c1             	mov    %rax,%rcx
   14000641c:	e8 0f b2 00 00       	call   140011630 <printf>
   140006421:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006425:	4c 8d 0d c8 d0 00 00 	lea    0xd0c8(%rip),%r9        # 1400134f4 <.rdata+0x4a4>
   14000642c:	4c 8d 05 d6 d1 00 00 	lea    0xd1d6(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140006433:	ba 00 01 00 00       	mov    $0x100,%edx
   140006438:	48 89 c1             	mov    %rax,%rcx
   14000643b:	e8 90 b1 00 00       	call   1400115d0 <snprintf>
   140006440:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006444:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   14000644b:	00 00 
   14000644d:	49 89 c1             	mov    %rax,%r9
   140006450:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140006456:	ba 16 00 00 00       	mov    $0x16,%edx
   14000645b:	48 8d 05 ef cd 00 00 	lea    0xcdef(%rip),%rax        # 140013251 <.rdata+0x201>
   140006462:	48 89 c1             	mov    %rax,%rcx
   140006465:	e8 c6 b1 00 00       	call   140011630 <printf>
   14000646a:	b9 0a 00 00 00       	mov    $0xa,%ecx
   14000646f:	e8 1c b6 00 00       	call   140011a90 <putchar>
   140006474:	48 8b 85 28 03 00 00 	mov    0x328(%rbp),%rax
   14000647b:	48 89 c1             	mov    %rax,%rcx
   14000647e:	e8 e8 bc ff ff       	call   14000216b <type__size>
   140006483:	48 3d 28 01 00 00    	cmp    $0x128,%rax
   140006489:	74 23                	je     1400064ae <main2+0x2acf>
   14000648b:	41 b8 95 04 00 00    	mov    $0x495,%r8d
   140006491:	48 8d 05 b8 cb 00 00 	lea    0xcbb8(%rip),%rax        # 140013050 <.rdata>
   140006498:	48 89 c2             	mov    %rax,%rdx
   14000649b:	48 8d 05 e6 d7 00 00 	lea    0xd7e6(%rip),%rax        # 140013c88 <.rdata+0xc38>
   1400064a2:	48 89 c1             	mov    %rax,%rcx
   1400064a5:	48 8b 05 94 4e 01 00 	mov    0x14e94(%rip),%rax        # 14001b340 <__imp__assert>
   1400064ac:	ff d0                	call   *%rax
   1400064ae:	48 8b 85 28 03 00 00 	mov    0x328(%rbp),%rax
   1400064b5:	48 8b 40 10          	mov    0x10(%rax),%rax
   1400064b9:	48 83 f8 08          	cmp    $0x8,%rax
   1400064bd:	74 23                	je     1400064e2 <main2+0x2b03>
   1400064bf:	41 b8 95 04 00 00    	mov    $0x495,%r8d
   1400064c5:	48 8d 05 84 cb 00 00 	lea    0xcb84(%rip),%rax        # 140013050 <.rdata>
   1400064cc:	48 89 c2             	mov    %rax,%rdx
   1400064cf:	48 8d 05 e2 d7 00 00 	lea    0xd7e2(%rip),%rax        # 140013cb8 <.rdata+0xc68>
   1400064d6:	48 89 c1             	mov    %rax,%rcx
   1400064d9:	48 8b 05 60 4e 01 00 	mov    0x14e60(%rip),%rax        # 14001b340 <__imp__assert>
   1400064e0:	ff d0                	call   *%rax
   1400064e2:	b9 01 00 00 00       	mov    $0x1,%ecx
   1400064e7:	48 8b 05 da 4d 01 00 	mov    0x14dda(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   1400064ee:	ff d0                	call   *%rax
   1400064f0:	48 89 c2             	mov    %rax,%rdx
   1400064f3:	48 8b 85 20 03 00 00 	mov    0x320(%rbp),%rax
   1400064fa:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140006501:	00 00 
   140006503:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140006509:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000650f:	48 89 c1             	mov    %rax,%rcx
   140006512:	e8 c7 cd ff ff       	call   1400032de <type__print>
   140006517:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000651b:	4c 8d 0d d4 cf 00 00 	lea    0xcfd4(%rip),%r9        # 1400134f6 <.rdata+0x4a6>
   140006522:	4c 8d 05 d3 d0 00 00 	lea    0xd0d3(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140006529:	ba 00 01 00 00       	mov    $0x100,%edx
   14000652e:	48 89 c1             	mov    %rax,%rcx
   140006531:	e8 9a b0 00 00       	call   1400115d0 <snprintf>
   140006536:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000653a:	48 c7 44 24 20 05 00 	movq   $0x5,0x20(%rsp)
   140006541:	00 00 
   140006543:	49 89 c1             	mov    %rax,%r9
   140006546:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000654c:	ba 16 00 00 00       	mov    $0x16,%edx
   140006551:	48 8d 05 f9 cc 00 00 	lea    0xccf9(%rip),%rax        # 140013251 <.rdata+0x201>
   140006558:	48 89 c1             	mov    %rax,%rcx
   14000655b:	e8 d0 b0 00 00       	call   140011630 <printf>
   140006560:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006564:	4c 8d 0d 8b cf 00 00 	lea    0xcf8b(%rip),%r9        # 1400134f6 <.rdata+0x4a6>
   14000656b:	4c 8d 05 97 d0 00 00 	lea    0xd097(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140006572:	ba 00 01 00 00       	mov    $0x100,%edx
   140006577:	48 89 c1             	mov    %rax,%rcx
   14000657a:	e8 51 b0 00 00       	call   1400115d0 <snprintf>
   14000657f:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006583:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   14000658a:	00 00 
   14000658c:	49 89 c1             	mov    %rax,%r9
   14000658f:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140006595:	ba 16 00 00 00       	mov    $0x16,%edx
   14000659a:	48 8d 05 b0 cc 00 00 	lea    0xccb0(%rip),%rax        # 140013251 <.rdata+0x201>
   1400065a1:	48 89 c1             	mov    %rax,%rcx
   1400065a4:	e8 87 b0 00 00       	call   140011630 <printf>
   1400065a9:	b9 0a 00 00 00       	mov    $0xa,%ecx
   1400065ae:	e8 dd b4 00 00       	call   140011a90 <putchar>
   1400065b3:	48 8b 85 20 03 00 00 	mov    0x320(%rbp),%rax
   1400065ba:	48 89 c1             	mov    %rax,%rcx
   1400065bd:	e8 a9 bb ff ff       	call   14000216b <type__size>
   1400065c2:	48 83 f8 05          	cmp    $0x5,%rax
   1400065c6:	74 23                	je     1400065eb <main2+0x2c0c>
   1400065c8:	41 b8 96 04 00 00    	mov    $0x496,%r8d
   1400065ce:	48 8d 05 7b ca 00 00 	lea    0xca7b(%rip),%rax        # 140013050 <.rdata>
   1400065d5:	48 89 c2             	mov    %rax,%rdx
   1400065d8:	48 8d 05 01 d7 00 00 	lea    0xd701(%rip),%rax        # 140013ce0 <.rdata+0xc90>
   1400065df:	48 89 c1             	mov    %rax,%rcx
   1400065e2:	48 8b 05 57 4d 01 00 	mov    0x14d57(%rip),%rax        # 14001b340 <__imp__assert>
   1400065e9:	ff d0                	call   *%rax
   1400065eb:	48 8b 85 20 03 00 00 	mov    0x320(%rbp),%rax
   1400065f2:	48 8b 40 10          	mov    0x10(%rax),%rax
   1400065f6:	48 83 f8 01          	cmp    $0x1,%rax
   1400065fa:	74 23                	je     14000661f <main2+0x2c40>
   1400065fc:	41 b8 96 04 00 00    	mov    $0x496,%r8d
   140006602:	48 8d 05 47 ca 00 00 	lea    0xca47(%rip),%rax        # 140013050 <.rdata>
   140006609:	48 89 c2             	mov    %rax,%rdx
   14000660c:	48 8d 05 fd d6 00 00 	lea    0xd6fd(%rip),%rax        # 140013d10 <.rdata+0xcc0>
   140006613:	48 89 c1             	mov    %rax,%rcx
   140006616:	48 8b 05 23 4d 01 00 	mov    0x14d23(%rip),%rax        # 14001b340 <__imp__assert>
   14000661d:	ff d0                	call   *%rax
   14000661f:	b9 01 00 00 00       	mov    $0x1,%ecx
   140006624:	48 8b 05 9d 4c 01 00 	mov    0x14c9d(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   14000662b:	ff d0                	call   *%rax
   14000662d:	48 89 c2             	mov    %rax,%rdx
   140006630:	48 8b 85 18 03 00 00 	mov    0x318(%rbp),%rax
   140006637:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000663e:	00 00 
   140006640:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140006646:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000664c:	48 89 c1             	mov    %rax,%rcx
   14000664f:	e8 8a cc ff ff       	call   1400032de <type__print>
   140006654:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006658:	4c 8d 0d 99 ce 00 00 	lea    0xce99(%rip),%r9        # 1400134f8 <.rdata+0x4a8>
   14000665f:	4c 8d 05 96 cf 00 00 	lea    0xcf96(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140006666:	ba 00 01 00 00       	mov    $0x100,%edx
   14000666b:	48 89 c1             	mov    %rax,%rcx
   14000666e:	e8 5d af 00 00       	call   1400115d0 <snprintf>
   140006673:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006677:	48 c7 44 24 20 00 04 	movq   $0x400,0x20(%rsp)
   14000667e:	00 00 
   140006680:	49 89 c1             	mov    %rax,%r9
   140006683:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140006689:	ba 16 00 00 00       	mov    $0x16,%edx
   14000668e:	48 8d 05 bc cb 00 00 	lea    0xcbbc(%rip),%rax        # 140013251 <.rdata+0x201>
   140006695:	48 89 c1             	mov    %rax,%rcx
   140006698:	e8 93 af 00 00       	call   140011630 <printf>
   14000669d:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400066a1:	4c 8d 0d 50 ce 00 00 	lea    0xce50(%rip),%r9        # 1400134f8 <.rdata+0x4a8>
   1400066a8:	4c 8d 05 5a cf 00 00 	lea    0xcf5a(%rip),%r8        # 140013609 <.rdata+0x5b9>
   1400066af:	ba 00 01 00 00       	mov    $0x100,%edx
   1400066b4:	48 89 c1             	mov    %rax,%rcx
   1400066b7:	e8 14 af 00 00       	call   1400115d0 <snprintf>
   1400066bc:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400066c0:	48 c7 44 24 20 00 04 	movq   $0x400,0x20(%rsp)
   1400066c7:	00 00 
   1400066c9:	49 89 c1             	mov    %rax,%r9
   1400066cc:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400066d2:	ba 16 00 00 00       	mov    $0x16,%edx
   1400066d7:	48 8d 05 73 cb 00 00 	lea    0xcb73(%rip),%rax        # 140013251 <.rdata+0x201>
   1400066de:	48 89 c1             	mov    %rax,%rcx
   1400066e1:	e8 4a af 00 00       	call   140011630 <printf>
   1400066e6:	b9 0a 00 00 00       	mov    $0xa,%ecx
   1400066eb:	e8 a0 b3 00 00       	call   140011a90 <putchar>
   1400066f0:	48 8b 85 18 03 00 00 	mov    0x318(%rbp),%rax
   1400066f7:	48 89 c1             	mov    %rax,%rcx
   1400066fa:	e8 6c ba ff ff       	call   14000216b <type__size>
   1400066ff:	48 3d 00 04 00 00    	cmp    $0x400,%rax
   140006705:	74 23                	je     14000672a <main2+0x2d4b>
   140006707:	41 b8 97 04 00 00    	mov    $0x497,%r8d
   14000670d:	48 8d 05 3c c9 00 00 	lea    0xc93c(%rip),%rax        # 140013050 <.rdata>
   140006714:	48 89 c2             	mov    %rax,%rdx
   140006717:	48 8d 05 1a d6 00 00 	lea    0xd61a(%rip),%rax        # 140013d38 <.rdata+0xce8>
   14000671e:	48 89 c1             	mov    %rax,%rcx
   140006721:	48 8b 05 18 4c 01 00 	mov    0x14c18(%rip),%rax        # 14001b340 <__imp__assert>
   140006728:	ff d0                	call   *%rax
   14000672a:	48 8b 85 18 03 00 00 	mov    0x318(%rbp),%rax
   140006731:	48 8b 40 10          	mov    0x10(%rax),%rax
   140006735:	48 3d 00 04 00 00    	cmp    $0x400,%rax
   14000673b:	74 23                	je     140006760 <main2+0x2d81>
   14000673d:	41 b8 97 04 00 00    	mov    $0x497,%r8d
   140006743:	48 8d 05 06 c9 00 00 	lea    0xc906(%rip),%rax        # 140013050 <.rdata>
   14000674a:	48 89 c2             	mov    %rax,%rdx
   14000674d:	48 8d 05 14 d6 00 00 	lea    0xd614(%rip),%rax        # 140013d68 <.rdata+0xd18>
   140006754:	48 89 c1             	mov    %rax,%rcx
   140006757:	48 8b 05 e2 4b 01 00 	mov    0x14be2(%rip),%rax        # 14001b340 <__imp__assert>
   14000675e:	ff d0                	call   *%rax
   140006760:	b9 01 00 00 00       	mov    $0x1,%ecx
   140006765:	48 8b 05 5c 4b 01 00 	mov    0x14b5c(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   14000676c:	ff d0                	call   *%rax
   14000676e:	48 89 c2             	mov    %rax,%rdx
   140006771:	48 8b 85 10 03 00 00 	mov    0x310(%rbp),%rax
   140006778:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000677f:	00 00 
   140006781:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140006787:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000678d:	48 89 c1             	mov    %rax,%rcx
   140006790:	e8 49 cb ff ff       	call   1400032de <type__print>
   140006795:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006799:	4c 8d 0d 5a cd 00 00 	lea    0xcd5a(%rip),%r9        # 1400134fa <.rdata+0x4aa>
   1400067a0:	4c 8d 05 55 ce 00 00 	lea    0xce55(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   1400067a7:	ba 00 01 00 00       	mov    $0x100,%edx
   1400067ac:	48 89 c1             	mov    %rax,%rcx
   1400067af:	e8 1c ae 00 00       	call   1400115d0 <snprintf>
   1400067b4:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400067b8:	48 c7 44 24 20 28 05 	movq   $0x528,0x20(%rsp)
   1400067bf:	00 00 
   1400067c1:	49 89 c1             	mov    %rax,%r9
   1400067c4:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400067ca:	ba 16 00 00 00       	mov    $0x16,%edx
   1400067cf:	48 8d 05 7b ca 00 00 	lea    0xca7b(%rip),%rax        # 140013251 <.rdata+0x201>
   1400067d6:	48 89 c1             	mov    %rax,%rcx
   1400067d9:	e8 52 ae 00 00       	call   140011630 <printf>
   1400067de:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400067e2:	4c 8d 0d 11 cd 00 00 	lea    0xcd11(%rip),%r9        # 1400134fa <.rdata+0x4aa>
   1400067e9:	4c 8d 05 19 ce 00 00 	lea    0xce19(%rip),%r8        # 140013609 <.rdata+0x5b9>
   1400067f0:	ba 00 01 00 00       	mov    $0x100,%edx
   1400067f5:	48 89 c1             	mov    %rax,%rcx
   1400067f8:	e8 d3 ad 00 00       	call   1400115d0 <snprintf>
   1400067fd:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006801:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140006808:	00 00 
   14000680a:	49 89 c1             	mov    %rax,%r9
   14000680d:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140006813:	ba 16 00 00 00       	mov    $0x16,%edx
   140006818:	48 8d 05 32 ca 00 00 	lea    0xca32(%rip),%rax        # 140013251 <.rdata+0x201>
   14000681f:	48 89 c1             	mov    %rax,%rcx
   140006822:	e8 09 ae 00 00       	call   140011630 <printf>
   140006827:	b9 0a 00 00 00       	mov    $0xa,%ecx
   14000682c:	e8 5f b2 00 00       	call   140011a90 <putchar>
   140006831:	48 8b 85 10 03 00 00 	mov    0x310(%rbp),%rax
   140006838:	48 89 c1             	mov    %rax,%rcx
   14000683b:	e8 2b b9 ff ff       	call   14000216b <type__size>
   140006840:	48 3d 28 05 00 00    	cmp    $0x528,%rax
   140006846:	74 23                	je     14000686b <main2+0x2e8c>
   140006848:	41 b8 98 04 00 00    	mov    $0x498,%r8d
   14000684e:	48 8d 05 fb c7 00 00 	lea    0xc7fb(%rip),%rax        # 140013050 <.rdata>
   140006855:	48 89 c2             	mov    %rax,%rdx
   140006858:	48 8d 05 31 d5 00 00 	lea    0xd531(%rip),%rax        # 140013d90 <.rdata+0xd40>
   14000685f:	48 89 c1             	mov    %rax,%rcx
   140006862:	48 8b 05 d7 4a 01 00 	mov    0x14ad7(%rip),%rax        # 14001b340 <__imp__assert>
   140006869:	ff d0                	call   *%rax
   14000686b:	48 8b 85 10 03 00 00 	mov    0x310(%rbp),%rax
   140006872:	48 8b 40 10          	mov    0x10(%rax),%rax
   140006876:	48 83 f8 01          	cmp    $0x1,%rax
   14000687a:	74 23                	je     14000689f <main2+0x2ec0>
   14000687c:	41 b8 98 04 00 00    	mov    $0x498,%r8d
   140006882:	48 8d 05 c7 c7 00 00 	lea    0xc7c7(%rip),%rax        # 140013050 <.rdata>
   140006889:	48 89 c2             	mov    %rax,%rdx
   14000688c:	48 8d 05 2d d5 00 00 	lea    0xd52d(%rip),%rax        # 140013dc0 <.rdata+0xd70>
   140006893:	48 89 c1             	mov    %rax,%rcx
   140006896:	48 8b 05 a3 4a 01 00 	mov    0x14aa3(%rip),%rax        # 14001b340 <__imp__assert>
   14000689d:	ff d0                	call   *%rax
   14000689f:	b9 01 00 00 00       	mov    $0x1,%ecx
   1400068a4:	48 8b 05 1d 4a 01 00 	mov    0x14a1d(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   1400068ab:	ff d0                	call   *%rax
   1400068ad:	48 89 c2             	mov    %rax,%rdx
   1400068b0:	48 8b 85 08 03 00 00 	mov    0x308(%rbp),%rax
   1400068b7:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   1400068be:	00 00 
   1400068c0:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   1400068c6:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   1400068cc:	48 89 c1             	mov    %rax,%rcx
   1400068cf:	e8 0a ca ff ff       	call   1400032de <type__print>
   1400068d4:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400068d8:	4c 8d 0d 1d cc 00 00 	lea    0xcc1d(%rip),%r9        # 1400134fc <.rdata+0x4ac>
   1400068df:	4c 8d 05 16 cd 00 00 	lea    0xcd16(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   1400068e6:	ba 00 01 00 00       	mov    $0x100,%edx
   1400068eb:	48 89 c1             	mov    %rax,%rcx
   1400068ee:	e8 dd ac 00 00       	call   1400115d0 <snprintf>
   1400068f3:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400068f7:	48 c7 44 24 20 06 00 	movq   $0x6,0x20(%rsp)
   1400068fe:	00 00 
   140006900:	49 89 c1             	mov    %rax,%r9
   140006903:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140006909:	ba 16 00 00 00       	mov    $0x16,%edx
   14000690e:	48 8d 05 3c c9 00 00 	lea    0xc93c(%rip),%rax        # 140013251 <.rdata+0x201>
   140006915:	48 89 c1             	mov    %rax,%rcx
   140006918:	e8 13 ad 00 00       	call   140011630 <printf>
   14000691d:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006921:	4c 8d 0d d4 cb 00 00 	lea    0xcbd4(%rip),%r9        # 1400134fc <.rdata+0x4ac>
   140006928:	4c 8d 05 da cc 00 00 	lea    0xccda(%rip),%r8        # 140013609 <.rdata+0x5b9>
   14000692f:	ba 00 01 00 00       	mov    $0x100,%edx
   140006934:	48 89 c1             	mov    %rax,%rcx
   140006937:	e8 94 ac 00 00       	call   1400115d0 <snprintf>
   14000693c:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006940:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140006947:	00 00 
   140006949:	49 89 c1             	mov    %rax,%r9
   14000694c:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140006952:	ba 16 00 00 00       	mov    $0x16,%edx
   140006957:	48 8d 05 f3 c8 00 00 	lea    0xc8f3(%rip),%rax        # 140013251 <.rdata+0x201>
   14000695e:	48 89 c1             	mov    %rax,%rcx
   140006961:	e8 ca ac 00 00       	call   140011630 <printf>
   140006966:	b9 0a 00 00 00       	mov    $0xa,%ecx
   14000696b:	e8 20 b1 00 00       	call   140011a90 <putchar>
   140006970:	48 8b 85 08 03 00 00 	mov    0x308(%rbp),%rax
   140006977:	48 89 c1             	mov    %rax,%rcx
   14000697a:	e8 ec b7 ff ff       	call   14000216b <type__size>
   14000697f:	48 83 f8 06          	cmp    $0x6,%rax
   140006983:	74 23                	je     1400069a8 <main2+0x2fc9>
   140006985:	41 b8 99 04 00 00    	mov    $0x499,%r8d
   14000698b:	48 8d 05 be c6 00 00 	lea    0xc6be(%rip),%rax        # 140013050 <.rdata>
   140006992:	48 89 c2             	mov    %rax,%rdx
   140006995:	48 8d 05 4c d4 00 00 	lea    0xd44c(%rip),%rax        # 140013de8 <.rdata+0xd98>
   14000699c:	48 89 c1             	mov    %rax,%rcx
   14000699f:	48 8b 05 9a 49 01 00 	mov    0x1499a(%rip),%rax        # 14001b340 <__imp__assert>
   1400069a6:	ff d0                	call   *%rax
   1400069a8:	48 8b 85 08 03 00 00 	mov    0x308(%rbp),%rax
   1400069af:	48 8b 40 10          	mov    0x10(%rax),%rax
   1400069b3:	48 83 f8 01          	cmp    $0x1,%rax
   1400069b7:	74 23                	je     1400069dc <main2+0x2ffd>
   1400069b9:	41 b8 99 04 00 00    	mov    $0x499,%r8d
   1400069bf:	48 8d 05 8a c6 00 00 	lea    0xc68a(%rip),%rax        # 140013050 <.rdata>
   1400069c6:	48 89 c2             	mov    %rax,%rdx
   1400069c9:	48 8d 05 48 d4 00 00 	lea    0xd448(%rip),%rax        # 140013e18 <.rdata+0xdc8>
   1400069d0:	48 89 c1             	mov    %rax,%rcx
   1400069d3:	48 8b 05 66 49 01 00 	mov    0x14966(%rip),%rax        # 14001b340 <__imp__assert>
   1400069da:	ff d0                	call   *%rax
   1400069dc:	b9 01 00 00 00       	mov    $0x1,%ecx
   1400069e1:	48 8b 05 e0 48 01 00 	mov    0x148e0(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   1400069e8:	ff d0                	call   *%rax
   1400069ea:	48 89 c2             	mov    %rax,%rdx
   1400069ed:	48 8b 85 00 03 00 00 	mov    0x300(%rbp),%rax
   1400069f4:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   1400069fb:	00 00 
   1400069fd:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140006a03:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140006a09:	48 89 c1             	mov    %rax,%rcx
   140006a0c:	e8 cd c8 ff ff       	call   1400032de <type__print>
   140006a11:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006a15:	4c 8d 0d e2 ca 00 00 	lea    0xcae2(%rip),%r9        # 1400134fe <.rdata+0x4ae>
   140006a1c:	4c 8d 05 d9 cb 00 00 	lea    0xcbd9(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140006a23:	ba 00 01 00 00       	mov    $0x100,%edx
   140006a28:	48 89 c1             	mov    %rax,%rcx
   140006a2b:	e8 a0 ab 00 00       	call   1400115d0 <snprintf>
   140006a30:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006a34:	48 c7 44 24 20 49 00 	movq   $0x49,0x20(%rsp)
   140006a3b:	00 00 
   140006a3d:	49 89 c1             	mov    %rax,%r9
   140006a40:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140006a46:	ba 16 00 00 00       	mov    $0x16,%edx
   140006a4b:	48 8d 05 ff c7 00 00 	lea    0xc7ff(%rip),%rax        # 140013251 <.rdata+0x201>
   140006a52:	48 89 c1             	mov    %rax,%rcx
   140006a55:	e8 d6 ab 00 00       	call   140011630 <printf>
   140006a5a:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006a5e:	4c 8d 0d 99 ca 00 00 	lea    0xca99(%rip),%r9        # 1400134fe <.rdata+0x4ae>
   140006a65:	4c 8d 05 9d cb 00 00 	lea    0xcb9d(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140006a6c:	ba 00 01 00 00       	mov    $0x100,%edx
   140006a71:	48 89 c1             	mov    %rax,%rcx
   140006a74:	e8 57 ab 00 00       	call   1400115d0 <snprintf>
   140006a79:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006a7d:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140006a84:	00 00 
   140006a86:	49 89 c1             	mov    %rax,%r9
   140006a89:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140006a8f:	ba 16 00 00 00       	mov    $0x16,%edx
   140006a94:	48 8d 05 b6 c7 00 00 	lea    0xc7b6(%rip),%rax        # 140013251 <.rdata+0x201>
   140006a9b:	48 89 c1             	mov    %rax,%rcx
   140006a9e:	e8 8d ab 00 00       	call   140011630 <printf>
   140006aa3:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140006aa8:	e8 e3 af 00 00       	call   140011a90 <putchar>
   140006aad:	48 8b 85 00 03 00 00 	mov    0x300(%rbp),%rax
   140006ab4:	48 89 c1             	mov    %rax,%rcx
   140006ab7:	e8 af b6 ff ff       	call   14000216b <type__size>
   140006abc:	48 83 f8 49          	cmp    $0x49,%rax
   140006ac0:	74 23                	je     140006ae5 <main2+0x3106>
   140006ac2:	41 b8 9a 04 00 00    	mov    $0x49a,%r8d
   140006ac8:	48 8d 05 81 c5 00 00 	lea    0xc581(%rip),%rax        # 140013050 <.rdata>
   140006acf:	48 89 c2             	mov    %rax,%rdx
   140006ad2:	48 8d 05 67 d3 00 00 	lea    0xd367(%rip),%rax        # 140013e40 <.rdata+0xdf0>
   140006ad9:	48 89 c1             	mov    %rax,%rcx
   140006adc:	48 8b 05 5d 48 01 00 	mov    0x1485d(%rip),%rax        # 14001b340 <__imp__assert>
   140006ae3:	ff d0                	call   *%rax
   140006ae5:	48 8b 85 00 03 00 00 	mov    0x300(%rbp),%rax
   140006aec:	48 8b 40 10          	mov    0x10(%rax),%rax
   140006af0:	48 83 f8 01          	cmp    $0x1,%rax
   140006af4:	74 23                	je     140006b19 <main2+0x313a>
   140006af6:	41 b8 9a 04 00 00    	mov    $0x49a,%r8d
   140006afc:	48 8d 05 4d c5 00 00 	lea    0xc54d(%rip),%rax        # 140013050 <.rdata>
   140006b03:	48 89 c2             	mov    %rax,%rdx
   140006b06:	48 8d 05 63 d3 00 00 	lea    0xd363(%rip),%rax        # 140013e70 <.rdata+0xe20>
   140006b0d:	48 89 c1             	mov    %rax,%rcx
   140006b10:	48 8b 05 29 48 01 00 	mov    0x14829(%rip),%rax        # 14001b340 <__imp__assert>
   140006b17:	ff d0                	call   *%rax
   140006b19:	b9 01 00 00 00       	mov    $0x1,%ecx
   140006b1e:	48 8b 05 a3 47 01 00 	mov    0x147a3(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140006b25:	ff d0                	call   *%rax
   140006b27:	48 89 c2             	mov    %rax,%rdx
   140006b2a:	48 8b 85 f8 02 00 00 	mov    0x2f8(%rbp),%rax
   140006b31:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140006b38:	00 00 
   140006b3a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140006b40:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140006b46:	48 89 c1             	mov    %rax,%rcx
   140006b49:	e8 90 c7 ff ff       	call   1400032de <type__print>
   140006b4e:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006b52:	4c 8d 0d a7 c9 00 00 	lea    0xc9a7(%rip),%r9        # 140013500 <.rdata+0x4b0>
   140006b59:	4c 8d 05 9c ca 00 00 	lea    0xca9c(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140006b60:	ba 00 01 00 00       	mov    $0x100,%edx
   140006b65:	48 89 c1             	mov    %rax,%rcx
   140006b68:	e8 63 aa 00 00       	call   1400115d0 <snprintf>
   140006b6d:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006b71:	48 c7 44 24 20 49 00 	movq   $0x49,0x20(%rsp)
   140006b78:	00 00 
   140006b7a:	49 89 c1             	mov    %rax,%r9
   140006b7d:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140006b83:	ba 16 00 00 00       	mov    $0x16,%edx
   140006b88:	48 8d 05 c2 c6 00 00 	lea    0xc6c2(%rip),%rax        # 140013251 <.rdata+0x201>
   140006b8f:	48 89 c1             	mov    %rax,%rcx
   140006b92:	e8 99 aa 00 00       	call   140011630 <printf>
   140006b97:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006b9b:	4c 8d 0d 5e c9 00 00 	lea    0xc95e(%rip),%r9        # 140013500 <.rdata+0x4b0>
   140006ba2:	4c 8d 05 60 ca 00 00 	lea    0xca60(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140006ba9:	ba 00 01 00 00       	mov    $0x100,%edx
   140006bae:	48 89 c1             	mov    %rax,%rcx
   140006bb1:	e8 1a aa 00 00       	call   1400115d0 <snprintf>
   140006bb6:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006bba:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140006bc1:	00 00 
   140006bc3:	49 89 c1             	mov    %rax,%r9
   140006bc6:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140006bcc:	ba 16 00 00 00       	mov    $0x16,%edx
   140006bd1:	48 8d 05 79 c6 00 00 	lea    0xc679(%rip),%rax        # 140013251 <.rdata+0x201>
   140006bd8:	48 89 c1             	mov    %rax,%rcx
   140006bdb:	e8 50 aa 00 00       	call   140011630 <printf>
   140006be0:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140006be5:	e8 a6 ae 00 00       	call   140011a90 <putchar>
   140006bea:	48 8b 85 f8 02 00 00 	mov    0x2f8(%rbp),%rax
   140006bf1:	48 89 c1             	mov    %rax,%rcx
   140006bf4:	e8 72 b5 ff ff       	call   14000216b <type__size>
   140006bf9:	48 83 f8 49          	cmp    $0x49,%rax
   140006bfd:	74 23                	je     140006c22 <main2+0x3243>
   140006bff:	41 b8 9b 04 00 00    	mov    $0x49b,%r8d
   140006c05:	48 8d 05 44 c4 00 00 	lea    0xc444(%rip),%rax        # 140013050 <.rdata>
   140006c0c:	48 89 c2             	mov    %rax,%rdx
   140006c0f:	48 8d 05 82 d2 00 00 	lea    0xd282(%rip),%rax        # 140013e98 <.rdata+0xe48>
   140006c16:	48 89 c1             	mov    %rax,%rcx
   140006c19:	48 8b 05 20 47 01 00 	mov    0x14720(%rip),%rax        # 14001b340 <__imp__assert>
   140006c20:	ff d0                	call   *%rax
   140006c22:	48 8b 85 f8 02 00 00 	mov    0x2f8(%rbp),%rax
   140006c29:	48 8b 40 10          	mov    0x10(%rax),%rax
   140006c2d:	48 83 f8 01          	cmp    $0x1,%rax
   140006c31:	74 23                	je     140006c56 <main2+0x3277>
   140006c33:	41 b8 9b 04 00 00    	mov    $0x49b,%r8d
   140006c39:	48 8d 05 10 c4 00 00 	lea    0xc410(%rip),%rax        # 140013050 <.rdata>
   140006c40:	48 89 c2             	mov    %rax,%rdx
   140006c43:	48 8d 05 7e d2 00 00 	lea    0xd27e(%rip),%rax        # 140013ec8 <.rdata+0xe78>
   140006c4a:	48 89 c1             	mov    %rax,%rcx
   140006c4d:	48 8b 05 ec 46 01 00 	mov    0x146ec(%rip),%rax        # 14001b340 <__imp__assert>
   140006c54:	ff d0                	call   *%rax
   140006c56:	b9 01 00 00 00       	mov    $0x1,%ecx
   140006c5b:	48 8b 05 66 46 01 00 	mov    0x14666(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140006c62:	ff d0                	call   *%rax
   140006c64:	48 89 c2             	mov    %rax,%rdx
   140006c67:	48 8b 85 f0 02 00 00 	mov    0x2f0(%rbp),%rax
   140006c6e:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140006c75:	00 00 
   140006c77:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140006c7d:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140006c83:	48 89 c1             	mov    %rax,%rcx
   140006c86:	e8 53 c6 ff ff       	call   1400032de <type__print>
   140006c8b:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006c8f:	4c 8d 0d 6c c8 00 00 	lea    0xc86c(%rip),%r9        # 140013502 <.rdata+0x4b2>
   140006c96:	4c 8d 05 5f c9 00 00 	lea    0xc95f(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140006c9d:	ba 00 01 00 00       	mov    $0x100,%edx
   140006ca2:	48 89 c1             	mov    %rax,%rcx
   140006ca5:	e8 26 a9 00 00       	call   1400115d0 <snprintf>
   140006caa:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006cae:	48 c7 44 24 20 54 00 	movq   $0x54,0x20(%rsp)
   140006cb5:	00 00 
   140006cb7:	49 89 c1             	mov    %rax,%r9
   140006cba:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140006cc0:	ba 16 00 00 00       	mov    $0x16,%edx
   140006cc5:	48 8d 05 85 c5 00 00 	lea    0xc585(%rip),%rax        # 140013251 <.rdata+0x201>
   140006ccc:	48 89 c1             	mov    %rax,%rcx
   140006ccf:	e8 5c a9 00 00       	call   140011630 <printf>
   140006cd4:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006cd8:	4c 8d 0d 23 c8 00 00 	lea    0xc823(%rip),%r9        # 140013502 <.rdata+0x4b2>
   140006cdf:	4c 8d 05 23 c9 00 00 	lea    0xc923(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140006ce6:	ba 00 01 00 00       	mov    $0x100,%edx
   140006ceb:	48 89 c1             	mov    %rax,%rcx
   140006cee:	e8 dd a8 00 00       	call   1400115d0 <snprintf>
   140006cf3:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006cf7:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140006cfe:	00 00 
   140006d00:	49 89 c1             	mov    %rax,%r9
   140006d03:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140006d09:	ba 16 00 00 00       	mov    $0x16,%edx
   140006d0e:	48 8d 05 3c c5 00 00 	lea    0xc53c(%rip),%rax        # 140013251 <.rdata+0x201>
   140006d15:	48 89 c1             	mov    %rax,%rcx
   140006d18:	e8 13 a9 00 00       	call   140011630 <printf>
   140006d1d:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140006d22:	e8 69 ad 00 00       	call   140011a90 <putchar>
   140006d27:	48 8b 85 f0 02 00 00 	mov    0x2f0(%rbp),%rax
   140006d2e:	48 89 c1             	mov    %rax,%rcx
   140006d31:	e8 35 b4 ff ff       	call   14000216b <type__size>
   140006d36:	48 83 f8 54          	cmp    $0x54,%rax
   140006d3a:	74 23                	je     140006d5f <main2+0x3380>
   140006d3c:	41 b8 9c 04 00 00    	mov    $0x49c,%r8d
   140006d42:	48 8d 05 07 c3 00 00 	lea    0xc307(%rip),%rax        # 140013050 <.rdata>
   140006d49:	48 89 c2             	mov    %rax,%rdx
   140006d4c:	48 8d 05 9d d1 00 00 	lea    0xd19d(%rip),%rax        # 140013ef0 <.rdata+0xea0>
   140006d53:	48 89 c1             	mov    %rax,%rcx
   140006d56:	48 8b 05 e3 45 01 00 	mov    0x145e3(%rip),%rax        # 14001b340 <__imp__assert>
   140006d5d:	ff d0                	call   *%rax
   140006d5f:	48 8b 85 f0 02 00 00 	mov    0x2f0(%rbp),%rax
   140006d66:	48 8b 40 10          	mov    0x10(%rax),%rax
   140006d6a:	48 83 f8 01          	cmp    $0x1,%rax
   140006d6e:	74 23                	je     140006d93 <main2+0x33b4>
   140006d70:	41 b8 9c 04 00 00    	mov    $0x49c,%r8d
   140006d76:	48 8d 05 d3 c2 00 00 	lea    0xc2d3(%rip),%rax        # 140013050 <.rdata>
   140006d7d:	48 89 c2             	mov    %rax,%rdx
   140006d80:	48 8d 05 99 d1 00 00 	lea    0xd199(%rip),%rax        # 140013f20 <.rdata+0xed0>
   140006d87:	48 89 c1             	mov    %rax,%rcx
   140006d8a:	48 8b 05 af 45 01 00 	mov    0x145af(%rip),%rax        # 14001b340 <__imp__assert>
   140006d91:	ff d0                	call   *%rax
   140006d93:	b9 01 00 00 00       	mov    $0x1,%ecx
   140006d98:	48 8b 05 29 45 01 00 	mov    0x14529(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140006d9f:	ff d0                	call   *%rax
   140006da1:	48 89 c2             	mov    %rax,%rdx
   140006da4:	48 8b 85 e8 02 00 00 	mov    0x2e8(%rbp),%rax
   140006dab:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140006db2:	00 00 
   140006db4:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140006dba:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140006dc0:	48 89 c1             	mov    %rax,%rcx
   140006dc3:	e8 16 c5 ff ff       	call   1400032de <type__print>
   140006dc8:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006dcc:	4c 8d 0d 31 c7 00 00 	lea    0xc731(%rip),%r9        # 140013504 <.rdata+0x4b4>
   140006dd3:	4c 8d 05 22 c8 00 00 	lea    0xc822(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140006dda:	ba 00 01 00 00       	mov    $0x100,%edx
   140006ddf:	48 89 c1             	mov    %rax,%rcx
   140006de2:	e8 e9 a7 00 00       	call   1400115d0 <snprintf>
   140006de7:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006deb:	48 c7 44 24 20 44 04 	movq   $0x444,0x20(%rsp)
   140006df2:	00 00 
   140006df4:	49 89 c1             	mov    %rax,%r9
   140006df7:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140006dfd:	ba 16 00 00 00       	mov    $0x16,%edx
   140006e02:	48 8d 05 48 c4 00 00 	lea    0xc448(%rip),%rax        # 140013251 <.rdata+0x201>
   140006e09:	48 89 c1             	mov    %rax,%rcx
   140006e0c:	e8 1f a8 00 00       	call   140011630 <printf>
   140006e11:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006e15:	4c 8d 0d e8 c6 00 00 	lea    0xc6e8(%rip),%r9        # 140013504 <.rdata+0x4b4>
   140006e1c:	4c 8d 05 e6 c7 00 00 	lea    0xc7e6(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140006e23:	ba 00 01 00 00       	mov    $0x100,%edx
   140006e28:	48 89 c1             	mov    %rax,%rcx
   140006e2b:	e8 a0 a7 00 00       	call   1400115d0 <snprintf>
   140006e30:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006e34:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140006e3b:	00 00 
   140006e3d:	49 89 c1             	mov    %rax,%r9
   140006e40:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140006e46:	ba 16 00 00 00       	mov    $0x16,%edx
   140006e4b:	48 8d 05 ff c3 00 00 	lea    0xc3ff(%rip),%rax        # 140013251 <.rdata+0x201>
   140006e52:	48 89 c1             	mov    %rax,%rcx
   140006e55:	e8 d6 a7 00 00       	call   140011630 <printf>
   140006e5a:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140006e5f:	e8 2c ac 00 00       	call   140011a90 <putchar>
   140006e64:	48 8b 85 e8 02 00 00 	mov    0x2e8(%rbp),%rax
   140006e6b:	48 89 c1             	mov    %rax,%rcx
   140006e6e:	e8 f8 b2 ff ff       	call   14000216b <type__size>
   140006e73:	48 3d 44 04 00 00    	cmp    $0x444,%rax
   140006e79:	74 23                	je     140006e9e <main2+0x34bf>
   140006e7b:	41 b8 9d 04 00 00    	mov    $0x49d,%r8d
   140006e81:	48 8d 05 c8 c1 00 00 	lea    0xc1c8(%rip),%rax        # 140013050 <.rdata>
   140006e88:	48 89 c2             	mov    %rax,%rdx
   140006e8b:	48 8d 05 b6 d0 00 00 	lea    0xd0b6(%rip),%rax        # 140013f48 <.rdata+0xef8>
   140006e92:	48 89 c1             	mov    %rax,%rcx
   140006e95:	48 8b 05 a4 44 01 00 	mov    0x144a4(%rip),%rax        # 14001b340 <__imp__assert>
   140006e9c:	ff d0                	call   *%rax
   140006e9e:	48 8b 85 e8 02 00 00 	mov    0x2e8(%rbp),%rax
   140006ea5:	48 8b 40 10          	mov    0x10(%rax),%rax
   140006ea9:	48 83 f8 01          	cmp    $0x1,%rax
   140006ead:	74 23                	je     140006ed2 <main2+0x34f3>
   140006eaf:	41 b8 9d 04 00 00    	mov    $0x49d,%r8d
   140006eb5:	48 8d 05 94 c1 00 00 	lea    0xc194(%rip),%rax        # 140013050 <.rdata>
   140006ebc:	48 89 c2             	mov    %rax,%rdx
   140006ebf:	48 8d 05 b2 d0 00 00 	lea    0xd0b2(%rip),%rax        # 140013f78 <.rdata+0xf28>
   140006ec6:	48 89 c1             	mov    %rax,%rcx
   140006ec9:	48 8b 05 70 44 01 00 	mov    0x14470(%rip),%rax        # 14001b340 <__imp__assert>
   140006ed0:	ff d0                	call   *%rax
   140006ed2:	b9 01 00 00 00       	mov    $0x1,%ecx
   140006ed7:	48 8b 05 ea 43 01 00 	mov    0x143ea(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140006ede:	ff d0                	call   *%rax
   140006ee0:	48 89 c2             	mov    %rax,%rdx
   140006ee3:	48 8b 85 e0 02 00 00 	mov    0x2e0(%rbp),%rax
   140006eea:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140006ef1:	00 00 
   140006ef3:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140006ef9:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140006eff:	48 89 c1             	mov    %rax,%rcx
   140006f02:	e8 d7 c3 ff ff       	call   1400032de <type__print>
   140006f07:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006f0b:	4c 8d 0d f4 c5 00 00 	lea    0xc5f4(%rip),%r9        # 140013506 <.rdata+0x4b6>
   140006f12:	4c 8d 05 e3 c6 00 00 	lea    0xc6e3(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140006f19:	ba 00 01 00 00       	mov    $0x100,%edx
   140006f1e:	48 89 c1             	mov    %rax,%rcx
   140006f21:	e8 aa a6 00 00       	call   1400115d0 <snprintf>
   140006f26:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006f2a:	48 c7 44 24 20 ec 04 	movq   $0x4ec,0x20(%rsp)
   140006f31:	00 00 
   140006f33:	49 89 c1             	mov    %rax,%r9
   140006f36:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140006f3c:	ba 16 00 00 00       	mov    $0x16,%edx
   140006f41:	48 8d 05 09 c3 00 00 	lea    0xc309(%rip),%rax        # 140013251 <.rdata+0x201>
   140006f48:	48 89 c1             	mov    %rax,%rcx
   140006f4b:	e8 e0 a6 00 00       	call   140011630 <printf>
   140006f50:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006f54:	4c 8d 0d ab c5 00 00 	lea    0xc5ab(%rip),%r9        # 140013506 <.rdata+0x4b6>
   140006f5b:	4c 8d 05 a7 c6 00 00 	lea    0xc6a7(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140006f62:	ba 00 01 00 00       	mov    $0x100,%edx
   140006f67:	48 89 c1             	mov    %rax,%rcx
   140006f6a:	e8 61 a6 00 00       	call   1400115d0 <snprintf>
   140006f6f:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140006f73:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   140006f7a:	00 00 
   140006f7c:	49 89 c1             	mov    %rax,%r9
   140006f7f:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140006f85:	ba 16 00 00 00       	mov    $0x16,%edx
   140006f8a:	48 8d 05 c0 c2 00 00 	lea    0xc2c0(%rip),%rax        # 140013251 <.rdata+0x201>
   140006f91:	48 89 c1             	mov    %rax,%rcx
   140006f94:	e8 97 a6 00 00       	call   140011630 <printf>
   140006f99:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140006f9e:	e8 ed aa 00 00       	call   140011a90 <putchar>
   140006fa3:	48 8b 85 e0 02 00 00 	mov    0x2e0(%rbp),%rax
   140006faa:	48 89 c1             	mov    %rax,%rcx
   140006fad:	e8 b9 b1 ff ff       	call   14000216b <type__size>
   140006fb2:	48 3d ec 04 00 00    	cmp    $0x4ec,%rax
   140006fb8:	74 23                	je     140006fdd <main2+0x35fe>
   140006fba:	41 b8 9e 04 00 00    	mov    $0x49e,%r8d
   140006fc0:	48 8d 05 89 c0 00 00 	lea    0xc089(%rip),%rax        # 140013050 <.rdata>
   140006fc7:	48 89 c2             	mov    %rax,%rdx
   140006fca:	48 8d 05 cf cf 00 00 	lea    0xcfcf(%rip),%rax        # 140013fa0 <.rdata+0xf50>
   140006fd1:	48 89 c1             	mov    %rax,%rcx
   140006fd4:	48 8b 05 65 43 01 00 	mov    0x14365(%rip),%rax        # 14001b340 <__imp__assert>
   140006fdb:	ff d0                	call   *%rax
   140006fdd:	48 8b 85 e0 02 00 00 	mov    0x2e0(%rbp),%rax
   140006fe4:	48 8b 40 10          	mov    0x10(%rax),%rax
   140006fe8:	48 83 f8 04          	cmp    $0x4,%rax
   140006fec:	74 23                	je     140007011 <main2+0x3632>
   140006fee:	41 b8 9e 04 00 00    	mov    $0x49e,%r8d
   140006ff4:	48 8d 05 55 c0 00 00 	lea    0xc055(%rip),%rax        # 140013050 <.rdata>
   140006ffb:	48 89 c2             	mov    %rax,%rdx
   140006ffe:	48 8d 05 cb cf 00 00 	lea    0xcfcb(%rip),%rax        # 140013fd0 <.rdata+0xf80>
   140007005:	48 89 c1             	mov    %rax,%rcx
   140007008:	48 8b 05 31 43 01 00 	mov    0x14331(%rip),%rax        # 14001b340 <__imp__assert>
   14000700f:	ff d0                	call   *%rax
   140007011:	b9 01 00 00 00       	mov    $0x1,%ecx
   140007016:	48 8b 05 ab 42 01 00 	mov    0x142ab(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   14000701d:	ff d0                	call   *%rax
   14000701f:	48 89 c2             	mov    %rax,%rdx
   140007022:	48 8b 85 d8 02 00 00 	mov    0x2d8(%rbp),%rax
   140007029:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140007030:	00 00 
   140007032:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140007038:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000703e:	48 89 c1             	mov    %rax,%rcx
   140007041:	e8 98 c2 ff ff       	call   1400032de <type__print>
   140007046:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000704a:	4c 8d 0d bd c4 00 00 	lea    0xc4bd(%rip),%r9        # 14001350e <.rdata+0x4be>
   140007051:	4c 8d 05 a4 c5 00 00 	lea    0xc5a4(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140007058:	ba 00 01 00 00       	mov    $0x100,%edx
   14000705d:	48 89 c1             	mov    %rax,%rcx
   140007060:	e8 6b a5 00 00       	call   1400115d0 <snprintf>
   140007065:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007069:	48 c7 44 24 20 cc 0c 	movq   $0xccc,0x20(%rsp)
   140007070:	00 00 
   140007072:	49 89 c1             	mov    %rax,%r9
   140007075:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000707b:	ba 16 00 00 00       	mov    $0x16,%edx
   140007080:	48 8d 05 ca c1 00 00 	lea    0xc1ca(%rip),%rax        # 140013251 <.rdata+0x201>
   140007087:	48 89 c1             	mov    %rax,%rcx
   14000708a:	e8 a1 a5 00 00       	call   140011630 <printf>
   14000708f:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007093:	4c 8d 0d 74 c4 00 00 	lea    0xc474(%rip),%r9        # 14001350e <.rdata+0x4be>
   14000709a:	4c 8d 05 68 c5 00 00 	lea    0xc568(%rip),%r8        # 140013609 <.rdata+0x5b9>
   1400070a1:	ba 00 01 00 00       	mov    $0x100,%edx
   1400070a6:	48 89 c1             	mov    %rax,%rcx
   1400070a9:	e8 22 a5 00 00       	call   1400115d0 <snprintf>
   1400070ae:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400070b2:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   1400070b9:	00 00 
   1400070bb:	49 89 c1             	mov    %rax,%r9
   1400070be:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400070c4:	ba 16 00 00 00       	mov    $0x16,%edx
   1400070c9:	48 8d 05 81 c1 00 00 	lea    0xc181(%rip),%rax        # 140013251 <.rdata+0x201>
   1400070d0:	48 89 c1             	mov    %rax,%rcx
   1400070d3:	e8 58 a5 00 00       	call   140011630 <printf>
   1400070d8:	b9 0a 00 00 00       	mov    $0xa,%ecx
   1400070dd:	e8 ae a9 00 00       	call   140011a90 <putchar>
   1400070e2:	48 8b 85 d8 02 00 00 	mov    0x2d8(%rbp),%rax
   1400070e9:	48 89 c1             	mov    %rax,%rcx
   1400070ec:	e8 7a b0 ff ff       	call   14000216b <type__size>
   1400070f1:	48 3d cc 0c 00 00    	cmp    $0xccc,%rax
   1400070f7:	74 23                	je     14000711c <main2+0x373d>
   1400070f9:	41 b8 9f 04 00 00    	mov    $0x49f,%r8d
   1400070ff:	48 8d 05 4a bf 00 00 	lea    0xbf4a(%rip),%rax        # 140013050 <.rdata>
   140007106:	48 89 c2             	mov    %rax,%rdx
   140007109:	48 8d 05 e8 ce 00 00 	lea    0xcee8(%rip),%rax        # 140013ff8 <.rdata+0xfa8>
   140007110:	48 89 c1             	mov    %rax,%rcx
   140007113:	48 8b 05 26 42 01 00 	mov    0x14226(%rip),%rax        # 14001b340 <__imp__assert>
   14000711a:	ff d0                	call   *%rax
   14000711c:	48 8b 85 d8 02 00 00 	mov    0x2d8(%rbp),%rax
   140007123:	48 8b 40 10          	mov    0x10(%rax),%rax
   140007127:	48 83 f8 01          	cmp    $0x1,%rax
   14000712b:	74 23                	je     140007150 <main2+0x3771>
   14000712d:	41 b8 9f 04 00 00    	mov    $0x49f,%r8d
   140007133:	48 8d 05 16 bf 00 00 	lea    0xbf16(%rip),%rax        # 140013050 <.rdata>
   14000713a:	48 89 c2             	mov    %rax,%rdx
   14000713d:	48 8d 05 e4 ce 00 00 	lea    0xcee4(%rip),%rax        # 140014028 <.rdata+0xfd8>
   140007144:	48 89 c1             	mov    %rax,%rcx
   140007147:	48 8b 05 f2 41 01 00 	mov    0x141f2(%rip),%rax        # 14001b340 <__imp__assert>
   14000714e:	ff d0                	call   *%rax
   140007150:	b9 01 00 00 00       	mov    $0x1,%ecx
   140007155:	48 8b 05 6c 41 01 00 	mov    0x1416c(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   14000715c:	ff d0                	call   *%rax
   14000715e:	48 89 c2             	mov    %rax,%rdx
   140007161:	48 8b 85 d0 02 00 00 	mov    0x2d0(%rbp),%rax
   140007168:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000716f:	00 00 
   140007171:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140007177:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000717d:	48 89 c1             	mov    %rax,%rcx
   140007180:	e8 59 c1 ff ff       	call   1400032de <type__print>
   140007185:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007189:	4c 8d 0d 80 c3 00 00 	lea    0xc380(%rip),%r9        # 140013510 <.rdata+0x4c0>
   140007190:	4c 8d 05 65 c4 00 00 	lea    0xc465(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140007197:	ba 00 01 00 00       	mov    $0x100,%edx
   14000719c:	48 89 c1             	mov    %rax,%rcx
   14000719f:	e8 2c a4 00 00       	call   1400115d0 <snprintf>
   1400071a4:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400071a8:	48 c7 44 24 20 07 00 	movq   $0x7,0x20(%rsp)
   1400071af:	00 00 
   1400071b1:	49 89 c1             	mov    %rax,%r9
   1400071b4:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400071ba:	ba 16 00 00 00       	mov    $0x16,%edx
   1400071bf:	48 8d 05 8b c0 00 00 	lea    0xc08b(%rip),%rax        # 140013251 <.rdata+0x201>
   1400071c6:	48 89 c1             	mov    %rax,%rcx
   1400071c9:	e8 62 a4 00 00       	call   140011630 <printf>
   1400071ce:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400071d2:	4c 8d 0d 37 c3 00 00 	lea    0xc337(%rip),%r9        # 140013510 <.rdata+0x4c0>
   1400071d9:	4c 8d 05 29 c4 00 00 	lea    0xc429(%rip),%r8        # 140013609 <.rdata+0x5b9>
   1400071e0:	ba 00 01 00 00       	mov    $0x100,%edx
   1400071e5:	48 89 c1             	mov    %rax,%rcx
   1400071e8:	e8 e3 a3 00 00       	call   1400115d0 <snprintf>
   1400071ed:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400071f1:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   1400071f8:	00 00 
   1400071fa:	49 89 c1             	mov    %rax,%r9
   1400071fd:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140007203:	ba 16 00 00 00       	mov    $0x16,%edx
   140007208:	48 8d 05 42 c0 00 00 	lea    0xc042(%rip),%rax        # 140013251 <.rdata+0x201>
   14000720f:	48 89 c1             	mov    %rax,%rcx
   140007212:	e8 19 a4 00 00       	call   140011630 <printf>
   140007217:	b9 0a 00 00 00       	mov    $0xa,%ecx
   14000721c:	e8 6f a8 00 00       	call   140011a90 <putchar>
   140007221:	48 8b 85 d0 02 00 00 	mov    0x2d0(%rbp),%rax
   140007228:	48 89 c1             	mov    %rax,%rcx
   14000722b:	e8 3b af ff ff       	call   14000216b <type__size>
   140007230:	48 83 f8 07          	cmp    $0x7,%rax
   140007234:	74 23                	je     140007259 <main2+0x387a>
   140007236:	41 b8 a0 04 00 00    	mov    $0x4a0,%r8d
   14000723c:	48 8d 05 0d be 00 00 	lea    0xbe0d(%rip),%rax        # 140013050 <.rdata>
   140007243:	48 89 c2             	mov    %rax,%rdx
   140007246:	48 8d 05 03 ce 00 00 	lea    0xce03(%rip),%rax        # 140014050 <.rdata+0x1000>
   14000724d:	48 89 c1             	mov    %rax,%rcx
   140007250:	48 8b 05 e9 40 01 00 	mov    0x140e9(%rip),%rax        # 14001b340 <__imp__assert>
   140007257:	ff d0                	call   *%rax
   140007259:	48 8b 85 d0 02 00 00 	mov    0x2d0(%rbp),%rax
   140007260:	48 8b 40 10          	mov    0x10(%rax),%rax
   140007264:	48 83 f8 01          	cmp    $0x1,%rax
   140007268:	74 23                	je     14000728d <main2+0x38ae>
   14000726a:	41 b8 a0 04 00 00    	mov    $0x4a0,%r8d
   140007270:	48 8d 05 d9 bd 00 00 	lea    0xbdd9(%rip),%rax        # 140013050 <.rdata>
   140007277:	48 89 c2             	mov    %rax,%rdx
   14000727a:	48 8d 05 ff cd 00 00 	lea    0xcdff(%rip),%rax        # 140014080 <.rdata+0x1030>
   140007281:	48 89 c1             	mov    %rax,%rcx
   140007284:	48 8b 05 b5 40 01 00 	mov    0x140b5(%rip),%rax        # 14001b340 <__imp__assert>
   14000728b:	ff d0                	call   *%rax
   14000728d:	b9 01 00 00 00       	mov    $0x1,%ecx
   140007292:	48 8b 05 2f 40 01 00 	mov    0x1402f(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140007299:	ff d0                	call   *%rax
   14000729b:	48 89 c2             	mov    %rax,%rdx
   14000729e:	48 8b 85 c8 02 00 00 	mov    0x2c8(%rbp),%rax
   1400072a5:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   1400072ac:	00 00 
   1400072ae:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   1400072b4:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   1400072ba:	48 89 c1             	mov    %rax,%rcx
   1400072bd:	e8 1c c0 ff ff       	call   1400032de <type__print>
   1400072c2:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400072c6:	4c 8d 0d 45 c2 00 00 	lea    0xc245(%rip),%r9        # 140013512 <.rdata+0x4c2>
   1400072cd:	4c 8d 05 28 c3 00 00 	lea    0xc328(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   1400072d4:	ba 00 01 00 00       	mov    $0x100,%edx
   1400072d9:	48 89 c1             	mov    %rax,%rcx
   1400072dc:	e8 ef a2 00 00       	call   1400115d0 <snprintf>
   1400072e1:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400072e5:	48 c7 44 24 20 11 01 	movq   $0x111,0x20(%rsp)
   1400072ec:	00 00 
   1400072ee:	49 89 c1             	mov    %rax,%r9
   1400072f1:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400072f7:	ba 16 00 00 00       	mov    $0x16,%edx
   1400072fc:	48 8d 05 4e bf 00 00 	lea    0xbf4e(%rip),%rax        # 140013251 <.rdata+0x201>
   140007303:	48 89 c1             	mov    %rax,%rcx
   140007306:	e8 25 a3 00 00       	call   140011630 <printf>
   14000730b:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000730f:	4c 8d 0d fc c1 00 00 	lea    0xc1fc(%rip),%r9        # 140013512 <.rdata+0x4c2>
   140007316:	4c 8d 05 ec c2 00 00 	lea    0xc2ec(%rip),%r8        # 140013609 <.rdata+0x5b9>
   14000731d:	ba 00 01 00 00       	mov    $0x100,%edx
   140007322:	48 89 c1             	mov    %rax,%rcx
   140007325:	e8 a6 a2 00 00       	call   1400115d0 <snprintf>
   14000732a:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000732e:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140007335:	00 00 
   140007337:	49 89 c1             	mov    %rax,%r9
   14000733a:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140007340:	ba 16 00 00 00       	mov    $0x16,%edx
   140007345:	48 8d 05 05 bf 00 00 	lea    0xbf05(%rip),%rax        # 140013251 <.rdata+0x201>
   14000734c:	48 89 c1             	mov    %rax,%rcx
   14000734f:	e8 dc a2 00 00       	call   140011630 <printf>
   140007354:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140007359:	e8 32 a7 00 00       	call   140011a90 <putchar>
   14000735e:	48 8b 85 c8 02 00 00 	mov    0x2c8(%rbp),%rax
   140007365:	48 89 c1             	mov    %rax,%rcx
   140007368:	e8 fe ad ff ff       	call   14000216b <type__size>
   14000736d:	48 3d 11 01 00 00    	cmp    $0x111,%rax
   140007373:	74 23                	je     140007398 <main2+0x39b9>
   140007375:	41 b8 a1 04 00 00    	mov    $0x4a1,%r8d
   14000737b:	48 8d 05 ce bc 00 00 	lea    0xbcce(%rip),%rax        # 140013050 <.rdata>
   140007382:	48 89 c2             	mov    %rax,%rdx
   140007385:	48 8d 05 1c cd 00 00 	lea    0xcd1c(%rip),%rax        # 1400140a8 <.rdata+0x1058>
   14000738c:	48 89 c1             	mov    %rax,%rcx
   14000738f:	48 8b 05 aa 3f 01 00 	mov    0x13faa(%rip),%rax        # 14001b340 <__imp__assert>
   140007396:	ff d0                	call   *%rax
   140007398:	48 8b 85 c8 02 00 00 	mov    0x2c8(%rbp),%rax
   14000739f:	48 8b 40 10          	mov    0x10(%rax),%rax
   1400073a3:	48 83 f8 01          	cmp    $0x1,%rax
   1400073a7:	74 23                	je     1400073cc <main2+0x39ed>
   1400073a9:	41 b8 a1 04 00 00    	mov    $0x4a1,%r8d
   1400073af:	48 8d 05 9a bc 00 00 	lea    0xbc9a(%rip),%rax        # 140013050 <.rdata>
   1400073b6:	48 89 c2             	mov    %rax,%rdx
   1400073b9:	48 8d 05 18 cd 00 00 	lea    0xcd18(%rip),%rax        # 1400140d8 <.rdata+0x1088>
   1400073c0:	48 89 c1             	mov    %rax,%rcx
   1400073c3:	48 8b 05 76 3f 01 00 	mov    0x13f76(%rip),%rax        # 14001b340 <__imp__assert>
   1400073ca:	ff d0                	call   *%rax
   1400073cc:	b9 01 00 00 00       	mov    $0x1,%ecx
   1400073d1:	48 8b 05 f0 3e 01 00 	mov    0x13ef0(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   1400073d8:	ff d0                	call   *%rax
   1400073da:	48 89 c2             	mov    %rax,%rdx
   1400073dd:	48 8b 85 c0 02 00 00 	mov    0x2c0(%rbp),%rax
   1400073e4:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   1400073eb:	00 00 
   1400073ed:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   1400073f3:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   1400073f9:	48 89 c1             	mov    %rax,%rcx
   1400073fc:	e8 dd be ff ff       	call   1400032de <type__print>
   140007401:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007405:	4c 8d 0d 08 c1 00 00 	lea    0xc108(%rip),%r9        # 140013514 <.rdata+0x4c4>
   14000740c:	4c 8d 05 e9 c1 00 00 	lea    0xc1e9(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140007413:	ba 00 01 00 00       	mov    $0x100,%edx
   140007418:	48 89 c1             	mov    %rax,%rcx
   14000741b:	e8 b0 a1 00 00       	call   1400115d0 <snprintf>
   140007420:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007424:	48 c7 44 24 20 dd 0d 	movq   $0xddd,0x20(%rsp)
   14000742b:	00 00 
   14000742d:	49 89 c1             	mov    %rax,%r9
   140007430:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140007436:	ba 16 00 00 00       	mov    $0x16,%edx
   14000743b:	48 8d 05 0f be 00 00 	lea    0xbe0f(%rip),%rax        # 140013251 <.rdata+0x201>
   140007442:	48 89 c1             	mov    %rax,%rcx
   140007445:	e8 e6 a1 00 00       	call   140011630 <printf>
   14000744a:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000744e:	4c 8d 0d bf c0 00 00 	lea    0xc0bf(%rip),%r9        # 140013514 <.rdata+0x4c4>
   140007455:	4c 8d 05 ad c1 00 00 	lea    0xc1ad(%rip),%r8        # 140013609 <.rdata+0x5b9>
   14000745c:	ba 00 01 00 00       	mov    $0x100,%edx
   140007461:	48 89 c1             	mov    %rax,%rcx
   140007464:	e8 67 a1 00 00       	call   1400115d0 <snprintf>
   140007469:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000746d:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140007474:	00 00 
   140007476:	49 89 c1             	mov    %rax,%r9
   140007479:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000747f:	ba 16 00 00 00       	mov    $0x16,%edx
   140007484:	48 8d 05 c6 bd 00 00 	lea    0xbdc6(%rip),%rax        # 140013251 <.rdata+0x201>
   14000748b:	48 89 c1             	mov    %rax,%rcx
   14000748e:	e8 9d a1 00 00       	call   140011630 <printf>
   140007493:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140007498:	e8 f3 a5 00 00       	call   140011a90 <putchar>
   14000749d:	48 8b 85 c0 02 00 00 	mov    0x2c0(%rbp),%rax
   1400074a4:	48 89 c1             	mov    %rax,%rcx
   1400074a7:	e8 bf ac ff ff       	call   14000216b <type__size>
   1400074ac:	48 3d dd 0d 00 00    	cmp    $0xddd,%rax
   1400074b2:	74 23                	je     1400074d7 <main2+0x3af8>
   1400074b4:	41 b8 a2 04 00 00    	mov    $0x4a2,%r8d
   1400074ba:	48 8d 05 8f bb 00 00 	lea    0xbb8f(%rip),%rax        # 140013050 <.rdata>
   1400074c1:	48 89 c2             	mov    %rax,%rdx
   1400074c4:	48 8d 05 35 cc 00 00 	lea    0xcc35(%rip),%rax        # 140014100 <.rdata+0x10b0>
   1400074cb:	48 89 c1             	mov    %rax,%rcx
   1400074ce:	48 8b 05 6b 3e 01 00 	mov    0x13e6b(%rip),%rax        # 14001b340 <__imp__assert>
   1400074d5:	ff d0                	call   *%rax
   1400074d7:	48 8b 85 c0 02 00 00 	mov    0x2c0(%rbp),%rax
   1400074de:	48 8b 40 10          	mov    0x10(%rax),%rax
   1400074e2:	48 83 f8 01          	cmp    $0x1,%rax
   1400074e6:	74 23                	je     14000750b <main2+0x3b2c>
   1400074e8:	41 b8 a2 04 00 00    	mov    $0x4a2,%r8d
   1400074ee:	48 8d 05 5b bb 00 00 	lea    0xbb5b(%rip),%rax        # 140013050 <.rdata>
   1400074f5:	48 89 c2             	mov    %rax,%rdx
   1400074f8:	48 8d 05 31 cc 00 00 	lea    0xcc31(%rip),%rax        # 140014130 <.rdata+0x10e0>
   1400074ff:	48 89 c1             	mov    %rax,%rcx
   140007502:	48 8b 05 37 3e 01 00 	mov    0x13e37(%rip),%rax        # 14001b340 <__imp__assert>
   140007509:	ff d0                	call   *%rax
   14000750b:	b9 01 00 00 00       	mov    $0x1,%ecx
   140007510:	48 8b 05 b1 3d 01 00 	mov    0x13db1(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140007517:	ff d0                	call   *%rax
   140007519:	48 89 c2             	mov    %rax,%rdx
   14000751c:	48 8b 85 b8 02 00 00 	mov    0x2b8(%rbp),%rax
   140007523:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000752a:	00 00 
   14000752c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140007532:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140007538:	48 89 c1             	mov    %rax,%rcx
   14000753b:	e8 9e bd ff ff       	call   1400032de <type__print>
   140007540:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007544:	4c 8d 0d cb bf 00 00 	lea    0xbfcb(%rip),%r9        # 140013516 <.rdata+0x4c6>
   14000754b:	4c 8d 05 aa c0 00 00 	lea    0xc0aa(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140007552:	ba 00 01 00 00       	mov    $0x100,%edx
   140007557:	48 89 c1             	mov    %rax,%rcx
   14000755a:	e8 71 a0 00 00       	call   1400115d0 <snprintf>
   14000755f:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007563:	48 c7 44 24 20 4c 67 	movq   $0x1674c,0x20(%rsp)
   14000756a:	01 00 
   14000756c:	49 89 c1             	mov    %rax,%r9
   14000756f:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140007575:	ba 16 00 00 00       	mov    $0x16,%edx
   14000757a:	48 8d 05 d0 bc 00 00 	lea    0xbcd0(%rip),%rax        # 140013251 <.rdata+0x201>
   140007581:	48 89 c1             	mov    %rax,%rcx
   140007584:	e8 a7 a0 00 00       	call   140011630 <printf>
   140007589:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000758d:	4c 8d 0d 82 bf 00 00 	lea    0xbf82(%rip),%r9        # 140013516 <.rdata+0x4c6>
   140007594:	4c 8d 05 6e c0 00 00 	lea    0xc06e(%rip),%r8        # 140013609 <.rdata+0x5b9>
   14000759b:	ba 00 01 00 00       	mov    $0x100,%edx
   1400075a0:	48 89 c1             	mov    %rax,%rcx
   1400075a3:	e8 28 a0 00 00       	call   1400115d0 <snprintf>
   1400075a8:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400075ac:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   1400075b3:	00 00 
   1400075b5:	49 89 c1             	mov    %rax,%r9
   1400075b8:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400075be:	ba 16 00 00 00       	mov    $0x16,%edx
   1400075c3:	48 8d 05 87 bc 00 00 	lea    0xbc87(%rip),%rax        # 140013251 <.rdata+0x201>
   1400075ca:	48 89 c1             	mov    %rax,%rcx
   1400075cd:	e8 5e a0 00 00       	call   140011630 <printf>
   1400075d2:	b9 0a 00 00 00       	mov    $0xa,%ecx
   1400075d7:	e8 b4 a4 00 00       	call   140011a90 <putchar>
   1400075dc:	48 8b 85 b8 02 00 00 	mov    0x2b8(%rbp),%rax
   1400075e3:	48 89 c1             	mov    %rax,%rcx
   1400075e6:	e8 80 ab ff ff       	call   14000216b <type__size>
   1400075eb:	48 3d 4c 67 01 00    	cmp    $0x1674c,%rax
   1400075f1:	74 23                	je     140007616 <main2+0x3c37>
   1400075f3:	41 b8 a3 04 00 00    	mov    $0x4a3,%r8d
   1400075f9:	48 8d 05 50 ba 00 00 	lea    0xba50(%rip),%rax        # 140013050 <.rdata>
   140007600:	48 89 c2             	mov    %rax,%rdx
   140007603:	48 8d 05 4e cb 00 00 	lea    0xcb4e(%rip),%rax        # 140014158 <.rdata+0x1108>
   14000760a:	48 89 c1             	mov    %rax,%rcx
   14000760d:	48 8b 05 2c 3d 01 00 	mov    0x13d2c(%rip),%rax        # 14001b340 <__imp__assert>
   140007614:	ff d0                	call   *%rax
   140007616:	48 8b 85 b8 02 00 00 	mov    0x2b8(%rbp),%rax
   14000761d:	48 8b 40 10          	mov    0x10(%rax),%rax
   140007621:	48 83 f8 04          	cmp    $0x4,%rax
   140007625:	74 23                	je     14000764a <main2+0x3c6b>
   140007627:	41 b8 a3 04 00 00    	mov    $0x4a3,%r8d
   14000762d:	48 8d 05 1c ba 00 00 	lea    0xba1c(%rip),%rax        # 140013050 <.rdata>
   140007634:	48 89 c2             	mov    %rax,%rdx
   140007637:	48 8d 05 4a cb 00 00 	lea    0xcb4a(%rip),%rax        # 140014188 <.rdata+0x1138>
   14000763e:	48 89 c1             	mov    %rax,%rcx
   140007641:	48 8b 05 f8 3c 01 00 	mov    0x13cf8(%rip),%rax        # 14001b340 <__imp__assert>
   140007648:	ff d0                	call   *%rax
   14000764a:	b9 01 00 00 00       	mov    $0x1,%ecx
   14000764f:	48 8b 05 72 3c 01 00 	mov    0x13c72(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140007656:	ff d0                	call   *%rax
   140007658:	48 89 c2             	mov    %rax,%rdx
   14000765b:	48 8b 85 b0 02 00 00 	mov    0x2b0(%rbp),%rax
   140007662:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140007669:	00 00 
   14000766b:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140007671:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140007677:	48 89 c1             	mov    %rax,%rcx
   14000767a:	e8 5f bc ff ff       	call   1400032de <type__print>
   14000767f:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007683:	4c 8d 0d 8e be 00 00 	lea    0xbe8e(%rip),%r9        # 140013518 <.rdata+0x4c8>
   14000768a:	4c 8d 05 6b bf 00 00 	lea    0xbf6b(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140007691:	ba 00 01 00 00       	mov    $0x100,%edx
   140007696:	48 89 c1             	mov    %rax,%rcx
   140007699:	e8 32 9f 00 00       	call   1400115d0 <snprintf>
   14000769e:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400076a2:	48 c7 44 24 20 0a 00 	movq   $0xa,0x20(%rsp)
   1400076a9:	00 00 
   1400076ab:	49 89 c1             	mov    %rax,%r9
   1400076ae:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400076b4:	ba 16 00 00 00       	mov    $0x16,%edx
   1400076b9:	48 8d 05 91 bb 00 00 	lea    0xbb91(%rip),%rax        # 140013251 <.rdata+0x201>
   1400076c0:	48 89 c1             	mov    %rax,%rcx
   1400076c3:	e8 68 9f 00 00       	call   140011630 <printf>
   1400076c8:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400076cc:	4c 8d 0d 45 be 00 00 	lea    0xbe45(%rip),%r9        # 140013518 <.rdata+0x4c8>
   1400076d3:	4c 8d 05 2f bf 00 00 	lea    0xbf2f(%rip),%r8        # 140013609 <.rdata+0x5b9>
   1400076da:	ba 00 01 00 00       	mov    $0x100,%edx
   1400076df:	48 89 c1             	mov    %rax,%rcx
   1400076e2:	e8 e9 9e 00 00       	call   1400115d0 <snprintf>
   1400076e7:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400076eb:	48 c7 44 24 20 02 00 	movq   $0x2,0x20(%rsp)
   1400076f2:	00 00 
   1400076f4:	49 89 c1             	mov    %rax,%r9
   1400076f7:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400076fd:	ba 16 00 00 00       	mov    $0x16,%edx
   140007702:	48 8d 05 48 bb 00 00 	lea    0xbb48(%rip),%rax        # 140013251 <.rdata+0x201>
   140007709:	48 89 c1             	mov    %rax,%rcx
   14000770c:	e8 1f 9f 00 00       	call   140011630 <printf>
   140007711:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140007716:	e8 75 a3 00 00       	call   140011a90 <putchar>
   14000771b:	48 8b 85 b0 02 00 00 	mov    0x2b0(%rbp),%rax
   140007722:	48 89 c1             	mov    %rax,%rcx
   140007725:	e8 41 aa ff ff       	call   14000216b <type__size>
   14000772a:	48 83 f8 0a          	cmp    $0xa,%rax
   14000772e:	74 23                	je     140007753 <main2+0x3d74>
   140007730:	41 b8 a4 04 00 00    	mov    $0x4a4,%r8d
   140007736:	48 8d 05 13 b9 00 00 	lea    0xb913(%rip),%rax        # 140013050 <.rdata>
   14000773d:	48 89 c2             	mov    %rax,%rdx
   140007740:	48 8d 05 69 ca 00 00 	lea    0xca69(%rip),%rax        # 1400141b0 <.rdata+0x1160>
   140007747:	48 89 c1             	mov    %rax,%rcx
   14000774a:	48 8b 05 ef 3b 01 00 	mov    0x13bef(%rip),%rax        # 14001b340 <__imp__assert>
   140007751:	ff d0                	call   *%rax
   140007753:	48 8b 85 b0 02 00 00 	mov    0x2b0(%rbp),%rax
   14000775a:	48 8b 40 10          	mov    0x10(%rax),%rax
   14000775e:	48 83 f8 02          	cmp    $0x2,%rax
   140007762:	74 23                	je     140007787 <main2+0x3da8>
   140007764:	41 b8 a4 04 00 00    	mov    $0x4a4,%r8d
   14000776a:	48 8d 05 df b8 00 00 	lea    0xb8df(%rip),%rax        # 140013050 <.rdata>
   140007771:	48 89 c2             	mov    %rax,%rdx
   140007774:	48 8d 05 65 ca 00 00 	lea    0xca65(%rip),%rax        # 1400141e0 <.rdata+0x1190>
   14000777b:	48 89 c1             	mov    %rax,%rcx
   14000777e:	48 8b 05 bb 3b 01 00 	mov    0x13bbb(%rip),%rax        # 14001b340 <__imp__assert>
   140007785:	ff d0                	call   *%rax
   140007787:	b9 01 00 00 00       	mov    $0x1,%ecx
   14000778c:	48 8b 05 35 3b 01 00 	mov    0x13b35(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140007793:	ff d0                	call   *%rax
   140007795:	48 89 c2             	mov    %rax,%rdx
   140007798:	48 8b 85 a8 02 00 00 	mov    0x2a8(%rbp),%rax
   14000779f:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   1400077a6:	00 00 
   1400077a8:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   1400077ae:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   1400077b4:	48 89 c1             	mov    %rax,%rcx
   1400077b7:	e8 22 bb ff ff       	call   1400032de <type__print>
   1400077bc:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400077c0:	4c 8d 0d 53 bd 00 00 	lea    0xbd53(%rip),%r9        # 14001351a <.rdata+0x4ca>
   1400077c7:	4c 8d 05 2e be 00 00 	lea    0xbe2e(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   1400077ce:	ba 00 01 00 00       	mov    $0x100,%edx
   1400077d3:	48 89 c1             	mov    %rax,%rcx
   1400077d6:	e8 f5 9d 00 00       	call   1400115d0 <snprintf>
   1400077db:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400077df:	48 c7 44 24 20 86 01 	movq   $0x186,0x20(%rsp)
   1400077e6:	00 00 
   1400077e8:	49 89 c1             	mov    %rax,%r9
   1400077eb:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400077f1:	ba 16 00 00 00       	mov    $0x16,%edx
   1400077f6:	48 8d 05 54 ba 00 00 	lea    0xba54(%rip),%rax        # 140013251 <.rdata+0x201>
   1400077fd:	48 89 c1             	mov    %rax,%rcx
   140007800:	e8 2b 9e 00 00       	call   140011630 <printf>
   140007805:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007809:	4c 8d 0d 0a bd 00 00 	lea    0xbd0a(%rip),%r9        # 14001351a <.rdata+0x4ca>
   140007810:	4c 8d 05 f2 bd 00 00 	lea    0xbdf2(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140007817:	ba 00 01 00 00       	mov    $0x100,%edx
   14000781c:	48 89 c1             	mov    %rax,%rcx
   14000781f:	e8 ac 9d 00 00       	call   1400115d0 <snprintf>
   140007824:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007828:	48 c7 44 24 20 02 00 	movq   $0x2,0x20(%rsp)
   14000782f:	00 00 
   140007831:	49 89 c1             	mov    %rax,%r9
   140007834:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000783a:	ba 16 00 00 00       	mov    $0x16,%edx
   14000783f:	48 8d 05 0b ba 00 00 	lea    0xba0b(%rip),%rax        # 140013251 <.rdata+0x201>
   140007846:	48 89 c1             	mov    %rax,%rcx
   140007849:	e8 e2 9d 00 00       	call   140011630 <printf>
   14000784e:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140007853:	e8 38 a2 00 00       	call   140011a90 <putchar>
   140007858:	48 8b 85 a8 02 00 00 	mov    0x2a8(%rbp),%rax
   14000785f:	48 89 c1             	mov    %rax,%rcx
   140007862:	e8 04 a9 ff ff       	call   14000216b <type__size>
   140007867:	48 3d 86 01 00 00    	cmp    $0x186,%rax
   14000786d:	74 23                	je     140007892 <main2+0x3eb3>
   14000786f:	41 b8 a5 04 00 00    	mov    $0x4a5,%r8d
   140007875:	48 8d 05 d4 b7 00 00 	lea    0xb7d4(%rip),%rax        # 140013050 <.rdata>
   14000787c:	48 89 c2             	mov    %rax,%rdx
   14000787f:	48 8d 05 82 c9 00 00 	lea    0xc982(%rip),%rax        # 140014208 <.rdata+0x11b8>
   140007886:	48 89 c1             	mov    %rax,%rcx
   140007889:	48 8b 05 b0 3a 01 00 	mov    0x13ab0(%rip),%rax        # 14001b340 <__imp__assert>
   140007890:	ff d0                	call   *%rax
   140007892:	48 8b 85 a8 02 00 00 	mov    0x2a8(%rbp),%rax
   140007899:	48 8b 40 10          	mov    0x10(%rax),%rax
   14000789d:	48 83 f8 02          	cmp    $0x2,%rax
   1400078a1:	74 23                	je     1400078c6 <main2+0x3ee7>
   1400078a3:	41 b8 a5 04 00 00    	mov    $0x4a5,%r8d
   1400078a9:	48 8d 05 a0 b7 00 00 	lea    0xb7a0(%rip),%rax        # 140013050 <.rdata>
   1400078b0:	48 89 c2             	mov    %rax,%rdx
   1400078b3:	48 8d 05 7e c9 00 00 	lea    0xc97e(%rip),%rax        # 140014238 <.rdata+0x11e8>
   1400078ba:	48 89 c1             	mov    %rax,%rcx
   1400078bd:	48 8b 05 7c 3a 01 00 	mov    0x13a7c(%rip),%rax        # 14001b340 <__imp__assert>
   1400078c4:	ff d0                	call   *%rax
   1400078c6:	b9 01 00 00 00       	mov    $0x1,%ecx
   1400078cb:	48 8b 05 f6 39 01 00 	mov    0x139f6(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   1400078d2:	ff d0                	call   *%rax
   1400078d4:	48 89 c2             	mov    %rax,%rdx
   1400078d7:	48 8b 85 a0 02 00 00 	mov    0x2a0(%rbp),%rax
   1400078de:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   1400078e5:	00 00 
   1400078e7:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   1400078ed:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   1400078f3:	48 89 c1             	mov    %rax,%rcx
   1400078f6:	e8 e3 b9 ff ff       	call   1400032de <type__print>
   1400078fb:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400078ff:	4c 8d 0d 16 bc 00 00 	lea    0xbc16(%rip),%r9        # 14001351c <.rdata+0x4cc>
   140007906:	4c 8d 05 ef bc 00 00 	lea    0xbcef(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   14000790d:	ba 00 01 00 00       	mov    $0x100,%edx
   140007912:	48 89 c1             	mov    %rax,%rcx
   140007915:	e8 b6 9c 00 00       	call   1400115d0 <snprintf>
   14000791a:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000791e:	48 c7 44 24 20 54 14 	movq   $0x1454,0x20(%rsp)
   140007925:	00 00 
   140007927:	49 89 c1             	mov    %rax,%r9
   14000792a:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140007930:	ba 16 00 00 00       	mov    $0x16,%edx
   140007935:	48 8d 05 15 b9 00 00 	lea    0xb915(%rip),%rax        # 140013251 <.rdata+0x201>
   14000793c:	48 89 c1             	mov    %rax,%rcx
   14000793f:	e8 ec 9c 00 00       	call   140011630 <printf>
   140007944:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007948:	4c 8d 0d cd bb 00 00 	lea    0xbbcd(%rip),%r9        # 14001351c <.rdata+0x4cc>
   14000794f:	4c 8d 05 b3 bc 00 00 	lea    0xbcb3(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140007956:	ba 00 01 00 00       	mov    $0x100,%edx
   14000795b:	48 89 c1             	mov    %rax,%rcx
   14000795e:	e8 6d 9c 00 00       	call   1400115d0 <snprintf>
   140007963:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007967:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   14000796e:	00 00 
   140007970:	49 89 c1             	mov    %rax,%r9
   140007973:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140007979:	ba 16 00 00 00       	mov    $0x16,%edx
   14000797e:	48 8d 05 cc b8 00 00 	lea    0xb8cc(%rip),%rax        # 140013251 <.rdata+0x201>
   140007985:	48 89 c1             	mov    %rax,%rcx
   140007988:	e8 a3 9c 00 00       	call   140011630 <printf>
   14000798d:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140007992:	e8 f9 a0 00 00       	call   140011a90 <putchar>
   140007997:	48 8b 85 a0 02 00 00 	mov    0x2a0(%rbp),%rax
   14000799e:	48 89 c1             	mov    %rax,%rcx
   1400079a1:	e8 c5 a7 ff ff       	call   14000216b <type__size>
   1400079a6:	48 3d 54 14 00 00    	cmp    $0x1454,%rax
   1400079ac:	74 23                	je     1400079d1 <main2+0x3ff2>
   1400079ae:	41 b8 a6 04 00 00    	mov    $0x4a6,%r8d
   1400079b4:	48 8d 05 95 b6 00 00 	lea    0xb695(%rip),%rax        # 140013050 <.rdata>
   1400079bb:	48 89 c2             	mov    %rax,%rdx
   1400079be:	48 8d 05 9b c8 00 00 	lea    0xc89b(%rip),%rax        # 140014260 <.rdata+0x1210>
   1400079c5:	48 89 c1             	mov    %rax,%rcx
   1400079c8:	48 8b 05 71 39 01 00 	mov    0x13971(%rip),%rax        # 14001b340 <__imp__assert>
   1400079cf:	ff d0                	call   *%rax
   1400079d1:	48 8b 85 a0 02 00 00 	mov    0x2a0(%rbp),%rax
   1400079d8:	48 8b 40 10          	mov    0x10(%rax),%rax
   1400079dc:	48 83 f8 04          	cmp    $0x4,%rax
   1400079e0:	74 23                	je     140007a05 <main2+0x4026>
   1400079e2:	41 b8 a6 04 00 00    	mov    $0x4a6,%r8d
   1400079e8:	48 8d 05 61 b6 00 00 	lea    0xb661(%rip),%rax        # 140013050 <.rdata>
   1400079ef:	48 89 c2             	mov    %rax,%rdx
   1400079f2:	48 8d 05 97 c8 00 00 	lea    0xc897(%rip),%rax        # 140014290 <.rdata+0x1240>
   1400079f9:	48 89 c1             	mov    %rax,%rcx
   1400079fc:	48 8b 05 3d 39 01 00 	mov    0x1393d(%rip),%rax        # 14001b340 <__imp__assert>
   140007a03:	ff d0                	call   *%rax
   140007a05:	b9 01 00 00 00       	mov    $0x1,%ecx
   140007a0a:	48 8b 05 b7 38 01 00 	mov    0x138b7(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140007a11:	ff d0                	call   *%rax
   140007a13:	48 89 c2             	mov    %rax,%rdx
   140007a16:	48 8b 85 98 02 00 00 	mov    0x298(%rbp),%rax
   140007a1d:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140007a24:	00 00 
   140007a26:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140007a2c:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140007a32:	48 89 c1             	mov    %rax,%rcx
   140007a35:	e8 a4 b8 ff ff       	call   1400032de <type__print>
   140007a3a:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007a3e:	4c 8d 0d d9 ba 00 00 	lea    0xbad9(%rip),%r9        # 14001351e <.rdata+0x4ce>
   140007a45:	4c 8d 05 b0 bb 00 00 	lea    0xbbb0(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140007a4c:	ba 00 01 00 00       	mov    $0x100,%edx
   140007a51:	48 89 c1             	mov    %rax,%rcx
   140007a54:	e8 77 9b 00 00       	call   1400115d0 <snprintf>
   140007a59:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007a5d:	48 c7 44 24 20 58 14 	movq   $0x1458,0x20(%rsp)
   140007a64:	00 00 
   140007a66:	49 89 c1             	mov    %rax,%r9
   140007a69:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140007a6f:	ba 16 00 00 00       	mov    $0x16,%edx
   140007a74:	48 8d 05 d6 b7 00 00 	lea    0xb7d6(%rip),%rax        # 140013251 <.rdata+0x201>
   140007a7b:	48 89 c1             	mov    %rax,%rcx
   140007a7e:	e8 ad 9b 00 00       	call   140011630 <printf>
   140007a83:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007a87:	4c 8d 0d 90 ba 00 00 	lea    0xba90(%rip),%r9        # 14001351e <.rdata+0x4ce>
   140007a8e:	4c 8d 05 74 bb 00 00 	lea    0xbb74(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140007a95:	ba 00 01 00 00       	mov    $0x100,%edx
   140007a9a:	48 89 c1             	mov    %rax,%rcx
   140007a9d:	e8 2e 9b 00 00       	call   1400115d0 <snprintf>
   140007aa2:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007aa6:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   140007aad:	00 00 
   140007aaf:	49 89 c1             	mov    %rax,%r9
   140007ab2:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140007ab8:	ba 16 00 00 00       	mov    $0x16,%edx
   140007abd:	48 8d 05 8d b7 00 00 	lea    0xb78d(%rip),%rax        # 140013251 <.rdata+0x201>
   140007ac4:	48 89 c1             	mov    %rax,%rcx
   140007ac7:	e8 64 9b 00 00       	call   140011630 <printf>
   140007acc:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140007ad1:	e8 ba 9f 00 00       	call   140011a90 <putchar>
   140007ad6:	48 8b 85 98 02 00 00 	mov    0x298(%rbp),%rax
   140007add:	48 89 c1             	mov    %rax,%rcx
   140007ae0:	e8 86 a6 ff ff       	call   14000216b <type__size>
   140007ae5:	48 3d 58 14 00 00    	cmp    $0x1458,%rax
   140007aeb:	74 23                	je     140007b10 <main2+0x4131>
   140007aed:	41 b8 a7 04 00 00    	mov    $0x4a7,%r8d
   140007af3:	48 8d 05 56 b5 00 00 	lea    0xb556(%rip),%rax        # 140013050 <.rdata>
   140007afa:	48 89 c2             	mov    %rax,%rdx
   140007afd:	48 8d 05 b4 c7 00 00 	lea    0xc7b4(%rip),%rax        # 1400142b8 <.rdata+0x1268>
   140007b04:	48 89 c1             	mov    %rax,%rcx
   140007b07:	48 8b 05 32 38 01 00 	mov    0x13832(%rip),%rax        # 14001b340 <__imp__assert>
   140007b0e:	ff d0                	call   *%rax
   140007b10:	48 8b 85 98 02 00 00 	mov    0x298(%rbp),%rax
   140007b17:	48 8b 40 10          	mov    0x10(%rax),%rax
   140007b1b:	48 83 f8 08          	cmp    $0x8,%rax
   140007b1f:	74 23                	je     140007b44 <main2+0x4165>
   140007b21:	41 b8 a7 04 00 00    	mov    $0x4a7,%r8d
   140007b27:	48 8d 05 22 b5 00 00 	lea    0xb522(%rip),%rax        # 140013050 <.rdata>
   140007b2e:	48 89 c2             	mov    %rax,%rdx
   140007b31:	48 8d 05 b0 c7 00 00 	lea    0xc7b0(%rip),%rax        # 1400142e8 <.rdata+0x1298>
   140007b38:	48 89 c1             	mov    %rax,%rcx
   140007b3b:	48 8b 05 fe 37 01 00 	mov    0x137fe(%rip),%rax        # 14001b340 <__imp__assert>
   140007b42:	ff d0                	call   *%rax
   140007b44:	b9 01 00 00 00       	mov    $0x1,%ecx
   140007b49:	48 8b 05 78 37 01 00 	mov    0x13778(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140007b50:	ff d0                	call   *%rax
   140007b52:	48 89 c2             	mov    %rax,%rdx
   140007b55:	48 8b 85 90 02 00 00 	mov    0x290(%rbp),%rax
   140007b5c:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140007b63:	00 00 
   140007b65:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140007b6b:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140007b71:	48 89 c1             	mov    %rax,%rcx
   140007b74:	e8 65 b7 ff ff       	call   1400032de <type__print>
   140007b79:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007b7d:	4c 8d 0d 9c b9 00 00 	lea    0xb99c(%rip),%r9        # 140013520 <.rdata+0x4d0>
   140007b84:	4c 8d 05 71 ba 00 00 	lea    0xba71(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140007b8b:	ba 00 01 00 00       	mov    $0x100,%edx
   140007b90:	48 89 c1             	mov    %rax,%rcx
   140007b93:	e8 38 9a 00 00       	call   1400115d0 <snprintf>
   140007b98:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007b9c:	48 c7 44 24 20 58 14 	movq   $0x1458,0x20(%rsp)
   140007ba3:	00 00 
   140007ba5:	49 89 c1             	mov    %rax,%r9
   140007ba8:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140007bae:	ba 16 00 00 00       	mov    $0x16,%edx
   140007bb3:	48 8d 05 97 b6 00 00 	lea    0xb697(%rip),%rax        # 140013251 <.rdata+0x201>
   140007bba:	48 89 c1             	mov    %rax,%rcx
   140007bbd:	e8 6e 9a 00 00       	call   140011630 <printf>
   140007bc2:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007bc6:	4c 8d 0d 53 b9 00 00 	lea    0xb953(%rip),%r9        # 140013520 <.rdata+0x4d0>
   140007bcd:	4c 8d 05 35 ba 00 00 	lea    0xba35(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140007bd4:	ba 00 01 00 00       	mov    $0x100,%edx
   140007bd9:	48 89 c1             	mov    %rax,%rcx
   140007bdc:	e8 ef 99 00 00       	call   1400115d0 <snprintf>
   140007be1:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007be5:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   140007bec:	00 00 
   140007bee:	49 89 c1             	mov    %rax,%r9
   140007bf1:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140007bf7:	ba 16 00 00 00       	mov    $0x16,%edx
   140007bfc:	48 8d 05 4e b6 00 00 	lea    0xb64e(%rip),%rax        # 140013251 <.rdata+0x201>
   140007c03:	48 89 c1             	mov    %rax,%rcx
   140007c06:	e8 25 9a 00 00       	call   140011630 <printf>
   140007c0b:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140007c10:	e8 7b 9e 00 00       	call   140011a90 <putchar>
   140007c15:	48 8b 85 90 02 00 00 	mov    0x290(%rbp),%rax
   140007c1c:	48 89 c1             	mov    %rax,%rcx
   140007c1f:	e8 47 a5 ff ff       	call   14000216b <type__size>
   140007c24:	48 3d 58 14 00 00    	cmp    $0x1458,%rax
   140007c2a:	74 23                	je     140007c4f <main2+0x4270>
   140007c2c:	41 b8 a8 04 00 00    	mov    $0x4a8,%r8d
   140007c32:	48 8d 05 17 b4 00 00 	lea    0xb417(%rip),%rax        # 140013050 <.rdata>
   140007c39:	48 89 c2             	mov    %rax,%rdx
   140007c3c:	48 8d 05 cd c6 00 00 	lea    0xc6cd(%rip),%rax        # 140014310 <.rdata+0x12c0>
   140007c43:	48 89 c1             	mov    %rax,%rcx
   140007c46:	48 8b 05 f3 36 01 00 	mov    0x136f3(%rip),%rax        # 14001b340 <__imp__assert>
   140007c4d:	ff d0                	call   *%rax
   140007c4f:	48 8b 85 90 02 00 00 	mov    0x290(%rbp),%rax
   140007c56:	48 8b 40 10          	mov    0x10(%rax),%rax
   140007c5a:	48 83 f8 08          	cmp    $0x8,%rax
   140007c5e:	74 23                	je     140007c83 <main2+0x42a4>
   140007c60:	41 b8 a8 04 00 00    	mov    $0x4a8,%r8d
   140007c66:	48 8d 05 e3 b3 00 00 	lea    0xb3e3(%rip),%rax        # 140013050 <.rdata>
   140007c6d:	48 89 c2             	mov    %rax,%rdx
   140007c70:	48 8d 05 c9 c6 00 00 	lea    0xc6c9(%rip),%rax        # 140014340 <.rdata+0x12f0>
   140007c77:	48 89 c1             	mov    %rax,%rcx
   140007c7a:	48 8b 05 bf 36 01 00 	mov    0x136bf(%rip),%rax        # 14001b340 <__imp__assert>
   140007c81:	ff d0                	call   *%rax
   140007c83:	b9 01 00 00 00       	mov    $0x1,%ecx
   140007c88:	48 8b 05 39 36 01 00 	mov    0x13639(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140007c8f:	ff d0                	call   *%rax
   140007c91:	48 89 c2             	mov    %rax,%rdx
   140007c94:	48 8b 85 88 02 00 00 	mov    0x288(%rbp),%rax
   140007c9b:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140007ca2:	00 00 
   140007ca4:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140007caa:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140007cb0:	48 89 c1             	mov    %rax,%rcx
   140007cb3:	e8 26 b6 ff ff       	call   1400032de <type__print>
   140007cb8:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007cbc:	4c 8d 0d 5f b8 00 00 	lea    0xb85f(%rip),%r9        # 140013522 <.rdata+0x4d2>
   140007cc3:	4c 8d 05 32 b9 00 00 	lea    0xb932(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140007cca:	ba 00 01 00 00       	mov    $0x100,%edx
   140007ccf:	48 89 c1             	mov    %rax,%rcx
   140007cd2:	e8 f9 98 00 00       	call   1400115d0 <snprintf>
   140007cd7:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007cdb:	48 c7 44 24 20 3c 05 	movq   $0x53c,0x20(%rsp)
   140007ce2:	00 00 
   140007ce4:	49 89 c1             	mov    %rax,%r9
   140007ce7:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140007ced:	ba 16 00 00 00       	mov    $0x16,%edx
   140007cf2:	48 8d 05 58 b5 00 00 	lea    0xb558(%rip),%rax        # 140013251 <.rdata+0x201>
   140007cf9:	48 89 c1             	mov    %rax,%rcx
   140007cfc:	e8 2f 99 00 00       	call   140011630 <printf>
   140007d01:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007d05:	4c 8d 0d 16 b8 00 00 	lea    0xb816(%rip),%r9        # 140013522 <.rdata+0x4d2>
   140007d0c:	4c 8d 05 f6 b8 00 00 	lea    0xb8f6(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140007d13:	ba 00 01 00 00       	mov    $0x100,%edx
   140007d18:	48 89 c1             	mov    %rax,%rcx
   140007d1b:	e8 b0 98 00 00       	call   1400115d0 <snprintf>
   140007d20:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007d24:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   140007d2b:	00 00 
   140007d2d:	49 89 c1             	mov    %rax,%r9
   140007d30:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140007d36:	ba 16 00 00 00       	mov    $0x16,%edx
   140007d3b:	48 8d 05 0f b5 00 00 	lea    0xb50f(%rip),%rax        # 140013251 <.rdata+0x201>
   140007d42:	48 89 c1             	mov    %rax,%rcx
   140007d45:	e8 e6 98 00 00       	call   140011630 <printf>
   140007d4a:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140007d4f:	e8 3c 9d 00 00       	call   140011a90 <putchar>
   140007d54:	48 8b 85 88 02 00 00 	mov    0x288(%rbp),%rax
   140007d5b:	48 89 c1             	mov    %rax,%rcx
   140007d5e:	e8 08 a4 ff ff       	call   14000216b <type__size>
   140007d63:	48 3d 3c 05 00 00    	cmp    $0x53c,%rax
   140007d69:	74 23                	je     140007d8e <main2+0x43af>
   140007d6b:	41 b8 a9 04 00 00    	mov    $0x4a9,%r8d
   140007d71:	48 8d 05 d8 b2 00 00 	lea    0xb2d8(%rip),%rax        # 140013050 <.rdata>
   140007d78:	48 89 c2             	mov    %rax,%rdx
   140007d7b:	48 8d 05 e6 c5 00 00 	lea    0xc5e6(%rip),%rax        # 140014368 <.rdata+0x1318>
   140007d82:	48 89 c1             	mov    %rax,%rcx
   140007d85:	48 8b 05 b4 35 01 00 	mov    0x135b4(%rip),%rax        # 14001b340 <__imp__assert>
   140007d8c:	ff d0                	call   *%rax
   140007d8e:	48 8b 85 88 02 00 00 	mov    0x288(%rbp),%rax
   140007d95:	48 8b 40 10          	mov    0x10(%rax),%rax
   140007d99:	48 83 f8 04          	cmp    $0x4,%rax
   140007d9d:	74 23                	je     140007dc2 <main2+0x43e3>
   140007d9f:	41 b8 a9 04 00 00    	mov    $0x4a9,%r8d
   140007da5:	48 8d 05 a4 b2 00 00 	lea    0xb2a4(%rip),%rax        # 140013050 <.rdata>
   140007dac:	48 89 c2             	mov    %rax,%rdx
   140007daf:	48 8d 05 e2 c5 00 00 	lea    0xc5e2(%rip),%rax        # 140014398 <.rdata+0x1348>
   140007db6:	48 89 c1             	mov    %rax,%rcx
   140007db9:	48 8b 05 80 35 01 00 	mov    0x13580(%rip),%rax        # 14001b340 <__imp__assert>
   140007dc0:	ff d0                	call   *%rax
   140007dc2:	b9 01 00 00 00       	mov    $0x1,%ecx
   140007dc7:	48 8b 05 fa 34 01 00 	mov    0x134fa(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140007dce:	ff d0                	call   *%rax
   140007dd0:	48 89 c2             	mov    %rax,%rdx
   140007dd3:	48 8b 85 80 02 00 00 	mov    0x280(%rbp),%rax
   140007dda:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140007de1:	00 00 
   140007de3:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140007de9:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140007def:	48 89 c1             	mov    %rax,%rcx
   140007df2:	e8 e7 b4 ff ff       	call   1400032de <type__print>
   140007df7:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007dfb:	4c 8d 0d 22 b7 00 00 	lea    0xb722(%rip),%r9        # 140013524 <.rdata+0x4d4>
   140007e02:	4c 8d 05 f3 b7 00 00 	lea    0xb7f3(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140007e09:	ba 00 01 00 00       	mov    $0x100,%edx
   140007e0e:	48 89 c1             	mov    %rax,%rcx
   140007e11:	e8 ba 97 00 00       	call   1400115d0 <snprintf>
   140007e16:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007e1a:	48 c7 44 24 20 54 14 	movq   $0x1454,0x20(%rsp)
   140007e21:	00 00 
   140007e23:	49 89 c1             	mov    %rax,%r9
   140007e26:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140007e2c:	ba 16 00 00 00       	mov    $0x16,%edx
   140007e31:	48 8d 05 19 b4 00 00 	lea    0xb419(%rip),%rax        # 140013251 <.rdata+0x201>
   140007e38:	48 89 c1             	mov    %rax,%rcx
   140007e3b:	e8 f0 97 00 00       	call   140011630 <printf>
   140007e40:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007e44:	4c 8d 0d d9 b6 00 00 	lea    0xb6d9(%rip),%r9        # 140013524 <.rdata+0x4d4>
   140007e4b:	4c 8d 05 b7 b7 00 00 	lea    0xb7b7(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140007e52:	ba 00 01 00 00       	mov    $0x100,%edx
   140007e57:	48 89 c1             	mov    %rax,%rcx
   140007e5a:	e8 71 97 00 00       	call   1400115d0 <snprintf>
   140007e5f:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007e63:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   140007e6a:	00 00 
   140007e6c:	49 89 c1             	mov    %rax,%r9
   140007e6f:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140007e75:	ba 16 00 00 00       	mov    $0x16,%edx
   140007e7a:	48 8d 05 d0 b3 00 00 	lea    0xb3d0(%rip),%rax        # 140013251 <.rdata+0x201>
   140007e81:	48 89 c1             	mov    %rax,%rcx
   140007e84:	e8 a7 97 00 00       	call   140011630 <printf>
   140007e89:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140007e8e:	e8 fd 9b 00 00       	call   140011a90 <putchar>
   140007e93:	48 8b 85 80 02 00 00 	mov    0x280(%rbp),%rax
   140007e9a:	48 89 c1             	mov    %rax,%rcx
   140007e9d:	e8 c9 a2 ff ff       	call   14000216b <type__size>
   140007ea2:	48 3d 54 14 00 00    	cmp    $0x1454,%rax
   140007ea8:	74 23                	je     140007ecd <main2+0x44ee>
   140007eaa:	41 b8 aa 04 00 00    	mov    $0x4aa,%r8d
   140007eb0:	48 8d 05 99 b1 00 00 	lea    0xb199(%rip),%rax        # 140013050 <.rdata>
   140007eb7:	48 89 c2             	mov    %rax,%rdx
   140007eba:	48 8d 05 ff c4 00 00 	lea    0xc4ff(%rip),%rax        # 1400143c0 <.rdata+0x1370>
   140007ec1:	48 89 c1             	mov    %rax,%rcx
   140007ec4:	48 8b 05 75 34 01 00 	mov    0x13475(%rip),%rax        # 14001b340 <__imp__assert>
   140007ecb:	ff d0                	call   *%rax
   140007ecd:	48 8b 85 80 02 00 00 	mov    0x280(%rbp),%rax
   140007ed4:	48 8b 40 10          	mov    0x10(%rax),%rax
   140007ed8:	48 83 f8 04          	cmp    $0x4,%rax
   140007edc:	74 23                	je     140007f01 <main2+0x4522>
   140007ede:	41 b8 aa 04 00 00    	mov    $0x4aa,%r8d
   140007ee4:	48 8d 05 65 b1 00 00 	lea    0xb165(%rip),%rax        # 140013050 <.rdata>
   140007eeb:	48 89 c2             	mov    %rax,%rdx
   140007eee:	48 8d 05 fb c4 00 00 	lea    0xc4fb(%rip),%rax        # 1400143f0 <.rdata+0x13a0>
   140007ef5:	48 89 c1             	mov    %rax,%rcx
   140007ef8:	48 8b 05 41 34 01 00 	mov    0x13441(%rip),%rax        # 14001b340 <__imp__assert>
   140007eff:	ff d0                	call   *%rax
   140007f01:	b9 01 00 00 00       	mov    $0x1,%ecx
   140007f06:	48 8b 05 bb 33 01 00 	mov    0x133bb(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140007f0d:	ff d0                	call   *%rax
   140007f0f:	48 89 c2             	mov    %rax,%rdx
   140007f12:	48 8b 85 78 02 00 00 	mov    0x278(%rbp),%rax
   140007f19:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140007f20:	00 00 
   140007f22:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140007f28:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140007f2e:	48 89 c1             	mov    %rax,%rcx
   140007f31:	e8 a8 b3 ff ff       	call   1400032de <type__print>
   140007f36:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007f3a:	4c 8d 0d e5 b5 00 00 	lea    0xb5e5(%rip),%r9        # 140013526 <.rdata+0x4d6>
   140007f41:	4c 8d 05 b4 b6 00 00 	lea    0xb6b4(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140007f48:	ba 00 01 00 00       	mov    $0x100,%edx
   140007f4d:	48 89 c1             	mov    %rax,%rcx
   140007f50:	e8 7b 96 00 00       	call   1400115d0 <snprintf>
   140007f55:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007f59:	48 c7 44 24 20 38 2e 	movq   $0x2e38,0x20(%rsp)
   140007f60:	00 00 
   140007f62:	49 89 c1             	mov    %rax,%r9
   140007f65:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140007f6b:	ba 16 00 00 00       	mov    $0x16,%edx
   140007f70:	48 8d 05 da b2 00 00 	lea    0xb2da(%rip),%rax        # 140013251 <.rdata+0x201>
   140007f77:	48 89 c1             	mov    %rax,%rcx
   140007f7a:	e8 b1 96 00 00       	call   140011630 <printf>
   140007f7f:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007f83:	4c 8d 0d 9c b5 00 00 	lea    0xb59c(%rip),%r9        # 140013526 <.rdata+0x4d6>
   140007f8a:	4c 8d 05 78 b6 00 00 	lea    0xb678(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140007f91:	ba 00 01 00 00       	mov    $0x100,%edx
   140007f96:	48 89 c1             	mov    %rax,%rcx
   140007f99:	e8 32 96 00 00       	call   1400115d0 <snprintf>
   140007f9e:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140007fa2:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   140007fa9:	00 00 
   140007fab:	49 89 c1             	mov    %rax,%r9
   140007fae:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140007fb4:	ba 16 00 00 00       	mov    $0x16,%edx
   140007fb9:	48 8d 05 91 b2 00 00 	lea    0xb291(%rip),%rax        # 140013251 <.rdata+0x201>
   140007fc0:	48 89 c1             	mov    %rax,%rcx
   140007fc3:	e8 68 96 00 00       	call   140011630 <printf>
   140007fc8:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140007fcd:	e8 be 9a 00 00       	call   140011a90 <putchar>
   140007fd2:	48 8b 85 78 02 00 00 	mov    0x278(%rbp),%rax
   140007fd9:	48 89 c1             	mov    %rax,%rcx
   140007fdc:	e8 8a a1 ff ff       	call   14000216b <type__size>
   140007fe1:	48 3d 38 2e 00 00    	cmp    $0x2e38,%rax
   140007fe7:	74 23                	je     14000800c <main2+0x462d>
   140007fe9:	41 b8 ab 04 00 00    	mov    $0x4ab,%r8d
   140007fef:	48 8d 05 5a b0 00 00 	lea    0xb05a(%rip),%rax        # 140013050 <.rdata>
   140007ff6:	48 89 c2             	mov    %rax,%rdx
   140007ff9:	48 8d 05 18 c4 00 00 	lea    0xc418(%rip),%rax        # 140014418 <.rdata+0x13c8>
   140008000:	48 89 c1             	mov    %rax,%rcx
   140008003:	48 8b 05 36 33 01 00 	mov    0x13336(%rip),%rax        # 14001b340 <__imp__assert>
   14000800a:	ff d0                	call   *%rax
   14000800c:	48 8b 85 78 02 00 00 	mov    0x278(%rbp),%rax
   140008013:	48 8b 40 10          	mov    0x10(%rax),%rax
   140008017:	48 83 f8 08          	cmp    $0x8,%rax
   14000801b:	74 23                	je     140008040 <main2+0x4661>
   14000801d:	41 b8 ab 04 00 00    	mov    $0x4ab,%r8d
   140008023:	48 8d 05 26 b0 00 00 	lea    0xb026(%rip),%rax        # 140013050 <.rdata>
   14000802a:	48 89 c2             	mov    %rax,%rdx
   14000802d:	48 8d 05 14 c4 00 00 	lea    0xc414(%rip),%rax        # 140014448 <.rdata+0x13f8>
   140008034:	48 89 c1             	mov    %rax,%rcx
   140008037:	48 8b 05 02 33 01 00 	mov    0x13302(%rip),%rax        # 14001b340 <__imp__assert>
   14000803e:	ff d0                	call   *%rax
   140008040:	b9 01 00 00 00       	mov    $0x1,%ecx
   140008045:	48 8b 05 7c 32 01 00 	mov    0x1327c(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   14000804c:	ff d0                	call   *%rax
   14000804e:	48 89 c2             	mov    %rax,%rdx
   140008051:	48 8b 85 70 02 00 00 	mov    0x270(%rbp),%rax
   140008058:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000805f:	00 00 
   140008061:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140008067:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000806d:	48 89 c1             	mov    %rax,%rcx
   140008070:	e8 69 b2 ff ff       	call   1400032de <type__print>
   140008075:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008079:	4c 8d 0d a8 b4 00 00 	lea    0xb4a8(%rip),%r9        # 140013528 <.rdata+0x4d8>
   140008080:	4c 8d 05 75 b5 00 00 	lea    0xb575(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140008087:	ba 00 01 00 00       	mov    $0x100,%edx
   14000808c:	48 89 c1             	mov    %rax,%rcx
   14000808f:	e8 3c 95 00 00       	call   1400115d0 <snprintf>
   140008094:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008098:	48 c7 44 24 20 36 01 	movq   $0x10136,0x20(%rsp)
   14000809f:	01 00 
   1400080a1:	49 89 c1             	mov    %rax,%r9
   1400080a4:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400080aa:	ba 16 00 00 00       	mov    $0x16,%edx
   1400080af:	48 8d 05 9b b1 00 00 	lea    0xb19b(%rip),%rax        # 140013251 <.rdata+0x201>
   1400080b6:	48 89 c1             	mov    %rax,%rcx
   1400080b9:	e8 72 95 00 00       	call   140011630 <printf>
   1400080be:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400080c2:	4c 8d 0d 5f b4 00 00 	lea    0xb45f(%rip),%r9        # 140013528 <.rdata+0x4d8>
   1400080c9:	4c 8d 05 39 b5 00 00 	lea    0xb539(%rip),%r8        # 140013609 <.rdata+0x5b9>
   1400080d0:	ba 00 01 00 00       	mov    $0x100,%edx
   1400080d5:	48 89 c1             	mov    %rax,%rcx
   1400080d8:	e8 f3 94 00 00       	call   1400115d0 <snprintf>
   1400080dd:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400080e1:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   1400080e8:	00 00 
   1400080ea:	49 89 c1             	mov    %rax,%r9
   1400080ed:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400080f3:	ba 16 00 00 00       	mov    $0x16,%edx
   1400080f8:	48 8d 05 52 b1 00 00 	lea    0xb152(%rip),%rax        # 140013251 <.rdata+0x201>
   1400080ff:	48 89 c1             	mov    %rax,%rcx
   140008102:	e8 29 95 00 00       	call   140011630 <printf>
   140008107:	b9 0a 00 00 00       	mov    $0xa,%ecx
   14000810c:	e8 7f 99 00 00       	call   140011a90 <putchar>
   140008111:	48 8b 85 70 02 00 00 	mov    0x270(%rbp),%rax
   140008118:	48 89 c1             	mov    %rax,%rcx
   14000811b:	e8 4b a0 ff ff       	call   14000216b <type__size>
   140008120:	48 3d 36 01 01 00    	cmp    $0x10136,%rax
   140008126:	74 23                	je     14000814b <main2+0x476c>
   140008128:	41 b8 ac 04 00 00    	mov    $0x4ac,%r8d
   14000812e:	48 8d 05 1b af 00 00 	lea    0xaf1b(%rip),%rax        # 140013050 <.rdata>
   140008135:	48 89 c2             	mov    %rax,%rdx
   140008138:	48 8d 05 31 c3 00 00 	lea    0xc331(%rip),%rax        # 140014470 <.rdata+0x1420>
   14000813f:	48 89 c1             	mov    %rax,%rcx
   140008142:	48 8b 05 f7 31 01 00 	mov    0x131f7(%rip),%rax        # 14001b340 <__imp__assert>
   140008149:	ff d0                	call   *%rax
   14000814b:	48 8b 85 70 02 00 00 	mov    0x270(%rbp),%rax
   140008152:	48 8b 40 10          	mov    0x10(%rax),%rax
   140008156:	48 83 f8 01          	cmp    $0x1,%rax
   14000815a:	74 23                	je     14000817f <main2+0x47a0>
   14000815c:	41 b8 ac 04 00 00    	mov    $0x4ac,%r8d
   140008162:	48 8d 05 e7 ae 00 00 	lea    0xaee7(%rip),%rax        # 140013050 <.rdata>
   140008169:	48 89 c2             	mov    %rax,%rdx
   14000816c:	48 8d 05 2d c3 00 00 	lea    0xc32d(%rip),%rax        # 1400144a0 <.rdata+0x1450>
   140008173:	48 89 c1             	mov    %rax,%rcx
   140008176:	48 8b 05 c3 31 01 00 	mov    0x131c3(%rip),%rax        # 14001b340 <__imp__assert>
   14000817d:	ff d0                	call   *%rax
   14000817f:	b9 01 00 00 00       	mov    $0x1,%ecx
   140008184:	48 8b 05 3d 31 01 00 	mov    0x1313d(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   14000818b:	ff d0                	call   *%rax
   14000818d:	48 89 c2             	mov    %rax,%rdx
   140008190:	48 8b 85 68 02 00 00 	mov    0x268(%rbp),%rax
   140008197:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000819e:	00 00 
   1400081a0:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   1400081a6:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   1400081ac:	48 89 c1             	mov    %rax,%rcx
   1400081af:	e8 2a b1 ff ff       	call   1400032de <type__print>
   1400081b4:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400081b8:	4c 8d 0d 6b b3 00 00 	lea    0xb36b(%rip),%r9        # 14001352a <.rdata+0x4da>
   1400081bf:	4c 8d 05 36 b4 00 00 	lea    0xb436(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   1400081c6:	ba 00 01 00 00       	mov    $0x100,%edx
   1400081cb:	48 89 c1             	mov    %rax,%rcx
   1400081ce:	e8 fd 93 00 00       	call   1400115d0 <snprintf>
   1400081d3:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400081d7:	48 c7 44 24 20 38 01 	movq   $0x10138,0x20(%rsp)
   1400081de:	01 00 
   1400081e0:	49 89 c1             	mov    %rax,%r9
   1400081e3:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400081e9:	ba 16 00 00 00       	mov    $0x16,%edx
   1400081ee:	48 8d 05 5c b0 00 00 	lea    0xb05c(%rip),%rax        # 140013251 <.rdata+0x201>
   1400081f5:	48 89 c1             	mov    %rax,%rcx
   1400081f8:	e8 33 94 00 00       	call   140011630 <printf>
   1400081fd:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008201:	4c 8d 0d 22 b3 00 00 	lea    0xb322(%rip),%r9        # 14001352a <.rdata+0x4da>
   140008208:	4c 8d 05 fa b3 00 00 	lea    0xb3fa(%rip),%r8        # 140013609 <.rdata+0x5b9>
   14000820f:	ba 00 01 00 00       	mov    $0x100,%edx
   140008214:	48 89 c1             	mov    %rax,%rcx
   140008217:	e8 b4 93 00 00       	call   1400115d0 <snprintf>
   14000821c:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008220:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   140008227:	00 00 
   140008229:	49 89 c1             	mov    %rax,%r9
   14000822c:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140008232:	ba 16 00 00 00       	mov    $0x16,%edx
   140008237:	48 8d 05 13 b0 00 00 	lea    0xb013(%rip),%rax        # 140013251 <.rdata+0x201>
   14000823e:	48 89 c1             	mov    %rax,%rcx
   140008241:	e8 ea 93 00 00       	call   140011630 <printf>
   140008246:	b9 0a 00 00 00       	mov    $0xa,%ecx
   14000824b:	e8 40 98 00 00       	call   140011a90 <putchar>
   140008250:	48 8b 85 68 02 00 00 	mov    0x268(%rbp),%rax
   140008257:	48 89 c1             	mov    %rax,%rcx
   14000825a:	e8 0c 9f ff ff       	call   14000216b <type__size>
   14000825f:	48 3d 38 01 01 00    	cmp    $0x10138,%rax
   140008265:	74 23                	je     14000828a <main2+0x48ab>
   140008267:	41 b8 ad 04 00 00    	mov    $0x4ad,%r8d
   14000826d:	48 8d 05 dc ad 00 00 	lea    0xaddc(%rip),%rax        # 140013050 <.rdata>
   140008274:	48 89 c2             	mov    %rax,%rdx
   140008277:	48 8d 05 4a c2 00 00 	lea    0xc24a(%rip),%rax        # 1400144c8 <.rdata+0x1478>
   14000827e:	48 89 c1             	mov    %rax,%rcx
   140008281:	48 8b 05 b8 30 01 00 	mov    0x130b8(%rip),%rax        # 14001b340 <__imp__assert>
   140008288:	ff d0                	call   *%rax
   14000828a:	48 8b 85 68 02 00 00 	mov    0x268(%rbp),%rax
   140008291:	48 8b 40 10          	mov    0x10(%rax),%rax
   140008295:	48 83 f8 04          	cmp    $0x4,%rax
   140008299:	74 23                	je     1400082be <main2+0x48df>
   14000829b:	41 b8 ad 04 00 00    	mov    $0x4ad,%r8d
   1400082a1:	48 8d 05 a8 ad 00 00 	lea    0xada8(%rip),%rax        # 140013050 <.rdata>
   1400082a8:	48 89 c2             	mov    %rax,%rdx
   1400082ab:	48 8d 05 46 c2 00 00 	lea    0xc246(%rip),%rax        # 1400144f8 <.rdata+0x14a8>
   1400082b2:	48 89 c1             	mov    %rax,%rcx
   1400082b5:	48 8b 05 84 30 01 00 	mov    0x13084(%rip),%rax        # 14001b340 <__imp__assert>
   1400082bc:	ff d0                	call   *%rax
   1400082be:	b9 01 00 00 00       	mov    $0x1,%ecx
   1400082c3:	48 8b 05 fe 2f 01 00 	mov    0x12ffe(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   1400082ca:	ff d0                	call   *%rax
   1400082cc:	48 89 c2             	mov    %rax,%rdx
   1400082cf:	48 8b 85 60 02 00 00 	mov    0x260(%rbp),%rax
   1400082d6:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   1400082dd:	00 00 
   1400082df:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   1400082e5:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   1400082eb:	48 89 c1             	mov    %rax,%rcx
   1400082ee:	e8 eb af ff ff       	call   1400032de <type__print>
   1400082f3:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400082f7:	4c 8d 0d 2e b2 00 00 	lea    0xb22e(%rip),%r9        # 14001352c <.rdata+0x4dc>
   1400082fe:	4c 8d 05 f7 b2 00 00 	lea    0xb2f7(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140008305:	ba 00 01 00 00       	mov    $0x100,%edx
   14000830a:	48 89 c1             	mov    %rax,%rcx
   14000830d:	e8 be 92 00 00       	call   1400115d0 <snprintf>
   140008312:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008316:	48 c7 44 24 20 cc 0c 	movq   $0xccc,0x20(%rsp)
   14000831d:	00 00 
   14000831f:	49 89 c1             	mov    %rax,%r9
   140008322:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140008328:	ba 16 00 00 00       	mov    $0x16,%edx
   14000832d:	48 8d 05 1d af 00 00 	lea    0xaf1d(%rip),%rax        # 140013251 <.rdata+0x201>
   140008334:	48 89 c1             	mov    %rax,%rcx
   140008337:	e8 f4 92 00 00       	call   140011630 <printf>
   14000833c:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008340:	4c 8d 0d e5 b1 00 00 	lea    0xb1e5(%rip),%r9        # 14001352c <.rdata+0x4dc>
   140008347:	4c 8d 05 bb b2 00 00 	lea    0xb2bb(%rip),%r8        # 140013609 <.rdata+0x5b9>
   14000834e:	ba 00 01 00 00       	mov    $0x100,%edx
   140008353:	48 89 c1             	mov    %rax,%rcx
   140008356:	e8 75 92 00 00       	call   1400115d0 <snprintf>
   14000835b:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000835f:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140008366:	00 00 
   140008368:	49 89 c1             	mov    %rax,%r9
   14000836b:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140008371:	ba 16 00 00 00       	mov    $0x16,%edx
   140008376:	48 8d 05 d4 ae 00 00 	lea    0xaed4(%rip),%rax        # 140013251 <.rdata+0x201>
   14000837d:	48 89 c1             	mov    %rax,%rcx
   140008380:	e8 ab 92 00 00       	call   140011630 <printf>
   140008385:	b9 0a 00 00 00       	mov    $0xa,%ecx
   14000838a:	e8 01 97 00 00       	call   140011a90 <putchar>
   14000838f:	48 8b 85 60 02 00 00 	mov    0x260(%rbp),%rax
   140008396:	48 89 c1             	mov    %rax,%rcx
   140008399:	e8 cd 9d ff ff       	call   14000216b <type__size>
   14000839e:	48 3d cc 0c 00 00    	cmp    $0xccc,%rax
   1400083a4:	74 23                	je     1400083c9 <main2+0x49ea>
   1400083a6:	41 b8 ae 04 00 00    	mov    $0x4ae,%r8d
   1400083ac:	48 8d 05 9d ac 00 00 	lea    0xac9d(%rip),%rax        # 140013050 <.rdata>
   1400083b3:	48 89 c2             	mov    %rax,%rdx
   1400083b6:	48 8d 05 63 c1 00 00 	lea    0xc163(%rip),%rax        # 140014520 <.rdata+0x14d0>
   1400083bd:	48 89 c1             	mov    %rax,%rcx
   1400083c0:	48 8b 05 79 2f 01 00 	mov    0x12f79(%rip),%rax        # 14001b340 <__imp__assert>
   1400083c7:	ff d0                	call   *%rax
   1400083c9:	48 8b 85 60 02 00 00 	mov    0x260(%rbp),%rax
   1400083d0:	48 8b 40 10          	mov    0x10(%rax),%rax
   1400083d4:	48 83 f8 01          	cmp    $0x1,%rax
   1400083d8:	74 23                	je     1400083fd <main2+0x4a1e>
   1400083da:	41 b8 ae 04 00 00    	mov    $0x4ae,%r8d
   1400083e0:	48 8d 05 69 ac 00 00 	lea    0xac69(%rip),%rax        # 140013050 <.rdata>
   1400083e7:	48 89 c2             	mov    %rax,%rdx
   1400083ea:	48 8d 05 5f c1 00 00 	lea    0xc15f(%rip),%rax        # 140014550 <.rdata+0x1500>
   1400083f1:	48 89 c1             	mov    %rax,%rcx
   1400083f4:	48 8b 05 45 2f 01 00 	mov    0x12f45(%rip),%rax        # 14001b340 <__imp__assert>
   1400083fb:	ff d0                	call   *%rax
   1400083fd:	b9 01 00 00 00       	mov    $0x1,%ecx
   140008402:	48 8b 05 bf 2e 01 00 	mov    0x12ebf(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140008409:	ff d0                	call   *%rax
   14000840b:	48 89 c2             	mov    %rax,%rdx
   14000840e:	48 8b 85 58 02 00 00 	mov    0x258(%rbp),%rax
   140008415:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000841c:	00 00 
   14000841e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140008424:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000842a:	48 89 c1             	mov    %rax,%rcx
   14000842d:	e8 ac ae ff ff       	call   1400032de <type__print>
   140008432:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008436:	4c 8d 0d f1 b0 00 00 	lea    0xb0f1(%rip),%r9        # 14001352e <.rdata+0x4de>
   14000843d:	4c 8d 05 b8 b1 00 00 	lea    0xb1b8(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140008444:	ba 00 01 00 00       	mov    $0x100,%edx
   140008449:	48 89 c1             	mov    %rax,%rcx
   14000844c:	e8 7f 91 00 00       	call   1400115d0 <snprintf>
   140008451:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008455:	48 c7 44 24 20 40 3c 	movq   $0x13c40,0x20(%rsp)
   14000845c:	01 00 
   14000845e:	49 89 c1             	mov    %rax,%r9
   140008461:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140008467:	ba 16 00 00 00       	mov    $0x16,%edx
   14000846c:	48 8d 05 de ad 00 00 	lea    0xadde(%rip),%rax        # 140013251 <.rdata+0x201>
   140008473:	48 89 c1             	mov    %rax,%rcx
   140008476:	e8 b5 91 00 00       	call   140011630 <printf>
   14000847b:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000847f:	4c 8d 0d a8 b0 00 00 	lea    0xb0a8(%rip),%r9        # 14001352e <.rdata+0x4de>
   140008486:	4c 8d 05 7c b1 00 00 	lea    0xb17c(%rip),%r8        # 140013609 <.rdata+0x5b9>
   14000848d:	ba 00 01 00 00       	mov    $0x100,%edx
   140008492:	48 89 c1             	mov    %rax,%rcx
   140008495:	e8 36 91 00 00       	call   1400115d0 <snprintf>
   14000849a:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000849e:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   1400084a5:	00 00 
   1400084a7:	49 89 c1             	mov    %rax,%r9
   1400084aa:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400084b0:	ba 16 00 00 00       	mov    $0x16,%edx
   1400084b5:	48 8d 05 95 ad 00 00 	lea    0xad95(%rip),%rax        # 140013251 <.rdata+0x201>
   1400084bc:	48 89 c1             	mov    %rax,%rcx
   1400084bf:	e8 6c 91 00 00       	call   140011630 <printf>
   1400084c4:	b9 0a 00 00 00       	mov    $0xa,%ecx
   1400084c9:	e8 c2 95 00 00       	call   140011a90 <putchar>
   1400084ce:	48 8b 85 58 02 00 00 	mov    0x258(%rbp),%rax
   1400084d5:	48 89 c1             	mov    %rax,%rcx
   1400084d8:	e8 8e 9c ff ff       	call   14000216b <type__size>
   1400084dd:	48 3d 40 3c 01 00    	cmp    $0x13c40,%rax
   1400084e3:	74 23                	je     140008508 <main2+0x4b29>
   1400084e5:	41 b8 af 04 00 00    	mov    $0x4af,%r8d
   1400084eb:	48 8d 05 5e ab 00 00 	lea    0xab5e(%rip),%rax        # 140013050 <.rdata>
   1400084f2:	48 89 c2             	mov    %rax,%rdx
   1400084f5:	48 8d 05 7c c0 00 00 	lea    0xc07c(%rip),%rax        # 140014578 <.rdata+0x1528>
   1400084fc:	48 89 c1             	mov    %rax,%rcx
   1400084ff:	48 8b 05 3a 2e 01 00 	mov    0x12e3a(%rip),%rax        # 14001b340 <__imp__assert>
   140008506:	ff d0                	call   *%rax
   140008508:	48 8b 85 58 02 00 00 	mov    0x258(%rbp),%rax
   14000850f:	48 8b 40 10          	mov    0x10(%rax),%rax
   140008513:	48 83 f8 08          	cmp    $0x8,%rax
   140008517:	74 23                	je     14000853c <main2+0x4b5d>
   140008519:	41 b8 af 04 00 00    	mov    $0x4af,%r8d
   14000851f:	48 8d 05 2a ab 00 00 	lea    0xab2a(%rip),%rax        # 140013050 <.rdata>
   140008526:	48 89 c2             	mov    %rax,%rdx
   140008529:	48 8d 05 78 c0 00 00 	lea    0xc078(%rip),%rax        # 1400145a8 <.rdata+0x1558>
   140008530:	48 89 c1             	mov    %rax,%rcx
   140008533:	48 8b 05 06 2e 01 00 	mov    0x12e06(%rip),%rax        # 14001b340 <__imp__assert>
   14000853a:	ff d0                	call   *%rax
   14000853c:	b9 01 00 00 00       	mov    $0x1,%ecx
   140008541:	48 8b 05 80 2d 01 00 	mov    0x12d80(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140008548:	ff d0                	call   *%rax
   14000854a:	48 89 c2             	mov    %rax,%rdx
   14000854d:	48 8b 85 50 02 00 00 	mov    0x250(%rbp),%rax
   140008554:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000855b:	00 00 
   14000855d:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140008563:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140008569:	48 89 c1             	mov    %rax,%rcx
   14000856c:	e8 6d ad ff ff       	call   1400032de <type__print>
   140008571:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008575:	4c 8d 0d b4 af 00 00 	lea    0xafb4(%rip),%r9        # 140013530 <.rdata+0x4e0>
   14000857c:	4c 8d 05 79 b0 00 00 	lea    0xb079(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140008583:	ba 00 01 00 00       	mov    $0x100,%edx
   140008588:	48 89 c1             	mov    %rax,%rcx
   14000858b:	e8 40 90 00 00       	call   1400115d0 <snprintf>
   140008590:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008594:	48 c7 44 24 20 00 27 	movq   $0x202700,0x20(%rsp)
   14000859b:	20 00 
   14000859d:	49 89 c1             	mov    %rax,%r9
   1400085a0:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400085a6:	ba 16 00 00 00       	mov    $0x16,%edx
   1400085ab:	48 8d 05 9f ac 00 00 	lea    0xac9f(%rip),%rax        # 140013251 <.rdata+0x201>
   1400085b2:	48 89 c1             	mov    %rax,%rcx
   1400085b5:	e8 76 90 00 00       	call   140011630 <printf>
   1400085ba:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400085be:	4c 8d 0d 6b af 00 00 	lea    0xaf6b(%rip),%r9        # 140013530 <.rdata+0x4e0>
   1400085c5:	4c 8d 05 3d b0 00 00 	lea    0xb03d(%rip),%r8        # 140013609 <.rdata+0x5b9>
   1400085cc:	ba 00 01 00 00       	mov    $0x100,%edx
   1400085d1:	48 89 c1             	mov    %rax,%rcx
   1400085d4:	e8 f7 8f 00 00       	call   1400115d0 <snprintf>
   1400085d9:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400085dd:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   1400085e4:	00 00 
   1400085e6:	49 89 c1             	mov    %rax,%r9
   1400085e9:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400085ef:	ba 16 00 00 00       	mov    $0x16,%edx
   1400085f4:	48 8d 05 56 ac 00 00 	lea    0xac56(%rip),%rax        # 140013251 <.rdata+0x201>
   1400085fb:	48 89 c1             	mov    %rax,%rcx
   1400085fe:	e8 2d 90 00 00       	call   140011630 <printf>
   140008603:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140008608:	e8 83 94 00 00       	call   140011a90 <putchar>
   14000860d:	48 8b 85 50 02 00 00 	mov    0x250(%rbp),%rax
   140008614:	48 89 c1             	mov    %rax,%rcx
   140008617:	e8 4f 9b ff ff       	call   14000216b <type__size>
   14000861c:	48 3d 00 27 20 00    	cmp    $0x202700,%rax
   140008622:	74 23                	je     140008647 <main2+0x4c68>
   140008624:	41 b8 b0 04 00 00    	mov    $0x4b0,%r8d
   14000862a:	48 8d 05 1f aa 00 00 	lea    0xaa1f(%rip),%rax        # 140013050 <.rdata>
   140008631:	48 89 c2             	mov    %rax,%rdx
   140008634:	48 8d 05 95 bf 00 00 	lea    0xbf95(%rip),%rax        # 1400145d0 <.rdata+0x1580>
   14000863b:	48 89 c1             	mov    %rax,%rcx
   14000863e:	48 8b 05 fb 2c 01 00 	mov    0x12cfb(%rip),%rax        # 14001b340 <__imp__assert>
   140008645:	ff d0                	call   *%rax
   140008647:	48 8b 85 50 02 00 00 	mov    0x250(%rbp),%rax
   14000864e:	48 8b 40 10          	mov    0x10(%rax),%rax
   140008652:	48 83 f8 04          	cmp    $0x4,%rax
   140008656:	74 23                	je     14000867b <main2+0x4c9c>
   140008658:	41 b8 b0 04 00 00    	mov    $0x4b0,%r8d
   14000865e:	48 8d 05 eb a9 00 00 	lea    0xa9eb(%rip),%rax        # 140013050 <.rdata>
   140008665:	48 89 c2             	mov    %rax,%rdx
   140008668:	48 8d 05 91 bf 00 00 	lea    0xbf91(%rip),%rax        # 140014600 <.rdata+0x15b0>
   14000866f:	48 89 c1             	mov    %rax,%rcx
   140008672:	48 8b 05 c7 2c 01 00 	mov    0x12cc7(%rip),%rax        # 14001b340 <__imp__assert>
   140008679:	ff d0                	call   *%rax
   14000867b:	b9 01 00 00 00       	mov    $0x1,%ecx
   140008680:	48 8b 05 41 2c 01 00 	mov    0x12c41(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140008687:	ff d0                	call   *%rax
   140008689:	48 89 c2             	mov    %rax,%rdx
   14000868c:	48 8b 85 48 02 00 00 	mov    0x248(%rbp),%rax
   140008693:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000869a:	00 00 
   14000869c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   1400086a2:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   1400086a8:	48 89 c1             	mov    %rax,%rcx
   1400086ab:	e8 2e ac ff ff       	call   1400032de <type__print>
   1400086b0:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400086b4:	4c 8d 0d 78 ae 00 00 	lea    0xae78(%rip),%r9        # 140013533 <.rdata+0x4e3>
   1400086bb:	4c 8d 05 3a af 00 00 	lea    0xaf3a(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   1400086c2:	ba 00 01 00 00       	mov    $0x100,%edx
   1400086c7:	48 89 c1             	mov    %rax,%rcx
   1400086ca:	e8 01 8f 00 00       	call   1400115d0 <snprintf>
   1400086cf:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400086d3:	48 c7 44 24 20 80 c4 	movq   $0x3dc480,0x20(%rsp)
   1400086da:	3d 00 
   1400086dc:	49 89 c1             	mov    %rax,%r9
   1400086df:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400086e5:	ba 16 00 00 00       	mov    $0x16,%edx
   1400086ea:	48 8d 05 60 ab 00 00 	lea    0xab60(%rip),%rax        # 140013251 <.rdata+0x201>
   1400086f1:	48 89 c1             	mov    %rax,%rcx
   1400086f4:	e8 37 8f 00 00       	call   140011630 <printf>
   1400086f9:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400086fd:	4c 8d 0d 2f ae 00 00 	lea    0xae2f(%rip),%r9        # 140013533 <.rdata+0x4e3>
   140008704:	4c 8d 05 fe ae 00 00 	lea    0xaefe(%rip),%r8        # 140013609 <.rdata+0x5b9>
   14000870b:	ba 00 01 00 00       	mov    $0x100,%edx
   140008710:	48 89 c1             	mov    %rax,%rcx
   140008713:	e8 b8 8e 00 00       	call   1400115d0 <snprintf>
   140008718:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000871c:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   140008723:	00 00 
   140008725:	49 89 c1             	mov    %rax,%r9
   140008728:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000872e:	ba 16 00 00 00       	mov    $0x16,%edx
   140008733:	48 8d 05 17 ab 00 00 	lea    0xab17(%rip),%rax        # 140013251 <.rdata+0x201>
   14000873a:	48 89 c1             	mov    %rax,%rcx
   14000873d:	e8 ee 8e 00 00       	call   140011630 <printf>
   140008742:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140008747:	e8 44 93 00 00       	call   140011a90 <putchar>
   14000874c:	48 8b 85 48 02 00 00 	mov    0x248(%rbp),%rax
   140008753:	48 89 c1             	mov    %rax,%rcx
   140008756:	e8 10 9a ff ff       	call   14000216b <type__size>
   14000875b:	48 3d 80 c4 3d 00    	cmp    $0x3dc480,%rax
   140008761:	74 23                	je     140008786 <main2+0x4da7>
   140008763:	41 b8 b1 04 00 00    	mov    $0x4b1,%r8d
   140008769:	48 8d 05 e0 a8 00 00 	lea    0xa8e0(%rip),%rax        # 140013050 <.rdata>
   140008770:	48 89 c2             	mov    %rax,%rdx
   140008773:	48 8d 05 ae be 00 00 	lea    0xbeae(%rip),%rax        # 140014628 <.rdata+0x15d8>
   14000877a:	48 89 c1             	mov    %rax,%rcx
   14000877d:	48 8b 05 bc 2b 01 00 	mov    0x12bbc(%rip),%rax        # 14001b340 <__imp__assert>
   140008784:	ff d0                	call   *%rax
   140008786:	48 8b 85 48 02 00 00 	mov    0x248(%rbp),%rax
   14000878d:	48 8b 40 10          	mov    0x10(%rax),%rax
   140008791:	48 83 f8 08          	cmp    $0x8,%rax
   140008795:	74 23                	je     1400087ba <main2+0x4ddb>
   140008797:	41 b8 b1 04 00 00    	mov    $0x4b1,%r8d
   14000879d:	48 8d 05 ac a8 00 00 	lea    0xa8ac(%rip),%rax        # 140013050 <.rdata>
   1400087a4:	48 89 c2             	mov    %rax,%rdx
   1400087a7:	48 8d 05 aa be 00 00 	lea    0xbeaa(%rip),%rax        # 140014658 <.rdata+0x1608>
   1400087ae:	48 89 c1             	mov    %rax,%rcx
   1400087b1:	48 8b 05 88 2b 01 00 	mov    0x12b88(%rip),%rax        # 14001b340 <__imp__assert>
   1400087b8:	ff d0                	call   *%rax
   1400087ba:	b9 01 00 00 00       	mov    $0x1,%ecx
   1400087bf:	48 8b 05 02 2b 01 00 	mov    0x12b02(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   1400087c6:	ff d0                	call   *%rax
   1400087c8:	48 89 c2             	mov    %rax,%rdx
   1400087cb:	48 8b 85 40 02 00 00 	mov    0x240(%rbp),%rax
   1400087d2:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   1400087d9:	00 00 
   1400087db:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   1400087e1:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   1400087e7:	48 89 c1             	mov    %rax,%rcx
   1400087ea:	e8 ef aa ff ff       	call   1400032de <type__print>
   1400087ef:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400087f3:	4c 8d 0d 3c ad 00 00 	lea    0xad3c(%rip),%r9        # 140013536 <.rdata+0x4e6>
   1400087fa:	4c 8d 05 fb ad 00 00 	lea    0xadfb(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140008801:	ba 00 01 00 00       	mov    $0x100,%edx
   140008806:	48 89 c1             	mov    %rax,%rcx
   140008809:	e8 c2 8d 00 00       	call   1400115d0 <snprintf>
   14000880e:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008812:	48 c7 44 24 20 88 2f 	movq   $0x272f88,0x20(%rsp)
   140008819:	27 00 
   14000881b:	49 89 c1             	mov    %rax,%r9
   14000881e:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140008824:	ba 16 00 00 00       	mov    $0x16,%edx
   140008829:	48 8d 05 21 aa 00 00 	lea    0xaa21(%rip),%rax        # 140013251 <.rdata+0x201>
   140008830:	48 89 c1             	mov    %rax,%rcx
   140008833:	e8 f8 8d 00 00       	call   140011630 <printf>
   140008838:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000883c:	4c 8d 0d f3 ac 00 00 	lea    0xacf3(%rip),%r9        # 140013536 <.rdata+0x4e6>
   140008843:	4c 8d 05 bf ad 00 00 	lea    0xadbf(%rip),%r8        # 140013609 <.rdata+0x5b9>
   14000884a:	ba 00 01 00 00       	mov    $0x100,%edx
   14000884f:	48 89 c1             	mov    %rax,%rcx
   140008852:	e8 79 8d 00 00       	call   1400115d0 <snprintf>
   140008857:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000885b:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   140008862:	00 00 
   140008864:	49 89 c1             	mov    %rax,%r9
   140008867:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000886d:	ba 16 00 00 00       	mov    $0x16,%edx
   140008872:	48 8d 05 d8 a9 00 00 	lea    0xa9d8(%rip),%rax        # 140013251 <.rdata+0x201>
   140008879:	48 89 c1             	mov    %rax,%rcx
   14000887c:	e8 af 8d 00 00       	call   140011630 <printf>
   140008881:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140008886:	e8 05 92 00 00       	call   140011a90 <putchar>
   14000888b:	48 8b 85 40 02 00 00 	mov    0x240(%rbp),%rax
   140008892:	48 89 c1             	mov    %rax,%rcx
   140008895:	e8 d1 98 ff ff       	call   14000216b <type__size>
   14000889a:	48 3d 88 2f 27 00    	cmp    $0x272f88,%rax
   1400088a0:	74 23                	je     1400088c5 <main2+0x4ee6>
   1400088a2:	41 b8 b2 04 00 00    	mov    $0x4b2,%r8d
   1400088a8:	48 8d 05 a1 a7 00 00 	lea    0xa7a1(%rip),%rax        # 140013050 <.rdata>
   1400088af:	48 89 c2             	mov    %rax,%rdx
   1400088b2:	48 8d 05 c7 bd 00 00 	lea    0xbdc7(%rip),%rax        # 140014680 <.rdata+0x1630>
   1400088b9:	48 89 c1             	mov    %rax,%rcx
   1400088bc:	48 8b 05 7d 2a 01 00 	mov    0x12a7d(%rip),%rax        # 14001b340 <__imp__assert>
   1400088c3:	ff d0                	call   *%rax
   1400088c5:	48 8b 85 40 02 00 00 	mov    0x240(%rbp),%rax
   1400088cc:	48 8b 40 10          	mov    0x10(%rax),%rax
   1400088d0:	48 83 f8 04          	cmp    $0x4,%rax
   1400088d4:	74 23                	je     1400088f9 <main2+0x4f1a>
   1400088d6:	41 b8 b2 04 00 00    	mov    $0x4b2,%r8d
   1400088dc:	48 8d 05 6d a7 00 00 	lea    0xa76d(%rip),%rax        # 140013050 <.rdata>
   1400088e3:	48 89 c2             	mov    %rax,%rdx
   1400088e6:	48 8d 05 c3 bd 00 00 	lea    0xbdc3(%rip),%rax        # 1400146b0 <.rdata+0x1660>
   1400088ed:	48 89 c1             	mov    %rax,%rcx
   1400088f0:	48 8b 05 49 2a 01 00 	mov    0x12a49(%rip),%rax        # 14001b340 <__imp__assert>
   1400088f7:	ff d0                	call   *%rax
   1400088f9:	b9 01 00 00 00       	mov    $0x1,%ecx
   1400088fe:	48 8b 05 c3 29 01 00 	mov    0x129c3(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140008905:	ff d0                	call   *%rax
   140008907:	48 89 c2             	mov    %rax,%rdx
   14000890a:	48 8b 85 38 02 00 00 	mov    0x238(%rbp),%rax
   140008911:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140008918:	00 00 
   14000891a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140008920:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140008926:	48 89 c1             	mov    %rax,%rcx
   140008929:	e8 b0 a9 ff ff       	call   1400032de <type__print>
   14000892e:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008932:	4c 8d 0d 00 ac 00 00 	lea    0xac00(%rip),%r9        # 140013539 <.rdata+0x4e9>
   140008939:	4c 8d 05 bc ac 00 00 	lea    0xacbc(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140008940:	ba 00 01 00 00       	mov    $0x100,%edx
   140008945:	48 89 c1             	mov    %rax,%rcx
   140008948:	e8 83 8c 00 00       	call   1400115d0 <snprintf>
   14000894d:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008951:	48 c7 44 24 20 80 c4 	movq   $0x3dc480,0x20(%rsp)
   140008958:	3d 00 
   14000895a:	49 89 c1             	mov    %rax,%r9
   14000895d:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140008963:	ba 16 00 00 00       	mov    $0x16,%edx
   140008968:	48 8d 05 e2 a8 00 00 	lea    0xa8e2(%rip),%rax        # 140013251 <.rdata+0x201>
   14000896f:	48 89 c1             	mov    %rax,%rcx
   140008972:	e8 b9 8c 00 00       	call   140011630 <printf>
   140008977:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000897b:	4c 8d 0d b7 ab 00 00 	lea    0xabb7(%rip),%r9        # 140013539 <.rdata+0x4e9>
   140008982:	4c 8d 05 80 ac 00 00 	lea    0xac80(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140008989:	ba 00 01 00 00       	mov    $0x100,%edx
   14000898e:	48 89 c1             	mov    %rax,%rcx
   140008991:	e8 3a 8c 00 00       	call   1400115d0 <snprintf>
   140008996:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000899a:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   1400089a1:	00 00 
   1400089a3:	49 89 c1             	mov    %rax,%r9
   1400089a6:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400089ac:	ba 16 00 00 00       	mov    $0x16,%edx
   1400089b1:	48 8d 05 99 a8 00 00 	lea    0xa899(%rip),%rax        # 140013251 <.rdata+0x201>
   1400089b8:	48 89 c1             	mov    %rax,%rcx
   1400089bb:	e8 70 8c 00 00       	call   140011630 <printf>
   1400089c0:	b9 0a 00 00 00       	mov    $0xa,%ecx
   1400089c5:	e8 c6 90 00 00       	call   140011a90 <putchar>
   1400089ca:	48 8b 85 38 02 00 00 	mov    0x238(%rbp),%rax
   1400089d1:	48 89 c1             	mov    %rax,%rcx
   1400089d4:	e8 92 97 ff ff       	call   14000216b <type__size>
   1400089d9:	48 3d 80 c4 3d 00    	cmp    $0x3dc480,%rax
   1400089df:	74 23                	je     140008a04 <main2+0x5025>
   1400089e1:	41 b8 b3 04 00 00    	mov    $0x4b3,%r8d
   1400089e7:	48 8d 05 62 a6 00 00 	lea    0xa662(%rip),%rax        # 140013050 <.rdata>
   1400089ee:	48 89 c2             	mov    %rax,%rdx
   1400089f1:	48 8d 05 e0 bc 00 00 	lea    0xbce0(%rip),%rax        # 1400146d8 <.rdata+0x1688>
   1400089f8:	48 89 c1             	mov    %rax,%rcx
   1400089fb:	48 8b 05 3e 29 01 00 	mov    0x1293e(%rip),%rax        # 14001b340 <__imp__assert>
   140008a02:	ff d0                	call   *%rax
   140008a04:	48 8b 85 38 02 00 00 	mov    0x238(%rbp),%rax
   140008a0b:	48 8b 40 10          	mov    0x10(%rax),%rax
   140008a0f:	48 83 f8 01          	cmp    $0x1,%rax
   140008a13:	74 23                	je     140008a38 <main2+0x5059>
   140008a15:	41 b8 b3 04 00 00    	mov    $0x4b3,%r8d
   140008a1b:	48 8d 05 2e a6 00 00 	lea    0xa62e(%rip),%rax        # 140013050 <.rdata>
   140008a22:	48 89 c2             	mov    %rax,%rdx
   140008a25:	48 8d 05 dc bc 00 00 	lea    0xbcdc(%rip),%rax        # 140014708 <.rdata+0x16b8>
   140008a2c:	48 89 c1             	mov    %rax,%rcx
   140008a2f:	48 8b 05 0a 29 01 00 	mov    0x1290a(%rip),%rax        # 14001b340 <__imp__assert>
   140008a36:	ff d0                	call   *%rax
   140008a38:	b9 01 00 00 00       	mov    $0x1,%ecx
   140008a3d:	48 8b 05 84 28 01 00 	mov    0x12884(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140008a44:	ff d0                	call   *%rax
   140008a46:	48 89 c2             	mov    %rax,%rdx
   140008a49:	48 8b 85 30 02 00 00 	mov    0x230(%rbp),%rax
   140008a50:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140008a57:	00 00 
   140008a59:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140008a5f:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140008a65:	48 89 c1             	mov    %rax,%rcx
   140008a68:	e8 71 a8 ff ff       	call   1400032de <type__print>
   140008a6d:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008a71:	4c 8d 0d c4 aa 00 00 	lea    0xaac4(%rip),%r9        # 14001353c <.rdata+0x4ec>
   140008a78:	4c 8d 05 7d ab 00 00 	lea    0xab7d(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140008a7f:	ba 00 01 00 00       	mov    $0x100,%edx
   140008a84:	48 89 c1             	mov    %rax,%rcx
   140008a87:	e8 44 8b 00 00       	call   1400115d0 <snprintf>
   140008a8c:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008a90:	48 c7 44 24 20 00 ec 	movq   $0x5dec00,0x20(%rsp)
   140008a97:	5d 00 
   140008a99:	49 89 c1             	mov    %rax,%r9
   140008a9c:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140008aa2:	ba 16 00 00 00       	mov    $0x16,%edx
   140008aa7:	48 8d 05 a3 a7 00 00 	lea    0xa7a3(%rip),%rax        # 140013251 <.rdata+0x201>
   140008aae:	48 89 c1             	mov    %rax,%rcx
   140008ab1:	e8 7a 8b 00 00       	call   140011630 <printf>
   140008ab6:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008aba:	4c 8d 0d 7b aa 00 00 	lea    0xaa7b(%rip),%r9        # 14001353c <.rdata+0x4ec>
   140008ac1:	4c 8d 05 41 ab 00 00 	lea    0xab41(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140008ac8:	ba 00 01 00 00       	mov    $0x100,%edx
   140008acd:	48 89 c1             	mov    %rax,%rcx
   140008ad0:	e8 fb 8a 00 00       	call   1400115d0 <snprintf>
   140008ad5:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008ad9:	48 c7 44 24 20 00 04 	movq   $0x400,0x20(%rsp)
   140008ae0:	00 00 
   140008ae2:	49 89 c1             	mov    %rax,%r9
   140008ae5:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140008aeb:	ba 16 00 00 00       	mov    $0x16,%edx
   140008af0:	48 8d 05 5a a7 00 00 	lea    0xa75a(%rip),%rax        # 140013251 <.rdata+0x201>
   140008af7:	48 89 c1             	mov    %rax,%rcx
   140008afa:	e8 31 8b 00 00       	call   140011630 <printf>
   140008aff:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140008b04:	e8 87 8f 00 00       	call   140011a90 <putchar>
   140008b09:	48 8b 85 30 02 00 00 	mov    0x230(%rbp),%rax
   140008b10:	48 89 c1             	mov    %rax,%rcx
   140008b13:	e8 53 96 ff ff       	call   14000216b <type__size>
   140008b18:	48 3d 00 ec 5d 00    	cmp    $0x5dec00,%rax
   140008b1e:	74 23                	je     140008b43 <main2+0x5164>
   140008b20:	41 b8 b4 04 00 00    	mov    $0x4b4,%r8d
   140008b26:	48 8d 05 23 a5 00 00 	lea    0xa523(%rip),%rax        # 140013050 <.rdata>
   140008b2d:	48 89 c2             	mov    %rax,%rdx
   140008b30:	48 8d 05 f9 bb 00 00 	lea    0xbbf9(%rip),%rax        # 140014730 <.rdata+0x16e0>
   140008b37:	48 89 c1             	mov    %rax,%rcx
   140008b3a:	48 8b 05 ff 27 01 00 	mov    0x127ff(%rip),%rax        # 14001b340 <__imp__assert>
   140008b41:	ff d0                	call   *%rax
   140008b43:	48 8b 85 30 02 00 00 	mov    0x230(%rbp),%rax
   140008b4a:	48 8b 40 10          	mov    0x10(%rax),%rax
   140008b4e:	48 3d 00 04 00 00    	cmp    $0x400,%rax
   140008b54:	74 23                	je     140008b79 <main2+0x519a>
   140008b56:	41 b8 b4 04 00 00    	mov    $0x4b4,%r8d
   140008b5c:	48 8d 05 ed a4 00 00 	lea    0xa4ed(%rip),%rax        # 140013050 <.rdata>
   140008b63:	48 89 c2             	mov    %rax,%rdx
   140008b66:	48 8d 05 f3 bb 00 00 	lea    0xbbf3(%rip),%rax        # 140014760 <.rdata+0x1710>
   140008b6d:	48 89 c1             	mov    %rax,%rcx
   140008b70:	48 8b 05 c9 27 01 00 	mov    0x127c9(%rip),%rax        # 14001b340 <__imp__assert>
   140008b77:	ff d0                	call   *%rax
   140008b79:	b9 01 00 00 00       	mov    $0x1,%ecx
   140008b7e:	48 8b 05 43 27 01 00 	mov    0x12743(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140008b85:	ff d0                	call   *%rax
   140008b87:	48 89 c2             	mov    %rax,%rdx
   140008b8a:	48 8b 85 28 02 00 00 	mov    0x228(%rbp),%rax
   140008b91:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140008b98:	00 00 
   140008b9a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140008ba0:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140008ba6:	48 89 c1             	mov    %rax,%rcx
   140008ba9:	e8 30 a7 ff ff       	call   1400032de <type__print>
   140008bae:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008bb2:	4c 8d 0d 86 a9 00 00 	lea    0xa986(%rip),%r9        # 14001353f <.rdata+0x4ef>
   140008bb9:	4c 8d 05 3c aa 00 00 	lea    0xaa3c(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140008bc0:	ba 00 01 00 00       	mov    $0x100,%edx
   140008bc5:	48 89 c1             	mov    %rax,%rcx
   140008bc8:	e8 03 8a 00 00       	call   1400115d0 <snprintf>
   140008bcd:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008bd1:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140008bd8:	00 00 
   140008bda:	49 89 c1             	mov    %rax,%r9
   140008bdd:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140008be3:	ba 16 00 00 00       	mov    $0x16,%edx
   140008be8:	48 8d 05 62 a6 00 00 	lea    0xa662(%rip),%rax        # 140013251 <.rdata+0x201>
   140008bef:	48 89 c1             	mov    %rax,%rcx
   140008bf2:	e8 39 8a 00 00       	call   140011630 <printf>
   140008bf7:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008bfb:	4c 8d 0d 3d a9 00 00 	lea    0xa93d(%rip),%r9        # 14001353f <.rdata+0x4ef>
   140008c02:	4c 8d 05 00 aa 00 00 	lea    0xaa00(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140008c09:	ba 00 01 00 00       	mov    $0x100,%edx
   140008c0e:	48 89 c1             	mov    %rax,%rcx
   140008c11:	e8 ba 89 00 00       	call   1400115d0 <snprintf>
   140008c16:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008c1a:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140008c21:	00 00 
   140008c23:	49 89 c1             	mov    %rax,%r9
   140008c26:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140008c2c:	ba 16 00 00 00       	mov    $0x16,%edx
   140008c31:	48 8d 05 19 a6 00 00 	lea    0xa619(%rip),%rax        # 140013251 <.rdata+0x201>
   140008c38:	48 89 c1             	mov    %rax,%rcx
   140008c3b:	e8 f0 89 00 00       	call   140011630 <printf>
   140008c40:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140008c45:	e8 46 8e 00 00       	call   140011a90 <putchar>
   140008c4a:	48 8b 85 28 02 00 00 	mov    0x228(%rbp),%rax
   140008c51:	48 89 c1             	mov    %rax,%rcx
   140008c54:	e8 12 95 ff ff       	call   14000216b <type__size>
   140008c59:	48 83 f8 01          	cmp    $0x1,%rax
   140008c5d:	74 23                	je     140008c82 <main2+0x52a3>
   140008c5f:	41 b8 b5 04 00 00    	mov    $0x4b5,%r8d
   140008c65:	48 8d 05 e4 a3 00 00 	lea    0xa3e4(%rip),%rax        # 140013050 <.rdata>
   140008c6c:	48 89 c2             	mov    %rax,%rdx
   140008c6f:	48 8d 05 12 bb 00 00 	lea    0xbb12(%rip),%rax        # 140014788 <.rdata+0x1738>
   140008c76:	48 89 c1             	mov    %rax,%rcx
   140008c79:	48 8b 05 c0 26 01 00 	mov    0x126c0(%rip),%rax        # 14001b340 <__imp__assert>
   140008c80:	ff d0                	call   *%rax
   140008c82:	48 8b 85 28 02 00 00 	mov    0x228(%rbp),%rax
   140008c89:	48 8b 40 10          	mov    0x10(%rax),%rax
   140008c8d:	48 83 f8 01          	cmp    $0x1,%rax
   140008c91:	74 23                	je     140008cb6 <main2+0x52d7>
   140008c93:	41 b8 b5 04 00 00    	mov    $0x4b5,%r8d
   140008c99:	48 8d 05 b0 a3 00 00 	lea    0xa3b0(%rip),%rax        # 140013050 <.rdata>
   140008ca0:	48 89 c2             	mov    %rax,%rdx
   140008ca3:	48 8d 05 0e bb 00 00 	lea    0xbb0e(%rip),%rax        # 1400147b8 <.rdata+0x1768>
   140008caa:	48 89 c1             	mov    %rax,%rcx
   140008cad:	48 8b 05 8c 26 01 00 	mov    0x1268c(%rip),%rax        # 14001b340 <__imp__assert>
   140008cb4:	ff d0                	call   *%rax
   140008cb6:	b9 01 00 00 00       	mov    $0x1,%ecx
   140008cbb:	48 8b 05 06 26 01 00 	mov    0x12606(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140008cc2:	ff d0                	call   *%rax
   140008cc4:	48 89 c2             	mov    %rax,%rdx
   140008cc7:	48 8b 85 20 02 00 00 	mov    0x220(%rbp),%rax
   140008cce:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140008cd5:	00 00 
   140008cd7:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140008cdd:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140008ce3:	48 89 c1             	mov    %rax,%rcx
   140008ce6:	e8 f3 a5 ff ff       	call   1400032de <type__print>
   140008ceb:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008cef:	4c 8d 0d 4c a8 00 00 	lea    0xa84c(%rip),%r9        # 140013542 <.rdata+0x4f2>
   140008cf6:	4c 8d 05 ff a8 00 00 	lea    0xa8ff(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140008cfd:	ba 00 01 00 00       	mov    $0x100,%edx
   140008d02:	48 89 c1             	mov    %rax,%rcx
   140008d05:	e8 c6 88 00 00       	call   1400115d0 <snprintf>
   140008d0a:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008d0e:	48 c7 44 24 20 05 00 	movq   $0x5,0x20(%rsp)
   140008d15:	00 00 
   140008d17:	49 89 c1             	mov    %rax,%r9
   140008d1a:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140008d20:	ba 16 00 00 00       	mov    $0x16,%edx
   140008d25:	48 8d 05 25 a5 00 00 	lea    0xa525(%rip),%rax        # 140013251 <.rdata+0x201>
   140008d2c:	48 89 c1             	mov    %rax,%rcx
   140008d2f:	e8 fc 88 00 00       	call   140011630 <printf>
   140008d34:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008d38:	4c 8d 0d 03 a8 00 00 	lea    0xa803(%rip),%r9        # 140013542 <.rdata+0x4f2>
   140008d3f:	4c 8d 05 c3 a8 00 00 	lea    0xa8c3(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140008d46:	ba 00 01 00 00       	mov    $0x100,%edx
   140008d4b:	48 89 c1             	mov    %rax,%rcx
   140008d4e:	e8 7d 88 00 00       	call   1400115d0 <snprintf>
   140008d53:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008d57:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140008d5e:	00 00 
   140008d60:	49 89 c1             	mov    %rax,%r9
   140008d63:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140008d69:	ba 16 00 00 00       	mov    $0x16,%edx
   140008d6e:	48 8d 05 dc a4 00 00 	lea    0xa4dc(%rip),%rax        # 140013251 <.rdata+0x201>
   140008d75:	48 89 c1             	mov    %rax,%rcx
   140008d78:	e8 b3 88 00 00       	call   140011630 <printf>
   140008d7d:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140008d82:	e8 09 8d 00 00       	call   140011a90 <putchar>
   140008d87:	48 8b 85 20 02 00 00 	mov    0x220(%rbp),%rax
   140008d8e:	48 89 c1             	mov    %rax,%rcx
   140008d91:	e8 d5 93 ff ff       	call   14000216b <type__size>
   140008d96:	48 83 f8 05          	cmp    $0x5,%rax
   140008d9a:	74 23                	je     140008dbf <main2+0x53e0>
   140008d9c:	41 b8 b6 04 00 00    	mov    $0x4b6,%r8d
   140008da2:	48 8d 05 a7 a2 00 00 	lea    0xa2a7(%rip),%rax        # 140013050 <.rdata>
   140008da9:	48 89 c2             	mov    %rax,%rdx
   140008dac:	48 8d 05 2d ba 00 00 	lea    0xba2d(%rip),%rax        # 1400147e0 <.rdata+0x1790>
   140008db3:	48 89 c1             	mov    %rax,%rcx
   140008db6:	48 8b 05 83 25 01 00 	mov    0x12583(%rip),%rax        # 14001b340 <__imp__assert>
   140008dbd:	ff d0                	call   *%rax
   140008dbf:	48 8b 85 20 02 00 00 	mov    0x220(%rbp),%rax
   140008dc6:	48 8b 40 10          	mov    0x10(%rax),%rax
   140008dca:	48 83 f8 01          	cmp    $0x1,%rax
   140008dce:	74 23                	je     140008df3 <main2+0x5414>
   140008dd0:	41 b8 b6 04 00 00    	mov    $0x4b6,%r8d
   140008dd6:	48 8d 05 73 a2 00 00 	lea    0xa273(%rip),%rax        # 140013050 <.rdata>
   140008ddd:	48 89 c2             	mov    %rax,%rdx
   140008de0:	48 8d 05 29 ba 00 00 	lea    0xba29(%rip),%rax        # 140014810 <.rdata+0x17c0>
   140008de7:	48 89 c1             	mov    %rax,%rcx
   140008dea:	48 8b 05 4f 25 01 00 	mov    0x1254f(%rip),%rax        # 14001b340 <__imp__assert>
   140008df1:	ff d0                	call   *%rax
   140008df3:	b9 01 00 00 00       	mov    $0x1,%ecx
   140008df8:	48 8b 05 c9 24 01 00 	mov    0x124c9(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140008dff:	ff d0                	call   *%rax
   140008e01:	48 89 c2             	mov    %rax,%rdx
   140008e04:	48 8b 85 18 02 00 00 	mov    0x218(%rbp),%rax
   140008e0b:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140008e12:	00 00 
   140008e14:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140008e1a:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140008e20:	48 89 c1             	mov    %rax,%rcx
   140008e23:	e8 b6 a4 ff ff       	call   1400032de <type__print>
   140008e28:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008e2c:	4c 8d 0d 12 a7 00 00 	lea    0xa712(%rip),%r9        # 140013545 <.rdata+0x4f5>
   140008e33:	4c 8d 05 c2 a7 00 00 	lea    0xa7c2(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140008e3a:	ba 00 01 00 00       	mov    $0x100,%edx
   140008e3f:	48 89 c1             	mov    %rax,%rcx
   140008e42:	e8 89 87 00 00       	call   1400115d0 <snprintf>
   140008e47:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008e4b:	48 c7 44 24 20 0c 00 	movq   $0xc,0x20(%rsp)
   140008e52:	00 00 
   140008e54:	49 89 c1             	mov    %rax,%r9
   140008e57:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140008e5d:	ba 16 00 00 00       	mov    $0x16,%edx
   140008e62:	48 8d 05 e8 a3 00 00 	lea    0xa3e8(%rip),%rax        # 140013251 <.rdata+0x201>
   140008e69:	48 89 c1             	mov    %rax,%rcx
   140008e6c:	e8 bf 87 00 00       	call   140011630 <printf>
   140008e71:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008e75:	4c 8d 0d c9 a6 00 00 	lea    0xa6c9(%rip),%r9        # 140013545 <.rdata+0x4f5>
   140008e7c:	4c 8d 05 86 a7 00 00 	lea    0xa786(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140008e83:	ba 00 01 00 00       	mov    $0x100,%edx
   140008e88:	48 89 c1             	mov    %rax,%rcx
   140008e8b:	e8 40 87 00 00       	call   1400115d0 <snprintf>
   140008e90:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008e94:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140008e9b:	00 00 
   140008e9d:	49 89 c1             	mov    %rax,%r9
   140008ea0:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140008ea6:	ba 16 00 00 00       	mov    $0x16,%edx
   140008eab:	48 8d 05 9f a3 00 00 	lea    0xa39f(%rip),%rax        # 140013251 <.rdata+0x201>
   140008eb2:	48 89 c1             	mov    %rax,%rcx
   140008eb5:	e8 76 87 00 00       	call   140011630 <printf>
   140008eba:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140008ebf:	e8 cc 8b 00 00       	call   140011a90 <putchar>
   140008ec4:	48 8b 85 18 02 00 00 	mov    0x218(%rbp),%rax
   140008ecb:	48 89 c1             	mov    %rax,%rcx
   140008ece:	e8 98 92 ff ff       	call   14000216b <type__size>
   140008ed3:	48 83 f8 0c          	cmp    $0xc,%rax
   140008ed7:	74 23                	je     140008efc <main2+0x551d>
   140008ed9:	41 b8 b7 04 00 00    	mov    $0x4b7,%r8d
   140008edf:	48 8d 05 6a a1 00 00 	lea    0xa16a(%rip),%rax        # 140013050 <.rdata>
   140008ee6:	48 89 c2             	mov    %rax,%rdx
   140008ee9:	48 8d 05 48 b9 00 00 	lea    0xb948(%rip),%rax        # 140014838 <.rdata+0x17e8>
   140008ef0:	48 89 c1             	mov    %rax,%rcx
   140008ef3:	48 8b 05 46 24 01 00 	mov    0x12446(%rip),%rax        # 14001b340 <__imp__assert>
   140008efa:	ff d0                	call   *%rax
   140008efc:	48 8b 85 18 02 00 00 	mov    0x218(%rbp),%rax
   140008f03:	48 8b 40 10          	mov    0x10(%rax),%rax
   140008f07:	48 83 f8 01          	cmp    $0x1,%rax
   140008f0b:	74 23                	je     140008f30 <main2+0x5551>
   140008f0d:	41 b8 b7 04 00 00    	mov    $0x4b7,%r8d
   140008f13:	48 8d 05 36 a1 00 00 	lea    0xa136(%rip),%rax        # 140013050 <.rdata>
   140008f1a:	48 89 c2             	mov    %rax,%rdx
   140008f1d:	48 8d 05 44 b9 00 00 	lea    0xb944(%rip),%rax        # 140014868 <.rdata+0x1818>
   140008f24:	48 89 c1             	mov    %rax,%rcx
   140008f27:	48 8b 05 12 24 01 00 	mov    0x12412(%rip),%rax        # 14001b340 <__imp__assert>
   140008f2e:	ff d0                	call   *%rax
   140008f30:	b9 01 00 00 00       	mov    $0x1,%ecx
   140008f35:	48 8b 05 8c 23 01 00 	mov    0x1238c(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140008f3c:	ff d0                	call   *%rax
   140008f3e:	48 89 c2             	mov    %rax,%rdx
   140008f41:	48 8b 85 10 02 00 00 	mov    0x210(%rbp),%rax
   140008f48:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140008f4f:	00 00 
   140008f51:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140008f57:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140008f5d:	48 89 c1             	mov    %rax,%rcx
   140008f60:	e8 79 a3 ff ff       	call   1400032de <type__print>
   140008f65:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008f69:	4c 8d 0d d8 a5 00 00 	lea    0xa5d8(%rip),%r9        # 140013548 <.rdata+0x4f8>
   140008f70:	4c 8d 05 85 a6 00 00 	lea    0xa685(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140008f77:	ba 00 01 00 00       	mov    $0x100,%edx
   140008f7c:	48 89 c1             	mov    %rax,%rcx
   140008f7f:	e8 4c 86 00 00       	call   1400115d0 <snprintf>
   140008f84:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008f88:	48 c7 44 24 20 db 00 	movq   $0xdb,0x20(%rsp)
   140008f8f:	00 00 
   140008f91:	49 89 c1             	mov    %rax,%r9
   140008f94:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140008f9a:	ba 16 00 00 00       	mov    $0x16,%edx
   140008f9f:	48 8d 05 ab a2 00 00 	lea    0xa2ab(%rip),%rax        # 140013251 <.rdata+0x201>
   140008fa6:	48 89 c1             	mov    %rax,%rcx
   140008fa9:	e8 82 86 00 00       	call   140011630 <printf>
   140008fae:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008fb2:	4c 8d 0d 8f a5 00 00 	lea    0xa58f(%rip),%r9        # 140013548 <.rdata+0x4f8>
   140008fb9:	4c 8d 05 49 a6 00 00 	lea    0xa649(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140008fc0:	ba 00 01 00 00       	mov    $0x100,%edx
   140008fc5:	48 89 c1             	mov    %rax,%rcx
   140008fc8:	e8 03 86 00 00       	call   1400115d0 <snprintf>
   140008fcd:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140008fd1:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140008fd8:	00 00 
   140008fda:	49 89 c1             	mov    %rax,%r9
   140008fdd:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140008fe3:	ba 16 00 00 00       	mov    $0x16,%edx
   140008fe8:	48 8d 05 62 a2 00 00 	lea    0xa262(%rip),%rax        # 140013251 <.rdata+0x201>
   140008fef:	48 89 c1             	mov    %rax,%rcx
   140008ff2:	e8 39 86 00 00       	call   140011630 <printf>
   140008ff7:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140008ffc:	e8 8f 8a 00 00       	call   140011a90 <putchar>
   140009001:	48 8b 85 10 02 00 00 	mov    0x210(%rbp),%rax
   140009008:	48 89 c1             	mov    %rax,%rcx
   14000900b:	e8 5b 91 ff ff       	call   14000216b <type__size>
   140009010:	48 3d db 00 00 00    	cmp    $0xdb,%rax
   140009016:	74 23                	je     14000903b <main2+0x565c>
   140009018:	41 b8 b8 04 00 00    	mov    $0x4b8,%r8d
   14000901e:	48 8d 05 2b a0 00 00 	lea    0xa02b(%rip),%rax        # 140013050 <.rdata>
   140009025:	48 89 c2             	mov    %rax,%rdx
   140009028:	48 8d 05 61 b8 00 00 	lea    0xb861(%rip),%rax        # 140014890 <.rdata+0x1840>
   14000902f:	48 89 c1             	mov    %rax,%rcx
   140009032:	48 8b 05 07 23 01 00 	mov    0x12307(%rip),%rax        # 14001b340 <__imp__assert>
   140009039:	ff d0                	call   *%rax
   14000903b:	48 8b 85 10 02 00 00 	mov    0x210(%rbp),%rax
   140009042:	48 8b 40 10          	mov    0x10(%rax),%rax
   140009046:	48 83 f8 01          	cmp    $0x1,%rax
   14000904a:	74 23                	je     14000906f <main2+0x5690>
   14000904c:	41 b8 b8 04 00 00    	mov    $0x4b8,%r8d
   140009052:	48 8d 05 f7 9f 00 00 	lea    0x9ff7(%rip),%rax        # 140013050 <.rdata>
   140009059:	48 89 c2             	mov    %rax,%rdx
   14000905c:	48 8d 05 5d b8 00 00 	lea    0xb85d(%rip),%rax        # 1400148c0 <.rdata+0x1870>
   140009063:	48 89 c1             	mov    %rax,%rcx
   140009066:	48 8b 05 d3 22 01 00 	mov    0x122d3(%rip),%rax        # 14001b340 <__imp__assert>
   14000906d:	ff d0                	call   *%rax
   14000906f:	b9 01 00 00 00       	mov    $0x1,%ecx
   140009074:	48 8b 05 4d 22 01 00 	mov    0x1224d(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   14000907b:	ff d0                	call   *%rax
   14000907d:	48 89 c2             	mov    %rax,%rdx
   140009080:	48 8b 85 08 02 00 00 	mov    0x208(%rbp),%rax
   140009087:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000908e:	00 00 
   140009090:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140009096:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000909c:	48 89 c1             	mov    %rax,%rcx
   14000909f:	e8 3a a2 ff ff       	call   1400032de <type__print>
   1400090a4:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400090a8:	4c 8d 0d 9c a4 00 00 	lea    0xa49c(%rip),%r9        # 14001354b <.rdata+0x4fb>
   1400090af:	4c 8d 05 46 a5 00 00 	lea    0xa546(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   1400090b6:	ba 00 01 00 00       	mov    $0x100,%edx
   1400090bb:	48 89 c1             	mov    %rax,%rcx
   1400090be:	e8 0d 85 00 00       	call   1400115d0 <snprintf>
   1400090c3:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400090c7:	48 c7 44 24 20 50 01 	movq   $0x150,0x20(%rsp)
   1400090ce:	00 00 
   1400090d0:	49 89 c1             	mov    %rax,%r9
   1400090d3:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400090d9:	ba 16 00 00 00       	mov    $0x16,%edx
   1400090de:	48 8d 05 6c a1 00 00 	lea    0xa16c(%rip),%rax        # 140013251 <.rdata+0x201>
   1400090e5:	48 89 c1             	mov    %rax,%rcx
   1400090e8:	e8 43 85 00 00       	call   140011630 <printf>
   1400090ed:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400090f1:	4c 8d 0d 53 a4 00 00 	lea    0xa453(%rip),%r9        # 14001354b <.rdata+0x4fb>
   1400090f8:	4c 8d 05 0a a5 00 00 	lea    0xa50a(%rip),%r8        # 140013609 <.rdata+0x5b9>
   1400090ff:	ba 00 01 00 00       	mov    $0x100,%edx
   140009104:	48 89 c1             	mov    %rax,%rcx
   140009107:	e8 c4 84 00 00       	call   1400115d0 <snprintf>
   14000910c:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009110:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   140009117:	00 00 
   140009119:	49 89 c1             	mov    %rax,%r9
   14000911c:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140009122:	ba 16 00 00 00       	mov    $0x16,%edx
   140009127:	48 8d 05 23 a1 00 00 	lea    0xa123(%rip),%rax        # 140013251 <.rdata+0x201>
   14000912e:	48 89 c1             	mov    %rax,%rcx
   140009131:	e8 fa 84 00 00       	call   140011630 <printf>
   140009136:	b9 0a 00 00 00       	mov    $0xa,%ecx
   14000913b:	e8 50 89 00 00       	call   140011a90 <putchar>
   140009140:	48 8b 85 08 02 00 00 	mov    0x208(%rbp),%rax
   140009147:	48 89 c1             	mov    %rax,%rcx
   14000914a:	e8 1c 90 ff ff       	call   14000216b <type__size>
   14000914f:	48 3d 50 01 00 00    	cmp    $0x150,%rax
   140009155:	74 23                	je     14000917a <main2+0x579b>
   140009157:	41 b8 b9 04 00 00    	mov    $0x4b9,%r8d
   14000915d:	48 8d 05 ec 9e 00 00 	lea    0x9eec(%rip),%rax        # 140013050 <.rdata>
   140009164:	48 89 c2             	mov    %rax,%rdx
   140009167:	48 8d 05 7a b7 00 00 	lea    0xb77a(%rip),%rax        # 1400148e8 <.rdata+0x1898>
   14000916e:	48 89 c1             	mov    %rax,%rcx
   140009171:	48 8b 05 c8 21 01 00 	mov    0x121c8(%rip),%rax        # 14001b340 <__imp__assert>
   140009178:	ff d0                	call   *%rax
   14000917a:	48 8b 85 08 02 00 00 	mov    0x208(%rbp),%rax
   140009181:	48 8b 40 10          	mov    0x10(%rax),%rax
   140009185:	48 83 f8 01          	cmp    $0x1,%rax
   140009189:	74 23                	je     1400091ae <main2+0x57cf>
   14000918b:	41 b8 b9 04 00 00    	mov    $0x4b9,%r8d
   140009191:	48 8d 05 b8 9e 00 00 	lea    0x9eb8(%rip),%rax        # 140013050 <.rdata>
   140009198:	48 89 c2             	mov    %rax,%rdx
   14000919b:	48 8d 05 76 b7 00 00 	lea    0xb776(%rip),%rax        # 140014918 <.rdata+0x18c8>
   1400091a2:	48 89 c1             	mov    %rax,%rcx
   1400091a5:	48 8b 05 94 21 01 00 	mov    0x12194(%rip),%rax        # 14001b340 <__imp__assert>
   1400091ac:	ff d0                	call   *%rax
   1400091ae:	b9 01 00 00 00       	mov    $0x1,%ecx
   1400091b3:	48 8b 05 0e 21 01 00 	mov    0x1210e(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   1400091ba:	ff d0                	call   *%rax
   1400091bc:	48 89 c2             	mov    %rax,%rdx
   1400091bf:	48 8b 85 00 02 00 00 	mov    0x200(%rbp),%rax
   1400091c6:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   1400091cd:	00 00 
   1400091cf:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   1400091d5:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   1400091db:	48 89 c1             	mov    %rax,%rcx
   1400091de:	e8 fb a0 ff ff       	call   1400032de <type__print>
   1400091e3:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400091e7:	4c 8d 0d 60 a3 00 00 	lea    0xa360(%rip),%r9        # 14001354e <.rdata+0x4fe>
   1400091ee:	4c 8d 05 07 a4 00 00 	lea    0xa407(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   1400091f5:	ba 00 01 00 00       	mov    $0x100,%edx
   1400091fa:	48 89 c1             	mov    %rax,%rcx
   1400091fd:	e8 ce 83 00 00       	call   1400115d0 <snprintf>
   140009202:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009206:	48 c7 44 24 20 9c 18 	movq   $0x189c,0x20(%rsp)
   14000920d:	00 00 
   14000920f:	49 89 c1             	mov    %rax,%r9
   140009212:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140009218:	ba 16 00 00 00       	mov    $0x16,%edx
   14000921d:	48 8d 05 2d a0 00 00 	lea    0xa02d(%rip),%rax        # 140013251 <.rdata+0x201>
   140009224:	48 89 c1             	mov    %rax,%rcx
   140009227:	e8 04 84 00 00       	call   140011630 <printf>
   14000922c:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009230:	4c 8d 0d 17 a3 00 00 	lea    0xa317(%rip),%r9        # 14001354e <.rdata+0x4fe>
   140009237:	4c 8d 05 cb a3 00 00 	lea    0xa3cb(%rip),%r8        # 140013609 <.rdata+0x5b9>
   14000923e:	ba 00 01 00 00       	mov    $0x100,%edx
   140009243:	48 89 c1             	mov    %rax,%rcx
   140009246:	e8 85 83 00 00       	call   1400115d0 <snprintf>
   14000924b:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000924f:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   140009256:	00 00 
   140009258:	49 89 c1             	mov    %rax,%r9
   14000925b:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140009261:	ba 16 00 00 00       	mov    $0x16,%edx
   140009266:	48 8d 05 e4 9f 00 00 	lea    0x9fe4(%rip),%rax        # 140013251 <.rdata+0x201>
   14000926d:	48 89 c1             	mov    %rax,%rcx
   140009270:	e8 bb 83 00 00       	call   140011630 <printf>
   140009275:	b9 0a 00 00 00       	mov    $0xa,%ecx
   14000927a:	e8 11 88 00 00       	call   140011a90 <putchar>
   14000927f:	48 8b 85 00 02 00 00 	mov    0x200(%rbp),%rax
   140009286:	48 89 c1             	mov    %rax,%rcx
   140009289:	e8 dd 8e ff ff       	call   14000216b <type__size>
   14000928e:	48 3d 9c 18 00 00    	cmp    $0x189c,%rax
   140009294:	74 23                	je     1400092b9 <main2+0x58da>
   140009296:	41 b8 ba 04 00 00    	mov    $0x4ba,%r8d
   14000929c:	48 8d 05 ad 9d 00 00 	lea    0x9dad(%rip),%rax        # 140013050 <.rdata>
   1400092a3:	48 89 c2             	mov    %rax,%rdx
   1400092a6:	48 8d 05 93 b6 00 00 	lea    0xb693(%rip),%rax        # 140014940 <.rdata+0x18f0>
   1400092ad:	48 89 c1             	mov    %rax,%rcx
   1400092b0:	48 8b 05 89 20 01 00 	mov    0x12089(%rip),%rax        # 14001b340 <__imp__assert>
   1400092b7:	ff d0                	call   *%rax
   1400092b9:	48 8b 85 00 02 00 00 	mov    0x200(%rbp),%rax
   1400092c0:	48 8b 40 10          	mov    0x10(%rax),%rax
   1400092c4:	48 83 f8 04          	cmp    $0x4,%rax
   1400092c8:	74 23                	je     1400092ed <main2+0x590e>
   1400092ca:	41 b8 ba 04 00 00    	mov    $0x4ba,%r8d
   1400092d0:	48 8d 05 79 9d 00 00 	lea    0x9d79(%rip),%rax        # 140013050 <.rdata>
   1400092d7:	48 89 c2             	mov    %rax,%rdx
   1400092da:	48 8d 05 8f b6 00 00 	lea    0xb68f(%rip),%rax        # 140014970 <.rdata+0x1920>
   1400092e1:	48 89 c1             	mov    %rax,%rcx
   1400092e4:	48 8b 05 55 20 01 00 	mov    0x12055(%rip),%rax        # 14001b340 <__imp__assert>
   1400092eb:	ff d0                	call   *%rax
   1400092ed:	b9 01 00 00 00       	mov    $0x1,%ecx
   1400092f2:	48 8b 05 cf 1f 01 00 	mov    0x11fcf(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   1400092f9:	ff d0                	call   *%rax
   1400092fb:	48 89 c2             	mov    %rax,%rdx
   1400092fe:	48 8b 85 f8 01 00 00 	mov    0x1f8(%rbp),%rax
   140009305:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000930c:	00 00 
   14000930e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140009314:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000931a:	48 89 c1             	mov    %rax,%rcx
   14000931d:	e8 bc 9f ff ff       	call   1400032de <type__print>
   140009322:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009326:	4c 8d 0d 24 a2 00 00 	lea    0xa224(%rip),%r9        # 140013551 <.rdata+0x501>
   14000932d:	4c 8d 05 c8 a2 00 00 	lea    0xa2c8(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140009334:	ba 00 01 00 00       	mov    $0x100,%edx
   140009339:	48 89 c1             	mov    %rax,%rcx
   14000933c:	e8 8f 82 00 00       	call   1400115d0 <snprintf>
   140009341:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009345:	48 c7 44 24 20 f8 79 	movq   $0x79f8,0x20(%rsp)
   14000934c:	00 00 
   14000934e:	49 89 c1             	mov    %rax,%r9
   140009351:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140009357:	ba 16 00 00 00       	mov    $0x16,%edx
   14000935c:	48 8d 05 ee 9e 00 00 	lea    0x9eee(%rip),%rax        # 140013251 <.rdata+0x201>
   140009363:	48 89 c1             	mov    %rax,%rcx
   140009366:	e8 c5 82 00 00       	call   140011630 <printf>
   14000936b:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000936f:	4c 8d 0d db a1 00 00 	lea    0xa1db(%rip),%r9        # 140013551 <.rdata+0x501>
   140009376:	4c 8d 05 8c a2 00 00 	lea    0xa28c(%rip),%r8        # 140013609 <.rdata+0x5b9>
   14000937d:	ba 00 01 00 00       	mov    $0x100,%edx
   140009382:	48 89 c1             	mov    %rax,%rcx
   140009385:	e8 46 82 00 00       	call   1400115d0 <snprintf>
   14000938a:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000938e:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   140009395:	00 00 
   140009397:	49 89 c1             	mov    %rax,%r9
   14000939a:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400093a0:	ba 16 00 00 00       	mov    $0x16,%edx
   1400093a5:	48 8d 05 a5 9e 00 00 	lea    0x9ea5(%rip),%rax        # 140013251 <.rdata+0x201>
   1400093ac:	48 89 c1             	mov    %rax,%rcx
   1400093af:	e8 7c 82 00 00       	call   140011630 <printf>
   1400093b4:	b9 0a 00 00 00       	mov    $0xa,%ecx
   1400093b9:	e8 d2 86 00 00       	call   140011a90 <putchar>
   1400093be:	48 8b 85 f8 01 00 00 	mov    0x1f8(%rbp),%rax
   1400093c5:	48 89 c1             	mov    %rax,%rcx
   1400093c8:	e8 9e 8d ff ff       	call   14000216b <type__size>
   1400093cd:	48 3d f8 79 00 00    	cmp    $0x79f8,%rax
   1400093d3:	74 23                	je     1400093f8 <main2+0x5a19>
   1400093d5:	41 b8 bb 04 00 00    	mov    $0x4bb,%r8d
   1400093db:	48 8d 05 6e 9c 00 00 	lea    0x9c6e(%rip),%rax        # 140013050 <.rdata>
   1400093e2:	48 89 c2             	mov    %rax,%rdx
   1400093e5:	48 8d 05 ac b5 00 00 	lea    0xb5ac(%rip),%rax        # 140014998 <.rdata+0x1948>
   1400093ec:	48 89 c1             	mov    %rax,%rcx
   1400093ef:	48 8b 05 4a 1f 01 00 	mov    0x11f4a(%rip),%rax        # 14001b340 <__imp__assert>
   1400093f6:	ff d0                	call   *%rax
   1400093f8:	48 8b 85 f8 01 00 00 	mov    0x1f8(%rbp),%rax
   1400093ff:	48 8b 40 10          	mov    0x10(%rax),%rax
   140009403:	48 83 f8 04          	cmp    $0x4,%rax
   140009407:	74 23                	je     14000942c <main2+0x5a4d>
   140009409:	41 b8 bb 04 00 00    	mov    $0x4bb,%r8d
   14000940f:	48 8d 05 3a 9c 00 00 	lea    0x9c3a(%rip),%rax        # 140013050 <.rdata>
   140009416:	48 89 c2             	mov    %rax,%rdx
   140009419:	48 8d 05 a8 b5 00 00 	lea    0xb5a8(%rip),%rax        # 1400149c8 <.rdata+0x1978>
   140009420:	48 89 c1             	mov    %rax,%rcx
   140009423:	48 8b 05 16 1f 01 00 	mov    0x11f16(%rip),%rax        # 14001b340 <__imp__assert>
   14000942a:	ff d0                	call   *%rax
   14000942c:	b9 01 00 00 00       	mov    $0x1,%ecx
   140009431:	48 8b 05 90 1e 01 00 	mov    0x11e90(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140009438:	ff d0                	call   *%rax
   14000943a:	48 89 c2             	mov    %rax,%rdx
   14000943d:	48 8b 85 f0 01 00 00 	mov    0x1f0(%rbp),%rax
   140009444:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000944b:	00 00 
   14000944d:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140009453:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140009459:	48 89 c1             	mov    %rax,%rcx
   14000945c:	e8 7d 9e ff ff       	call   1400032de <type__print>
   140009461:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009465:	4c 8d 0d e8 a0 00 00 	lea    0xa0e8(%rip),%r9        # 140013554 <.rdata+0x504>
   14000946c:	4c 8d 05 89 a1 00 00 	lea    0xa189(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140009473:	ba 00 01 00 00       	mov    $0x100,%edx
   140009478:	48 89 c1             	mov    %rax,%rcx
   14000947b:	e8 50 81 00 00       	call   1400115d0 <snprintf>
   140009480:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009484:	48 c7 44 24 20 68 8e 	movq   $0x8e68,0x20(%rsp)
   14000948b:	00 00 
   14000948d:	49 89 c1             	mov    %rax,%r9
   140009490:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140009496:	ba 16 00 00 00       	mov    $0x16,%edx
   14000949b:	48 8d 05 af 9d 00 00 	lea    0x9daf(%rip),%rax        # 140013251 <.rdata+0x201>
   1400094a2:	48 89 c1             	mov    %rax,%rcx
   1400094a5:	e8 86 81 00 00       	call   140011630 <printf>
   1400094aa:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400094ae:	4c 8d 0d 9f a0 00 00 	lea    0xa09f(%rip),%r9        # 140013554 <.rdata+0x504>
   1400094b5:	4c 8d 05 4d a1 00 00 	lea    0xa14d(%rip),%r8        # 140013609 <.rdata+0x5b9>
   1400094bc:	ba 00 01 00 00       	mov    $0x100,%edx
   1400094c1:	48 89 c1             	mov    %rax,%rcx
   1400094c4:	e8 07 81 00 00       	call   1400115d0 <snprintf>
   1400094c9:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400094cd:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   1400094d4:	00 00 
   1400094d6:	49 89 c1             	mov    %rax,%r9
   1400094d9:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400094df:	ba 16 00 00 00       	mov    $0x16,%edx
   1400094e4:	48 8d 05 66 9d 00 00 	lea    0x9d66(%rip),%rax        # 140013251 <.rdata+0x201>
   1400094eb:	48 89 c1             	mov    %rax,%rcx
   1400094ee:	e8 3d 81 00 00       	call   140011630 <printf>
   1400094f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
   1400094f8:	e8 93 85 00 00       	call   140011a90 <putchar>
   1400094fd:	48 8b 85 f0 01 00 00 	mov    0x1f0(%rbp),%rax
   140009504:	48 89 c1             	mov    %rax,%rcx
   140009507:	e8 5f 8c ff ff       	call   14000216b <type__size>
   14000950c:	48 3d 68 8e 00 00    	cmp    $0x8e68,%rax
   140009512:	74 23                	je     140009537 <main2+0x5b58>
   140009514:	41 b8 bc 04 00 00    	mov    $0x4bc,%r8d
   14000951a:	48 8d 05 2f 9b 00 00 	lea    0x9b2f(%rip),%rax        # 140013050 <.rdata>
   140009521:	48 89 c2             	mov    %rax,%rdx
   140009524:	48 8d 05 c5 b4 00 00 	lea    0xb4c5(%rip),%rax        # 1400149f0 <.rdata+0x19a0>
   14000952b:	48 89 c1             	mov    %rax,%rcx
   14000952e:	48 8b 05 0b 1e 01 00 	mov    0x11e0b(%rip),%rax        # 14001b340 <__imp__assert>
   140009535:	ff d0                	call   *%rax
   140009537:	48 8b 85 f0 01 00 00 	mov    0x1f0(%rbp),%rax
   14000953e:	48 8b 40 10          	mov    0x10(%rax),%rax
   140009542:	48 83 f8 08          	cmp    $0x8,%rax
   140009546:	74 23                	je     14000956b <main2+0x5b8c>
   140009548:	41 b8 bc 04 00 00    	mov    $0x4bc,%r8d
   14000954e:	48 8d 05 fb 9a 00 00 	lea    0x9afb(%rip),%rax        # 140013050 <.rdata>
   140009555:	48 89 c2             	mov    %rax,%rdx
   140009558:	48 8d 05 c1 b4 00 00 	lea    0xb4c1(%rip),%rax        # 140014a20 <.rdata+0x19d0>
   14000955f:	48 89 c1             	mov    %rax,%rcx
   140009562:	48 8b 05 d7 1d 01 00 	mov    0x11dd7(%rip),%rax        # 14001b340 <__imp__assert>
   140009569:	ff d0                	call   *%rax
   14000956b:	b9 01 00 00 00       	mov    $0x1,%ecx
   140009570:	48 8b 05 51 1d 01 00 	mov    0x11d51(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140009577:	ff d0                	call   *%rax
   140009579:	48 89 c2             	mov    %rax,%rdx
   14000957c:	48 8b 85 e8 01 00 00 	mov    0x1e8(%rbp),%rax
   140009583:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000958a:	00 00 
   14000958c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140009592:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140009598:	48 89 c1             	mov    %rax,%rcx
   14000959b:	e8 3e 9d ff ff       	call   1400032de <type__print>
   1400095a0:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400095a4:	4c 8d 0d ac 9f 00 00 	lea    0x9fac(%rip),%r9        # 140013557 <.rdata+0x507>
   1400095ab:	4c 8d 05 4a a0 00 00 	lea    0xa04a(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   1400095b2:	ba 00 01 00 00       	mov    $0x100,%edx
   1400095b7:	48 89 c1             	mov    %rax,%rcx
   1400095ba:	e8 11 80 00 00       	call   1400115d0 <snprintf>
   1400095bf:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400095c3:	48 c7 44 24 20 a0 a2 	movq   $0xa2a0,0x20(%rsp)
   1400095ca:	00 00 
   1400095cc:	49 89 c1             	mov    %rax,%r9
   1400095cf:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400095d5:	ba 16 00 00 00       	mov    $0x16,%edx
   1400095da:	48 8d 05 70 9c 00 00 	lea    0x9c70(%rip),%rax        # 140013251 <.rdata+0x201>
   1400095e1:	48 89 c1             	mov    %rax,%rcx
   1400095e4:	e8 47 80 00 00       	call   140011630 <printf>
   1400095e9:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400095ed:	4c 8d 0d 63 9f 00 00 	lea    0x9f63(%rip),%r9        # 140013557 <.rdata+0x507>
   1400095f4:	4c 8d 05 0e a0 00 00 	lea    0xa00e(%rip),%r8        # 140013609 <.rdata+0x5b9>
   1400095fb:	ba 00 01 00 00       	mov    $0x100,%edx
   140009600:	48 89 c1             	mov    %rax,%rcx
   140009603:	e8 c8 7f 00 00       	call   1400115d0 <snprintf>
   140009608:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000960c:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   140009613:	00 00 
   140009615:	49 89 c1             	mov    %rax,%r9
   140009618:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000961e:	ba 16 00 00 00       	mov    $0x16,%edx
   140009623:	48 8d 05 27 9c 00 00 	lea    0x9c27(%rip),%rax        # 140013251 <.rdata+0x201>
   14000962a:	48 89 c1             	mov    %rax,%rcx
   14000962d:	e8 fe 7f 00 00       	call   140011630 <printf>
   140009632:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140009637:	e8 54 84 00 00       	call   140011a90 <putchar>
   14000963c:	48 8b 85 e8 01 00 00 	mov    0x1e8(%rbp),%rax
   140009643:	48 89 c1             	mov    %rax,%rcx
   140009646:	e8 20 8b ff ff       	call   14000216b <type__size>
   14000964b:	48 3d a0 a2 00 00    	cmp    $0xa2a0,%rax
   140009651:	74 23                	je     140009676 <main2+0x5c97>
   140009653:	41 b8 bd 04 00 00    	mov    $0x4bd,%r8d
   140009659:	48 8d 05 f0 99 00 00 	lea    0x99f0(%rip),%rax        # 140013050 <.rdata>
   140009660:	48 89 c2             	mov    %rax,%rdx
   140009663:	48 8d 05 de b3 00 00 	lea    0xb3de(%rip),%rax        # 140014a48 <.rdata+0x19f8>
   14000966a:	48 89 c1             	mov    %rax,%rcx
   14000966d:	48 8b 05 cc 1c 01 00 	mov    0x11ccc(%rip),%rax        # 14001b340 <__imp__assert>
   140009674:	ff d0                	call   *%rax
   140009676:	48 8b 85 e8 01 00 00 	mov    0x1e8(%rbp),%rax
   14000967d:	48 8b 40 10          	mov    0x10(%rax),%rax
   140009681:	48 83 f8 04          	cmp    $0x4,%rax
   140009685:	74 23                	je     1400096aa <main2+0x5ccb>
   140009687:	41 b8 bd 04 00 00    	mov    $0x4bd,%r8d
   14000968d:	48 8d 05 bc 99 00 00 	lea    0x99bc(%rip),%rax        # 140013050 <.rdata>
   140009694:	48 89 c2             	mov    %rax,%rdx
   140009697:	48 8d 05 da b3 00 00 	lea    0xb3da(%rip),%rax        # 140014a78 <.rdata+0x1a28>
   14000969e:	48 89 c1             	mov    %rax,%rcx
   1400096a1:	48 8b 05 98 1c 01 00 	mov    0x11c98(%rip),%rax        # 14001b340 <__imp__assert>
   1400096a8:	ff d0                	call   *%rax
   1400096aa:	b9 01 00 00 00       	mov    $0x1,%ecx
   1400096af:	48 8b 05 12 1c 01 00 	mov    0x11c12(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   1400096b6:	ff d0                	call   *%rax
   1400096b8:	48 89 c2             	mov    %rax,%rdx
   1400096bb:	48 8b 85 e0 01 00 00 	mov    0x1e0(%rbp),%rax
   1400096c2:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   1400096c9:	00 00 
   1400096cb:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   1400096d1:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   1400096d7:	48 89 c1             	mov    %rax,%rcx
   1400096da:	e8 ff 9b ff ff       	call   1400032de <type__print>
   1400096df:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400096e3:	4c 8d 0d 70 9e 00 00 	lea    0x9e70(%rip),%r9        # 14001355a <.rdata+0x50a>
   1400096ea:	4c 8d 05 0b 9f 00 00 	lea    0x9f0b(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   1400096f1:	ba 00 01 00 00       	mov    $0x100,%edx
   1400096f6:	48 89 c1             	mov    %rax,%rcx
   1400096f9:	e8 d2 7e 00 00       	call   1400115d0 <snprintf>
   1400096fe:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009702:	48 c7 44 24 20 f8 9f 	movq   $0x19ff8,0x20(%rsp)
   140009709:	01 00 
   14000970b:	49 89 c1             	mov    %rax,%r9
   14000970e:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140009714:	ba 16 00 00 00       	mov    $0x16,%edx
   140009719:	48 8d 05 31 9b 00 00 	lea    0x9b31(%rip),%rax        # 140013251 <.rdata+0x201>
   140009720:	48 89 c1             	mov    %rax,%rcx
   140009723:	e8 08 7f 00 00       	call   140011630 <printf>
   140009728:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000972c:	4c 8d 0d 27 9e 00 00 	lea    0x9e27(%rip),%r9        # 14001355a <.rdata+0x50a>
   140009733:	4c 8d 05 cf 9e 00 00 	lea    0x9ecf(%rip),%r8        # 140013609 <.rdata+0x5b9>
   14000973a:	ba 00 01 00 00       	mov    $0x100,%edx
   14000973f:	48 89 c1             	mov    %rax,%rcx
   140009742:	e8 89 7e 00 00       	call   1400115d0 <snprintf>
   140009747:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000974b:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   140009752:	00 00 
   140009754:	49 89 c1             	mov    %rax,%r9
   140009757:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000975d:	ba 16 00 00 00       	mov    $0x16,%edx
   140009762:	48 8d 05 e8 9a 00 00 	lea    0x9ae8(%rip),%rax        # 140013251 <.rdata+0x201>
   140009769:	48 89 c1             	mov    %rax,%rcx
   14000976c:	e8 bf 7e 00 00       	call   140011630 <printf>
   140009771:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140009776:	e8 15 83 00 00       	call   140011a90 <putchar>
   14000977b:	48 8b 85 e0 01 00 00 	mov    0x1e0(%rbp),%rax
   140009782:	48 89 c1             	mov    %rax,%rcx
   140009785:	e8 e1 89 ff ff       	call   14000216b <type__size>
   14000978a:	48 3d f8 9f 01 00    	cmp    $0x19ff8,%rax
   140009790:	74 23                	je     1400097b5 <main2+0x5dd6>
   140009792:	41 b8 be 04 00 00    	mov    $0x4be,%r8d
   140009798:	48 8d 05 b1 98 00 00 	lea    0x98b1(%rip),%rax        # 140013050 <.rdata>
   14000979f:	48 89 c2             	mov    %rax,%rdx
   1400097a2:	48 8d 05 f7 b2 00 00 	lea    0xb2f7(%rip),%rax        # 140014aa0 <.rdata+0x1a50>
   1400097a9:	48 89 c1             	mov    %rax,%rcx
   1400097ac:	48 8b 05 8d 1b 01 00 	mov    0x11b8d(%rip),%rax        # 14001b340 <__imp__assert>
   1400097b3:	ff d0                	call   *%rax
   1400097b5:	48 8b 85 e0 01 00 00 	mov    0x1e0(%rbp),%rax
   1400097bc:	48 8b 40 10          	mov    0x10(%rax),%rax
   1400097c0:	48 83 f8 08          	cmp    $0x8,%rax
   1400097c4:	74 23                	je     1400097e9 <main2+0x5e0a>
   1400097c6:	41 b8 be 04 00 00    	mov    $0x4be,%r8d
   1400097cc:	48 8d 05 7d 98 00 00 	lea    0x987d(%rip),%rax        # 140013050 <.rdata>
   1400097d3:	48 89 c2             	mov    %rax,%rdx
   1400097d6:	48 8d 05 f3 b2 00 00 	lea    0xb2f3(%rip),%rax        # 140014ad0 <.rdata+0x1a80>
   1400097dd:	48 89 c1             	mov    %rax,%rcx
   1400097e0:	48 8b 05 59 1b 01 00 	mov    0x11b59(%rip),%rax        # 14001b340 <__imp__assert>
   1400097e7:	ff d0                	call   *%rax
   1400097e9:	b9 01 00 00 00       	mov    $0x1,%ecx
   1400097ee:	48 8b 05 d3 1a 01 00 	mov    0x11ad3(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   1400097f5:	ff d0                	call   *%rax
   1400097f7:	48 89 c2             	mov    %rax,%rdx
   1400097fa:	48 8b 85 d8 01 00 00 	mov    0x1d8(%rbp),%rax
   140009801:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140009808:	00 00 
   14000980a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140009810:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140009816:	48 89 c1             	mov    %rax,%rcx
   140009819:	e8 c0 9a ff ff       	call   1400032de <type__print>
   14000981e:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009822:	4c 8d 0d 34 9d 00 00 	lea    0x9d34(%rip),%r9        # 14001355d <.rdata+0x50d>
   140009829:	4c 8d 05 cc 9d 00 00 	lea    0x9dcc(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140009830:	ba 00 01 00 00       	mov    $0x100,%edx
   140009835:	48 89 c1             	mov    %rax,%rcx
   140009838:	e8 93 7d 00 00       	call   1400115d0 <snprintf>
   14000983d:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009841:	48 c7 44 24 20 30 0c 	movq   $0xa0c30,0x20(%rsp)
   140009848:	0a 00 
   14000984a:	49 89 c1             	mov    %rax,%r9
   14000984d:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140009853:	ba 16 00 00 00       	mov    $0x16,%edx
   140009858:	48 8d 05 f2 99 00 00 	lea    0x99f2(%rip),%rax        # 140013251 <.rdata+0x201>
   14000985f:	48 89 c1             	mov    %rax,%rcx
   140009862:	e8 c9 7d 00 00       	call   140011630 <printf>
   140009867:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000986b:	4c 8d 0d eb 9c 00 00 	lea    0x9ceb(%rip),%r9        # 14001355d <.rdata+0x50d>
   140009872:	4c 8d 05 90 9d 00 00 	lea    0x9d90(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140009879:	ba 00 01 00 00       	mov    $0x100,%edx
   14000987e:	48 89 c1             	mov    %rax,%rcx
   140009881:	e8 4a 7d 00 00       	call   1400115d0 <snprintf>
   140009886:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000988a:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   140009891:	00 00 
   140009893:	49 89 c1             	mov    %rax,%r9
   140009896:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000989c:	ba 16 00 00 00       	mov    $0x16,%edx
   1400098a1:	48 8d 05 a9 99 00 00 	lea    0x99a9(%rip),%rax        # 140013251 <.rdata+0x201>
   1400098a8:	48 89 c1             	mov    %rax,%rcx
   1400098ab:	e8 80 7d 00 00       	call   140011630 <printf>
   1400098b0:	b9 0a 00 00 00       	mov    $0xa,%ecx
   1400098b5:	e8 d6 81 00 00       	call   140011a90 <putchar>
   1400098ba:	48 8b 85 d8 01 00 00 	mov    0x1d8(%rbp),%rax
   1400098c1:	48 89 c1             	mov    %rax,%rcx
   1400098c4:	e8 a2 88 ff ff       	call   14000216b <type__size>
   1400098c9:	48 3d 30 0c 0a 00    	cmp    $0xa0c30,%rax
   1400098cf:	74 23                	je     1400098f4 <main2+0x5f15>
   1400098d1:	41 b8 bf 04 00 00    	mov    $0x4bf,%r8d
   1400098d7:	48 8d 05 72 97 00 00 	lea    0x9772(%rip),%rax        # 140013050 <.rdata>
   1400098de:	48 89 c2             	mov    %rax,%rdx
   1400098e1:	48 8d 05 10 b2 00 00 	lea    0xb210(%rip),%rax        # 140014af8 <.rdata+0x1aa8>
   1400098e8:	48 89 c1             	mov    %rax,%rcx
   1400098eb:	48 8b 05 4e 1a 01 00 	mov    0x11a4e(%rip),%rax        # 14001b340 <__imp__assert>
   1400098f2:	ff d0                	call   *%rax
   1400098f4:	48 8b 85 d8 01 00 00 	mov    0x1d8(%rbp),%rax
   1400098fb:	48 8b 40 10          	mov    0x10(%rax),%rax
   1400098ff:	48 83 f8 04          	cmp    $0x4,%rax
   140009903:	74 23                	je     140009928 <main2+0x5f49>
   140009905:	41 b8 bf 04 00 00    	mov    $0x4bf,%r8d
   14000990b:	48 8d 05 3e 97 00 00 	lea    0x973e(%rip),%rax        # 140013050 <.rdata>
   140009912:	48 89 c2             	mov    %rax,%rdx
   140009915:	48 8d 05 0c b2 00 00 	lea    0xb20c(%rip),%rax        # 140014b28 <.rdata+0x1ad8>
   14000991c:	48 89 c1             	mov    %rax,%rcx
   14000991f:	48 8b 05 1a 1a 01 00 	mov    0x11a1a(%rip),%rax        # 14001b340 <__imp__assert>
   140009926:	ff d0                	call   *%rax
   140009928:	b9 01 00 00 00       	mov    $0x1,%ecx
   14000992d:	48 8b 05 94 19 01 00 	mov    0x11994(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140009934:	ff d0                	call   *%rax
   140009936:	48 89 c2             	mov    %rax,%rdx
   140009939:	48 8b 85 d0 01 00 00 	mov    0x1d0(%rbp),%rax
   140009940:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140009947:	00 00 
   140009949:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000994f:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140009955:	48 89 c1             	mov    %rax,%rcx
   140009958:	e8 81 99 ff ff       	call   1400032de <type__print>
   14000995d:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009961:	4c 8d 0d f8 9b 00 00 	lea    0x9bf8(%rip),%r9        # 140013560 <.rdata+0x510>
   140009968:	4c 8d 05 8d 9c 00 00 	lea    0x9c8d(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   14000996f:	ba 00 01 00 00       	mov    $0x100,%edx
   140009974:	48 89 c1             	mov    %rax,%rcx
   140009977:	e8 54 7c 00 00       	call   1400115d0 <snprintf>
   14000997c:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009980:	48 c7 44 24 20 c0 96 	movq   $0xd96c0,0x20(%rsp)
   140009987:	0d 00 
   140009989:	49 89 c1             	mov    %rax,%r9
   14000998c:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140009992:	ba 16 00 00 00       	mov    $0x16,%edx
   140009997:	48 8d 05 b3 98 00 00 	lea    0x98b3(%rip),%rax        # 140013251 <.rdata+0x201>
   14000999e:	48 89 c1             	mov    %rax,%rcx
   1400099a1:	e8 8a 7c 00 00       	call   140011630 <printf>
   1400099a6:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400099aa:	4c 8d 0d af 9b 00 00 	lea    0x9baf(%rip),%r9        # 140013560 <.rdata+0x510>
   1400099b1:	4c 8d 05 51 9c 00 00 	lea    0x9c51(%rip),%r8        # 140013609 <.rdata+0x5b9>
   1400099b8:	ba 00 01 00 00       	mov    $0x100,%edx
   1400099bd:	48 89 c1             	mov    %rax,%rcx
   1400099c0:	e8 0b 7c 00 00       	call   1400115d0 <snprintf>
   1400099c5:	48 8d 45 50          	lea    0x50(%rbp),%rax
   1400099c9:	48 c7 44 24 20 08 00 	movq   $0x8,0x20(%rsp)
   1400099d0:	00 00 
   1400099d2:	49 89 c1             	mov    %rax,%r9
   1400099d5:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   1400099db:	ba 16 00 00 00       	mov    $0x16,%edx
   1400099e0:	48 8d 05 6a 98 00 00 	lea    0x986a(%rip),%rax        # 140013251 <.rdata+0x201>
   1400099e7:	48 89 c1             	mov    %rax,%rcx
   1400099ea:	e8 41 7c 00 00       	call   140011630 <printf>
   1400099ef:	b9 0a 00 00 00       	mov    $0xa,%ecx
   1400099f4:	e8 97 80 00 00       	call   140011a90 <putchar>
   1400099f9:	48 8b 85 d0 01 00 00 	mov    0x1d0(%rbp),%rax
   140009a00:	48 89 c1             	mov    %rax,%rcx
   140009a03:	e8 63 87 ff ff       	call   14000216b <type__size>
   140009a08:	48 3d c0 96 0d 00    	cmp    $0xd96c0,%rax
   140009a0e:	74 23                	je     140009a33 <main2+0x6054>
   140009a10:	41 b8 c0 04 00 00    	mov    $0x4c0,%r8d
   140009a16:	48 8d 05 33 96 00 00 	lea    0x9633(%rip),%rax        # 140013050 <.rdata>
   140009a1d:	48 89 c2             	mov    %rax,%rdx
   140009a20:	48 8d 05 29 b1 00 00 	lea    0xb129(%rip),%rax        # 140014b50 <.rdata+0x1b00>
   140009a27:	48 89 c1             	mov    %rax,%rcx
   140009a2a:	48 8b 05 0f 19 01 00 	mov    0x1190f(%rip),%rax        # 14001b340 <__imp__assert>
   140009a31:	ff d0                	call   *%rax
   140009a33:	48 8b 85 d0 01 00 00 	mov    0x1d0(%rbp),%rax
   140009a3a:	48 8b 40 10          	mov    0x10(%rax),%rax
   140009a3e:	48 83 f8 08          	cmp    $0x8,%rax
   140009a42:	74 23                	je     140009a67 <main2+0x6088>
   140009a44:	41 b8 c0 04 00 00    	mov    $0x4c0,%r8d
   140009a4a:	48 8d 05 ff 95 00 00 	lea    0x95ff(%rip),%rax        # 140013050 <.rdata>
   140009a51:	48 89 c2             	mov    %rax,%rdx
   140009a54:	48 8d 05 25 b1 00 00 	lea    0xb125(%rip),%rax        # 140014b80 <.rdata+0x1b30>
   140009a5b:	48 89 c1             	mov    %rax,%rcx
   140009a5e:	48 8b 05 db 18 01 00 	mov    0x118db(%rip),%rax        # 14001b340 <__imp__assert>
   140009a65:	ff d0                	call   *%rax
   140009a67:	b9 01 00 00 00       	mov    $0x1,%ecx
   140009a6c:	48 8b 05 55 18 01 00 	mov    0x11855(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140009a73:	ff d0                	call   *%rax
   140009a75:	48 89 c2             	mov    %rax,%rdx
   140009a78:	48 8b 85 c8 01 00 00 	mov    0x1c8(%rbp),%rax
   140009a7f:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140009a86:	00 00 
   140009a88:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140009a8e:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140009a94:	48 89 c1             	mov    %rax,%rcx
   140009a97:	e8 42 98 ff ff       	call   1400032de <type__print>
   140009a9c:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009aa0:	4c 8d 0d bc 9a 00 00 	lea    0x9abc(%rip),%r9        # 140013563 <.rdata+0x513>
   140009aa7:	4c 8d 05 4e 9b 00 00 	lea    0x9b4e(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140009aae:	ba 00 01 00 00       	mov    $0x100,%edx
   140009ab3:	48 89 c1             	mov    %rax,%rcx
   140009ab6:	e8 15 7b 00 00       	call   1400115d0 <snprintf>
   140009abb:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009abf:	48 c7 44 24 20 00 10 	movq   $0x4671000,0x20(%rsp)
   140009ac6:	67 04 
   140009ac8:	49 89 c1             	mov    %rax,%r9
   140009acb:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140009ad1:	ba 16 00 00 00       	mov    $0x16,%edx
   140009ad6:	48 8d 05 74 97 00 00 	lea    0x9774(%rip),%rax        # 140013251 <.rdata+0x201>
   140009add:	48 89 c1             	mov    %rax,%rcx
   140009ae0:	e8 4b 7b 00 00       	call   140011630 <printf>
   140009ae5:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009ae9:	4c 8d 0d 73 9a 00 00 	lea    0x9a73(%rip),%r9        # 140013563 <.rdata+0x513>
   140009af0:	4c 8d 05 12 9b 00 00 	lea    0x9b12(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140009af7:	ba 00 01 00 00       	mov    $0x100,%edx
   140009afc:	48 89 c1             	mov    %rax,%rcx
   140009aff:	e8 cc 7a 00 00       	call   1400115d0 <snprintf>
   140009b04:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009b08:	48 c7 44 24 20 00 04 	movq   $0x400,0x20(%rsp)
   140009b0f:	00 00 
   140009b11:	49 89 c1             	mov    %rax,%r9
   140009b14:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140009b1a:	ba 16 00 00 00       	mov    $0x16,%edx
   140009b1f:	48 8d 05 2b 97 00 00 	lea    0x972b(%rip),%rax        # 140013251 <.rdata+0x201>
   140009b26:	48 89 c1             	mov    %rax,%rcx
   140009b29:	e8 02 7b 00 00       	call   140011630 <printf>
   140009b2e:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140009b33:	e8 58 7f 00 00       	call   140011a90 <putchar>
   140009b38:	48 8b 85 c8 01 00 00 	mov    0x1c8(%rbp),%rax
   140009b3f:	48 89 c1             	mov    %rax,%rcx
   140009b42:	e8 24 86 ff ff       	call   14000216b <type__size>
   140009b47:	48 3d 00 10 67 04    	cmp    $0x4671000,%rax
   140009b4d:	74 23                	je     140009b72 <main2+0x6193>
   140009b4f:	41 b8 c1 04 00 00    	mov    $0x4c1,%r8d
   140009b55:	48 8d 05 f4 94 00 00 	lea    0x94f4(%rip),%rax        # 140013050 <.rdata>
   140009b5c:	48 89 c2             	mov    %rax,%rdx
   140009b5f:	48 8d 05 42 b0 00 00 	lea    0xb042(%rip),%rax        # 140014ba8 <.rdata+0x1b58>
   140009b66:	48 89 c1             	mov    %rax,%rcx
   140009b69:	48 8b 05 d0 17 01 00 	mov    0x117d0(%rip),%rax        # 14001b340 <__imp__assert>
   140009b70:	ff d0                	call   *%rax
   140009b72:	48 8b 85 c8 01 00 00 	mov    0x1c8(%rbp),%rax
   140009b79:	48 8b 40 10          	mov    0x10(%rax),%rax
   140009b7d:	48 3d 00 04 00 00    	cmp    $0x400,%rax
   140009b83:	74 23                	je     140009ba8 <main2+0x61c9>
   140009b85:	41 b8 c1 04 00 00    	mov    $0x4c1,%r8d
   140009b8b:	48 8d 05 be 94 00 00 	lea    0x94be(%rip),%rax        # 140013050 <.rdata>
   140009b92:	48 89 c2             	mov    %rax,%rdx
   140009b95:	48 8d 05 3c b0 00 00 	lea    0xb03c(%rip),%rax        # 140014bd8 <.rdata+0x1b88>
   140009b9c:	48 89 c1             	mov    %rax,%rcx
   140009b9f:	48 8b 05 9a 17 01 00 	mov    0x1179a(%rip),%rax        # 14001b340 <__imp__assert>
   140009ba6:	ff d0                	call   *%rax
   140009ba8:	b9 01 00 00 00       	mov    $0x1,%ecx
   140009bad:	48 8b 05 14 17 01 00 	mov    0x11714(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140009bb4:	ff d0                	call   *%rax
   140009bb6:	48 89 c2             	mov    %rax,%rdx
   140009bb9:	48 8b 85 c0 01 00 00 	mov    0x1c0(%rbp),%rax
   140009bc0:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140009bc7:	00 00 
   140009bc9:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140009bcf:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140009bd5:	48 89 c1             	mov    %rax,%rcx
   140009bd8:	e8 01 97 ff ff       	call   1400032de <type__print>
   140009bdd:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009be1:	4c 8d 0d 7e 99 00 00 	lea    0x997e(%rip),%r9        # 140013566 <.rdata+0x516>
   140009be8:	4c 8d 05 0d 9a 00 00 	lea    0x9a0d(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140009bef:	ba 00 01 00 00       	mov    $0x100,%edx
   140009bf4:	48 89 c1             	mov    %rax,%rcx
   140009bf7:	e8 d4 79 00 00       	call   1400115d0 <snprintf>
   140009bfc:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009c00:	48 c7 44 24 20 00 20 	movq   $0x4822000,0x20(%rsp)
   140009c07:	82 04 
   140009c09:	49 89 c1             	mov    %rax,%r9
   140009c0c:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140009c12:	ba 16 00 00 00       	mov    $0x16,%edx
   140009c17:	48 8d 05 33 96 00 00 	lea    0x9633(%rip),%rax        # 140013251 <.rdata+0x201>
   140009c1e:	48 89 c1             	mov    %rax,%rcx
   140009c21:	e8 0a 7a 00 00       	call   140011630 <printf>
   140009c26:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009c2a:	4c 8d 0d 35 99 00 00 	lea    0x9935(%rip),%r9        # 140013566 <.rdata+0x516>
   140009c31:	4c 8d 05 d1 99 00 00 	lea    0x99d1(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140009c38:	ba 00 01 00 00       	mov    $0x100,%edx
   140009c3d:	48 89 c1             	mov    %rax,%rcx
   140009c40:	e8 8b 79 00 00       	call   1400115d0 <snprintf>
   140009c45:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009c49:	48 c7 44 24 20 00 10 	movq   $0x1000,0x20(%rsp)
   140009c50:	00 00 
   140009c52:	49 89 c1             	mov    %rax,%r9
   140009c55:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140009c5b:	ba 16 00 00 00       	mov    $0x16,%edx
   140009c60:	48 8d 05 ea 95 00 00 	lea    0x95ea(%rip),%rax        # 140013251 <.rdata+0x201>
   140009c67:	48 89 c1             	mov    %rax,%rcx
   140009c6a:	e8 c1 79 00 00       	call   140011630 <printf>
   140009c6f:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140009c74:	e8 17 7e 00 00       	call   140011a90 <putchar>
   140009c79:	48 8b 85 c0 01 00 00 	mov    0x1c0(%rbp),%rax
   140009c80:	48 89 c1             	mov    %rax,%rcx
   140009c83:	e8 e3 84 ff ff       	call   14000216b <type__size>
   140009c88:	48 3d 00 20 82 04    	cmp    $0x4822000,%rax
   140009c8e:	74 23                	je     140009cb3 <main2+0x62d4>
   140009c90:	41 b8 c2 04 00 00    	mov    $0x4c2,%r8d
   140009c96:	48 8d 05 b3 93 00 00 	lea    0x93b3(%rip),%rax        # 140013050 <.rdata>
   140009c9d:	48 89 c2             	mov    %rax,%rdx
   140009ca0:	48 8d 05 59 af 00 00 	lea    0xaf59(%rip),%rax        # 140014c00 <.rdata+0x1bb0>
   140009ca7:	48 89 c1             	mov    %rax,%rcx
   140009caa:	48 8b 05 8f 16 01 00 	mov    0x1168f(%rip),%rax        # 14001b340 <__imp__assert>
   140009cb1:	ff d0                	call   *%rax
   140009cb3:	48 8b 85 c0 01 00 00 	mov    0x1c0(%rbp),%rax
   140009cba:	48 8b 40 10          	mov    0x10(%rax),%rax
   140009cbe:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
   140009cc4:	74 23                	je     140009ce9 <main2+0x630a>
   140009cc6:	41 b8 c2 04 00 00    	mov    $0x4c2,%r8d
   140009ccc:	48 8d 05 7d 93 00 00 	lea    0x937d(%rip),%rax        # 140013050 <.rdata>
   140009cd3:	48 89 c2             	mov    %rax,%rdx
   140009cd6:	48 8d 05 53 af 00 00 	lea    0xaf53(%rip),%rax        # 140014c30 <.rdata+0x1be0>
   140009cdd:	48 89 c1             	mov    %rax,%rcx
   140009ce0:	48 8b 05 59 16 01 00 	mov    0x11659(%rip),%rax        # 14001b340 <__imp__assert>
   140009ce7:	ff d0                	call   *%rax
   140009ce9:	b9 01 00 00 00       	mov    $0x1,%ecx
   140009cee:	48 8b 05 d3 15 01 00 	mov    0x115d3(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140009cf5:	ff d0                	call   *%rax
   140009cf7:	48 89 c2             	mov    %rax,%rdx
   140009cfa:	48 8b 85 b8 01 00 00 	mov    0x1b8(%rbp),%rax
   140009d01:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140009d08:	00 00 
   140009d0a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140009d10:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140009d16:	48 89 c1             	mov    %rax,%rcx
   140009d19:	e8 c0 95 ff ff       	call   1400032de <type__print>
   140009d1e:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009d22:	4c 8d 0d 86 98 00 00 	lea    0x9886(%rip),%r9        # 1400135af <.rdata+0x55f>
   140009d29:	4c 8d 05 cc 98 00 00 	lea    0x98cc(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140009d30:	ba 00 01 00 00       	mov    $0x100,%edx
   140009d35:	48 89 c1             	mov    %rax,%rcx
   140009d38:	e8 93 78 00 00       	call   1400115d0 <snprintf>
   140009d3d:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009d41:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   140009d48:	00 00 
   140009d4a:	49 89 c1             	mov    %rax,%r9
   140009d4d:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140009d53:	ba 16 00 00 00       	mov    $0x16,%edx
   140009d58:	48 8d 05 f2 94 00 00 	lea    0x94f2(%rip),%rax        # 140013251 <.rdata+0x201>
   140009d5f:	48 89 c1             	mov    %rax,%rcx
   140009d62:	e8 c9 78 00 00       	call   140011630 <printf>
   140009d67:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009d6b:	4c 8d 0d 3d 98 00 00 	lea    0x983d(%rip),%r9        # 1400135af <.rdata+0x55f>
   140009d72:	4c 8d 05 90 98 00 00 	lea    0x9890(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140009d79:	ba 00 01 00 00       	mov    $0x100,%edx
   140009d7e:	48 89 c1             	mov    %rax,%rcx
   140009d81:	e8 4a 78 00 00       	call   1400115d0 <snprintf>
   140009d86:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009d8a:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   140009d91:	00 00 
   140009d93:	49 89 c1             	mov    %rax,%r9
   140009d96:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140009d9c:	ba 16 00 00 00       	mov    $0x16,%edx
   140009da1:	48 8d 05 a9 94 00 00 	lea    0x94a9(%rip),%rax        # 140013251 <.rdata+0x201>
   140009da8:	48 89 c1             	mov    %rax,%rcx
   140009dab:	e8 80 78 00 00       	call   140011630 <printf>
   140009db0:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140009db5:	e8 d6 7c 00 00       	call   140011a90 <putchar>
   140009dba:	48 8b 85 b8 01 00 00 	mov    0x1b8(%rbp),%rax
   140009dc1:	48 89 c1             	mov    %rax,%rcx
   140009dc4:	e8 a2 83 ff ff       	call   14000216b <type__size>
   140009dc9:	48 83 f8 04          	cmp    $0x4,%rax
   140009dcd:	74 23                	je     140009df2 <main2+0x6413>
   140009dcf:	41 b8 c3 04 00 00    	mov    $0x4c3,%r8d
   140009dd5:	48 8d 05 74 92 00 00 	lea    0x9274(%rip),%rax        # 140013050 <.rdata>
   140009ddc:	48 89 c2             	mov    %rax,%rdx
   140009ddf:	48 8d 05 72 ae 00 00 	lea    0xae72(%rip),%rax        # 140014c58 <.rdata+0x1c08>
   140009de6:	48 89 c1             	mov    %rax,%rcx
   140009de9:	48 8b 05 50 15 01 00 	mov    0x11550(%rip),%rax        # 14001b340 <__imp__assert>
   140009df0:	ff d0                	call   *%rax
   140009df2:	48 8b 85 b8 01 00 00 	mov    0x1b8(%rbp),%rax
   140009df9:	48 8b 40 10          	mov    0x10(%rax),%rax
   140009dfd:	48 83 f8 04          	cmp    $0x4,%rax
   140009e01:	74 23                	je     140009e26 <main2+0x6447>
   140009e03:	41 b8 c3 04 00 00    	mov    $0x4c3,%r8d
   140009e09:	48 8d 05 40 92 00 00 	lea    0x9240(%rip),%rax        # 140013050 <.rdata>
   140009e10:	48 89 c2             	mov    %rax,%rdx
   140009e13:	48 8d 05 6e ae 00 00 	lea    0xae6e(%rip),%rax        # 140014c88 <.rdata+0x1c38>
   140009e1a:	48 89 c1             	mov    %rax,%rcx
   140009e1d:	48 8b 05 1c 15 01 00 	mov    0x1151c(%rip),%rax        # 14001b340 <__imp__assert>
   140009e24:	ff d0                	call   *%rax
   140009e26:	b9 01 00 00 00       	mov    $0x1,%ecx
   140009e2b:	48 8b 05 96 14 01 00 	mov    0x11496(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140009e32:	ff d0                	call   *%rax
   140009e34:	48 89 c2             	mov    %rax,%rdx
   140009e37:	48 8b 85 b0 01 00 00 	mov    0x1b0(%rbp),%rax
   140009e3e:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140009e45:	00 00 
   140009e47:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140009e4d:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140009e53:	48 89 c1             	mov    %rax,%rcx
   140009e56:	e8 83 94 ff ff       	call   1400032de <type__print>
   140009e5b:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009e5f:	4c 8d 0d 4c 97 00 00 	lea    0x974c(%rip),%r9        # 1400135b2 <.rdata+0x562>
   140009e66:	4c 8d 05 8f 97 00 00 	lea    0x978f(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140009e6d:	ba 00 01 00 00       	mov    $0x100,%edx
   140009e72:	48 89 c1             	mov    %rax,%rcx
   140009e75:	e8 56 77 00 00       	call   1400115d0 <snprintf>
   140009e7a:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009e7e:	48 c7 44 24 20 1c 00 	movq   $0x1c,0x20(%rsp)
   140009e85:	00 00 
   140009e87:	49 89 c1             	mov    %rax,%r9
   140009e8a:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140009e90:	ba 16 00 00 00       	mov    $0x16,%edx
   140009e95:	48 8d 05 b5 93 00 00 	lea    0x93b5(%rip),%rax        # 140013251 <.rdata+0x201>
   140009e9c:	48 89 c1             	mov    %rax,%rcx
   140009e9f:	e8 8c 77 00 00       	call   140011630 <printf>
   140009ea4:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009ea8:	4c 8d 0d 03 97 00 00 	lea    0x9703(%rip),%r9        # 1400135b2 <.rdata+0x562>
   140009eaf:	4c 8d 05 53 97 00 00 	lea    0x9753(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140009eb6:	ba 00 01 00 00       	mov    $0x100,%edx
   140009ebb:	48 89 c1             	mov    %rax,%rcx
   140009ebe:	e8 0d 77 00 00       	call   1400115d0 <snprintf>
   140009ec3:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009ec7:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   140009ece:	00 00 
   140009ed0:	49 89 c1             	mov    %rax,%r9
   140009ed3:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140009ed9:	ba 16 00 00 00       	mov    $0x16,%edx
   140009ede:	48 8d 05 6c 93 00 00 	lea    0x936c(%rip),%rax        # 140013251 <.rdata+0x201>
   140009ee5:	48 89 c1             	mov    %rax,%rcx
   140009ee8:	e8 43 77 00 00       	call   140011630 <printf>
   140009eed:	b9 0a 00 00 00       	mov    $0xa,%ecx
   140009ef2:	e8 99 7b 00 00       	call   140011a90 <putchar>
   140009ef7:	48 8b 85 b0 01 00 00 	mov    0x1b0(%rbp),%rax
   140009efe:	48 89 c1             	mov    %rax,%rcx
   140009f01:	e8 65 82 ff ff       	call   14000216b <type__size>
   140009f06:	48 83 f8 1c          	cmp    $0x1c,%rax
   140009f0a:	74 23                	je     140009f2f <main2+0x6550>
   140009f0c:	41 b8 c4 04 00 00    	mov    $0x4c4,%r8d
   140009f12:	48 8d 05 37 91 00 00 	lea    0x9137(%rip),%rax        # 140013050 <.rdata>
   140009f19:	48 89 c2             	mov    %rax,%rdx
   140009f1c:	48 8d 05 8d ad 00 00 	lea    0xad8d(%rip),%rax        # 140014cb0 <.rdata+0x1c60>
   140009f23:	48 89 c1             	mov    %rax,%rcx
   140009f26:	48 8b 05 13 14 01 00 	mov    0x11413(%rip),%rax        # 14001b340 <__imp__assert>
   140009f2d:	ff d0                	call   *%rax
   140009f2f:	48 8b 85 b0 01 00 00 	mov    0x1b0(%rbp),%rax
   140009f36:	48 8b 40 10          	mov    0x10(%rax),%rax
   140009f3a:	48 83 f8 04          	cmp    $0x4,%rax
   140009f3e:	74 23                	je     140009f63 <main2+0x6584>
   140009f40:	41 b8 c4 04 00 00    	mov    $0x4c4,%r8d
   140009f46:	48 8d 05 03 91 00 00 	lea    0x9103(%rip),%rax        # 140013050 <.rdata>
   140009f4d:	48 89 c2             	mov    %rax,%rdx
   140009f50:	48 8d 05 89 ad 00 00 	lea    0xad89(%rip),%rax        # 140014ce0 <.rdata+0x1c90>
   140009f57:	48 89 c1             	mov    %rax,%rcx
   140009f5a:	48 8b 05 df 13 01 00 	mov    0x113df(%rip),%rax        # 14001b340 <__imp__assert>
   140009f61:	ff d0                	call   *%rax
   140009f63:	b9 01 00 00 00       	mov    $0x1,%ecx
   140009f68:	48 8b 05 59 13 01 00 	mov    0x11359(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   140009f6f:	ff d0                	call   *%rax
   140009f71:	48 89 c2             	mov    %rax,%rdx
   140009f74:	48 8b 85 a8 01 00 00 	mov    0x1a8(%rbp),%rax
   140009f7b:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   140009f82:	00 00 
   140009f84:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140009f8a:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140009f90:	48 89 c1             	mov    %rax,%rcx
   140009f93:	e8 46 93 ff ff       	call   1400032de <type__print>
   140009f98:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009f9c:	4c 8d 0d 12 96 00 00 	lea    0x9612(%rip),%r9        # 1400135b5 <.rdata+0x565>
   140009fa3:	4c 8d 05 52 96 00 00 	lea    0x9652(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   140009faa:	ba 00 01 00 00       	mov    $0x100,%edx
   140009faf:	48 89 c1             	mov    %rax,%rcx
   140009fb2:	e8 19 76 00 00       	call   1400115d0 <snprintf>
   140009fb7:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009fbb:	48 c7 44 24 20 1c 00 	movq   $0x1c,0x20(%rsp)
   140009fc2:	00 00 
   140009fc4:	49 89 c1             	mov    %rax,%r9
   140009fc7:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   140009fcd:	ba 16 00 00 00       	mov    $0x16,%edx
   140009fd2:	48 8d 05 78 92 00 00 	lea    0x9278(%rip),%rax        # 140013251 <.rdata+0x201>
   140009fd9:	48 89 c1             	mov    %rax,%rcx
   140009fdc:	e8 4f 76 00 00       	call   140011630 <printf>
   140009fe1:	48 8d 45 50          	lea    0x50(%rbp),%rax
   140009fe5:	4c 8d 0d c9 95 00 00 	lea    0x95c9(%rip),%r9        # 1400135b5 <.rdata+0x565>
   140009fec:	4c 8d 05 16 96 00 00 	lea    0x9616(%rip),%r8        # 140013609 <.rdata+0x5b9>
   140009ff3:	ba 00 01 00 00       	mov    $0x100,%edx
   140009ff8:	48 89 c1             	mov    %rax,%rcx
   140009ffb:	e8 d0 75 00 00       	call   1400115d0 <snprintf>
   14000a000:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000a004:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   14000a00b:	00 00 
   14000a00d:	49 89 c1             	mov    %rax,%r9
   14000a010:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000a016:	ba 16 00 00 00       	mov    $0x16,%edx
   14000a01b:	48 8d 05 2f 92 00 00 	lea    0x922f(%rip),%rax        # 140013251 <.rdata+0x201>
   14000a022:	48 89 c1             	mov    %rax,%rcx
   14000a025:	e8 06 76 00 00       	call   140011630 <printf>
   14000a02a:	b9 0a 00 00 00       	mov    $0xa,%ecx
   14000a02f:	e8 5c 7a 00 00       	call   140011a90 <putchar>
   14000a034:	48 8b 85 a8 01 00 00 	mov    0x1a8(%rbp),%rax
   14000a03b:	48 89 c1             	mov    %rax,%rcx
   14000a03e:	e8 28 81 ff ff       	call   14000216b <type__size>
   14000a043:	48 83 f8 1c          	cmp    $0x1c,%rax
   14000a047:	74 23                	je     14000a06c <main2+0x668d>
   14000a049:	41 b8 c5 04 00 00    	mov    $0x4c5,%r8d
   14000a04f:	48 8d 05 fa 8f 00 00 	lea    0x8ffa(%rip),%rax        # 140013050 <.rdata>
   14000a056:	48 89 c2             	mov    %rax,%rdx
   14000a059:	48 8d 05 a8 ac 00 00 	lea    0xaca8(%rip),%rax        # 140014d08 <.rdata+0x1cb8>
   14000a060:	48 89 c1             	mov    %rax,%rcx
   14000a063:	48 8b 05 d6 12 01 00 	mov    0x112d6(%rip),%rax        # 14001b340 <__imp__assert>
   14000a06a:	ff d0                	call   *%rax
   14000a06c:	48 8b 85 a8 01 00 00 	mov    0x1a8(%rbp),%rax
   14000a073:	48 8b 40 10          	mov    0x10(%rax),%rax
   14000a077:	48 83 f8 01          	cmp    $0x1,%rax
   14000a07b:	74 23                	je     14000a0a0 <main2+0x66c1>
   14000a07d:	41 b8 c5 04 00 00    	mov    $0x4c5,%r8d
   14000a083:	48 8d 05 c6 8f 00 00 	lea    0x8fc6(%rip),%rax        # 140013050 <.rdata>
   14000a08a:	48 89 c2             	mov    %rax,%rdx
   14000a08d:	48 8d 05 a4 ac 00 00 	lea    0xaca4(%rip),%rax        # 140014d38 <.rdata+0x1ce8>
   14000a094:	48 89 c1             	mov    %rax,%rcx
   14000a097:	48 8b 05 a2 12 01 00 	mov    0x112a2(%rip),%rax        # 14001b340 <__imp__assert>
   14000a09e:	ff d0                	call   *%rax
   14000a0a0:	b9 01 00 00 00       	mov    $0x1,%ecx
   14000a0a5:	48 8b 05 1c 12 01 00 	mov    0x1121c(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   14000a0ac:	ff d0                	call   *%rax
   14000a0ae:	48 89 c2             	mov    %rax,%rdx
   14000a0b1:	48 8b 85 a0 01 00 00 	mov    0x1a0(%rbp),%rax
   14000a0b8:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000a0bf:	00 00 
   14000a0c1:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000a0c7:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000a0cd:	48 89 c1             	mov    %rax,%rcx
   14000a0d0:	e8 09 92 ff ff       	call   1400032de <type__print>
   14000a0d5:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000a0d9:	4c 8d 0d d8 94 00 00 	lea    0x94d8(%rip),%r9        # 1400135b8 <.rdata+0x568>
   14000a0e0:	4c 8d 05 15 95 00 00 	lea    0x9515(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   14000a0e7:	ba 00 01 00 00       	mov    $0x100,%edx
   14000a0ec:	48 89 c1             	mov    %rax,%rcx
   14000a0ef:	e8 dc 74 00 00       	call   1400115d0 <snprintf>
   14000a0f4:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000a0f8:	48 c7 44 24 20 00 08 	movq   $0x800,0x20(%rsp)
   14000a0ff:	00 00 
   14000a101:	49 89 c1             	mov    %rax,%r9
   14000a104:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000a10a:	ba 16 00 00 00       	mov    $0x16,%edx
   14000a10f:	48 8d 05 3b 91 00 00 	lea    0x913b(%rip),%rax        # 140013251 <.rdata+0x201>
   14000a116:	48 89 c1             	mov    %rax,%rcx
   14000a119:	e8 12 75 00 00       	call   140011630 <printf>
   14000a11e:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000a122:	4c 8d 0d 8f 94 00 00 	lea    0x948f(%rip),%r9        # 1400135b8 <.rdata+0x568>
   14000a129:	4c 8d 05 d9 94 00 00 	lea    0x94d9(%rip),%r8        # 140013609 <.rdata+0x5b9>
   14000a130:	ba 00 01 00 00       	mov    $0x100,%edx
   14000a135:	48 89 c1             	mov    %rax,%rcx
   14000a138:	e8 93 74 00 00       	call   1400115d0 <snprintf>
   14000a13d:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000a141:	48 c7 44 24 20 00 08 	movq   $0x800,0x20(%rsp)
   14000a148:	00 00 
   14000a14a:	49 89 c1             	mov    %rax,%r9
   14000a14d:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000a153:	ba 16 00 00 00       	mov    $0x16,%edx
   14000a158:	48 8d 05 f2 90 00 00 	lea    0x90f2(%rip),%rax        # 140013251 <.rdata+0x201>
   14000a15f:	48 89 c1             	mov    %rax,%rcx
   14000a162:	e8 c9 74 00 00       	call   140011630 <printf>
   14000a167:	b9 0a 00 00 00       	mov    $0xa,%ecx
   14000a16c:	e8 1f 79 00 00       	call   140011a90 <putchar>
   14000a171:	48 8b 85 a0 01 00 00 	mov    0x1a0(%rbp),%rax
   14000a178:	48 89 c1             	mov    %rax,%rcx
   14000a17b:	e8 eb 7f ff ff       	call   14000216b <type__size>
   14000a180:	48 3d 00 08 00 00    	cmp    $0x800,%rax
   14000a186:	74 23                	je     14000a1ab <main2+0x67cc>
   14000a188:	41 b8 c6 04 00 00    	mov    $0x4c6,%r8d
   14000a18e:	48 8d 05 bb 8e 00 00 	lea    0x8ebb(%rip),%rax        # 140013050 <.rdata>
   14000a195:	48 89 c2             	mov    %rax,%rdx
   14000a198:	48 8d 05 c1 ab 00 00 	lea    0xabc1(%rip),%rax        # 140014d60 <.rdata+0x1d10>
   14000a19f:	48 89 c1             	mov    %rax,%rcx
   14000a1a2:	48 8b 05 97 11 01 00 	mov    0x11197(%rip),%rax        # 14001b340 <__imp__assert>
   14000a1a9:	ff d0                	call   *%rax
   14000a1ab:	48 8b 85 a0 01 00 00 	mov    0x1a0(%rbp),%rax
   14000a1b2:	48 8b 40 10          	mov    0x10(%rax),%rax
   14000a1b6:	48 3d 00 08 00 00    	cmp    $0x800,%rax
   14000a1bc:	74 23                	je     14000a1e1 <main2+0x6802>
   14000a1be:	41 b8 c6 04 00 00    	mov    $0x4c6,%r8d
   14000a1c4:	48 8d 05 85 8e 00 00 	lea    0x8e85(%rip),%rax        # 140013050 <.rdata>
   14000a1cb:	48 89 c2             	mov    %rax,%rdx
   14000a1ce:	48 8d 05 bb ab 00 00 	lea    0xabbb(%rip),%rax        # 140014d90 <.rdata+0x1d40>
   14000a1d5:	48 89 c1             	mov    %rax,%rcx
   14000a1d8:	48 8b 05 61 11 01 00 	mov    0x11161(%rip),%rax        # 14001b340 <__imp__assert>
   14000a1df:	ff d0                	call   *%rax
   14000a1e1:	b9 01 00 00 00       	mov    $0x1,%ecx
   14000a1e6:	48 8b 05 db 10 01 00 	mov    0x110db(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   14000a1ed:	ff d0                	call   *%rax
   14000a1ef:	48 89 c2             	mov    %rax,%rdx
   14000a1f2:	48 8b 85 98 01 00 00 	mov    0x198(%rbp),%rax
   14000a1f9:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000a200:	00 00 
   14000a202:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000a208:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000a20e:	48 89 c1             	mov    %rax,%rcx
   14000a211:	e8 c8 90 ff ff       	call   1400032de <type__print>
   14000a216:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000a21a:	4c 8d 0d 9a 93 00 00 	lea    0x939a(%rip),%r9        # 1400135bb <.rdata+0x56b>
   14000a221:	4c 8d 05 d4 93 00 00 	lea    0x93d4(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   14000a228:	ba 00 01 00 00       	mov    $0x100,%edx
   14000a22d:	48 89 c1             	mov    %rax,%rcx
   14000a230:	e8 9b 73 00 00       	call   1400115d0 <snprintf>
   14000a235:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000a239:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
   14000a240:	00 00 
   14000a242:	49 89 c1             	mov    %rax,%r9
   14000a245:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000a24b:	ba 16 00 00 00       	mov    $0x16,%edx
   14000a250:	48 8d 05 fa 8f 00 00 	lea    0x8ffa(%rip),%rax        # 140013251 <.rdata+0x201>
   14000a257:	48 89 c1             	mov    %rax,%rcx
   14000a25a:	e8 d1 73 00 00       	call   140011630 <printf>
   14000a25f:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000a263:	4c 8d 0d 51 93 00 00 	lea    0x9351(%rip),%r9        # 1400135bb <.rdata+0x56b>
   14000a26a:	4c 8d 05 98 93 00 00 	lea    0x9398(%rip),%r8        # 140013609 <.rdata+0x5b9>
   14000a271:	ba 00 01 00 00       	mov    $0x100,%edx
   14000a276:	48 89 c1             	mov    %rax,%rcx
   14000a279:	e8 52 73 00 00       	call   1400115d0 <snprintf>
   14000a27e:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000a282:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   14000a289:	00 00 
   14000a28b:	49 89 c1             	mov    %rax,%r9
   14000a28e:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000a294:	ba 16 00 00 00       	mov    $0x16,%edx
   14000a299:	48 8d 05 b1 8f 00 00 	lea    0x8fb1(%rip),%rax        # 140013251 <.rdata+0x201>
   14000a2a0:	48 89 c1             	mov    %rax,%rcx
   14000a2a3:	e8 88 73 00 00       	call   140011630 <printf>
   14000a2a8:	b9 0a 00 00 00       	mov    $0xa,%ecx
   14000a2ad:	e8 de 77 00 00       	call   140011a90 <putchar>
   14000a2b2:	48 8b 85 98 01 00 00 	mov    0x198(%rbp),%rax
   14000a2b9:	48 89 c1             	mov    %rax,%rcx
   14000a2bc:	e8 aa 7e ff ff       	call   14000216b <type__size>
   14000a2c1:	48 83 f8 01          	cmp    $0x1,%rax
   14000a2c5:	74 23                	je     14000a2ea <main2+0x690b>
   14000a2c7:	41 b8 c7 04 00 00    	mov    $0x4c7,%r8d
   14000a2cd:	48 8d 05 7c 8d 00 00 	lea    0x8d7c(%rip),%rax        # 140013050 <.rdata>
   14000a2d4:	48 89 c2             	mov    %rax,%rdx
   14000a2d7:	48 8d 05 da aa 00 00 	lea    0xaada(%rip),%rax        # 140014db8 <.rdata+0x1d68>
   14000a2de:	48 89 c1             	mov    %rax,%rcx
   14000a2e1:	48 8b 05 58 10 01 00 	mov    0x11058(%rip),%rax        # 14001b340 <__imp__assert>
   14000a2e8:	ff d0                	call   *%rax
   14000a2ea:	48 8b 85 98 01 00 00 	mov    0x198(%rbp),%rax
   14000a2f1:	48 8b 40 10          	mov    0x10(%rax),%rax
   14000a2f5:	48 83 f8 04          	cmp    $0x4,%rax
   14000a2f9:	74 23                	je     14000a31e <main2+0x693f>
   14000a2fb:	41 b8 c7 04 00 00    	mov    $0x4c7,%r8d
   14000a301:	48 8d 05 48 8d 00 00 	lea    0x8d48(%rip),%rax        # 140013050 <.rdata>
   14000a308:	48 89 c2             	mov    %rax,%rdx
   14000a30b:	48 8d 05 d6 aa 00 00 	lea    0xaad6(%rip),%rax        # 140014de8 <.rdata+0x1d98>
   14000a312:	48 89 c1             	mov    %rax,%rcx
   14000a315:	48 8b 05 24 10 01 00 	mov    0x11024(%rip),%rax        # 14001b340 <__imp__assert>
   14000a31c:	ff d0                	call   *%rax
   14000a31e:	b9 01 00 00 00       	mov    $0x1,%ecx
   14000a323:	48 8b 05 9e 0f 01 00 	mov    0x10f9e(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   14000a32a:	ff d0                	call   *%rax
   14000a32c:	48 89 c2             	mov    %rax,%rdx
   14000a32f:	48 8b 85 90 01 00 00 	mov    0x190(%rbp),%rax
   14000a336:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000a33d:	00 00 
   14000a33f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000a345:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000a34b:	48 89 c1             	mov    %rax,%rcx
   14000a34e:	e8 8b 8f ff ff       	call   1400032de <type__print>
   14000a353:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000a357:	4c 8d 0d 60 92 00 00 	lea    0x9260(%rip),%r9        # 1400135be <.rdata+0x56e>
   14000a35e:	4c 8d 05 97 92 00 00 	lea    0x9297(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   14000a365:	ba 00 01 00 00       	mov    $0x100,%edx
   14000a36a:	48 89 c1             	mov    %rax,%rcx
   14000a36d:	e8 5e 72 00 00       	call   1400115d0 <snprintf>
   14000a372:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000a376:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   14000a37d:	00 00 
   14000a37f:	49 89 c1             	mov    %rax,%r9
   14000a382:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000a388:	ba 16 00 00 00       	mov    $0x16,%edx
   14000a38d:	48 8d 05 bd 8e 00 00 	lea    0x8ebd(%rip),%rax        # 140013251 <.rdata+0x201>
   14000a394:	48 89 c1             	mov    %rax,%rcx
   14000a397:	e8 94 72 00 00       	call   140011630 <printf>
   14000a39c:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000a3a0:	4c 8d 0d 17 92 00 00 	lea    0x9217(%rip),%r9        # 1400135be <.rdata+0x56e>
   14000a3a7:	4c 8d 05 5b 92 00 00 	lea    0x925b(%rip),%r8        # 140013609 <.rdata+0x5b9>
   14000a3ae:	ba 00 01 00 00       	mov    $0x100,%edx
   14000a3b3:	48 89 c1             	mov    %rax,%rcx
   14000a3b6:	e8 15 72 00 00       	call   1400115d0 <snprintf>
   14000a3bb:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000a3bf:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   14000a3c6:	00 00 
   14000a3c8:	49 89 c1             	mov    %rax,%r9
   14000a3cb:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000a3d1:	ba 16 00 00 00       	mov    $0x16,%edx
   14000a3d6:	48 8d 05 74 8e 00 00 	lea    0x8e74(%rip),%rax        # 140013251 <.rdata+0x201>
   14000a3dd:	48 89 c1             	mov    %rax,%rcx
   14000a3e0:	e8 4b 72 00 00       	call   140011630 <printf>
   14000a3e5:	b9 0a 00 00 00       	mov    $0xa,%ecx
   14000a3ea:	e8 a1 76 00 00       	call   140011a90 <putchar>
   14000a3ef:	48 8b 85 90 01 00 00 	mov    0x190(%rbp),%rax
   14000a3f6:	48 89 c1             	mov    %rax,%rcx
   14000a3f9:	e8 6d 7d ff ff       	call   14000216b <type__size>
   14000a3fe:	48 83 f8 04          	cmp    $0x4,%rax
   14000a402:	74 23                	je     14000a427 <main2+0x6a48>
   14000a404:	41 b8 c8 04 00 00    	mov    $0x4c8,%r8d
   14000a40a:	48 8d 05 3f 8c 00 00 	lea    0x8c3f(%rip),%rax        # 140013050 <.rdata>
   14000a411:	48 89 c2             	mov    %rax,%rdx
   14000a414:	48 8d 05 f5 a9 00 00 	lea    0xa9f5(%rip),%rax        # 140014e10 <.rdata+0x1dc0>
   14000a41b:	48 89 c1             	mov    %rax,%rcx
   14000a41e:	48 8b 05 1b 0f 01 00 	mov    0x10f1b(%rip),%rax        # 14001b340 <__imp__assert>
   14000a425:	ff d0                	call   *%rax
   14000a427:	48 8b 85 90 01 00 00 	mov    0x190(%rbp),%rax
   14000a42e:	48 8b 40 10          	mov    0x10(%rax),%rax
   14000a432:	48 83 f8 04          	cmp    $0x4,%rax
   14000a436:	74 23                	je     14000a45b <main2+0x6a7c>
   14000a438:	41 b8 c8 04 00 00    	mov    $0x4c8,%r8d
   14000a43e:	48 8d 05 0b 8c 00 00 	lea    0x8c0b(%rip),%rax        # 140013050 <.rdata>
   14000a445:	48 89 c2             	mov    %rax,%rdx
   14000a448:	48 8d 05 f1 a9 00 00 	lea    0xa9f1(%rip),%rax        # 140014e40 <.rdata+0x1df0>
   14000a44f:	48 89 c1             	mov    %rax,%rcx
   14000a452:	48 8b 05 e7 0e 01 00 	mov    0x10ee7(%rip),%rax        # 14001b340 <__imp__assert>
   14000a459:	ff d0                	call   *%rax
   14000a45b:	b9 01 00 00 00       	mov    $0x1,%ecx
   14000a460:	48 8b 05 61 0e 01 00 	mov    0x10e61(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   14000a467:	ff d0                	call   *%rax
   14000a469:	48 89 c2             	mov    %rax,%rdx
   14000a46c:	48 8b 85 88 01 00 00 	mov    0x188(%rbp),%rax
   14000a473:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000a47a:	00 00 
   14000a47c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000a482:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000a488:	48 89 c1             	mov    %rax,%rcx
   14000a48b:	e8 4e 8e ff ff       	call   1400032de <type__print>
   14000a490:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000a494:	4c 8d 0d 46 91 00 00 	lea    0x9146(%rip),%r9        # 1400135e1 <.rdata+0x591>
   14000a49b:	4c 8d 05 5a 91 00 00 	lea    0x915a(%rip),%r8        # 1400135fc <.rdata+0x5ac>
   14000a4a2:	ba 00 01 00 00       	mov    $0x100,%edx
   14000a4a7:	48 89 c1             	mov    %rax,%rcx
   14000a4aa:	e8 21 71 00 00       	call   1400115d0 <snprintf>
   14000a4af:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000a4b3:	48 c7 44 24 20 04 00 	movq   $0x4,0x20(%rsp)
   14000a4ba:	00 00 
   14000a4bc:	49 89 c1             	mov    %rax,%r9
   14000a4bf:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000a4c5:	ba 16 00 00 00       	mov    $0x16,%edx
   14000a4ca:	48 8d 05 80 8d 00 00 	lea    0x8d80(%rip),%rax        # 140013251 <.rdata+0x201>
   14000a4d1:	48 89 c1             	mov    %rax,%rcx
   14000a4d4:	e8 57 71 00 00       	call   140011630 <printf>
   14000a4d9:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000a4dd:	4c 8d 0d fd 90 00 00 	lea    0x90fd(%rip),%r9        # 1400135e1 <.rdata+0x591>
   14000a4e4:	4c 8d 05 1e 91 00 00 	lea    0x911e(%rip),%r8        # 140013609 <.rdata+0x5b9>
   14000a4eb:	ba 00 01 00 00       	mov    $0x100,%edx
   14000a4f0:	48 89 c1             	mov    %rax,%rcx
   14000a4f3:	e8 d8 70 00 00       	call   1400115d0 <snprintf>
   14000a4f8:	48 8d 45 50          	lea    0x50(%rbp),%rax
   14000a4fc:	48 c7 44 24 20 00 10 	movq   $0x1000,0x20(%rsp)
   14000a503:	00 00 
   14000a505:	49 89 c1             	mov    %rax,%r9
   14000a508:	41 b8 16 00 00 00    	mov    $0x16,%r8d
   14000a50e:	ba 16 00 00 00       	mov    $0x16,%edx
   14000a513:	48 8d 05 37 8d 00 00 	lea    0x8d37(%rip),%rax        # 140013251 <.rdata+0x201>
   14000a51a:	48 89 c1             	mov    %rax,%rcx
   14000a51d:	e8 0e 71 00 00       	call   140011630 <printf>
   14000a522:	b9 0a 00 00 00       	mov    $0xa,%ecx
   14000a527:	e8 64 75 00 00       	call   140011a90 <putchar>
   14000a52c:	48 8b 85 88 01 00 00 	mov    0x188(%rbp),%rax
   14000a533:	48 89 c1             	mov    %rax,%rcx
   14000a536:	e8 30 7c ff ff       	call   14000216b <type__size>
   14000a53b:	48 83 f8 04          	cmp    $0x4,%rax
   14000a53f:	74 23                	je     14000a564 <main2+0x6b85>
   14000a541:	41 b8 c9 04 00 00    	mov    $0x4c9,%r8d
   14000a547:	48 8d 05 02 8b 00 00 	lea    0x8b02(%rip),%rax        # 140013050 <.rdata>
   14000a54e:	48 89 c2             	mov    %rax,%rdx
   14000a551:	48 8d 05 10 a9 00 00 	lea    0xa910(%rip),%rax        # 140014e68 <.rdata+0x1e18>
   14000a558:	48 89 c1             	mov    %rax,%rcx
   14000a55b:	48 8b 05 de 0d 01 00 	mov    0x10dde(%rip),%rax        # 14001b340 <__imp__assert>
   14000a562:	ff d0                	call   *%rax
   14000a564:	48 8b 85 88 01 00 00 	mov    0x188(%rbp),%rax
   14000a56b:	48 8b 40 10          	mov    0x10(%rax),%rax
   14000a56f:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
   14000a575:	74 23                	je     14000a59a <main2+0x6bbb>
   14000a577:	41 b8 c9 04 00 00    	mov    $0x4c9,%r8d
   14000a57d:	48 8d 05 cc 8a 00 00 	lea    0x8acc(%rip),%rax        # 140013050 <.rdata>
   14000a584:	48 89 c2             	mov    %rax,%rdx
   14000a587:	48 8d 05 0a a9 00 00 	lea    0xa90a(%rip),%rax        # 140014e98 <.rdata+0x1e48>
   14000a58e:	48 89 c1             	mov    %rax,%rcx
   14000a591:	48 8b 05 a8 0d 01 00 	mov    0x10da8(%rip),%rax        # 14001b340 <__imp__assert>
   14000a598:	ff d0                	call   *%rax
   14000a59a:	c6 85 80 01 00 00 03 	movb   $0x3,0x180(%rbp)
   14000a5a1:	c7 85 84 01 00 00 5d 	movl   $0xffff695d,0x184(%rbp)
   14000a5a8:	69 ff ff 
   14000a5ab:	b9 01 00 00 00       	mov    $0x1,%ecx
   14000a5b0:	48 8b 05 11 0d 01 00 	mov    0x10d11(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   14000a5b7:	ff d0                	call   *%rax
   14000a5b9:	48 89 c1             	mov    %rax,%rcx
   14000a5bc:	48 8b 85 60 03 00 00 	mov    0x360(%rbp),%rax
   14000a5c3:	48 8d 95 80 01 00 00 	lea    0x180(%rbp),%rdx
   14000a5ca:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   14000a5cf:	41 b9 05 00 00 00    	mov    $0x5,%r9d
   14000a5d5:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000a5db:	48 89 ca             	mov    %rcx,%rdx
   14000a5de:	48 89 c1             	mov    %rax,%rcx
   14000a5e1:	e8 f8 8c ff ff       	call   1400032de <type__print>
   14000a5e6:	b9 0a 00 00 00       	mov    $0xa,%ecx
   14000a5eb:	e8 a0 74 00 00       	call   140011a90 <putchar>
   14000a5f0:	48 c7 85 60 01 00 00 	movq   $0xabab,0x160(%rbp)
   14000a5f7:	ab ab 00 00 
   14000a5fb:	f3 0f 10 05 bd a8 00 	movss  0xa8bd(%rip),%xmm0        # 140014ec0 <.rdata+0x1e70>
   14000a602:	00 
   14000a603:	f3 0f 11 85 68 01 00 	movss  %xmm0,0x168(%rbp)
   14000a60a:	00 
   14000a60b:	48 b8 b0 a5 12 02 01 	movabs $0x10212a5b0,%rax
   14000a612:	00 00 00 
   14000a615:	48 89 85 70 01 00 00 	mov    %rax,0x170(%rbp)
   14000a61c:	c7 85 78 01 00 00 d2 	movl   $0xffffa2d2,0x178(%rbp)
   14000a623:	a2 ff ff 
   14000a626:	c6 85 7c 01 00 00 de 	movb   $0xde,0x17c(%rbp)
   14000a62d:	b9 01 00 00 00       	mov    $0x1,%ecx
   14000a632:	48 8b 05 8f 0c 01 00 	mov    0x10c8f(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   14000a639:	ff d0                	call   *%rax
   14000a63b:	48 89 c1             	mov    %rax,%rcx
   14000a63e:	48 8b 85 38 03 00 00 	mov    0x338(%rbp),%rax
   14000a645:	48 8d 95 60 01 00 00 	lea    0x160(%rbp),%rdx
   14000a64c:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   14000a651:	41 b9 ff ff ff ff    	mov    $0xffffffff,%r9d
   14000a657:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000a65d:	48 89 ca             	mov    %rcx,%rdx
   14000a660:	48 89 c1             	mov    %rax,%rcx
   14000a663:	e8 76 8c ff ff       	call   1400032de <type__print>
   14000a668:	b9 0a 00 00 00       	mov    $0xa,%ecx
   14000a66d:	e8 1e 74 00 00       	call   140011a90 <putchar>
   14000a672:	66 c7 85 5d 01 00 00 	movw   $0x48fd,0x15d(%rbp)
   14000a679:	fd 48 
   14000a67b:	c6 85 5f 01 00 00 88 	movb   $0x88,0x15f(%rbp)
   14000a682:	b9 01 00 00 00       	mov    $0x1,%ecx
   14000a687:	48 8b 05 3a 0c 01 00 	mov    0x10c3a(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   14000a68e:	ff d0                	call   *%rax
   14000a690:	48 89 c1             	mov    %rax,%rcx
   14000a693:	48 8b 85 50 03 00 00 	mov    0x350(%rbp),%rax
   14000a69a:	48 8d 95 5d 01 00 00 	lea    0x15d(%rbp),%rdx
   14000a6a1:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   14000a6a6:	41 b9 ff ff ff ff    	mov    $0xffffffff,%r9d
   14000a6ac:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000a6b2:	48 89 ca             	mov    %rcx,%rdx
   14000a6b5:	48 89 c1             	mov    %rax,%rcx
   14000a6b8:	e8 21 8c ff ff       	call   1400032de <type__print>
   14000a6bd:	b9 0a 00 00 00       	mov    $0xa,%ecx
   14000a6c2:	e8 c9 73 00 00       	call   140011a90 <putchar>
   14000a6c7:	b8 00 00 00 00       	mov    $0x0,%eax
   14000a6cc:	48 81 c4 40 04 00 00 	add    $0x440,%rsp
   14000a6d3:	5d                   	pop    %rbp
   14000a6d4:	c3                   	ret
   14000a6d5:	90                   	nop
   14000a6d6:	90                   	nop
   14000a6d7:	90                   	nop
   14000a6d8:	90                   	nop
   14000a6d9:	90                   	nop
   14000a6da:	90                   	nop
   14000a6db:	90                   	nop
   14000a6dc:	90                   	nop
   14000a6dd:	90                   	nop
   14000a6de:	90                   	nop
   14000a6df:	90                   	nop

000000014000a6e0 <state__type_add>:
   14000a6e0:	55                   	push   %rbp
   14000a6e1:	48 89 e5             	mov    %rsp,%rbp
   14000a6e4:	48 83 ec 20          	sub    $0x20,%rsp
   14000a6e8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000a6ec:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000a6f0:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000a6f4:	8b 50 64             	mov    0x64(%rax),%edx
   14000a6f7:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000a6fb:	8b 40 60             	mov    0x60(%rax),%eax
   14000a6fe:	39 c2                	cmp    %eax,%edx
   14000a700:	75 72                	jne    14000a774 <state__type_add+0x94>
   14000a702:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000a706:	8b 40 64             	mov    0x64(%rax),%eax
   14000a709:	85 c0                	test   %eax,%eax
   14000a70b:	75 2d                	jne    14000a73a <state__type_add+0x5a>
   14000a70d:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000a711:	c7 40 60 08 00 00 00 	movl   $0x8,0x60(%rax)
   14000a718:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000a71c:	8b 40 60             	mov    0x60(%rax),%eax
   14000a71f:	89 c0                	mov    %eax,%eax
   14000a721:	48 c1 e0 03          	shl    $0x3,%rax
   14000a725:	48 89 c1             	mov    %rax,%rcx
   14000a728:	e8 43 73 00 00       	call   140011a70 <malloc>
   14000a72d:	48 89 c2             	mov    %rax,%rdx
   14000a730:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000a734:	48 89 50 58          	mov    %rdx,0x58(%rax)
   14000a738:	eb 3a                	jmp    14000a774 <state__type_add+0x94>
   14000a73a:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000a73e:	8b 40 60             	mov    0x60(%rax),%eax
   14000a741:	8d 14 00             	lea    (%rax,%rax,1),%edx
   14000a744:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000a748:	89 50 60             	mov    %edx,0x60(%rax)
   14000a74b:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000a74f:	8b 40 60             	mov    0x60(%rax),%eax
   14000a752:	89 c0                	mov    %eax,%eax
   14000a754:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   14000a75b:	00 
   14000a75c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000a760:	48 8b 40 58          	mov    0x58(%rax),%rax
   14000a764:	48 89 c1             	mov    %rax,%rcx
   14000a767:	e8 2c 73 00 00       	call   140011a98 <realloc>
   14000a76c:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   14000a770:	48 89 42 58          	mov    %rax,0x58(%rdx)
   14000a774:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000a778:	8b 50 64             	mov    0x64(%rax),%edx
   14000a77b:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000a77f:	8b 40 60             	mov    0x60(%rax),%eax
   14000a782:	39 c2                	cmp    %eax,%edx
   14000a784:	72 23                	jb     14000a7a9 <state__type_add+0xc9>
   14000a786:	41 b8 78 00 00 00    	mov    $0x78,%r8d
   14000a78c:	48 8d 05 3d a7 00 00 	lea    0xa73d(%rip),%rax        # 140014ed0 <.rdata>
   14000a793:	48 89 c2             	mov    %rax,%rdx
   14000a796:	48 8d 05 3b a7 00 00 	lea    0xa73b(%rip),%rax        # 140014ed8 <.rdata+0x8>
   14000a79d:	48 89 c1             	mov    %rax,%rcx
   14000a7a0:	48 8b 05 99 0b 01 00 	mov    0x10b99(%rip),%rax        # 14001b340 <__imp__assert>
   14000a7a7:	ff d0                	call   *%rax
   14000a7a9:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000a7ad:	4c 8b 40 58          	mov    0x58(%rax),%r8
   14000a7b1:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000a7b5:	8b 40 64             	mov    0x64(%rax),%eax
   14000a7b8:	8d 48 01             	lea    0x1(%rax),%ecx
   14000a7bb:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   14000a7bf:	89 4a 64             	mov    %ecx,0x64(%rdx)
   14000a7c2:	89 c0                	mov    %eax,%eax
   14000a7c4:	48 c1 e0 03          	shl    $0x3,%rax
   14000a7c8:	49 8d 14 00          	lea    (%r8,%rax,1),%rdx
   14000a7cc:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000a7d0:	48 89 02             	mov    %rax,(%rdx)
   14000a7d3:	90                   	nop
   14000a7d4:	48 83 c4 20          	add    $0x20,%rsp
   14000a7d8:	5d                   	pop    %rbp
   14000a7d9:	c3                   	ret

000000014000a7da <state__type_find>:
   14000a7da:	55                   	push   %rbp
   14000a7db:	48 89 e5             	mov    %rsp,%rbp
   14000a7de:	48 83 ec 40          	sub    $0x40,%rsp
   14000a7e2:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000a7e6:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000a7ea:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   14000a7f1:	00 
   14000a7f2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   14000a7f9:	eb 3f                	jmp    14000a83a <state__type_find+0x60>
   14000a7fb:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000a7ff:	48 8b 40 58          	mov    0x58(%rax),%rax
   14000a803:	8b 55 f4             	mov    -0xc(%rbp),%edx
   14000a806:	48 c1 e2 03          	shl    $0x3,%rdx
   14000a80a:	48 01 d0             	add    %rdx,%rax
   14000a80d:	48 8b 00             	mov    (%rax),%rax
   14000a810:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000a814:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000a818:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000a81c:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   14000a820:	48 89 c1             	mov    %rax,%rcx
   14000a823:	e8 80 72 00 00       	call   140011aa8 <strcmp>
   14000a828:	85 c0                	test   %eax,%eax
   14000a82a:	75 0a                	jne    14000a836 <state__type_find+0x5c>
   14000a82c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000a830:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000a834:	eb 0f                	jmp    14000a845 <state__type_find+0x6b>
   14000a836:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   14000a83a:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000a83e:	8b 40 64             	mov    0x64(%rax),%eax
   14000a841:	85 c0                	test   %eax,%eax
   14000a843:	75 b6                	jne    14000a7fb <state__type_find+0x21>
   14000a845:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000a849:	48 83 c4 40          	add    $0x40,%rsp
   14000a84d:	5d                   	pop    %rbp
   14000a84e:	c3                   	ret

000000014000a84f <state__patch_jmp>:
   14000a84f:	55                   	push   %rbp
   14000a850:	48 89 e5             	mov    %rsp,%rbp
   14000a853:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000a857:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000a85b:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   14000a85f:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000a863:	48 8d 50 01          	lea    0x1(%rax),%rdx
   14000a867:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000a86b:	48 89 02             	mov    %rax,(%rdx)
   14000a86e:	90                   	nop
   14000a86f:	5d                   	pop    %rbp
   14000a870:	c3                   	ret

000000014000a871 <state__patch_call>:
   14000a871:	55                   	push   %rbp
   14000a872:	48 89 e5             	mov    %rsp,%rbp
   14000a875:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000a879:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000a87d:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   14000a881:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000a885:	48 8d 50 01          	lea    0x1(%rax),%rdx
   14000a889:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000a88d:	48 89 02             	mov    %rax,(%rdx)
   14000a890:	90                   	nop
   14000a891:	5d                   	pop    %rbp
   14000a892:	c3                   	ret

000000014000a893 <state__add_ins>:
   14000a893:	55                   	push   %rbp
   14000a894:	48 89 e5             	mov    %rsp,%rbp
   14000a897:	48 81 ec 90 00 00 00 	sub    $0x90,%rsp
   14000a89e:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000a8a2:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000a8a6:	44 89 45 20          	mov    %r8d,0x20(%rbp)
   14000a8aa:	4c 89 4d 28          	mov    %r9,0x28(%rbp)
   14000a8ae:	48 8d 45 28          	lea    0x28(%rbp),%rax
   14000a8b2:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   14000a8b6:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000a8ba:	48 8d 50 01          	lea    0x1(%rax),%rdx
   14000a8be:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000a8c2:	8b 55 20             	mov    0x20(%rbp),%edx
   14000a8c5:	88 10                	mov    %dl,(%rax)
   14000a8c7:	83 7d 20 32          	cmpl   $0x32,0x20(%rbp)
   14000a8cb:	0f 87 0b 02 00 00    	ja     14000aadc <state__add_ins+0x249>
   14000a8d1:	8b 45 20             	mov    0x20(%rbp),%eax
   14000a8d4:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   14000a8db:	00 
   14000a8dc:	48 8d 05 21 a6 00 00 	lea    0xa621(%rip),%rax        # 140014f04 <.rdata+0x34>
   14000a8e3:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   14000a8e6:	48 98                	cltq
   14000a8e8:	48 8d 15 15 a6 00 00 	lea    0xa615(%rip),%rdx        # 140014f04 <.rdata+0x34>
   14000a8ef:	48 01 d0             	add    %rdx,%rax
   14000a8f2:	ff e0                	jmp    *%rax
   14000a8f4:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   14000a8f8:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000a8fc:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   14000a900:	48 8b 00             	mov    (%rax),%rax
   14000a903:	48 8b 50 08          	mov    0x8(%rax),%rdx
   14000a907:	48 8b 00             	mov    (%rax),%rax
   14000a90a:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   14000a90e:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
   14000a912:	48 8b 4d 18          	mov    0x18(%rbp),%rcx
   14000a916:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   14000a91a:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   14000a91e:	48 89 01             	mov    %rax,(%rcx)
   14000a921:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000a925:	48 83 45 18 10       	addq   $0x10,0x18(%rbp)
   14000a92a:	e9 d1 01 00 00       	jmp    14000ab00 <state__add_ins+0x26d>
   14000a92f:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   14000a933:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000a937:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   14000a93b:	48 8b 00             	mov    (%rax),%rax
   14000a93e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   14000a942:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   14000a946:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000a94a:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   14000a94e:	48 8b 00             	mov    (%rax),%rax
   14000a951:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   14000a955:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000a959:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   14000a95d:	48 89 10             	mov    %rdx,(%rax)
   14000a960:	48 83 45 18 08       	addq   $0x8,0x18(%rbp)
   14000a965:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000a969:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   14000a96d:	48 89 10             	mov    %rdx,(%rax)
   14000a970:	48 83 45 18 08       	addq   $0x8,0x18(%rbp)
   14000a975:	e9 86 01 00 00       	jmp    14000ab00 <state__add_ins+0x26d>
   14000a97a:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   14000a97e:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000a982:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   14000a986:	48 8b 00             	mov    (%rax),%rax
   14000a989:	48 8b 50 08          	mov    0x8(%rax),%rdx
   14000a98d:	48 8b 00             	mov    (%rax),%rax
   14000a990:	48 89 45 90          	mov    %rax,-0x70(%rbp)
   14000a994:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   14000a998:	48 8b 4d 18          	mov    0x18(%rbp),%rcx
   14000a99c:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   14000a9a0:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   14000a9a4:	48 89 01             	mov    %rax,(%rcx)
   14000a9a7:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000a9ab:	48 83 45 18 10       	addq   $0x10,0x18(%rbp)
   14000a9b0:	e9 4b 01 00 00       	jmp    14000ab00 <state__add_ins+0x26d>
   14000a9b5:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   14000a9b9:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000a9bd:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   14000a9c1:	8b 00                	mov    (%rax),%eax
   14000a9c3:	88 45 d7             	mov    %al,-0x29(%rbp)
   14000a9c6:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   14000a9ca:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000a9ce:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   14000a9d2:	8b 00                	mov    (%rax),%eax
   14000a9d4:	88 45 d6             	mov    %al,-0x2a(%rbp)
   14000a9d7:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000a9db:	0f b6 55 d7          	movzbl -0x29(%rbp),%edx
   14000a9df:	88 10                	mov    %dl,(%rax)
   14000a9e1:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   14000a9e6:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000a9ea:	0f b6 55 d6          	movzbl -0x2a(%rbp),%edx
   14000a9ee:	88 10                	mov    %dl,(%rax)
   14000a9f0:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   14000a9f5:	e9 06 01 00 00       	jmp    14000ab00 <state__add_ins+0x26d>
   14000a9fa:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   14000a9fe:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000aa02:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   14000aa06:	48 8b 00             	mov    (%rax),%rax
   14000aa09:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   14000aa0d:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000aa11:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   14000aa15:	48 89 10             	mov    %rdx,(%rax)
   14000aa18:	48 83 45 18 08       	addq   $0x8,0x18(%rbp)
   14000aa1d:	e9 de 00 00 00       	jmp    14000ab00 <state__add_ins+0x26d>
   14000aa22:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   14000aa26:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000aa2a:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   14000aa2e:	48 8b 00             	mov    (%rax),%rax
   14000aa31:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   14000aa35:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000aa39:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   14000aa3d:	48 89 10             	mov    %rdx,(%rax)
   14000aa40:	48 83 45 18 08       	addq   $0x8,0x18(%rbp)
   14000aa45:	e9 b6 00 00 00       	jmp    14000ab00 <state__add_ins+0x26d>
   14000aa4a:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   14000aa4e:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000aa52:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   14000aa56:	8b 00                	mov    (%rax),%eax
   14000aa58:	88 45 ef             	mov    %al,-0x11(%rbp)
   14000aa5b:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000aa5f:	0f b6 55 ef          	movzbl -0x11(%rbp),%edx
   14000aa63:	88 10                	mov    %dl,(%rax)
   14000aa65:	48 83 45 18 01       	addq   $0x1,0x18(%rbp)
   14000aa6a:	e9 91 00 00 00       	jmp    14000ab00 <state__add_ins+0x26d>
   14000aa6f:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   14000aa73:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000aa77:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   14000aa7b:	48 8b 00             	mov    (%rax),%rax
   14000aa7e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000aa82:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000aa86:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   14000aa8a:	48 89 10             	mov    %rdx,(%rax)
   14000aa8d:	48 83 45 18 08       	addq   $0x8,0x18(%rbp)
   14000aa92:	eb 6c                	jmp    14000ab00 <state__add_ins+0x26d>
   14000aa94:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   14000aa98:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000aa9c:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   14000aaa0:	8b 00                	mov    (%rax),%eax
   14000aaa2:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
   14000aaa6:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000aaaa:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
   14000aaae:	66 89 10             	mov    %dx,(%rax)
   14000aab1:	48 83 45 18 02       	addq   $0x2,0x18(%rbp)
   14000aab6:	eb 48                	jmp    14000ab00 <state__add_ins+0x26d>
   14000aab8:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   14000aabc:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000aac0:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   14000aac4:	8b 00                	mov    (%rax),%eax
   14000aac6:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
   14000aaca:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000aace:	0f b7 55 fe          	movzwl -0x2(%rbp),%edx
   14000aad2:	66 89 10             	mov    %dx,(%rax)
   14000aad5:	48 83 45 18 02       	addq   $0x2,0x18(%rbp)
   14000aada:	eb 24                	jmp    14000ab00 <state__add_ins+0x26d>
   14000aadc:	41 b8 48 01 00 00    	mov    $0x148,%r8d
   14000aae2:	48 8d 05 e7 a3 00 00 	lea    0xa3e7(%rip),%rax        # 140014ed0 <.rdata>
   14000aae9:	48 89 c2             	mov    %rax,%rdx
   14000aaec:	48 8d 05 08 a4 00 00 	lea    0xa408(%rip),%rax        # 140014efb <.rdata+0x2b>
   14000aaf3:	48 89 c1             	mov    %rax,%rcx
   14000aaf6:	48 8b 05 43 08 01 00 	mov    0x10843(%rip),%rax        # 14001b340 <__imp__assert>
   14000aafd:	ff d0                	call   *%rax
   14000aaff:	90                   	nop
   14000ab00:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000ab04:	48 81 c4 90 00 00 00 	add    $0x90,%rsp
   14000ab0b:	5d                   	pop    %rbp
   14000ab0c:	c3                   	ret

000000014000ab0d <fn_decl__create>:
   14000ab0d:	55                   	push   %rbp
   14000ab0e:	48 89 e5             	mov    %rsp,%rbp
   14000ab11:	48 83 ec 30          	sub    $0x30,%rsp
   14000ab15:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000ab19:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000ab1d:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   14000ab21:	ba 48 00 00 00       	mov    $0x48,%edx
   14000ab26:	b9 01 00 00 00       	mov    $0x1,%ecx
   14000ab2b:	e8 00 6f 00 00       	call   140011a30 <calloc>
   14000ab30:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000ab34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000ab38:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   14000ab3c:	48 89 50 18          	mov    %rdx,0x18(%rax)
   14000ab40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000ab44:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   14000ab48:	48 89 50 08          	mov    %rdx,0x8(%rax)
   14000ab4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000ab50:	48 83 c4 30          	add    $0x30,%rsp
   14000ab54:	5d                   	pop    %rbp
   14000ab55:	c3                   	ret

000000014000ab56 <state__compile_fn>:
   14000ab56:	55                   	push   %rbp
   14000ab57:	48 89 e5             	mov    %rsp,%rbp
   14000ab5a:	48 83 ec 20          	sub    $0x20,%rsp
   14000ab5e:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000ab62:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000ab66:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   14000ab6a:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000ab6e:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   14000ab72:	48 89 50 10          	mov    %rdx,0x10(%rax)
   14000ab76:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000ab7a:	4c 8b 48 08          	mov    0x8(%rax),%r9
   14000ab7e:	48 8b 4d 20          	mov    0x20(%rbp),%rcx
   14000ab82:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   14000ab86:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000ab8a:	49 89 c8             	mov    %rcx,%r8
   14000ab8d:	48 89 c1             	mov    %rax,%rcx
   14000ab90:	41 ff d1             	call   *%r9
   14000ab93:	48 83 c4 20          	add    $0x20,%rsp
   14000ab97:	5d                   	pop    %rbp
   14000ab98:	c3                   	ret

000000014000ab99 <fn_decl__get_fn_return_offset_from_bp>:
   14000ab99:	55                   	push   %rbp
   14000ab9a:	48 89 e5             	mov    %rsp,%rbp
   14000ab9d:	48 83 ec 60          	sub    $0x60,%rsp
   14000aba1:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000aba5:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000aba9:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000abad:	48 8b 40 18          	mov    0x18(%rax),%rax
   14000abb1:	48 85 c0             	test   %rax,%rax
   14000abb4:	75 23                	jne    14000abd9 <fn_decl__get_fn_return_offset_from_bp+0x40>
   14000abb6:	41 b8 96 01 00 00    	mov    $0x196,%r8d
   14000abbc:	48 8d 05 0d a3 00 00 	lea    0xa30d(%rip),%rax        # 140014ed0 <.rdata>
   14000abc3:	48 89 c2             	mov    %rax,%rdx
   14000abc6:	48 8d 05 03 a4 00 00 	lea    0xa403(%rip),%rax        # 140014fd0 <.rdata+0x100>
   14000abcd:	48 89 c1             	mov    %rax,%rcx
   14000abd0:	48 8b 05 69 07 01 00 	mov    0x10769(%rip),%rax        # 14001b340 <__imp__assert>
   14000abd7:	ff d0                	call   *%rax
   14000abd9:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   14000abe0:	00 
   14000abe1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000abe5:	48 83 e8 10          	sub    $0x10,%rax
   14000abe9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000abed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000abf1:	48 83 e8 08          	sub    $0x8,%rax
   14000abf5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000abf9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   14000ac00:	eb 2c                	jmp    14000ac2e <fn_decl__get_fn_return_offset_from_bp+0x95>
   14000ac02:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000ac06:	48 8b 40 20          	mov    0x20(%rax),%rax
   14000ac0a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   14000ac0d:	48 c1 e2 03          	shl    $0x3,%rdx
   14000ac11:	48 01 d0             	add    %rdx,%rax
   14000ac14:	48 8b 00             	mov    (%rax),%rax
   14000ac17:	48 89 c1             	mov    %rax,%rcx
   14000ac1a:	e8 4c 75 ff ff       	call   14000216b <type__size>
   14000ac1f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   14000ac23:	48 29 c2             	sub    %rax,%rdx
   14000ac26:	48 89 55 f8          	mov    %rdx,-0x8(%rbp)
   14000ac2a:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   14000ac2e:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000ac32:	8b 40 28             	mov    0x28(%rax),%eax
   14000ac35:	39 45 f4             	cmp    %eax,-0xc(%rbp)
   14000ac38:	72 c8                	jb     14000ac02 <fn_decl__get_fn_return_offset_from_bp+0x69>
   14000ac3a:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000ac3e:	48 8b 40 18          	mov    0x18(%rax),%rax
   14000ac42:	48 89 c1             	mov    %rax,%rcx
   14000ac45:	e8 21 75 ff ff       	call   14000216b <type__size>
   14000ac4a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   14000ac4e:	48 29 c2             	sub    %rax,%rdx
   14000ac51:	48 89 55 f8          	mov    %rdx,-0x8(%rbp)
   14000ac55:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000ac59:	48 8b 40 18          	mov    0x18(%rax),%rax
   14000ac5d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000ac61:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000ac65:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000ac69:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000ac6d:	48 8b 00             	mov    (%rax),%rax
   14000ac70:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   14000ac74:	e9 bc 00 00 00       	jmp    14000ad35 <fn_decl__get_fn_return_offset_from_bp+0x19c>
   14000ac79:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   14000ac7d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000ac81:	48 89 c1             	mov    %rax,%rcx
   14000ac84:	e8 17 7f ff ff       	call   140002ba0 <type__member>
   14000ac89:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   14000ac8d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   14000ac92:	74 6b                	je     14000acff <fn_decl__get_fn_return_offset_from_bp+0x166>
   14000ac94:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14000ac98:	48 8b 40 10          	mov    0x10(%rax),%rax
   14000ac9c:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   14000aca0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14000aca4:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000aca8:	8b 00                	mov    (%rax),%eax
   14000acaa:	83 f8 03             	cmp    $0x3,%eax
   14000acad:	75 42                	jne    14000acf1 <fn_decl__get_fn_return_offset_from_bp+0x158>
   14000acaf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14000acb3:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000acb7:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   14000acbb:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000acbf:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000acc3:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000acc7:	48 8b 00             	mov    (%rax),%rax
   14000acca:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   14000acce:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   14000acd2:	48 8b 40 30          	mov    0x30(%rax),%rax
   14000acd6:	48 89 c1             	mov    %rax,%rcx
   14000acd9:	e8 8d 74 ff ff       	call   14000216b <type__size>
   14000acde:	48 0f af 45 c8       	imul   -0x38(%rbp),%rax
   14000ace3:	48 89 c2             	mov    %rax,%rdx
   14000ace6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000acea:	48 01 d0             	add    %rdx,%rax
   14000aced:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000acf1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14000acf5:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000acf9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000acfd:	eb 23                	jmp    14000ad22 <fn_decl__get_fn_return_offset_from_bp+0x189>
   14000acff:	41 b8 ad 01 00 00    	mov    $0x1ad,%r8d
   14000ad05:	48 8d 05 c4 a1 00 00 	lea    0xa1c4(%rip),%rax        # 140014ed0 <.rdata>
   14000ad0c:	48 89 c2             	mov    %rax,%rdx
   14000ad0f:	48 8d 05 e5 a1 00 00 	lea    0xa1e5(%rip),%rax        # 140014efb <.rdata+0x2b>
   14000ad16:	48 89 c1             	mov    %rax,%rcx
   14000ad19:	48 8b 05 20 06 01 00 	mov    0x10620(%rip),%rax        # 14001b340 <__imp__assert>
   14000ad20:	ff d0                	call   *%rax
   14000ad22:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000ad26:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000ad2a:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000ad2e:	48 8b 00             	mov    (%rax),%rax
   14000ad31:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   14000ad35:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   14000ad3a:	0f 85 39 ff ff ff    	jne    14000ac79 <fn_decl__get_fn_return_offset_from_bp+0xe0>
   14000ad40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000ad44:	48 83 c4 60          	add    $0x60,%rsp
   14000ad48:	5d                   	pop    %rbp
   14000ad49:	c3                   	ret

000000014000ad4a <fn_decl__get_fn_arg_offset_from_bp>:
   14000ad4a:	55                   	push   %rbp
   14000ad4b:	48 89 e5             	mov    %rsp,%rbp
   14000ad4e:	48 83 ec 60          	sub    $0x60,%rsp
   14000ad52:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000ad56:	89 55 18             	mov    %edx,0x18(%rbp)
   14000ad59:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   14000ad5d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   14000ad64:	00 
   14000ad65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000ad69:	48 83 e8 10          	sub    $0x10,%rax
   14000ad6d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000ad71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000ad75:	48 83 e8 08          	sub    $0x8,%rax
   14000ad79:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000ad7d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   14000ad84:	e9 54 01 00 00       	jmp    14000aedd <fn_decl__get_fn_arg_offset_from_bp+0x193>
   14000ad89:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000ad8d:	48 8b 40 20          	mov    0x20(%rax),%rax
   14000ad91:	8b 55 f4             	mov    -0xc(%rbp),%edx
   14000ad94:	48 c1 e2 03          	shl    $0x3,%rdx
   14000ad98:	48 01 d0             	add    %rdx,%rax
   14000ad9b:	48 8b 00             	mov    (%rax),%rax
   14000ad9e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   14000ada2:	8b 45 f4             	mov    -0xc(%rbp),%eax
   14000ada5:	3b 45 18             	cmp    0x18(%rbp),%eax
   14000ada8:	73 23                	jae    14000adcd <fn_decl__get_fn_arg_offset_from_bp+0x83>
   14000adaa:	41 b8 bc 01 00 00    	mov    $0x1bc,%r8d
   14000adb0:	48 8d 05 19 a1 00 00 	lea    0xa119(%rip),%rax        # 140014ed0 <.rdata>
   14000adb7:	48 89 c2             	mov    %rax,%rdx
   14000adba:	48 8d 05 3a a1 00 00 	lea    0xa13a(%rip),%rax        # 140014efb <.rdata+0x2b>
   14000adc1:	48 89 c1             	mov    %rax,%rcx
   14000adc4:	48 8b 05 75 05 01 00 	mov    0x10575(%rip),%rax        # 14001b340 <__imp__assert>
   14000adcb:	ff d0                	call   *%rax
   14000adcd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14000add1:	48 89 c1             	mov    %rax,%rcx
   14000add4:	e8 92 73 ff ff       	call   14000216b <type__size>
   14000add9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   14000addd:	48 29 c2             	sub    %rax,%rdx
   14000ade0:	48 89 55 f8          	mov    %rdx,-0x8(%rbp)
   14000ade4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   14000ade7:	3b 45 18             	cmp    0x18(%rbp),%eax
   14000adea:	0f 85 e9 00 00 00    	jne    14000aed9 <fn_decl__get_fn_arg_offset_from_bp+0x18f>
   14000adf0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14000adf4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000adf8:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000adfc:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000ae00:	48 89 55 20          	mov    %rdx,0x20(%rbp)
   14000ae04:	48 8b 00             	mov    (%rax),%rax
   14000ae07:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   14000ae0b:	e9 bc 00 00 00       	jmp    14000aecc <fn_decl__get_fn_arg_offset_from_bp+0x182>
   14000ae10:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   14000ae14:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000ae18:	48 89 c1             	mov    %rax,%rcx
   14000ae1b:	e8 80 7d ff ff       	call   140002ba0 <type__member>
   14000ae20:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   14000ae24:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   14000ae29:	74 6b                	je     14000ae96 <fn_decl__get_fn_arg_offset_from_bp+0x14c>
   14000ae2b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   14000ae2f:	48 8b 40 10          	mov    0x10(%rax),%rax
   14000ae33:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   14000ae37:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   14000ae3b:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000ae3f:	8b 00                	mov    (%rax),%eax
   14000ae41:	83 f8 03             	cmp    $0x3,%eax
   14000ae44:	75 42                	jne    14000ae88 <fn_decl__get_fn_arg_offset_from_bp+0x13e>
   14000ae46:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   14000ae4a:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000ae4e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   14000ae52:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000ae56:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000ae5a:	48 89 55 20          	mov    %rdx,0x20(%rbp)
   14000ae5e:	48 8b 00             	mov    (%rax),%rax
   14000ae61:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   14000ae65:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   14000ae69:	48 8b 40 30          	mov    0x30(%rax),%rax
   14000ae6d:	48 89 c1             	mov    %rax,%rcx
   14000ae70:	e8 f6 72 ff ff       	call   14000216b <type__size>
   14000ae75:	48 0f af 45 c0       	imul   -0x40(%rbp),%rax
   14000ae7a:	48 89 c2             	mov    %rax,%rdx
   14000ae7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000ae81:	48 01 d0             	add    %rdx,%rax
   14000ae84:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000ae88:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   14000ae8c:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000ae90:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000ae94:	eb 23                	jmp    14000aeb9 <fn_decl__get_fn_arg_offset_from_bp+0x16f>
   14000ae96:	41 b8 cd 01 00 00    	mov    $0x1cd,%r8d
   14000ae9c:	48 8d 05 2d a0 00 00 	lea    0xa02d(%rip),%rax        # 140014ed0 <.rdata>
   14000aea3:	48 89 c2             	mov    %rax,%rdx
   14000aea6:	48 8d 05 4e a0 00 00 	lea    0xa04e(%rip),%rax        # 140014efb <.rdata+0x2b>
   14000aead:	48 89 c1             	mov    %rax,%rcx
   14000aeb0:	48 8b 05 89 04 01 00 	mov    0x10489(%rip),%rax        # 14001b340 <__imp__assert>
   14000aeb7:	ff d0                	call   *%rax
   14000aeb9:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000aebd:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000aec1:	48 89 55 20          	mov    %rdx,0x20(%rbp)
   14000aec5:	48 8b 00             	mov    (%rax),%rax
   14000aec8:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   14000aecc:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   14000aed1:	0f 85 39 ff ff ff    	jne    14000ae10 <fn_decl__get_fn_arg_offset_from_bp+0xc6>
   14000aed7:	eb 14                	jmp    14000aeed <fn_decl__get_fn_arg_offset_from_bp+0x1a3>
   14000aed9:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   14000aedd:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000aee1:	8b 40 28             	mov    0x28(%rax),%eax
   14000aee4:	39 45 f4             	cmp    %eax,-0xc(%rbp)
   14000aee7:	0f 82 9c fe ff ff    	jb     14000ad89 <fn_decl__get_fn_arg_offset_from_bp+0x3f>
   14000aeed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000aef1:	48 83 c4 60          	add    $0x60,%rsp
   14000aef5:	5d                   	pop    %rbp
   14000aef6:	c3                   	ret

000000014000aef7 <fn_decl__get_fn_local_offset_from_bp>:
   14000aef7:	55                   	push   %rbp
   14000aef8:	48 89 e5             	mov    %rsp,%rbp
   14000aefb:	48 83 ec 60          	sub    $0x60,%rsp
   14000aeff:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000af03:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000af07:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   14000af0b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   14000af12:	00 
   14000af13:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
   14000af17:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
   14000af1e:	e9 44 01 00 00       	jmp    14000b067 <fn_decl__get_fn_local_offset_from_bp+0x170>
   14000af23:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000af27:	48 8b 40 38          	mov    0x38(%rax),%rax
   14000af2b:	8b 55 f0             	mov    -0x10(%rbp),%edx
   14000af2e:	48 c1 e2 03          	shl    $0x3,%rdx
   14000af32:	48 01 d0             	add    %rdx,%rax
   14000af35:	48 8b 00             	mov    (%rax),%rax
   14000af38:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   14000af3c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14000af40:	48 8b 10             	mov    (%rax),%rdx
   14000af43:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000af47:	48 89 c1             	mov    %rax,%rcx
   14000af4a:	e8 59 6b 00 00       	call   140011aa8 <strcmp>
   14000af4f:	85 c0                	test   %eax,%eax
   14000af51:	0f 85 f1 00 00 00    	jne    14000b048 <fn_decl__get_fn_local_offset_from_bp+0x151>
   14000af57:	c6 45 f7 01          	movb   $0x1,-0x9(%rbp)
   14000af5b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14000af5f:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000af63:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000af67:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000af6b:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000af6f:	48 89 55 20          	mov    %rdx,0x20(%rbp)
   14000af73:	48 8b 00             	mov    (%rax),%rax
   14000af76:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   14000af7a:	e9 bc 00 00 00       	jmp    14000b03b <fn_decl__get_fn_local_offset_from_bp+0x144>
   14000af7f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   14000af83:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000af87:	48 89 c1             	mov    %rax,%rcx
   14000af8a:	e8 11 7c ff ff       	call   140002ba0 <type__member>
   14000af8f:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   14000af93:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   14000af98:	74 6b                	je     14000b005 <fn_decl__get_fn_local_offset_from_bp+0x10e>
   14000af9a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   14000af9e:	48 8b 40 10          	mov    0x10(%rax),%rax
   14000afa2:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   14000afa6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   14000afaa:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000afae:	8b 00                	mov    (%rax),%eax
   14000afb0:	83 f8 03             	cmp    $0x3,%eax
   14000afb3:	75 42                	jne    14000aff7 <fn_decl__get_fn_local_offset_from_bp+0x100>
   14000afb5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   14000afb9:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000afbd:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   14000afc1:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000afc5:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000afc9:	48 89 55 20          	mov    %rdx,0x20(%rbp)
   14000afcd:	48 8b 00             	mov    (%rax),%rax
   14000afd0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   14000afd4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   14000afd8:	48 8b 40 30          	mov    0x30(%rax),%rax
   14000afdc:	48 89 c1             	mov    %rax,%rcx
   14000afdf:	e8 87 71 ff ff       	call   14000216b <type__size>
   14000afe4:	48 0f af 45 c0       	imul   -0x40(%rbp),%rax
   14000afe9:	48 89 c2             	mov    %rax,%rdx
   14000afec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000aff0:	48 01 d0             	add    %rdx,%rax
   14000aff3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000aff7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   14000affb:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000afff:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000b003:	eb 23                	jmp    14000b028 <fn_decl__get_fn_local_offset_from_bp+0x131>
   14000b005:	41 b8 ec 01 00 00    	mov    $0x1ec,%r8d
   14000b00b:	48 8d 05 be 9e 00 00 	lea    0x9ebe(%rip),%rax        # 140014ed0 <.rdata>
   14000b012:	48 89 c2             	mov    %rax,%rdx
   14000b015:	48 8d 05 df 9e 00 00 	lea    0x9edf(%rip),%rax        # 140014efb <.rdata+0x2b>
   14000b01c:	48 89 c1             	mov    %rax,%rcx
   14000b01f:	48 8b 05 1a 03 01 00 	mov    0x1031a(%rip),%rax        # 14001b340 <__imp__assert>
   14000b026:	ff d0                	call   *%rax
   14000b028:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b02c:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000b030:	48 89 55 20          	mov    %rdx,0x20(%rbp)
   14000b034:	48 8b 00             	mov    (%rax),%rax
   14000b037:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   14000b03b:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   14000b040:	0f 85 39 ff ff ff    	jne    14000af7f <fn_decl__get_fn_local_offset_from_bp+0x88>
   14000b046:	eb 2f                	jmp    14000b077 <fn_decl__get_fn_local_offset_from_bp+0x180>
   14000b048:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14000b04c:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000b050:	48 89 c1             	mov    %rax,%rcx
   14000b053:	e8 13 71 ff ff       	call   14000216b <type__size>
   14000b058:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   14000b05c:	48 01 d0             	add    %rdx,%rax
   14000b05f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000b063:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
   14000b067:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b06b:	8b 40 40             	mov    0x40(%rax),%eax
   14000b06e:	39 45 f0             	cmp    %eax,-0x10(%rbp)
   14000b071:	0f 82 ac fe ff ff    	jb     14000af23 <fn_decl__get_fn_local_offset_from_bp+0x2c>
   14000b077:	80 7d f7 00          	cmpb   $0x0,-0x9(%rbp)
   14000b07b:	75 23                	jne    14000b0a0 <fn_decl__get_fn_local_offset_from_bp+0x1a9>
   14000b07d:	41 b8 f4 01 00 00    	mov    $0x1f4,%r8d
   14000b083:	48 8d 05 46 9e 00 00 	lea    0x9e46(%rip),%rax        # 140014ed0 <.rdata>
   14000b08a:	48 89 c2             	mov    %rax,%rdx
   14000b08d:	48 8d 05 4e 9f 00 00 	lea    0x9f4e(%rip),%rax        # 140014fe2 <.rdata+0x112>
   14000b094:	48 89 c1             	mov    %rax,%rcx
   14000b097:	48 8b 05 a2 02 01 00 	mov    0x102a2(%rip),%rax        # 14001b340 <__imp__assert>
   14000b09e:	ff d0                	call   *%rax
   14000b0a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000b0a4:	48 83 c4 60          	add    $0x60,%rsp
   14000b0a8:	5d                   	pop    %rbp
   14000b0a9:	c3                   	ret

000000014000b0aa <fn_decl__add_argument>:
   14000b0aa:	55                   	push   %rbp
   14000b0ab:	48 89 e5             	mov    %rsp,%rbp
   14000b0ae:	48 83 ec 20          	sub    $0x20,%rsp
   14000b0b2:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000b0b6:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000b0ba:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b0be:	8b 40 2c             	mov    0x2c(%rax),%eax
   14000b0c1:	85 c0                	test   %eax,%eax
   14000b0c3:	75 2d                	jne    14000b0f2 <fn_decl__add_argument+0x48>
   14000b0c5:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b0c9:	c7 40 2c 08 00 00 00 	movl   $0x8,0x2c(%rax)
   14000b0d0:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b0d4:	8b 40 2c             	mov    0x2c(%rax),%eax
   14000b0d7:	89 c0                	mov    %eax,%eax
   14000b0d9:	48 c1 e0 03          	shl    $0x3,%rax
   14000b0dd:	48 89 c1             	mov    %rax,%rcx
   14000b0e0:	e8 8b 69 00 00       	call   140011a70 <malloc>
   14000b0e5:	48 89 c2             	mov    %rax,%rdx
   14000b0e8:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b0ec:	48 89 50 20          	mov    %rdx,0x20(%rax)
   14000b0f0:	eb 4c                	jmp    14000b13e <fn_decl__add_argument+0x94>
   14000b0f2:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b0f6:	8b 50 28             	mov    0x28(%rax),%edx
   14000b0f9:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b0fd:	8b 40 2c             	mov    0x2c(%rax),%eax
   14000b100:	39 c2                	cmp    %eax,%edx
   14000b102:	75 3a                	jne    14000b13e <fn_decl__add_argument+0x94>
   14000b104:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b108:	8b 40 2c             	mov    0x2c(%rax),%eax
   14000b10b:	8d 14 00             	lea    (%rax,%rax,1),%edx
   14000b10e:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b112:	89 50 2c             	mov    %edx,0x2c(%rax)
   14000b115:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b119:	8b 40 2c             	mov    0x2c(%rax),%eax
   14000b11c:	89 c0                	mov    %eax,%eax
   14000b11e:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   14000b125:	00 
   14000b126:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b12a:	48 8b 40 20          	mov    0x20(%rax),%rax
   14000b12e:	48 89 c1             	mov    %rax,%rcx
   14000b131:	e8 62 69 00 00       	call   140011a98 <realloc>
   14000b136:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   14000b13a:	48 89 42 20          	mov    %rax,0x20(%rdx)
   14000b13e:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b142:	8b 50 28             	mov    0x28(%rax),%edx
   14000b145:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b149:	8b 40 2c             	mov    0x2c(%rax),%eax
   14000b14c:	39 c2                	cmp    %eax,%edx
   14000b14e:	75 23                	jne    14000b173 <fn_decl__add_argument+0xc9>
   14000b150:	41 b8 0a 02 00 00    	mov    $0x20a,%r8d
   14000b156:	48 8d 05 73 9d 00 00 	lea    0x9d73(%rip),%rax        # 140014ed0 <.rdata>
   14000b15d:	48 89 c2             	mov    %rax,%rdx
   14000b160:	48 8d 05 81 9e 00 00 	lea    0x9e81(%rip),%rax        # 140014fe8 <.rdata+0x118>
   14000b167:	48 89 c1             	mov    %rax,%rcx
   14000b16a:	48 8b 05 cf 01 01 00 	mov    0x101cf(%rip),%rax        # 14001b340 <__imp__assert>
   14000b171:	ff d0                	call   *%rax
   14000b173:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b177:	4c 8b 40 20          	mov    0x20(%rax),%r8
   14000b17b:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b17f:	8b 40 28             	mov    0x28(%rax),%eax
   14000b182:	8d 48 01             	lea    0x1(%rax),%ecx
   14000b185:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   14000b189:	89 4a 28             	mov    %ecx,0x28(%rdx)
   14000b18c:	89 c0                	mov    %eax,%eax
   14000b18e:	48 c1 e0 03          	shl    $0x3,%rax
   14000b192:	49 8d 14 00          	lea    (%r8,%rax,1),%rdx
   14000b196:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000b19a:	48 89 02             	mov    %rax,(%rdx)
   14000b19d:	90                   	nop
   14000b19e:	48 83 c4 20          	add    $0x20,%rsp
   14000b1a2:	5d                   	pop    %rbp
   14000b1a3:	c3                   	ret

000000014000b1a4 <fn_decl__add_local>:
   14000b1a4:	55                   	push   %rbp
   14000b1a5:	48 89 e5             	mov    %rsp,%rbp
   14000b1a8:	48 83 ec 30          	sub    $0x30,%rsp
   14000b1ac:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000b1b0:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000b1b4:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   14000b1b8:	ba 10 00 00 00       	mov    $0x10,%edx
   14000b1bd:	b9 01 00 00 00       	mov    $0x1,%ecx
   14000b1c2:	e8 69 68 00 00       	call   140011a30 <calloc>
   14000b1c7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000b1cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000b1cf:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   14000b1d3:	48 89 10             	mov    %rdx,(%rax)
   14000b1d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000b1da:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   14000b1de:	48 89 50 08          	mov    %rdx,0x8(%rax)
   14000b1e2:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b1e6:	8b 40 44             	mov    0x44(%rax),%eax
   14000b1e9:	85 c0                	test   %eax,%eax
   14000b1eb:	75 2d                	jne    14000b21a <fn_decl__add_local+0x76>
   14000b1ed:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b1f1:	c7 40 44 08 00 00 00 	movl   $0x8,0x44(%rax)
   14000b1f8:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b1fc:	8b 40 44             	mov    0x44(%rax),%eax
   14000b1ff:	89 c0                	mov    %eax,%eax
   14000b201:	48 c1 e0 03          	shl    $0x3,%rax
   14000b205:	48 89 c1             	mov    %rax,%rcx
   14000b208:	e8 63 68 00 00       	call   140011a70 <malloc>
   14000b20d:	48 89 c2             	mov    %rax,%rdx
   14000b210:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b214:	48 89 50 38          	mov    %rdx,0x38(%rax)
   14000b218:	eb 4c                	jmp    14000b266 <fn_decl__add_local+0xc2>
   14000b21a:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b21e:	8b 50 40             	mov    0x40(%rax),%edx
   14000b221:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b225:	8b 40 44             	mov    0x44(%rax),%eax
   14000b228:	39 c2                	cmp    %eax,%edx
   14000b22a:	75 3a                	jne    14000b266 <fn_decl__add_local+0xc2>
   14000b22c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b230:	8b 40 44             	mov    0x44(%rax),%eax
   14000b233:	8d 14 00             	lea    (%rax,%rax,1),%edx
   14000b236:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b23a:	89 50 44             	mov    %edx,0x44(%rax)
   14000b23d:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b241:	8b 40 44             	mov    0x44(%rax),%eax
   14000b244:	89 c0                	mov    %eax,%eax
   14000b246:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   14000b24d:	00 
   14000b24e:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b252:	48 8b 40 38          	mov    0x38(%rax),%rax
   14000b256:	48 89 c1             	mov    %rax,%rcx
   14000b259:	e8 3a 68 00 00       	call   140011a98 <realloc>
   14000b25e:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   14000b262:	48 89 42 38          	mov    %rax,0x38(%rdx)
   14000b266:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b26a:	8b 50 40             	mov    0x40(%rax),%edx
   14000b26d:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b271:	8b 40 44             	mov    0x44(%rax),%eax
   14000b274:	39 c2                	cmp    %eax,%edx
   14000b276:	75 23                	jne    14000b29b <fn_decl__add_local+0xf7>
   14000b278:	41 b8 1b 02 00 00    	mov    $0x21b,%r8d
   14000b27e:	48 8d 05 4b 9c 00 00 	lea    0x9c4b(%rip),%rax        # 140014ed0 <.rdata>
   14000b285:	48 89 c2             	mov    %rax,%rdx
   14000b288:	48 8d 05 89 9d 00 00 	lea    0x9d89(%rip),%rax        # 140015018 <.rdata+0x148>
   14000b28f:	48 89 c1             	mov    %rax,%rcx
   14000b292:	48 8b 05 a7 00 01 00 	mov    0x100a7(%rip),%rax        # 14001b340 <__imp__assert>
   14000b299:	ff d0                	call   *%rax
   14000b29b:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b29f:	4c 8b 40 38          	mov    0x38(%rax),%r8
   14000b2a3:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b2a7:	8b 40 40             	mov    0x40(%rax),%eax
   14000b2aa:	8d 48 01             	lea    0x1(%rax),%ecx
   14000b2ad:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   14000b2b1:	89 4a 40             	mov    %ecx,0x40(%rdx)
   14000b2b4:	89 c0                	mov    %eax,%eax
   14000b2b6:	48 c1 e0 03          	shl    $0x3,%rax
   14000b2ba:	49 8d 14 00          	lea    (%r8,%rax,1),%rdx
   14000b2be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000b2c2:	48 89 02             	mov    %rax,(%rdx)
   14000b2c5:	90                   	nop
   14000b2c6:	48 83 c4 30          	add    $0x30,%rsp
   14000b2ca:	5d                   	pop    %rbp
   14000b2cb:	c3                   	ret

000000014000b2cc <fn_decl__size_of_arg>:
   14000b2cc:	55                   	push   %rbp
   14000b2cd:	48 89 e5             	mov    %rsp,%rbp
   14000b2d0:	48 83 ec 50          	sub    $0x50,%rsp
   14000b2d4:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000b2d8:	89 55 18             	mov    %edx,0x18(%rbp)
   14000b2db:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   14000b2df:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b2e3:	8b 40 28             	mov    0x28(%rax),%eax
   14000b2e6:	39 45 18             	cmp    %eax,0x18(%rbp)
   14000b2e9:	72 23                	jb     14000b30e <fn_decl__size_of_arg+0x42>
   14000b2eb:	41 b8 20 02 00 00    	mov    $0x220,%r8d
   14000b2f1:	48 8d 05 d8 9b 00 00 	lea    0x9bd8(%rip),%rax        # 140014ed0 <.rdata>
   14000b2f8:	48 89 c2             	mov    %rax,%rdx
   14000b2fb:	48 8d 05 3e 9d 00 00 	lea    0x9d3e(%rip),%rax        # 140015040 <.rdata+0x170>
   14000b302:	48 89 c1             	mov    %rax,%rcx
   14000b305:	48 8b 05 34 00 01 00 	mov    0x10034(%rip),%rax        # 14001b340 <__imp__assert>
   14000b30c:	ff d0                	call   *%rax
   14000b30e:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b312:	48 8b 40 20          	mov    0x20(%rax),%rax
   14000b316:	8b 55 18             	mov    0x18(%rbp),%edx
   14000b319:	48 c1 e2 03          	shl    $0x3,%rdx
   14000b31d:	48 01 d0             	add    %rdx,%rax
   14000b320:	48 8b 00             	mov    (%rax),%rax
   14000b323:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000b327:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b32b:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000b32f:	48 89 55 20          	mov    %rdx,0x20(%rbp)
   14000b333:	48 8b 00             	mov    (%rax),%rax
   14000b336:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000b33a:	e9 9b 00 00 00       	jmp    14000b3da <fn_decl__size_of_arg+0x10e>
   14000b33f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   14000b343:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000b347:	48 89 c1             	mov    %rax,%rcx
   14000b34a:	e8 51 78 ff ff       	call   140002ba0 <type__member>
   14000b34f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000b353:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   14000b358:	74 4a                	je     14000b3a4 <fn_decl__size_of_arg+0xd8>
   14000b35a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000b35e:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000b362:	8b 00                	mov    (%rax),%eax
   14000b364:	83 f8 03             	cmp    $0x3,%eax
   14000b367:	75 2d                	jne    14000b396 <fn_decl__size_of_arg+0xca>
   14000b369:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b36d:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000b371:	48 89 55 20          	mov    %rdx,0x20(%rbp)
   14000b375:	48 8b 00             	mov    (%rax),%rax
   14000b378:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   14000b37c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000b380:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000b384:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   14000b388:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14000b38c:	48 8b 40 30          	mov    0x30(%rax),%rax
   14000b390:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000b394:	eb 31                	jmp    14000b3c7 <fn_decl__size_of_arg+0xfb>
   14000b396:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000b39a:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000b39e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000b3a2:	eb 23                	jmp    14000b3c7 <fn_decl__size_of_arg+0xfb>
   14000b3a4:	41 b8 30 02 00 00    	mov    $0x230,%r8d
   14000b3aa:	48 8d 05 1f 9b 00 00 	lea    0x9b1f(%rip),%rax        # 140014ed0 <.rdata>
   14000b3b1:	48 89 c2             	mov    %rax,%rdx
   14000b3b4:	48 8d 05 40 9b 00 00 	lea    0x9b40(%rip),%rax        # 140014efb <.rdata+0x2b>
   14000b3bb:	48 89 c1             	mov    %rax,%rcx
   14000b3be:	48 8b 05 7b ff 00 00 	mov    0xff7b(%rip),%rax        # 14001b340 <__imp__assert>
   14000b3c5:	ff d0                	call   *%rax
   14000b3c7:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b3cb:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000b3cf:	48 89 55 20          	mov    %rdx,0x20(%rbp)
   14000b3d3:	48 8b 00             	mov    (%rax),%rax
   14000b3d6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000b3da:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   14000b3df:	0f 85 5a ff ff ff    	jne    14000b33f <fn_decl__size_of_arg+0x73>
   14000b3e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000b3e9:	48 89 c1             	mov    %rax,%rcx
   14000b3ec:	e8 7a 6d ff ff       	call   14000216b <type__size>
   14000b3f1:	48 83 c4 50          	add    $0x50,%rsp
   14000b3f5:	5d                   	pop    %rbp
   14000b3f6:	c3                   	ret

000000014000b3f7 <fn_decl__size_of_ret>:
   14000b3f7:	55                   	push   %rbp
   14000b3f8:	48 89 e5             	mov    %rsp,%rbp
   14000b3fb:	48 83 ec 50          	sub    $0x50,%rsp
   14000b3ff:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000b403:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000b407:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b40b:	48 8b 40 18          	mov    0x18(%rax),%rax
   14000b40f:	48 85 c0             	test   %rax,%rax
   14000b412:	75 23                	jne    14000b437 <fn_decl__size_of_ret+0x40>
   14000b414:	41 b8 39 02 00 00    	mov    $0x239,%r8d
   14000b41a:	48 8d 05 af 9a 00 00 	lea    0x9aaf(%rip),%rax        # 140014ed0 <.rdata>
   14000b421:	48 89 c2             	mov    %rax,%rdx
   14000b424:	48 8d 05 a5 9b 00 00 	lea    0x9ba5(%rip),%rax        # 140014fd0 <.rdata+0x100>
   14000b42b:	48 89 c1             	mov    %rax,%rcx
   14000b42e:	48 8b 05 0b ff 00 00 	mov    0xff0b(%rip),%rax        # 14001b340 <__imp__assert>
   14000b435:	ff d0                	call   *%rax
   14000b437:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b43b:	48 8b 40 18          	mov    0x18(%rax),%rax
   14000b43f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000b443:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000b447:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000b44b:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000b44f:	48 8b 00             	mov    (%rax),%rax
   14000b452:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000b456:	e9 9b 00 00 00       	jmp    14000b4f6 <fn_decl__size_of_ret+0xff>
   14000b45b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   14000b45f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000b463:	48 89 c1             	mov    %rax,%rcx
   14000b466:	e8 35 77 ff ff       	call   140002ba0 <type__member>
   14000b46b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000b46f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   14000b474:	74 4a                	je     14000b4c0 <fn_decl__size_of_ret+0xc9>
   14000b476:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000b47a:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000b47e:	8b 00                	mov    (%rax),%eax
   14000b480:	83 f8 03             	cmp    $0x3,%eax
   14000b483:	75 2d                	jne    14000b4b2 <fn_decl__size_of_ret+0xbb>
   14000b485:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000b489:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000b48d:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000b491:	48 8b 00             	mov    (%rax),%rax
   14000b494:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   14000b498:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000b49c:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000b4a0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   14000b4a4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14000b4a8:	48 8b 40 30          	mov    0x30(%rax),%rax
   14000b4ac:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000b4b0:	eb 31                	jmp    14000b4e3 <fn_decl__size_of_ret+0xec>
   14000b4b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000b4b6:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000b4ba:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000b4be:	eb 23                	jmp    14000b4e3 <fn_decl__size_of_ret+0xec>
   14000b4c0:	41 b8 49 02 00 00    	mov    $0x249,%r8d
   14000b4c6:	48 8d 05 03 9a 00 00 	lea    0x9a03(%rip),%rax        # 140014ed0 <.rdata>
   14000b4cd:	48 89 c2             	mov    %rax,%rdx
   14000b4d0:	48 8d 05 24 9a 00 00 	lea    0x9a24(%rip),%rax        # 140014efb <.rdata+0x2b>
   14000b4d7:	48 89 c1             	mov    %rax,%rcx
   14000b4da:	48 8b 05 5f fe 00 00 	mov    0xfe5f(%rip),%rax        # 14001b340 <__imp__assert>
   14000b4e1:	ff d0                	call   *%rax
   14000b4e3:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000b4e7:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000b4eb:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000b4ef:	48 8b 00             	mov    (%rax),%rax
   14000b4f2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000b4f6:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   14000b4fb:	0f 85 5a ff ff ff    	jne    14000b45b <fn_decl__size_of_ret+0x64>
   14000b501:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000b505:	48 89 c1             	mov    %rax,%rcx
   14000b508:	e8 5e 6c ff ff       	call   14000216b <type__size>
   14000b50d:	48 83 c4 50          	add    $0x50,%rsp
   14000b511:	5d                   	pop    %rbp
   14000b512:	c3                   	ret

000000014000b513 <fn_decl__size_of_local>:
   14000b513:	55                   	push   %rbp
   14000b514:	48 89 e5             	mov    %rsp,%rbp
   14000b517:	48 83 ec 60          	sub    $0x60,%rsp
   14000b51b:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000b51f:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000b523:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   14000b527:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   14000b52e:	e9 10 01 00 00       	jmp    14000b643 <fn_decl__size_of_local+0x130>
   14000b533:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b537:	48 8b 40 38          	mov    0x38(%rax),%rax
   14000b53b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   14000b53e:	48 c1 e2 03          	shl    $0x3,%rdx
   14000b542:	48 01 d0             	add    %rdx,%rax
   14000b545:	48 8b 00             	mov    (%rax),%rax
   14000b548:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   14000b54c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   14000b550:	48 8b 10             	mov    (%rax),%rdx
   14000b553:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000b557:	48 89 c1             	mov    %rax,%rcx
   14000b55a:	e8 49 65 00 00       	call   140011aa8 <strcmp>
   14000b55f:	85 c0                	test   %eax,%eax
   14000b561:	0f 85 d8 00 00 00    	jne    14000b63f <fn_decl__size_of_local+0x12c>
   14000b567:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   14000b56b:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000b56f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000b573:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b577:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000b57b:	48 89 55 20          	mov    %rdx,0x20(%rbp)
   14000b57f:	48 8b 00             	mov    (%rax),%rax
   14000b582:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000b586:	e9 9b 00 00 00       	jmp    14000b626 <fn_decl__size_of_local+0x113>
   14000b58b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   14000b58f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000b593:	48 89 c1             	mov    %rax,%rcx
   14000b596:	e8 05 76 ff ff       	call   140002ba0 <type__member>
   14000b59b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   14000b59f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   14000b5a4:	74 4a                	je     14000b5f0 <fn_decl__size_of_local+0xdd>
   14000b5a6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14000b5aa:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000b5ae:	8b 00                	mov    (%rax),%eax
   14000b5b0:	83 f8 03             	cmp    $0x3,%eax
   14000b5b3:	75 2d                	jne    14000b5e2 <fn_decl__size_of_local+0xcf>
   14000b5b5:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b5b9:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000b5bd:	48 89 55 20          	mov    %rdx,0x20(%rbp)
   14000b5c1:	48 8b 00             	mov    (%rax),%rax
   14000b5c4:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   14000b5c8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14000b5cc:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000b5d0:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   14000b5d4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   14000b5d8:	48 8b 40 30          	mov    0x30(%rax),%rax
   14000b5dc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000b5e0:	eb 31                	jmp    14000b613 <fn_decl__size_of_local+0x100>
   14000b5e2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14000b5e6:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000b5ea:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000b5ee:	eb 23                	jmp    14000b613 <fn_decl__size_of_local+0x100>
   14000b5f0:	41 b8 63 02 00 00    	mov    $0x263,%r8d
   14000b5f6:	48 8d 05 d3 98 00 00 	lea    0x98d3(%rip),%rax        # 140014ed0 <.rdata>
   14000b5fd:	48 89 c2             	mov    %rax,%rdx
   14000b600:	48 8d 05 f4 98 00 00 	lea    0x98f4(%rip),%rax        # 140014efb <.rdata+0x2b>
   14000b607:	48 89 c1             	mov    %rax,%rcx
   14000b60a:	48 8b 05 2f fd 00 00 	mov    0xfd2f(%rip),%rax        # 14001b340 <__imp__assert>
   14000b611:	ff d0                	call   *%rax
   14000b613:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b617:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000b61b:	48 89 55 20          	mov    %rdx,0x20(%rbp)
   14000b61f:	48 8b 00             	mov    (%rax),%rax
   14000b622:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000b626:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   14000b62b:	0f 85 5a ff ff ff    	jne    14000b58b <fn_decl__size_of_local+0x78>
   14000b631:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000b635:	48 89 c1             	mov    %rax,%rcx
   14000b638:	e8 2e 6b ff ff       	call   14000216b <type__size>
   14000b63d:	eb 37                	jmp    14000b676 <fn_decl__size_of_local+0x163>
   14000b63f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   14000b643:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000b647:	8b 40 40             	mov    0x40(%rax),%eax
   14000b64a:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   14000b64d:	0f 82 e0 fe ff ff    	jb     14000b533 <fn_decl__size_of_local+0x20>
   14000b653:	41 b8 6b 02 00 00    	mov    $0x26b,%r8d
   14000b659:	48 8d 05 70 98 00 00 	lea    0x9870(%rip),%rax        # 140014ed0 <.rdata>
   14000b660:	48 89 c2             	mov    %rax,%rdx
   14000b663:	48 8d 05 91 98 00 00 	lea    0x9891(%rip),%rax        # 140014efb <.rdata+0x2b>
   14000b66a:	48 89 c1             	mov    %rax,%rcx
   14000b66d:	48 8b 05 cc fc 00 00 	mov    0xfccc(%rip),%rax        # 14001b340 <__imp__assert>
   14000b674:	ff d0                	call   *%rax
   14000b676:	48 83 c4 60          	add    $0x60,%rsp
   14000b67a:	5d                   	pop    %rbp
   14000b67b:	c3                   	ret

000000014000b67c <compile__store_argument>:
   14000b67c:	55                   	push   %rbp
   14000b67d:	57                   	push   %rdi
   14000b67e:	56                   	push   %rsi
   14000b67f:	48 83 ec 40          	sub    $0x40,%rsp
   14000b683:	48 8d 6c 24 40       	lea    0x40(%rsp),%rbp
   14000b688:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   14000b68c:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   14000b690:	4c 89 45 30          	mov    %r8,0x30(%rbp)
   14000b694:	44 89 4d 38          	mov    %r9d,0x38(%rbp)
   14000b698:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000b69c:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b6a0:	41 b8 04 00 00 00    	mov    $0x4,%r8d
   14000b6a6:	48 89 c1             	mov    %rax,%rcx
   14000b6a9:	e8 e5 f1 ff ff       	call   14000a893 <state__add_ins>
   14000b6ae:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000b6b2:	48 8d 45 40          	lea    0x40(%rbp),%rax
   14000b6b6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000b6ba:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
   14000b6be:	8b 55 38             	mov    0x38(%rbp),%edx
   14000b6c1:	48 8b 45 28          	mov    0x28(%rbp),%rax
   14000b6c5:	49 89 c8             	mov    %rcx,%r8
   14000b6c8:	48 89 c1             	mov    %rax,%rcx
   14000b6cb:	e8 7a f6 ff ff       	call   14000ad4a <fn_decl__get_fn_arg_offset_from_bp>
   14000b6d0:	48 89 c6             	mov    %rax,%rsi
   14000b6d3:	bf 00 00 00 00       	mov    $0x0,%edi
   14000b6d8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   14000b6dc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   14000b6e0:	48 8d 4d e0          	lea    -0x20(%rbp),%rcx
   14000b6e4:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000b6e8:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b6ec:	49 89 c9             	mov    %rcx,%r9
   14000b6ef:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   14000b6f5:	48 89 c1             	mov    %rax,%rcx
   14000b6f8:	e8 96 f1 ff ff       	call   14000a893 <state__add_ins>
   14000b6fd:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000b701:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000b705:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b709:	41 b8 0c 00 00 00    	mov    $0xc,%r8d
   14000b70f:	48 89 c1             	mov    %rax,%rcx
   14000b712:	e8 7c f1 ff ff       	call   14000a893 <state__add_ins>
   14000b717:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000b71b:	48 8d 45 40          	lea    0x40(%rbp),%rax
   14000b71f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000b723:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
   14000b727:	8b 55 38             	mov    0x38(%rbp),%edx
   14000b72a:	48 8b 45 28          	mov    0x28(%rbp),%rax
   14000b72e:	49 89 c8             	mov    %rcx,%r8
   14000b731:	48 89 c1             	mov    %rax,%rcx
   14000b734:	e8 93 fb ff ff       	call   14000b2cc <fn_decl__size_of_arg>
   14000b739:	48 89 c1             	mov    %rax,%rcx
   14000b73c:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000b740:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b744:	49 89 c9             	mov    %rcx,%r9
   14000b747:	41 b8 2e 00 00 00    	mov    $0x2e,%r8d
   14000b74d:	48 89 c1             	mov    %rax,%rcx
   14000b750:	e8 3e f1 ff ff       	call   14000a893 <state__add_ins>
   14000b755:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000b759:	90                   	nop
   14000b75a:	48 83 c4 40          	add    $0x40,%rsp
   14000b75e:	5e                   	pop    %rsi
   14000b75f:	5f                   	pop    %rdi
   14000b760:	5d                   	pop    %rbp
   14000b761:	c3                   	ret

000000014000b762 <compile__load_argument>:
   14000b762:	55                   	push   %rbp
   14000b763:	57                   	push   %rdi
   14000b764:	56                   	push   %rsi
   14000b765:	48 83 ec 40          	sub    $0x40,%rsp
   14000b769:	48 8d 6c 24 40       	lea    0x40(%rsp),%rbp
   14000b76e:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   14000b772:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   14000b776:	4c 89 45 30          	mov    %r8,0x30(%rbp)
   14000b77a:	44 89 4d 38          	mov    %r9d,0x38(%rbp)
   14000b77e:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000b782:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b786:	41 b8 04 00 00 00    	mov    $0x4,%r8d
   14000b78c:	48 89 c1             	mov    %rax,%rcx
   14000b78f:	e8 ff f0 ff ff       	call   14000a893 <state__add_ins>
   14000b794:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000b798:	48 8d 45 40          	lea    0x40(%rbp),%rax
   14000b79c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000b7a0:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
   14000b7a4:	8b 55 38             	mov    0x38(%rbp),%edx
   14000b7a7:	48 8b 45 28          	mov    0x28(%rbp),%rax
   14000b7ab:	49 89 c8             	mov    %rcx,%r8
   14000b7ae:	48 89 c1             	mov    %rax,%rcx
   14000b7b1:	e8 94 f5 ff ff       	call   14000ad4a <fn_decl__get_fn_arg_offset_from_bp>
   14000b7b6:	48 89 c6             	mov    %rax,%rsi
   14000b7b9:	bf 00 00 00 00       	mov    $0x0,%edi
   14000b7be:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   14000b7c2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   14000b7c6:	48 8d 4d e0          	lea    -0x20(%rbp),%rcx
   14000b7ca:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000b7ce:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b7d2:	49 89 c9             	mov    %rcx,%r9
   14000b7d5:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   14000b7db:	48 89 c1             	mov    %rax,%rcx
   14000b7de:	e8 b0 f0 ff ff       	call   14000a893 <state__add_ins>
   14000b7e3:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000b7e7:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000b7eb:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b7ef:	41 b8 0c 00 00 00    	mov    $0xc,%r8d
   14000b7f5:	48 89 c1             	mov    %rax,%rcx
   14000b7f8:	e8 96 f0 ff ff       	call   14000a893 <state__add_ins>
   14000b7fd:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000b801:	48 8d 45 40          	lea    0x40(%rbp),%rax
   14000b805:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000b809:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
   14000b80d:	8b 55 38             	mov    0x38(%rbp),%edx
   14000b810:	48 8b 45 28          	mov    0x28(%rbp),%rax
   14000b814:	49 89 c8             	mov    %rcx,%r8
   14000b817:	48 89 c1             	mov    %rax,%rcx
   14000b81a:	e8 ad fa ff ff       	call   14000b2cc <fn_decl__size_of_arg>
   14000b81f:	48 89 c1             	mov    %rax,%rcx
   14000b822:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000b826:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b82a:	49 89 c9             	mov    %rcx,%r9
   14000b82d:	41 b8 2d 00 00 00    	mov    $0x2d,%r8d
   14000b833:	48 89 c1             	mov    %rax,%rcx
   14000b836:	e8 58 f0 ff ff       	call   14000a893 <state__add_ins>
   14000b83b:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000b83f:	90                   	nop
   14000b840:	48 83 c4 40          	add    $0x40,%rsp
   14000b844:	5e                   	pop    %rsi
   14000b845:	5f                   	pop    %rdi
   14000b846:	5d                   	pop    %rbp
   14000b847:	c3                   	ret

000000014000b848 <compile__store_return>:
   14000b848:	55                   	push   %rbp
   14000b849:	57                   	push   %rdi
   14000b84a:	56                   	push   %rsi
   14000b84b:	48 83 ec 40          	sub    $0x40,%rsp
   14000b84f:	48 8d 6c 24 40       	lea    0x40(%rsp),%rbp
   14000b854:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   14000b858:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   14000b85c:	4c 89 45 30          	mov    %r8,0x30(%rbp)
   14000b860:	4c 89 4d 38          	mov    %r9,0x38(%rbp)
   14000b864:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000b868:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b86c:	41 b8 04 00 00 00    	mov    $0x4,%r8d
   14000b872:	48 89 c1             	mov    %rax,%rcx
   14000b875:	e8 19 f0 ff ff       	call   14000a893 <state__add_ins>
   14000b87a:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000b87e:	48 8d 45 38          	lea    0x38(%rbp),%rax
   14000b882:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000b886:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   14000b88a:	48 8b 45 28          	mov    0x28(%rbp),%rax
   14000b88e:	48 89 c1             	mov    %rax,%rcx
   14000b891:	e8 03 f3 ff ff       	call   14000ab99 <fn_decl__get_fn_return_offset_from_bp>
   14000b896:	48 89 c6             	mov    %rax,%rsi
   14000b899:	bf 00 00 00 00       	mov    $0x0,%edi
   14000b89e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   14000b8a2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   14000b8a6:	48 8d 4d e0          	lea    -0x20(%rbp),%rcx
   14000b8aa:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000b8ae:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b8b2:	49 89 c9             	mov    %rcx,%r9
   14000b8b5:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   14000b8bb:	48 89 c1             	mov    %rax,%rcx
   14000b8be:	e8 d0 ef ff ff       	call   14000a893 <state__add_ins>
   14000b8c3:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000b8c7:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000b8cb:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b8cf:	41 b8 0c 00 00 00    	mov    $0xc,%r8d
   14000b8d5:	48 89 c1             	mov    %rax,%rcx
   14000b8d8:	e8 b6 ef ff ff       	call   14000a893 <state__add_ins>
   14000b8dd:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000b8e1:	48 8d 45 38          	lea    0x38(%rbp),%rax
   14000b8e5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000b8e9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   14000b8ed:	48 8b 45 28          	mov    0x28(%rbp),%rax
   14000b8f1:	48 89 c1             	mov    %rax,%rcx
   14000b8f4:	e8 fe fa ff ff       	call   14000b3f7 <fn_decl__size_of_ret>
   14000b8f9:	48 89 c1             	mov    %rax,%rcx
   14000b8fc:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000b900:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b904:	49 89 c9             	mov    %rcx,%r9
   14000b907:	41 b8 2e 00 00 00    	mov    $0x2e,%r8d
   14000b90d:	48 89 c1             	mov    %rax,%rcx
   14000b910:	e8 7e ef ff ff       	call   14000a893 <state__add_ins>
   14000b915:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000b919:	90                   	nop
   14000b91a:	48 83 c4 40          	add    $0x40,%rsp
   14000b91e:	5e                   	pop    %rsi
   14000b91f:	5f                   	pop    %rdi
   14000b920:	5d                   	pop    %rbp
   14000b921:	c3                   	ret

000000014000b922 <compile__load_return>:
   14000b922:	55                   	push   %rbp
   14000b923:	57                   	push   %rdi
   14000b924:	56                   	push   %rsi
   14000b925:	48 83 ec 40          	sub    $0x40,%rsp
   14000b929:	48 8d 6c 24 40       	lea    0x40(%rsp),%rbp
   14000b92e:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   14000b932:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   14000b936:	4c 89 45 30          	mov    %r8,0x30(%rbp)
   14000b93a:	4c 89 4d 38          	mov    %r9,0x38(%rbp)
   14000b93e:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000b942:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b946:	41 b8 04 00 00 00    	mov    $0x4,%r8d
   14000b94c:	48 89 c1             	mov    %rax,%rcx
   14000b94f:	e8 3f ef ff ff       	call   14000a893 <state__add_ins>
   14000b954:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000b958:	48 8d 45 38          	lea    0x38(%rbp),%rax
   14000b95c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000b960:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   14000b964:	48 8b 45 28          	mov    0x28(%rbp),%rax
   14000b968:	48 89 c1             	mov    %rax,%rcx
   14000b96b:	e8 29 f2 ff ff       	call   14000ab99 <fn_decl__get_fn_return_offset_from_bp>
   14000b970:	48 89 c6             	mov    %rax,%rsi
   14000b973:	bf 00 00 00 00       	mov    $0x0,%edi
   14000b978:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   14000b97c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   14000b980:	48 8d 4d e0          	lea    -0x20(%rbp),%rcx
   14000b984:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000b988:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b98c:	49 89 c9             	mov    %rcx,%r9
   14000b98f:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   14000b995:	48 89 c1             	mov    %rax,%rcx
   14000b998:	e8 f6 ee ff ff       	call   14000a893 <state__add_ins>
   14000b99d:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000b9a1:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000b9a5:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b9a9:	41 b8 0c 00 00 00    	mov    $0xc,%r8d
   14000b9af:	48 89 c1             	mov    %rax,%rcx
   14000b9b2:	e8 dc ee ff ff       	call   14000a893 <state__add_ins>
   14000b9b7:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000b9bb:	48 8d 45 38          	lea    0x38(%rbp),%rax
   14000b9bf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000b9c3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   14000b9c7:	48 8b 45 28          	mov    0x28(%rbp),%rax
   14000b9cb:	48 89 c1             	mov    %rax,%rcx
   14000b9ce:	e8 24 fa ff ff       	call   14000b3f7 <fn_decl__size_of_ret>
   14000b9d3:	48 89 c1             	mov    %rax,%rcx
   14000b9d6:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000b9da:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000b9de:	49 89 c9             	mov    %rcx,%r9
   14000b9e1:	41 b8 2d 00 00 00    	mov    $0x2d,%r8d
   14000b9e7:	48 89 c1             	mov    %rax,%rcx
   14000b9ea:	e8 a4 ee ff ff       	call   14000a893 <state__add_ins>
   14000b9ef:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000b9f3:	90                   	nop
   14000b9f4:	48 83 c4 40          	add    $0x40,%rsp
   14000b9f8:	5e                   	pop    %rsi
   14000b9f9:	5f                   	pop    %rdi
   14000b9fa:	5d                   	pop    %rbp
   14000b9fb:	c3                   	ret

000000014000b9fc <compile__load_local>:
   14000b9fc:	55                   	push   %rbp
   14000b9fd:	57                   	push   %rdi
   14000b9fe:	56                   	push   %rsi
   14000b9ff:	48 83 ec 40          	sub    $0x40,%rsp
   14000ba03:	48 8d 6c 24 40       	lea    0x40(%rsp),%rbp
   14000ba08:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   14000ba0c:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   14000ba10:	4c 89 45 30          	mov    %r8,0x30(%rbp)
   14000ba14:	4c 89 4d 38          	mov    %r9,0x38(%rbp)
   14000ba18:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000ba1c:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000ba20:	41 b8 04 00 00 00    	mov    $0x4,%r8d
   14000ba26:	48 89 c1             	mov    %rax,%rcx
   14000ba29:	e8 65 ee ff ff       	call   14000a893 <state__add_ins>
   14000ba2e:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000ba32:	48 8d 45 40          	lea    0x40(%rbp),%rax
   14000ba36:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000ba3a:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
   14000ba3e:	48 8b 55 38          	mov    0x38(%rbp),%rdx
   14000ba42:	48 8b 45 28          	mov    0x28(%rbp),%rax
   14000ba46:	49 89 c8             	mov    %rcx,%r8
   14000ba49:	48 89 c1             	mov    %rax,%rcx
   14000ba4c:	e8 a6 f4 ff ff       	call   14000aef7 <fn_decl__get_fn_local_offset_from_bp>
   14000ba51:	48 89 c6             	mov    %rax,%rsi
   14000ba54:	bf 00 00 00 00       	mov    $0x0,%edi
   14000ba59:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   14000ba5d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   14000ba61:	48 8d 4d e0          	lea    -0x20(%rbp),%rcx
   14000ba65:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000ba69:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000ba6d:	49 89 c9             	mov    %rcx,%r9
   14000ba70:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   14000ba76:	48 89 c1             	mov    %rax,%rcx
   14000ba79:	e8 15 ee ff ff       	call   14000a893 <state__add_ins>
   14000ba7e:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000ba82:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000ba86:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000ba8a:	41 b8 0c 00 00 00    	mov    $0xc,%r8d
   14000ba90:	48 89 c1             	mov    %rax,%rcx
   14000ba93:	e8 fb ed ff ff       	call   14000a893 <state__add_ins>
   14000ba98:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000ba9c:	48 8d 45 40          	lea    0x40(%rbp),%rax
   14000baa0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000baa4:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
   14000baa8:	48 8b 55 38          	mov    0x38(%rbp),%rdx
   14000baac:	48 8b 45 28          	mov    0x28(%rbp),%rax
   14000bab0:	49 89 c8             	mov    %rcx,%r8
   14000bab3:	48 89 c1             	mov    %rax,%rcx
   14000bab6:	e8 58 fa ff ff       	call   14000b513 <fn_decl__size_of_local>
   14000babb:	48 89 c1             	mov    %rax,%rcx
   14000babe:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000bac2:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000bac6:	49 89 c9             	mov    %rcx,%r9
   14000bac9:	41 b8 2d 00 00 00    	mov    $0x2d,%r8d
   14000bacf:	48 89 c1             	mov    %rax,%rcx
   14000bad2:	e8 bc ed ff ff       	call   14000a893 <state__add_ins>
   14000bad7:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000badb:	90                   	nop
   14000badc:	48 83 c4 40          	add    $0x40,%rsp
   14000bae0:	5e                   	pop    %rsi
   14000bae1:	5f                   	pop    %rdi
   14000bae2:	5d                   	pop    %rbp
   14000bae3:	c3                   	ret

000000014000bae4 <compile__store_local>:
   14000bae4:	55                   	push   %rbp
   14000bae5:	57                   	push   %rdi
   14000bae6:	56                   	push   %rsi
   14000bae7:	48 83 ec 40          	sub    $0x40,%rsp
   14000baeb:	48 8d 6c 24 40       	lea    0x40(%rsp),%rbp
   14000baf0:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   14000baf4:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   14000baf8:	4c 89 45 30          	mov    %r8,0x30(%rbp)
   14000bafc:	4c 89 4d 38          	mov    %r9,0x38(%rbp)
   14000bb00:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000bb04:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000bb08:	41 b8 04 00 00 00    	mov    $0x4,%r8d
   14000bb0e:	48 89 c1             	mov    %rax,%rcx
   14000bb11:	e8 7d ed ff ff       	call   14000a893 <state__add_ins>
   14000bb16:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000bb1a:	48 8d 45 40          	lea    0x40(%rbp),%rax
   14000bb1e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000bb22:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
   14000bb26:	48 8b 55 38          	mov    0x38(%rbp),%rdx
   14000bb2a:	48 8b 45 28          	mov    0x28(%rbp),%rax
   14000bb2e:	49 89 c8             	mov    %rcx,%r8
   14000bb31:	48 89 c1             	mov    %rax,%rcx
   14000bb34:	e8 be f3 ff ff       	call   14000aef7 <fn_decl__get_fn_local_offset_from_bp>
   14000bb39:	48 89 c6             	mov    %rax,%rsi
   14000bb3c:	bf 00 00 00 00       	mov    $0x0,%edi
   14000bb41:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   14000bb45:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   14000bb49:	48 8d 4d e0          	lea    -0x20(%rbp),%rcx
   14000bb4d:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000bb51:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000bb55:	49 89 c9             	mov    %rcx,%r9
   14000bb58:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   14000bb5e:	48 89 c1             	mov    %rax,%rcx
   14000bb61:	e8 2d ed ff ff       	call   14000a893 <state__add_ins>
   14000bb66:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000bb6a:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000bb6e:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000bb72:	41 b8 0c 00 00 00    	mov    $0xc,%r8d
   14000bb78:	48 89 c1             	mov    %rax,%rcx
   14000bb7b:	e8 13 ed ff ff       	call   14000a893 <state__add_ins>
   14000bb80:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000bb84:	48 8d 45 40          	lea    0x40(%rbp),%rax
   14000bb88:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000bb8c:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
   14000bb90:	48 8b 55 38          	mov    0x38(%rbp),%rdx
   14000bb94:	48 8b 45 28          	mov    0x28(%rbp),%rax
   14000bb98:	49 89 c8             	mov    %rcx,%r8
   14000bb9b:	48 89 c1             	mov    %rax,%rcx
   14000bb9e:	e8 70 f9 ff ff       	call   14000b513 <fn_decl__size_of_local>
   14000bba3:	48 89 c1             	mov    %rax,%rcx
   14000bba6:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000bbaa:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000bbae:	49 89 c9             	mov    %rcx,%r9
   14000bbb1:	41 b8 2e 00 00 00    	mov    $0x2e,%r8d
   14000bbb7:	48 89 c1             	mov    %rax,%rcx
   14000bbba:	e8 d4 ec ff ff       	call   14000a893 <state__add_ins>
   14000bbbf:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000bbc3:	90                   	nop
   14000bbc4:	48 83 c4 40          	add    $0x40,%rsp
   14000bbc8:	5e                   	pop    %rsi
   14000bbc9:	5f                   	pop    %rdi
   14000bbca:	5d                   	pop    %rbp
   14000bbcb:	c3                   	ret

000000014000bbcc <state__compile_fact_fn>:
   14000bbcc:	55                   	push   %rbp
   14000bbcd:	57                   	push   %rdi
   14000bbce:	56                   	push   %rsi
   14000bbcf:	48 83 ec 60          	sub    $0x60,%rsp
   14000bbd3:	48 8d 6c 24 60       	lea    0x60(%rsp),%rbp
   14000bbd8:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   14000bbdc:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   14000bbe0:	4c 89 45 30          	mov    %r8,0x30(%rbp)
   14000bbe4:	41 ba 01 00 00 00    	mov    $0x1,%r10d
   14000bbea:	41 bb 00 00 00 00    	mov    $0x0,%r11d
   14000bbf0:	4c 89 55 d0          	mov    %r10,-0x30(%rbp)
   14000bbf4:	4c 89 5d d8          	mov    %r11,-0x28(%rbp)
   14000bbf8:	48 8d 4d d0          	lea    -0x30(%rbp),%rcx
   14000bbfc:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000bc00:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000bc04:	49 89 c9             	mov    %rcx,%r9
   14000bc07:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   14000bc0d:	48 89 c1             	mov    %rax,%rcx
   14000bc10:	e8 7e ec ff ff       	call   14000a893 <state__add_ins>
   14000bc15:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000bc19:	48 8b 4d 30          	mov    0x30(%rbp),%rcx
   14000bc1d:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   14000bc21:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000bc25:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000bc2b:	49 89 c8             	mov    %rcx,%r8
   14000bc2e:	48 89 c1             	mov    %rax,%rcx
   14000bc31:	e8 12 fc ff ff       	call   14000b848 <compile__store_return>
   14000bc36:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000bc3a:	48 8b 4d 30          	mov    0x30(%rbp),%rcx
   14000bc3e:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   14000bc42:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000bc46:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000bc4d:	00 00 
   14000bc4f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000bc55:	49 89 c8             	mov    %rcx,%r8
   14000bc58:	48 89 c1             	mov    %rax,%rcx
   14000bc5b:	e8 02 fb ff ff       	call   14000b762 <compile__load_argument>
   14000bc60:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000bc64:	be 01 00 00 00       	mov    $0x1,%esi
   14000bc69:	bf 00 00 00 00       	mov    $0x0,%edi
   14000bc6e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   14000bc72:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   14000bc76:	48 8d 4d d0          	lea    -0x30(%rbp),%rcx
   14000bc7a:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000bc7e:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000bc82:	49 89 c9             	mov    %rcx,%r9
   14000bc85:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   14000bc8b:	48 89 c1             	mov    %rax,%rcx
   14000bc8e:	e8 00 ec ff ff       	call   14000a893 <state__add_ins>
   14000bc93:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000bc97:	48 8b 45 30          	mov    0x30(%rbp),%rax
   14000bc9b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000bc9f:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000bca3:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000bca7:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000bcad:	41 b8 29 00 00 00    	mov    $0x29,%r8d
   14000bcb3:	48 89 c1             	mov    %rax,%rcx
   14000bcb6:	e8 d8 eb ff ff       	call   14000a893 <state__add_ins>
   14000bcbb:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000bcbf:	48 8b 45 30          	mov    0x30(%rbp),%rax
   14000bcc3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000bcc7:	48 8b 4d 30          	mov    0x30(%rbp),%rcx
   14000bccb:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   14000bccf:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000bcd3:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000bcd9:	49 89 c8             	mov    %rcx,%r8
   14000bcdc:	48 89 c1             	mov    %rax,%rcx
   14000bcdf:	e8 3e fc ff ff       	call   14000b922 <compile__load_return>
   14000bce4:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000bce8:	48 8b 4d 30          	mov    0x30(%rbp),%rcx
   14000bcec:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   14000bcf0:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000bcf4:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000bcfb:	00 00 
   14000bcfd:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000bd03:	49 89 c8             	mov    %rcx,%r8
   14000bd06:	48 89 c1             	mov    %rax,%rcx
   14000bd09:	e8 54 fa ff ff       	call   14000b762 <compile__load_argument>
   14000bd0e:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000bd12:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000bd16:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000bd1a:	41 b8 10 00 00 00    	mov    $0x10,%r8d
   14000bd20:	48 89 c1             	mov    %rax,%rcx
   14000bd23:	e8 6b eb ff ff       	call   14000a893 <state__add_ins>
   14000bd28:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000bd2c:	48 8b 4d 30          	mov    0x30(%rbp),%rcx
   14000bd30:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   14000bd34:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000bd38:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000bd3e:	49 89 c8             	mov    %rcx,%r8
   14000bd41:	48 89 c1             	mov    %rax,%rcx
   14000bd44:	e8 ff fa ff ff       	call   14000b848 <compile__store_return>
   14000bd49:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000bd4d:	48 8b 4d 30          	mov    0x30(%rbp),%rcx
   14000bd51:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   14000bd55:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000bd59:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000bd60:	00 00 
   14000bd62:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000bd68:	49 89 c8             	mov    %rcx,%r8
   14000bd6b:	48 89 c1             	mov    %rax,%rcx
   14000bd6e:	e8 ef f9 ff ff       	call   14000b762 <compile__load_argument>
   14000bd73:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000bd77:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000bd7b:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000bd7f:	41 b8 1b 00 00 00    	mov    $0x1b,%r8d
   14000bd85:	48 89 c1             	mov    %rax,%rcx
   14000bd88:	e8 06 eb ff ff       	call   14000a893 <state__add_ins>
   14000bd8d:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000bd91:	48 8b 4d 30          	mov    0x30(%rbp),%rcx
   14000bd95:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   14000bd99:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000bd9d:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000bda4:	00 00 
   14000bda6:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000bdac:	49 89 c8             	mov    %rcx,%r8
   14000bdaf:	48 89 c1             	mov    %rax,%rcx
   14000bdb2:	e8 c5 f8 ff ff       	call   14000b67c <compile__store_argument>
   14000bdb7:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000bdbb:	48 8b 4d 30          	mov    0x30(%rbp),%rcx
   14000bdbf:	48 8b 55 28          	mov    0x28(%rbp),%rdx
   14000bdc3:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000bdc7:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000bdce:	00 00 
   14000bdd0:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000bdd6:	49 89 c8             	mov    %rcx,%r8
   14000bdd9:	48 89 c1             	mov    %rax,%rcx
   14000bddc:	e8 81 f9 ff ff       	call   14000b762 <compile__load_argument>
   14000bde1:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000bde5:	48 8b 45 30          	mov    0x30(%rbp),%rax
   14000bde9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000bded:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
   14000bdf1:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000bdf5:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000bdf9:	49 89 c9             	mov    %rcx,%r9
   14000bdfc:	41 b8 21 00 00 00    	mov    $0x21,%r8d
   14000be02:	48 89 c1             	mov    %rax,%rcx
   14000be05:	e8 89 ea ff ff       	call   14000a893 <state__add_ins>
   14000be0a:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000be0e:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
   14000be12:	48 8b 55 30          	mov    0x30(%rbp),%rdx
   14000be16:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000be1a:	49 89 c9             	mov    %rcx,%r9
   14000be1d:	41 b8 20 00 00 00    	mov    $0x20,%r8d
   14000be23:	48 89 c1             	mov    %rax,%rcx
   14000be26:	e8 68 ea ff ff       	call   14000a893 <state__add_ins>
   14000be2b:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000be2f:	48 8b 4d 30          	mov    0x30(%rbp),%rcx
   14000be33:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   14000be37:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000be3b:	49 89 c8             	mov    %rcx,%r8
   14000be3e:	48 89 c1             	mov    %rax,%rcx
   14000be41:	e8 09 ea ff ff       	call   14000a84f <state__patch_jmp>
   14000be46:	48 8b 4d 30          	mov    0x30(%rbp),%rcx
   14000be4a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   14000be4e:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000be52:	49 89 c8             	mov    %rcx,%r8
   14000be55:	48 89 c1             	mov    %rax,%rcx
   14000be58:	e8 f2 e9 ff ff       	call   14000a84f <state__patch_jmp>
   14000be5d:	48 8b 45 30          	mov    0x30(%rbp),%rax
   14000be61:	48 83 c4 60          	add    $0x60,%rsp
   14000be65:	5e                   	pop    %rsi
   14000be66:	5f                   	pop    %rdi
   14000be67:	5d                   	pop    %rbp
   14000be68:	c3                   	ret

000000014000be69 <state__compile_ret_struct_fn>:
   14000be69:	55                   	push   %rbp
   14000be6a:	41 57                	push   %r15
   14000be6c:	41 56                	push   %r14
   14000be6e:	41 55                	push   %r13
   14000be70:	41 54                	push   %r12
   14000be72:	57                   	push   %rdi
   14000be73:	56                   	push   %rsi
   14000be74:	48 83 ec 60          	sub    $0x60,%rsp
   14000be78:	48 8d 6c 24 60       	lea    0x60(%rsp),%rbp
   14000be7d:	48 89 4d 40          	mov    %rcx,0x40(%rbp)
   14000be81:	48 89 55 48          	mov    %rdx,0x48(%rbp)
   14000be85:	4c 89 45 50          	mov    %r8,0x50(%rbp)
   14000be89:	49 c7 c2 88 ff ff ff 	mov    $0xffffffffffffff88,%r10
   14000be90:	41 bb 00 00 00 00    	mov    $0x0,%r11d
   14000be96:	4c 89 55 d0          	mov    %r10,-0x30(%rbp)
   14000be9a:	4c 89 5d d8          	mov    %r11,-0x28(%rbp)
   14000be9e:	48 8d 4d d0          	lea    -0x30(%rbp),%rcx
   14000bea2:	48 8b 55 50          	mov    0x50(%rbp),%rdx
   14000bea6:	48 8b 45 40          	mov    0x40(%rbp),%rax
   14000beaa:	49 89 c9             	mov    %rcx,%r9
   14000bead:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   14000beb3:	48 89 c1             	mov    %rax,%rcx
   14000beb6:	e8 d8 e9 ff ff       	call   14000a893 <state__add_ins>
   14000bebb:	48 89 45 50          	mov    %rax,0x50(%rbp)
   14000bebf:	48 8b 4d 50          	mov    0x50(%rbp),%rcx
   14000bec3:	48 8b 55 48          	mov    0x48(%rbp),%rdx
   14000bec7:	48 8b 45 40          	mov    0x40(%rbp),%rax
   14000becb:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000bed2:	00 00 
   14000bed4:	4c 8d 0d 85 91 00 00 	lea    0x9185(%rip),%r9        # 140015060 <.rdata+0x190>
   14000bedb:	49 89 c8             	mov    %rcx,%r8
   14000bede:	48 89 c1             	mov    %rax,%rcx
   14000bee1:	e8 62 f9 ff ff       	call   14000b848 <compile__store_return>
   14000bee6:	48 89 45 50          	mov    %rax,0x50(%rbp)
   14000beea:	49 c7 c4 c7 cf ff ff 	mov    $0xffffffffffffcfc7,%r12
   14000bef1:	41 bd 00 00 00 00    	mov    $0x0,%r13d
   14000bef7:	4c 89 65 d0          	mov    %r12,-0x30(%rbp)
   14000befb:	4c 89 6d d8          	mov    %r13,-0x28(%rbp)
   14000beff:	48 8d 4d d0          	lea    -0x30(%rbp),%rcx
   14000bf03:	48 8b 55 50          	mov    0x50(%rbp),%rdx
   14000bf07:	48 8b 45 40          	mov    0x40(%rbp),%rax
   14000bf0b:	49 89 c9             	mov    %rcx,%r9
   14000bf0e:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   14000bf14:	48 89 c1             	mov    %rax,%rcx
   14000bf17:	e8 77 e9 ff ff       	call   14000a893 <state__add_ins>
   14000bf1c:	48 89 45 50          	mov    %rax,0x50(%rbp)
   14000bf20:	48 8b 4d 50          	mov    0x50(%rbp),%rcx
   14000bf24:	48 8b 55 48          	mov    0x48(%rbp),%rdx
   14000bf28:	48 8b 45 40          	mov    0x40(%rbp),%rax
   14000bf2c:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000bf33:	00 00 
   14000bf35:	4c 8d 0d 2d 91 00 00 	lea    0x912d(%rip),%r9        # 140015069 <.rdata+0x199>
   14000bf3c:	49 89 c8             	mov    %rcx,%r8
   14000bf3f:	48 89 c1             	mov    %rax,%rcx
   14000bf42:	e8 01 f9 ff ff       	call   14000b848 <compile__store_return>
   14000bf47:	48 89 45 50          	mov    %rax,0x50(%rbp)
   14000bf4b:	48 be 38 3a 0f 86 48 	movabs $0x7048860f3a38,%rsi
   14000bf52:	70 00 00 
   14000bf55:	bf 00 00 00 00       	mov    $0x0,%edi
   14000bf5a:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   14000bf5e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   14000bf62:	48 8d 4d d0          	lea    -0x30(%rbp),%rcx
   14000bf66:	48 8b 55 50          	mov    0x50(%rbp),%rdx
   14000bf6a:	48 8b 45 40          	mov    0x40(%rbp),%rax
   14000bf6e:	49 89 c9             	mov    %rcx,%r9
   14000bf71:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   14000bf77:	48 89 c1             	mov    %rax,%rcx
   14000bf7a:	e8 14 e9 ff ff       	call   14000a893 <state__add_ins>
   14000bf7f:	48 89 45 50          	mov    %rax,0x50(%rbp)
   14000bf83:	48 8b 4d 50          	mov    0x50(%rbp),%rcx
   14000bf87:	48 8b 55 48          	mov    0x48(%rbp),%rdx
   14000bf8b:	48 8b 45 40          	mov    0x40(%rbp),%rax
   14000bf8f:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000bf96:	00 00 
   14000bf98:	4c 8d 0d d3 90 00 00 	lea    0x90d3(%rip),%r9        # 140015072 <.rdata+0x1a2>
   14000bf9f:	49 89 c8             	mov    %rcx,%r8
   14000bfa2:	48 89 c1             	mov    %rax,%rcx
   14000bfa5:	e8 9e f8 ff ff       	call   14000b848 <compile__store_return>
   14000bfaa:	48 89 45 50          	mov    %rax,0x50(%rbp)
   14000bfae:	48 8b 45 40          	mov    0x40(%rbp),%rax
   14000bfb2:	48 8d 15 c2 90 00 00 	lea    0x90c2(%rip),%rdx        # 14001507b <.rdata+0x1ab>
   14000bfb9:	48 89 c1             	mov    %rax,%rcx
   14000bfbc:	e8 19 e8 ff ff       	call   14000a7da <state__type_find>
   14000bfc1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000bfc5:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   14000bfca:	75 23                	jne    14000bfef <state__compile_ret_struct_fn+0x186>
   14000bfcc:	41 b8 fa 02 00 00    	mov    $0x2fa,%r8d
   14000bfd2:	48 8d 05 f7 8e 00 00 	lea    0x8ef7(%rip),%rax        # 140014ed0 <.rdata>
   14000bfd9:	48 89 c2             	mov    %rax,%rdx
   14000bfdc:	48 8d 05 9a 90 00 00 	lea    0x909a(%rip),%rax        # 14001507d <.rdata+0x1ad>
   14000bfe3:	48 89 c1             	mov    %rax,%rcx
   14000bfe6:	48 8b 05 53 f3 00 00 	mov    0xf353(%rip),%rax        # 14001b340 <__imp__assert>
   14000bfed:	ff d0                	call   *%rax
   14000bfef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000bff3:	48 8d 15 8c 90 00 00 	lea    0x908c(%rip),%rdx        # 140015086 <.rdata+0x1b6>
   14000bffa:	48 89 c1             	mov    %rax,%rcx
   14000bffd:	e8 a1 62 ff ff       	call   1400022a3 <type_struct__member>
   14000c002:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000c006:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   14000c00b:	75 23                	jne    14000c030 <state__compile_ret_struct_fn+0x1c7>
   14000c00d:	41 b8 fc 02 00 00    	mov    $0x2fc,%r8d
   14000c013:	48 8d 05 b6 8e 00 00 	lea    0x8eb6(%rip),%rax        # 140014ed0 <.rdata>
   14000c01a:	48 89 c2             	mov    %rax,%rdx
   14000c01d:	48 8d 05 62 90 00 00 	lea    0x9062(%rip),%rax        # 140015086 <.rdata+0x1b6>
   14000c024:	48 89 c1             	mov    %rax,%rcx
   14000c027:	48 8b 05 12 f3 00 00 	mov    0xf312(%rip),%rax        # 14001b340 <__imp__assert>
   14000c02e:	ff d0                	call   *%rax
   14000c030:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000c034:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000c038:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   14000c03c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000c040:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000c044:	8b 00                	mov    (%rax),%eax
   14000c046:	83 f8 03             	cmp    $0x3,%eax
   14000c049:	74 23                	je     14000c06e <state__compile_ret_struct_fn+0x205>
   14000c04b:	41 b8 fe 02 00 00    	mov    $0x2fe,%r8d
   14000c051:	48 8d 05 78 8e 00 00 	lea    0x8e78(%rip),%rax        # 140014ed0 <.rdata>
   14000c058:	48 89 c2             	mov    %rax,%rdx
   14000c05b:	48 8d 05 36 90 00 00 	lea    0x9036(%rip),%rax        # 140015098 <.rdata+0x1c8>
   14000c062:	48 89 c1             	mov    %rax,%rcx
   14000c065:	48 8b 05 d4 f2 00 00 	mov    0xf2d4(%rip),%rax        # 14001b340 <__imp__assert>
   14000c06c:	ff d0                	call   *%rax
   14000c06e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   14000c075:	eb 75                	jmp    14000c0ec <state__compile_ret_struct_fn+0x283>
   14000c077:	8b 55 fc             	mov    -0x4(%rbp),%edx
   14000c07a:	89 d0                	mov    %edx,%eax
   14000c07c:	01 c0                	add    %eax,%eax
   14000c07e:	01 d0                	add    %edx,%eax
   14000c080:	c1 e0 02             	shl    $0x2,%eax
   14000c083:	01 d0                	add    %edx,%eax
   14000c085:	89 c0                	mov    %eax,%eax
   14000c087:	49 89 c6             	mov    %rax,%r14
   14000c08a:	41 bf 00 00 00 00    	mov    $0x0,%r15d
   14000c090:	4c 89 75 d0          	mov    %r14,-0x30(%rbp)
   14000c094:	4c 89 7d d8          	mov    %r15,-0x28(%rbp)
   14000c098:	48 8d 4d d0          	lea    -0x30(%rbp),%rcx
   14000c09c:	48 8b 55 50          	mov    0x50(%rbp),%rdx
   14000c0a0:	48 8b 45 40          	mov    0x40(%rbp),%rax
   14000c0a4:	49 89 c9             	mov    %rcx,%r9
   14000c0a7:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   14000c0ad:	48 89 c1             	mov    %rax,%rcx
   14000c0b0:	e8 de e7 ff ff       	call   14000a893 <state__add_ins>
   14000c0b5:	48 89 45 50          	mov    %rax,0x50(%rbp)
   14000c0b9:	4c 8b 45 50          	mov    0x50(%rbp),%r8
   14000c0bd:	48 8b 55 48          	mov    0x48(%rbp),%rdx
   14000c0c1:	48 8b 45 40          	mov    0x40(%rbp),%rax
   14000c0c5:	48 c7 44 24 28 00 00 	movq   $0x0,0x28(%rsp)
   14000c0cc:	00 00 
   14000c0ce:	8b 4d fc             	mov    -0x4(%rbp),%ecx
   14000c0d1:	89 4c 24 20          	mov    %ecx,0x20(%rsp)
   14000c0d5:	4c 8d 0d aa 8f 00 00 	lea    0x8faa(%rip),%r9        # 140015086 <.rdata+0x1b6>
   14000c0dc:	48 89 c1             	mov    %rax,%rcx
   14000c0df:	e8 64 f7 ff ff       	call   14000b848 <compile__store_return>
   14000c0e4:	48 89 45 50          	mov    %rax,0x50(%rbp)
   14000c0e8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   14000c0ec:	8b 55 fc             	mov    -0x4(%rbp),%edx
   14000c0ef:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   14000c0f3:	48 8b 40 38          	mov    0x38(%rax),%rax
   14000c0f7:	48 39 c2             	cmp    %rax,%rdx
   14000c0fa:	0f 82 77 ff ff ff    	jb     14000c077 <state__compile_ret_struct_fn+0x20e>
   14000c100:	48 8b 45 50          	mov    0x50(%rbp),%rax
   14000c104:	48 83 c4 60          	add    $0x60,%rsp
   14000c108:	5e                   	pop    %rsi
   14000c109:	5f                   	pop    %rdi
   14000c10a:	41 5c                	pop    %r12
   14000c10c:	41 5d                	pop    %r13
   14000c10e:	41 5e                	pop    %r14
   14000c110:	41 5f                	pop    %r15
   14000c112:	5d                   	pop    %rbp
   14000c113:	c3                   	ret

000000014000c114 <fact>:
   14000c114:	55                   	push   %rbp
   14000c115:	48 89 e5             	mov    %rsp,%rbp
   14000c118:	48 83 ec 10          	sub    $0x10,%rsp
   14000c11c:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000c120:	48 c7 45 f8 01 00 00 	movq   $0x1,-0x8(%rbp)
   14000c127:	00 
   14000c128:	48 83 7d 10 00       	cmpq   $0x0,0x10(%rbp)
   14000c12d:	75 1e                	jne    14000c14d <fact+0x39>
   14000c12f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000c133:	eb 23                	jmp    14000c158 <fact+0x44>
   14000c135:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000c139:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   14000c13d:	48 89 55 10          	mov    %rdx,0x10(%rbp)
   14000c141:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   14000c145:	48 0f af c2          	imul   %rdx,%rax
   14000c149:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000c14d:	48 83 7d 10 00       	cmpq   $0x0,0x10(%rbp)
   14000c152:	75 e1                	jne    14000c135 <fact+0x21>
   14000c154:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000c158:	48 83 c4 10          	add    $0x10,%rsp
   14000c15c:	5d                   	pop    %rbp
   14000c15d:	c3                   	ret

000000014000c15e <state__add_fn>:
   14000c15e:	55                   	push   %rbp
   14000c15f:	48 89 e5             	mov    %rsp,%rbp
   14000c162:	48 83 ec 30          	sub    $0x30,%rsp
   14000c166:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000c16a:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000c16e:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   14000c172:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   14000c176:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000c17a:	41 b8 04 00 00 00    	mov    $0x4,%r8d
   14000c180:	48 89 c1             	mov    %rax,%rcx
   14000c183:	e8 0b e7 ff ff       	call   14000a893 <state__add_ins>
   14000c188:	48 89 45 20          	mov    %rax,0x20(%rbp)
   14000c18c:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   14000c190:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000c194:	c7 44 24 20 01 00 00 	movl   $0x1,0x20(%rsp)
   14000c19b:	00 
   14000c19c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000c1a2:	41 b8 0b 00 00 00    	mov    $0xb,%r8d
   14000c1a8:	48 89 c1             	mov    %rax,%rcx
   14000c1ab:	e8 e3 e6 ff ff       	call   14000a893 <state__add_ins>
   14000c1b0:	48 89 45 20          	mov    %rax,0x20(%rbp)
   14000c1b4:	48 8b 4d 20          	mov    0x20(%rbp),%rcx
   14000c1b8:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   14000c1bc:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000c1c0:	49 89 c8             	mov    %rcx,%r8
   14000c1c3:	48 89 c1             	mov    %rax,%rcx
   14000c1c6:	e8 8b e9 ff ff       	call   14000ab56 <state__compile_fn>
   14000c1cb:	48 89 45 20          	mov    %rax,0x20(%rbp)
   14000c1cf:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   14000c1d3:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000c1d7:	41 b8 09 00 00 00    	mov    $0x9,%r8d
   14000c1dd:	48 89 c1             	mov    %rax,%rcx
   14000c1e0:	e8 ae e6 ff ff       	call   14000a893 <state__add_ins>
   14000c1e5:	48 89 45 20          	mov    %rax,0x20(%rbp)
   14000c1e9:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000c1ed:	8b 48 28             	mov    0x28(%rax),%ecx
   14000c1f0:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   14000c1f4:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000c1f8:	41 89 c9             	mov    %ecx,%r9d
   14000c1fb:	41 b8 31 00 00 00    	mov    $0x31,%r8d
   14000c201:	48 89 c1             	mov    %rax,%rcx
   14000c204:	e8 8a e6 ff ff       	call   14000a893 <state__add_ins>
   14000c209:	48 89 45 20          	mov    %rax,0x20(%rbp)
   14000c20d:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c211:	48 83 c4 30          	add    $0x30,%rsp
   14000c215:	5d                   	pop    %rbp
   14000c216:	c3                   	ret

000000014000c217 <state__compile_main_fn>:
   14000c217:	55                   	push   %rbp
   14000c218:	41 57                	push   %r15
   14000c21a:	41 56                	push   %r14
   14000c21c:	41 55                	push   %r13
   14000c21e:	41 54                	push   %r12
   14000c220:	57                   	push   %rdi
   14000c221:	56                   	push   %rsi
   14000c222:	53                   	push   %rbx
   14000c223:	48 83 ec 78          	sub    $0x78,%rsp
   14000c227:	48 8d 6c 24 70       	lea    0x70(%rsp),%rbp
   14000c22c:	48 89 4d 50          	mov    %rcx,0x50(%rbp)
   14000c230:	48 89 55 58          	mov    %rdx,0x58(%rbp)
   14000c234:	4c 89 45 60          	mov    %r8,0x60(%rbp)
   14000c238:	48 8b 45 50          	mov    0x50(%rbp),%rax
   14000c23c:	48 8d 15 86 8e 00 00 	lea    0x8e86(%rip),%rdx        # 1400150c9 <.rdata+0x1f9>
   14000c243:	48 89 c1             	mov    %rax,%rcx
   14000c246:	e8 8f e5 ff ff       	call   14000a7da <state__type_find>
   14000c24b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000c24f:	48 8b 45 50          	mov    0x50(%rbp),%rax
   14000c253:	48 8d 15 73 8e 00 00 	lea    0x8e73(%rip),%rdx        # 1400150cd <.rdata+0x1fd>
   14000c25a:	48 89 c1             	mov    %rax,%rcx
   14000c25d:	e8 78 e5 ff ff       	call   14000a7da <state__type_find>
   14000c262:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000c266:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   14000c26b:	75 23                	jne    14000c290 <state__compile_main_fn+0x79>
   14000c26d:	41 b8 26 03 00 00    	mov    $0x326,%r8d
   14000c273:	48 8d 05 56 8c 00 00 	lea    0x8c56(%rip),%rax        # 140014ed0 <.rdata>
   14000c27a:	48 89 c2             	mov    %rax,%rdx
   14000c27d:	48 8d 05 4d 8e 00 00 	lea    0x8e4d(%rip),%rax        # 1400150d1 <.rdata+0x201>
   14000c284:	48 89 c1             	mov    %rax,%rcx
   14000c287:	48 8b 05 b2 f0 00 00 	mov    0xf0b2(%rip),%rax        # 14001b340 <__imp__assert>
   14000c28e:	ff d0                	call   *%rax
   14000c290:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   14000c295:	75 23                	jne    14000c2ba <state__compile_main_fn+0xa3>
   14000c297:	41 b8 27 03 00 00    	mov    $0x327,%r8d
   14000c29d:	48 8d 05 2c 8c 00 00 	lea    0x8c2c(%rip),%rax        # 140014ed0 <.rdata>
   14000c2a4:	48 89 c2             	mov    %rax,%rdx
   14000c2a7:	48 8d 05 29 8e 00 00 	lea    0x8e29(%rip),%rax        # 1400150d7 <.rdata+0x207>
   14000c2ae:	48 89 c1             	mov    %rax,%rcx
   14000c2b1:	48 8b 05 88 f0 00 00 	mov    0xf088(%rip),%rax        # 14001b340 <__imp__assert>
   14000c2b8:	ff d0                	call   *%rax
   14000c2ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000c2be:	49 89 c0             	mov    %rax,%r8
   14000c2c1:	48 8d 05 04 f9 ff ff 	lea    -0x6fc(%rip),%rax        # 14000bbcc <state__compile_fact_fn>
   14000c2c8:	48 89 c2             	mov    %rax,%rdx
   14000c2cb:	48 8d 05 0b 8e 00 00 	lea    0x8e0b(%rip),%rax        # 1400150dd <.rdata+0x20d>
   14000c2d2:	48 89 c1             	mov    %rax,%rcx
   14000c2d5:	e8 33 e8 ff ff       	call   14000ab0d <fn_decl__create>
   14000c2da:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000c2de:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   14000c2e2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000c2e6:	48 89 c1             	mov    %rax,%rcx
   14000c2e9:	e8 bc ed ff ff       	call   14000b0aa <fn_decl__add_argument>
   14000c2ee:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   14000c2f2:	48 8b 45 58          	mov    0x58(%rbp),%rax
   14000c2f6:	49 89 d0             	mov    %rdx,%r8
   14000c2f9:	48 8d 15 e2 8d 00 00 	lea    0x8de2(%rip),%rdx        # 1400150e2 <.rdata+0x212>
   14000c300:	48 89 c1             	mov    %rax,%rcx
   14000c303:	e8 9c ee ff ff       	call   14000b1a4 <fn_decl__add_local>
   14000c308:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000c30c:	48 89 c1             	mov    %rax,%rcx
   14000c30f:	e8 57 5e ff ff       	call   14000216b <type__size>
   14000c314:	48 89 c3             	mov    %rax,%rbx
   14000c317:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000c31b:	48 89 c1             	mov    %rax,%rcx
   14000c31e:	e8 36 5e ff ff       	call   140002159 <type__alignment>
   14000c323:	48 89 c1             	mov    %rax,%rcx
   14000c326:	48 8b 55 60          	mov    0x60(%rbp),%rdx
   14000c32a:	48 8b 45 50          	mov    0x50(%rbp),%rax
   14000c32e:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
   14000c333:	49 89 c9             	mov    %rcx,%r9
   14000c336:	41 b8 01 00 00 00    	mov    $0x1,%r8d
   14000c33c:	48 89 c1             	mov    %rax,%rcx
   14000c33f:	e8 4f e5 ff ff       	call   14000a893 <state__add_ins>
   14000c344:	48 89 45 60          	mov    %rax,0x60(%rbp)
   14000c348:	41 be 0a 00 00 00    	mov    $0xa,%r14d
   14000c34e:	41 bf 00 00 00 00    	mov    $0x0,%r15d
   14000c354:	4c 89 75 c0          	mov    %r14,-0x40(%rbp)
   14000c358:	4c 89 7d c8          	mov    %r15,-0x38(%rbp)
   14000c35c:	48 8d 4d c0          	lea    -0x40(%rbp),%rcx
   14000c360:	48 8b 55 60          	mov    0x60(%rbp),%rdx
   14000c364:	48 8b 45 50          	mov    0x50(%rbp),%rax
   14000c368:	49 89 c9             	mov    %rcx,%r9
   14000c36b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   14000c371:	48 89 c1             	mov    %rax,%rcx
   14000c374:	e8 1a e5 ff ff       	call   14000a893 <state__add_ins>
   14000c379:	48 89 45 60          	mov    %rax,0x60(%rbp)
   14000c37d:	48 8b 4d 60          	mov    0x60(%rbp),%rcx
   14000c381:	48 8b 55 58          	mov    0x58(%rbp),%rdx
   14000c385:	48 8b 45 50          	mov    0x50(%rbp),%rax
   14000c389:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14000c390:	00 00 
   14000c392:	4c 8d 0d 49 8d 00 00 	lea    0x8d49(%rip),%r9        # 1400150e2 <.rdata+0x212>
   14000c399:	49 89 c8             	mov    %rcx,%r8
   14000c39c:	48 89 c1             	mov    %rax,%rcx
   14000c39f:	e8 40 f7 ff ff       	call   14000bae4 <compile__store_local>
   14000c3a4:	48 89 45 60          	mov    %rax,0x60(%rbp)
   14000c3a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000c3ac:	48 89 c1             	mov    %rax,%rcx
   14000c3af:	e8 b7 5d ff ff       	call   14000216b <type__size>
   14000c3b4:	48 89 c3             	mov    %rax,%rbx
   14000c3b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000c3bb:	48 89 c1             	mov    %rax,%rcx
   14000c3be:	e8 96 5d ff ff       	call   140002159 <type__alignment>
   14000c3c3:	48 89 c1             	mov    %rax,%rcx
   14000c3c6:	48 8b 55 60          	mov    0x60(%rbp),%rdx
   14000c3ca:	48 8b 45 50          	mov    0x50(%rbp),%rax
   14000c3ce:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
   14000c3d3:	49 89 c9             	mov    %rcx,%r9
   14000c3d6:	41 b8 01 00 00 00    	mov    $0x1,%r8d
   14000c3dc:	48 89 c1             	mov    %rax,%rcx
   14000c3df:	e8 af e4 ff ff       	call   14000a893 <state__add_ins>
   14000c3e4:	48 89 45 60          	mov    %rax,0x60(%rbp)
   14000c3e8:	48 8b 45 60          	mov    0x60(%rbp),%rax
   14000c3ec:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   14000c3f0:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   14000c3f4:	48 8b 55 60          	mov    0x60(%rbp),%rdx
   14000c3f8:	48 8b 45 50          	mov    0x50(%rbp),%rax
   14000c3fc:	49 89 c9             	mov    %rcx,%r9
   14000c3ff:	41 b8 2f 00 00 00    	mov    $0x2f,%r8d
   14000c405:	48 89 c1             	mov    %rax,%rcx
   14000c408:	e8 86 e4 ff ff       	call   14000a893 <state__add_ins>
   14000c40d:	48 89 45 60          	mov    %rax,0x60(%rbp)
   14000c411:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000c415:	48 89 c1             	mov    %rax,%rcx
   14000c418:	e8 d8 67 ff ff       	call   140002bf5 <type__hash>
   14000c41d:	49 89 c4             	mov    %rax,%r12
   14000c420:	41 bd 00 00 00 00    	mov    $0x0,%r13d
   14000c426:	4c 89 65 c0          	mov    %r12,-0x40(%rbp)
   14000c42a:	4c 89 6d c8          	mov    %r13,-0x38(%rbp)
   14000c42e:	48 8d 4d c0          	lea    -0x40(%rbp),%rcx
   14000c432:	48 8b 55 60          	mov    0x60(%rbp),%rdx
   14000c436:	48 8b 45 50          	mov    0x50(%rbp),%rax
   14000c43a:	49 89 c9             	mov    %rcx,%r9
   14000c43d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   14000c443:	48 89 c1             	mov    %rax,%rcx
   14000c446:	e8 48 e4 ff ff       	call   14000a893 <state__add_ins>
   14000c44b:	48 89 45 60          	mov    %rax,0x60(%rbp)
   14000c44f:	48 8b 55 60          	mov    0x60(%rbp),%rdx
   14000c453:	48 8b 45 50          	mov    0x50(%rbp),%rax
   14000c457:	41 b9 02 00 00 00    	mov    $0x2,%r9d
   14000c45d:	41 b8 30 00 00 00    	mov    $0x30,%r8d
   14000c463:	48 89 c1             	mov    %rax,%rcx
   14000c466:	e8 28 e4 ff ff       	call   14000a893 <state__add_ins>
   14000c46b:	48 89 45 60          	mov    %rax,0x60(%rbp)
   14000c46f:	48 8b 55 60          	mov    0x60(%rbp),%rdx
   14000c473:	48 8b 45 50          	mov    0x50(%rbp),%rax
   14000c477:	41 b8 06 00 00 00    	mov    $0x6,%r8d
   14000c47d:	48 89 c1             	mov    %rax,%rcx
   14000c480:	e8 0e e4 ff ff       	call   14000a893 <state__add_ins>
   14000c485:	48 89 45 60          	mov    %rax,0x60(%rbp)
   14000c489:	be 2a 00 00 00       	mov    $0x2a,%esi
   14000c48e:	bf 00 00 00 00       	mov    $0x0,%edi
   14000c493:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   14000c497:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   14000c49b:	48 8d 4d c0          	lea    -0x40(%rbp),%rcx
   14000c49f:	48 8b 55 60          	mov    0x60(%rbp),%rdx
   14000c4a3:	48 8b 45 50          	mov    0x50(%rbp),%rax
   14000c4a7:	49 89 c9             	mov    %rcx,%r9
   14000c4aa:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   14000c4b0:	48 89 c1             	mov    %rax,%rcx
   14000c4b3:	e8 db e3 ff ff       	call   14000a893 <state__add_ins>
   14000c4b8:	48 89 45 60          	mov    %rax,0x60(%rbp)
   14000c4bc:	48 8b 4d 60          	mov    0x60(%rbp),%rcx
   14000c4c0:	48 8b 55 58          	mov    0x58(%rbp),%rdx
   14000c4c4:	48 8b 45 50          	mov    0x50(%rbp),%rax
   14000c4c8:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000c4ce:	49 89 c8             	mov    %rcx,%r8
   14000c4d1:	48 89 c1             	mov    %rax,%rcx
   14000c4d4:	e8 6f f3 ff ff       	call   14000b848 <compile__store_return>
   14000c4d9:	48 89 45 60          	mov    %rax,0x60(%rbp)
   14000c4dd:	48 8b 45 60          	mov    0x60(%rbp),%rax
   14000c4e1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   14000c4e5:	48 8b 55 60          	mov    0x60(%rbp),%rdx
   14000c4e9:	48 8b 45 50          	mov    0x50(%rbp),%rax
   14000c4ed:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14000c4f3:	41 b8 20 00 00 00    	mov    $0x20,%r8d
   14000c4f9:	48 89 c1             	mov    %rax,%rcx
   14000c4fc:	e8 92 e3 ff ff       	call   14000a893 <state__add_ins>
   14000c501:	48 89 45 60          	mov    %rax,0x60(%rbp)
   14000c505:	48 8b 4d 60          	mov    0x60(%rbp),%rcx
   14000c509:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   14000c50d:	48 8b 45 50          	mov    0x50(%rbp),%rax
   14000c511:	49 89 c8             	mov    %rcx,%r8
   14000c514:	48 89 c1             	mov    %rax,%rcx
   14000c517:	e8 55 e3 ff ff       	call   14000a871 <state__patch_call>
   14000c51c:	48 8b 4d 60          	mov    0x60(%rbp),%rcx
   14000c520:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   14000c524:	48 8b 45 50          	mov    0x50(%rbp),%rax
   14000c528:	49 89 c8             	mov    %rcx,%r8
   14000c52b:	48 89 c1             	mov    %rax,%rcx
   14000c52e:	e8 2b fc ff ff       	call   14000c15e <state__add_fn>
   14000c533:	48 89 45 60          	mov    %rax,0x60(%rbp)
   14000c537:	48 8b 4d 60          	mov    0x60(%rbp),%rcx
   14000c53b:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   14000c53f:	48 8b 45 50          	mov    0x50(%rbp),%rax
   14000c543:	49 89 c8             	mov    %rcx,%r8
   14000c546:	48 89 c1             	mov    %rax,%rcx
   14000c549:	e8 01 e3 ff ff       	call   14000a84f <state__patch_jmp>
   14000c54e:	48 8b 45 60          	mov    0x60(%rbp),%rax
   14000c552:	48 83 c4 78          	add    $0x78,%rsp
   14000c556:	5b                   	pop    %rbx
   14000c557:	5e                   	pop    %rsi
   14000c558:	5f                   	pop    %rdi
   14000c559:	41 5c                	pop    %r12
   14000c55b:	41 5d                	pop    %r13
   14000c55d:	41 5e                	pop    %r14
   14000c55f:	41 5f                	pop    %r15
   14000c561:	5d                   	pop    %rbp
   14000c562:	c3                   	ret

000000014000c563 <state__compile>:
   14000c563:	55                   	push   %rbp
   14000c564:	53                   	push   %rbx
   14000c565:	48 83 ec 78          	sub    $0x78,%rsp
   14000c569:	48 8d 6c 24 70       	lea    0x70(%rsp),%rbp
   14000c56e:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   14000c572:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c576:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000c57a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000c57e:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c582:	48 8d 15 65 8b 00 00 	lea    0x8b65(%rip),%rdx        # 1400150ee <.rdata+0x21e>
   14000c589:	48 89 c1             	mov    %rax,%rcx
   14000c58c:	e8 49 e2 ff ff       	call   14000a7da <state__type_find>
   14000c591:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000c595:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   14000c59a:	75 23                	jne    14000c5bf <state__compile+0x5c>
   14000c59c:	41 b8 47 03 00 00    	mov    $0x347,%r8d
   14000c5a2:	48 8d 05 27 89 00 00 	lea    0x8927(%rip),%rax        # 140014ed0 <.rdata>
   14000c5a9:	48 89 c2             	mov    %rax,%rdx
   14000c5ac:	48 8d 05 3f 8b 00 00 	lea    0x8b3f(%rip),%rax        # 1400150f2 <.rdata+0x222>
   14000c5b3:	48 89 c1             	mov    %rax,%rcx
   14000c5b6:	48 8b 05 83 ed 00 00 	mov    0xed83(%rip),%rax        # 14001b340 <__imp__assert>
   14000c5bd:	ff d0                	call   *%rax
   14000c5bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000c5c3:	49 89 c0             	mov    %rax,%r8
   14000c5c6:	48 8d 05 4a fc ff ff 	lea    -0x3b6(%rip),%rax        # 14000c217 <state__compile_main_fn>
   14000c5cd:	48 89 c2             	mov    %rax,%rdx
   14000c5d0:	48 8d 05 21 8b 00 00 	lea    0x8b21(%rip),%rax        # 1400150f8 <.rdata+0x228>
   14000c5d7:	48 89 c1             	mov    %rax,%rcx
   14000c5da:	e8 2e e5 ff ff       	call   14000ab0d <fn_decl__create>
   14000c5df:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   14000c5e3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000c5e7:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   14000c5eb:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   14000c5ef:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   14000c5f3:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c5f7:	49 89 c8             	mov    %rcx,%r8
   14000c5fa:	48 89 c1             	mov    %rax,%rcx
   14000c5fd:	e8 5c fb ff ff       	call   14000c15e <state__add_fn>
   14000c602:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000c606:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000c60a:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   14000c60e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000c612:	48 89 c1             	mov    %rax,%rcx
   14000c615:	e8 51 5b ff ff       	call   14000216b <type__size>
   14000c61a:	48 89 c3             	mov    %rax,%rbx
   14000c61d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000c621:	48 89 c1             	mov    %rax,%rcx
   14000c624:	e8 30 5b ff ff       	call   140002159 <type__alignment>
   14000c629:	48 89 c1             	mov    %rax,%rcx
   14000c62c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   14000c630:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c634:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
   14000c639:	49 89 c9             	mov    %rcx,%r9
   14000c63c:	41 b8 01 00 00 00    	mov    $0x1,%r8d
   14000c642:	48 89 c1             	mov    %rax,%rcx
   14000c645:	e8 49 e2 ff ff       	call   14000a893 <state__add_ins>
   14000c64a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000c64e:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   14000c652:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   14000c656:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c65a:	49 89 c9             	mov    %rcx,%r9
   14000c65d:	41 b8 2f 00 00 00    	mov    $0x2f,%r8d
   14000c663:	48 89 c1             	mov    %rax,%rcx
   14000c666:	e8 28 e2 ff ff       	call   14000a893 <state__add_ins>
   14000c66b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000c66f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   14000c673:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c677:	41 b8 32 00 00 00    	mov    $0x32,%r8d
   14000c67d:	48 89 c1             	mov    %rax,%rcx
   14000c680:	e8 0e e2 ff ff       	call   14000a893 <state__add_ins>
   14000c685:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000c689:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c68d:	48 8b 40 08          	mov    0x8(%rax),%rax
   14000c691:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   14000c695:	48 29 c2             	sub    %rax,%rdx
   14000c698:	89 55 cc             	mov    %edx,-0x34(%rbp)
   14000c69b:	48 8d 05 5b 8a 00 00 	lea    0x8a5b(%rip),%rax        # 1400150fd <.rdata+0x22d>
   14000c6a2:	48 89 c2             	mov    %rax,%rdx
   14000c6a5:	48 8d 05 53 8a 00 00 	lea    0x8a53(%rip),%rax        # 1400150ff <.rdata+0x22f>
   14000c6ac:	48 89 c1             	mov    %rax,%rcx
   14000c6af:	e8 94 53 00 00       	call   140011a48 <fopen>
   14000c6b4:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   14000c6b8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   14000c6bf:	eb 2e                	jmp    14000c6ef <state__compile+0x18c>
   14000c6c1:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c6c5:	48 8b 50 08          	mov    0x8(%rax),%rdx
   14000c6c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   14000c6cc:	48 01 d0             	add    %rdx,%rax
   14000c6cf:	0f b6 00             	movzbl (%rax),%eax
   14000c6d2:	0f b6 d0             	movzbl %al,%edx
   14000c6d5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   14000c6d9:	41 89 d0             	mov    %edx,%r8d
   14000c6dc:	48 8d 15 22 8a 00 00 	lea    0x8a22(%rip),%rdx        # 140015105 <.rdata+0x235>
   14000c6e3:	48 89 c1             	mov    %rax,%rcx
   14000c6e6:	e8 a5 4f 00 00       	call   140011690 <fprintf>
   14000c6eb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   14000c6ef:	8b 45 fc             	mov    -0x4(%rbp),%eax
   14000c6f2:	3b 45 cc             	cmp    -0x34(%rbp),%eax
   14000c6f5:	72 ca                	jb     14000c6c1 <state__compile+0x15e>
   14000c6f7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   14000c6fb:	48 89 c2             	mov    %rax,%rdx
   14000c6fe:	b9 0a 00 00 00       	mov    $0xa,%ecx
   14000c703:	e8 48 53 00 00       	call   140011a50 <fputc>
   14000c708:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   14000c70c:	48 89 c1             	mov    %rax,%rcx
   14000c70f:	e8 2c 53 00 00       	call   140011a40 <fclose>
   14000c714:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   14000c718:	48 83 c4 78          	add    $0x78,%rsp
   14000c71c:	5b                   	pop    %rbx
   14000c71d:	5d                   	pop    %rbp
   14000c71e:	c3                   	ret

000000014000c71f <clear_cache>:
   14000c71f:	55                   	push   %rbp
   14000c720:	48 89 e5             	mov    %rsp,%rbp
   14000c723:	48 83 ec 10          	sub    $0x10,%rsp
   14000c727:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000c72b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   14000c732:	eb 26                	jmp    14000c75a <clear_cache+0x3b>
   14000c734:	8b 45 fc             	mov    -0x4(%rbp),%eax
   14000c737:	89 c1                	mov    %eax,%ecx
   14000c739:	8b 45 fc             	mov    -0x4(%rbp),%eax
   14000c73c:	89 c2                	mov    %eax,%edx
   14000c73e:	89 c8                	mov    %ecx,%eax
   14000c740:	0f af c2             	imul   %edx,%eax
   14000c743:	89 c1                	mov    %eax,%ecx
   14000c745:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000c749:	48 8b 10             	mov    (%rax),%rdx
   14000c74c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   14000c74f:	48 01 d0             	add    %rdx,%rax
   14000c752:	89 ca                	mov    %ecx,%edx
   14000c754:	88 10                	mov    %dl,(%rax)
   14000c756:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   14000c75a:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000c75e:	8b 40 08             	mov    0x8(%rax),%eax
   14000c761:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   14000c764:	72 ce                	jb     14000c734 <clear_cache+0x15>
   14000c766:	90                   	nop
   14000c767:	90                   	nop
   14000c768:	48 83 c4 10          	add    $0x10,%rsp
   14000c76c:	5d                   	pop    %rbp
   14000c76d:	c3                   	ret

000000014000c76e <state__builtin_execute>:
   14000c76e:	55                   	push   %rbp
   14000c76f:	53                   	push   %rbx
   14000c770:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
   14000c777:	48 8d ac 24 80 00 00 	lea    0x80(%rsp),%rbp
   14000c77e:	00 
   14000c77f:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   14000c783:	89 d0                	mov    %edx,%eax
   14000c785:	66 89 45 28          	mov    %ax,0x28(%rbp)
   14000c789:	0f b7 45 28          	movzwl 0x28(%rbp),%eax
   14000c78d:	83 f8 02             	cmp    $0x2,%eax
   14000c790:	0f 84 0c 01 00 00    	je     14000c8a2 <state__builtin_execute+0x134>
   14000c796:	83 f8 02             	cmp    $0x2,%eax
   14000c799:	0f 8f fb 01 00 00    	jg     14000c99a <state__builtin_execute+0x22c>
   14000c79f:	85 c0                	test   %eax,%eax
   14000c7a1:	74 0e                	je     14000c7b1 <state__builtin_execute+0x43>
   14000c7a3:	83 f8 01             	cmp    $0x1,%eax
   14000c7a6:	0f 84 cd 00 00 00    	je     14000c879 <state__builtin_execute+0x10b>
   14000c7ac:	e9 e9 01 00 00       	jmp    14000c99a <state__builtin_execute+0x22c>
   14000c7b1:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c7b5:	48 8b 40 18          	mov    0x18(%rax),%rax
   14000c7b9:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000c7bd:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000c7c1:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   14000c7c5:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   14000c7c9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   14000c7cd:	48 89 c1             	mov    %rax,%rcx
   14000c7d0:	e8 9b 52 00 00       	call   140011a70 <malloc>
   14000c7d5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000c7d9:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c7dd:	48 8b 40 18          	mov    0x18(%rax),%rax
   14000c7e1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   14000c7e5:	48 89 10             	mov    %rdx,(%rax)
   14000c7e8:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c7ec:	48 8b 40 18          	mov    0x18(%rax),%rax
   14000c7f0:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000c7f4:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c7f8:	48 8b 40 20          	mov    0x20(%rax),%rax
   14000c7fc:	48 39 c2             	cmp    %rax,%rdx
   14000c7ff:	73 23                	jae    14000c824 <state__builtin_execute+0xb6>
   14000c801:	41 b8 b0 03 00 00    	mov    $0x3b0,%r8d
   14000c807:	48 8d 05 c2 86 00 00 	lea    0x86c2(%rip),%rax        # 140014ed0 <.rdata>
   14000c80e:	48 89 c2             	mov    %rax,%rdx
   14000c811:	48 8d 05 f8 88 00 00 	lea    0x88f8(%rip),%rax        # 140015110 <.rdata+0x240>
   14000c818:	48 89 c1             	mov    %rax,%rcx
   14000c81b:	48 8b 05 1e eb 00 00 	mov    0xeb1e(%rip),%rax        # 14001b340 <__imp__assert>
   14000c822:	ff d0                	call   *%rax
   14000c824:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c828:	48 8b 40 18          	mov    0x18(%rax),%rax
   14000c82c:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000c830:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c834:	48 8b 40 28          	mov    0x28(%rax),%rax
   14000c838:	48 39 c2             	cmp    %rax,%rdx
   14000c83b:	72 23                	jb     14000c860 <state__builtin_execute+0xf2>
   14000c83d:	41 b8 b0 03 00 00    	mov    $0x3b0,%r8d
   14000c843:	48 8d 05 86 86 00 00 	lea    0x8686(%rip),%rax        # 140014ed0 <.rdata>
   14000c84a:	48 89 c2             	mov    %rax,%rdx
   14000c84d:	48 8d 05 14 89 00 00 	lea    0x8914(%rip),%rax        # 140015168 <.rdata+0x298>
   14000c854:	48 89 c1             	mov    %rax,%rcx
   14000c857:	48 8b 05 e2 ea 00 00 	mov    0xeae2(%rip),%rax        # 14001b340 <__imp__assert>
   14000c85e:	ff d0                	call   *%rax
   14000c860:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c864:	48 8b 40 18          	mov    0x18(%rax),%rax
   14000c868:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000c86c:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c870:	48 89 50 18          	mov    %rdx,0x18(%rax)
   14000c874:	e9 45 01 00 00       	jmp    14000c9be <state__builtin_execute+0x250>
   14000c879:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c87d:	48 8b 40 18          	mov    0x18(%rax),%rax
   14000c881:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000c885:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000c889:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   14000c88d:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   14000c891:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   14000c895:	48 89 c1             	mov    %rax,%rcx
   14000c898:	e8 c3 51 00 00       	call   140011a60 <free>
   14000c89d:	e9 1c 01 00 00       	jmp    14000c9be <state__builtin_execute+0x250>
   14000c8a2:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c8a6:	48 8b 40 18          	mov    0x18(%rax),%rax
   14000c8aa:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000c8ae:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000c8b2:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
   14000c8b6:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   14000c8ba:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c8be:	48 8b 40 18          	mov    0x18(%rax),%rax
   14000c8c2:	48 8d 50 f0          	lea    -0x10(%rax),%rdx
   14000c8c6:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c8ca:	48 89 50 18          	mov    %rdx,0x18(%rax)
   14000c8ce:	c6 45 ff 00          	movb   $0x0,-0x1(%rbp)
   14000c8d2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   14000c8d9:	e9 83 00 00 00       	jmp    14000c961 <state__builtin_execute+0x1f3>
   14000c8de:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c8e2:	48 8b 40 58          	mov    0x58(%rax),%rax
   14000c8e6:	8b 55 f8             	mov    -0x8(%rbp),%edx
   14000c8e9:	48 c1 e2 03          	shl    $0x3,%rdx
   14000c8ed:	48 01 d0             	add    %rdx,%rax
   14000c8f0:	48 8b 00             	mov    (%rax),%rax
   14000c8f3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000c8f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000c8fb:	48 89 c1             	mov    %rax,%rcx
   14000c8fe:	e8 f2 62 ff ff       	call   140002bf5 <type__hash>
   14000c903:	48 89 c2             	mov    %rax,%rdx
   14000c906:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   14000c90a:	48 39 c2             	cmp    %rax,%rdx
   14000c90d:	75 4e                	jne    14000c95d <state__builtin_execute+0x1ef>
   14000c90f:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c913:	48 8b 58 18          	mov    0x18(%rax),%rbx
   14000c917:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000c91b:	48 89 c1             	mov    %rax,%rcx
   14000c91e:	e8 48 58 ff ff       	call   14000216b <type__size>
   14000c923:	48 f7 d8             	neg    %rax
   14000c926:	48 01 c3             	add    %rax,%rbx
   14000c929:	b9 01 00 00 00       	mov    $0x1,%ecx
   14000c92e:	48 8b 05 93 e9 00 00 	mov    0xe993(%rip),%rax        # 14001b2c8 <__imp___acrt_iob_func>
   14000c935:	ff d0                	call   *%rax
   14000c937:	48 89 c2             	mov    %rax,%rdx
   14000c93a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000c93e:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
   14000c943:	41 b9 ff ff ff ff    	mov    $0xffffffff,%r9d
   14000c949:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   14000c94f:	48 89 c1             	mov    %rax,%rcx
   14000c952:	e8 87 69 ff ff       	call   1400032de <type__print>
   14000c957:	c6 45 ff 01          	movb   $0x1,-0x1(%rbp)
   14000c95b:	eb 14                	jmp    14000c971 <state__builtin_execute+0x203>
   14000c95d:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   14000c961:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14000c965:	8b 40 64             	mov    0x64(%rax),%eax
   14000c968:	39 45 f8             	cmp    %eax,-0x8(%rbp)
   14000c96b:	0f 82 6d ff ff ff    	jb     14000c8de <state__builtin_execute+0x170>
   14000c971:	80 7d ff 00          	cmpb   $0x0,-0x1(%rbp)
   14000c975:	75 46                	jne    14000c9bd <state__builtin_execute+0x24f>
   14000c977:	41 b8 c2 03 00 00    	mov    $0x3c2,%r8d
   14000c97d:	48 8d 05 4c 85 00 00 	lea    0x854c(%rip),%rax        # 140014ed0 <.rdata>
   14000c984:	48 89 c2             	mov    %rax,%rdx
   14000c987:	48 8d 05 33 88 00 00 	lea    0x8833(%rip),%rax        # 1400151c1 <.rdata+0x2f1>
   14000c98e:	48 89 c1             	mov    %rax,%rcx
   14000c991:	48 8b 05 a8 e9 00 00 	mov    0xe9a8(%rip),%rax        # 14001b340 <__imp__assert>
   14000c998:	ff d0                	call   *%rax
   14000c99a:	41 b8 c4 03 00 00    	mov    $0x3c4,%r8d
   14000c9a0:	48 8d 05 29 85 00 00 	lea    0x8529(%rip),%rax        # 140014ed0 <.rdata>
   14000c9a7:	48 89 c2             	mov    %rax,%rdx
   14000c9aa:	48 8d 05 4a 85 00 00 	lea    0x854a(%rip),%rax        # 140014efb <.rdata+0x2b>
   14000c9b1:	48 89 c1             	mov    %rax,%rcx
   14000c9b4:	48 8b 05 85 e9 00 00 	mov    0xe985(%rip),%rax        # 14001b340 <__imp__assert>
   14000c9bb:	ff d0                	call   *%rax
   14000c9bd:	90                   	nop
   14000c9be:	90                   	nop
   14000c9bf:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
   14000c9c6:	5b                   	pop    %rbx
   14000c9c7:	5d                   	pop    %rbp
   14000c9c8:	c3                   	ret

000000014000c9c9 <_type__print_value_s8>:
   14000c9c9:	55                   	push   %rbp
   14000c9ca:	48 89 e5             	mov    %rsp,%rbp
   14000c9cd:	48 83 ec 20          	sub    $0x20,%rsp
   14000c9d1:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000c9d5:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000c9d9:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000c9dd:	0f b6 00             	movzbl (%rax),%eax
   14000c9e0:	0f be d0             	movsbl %al,%edx
   14000c9e3:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000c9e7:	41 89 d0             	mov    %edx,%r8d
   14000c9ea:	48 8d 15 db 87 00 00 	lea    0x87db(%rip),%rdx        # 1400151cc <.rdata+0x2fc>
   14000c9f1:	48 89 c1             	mov    %rax,%rcx
   14000c9f4:	e8 97 4c 00 00       	call   140011690 <fprintf>
   14000c9f9:	90                   	nop
   14000c9fa:	48 83 c4 20          	add    $0x20,%rsp
   14000c9fe:	5d                   	pop    %rbp
   14000c9ff:	c3                   	ret

000000014000ca00 <_type__print_value_s16>:
   14000ca00:	55                   	push   %rbp
   14000ca01:	48 89 e5             	mov    %rsp,%rbp
   14000ca04:	48 83 ec 20          	sub    $0x20,%rsp
   14000ca08:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000ca0c:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000ca10:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000ca14:	0f b7 00             	movzwl (%rax),%eax
   14000ca17:	0f bf d0             	movswl %ax,%edx
   14000ca1a:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000ca1e:	41 89 d0             	mov    %edx,%r8d
   14000ca21:	48 8d 15 a4 87 00 00 	lea    0x87a4(%rip),%rdx        # 1400151cc <.rdata+0x2fc>
   14000ca28:	48 89 c1             	mov    %rax,%rcx
   14000ca2b:	e8 60 4c 00 00       	call   140011690 <fprintf>
   14000ca30:	90                   	nop
   14000ca31:	48 83 c4 20          	add    $0x20,%rsp
   14000ca35:	5d                   	pop    %rbp
   14000ca36:	c3                   	ret

000000014000ca37 <_type__print_value_s32>:
   14000ca37:	55                   	push   %rbp
   14000ca38:	48 89 e5             	mov    %rsp,%rbp
   14000ca3b:	48 83 ec 20          	sub    $0x20,%rsp
   14000ca3f:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000ca43:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000ca47:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000ca4b:	8b 10                	mov    (%rax),%edx
   14000ca4d:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000ca51:	41 89 d0             	mov    %edx,%r8d
   14000ca54:	48 8d 15 71 87 00 00 	lea    0x8771(%rip),%rdx        # 1400151cc <.rdata+0x2fc>
   14000ca5b:	48 89 c1             	mov    %rax,%rcx
   14000ca5e:	e8 2d 4c 00 00       	call   140011690 <fprintf>
   14000ca63:	90                   	nop
   14000ca64:	48 83 c4 20          	add    $0x20,%rsp
   14000ca68:	5d                   	pop    %rbp
   14000ca69:	c3                   	ret

000000014000ca6a <_type__print_value_s64>:
   14000ca6a:	55                   	push   %rbp
   14000ca6b:	48 89 e5             	mov    %rsp,%rbp
   14000ca6e:	48 83 ec 20          	sub    $0x20,%rsp
   14000ca72:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000ca76:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000ca7a:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000ca7e:	48 8b 10             	mov    (%rax),%rdx
   14000ca81:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000ca85:	49 89 d0             	mov    %rdx,%r8
   14000ca88:	48 8d 15 40 87 00 00 	lea    0x8740(%rip),%rdx        # 1400151cf <.rdata+0x2ff>
   14000ca8f:	48 89 c1             	mov    %rax,%rcx
   14000ca92:	e8 f9 4b 00 00       	call   140011690 <fprintf>
   14000ca97:	90                   	nop
   14000ca98:	48 83 c4 20          	add    $0x20,%rsp
   14000ca9c:	5d                   	pop    %rbp
   14000ca9d:	c3                   	ret

000000014000ca9e <_type__print_value_u8>:
   14000ca9e:	55                   	push   %rbp
   14000ca9f:	48 89 e5             	mov    %rsp,%rbp
   14000caa2:	48 83 ec 20          	sub    $0x20,%rsp
   14000caa6:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000caaa:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000caae:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000cab2:	0f b6 00             	movzbl (%rax),%eax
   14000cab5:	0f b6 d0             	movzbl %al,%edx
   14000cab8:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000cabc:	41 89 d0             	mov    %edx,%r8d
   14000cabf:	48 8d 15 0e 87 00 00 	lea    0x870e(%rip),%rdx        # 1400151d4 <.rdata+0x304>
   14000cac6:	48 89 c1             	mov    %rax,%rcx
   14000cac9:	e8 c2 4b 00 00       	call   140011690 <fprintf>
   14000cace:	90                   	nop
   14000cacf:	48 83 c4 20          	add    $0x20,%rsp
   14000cad3:	5d                   	pop    %rbp
   14000cad4:	c3                   	ret

000000014000cad5 <_type__print_value_u16>:
   14000cad5:	55                   	push   %rbp
   14000cad6:	48 89 e5             	mov    %rsp,%rbp
   14000cad9:	48 83 ec 20          	sub    $0x20,%rsp
   14000cadd:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000cae1:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000cae5:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000cae9:	0f b7 00             	movzwl (%rax),%eax
   14000caec:	0f b7 d0             	movzwl %ax,%edx
   14000caef:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000caf3:	41 89 d0             	mov    %edx,%r8d
   14000caf6:	48 8d 15 d7 86 00 00 	lea    0x86d7(%rip),%rdx        # 1400151d4 <.rdata+0x304>
   14000cafd:	48 89 c1             	mov    %rax,%rcx
   14000cb00:	e8 8b 4b 00 00       	call   140011690 <fprintf>
   14000cb05:	90                   	nop
   14000cb06:	48 83 c4 20          	add    $0x20,%rsp
   14000cb0a:	5d                   	pop    %rbp
   14000cb0b:	c3                   	ret

000000014000cb0c <_type__print_value_u32>:
   14000cb0c:	55                   	push   %rbp
   14000cb0d:	48 89 e5             	mov    %rsp,%rbp
   14000cb10:	48 83 ec 20          	sub    $0x20,%rsp
   14000cb14:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000cb18:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000cb1c:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000cb20:	8b 10                	mov    (%rax),%edx
   14000cb22:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000cb26:	41 89 d0             	mov    %edx,%r8d
   14000cb29:	48 8d 15 a4 86 00 00 	lea    0x86a4(%rip),%rdx        # 1400151d4 <.rdata+0x304>
   14000cb30:	48 89 c1             	mov    %rax,%rcx
   14000cb33:	e8 58 4b 00 00       	call   140011690 <fprintf>
   14000cb38:	90                   	nop
   14000cb39:	48 83 c4 20          	add    $0x20,%rsp
   14000cb3d:	5d                   	pop    %rbp
   14000cb3e:	c3                   	ret

000000014000cb3f <_type__print_value_u64>:
   14000cb3f:	55                   	push   %rbp
   14000cb40:	48 89 e5             	mov    %rsp,%rbp
   14000cb43:	48 83 ec 20          	sub    $0x20,%rsp
   14000cb47:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000cb4b:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000cb4f:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000cb53:	48 8b 10             	mov    (%rax),%rdx
   14000cb56:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000cb5a:	49 89 d0             	mov    %rdx,%r8
   14000cb5d:	48 8d 15 73 86 00 00 	lea    0x8673(%rip),%rdx        # 1400151d7 <.rdata+0x307>
   14000cb64:	48 89 c1             	mov    %rax,%rcx
   14000cb67:	e8 24 4b 00 00       	call   140011690 <fprintf>
   14000cb6c:	90                   	nop
   14000cb6d:	48 83 c4 20          	add    $0x20,%rsp
   14000cb71:	5d                   	pop    %rbp
   14000cb72:	c3                   	ret

000000014000cb73 <_type__print_value_r32>:
   14000cb73:	55                   	push   %rbp
   14000cb74:	48 89 e5             	mov    %rsp,%rbp
   14000cb77:	48 83 ec 20          	sub    $0x20,%rsp
   14000cb7b:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000cb7f:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000cb83:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000cb87:	f3 0f 10 00          	movss  (%rax),%xmm0
   14000cb8b:	f3 0f 5a c0          	cvtss2sd %xmm0,%xmm0
   14000cb8f:	66 48 0f 7e c0       	movq   %xmm0,%rax
   14000cb94:	48 89 c2             	mov    %rax,%rdx
   14000cb97:	66 48 0f 6e c2       	movq   %rdx,%xmm0
   14000cb9c:	48 89 c2             	mov    %rax,%rdx
   14000cb9f:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000cba3:	66 0f 28 d0          	movapd %xmm0,%xmm2
   14000cba7:	49 89 d0             	mov    %rdx,%r8
   14000cbaa:	48 8d 15 2b 86 00 00 	lea    0x862b(%rip),%rdx        # 1400151dc <.rdata+0x30c>
   14000cbb1:	48 89 c1             	mov    %rax,%rcx
   14000cbb4:	e8 d7 4a 00 00       	call   140011690 <fprintf>
   14000cbb9:	90                   	nop
   14000cbba:	48 83 c4 20          	add    $0x20,%rsp
   14000cbbe:	5d                   	pop    %rbp
   14000cbbf:	c3                   	ret

000000014000cbc0 <_type__print_value_r64>:
   14000cbc0:	55                   	push   %rbp
   14000cbc1:	48 89 e5             	mov    %rsp,%rbp
   14000cbc4:	48 83 ec 20          	sub    $0x20,%rsp
   14000cbc8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000cbcc:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000cbd0:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000cbd4:	f2 0f 10 00          	movsd  (%rax),%xmm0
   14000cbd8:	66 48 0f 7e c0       	movq   %xmm0,%rax
   14000cbdd:	48 89 c2             	mov    %rax,%rdx
   14000cbe0:	66 48 0f 6e c2       	movq   %rdx,%xmm0
   14000cbe5:	48 89 c2             	mov    %rax,%rdx
   14000cbe8:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000cbec:	66 0f 28 d0          	movapd %xmm0,%xmm2
   14000cbf0:	49 89 d0             	mov    %rdx,%r8
   14000cbf3:	48 8d 15 e5 85 00 00 	lea    0x85e5(%rip),%rdx        # 1400151df <.rdata+0x30f>
   14000cbfa:	48 89 c1             	mov    %rax,%rcx
   14000cbfd:	e8 8e 4a 00 00       	call   140011690 <fprintf>
   14000cc02:	90                   	nop
   14000cc03:	48 83 c4 20          	add    $0x20,%rsp
   14000cc07:	5d                   	pop    %rbp
   14000cc08:	c3                   	ret

000000014000cc09 <_type__print_value_reg>:
   14000cc09:	55                   	push   %rbp
   14000cc0a:	48 89 e5             	mov    %rsp,%rbp
   14000cc0d:	48 83 ec 30          	sub    $0x30,%rsp
   14000cc11:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000cc15:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000cc19:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14000cc1d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000cc21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000cc25:	48 8b 10             	mov    (%rax),%rdx
   14000cc28:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000cc2c:	49 89 d0             	mov    %rdx,%r8
   14000cc2f:	48 8d 15 a1 85 00 00 	lea    0x85a1(%rip),%rdx        # 1400151d7 <.rdata+0x307>
   14000cc36:	48 89 c1             	mov    %rax,%rcx
   14000cc39:	e8 52 4a 00 00       	call   140011690 <fprintf>
   14000cc3e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000cc42:	48 8b 50 08          	mov    0x8(%rax),%rdx
   14000cc46:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000cc4a:	49 89 d0             	mov    %rdx,%r8
   14000cc4d:	48 8d 15 8f 85 00 00 	lea    0x858f(%rip),%rdx        # 1400151e3 <.rdata+0x313>
   14000cc54:	48 89 c1             	mov    %rax,%rcx
   14000cc57:	e8 34 4a 00 00       	call   140011690 <fprintf>
   14000cc5c:	90                   	nop
   14000cc5d:	48 83 c4 30          	add    $0x30,%rsp
   14000cc61:	5d                   	pop    %rbp
   14000cc62:	c3                   	ret

000000014000cc63 <state__create_atom_types>:
   14000cc63:	55                   	push   %rbp
   14000cc64:	48 89 e5             	mov    %rsp,%rbp
   14000cc67:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   14000cc6b:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000cc6f:	4c 8d 0d 53 fd ff ff 	lea    -0x2ad(%rip),%r9        # 14000c9c9 <_type__print_value_s8>
   14000cc76:	41 b8 01 00 00 00    	mov    $0x1,%r8d
   14000cc7c:	48 8d 05 67 85 00 00 	lea    0x8567(%rip),%rax        # 1400151ea <.rdata+0x31a>
   14000cc83:	48 89 c2             	mov    %rax,%rdx
   14000cc86:	48 8d 05 5d 85 00 00 	lea    0x855d(%rip),%rax        # 1400151ea <.rdata+0x31a>
   14000cc8d:	48 89 c1             	mov    %rax,%rcx
   14000cc90:	e8 72 52 ff ff       	call   140001f07 <type_atom__create>
   14000cc95:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000cc99:	4c 8d 0d 60 fd ff ff 	lea    -0x2a0(%rip),%r9        # 14000ca00 <_type__print_value_s16>
   14000cca0:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000cca6:	48 8d 05 40 85 00 00 	lea    0x8540(%rip),%rax        # 1400151ed <.rdata+0x31d>
   14000ccad:	48 89 c2             	mov    %rax,%rdx
   14000ccb0:	48 8d 05 36 85 00 00 	lea    0x8536(%rip),%rax        # 1400151ed <.rdata+0x31d>
   14000ccb7:	48 89 c1             	mov    %rax,%rcx
   14000ccba:	e8 48 52 ff ff       	call   140001f07 <type_atom__create>
   14000ccbf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000ccc3:	4c 8d 0d 6d fd ff ff 	lea    -0x293(%rip),%r9        # 14000ca37 <_type__print_value_s32>
   14000ccca:	41 b8 04 00 00 00    	mov    $0x4,%r8d
   14000ccd0:	48 8d 05 f6 83 00 00 	lea    0x83f6(%rip),%rax        # 1400150cd <.rdata+0x1fd>
   14000ccd7:	48 89 c2             	mov    %rax,%rdx
   14000ccda:	48 8d 05 ec 83 00 00 	lea    0x83ec(%rip),%rax        # 1400150cd <.rdata+0x1fd>
   14000cce1:	48 89 c1             	mov    %rax,%rcx
   14000cce4:	e8 1e 52 ff ff       	call   140001f07 <type_atom__create>
   14000cce9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000cced:	4c 8d 0d 76 fd ff ff 	lea    -0x28a(%rip),%r9        # 14000ca6a <_type__print_value_s64>
   14000ccf4:	41 b8 08 00 00 00    	mov    $0x8,%r8d
   14000ccfa:	48 8d 05 c8 83 00 00 	lea    0x83c8(%rip),%rax        # 1400150c9 <.rdata+0x1f9>
   14000cd01:	48 89 c2             	mov    %rax,%rdx
   14000cd04:	48 8d 05 be 83 00 00 	lea    0x83be(%rip),%rax        # 1400150c9 <.rdata+0x1f9>
   14000cd0b:	48 89 c1             	mov    %rax,%rcx
   14000cd0e:	e8 f4 51 ff ff       	call   140001f07 <type_atom__create>
   14000cd13:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   14000cd17:	4c 8d 0d 80 fd ff ff 	lea    -0x280(%rip),%r9        # 14000ca9e <_type__print_value_u8>
   14000cd1e:	41 b8 01 00 00 00    	mov    $0x1,%r8d
   14000cd24:	48 8d 05 c6 84 00 00 	lea    0x84c6(%rip),%rax        # 1400151f1 <.rdata+0x321>
   14000cd2b:	48 89 c2             	mov    %rax,%rdx
   14000cd2e:	48 8d 05 bc 84 00 00 	lea    0x84bc(%rip),%rax        # 1400151f1 <.rdata+0x321>
   14000cd35:	48 89 c1             	mov    %rax,%rcx
   14000cd38:	e8 ca 51 ff ff       	call   140001f07 <type_atom__create>
   14000cd3d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   14000cd41:	4c 8d 0d 8d fd ff ff 	lea    -0x273(%rip),%r9        # 14000cad5 <_type__print_value_u16>
   14000cd48:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000cd4e:	48 8d 05 9f 84 00 00 	lea    0x849f(%rip),%rax        # 1400151f4 <.rdata+0x324>
   14000cd55:	48 89 c2             	mov    %rax,%rdx
   14000cd58:	48 8d 05 95 84 00 00 	lea    0x8495(%rip),%rax        # 1400151f4 <.rdata+0x324>
   14000cd5f:	48 89 c1             	mov    %rax,%rcx
   14000cd62:	e8 a0 51 ff ff       	call   140001f07 <type_atom__create>
   14000cd67:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   14000cd6b:	4c 8d 0d 9a fd ff ff 	lea    -0x266(%rip),%r9        # 14000cb0c <_type__print_value_u32>
   14000cd72:	41 b8 04 00 00 00    	mov    $0x4,%r8d
   14000cd78:	48 8d 05 79 84 00 00 	lea    0x8479(%rip),%rax        # 1400151f8 <.rdata+0x328>
   14000cd7f:	48 89 c2             	mov    %rax,%rdx
   14000cd82:	48 8d 05 6f 84 00 00 	lea    0x846f(%rip),%rax        # 1400151f8 <.rdata+0x328>
   14000cd89:	48 89 c1             	mov    %rax,%rcx
   14000cd8c:	e8 76 51 ff ff       	call   140001f07 <type_atom__create>
   14000cd91:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   14000cd95:	4c 8d 0d a3 fd ff ff 	lea    -0x25d(%rip),%r9        # 14000cb3f <_type__print_value_u64>
   14000cd9c:	41 b8 08 00 00 00    	mov    $0x8,%r8d
   14000cda2:	48 8d 05 53 84 00 00 	lea    0x8453(%rip),%rax        # 1400151fc <.rdata+0x32c>
   14000cda9:	48 89 c2             	mov    %rax,%rdx
   14000cdac:	48 8d 05 49 84 00 00 	lea    0x8449(%rip),%rax        # 1400151fc <.rdata+0x32c>
   14000cdb3:	48 89 c1             	mov    %rax,%rcx
   14000cdb6:	e8 4c 51 ff ff       	call   140001f07 <type_atom__create>
   14000cdbb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   14000cdbf:	4c 8d 0d ad fd ff ff 	lea    -0x253(%rip),%r9        # 14000cb73 <_type__print_value_r32>
   14000cdc6:	41 b8 04 00 00 00    	mov    $0x4,%r8d
   14000cdcc:	48 8d 05 2d 84 00 00 	lea    0x842d(%rip),%rax        # 140015200 <.rdata+0x330>
   14000cdd3:	48 89 c2             	mov    %rax,%rdx
   14000cdd6:	48 8d 05 23 84 00 00 	lea    0x8423(%rip),%rax        # 140015200 <.rdata+0x330>
   14000cddd:	48 89 c1             	mov    %rax,%rcx
   14000cde0:	e8 22 51 ff ff       	call   140001f07 <type_atom__create>
   14000cde5:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   14000cde9:	4c 8d 0d d0 fd ff ff 	lea    -0x230(%rip),%r9        # 14000cbc0 <_type__print_value_r64>
   14000cdf0:	41 b8 08 00 00 00    	mov    $0x8,%r8d
   14000cdf6:	48 8d 05 07 84 00 00 	lea    0x8407(%rip),%rax        # 140015204 <.rdata+0x334>
   14000cdfd:	48 89 c2             	mov    %rax,%rdx
   14000ce00:	48 8d 05 fd 83 00 00 	lea    0x83fd(%rip),%rax        # 140015204 <.rdata+0x334>
   14000ce07:	48 89 c1             	mov    %rax,%rcx
   14000ce0a:	e8 f8 50 ff ff       	call   140001f07 <type_atom__create>
   14000ce0f:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
   14000ce13:	4c 8d 0d ef fd ff ff 	lea    -0x211(%rip),%r9        # 14000cc09 <_type__print_value_reg>
   14000ce1a:	41 b8 10 00 00 00    	mov    $0x10,%r8d
   14000ce20:	48 8d 05 c7 82 00 00 	lea    0x82c7(%rip),%rax        # 1400150ee <.rdata+0x21e>
   14000ce27:	48 89 c2             	mov    %rax,%rdx
   14000ce2a:	48 8d 05 bd 82 00 00 	lea    0x82bd(%rip),%rax        # 1400150ee <.rdata+0x21e>
   14000ce31:	48 89 c1             	mov    %rax,%rcx
   14000ce34:	e8 ce 50 ff ff       	call   140001f07 <type_atom__create>
   14000ce39:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
   14000ce3d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   14000ce41:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000ce45:	48 89 c1             	mov    %rax,%rcx
   14000ce48:	e8 93 d8 ff ff       	call   14000a6e0 <state__type_add>
   14000ce4d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   14000ce51:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000ce55:	48 89 c1             	mov    %rax,%rcx
   14000ce58:	e8 83 d8 ff ff       	call   14000a6e0 <state__type_add>
   14000ce5d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   14000ce61:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000ce65:	48 89 c1             	mov    %rax,%rcx
   14000ce68:	e8 73 d8 ff ff       	call   14000a6e0 <state__type_add>
   14000ce6d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   14000ce71:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000ce75:	48 89 c1             	mov    %rax,%rcx
   14000ce78:	e8 63 d8 ff ff       	call   14000a6e0 <state__type_add>
   14000ce7d:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   14000ce81:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000ce85:	48 89 c1             	mov    %rax,%rcx
   14000ce88:	e8 53 d8 ff ff       	call   14000a6e0 <state__type_add>
   14000ce8d:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   14000ce91:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000ce95:	48 89 c1             	mov    %rax,%rcx
   14000ce98:	e8 43 d8 ff ff       	call   14000a6e0 <state__type_add>
   14000ce9d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   14000cea1:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000cea5:	48 89 c1             	mov    %rax,%rcx
   14000cea8:	e8 33 d8 ff ff       	call   14000a6e0 <state__type_add>
   14000cead:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   14000ceb1:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000ceb5:	48 89 c1             	mov    %rax,%rcx
   14000ceb8:	e8 23 d8 ff ff       	call   14000a6e0 <state__type_add>
   14000cebd:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   14000cec1:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000cec5:	48 89 c1             	mov    %rax,%rcx
   14000cec8:	e8 13 d8 ff ff       	call   14000a6e0 <state__type_add>
   14000cecd:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   14000ced1:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000ced5:	48 89 c1             	mov    %rax,%rcx
   14000ced8:	e8 03 d8 ff ff       	call   14000a6e0 <state__type_add>
   14000cedd:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   14000cee1:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000cee5:	48 89 c1             	mov    %rax,%rcx
   14000cee8:	e8 f3 d7 ff ff       	call   14000a6e0 <state__type_add>
   14000ceed:	90                   	nop
   14000ceee:	48 83 ec 80          	sub    $0xffffffffffffff80,%rsp
   14000cef2:	5d                   	pop    %rbp
   14000cef3:	c3                   	ret

000000014000cef4 <state__create_user_types>:
   14000cef4:	55                   	push   %rbp
   14000cef5:	48 89 e5             	mov    %rsp,%rbp
   14000cef8:	48 83 ec 50          	sub    $0x50,%rsp
   14000cefc:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000cf00:	48 8d 05 74 81 00 00 	lea    0x8174(%rip),%rax        # 14001507b <.rdata+0x1ab>
   14000cf07:	48 89 c1             	mov    %rax,%rcx
   14000cf0a:	e8 6c 55 ff ff       	call   14000247b <type_struct__create>
   14000cf0f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000cf13:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   14000cf17:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000cf1b:	48 89 c1             	mov    %rax,%rcx
   14000cf1e:	e8 bd d7 ff ff       	call   14000a6e0 <state__type_add>
   14000cf23:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000cf27:	48 8d 15 bc 82 00 00 	lea    0x82bc(%rip),%rdx        # 1400151ea <.rdata+0x31a>
   14000cf2e:	48 89 c1             	mov    %rax,%rcx
   14000cf31:	e8 a4 d8 ff ff       	call   14000a7da <state__type_find>
   14000cf36:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000cf3a:	4c 8d 0d bf fa ff ff 	lea    -0x541(%rip),%r9        # 14000ca00 <_type__print_value_s16>
   14000cf41:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   14000cf47:	48 8d 05 ba 82 00 00 	lea    0x82ba(%rip),%rax        # 140015208 <.rdata+0x338>
   14000cf4e:	48 89 c2             	mov    %rax,%rdx
   14000cf51:	48 8d 05 b0 82 00 00 	lea    0x82b0(%rip),%rax        # 140015208 <.rdata+0x338>
   14000cf58:	48 89 c1             	mov    %rax,%rcx
   14000cf5b:	e8 a7 4f ff ff       	call   140001f07 <type_atom__create>
   14000cf60:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14000cf64:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14000cf68:	ba 04 00 00 00       	mov    $0x4,%edx
   14000cf6d:	48 89 c1             	mov    %rax,%rcx
   14000cf70:	e8 74 51 ff ff       	call   1400020e9 <type__set_alignment>
   14000cf75:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000cf79:	48 8d 15 7c 82 00 00 	lea    0x827c(%rip),%rdx        # 1400151fc <.rdata+0x32c>
   14000cf80:	48 89 c1             	mov    %rax,%rcx
   14000cf83:	e8 52 d8 ff ff       	call   14000a7da <state__type_find>
   14000cf88:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   14000cf8c:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   14000cf91:	75 23                	jne    14000cfb6 <state__create_user_types+0xc2>
   14000cf93:	41 b8 21 04 00 00    	mov    $0x421,%r8d
   14000cf99:	48 8d 05 30 7f 00 00 	lea    0x7f30(%rip),%rax        # 140014ed0 <.rdata>
   14000cfa0:	48 89 c2             	mov    %rax,%rdx
   14000cfa3:	48 8d 05 6c 82 00 00 	lea    0x826c(%rip),%rax        # 140015216 <.rdata+0x346>
   14000cfaa:	48 89 c1             	mov    %rax,%rcx
   14000cfad:	48 8b 05 8c e3 00 00 	mov    0xe38c(%rip),%rax        # 14001b340 <__imp__assert>
   14000cfb4:	ff d0                	call   *%rax
   14000cfb6:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   14000cfbb:	75 23                	jne    14000cfe0 <state__create_user_types+0xec>
   14000cfbd:	41 b8 22 04 00 00    	mov    $0x422,%r8d
   14000cfc3:	48 8d 05 06 7f 00 00 	lea    0x7f06(%rip),%rax        # 140014ed0 <.rdata>
   14000cfca:	48 89 c2             	mov    %rax,%rdx
   14000cfcd:	48 8d 05 46 82 00 00 	lea    0x8246(%rip),%rax        # 14001521a <.rdata+0x34a>
   14000cfd4:	48 89 c1             	mov    %rax,%rcx
   14000cfd7:	48 8b 05 62 e3 00 00 	mov    0xe362(%rip),%rax        # 14001b340 <__imp__assert>
   14000cfde:	ff d0                	call   *%rax
   14000cfe0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   14000cfe4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000cfe8:	4c 8d 05 71 80 00 00 	lea    0x8071(%rip),%r8        # 140015060 <.rdata+0x190>
   14000cfef:	48 89 c1             	mov    %rax,%rcx
   14000cff2:	e8 dd 54 ff ff       	call   1400024d4 <type_struct__add>
   14000cff7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   14000cffb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000cfff:	4c 8d 05 63 80 00 00 	lea    0x8063(%rip),%r8        # 140015069 <.rdata+0x199>
   14000d006:	48 89 c1             	mov    %rax,%rcx
   14000d009:	e8 c6 54 ff ff       	call   1400024d4 <type_struct__add>
   14000d00e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   14000d012:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000d016:	4c 8d 05 55 80 00 00 	lea    0x8055(%rip),%r8        # 140015072 <.rdata+0x1a2>
   14000d01d:	48 89 c1             	mov    %rax,%rcx
   14000d020:	e8 af 54 ff ff       	call   1400024d4 <type_struct__add>
   14000d025:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000d029:	ba 00 04 00 00       	mov    $0x400,%edx
   14000d02e:	48 89 c1             	mov    %rax,%rcx
   14000d031:	e8 b3 50 ff ff       	call   1400020e9 <type__set_alignment>
   14000d036:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000d03a:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   14000d040:	48 89 c2             	mov    %rax,%rdx
   14000d043:	48 8d 05 d5 81 00 00 	lea    0x81d5(%rip),%rax        # 14001521f <.rdata+0x34f>
   14000d04a:	48 89 c1             	mov    %rax,%rcx
   14000d04d:	e8 d5 57 ff ff       	call   140002827 <type_array__create>
   14000d052:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   14000d056:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   14000d05a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000d05e:	4c 8d 05 21 80 00 00 	lea    0x8021(%rip),%r8        # 140015086 <.rdata+0x1b6>
   14000d065:	48 89 c1             	mov    %rax,%rcx
   14000d068:	e8 67 54 ff ff       	call   1400024d4 <type_struct__add>
   14000d06d:	90                   	nop
   14000d06e:	48 83 c4 50          	add    $0x50,%rsp
   14000d072:	5d                   	pop    %rbp
   14000d073:	c3                   	ret

000000014000d074 <main>:
   14000d074:	55                   	push   %rbp
   14000d075:	57                   	push   %rdi
   14000d076:	48 81 ec 78 06 00 00 	sub    $0x678,%rsp
   14000d07d:	48 8d ac 24 80 00 00 	lea    0x80(%rsp),%rbp
   14000d084:	00 
   14000d085:	e8 bd 2e 00 00       	call   14000ff47 <__main>
   14000d08a:	c7 85 f8 04 00 00 00 	movl   $0x1400000,0x4f8(%rbp)
   14000d091:	00 40 01 
   14000d094:	8b 85 f8 04 00 00    	mov    0x4f8(%rbp),%eax
   14000d09a:	89 c0                	mov    %eax,%eax
   14000d09c:	48 89 c1             	mov    %rax,%rcx
   14000d09f:	e8 cc 49 00 00       	call   140011a70 <malloc>
   14000d0a4:	48 89 85 f0 04 00 00 	mov    %rax,0x4f0(%rbp)
   14000d0ab:	48 8d 95 80 04 00 00 	lea    0x480(%rbp),%rdx
   14000d0b2:	b8 00 00 00 00       	mov    $0x0,%eax
   14000d0b7:	b9 0e 00 00 00       	mov    $0xe,%ecx
   14000d0bc:	48 89 d7             	mov    %rdx,%rdi
   14000d0bf:	f3 48 ab             	rep stos %rax,%es:(%rdi)
   14000d0c2:	48 8d 85 80 04 00 00 	lea    0x480(%rbp),%rax
   14000d0c9:	48 89 c1             	mov    %rax,%rcx
   14000d0cc:	e8 92 fb ff ff       	call   14000cc63 <state__create_atom_types>
   14000d0d1:	48 8d 85 80 04 00 00 	lea    0x480(%rbp),%rax
   14000d0d8:	48 89 c1             	mov    %rax,%rcx
   14000d0db:	e8 14 fe ff ff       	call   14000cef4 <state__create_user_types>
   14000d0e0:	c7 85 90 04 00 00 00 	movl   $0x1000,0x490(%rbp)
   14000d0e7:	10 00 00 
   14000d0ea:	8b 85 90 04 00 00    	mov    0x490(%rbp),%eax
   14000d0f0:	89 c0                	mov    %eax,%eax
   14000d0f2:	48 89 c1             	mov    %rax,%rcx
   14000d0f5:	e8 76 49 00 00       	call   140011a70 <malloc>
   14000d0fa:	48 89 85 88 04 00 00 	mov    %rax,0x488(%rbp)
   14000d101:	48 c7 85 e0 05 00 00 	movq   $0x1000,0x5e0(%rbp)
   14000d108:	00 10 00 00 
   14000d10c:	48 8b 85 e0 05 00 00 	mov    0x5e0(%rbp),%rax
   14000d113:	48 89 c1             	mov    %rax,%rcx
   14000d116:	e8 55 49 00 00       	call   140011a70 <malloc>
   14000d11b:	48 89 85 a0 04 00 00 	mov    %rax,0x4a0(%rbp)
   14000d122:	48 8b 95 a0 04 00 00 	mov    0x4a0(%rbp),%rdx
   14000d129:	48 8b 85 e0 05 00 00 	mov    0x5e0(%rbp),%rax
   14000d130:	48 01 d0             	add    %rdx,%rax
   14000d133:	48 89 85 a8 04 00 00 	mov    %rax,0x4a8(%rbp)
   14000d13a:	48 8b 85 88 04 00 00 	mov    0x488(%rbp),%rax
   14000d141:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000d148:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000d14f:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000d156:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d15d:	48 89 85 b0 04 00 00 	mov    %rax,0x4b0(%rbp)
   14000d164:	c7 85 c4 04 00 00 00 	movl   $0x400,0x4c4(%rbp)
   14000d16b:	04 00 00 
   14000d16e:	8b 85 c4 04 00 00    	mov    0x4c4(%rbp),%eax
   14000d174:	89 c0                	mov    %eax,%eax
   14000d176:	48 c1 e0 03          	shl    $0x3,%rax
   14000d17a:	48 89 c1             	mov    %rax,%rcx
   14000d17d:	e8 ee 48 00 00       	call   140011a70 <malloc>
   14000d182:	48 89 85 b8 04 00 00 	mov    %rax,0x4b8(%rbp)
   14000d189:	48 8d 85 80 04 00 00 	lea    0x480(%rbp),%rax
   14000d190:	48 89 c1             	mov    %rax,%rcx
   14000d193:	e8 cb f3 ff ff       	call   14000c563 <state__compile>
   14000d198:	48 89 85 d8 05 00 00 	mov    %rax,0x5d8(%rbp)
   14000d19f:	48 c7 85 d0 05 00 00 	movq   $0x0,0x5d0(%rbp)
   14000d1a6:	00 00 00 00 
   14000d1aa:	48 c7 85 c8 05 00 00 	movq   $0x0,0x5c8(%rbp)
   14000d1b1:	00 00 00 00 
   14000d1b5:	c7 85 c4 05 00 00 01 	movl   $0x1,0x5c4(%rbp)
   14000d1bc:	00 00 00 
   14000d1bf:	c7 85 ec 05 00 00 00 	movl   $0x0,0x5ec(%rbp)
   14000d1c6:	00 00 00 
   14000d1c9:	e9 69 2c 00 00       	jmp    14000fe37 <main+0x2dc3>
   14000d1ce:	c6 85 e8 04 00 00 01 	movb   $0x1,0x4e8(%rbp)
   14000d1d5:	48 8b 85 d8 05 00 00 	mov    0x5d8(%rbp),%rax
   14000d1dc:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000d1e3:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000d1ea:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000d1f1:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000d1f8:	48 89 85 b0 04 00 00 	mov    %rax,0x4b0(%rbp)
   14000d1ff:	e9 1d 2c 00 00       	jmp    14000fe21 <main+0x2dad>
   14000d204:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000d20b:	48 8d 50 01          	lea    0x1(%rax),%rdx
   14000d20f:	48 89 95 80 04 00 00 	mov    %rdx,0x480(%rbp)
   14000d216:	0f b6 00             	movzbl (%rax),%eax
   14000d219:	88 85 c3 05 00 00    	mov    %al,0x5c3(%rbp)
   14000d21f:	0f b6 85 c3 05 00 00 	movzbl 0x5c3(%rbp),%eax
   14000d226:	83 f8 32             	cmp    $0x32,%eax
   14000d229:	0f 87 cf 2b 00 00    	ja     14000fdfe <main+0x2d8a>
   14000d22f:	89 c0                	mov    %eax,%eax
   14000d231:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   14000d238:	00 
   14000d239:	48 8d 05 00 88 00 00 	lea    0x8800(%rip),%rax        # 140015a40 <.rdata+0xb70>
   14000d240:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   14000d243:	48 98                	cltq
   14000d245:	48 8d 15 f4 87 00 00 	lea    0x87f4(%rip),%rdx        # 140015a40 <.rdata+0xb70>
   14000d24c:	48 01 d0             	add    %rdx,%rax
   14000d24f:	ff e0                	jmp    *%rax
   14000d251:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000d258:	48 8b 50 08          	mov    0x8(%rax),%rdx
   14000d25c:	48 8b 00             	mov    (%rax),%rax
   14000d25f:	48 89 85 70 04 00 00 	mov    %rax,0x470(%rbp)
   14000d266:	48 89 95 78 04 00 00 	mov    %rdx,0x478(%rbp)
   14000d26d:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000d274:	48 83 c0 10          	add    $0x10,%rax
   14000d278:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000d27f:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000d286:	48 8b 85 70 04 00 00 	mov    0x470(%rbp),%rax
   14000d28d:	48 8b 95 78 04 00 00 	mov    0x478(%rbp),%rdx
   14000d294:	48 89 01             	mov    %rax,(%rcx)
   14000d297:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000d29b:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d2a2:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000d2a6:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000d2ad:	48 39 c2             	cmp    %rax,%rdx
   14000d2b0:	73 23                	jae    14000d2d5 <main+0x261>
   14000d2b2:	41 b8 53 04 00 00    	mov    $0x453,%r8d
   14000d2b8:	48 8d 05 11 7c 00 00 	lea    0x7c11(%rip),%rax        # 140014ed0 <.rdata>
   14000d2bf:	48 89 c2             	mov    %rax,%rdx
   14000d2c2:	48 8d 05 5f 7f 00 00 	lea    0x7f5f(%rip),%rax        # 140015228 <.rdata+0x358>
   14000d2c9:	48 89 c1             	mov    %rax,%rcx
   14000d2cc:	48 8b 05 6d e0 00 00 	mov    0xe06d(%rip),%rax        # 14001b340 <__imp__assert>
   14000d2d3:	ff d0                	call   *%rax
   14000d2d5:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d2dc:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000d2e0:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000d2e7:	48 39 c2             	cmp    %rax,%rdx
   14000d2ea:	72 23                	jb     14000d30f <main+0x29b>
   14000d2ec:	41 b8 53 04 00 00    	mov    $0x453,%r8d
   14000d2f2:	48 8d 05 d7 7b 00 00 	lea    0x7bd7(%rip),%rax        # 140014ed0 <.rdata>
   14000d2f9:	48 89 c2             	mov    %rax,%rdx
   14000d2fc:	48 8d 05 7d 7f 00 00 	lea    0x7f7d(%rip),%rax        # 140015280 <.rdata+0x3b0>
   14000d303:	48 89 c1             	mov    %rax,%rcx
   14000d306:	48 8b 05 33 e0 00 00 	mov    0xe033(%rip),%rax        # 14001b340 <__imp__assert>
   14000d30d:	ff d0                	call   *%rax
   14000d30f:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d316:	48 83 c0 10          	add    $0x10,%rax
   14000d31a:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000d321:	e9 fb 2a 00 00       	jmp    14000fe21 <main+0x2dad>
   14000d326:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000d32d:	48 8b 00             	mov    (%rax),%rax
   14000d330:	48 89 85 10 05 00 00 	mov    %rax,0x510(%rbp)
   14000d337:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000d33e:	48 83 c0 08          	add    $0x8,%rax
   14000d342:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000d349:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000d350:	48 8b 00             	mov    (%rax),%rax
   14000d353:	48 89 85 08 05 00 00 	mov    %rax,0x508(%rbp)
   14000d35a:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000d361:	48 83 c0 08          	add    $0x8,%rax
   14000d365:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000d36c:	8b 95 c0 04 00 00    	mov    0x4c0(%rbp),%edx
   14000d372:	8b 85 c4 04 00 00    	mov    0x4c4(%rbp),%eax
   14000d378:	39 c2                	cmp    %eax,%edx
   14000d37a:	72 23                	jb     14000d39f <main+0x32b>
   14000d37c:	41 b8 5a 04 00 00    	mov    $0x45a,%r8d
   14000d382:	48 8d 05 47 7b 00 00 	lea    0x7b47(%rip),%rax        # 140014ed0 <.rdata>
   14000d389:	48 89 c2             	mov    %rax,%rdx
   14000d38c:	48 8d 05 4d 7f 00 00 	lea    0x7f4d(%rip),%rax        # 1400152e0 <.rdata+0x410>
   14000d393:	48 89 c1             	mov    %rax,%rcx
   14000d396:	48 8b 05 a3 df 00 00 	mov    0xdfa3(%rip),%rax        # 14001b340 <__imp__assert>
   14000d39d:	ff d0                	call   *%rax
   14000d39f:	48 8b 8d b8 04 00 00 	mov    0x4b8(%rbp),%rcx
   14000d3a6:	8b 85 c0 04 00 00    	mov    0x4c0(%rbp),%eax
   14000d3ac:	8d 50 01             	lea    0x1(%rax),%edx
   14000d3af:	89 95 c0 04 00 00    	mov    %edx,0x4c0(%rbp)
   14000d3b5:	89 c0                	mov    %eax,%eax
   14000d3b7:	48 c1 e0 03          	shl    $0x3,%rax
   14000d3bb:	48 8d 14 01          	lea    (%rcx,%rax,1),%rdx
   14000d3bf:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d3c6:	48 89 02             	mov    %rax,(%rdx)
   14000d3c9:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d3d0:	ba 00 00 00 00       	mov    $0x0,%edx
   14000d3d5:	48 f7 b5 10 05 00 00 	divq   0x510(%rbp)
   14000d3dc:	48 89 95 00 05 00 00 	mov    %rdx,0x500(%rbp)
   14000d3e3:	48 83 bd 00 05 00 00 	cmpq   $0x0,0x500(%rbp)
   14000d3ea:	00 
   14000d3eb:	0f 84 ad 00 00 00    	je     14000d49e <main+0x42a>
   14000d3f1:	48 8b 95 98 04 00 00 	mov    0x498(%rbp),%rdx
   14000d3f8:	48 8b 85 10 05 00 00 	mov    0x510(%rbp),%rax
   14000d3ff:	48 2b 85 00 05 00 00 	sub    0x500(%rbp),%rax
   14000d406:	48 01 c2             	add    %rax,%rdx
   14000d409:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000d410:	48 39 c2             	cmp    %rax,%rdx
   14000d413:	73 23                	jae    14000d438 <main+0x3c4>
   14000d415:	41 b8 5e 04 00 00    	mov    $0x45e,%r8d
   14000d41b:	48 8d 05 ae 7a 00 00 	lea    0x7aae(%rip),%rax        # 140014ed0 <.rdata>
   14000d422:	48 89 c2             	mov    %rax,%rdx
   14000d425:	48 8d 05 0c 7f 00 00 	lea    0x7f0c(%rip),%rax        # 140015338 <.rdata+0x468>
   14000d42c:	48 89 c1             	mov    %rax,%rcx
   14000d42f:	48 8b 05 0a df 00 00 	mov    0xdf0a(%rip),%rax        # 14001b340 <__imp__assert>
   14000d436:	ff d0                	call   *%rax
   14000d438:	48 8b 95 98 04 00 00 	mov    0x498(%rbp),%rdx
   14000d43f:	48 8b 85 10 05 00 00 	mov    0x510(%rbp),%rax
   14000d446:	48 2b 85 00 05 00 00 	sub    0x500(%rbp),%rax
   14000d44d:	48 01 c2             	add    %rax,%rdx
   14000d450:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000d457:	48 39 c2             	cmp    %rax,%rdx
   14000d45a:	72 23                	jb     14000d47f <main+0x40b>
   14000d45c:	41 b8 5e 04 00 00    	mov    $0x45e,%r8d
   14000d462:	48 8d 05 67 7a 00 00 	lea    0x7a67(%rip),%rax        # 140014ed0 <.rdata>
   14000d469:	48 89 c2             	mov    %rax,%rdx
   14000d46c:	48 8d 05 25 7f 00 00 	lea    0x7f25(%rip),%rax        # 140015398 <.rdata+0x4c8>
   14000d473:	48 89 c1             	mov    %rax,%rcx
   14000d476:	48 8b 05 c3 de 00 00 	mov    0xdec3(%rip),%rax        # 14001b340 <__imp__assert>
   14000d47d:	ff d0                	call   *%rax
   14000d47f:	48 8b 95 98 04 00 00 	mov    0x498(%rbp),%rdx
   14000d486:	48 8b 85 10 05 00 00 	mov    0x510(%rbp),%rax
   14000d48d:	48 2b 85 00 05 00 00 	sub    0x500(%rbp),%rax
   14000d494:	48 01 d0             	add    %rdx,%rax
   14000d497:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000d49e:	48 8b 95 98 04 00 00 	mov    0x498(%rbp),%rdx
   14000d4a5:	48 8b 85 08 05 00 00 	mov    0x508(%rbp),%rax
   14000d4ac:	48 01 c2             	add    %rax,%rdx
   14000d4af:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000d4b6:	48 39 c2             	cmp    %rax,%rdx
   14000d4b9:	73 23                	jae    14000d4de <main+0x46a>
   14000d4bb:	41 b8 60 04 00 00    	mov    $0x460,%r8d
   14000d4c1:	48 8d 05 08 7a 00 00 	lea    0x7a08(%rip),%rax        # 140014ed0 <.rdata>
   14000d4c8:	48 89 c2             	mov    %rax,%rdx
   14000d4cb:	48 8d 05 2e 7f 00 00 	lea    0x7f2e(%rip),%rax        # 140015400 <.rdata+0x530>
   14000d4d2:	48 89 c1             	mov    %rax,%rcx
   14000d4d5:	48 8b 05 64 de 00 00 	mov    0xde64(%rip),%rax        # 14001b340 <__imp__assert>
   14000d4dc:	ff d0                	call   *%rax
   14000d4de:	48 8b 95 98 04 00 00 	mov    0x498(%rbp),%rdx
   14000d4e5:	48 8b 85 08 05 00 00 	mov    0x508(%rbp),%rax
   14000d4ec:	48 01 c2             	add    %rax,%rdx
   14000d4ef:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000d4f6:	48 39 c2             	cmp    %rax,%rdx
   14000d4f9:	72 23                	jb     14000d51e <main+0x4aa>
   14000d4fb:	41 b8 60 04 00 00    	mov    $0x460,%r8d
   14000d501:	48 8d 05 c8 79 00 00 	lea    0x79c8(%rip),%rax        # 140014ed0 <.rdata>
   14000d508:	48 89 c2             	mov    %rax,%rdx
   14000d50b:	48 8d 05 3e 7f 00 00 	lea    0x7f3e(%rip),%rax        # 140015450 <.rdata+0x580>
   14000d512:	48 89 c1             	mov    %rax,%rcx
   14000d515:	48 8b 05 24 de 00 00 	mov    0xde24(%rip),%rax        # 14001b340 <__imp__assert>
   14000d51c:	ff d0                	call   *%rax
   14000d51e:	48 8b 95 98 04 00 00 	mov    0x498(%rbp),%rdx
   14000d525:	48 8b 85 08 05 00 00 	mov    0x508(%rbp),%rax
   14000d52c:	48 01 d0             	add    %rdx,%rax
   14000d52f:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000d536:	e9 e6 28 00 00       	jmp    14000fe21 <main+0x2dad>
   14000d53b:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000d542:	48 8b 50 08          	mov    0x8(%rax),%rdx
   14000d546:	48 8b 00             	mov    (%rax),%rax
   14000d549:	48 89 85 60 04 00 00 	mov    %rax,0x460(%rbp)
   14000d550:	48 89 95 68 04 00 00 	mov    %rdx,0x468(%rbp)
   14000d557:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000d55e:	48 83 c0 10          	add    $0x10,%rax
   14000d562:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000d569:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000d570:	48 8b 85 60 04 00 00 	mov    0x460(%rbp),%rax
   14000d577:	48 8b 95 68 04 00 00 	mov    0x468(%rbp),%rdx
   14000d57e:	48 89 01             	mov    %rax,(%rcx)
   14000d581:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000d585:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d58c:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000d590:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000d597:	48 39 c2             	cmp    %rax,%rdx
   14000d59a:	73 23                	jae    14000d5bf <main+0x54b>
   14000d59c:	41 b8 65 04 00 00    	mov    $0x465,%r8d
   14000d5a2:	48 8d 05 27 79 00 00 	lea    0x7927(%rip),%rax        # 140014ed0 <.rdata>
   14000d5a9:	48 89 c2             	mov    %rax,%rdx
   14000d5ac:	48 8d 05 f5 7e 00 00 	lea    0x7ef5(%rip),%rax        # 1400154a8 <.rdata+0x5d8>
   14000d5b3:	48 89 c1             	mov    %rax,%rcx
   14000d5b6:	48 8b 05 83 dd 00 00 	mov    0xdd83(%rip),%rax        # 14001b340 <__imp__assert>
   14000d5bd:	ff d0                	call   *%rax
   14000d5bf:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d5c6:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000d5ca:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000d5d1:	48 39 c2             	cmp    %rax,%rdx
   14000d5d4:	72 23                	jb     14000d5f9 <main+0x585>
   14000d5d6:	41 b8 65 04 00 00    	mov    $0x465,%r8d
   14000d5dc:	48 8d 05 ed 78 00 00 	lea    0x78ed(%rip),%rax        # 140014ed0 <.rdata>
   14000d5e3:	48 89 c2             	mov    %rax,%rdx
   14000d5e6:	48 8d 05 1b 7f 00 00 	lea    0x7f1b(%rip),%rax        # 140015508 <.rdata+0x638>
   14000d5ed:	48 89 c1             	mov    %rax,%rcx
   14000d5f0:	48 8b 05 49 dd 00 00 	mov    0xdd49(%rip),%rax        # 14001b340 <__imp__assert>
   14000d5f7:	ff d0                	call   *%rax
   14000d5f9:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d600:	48 83 c0 10          	add    $0x10,%rax
   14000d604:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000d60b:	e9 11 28 00 00       	jmp    14000fe21 <main+0x2dad>
   14000d610:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d617:	48 89 85 50 04 00 00 	mov    %rax,0x450(%rbp)
   14000d61e:	48 c7 85 58 04 00 00 	movq   $0x0,0x458(%rbp)
   14000d625:	00 00 00 00 
   14000d629:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000d630:	48 8b 85 50 04 00 00 	mov    0x450(%rbp),%rax
   14000d637:	48 8b 95 58 04 00 00 	mov    0x458(%rbp),%rdx
   14000d63e:	48 89 01             	mov    %rax,(%rcx)
   14000d641:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000d645:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d64c:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000d650:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000d657:	48 39 c2             	cmp    %rax,%rdx
   14000d65a:	73 23                	jae    14000d67f <main+0x60b>
   14000d65c:	41 b8 6c 04 00 00    	mov    $0x46c,%r8d
   14000d662:	48 8d 05 67 78 00 00 	lea    0x7867(%rip),%rax        # 140014ed0 <.rdata>
   14000d669:	48 89 c2             	mov    %rax,%rdx
   14000d66c:	48 8d 05 b5 7b 00 00 	lea    0x7bb5(%rip),%rax        # 140015228 <.rdata+0x358>
   14000d673:	48 89 c1             	mov    %rax,%rcx
   14000d676:	48 8b 05 c3 dc 00 00 	mov    0xdcc3(%rip),%rax        # 14001b340 <__imp__assert>
   14000d67d:	ff d0                	call   *%rax
   14000d67f:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d686:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000d68a:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000d691:	48 39 c2             	cmp    %rax,%rdx
   14000d694:	72 23                	jb     14000d6b9 <main+0x645>
   14000d696:	41 b8 6c 04 00 00    	mov    $0x46c,%r8d
   14000d69c:	48 8d 05 2d 78 00 00 	lea    0x782d(%rip),%rax        # 140014ed0 <.rdata>
   14000d6a3:	48 89 c2             	mov    %rax,%rdx
   14000d6a6:	48 8d 05 d3 7b 00 00 	lea    0x7bd3(%rip),%rax        # 140015280 <.rdata+0x3b0>
   14000d6ad:	48 89 c1             	mov    %rax,%rcx
   14000d6b0:	48 8b 05 89 dc 00 00 	mov    0xdc89(%rip),%rax        # 14001b340 <__imp__assert>
   14000d6b7:	ff d0                	call   *%rax
   14000d6b9:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d6c0:	48 83 c0 10          	add    $0x10,%rax
   14000d6c4:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000d6cb:	e9 51 27 00 00       	jmp    14000fe21 <main+0x2dad>
   14000d6d0:	48 8b 85 b0 04 00 00 	mov    0x4b0(%rbp),%rax
   14000d6d7:	48 89 85 40 04 00 00 	mov    %rax,0x440(%rbp)
   14000d6de:	48 c7 85 48 04 00 00 	movq   $0x0,0x448(%rbp)
   14000d6e5:	00 00 00 00 
   14000d6e9:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000d6f0:	48 8b 85 40 04 00 00 	mov    0x440(%rbp),%rax
   14000d6f7:	48 8b 95 48 04 00 00 	mov    0x448(%rbp),%rdx
   14000d6fe:	48 89 01             	mov    %rax,(%rcx)
   14000d701:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000d705:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d70c:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000d710:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000d717:	48 39 c2             	cmp    %rax,%rdx
   14000d71a:	73 23                	jae    14000d73f <main+0x6cb>
   14000d71c:	41 b8 73 04 00 00    	mov    $0x473,%r8d
   14000d722:	48 8d 05 a7 77 00 00 	lea    0x77a7(%rip),%rax        # 140014ed0 <.rdata>
   14000d729:	48 89 c2             	mov    %rax,%rdx
   14000d72c:	48 8d 05 f5 7a 00 00 	lea    0x7af5(%rip),%rax        # 140015228 <.rdata+0x358>
   14000d733:	48 89 c1             	mov    %rax,%rcx
   14000d736:	48 8b 05 03 dc 00 00 	mov    0xdc03(%rip),%rax        # 14001b340 <__imp__assert>
   14000d73d:	ff d0                	call   *%rax
   14000d73f:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d746:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000d74a:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000d751:	48 39 c2             	cmp    %rax,%rdx
   14000d754:	72 23                	jb     14000d779 <main+0x705>
   14000d756:	41 b8 73 04 00 00    	mov    $0x473,%r8d
   14000d75c:	48 8d 05 6d 77 00 00 	lea    0x776d(%rip),%rax        # 140014ed0 <.rdata>
   14000d763:	48 89 c2             	mov    %rax,%rdx
   14000d766:	48 8d 05 13 7b 00 00 	lea    0x7b13(%rip),%rax        # 140015280 <.rdata+0x3b0>
   14000d76d:	48 89 c1             	mov    %rax,%rcx
   14000d770:	48 8b 05 c9 db 00 00 	mov    0xdbc9(%rip),%rax        # 14001b340 <__imp__assert>
   14000d777:	ff d0                	call   *%rax
   14000d779:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d780:	48 83 c0 10          	add    $0x10,%rax
   14000d784:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000d78b:	e9 91 26 00 00       	jmp    14000fe21 <main+0x2dad>
   14000d790:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d797:	48 8d 50 f0          	lea    -0x10(%rax),%rdx
   14000d79b:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000d7a2:	48 39 c2             	cmp    %rax,%rdx
   14000d7a5:	73 23                	jae    14000d7ca <main+0x756>
   14000d7a7:	41 b8 76 04 00 00    	mov    $0x476,%r8d
   14000d7ad:	48 8d 05 1c 77 00 00 	lea    0x771c(%rip),%rax        # 140014ed0 <.rdata>
   14000d7b4:	48 89 c2             	mov    %rax,%rdx
   14000d7b7:	48 8d 05 aa 7d 00 00 	lea    0x7daa(%rip),%rax        # 140015568 <.rdata+0x698>
   14000d7be:	48 89 c1             	mov    %rax,%rcx
   14000d7c1:	48 8b 05 78 db 00 00 	mov    0xdb78(%rip),%rax        # 14001b340 <__imp__assert>
   14000d7c8:	ff d0                	call   *%rax
   14000d7ca:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d7d1:	48 8d 50 f0          	lea    -0x10(%rax),%rdx
   14000d7d5:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000d7dc:	48 39 c2             	cmp    %rax,%rdx
   14000d7df:	72 23                	jb     14000d804 <main+0x790>
   14000d7e1:	41 b8 76 04 00 00    	mov    $0x476,%r8d
   14000d7e7:	48 8d 05 e2 76 00 00 	lea    0x76e2(%rip),%rax        # 140014ed0 <.rdata>
   14000d7ee:	48 89 c2             	mov    %rax,%rdx
   14000d7f1:	48 8d 05 d8 7d 00 00 	lea    0x7dd8(%rip),%rax        # 1400155d0 <.rdata+0x700>
   14000d7f8:	48 89 c1             	mov    %rax,%rcx
   14000d7fb:	48 8b 05 3e db 00 00 	mov    0xdb3e(%rip),%rax        # 14001b340 <__imp__assert>
   14000d802:	ff d0                	call   *%rax
   14000d804:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d80b:	48 83 e8 10          	sub    $0x10,%rax
   14000d80f:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000d816:	e9 06 26 00 00       	jmp    14000fe21 <main+0x2dad>
   14000d81b:	8b 85 c0 04 00 00    	mov    0x4c0(%rbp),%eax
   14000d821:	85 c0                	test   %eax,%eax
   14000d823:	75 23                	jne    14000d848 <main+0x7d4>
   14000d825:	41 b8 79 04 00 00    	mov    $0x479,%r8d
   14000d82b:	48 8d 05 9e 76 00 00 	lea    0x769e(%rip),%rax        # 140014ed0 <.rdata>
   14000d832:	48 89 c2             	mov    %rax,%rdx
   14000d835:	48 8d 05 fc 7d 00 00 	lea    0x7dfc(%rip),%rax        # 140015638 <.rdata+0x768>
   14000d83c:	48 89 c1             	mov    %rax,%rcx
   14000d83f:	48 8b 05 fa da 00 00 	mov    0xdafa(%rip),%rax        # 14001b340 <__imp__assert>
   14000d846:	ff d0                	call   *%rax
   14000d848:	48 8b 85 b8 04 00 00 	mov    0x4b8(%rbp),%rax
   14000d84f:	8b 95 c0 04 00 00    	mov    0x4c0(%rbp),%edx
   14000d855:	83 ea 01             	sub    $0x1,%edx
   14000d858:	89 95 c0 04 00 00    	mov    %edx,0x4c0(%rbp)
   14000d85e:	8b 95 c0 04 00 00    	mov    0x4c0(%rbp),%edx
   14000d864:	89 d2                	mov    %edx,%edx
   14000d866:	48 c1 e2 03          	shl    $0x3,%rdx
   14000d86a:	48 01 d0             	add    %rdx,%rax
   14000d86d:	48 8b 00             	mov    (%rax),%rax
   14000d870:	48 89 85 18 05 00 00 	mov    %rax,0x518(%rbp)
   14000d877:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000d87e:	48 39 85 18 05 00 00 	cmp    %rax,0x518(%rbp)
   14000d885:	73 23                	jae    14000d8aa <main+0x836>
   14000d887:	41 b8 7b 04 00 00    	mov    $0x47b,%r8d
   14000d88d:	48 8d 05 3c 76 00 00 	lea    0x763c(%rip),%rax        # 140014ed0 <.rdata>
   14000d894:	48 89 c2             	mov    %rax,%rdx
   14000d897:	48 8d 05 e2 7d 00 00 	lea    0x7de2(%rip),%rax        # 140015680 <.rdata+0x7b0>
   14000d89e:	48 89 c1             	mov    %rax,%rcx
   14000d8a1:	48 8b 05 98 da 00 00 	mov    0xda98(%rip),%rax        # 14001b340 <__imp__assert>
   14000d8a8:	ff d0                	call   *%rax
   14000d8aa:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000d8b1:	48 39 85 18 05 00 00 	cmp    %rax,0x518(%rbp)
   14000d8b8:	72 23                	jb     14000d8dd <main+0x869>
   14000d8ba:	41 b8 7b 04 00 00    	mov    $0x47b,%r8d
   14000d8c0:	48 8d 05 09 76 00 00 	lea    0x7609(%rip),%rax        # 140014ed0 <.rdata>
   14000d8c7:	48 89 c2             	mov    %rax,%rdx
   14000d8ca:	48 8d 05 ef 7d 00 00 	lea    0x7def(%rip),%rax        # 1400156c0 <.rdata+0x7f0>
   14000d8d1:	48 89 c1             	mov    %rax,%rcx
   14000d8d4:	48 8b 05 65 da 00 00 	mov    0xda65(%rip),%rax        # 14001b340 <__imp__assert>
   14000d8db:	ff d0                	call   *%rax
   14000d8dd:	48 8b 85 18 05 00 00 	mov    0x518(%rbp),%rax
   14000d8e4:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000d8eb:	e9 31 25 00 00       	jmp    14000fe21 <main+0x2dad>
   14000d8f0:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d8f7:	48 8d 50 f0          	lea    -0x10(%rax),%rdx
   14000d8fb:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000d902:	48 39 c2             	cmp    %rax,%rdx
   14000d905:	73 23                	jae    14000d92a <main+0x8b6>
   14000d907:	41 b8 7e 04 00 00    	mov    $0x47e,%r8d
   14000d90d:	48 8d 05 bc 75 00 00 	lea    0x75bc(%rip),%rax        # 140014ed0 <.rdata>
   14000d914:	48 89 c2             	mov    %rax,%rdx
   14000d917:	48 8d 05 e2 7d 00 00 	lea    0x7de2(%rip),%rax        # 140015700 <.rdata+0x830>
   14000d91e:	48 89 c1             	mov    %rax,%rcx
   14000d921:	48 8b 05 18 da 00 00 	mov    0xda18(%rip),%rax        # 14001b340 <__imp__assert>
   14000d928:	ff d0                	call   *%rax
   14000d92a:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d931:	48 8d 50 f0          	lea    -0x10(%rax),%rdx
   14000d935:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000d93c:	48 39 c2             	cmp    %rax,%rdx
   14000d93f:	72 23                	jb     14000d964 <main+0x8f0>
   14000d941:	41 b8 7e 04 00 00    	mov    $0x47e,%r8d
   14000d947:	48 8d 05 82 75 00 00 	lea    0x7582(%rip),%rax        # 140014ed0 <.rdata>
   14000d94e:	48 89 c2             	mov    %rax,%rdx
   14000d951:	48 8d 05 10 7e 00 00 	lea    0x7e10(%rip),%rax        # 140015768 <.rdata+0x898>
   14000d958:	48 89 c1             	mov    %rax,%rcx
   14000d95b:	48 8b 05 de d9 00 00 	mov    0xd9de(%rip),%rax        # 14001b340 <__imp__assert>
   14000d962:	ff d0                	call   *%rax
   14000d964:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d96b:	48 83 e8 10          	sub    $0x10,%rax
   14000d96f:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000d976:	e9 a6 24 00 00       	jmp    14000fe21 <main+0x2dad>
   14000d97b:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d982:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000d986:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000d98a:	48 89 85 30 04 00 00 	mov    %rax,0x430(%rbp)
   14000d991:	48 89 95 38 04 00 00 	mov    %rdx,0x438(%rbp)
   14000d998:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000d99f:	48 83 e8 10          	sub    $0x10,%rax
   14000d9a3:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000d9aa:	48 8b 85 30 04 00 00 	mov    0x430(%rbp),%rax
   14000d9b1:	48 89 c2             	mov    %rax,%rdx
   14000d9b4:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000d9bb:	48 39 c2             	cmp    %rax,%rdx
   14000d9be:	73 23                	jae    14000d9e3 <main+0x96f>
   14000d9c0:	41 b8 83 04 00 00    	mov    $0x483,%r8d
   14000d9c6:	48 8d 05 03 75 00 00 	lea    0x7503(%rip),%rax        # 140014ed0 <.rdata>
   14000d9cd:	48 89 c2             	mov    %rax,%rdx
   14000d9d0:	48 8d 05 f9 7d 00 00 	lea    0x7df9(%rip),%rax        # 1400157d0 <.rdata+0x900>
   14000d9d7:	48 89 c1             	mov    %rax,%rcx
   14000d9da:	48 8b 05 5f d9 00 00 	mov    0xd95f(%rip),%rax        # 14001b340 <__imp__assert>
   14000d9e1:	ff d0                	call   *%rax
   14000d9e3:	48 8b 85 30 04 00 00 	mov    0x430(%rbp),%rax
   14000d9ea:	48 89 c2             	mov    %rax,%rdx
   14000d9ed:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000d9f4:	48 39 c2             	cmp    %rax,%rdx
   14000d9f7:	72 23                	jb     14000da1c <main+0x9a8>
   14000d9f9:	41 b8 83 04 00 00    	mov    $0x483,%r8d
   14000d9ff:	48 8d 05 ca 74 00 00 	lea    0x74ca(%rip),%rax        # 140014ed0 <.rdata>
   14000da06:	48 89 c2             	mov    %rax,%rdx
   14000da09:	48 8d 05 08 7e 00 00 	lea    0x7e08(%rip),%rax        # 140015818 <.rdata+0x948>
   14000da10:	48 89 c1             	mov    %rax,%rcx
   14000da13:	48 8b 05 26 d9 00 00 	mov    0xd926(%rip),%rax        # 14001b340 <__imp__assert>
   14000da1a:	ff d0                	call   *%rax
   14000da1c:	48 8b 85 30 04 00 00 	mov    0x430(%rbp),%rax
   14000da23:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000da2a:	e9 f2 23 00 00       	jmp    14000fe21 <main+0x2dad>
   14000da2f:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000da36:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000da3a:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000da3e:	48 89 85 20 04 00 00 	mov    %rax,0x420(%rbp)
   14000da45:	48 89 95 28 04 00 00 	mov    %rdx,0x428(%rbp)
   14000da4c:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000da53:	48 83 e8 10          	sub    $0x10,%rax
   14000da57:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000da5e:	48 8b 85 20 04 00 00 	mov    0x420(%rbp),%rax
   14000da65:	48 89 c2             	mov    %rax,%rdx
   14000da68:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000da6f:	48 39 c2             	cmp    %rax,%rdx
   14000da72:	73 23                	jae    14000da97 <main+0xa23>
   14000da74:	41 b8 88 04 00 00    	mov    $0x488,%r8d
   14000da7a:	48 8d 05 4f 74 00 00 	lea    0x744f(%rip),%rax        # 140014ed0 <.rdata>
   14000da81:	48 89 c2             	mov    %rax,%rdx
   14000da84:	48 8d 05 45 7d 00 00 	lea    0x7d45(%rip),%rax        # 1400157d0 <.rdata+0x900>
   14000da8b:	48 89 c1             	mov    %rax,%rcx
   14000da8e:	48 8b 05 ab d8 00 00 	mov    0xd8ab(%rip),%rax        # 14001b340 <__imp__assert>
   14000da95:	ff d0                	call   *%rax
   14000da97:	48 8b 85 20 04 00 00 	mov    0x420(%rbp),%rax
   14000da9e:	48 89 c2             	mov    %rax,%rdx
   14000daa1:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000daa8:	48 39 c2             	cmp    %rax,%rdx
   14000daab:	72 23                	jb     14000dad0 <main+0xa5c>
   14000daad:	41 b8 88 04 00 00    	mov    $0x488,%r8d
   14000dab3:	48 8d 05 16 74 00 00 	lea    0x7416(%rip),%rax        # 140014ed0 <.rdata>
   14000daba:	48 89 c2             	mov    %rax,%rdx
   14000dabd:	48 8d 05 54 7d 00 00 	lea    0x7d54(%rip),%rax        # 140015818 <.rdata+0x948>
   14000dac4:	48 89 c1             	mov    %rax,%rcx
   14000dac7:	48 8b 05 72 d8 00 00 	mov    0xd872(%rip),%rax        # 14001b340 <__imp__assert>
   14000dace:	ff d0                	call   *%rax
   14000dad0:	48 8b 85 20 04 00 00 	mov    0x420(%rbp),%rax
   14000dad7:	48 89 85 b0 04 00 00 	mov    %rax,0x4b0(%rbp)
   14000dade:	e9 3e 23 00 00       	jmp    14000fe21 <main+0x2dad>
   14000dae3:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000daea:	0f b6 00             	movzbl (%rax),%eax
   14000daed:	88 85 27 05 00 00    	mov    %al,0x527(%rbp)
   14000daf3:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000dafa:	48 83 c0 01          	add    $0x1,%rax
   14000dafe:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000db05:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000db0c:	0f b6 00             	movzbl (%rax),%eax
   14000db0f:	88 85 26 05 00 00    	mov    %al,0x526(%rbp)
   14000db15:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000db1c:	48 83 c0 01          	add    $0x1,%rax
   14000db20:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000db27:	48 8b 95 98 04 00 00 	mov    0x498(%rbp),%rdx
   14000db2e:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000db35:	48 39 c2             	cmp    %rax,%rdx
   14000db38:	73 23                	jae    14000db5d <main+0xae9>
   14000db3a:	41 b8 8f 04 00 00    	mov    $0x48f,%r8d
   14000db40:	48 8d 05 89 73 00 00 	lea    0x7389(%rip),%rax        # 140014ed0 <.rdata>
   14000db47:	48 89 c2             	mov    %rax,%rdx
   14000db4a:	48 8d 05 17 7d 00 00 	lea    0x7d17(%rip),%rax        # 140015868 <.rdata+0x998>
   14000db51:	48 89 c1             	mov    %rax,%rcx
   14000db54:	48 8b 05 e5 d7 00 00 	mov    0xd7e5(%rip),%rax        # 14001b340 <__imp__assert>
   14000db5b:	ff d0                	call   *%rax
   14000db5d:	48 8b 95 98 04 00 00 	mov    0x498(%rbp),%rdx
   14000db64:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000db6b:	48 39 c2             	cmp    %rax,%rdx
   14000db6e:	72 23                	jb     14000db93 <main+0xb1f>
   14000db70:	41 b8 8f 04 00 00    	mov    $0x48f,%r8d
   14000db76:	48 8d 05 53 73 00 00 	lea    0x7353(%rip),%rax        # 140014ed0 <.rdata>
   14000db7d:	48 89 c2             	mov    %rax,%rdx
   14000db80:	48 8d 05 29 7d 00 00 	lea    0x7d29(%rip),%rax        # 1400158b0 <.rdata+0x9e0>
   14000db87:	48 89 c1             	mov    %rax,%rcx
   14000db8a:	48 8b 05 af d7 00 00 	mov    0xd7af(%rip),%rax        # 14001b340 <__imp__assert>
   14000db91:	ff d0                	call   *%rax
   14000db93:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000db9a:	48 89 85 b0 04 00 00 	mov    %rax,0x4b0(%rbp)
   14000dba1:	e9 7b 22 00 00       	jmp    14000fe21 <main+0x2dad>
   14000dba6:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000dbad:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000dbb1:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000dbb5:	48 89 85 00 04 00 00 	mov    %rax,0x400(%rbp)
   14000dbbc:	48 89 95 08 04 00 00 	mov    %rdx,0x408(%rbp)
   14000dbc3:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000dbca:	48 83 e8 10          	sub    $0x10,%rax
   14000dbce:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000dbd5:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000dbdc:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000dbe0:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000dbe4:	48 89 85 10 04 00 00 	mov    %rax,0x410(%rbp)
   14000dbeb:	48 89 95 18 04 00 00 	mov    %rdx,0x418(%rbp)
   14000dbf2:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000dbf9:	48 83 e8 10          	sub    $0x10,%rax
   14000dbfd:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000dc04:	48 8b 95 10 04 00 00 	mov    0x410(%rbp),%rdx
   14000dc0b:	48 8b 85 00 04 00 00 	mov    0x400(%rbp),%rax
   14000dc12:	48 01 d0             	add    %rdx,%rax
   14000dc15:	48 89 85 f0 03 00 00 	mov    %rax,0x3f0(%rbp)
   14000dc1c:	48 c7 85 f8 03 00 00 	movq   $0x0,0x3f8(%rbp)
   14000dc23:	00 00 00 00 
   14000dc27:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000dc2e:	48 8b 85 f0 03 00 00 	mov    0x3f0(%rbp),%rax
   14000dc35:	48 8b 95 f8 03 00 00 	mov    0x3f8(%rbp),%rdx
   14000dc3c:	48 89 01             	mov    %rax,(%rcx)
   14000dc3f:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000dc43:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000dc4a:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000dc4e:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000dc55:	48 39 c2             	cmp    %rax,%rdx
   14000dc58:	73 23                	jae    14000dc7d <main+0xc09>
   14000dc5a:	41 b8 9a 04 00 00    	mov    $0x49a,%r8d
   14000dc60:	48 8d 05 69 72 00 00 	lea    0x7269(%rip),%rax        # 140014ed0 <.rdata>
   14000dc67:	48 89 c2             	mov    %rax,%rdx
   14000dc6a:	48 8d 05 b7 75 00 00 	lea    0x75b7(%rip),%rax        # 140015228 <.rdata+0x358>
   14000dc71:	48 89 c1             	mov    %rax,%rcx
   14000dc74:	48 8b 05 c5 d6 00 00 	mov    0xd6c5(%rip),%rax        # 14001b340 <__imp__assert>
   14000dc7b:	ff d0                	call   *%rax
   14000dc7d:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000dc84:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000dc88:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000dc8f:	48 39 c2             	cmp    %rax,%rdx
   14000dc92:	72 23                	jb     14000dcb7 <main+0xc43>
   14000dc94:	41 b8 9a 04 00 00    	mov    $0x49a,%r8d
   14000dc9a:	48 8d 05 2f 72 00 00 	lea    0x722f(%rip),%rax        # 140014ed0 <.rdata>
   14000dca1:	48 89 c2             	mov    %rax,%rdx
   14000dca4:	48 8d 05 d5 75 00 00 	lea    0x75d5(%rip),%rax        # 140015280 <.rdata+0x3b0>
   14000dcab:	48 89 c1             	mov    %rax,%rcx
   14000dcae:	48 8b 05 8b d6 00 00 	mov    0xd68b(%rip),%rax        # 14001b340 <__imp__assert>
   14000dcb5:	ff d0                	call   *%rax
   14000dcb7:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000dcbe:	48 83 c0 10          	add    $0x10,%rax
   14000dcc2:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000dcc9:	e9 53 21 00 00       	jmp    14000fe21 <main+0x2dad>
   14000dcce:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000dcd5:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000dcd9:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000dcdd:	48 89 85 d0 03 00 00 	mov    %rax,0x3d0(%rbp)
   14000dce4:	48 89 95 d8 03 00 00 	mov    %rdx,0x3d8(%rbp)
   14000dceb:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000dcf2:	48 83 e8 10          	sub    $0x10,%rax
   14000dcf6:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000dcfd:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000dd04:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000dd08:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000dd0c:	48 89 85 e0 03 00 00 	mov    %rax,0x3e0(%rbp)
   14000dd13:	48 89 95 e8 03 00 00 	mov    %rdx,0x3e8(%rbp)
   14000dd1a:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000dd21:	48 83 e8 10          	sub    $0x10,%rax
   14000dd25:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000dd2c:	f2 0f 10 8d e0 03 00 	movsd  0x3e0(%rbp),%xmm1
   14000dd33:	00 
   14000dd34:	f2 0f 10 85 d0 03 00 	movsd  0x3d0(%rbp),%xmm0
   14000dd3b:	00 
   14000dd3c:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
   14000dd40:	f2 0f 11 85 c0 03 00 	movsd  %xmm0,0x3c0(%rbp)
   14000dd47:	00 
   14000dd48:	66 0f ef c0          	pxor   %xmm0,%xmm0
   14000dd4c:	f2 0f 11 85 c8 03 00 	movsd  %xmm0,0x3c8(%rbp)
   14000dd53:	00 
   14000dd54:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000dd5b:	48 8b 85 c0 03 00 00 	mov    0x3c0(%rbp),%rax
   14000dd62:	48 8b 95 c8 03 00 00 	mov    0x3c8(%rbp),%rdx
   14000dd69:	48 89 01             	mov    %rax,(%rcx)
   14000dd6c:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000dd70:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000dd77:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000dd7b:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000dd82:	48 39 c2             	cmp    %rax,%rdx
   14000dd85:	73 23                	jae    14000ddaa <main+0xd36>
   14000dd87:	41 b8 a5 04 00 00    	mov    $0x4a5,%r8d
   14000dd8d:	48 8d 05 3c 71 00 00 	lea    0x713c(%rip),%rax        # 140014ed0 <.rdata>
   14000dd94:	48 89 c2             	mov    %rax,%rdx
   14000dd97:	48 8d 05 0a 77 00 00 	lea    0x770a(%rip),%rax        # 1400154a8 <.rdata+0x5d8>
   14000dd9e:	48 89 c1             	mov    %rax,%rcx
   14000dda1:	48 8b 05 98 d5 00 00 	mov    0xd598(%rip),%rax        # 14001b340 <__imp__assert>
   14000dda8:	ff d0                	call   *%rax
   14000ddaa:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ddb1:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000ddb5:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000ddbc:	48 39 c2             	cmp    %rax,%rdx
   14000ddbf:	72 23                	jb     14000dde4 <main+0xd70>
   14000ddc1:	41 b8 a5 04 00 00    	mov    $0x4a5,%r8d
   14000ddc7:	48 8d 05 02 71 00 00 	lea    0x7102(%rip),%rax        # 140014ed0 <.rdata>
   14000ddce:	48 89 c2             	mov    %rax,%rdx
   14000ddd1:	48 8d 05 30 77 00 00 	lea    0x7730(%rip),%rax        # 140015508 <.rdata+0x638>
   14000ddd8:	48 89 c1             	mov    %rax,%rcx
   14000dddb:	48 8b 05 5e d5 00 00 	mov    0xd55e(%rip),%rax        # 14001b340 <__imp__assert>
   14000dde2:	ff d0                	call   *%rax
   14000dde4:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ddeb:	48 83 c0 10          	add    $0x10,%rax
   14000ddef:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000ddf6:	e9 26 20 00 00       	jmp    14000fe21 <main+0x2dad>
   14000ddfb:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000de02:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000de06:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000de0a:	48 89 85 a0 03 00 00 	mov    %rax,0x3a0(%rbp)
   14000de11:	48 89 95 a8 03 00 00 	mov    %rdx,0x3a8(%rbp)
   14000de18:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000de1f:	48 83 e8 10          	sub    $0x10,%rax
   14000de23:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000de2a:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000de31:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000de35:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000de39:	48 89 85 b0 03 00 00 	mov    %rax,0x3b0(%rbp)
   14000de40:	48 89 95 b8 03 00 00 	mov    %rdx,0x3b8(%rbp)
   14000de47:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000de4e:	48 83 e8 10          	sub    $0x10,%rax
   14000de52:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000de59:	48 8b 95 b0 03 00 00 	mov    0x3b0(%rbp),%rdx
   14000de60:	48 8b 85 a0 03 00 00 	mov    0x3a0(%rbp),%rax
   14000de67:	48 29 c2             	sub    %rax,%rdx
   14000de6a:	48 89 95 90 03 00 00 	mov    %rdx,0x390(%rbp)
   14000de71:	48 c7 85 98 03 00 00 	movq   $0x0,0x398(%rbp)
   14000de78:	00 00 00 00 
   14000de7c:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000de83:	48 8b 85 90 03 00 00 	mov    0x390(%rbp),%rax
   14000de8a:	48 8b 95 98 03 00 00 	mov    0x398(%rbp),%rdx
   14000de91:	48 89 01             	mov    %rax,(%rcx)
   14000de94:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000de98:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000de9f:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000dea3:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000deaa:	48 39 c2             	cmp    %rax,%rdx
   14000dead:	73 23                	jae    14000ded2 <main+0xe5e>
   14000deaf:	41 b8 b0 04 00 00    	mov    $0x4b0,%r8d
   14000deb5:	48 8d 05 14 70 00 00 	lea    0x7014(%rip),%rax        # 140014ed0 <.rdata>
   14000debc:	48 89 c2             	mov    %rax,%rdx
   14000debf:	48 8d 05 62 73 00 00 	lea    0x7362(%rip),%rax        # 140015228 <.rdata+0x358>
   14000dec6:	48 89 c1             	mov    %rax,%rcx
   14000dec9:	48 8b 05 70 d4 00 00 	mov    0xd470(%rip),%rax        # 14001b340 <__imp__assert>
   14000ded0:	ff d0                	call   *%rax
   14000ded2:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ded9:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000dedd:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000dee4:	48 39 c2             	cmp    %rax,%rdx
   14000dee7:	72 23                	jb     14000df0c <main+0xe98>
   14000dee9:	41 b8 b0 04 00 00    	mov    $0x4b0,%r8d
   14000deef:	48 8d 05 da 6f 00 00 	lea    0x6fda(%rip),%rax        # 140014ed0 <.rdata>
   14000def6:	48 89 c2             	mov    %rax,%rdx
   14000def9:	48 8d 05 80 73 00 00 	lea    0x7380(%rip),%rax        # 140015280 <.rdata+0x3b0>
   14000df00:	48 89 c1             	mov    %rax,%rcx
   14000df03:	48 8b 05 36 d4 00 00 	mov    0xd436(%rip),%rax        # 14001b340 <__imp__assert>
   14000df0a:	ff d0                	call   *%rax
   14000df0c:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000df13:	48 83 c0 10          	add    $0x10,%rax
   14000df17:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000df1e:	e9 fe 1e 00 00       	jmp    14000fe21 <main+0x2dad>
   14000df23:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000df2a:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000df2e:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000df32:	48 89 85 70 03 00 00 	mov    %rax,0x370(%rbp)
   14000df39:	48 89 95 78 03 00 00 	mov    %rdx,0x378(%rbp)
   14000df40:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000df47:	48 83 e8 10          	sub    $0x10,%rax
   14000df4b:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000df52:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000df59:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000df5d:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000df61:	48 89 85 80 03 00 00 	mov    %rax,0x380(%rbp)
   14000df68:	48 89 95 88 03 00 00 	mov    %rdx,0x388(%rbp)
   14000df6f:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000df76:	48 83 e8 10          	sub    $0x10,%rax
   14000df7a:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000df81:	f2 0f 10 85 80 03 00 	movsd  0x380(%rbp),%xmm0
   14000df88:	00 
   14000df89:	f2 0f 10 8d 70 03 00 	movsd  0x370(%rbp),%xmm1
   14000df90:	00 
   14000df91:	f2 0f 5c c1          	subsd  %xmm1,%xmm0
   14000df95:	f2 0f 11 85 60 03 00 	movsd  %xmm0,0x360(%rbp)
   14000df9c:	00 
   14000df9d:	66 0f ef c0          	pxor   %xmm0,%xmm0
   14000dfa1:	f2 0f 11 85 68 03 00 	movsd  %xmm0,0x368(%rbp)
   14000dfa8:	00 
   14000dfa9:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000dfb0:	48 8b 85 60 03 00 00 	mov    0x360(%rbp),%rax
   14000dfb7:	48 8b 95 68 03 00 00 	mov    0x368(%rbp),%rdx
   14000dfbe:	48 89 01             	mov    %rax,(%rcx)
   14000dfc1:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000dfc5:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000dfcc:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000dfd0:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000dfd7:	48 39 c2             	cmp    %rax,%rdx
   14000dfda:	73 23                	jae    14000dfff <main+0xf8b>
   14000dfdc:	41 b8 bb 04 00 00    	mov    $0x4bb,%r8d
   14000dfe2:	48 8d 05 e7 6e 00 00 	lea    0x6ee7(%rip),%rax        # 140014ed0 <.rdata>
   14000dfe9:	48 89 c2             	mov    %rax,%rdx
   14000dfec:	48 8d 05 b5 74 00 00 	lea    0x74b5(%rip),%rax        # 1400154a8 <.rdata+0x5d8>
   14000dff3:	48 89 c1             	mov    %rax,%rcx
   14000dff6:	48 8b 05 43 d3 00 00 	mov    0xd343(%rip),%rax        # 14001b340 <__imp__assert>
   14000dffd:	ff d0                	call   *%rax
   14000dfff:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e006:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000e00a:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000e011:	48 39 c2             	cmp    %rax,%rdx
   14000e014:	72 23                	jb     14000e039 <main+0xfc5>
   14000e016:	41 b8 bb 04 00 00    	mov    $0x4bb,%r8d
   14000e01c:	48 8d 05 ad 6e 00 00 	lea    0x6ead(%rip),%rax        # 140014ed0 <.rdata>
   14000e023:	48 89 c2             	mov    %rax,%rdx
   14000e026:	48 8d 05 db 74 00 00 	lea    0x74db(%rip),%rax        # 140015508 <.rdata+0x638>
   14000e02d:	48 89 c1             	mov    %rax,%rcx
   14000e030:	48 8b 05 09 d3 00 00 	mov    0xd309(%rip),%rax        # 14001b340 <__imp__assert>
   14000e037:	ff d0                	call   *%rax
   14000e039:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e040:	48 83 c0 10          	add    $0x10,%rax
   14000e044:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e04b:	e9 d1 1d 00 00       	jmp    14000fe21 <main+0x2dad>
   14000e050:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e057:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000e05b:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000e05f:	48 89 85 40 03 00 00 	mov    %rax,0x340(%rbp)
   14000e066:	48 89 95 48 03 00 00 	mov    %rdx,0x348(%rbp)
   14000e06d:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e074:	48 83 e8 10          	sub    $0x10,%rax
   14000e078:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e07f:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e086:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000e08a:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000e08e:	48 89 85 50 03 00 00 	mov    %rax,0x350(%rbp)
   14000e095:	48 89 95 58 03 00 00 	mov    %rdx,0x358(%rbp)
   14000e09c:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e0a3:	48 83 e8 10          	sub    $0x10,%rax
   14000e0a7:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e0ae:	48 8b 95 50 03 00 00 	mov    0x350(%rbp),%rdx
   14000e0b5:	48 8b 85 40 03 00 00 	mov    0x340(%rbp),%rax
   14000e0bc:	48 0f af c2          	imul   %rdx,%rax
   14000e0c0:	48 89 85 30 03 00 00 	mov    %rax,0x330(%rbp)
   14000e0c7:	48 c7 85 38 03 00 00 	movq   $0x0,0x338(%rbp)
   14000e0ce:	00 00 00 00 
   14000e0d2:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000e0d9:	48 8b 85 30 03 00 00 	mov    0x330(%rbp),%rax
   14000e0e0:	48 8b 95 38 03 00 00 	mov    0x338(%rbp),%rdx
   14000e0e7:	48 89 01             	mov    %rax,(%rcx)
   14000e0ea:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000e0ee:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e0f5:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000e0f9:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000e100:	48 39 c2             	cmp    %rax,%rdx
   14000e103:	73 23                	jae    14000e128 <main+0x10b4>
   14000e105:	41 b8 c6 04 00 00    	mov    $0x4c6,%r8d
   14000e10b:	48 8d 05 be 6d 00 00 	lea    0x6dbe(%rip),%rax        # 140014ed0 <.rdata>
   14000e112:	48 89 c2             	mov    %rax,%rdx
   14000e115:	48 8d 05 0c 71 00 00 	lea    0x710c(%rip),%rax        # 140015228 <.rdata+0x358>
   14000e11c:	48 89 c1             	mov    %rax,%rcx
   14000e11f:	48 8b 05 1a d2 00 00 	mov    0xd21a(%rip),%rax        # 14001b340 <__imp__assert>
   14000e126:	ff d0                	call   *%rax
   14000e128:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e12f:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000e133:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000e13a:	48 39 c2             	cmp    %rax,%rdx
   14000e13d:	72 23                	jb     14000e162 <main+0x10ee>
   14000e13f:	41 b8 c6 04 00 00    	mov    $0x4c6,%r8d
   14000e145:	48 8d 05 84 6d 00 00 	lea    0x6d84(%rip),%rax        # 140014ed0 <.rdata>
   14000e14c:	48 89 c2             	mov    %rax,%rdx
   14000e14f:	48 8d 05 2a 71 00 00 	lea    0x712a(%rip),%rax        # 140015280 <.rdata+0x3b0>
   14000e156:	48 89 c1             	mov    %rax,%rcx
   14000e159:	48 8b 05 e0 d1 00 00 	mov    0xd1e0(%rip),%rax        # 14001b340 <__imp__assert>
   14000e160:	ff d0                	call   *%rax
   14000e162:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e169:	48 83 c0 10          	add    $0x10,%rax
   14000e16d:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e174:	e9 a8 1c 00 00       	jmp    14000fe21 <main+0x2dad>
   14000e179:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e180:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000e184:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000e188:	48 89 85 10 03 00 00 	mov    %rax,0x310(%rbp)
   14000e18f:	48 89 95 18 03 00 00 	mov    %rdx,0x318(%rbp)
   14000e196:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e19d:	48 83 e8 10          	sub    $0x10,%rax
   14000e1a1:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e1a8:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e1af:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000e1b3:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000e1b7:	48 89 85 20 03 00 00 	mov    %rax,0x320(%rbp)
   14000e1be:	48 89 95 28 03 00 00 	mov    %rdx,0x328(%rbp)
   14000e1c5:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e1cc:	48 83 e8 10          	sub    $0x10,%rax
   14000e1d0:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e1d7:	f2 0f 10 8d 20 03 00 	movsd  0x320(%rbp),%xmm1
   14000e1de:	00 
   14000e1df:	f2 0f 10 85 10 03 00 	movsd  0x310(%rbp),%xmm0
   14000e1e6:	00 
   14000e1e7:	f2 0f 59 c1          	mulsd  %xmm1,%xmm0
   14000e1eb:	f2 0f 11 85 00 03 00 	movsd  %xmm0,0x300(%rbp)
   14000e1f2:	00 
   14000e1f3:	66 0f ef c0          	pxor   %xmm0,%xmm0
   14000e1f7:	f2 0f 11 85 08 03 00 	movsd  %xmm0,0x308(%rbp)
   14000e1fe:	00 
   14000e1ff:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000e206:	48 8b 85 00 03 00 00 	mov    0x300(%rbp),%rax
   14000e20d:	48 8b 95 08 03 00 00 	mov    0x308(%rbp),%rdx
   14000e214:	48 89 01             	mov    %rax,(%rcx)
   14000e217:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000e21b:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e222:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000e226:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000e22d:	48 39 c2             	cmp    %rax,%rdx
   14000e230:	73 23                	jae    14000e255 <main+0x11e1>
   14000e232:	41 b8 d1 04 00 00    	mov    $0x4d1,%r8d
   14000e238:	48 8d 05 91 6c 00 00 	lea    0x6c91(%rip),%rax        # 140014ed0 <.rdata>
   14000e23f:	48 89 c2             	mov    %rax,%rdx
   14000e242:	48 8d 05 5f 72 00 00 	lea    0x725f(%rip),%rax        # 1400154a8 <.rdata+0x5d8>
   14000e249:	48 89 c1             	mov    %rax,%rcx
   14000e24c:	48 8b 05 ed d0 00 00 	mov    0xd0ed(%rip),%rax        # 14001b340 <__imp__assert>
   14000e253:	ff d0                	call   *%rax
   14000e255:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e25c:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000e260:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000e267:	48 39 c2             	cmp    %rax,%rdx
   14000e26a:	72 23                	jb     14000e28f <main+0x121b>
   14000e26c:	41 b8 d1 04 00 00    	mov    $0x4d1,%r8d
   14000e272:	48 8d 05 57 6c 00 00 	lea    0x6c57(%rip),%rax        # 140014ed0 <.rdata>
   14000e279:	48 89 c2             	mov    %rax,%rdx
   14000e27c:	48 8d 05 85 72 00 00 	lea    0x7285(%rip),%rax        # 140015508 <.rdata+0x638>
   14000e283:	48 89 c1             	mov    %rax,%rcx
   14000e286:	48 8b 05 b3 d0 00 00 	mov    0xd0b3(%rip),%rax        # 14001b340 <__imp__assert>
   14000e28d:	ff d0                	call   *%rax
   14000e28f:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e296:	48 83 c0 10          	add    $0x10,%rax
   14000e29a:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e2a1:	e9 7b 1b 00 00       	jmp    14000fe21 <main+0x2dad>
   14000e2a6:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e2ad:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000e2b1:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000e2b5:	48 89 85 e0 02 00 00 	mov    %rax,0x2e0(%rbp)
   14000e2bc:	48 89 95 e8 02 00 00 	mov    %rdx,0x2e8(%rbp)
   14000e2c3:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e2ca:	48 83 e8 10          	sub    $0x10,%rax
   14000e2ce:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e2d5:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e2dc:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000e2e0:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000e2e4:	48 89 85 f0 02 00 00 	mov    %rax,0x2f0(%rbp)
   14000e2eb:	48 89 95 f8 02 00 00 	mov    %rdx,0x2f8(%rbp)
   14000e2f2:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e2f9:	48 83 e8 10          	sub    $0x10,%rax
   14000e2fd:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e304:	48 8b 85 f0 02 00 00 	mov    0x2f0(%rbp),%rax
   14000e30b:	48 8b bd e0 02 00 00 	mov    0x2e0(%rbp),%rdi
   14000e312:	ba 00 00 00 00       	mov    $0x0,%edx
   14000e317:	48 f7 f7             	div    %rdi
   14000e31a:	48 89 85 d0 02 00 00 	mov    %rax,0x2d0(%rbp)
   14000e321:	48 c7 85 d8 02 00 00 	movq   $0x0,0x2d8(%rbp)
   14000e328:	00 00 00 00 
   14000e32c:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000e333:	48 8b 85 d0 02 00 00 	mov    0x2d0(%rbp),%rax
   14000e33a:	48 8b 95 d8 02 00 00 	mov    0x2d8(%rbp),%rdx
   14000e341:	48 89 01             	mov    %rax,(%rcx)
   14000e344:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000e348:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e34f:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000e353:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000e35a:	48 39 c2             	cmp    %rax,%rdx
   14000e35d:	73 23                	jae    14000e382 <main+0x130e>
   14000e35f:	41 b8 dc 04 00 00    	mov    $0x4dc,%r8d
   14000e365:	48 8d 05 64 6b 00 00 	lea    0x6b64(%rip),%rax        # 140014ed0 <.rdata>
   14000e36c:	48 89 c2             	mov    %rax,%rdx
   14000e36f:	48 8d 05 b2 6e 00 00 	lea    0x6eb2(%rip),%rax        # 140015228 <.rdata+0x358>
   14000e376:	48 89 c1             	mov    %rax,%rcx
   14000e379:	48 8b 05 c0 cf 00 00 	mov    0xcfc0(%rip),%rax        # 14001b340 <__imp__assert>
   14000e380:	ff d0                	call   *%rax
   14000e382:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e389:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000e38d:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000e394:	48 39 c2             	cmp    %rax,%rdx
   14000e397:	72 23                	jb     14000e3bc <main+0x1348>
   14000e399:	41 b8 dc 04 00 00    	mov    $0x4dc,%r8d
   14000e39f:	48 8d 05 2a 6b 00 00 	lea    0x6b2a(%rip),%rax        # 140014ed0 <.rdata>
   14000e3a6:	48 89 c2             	mov    %rax,%rdx
   14000e3a9:	48 8d 05 d0 6e 00 00 	lea    0x6ed0(%rip),%rax        # 140015280 <.rdata+0x3b0>
   14000e3b0:	48 89 c1             	mov    %rax,%rcx
   14000e3b3:	48 8b 05 86 cf 00 00 	mov    0xcf86(%rip),%rax        # 14001b340 <__imp__assert>
   14000e3ba:	ff d0                	call   *%rax
   14000e3bc:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e3c3:	48 83 c0 10          	add    $0x10,%rax
   14000e3c7:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e3ce:	e9 4e 1a 00 00       	jmp    14000fe21 <main+0x2dad>
   14000e3d3:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e3da:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000e3de:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000e3e2:	48 89 85 b0 02 00 00 	mov    %rax,0x2b0(%rbp)
   14000e3e9:	48 89 95 b8 02 00 00 	mov    %rdx,0x2b8(%rbp)
   14000e3f0:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e3f7:	48 83 e8 10          	sub    $0x10,%rax
   14000e3fb:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e402:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e409:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000e40d:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000e411:	48 89 85 c0 02 00 00 	mov    %rax,0x2c0(%rbp)
   14000e418:	48 89 95 c8 02 00 00 	mov    %rdx,0x2c8(%rbp)
   14000e41f:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e426:	48 83 e8 10          	sub    $0x10,%rax
   14000e42a:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e431:	f2 0f 10 85 c0 02 00 	movsd  0x2c0(%rbp),%xmm0
   14000e438:	00 
   14000e439:	f2 0f 10 8d b0 02 00 	movsd  0x2b0(%rbp),%xmm1
   14000e440:	00 
   14000e441:	f2 0f 5e c1          	divsd  %xmm1,%xmm0
   14000e445:	f2 0f 11 85 a0 02 00 	movsd  %xmm0,0x2a0(%rbp)
   14000e44c:	00 
   14000e44d:	66 0f ef c0          	pxor   %xmm0,%xmm0
   14000e451:	f2 0f 11 85 a8 02 00 	movsd  %xmm0,0x2a8(%rbp)
   14000e458:	00 
   14000e459:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000e460:	48 8b 85 a0 02 00 00 	mov    0x2a0(%rbp),%rax
   14000e467:	48 8b 95 a8 02 00 00 	mov    0x2a8(%rbp),%rdx
   14000e46e:	48 89 01             	mov    %rax,(%rcx)
   14000e471:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000e475:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e47c:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000e480:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000e487:	48 39 c2             	cmp    %rax,%rdx
   14000e48a:	73 23                	jae    14000e4af <main+0x143b>
   14000e48c:	41 b8 e7 04 00 00    	mov    $0x4e7,%r8d
   14000e492:	48 8d 05 37 6a 00 00 	lea    0x6a37(%rip),%rax        # 140014ed0 <.rdata>
   14000e499:	48 89 c2             	mov    %rax,%rdx
   14000e49c:	48 8d 05 05 70 00 00 	lea    0x7005(%rip),%rax        # 1400154a8 <.rdata+0x5d8>
   14000e4a3:	48 89 c1             	mov    %rax,%rcx
   14000e4a6:	48 8b 05 93 ce 00 00 	mov    0xce93(%rip),%rax        # 14001b340 <__imp__assert>
   14000e4ad:	ff d0                	call   *%rax
   14000e4af:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e4b6:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000e4ba:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000e4c1:	48 39 c2             	cmp    %rax,%rdx
   14000e4c4:	72 23                	jb     14000e4e9 <main+0x1475>
   14000e4c6:	41 b8 e7 04 00 00    	mov    $0x4e7,%r8d
   14000e4cc:	48 8d 05 fd 69 00 00 	lea    0x69fd(%rip),%rax        # 140014ed0 <.rdata>
   14000e4d3:	48 89 c2             	mov    %rax,%rdx
   14000e4d6:	48 8d 05 2b 70 00 00 	lea    0x702b(%rip),%rax        # 140015508 <.rdata+0x638>
   14000e4dd:	48 89 c1             	mov    %rax,%rcx
   14000e4e0:	48 8b 05 59 ce 00 00 	mov    0xce59(%rip),%rax        # 14001b340 <__imp__assert>
   14000e4e7:	ff d0                	call   *%rax
   14000e4e9:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e4f0:	48 83 c0 10          	add    $0x10,%rax
   14000e4f4:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e4fb:	e9 21 19 00 00       	jmp    14000fe21 <main+0x2dad>
   14000e500:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e507:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000e50b:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000e50f:	48 89 85 80 02 00 00 	mov    %rax,0x280(%rbp)
   14000e516:	48 89 95 88 02 00 00 	mov    %rdx,0x288(%rbp)
   14000e51d:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e524:	48 83 e8 10          	sub    $0x10,%rax
   14000e528:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e52f:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e536:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000e53a:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000e53e:	48 89 85 90 02 00 00 	mov    %rax,0x290(%rbp)
   14000e545:	48 89 95 98 02 00 00 	mov    %rdx,0x298(%rbp)
   14000e54c:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e553:	48 83 e8 10          	sub    $0x10,%rax
   14000e557:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e55e:	48 8b 85 90 02 00 00 	mov    0x290(%rbp),%rax
   14000e565:	48 8b bd 80 02 00 00 	mov    0x280(%rbp),%rdi
   14000e56c:	ba 00 00 00 00       	mov    $0x0,%edx
   14000e571:	48 f7 f7             	div    %rdi
   14000e574:	48 89 d1             	mov    %rdx,%rcx
   14000e577:	48 89 c8             	mov    %rcx,%rax
   14000e57a:	48 89 85 70 02 00 00 	mov    %rax,0x270(%rbp)
   14000e581:	48 c7 85 78 02 00 00 	movq   $0x0,0x278(%rbp)
   14000e588:	00 00 00 00 
   14000e58c:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000e593:	48 8b 85 70 02 00 00 	mov    0x270(%rbp),%rax
   14000e59a:	48 8b 95 78 02 00 00 	mov    0x278(%rbp),%rdx
   14000e5a1:	48 89 01             	mov    %rax,(%rcx)
   14000e5a4:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000e5a8:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e5af:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000e5b3:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000e5ba:	48 39 c2             	cmp    %rax,%rdx
   14000e5bd:	73 23                	jae    14000e5e2 <main+0x156e>
   14000e5bf:	41 b8 f2 04 00 00    	mov    $0x4f2,%r8d
   14000e5c5:	48 8d 05 04 69 00 00 	lea    0x6904(%rip),%rax        # 140014ed0 <.rdata>
   14000e5cc:	48 89 c2             	mov    %rax,%rdx
   14000e5cf:	48 8d 05 52 6c 00 00 	lea    0x6c52(%rip),%rax        # 140015228 <.rdata+0x358>
   14000e5d6:	48 89 c1             	mov    %rax,%rcx
   14000e5d9:	48 8b 05 60 cd 00 00 	mov    0xcd60(%rip),%rax        # 14001b340 <__imp__assert>
   14000e5e0:	ff d0                	call   *%rax
   14000e5e2:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e5e9:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000e5ed:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000e5f4:	48 39 c2             	cmp    %rax,%rdx
   14000e5f7:	72 23                	jb     14000e61c <main+0x15a8>
   14000e5f9:	41 b8 f2 04 00 00    	mov    $0x4f2,%r8d
   14000e5ff:	48 8d 05 ca 68 00 00 	lea    0x68ca(%rip),%rax        # 140014ed0 <.rdata>
   14000e606:	48 89 c2             	mov    %rax,%rdx
   14000e609:	48 8d 05 70 6c 00 00 	lea    0x6c70(%rip),%rax        # 140015280 <.rdata+0x3b0>
   14000e610:	48 89 c1             	mov    %rax,%rcx
   14000e613:	48 8b 05 26 cd 00 00 	mov    0xcd26(%rip),%rax        # 14001b340 <__imp__assert>
   14000e61a:	ff d0                	call   *%rax
   14000e61c:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e623:	48 83 c0 10          	add    $0x10,%rax
   14000e627:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e62e:	e9 ee 17 00 00       	jmp    14000fe21 <main+0x2dad>
   14000e633:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e63a:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000e63e:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000e642:	48 89 85 50 02 00 00 	mov    %rax,0x250(%rbp)
   14000e649:	48 89 95 58 02 00 00 	mov    %rdx,0x258(%rbp)
   14000e650:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e657:	48 83 e8 10          	sub    $0x10,%rax
   14000e65b:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e662:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e669:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000e66d:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000e671:	48 89 85 60 02 00 00 	mov    %rax,0x260(%rbp)
   14000e678:	48 89 95 68 02 00 00 	mov    %rdx,0x268(%rbp)
   14000e67f:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e686:	48 83 e8 10          	sub    $0x10,%rax
   14000e68a:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e691:	f2 0f 10 85 50 02 00 	movsd  0x250(%rbp),%xmm0
   14000e698:	00 
   14000e699:	48 8b 85 60 02 00 00 	mov    0x260(%rbp),%rax
   14000e6a0:	66 0f 28 c8          	movapd %xmm0,%xmm1
   14000e6a4:	66 48 0f 6e c0       	movq   %rax,%xmm0
   14000e6a9:	e8 72 2e 00 00       	call   140011520 <fmod>
   14000e6ae:	66 48 0f 7e c0       	movq   %xmm0,%rax
   14000e6b3:	48 89 85 40 02 00 00 	mov    %rax,0x240(%rbp)
   14000e6ba:	66 0f ef c0          	pxor   %xmm0,%xmm0
   14000e6be:	f2 0f 11 85 48 02 00 	movsd  %xmm0,0x248(%rbp)
   14000e6c5:	00 
   14000e6c6:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000e6cd:	48 8b 85 40 02 00 00 	mov    0x240(%rbp),%rax
   14000e6d4:	48 8b 95 48 02 00 00 	mov    0x248(%rbp),%rdx
   14000e6db:	48 89 01             	mov    %rax,(%rcx)
   14000e6de:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000e6e2:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e6e9:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000e6ed:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000e6f4:	48 39 c2             	cmp    %rax,%rdx
   14000e6f7:	73 23                	jae    14000e71c <main+0x16a8>
   14000e6f9:	41 b8 fd 04 00 00    	mov    $0x4fd,%r8d
   14000e6ff:	48 8d 05 ca 67 00 00 	lea    0x67ca(%rip),%rax        # 140014ed0 <.rdata>
   14000e706:	48 89 c2             	mov    %rax,%rdx
   14000e709:	48 8d 05 98 6d 00 00 	lea    0x6d98(%rip),%rax        # 1400154a8 <.rdata+0x5d8>
   14000e710:	48 89 c1             	mov    %rax,%rcx
   14000e713:	48 8b 05 26 cc 00 00 	mov    0xcc26(%rip),%rax        # 14001b340 <__imp__assert>
   14000e71a:	ff d0                	call   *%rax
   14000e71c:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e723:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000e727:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000e72e:	48 39 c2             	cmp    %rax,%rdx
   14000e731:	72 23                	jb     14000e756 <main+0x16e2>
   14000e733:	41 b8 fd 04 00 00    	mov    $0x4fd,%r8d
   14000e739:	48 8d 05 90 67 00 00 	lea    0x6790(%rip),%rax        # 140014ed0 <.rdata>
   14000e740:	48 89 c2             	mov    %rax,%rdx
   14000e743:	48 8d 05 be 6d 00 00 	lea    0x6dbe(%rip),%rax        # 140015508 <.rdata+0x638>
   14000e74a:	48 89 c1             	mov    %rax,%rcx
   14000e74d:	48 8b 05 ec cb 00 00 	mov    0xcbec(%rip),%rax        # 14001b340 <__imp__assert>
   14000e754:	ff d0                	call   *%rax
   14000e756:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e75d:	48 83 c0 10          	add    $0x10,%rax
   14000e761:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e768:	e9 b4 16 00 00       	jmp    14000fe21 <main+0x2dad>
   14000e76d:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e774:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000e778:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000e77c:	48 89 85 30 02 00 00 	mov    %rax,0x230(%rbp)
   14000e783:	48 89 95 38 02 00 00 	mov    %rdx,0x238(%rbp)
   14000e78a:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000e791:	48 8b 85 30 02 00 00 	mov    0x230(%rbp),%rax
   14000e798:	48 8b 95 38 02 00 00 	mov    0x238(%rbp),%rdx
   14000e79f:	48 89 01             	mov    %rax,(%rcx)
   14000e7a2:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000e7a6:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e7ad:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000e7b1:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000e7b8:	48 39 c2             	cmp    %rax,%rdx
   14000e7bb:	73 23                	jae    14000e7e0 <main+0x176c>
   14000e7bd:	41 b8 01 05 00 00    	mov    $0x501,%r8d
   14000e7c3:	48 8d 05 06 67 00 00 	lea    0x6706(%rip),%rax        # 140014ed0 <.rdata>
   14000e7ca:	48 89 c2             	mov    %rax,%rdx
   14000e7cd:	48 8d 05 54 6a 00 00 	lea    0x6a54(%rip),%rax        # 140015228 <.rdata+0x358>
   14000e7d4:	48 89 c1             	mov    %rax,%rcx
   14000e7d7:	48 8b 05 62 cb 00 00 	mov    0xcb62(%rip),%rax        # 14001b340 <__imp__assert>
   14000e7de:	ff d0                	call   *%rax
   14000e7e0:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e7e7:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000e7eb:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000e7f2:	48 39 c2             	cmp    %rax,%rdx
   14000e7f5:	72 23                	jb     14000e81a <main+0x17a6>
   14000e7f7:	41 b8 01 05 00 00    	mov    $0x501,%r8d
   14000e7fd:	48 8d 05 cc 66 00 00 	lea    0x66cc(%rip),%rax        # 140014ed0 <.rdata>
   14000e804:	48 89 c2             	mov    %rax,%rdx
   14000e807:	48 8d 05 72 6a 00 00 	lea    0x6a72(%rip),%rax        # 140015280 <.rdata+0x3b0>
   14000e80e:	48 89 c1             	mov    %rax,%rcx
   14000e811:	48 8b 05 28 cb 00 00 	mov    0xcb28(%rip),%rax        # 14001b340 <__imp__assert>
   14000e818:	ff d0                	call   *%rax
   14000e81a:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e821:	48 83 c0 10          	add    $0x10,%rax
   14000e825:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e82c:	e9 f0 15 00 00       	jmp    14000fe21 <main+0x2dad>
   14000e831:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e838:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000e83c:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000e840:	48 89 85 20 02 00 00 	mov    %rax,0x220(%rbp)
   14000e847:	48 89 95 28 02 00 00 	mov    %rdx,0x228(%rbp)
   14000e84e:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000e855:	48 8b 85 20 02 00 00 	mov    0x220(%rbp),%rax
   14000e85c:	48 8b 95 28 02 00 00 	mov    0x228(%rbp),%rdx
   14000e863:	48 89 01             	mov    %rax,(%rcx)
   14000e866:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000e86a:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e871:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000e875:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000e87c:	48 39 c2             	cmp    %rax,%rdx
   14000e87f:	73 23                	jae    14000e8a4 <main+0x1830>
   14000e881:	41 b8 05 05 00 00    	mov    $0x505,%r8d
   14000e887:	48 8d 05 42 66 00 00 	lea    0x6642(%rip),%rax        # 140014ed0 <.rdata>
   14000e88e:	48 89 c2             	mov    %rax,%rdx
   14000e891:	48 8d 05 10 6c 00 00 	lea    0x6c10(%rip),%rax        # 1400154a8 <.rdata+0x5d8>
   14000e898:	48 89 c1             	mov    %rax,%rcx
   14000e89b:	48 8b 05 9e ca 00 00 	mov    0xca9e(%rip),%rax        # 14001b340 <__imp__assert>
   14000e8a2:	ff d0                	call   *%rax
   14000e8a4:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e8ab:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000e8af:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000e8b6:	48 39 c2             	cmp    %rax,%rdx
   14000e8b9:	72 23                	jb     14000e8de <main+0x186a>
   14000e8bb:	41 b8 05 05 00 00    	mov    $0x505,%r8d
   14000e8c1:	48 8d 05 08 66 00 00 	lea    0x6608(%rip),%rax        # 140014ed0 <.rdata>
   14000e8c8:	48 89 c2             	mov    %rax,%rdx
   14000e8cb:	48 8d 05 36 6c 00 00 	lea    0x6c36(%rip),%rax        # 140015508 <.rdata+0x638>
   14000e8d2:	48 89 c1             	mov    %rax,%rcx
   14000e8d5:	48 8b 05 64 ca 00 00 	mov    0xca64(%rip),%rax        # 14001b340 <__imp__assert>
   14000e8dc:	ff d0                	call   *%rax
   14000e8de:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e8e5:	48 83 c0 10          	add    $0x10,%rax
   14000e8e9:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e8f0:	e9 2c 15 00 00       	jmp    14000fe21 <main+0x2dad>
   14000e8f5:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e8fc:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000e900:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000e904:	48 89 85 10 02 00 00 	mov    %rax,0x210(%rbp)
   14000e90b:	48 89 95 18 02 00 00 	mov    %rdx,0x218(%rbp)
   14000e912:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e919:	48 83 e8 10          	sub    $0x10,%rax
   14000e91d:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e924:	48 8b 85 10 02 00 00 	mov    0x210(%rbp),%rax
   14000e92b:	48 f7 d8             	neg    %rax
   14000e92e:	48 89 85 10 02 00 00 	mov    %rax,0x210(%rbp)
   14000e935:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000e93c:	48 8b 85 10 02 00 00 	mov    0x210(%rbp),%rax
   14000e943:	48 8b 95 18 02 00 00 	mov    0x218(%rbp),%rdx
   14000e94a:	48 89 01             	mov    %rax,(%rcx)
   14000e94d:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000e951:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e958:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000e95c:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000e963:	48 39 c2             	cmp    %rax,%rdx
   14000e966:	73 23                	jae    14000e98b <main+0x1917>
   14000e968:	41 b8 0b 05 00 00    	mov    $0x50b,%r8d
   14000e96e:	48 8d 05 5b 65 00 00 	lea    0x655b(%rip),%rax        # 140014ed0 <.rdata>
   14000e975:	48 89 c2             	mov    %rax,%rdx
   14000e978:	48 8d 05 a9 68 00 00 	lea    0x68a9(%rip),%rax        # 140015228 <.rdata+0x358>
   14000e97f:	48 89 c1             	mov    %rax,%rcx
   14000e982:	48 8b 05 b7 c9 00 00 	mov    0xc9b7(%rip),%rax        # 14001b340 <__imp__assert>
   14000e989:	ff d0                	call   *%rax
   14000e98b:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e992:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000e996:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000e99d:	48 39 c2             	cmp    %rax,%rdx
   14000e9a0:	72 23                	jb     14000e9c5 <main+0x1951>
   14000e9a2:	41 b8 0b 05 00 00    	mov    $0x50b,%r8d
   14000e9a8:	48 8d 05 21 65 00 00 	lea    0x6521(%rip),%rax        # 140014ed0 <.rdata>
   14000e9af:	48 89 c2             	mov    %rax,%rdx
   14000e9b2:	48 8d 05 c7 68 00 00 	lea    0x68c7(%rip),%rax        # 140015280 <.rdata+0x3b0>
   14000e9b9:	48 89 c1             	mov    %rax,%rcx
   14000e9bc:	48 8b 05 7d c9 00 00 	mov    0xc97d(%rip),%rax        # 14001b340 <__imp__assert>
   14000e9c3:	ff d0                	call   *%rax
   14000e9c5:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e9cc:	48 83 c0 10          	add    $0x10,%rax
   14000e9d0:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000e9d7:	e9 45 14 00 00       	jmp    14000fe21 <main+0x2dad>
   14000e9dc:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000e9e3:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000e9e7:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000e9eb:	48 89 85 00 02 00 00 	mov    %rax,0x200(%rbp)
   14000e9f2:	48 89 95 08 02 00 00 	mov    %rdx,0x208(%rbp)
   14000e9f9:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ea00:	48 83 e8 10          	sub    $0x10,%rax
   14000ea04:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000ea0b:	f2 0f 10 85 00 02 00 	movsd  0x200(%rbp),%xmm0
   14000ea12:	00 
   14000ea13:	f3 0f 7e 0d f5 70 00 	movq   0x70f5(%rip),%xmm1        # 140015b10 <.rdata+0xc40>
   14000ea1a:	00 
   14000ea1b:	66 0f 57 c1          	xorpd  %xmm1,%xmm0
   14000ea1f:	f2 0f 11 85 00 02 00 	movsd  %xmm0,0x200(%rbp)
   14000ea26:	00 
   14000ea27:	f2 0f 10 85 08 02 00 	movsd  0x208(%rbp),%xmm0
   14000ea2e:	00 
   14000ea2f:	f3 0f 7e 0d d9 70 00 	movq   0x70d9(%rip),%xmm1        # 140015b10 <.rdata+0xc40>
   14000ea36:	00 
   14000ea37:	66 0f 57 c1          	xorpd  %xmm1,%xmm0
   14000ea3b:	f2 0f 11 85 08 02 00 	movsd  %xmm0,0x208(%rbp)
   14000ea42:	00 
   14000ea43:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000ea4a:	48 8b 85 00 02 00 00 	mov    0x200(%rbp),%rax
   14000ea51:	48 8b 95 08 02 00 00 	mov    0x208(%rbp),%rdx
   14000ea58:	48 89 01             	mov    %rax,(%rcx)
   14000ea5b:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000ea5f:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ea66:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000ea6a:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000ea71:	48 39 c2             	cmp    %rax,%rdx
   14000ea74:	73 23                	jae    14000ea99 <main+0x1a25>
   14000ea76:	41 b8 12 05 00 00    	mov    $0x512,%r8d
   14000ea7c:	48 8d 05 4d 64 00 00 	lea    0x644d(%rip),%rax        # 140014ed0 <.rdata>
   14000ea83:	48 89 c2             	mov    %rax,%rdx
   14000ea86:	48 8d 05 1b 6a 00 00 	lea    0x6a1b(%rip),%rax        # 1400154a8 <.rdata+0x5d8>
   14000ea8d:	48 89 c1             	mov    %rax,%rcx
   14000ea90:	48 8b 05 a9 c8 00 00 	mov    0xc8a9(%rip),%rax        # 14001b340 <__imp__assert>
   14000ea97:	ff d0                	call   *%rax
   14000ea99:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000eaa0:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000eaa4:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000eaab:	48 39 c2             	cmp    %rax,%rdx
   14000eaae:	72 23                	jb     14000ead3 <main+0x1a5f>
   14000eab0:	41 b8 12 05 00 00    	mov    $0x512,%r8d
   14000eab6:	48 8d 05 13 64 00 00 	lea    0x6413(%rip),%rax        # 140014ed0 <.rdata>
   14000eabd:	48 89 c2             	mov    %rax,%rdx
   14000eac0:	48 8d 05 41 6a 00 00 	lea    0x6a41(%rip),%rax        # 140015508 <.rdata+0x638>
   14000eac7:	48 89 c1             	mov    %rax,%rcx
   14000eaca:	48 8b 05 6f c8 00 00 	mov    0xc86f(%rip),%rax        # 14001b340 <__imp__assert>
   14000ead1:	ff d0                	call   *%rax
   14000ead3:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000eada:	48 83 c0 10          	add    $0x10,%rax
   14000eade:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000eae5:	e9 37 13 00 00       	jmp    14000fe21 <main+0x2dad>
   14000eaea:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000eaf1:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000eaf5:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000eaf9:	48 89 85 f0 01 00 00 	mov    %rax,0x1f0(%rbp)
   14000eb00:	48 89 95 f8 01 00 00 	mov    %rdx,0x1f8(%rbp)
   14000eb07:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000eb0e:	48 83 e8 10          	sub    $0x10,%rax
   14000eb12:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000eb19:	48 8b 85 f0 01 00 00 	mov    0x1f0(%rbp),%rax
   14000eb20:	48 83 c0 01          	add    $0x1,%rax
   14000eb24:	48 89 85 e0 01 00 00 	mov    %rax,0x1e0(%rbp)
   14000eb2b:	48 c7 85 e8 01 00 00 	movq   $0x0,0x1e8(%rbp)
   14000eb32:	00 00 00 00 
   14000eb36:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000eb3d:	48 8b 85 e0 01 00 00 	mov    0x1e0(%rbp),%rax
   14000eb44:	48 8b 95 e8 01 00 00 	mov    0x1e8(%rbp),%rdx
   14000eb4b:	48 89 01             	mov    %rax,(%rcx)
   14000eb4e:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000eb52:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000eb59:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000eb5d:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000eb64:	48 39 c2             	cmp    %rax,%rdx
   14000eb67:	73 23                	jae    14000eb8c <main+0x1b18>
   14000eb69:	41 b8 1b 05 00 00    	mov    $0x51b,%r8d
   14000eb6f:	48 8d 05 5a 63 00 00 	lea    0x635a(%rip),%rax        # 140014ed0 <.rdata>
   14000eb76:	48 89 c2             	mov    %rax,%rdx
   14000eb79:	48 8d 05 a8 66 00 00 	lea    0x66a8(%rip),%rax        # 140015228 <.rdata+0x358>
   14000eb80:	48 89 c1             	mov    %rax,%rcx
   14000eb83:	48 8b 05 b6 c7 00 00 	mov    0xc7b6(%rip),%rax        # 14001b340 <__imp__assert>
   14000eb8a:	ff d0                	call   *%rax
   14000eb8c:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000eb93:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000eb97:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000eb9e:	48 39 c2             	cmp    %rax,%rdx
   14000eba1:	72 23                	jb     14000ebc6 <main+0x1b52>
   14000eba3:	41 b8 1b 05 00 00    	mov    $0x51b,%r8d
   14000eba9:	48 8d 05 20 63 00 00 	lea    0x6320(%rip),%rax        # 140014ed0 <.rdata>
   14000ebb0:	48 89 c2             	mov    %rax,%rdx
   14000ebb3:	48 8d 05 c6 66 00 00 	lea    0x66c6(%rip),%rax        # 140015280 <.rdata+0x3b0>
   14000ebba:	48 89 c1             	mov    %rax,%rcx
   14000ebbd:	48 8b 05 7c c7 00 00 	mov    0xc77c(%rip),%rax        # 14001b340 <__imp__assert>
   14000ebc4:	ff d0                	call   *%rax
   14000ebc6:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ebcd:	48 83 c0 10          	add    $0x10,%rax
   14000ebd1:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000ebd8:	e9 44 12 00 00       	jmp    14000fe21 <main+0x2dad>
   14000ebdd:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ebe4:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000ebe8:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000ebec:	48 89 85 d0 01 00 00 	mov    %rax,0x1d0(%rbp)
   14000ebf3:	48 89 95 d8 01 00 00 	mov    %rdx,0x1d8(%rbp)
   14000ebfa:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ec01:	48 83 e8 10          	sub    $0x10,%rax
   14000ec05:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000ec0c:	48 8b 85 d0 01 00 00 	mov    0x1d0(%rbp),%rax
   14000ec13:	48 83 e8 01          	sub    $0x1,%rax
   14000ec17:	48 89 85 c0 01 00 00 	mov    %rax,0x1c0(%rbp)
   14000ec1e:	48 c7 85 c8 01 00 00 	movq   $0x0,0x1c8(%rbp)
   14000ec25:	00 00 00 00 
   14000ec29:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000ec30:	48 8b 85 c0 01 00 00 	mov    0x1c0(%rbp),%rax
   14000ec37:	48 8b 95 c8 01 00 00 	mov    0x1c8(%rbp),%rdx
   14000ec3e:	48 89 01             	mov    %rax,(%rcx)
   14000ec41:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000ec45:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ec4c:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000ec50:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000ec57:	48 39 c2             	cmp    %rax,%rdx
   14000ec5a:	73 23                	jae    14000ec7f <main+0x1c0b>
   14000ec5c:	41 b8 24 05 00 00    	mov    $0x524,%r8d
   14000ec62:	48 8d 05 67 62 00 00 	lea    0x6267(%rip),%rax        # 140014ed0 <.rdata>
   14000ec69:	48 89 c2             	mov    %rax,%rdx
   14000ec6c:	48 8d 05 b5 65 00 00 	lea    0x65b5(%rip),%rax        # 140015228 <.rdata+0x358>
   14000ec73:	48 89 c1             	mov    %rax,%rcx
   14000ec76:	48 8b 05 c3 c6 00 00 	mov    0xc6c3(%rip),%rax        # 14001b340 <__imp__assert>
   14000ec7d:	ff d0                	call   *%rax
   14000ec7f:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ec86:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000ec8a:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000ec91:	48 39 c2             	cmp    %rax,%rdx
   14000ec94:	72 23                	jb     14000ecb9 <main+0x1c45>
   14000ec96:	41 b8 24 05 00 00    	mov    $0x524,%r8d
   14000ec9c:	48 8d 05 2d 62 00 00 	lea    0x622d(%rip),%rax        # 140014ed0 <.rdata>
   14000eca3:	48 89 c2             	mov    %rax,%rdx
   14000eca6:	48 8d 05 d3 65 00 00 	lea    0x65d3(%rip),%rax        # 140015280 <.rdata+0x3b0>
   14000ecad:	48 89 c1             	mov    %rax,%rcx
   14000ecb0:	48 8b 05 89 c6 00 00 	mov    0xc689(%rip),%rax        # 14001b340 <__imp__assert>
   14000ecb7:	ff d0                	call   *%rax
   14000ecb9:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ecc0:	48 83 c0 10          	add    $0x10,%rax
   14000ecc4:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000eccb:	e9 51 11 00 00       	jmp    14000fe21 <main+0x2dad>
   14000ecd0:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ecd7:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000ecdb:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000ecdf:	48 89 85 b0 01 00 00 	mov    %rax,0x1b0(%rbp)
   14000ece6:	48 89 95 b8 01 00 00 	mov    %rdx,0x1b8(%rbp)
   14000eced:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ecf4:	48 83 e8 10          	sub    $0x10,%rax
   14000ecf8:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000ecff:	48 8b 85 b0 01 00 00 	mov    0x1b0(%rbp),%rax
   14000ed06:	48 f7 d0             	not    %rax
   14000ed09:	48 89 85 b0 01 00 00 	mov    %rax,0x1b0(%rbp)
   14000ed10:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000ed17:	48 8b 85 b0 01 00 00 	mov    0x1b0(%rbp),%rax
   14000ed1e:	48 8b 95 b8 01 00 00 	mov    0x1b8(%rbp),%rdx
   14000ed25:	48 89 01             	mov    %rax,(%rcx)
   14000ed28:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000ed2c:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ed33:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000ed37:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000ed3e:	48 39 c2             	cmp    %rax,%rdx
   14000ed41:	73 23                	jae    14000ed66 <main+0x1cf2>
   14000ed43:	41 b8 2a 05 00 00    	mov    $0x52a,%r8d
   14000ed49:	48 8d 05 80 61 00 00 	lea    0x6180(%rip),%rax        # 140014ed0 <.rdata>
   14000ed50:	48 89 c2             	mov    %rax,%rdx
   14000ed53:	48 8d 05 ce 64 00 00 	lea    0x64ce(%rip),%rax        # 140015228 <.rdata+0x358>
   14000ed5a:	48 89 c1             	mov    %rax,%rcx
   14000ed5d:	48 8b 05 dc c5 00 00 	mov    0xc5dc(%rip),%rax        # 14001b340 <__imp__assert>
   14000ed64:	ff d0                	call   *%rax
   14000ed66:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ed6d:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000ed71:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000ed78:	48 39 c2             	cmp    %rax,%rdx
   14000ed7b:	72 23                	jb     14000eda0 <main+0x1d2c>
   14000ed7d:	41 b8 2a 05 00 00    	mov    $0x52a,%r8d
   14000ed83:	48 8d 05 46 61 00 00 	lea    0x6146(%rip),%rax        # 140014ed0 <.rdata>
   14000ed8a:	48 89 c2             	mov    %rax,%rdx
   14000ed8d:	48 8d 05 ec 64 00 00 	lea    0x64ec(%rip),%rax        # 140015280 <.rdata+0x3b0>
   14000ed94:	48 89 c1             	mov    %rax,%rcx
   14000ed97:	48 8b 05 a2 c5 00 00 	mov    0xc5a2(%rip),%rax        # 14001b340 <__imp__assert>
   14000ed9e:	ff d0                	call   *%rax
   14000eda0:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000eda7:	48 83 c0 10          	add    $0x10,%rax
   14000edab:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000edb2:	e9 6a 10 00 00       	jmp    14000fe21 <main+0x2dad>
   14000edb7:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000edbe:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000edc2:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000edc6:	48 89 85 90 01 00 00 	mov    %rax,0x190(%rbp)
   14000edcd:	48 89 95 98 01 00 00 	mov    %rdx,0x198(%rbp)
   14000edd4:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000eddb:	48 83 e8 10          	sub    $0x10,%rax
   14000eddf:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000ede6:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000eded:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000edf1:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000edf5:	48 89 85 a0 01 00 00 	mov    %rax,0x1a0(%rbp)
   14000edfc:	48 89 95 a8 01 00 00 	mov    %rdx,0x1a8(%rbp)
   14000ee03:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ee0a:	48 83 e8 10          	sub    $0x10,%rax
   14000ee0e:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000ee15:	48 8b 95 a0 01 00 00 	mov    0x1a0(%rbp),%rdx
   14000ee1c:	48 8b 85 90 01 00 00 	mov    0x190(%rbp),%rax
   14000ee23:	48 31 d0             	xor    %rdx,%rax
   14000ee26:	48 89 85 80 01 00 00 	mov    %rax,0x180(%rbp)
   14000ee2d:	48 c7 85 88 01 00 00 	movq   $0x0,0x188(%rbp)
   14000ee34:	00 00 00 00 
   14000ee38:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000ee3f:	48 8b 85 80 01 00 00 	mov    0x180(%rbp),%rax
   14000ee46:	48 8b 95 88 01 00 00 	mov    0x188(%rbp),%rdx
   14000ee4d:	48 89 01             	mov    %rax,(%rcx)
   14000ee50:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000ee54:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ee5b:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000ee5f:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000ee66:	48 39 c2             	cmp    %rax,%rdx
   14000ee69:	73 23                	jae    14000ee8e <main+0x1e1a>
   14000ee6b:	41 b8 35 05 00 00    	mov    $0x535,%r8d
   14000ee71:	48 8d 05 58 60 00 00 	lea    0x6058(%rip),%rax        # 140014ed0 <.rdata>
   14000ee78:	48 89 c2             	mov    %rax,%rdx
   14000ee7b:	48 8d 05 a6 63 00 00 	lea    0x63a6(%rip),%rax        # 140015228 <.rdata+0x358>
   14000ee82:	48 89 c1             	mov    %rax,%rcx
   14000ee85:	48 8b 05 b4 c4 00 00 	mov    0xc4b4(%rip),%rax        # 14001b340 <__imp__assert>
   14000ee8c:	ff d0                	call   *%rax
   14000ee8e:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ee95:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000ee99:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000eea0:	48 39 c2             	cmp    %rax,%rdx
   14000eea3:	72 23                	jb     14000eec8 <main+0x1e54>
   14000eea5:	41 b8 35 05 00 00    	mov    $0x535,%r8d
   14000eeab:	48 8d 05 1e 60 00 00 	lea    0x601e(%rip),%rax        # 140014ed0 <.rdata>
   14000eeb2:	48 89 c2             	mov    %rax,%rdx
   14000eeb5:	48 8d 05 c4 63 00 00 	lea    0x63c4(%rip),%rax        # 140015280 <.rdata+0x3b0>
   14000eebc:	48 89 c1             	mov    %rax,%rcx
   14000eebf:	48 8b 05 7a c4 00 00 	mov    0xc47a(%rip),%rax        # 14001b340 <__imp__assert>
   14000eec6:	ff d0                	call   *%rax
   14000eec8:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000eecf:	48 83 c0 10          	add    $0x10,%rax
   14000eed3:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000eeda:	e9 42 0f 00 00       	jmp    14000fe21 <main+0x2dad>
   14000eedf:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000eee6:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000eeea:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000eeee:	48 89 85 60 01 00 00 	mov    %rax,0x160(%rbp)
   14000eef5:	48 89 95 68 01 00 00 	mov    %rdx,0x168(%rbp)
   14000eefc:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ef03:	48 83 e8 10          	sub    $0x10,%rax
   14000ef07:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000ef0e:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ef15:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000ef19:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000ef1d:	48 89 85 70 01 00 00 	mov    %rax,0x170(%rbp)
   14000ef24:	48 89 95 78 01 00 00 	mov    %rdx,0x178(%rbp)
   14000ef2b:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ef32:	48 83 e8 10          	sub    $0x10,%rax
   14000ef36:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000ef3d:	48 8b 95 70 01 00 00 	mov    0x170(%rbp),%rdx
   14000ef44:	48 8b 85 60 01 00 00 	mov    0x160(%rbp),%rax
   14000ef4b:	48 21 d0             	and    %rdx,%rax
   14000ef4e:	48 89 85 50 01 00 00 	mov    %rax,0x150(%rbp)
   14000ef55:	48 c7 85 58 01 00 00 	movq   $0x0,0x158(%rbp)
   14000ef5c:	00 00 00 00 
   14000ef60:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000ef67:	48 8b 85 50 01 00 00 	mov    0x150(%rbp),%rax
   14000ef6e:	48 8b 95 58 01 00 00 	mov    0x158(%rbp),%rdx
   14000ef75:	48 89 01             	mov    %rax,(%rcx)
   14000ef78:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000ef7c:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000ef83:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000ef87:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000ef8e:	48 39 c2             	cmp    %rax,%rdx
   14000ef91:	73 23                	jae    14000efb6 <main+0x1f42>
   14000ef93:	41 b8 40 05 00 00    	mov    $0x540,%r8d
   14000ef99:	48 8d 05 30 5f 00 00 	lea    0x5f30(%rip),%rax        # 140014ed0 <.rdata>
   14000efa0:	48 89 c2             	mov    %rax,%rdx
   14000efa3:	48 8d 05 7e 62 00 00 	lea    0x627e(%rip),%rax        # 140015228 <.rdata+0x358>
   14000efaa:	48 89 c1             	mov    %rax,%rcx
   14000efad:	48 8b 05 8c c3 00 00 	mov    0xc38c(%rip),%rax        # 14001b340 <__imp__assert>
   14000efb4:	ff d0                	call   *%rax
   14000efb6:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000efbd:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000efc1:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000efc8:	48 39 c2             	cmp    %rax,%rdx
   14000efcb:	72 23                	jb     14000eff0 <main+0x1f7c>
   14000efcd:	41 b8 40 05 00 00    	mov    $0x540,%r8d
   14000efd3:	48 8d 05 f6 5e 00 00 	lea    0x5ef6(%rip),%rax        # 140014ed0 <.rdata>
   14000efda:	48 89 c2             	mov    %rax,%rdx
   14000efdd:	48 8d 05 9c 62 00 00 	lea    0x629c(%rip),%rax        # 140015280 <.rdata+0x3b0>
   14000efe4:	48 89 c1             	mov    %rax,%rcx
   14000efe7:	48 8b 05 52 c3 00 00 	mov    0xc352(%rip),%rax        # 14001b340 <__imp__assert>
   14000efee:	ff d0                	call   *%rax
   14000eff0:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000eff7:	48 83 c0 10          	add    $0x10,%rax
   14000effb:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f002:	e9 1a 0e 00 00       	jmp    14000fe21 <main+0x2dad>
   14000f007:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f00e:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f012:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f016:	48 89 85 30 01 00 00 	mov    %rax,0x130(%rbp)
   14000f01d:	48 89 95 38 01 00 00 	mov    %rdx,0x138(%rbp)
   14000f024:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f02b:	48 83 e8 10          	sub    $0x10,%rax
   14000f02f:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f036:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f03d:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f041:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f045:	48 89 85 40 01 00 00 	mov    %rax,0x140(%rbp)
   14000f04c:	48 89 95 48 01 00 00 	mov    %rdx,0x148(%rbp)
   14000f053:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f05a:	48 83 e8 10          	sub    $0x10,%rax
   14000f05e:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f065:	48 8b 95 40 01 00 00 	mov    0x140(%rbp),%rdx
   14000f06c:	48 8b 85 30 01 00 00 	mov    0x130(%rbp),%rax
   14000f073:	48 09 d0             	or     %rdx,%rax
   14000f076:	48 89 85 20 01 00 00 	mov    %rax,0x120(%rbp)
   14000f07d:	48 c7 85 28 01 00 00 	movq   $0x0,0x128(%rbp)
   14000f084:	00 00 00 00 
   14000f088:	48 8b 8d 98 04 00 00 	mov    0x498(%rbp),%rcx
   14000f08f:	48 8b 85 20 01 00 00 	mov    0x120(%rbp),%rax
   14000f096:	48 8b 95 28 01 00 00 	mov    0x128(%rbp),%rdx
   14000f09d:	48 89 01             	mov    %rax,(%rcx)
   14000f0a0:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   14000f0a4:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f0ab:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000f0af:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000f0b6:	48 39 c2             	cmp    %rax,%rdx
   14000f0b9:	73 23                	jae    14000f0de <main+0x206a>
   14000f0bb:	41 b8 4b 05 00 00    	mov    $0x54b,%r8d
   14000f0c1:	48 8d 05 08 5e 00 00 	lea    0x5e08(%rip),%rax        # 140014ed0 <.rdata>
   14000f0c8:	48 89 c2             	mov    %rax,%rdx
   14000f0cb:	48 8d 05 56 61 00 00 	lea    0x6156(%rip),%rax        # 140015228 <.rdata+0x358>
   14000f0d2:	48 89 c1             	mov    %rax,%rcx
   14000f0d5:	48 8b 05 64 c2 00 00 	mov    0xc264(%rip),%rax        # 14001b340 <__imp__assert>
   14000f0dc:	ff d0                	call   *%rax
   14000f0de:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f0e5:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000f0e9:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000f0f0:	48 39 c2             	cmp    %rax,%rdx
   14000f0f3:	72 23                	jb     14000f118 <main+0x20a4>
   14000f0f5:	41 b8 4b 05 00 00    	mov    $0x54b,%r8d
   14000f0fb:	48 8d 05 ce 5d 00 00 	lea    0x5dce(%rip),%rax        # 140014ed0 <.rdata>
   14000f102:	48 89 c2             	mov    %rax,%rdx
   14000f105:	48 8d 05 74 61 00 00 	lea    0x6174(%rip),%rax        # 140015280 <.rdata+0x3b0>
   14000f10c:	48 89 c1             	mov    %rax,%rcx
   14000f10f:	48 8b 05 2a c2 00 00 	mov    0xc22a(%rip),%rax        # 14001b340 <__imp__assert>
   14000f116:	ff d0                	call   *%rax
   14000f118:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f11f:	48 83 c0 10          	add    $0x10,%rax
   14000f123:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f12a:	e9 f2 0c 00 00       	jmp    14000fe21 <main+0x2dad>
   14000f12f:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f136:	48 8b 00             	mov    (%rax),%rax
   14000f139:	48 89 85 28 05 00 00 	mov    %rax,0x528(%rbp)
   14000f140:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f147:	48 83 c0 08          	add    $0x8,%rax
   14000f14b:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f152:	48 8b 85 28 05 00 00 	mov    0x528(%rbp),%rax
   14000f159:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f160:	e9 bc 0c 00 00       	jmp    14000fe21 <main+0x2dad>
   14000f165:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f16c:	48 8b 00             	mov    (%rax),%rax
   14000f16f:	48 89 85 30 05 00 00 	mov    %rax,0x530(%rbp)
   14000f176:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f17d:	48 83 c0 08          	add    $0x8,%rax
   14000f181:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f188:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f18f:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f193:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f197:	48 89 85 10 01 00 00 	mov    %rax,0x110(%rbp)
   14000f19e:	48 89 95 18 01 00 00 	mov    %rdx,0x118(%rbp)
   14000f1a5:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f1ac:	48 83 e8 10          	sub    $0x10,%rax
   14000f1b0:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f1b7:	48 8b 85 10 01 00 00 	mov    0x110(%rbp),%rax
   14000f1be:	48 85 c0             	test   %rax,%rax
   14000f1c1:	0f 85 5a 0c 00 00    	jne    14000fe21 <main+0x2dad>
   14000f1c7:	48 8b 85 30 05 00 00 	mov    0x530(%rbp),%rax
   14000f1ce:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f1d5:	e9 47 0c 00 00       	jmp    14000fe21 <main+0x2dad>
   14000f1da:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f1e1:	48 8b 00             	mov    (%rax),%rax
   14000f1e4:	48 89 85 38 05 00 00 	mov    %rax,0x538(%rbp)
   14000f1eb:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f1f2:	48 83 c0 08          	add    $0x8,%rax
   14000f1f6:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f1fd:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f204:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f208:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f20c:	48 89 85 00 01 00 00 	mov    %rax,0x100(%rbp)
   14000f213:	48 89 95 08 01 00 00 	mov    %rdx,0x108(%rbp)
   14000f21a:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f221:	48 83 e8 10          	sub    $0x10,%rax
   14000f225:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f22c:	f2 0f 10 85 00 01 00 	movsd  0x100(%rbp),%xmm0
   14000f233:	00 
   14000f234:	66 0f ef c9          	pxor   %xmm1,%xmm1
   14000f238:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
   14000f23c:	0f 8a df 0b 00 00    	jp     14000fe21 <main+0x2dad>
   14000f242:	66 0f ef c9          	pxor   %xmm1,%xmm1
   14000f246:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
   14000f24a:	75 2e                	jne    14000f27a <main+0x2206>
   14000f24c:	f2 0f 10 85 08 01 00 	movsd  0x108(%rbp),%xmm0
   14000f253:	00 
   14000f254:	66 0f ef c9          	pxor   %xmm1,%xmm1
   14000f258:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
   14000f25c:	0f 8a bf 0b 00 00    	jp     14000fe21 <main+0x2dad>
   14000f262:	66 0f ef c9          	pxor   %xmm1,%xmm1
   14000f266:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
   14000f26a:	75 0e                	jne    14000f27a <main+0x2206>
   14000f26c:	48 8b 85 38 05 00 00 	mov    0x538(%rbp),%rax
   14000f273:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f27a:	e9 a2 0b 00 00       	jmp    14000fe21 <main+0x2dad>
   14000f27f:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f286:	48 8b 00             	mov    (%rax),%rax
   14000f289:	48 89 85 40 05 00 00 	mov    %rax,0x540(%rbp)
   14000f290:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f297:	48 83 c0 08          	add    $0x8,%rax
   14000f29b:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f2a2:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f2a9:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f2ad:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f2b1:	48 89 85 e0 00 00 00 	mov    %rax,0xe0(%rbp)
   14000f2b8:	48 89 95 e8 00 00 00 	mov    %rdx,0xe8(%rbp)
   14000f2bf:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f2c6:	48 83 e8 10          	sub    $0x10,%rax
   14000f2ca:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f2d1:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f2d8:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f2dc:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f2e0:	48 89 85 f0 00 00 00 	mov    %rax,0xf0(%rbp)
   14000f2e7:	48 89 95 f8 00 00 00 	mov    %rdx,0xf8(%rbp)
   14000f2ee:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f2f5:	48 83 e8 10          	sub    $0x10,%rax
   14000f2f9:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f300:	48 8b 95 f0 00 00 00 	mov    0xf0(%rbp),%rdx
   14000f307:	48 8b 85 e0 00 00 00 	mov    0xe0(%rbp),%rax
   14000f30e:	48 39 c2             	cmp    %rax,%rdx
   14000f311:	0f 83 0a 0b 00 00    	jae    14000fe21 <main+0x2dad>
   14000f317:	48 8b 85 40 05 00 00 	mov    0x540(%rbp),%rax
   14000f31e:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f325:	e9 f7 0a 00 00       	jmp    14000fe21 <main+0x2dad>
   14000f32a:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f331:	48 8b 00             	mov    (%rax),%rax
   14000f334:	48 89 85 48 05 00 00 	mov    %rax,0x548(%rbp)
   14000f33b:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f342:	48 83 c0 08          	add    $0x8,%rax
   14000f346:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f34d:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f354:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f358:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f35c:	48 89 85 c0 00 00 00 	mov    %rax,0xc0(%rbp)
   14000f363:	48 89 95 c8 00 00 00 	mov    %rdx,0xc8(%rbp)
   14000f36a:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f371:	48 83 e8 10          	sub    $0x10,%rax
   14000f375:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f37c:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f383:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f387:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f38b:	48 89 85 d0 00 00 00 	mov    %rax,0xd0(%rbp)
   14000f392:	48 89 95 d8 00 00 00 	mov    %rdx,0xd8(%rbp)
   14000f399:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f3a0:	48 83 e8 10          	sub    $0x10,%rax
   14000f3a4:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f3ab:	f2 0f 10 8d d0 00 00 	movsd  0xd0(%rbp),%xmm1
   14000f3b2:	00 
   14000f3b3:	f2 0f 10 85 c0 00 00 	movsd  0xc0(%rbp),%xmm0
   14000f3ba:	00 
   14000f3bb:	66 0f 2f c1          	comisd %xmm1,%xmm0
   14000f3bf:	76 0e                	jbe    14000f3cf <main+0x235b>
   14000f3c1:	48 8b 85 48 05 00 00 	mov    0x548(%rbp),%rax
   14000f3c8:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f3cf:	e9 4d 0a 00 00       	jmp    14000fe21 <main+0x2dad>
   14000f3d4:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f3db:	48 8b 00             	mov    (%rax),%rax
   14000f3de:	48 89 85 50 05 00 00 	mov    %rax,0x550(%rbp)
   14000f3e5:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f3ec:	48 83 c0 08          	add    $0x8,%rax
   14000f3f0:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f3f7:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f3fe:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f402:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f406:	48 89 85 a0 00 00 00 	mov    %rax,0xa0(%rbp)
   14000f40d:	48 89 95 a8 00 00 00 	mov    %rdx,0xa8(%rbp)
   14000f414:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f41b:	48 83 e8 10          	sub    $0x10,%rax
   14000f41f:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f426:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f42d:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f431:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f435:	48 89 85 b0 00 00 00 	mov    %rax,0xb0(%rbp)
   14000f43c:	48 89 95 b8 00 00 00 	mov    %rdx,0xb8(%rbp)
   14000f443:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f44a:	48 83 e8 10          	sub    $0x10,%rax
   14000f44e:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f455:	48 8b 85 b0 00 00 00 	mov    0xb0(%rbp),%rax
   14000f45c:	48 8b 95 a0 00 00 00 	mov    0xa0(%rbp),%rdx
   14000f463:	48 39 c2             	cmp    %rax,%rdx
   14000f466:	0f 83 b5 09 00 00    	jae    14000fe21 <main+0x2dad>
   14000f46c:	48 8b 85 50 05 00 00 	mov    0x550(%rbp),%rax
   14000f473:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f47a:	e9 a2 09 00 00       	jmp    14000fe21 <main+0x2dad>
   14000f47f:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f486:	48 8b 00             	mov    (%rax),%rax
   14000f489:	48 89 85 58 05 00 00 	mov    %rax,0x558(%rbp)
   14000f490:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f497:	48 83 c0 08          	add    $0x8,%rax
   14000f49b:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f4a2:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f4a9:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f4ad:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f4b1:	48 89 85 80 00 00 00 	mov    %rax,0x80(%rbp)
   14000f4b8:	48 89 95 88 00 00 00 	mov    %rdx,0x88(%rbp)
   14000f4bf:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f4c6:	48 83 e8 10          	sub    $0x10,%rax
   14000f4ca:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f4d1:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f4d8:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f4dc:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f4e0:	48 89 85 90 00 00 00 	mov    %rax,0x90(%rbp)
   14000f4e7:	48 89 95 98 00 00 00 	mov    %rdx,0x98(%rbp)
   14000f4ee:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f4f5:	48 83 e8 10          	sub    $0x10,%rax
   14000f4f9:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f500:	f2 0f 10 85 90 00 00 	movsd  0x90(%rbp),%xmm0
   14000f507:	00 
   14000f508:	f2 0f 10 8d 80 00 00 	movsd  0x80(%rbp),%xmm1
   14000f50f:	00 
   14000f510:	66 0f 2f c1          	comisd %xmm1,%xmm0
   14000f514:	76 0e                	jbe    14000f524 <main+0x24b0>
   14000f516:	48 8b 85 58 05 00 00 	mov    0x558(%rbp),%rax
   14000f51d:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f524:	e9 f8 08 00 00       	jmp    14000fe21 <main+0x2dad>
   14000f529:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f530:	48 8b 00             	mov    (%rax),%rax
   14000f533:	48 89 85 60 05 00 00 	mov    %rax,0x560(%rbp)
   14000f53a:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f541:	48 83 c0 08          	add    $0x8,%rax
   14000f545:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f54c:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f553:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f557:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f55b:	48 89 45 60          	mov    %rax,0x60(%rbp)
   14000f55f:	48 89 55 68          	mov    %rdx,0x68(%rbp)
   14000f563:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f56a:	48 83 e8 10          	sub    $0x10,%rax
   14000f56e:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f575:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f57c:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f580:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f584:	48 89 45 70          	mov    %rax,0x70(%rbp)
   14000f588:	48 89 55 78          	mov    %rdx,0x78(%rbp)
   14000f58c:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f593:	48 83 e8 10          	sub    $0x10,%rax
   14000f597:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f59e:	48 8b 55 70          	mov    0x70(%rbp),%rdx
   14000f5a2:	48 8b 45 60          	mov    0x60(%rbp),%rax
   14000f5a6:	48 39 c2             	cmp    %rax,%rdx
   14000f5a9:	0f 85 72 08 00 00    	jne    14000fe21 <main+0x2dad>
   14000f5af:	48 8b 85 60 05 00 00 	mov    0x560(%rbp),%rax
   14000f5b6:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f5bd:	e9 5f 08 00 00       	jmp    14000fe21 <main+0x2dad>
   14000f5c2:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f5c9:	48 8b 00             	mov    (%rax),%rax
   14000f5cc:	48 89 85 68 05 00 00 	mov    %rax,0x568(%rbp)
   14000f5d3:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f5da:	48 83 c0 08          	add    $0x8,%rax
   14000f5de:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f5e5:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f5ec:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f5f0:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f5f4:	48 89 45 40          	mov    %rax,0x40(%rbp)
   14000f5f8:	48 89 55 48          	mov    %rdx,0x48(%rbp)
   14000f5fc:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f603:	48 83 e8 10          	sub    $0x10,%rax
   14000f607:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f60e:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f615:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f619:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f61d:	48 89 45 50          	mov    %rax,0x50(%rbp)
   14000f621:	48 89 55 58          	mov    %rdx,0x58(%rbp)
   14000f625:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f62c:	48 83 e8 10          	sub    $0x10,%rax
   14000f630:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f637:	f2 0f 10 45 50       	movsd  0x50(%rbp),%xmm0
   14000f63c:	f2 0f 10 4d 40       	movsd  0x40(%rbp),%xmm1
   14000f641:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
   14000f645:	0f 8a d6 07 00 00    	jp     14000fe21 <main+0x2dad>
   14000f64b:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
   14000f64f:	75 28                	jne    14000f679 <main+0x2605>
   14000f651:	f2 0f 10 45 58       	movsd  0x58(%rbp),%xmm0
   14000f656:	f2 0f 10 4d 48       	movsd  0x48(%rbp),%xmm1
   14000f65b:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
   14000f65f:	0f 8a bc 07 00 00    	jp     14000fe21 <main+0x2dad>
   14000f665:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
   14000f669:	75 0e                	jne    14000f679 <main+0x2605>
   14000f66b:	48 8b 85 68 05 00 00 	mov    0x568(%rbp),%rax
   14000f672:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f679:	e9 a3 07 00 00       	jmp    14000fe21 <main+0x2dad>
   14000f67e:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f685:	48 8b 00             	mov    (%rax),%rax
   14000f688:	48 89 85 70 05 00 00 	mov    %rax,0x570(%rbp)
   14000f68f:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f696:	48 83 c0 08          	add    $0x8,%rax
   14000f69a:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f6a1:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f6a8:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f6ac:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f6b0:	48 89 45 20          	mov    %rax,0x20(%rbp)
   14000f6b4:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   14000f6b8:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f6bf:	48 83 e8 10          	sub    $0x10,%rax
   14000f6c3:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f6ca:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f6d1:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f6d5:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f6d9:	48 89 45 30          	mov    %rax,0x30(%rbp)
   14000f6dd:	48 89 55 38          	mov    %rdx,0x38(%rbp)
   14000f6e1:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f6e8:	48 83 e8 10          	sub    $0x10,%rax
   14000f6ec:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f6f3:	48 8b 45 30          	mov    0x30(%rbp),%rax
   14000f6f7:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   14000f6fb:	48 39 c2             	cmp    %rax,%rdx
   14000f6fe:	0f 82 1d 07 00 00    	jb     14000fe21 <main+0x2dad>
   14000f704:	48 8b 85 70 05 00 00 	mov    0x570(%rbp),%rax
   14000f70b:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f712:	e9 0a 07 00 00       	jmp    14000fe21 <main+0x2dad>
   14000f717:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f71e:	48 8b 00             	mov    (%rax),%rax
   14000f721:	48 89 85 78 05 00 00 	mov    %rax,0x578(%rbp)
   14000f728:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f72f:	48 83 c0 08          	add    $0x8,%rax
   14000f733:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f73a:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f741:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f745:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f749:	48 89 45 00          	mov    %rax,0x0(%rbp)
   14000f74d:	48 89 55 08          	mov    %rdx,0x8(%rbp)
   14000f751:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f758:	48 83 e8 10          	sub    $0x10,%rax
   14000f75c:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f763:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f76a:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f76e:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f772:	48 89 45 10          	mov    %rax,0x10(%rbp)
   14000f776:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14000f77a:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f781:	48 83 e8 10          	sub    $0x10,%rax
   14000f785:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f78c:	f2 0f 10 4d 10       	movsd  0x10(%rbp),%xmm1
   14000f791:	f2 0f 10 45 00       	movsd  0x0(%rbp),%xmm0
   14000f796:	66 0f 2f c1          	comisd %xmm1,%xmm0
   14000f79a:	72 0e                	jb     14000f7aa <main+0x2736>
   14000f79c:	48 8b 85 78 05 00 00 	mov    0x578(%rbp),%rax
   14000f7a3:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f7aa:	e9 72 06 00 00       	jmp    14000fe21 <main+0x2dad>
   14000f7af:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f7b6:	48 8b 00             	mov    (%rax),%rax
   14000f7b9:	48 89 85 80 05 00 00 	mov    %rax,0x580(%rbp)
   14000f7c0:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f7c7:	48 83 c0 08          	add    $0x8,%rax
   14000f7cb:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f7d2:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f7d9:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f7dd:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f7e1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   14000f7e5:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
   14000f7e9:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f7f0:	48 83 e8 10          	sub    $0x10,%rax
   14000f7f4:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f7fb:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f802:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f806:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f80a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000f80e:	48 89 55 f8          	mov    %rdx,-0x8(%rbp)
   14000f812:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f819:	48 83 e8 10          	sub    $0x10,%rax
   14000f81d:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f824:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   14000f828:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   14000f82c:	48 39 c2             	cmp    %rax,%rdx
   14000f82f:	0f 82 ec 05 00 00    	jb     14000fe21 <main+0x2dad>
   14000f835:	48 8b 85 80 05 00 00 	mov    0x580(%rbp),%rax
   14000f83c:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f843:	e9 d9 05 00 00       	jmp    14000fe21 <main+0x2dad>
   14000f848:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f84f:	48 8b 00             	mov    (%rax),%rax
   14000f852:	48 89 85 88 05 00 00 	mov    %rax,0x588(%rbp)
   14000f859:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f860:	48 83 c0 08          	add    $0x8,%rax
   14000f864:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f86b:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f872:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f876:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f87a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   14000f87e:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   14000f882:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f889:	48 83 e8 10          	sub    $0x10,%rax
   14000f88d:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f894:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f89b:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f89f:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f8a3:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   14000f8a7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   14000f8ab:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f8b2:	48 83 e8 10          	sub    $0x10,%rax
   14000f8b6:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f8bd:	f2 0f 10 45 d0       	movsd  -0x30(%rbp),%xmm0
   14000f8c2:	f2 0f 10 4d c0       	movsd  -0x40(%rbp),%xmm1
   14000f8c7:	66 0f 2f c1          	comisd %xmm1,%xmm0
   14000f8cb:	72 0e                	jb     14000f8db <main+0x2867>
   14000f8cd:	48 8b 85 88 05 00 00 	mov    0x588(%rbp),%rax
   14000f8d4:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f8db:	e9 41 05 00 00       	jmp    14000fe21 <main+0x2dad>
   14000f8e0:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f8e7:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000f8eb:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000f8ef:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
   14000f8f3:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   14000f8f7:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f8fe:	48 83 e8 10          	sub    $0x10,%rax
   14000f902:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000f909:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f910:	0f b6 00             	movzbl (%rax),%eax
   14000f913:	88 85 96 05 00 00    	mov    %al,0x596(%rbp)
   14000f919:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000f920:	48 83 c0 01          	add    $0x1,%rax
   14000f924:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000f92b:	80 bd 96 05 00 00 10 	cmpb   $0x10,0x596(%rbp)
   14000f932:	76 23                	jbe    14000f957 <main+0x28e3>
   14000f934:	41 b8 e3 05 00 00    	mov    $0x5e3,%r8d
   14000f93a:	48 8d 05 8f 55 00 00 	lea    0x558f(%rip),%rax        # 140014ed0 <.rdata>
   14000f941:	48 89 c2             	mov    %rax,%rdx
   14000f944:	48 8d 05 ab 5f 00 00 	lea    0x5fab(%rip),%rax        # 1400158f6 <.rdata+0xa26>
   14000f94b:	48 89 c1             	mov    %rax,%rcx
   14000f94e:	48 8b 05 eb b9 00 00 	mov    0xb9eb(%rip),%rax        # 14001b340 <__imp__assert>
   14000f955:	ff d0                	call   *%rax
   14000f957:	0f b6 95 96 05 00 00 	movzbl 0x596(%rbp),%edx
   14000f95e:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   14000f962:	48 89 c1             	mov    %rax,%rcx
   14000f965:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f96c:	49 89 d0             	mov    %rdx,%r8
   14000f96f:	48 89 ca             	mov    %rcx,%rdx
   14000f972:	48 89 c1             	mov    %rax,%rcx
   14000f975:	e8 06 21 00 00       	call   140011a80 <memmove>
   14000f97a:	80 bd 96 05 00 00 0f 	cmpb   $0xf,0x596(%rbp)
   14000f981:	77 33                	ja     14000f9b6 <main+0x2942>
   14000f983:	0f b6 85 96 05 00 00 	movzbl 0x596(%rbp),%eax
   14000f98a:	ba 10 00 00 00       	mov    $0x10,%edx
   14000f98f:	48 89 d1             	mov    %rdx,%rcx
   14000f992:	48 29 c1             	sub    %rax,%rcx
   14000f995:	48 8b 95 98 04 00 00 	mov    0x498(%rbp),%rdx
   14000f99c:	0f b6 85 96 05 00 00 	movzbl 0x596(%rbp),%eax
   14000f9a3:	48 01 d0             	add    %rdx,%rax
   14000f9a6:	49 89 c8             	mov    %rcx,%r8
   14000f9a9:	ba 00 00 00 00       	mov    $0x0,%edx
   14000f9ae:	48 89 c1             	mov    %rax,%rcx
   14000f9b1:	e8 d2 20 00 00       	call   140011a88 <memset>
   14000f9b6:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f9bd:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000f9c1:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000f9c8:	48 39 c2             	cmp    %rax,%rdx
   14000f9cb:	73 23                	jae    14000f9f0 <main+0x297c>
   14000f9cd:	41 b8 e9 05 00 00    	mov    $0x5e9,%r8d
   14000f9d3:	48 8d 05 f6 54 00 00 	lea    0x54f6(%rip),%rax        # 140014ed0 <.rdata>
   14000f9da:	48 89 c2             	mov    %rax,%rdx
   14000f9dd:	48 8d 05 44 58 00 00 	lea    0x5844(%rip),%rax        # 140015228 <.rdata+0x358>
   14000f9e4:	48 89 c1             	mov    %rax,%rcx
   14000f9e7:	48 8b 05 52 b9 00 00 	mov    0xb952(%rip),%rax        # 14001b340 <__imp__assert>
   14000f9ee:	ff d0                	call   *%rax
   14000f9f0:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000f9f7:	48 8d 50 10          	lea    0x10(%rax),%rdx
   14000f9fb:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000fa02:	48 39 c2             	cmp    %rax,%rdx
   14000fa05:	72 23                	jb     14000fa2a <main+0x29b6>
   14000fa07:	41 b8 e9 05 00 00    	mov    $0x5e9,%r8d
   14000fa0d:	48 8d 05 bc 54 00 00 	lea    0x54bc(%rip),%rax        # 140014ed0 <.rdata>
   14000fa14:	48 89 c2             	mov    %rax,%rdx
   14000fa17:	48 8d 05 62 58 00 00 	lea    0x5862(%rip),%rax        # 140015280 <.rdata+0x3b0>
   14000fa1e:	48 89 c1             	mov    %rax,%rcx
   14000fa21:	48 8b 05 18 b9 00 00 	mov    0xb918(%rip),%rax        # 14001b340 <__imp__assert>
   14000fa28:	ff d0                	call   *%rax
   14000fa2a:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000fa31:	48 83 c0 10          	add    $0x10,%rax
   14000fa35:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000fa3c:	e9 e0 03 00 00       	jmp    14000fe21 <main+0x2dad>
   14000fa41:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000fa48:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000fa4c:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000fa50:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   14000fa54:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
   14000fa58:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000fa5f:	48 83 e8 10          	sub    $0x10,%rax
   14000fa63:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000fa6a:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000fa71:	0f b6 00             	movzbl (%rax),%eax
   14000fa74:	88 85 97 05 00 00    	mov    %al,0x597(%rbp)
   14000fa7a:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000fa81:	48 83 c0 01          	add    $0x1,%rax
   14000fa85:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000fa8c:	80 bd 97 05 00 00 10 	cmpb   $0x10,0x597(%rbp)
   14000fa93:	76 23                	jbe    14000fab8 <main+0x2a44>
   14000fa95:	41 b8 f0 05 00 00    	mov    $0x5f0,%r8d
   14000fa9b:	48 8d 05 2e 54 00 00 	lea    0x542e(%rip),%rax        # 140014ed0 <.rdata>
   14000faa2:	48 89 c2             	mov    %rax,%rdx
   14000faa5:	48 8d 05 4a 5e 00 00 	lea    0x5e4a(%rip),%rax        # 1400158f6 <.rdata+0xa26>
   14000faac:	48 89 c1             	mov    %rax,%rcx
   14000faaf:	48 8b 05 8a b8 00 00 	mov    0xb88a(%rip),%rax        # 14001b340 <__imp__assert>
   14000fab6:	ff d0                	call   *%rax
   14000fab8:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000fabf:	48 8d 50 f0          	lea    -0x10(%rax),%rdx
   14000fac3:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000faca:	48 39 c2             	cmp    %rax,%rdx
   14000facd:	73 23                	jae    14000faf2 <main+0x2a7e>
   14000facf:	41 b8 f1 05 00 00    	mov    $0x5f1,%r8d
   14000fad5:	48 8d 05 f4 53 00 00 	lea    0x53f4(%rip),%rax        # 140014ed0 <.rdata>
   14000fadc:	48 89 c2             	mov    %rax,%rdx
   14000fadf:	48 8d 05 82 5a 00 00 	lea    0x5a82(%rip),%rax        # 140015568 <.rdata+0x698>
   14000fae6:	48 89 c1             	mov    %rax,%rcx
   14000fae9:	48 8b 05 50 b8 00 00 	mov    0xb850(%rip),%rax        # 14001b340 <__imp__assert>
   14000faf0:	ff d0                	call   *%rax
   14000faf2:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000faf9:	48 8d 50 f0          	lea    -0x10(%rax),%rdx
   14000fafd:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000fb04:	48 39 c2             	cmp    %rax,%rdx
   14000fb07:	72 23                	jb     14000fb2c <main+0x2ab8>
   14000fb09:	41 b8 f1 05 00 00    	mov    $0x5f1,%r8d
   14000fb0f:	48 8d 05 ba 53 00 00 	lea    0x53ba(%rip),%rax        # 140014ed0 <.rdata>
   14000fb16:	48 89 c2             	mov    %rax,%rdx
   14000fb19:	48 8d 05 b0 5a 00 00 	lea    0x5ab0(%rip),%rax        # 1400155d0 <.rdata+0x700>
   14000fb20:	48 89 c1             	mov    %rax,%rcx
   14000fb23:	48 8b 05 16 b8 00 00 	mov    0xb816(%rip),%rax        # 14001b340 <__imp__assert>
   14000fb2a:	ff d0                	call   *%rax
   14000fb2c:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000fb33:	48 83 e8 10          	sub    $0x10,%rax
   14000fb37:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000fb3e:	0f b6 95 97 05 00 00 	movzbl 0x597(%rbp),%edx
   14000fb45:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000fb4c:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
   14000fb50:	49 89 d0             	mov    %rdx,%r8
   14000fb53:	48 89 c2             	mov    %rax,%rdx
   14000fb56:	e8 25 1f 00 00       	call   140011a80 <memmove>
   14000fb5b:	e9 c1 02 00 00       	jmp    14000fe21 <main+0x2dad>
   14000fb60:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000fb67:	48 8b 00             	mov    (%rax),%rax
   14000fb6a:	48 89 85 98 05 00 00 	mov    %rax,0x598(%rbp)
   14000fb71:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000fb78:	48 83 c0 08          	add    $0x8,%rax
   14000fb7c:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000fb83:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000fb8a:	48 8b 95 80 04 00 00 	mov    0x480(%rbp),%rdx
   14000fb91:	48 89 10             	mov    %rdx,(%rax)
   14000fb94:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000fb9b:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000fb9f:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000fba6:	48 39 c2             	cmp    %rax,%rdx
   14000fba9:	73 23                	jae    14000fbce <main+0x2b5a>
   14000fbab:	41 b8 f7 05 00 00    	mov    $0x5f7,%r8d
   14000fbb1:	48 8d 05 18 53 00 00 	lea    0x5318(%rip),%rax        # 140014ed0 <.rdata>
   14000fbb8:	48 89 c2             	mov    %rax,%rdx
   14000fbbb:	48 8d 05 4e 5d 00 00 	lea    0x5d4e(%rip),%rax        # 140015910 <.rdata+0xa40>
   14000fbc2:	48 89 c1             	mov    %rax,%rcx
   14000fbc5:	48 8b 05 74 b7 00 00 	mov    0xb774(%rip),%rax        # 14001b340 <__imp__assert>
   14000fbcc:	ff d0                	call   *%rax
   14000fbce:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000fbd5:	48 8d 50 08          	lea    0x8(%rax),%rdx
   14000fbd9:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000fbe0:	48 39 c2             	cmp    %rax,%rdx
   14000fbe3:	72 23                	jb     14000fc08 <main+0x2b94>
   14000fbe5:	41 b8 f7 05 00 00    	mov    $0x5f7,%r8d
   14000fbeb:	48 8d 05 de 52 00 00 	lea    0x52de(%rip),%rax        # 140014ed0 <.rdata>
   14000fbf2:	48 89 c2             	mov    %rax,%rdx
   14000fbf5:	48 8d 05 74 5d 00 00 	lea    0x5d74(%rip),%rax        # 140015970 <.rdata+0xaa0>
   14000fbfc:	48 89 c1             	mov    %rax,%rcx
   14000fbff:	48 8b 05 3a b7 00 00 	mov    0xb73a(%rip),%rax        # 14001b340 <__imp__assert>
   14000fc06:	ff d0                	call   *%rax
   14000fc08:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000fc0f:	48 83 c0 08          	add    $0x8,%rax
   14000fc13:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000fc1a:	48 8b 85 98 05 00 00 	mov    0x598(%rbp),%rax
   14000fc21:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000fc28:	e9 f4 01 00 00       	jmp    14000fe21 <main+0x2dad>
   14000fc2d:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000fc34:	0f b7 00             	movzwl (%rax),%eax
   14000fc37:	66 89 85 a6 05 00 00 	mov    %ax,0x5a6(%rbp)
   14000fc3e:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000fc45:	48 83 c0 02          	add    $0x2,%rax
   14000fc49:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000fc50:	0f b7 95 a6 05 00 00 	movzwl 0x5a6(%rbp),%edx
   14000fc57:	48 8d 85 80 04 00 00 	lea    0x480(%rbp),%rax
   14000fc5e:	48 89 c1             	mov    %rax,%rcx
   14000fc61:	e8 08 cb ff ff       	call   14000c76e <state__builtin_execute>
   14000fc66:	e9 b6 01 00 00       	jmp    14000fe21 <main+0x2dad>
   14000fc6b:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000fc72:	48 8b 40 f8          	mov    -0x8(%rax),%rax
   14000fc76:	48 89 85 b8 05 00 00 	mov    %rax,0x5b8(%rbp)
   14000fc7d:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000fc84:	48 83 e8 08          	sub    $0x8,%rax
   14000fc88:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000fc8f:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000fc96:	0f b7 00             	movzwl (%rax),%eax
   14000fc99:	66 89 85 b6 05 00 00 	mov    %ax,0x5b6(%rbp)
   14000fca0:	48 8b 85 80 04 00 00 	mov    0x480(%rbp),%rax
   14000fca7:	48 83 c0 02          	add    $0x2,%rax
   14000fcab:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000fcb2:	8b 95 c0 04 00 00    	mov    0x4c0(%rbp),%edx
   14000fcb8:	0f b7 85 b6 05 00 00 	movzwl 0x5b6(%rbp),%eax
   14000fcbf:	39 c2                	cmp    %eax,%edx
   14000fcc1:	73 23                	jae    14000fce6 <main+0x2c72>
   14000fcc3:	41 b8 04 06 00 00    	mov    $0x604,%r8d
   14000fcc9:	48 8d 05 00 52 00 00 	lea    0x5200(%rip),%rax        # 140014ed0 <.rdata>
   14000fcd0:	48 89 c2             	mov    %rax,%rdx
   14000fcd3:	48 8d 05 f6 5c 00 00 	lea    0x5cf6(%rip),%rax        # 1400159d0 <.rdata+0xb00>
   14000fcda:	48 89 c1             	mov    %rax,%rcx
   14000fcdd:	48 8b 05 5c b6 00 00 	mov    0xb65c(%rip),%rax        # 14001b340 <__imp__assert>
   14000fce4:	ff d0                	call   *%rax
   14000fce6:	8b 95 c0 04 00 00    	mov    0x4c0(%rbp),%edx
   14000fcec:	0f b7 85 b6 05 00 00 	movzwl 0x5b6(%rbp),%eax
   14000fcf3:	29 c2                	sub    %eax,%edx
   14000fcf5:	89 95 c0 04 00 00    	mov    %edx,0x4c0(%rbp)
   14000fcfb:	66 83 bd b6 05 00 00 	cmpw   $0x0,0x5b6(%rbp)
   14000fd02:	00 
   14000fd03:	0f 84 94 00 00 00    	je     14000fd9d <main+0x2d29>
   14000fd09:	48 8b 85 b8 04 00 00 	mov    0x4b8(%rbp),%rax
   14000fd10:	8b 95 c0 04 00 00    	mov    0x4c0(%rbp),%edx
   14000fd16:	89 d2                	mov    %edx,%edx
   14000fd18:	48 c1 e2 03          	shl    $0x3,%rdx
   14000fd1c:	48 01 d0             	add    %rdx,%rax
   14000fd1f:	48 8b 00             	mov    (%rax),%rax
   14000fd22:	48 89 85 a8 05 00 00 	mov    %rax,0x5a8(%rbp)
   14000fd29:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000fd30:	48 39 85 a8 05 00 00 	cmp    %rax,0x5a8(%rbp)
   14000fd37:	73 23                	jae    14000fd5c <main+0x2ce8>
   14000fd39:	41 b8 08 06 00 00    	mov    $0x608,%r8d
   14000fd3f:	48 8d 05 8a 51 00 00 	lea    0x518a(%rip),%rax        # 140014ed0 <.rdata>
   14000fd46:	48 89 c2             	mov    %rax,%rdx
   14000fd49:	48 8d 05 30 59 00 00 	lea    0x5930(%rip),%rax        # 140015680 <.rdata+0x7b0>
   14000fd50:	48 89 c1             	mov    %rax,%rcx
   14000fd53:	48 8b 05 e6 b5 00 00 	mov    0xb5e6(%rip),%rax        # 14001b340 <__imp__assert>
   14000fd5a:	ff d0                	call   *%rax
   14000fd5c:	48 8b 85 a8 04 00 00 	mov    0x4a8(%rbp),%rax
   14000fd63:	48 39 85 a8 05 00 00 	cmp    %rax,0x5a8(%rbp)
   14000fd6a:	72 23                	jb     14000fd8f <main+0x2d1b>
   14000fd6c:	41 b8 08 06 00 00    	mov    $0x608,%r8d
   14000fd72:	48 8d 05 57 51 00 00 	lea    0x5157(%rip),%rax        # 140014ed0 <.rdata>
   14000fd79:	48 89 c2             	mov    %rax,%rdx
   14000fd7c:	48 8d 05 3d 59 00 00 	lea    0x593d(%rip),%rax        # 1400156c0 <.rdata+0x7f0>
   14000fd83:	48 89 c1             	mov    %rax,%rcx
   14000fd86:	48 8b 05 b3 b5 00 00 	mov    0xb5b3(%rip),%rax        # 14001b340 <__imp__assert>
   14000fd8d:	ff d0                	call   *%rax
   14000fd8f:	48 8b 85 a8 05 00 00 	mov    0x5a8(%rbp),%rax
   14000fd96:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000fd9d:	48 8b 85 b8 05 00 00 	mov    0x5b8(%rbp),%rax
   14000fda4:	48 89 85 80 04 00 00 	mov    %rax,0x480(%rbp)
   14000fdab:	eb 74                	jmp    14000fe21 <main+0x2dad>
   14000fdad:	c6 85 e8 04 00 00 00 	movb   $0x0,0x4e8(%rbp)
   14000fdb4:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000fdbb:	48 8b 50 f8          	mov    -0x8(%rax),%rdx
   14000fdbf:	48 8b 40 f0          	mov    -0x10(%rax),%rax
   14000fdc3:	48 89 85 c8 04 00 00 	mov    %rax,0x4c8(%rbp)
   14000fdca:	48 89 95 d0 04 00 00 	mov    %rdx,0x4d0(%rbp)
   14000fdd1:	48 8b 85 98 04 00 00 	mov    0x498(%rbp),%rax
   14000fdd8:	48 83 e8 10          	sub    $0x10,%rax
   14000fddc:	48 89 85 98 04 00 00 	mov    %rax,0x498(%rbp)
   14000fde3:	48 8b 85 c8 04 00 00 	mov    0x4c8(%rbp),%rax
   14000fdea:	48 89 c2             	mov    %rax,%rdx
   14000fded:	48 8d 05 31 5c 00 00 	lea    0x5c31(%rip),%rax        # 140015a25 <.rdata+0xb55>
   14000fdf4:	48 89 c1             	mov    %rax,%rcx
   14000fdf7:	e8 34 18 00 00       	call   140011630 <printf>
   14000fdfc:	eb 23                	jmp    14000fe21 <main+0x2dad>
   14000fdfe:	41 b8 11 06 00 00    	mov    $0x611,%r8d
   14000fe04:	48 8d 05 c5 50 00 00 	lea    0x50c5(%rip),%rax        # 140014ed0 <.rdata>
   14000fe0b:	48 89 c2             	mov    %rax,%rdx
   14000fe0e:	48 8d 05 e6 50 00 00 	lea    0x50e6(%rip),%rax        # 140014efb <.rdata+0x2b>
   14000fe15:	48 89 c1             	mov    %rax,%rcx
   14000fe18:	48 8b 05 21 b5 00 00 	mov    0xb521(%rip),%rax        # 14001b340 <__imp__assert>
   14000fe1f:	ff d0                	call   *%rax
   14000fe21:	0f b6 85 e8 04 00 00 	movzbl 0x4e8(%rbp),%eax
   14000fe28:	84 c0                	test   %al,%al
   14000fe2a:	0f 85 d4 d3 ff ff    	jne    14000d204 <main+0x190>
   14000fe30:	83 85 ec 05 00 00 01 	addl   $0x1,0x5ec(%rbp)
   14000fe37:	8b 85 ec 05 00 00    	mov    0x5ec(%rbp),%eax
   14000fe3d:	3b 85 c4 05 00 00    	cmp    0x5c4(%rbp),%eax
   14000fe43:	0f 82 85 d3 ff ff    	jb     14000d1ce <main+0x15a>
   14000fe49:	48 8b 85 f0 04 00 00 	mov    0x4f0(%rbp),%rax
   14000fe50:	48 89 c1             	mov    %rax,%rcx
   14000fe53:	e8 08 1c 00 00       	call   140011a60 <free>
   14000fe58:	48 8b 85 88 04 00 00 	mov    0x488(%rbp),%rax
   14000fe5f:	48 89 c1             	mov    %rax,%rcx
   14000fe62:	e8 f9 1b 00 00       	call   140011a60 <free>
   14000fe67:	48 8b 85 a0 04 00 00 	mov    0x4a0(%rbp),%rax
   14000fe6e:	48 89 c1             	mov    %rax,%rcx
   14000fe71:	e8 ea 1b 00 00       	call   140011a60 <free>
   14000fe76:	b8 00 00 00 00       	mov    $0x0,%eax
   14000fe7b:	48 81 c4 78 06 00 00 	add    $0x678,%rsp
   14000fe82:	5f                   	pop    %rdi
   14000fe83:	5d                   	pop    %rbp
   14000fe84:	c3                   	ret
   14000fe85:	90                   	nop
   14000fe86:	90                   	nop
   14000fe87:	90                   	nop
   14000fe88:	90                   	nop
   14000fe89:	90                   	nop
   14000fe8a:	90                   	nop
   14000fe8b:	90                   	nop
   14000fe8c:	90                   	nop
   14000fe8d:	90                   	nop
   14000fe8e:	90                   	nop
   14000fe8f:	90                   	nop

000000014000fe90 <__do_global_dtors>:
   14000fe90:	55                   	push   %rbp
   14000fe91:	48 89 e5             	mov    %rsp,%rbp
   14000fe94:	48 83 ec 20          	sub    $0x20,%rsp
   14000fe98:	eb 1e                	jmp    14000feb8 <__do_global_dtors+0x28>
   14000fe9a:	48 8b 05 6f 21 00 00 	mov    0x216f(%rip),%rax        # 140012010 <p.0>
   14000fea1:	48 8b 00             	mov    (%rax),%rax
   14000fea4:	ff d0                	call   *%rax
   14000fea6:	48 8b 05 63 21 00 00 	mov    0x2163(%rip),%rax        # 140012010 <p.0>
   14000fead:	48 83 c0 08          	add    $0x8,%rax
   14000feb1:	48 89 05 58 21 00 00 	mov    %rax,0x2158(%rip)        # 140012010 <p.0>
   14000feb8:	48 8b 05 51 21 00 00 	mov    0x2151(%rip),%rax        # 140012010 <p.0>
   14000febf:	48 8b 00             	mov    (%rax),%rax
   14000fec2:	48 85 c0             	test   %rax,%rax
   14000fec5:	75 d3                	jne    14000fe9a <__do_global_dtors+0xa>
   14000fec7:	90                   	nop
   14000fec8:	90                   	nop
   14000fec9:	48 83 c4 20          	add    $0x20,%rsp
   14000fecd:	5d                   	pop    %rbp
   14000fece:	c3                   	ret

000000014000fecf <__do_global_ctors>:
   14000fecf:	55                   	push   %rbp
   14000fed0:	48 89 e5             	mov    %rsp,%rbp
   14000fed3:	48 83 ec 30          	sub    $0x30,%rsp
   14000fed7:	48 8b 05 92 5f 00 00 	mov    0x5f92(%rip),%rax        # 140015e70 <.refptr.__CTOR_LIST__>
   14000fede:	48 8b 00             	mov    (%rax),%rax
   14000fee1:	89 45 fc             	mov    %eax,-0x4(%rbp)
   14000fee4:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%rbp)
   14000fee8:	75 25                	jne    14000ff0f <__do_global_ctors+0x40>
   14000feea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   14000fef1:	eb 04                	jmp    14000fef7 <__do_global_ctors+0x28>
   14000fef3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   14000fef7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   14000fefa:	8d 50 01             	lea    0x1(%rax),%edx
   14000fefd:	48 8b 05 6c 5f 00 00 	mov    0x5f6c(%rip),%rax        # 140015e70 <.refptr.__CTOR_LIST__>
   14000ff04:	89 d2                	mov    %edx,%edx
   14000ff06:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   14000ff0a:	48 85 c0             	test   %rax,%rax
   14000ff0d:	75 e4                	jne    14000fef3 <__do_global_ctors+0x24>
   14000ff0f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   14000ff12:	89 45 f8             	mov    %eax,-0x8(%rbp)
   14000ff15:	eb 14                	jmp    14000ff2b <__do_global_ctors+0x5c>
   14000ff17:	48 8b 05 52 5f 00 00 	mov    0x5f52(%rip),%rax        # 140015e70 <.refptr.__CTOR_LIST__>
   14000ff1e:	8b 55 f8             	mov    -0x8(%rbp),%edx
   14000ff21:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   14000ff25:	ff d0                	call   *%rax
   14000ff27:	83 6d f8 01          	subl   $0x1,-0x8(%rbp)
   14000ff2b:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
   14000ff2f:	75 e6                	jne    14000ff17 <__do_global_ctors+0x48>
   14000ff31:	48 8d 05 58 ff ff ff 	lea    -0xa8(%rip),%rax        # 14000fe90 <__do_global_dtors>
   14000ff38:	48 89 c1             	mov    %rax,%rcx
   14000ff3b:	e8 43 16 ff ff       	call   140001583 <atexit>
   14000ff40:	90                   	nop
   14000ff41:	48 83 c4 30          	add    $0x30,%rsp
   14000ff45:	5d                   	pop    %rbp
   14000ff46:	c3                   	ret

000000014000ff47 <__main>:
   14000ff47:	55                   	push   %rbp
   14000ff48:	48 89 e5             	mov    %rsp,%rbp
   14000ff4b:	48 83 ec 20          	sub    $0x20,%rsp
   14000ff4f:	8b 05 4b a1 00 00    	mov    0xa14b(%rip),%eax        # 14001a0a0 <initialized>
   14000ff55:	85 c0                	test   %eax,%eax
   14000ff57:	75 0f                	jne    14000ff68 <__main+0x21>
   14000ff59:	c7 05 3d a1 00 00 01 	movl   $0x1,0xa13d(%rip)        # 14001a0a0 <initialized>
   14000ff60:	00 00 00 
   14000ff63:	e8 67 ff ff ff       	call   14000fecf <__do_global_ctors>
   14000ff68:	90                   	nop
   14000ff69:	48 83 c4 20          	add    $0x20,%rsp
   14000ff6d:	5d                   	pop    %rbp
   14000ff6e:	c3                   	ret
   14000ff6f:	90                   	nop

000000014000ff70 <_setargv>:
   14000ff70:	55                   	push   %rbp
   14000ff71:	48 89 e5             	mov    %rsp,%rbp
   14000ff74:	b8 00 00 00 00       	mov    $0x0,%eax
   14000ff79:	5d                   	pop    %rbp
   14000ff7a:	c3                   	ret
   14000ff7b:	90                   	nop
   14000ff7c:	90                   	nop
   14000ff7d:	90                   	nop
   14000ff7e:	90                   	nop
   14000ff7f:	90                   	nop

000000014000ff80 <__dyn_tls_init>:
   14000ff80:	55                   	push   %rbp
   14000ff81:	48 89 e5             	mov    %rsp,%rbp
   14000ff84:	48 83 ec 30          	sub    $0x30,%rsp
   14000ff88:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14000ff8c:	89 55 18             	mov    %edx,0x18(%rbp)
   14000ff8f:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   14000ff93:	48 8b 05 b6 5e 00 00 	mov    0x5eb6(%rip),%rax        # 140015e50 <.refptr._CRT_MT>
   14000ff9a:	8b 00                	mov    (%rax),%eax
   14000ff9c:	83 f8 02             	cmp    $0x2,%eax
   14000ff9f:	74 0d                	je     14000ffae <__dyn_tls_init+0x2e>
   14000ffa1:	48 8b 05 a8 5e 00 00 	mov    0x5ea8(%rip),%rax        # 140015e50 <.refptr._CRT_MT>
   14000ffa8:	c7 00 02 00 00 00    	movl   $0x2,(%rax)
   14000ffae:	83 7d 18 02          	cmpl   $0x2,0x18(%rbp)
   14000ffb2:	74 23                	je     14000ffd7 <__dyn_tls_init+0x57>
   14000ffb4:	83 7d 18 01          	cmpl   $0x1,0x18(%rbp)
   14000ffb8:	75 16                	jne    14000ffd0 <__dyn_tls_init+0x50>
   14000ffba:	48 8b 4d 20          	mov    0x20(%rbp),%rcx
   14000ffbe:	8b 55 18             	mov    0x18(%rbp),%edx
   14000ffc1:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14000ffc5:	49 89 c8             	mov    %rcx,%r8
   14000ffc8:	48 89 c1             	mov    %rax,%rcx
   14000ffcb:	e8 61 0f 00 00       	call   140010f31 <__mingw_TLScallback>
   14000ffd0:	b8 01 00 00 00       	mov    $0x1,%eax
   14000ffd5:	eb 46                	jmp    14001001d <__dyn_tls_init+0x9d>
   14000ffd7:	48 8d 05 72 c0 00 00 	lea    0xc072(%rip),%rax        # 14001c050 <___crt_xp_end__>
   14000ffde:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14000ffe2:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
   14000ffe7:	eb 22                	jmp    14001000b <__dyn_tls_init+0x8b>
   14000ffe9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14000ffed:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14000fff1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14000fff5:	48 8b 00             	mov    (%rax),%rax
   14000fff8:	48 85 c0             	test   %rax,%rax
   14000fffb:	74 09                	je     140010006 <__dyn_tls_init+0x86>
   14000fffd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140010001:	48 8b 00             	mov    (%rax),%rax
   140010004:	ff d0                	call   *%rax
   140010006:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
   14001000b:	48 8d 05 46 c0 00 00 	lea    0xc046(%rip),%rax        # 14001c058 <__xd_z>
   140010012:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   140010016:	75 d1                	jne    14000ffe9 <__dyn_tls_init+0x69>
   140010018:	b8 01 00 00 00       	mov    $0x1,%eax
   14001001d:	48 83 c4 30          	add    $0x30,%rsp
   140010021:	5d                   	pop    %rbp
   140010022:	c3                   	ret

0000000140010023 <__tlregdtor>:
   140010023:	55                   	push   %rbp
   140010024:	48 89 e5             	mov    %rsp,%rbp
   140010027:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14001002b:	48 83 7d 10 00       	cmpq   $0x0,0x10(%rbp)
   140010030:	75 07                	jne    140010039 <__tlregdtor+0x16>
   140010032:	b8 00 00 00 00       	mov    $0x0,%eax
   140010037:	eb 05                	jmp    14001003e <__tlregdtor+0x1b>
   140010039:	b8 00 00 00 00       	mov    $0x0,%eax
   14001003e:	5d                   	pop    %rbp
   14001003f:	c3                   	ret

0000000140010040 <__dyn_tls_dtor>:
   140010040:	55                   	push   %rbp
   140010041:	48 89 e5             	mov    %rsp,%rbp
   140010044:	48 83 ec 20          	sub    $0x20,%rsp
   140010048:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14001004c:	89 55 18             	mov    %edx,0x18(%rbp)
   14001004f:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140010053:	83 7d 18 03          	cmpl   $0x3,0x18(%rbp)
   140010057:	74 0d                	je     140010066 <__dyn_tls_dtor+0x26>
   140010059:	83 7d 18 00          	cmpl   $0x0,0x18(%rbp)
   14001005d:	74 07                	je     140010066 <__dyn_tls_dtor+0x26>
   14001005f:	b8 01 00 00 00       	mov    $0x1,%eax
   140010064:	eb 1b                	jmp    140010081 <__dyn_tls_dtor+0x41>
   140010066:	48 8b 4d 20          	mov    0x20(%rbp),%rcx
   14001006a:	8b 55 18             	mov    0x18(%rbp),%edx
   14001006d:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140010071:	49 89 c8             	mov    %rcx,%r8
   140010074:	48 89 c1             	mov    %rax,%rcx
   140010077:	e8 b5 0e 00 00       	call   140010f31 <__mingw_TLScallback>
   14001007c:	b8 01 00 00 00       	mov    $0x1,%eax
   140010081:	48 83 c4 20          	add    $0x20,%rsp
   140010085:	5d                   	pop    %rbp
   140010086:	c3                   	ret
   140010087:	90                   	nop
   140010088:	90                   	nop
   140010089:	90                   	nop
   14001008a:	90                   	nop
   14001008b:	90                   	nop
   14001008c:	90                   	nop
   14001008d:	90                   	nop
   14001008e:	90                   	nop
   14001008f:	90                   	nop

0000000140010090 <_matherr>:
   140010090:	55                   	push   %rbp
   140010091:	53                   	push   %rbx
   140010092:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
   140010099:	48 8d 6c 24 50       	lea    0x50(%rsp),%rbp
   14001009e:	0f 29 75 00          	movaps %xmm6,0x0(%rbp)
   1400100a2:	0f 29 7d 10          	movaps %xmm7,0x10(%rbp)
   1400100a6:	44 0f 29 45 20       	movaps %xmm8,0x20(%rbp)
   1400100ab:	48 89 4d 50          	mov    %rcx,0x50(%rbp)
   1400100af:	48 8b 45 50          	mov    0x50(%rbp),%rax
   1400100b3:	8b 00                	mov    (%rax),%eax
   1400100b5:	83 f8 06             	cmp    $0x6,%eax
   1400100b8:	77 70                	ja     14001012a <_matherr+0x9a>
   1400100ba:	89 c0                	mov    %eax,%eax
   1400100bc:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   1400100c3:	00 
   1400100c4:	48 8d 05 b9 5b 00 00 	lea    0x5bb9(%rip),%rax        # 140015c84 <.rdata+0x124>
   1400100cb:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   1400100ce:	48 98                	cltq
   1400100d0:	48 8d 15 ad 5b 00 00 	lea    0x5bad(%rip),%rdx        # 140015c84 <.rdata+0x124>
   1400100d7:	48 01 d0             	add    %rdx,%rax
   1400100da:	ff e0                	jmp    *%rax
   1400100dc:	48 8d 05 7d 5a 00 00 	lea    0x5a7d(%rip),%rax        # 140015b60 <.rdata>
   1400100e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   1400100e7:	eb 4d                	jmp    140010136 <_matherr+0xa6>
   1400100e9:	48 8d 05 8f 5a 00 00 	lea    0x5a8f(%rip),%rax        # 140015b7f <.rdata+0x1f>
   1400100f0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   1400100f4:	eb 40                	jmp    140010136 <_matherr+0xa6>
   1400100f6:	48 8d 05 a3 5a 00 00 	lea    0x5aa3(%rip),%rax        # 140015ba0 <.rdata+0x40>
   1400100fd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140010101:	eb 33                	jmp    140010136 <_matherr+0xa6>
   140010103:	48 8d 05 b6 5a 00 00 	lea    0x5ab6(%rip),%rax        # 140015bc0 <.rdata+0x60>
   14001010a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14001010e:	eb 26                	jmp    140010136 <_matherr+0xa6>
   140010110:	48 8d 05 d1 5a 00 00 	lea    0x5ad1(%rip),%rax        # 140015be8 <.rdata+0x88>
   140010117:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14001011b:	eb 19                	jmp    140010136 <_matherr+0xa6>
   14001011d:	48 8d 05 ec 5a 00 00 	lea    0x5aec(%rip),%rax        # 140015c10 <.rdata+0xb0>
   140010124:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140010128:	eb 0c                	jmp    140010136 <_matherr+0xa6>
   14001012a:	48 8d 05 15 5b 00 00 	lea    0x5b15(%rip),%rax        # 140015c46 <.rdata+0xe6>
   140010131:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140010135:	90                   	nop
   140010136:	48 8b 45 50          	mov    0x50(%rbp),%rax
   14001013a:	f2 44 0f 10 40 20    	movsd  0x20(%rax),%xmm8
   140010140:	48 8b 45 50          	mov    0x50(%rbp),%rax
   140010144:	f2 0f 10 78 18       	movsd  0x18(%rax),%xmm7
   140010149:	48 8b 45 50          	mov    0x50(%rbp),%rax
   14001014d:	f2 0f 10 70 10       	movsd  0x10(%rax),%xmm6
   140010152:	48 8b 45 50          	mov    0x50(%rbp),%rax
   140010156:	48 8b 58 08          	mov    0x8(%rax),%rbx
   14001015a:	b9 02 00 00 00       	mov    $0x2,%ecx
   14001015f:	e8 e4 17 00 00       	call   140011948 <__acrt_iob_func>
   140010164:	48 89 c1             	mov    %rax,%rcx
   140010167:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14001016b:	f2 44 0f 11 44 24 30 	movsd  %xmm8,0x30(%rsp)
   140010172:	f2 0f 11 7c 24 28    	movsd  %xmm7,0x28(%rsp)
   140010178:	f2 0f 11 74 24 20    	movsd  %xmm6,0x20(%rsp)
   14001017e:	49 89 d9             	mov    %rbx,%r9
   140010181:	49 89 c0             	mov    %rax,%r8
   140010184:	48 8d 05 cd 5a 00 00 	lea    0x5acd(%rip),%rax        # 140015c58 <.rdata+0xf8>
   14001018b:	48 89 c2             	mov    %rax,%rdx
   14001018e:	e8 fd 14 00 00       	call   140011690 <fprintf>
   140010193:	b8 00 00 00 00       	mov    $0x0,%eax
   140010198:	0f 28 75 00          	movaps 0x0(%rbp),%xmm6
   14001019c:	0f 28 7d 10          	movaps 0x10(%rbp),%xmm7
   1400101a0:	44 0f 28 45 20       	movaps 0x20(%rbp),%xmm8
   1400101a5:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
   1400101ac:	5b                   	pop    %rbx
   1400101ad:	5d                   	pop    %rbp
   1400101ae:	c3                   	ret
   1400101af:	90                   	nop

00000001400101b0 <_fpreset>:
   1400101b0:	55                   	push   %rbp
   1400101b1:	48 89 e5             	mov    %rsp,%rbp
   1400101b4:	db e3                	fninit
   1400101b6:	90                   	nop
   1400101b7:	5d                   	pop    %rbp
   1400101b8:	c3                   	ret
   1400101b9:	90                   	nop
   1400101ba:	90                   	nop
   1400101bb:	90                   	nop
   1400101bc:	90                   	nop
   1400101bd:	90                   	nop
   1400101be:	90                   	nop
   1400101bf:	90                   	nop

00000001400101c0 <__report_error>:
   1400101c0:	55                   	push   %rbp
   1400101c1:	53                   	push   %rbx
   1400101c2:	48 83 ec 38          	sub    $0x38,%rsp
   1400101c6:	48 8d 6c 24 30       	lea    0x30(%rsp),%rbp
   1400101cb:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   1400101cf:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   1400101d3:	4c 89 45 30          	mov    %r8,0x30(%rbp)
   1400101d7:	4c 89 4d 38          	mov    %r9,0x38(%rbp)
   1400101db:	48 8d 45 28          	lea    0x28(%rbp),%rax
   1400101df:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   1400101e3:	b9 02 00 00 00       	mov    $0x2,%ecx
   1400101e8:	e8 5b 17 00 00       	call   140011948 <__acrt_iob_func>
   1400101ed:	49 89 c1             	mov    %rax,%r9
   1400101f0:	41 b8 1b 00 00 00    	mov    $0x1b,%r8d
   1400101f6:	ba 01 00 00 00       	mov    $0x1,%edx
   1400101fb:	48 8d 05 9e 5a 00 00 	lea    0x5a9e(%rip),%rax        # 140015ca0 <.rdata>
   140010202:	48 89 c1             	mov    %rax,%rcx
   140010205:	e8 5e 18 00 00       	call   140011a68 <fwrite>
   14001020a:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   14001020e:	b9 02 00 00 00       	mov    $0x2,%ecx
   140010213:	e8 30 17 00 00       	call   140011948 <__acrt_iob_func>
   140010218:	48 89 c1             	mov    %rax,%rcx
   14001021b:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14001021f:	49 89 d8             	mov    %rbx,%r8
   140010222:	48 89 c2             	mov    %rax,%rdx
   140010225:	e8 56 13 00 00       	call   140011580 <vfprintf>
   14001022a:	e8 f9 17 00 00       	call   140011a28 <abort>
   14001022f:	90                   	nop

0000000140010230 <mark_section_writable>:
   140010230:	55                   	push   %rbp
   140010231:	48 89 e5             	mov    %rsp,%rbp
   140010234:	48 83 ec 60          	sub    $0x60,%rsp
   140010238:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14001023c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   140010243:	e9 82 00 00 00       	jmp    1400102ca <mark_section_writable+0x9a>
   140010248:	48 8b 0d a1 9e 00 00 	mov    0x9ea1(%rip),%rcx        # 14001a0f0 <the_secs>
   14001024f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140010252:	48 63 d0             	movslq %eax,%rdx
   140010255:	48 89 d0             	mov    %rdx,%rax
   140010258:	48 c1 e0 02          	shl    $0x2,%rax
   14001025c:	48 01 d0             	add    %rdx,%rax
   14001025f:	48 c1 e0 03          	shl    $0x3,%rax
   140010263:	48 01 c8             	add    %rcx,%rax
   140010266:	48 8b 40 18          	mov    0x18(%rax),%rax
   14001026a:	48 39 45 10          	cmp    %rax,0x10(%rbp)
   14001026e:	72 56                	jb     1400102c6 <mark_section_writable+0x96>
   140010270:	48 8b 0d 79 9e 00 00 	mov    0x9e79(%rip),%rcx        # 14001a0f0 <the_secs>
   140010277:	8b 45 fc             	mov    -0x4(%rbp),%eax
   14001027a:	48 63 d0             	movslq %eax,%rdx
   14001027d:	48 89 d0             	mov    %rdx,%rax
   140010280:	48 c1 e0 02          	shl    $0x2,%rax
   140010284:	48 01 d0             	add    %rdx,%rax
   140010287:	48 c1 e0 03          	shl    $0x3,%rax
   14001028b:	48 01 c8             	add    %rcx,%rax
   14001028e:	48 8b 48 18          	mov    0x18(%rax),%rcx
   140010292:	4c 8b 05 57 9e 00 00 	mov    0x9e57(%rip),%r8        # 14001a0f0 <the_secs>
   140010299:	8b 45 fc             	mov    -0x4(%rbp),%eax
   14001029c:	48 63 d0             	movslq %eax,%rdx
   14001029f:	48 89 d0             	mov    %rdx,%rax
   1400102a2:	48 c1 e0 02          	shl    $0x2,%rax
   1400102a6:	48 01 d0             	add    %rdx,%rax
   1400102a9:	48 c1 e0 03          	shl    $0x3,%rax
   1400102ad:	4c 01 c0             	add    %r8,%rax
   1400102b0:	48 8b 40 20          	mov    0x20(%rax),%rax
   1400102b4:	8b 40 08             	mov    0x8(%rax),%eax
   1400102b7:	89 c0                	mov    %eax,%eax
   1400102b9:	48 01 c8             	add    %rcx,%rax
   1400102bc:	48 39 45 10          	cmp    %rax,0x10(%rbp)
   1400102c0:	0f 82 42 02 00 00    	jb     140010508 <mark_section_writable+0x2d8>
   1400102c6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   1400102ca:	8b 05 28 9e 00 00    	mov    0x9e28(%rip),%eax        # 14001a0f8 <maxSections>
   1400102d0:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   1400102d3:	0f 8c 6f ff ff ff    	jl     140010248 <mark_section_writable+0x18>
   1400102d9:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400102dd:	48 89 c1             	mov    %rax,%rcx
   1400102e0:	e8 26 0f 00 00       	call   14001120b <__mingw_GetSectionForAddress>
   1400102e5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   1400102e9:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   1400102ee:	75 16                	jne    140010306 <mark_section_writable+0xd6>
   1400102f0:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400102f4:	48 89 c2             	mov    %rax,%rdx
   1400102f7:	48 8d 05 c2 59 00 00 	lea    0x59c2(%rip),%rax        # 140015cc0 <.rdata+0x20>
   1400102fe:	48 89 c1             	mov    %rax,%rcx
   140010301:	e8 ba fe ff ff       	call   1400101c0 <__report_error>
   140010306:	48 8b 0d e3 9d 00 00 	mov    0x9de3(%rip),%rcx        # 14001a0f0 <the_secs>
   14001030d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140010310:	48 63 d0             	movslq %eax,%rdx
   140010313:	48 89 d0             	mov    %rdx,%rax
   140010316:	48 c1 e0 02          	shl    $0x2,%rax
   14001031a:	48 01 d0             	add    %rdx,%rax
   14001031d:	48 c1 e0 03          	shl    $0x3,%rax
   140010321:	48 8d 14 01          	lea    (%rcx,%rax,1),%rdx
   140010325:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140010329:	48 89 42 20          	mov    %rax,0x20(%rdx)
   14001032d:	48 8b 0d bc 9d 00 00 	mov    0x9dbc(%rip),%rcx        # 14001a0f0 <the_secs>
   140010334:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140010337:	48 63 d0             	movslq %eax,%rdx
   14001033a:	48 89 d0             	mov    %rdx,%rax
   14001033d:	48 c1 e0 02          	shl    $0x2,%rax
   140010341:	48 01 d0             	add    %rdx,%rax
   140010344:	48 c1 e0 03          	shl    $0x3,%rax
   140010348:	48 01 c8             	add    %rcx,%rax
   14001034b:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   140010351:	e8 01 10 00 00       	call   140011357 <_GetPEImageBase>
   140010356:	48 89 c1             	mov    %rax,%rcx
   140010359:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14001035d:	8b 40 0c             	mov    0xc(%rax),%eax
   140010360:	41 89 c1             	mov    %eax,%r9d
   140010363:	4c 8b 05 86 9d 00 00 	mov    0x9d86(%rip),%r8        # 14001a0f0 <the_secs>
   14001036a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   14001036d:	48 63 d0             	movslq %eax,%rdx
   140010370:	48 89 d0             	mov    %rdx,%rax
   140010373:	48 c1 e0 02          	shl    $0x2,%rax
   140010377:	48 01 d0             	add    %rdx,%rax
   14001037a:	48 c1 e0 03          	shl    $0x3,%rax
   14001037e:	4c 01 c0             	add    %r8,%rax
   140010381:	4a 8d 14 09          	lea    (%rcx,%r9,1),%rdx
   140010385:	48 89 50 18          	mov    %rdx,0x18(%rax)
   140010389:	48 8b 0d 60 9d 00 00 	mov    0x9d60(%rip),%rcx        # 14001a0f0 <the_secs>
   140010390:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140010393:	48 63 d0             	movslq %eax,%rdx
   140010396:	48 89 d0             	mov    %rdx,%rax
   140010399:	48 c1 e0 02          	shl    $0x2,%rax
   14001039d:	48 01 d0             	add    %rdx,%rax
   1400103a0:	48 c1 e0 03          	shl    $0x3,%rax
   1400103a4:	48 01 c8             	add    %rcx,%rax
   1400103a7:	48 8b 40 18          	mov    0x18(%rax),%rax
   1400103ab:	48 8d 55 c0          	lea    -0x40(%rbp),%rdx
   1400103af:	41 b8 30 00 00 00    	mov    $0x30,%r8d
   1400103b5:	48 89 c1             	mov    %rax,%rcx
   1400103b8:	48 8b 05 f1 ae 00 00 	mov    0xaef1(%rip),%rax        # 14001b2b0 <__imp_VirtualQuery>
   1400103bf:	ff d0                	call   *%rax
   1400103c1:	48 85 c0             	test   %rax,%rax
   1400103c4:	75 3d                	jne    140010403 <mark_section_writable+0x1d3>
   1400103c6:	48 8b 0d 23 9d 00 00 	mov    0x9d23(%rip),%rcx        # 14001a0f0 <the_secs>
   1400103cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   1400103d0:	48 63 d0             	movslq %eax,%rdx
   1400103d3:	48 89 d0             	mov    %rdx,%rax
   1400103d6:	48 c1 e0 02          	shl    $0x2,%rax
   1400103da:	48 01 d0             	add    %rdx,%rax
   1400103dd:	48 c1 e0 03          	shl    $0x3,%rax
   1400103e1:	48 01 c8             	add    %rcx,%rax
   1400103e4:	48 8b 50 18          	mov    0x18(%rax),%rdx
   1400103e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   1400103ec:	8b 40 08             	mov    0x8(%rax),%eax
   1400103ef:	49 89 d0             	mov    %rdx,%r8
   1400103f2:	89 c2                	mov    %eax,%edx
   1400103f4:	48 8d 05 e5 58 00 00 	lea    0x58e5(%rip),%rax        # 140015ce0 <.rdata+0x40>
   1400103fb:	48 89 c1             	mov    %rax,%rcx
   1400103fe:	e8 bd fd ff ff       	call   1400101c0 <__report_error>
   140010403:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   140010406:	83 f8 40             	cmp    $0x40,%eax
   140010409:	0f 84 e8 00 00 00    	je     1400104f7 <mark_section_writable+0x2c7>
   14001040f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   140010412:	83 f8 04             	cmp    $0x4,%eax
   140010415:	0f 84 dc 00 00 00    	je     1400104f7 <mark_section_writable+0x2c7>
   14001041b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   14001041e:	3d 80 00 00 00       	cmp    $0x80,%eax
   140010423:	0f 84 ce 00 00 00    	je     1400104f7 <mark_section_writable+0x2c7>
   140010429:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   14001042c:	83 f8 08             	cmp    $0x8,%eax
   14001042f:	0f 84 c2 00 00 00    	je     1400104f7 <mark_section_writable+0x2c7>
   140010435:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   140010438:	83 f8 02             	cmp    $0x2,%eax
   14001043b:	75 09                	jne    140010446 <mark_section_writable+0x216>
   14001043d:	c7 45 f8 04 00 00 00 	movl   $0x4,-0x8(%rbp)
   140010444:	eb 07                	jmp    14001044d <mark_section_writable+0x21d>
   140010446:	c7 45 f8 40 00 00 00 	movl   $0x40,-0x8(%rbp)
   14001044d:	48 8b 0d 9c 9c 00 00 	mov    0x9c9c(%rip),%rcx        # 14001a0f0 <the_secs>
   140010454:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140010457:	48 63 d0             	movslq %eax,%rdx
   14001045a:	48 89 d0             	mov    %rdx,%rax
   14001045d:	48 c1 e0 02          	shl    $0x2,%rax
   140010461:	48 01 d0             	add    %rdx,%rax
   140010464:	48 c1 e0 03          	shl    $0x3,%rax
   140010468:	48 8d 14 01          	lea    (%rcx,%rax,1),%rdx
   14001046c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   140010470:	48 89 42 08          	mov    %rax,0x8(%rdx)
   140010474:	48 8b 0d 75 9c 00 00 	mov    0x9c75(%rip),%rcx        # 14001a0f0 <the_secs>
   14001047b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   14001047e:	48 63 d0             	movslq %eax,%rdx
   140010481:	48 89 d0             	mov    %rdx,%rax
   140010484:	48 c1 e0 02          	shl    $0x2,%rax
   140010488:	48 01 d0             	add    %rdx,%rax
   14001048b:	48 c1 e0 03          	shl    $0x3,%rax
   14001048f:	48 8d 14 01          	lea    (%rcx,%rax,1),%rdx
   140010493:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   140010497:	48 89 42 10          	mov    %rax,0x10(%rdx)
   14001049b:	48 8b 0d 4e 9c 00 00 	mov    0x9c4e(%rip),%rcx        # 14001a0f0 <the_secs>
   1400104a2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   1400104a5:	48 63 d0             	movslq %eax,%rdx
   1400104a8:	48 89 d0             	mov    %rdx,%rax
   1400104ab:	48 c1 e0 02          	shl    $0x2,%rax
   1400104af:	48 01 d0             	add    %rdx,%rax
   1400104b2:	48 c1 e0 03          	shl    $0x3,%rax
   1400104b6:	48 01 c8             	add    %rcx,%rax
   1400104b9:	49 89 c0             	mov    %rax,%r8
   1400104bc:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   1400104c0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   1400104c4:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   1400104c7:	4d 89 c1             	mov    %r8,%r9
   1400104ca:	41 89 c8             	mov    %ecx,%r8d
   1400104cd:	48 89 c1             	mov    %rax,%rcx
   1400104d0:	48 8b 05 d1 ad 00 00 	mov    0xadd1(%rip),%rax        # 14001b2a8 <__imp_VirtualProtect>
   1400104d7:	ff d0                	call   *%rax
   1400104d9:	85 c0                	test   %eax,%eax
   1400104db:	75 1a                	jne    1400104f7 <mark_section_writable+0x2c7>
   1400104dd:	48 8b 05 7c ad 00 00 	mov    0xad7c(%rip),%rax        # 14001b260 <__imp_GetLastError>
   1400104e4:	ff d0                	call   *%rax
   1400104e6:	89 c2                	mov    %eax,%edx
   1400104e8:	48 8d 05 29 58 00 00 	lea    0x5829(%rip),%rax        # 140015d18 <.rdata+0x78>
   1400104ef:	48 89 c1             	mov    %rax,%rcx
   1400104f2:	e8 c9 fc ff ff       	call   1400101c0 <__report_error>
   1400104f7:	8b 05 fb 9b 00 00    	mov    0x9bfb(%rip),%eax        # 14001a0f8 <maxSections>
   1400104fd:	83 c0 01             	add    $0x1,%eax
   140010500:	89 05 f2 9b 00 00    	mov    %eax,0x9bf2(%rip)        # 14001a0f8 <maxSections>
   140010506:	eb 01                	jmp    140010509 <mark_section_writable+0x2d9>
   140010508:	90                   	nop
   140010509:	48 83 c4 60          	add    $0x60,%rsp
   14001050d:	5d                   	pop    %rbp
   14001050e:	c3                   	ret

000000014001050f <restore_modified_sections>:
   14001050f:	55                   	push   %rbp
   140010510:	48 89 e5             	mov    %rsp,%rbp
   140010513:	48 83 ec 30          	sub    $0x30,%rsp
   140010517:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   14001051e:	e9 ad 00 00 00       	jmp    1400105d0 <restore_modified_sections+0xc1>
   140010523:	48 8b 0d c6 9b 00 00 	mov    0x9bc6(%rip),%rcx        # 14001a0f0 <the_secs>
   14001052a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   14001052d:	48 63 d0             	movslq %eax,%rdx
   140010530:	48 89 d0             	mov    %rdx,%rax
   140010533:	48 c1 e0 02          	shl    $0x2,%rax
   140010537:	48 01 d0             	add    %rdx,%rax
   14001053a:	48 c1 e0 03          	shl    $0x3,%rax
   14001053e:	48 01 c8             	add    %rcx,%rax
   140010541:	8b 00                	mov    (%rax),%eax
   140010543:	85 c0                	test   %eax,%eax
   140010545:	0f 84 80 00 00 00    	je     1400105cb <restore_modified_sections+0xbc>
   14001054b:	48 8b 0d 9e 9b 00 00 	mov    0x9b9e(%rip),%rcx        # 14001a0f0 <the_secs>
   140010552:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140010555:	48 63 d0             	movslq %eax,%rdx
   140010558:	48 89 d0             	mov    %rdx,%rax
   14001055b:	48 c1 e0 02          	shl    $0x2,%rax
   14001055f:	48 01 d0             	add    %rdx,%rax
   140010562:	48 c1 e0 03          	shl    $0x3,%rax
   140010566:	48 01 c8             	add    %rcx,%rax
   140010569:	44 8b 10             	mov    (%rax),%r10d
   14001056c:	48 8b 0d 7d 9b 00 00 	mov    0x9b7d(%rip),%rcx        # 14001a0f0 <the_secs>
   140010573:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140010576:	48 63 d0             	movslq %eax,%rdx
   140010579:	48 89 d0             	mov    %rdx,%rax
   14001057c:	48 c1 e0 02          	shl    $0x2,%rax
   140010580:	48 01 d0             	add    %rdx,%rax
   140010583:	48 c1 e0 03          	shl    $0x3,%rax
   140010587:	48 01 c8             	add    %rcx,%rax
   14001058a:	48 8b 48 10          	mov    0x10(%rax),%rcx
   14001058e:	4c 8b 05 5b 9b 00 00 	mov    0x9b5b(%rip),%r8        # 14001a0f0 <the_secs>
   140010595:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140010598:	48 63 d0             	movslq %eax,%rdx
   14001059b:	48 89 d0             	mov    %rdx,%rax
   14001059e:	48 c1 e0 02          	shl    $0x2,%rax
   1400105a2:	48 01 d0             	add    %rdx,%rax
   1400105a5:	48 c1 e0 03          	shl    $0x3,%rax
   1400105a9:	4c 01 c0             	add    %r8,%rax
   1400105ac:	48 8b 40 08          	mov    0x8(%rax),%rax
   1400105b0:	48 8d 55 f8          	lea    -0x8(%rbp),%rdx
   1400105b4:	49 89 d1             	mov    %rdx,%r9
   1400105b7:	45 89 d0             	mov    %r10d,%r8d
   1400105ba:	48 89 ca             	mov    %rcx,%rdx
   1400105bd:	48 89 c1             	mov    %rax,%rcx
   1400105c0:	48 8b 05 e1 ac 00 00 	mov    0xace1(%rip),%rax        # 14001b2a8 <__imp_VirtualProtect>
   1400105c7:	ff d0                	call   *%rax
   1400105c9:	eb 01                	jmp    1400105cc <restore_modified_sections+0xbd>
   1400105cb:	90                   	nop
   1400105cc:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   1400105d0:	8b 05 22 9b 00 00    	mov    0x9b22(%rip),%eax        # 14001a0f8 <maxSections>
   1400105d6:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   1400105d9:	0f 8c 44 ff ff ff    	jl     140010523 <restore_modified_sections+0x14>
   1400105df:	90                   	nop
   1400105e0:	90                   	nop
   1400105e1:	48 83 c4 30          	add    $0x30,%rsp
   1400105e5:	5d                   	pop    %rbp
   1400105e6:	c3                   	ret

00000001400105e7 <__write_memory>:
   1400105e7:	55                   	push   %rbp
   1400105e8:	48 89 e5             	mov    %rsp,%rbp
   1400105eb:	48 83 ec 20          	sub    $0x20,%rsp
   1400105ef:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400105f3:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400105f7:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   1400105fb:	48 83 7d 20 00       	cmpq   $0x0,0x20(%rbp)
   140010600:	74 25                	je     140010627 <__write_memory+0x40>
   140010602:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140010606:	48 89 c1             	mov    %rax,%rcx
   140010609:	e8 22 fc ff ff       	call   140010230 <mark_section_writable>
   14001060e:	48 8b 4d 20          	mov    0x20(%rbp),%rcx
   140010612:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140010616:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14001061a:	49 89 c8             	mov    %rcx,%r8
   14001061d:	48 89 c1             	mov    %rax,%rcx
   140010620:	e8 53 14 00 00       	call   140011a78 <memcpy>
   140010625:	eb 01                	jmp    140010628 <__write_memory+0x41>
   140010627:	90                   	nop
   140010628:	48 83 c4 20          	add    $0x20,%rsp
   14001062c:	5d                   	pop    %rbp
   14001062d:	c3                   	ret

000000014001062e <do_pseudo_reloc>:
   14001062e:	55                   	push   %rbp
   14001062f:	48 89 e5             	mov    %rsp,%rbp
   140010632:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   140010636:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14001063a:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   14001063e:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140010642:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140010646:	48 2b 45 10          	sub    0x10(%rbp),%rax
   14001064a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   14001064e:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140010652:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140010656:	48 83 7d e0 07       	cmpq   $0x7,-0x20(%rbp)
   14001065b:	0f 8e 50 03 00 00    	jle    1400109b1 <do_pseudo_reloc+0x383>
   140010661:	48 83 7d e0 0b       	cmpq   $0xb,-0x20(%rbp)
   140010666:	7e 25                	jle    14001068d <do_pseudo_reloc+0x5f>
   140010668:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14001066c:	8b 00                	mov    (%rax),%eax
   14001066e:	85 c0                	test   %eax,%eax
   140010670:	75 1b                	jne    14001068d <do_pseudo_reloc+0x5f>
   140010672:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140010676:	8b 40 04             	mov    0x4(%rax),%eax
   140010679:	85 c0                	test   %eax,%eax
   14001067b:	75 10                	jne    14001068d <do_pseudo_reloc+0x5f>
   14001067d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140010681:	8b 40 08             	mov    0x8(%rax),%eax
   140010684:	85 c0                	test   %eax,%eax
   140010686:	75 05                	jne    14001068d <do_pseudo_reloc+0x5f>
   140010688:	48 83 45 f8 0c       	addq   $0xc,-0x8(%rbp)
   14001068d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140010691:	8b 00                	mov    (%rax),%eax
   140010693:	85 c0                	test   %eax,%eax
   140010695:	75 0b                	jne    1400106a2 <do_pseudo_reloc+0x74>
   140010697:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14001069b:	8b 40 04             	mov    0x4(%rax),%eax
   14001069e:	85 c0                	test   %eax,%eax
   1400106a0:	74 59                	je     1400106fb <do_pseudo_reloc+0xcd>
   1400106a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400106a6:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   1400106aa:	eb 40                	jmp    1400106ec <do_pseudo_reloc+0xbe>
   1400106ac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   1400106b0:	8b 40 04             	mov    0x4(%rax),%eax
   1400106b3:	89 c2                	mov    %eax,%edx
   1400106b5:	48 8b 45 20          	mov    0x20(%rbp),%rax
   1400106b9:	48 01 d0             	add    %rdx,%rax
   1400106bc:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   1400106c0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   1400106c4:	8b 10                	mov    (%rax),%edx
   1400106c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   1400106ca:	8b 00                	mov    (%rax),%eax
   1400106cc:	01 d0                	add    %edx,%eax
   1400106ce:	89 45 b4             	mov    %eax,-0x4c(%rbp)
   1400106d1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   1400106d5:	48 8d 55 b4          	lea    -0x4c(%rbp),%rdx
   1400106d9:	41 b8 04 00 00 00    	mov    $0x4,%r8d
   1400106df:	48 89 c1             	mov    %rax,%rcx
   1400106e2:	e8 00 ff ff ff       	call   1400105e7 <__write_memory>
   1400106e7:	48 83 45 e8 08       	addq   $0x8,-0x18(%rbp)
   1400106ec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   1400106f0:	48 3b 45 18          	cmp    0x18(%rbp),%rax
   1400106f4:	72 b6                	jb     1400106ac <do_pseudo_reloc+0x7e>
   1400106f6:	e9 b7 02 00 00       	jmp    1400109b2 <do_pseudo_reloc+0x384>
   1400106fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400106ff:	8b 40 08             	mov    0x8(%rax),%eax
   140010702:	83 f8 01             	cmp    $0x1,%eax
   140010705:	74 18                	je     14001071f <do_pseudo_reloc+0xf1>
   140010707:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14001070b:	8b 40 08             	mov    0x8(%rax),%eax
   14001070e:	89 c2                	mov    %eax,%edx
   140010710:	48 8d 05 29 56 00 00 	lea    0x5629(%rip),%rax        # 140015d40 <.rdata+0xa0>
   140010717:	48 89 c1             	mov    %rax,%rcx
   14001071a:	e8 a1 fa ff ff       	call   1400101c0 <__report_error>
   14001071f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140010723:	48 83 c0 0c          	add    $0xc,%rax
   140010727:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14001072b:	e9 71 02 00 00       	jmp    1400109a1 <do_pseudo_reloc+0x373>
   140010730:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140010734:	8b 40 04             	mov    0x4(%rax),%eax
   140010737:	89 c2                	mov    %eax,%edx
   140010739:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14001073d:	48 01 d0             	add    %rdx,%rax
   140010740:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   140010744:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140010748:	8b 00                	mov    (%rax),%eax
   14001074a:	89 c2                	mov    %eax,%edx
   14001074c:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140010750:	48 01 d0             	add    %rdx,%rax
   140010753:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   140010757:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   14001075b:	48 8b 00             	mov    (%rax),%rax
   14001075e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   140010762:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140010766:	8b 40 08             	mov    0x8(%rax),%eax
   140010769:	0f b6 c0             	movzbl %al,%eax
   14001076c:	83 f8 40             	cmp    $0x40,%eax
   14001076f:	0f 84 b6 00 00 00    	je     14001082b <do_pseudo_reloc+0x1fd>
   140010775:	83 f8 40             	cmp    $0x40,%eax
   140010778:	0f 87 ba 00 00 00    	ja     140010838 <do_pseudo_reloc+0x20a>
   14001077e:	83 f8 20             	cmp    $0x20,%eax
   140010781:	74 77                	je     1400107fa <do_pseudo_reloc+0x1cc>
   140010783:	83 f8 20             	cmp    $0x20,%eax
   140010786:	0f 87 ac 00 00 00    	ja     140010838 <do_pseudo_reloc+0x20a>
   14001078c:	83 f8 08             	cmp    $0x8,%eax
   14001078f:	74 0a                	je     14001079b <do_pseudo_reloc+0x16d>
   140010791:	83 f8 10             	cmp    $0x10,%eax
   140010794:	74 38                	je     1400107ce <do_pseudo_reloc+0x1a0>
   140010796:	e9 9d 00 00 00       	jmp    140010838 <do_pseudo_reloc+0x20a>
   14001079b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   14001079f:	0f b6 00             	movzbl (%rax),%eax
   1400107a2:	0f b6 c0             	movzbl %al,%eax
   1400107a5:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   1400107a9:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   1400107ad:	25 80 00 00 00       	and    $0x80,%eax
   1400107b2:	48 85 c0             	test   %rax,%rax
   1400107b5:	0f 84 a0 00 00 00    	je     14001085b <do_pseudo_reloc+0x22d>
   1400107bb:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   1400107bf:	48 0d 00 ff ff ff    	or     $0xffffffffffffff00,%rax
   1400107c5:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   1400107c9:	e9 8d 00 00 00       	jmp    14001085b <do_pseudo_reloc+0x22d>
   1400107ce:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   1400107d2:	0f b7 00             	movzwl (%rax),%eax
   1400107d5:	0f b7 c0             	movzwl %ax,%eax
   1400107d8:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   1400107dc:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   1400107e0:	25 00 80 00 00       	and    $0x8000,%eax
   1400107e5:	48 85 c0             	test   %rax,%rax
   1400107e8:	74 74                	je     14001085e <do_pseudo_reloc+0x230>
   1400107ea:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   1400107ee:	48 0d 00 00 ff ff    	or     $0xffffffffffff0000,%rax
   1400107f4:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   1400107f8:	eb 64                	jmp    14001085e <do_pseudo_reloc+0x230>
   1400107fa:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   1400107fe:	8b 00                	mov    (%rax),%eax
   140010800:	89 c0                	mov    %eax,%eax
   140010802:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   140010806:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   14001080a:	25 00 00 00 80       	and    $0x80000000,%eax
   14001080f:	48 85 c0             	test   %rax,%rax
   140010812:	74 4d                	je     140010861 <do_pseudo_reloc+0x233>
   140010814:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   140010818:	48 ba 00 00 00 00 ff 	movabs $0xffffffff00000000,%rdx
   14001081f:	ff ff ff 
   140010822:	48 09 d0             	or     %rdx,%rax
   140010825:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   140010829:	eb 36                	jmp    140010861 <do_pseudo_reloc+0x233>
   14001082b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   14001082f:	48 8b 00             	mov    (%rax),%rax
   140010832:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   140010836:	eb 2a                	jmp    140010862 <do_pseudo_reloc+0x234>
   140010838:	48 c7 45 b8 00 00 00 	movq   $0x0,-0x48(%rbp)
   14001083f:	00 
   140010840:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140010844:	8b 40 08             	mov    0x8(%rax),%eax
   140010847:	0f b6 c0             	movzbl %al,%eax
   14001084a:	89 c2                	mov    %eax,%edx
   14001084c:	48 8d 05 25 55 00 00 	lea    0x5525(%rip),%rax        # 140015d78 <.rdata+0xd8>
   140010853:	48 89 c1             	mov    %rax,%rcx
   140010856:	e8 65 f9 ff ff       	call   1400101c0 <__report_error>
   14001085b:	90                   	nop
   14001085c:	eb 04                	jmp    140010862 <do_pseudo_reloc+0x234>
   14001085e:	90                   	nop
   14001085f:	eb 01                	jmp    140010862 <do_pseudo_reloc+0x234>
   140010861:	90                   	nop
   140010862:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   140010866:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14001086a:	8b 00                	mov    (%rax),%eax
   14001086c:	89 c2                	mov    %eax,%edx
   14001086e:	48 8b 45 20          	mov    0x20(%rbp),%rax
   140010872:	48 01 c2             	add    %rax,%rdx
   140010875:	48 89 c8             	mov    %rcx,%rax
   140010878:	48 29 d0             	sub    %rdx,%rax
   14001087b:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   14001087f:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   140010883:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   140010887:	48 01 d0             	add    %rdx,%rax
   14001088a:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   14001088e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140010892:	8b 40 08             	mov    0x8(%rax),%eax
   140010895:	25 ff 00 00 00       	and    $0xff,%eax
   14001089a:	89 45 d4             	mov    %eax,-0x2c(%rbp)
   14001089d:	83 7d d4 3f          	cmpl   $0x3f,-0x2c(%rbp)
   1400108a1:	77 70                	ja     140010913 <do_pseudo_reloc+0x2e5>
   1400108a3:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   1400108a6:	ba 01 00 00 00       	mov    $0x1,%edx
   1400108ab:	89 c1                	mov    %eax,%ecx
   1400108ad:	48 d3 e2             	shl    %cl,%rdx
   1400108b0:	48 89 d0             	mov    %rdx,%rax
   1400108b3:	48 83 e8 01          	sub    $0x1,%rax
   1400108b7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   1400108bb:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   1400108be:	83 e8 01             	sub    $0x1,%eax
   1400108c1:	48 c7 c2 ff ff ff ff 	mov    $0xffffffffffffffff,%rdx
   1400108c8:	89 c1                	mov    %eax,%ecx
   1400108ca:	48 d3 e2             	shl    %cl,%rdx
   1400108cd:	48 89 d0             	mov    %rdx,%rax
   1400108d0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   1400108d4:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   1400108d8:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
   1400108dc:	7c 0a                	jl     1400108e8 <do_pseudo_reloc+0x2ba>
   1400108de:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   1400108e2:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
   1400108e6:	7e 2b                	jle    140010913 <do_pseudo_reloc+0x2e5>
   1400108e8:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   1400108ec:	4c 8b 45 d8          	mov    -0x28(%rbp),%r8
   1400108f0:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   1400108f4:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   1400108f7:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   1400108fc:	4d 89 c1             	mov    %r8,%r9
   1400108ff:	49 89 c8             	mov    %rcx,%r8
   140010902:	89 c2                	mov    %eax,%edx
   140010904:	48 8d 05 9d 54 00 00 	lea    0x549d(%rip),%rax        # 140015da8 <.rdata+0x108>
   14001090b:	48 89 c1             	mov    %rax,%rcx
   14001090e:	e8 ad f8 ff ff       	call   1400101c0 <__report_error>
   140010913:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140010917:	8b 40 08             	mov    0x8(%rax),%eax
   14001091a:	0f b6 c0             	movzbl %al,%eax
   14001091d:	83 f8 40             	cmp    $0x40,%eax
   140010920:	74 63                	je     140010985 <do_pseudo_reloc+0x357>
   140010922:	83 f8 40             	cmp    $0x40,%eax
   140010925:	77 75                	ja     14001099c <do_pseudo_reloc+0x36e>
   140010927:	83 f8 20             	cmp    $0x20,%eax
   14001092a:	74 41                	je     14001096d <do_pseudo_reloc+0x33f>
   14001092c:	83 f8 20             	cmp    $0x20,%eax
   14001092f:	77 6b                	ja     14001099c <do_pseudo_reloc+0x36e>
   140010931:	83 f8 08             	cmp    $0x8,%eax
   140010934:	74 07                	je     14001093d <do_pseudo_reloc+0x30f>
   140010936:	83 f8 10             	cmp    $0x10,%eax
   140010939:	74 1a                	je     140010955 <do_pseudo_reloc+0x327>
   14001093b:	eb 5f                	jmp    14001099c <do_pseudo_reloc+0x36e>
   14001093d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   140010941:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   140010945:	41 b8 01 00 00 00    	mov    $0x1,%r8d
   14001094b:	48 89 c1             	mov    %rax,%rcx
   14001094e:	e8 94 fc ff ff       	call   1400105e7 <__write_memory>
   140010953:	eb 47                	jmp    14001099c <do_pseudo_reloc+0x36e>
   140010955:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   140010959:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   14001095d:	41 b8 02 00 00 00    	mov    $0x2,%r8d
   140010963:	48 89 c1             	mov    %rax,%rcx
   140010966:	e8 7c fc ff ff       	call   1400105e7 <__write_memory>
   14001096b:	eb 2f                	jmp    14001099c <do_pseudo_reloc+0x36e>
   14001096d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   140010971:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   140010975:	41 b8 04 00 00 00    	mov    $0x4,%r8d
   14001097b:	48 89 c1             	mov    %rax,%rcx
   14001097e:	e8 64 fc ff ff       	call   1400105e7 <__write_memory>
   140010983:	eb 17                	jmp    14001099c <do_pseudo_reloc+0x36e>
   140010985:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   140010989:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   14001098d:	41 b8 08 00 00 00    	mov    $0x8,%r8d
   140010993:	48 89 c1             	mov    %rax,%rcx
   140010996:	e8 4c fc ff ff       	call   1400105e7 <__write_memory>
   14001099b:	90                   	nop
   14001099c:	48 83 45 f0 0c       	addq   $0xc,-0x10(%rbp)
   1400109a1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   1400109a5:	48 3b 45 18          	cmp    0x18(%rbp),%rax
   1400109a9:	0f 82 81 fd ff ff    	jb     140010730 <do_pseudo_reloc+0x102>
   1400109af:	eb 01                	jmp    1400109b2 <do_pseudo_reloc+0x384>
   1400109b1:	90                   	nop
   1400109b2:	48 83 ec 80          	sub    $0xffffffffffffff80,%rsp
   1400109b6:	5d                   	pop    %rbp
   1400109b7:	c3                   	ret

00000001400109b8 <_pei386_runtime_relocator>:
   1400109b8:	55                   	push   %rbp
   1400109b9:	48 89 e5             	mov    %rsp,%rbp
   1400109bc:	48 83 ec 30          	sub    $0x30,%rsp
   1400109c0:	8b 05 36 97 00 00    	mov    0x9736(%rip),%eax        # 14001a0fc <was_init.0>
   1400109c6:	85 c0                	test   %eax,%eax
   1400109c8:	0f 85 88 00 00 00    	jne    140010a56 <_pei386_runtime_relocator+0x9e>
   1400109ce:	8b 05 28 97 00 00    	mov    0x9728(%rip),%eax        # 14001a0fc <was_init.0>
   1400109d4:	83 c0 01             	add    $0x1,%eax
   1400109d7:	89 05 1f 97 00 00    	mov    %eax,0x971f(%rip)        # 14001a0fc <was_init.0>
   1400109dd:	e8 79 08 00 00       	call   14001125b <__mingw_GetSectionCount>
   1400109e2:	89 45 fc             	mov    %eax,-0x4(%rbp)
   1400109e5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   1400109e8:	48 63 d0             	movslq %eax,%rdx
   1400109eb:	48 89 d0             	mov    %rdx,%rax
   1400109ee:	48 c1 e0 02          	shl    $0x2,%rax
   1400109f2:	48 01 d0             	add    %rdx,%rax
   1400109f5:	48 c1 e0 03          	shl    $0x3,%rax
   1400109f9:	48 83 c0 0f          	add    $0xf,%rax
   1400109fd:	48 c1 e8 04          	shr    $0x4,%rax
   140010a01:	48 c1 e0 04          	shl    $0x4,%rax
   140010a05:	e8 d6 0a 00 00       	call   1400114e0 <___chkstk_ms>
   140010a0a:	48 29 c4             	sub    %rax,%rsp
   140010a0d:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
   140010a12:	48 83 c0 0f          	add    $0xf,%rax
   140010a16:	48 c1 e8 04          	shr    $0x4,%rax
   140010a1a:	48 c1 e0 04          	shl    $0x4,%rax
   140010a1e:	48 89 05 cb 96 00 00 	mov    %rax,0x96cb(%rip)        # 14001a0f0 <the_secs>
   140010a25:	c7 05 c9 96 00 00 00 	movl   $0x0,0x96c9(%rip)        # 14001a0f8 <maxSections>
   140010a2c:	00 00 00 
   140010a2f:	4c 8b 05 8a 54 00 00 	mov    0x548a(%rip),%r8        # 140015ec0 <.refptr.__image_base__>
   140010a36:	48 8b 05 43 54 00 00 	mov    0x5443(%rip),%rax        # 140015e80 <.refptr.__RUNTIME_PSEUDO_RELOC_LIST_END__>
   140010a3d:	48 89 c2             	mov    %rax,%rdx
   140010a40:	48 8b 05 49 54 00 00 	mov    0x5449(%rip),%rax        # 140015e90 <.refptr.__RUNTIME_PSEUDO_RELOC_LIST__>
   140010a47:	48 89 c1             	mov    %rax,%rcx
   140010a4a:	e8 df fb ff ff       	call   14001062e <do_pseudo_reloc>
   140010a4f:	e8 bb fa ff ff       	call   14001050f <restore_modified_sections>
   140010a54:	eb 01                	jmp    140010a57 <_pei386_runtime_relocator+0x9f>
   140010a56:	90                   	nop
   140010a57:	48 89 ec             	mov    %rbp,%rsp
   140010a5a:	5d                   	pop    %rbp
   140010a5b:	c3                   	ret
   140010a5c:	90                   	nop
   140010a5d:	90                   	nop
   140010a5e:	90                   	nop
   140010a5f:	90                   	nop

0000000140010a60 <__mingw_raise_matherr>:
   140010a60:	55                   	push   %rbp
   140010a61:	48 89 e5             	mov    %rsp,%rbp
   140010a64:	48 83 ec 50          	sub    $0x50,%rsp
   140010a68:	89 4d 10             	mov    %ecx,0x10(%rbp)
   140010a6b:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140010a6f:	f2 0f 11 55 20       	movsd  %xmm2,0x20(%rbp)
   140010a74:	f2 0f 11 5d 28       	movsd  %xmm3,0x28(%rbp)
   140010a79:	48 8b 05 80 96 00 00 	mov    0x9680(%rip),%rax        # 14001a100 <stUserMathErr>
   140010a80:	48 85 c0             	test   %rax,%rax
   140010a83:	74 3e                	je     140010ac3 <__mingw_raise_matherr+0x63>
   140010a85:	8b 45 10             	mov    0x10(%rbp),%eax
   140010a88:	89 45 d0             	mov    %eax,-0x30(%rbp)
   140010a8b:	48 8b 45 18          	mov    0x18(%rbp),%rax
   140010a8f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   140010a93:	f2 0f 10 45 20       	movsd  0x20(%rbp),%xmm0
   140010a98:	f2 0f 11 45 e0       	movsd  %xmm0,-0x20(%rbp)
   140010a9d:	f2 0f 10 45 28       	movsd  0x28(%rbp),%xmm0
   140010aa2:	f2 0f 11 45 e8       	movsd  %xmm0,-0x18(%rbp)
   140010aa7:	f2 0f 10 45 30       	movsd  0x30(%rbp),%xmm0
   140010aac:	f2 0f 11 45 f0       	movsd  %xmm0,-0x10(%rbp)
   140010ab1:	48 8b 15 48 96 00 00 	mov    0x9648(%rip),%rdx        # 14001a100 <stUserMathErr>
   140010ab8:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   140010abc:	48 89 c1             	mov    %rax,%rcx
   140010abf:	ff d2                	call   *%rdx
   140010ac1:	eb 01                	jmp    140010ac4 <__mingw_raise_matherr+0x64>
   140010ac3:	90                   	nop
   140010ac4:	48 83 c4 50          	add    $0x50,%rsp
   140010ac8:	5d                   	pop    %rbp
   140010ac9:	c3                   	ret

0000000140010aca <__mingw_setusermatherr>:
   140010aca:	55                   	push   %rbp
   140010acb:	48 89 e5             	mov    %rsp,%rbp
   140010ace:	48 83 ec 20          	sub    $0x20,%rsp
   140010ad2:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140010ad6:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140010ada:	48 89 05 1f 96 00 00 	mov    %rax,0x961f(%rip)        # 14001a100 <stUserMathErr>
   140010ae1:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140010ae5:	48 89 c1             	mov    %rax,%rcx
   140010ae8:	e8 a3 0e 00 00       	call   140011990 <__setusermatherr>
   140010aed:	90                   	nop
   140010aee:	48 83 c4 20          	add    $0x20,%rsp
   140010af2:	5d                   	pop    %rbp
   140010af3:	c3                   	ret
   140010af4:	90                   	nop
   140010af5:	90                   	nop
   140010af6:	90                   	nop
   140010af7:	90                   	nop
   140010af8:	90                   	nop
   140010af9:	90                   	nop
   140010afa:	90                   	nop
   140010afb:	90                   	nop
   140010afc:	90                   	nop
   140010afd:	90                   	nop
   140010afe:	90                   	nop
   140010aff:	90                   	nop

0000000140010b00 <_gnu_exception_handler>:
   140010b00:	55                   	push   %rbp
   140010b01:	48 89 e5             	mov    %rsp,%rbp
   140010b04:	48 83 ec 30          	sub    $0x30,%rsp
   140010b08:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140010b0c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   140010b13:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   140010b1a:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140010b1e:	48 8b 00             	mov    (%rax),%rax
   140010b21:	8b 00                	mov    (%rax),%eax
   140010b23:	25 ff ff ff 20       	and    $0x20ffffff,%eax
   140010b28:	3d 43 43 47 20       	cmp    $0x20474343,%eax
   140010b2d:	75 1b                	jne    140010b4a <_gnu_exception_handler+0x4a>
   140010b2f:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140010b33:	48 8b 00             	mov    (%rax),%rax
   140010b36:	8b 40 04             	mov    0x4(%rax),%eax
   140010b39:	83 e0 01             	and    $0x1,%eax
   140010b3c:	85 c0                	test   %eax,%eax
   140010b3e:	75 0a                	jne    140010b4a <_gnu_exception_handler+0x4a>
   140010b40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   140010b45:	e9 d3 01 00 00       	jmp    140010d1d <_gnu_exception_handler+0x21d>
   140010b4a:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140010b4e:	48 8b 00             	mov    (%rax),%rax
   140010b51:	8b 00                	mov    (%rax),%eax
   140010b53:	3d 96 00 00 c0       	cmp    $0xc0000096,%eax
   140010b58:	0f 87 8d 01 00 00    	ja     140010ceb <_gnu_exception_handler+0x1eb>
   140010b5e:	3d 8c 00 00 c0       	cmp    $0xc000008c,%eax
   140010b63:	73 43                	jae    140010ba8 <_gnu_exception_handler+0xa8>
   140010b65:	3d 1d 00 00 c0       	cmp    $0xc000001d,%eax
   140010b6a:	0f 84 bf 00 00 00    	je     140010c2f <_gnu_exception_handler+0x12f>
   140010b70:	3d 1d 00 00 c0       	cmp    $0xc000001d,%eax
   140010b75:	0f 87 70 01 00 00    	ja     140010ceb <_gnu_exception_handler+0x1eb>
   140010b7b:	3d 08 00 00 c0       	cmp    $0xc0000008,%eax
   140010b80:	0f 84 5c 01 00 00    	je     140010ce2 <_gnu_exception_handler+0x1e2>
   140010b86:	3d 08 00 00 c0       	cmp    $0xc0000008,%eax
   140010b8b:	0f 87 5a 01 00 00    	ja     140010ceb <_gnu_exception_handler+0x1eb>
   140010b91:	3d 02 00 00 80       	cmp    $0x80000002,%eax
   140010b96:	0f 84 46 01 00 00    	je     140010ce2 <_gnu_exception_handler+0x1e2>
   140010b9c:	3d 05 00 00 c0       	cmp    $0xc0000005,%eax
   140010ba1:	74 35                	je     140010bd8 <_gnu_exception_handler+0xd8>
   140010ba3:	e9 43 01 00 00       	jmp    140010ceb <_gnu_exception_handler+0x1eb>
   140010ba8:	05 74 ff ff 3f       	add    $0x3fffff74,%eax
   140010bad:	83 f8 0a             	cmp    $0xa,%eax
   140010bb0:	0f 87 35 01 00 00    	ja     140010ceb <_gnu_exception_handler+0x1eb>
   140010bb6:	89 c0                	mov    %eax,%eax
   140010bb8:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
   140010bbf:	00 
   140010bc0:	48 8d 05 39 52 00 00 	lea    0x5239(%rip),%rax        # 140015e00 <.rdata>
   140010bc7:	8b 04 02             	mov    (%rdx,%rax,1),%eax
   140010bca:	48 98                	cltq
   140010bcc:	48 8d 15 2d 52 00 00 	lea    0x522d(%rip),%rdx        # 140015e00 <.rdata>
   140010bd3:	48 01 d0             	add    %rdx,%rax
   140010bd6:	ff e0                	jmp    *%rax
   140010bd8:	ba 00 00 00 00       	mov    $0x0,%edx
   140010bdd:	b9 0b 00 00 00       	mov    $0xb,%ecx
   140010be2:	e8 b9 0e 00 00       	call   140011aa0 <signal>
   140010be7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140010beb:	48 83 7d f0 01       	cmpq   $0x1,-0x10(%rbp)
   140010bf0:	75 1b                	jne    140010c0d <_gnu_exception_handler+0x10d>
   140010bf2:	ba 01 00 00 00       	mov    $0x1,%edx
   140010bf7:	b9 0b 00 00 00       	mov    $0xb,%ecx
   140010bfc:	e8 9f 0e 00 00       	call   140011aa0 <signal>
   140010c01:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   140010c08:	e9 e1 00 00 00       	jmp    140010cee <_gnu_exception_handler+0x1ee>
   140010c0d:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   140010c12:	0f 84 d6 00 00 00    	je     140010cee <_gnu_exception_handler+0x1ee>
   140010c18:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140010c1c:	b9 0b 00 00 00       	mov    $0xb,%ecx
   140010c21:	ff d0                	call   *%rax
   140010c23:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   140010c2a:	e9 bf 00 00 00       	jmp    140010cee <_gnu_exception_handler+0x1ee>
   140010c2f:	ba 00 00 00 00       	mov    $0x0,%edx
   140010c34:	b9 04 00 00 00       	mov    $0x4,%ecx
   140010c39:	e8 62 0e 00 00       	call   140011aa0 <signal>
   140010c3e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140010c42:	48 83 7d f0 01       	cmpq   $0x1,-0x10(%rbp)
   140010c47:	75 1b                	jne    140010c64 <_gnu_exception_handler+0x164>
   140010c49:	ba 01 00 00 00       	mov    $0x1,%edx
   140010c4e:	b9 04 00 00 00       	mov    $0x4,%ecx
   140010c53:	e8 48 0e 00 00       	call   140011aa0 <signal>
   140010c58:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   140010c5f:	e9 8d 00 00 00       	jmp    140010cf1 <_gnu_exception_handler+0x1f1>
   140010c64:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   140010c69:	0f 84 82 00 00 00    	je     140010cf1 <_gnu_exception_handler+0x1f1>
   140010c6f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140010c73:	b9 04 00 00 00       	mov    $0x4,%ecx
   140010c78:	ff d0                	call   *%rax
   140010c7a:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   140010c81:	eb 6e                	jmp    140010cf1 <_gnu_exception_handler+0x1f1>
   140010c83:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   140010c8a:	ba 00 00 00 00       	mov    $0x0,%edx
   140010c8f:	b9 08 00 00 00       	mov    $0x8,%ecx
   140010c94:	e8 07 0e 00 00       	call   140011aa0 <signal>
   140010c99:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140010c9d:	48 83 7d f0 01       	cmpq   $0x1,-0x10(%rbp)
   140010ca2:	75 23                	jne    140010cc7 <_gnu_exception_handler+0x1c7>
   140010ca4:	ba 01 00 00 00       	mov    $0x1,%edx
   140010ca9:	b9 08 00 00 00       	mov    $0x8,%ecx
   140010cae:	e8 ed 0d 00 00       	call   140011aa0 <signal>
   140010cb3:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
   140010cb7:	74 05                	je     140010cbe <_gnu_exception_handler+0x1be>
   140010cb9:	e8 f2 f4 ff ff       	call   1400101b0 <_fpreset>
   140010cbe:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   140010cc5:	eb 2d                	jmp    140010cf4 <_gnu_exception_handler+0x1f4>
   140010cc7:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   140010ccc:	74 26                	je     140010cf4 <_gnu_exception_handler+0x1f4>
   140010cce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140010cd2:	b9 08 00 00 00       	mov    $0x8,%ecx
   140010cd7:	ff d0                	call   *%rax
   140010cd9:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   140010ce0:	eb 12                	jmp    140010cf4 <_gnu_exception_handler+0x1f4>
   140010ce2:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   140010ce9:	eb 0a                	jmp    140010cf5 <_gnu_exception_handler+0x1f5>
   140010ceb:	90                   	nop
   140010cec:	eb 07                	jmp    140010cf5 <_gnu_exception_handler+0x1f5>
   140010cee:	90                   	nop
   140010cef:	eb 04                	jmp    140010cf5 <_gnu_exception_handler+0x1f5>
   140010cf1:	90                   	nop
   140010cf2:	eb 01                	jmp    140010cf5 <_gnu_exception_handler+0x1f5>
   140010cf4:	90                   	nop
   140010cf5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   140010cf9:	75 1f                	jne    140010d1a <_gnu_exception_handler+0x21a>
   140010cfb:	48 8b 05 1e 94 00 00 	mov    0x941e(%rip),%rax        # 14001a120 <__mingw_oldexcpt_handler>
   140010d02:	48 85 c0             	test   %rax,%rax
   140010d05:	74 13                	je     140010d1a <_gnu_exception_handler+0x21a>
   140010d07:	48 8b 15 12 94 00 00 	mov    0x9412(%rip),%rdx        # 14001a120 <__mingw_oldexcpt_handler>
   140010d0e:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140010d12:	48 89 c1             	mov    %rax,%rcx
   140010d15:	ff d2                	call   *%rdx
   140010d17:	89 45 fc             	mov    %eax,-0x4(%rbp)
   140010d1a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140010d1d:	48 83 c4 30          	add    $0x30,%rsp
   140010d21:	5d                   	pop    %rbp
   140010d22:	c3                   	ret
   140010d23:	90                   	nop
   140010d24:	90                   	nop
   140010d25:	90                   	nop
   140010d26:	90                   	nop
   140010d27:	90                   	nop
   140010d28:	90                   	nop
   140010d29:	90                   	nop
   140010d2a:	90                   	nop
   140010d2b:	90                   	nop
   140010d2c:	90                   	nop
   140010d2d:	90                   	nop
   140010d2e:	90                   	nop
   140010d2f:	90                   	nop

0000000140010d30 <___w64_mingwthr_add_key_dtor>:
   140010d30:	55                   	push   %rbp
   140010d31:	48 89 e5             	mov    %rsp,%rbp
   140010d34:	48 83 ec 30          	sub    $0x30,%rsp
   140010d38:	89 4d 10             	mov    %ecx,0x10(%rbp)
   140010d3b:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140010d3f:	8b 05 23 94 00 00    	mov    0x9423(%rip),%eax        # 14001a168 <__mingwthr_cs_init>
   140010d45:	85 c0                	test   %eax,%eax
   140010d47:	75 07                	jne    140010d50 <___w64_mingwthr_add_key_dtor+0x20>
   140010d49:	b8 00 00 00 00       	mov    $0x0,%eax
   140010d4e:	eb 7b                	jmp    140010dcb <___w64_mingwthr_add_key_dtor+0x9b>
   140010d50:	ba 18 00 00 00       	mov    $0x18,%edx
   140010d55:	b9 01 00 00 00       	mov    $0x1,%ecx
   140010d5a:	e8 d1 0c 00 00       	call   140011a30 <calloc>
   140010d5f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140010d63:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   140010d68:	75 07                	jne    140010d71 <___w64_mingwthr_add_key_dtor+0x41>
   140010d6a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   140010d6f:	eb 5a                	jmp    140010dcb <___w64_mingwthr_add_key_dtor+0x9b>
   140010d71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140010d75:	8b 55 10             	mov    0x10(%rbp),%edx
   140010d78:	89 10                	mov    %edx,(%rax)
   140010d7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140010d7e:	48 8b 55 18          	mov    0x18(%rbp),%rdx
   140010d82:	48 89 50 08          	mov    %rdx,0x8(%rax)
   140010d86:	48 8d 05 b3 93 00 00 	lea    0x93b3(%rip),%rax        # 14001a140 <__mingwthr_cs>
   140010d8d:	48 89 c1             	mov    %rax,%rcx
   140010d90:	48 8b 05 b9 a4 00 00 	mov    0xa4b9(%rip),%rax        # 14001b250 <__imp_EnterCriticalSection>
   140010d97:	ff d0                	call   *%rax
   140010d99:	48 8b 15 d0 93 00 00 	mov    0x93d0(%rip),%rdx        # 14001a170 <key_dtor_list>
   140010da0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140010da4:	48 89 50 10          	mov    %rdx,0x10(%rax)
   140010da8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140010dac:	48 89 05 bd 93 00 00 	mov    %rax,0x93bd(%rip)        # 14001a170 <key_dtor_list>
   140010db3:	48 8d 05 86 93 00 00 	lea    0x9386(%rip),%rax        # 14001a140 <__mingwthr_cs>
   140010dba:	48 89 c1             	mov    %rax,%rcx
   140010dbd:	48 8b 05 bc a4 00 00 	mov    0xa4bc(%rip),%rax        # 14001b280 <__imp_LeaveCriticalSection>
   140010dc4:	ff d0                	call   *%rax
   140010dc6:	b8 00 00 00 00       	mov    $0x0,%eax
   140010dcb:	48 83 c4 30          	add    $0x30,%rsp
   140010dcf:	5d                   	pop    %rbp
   140010dd0:	c3                   	ret

0000000140010dd1 <___w64_mingwthr_remove_key_dtor>:
   140010dd1:	55                   	push   %rbp
   140010dd2:	48 89 e5             	mov    %rsp,%rbp
   140010dd5:	48 83 ec 30          	sub    $0x30,%rsp
   140010dd9:	89 4d 10             	mov    %ecx,0x10(%rbp)
   140010ddc:	8b 05 86 93 00 00    	mov    0x9386(%rip),%eax        # 14001a168 <__mingwthr_cs_init>
   140010de2:	85 c0                	test   %eax,%eax
   140010de4:	75 0a                	jne    140010df0 <___w64_mingwthr_remove_key_dtor+0x1f>
   140010de6:	b8 00 00 00 00       	mov    $0x0,%eax
   140010deb:	e9 9c 00 00 00       	jmp    140010e8c <___w64_mingwthr_remove_key_dtor+0xbb>
   140010df0:	48 8d 05 49 93 00 00 	lea    0x9349(%rip),%rax        # 14001a140 <__mingwthr_cs>
   140010df7:	48 89 c1             	mov    %rax,%rcx
   140010dfa:	48 8b 05 4f a4 00 00 	mov    0xa44f(%rip),%rax        # 14001b250 <__imp_EnterCriticalSection>
   140010e01:	ff d0                	call   *%rax
   140010e03:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   140010e0a:	00 
   140010e0b:	48 8b 05 5e 93 00 00 	mov    0x935e(%rip),%rax        # 14001a170 <key_dtor_list>
   140010e12:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140010e16:	eb 55                	jmp    140010e6d <___w64_mingwthr_remove_key_dtor+0x9c>
   140010e18:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140010e1c:	8b 00                	mov    (%rax),%eax
   140010e1e:	39 45 10             	cmp    %eax,0x10(%rbp)
   140010e21:	75 36                	jne    140010e59 <___w64_mingwthr_remove_key_dtor+0x88>
   140010e23:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   140010e28:	75 11                	jne    140010e3b <___w64_mingwthr_remove_key_dtor+0x6a>
   140010e2a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140010e2e:	48 8b 40 10          	mov    0x10(%rax),%rax
   140010e32:	48 89 05 37 93 00 00 	mov    %rax,0x9337(%rip)        # 14001a170 <key_dtor_list>
   140010e39:	eb 10                	jmp    140010e4b <___w64_mingwthr_remove_key_dtor+0x7a>
   140010e3b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140010e3f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   140010e43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140010e47:	48 89 50 10          	mov    %rdx,0x10(%rax)
   140010e4b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140010e4f:	48 89 c1             	mov    %rax,%rcx
   140010e52:	e8 09 0c 00 00       	call   140011a60 <free>
   140010e57:	eb 1b                	jmp    140010e74 <___w64_mingwthr_remove_key_dtor+0xa3>
   140010e59:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140010e5d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140010e61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140010e65:	48 8b 40 10          	mov    0x10(%rax),%rax
   140010e69:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140010e6d:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   140010e72:	75 a4                	jne    140010e18 <___w64_mingwthr_remove_key_dtor+0x47>
   140010e74:	48 8d 05 c5 92 00 00 	lea    0x92c5(%rip),%rax        # 14001a140 <__mingwthr_cs>
   140010e7b:	48 89 c1             	mov    %rax,%rcx
   140010e7e:	48 8b 05 fb a3 00 00 	mov    0xa3fb(%rip),%rax        # 14001b280 <__imp_LeaveCriticalSection>
   140010e85:	ff d0                	call   *%rax
   140010e87:	b8 00 00 00 00       	mov    $0x0,%eax
   140010e8c:	48 83 c4 30          	add    $0x30,%rsp
   140010e90:	5d                   	pop    %rbp
   140010e91:	c3                   	ret

0000000140010e92 <__mingwthr_run_key_dtors>:
   140010e92:	55                   	push   %rbp
   140010e93:	48 89 e5             	mov    %rsp,%rbp
   140010e96:	48 83 ec 30          	sub    $0x30,%rsp
   140010e9a:	8b 05 c8 92 00 00    	mov    0x92c8(%rip),%eax        # 14001a168 <__mingwthr_cs_init>
   140010ea0:	85 c0                	test   %eax,%eax
   140010ea2:	0f 84 82 00 00 00    	je     140010f2a <__mingwthr_run_key_dtors+0x98>
   140010ea8:	48 8d 05 91 92 00 00 	lea    0x9291(%rip),%rax        # 14001a140 <__mingwthr_cs>
   140010eaf:	48 89 c1             	mov    %rax,%rcx
   140010eb2:	48 8b 05 97 a3 00 00 	mov    0xa397(%rip),%rax        # 14001b250 <__imp_EnterCriticalSection>
   140010eb9:	ff d0                	call   *%rax
   140010ebb:	48 8b 05 ae 92 00 00 	mov    0x92ae(%rip),%rax        # 14001a170 <key_dtor_list>
   140010ec2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140010ec6:	eb 46                	jmp    140010f0e <__mingwthr_run_key_dtors+0x7c>
   140010ec8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140010ecc:	8b 00                	mov    (%rax),%eax
   140010ece:	89 c1                	mov    %eax,%ecx
   140010ed0:	48 8b 05 c9 a3 00 00 	mov    0xa3c9(%rip),%rax        # 14001b2a0 <__imp_TlsGetValue>
   140010ed7:	ff d0                	call   *%rax
   140010ed9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140010edd:	48 8b 05 7c a3 00 00 	mov    0xa37c(%rip),%rax        # 14001b260 <__imp_GetLastError>
   140010ee4:	ff d0                	call   *%rax
   140010ee6:	85 c0                	test   %eax,%eax
   140010ee8:	75 18                	jne    140010f02 <__mingwthr_run_key_dtors+0x70>
   140010eea:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   140010eef:	74 11                	je     140010f02 <__mingwthr_run_key_dtors+0x70>
   140010ef1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140010ef5:	48 8b 50 08          	mov    0x8(%rax),%rdx
   140010ef9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140010efd:	48 89 c1             	mov    %rax,%rcx
   140010f00:	ff d2                	call   *%rdx
   140010f02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140010f06:	48 8b 40 10          	mov    0x10(%rax),%rax
   140010f0a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140010f0e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   140010f13:	75 b3                	jne    140010ec8 <__mingwthr_run_key_dtors+0x36>
   140010f15:	48 8d 05 24 92 00 00 	lea    0x9224(%rip),%rax        # 14001a140 <__mingwthr_cs>
   140010f1c:	48 89 c1             	mov    %rax,%rcx
   140010f1f:	48 8b 05 5a a3 00 00 	mov    0xa35a(%rip),%rax        # 14001b280 <__imp_LeaveCriticalSection>
   140010f26:	ff d0                	call   *%rax
   140010f28:	eb 01                	jmp    140010f2b <__mingwthr_run_key_dtors+0x99>
   140010f2a:	90                   	nop
   140010f2b:	48 83 c4 30          	add    $0x30,%rsp
   140010f2f:	5d                   	pop    %rbp
   140010f30:	c3                   	ret

0000000140010f31 <__mingw_TLScallback>:
   140010f31:	55                   	push   %rbp
   140010f32:	48 89 e5             	mov    %rsp,%rbp
   140010f35:	48 83 ec 30          	sub    $0x30,%rsp
   140010f39:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140010f3d:	89 55 18             	mov    %edx,0x18(%rbp)
   140010f40:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140010f44:	83 7d 18 03          	cmpl   $0x3,0x18(%rbp)
   140010f48:	0f 84 cc 00 00 00    	je     14001101a <__mingw_TLScallback+0xe9>
   140010f4e:	83 7d 18 03          	cmpl   $0x3,0x18(%rbp)
   140010f52:	0f 87 ca 00 00 00    	ja     140011022 <__mingw_TLScallback+0xf1>
   140010f58:	83 7d 18 02          	cmpl   $0x2,0x18(%rbp)
   140010f5c:	0f 84 b1 00 00 00    	je     140011013 <__mingw_TLScallback+0xe2>
   140010f62:	83 7d 18 02          	cmpl   $0x2,0x18(%rbp)
   140010f66:	0f 87 b6 00 00 00    	ja     140011022 <__mingw_TLScallback+0xf1>
   140010f6c:	83 7d 18 00          	cmpl   $0x0,0x18(%rbp)
   140010f70:	74 33                	je     140010fa5 <__mingw_TLScallback+0x74>
   140010f72:	83 7d 18 01          	cmpl   $0x1,0x18(%rbp)
   140010f76:	0f 85 a6 00 00 00    	jne    140011022 <__mingw_TLScallback+0xf1>
   140010f7c:	8b 05 e6 91 00 00    	mov    0x91e6(%rip),%eax        # 14001a168 <__mingwthr_cs_init>
   140010f82:	85 c0                	test   %eax,%eax
   140010f84:	75 13                	jne    140010f99 <__mingw_TLScallback+0x68>
   140010f86:	48 8d 05 b3 91 00 00 	lea    0x91b3(%rip),%rax        # 14001a140 <__mingwthr_cs>
   140010f8d:	48 89 c1             	mov    %rax,%rcx
   140010f90:	48 8b 05 e1 a2 00 00 	mov    0xa2e1(%rip),%rax        # 14001b278 <__imp_InitializeCriticalSection>
   140010f97:	ff d0                	call   *%rax
   140010f99:	c7 05 c5 91 00 00 01 	movl   $0x1,0x91c5(%rip)        # 14001a168 <__mingwthr_cs_init>
   140010fa0:	00 00 00 
   140010fa3:	eb 7d                	jmp    140011022 <__mingw_TLScallback+0xf1>
   140010fa5:	e8 e8 fe ff ff       	call   140010e92 <__mingwthr_run_key_dtors>
   140010faa:	8b 05 b8 91 00 00    	mov    0x91b8(%rip),%eax        # 14001a168 <__mingwthr_cs_init>
   140010fb0:	83 f8 01             	cmp    $0x1,%eax
   140010fb3:	75 6c                	jne    140011021 <__mingw_TLScallback+0xf0>
   140010fb5:	48 8b 05 b4 91 00 00 	mov    0x91b4(%rip),%rax        # 14001a170 <key_dtor_list>
   140010fbc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140010fc0:	eb 20                	jmp    140010fe2 <__mingw_TLScallback+0xb1>
   140010fc2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140010fc6:	48 8b 40 10          	mov    0x10(%rax),%rax
   140010fca:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140010fce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140010fd2:	48 89 c1             	mov    %rax,%rcx
   140010fd5:	e8 86 0a 00 00       	call   140011a60 <free>
   140010fda:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140010fde:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140010fe2:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   140010fe7:	75 d9                	jne    140010fc2 <__mingw_TLScallback+0x91>
   140010fe9:	48 c7 05 7c 91 00 00 	movq   $0x0,0x917c(%rip)        # 14001a170 <key_dtor_list>
   140010ff0:	00 00 00 00 
   140010ff4:	c7 05 6a 91 00 00 00 	movl   $0x0,0x916a(%rip)        # 14001a168 <__mingwthr_cs_init>
   140010ffb:	00 00 00 
   140010ffe:	48 8d 05 3b 91 00 00 	lea    0x913b(%rip),%rax        # 14001a140 <__mingwthr_cs>
   140011005:	48 89 c1             	mov    %rax,%rcx
   140011008:	48 8b 05 39 a2 00 00 	mov    0xa239(%rip),%rax        # 14001b248 <__IAT_start__>
   14001100f:	ff d0                	call   *%rax
   140011011:	eb 0e                	jmp    140011021 <__mingw_TLScallback+0xf0>
   140011013:	e8 98 f1 ff ff       	call   1400101b0 <_fpreset>
   140011018:	eb 08                	jmp    140011022 <__mingw_TLScallback+0xf1>
   14001101a:	e8 73 fe ff ff       	call   140010e92 <__mingwthr_run_key_dtors>
   14001101f:	eb 01                	jmp    140011022 <__mingw_TLScallback+0xf1>
   140011021:	90                   	nop
   140011022:	b8 01 00 00 00       	mov    $0x1,%eax
   140011027:	48 83 c4 30          	add    $0x30,%rsp
   14001102b:	5d                   	pop    %rbp
   14001102c:	c3                   	ret
   14001102d:	90                   	nop
   14001102e:	90                   	nop
   14001102f:	90                   	nop

0000000140011030 <_ValidateImageBase>:
   140011030:	55                   	push   %rbp
   140011031:	48 89 e5             	mov    %rsp,%rbp
   140011034:	48 83 ec 20          	sub    $0x20,%rsp
   140011038:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14001103c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140011040:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140011044:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140011048:	0f b7 00             	movzwl (%rax),%eax
   14001104b:	66 3d 4d 5a          	cmp    $0x5a4d,%ax
   14001104f:	74 07                	je     140011058 <_ValidateImageBase+0x28>
   140011051:	b8 00 00 00 00       	mov    $0x0,%eax
   140011056:	eb 4e                	jmp    1400110a6 <_ValidateImageBase+0x76>
   140011058:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14001105c:	8b 40 3c             	mov    0x3c(%rax),%eax
   14001105f:	48 63 d0             	movslq %eax,%rdx
   140011062:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140011066:	48 01 d0             	add    %rdx,%rax
   140011069:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14001106d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140011071:	8b 00                	mov    (%rax),%eax
   140011073:	3d 50 45 00 00       	cmp    $0x4550,%eax
   140011078:	74 07                	je     140011081 <_ValidateImageBase+0x51>
   14001107a:	b8 00 00 00 00       	mov    $0x0,%eax
   14001107f:	eb 25                	jmp    1400110a6 <_ValidateImageBase+0x76>
   140011081:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140011085:	48 83 c0 18          	add    $0x18,%rax
   140011089:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   14001108d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140011091:	0f b7 00             	movzwl (%rax),%eax
   140011094:	66 3d 0b 02          	cmp    $0x20b,%ax
   140011098:	74 07                	je     1400110a1 <_ValidateImageBase+0x71>
   14001109a:	b8 00 00 00 00       	mov    $0x0,%eax
   14001109f:	eb 05                	jmp    1400110a6 <_ValidateImageBase+0x76>
   1400110a1:	b8 01 00 00 00       	mov    $0x1,%eax
   1400110a6:	48 83 c4 20          	add    $0x20,%rsp
   1400110aa:	5d                   	pop    %rbp
   1400110ab:	c3                   	ret

00000001400110ac <_FindPESection>:
   1400110ac:	55                   	push   %rbp
   1400110ad:	48 89 e5             	mov    %rsp,%rbp
   1400110b0:	48 83 ec 20          	sub    $0x20,%rsp
   1400110b4:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400110b8:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400110bc:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400110c0:	8b 40 3c             	mov    0x3c(%rax),%eax
   1400110c3:	48 63 d0             	movslq %eax,%rdx
   1400110c6:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400110ca:	48 01 d0             	add    %rdx,%rax
   1400110cd:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   1400110d1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   1400110d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   1400110dc:	0f b7 40 14          	movzwl 0x14(%rax),%eax
   1400110e0:	0f b7 d0             	movzwl %ax,%edx
   1400110e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   1400110e7:	48 01 d0             	add    %rdx,%rax
   1400110ea:	48 83 c0 18          	add    $0x18,%rax
   1400110ee:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   1400110f2:	eb 36                	jmp    14001112a <_FindPESection+0x7e>
   1400110f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400110f8:	8b 40 0c             	mov    0xc(%rax),%eax
   1400110fb:	89 c0                	mov    %eax,%eax
   1400110fd:	48 39 45 18          	cmp    %rax,0x18(%rbp)
   140011101:	72 1e                	jb     140011121 <_FindPESection+0x75>
   140011103:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140011107:	8b 50 0c             	mov    0xc(%rax),%edx
   14001110a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14001110e:	8b 40 08             	mov    0x8(%rax),%eax
   140011111:	01 d0                	add    %edx,%eax
   140011113:	89 c0                	mov    %eax,%eax
   140011115:	48 39 45 18          	cmp    %rax,0x18(%rbp)
   140011119:	73 06                	jae    140011121 <_FindPESection+0x75>
   14001111b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14001111f:	eb 1e                	jmp    14001113f <_FindPESection+0x93>
   140011121:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   140011125:	48 83 45 f8 28       	addq   $0x28,-0x8(%rbp)
   14001112a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14001112e:	0f b7 40 06          	movzwl 0x6(%rax),%eax
   140011132:	0f b7 c0             	movzwl %ax,%eax
   140011135:	39 45 f4             	cmp    %eax,-0xc(%rbp)
   140011138:	72 ba                	jb     1400110f4 <_FindPESection+0x48>
   14001113a:	b8 00 00 00 00       	mov    $0x0,%eax
   14001113f:	48 83 c4 20          	add    $0x20,%rsp
   140011143:	5d                   	pop    %rbp
   140011144:	c3                   	ret

0000000140011145 <_FindPESectionByName>:
   140011145:	55                   	push   %rbp
   140011146:	48 89 e5             	mov    %rsp,%rbp
   140011149:	48 83 ec 40          	sub    $0x40,%rsp
   14001114d:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140011151:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140011155:	48 89 c1             	mov    %rax,%rcx
   140011158:	e8 53 09 00 00       	call   140011ab0 <strlen>
   14001115d:	48 83 f8 08          	cmp    $0x8,%rax
   140011161:	76 0a                	jbe    14001116d <_FindPESectionByName+0x28>
   140011163:	b8 00 00 00 00       	mov    $0x0,%eax
   140011168:	e9 98 00 00 00       	jmp    140011205 <_FindPESectionByName+0xc0>
   14001116d:	48 8b 05 4c 4d 00 00 	mov    0x4d4c(%rip),%rax        # 140015ec0 <.refptr.__image_base__>
   140011174:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   140011178:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14001117c:	48 89 c1             	mov    %rax,%rcx
   14001117f:	e8 ac fe ff ff       	call   140011030 <_ValidateImageBase>
   140011184:	85 c0                	test   %eax,%eax
   140011186:	75 07                	jne    14001118f <_FindPESectionByName+0x4a>
   140011188:	b8 00 00 00 00       	mov    $0x0,%eax
   14001118d:	eb 76                	jmp    140011205 <_FindPESectionByName+0xc0>
   14001118f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140011193:	8b 40 3c             	mov    0x3c(%rax),%eax
   140011196:	48 63 d0             	movslq %eax,%rdx
   140011199:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   14001119d:	48 01 d0             	add    %rdx,%rax
   1400111a0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   1400111a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   1400111ab:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   1400111af:	0f b7 40 14          	movzwl 0x14(%rax),%eax
   1400111b3:	0f b7 d0             	movzwl %ax,%edx
   1400111b6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   1400111ba:	48 01 d0             	add    %rdx,%rax
   1400111bd:	48 83 c0 18          	add    $0x18,%rax
   1400111c1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   1400111c5:	eb 29                	jmp    1400111f0 <_FindPESectionByName+0xab>
   1400111c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400111cb:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   1400111cf:	41 b8 08 00 00 00    	mov    $0x8,%r8d
   1400111d5:	48 89 c1             	mov    %rax,%rcx
   1400111d8:	e8 db 08 00 00       	call   140011ab8 <strncmp>
   1400111dd:	85 c0                	test   %eax,%eax
   1400111df:	75 06                	jne    1400111e7 <_FindPESectionByName+0xa2>
   1400111e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400111e5:	eb 1e                	jmp    140011205 <_FindPESectionByName+0xc0>
   1400111e7:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   1400111eb:	48 83 45 f8 28       	addq   $0x28,-0x8(%rbp)
   1400111f0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   1400111f4:	0f b7 40 06          	movzwl 0x6(%rax),%eax
   1400111f8:	0f b7 c0             	movzwl %ax,%eax
   1400111fb:	39 45 f4             	cmp    %eax,-0xc(%rbp)
   1400111fe:	72 c7                	jb     1400111c7 <_FindPESectionByName+0x82>
   140011200:	b8 00 00 00 00       	mov    $0x0,%eax
   140011205:	48 83 c4 40          	add    $0x40,%rsp
   140011209:	5d                   	pop    %rbp
   14001120a:	c3                   	ret

000000014001120b <__mingw_GetSectionForAddress>:
   14001120b:	55                   	push   %rbp
   14001120c:	48 89 e5             	mov    %rsp,%rbp
   14001120f:	48 83 ec 30          	sub    $0x30,%rsp
   140011213:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140011217:	48 8b 05 a2 4c 00 00 	mov    0x4ca2(%rip),%rax        # 140015ec0 <.refptr.__image_base__>
   14001121e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   140011222:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140011226:	48 89 c1             	mov    %rax,%rcx
   140011229:	e8 02 fe ff ff       	call   140011030 <_ValidateImageBase>
   14001122e:	85 c0                	test   %eax,%eax
   140011230:	75 07                	jne    140011239 <__mingw_GetSectionForAddress+0x2e>
   140011232:	b8 00 00 00 00       	mov    $0x0,%eax
   140011237:	eb 1c                	jmp    140011255 <__mingw_GetSectionForAddress+0x4a>
   140011239:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14001123d:	48 2b 45 f8          	sub    -0x8(%rbp),%rax
   140011241:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140011245:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   140011249:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14001124d:	48 89 c1             	mov    %rax,%rcx
   140011250:	e8 57 fe ff ff       	call   1400110ac <_FindPESection>
   140011255:	48 83 c4 30          	add    $0x30,%rsp
   140011259:	5d                   	pop    %rbp
   14001125a:	c3                   	ret

000000014001125b <__mingw_GetSectionCount>:
   14001125b:	55                   	push   %rbp
   14001125c:	48 89 e5             	mov    %rsp,%rbp
   14001125f:	48 83 ec 30          	sub    $0x30,%rsp
   140011263:	48 8b 05 56 4c 00 00 	mov    0x4c56(%rip),%rax        # 140015ec0 <.refptr.__image_base__>
   14001126a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14001126e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140011272:	48 89 c1             	mov    %rax,%rcx
   140011275:	e8 b6 fd ff ff       	call   140011030 <_ValidateImageBase>
   14001127a:	85 c0                	test   %eax,%eax
   14001127c:	75 07                	jne    140011285 <__mingw_GetSectionCount+0x2a>
   14001127e:	b8 00 00 00 00       	mov    $0x0,%eax
   140011283:	eb 20                	jmp    1400112a5 <__mingw_GetSectionCount+0x4a>
   140011285:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140011289:	8b 40 3c             	mov    0x3c(%rax),%eax
   14001128c:	48 63 d0             	movslq %eax,%rdx
   14001128f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140011293:	48 01 d0             	add    %rdx,%rax
   140011296:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   14001129a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14001129e:	0f b7 40 06          	movzwl 0x6(%rax),%eax
   1400112a2:	0f b7 c0             	movzwl %ax,%eax
   1400112a5:	48 83 c4 30          	add    $0x30,%rsp
   1400112a9:	5d                   	pop    %rbp
   1400112aa:	c3                   	ret

00000001400112ab <_FindPESectionExec>:
   1400112ab:	55                   	push   %rbp
   1400112ac:	48 89 e5             	mov    %rsp,%rbp
   1400112af:	48 83 ec 40          	sub    $0x40,%rsp
   1400112b3:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400112b7:	48 8b 05 02 4c 00 00 	mov    0x4c02(%rip),%rax        # 140015ec0 <.refptr.__image_base__>
   1400112be:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   1400112c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   1400112c6:	48 89 c1             	mov    %rax,%rcx
   1400112c9:	e8 62 fd ff ff       	call   140011030 <_ValidateImageBase>
   1400112ce:	85 c0                	test   %eax,%eax
   1400112d0:	75 07                	jne    1400112d9 <_FindPESectionExec+0x2e>
   1400112d2:	b8 00 00 00 00       	mov    $0x0,%eax
   1400112d7:	eb 78                	jmp    140011351 <_FindPESectionExec+0xa6>
   1400112d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   1400112dd:	8b 40 3c             	mov    0x3c(%rax),%eax
   1400112e0:	48 63 d0             	movslq %eax,%rdx
   1400112e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   1400112e7:	48 01 d0             	add    %rdx,%rax
   1400112ea:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   1400112ee:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   1400112f5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   1400112f9:	0f b7 40 14          	movzwl 0x14(%rax),%eax
   1400112fd:	0f b7 d0             	movzwl %ax,%edx
   140011300:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   140011304:	48 01 d0             	add    %rdx,%rax
   140011307:	48 83 c0 18          	add    $0x18,%rax
   14001130b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14001130f:	eb 2b                	jmp    14001133c <_FindPESectionExec+0x91>
   140011311:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140011315:	8b 40 24             	mov    0x24(%rax),%eax
   140011318:	25 00 00 00 20       	and    $0x20000000,%eax
   14001131d:	85 c0                	test   %eax,%eax
   14001131f:	74 12                	je     140011333 <_FindPESectionExec+0x88>
   140011321:	48 83 7d 10 00       	cmpq   $0x0,0x10(%rbp)
   140011326:	75 06                	jne    14001132e <_FindPESectionExec+0x83>
   140011328:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14001132c:	eb 23                	jmp    140011351 <_FindPESectionExec+0xa6>
   14001132e:	48 83 6d 10 01       	subq   $0x1,0x10(%rbp)
   140011333:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   140011337:	48 83 45 f8 28       	addq   $0x28,-0x8(%rbp)
   14001133c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   140011340:	0f b7 40 06          	movzwl 0x6(%rax),%eax
   140011344:	0f b7 c0             	movzwl %ax,%eax
   140011347:	39 45 f4             	cmp    %eax,-0xc(%rbp)
   14001134a:	72 c5                	jb     140011311 <_FindPESectionExec+0x66>
   14001134c:	b8 00 00 00 00       	mov    $0x0,%eax
   140011351:	48 83 c4 40          	add    $0x40,%rsp
   140011355:	5d                   	pop    %rbp
   140011356:	c3                   	ret

0000000140011357 <_GetPEImageBase>:
   140011357:	55                   	push   %rbp
   140011358:	48 89 e5             	mov    %rsp,%rbp
   14001135b:	48 83 ec 30          	sub    $0x30,%rsp
   14001135f:	48 8b 05 5a 4b 00 00 	mov    0x4b5a(%rip),%rax        # 140015ec0 <.refptr.__image_base__>
   140011366:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14001136a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14001136e:	48 89 c1             	mov    %rax,%rcx
   140011371:	e8 ba fc ff ff       	call   140011030 <_ValidateImageBase>
   140011376:	85 c0                	test   %eax,%eax
   140011378:	75 07                	jne    140011381 <_GetPEImageBase+0x2a>
   14001137a:	b8 00 00 00 00       	mov    $0x0,%eax
   14001137f:	eb 04                	jmp    140011385 <_GetPEImageBase+0x2e>
   140011381:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   140011385:	48 83 c4 30          	add    $0x30,%rsp
   140011389:	5d                   	pop    %rbp
   14001138a:	c3                   	ret

000000014001138b <_IsNonwritableInCurrentImage>:
   14001138b:	55                   	push   %rbp
   14001138c:	48 89 e5             	mov    %rsp,%rbp
   14001138f:	48 83 ec 40          	sub    $0x40,%rsp
   140011393:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140011397:	48 8b 05 22 4b 00 00 	mov    0x4b22(%rip),%rax        # 140015ec0 <.refptr.__image_base__>
   14001139e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   1400113a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400113a6:	48 89 c1             	mov    %rax,%rcx
   1400113a9:	e8 82 fc ff ff       	call   140011030 <_ValidateImageBase>
   1400113ae:	85 c0                	test   %eax,%eax
   1400113b0:	75 07                	jne    1400113b9 <_IsNonwritableInCurrentImage+0x2e>
   1400113b2:	b8 00 00 00 00       	mov    $0x0,%eax
   1400113b7:	eb 3d                	jmp    1400113f6 <_IsNonwritableInCurrentImage+0x6b>
   1400113b9:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400113bd:	48 2b 45 f8          	sub    -0x8(%rbp),%rax
   1400113c1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   1400113c5:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   1400113c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400113cd:	48 89 c1             	mov    %rax,%rcx
   1400113d0:	e8 d7 fc ff ff       	call   1400110ac <_FindPESection>
   1400113d5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   1400113d9:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   1400113de:	75 07                	jne    1400113e7 <_IsNonwritableInCurrentImage+0x5c>
   1400113e0:	b8 00 00 00 00       	mov    $0x0,%eax
   1400113e5:	eb 0f                	jmp    1400113f6 <_IsNonwritableInCurrentImage+0x6b>
   1400113e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   1400113eb:	8b 40 24             	mov    0x24(%rax),%eax
   1400113ee:	f7 d0                	not    %eax
   1400113f0:	c1 e8 1f             	shr    $0x1f,%eax
   1400113f3:	0f b6 c0             	movzbl %al,%eax
   1400113f6:	48 83 c4 40          	add    $0x40,%rsp
   1400113fa:	5d                   	pop    %rbp
   1400113fb:	c3                   	ret

00000001400113fc <__mingw_enum_import_library_names>:
   1400113fc:	55                   	push   %rbp
   1400113fd:	48 89 e5             	mov    %rsp,%rbp
   140011400:	48 83 ec 50          	sub    $0x50,%rsp
   140011404:	89 4d 10             	mov    %ecx,0x10(%rbp)
   140011407:	48 8b 05 b2 4a 00 00 	mov    0x4ab2(%rip),%rax        # 140015ec0 <.refptr.__image_base__>
   14001140e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140011412:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140011416:	48 89 c1             	mov    %rax,%rcx
   140011419:	e8 12 fc ff ff       	call   140011030 <_ValidateImageBase>
   14001141e:	85 c0                	test   %eax,%eax
   140011420:	75 0a                	jne    14001142c <__mingw_enum_import_library_names+0x30>
   140011422:	b8 00 00 00 00       	mov    $0x0,%eax
   140011427:	e9 ab 00 00 00       	jmp    1400114d7 <__mingw_enum_import_library_names+0xdb>
   14001142c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140011430:	8b 40 3c             	mov    0x3c(%rax),%eax
   140011433:	48 63 d0             	movslq %eax,%rdx
   140011436:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   14001143a:	48 01 d0             	add    %rdx,%rax
   14001143d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   140011441:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   140011445:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
   14001144b:	89 45 e4             	mov    %eax,-0x1c(%rbp)
   14001144e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   140011452:	75 07                	jne    14001145b <__mingw_enum_import_library_names+0x5f>
   140011454:	b8 00 00 00 00       	mov    $0x0,%eax
   140011459:	eb 7c                	jmp    1400114d7 <__mingw_enum_import_library_names+0xdb>
   14001145b:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   14001145e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140011462:	48 89 c1             	mov    %rax,%rcx
   140011465:	e8 42 fc ff ff       	call   1400110ac <_FindPESection>
   14001146a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   14001146e:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   140011473:	75 07                	jne    14001147c <__mingw_enum_import_library_names+0x80>
   140011475:	b8 00 00 00 00       	mov    $0x0,%eax
   14001147a:	eb 5b                	jmp    1400114d7 <__mingw_enum_import_library_names+0xdb>
   14001147c:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   14001147f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   140011483:	48 01 d0             	add    %rdx,%rax
   140011486:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   14001148a:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   14001148f:	75 07                	jne    140011498 <__mingw_enum_import_library_names+0x9c>
   140011491:	b8 00 00 00 00       	mov    $0x0,%eax
   140011496:	eb 3f                	jmp    1400114d7 <__mingw_enum_import_library_names+0xdb>
   140011498:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   14001149c:	8b 40 04             	mov    0x4(%rax),%eax
   14001149f:	85 c0                	test   %eax,%eax
   1400114a1:	75 0b                	jne    1400114ae <__mingw_enum_import_library_names+0xb2>
   1400114a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400114a7:	8b 40 0c             	mov    0xc(%rax),%eax
   1400114aa:	85 c0                	test   %eax,%eax
   1400114ac:	74 23                	je     1400114d1 <__mingw_enum_import_library_names+0xd5>
   1400114ae:	83 7d 10 00          	cmpl   $0x0,0x10(%rbp)
   1400114b2:	7f 12                	jg     1400114c6 <__mingw_enum_import_library_names+0xca>
   1400114b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   1400114b8:	8b 40 0c             	mov    0xc(%rax),%eax
   1400114bb:	89 c2                	mov    %eax,%edx
   1400114bd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   1400114c1:	48 01 d0             	add    %rdx,%rax
   1400114c4:	eb 11                	jmp    1400114d7 <__mingw_enum_import_library_names+0xdb>
   1400114c6:	83 6d 10 01          	subl   $0x1,0x10(%rbp)
   1400114ca:	48 83 45 f8 14       	addq   $0x14,-0x8(%rbp)
   1400114cf:	eb c7                	jmp    140011498 <__mingw_enum_import_library_names+0x9c>
   1400114d1:	90                   	nop
   1400114d2:	b8 00 00 00 00       	mov    $0x0,%eax
   1400114d7:	48 83 c4 50          	add    $0x50,%rsp
   1400114db:	5d                   	pop    %rbp
   1400114dc:	c3                   	ret
   1400114dd:	90                   	nop
   1400114de:	90                   	nop
   1400114df:	90                   	nop

00000001400114e0 <___chkstk_ms>:
   1400114e0:	51                   	push   %rcx
   1400114e1:	50                   	push   %rax
   1400114e2:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
   1400114e8:	48 8d 4c 24 18       	lea    0x18(%rsp),%rcx
   1400114ed:	72 19                	jb     140011508 <___chkstk_ms+0x28>
   1400114ef:	48 81 e9 00 10 00 00 	sub    $0x1000,%rcx
   1400114f6:	48 83 09 00          	orq    $0x0,(%rcx)
   1400114fa:	48 2d 00 10 00 00    	sub    $0x1000,%rax
   140011500:	48 3d 00 10 00 00    	cmp    $0x1000,%rax
   140011506:	77 e7                	ja     1400114ef <___chkstk_ms+0xf>
   140011508:	48 29 c1             	sub    %rax,%rcx
   14001150b:	48 83 09 00          	orq    $0x0,(%rcx)
   14001150f:	58                   	pop    %rax
   140011510:	59                   	pop    %rcx
   140011511:	c3                   	ret
   140011512:	90                   	nop
   140011513:	90                   	nop
   140011514:	90                   	nop
   140011515:	90                   	nop
   140011516:	90                   	nop
   140011517:	90                   	nop
   140011518:	90                   	nop
   140011519:	90                   	nop
   14001151a:	90                   	nop
   14001151b:	90                   	nop
   14001151c:	90                   	nop
   14001151d:	90                   	nop
   14001151e:	90                   	nop
   14001151f:	90                   	nop

0000000140011520 <fmod>:
   140011520:	55                   	push   %rbp
   140011521:	48 89 e5             	mov    %rsp,%rbp
   140011524:	48 83 ec 20          	sub    $0x20,%rsp
   140011528:	f2 0f 11 45 10       	movsd  %xmm0,0x10(%rbp)
   14001152d:	f2 0f 11 4d 18       	movsd  %xmm1,0x18(%rbp)
   140011532:	66 0f ef c0          	pxor   %xmm0,%xmm0
   140011536:	f2 0f 11 45 f8       	movsd  %xmm0,-0x8(%rbp)
   14001153b:	f2 0f 10 45 10       	movsd  0x10(%rbp),%xmm0
   140011540:	f2 0f 10 55 18       	movsd  0x18(%rbp),%xmm2
   140011545:	f2 0f 11 55 e8       	movsd  %xmm2,-0x18(%rbp)
   14001154a:	dd 45 e8             	fldl   -0x18(%rbp)
   14001154d:	f2 0f 11 45 e8       	movsd  %xmm0,-0x18(%rbp)
   140011552:	dd 45 e8             	fldl   -0x18(%rbp)
   140011555:	d9 f8                	fprem
   140011557:	9b df e0             	fstsw  %ax
   14001155a:	9e                   	sahf
   14001155b:	7a f8                	jp     140011555 <fmod+0x35>
   14001155d:	dd d9                	fstp   %st(1)
   14001155f:	dd 5d f8             	fstpl  -0x8(%rbp)
   140011562:	f2 0f 10 45 f8       	movsd  -0x8(%rbp),%xmm0
   140011567:	66 48 0f 7e c0       	movq   %xmm0,%rax
   14001156c:	66 48 0f 6e c0       	movq   %rax,%xmm0
   140011571:	48 83 c4 20          	add    $0x20,%rsp
   140011575:	5d                   	pop    %rbp
   140011576:	c3                   	ret
   140011577:	90                   	nop
   140011578:	90                   	nop
   140011579:	90                   	nop
   14001157a:	90                   	nop
   14001157b:	90                   	nop
   14001157c:	90                   	nop
   14001157d:	90                   	nop
   14001157e:	90                   	nop
   14001157f:	90                   	nop

0000000140011580 <vfprintf>:
   140011580:	55                   	push   %rbp
   140011581:	48 89 e5             	mov    %rsp,%rbp
   140011584:	48 83 ec 30          	sub    $0x30,%rsp
   140011588:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14001158c:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140011590:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140011594:	48 8b 4d 18          	mov    0x18(%rbp),%rcx
   140011598:	48 8b 45 10          	mov    0x10(%rbp),%rax
   14001159c:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   1400115a0:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   1400115a5:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   1400115ab:	49 89 c8             	mov    %rcx,%r8
   1400115ae:	48 89 c2             	mov    %rax,%rdx
   1400115b1:	b9 00 00 00 00       	mov    $0x0,%ecx
   1400115b6:	e8 dd 03 00 00       	call   140011998 <__stdio_common_vfprintf>
   1400115bb:	48 83 c4 30          	add    $0x30,%rsp
   1400115bf:	5d                   	pop    %rbp
   1400115c0:	c3                   	ret
   1400115c1:	90                   	nop
   1400115c2:	90                   	nop
   1400115c3:	90                   	nop
   1400115c4:	90                   	nop
   1400115c5:	90                   	nop
   1400115c6:	90                   	nop
   1400115c7:	90                   	nop
   1400115c8:	90                   	nop
   1400115c9:	90                   	nop
   1400115ca:	90                   	nop
   1400115cb:	90                   	nop
   1400115cc:	90                   	nop
   1400115cd:	90                   	nop
   1400115ce:	90                   	nop
   1400115cf:	90                   	nop

00000001400115d0 <snprintf>:
   1400115d0:	55                   	push   %rbp
   1400115d1:	48 89 e5             	mov    %rsp,%rbp
   1400115d4:	48 83 ec 40          	sub    $0x40,%rsp
   1400115d8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400115dc:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400115e0:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   1400115e4:	4c 89 4d 28          	mov    %r9,0x28(%rbp)
   1400115e8:	48 8d 45 28          	lea    0x28(%rbp),%rax
   1400115ec:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   1400115f0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   1400115f4:	4c 8b 45 20          	mov    0x20(%rbp),%r8
   1400115f8:	48 8b 4d 18          	mov    0x18(%rbp),%rcx
   1400115fc:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140011600:	48 89 54 24 28       	mov    %rdx,0x28(%rsp)
   140011605:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   14001160c:	00 00 
   14001160e:	4d 89 c1             	mov    %r8,%r9
   140011611:	49 89 c8             	mov    %rcx,%r8
   140011614:	48 89 c2             	mov    %rax,%rdx
   140011617:	b9 02 00 00 00       	mov    $0x2,%ecx
   14001161c:	e8 87 03 00 00       	call   1400119a8 <__stdio_common_vsprintf>
   140011621:	89 45 fc             	mov    %eax,-0x4(%rbp)
   140011624:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140011627:	48 83 c4 40          	add    $0x40,%rsp
   14001162b:	5d                   	pop    %rbp
   14001162c:	c3                   	ret
   14001162d:	90                   	nop
   14001162e:	90                   	nop
   14001162f:	90                   	nop

0000000140011630 <printf>:
   140011630:	55                   	push   %rbp
   140011631:	53                   	push   %rbx
   140011632:	48 83 ec 48          	sub    $0x48,%rsp
   140011636:	48 8d 6c 24 40       	lea    0x40(%rsp),%rbp
   14001163b:	48 89 4d 20          	mov    %rcx,0x20(%rbp)
   14001163f:	48 89 55 28          	mov    %rdx,0x28(%rbp)
   140011643:	4c 89 45 30          	mov    %r8,0x30(%rbp)
   140011647:	4c 89 4d 38          	mov    %r9,0x38(%rbp)
   14001164b:	48 8d 45 28          	lea    0x28(%rbp),%rax
   14001164f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140011653:	48 8b 5d f0          	mov    -0x10(%rbp),%rbx
   140011657:	b9 01 00 00 00       	mov    $0x1,%ecx
   14001165c:	e8 e7 02 00 00       	call   140011948 <__acrt_iob_func>
   140011661:	48 8b 55 20          	mov    0x20(%rbp),%rdx
   140011665:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
   14001166a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   140011670:	49 89 d0             	mov    %rdx,%r8
   140011673:	48 89 c2             	mov    %rax,%rdx
   140011676:	b9 00 00 00 00       	mov    $0x0,%ecx
   14001167b:	e8 18 03 00 00       	call   140011998 <__stdio_common_vfprintf>
   140011680:	89 45 fc             	mov    %eax,-0x4(%rbp)
   140011683:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140011686:	48 83 c4 48          	add    $0x48,%rsp
   14001168a:	5b                   	pop    %rbx
   14001168b:	5d                   	pop    %rbp
   14001168c:	c3                   	ret
   14001168d:	90                   	nop
   14001168e:	90                   	nop
   14001168f:	90                   	nop

0000000140011690 <fprintf>:
   140011690:	55                   	push   %rbp
   140011691:	48 89 e5             	mov    %rsp,%rbp
   140011694:	48 83 ec 40          	sub    $0x40,%rsp
   140011698:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14001169c:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400116a0:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   1400116a4:	4c 89 4d 28          	mov    %r9,0x28(%rbp)
   1400116a8:	48 8d 45 20          	lea    0x20(%rbp),%rax
   1400116ac:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   1400116b0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   1400116b4:	48 8b 4d 18          	mov    0x18(%rbp),%rcx
   1400116b8:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400116bc:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   1400116c1:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   1400116c7:	49 89 c8             	mov    %rcx,%r8
   1400116ca:	48 89 c2             	mov    %rax,%rdx
   1400116cd:	b9 00 00 00 00       	mov    $0x0,%ecx
   1400116d2:	e8 c1 02 00 00       	call   140011998 <__stdio_common_vfprintf>
   1400116d7:	89 45 fc             	mov    %eax,-0x4(%rbp)
   1400116da:	8b 45 fc             	mov    -0x4(%rbp),%eax
   1400116dd:	48 83 c4 40          	add    $0x40,%rsp
   1400116e1:	5d                   	pop    %rbp
   1400116e2:	c3                   	ret
   1400116e3:	90                   	nop
   1400116e4:	90                   	nop
   1400116e5:	90                   	nop
   1400116e6:	90                   	nop
   1400116e7:	90                   	nop
   1400116e8:	90                   	nop
   1400116e9:	90                   	nop
   1400116ea:	90                   	nop
   1400116eb:	90                   	nop
   1400116ec:	90                   	nop
   1400116ed:	90                   	nop
   1400116ee:	90                   	nop
   1400116ef:	90                   	nop

00000001400116f0 <__getmainargs>:
   1400116f0:	55                   	push   %rbp
   1400116f1:	48 89 e5             	mov    %rsp,%rbp
   1400116f4:	48 83 ec 20          	sub    $0x20,%rsp
   1400116f8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400116fc:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140011700:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140011704:	44 89 4d 28          	mov    %r9d,0x28(%rbp)
   140011708:	e8 eb 02 00 00       	call   1400119f8 <_initialize_narrow_environment>
   14001170d:	83 7d 28 00          	cmpl   $0x0,0x28(%rbp)
   140011711:	74 07                	je     14001171a <__getmainargs+0x2a>
   140011713:	b8 02 00 00 00       	mov    $0x2,%eax
   140011718:	eb 05                	jmp    14001171f <__getmainargs+0x2f>
   14001171a:	b8 01 00 00 00       	mov    $0x1,%eax
   14001171f:	89 c1                	mov    %eax,%ecx
   140011721:	e8 aa 02 00 00       	call   1400119d0 <_configure_narrow_argv>
   140011726:	e8 2d 02 00 00       	call   140011958 <__p___argc>
   14001172b:	8b 10                	mov    (%rax),%edx
   14001172d:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140011731:	89 10                	mov    %edx,(%rax)
   140011733:	e8 28 02 00 00       	call   140011960 <__p___argv>
   140011738:	48 8b 10             	mov    (%rax),%rdx
   14001173b:	48 8b 45 18          	mov    0x18(%rbp),%rax
   14001173f:	48 89 10             	mov    %rdx,(%rax)
   140011742:	e8 31 02 00 00       	call   140011978 <__p__environ>
   140011747:	48 8b 10             	mov    (%rax),%rdx
   14001174a:	48 8b 45 20          	mov    0x20(%rbp),%rax
   14001174e:	48 89 10             	mov    %rdx,(%rax)
   140011751:	48 83 7d 30 00       	cmpq   $0x0,0x30(%rbp)
   140011756:	74 0d                	je     140011765 <__getmainargs+0x75>
   140011758:	48 8b 45 30          	mov    0x30(%rbp),%rax
   14001175c:	8b 00                	mov    (%rax),%eax
   14001175e:	89 c1                	mov    %eax,%ecx
   140011760:	e8 bb 02 00 00       	call   140011a20 <_set_new_mode>
   140011765:	b8 00 00 00 00       	mov    $0x0,%eax
   14001176a:	48 83 c4 20          	add    $0x20,%rsp
   14001176e:	5d                   	pop    %rbp
   14001176f:	c3                   	ret

0000000140011770 <__wgetmainargs>:
   140011770:	55                   	push   %rbp
   140011771:	48 89 e5             	mov    %rsp,%rbp
   140011774:	48 83 ec 20          	sub    $0x20,%rsp
   140011778:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   14001177c:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   140011780:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   140011784:	44 89 4d 28          	mov    %r9d,0x28(%rbp)
   140011788:	e8 73 02 00 00       	call   140011a00 <_initialize_wide_environment>
   14001178d:	83 7d 28 00          	cmpl   $0x0,0x28(%rbp)
   140011791:	74 07                	je     14001179a <__wgetmainargs+0x2a>
   140011793:	b8 02 00 00 00       	mov    $0x2,%eax
   140011798:	eb 05                	jmp    14001179f <__wgetmainargs+0x2f>
   14001179a:	b8 01 00 00 00       	mov    $0x1,%eax
   14001179f:	89 c1                	mov    %eax,%ecx
   1400117a1:	e8 32 02 00 00       	call   1400119d8 <_configure_wide_argv>
   1400117a6:	e8 ad 01 00 00       	call   140011958 <__p___argc>
   1400117ab:	8b 10                	mov    (%rax),%edx
   1400117ad:	48 8b 45 10          	mov    0x10(%rbp),%rax
   1400117b1:	89 10                	mov    %edx,(%rax)
   1400117b3:	e8 b0 01 00 00       	call   140011968 <__p___wargv>
   1400117b8:	48 8b 10             	mov    (%rax),%rdx
   1400117bb:	48 8b 45 18          	mov    0x18(%rbp),%rax
   1400117bf:	48 89 10             	mov    %rdx,(%rax)
   1400117c2:	e8 c1 01 00 00       	call   140011988 <__p__wenviron>
   1400117c7:	48 8b 10             	mov    (%rax),%rdx
   1400117ca:	48 8b 45 20          	mov    0x20(%rbp),%rax
   1400117ce:	48 89 10             	mov    %rdx,(%rax)
   1400117d1:	48 83 7d 30 00       	cmpq   $0x0,0x30(%rbp)
   1400117d6:	74 0d                	je     1400117e5 <__wgetmainargs+0x75>
   1400117d8:	48 8b 45 30          	mov    0x30(%rbp),%rax
   1400117dc:	8b 00                	mov    (%rax),%eax
   1400117de:	89 c1                	mov    %eax,%ecx
   1400117e0:	e8 3b 02 00 00       	call   140011a20 <_set_new_mode>
   1400117e5:	b8 00 00 00 00       	mov    $0x0,%eax
   1400117ea:	48 83 c4 20          	add    $0x20,%rsp
   1400117ee:	5d                   	pop    %rbp
   1400117ef:	c3                   	ret

00000001400117f0 <_onexit>:
   1400117f0:	55                   	push   %rbp
   1400117f1:	48 89 e5             	mov    %rsp,%rbp
   1400117f4:	48 83 ec 20          	sub    $0x20,%rsp
   1400117f8:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400117fc:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140011800:	48 89 c1             	mov    %rax,%rcx
   140011803:	e8 e0 01 00 00       	call   1400119e8 <_crt_atexit>
   140011808:	85 c0                	test   %eax,%eax
   14001180a:	75 06                	jne    140011812 <_onexit+0x22>
   14001180c:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140011810:	eb 05                	jmp    140011817 <_onexit+0x27>
   140011812:	b8 00 00 00 00       	mov    $0x0,%eax
   140011817:	48 83 c4 20          	add    $0x20,%rsp
   14001181b:	5d                   	pop    %rbp
   14001181c:	c3                   	ret

000000014001181d <at_quick_exit>:
   14001181d:	55                   	push   %rbp
   14001181e:	48 89 e5             	mov    %rsp,%rbp
   140011821:	48 83 ec 20          	sub    $0x20,%rsp
   140011825:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   140011829:	48 8b 05 00 47 00 00 	mov    0x4700(%rip),%rax        # 140015f30 <.refptr.__mingw_module_is_dll>
   140011830:	0f b6 00             	movzbl (%rax),%eax
   140011833:	84 c0                	test   %al,%al
   140011835:	74 07                	je     14001183e <at_quick_exit+0x21>
   140011837:	b8 00 00 00 00       	mov    $0x0,%eax
   14001183c:	eb 0c                	jmp    14001184a <at_quick_exit+0x2d>
   14001183e:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140011842:	48 89 c1             	mov    %rax,%rcx
   140011845:	e8 96 01 00 00       	call   1400119e0 <_crt_at_quick_exit>
   14001184a:	48 83 c4 20          	add    $0x20,%rsp
   14001184e:	5d                   	pop    %rbp
   14001184f:	c3                   	ret

0000000140011850 <_amsg_exit>:
   140011850:	55                   	push   %rbp
   140011851:	48 89 e5             	mov    %rsp,%rbp
   140011854:	48 83 ec 20          	sub    $0x20,%rsp
   140011858:	89 4d 10             	mov    %ecx,0x10(%rbp)
   14001185b:	b9 02 00 00 00       	mov    $0x2,%ecx
   140011860:	e8 e3 00 00 00       	call   140011948 <__acrt_iob_func>
   140011865:	48 89 c1             	mov    %rax,%rcx
   140011868:	8b 45 10             	mov    0x10(%rbp),%eax
   14001186b:	41 89 c0             	mov    %eax,%r8d
   14001186e:	48 8d 05 bb 45 00 00 	lea    0x45bb(%rip),%rax        # 140015e30 <.rdata>
   140011875:	48 89 c2             	mov    %rax,%rdx
   140011878:	e8 13 fe ff ff       	call   140011690 <fprintf>
   14001187d:	b9 ff 00 00 00       	mov    $0xff,%ecx
   140011882:	e8 69 01 00 00       	call   1400119f0 <_exit>
   140011887:	90                   	nop

0000000140011888 <_get_output_format>:
   140011888:	55                   	push   %rbp
   140011889:	48 89 e5             	mov    %rsp,%rbp
   14001188c:	b8 00 00 00 00       	mov    $0x0,%eax
   140011891:	5d                   	pop    %rbp
   140011892:	c3                   	ret

0000000140011893 <_tzset>:
   140011893:	55                   	push   %rbp
   140011894:	48 89 e5             	mov    %rsp,%rbp
   140011897:	48 83 ec 20          	sub    $0x20,%rsp
   14001189b:	48 8b 05 3e 46 00 00 	mov    0x463e(%rip),%rax        # 140015ee0 <.refptr.__imp__tzset>
   1400118a2:	48 8b 00             	mov    (%rax),%rax
   1400118a5:	ff d0                	call   *%rax
   1400118a7:	e8 0c 01 00 00       	call   1400119b8 <__tzname>
   1400118ac:	48 89 05 45 08 00 00 	mov    %rax,0x845(%rip)        # 1400120f8 <__imp_tzname>
   1400118b3:	e8 f8 00 00 00       	call   1400119b0 <__timezone>
   1400118b8:	48 89 05 41 08 00 00 	mov    %rax,0x841(%rip)        # 140012100 <__imp_timezone>
   1400118bf:	e8 8c 00 00 00       	call   140011950 <__daylight>
   1400118c4:	48 89 05 3d 08 00 00 	mov    %rax,0x83d(%rip)        # 140012108 <__imp_daylight>
   1400118cb:	90                   	nop
   1400118cc:	48 83 c4 20          	add    $0x20,%rsp
   1400118d0:	5d                   	pop    %rbp
   1400118d1:	c3                   	ret

00000001400118d2 <tzset>:
   1400118d2:	55                   	push   %rbp
   1400118d3:	48 89 e5             	mov    %rsp,%rbp
   1400118d6:	48 83 ec 20          	sub    $0x20,%rsp
   1400118da:	e8 b4 ff ff ff       	call   140011893 <_tzset>
   1400118df:	90                   	nop
   1400118e0:	48 83 c4 20          	add    $0x20,%rsp
   1400118e4:	5d                   	pop    %rbp
   1400118e5:	c3                   	ret

00000001400118e6 <__ms_fwprintf>:
   1400118e6:	55                   	push   %rbp
   1400118e7:	48 89 e5             	mov    %rsp,%rbp
   1400118ea:	48 83 ec 40          	sub    $0x40,%rsp
   1400118ee:	48 89 4d 10          	mov    %rcx,0x10(%rbp)
   1400118f2:	48 89 55 18          	mov    %rdx,0x18(%rbp)
   1400118f6:	4c 89 45 20          	mov    %r8,0x20(%rbp)
   1400118fa:	4c 89 4d 28          	mov    %r9,0x28(%rbp)
   1400118fe:	48 8d 45 20          	lea    0x20(%rbp),%rax
   140011902:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   140011906:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   14001190a:	48 8b 4d 18          	mov    0x18(%rbp),%rcx
   14001190e:	48 8b 45 10          	mov    0x10(%rbp),%rax
   140011912:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
   140011917:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   14001191d:	49 89 c8             	mov    %rcx,%r8
   140011920:	48 89 c2             	mov    %rax,%rdx
   140011923:	b9 04 00 00 00       	mov    $0x4,%ecx
   140011928:	e8 73 00 00 00       	call   1400119a0 <__stdio_common_vfwprintf>
   14001192d:	89 45 fc             	mov    %eax,-0x4(%rbp)
   140011930:	8b 45 fc             	mov    -0x4(%rbp),%eax
   140011933:	48 83 c4 40          	add    $0x40,%rsp
   140011937:	5d                   	pop    %rbp
   140011938:	c3                   	ret
   140011939:	90                   	nop
   14001193a:	90                   	nop
   14001193b:	90                   	nop
   14001193c:	90                   	nop
   14001193d:	90                   	nop
   14001193e:	90                   	nop
   14001193f:	90                   	nop

0000000140011940 <__C_specific_handler>:
   140011940:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b2c0 <__imp___C_specific_handler>
   140011946:	90                   	nop
   140011947:	90                   	nop

0000000140011948 <__acrt_iob_func>:
   140011948:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b2c8 <__imp___acrt_iob_func>
   14001194e:	90                   	nop
   14001194f:	90                   	nop

0000000140011950 <__daylight>:
   140011950:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b2d0 <__imp___daylight>
   140011956:	90                   	nop
   140011957:	90                   	nop

0000000140011958 <__p___argc>:
   140011958:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b2d8 <__imp___p___argc>
   14001195e:	90                   	nop
   14001195f:	90                   	nop

0000000140011960 <__p___argv>:
   140011960:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b2e0 <__imp___p___argv>
   140011966:	90                   	nop
   140011967:	90                   	nop

0000000140011968 <__p___wargv>:
   140011968:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b2e8 <__imp___p___wargv>
   14001196e:	90                   	nop
   14001196f:	90                   	nop

0000000140011970 <__p__commode>:
   140011970:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b2f0 <__imp___p__commode>
   140011976:	90                   	nop
   140011977:	90                   	nop

0000000140011978 <__p__environ>:
   140011978:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b2f8 <__imp___p__environ>
   14001197e:	90                   	nop
   14001197f:	90                   	nop

0000000140011980 <__p__fmode>:
   140011980:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b300 <__imp___p__fmode>
   140011986:	90                   	nop
   140011987:	90                   	nop

0000000140011988 <__p__wenviron>:
   140011988:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b308 <__imp___p__wenviron>
   14001198e:	90                   	nop
   14001198f:	90                   	nop

0000000140011990 <__setusermatherr>:
   140011990:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b310 <__imp___setusermatherr>
   140011996:	90                   	nop
   140011997:	90                   	nop

0000000140011998 <__stdio_common_vfprintf>:
   140011998:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b318 <__imp___stdio_common_vfprintf>
   14001199e:	90                   	nop
   14001199f:	90                   	nop

00000001400119a0 <__stdio_common_vfwprintf>:
   1400119a0:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b320 <__imp___stdio_common_vfwprintf>
   1400119a6:	90                   	nop
   1400119a7:	90                   	nop

00000001400119a8 <__stdio_common_vsprintf>:
   1400119a8:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b328 <__imp___stdio_common_vsprintf>
   1400119ae:	90                   	nop
   1400119af:	90                   	nop

00000001400119b0 <__timezone>:
   1400119b0:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b330 <__imp___timezone>
   1400119b6:	90                   	nop
   1400119b7:	90                   	nop

00000001400119b8 <__tzname>:
   1400119b8:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b338 <__imp___tzname>
   1400119be:	90                   	nop
   1400119bf:	90                   	nop

00000001400119c0 <_assert>:
   1400119c0:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b340 <__imp__assert>
   1400119c6:	90                   	nop
   1400119c7:	90                   	nop

00000001400119c8 <_cexit>:
   1400119c8:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b348 <__imp__cexit>
   1400119ce:	90                   	nop
   1400119cf:	90                   	nop

00000001400119d0 <_configure_narrow_argv>:
   1400119d0:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b350 <__imp__configure_narrow_argv>
   1400119d6:	90                   	nop
   1400119d7:	90                   	nop

00000001400119d8 <_configure_wide_argv>:
   1400119d8:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b358 <__imp__configure_wide_argv>
   1400119de:	90                   	nop
   1400119df:	90                   	nop

00000001400119e0 <_crt_at_quick_exit>:
   1400119e0:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b360 <__imp__crt_at_quick_exit>
   1400119e6:	90                   	nop
   1400119e7:	90                   	nop

00000001400119e8 <_crt_atexit>:
   1400119e8:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b368 <__imp__crt_atexit>
   1400119ee:	90                   	nop
   1400119ef:	90                   	nop

00000001400119f0 <_exit>:
   1400119f0:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b370 <__imp__exit>
   1400119f6:	90                   	nop
   1400119f7:	90                   	nop

00000001400119f8 <_initialize_narrow_environment>:
   1400119f8:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b378 <__imp__initialize_narrow_environment>
   1400119fe:	90                   	nop
   1400119ff:	90                   	nop

0000000140011a00 <_initialize_wide_environment>:
   140011a00:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b380 <__imp__initialize_wide_environment>
   140011a06:	90                   	nop
   140011a07:	90                   	nop

0000000140011a08 <_initterm>:
   140011a08:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b388 <__imp__initterm>
   140011a0e:	90                   	nop
   140011a0f:	90                   	nop

0000000140011a10 <__set_app_type>:
   140011a10:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b390 <__imp___set_app_type>
   140011a16:	90                   	nop
   140011a17:	90                   	nop

0000000140011a18 <_set_invalid_parameter_handler>:
   140011a18:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b398 <__imp__set_invalid_parameter_handler>
   140011a1e:	90                   	nop
   140011a1f:	90                   	nop

0000000140011a20 <_set_new_mode>:
   140011a20:	ff 25 7a 99 00 00    	jmp    *0x997a(%rip)        # 14001b3a0 <__imp__set_new_mode>
   140011a26:	90                   	nop
   140011a27:	90                   	nop

0000000140011a28 <abort>:
   140011a28:	ff 25 82 99 00 00    	jmp    *0x9982(%rip)        # 14001b3b0 <__imp_abort>
   140011a2e:	90                   	nop
   140011a2f:	90                   	nop

0000000140011a30 <calloc>:
   140011a30:	ff 25 82 99 00 00    	jmp    *0x9982(%rip)        # 14001b3b8 <__imp_calloc>
   140011a36:	90                   	nop
   140011a37:	90                   	nop

0000000140011a38 <exit>:
   140011a38:	ff 25 82 99 00 00    	jmp    *0x9982(%rip)        # 14001b3c0 <__imp_exit>
   140011a3e:	90                   	nop
   140011a3f:	90                   	nop

0000000140011a40 <fclose>:
   140011a40:	ff 25 82 99 00 00    	jmp    *0x9982(%rip)        # 14001b3c8 <__imp_fclose>
   140011a46:	90                   	nop
   140011a47:	90                   	nop

0000000140011a48 <fopen>:
   140011a48:	ff 25 82 99 00 00    	jmp    *0x9982(%rip)        # 14001b3d0 <__imp_fopen>
   140011a4e:	90                   	nop
   140011a4f:	90                   	nop

0000000140011a50 <fputc>:
   140011a50:	ff 25 82 99 00 00    	jmp    *0x9982(%rip)        # 14001b3d8 <__imp_fputc>
   140011a56:	90                   	nop
   140011a57:	90                   	nop

0000000140011a58 <fputs>:
   140011a58:	ff 25 82 99 00 00    	jmp    *0x9982(%rip)        # 14001b3e0 <__imp_fputs>
   140011a5e:	90                   	nop
   140011a5f:	90                   	nop

0000000140011a60 <free>:
   140011a60:	ff 25 82 99 00 00    	jmp    *0x9982(%rip)        # 14001b3e8 <__imp_free>
   140011a66:	90                   	nop
   140011a67:	90                   	nop

0000000140011a68 <fwrite>:
   140011a68:	ff 25 82 99 00 00    	jmp    *0x9982(%rip)        # 14001b3f0 <__imp_fwrite>
   140011a6e:	90                   	nop
   140011a6f:	90                   	nop

0000000140011a70 <malloc>:
   140011a70:	ff 25 82 99 00 00    	jmp    *0x9982(%rip)        # 14001b3f8 <__imp_malloc>
   140011a76:	90                   	nop
   140011a77:	90                   	nop

0000000140011a78 <memcpy>:
   140011a78:	ff 25 82 99 00 00    	jmp    *0x9982(%rip)        # 14001b400 <__imp_memcpy>
   140011a7e:	90                   	nop
   140011a7f:	90                   	nop

0000000140011a80 <memmove>:
   140011a80:	ff 25 82 99 00 00    	jmp    *0x9982(%rip)        # 14001b408 <__imp_memmove>
   140011a86:	90                   	nop
   140011a87:	90                   	nop

0000000140011a88 <memset>:
   140011a88:	ff 25 82 99 00 00    	jmp    *0x9982(%rip)        # 14001b410 <__imp_memset>
   140011a8e:	90                   	nop
   140011a8f:	90                   	nop

0000000140011a90 <putchar>:
   140011a90:	ff 25 82 99 00 00    	jmp    *0x9982(%rip)        # 14001b418 <__imp_putchar>
   140011a96:	90                   	nop
   140011a97:	90                   	nop

0000000140011a98 <realloc>:
   140011a98:	ff 25 82 99 00 00    	jmp    *0x9982(%rip)        # 14001b420 <__imp_realloc>
   140011a9e:	90                   	nop
   140011a9f:	90                   	nop

0000000140011aa0 <signal>:
   140011aa0:	ff 25 82 99 00 00    	jmp    *0x9982(%rip)        # 14001b428 <__imp_signal>
   140011aa6:	90                   	nop
   140011aa7:	90                   	nop

0000000140011aa8 <strcmp>:
   140011aa8:	ff 25 82 99 00 00    	jmp    *0x9982(%rip)        # 14001b430 <__imp_strcmp>
   140011aae:	90                   	nop
   140011aaf:	90                   	nop

0000000140011ab0 <strlen>:
   140011ab0:	ff 25 82 99 00 00    	jmp    *0x9982(%rip)        # 14001b438 <__imp_strlen>
   140011ab6:	90                   	nop
   140011ab7:	90                   	nop

0000000140011ab8 <strncmp>:
   140011ab8:	ff 25 82 99 00 00    	jmp    *0x9982(%rip)        # 14001b440 <__imp_strncmp>
   140011abe:	90                   	nop
   140011abf:	90                   	nop

0000000140011ac0 <VirtualQuery>:
   140011ac0:	ff 25 ea 97 00 00    	jmp    *0x97ea(%rip)        # 14001b2b0 <__imp_VirtualQuery>
   140011ac6:	90                   	nop
   140011ac7:	90                   	nop

0000000140011ac8 <VirtualProtect>:
   140011ac8:	ff 25 da 97 00 00    	jmp    *0x97da(%rip)        # 14001b2a8 <__imp_VirtualProtect>
   140011ace:	90                   	nop
   140011acf:	90                   	nop

0000000140011ad0 <TlsGetValue>:
   140011ad0:	ff 25 ca 97 00 00    	jmp    *0x97ca(%rip)        # 14001b2a0 <__imp_TlsGetValue>
   140011ad6:	90                   	nop
   140011ad7:	90                   	nop

0000000140011ad8 <Sleep>:
   140011ad8:	ff 25 ba 97 00 00    	jmp    *0x97ba(%rip)        # 14001b298 <__imp_Sleep>
   140011ade:	90                   	nop
   140011adf:	90                   	nop

0000000140011ae0 <SetUnhandledExceptionFilter>:
   140011ae0:	ff 25 aa 97 00 00    	jmp    *0x97aa(%rip)        # 14001b290 <__imp_SetUnhandledExceptionFilter>
   140011ae6:	90                   	nop
   140011ae7:	90                   	nop

0000000140011ae8 <LoadLibraryA>:
   140011ae8:	ff 25 9a 97 00 00    	jmp    *0x979a(%rip)        # 14001b288 <__imp_LoadLibraryA>
   140011aee:	90                   	nop
   140011aef:	90                   	nop

0000000140011af0 <LeaveCriticalSection>:
   140011af0:	ff 25 8a 97 00 00    	jmp    *0x978a(%rip)        # 14001b280 <__imp_LeaveCriticalSection>
   140011af6:	90                   	nop
   140011af7:	90                   	nop

0000000140011af8 <InitializeCriticalSection>:
   140011af8:	ff 25 7a 97 00 00    	jmp    *0x977a(%rip)        # 14001b278 <__imp_InitializeCriticalSection>
   140011afe:	90                   	nop
   140011aff:	90                   	nop

0000000140011b00 <GetProcAddress>:
   140011b00:	ff 25 6a 97 00 00    	jmp    *0x976a(%rip)        # 14001b270 <__imp_GetProcAddress>
   140011b06:	90                   	nop
   140011b07:	90                   	nop

0000000140011b08 <GetModuleHandleA>:
   140011b08:	ff 25 5a 97 00 00    	jmp    *0x975a(%rip)        # 14001b268 <__imp_GetModuleHandleA>
   140011b0e:	90                   	nop
   140011b0f:	90                   	nop

0000000140011b10 <GetLastError>:
   140011b10:	ff 25 4a 97 00 00    	jmp    *0x974a(%rip)        # 14001b260 <__imp_GetLastError>
   140011b16:	90                   	nop
   140011b17:	90                   	nop

0000000140011b18 <FreeLibrary>:
   140011b18:	ff 25 3a 97 00 00    	jmp    *0x973a(%rip)        # 14001b258 <__imp_FreeLibrary>
   140011b1e:	90                   	nop
   140011b1f:	90                   	nop

0000000140011b20 <EnterCriticalSection>:
   140011b20:	ff 25 2a 97 00 00    	jmp    *0x972a(%rip)        # 14001b250 <__imp_EnterCriticalSection>
   140011b26:	90                   	nop
   140011b27:	90                   	nop

0000000140011b28 <DeleteCriticalSection>:
   140011b28:	ff 25 1a 97 00 00    	jmp    *0x971a(%rip)        # 14001b248 <__IAT_start__>
   140011b2e:	90                   	nop
   140011b2f:	90                   	nop

0000000140011b30 <register_frame_ctor>:
   140011b30:	e9 ab fa fe ff       	jmp    1400015e0 <__gcc_register_frame>
   140011b35:	90                   	nop
   140011b36:	90                   	nop
   140011b37:	90                   	nop
   140011b38:	90                   	nop
   140011b39:	90                   	nop
   140011b3a:	90                   	nop
   140011b3b:	90                   	nop
   140011b3c:	90                   	nop
   140011b3d:	90                   	nop
   140011b3e:	90                   	nop
   140011b3f:	90                   	nop

0000000140011b40 <__CTOR_LIST__>:
   140011b40:	ff                   	(bad)
   140011b41:	ff                   	(bad)
   140011b42:	ff                   	(bad)
   140011b43:	ff                   	(bad)
   140011b44:	ff                   	(bad)
   140011b45:	ff                   	(bad)
   140011b46:	ff                   	(bad)
   140011b47:	ff                   	.byte 0xff

0000000140011b48 <.ctors.65535>:
   140011b48:	30 1b                	xor    %bl,(%rbx)
   140011b4a:	01 40 01             	add    %eax,0x1(%rax)
	...

0000000140011b58 <__DTOR_LIST__>:
   140011b58:	ff                   	(bad)
   140011b59:	ff                   	(bad)
   140011b5a:	ff                   	(bad)
   140011b5b:	ff                   	(bad)
   140011b5c:	ff                   	(bad)
   140011b5d:	ff                   	(bad)
   140011b5e:	ff                   	(bad)
   140011b5f:	ff 00                	incl   (%rax)
   140011b61:	00 00                	add    %al,(%rax)
   140011b63:	00 00                	add    %al,(%rax)
   140011b65:	00 00                	add    %al,(%rax)
	...
