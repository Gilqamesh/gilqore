
a.exe:     file format pei-i386


Disassembly of section .text:

00401000 <.text>:
  401000:	83 ec 1c             	sub    $0x1c,%esp
  401003:	8b 44 24 20          	mov    0x20(%esp),%eax
  401007:	8b 00                	mov    (%eax),%eax
  401009:	8b 00                	mov    (%eax),%eax
  40100b:	3d 91 00 00 c0       	cmp    $0xc0000091,%eax
  401010:	77 4e                	ja     401060 <.text+0x60>
  401012:	3d 8d 00 00 c0       	cmp    $0xc000008d,%eax
  401017:	73 60                	jae    401079 <.text+0x79>
  401019:	3d 05 00 00 c0       	cmp    $0xc0000005,%eax
  40101e:	0f 85 cc 00 00 00    	jne    4010f0 <.text+0xf0>
  401024:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  40102b:	00 
  40102c:	c7 04 24 0b 00 00 00 	movl   $0xb,(%esp)
  401033:	e8 a0 2a 00 00       	call   403ad8 <_signal>
  401038:	83 f8 01             	cmp    $0x1,%eax
  40103b:	0f 84 48 01 00 00    	je     401189 <.text+0x189>
  401041:	85 c0                	test   %eax,%eax
  401043:	0f 85 e7 00 00 00    	jne    401130 <.text+0x130>
  401049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  401050:	31 c0                	xor    %eax,%eax
  401052:	83 c4 1c             	add    $0x1c,%esp
  401055:	c2 04 00             	ret    $0x4
  401058:	90                   	nop
  401059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  401060:	3d 94 00 00 c0       	cmp    $0xc0000094,%eax
  401065:	74 49                	je     4010b0 <.text+0xb0>
  401067:	3d 96 00 00 c0       	cmp    $0xc0000096,%eax
  40106c:	0f 84 89 00 00 00    	je     4010fb <.text+0xfb>
  401072:	3d 93 00 00 c0       	cmp    $0xc0000093,%eax
  401077:	75 d7                	jne    401050 <.text+0x50>
  401079:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  401080:	00 
  401081:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  401088:	e8 4b 2a 00 00       	call   403ad8 <_signal>
  40108d:	83 f8 01             	cmp    $0x1,%eax
  401090:	0f 84 ad 00 00 00    	je     401143 <.text+0x143>
  401096:	85 c0                	test   %eax,%eax
  401098:	74 b6                	je     401050 <.text+0x50>
  40109a:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  4010a1:	ff d0                	call   *%eax
  4010a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  4010a8:	eb a8                	jmp    401052 <.text+0x52>
  4010aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  4010b0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  4010b7:	00 
  4010b8:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  4010bf:	e8 14 2a 00 00       	call   403ad8 <_signal>
  4010c4:	83 f8 01             	cmp    $0x1,%eax
  4010c7:	75 cd                	jne    401096 <.text+0x96>
  4010c9:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  4010d0:	00 
  4010d1:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  4010d8:	e8 fb 29 00 00       	call   403ad8 <_signal>
  4010dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  4010e2:	e9 6b ff ff ff       	jmp    401052 <.text+0x52>
  4010e7:	89 f6                	mov    %esi,%esi
  4010e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  4010f0:	3d 1d 00 00 c0       	cmp    $0xc000001d,%eax
  4010f5:	0f 85 55 ff ff ff    	jne    401050 <.text+0x50>
  4010fb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  401102:	00 
  401103:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  40110a:	e8 c9 29 00 00       	call   403ad8 <_signal>
  40110f:	83 f8 01             	cmp    $0x1,%eax
  401112:	74 59                	je     40116d <.text+0x16d>
  401114:	85 c0                	test   %eax,%eax
  401116:	0f 84 34 ff ff ff    	je     401050 <.text+0x50>
  40111c:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  401123:	ff d0                	call   *%eax
  401125:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  40112a:	e9 23 ff ff ff       	jmp    401052 <.text+0x52>
  40112f:	90                   	nop
  401130:	c7 04 24 0b 00 00 00 	movl   $0xb,(%esp)
  401137:	ff d0                	call   *%eax
  401139:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  40113e:	e9 0f ff ff ff       	jmp    401052 <.text+0x52>
  401143:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  40114a:	00 
  40114b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  401152:	e8 81 29 00 00       	call   403ad8 <_signal>
  401157:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  40115e:	e8 6d 0f 00 00       	call   4020d0 <_fesetenv>
  401163:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401168:	e9 e5 fe ff ff       	jmp    401052 <.text+0x52>
  40116d:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  401174:	00 
  401175:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  40117c:	e8 57 29 00 00       	call   403ad8 <_signal>
  401181:	83 c8 ff             	or     $0xffffffff,%eax
  401184:	e9 c9 fe ff ff       	jmp    401052 <.text+0x52>
  401189:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  401190:	00 
  401191:	c7 04 24 0b 00 00 00 	movl   $0xb,(%esp)
  401198:	e8 3b 29 00 00       	call   403ad8 <_signal>
  40119d:	83 c8 ff             	or     $0xffffffff,%eax
  4011a0:	e9 ad fe ff ff       	jmp    401052 <.text+0x52>
  4011a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  4011a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  4011b0:	55                   	push   %ebp
  4011b1:	89 e5                	mov    %esp,%ebp
  4011b3:	53                   	push   %ebx
  4011b4:	83 ec 14             	sub    $0x14,%esp
  4011b7:	a1 68 50 40 00       	mov    0x405068,%eax
  4011bc:	85 c0                	test   %eax,%eax
  4011be:	74 1c                	je     4011dc <.text+0x1dc>
  4011c0:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  4011c7:	00 
  4011c8:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  4011cf:	00 
  4011d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  4011d7:	ff d0                	call   *%eax
  4011d9:	83 ec 0c             	sub    $0xc,%esp
  4011dc:	c7 04 24 00 10 40 00 	movl   $0x401000,(%esp)
  4011e3:	e8 a0 29 00 00       	call   403b88 <_SetUnhandledExceptionFilter@4>
  4011e8:	83 ec 04             	sub    $0x4,%esp
  4011eb:	e8 d0 06 00 00       	call   4018c0 <___cpu_features_init>
  4011f0:	a1 24 41 40 00       	mov    0x404124,%eax
  4011f5:	89 04 24             	mov    %eax,(%esp)
  4011f8:	e8 d3 0e 00 00       	call   4020d0 <_fesetenv>
  4011fd:	e8 1e 03 00 00       	call   401520 <__setargv>
  401202:	a1 20 70 40 00       	mov    0x407020,%eax
  401207:	85 c0                	test   %eax,%eax
  401209:	74 42                	je     40124d <.text+0x24d>
  40120b:	8b 1d a4 81 40 00    	mov    0x4081a4,%ebx
  401211:	a3 28 41 40 00       	mov    %eax,0x404128
  401216:	89 44 24 04          	mov    %eax,0x4(%esp)
  40121a:	8b 43 10             	mov    0x10(%ebx),%eax
  40121d:	89 04 24             	mov    %eax,(%esp)
  401220:	e8 0b 29 00 00       	call   403b30 <__setmode>
  401225:	a1 20 70 40 00       	mov    0x407020,%eax
  40122a:	89 44 24 04          	mov    %eax,0x4(%esp)
  40122e:	8b 43 30             	mov    0x30(%ebx),%eax
  401231:	89 04 24             	mov    %eax,(%esp)
  401234:	e8 f7 28 00 00       	call   403b30 <__setmode>
  401239:	a1 20 70 40 00       	mov    0x407020,%eax
  40123e:	89 44 24 04          	mov    %eax,0x4(%esp)
  401242:	8b 43 50             	mov    0x50(%ebx),%eax
  401245:	89 04 24             	mov    %eax,(%esp)
  401248:	e8 e3 28 00 00       	call   403b30 <__setmode>
  40124d:	e8 06 29 00 00       	call   403b58 <___p__fmode>
  401252:	8b 15 28 41 40 00    	mov    0x404128,%edx
  401258:	89 10                	mov    %edx,(%eax)
  40125a:	e8 71 0c 00 00       	call   401ed0 <__pei386_runtime_relocator>
  40125f:	83 e4 f0             	and    $0xfffffff0,%esp
  401262:	e8 e9 07 00 00       	call   401a50 <___main>
  401267:	e8 f4 28 00 00       	call   403b60 <___p__environ>
  40126c:	8b 00                	mov    (%eax),%eax
  40126e:	89 44 24 08          	mov    %eax,0x8(%esp)
  401272:	a1 00 70 40 00       	mov    0x407000,%eax
  401277:	89 44 24 04          	mov    %eax,0x4(%esp)
  40127b:	a1 04 70 40 00       	mov    0x407004,%eax
  401280:	89 04 24             	mov    %eax,(%esp)
  401283:	e8 3f 02 00 00       	call   4014c7 <_main>
  401288:	89 c3                	mov    %eax,%ebx
  40128a:	e8 c1 28 00 00       	call   403b50 <__cexit>
  40128f:	89 1c 24             	mov    %ebx,(%esp)
  401292:	e8 51 29 00 00       	call   403be8 <_ExitProcess@4>
  401297:	89 f6                	mov    %esi,%esi
  401299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

004012a0 <__mingw32_init_mainargs>:
  4012a0:	83 ec 3c             	sub    $0x3c,%esp
  4012a3:	8d 44 24 2c          	lea    0x2c(%esp),%eax
  4012a7:	c7 44 24 04 00 70 40 	movl   $0x407000,0x4(%esp)
  4012ae:	00 
  4012af:	c7 04 24 04 70 40 00 	movl   $0x407004,(%esp)
  4012b6:	c7 44 24 2c 00 00 00 	movl   $0x0,0x2c(%esp)
  4012bd:	00 
  4012be:	89 44 24 10          	mov    %eax,0x10(%esp)
  4012c2:	a1 20 41 40 00       	mov    0x404120,%eax
  4012c7:	83 e0 01             	and    $0x1,%eax
  4012ca:	89 44 24 0c          	mov    %eax,0xc(%esp)
  4012ce:	8d 44 24 28          	lea    0x28(%esp),%eax
  4012d2:	89 44 24 08          	mov    %eax,0x8(%esp)
  4012d6:	e8 8d 28 00 00       	call   403b68 <___getmainargs>
  4012db:	83 c4 3c             	add    $0x3c,%esp
  4012de:	c3                   	ret    
  4012df:	90                   	nop

004012e0 <_mainCRTStartup>:
  4012e0:	83 ec 1c             	sub    $0x1c,%esp
  4012e3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  4012ea:	ff 15 90 81 40 00    	call   *0x408190
  4012f0:	e8 bb fe ff ff       	call   4011b0 <.text+0x1b0>
  4012f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  4012f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00401300 <_WinMainCRTStartup>:
  401300:	83 ec 1c             	sub    $0x1c,%esp
  401303:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  40130a:	ff 15 90 81 40 00    	call   *0x408190
  401310:	e8 9b fe ff ff       	call   4011b0 <.text+0x1b0>
  401315:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  401319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00401320 <_atexit>:
  401320:	ff 25 bc 81 40 00    	jmp    *0x4081bc
  401326:	8d 76 00             	lea    0x0(%esi),%esi
  401329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00401330 <__onexit>:
  401330:	ff 25 ac 81 40 00    	jmp    *0x4081ac
  401336:	90                   	nop
  401337:	90                   	nop
  401338:	90                   	nop
  401339:	90                   	nop
  40133a:	90                   	nop
  40133b:	90                   	nop
  40133c:	90                   	nop
  40133d:	90                   	nop
  40133e:	90                   	nop
  40133f:	90                   	nop

00401340 <___gcc_register_frame>:
  401340:	55                   	push   %ebp
  401341:	89 e5                	mov    %esp,%ebp
  401343:	56                   	push   %esi
  401344:	53                   	push   %ebx
  401345:	83 ec 10             	sub    $0x10,%esp
  401348:	c7 04 24 00 50 40 00 	movl   $0x405000,(%esp)
  40134f:	e8 5c 28 00 00       	call   403bb0 <_GetModuleHandleA@4>
  401354:	83 ec 04             	sub    $0x4,%esp
  401357:	85 c0                	test   %eax,%eax
  401359:	0f 84 b1 00 00 00    	je     401410 <___gcc_register_frame+0xd0>
  40135f:	c7 04 24 00 50 40 00 	movl   $0x405000,(%esp)
  401366:	89 c3                	mov    %eax,%ebx
  401368:	e8 23 28 00 00       	call   403b90 <_LoadLibraryA@4>
  40136d:	83 ec 04             	sub    $0x4,%esp
  401370:	a3 6c 70 40 00       	mov    %eax,0x40706c
  401375:	c7 44 24 04 13 50 40 	movl   $0x405013,0x4(%esp)
  40137c:	00 
  40137d:	89 1c 24             	mov    %ebx,(%esp)
  401380:	e8 23 28 00 00       	call   403ba8 <_GetProcAddress@8>
  401385:	83 ec 08             	sub    $0x8,%esp
  401388:	89 c6                	mov    %eax,%esi
  40138a:	c7 44 24 04 29 50 40 	movl   $0x405029,0x4(%esp)
  401391:	00 
  401392:	89 1c 24             	mov    %ebx,(%esp)
  401395:	e8 0e 28 00 00       	call   403ba8 <_GetProcAddress@8>
  40139a:	83 ec 08             	sub    $0x8,%esp
  40139d:	a3 00 40 40 00       	mov    %eax,0x404000
  4013a2:	85 f6                	test   %esi,%esi
  4013a4:	74 11                	je     4013b7 <___gcc_register_frame+0x77>
  4013a6:	c7 44 24 04 08 70 40 	movl   $0x407008,0x4(%esp)
  4013ad:	00 
  4013ae:	c7 04 24 b8 60 40 00 	movl   $0x4060b8,(%esp)
  4013b5:	ff d6                	call   *%esi
  4013b7:	a1 34 41 40 00       	mov    0x404134,%eax
  4013bc:	85 c0                	test   %eax,%eax
  4013be:	74 3a                	je     4013fa <___gcc_register_frame+0xba>
  4013c0:	c7 04 24 41 50 40 00 	movl   $0x405041,(%esp)
  4013c7:	e8 e4 27 00 00       	call   403bb0 <_GetModuleHandleA@4>
  4013cc:	83 ec 04             	sub    $0x4,%esp
  4013cf:	85 c0                	test   %eax,%eax
  4013d1:	ba 00 00 00 00       	mov    $0x0,%edx
  4013d6:	74 15                	je     4013ed <___gcc_register_frame+0xad>
  4013d8:	c7 44 24 04 4f 50 40 	movl   $0x40504f,0x4(%esp)
  4013df:	00 
  4013e0:	89 04 24             	mov    %eax,(%esp)
  4013e3:	e8 c0 27 00 00       	call   403ba8 <_GetProcAddress@8>
  4013e8:	83 ec 08             	sub    $0x8,%esp
  4013eb:	89 c2                	mov    %eax,%edx
  4013ed:	85 d2                	test   %edx,%edx
  4013ef:	74 09                	je     4013fa <___gcc_register_frame+0xba>
  4013f1:	c7 04 24 34 41 40 00 	movl   $0x404134,(%esp)
  4013f8:	ff d2                	call   *%edx
  4013fa:	c7 04 24 30 14 40 00 	movl   $0x401430,(%esp)
  401401:	e8 1a ff ff ff       	call   401320 <_atexit>
  401406:	8d 65 f8             	lea    -0x8(%ebp),%esp
  401409:	5b                   	pop    %ebx
  40140a:	5e                   	pop    %esi
  40140b:	5d                   	pop    %ebp
  40140c:	c3                   	ret    
  40140d:	8d 76 00             	lea    0x0(%esi),%esi
  401410:	c7 05 00 40 40 00 00 	movl   $0x0,0x404000
  401417:	00 00 00 
  40141a:	be 00 00 00 00       	mov    $0x0,%esi
  40141f:	eb 81                	jmp    4013a2 <___gcc_register_frame+0x62>
  401421:	eb 0d                	jmp    401430 <___gcc_deregister_frame>
  401423:	90                   	nop
  401424:	90                   	nop
  401425:	90                   	nop
  401426:	90                   	nop
  401427:	90                   	nop
  401428:	90                   	nop
  401429:	90                   	nop
  40142a:	90                   	nop
  40142b:	90                   	nop
  40142c:	90                   	nop
  40142d:	90                   	nop
  40142e:	90                   	nop
  40142f:	90                   	nop

00401430 <___gcc_deregister_frame>:
  401430:	55                   	push   %ebp
  401431:	89 e5                	mov    %esp,%ebp
  401433:	83 ec 18             	sub    $0x18,%esp
  401436:	a1 00 40 40 00       	mov    0x404000,%eax
  40143b:	85 c0                	test   %eax,%eax
  40143d:	74 09                	je     401448 <___gcc_deregister_frame+0x18>
  40143f:	c7 04 24 b8 60 40 00 	movl   $0x4060b8,(%esp)
  401446:	ff d0                	call   *%eax
  401448:	a1 6c 70 40 00       	mov    0x40706c,%eax
  40144d:	85 c0                	test   %eax,%eax
  40144f:	74 0b                	je     40145c <___gcc_deregister_frame+0x2c>
  401451:	89 04 24             	mov    %eax,(%esp)
  401454:	e8 6f 27 00 00       	call   403bc8 <_FreeLibrary@4>
  401459:	83 ec 04             	sub    $0x4,%esp
  40145c:	c9                   	leave  
  40145d:	c3                   	ret    
  40145e:	90                   	nop
  40145f:	90                   	nop

00401460 <_fun_fun>:
  401460:	55                   	push   %ebp
  401461:	89 e5                	mov    %esp,%ebp
  401463:	8b 45 08             	mov    0x8(%ebp),%eax
  401466:	d1 e8                	shr    %eax
  401468:	89 c2                	mov    %eax,%edx
  40146a:	8b 45 08             	mov    0x8(%ebp),%eax
  40146d:	09 d0                	or     %edx,%eax
  40146f:	89 45 08             	mov    %eax,0x8(%ebp)
  401472:	8b 45 08             	mov    0x8(%ebp),%eax
  401475:	c1 e8 02             	shr    $0x2,%eax
  401478:	89 c2                	mov    %eax,%edx
  40147a:	8b 45 08             	mov    0x8(%ebp),%eax
  40147d:	09 d0                	or     %edx,%eax
  40147f:	89 45 08             	mov    %eax,0x8(%ebp)
  401482:	8b 45 08             	mov    0x8(%ebp),%eax
  401485:	c1 e8 04             	shr    $0x4,%eax
  401488:	89 c2                	mov    %eax,%edx
  40148a:	8b 45 08             	mov    0x8(%ebp),%eax
  40148d:	09 d0                	or     %edx,%eax
  40148f:	89 45 08             	mov    %eax,0x8(%ebp)
  401492:	8b 45 08             	mov    0x8(%ebp),%eax
  401495:	c1 e8 08             	shr    $0x8,%eax
  401498:	89 c2                	mov    %eax,%edx
  40149a:	8b 45 08             	mov    0x8(%ebp),%eax
  40149d:	09 d0                	or     %edx,%eax
  40149f:	89 45 08             	mov    %eax,0x8(%ebp)
  4014a2:	8b 45 08             	mov    0x8(%ebp),%eax
  4014a5:	c1 e8 10             	shr    $0x10,%eax
  4014a8:	89 c2                	mov    %eax,%edx
  4014aa:	8b 45 08             	mov    0x8(%ebp),%eax
  4014ad:	09 d0                	or     %edx,%eax
  4014af:	89 45 08             	mov    %eax,0x8(%ebp)
  4014b2:	8b 45 08             	mov    0x8(%ebp),%eax
  4014b5:	69 c0 0d df ba 04    	imul   $0x4badf0d,%eax,%eax
  4014bb:	c1 e8 1a             	shr    $0x1a,%eax
  4014be:	8b 04 85 20 40 40 00 	mov    0x404020(,%eax,4),%eax
  4014c5:	5d                   	pop    %ebp
  4014c6:	c3                   	ret    

004014c7 <_main>:
  4014c7:	55                   	push   %ebp
  4014c8:	89 e5                	mov    %esp,%ebp
  4014ca:	83 e4 f0             	and    $0xfffffff0,%esp
  4014cd:	83 ec 20             	sub    $0x20,%esp
  4014d0:	e8 7b 05 00 00       	call   401a50 <___main>
  4014d5:	c7 44 24 1c 00 00 00 	movl   $0xff000000,0x1c(%esp)
  4014dc:	ff 
  4014dd:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  4014e4:	00 
  4014e5:	eb 29                	jmp    401510 <_main+0x49>
  4014e7:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  4014eb:	89 04 24             	mov    %eax,(%esp)
  4014ee:	e8 6d ff ff ff       	call   401460 <_fun_fun>
  4014f3:	89 44 24 04          	mov    %eax,0x4(%esp)
  4014f7:	c7 04 24 64 50 40 00 	movl   $0x405064,(%esp)
  4014fe:	e8 ed 25 00 00       	call   403af0 <_printf>
  401503:	81 44 24 1c 00 00 20 	addl   $0x200000,0x1c(%esp)
  40150a:	00 
  40150b:	83 44 24 18 01       	addl   $0x1,0x18(%esp)
  401510:	83 7c 24 18 13       	cmpl   $0x13,0x18(%esp)
  401515:	7e d0                	jle    4014e7 <_main+0x20>
  401517:	b8 00 00 00 00       	mov    $0x0,%eax
  40151c:	c9                   	leave  
  40151d:	c3                   	ret    
  40151e:	90                   	nop
  40151f:	90                   	nop

00401520 <__setargv>:
  401520:	55                   	push   %ebp
  401521:	89 e5                	mov    %esp,%ebp
  401523:	57                   	push   %edi
  401524:	56                   	push   %esi
  401525:	53                   	push   %ebx
  401526:	83 ec 4c             	sub    $0x4c,%esp
  401529:	f6 05 20 41 40 00 02 	testb  $0x2,0x404120
  401530:	0f 84 ea 02 00 00    	je     401820 <__setargv+0x300>
  401536:	e8 85 26 00 00       	call   403bc0 <_GetCommandLineA@0>
  40153b:	89 65 c4             	mov    %esp,-0x3c(%ebp)
  40153e:	89 04 24             	mov    %eax,(%esp)
  401541:	89 c6                	mov    %eax,%esi
  401543:	e8 80 25 00 00       	call   403ac8 <_strlen>
  401548:	8d 44 00 11          	lea    0x11(%eax,%eax,1),%eax
  40154c:	c1 e8 04             	shr    $0x4,%eax
  40154f:	c1 e0 04             	shl    $0x4,%eax
  401552:	e8 49 0b 00 00       	call   4020a0 <___chkstk_ms>
  401557:	29 c4                	sub    %eax,%esp
  401559:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  401560:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  401567:	8d 44 24 10          	lea    0x10(%esp),%eax
  40156b:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  401572:	89 c2                	mov    %eax,%edx
  401574:	89 45 cc             	mov    %eax,-0x34(%ebp)
  401577:	a1 20 41 40 00       	mov    0x404120,%eax
  40157c:	25 00 44 00 00       	and    $0x4400,%eax
  401581:	83 c8 10             	or     $0x10,%eax
  401584:	89 45 c8             	mov    %eax,-0x38(%ebp)
  401587:	31 c0                	xor    %eax,%eax
  401589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  401590:	83 c6 01             	add    $0x1,%esi
  401593:	0f be 4e ff          	movsbl -0x1(%esi),%ecx
  401597:	85 c9                	test   %ecx,%ecx
  401599:	89 cb                	mov    %ecx,%ebx
  40159b:	74 73                	je     401610 <__setargv+0xf0>
  40159d:	80 fb 3f             	cmp    $0x3f,%bl
  4015a0:	0f 84 8d 01 00 00    	je     401733 <__setargv+0x213>
  4015a6:	0f 8f b4 00 00 00    	jg     401660 <__setargv+0x140>
  4015ac:	80 fb 27             	cmp    $0x27,%bl
  4015af:	0f 84 b0 01 00 00    	je     401765 <__setargv+0x245>
  4015b5:	80 fb 2a             	cmp    $0x2a,%bl
  4015b8:	0f 84 75 01 00 00    	je     401733 <__setargv+0x213>
  4015be:	80 fb 22             	cmp    $0x22,%bl
  4015c1:	0f 85 09 01 00 00    	jne    4016d0 <__setargv+0x1b0>
  4015c7:	89 c1                	mov    %eax,%ecx
  4015c9:	d1 f9                	sar    %ecx
  4015cb:	0f 84 d9 02 00 00    	je     4018aa <__setargv+0x38a>
  4015d1:	01 d1                	add    %edx,%ecx
  4015d3:	83 c2 01             	add    $0x1,%edx
  4015d6:	c6 42 ff 5c          	movb   $0x5c,-0x1(%edx)
  4015da:	39 ca                	cmp    %ecx,%edx
  4015dc:	75 f5                	jne    4015d3 <__setargv+0xb3>
  4015de:	83 7d d4 27          	cmpl   $0x27,-0x2c(%ebp)
  4015e2:	0f 84 c9 01 00 00    	je     4017b1 <__setargv+0x291>
  4015e8:	a8 01                	test   $0x1,%al
  4015ea:	0f 85 c1 01 00 00    	jne    4017b1 <__setargv+0x291>
  4015f0:	83 c6 01             	add    $0x1,%esi
  4015f3:	89 ca                	mov    %ecx,%edx
  4015f5:	83 75 d4 22          	xorl   $0x22,-0x2c(%ebp)
  4015f9:	0f be 4e ff          	movsbl -0x1(%esi),%ecx
  4015fd:	31 c0                	xor    %eax,%eax
  4015ff:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
  401606:	85 c9                	test   %ecx,%ecx
  401608:	89 cb                	mov    %ecx,%ebx
  40160a:	75 91                	jne    40159d <__setargv+0x7d>
  40160c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  401610:	85 c0                	test   %eax,%eax
  401612:	0f 84 99 02 00 00    	je     4018b1 <__setargv+0x391>
  401618:	01 d0                	add    %edx,%eax
  40161a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  401620:	83 c2 01             	add    $0x1,%edx
  401623:	c6 42 ff 5c          	movb   $0x5c,-0x1(%edx)
  401627:	39 c2                	cmp    %eax,%edx
  401629:	75 f5                	jne    401620 <__setargv+0x100>
  40162b:	39 45 cc             	cmp    %eax,-0x34(%ebp)
  40162e:	0f 82 be 01 00 00    	jb     4017f2 <__setargv+0x2d2>
  401634:	8b 55 d0             	mov    -0x30(%ebp),%edx
  401637:	85 d2                	test   %edx,%edx
  401639:	0f 85 b3 01 00 00    	jne    4017f2 <__setargv+0x2d2>
  40163f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  401642:	a3 04 70 40 00       	mov    %eax,0x407004
  401647:	8b 45 e0             	mov    -0x20(%ebp),%eax
  40164a:	a3 00 70 40 00       	mov    %eax,0x407000
  40164f:	8b 65 c4             	mov    -0x3c(%ebp),%esp
  401652:	8d 65 f4             	lea    -0xc(%ebp),%esp
  401655:	5b                   	pop    %ebx
  401656:	5e                   	pop    %esi
  401657:	5f                   	pop    %edi
  401658:	5d                   	pop    %ebp
  401659:	c3                   	ret    
  40165a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  401660:	80 fb 5c             	cmp    $0x5c,%bl
  401663:	0f 84 ea 00 00 00    	je     401753 <__setargv+0x233>
  401669:	80 fb 7f             	cmp    $0x7f,%bl
  40166c:	0f 84 c1 00 00 00    	je     401733 <__setargv+0x213>
  401672:	80 fb 5b             	cmp    $0x5b,%bl
  401675:	75 59                	jne    4016d0 <__setargv+0x1b0>
  401677:	f6 05 20 41 40 00 20 	testb  $0x20,0x404120
  40167e:	0f 85 af 00 00 00    	jne    401733 <__setargv+0x213>
  401684:	85 c0                	test   %eax,%eax
  401686:	8d 78 ff             	lea    -0x1(%eax),%edi
  401689:	b9 01 00 00 00       	mov    $0x1,%ecx
  40168e:	74 32                	je     4016c2 <__setargv+0x1a2>
  401690:	8d 7c 3a 01          	lea    0x1(%edx,%edi,1),%edi
  401694:	89 d0                	mov    %edx,%eax
  401696:	8d 76 00             	lea    0x0(%esi),%esi
  401699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  4016a0:	83 c0 01             	add    $0x1,%eax
  4016a3:	c6 40 ff 5c          	movb   $0x5c,-0x1(%eax)
  4016a7:	39 f8                	cmp    %edi,%eax
  4016a9:	75 f5                	jne    4016a0 <__setargv+0x180>
  4016ab:	84 c9                	test   %cl,%cl
  4016ad:	75 11                	jne    4016c0 <__setargv+0x1a0>
  4016af:	8d 50 01             	lea    0x1(%eax),%edx
  4016b2:	88 18                	mov    %bl,(%eax)
  4016b4:	31 c0                	xor    %eax,%eax
  4016b6:	e9 d5 fe ff ff       	jmp    401590 <__setargv+0x70>
  4016bb:	90                   	nop
  4016bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  4016c0:	89 c2                	mov    %eax,%edx
  4016c2:	8d 42 01             	lea    0x1(%edx),%eax
  4016c5:	c6 02 7f             	movb   $0x7f,(%edx)
  4016c8:	eb e5                	jmp    4016af <__setargv+0x18f>
  4016ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  4016d0:	85 c0                	test   %eax,%eax
  4016d2:	8d 3c 02             	lea    (%edx,%eax,1),%edi
  4016d5:	0f 84 c8 01 00 00    	je     4018a3 <__setargv+0x383>
  4016db:	90                   	nop
  4016dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  4016e0:	83 c2 01             	add    $0x1,%edx
  4016e3:	c6 42 ff 5c          	movb   $0x5c,-0x1(%edx)
  4016e7:	39 fa                	cmp    %edi,%edx
  4016e9:	75 f5                	jne    4016e0 <__setargv+0x1c0>
  4016eb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  4016ee:	85 c0                	test   %eax,%eax
  4016f0:	75 35                	jne    401727 <__setargv+0x207>
  4016f2:	a1 84 81 40 00       	mov    0x408184,%eax
  4016f7:	83 38 01             	cmpl   $0x1,(%eax)
  4016fa:	0f 84 c5 00 00 00    	je     4017c5 <__setargv+0x2a5>
  401700:	c7 44 24 04 40 00 00 	movl   $0x40,0x4(%esp)
  401707:	00 
  401708:	89 0c 24             	mov    %ecx,(%esp)
  40170b:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  40170e:	e8 25 24 00 00       	call   403b38 <__isctype>
  401713:	85 c0                	test   %eax,%eax
  401715:	0f 85 bb 00 00 00    	jne    4017d6 <__setargv+0x2b6>
  40171b:	8b 4d c0             	mov    -0x40(%ebp),%ecx
  40171e:	83 f9 09             	cmp    $0x9,%ecx
  401721:	0f 84 af 00 00 00    	je     4017d6 <__setargv+0x2b6>
  401727:	8d 57 01             	lea    0x1(%edi),%edx
  40172a:	88 1f                	mov    %bl,(%edi)
  40172c:	31 c0                	xor    %eax,%eax
  40172e:	e9 5d fe ff ff       	jmp    401590 <__setargv+0x70>
  401733:	85 c0                	test   %eax,%eax
  401735:	8d 78 ff             	lea    -0x1(%eax),%edi
  401738:	0f 84 4e 01 00 00    	je     40188c <__setargv+0x36c>
  40173e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  401741:	83 f9 7f             	cmp    $0x7f,%ecx
  401744:	0f 94 c1             	sete   %cl
  401747:	85 c0                	test   %eax,%eax
  401749:	0f 95 c0             	setne  %al
  40174c:	09 c1                	or     %eax,%ecx
  40174e:	e9 3d ff ff ff       	jmp    401690 <__setargv+0x170>
  401753:	83 7d d4 27          	cmpl   $0x27,-0x2c(%ebp)
  401757:	0f 84 e4 00 00 00    	je     401841 <__setargv+0x321>
  40175d:	83 c0 01             	add    $0x1,%eax
  401760:	e9 2b fe ff ff       	jmp    401590 <__setargv+0x70>
  401765:	f6 05 20 41 40 00 10 	testb  $0x10,0x404120
  40176c:	0f 84 5e ff ff ff    	je     4016d0 <__setargv+0x1b0>
  401772:	89 c1                	mov    %eax,%ecx
  401774:	d1 f9                	sar    %ecx
  401776:	0f 84 3c 01 00 00    	je     4018b8 <__setargv+0x398>
  40177c:	01 d1                	add    %edx,%ecx
  40177e:	66 90                	xchg   %ax,%ax
  401780:	83 c2 01             	add    $0x1,%edx
  401783:	c6 42 ff 5c          	movb   $0x5c,-0x1(%edx)
  401787:	39 ca                	cmp    %ecx,%edx
  401789:	75 f5                	jne    401780 <__setargv+0x260>
  40178b:	83 7d d4 22          	cmpl   $0x22,-0x2c(%ebp)
  40178f:	0f 84 98 00 00 00    	je     40182d <__setargv+0x30d>
  401795:	a8 01                	test   $0x1,%al
  401797:	0f 85 90 00 00 00    	jne    40182d <__setargv+0x30d>
  40179d:	83 75 d4 27          	xorl   $0x27,-0x2c(%ebp)
  4017a1:	89 ca                	mov    %ecx,%edx
  4017a3:	31 c0                	xor    %eax,%eax
  4017a5:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
  4017ac:	e9 df fd ff ff       	jmp    401590 <__setargv+0x70>
  4017b1:	8d 51 01             	lea    0x1(%ecx),%edx
  4017b4:	c6 01 22             	movb   $0x22,(%ecx)
  4017b7:	31 c0                	xor    %eax,%eax
  4017b9:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
  4017c0:	e9 cb fd ff ff       	jmp    401590 <__setargv+0x70>
  4017c5:	a1 b0 81 40 00       	mov    0x4081b0,%eax
  4017ca:	8b 00                	mov    (%eax),%eax
  4017cc:	f6 04 48 40          	testb  $0x40,(%eax,%ecx,2)
  4017d0:	0f 84 48 ff ff ff    	je     40171e <__setargv+0x1fe>
  4017d6:	39 7d cc             	cmp    %edi,-0x34(%ebp)
  4017d9:	72 75                	jb     401850 <__setargv+0x330>
  4017db:	8b 45 d0             	mov    -0x30(%ebp),%eax
  4017de:	85 c0                	test   %eax,%eax
  4017e0:	75 6e                	jne    401850 <__setargv+0x330>
  4017e2:	89 fa                	mov    %edi,%edx
  4017e4:	31 c0                	xor    %eax,%eax
  4017e6:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  4017ed:	e9 9e fd ff ff       	jmp    401590 <__setargv+0x70>
  4017f2:	c6 00 00             	movb   $0x0,(%eax)
  4017f5:	8d 45 d8             	lea    -0x28(%ebp),%eax
  4017f8:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  4017ff:	00 
  401800:	89 44 24 0c          	mov    %eax,0xc(%esp)
  401804:	8b 45 c8             	mov    -0x38(%ebp),%eax
  401807:	89 44 24 04          	mov    %eax,0x4(%esp)
  40180b:	8b 45 cc             	mov    -0x34(%ebp),%eax
  40180e:	89 04 24             	mov    %eax,(%esp)
  401811:	e8 5a 18 00 00       	call   403070 <___mingw_glob>
  401816:	e9 24 fe ff ff       	jmp    40163f <__setargv+0x11f>
  40181b:	90                   	nop
  40181c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  401820:	e8 7b fa ff ff       	call   4012a0 <__mingw32_init_mainargs>
  401825:	8d 65 f4             	lea    -0xc(%ebp),%esp
  401828:	5b                   	pop    %ebx
  401829:	5e                   	pop    %esi
  40182a:	5f                   	pop    %edi
  40182b:	5d                   	pop    %ebp
  40182c:	c3                   	ret    
  40182d:	8d 51 01             	lea    0x1(%ecx),%edx
  401830:	c6 01 27             	movb   $0x27,(%ecx)
  401833:	31 c0                	xor    %eax,%eax
  401835:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
  40183c:	e9 4f fd ff ff       	jmp    401590 <__setargv+0x70>
  401841:	c6 02 5c             	movb   $0x5c,(%edx)
  401844:	83 c2 01             	add    $0x1,%edx
  401847:	e9 44 fd ff ff       	jmp    401590 <__setargv+0x70>
  40184c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  401850:	8d 45 d8             	lea    -0x28(%ebp),%eax
  401853:	c6 07 00             	movb   $0x0,(%edi)
  401856:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  40185d:	00 
  40185e:	89 44 24 0c          	mov    %eax,0xc(%esp)
  401862:	8b 5d c8             	mov    -0x38(%ebp),%ebx
  401865:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  401869:	8b 7d cc             	mov    -0x34(%ebp),%edi
  40186c:	89 3c 24             	mov    %edi,(%esp)
  40186f:	e8 fc 17 00 00       	call   403070 <___mingw_glob>
  401874:	89 d8                	mov    %ebx,%eax
  401876:	89 fa                	mov    %edi,%edx
  401878:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  40187f:	83 c8 01             	or     $0x1,%eax
  401882:	89 45 c8             	mov    %eax,-0x38(%ebp)
  401885:	31 c0                	xor    %eax,%eax
  401887:	e9 04 fd ff ff       	jmp    401590 <__setargv+0x70>
  40188c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  40188f:	85 c0                	test   %eax,%eax
  401891:	0f 95 c0             	setne  %al
  401894:	83 f9 7f             	cmp    $0x7f,%ecx
  401897:	0f 94 c1             	sete   %cl
  40189a:	09 c1                	or     %eax,%ecx
  40189c:	89 d0                	mov    %edx,%eax
  40189e:	e9 08 fe ff ff       	jmp    4016ab <__setargv+0x18b>
  4018a3:	89 d7                	mov    %edx,%edi
  4018a5:	e9 41 fe ff ff       	jmp    4016eb <__setargv+0x1cb>
  4018aa:	89 d1                	mov    %edx,%ecx
  4018ac:	e9 2d fd ff ff       	jmp    4015de <__setargv+0xbe>
  4018b1:	89 d0                	mov    %edx,%eax
  4018b3:	e9 73 fd ff ff       	jmp    40162b <__setargv+0x10b>
  4018b8:	89 d1                	mov    %edx,%ecx
  4018ba:	e9 cc fe ff ff       	jmp    40178b <__setargv+0x26b>
  4018bf:	90                   	nop

004018c0 <___cpu_features_init>:
  4018c0:	9c                   	pushf  
  4018c1:	9c                   	pushf  
  4018c2:	58                   	pop    %eax
  4018c3:	89 c2                	mov    %eax,%edx
  4018c5:	35 00 00 20 00       	xor    $0x200000,%eax
  4018ca:	50                   	push   %eax
  4018cb:	9d                   	popf   
  4018cc:	9c                   	pushf  
  4018cd:	58                   	pop    %eax
  4018ce:	9d                   	popf   
  4018cf:	31 d0                	xor    %edx,%eax
  4018d1:	a9 00 00 20 00       	test   $0x200000,%eax
  4018d6:	0f 84 e9 00 00 00    	je     4019c5 <___cpu_features_init+0x105>
  4018dc:	53                   	push   %ebx
  4018dd:	31 c0                	xor    %eax,%eax
  4018df:	0f a2                	cpuid  
  4018e1:	85 c0                	test   %eax,%eax
  4018e3:	0f 84 db 00 00 00    	je     4019c4 <___cpu_features_init+0x104>
  4018e9:	b8 01 00 00 00       	mov    $0x1,%eax
  4018ee:	0f a2                	cpuid  
  4018f0:	31 c0                	xor    %eax,%eax
  4018f2:	f6 c6 01             	test   $0x1,%dh
  4018f5:	74 03                	je     4018fa <___cpu_features_init+0x3a>
  4018f7:	83 c8 01             	or     $0x1,%eax
  4018fa:	f6 c5 20             	test   $0x20,%ch
  4018fd:	74 05                	je     401904 <___cpu_features_init+0x44>
  4018ff:	0d 80 00 00 00       	or     $0x80,%eax
  401904:	f6 c6 80             	test   $0x80,%dh
  401907:	74 03                	je     40190c <___cpu_features_init+0x4c>
  401909:	83 c8 02             	or     $0x2,%eax
  40190c:	f7 c2 00 00 80 00    	test   $0x800000,%edx
  401912:	74 03                	je     401917 <___cpu_features_init+0x57>
  401914:	83 c8 04             	or     $0x4,%eax
  401917:	f7 c2 00 00 00 01    	test   $0x1000000,%edx
  40191d:	74 6d                	je     40198c <___cpu_features_init+0xcc>
  40191f:	83 c8 08             	or     $0x8,%eax
  401922:	55                   	push   %ebp
  401923:	89 e5                	mov    %esp,%ebp
  401925:	81 ec 00 02 00 00    	sub    $0x200,%esp
  40192b:	83 e4 f0             	and    $0xfffffff0,%esp
  40192e:	0f ae 04 24          	fxsave (%esp)
  401932:	8b 9c 24 c8 00 00 00 	mov    0xc8(%esp),%ebx
  401939:	81 b4 24 c8 00 00 00 	xorl   $0x13c0de,0xc8(%esp)
  401940:	de c0 13 00 
  401944:	0f ae 0c 24          	fxrstor (%esp)
  401948:	89 9c 24 c8 00 00 00 	mov    %ebx,0xc8(%esp)
  40194f:	0f ae 04 24          	fxsave (%esp)
  401953:	87 9c 24 c8 00 00 00 	xchg   %ebx,0xc8(%esp)
  40195a:	0f ae 0c 24          	fxrstor (%esp)
  40195e:	33 9c 24 c8 00 00 00 	xor    0xc8(%esp),%ebx
  401965:	c9                   	leave  
  401966:	81 fb de c0 13 00    	cmp    $0x13c0de,%ebx
  40196c:	75 1e                	jne    40198c <___cpu_features_init+0xcc>
  40196e:	f7 c2 00 00 00 02    	test   $0x2000000,%edx
  401974:	74 03                	je     401979 <___cpu_features_init+0xb9>
  401976:	83 c8 10             	or     $0x10,%eax
  401979:	f7 c2 00 00 00 04    	test   $0x4000000,%edx
  40197f:	74 03                	je     401984 <___cpu_features_init+0xc4>
  401981:	83 c8 20             	or     $0x20,%eax
  401984:	f6 c1 01             	test   $0x1,%cl
  401987:	74 03                	je     40198c <___cpu_features_init+0xcc>
  401989:	83 c8 40             	or     $0x40,%eax
  40198c:	a3 24 70 40 00       	mov    %eax,0x407024
  401991:	b8 00 00 00 80       	mov    $0x80000000,%eax
  401996:	0f a2                	cpuid  
  401998:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  40199d:	76 25                	jbe    4019c4 <___cpu_features_init+0x104>
  40199f:	b8 01 00 00 80       	mov    $0x80000001,%eax
  4019a4:	0f a2                	cpuid  
  4019a6:	31 c0                	xor    %eax,%eax
  4019a8:	85 d2                	test   %edx,%edx
  4019aa:	79 05                	jns    4019b1 <___cpu_features_init+0xf1>
  4019ac:	b8 00 01 00 00       	mov    $0x100,%eax
  4019b1:	f7 c2 00 00 00 40    	test   $0x40000000,%edx
  4019b7:	74 05                	je     4019be <___cpu_features_init+0xfe>
  4019b9:	0d 00 02 00 00       	or     $0x200,%eax
  4019be:	09 05 24 70 40 00    	or     %eax,0x407024
  4019c4:	5b                   	pop    %ebx
  4019c5:	f3 c3                	repz ret 
  4019c7:	90                   	nop
  4019c8:	90                   	nop
  4019c9:	90                   	nop
  4019ca:	90                   	nop
  4019cb:	90                   	nop
  4019cc:	90                   	nop
  4019cd:	90                   	nop
  4019ce:	90                   	nop
  4019cf:	90                   	nop

004019d0 <___do_global_dtors>:
  4019d0:	a1 2c 41 40 00       	mov    0x40412c,%eax
  4019d5:	8b 00                	mov    (%eax),%eax
  4019d7:	85 c0                	test   %eax,%eax
  4019d9:	74 1f                	je     4019fa <___do_global_dtors+0x2a>
  4019db:	83 ec 0c             	sub    $0xc,%esp
  4019de:	66 90                	xchg   %ax,%ax
  4019e0:	ff d0                	call   *%eax
  4019e2:	a1 2c 41 40 00       	mov    0x40412c,%eax
  4019e7:	8d 50 04             	lea    0x4(%eax),%edx
  4019ea:	8b 40 04             	mov    0x4(%eax),%eax
  4019ed:	89 15 2c 41 40 00    	mov    %edx,0x40412c
  4019f3:	85 c0                	test   %eax,%eax
  4019f5:	75 e9                	jne    4019e0 <___do_global_dtors+0x10>
  4019f7:	83 c4 0c             	add    $0xc,%esp
  4019fa:	f3 c3                	repz ret 
  4019fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00401a00 <___do_global_ctors>:
  401a00:	53                   	push   %ebx
  401a01:	83 ec 18             	sub    $0x18,%esp
  401a04:	8b 1d 20 3c 40 00    	mov    0x403c20,%ebx
  401a0a:	83 fb ff             	cmp    $0xffffffff,%ebx
  401a0d:	74 21                	je     401a30 <___do_global_ctors+0x30>
  401a0f:	85 db                	test   %ebx,%ebx
  401a11:	74 0c                	je     401a1f <___do_global_ctors+0x1f>
  401a13:	ff 14 9d 20 3c 40 00 	call   *0x403c20(,%ebx,4)
  401a1a:	83 eb 01             	sub    $0x1,%ebx
  401a1d:	75 f4                	jne    401a13 <___do_global_ctors+0x13>
  401a1f:	c7 04 24 d0 19 40 00 	movl   $0x4019d0,(%esp)
  401a26:	e8 f5 f8 ff ff       	call   401320 <_atexit>
  401a2b:	83 c4 18             	add    $0x18,%esp
  401a2e:	5b                   	pop    %ebx
  401a2f:	c3                   	ret    
  401a30:	31 db                	xor    %ebx,%ebx
  401a32:	eb 02                	jmp    401a36 <___do_global_ctors+0x36>
  401a34:	89 c3                	mov    %eax,%ebx
  401a36:	8d 43 01             	lea    0x1(%ebx),%eax
  401a39:	8b 14 85 20 3c 40 00 	mov    0x403c20(,%eax,4),%edx
  401a40:	85 d2                	test   %edx,%edx
  401a42:	75 f0                	jne    401a34 <___do_global_ctors+0x34>
  401a44:	eb c9                	jmp    401a0f <___do_global_ctors+0xf>
  401a46:	8d 76 00             	lea    0x0(%esi),%esi
  401a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00401a50 <___main>:
  401a50:	a1 28 70 40 00       	mov    0x407028,%eax
  401a55:	85 c0                	test   %eax,%eax
  401a57:	74 07                	je     401a60 <___main+0x10>
  401a59:	f3 c3                	repz ret 
  401a5b:	90                   	nop
  401a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  401a60:	c7 05 28 70 40 00 01 	movl   $0x1,0x407028
  401a67:	00 00 00 
  401a6a:	eb 94                	jmp    401a00 <___do_global_ctors>
  401a6c:	90                   	nop
  401a6d:	90                   	nop
  401a6e:	90                   	nop
  401a6f:	90                   	nop

00401a70 <.text>:
  401a70:	83 ec 1c             	sub    $0x1c,%esp
  401a73:	8b 44 24 24          	mov    0x24(%esp),%eax
  401a77:	83 f8 03             	cmp    $0x3,%eax
  401a7a:	74 14                	je     401a90 <.text+0x20>
  401a7c:	85 c0                	test   %eax,%eax
  401a7e:	74 10                	je     401a90 <.text+0x20>
  401a80:	b8 01 00 00 00       	mov    $0x1,%eax
  401a85:	83 c4 1c             	add    $0x1c,%esp
  401a88:	c2 0c 00             	ret    $0xc
  401a8b:	90                   	nop
  401a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  401a90:	8b 54 24 28          	mov    0x28(%esp),%edx
  401a94:	89 44 24 04          	mov    %eax,0x4(%esp)
  401a98:	8b 44 24 20          	mov    0x20(%esp),%eax
  401a9c:	89 54 24 08          	mov    %edx,0x8(%esp)
  401aa0:	89 04 24             	mov    %eax,(%esp)
  401aa3:	e8 48 02 00 00       	call   401cf0 <___mingw_TLScallback>
  401aa8:	b8 01 00 00 00       	mov    $0x1,%eax
  401aad:	83 c4 1c             	add    $0x1c,%esp
  401ab0:	c2 0c 00             	ret    $0xc
  401ab3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  401ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00401ac0 <___dyn_tls_init@12>:
  401ac0:	56                   	push   %esi
  401ac1:	53                   	push   %ebx
  401ac2:	83 ec 14             	sub    $0x14,%esp
  401ac5:	83 3d 64 70 40 00 02 	cmpl   $0x2,0x407064
  401acc:	8b 44 24 24          	mov    0x24(%esp),%eax
  401ad0:	74 0a                	je     401adc <___dyn_tls_init@12+0x1c>
  401ad2:	c7 05 64 70 40 00 02 	movl   $0x2,0x407064
  401ad9:	00 00 00 
  401adc:	83 f8 02             	cmp    $0x2,%eax
  401adf:	74 12                	je     401af3 <___dyn_tls_init@12+0x33>
  401ae1:	83 f8 01             	cmp    $0x1,%eax
  401ae4:	74 3f                	je     401b25 <___dyn_tls_init@12+0x65>
  401ae6:	83 c4 14             	add    $0x14,%esp
  401ae9:	b8 01 00 00 00       	mov    $0x1,%eax
  401aee:	5b                   	pop    %ebx
  401aef:	5e                   	pop    %esi
  401af0:	c2 0c 00             	ret    $0xc
  401af3:	be 14 90 40 00       	mov    $0x409014,%esi
  401af8:	81 ee 14 90 40 00    	sub    $0x409014,%esi
  401afe:	83 fe 03             	cmp    $0x3,%esi
  401b01:	7e e3                	jle    401ae6 <___dyn_tls_init@12+0x26>
  401b03:	31 db                	xor    %ebx,%ebx
  401b05:	8b 83 14 90 40 00    	mov    0x409014(%ebx),%eax
  401b0b:	85 c0                	test   %eax,%eax
  401b0d:	74 02                	je     401b11 <___dyn_tls_init@12+0x51>
  401b0f:	ff d0                	call   *%eax
  401b11:	83 c3 04             	add    $0x4,%ebx
  401b14:	39 de                	cmp    %ebx,%esi
  401b16:	75 ed                	jne    401b05 <___dyn_tls_init@12+0x45>
  401b18:	83 c4 14             	add    $0x14,%esp
  401b1b:	b8 01 00 00 00       	mov    $0x1,%eax
  401b20:	5b                   	pop    %ebx
  401b21:	5e                   	pop    %esi
  401b22:	c2 0c 00             	ret    $0xc
  401b25:	8b 44 24 28          	mov    0x28(%esp),%eax
  401b29:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  401b30:	00 
  401b31:	89 44 24 08          	mov    %eax,0x8(%esp)
  401b35:	8b 44 24 20          	mov    0x20(%esp),%eax
  401b39:	89 04 24             	mov    %eax,(%esp)
  401b3c:	e8 af 01 00 00       	call   401cf0 <___mingw_TLScallback>
  401b41:	eb a3                	jmp    401ae6 <___dyn_tls_init@12+0x26>
  401b43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  401b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00401b50 <___tlregdtor>:
  401b50:	31 c0                	xor    %eax,%eax
  401b52:	c3                   	ret    
  401b53:	90                   	nop
  401b54:	90                   	nop
  401b55:	90                   	nop
  401b56:	90                   	nop
  401b57:	90                   	nop
  401b58:	90                   	nop
  401b59:	90                   	nop
  401b5a:	90                   	nop
  401b5b:	90                   	nop
  401b5c:	90                   	nop
  401b5d:	90                   	nop
  401b5e:	90                   	nop
  401b5f:	90                   	nop

00401b60 <.text>:
  401b60:	56                   	push   %esi
  401b61:	53                   	push   %ebx
  401b62:	83 ec 14             	sub    $0x14,%esp
  401b65:	c7 04 24 44 70 40 00 	movl   $0x407044,(%esp)
  401b6c:	e8 7f 20 00 00       	call   403bf0 <_EnterCriticalSection@4>
  401b71:	8b 1d 3c 70 40 00    	mov    0x40703c,%ebx
  401b77:	83 ec 04             	sub    $0x4,%esp
  401b7a:	85 db                	test   %ebx,%ebx
  401b7c:	74 2d                	je     401bab <.text+0x4b>
  401b7e:	66 90                	xchg   %ax,%ax
  401b80:	8b 03                	mov    (%ebx),%eax
  401b82:	89 04 24             	mov    %eax,(%esp)
  401b85:	e8 f6 1f 00 00       	call   403b80 <_TlsGetValue@4>
  401b8a:	83 ec 04             	sub    $0x4,%esp
  401b8d:	89 c6                	mov    %eax,%esi
  401b8f:	e8 24 20 00 00       	call   403bb8 <_GetLastError@0>
  401b94:	85 c0                	test   %eax,%eax
  401b96:	75 0c                	jne    401ba4 <.text+0x44>
  401b98:	85 f6                	test   %esi,%esi
  401b9a:	74 08                	je     401ba4 <.text+0x44>
  401b9c:	8b 43 04             	mov    0x4(%ebx),%eax
  401b9f:	89 34 24             	mov    %esi,(%esp)
  401ba2:	ff d0                	call   *%eax
  401ba4:	8b 5b 08             	mov    0x8(%ebx),%ebx
  401ba7:	85 db                	test   %ebx,%ebx
  401ba9:	75 d5                	jne    401b80 <.text+0x20>
  401bab:	c7 04 24 44 70 40 00 	movl   $0x407044,(%esp)
  401bb2:	e8 e1 1f 00 00       	call   403b98 <_LeaveCriticalSection@4>
  401bb7:	83 ec 04             	sub    $0x4,%esp
  401bba:	83 c4 14             	add    $0x14,%esp
  401bbd:	5b                   	pop    %ebx
  401bbe:	5e                   	pop    %esi
  401bbf:	c3                   	ret    

00401bc0 <____w64_mingwthr_add_key_dtor>:
  401bc0:	56                   	push   %esi
  401bc1:	53                   	push   %ebx
  401bc2:	31 f6                	xor    %esi,%esi
  401bc4:	83 ec 14             	sub    $0x14,%esp
  401bc7:	a1 40 70 40 00       	mov    0x407040,%eax
  401bcc:	85 c0                	test   %eax,%eax
  401bce:	75 10                	jne    401be0 <____w64_mingwthr_add_key_dtor+0x20>
  401bd0:	83 c4 14             	add    $0x14,%esp
  401bd3:	89 f0                	mov    %esi,%eax
  401bd5:	5b                   	pop    %ebx
  401bd6:	5e                   	pop    %esi
  401bd7:	c3                   	ret    
  401bd8:	90                   	nop
  401bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  401be0:	c7 44 24 04 0c 00 00 	movl   $0xc,0x4(%esp)
  401be7:	00 
  401be8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  401bef:	e8 2c 1f 00 00       	call   403b20 <_calloc>
  401bf4:	85 c0                	test   %eax,%eax
  401bf6:	89 c3                	mov    %eax,%ebx
  401bf8:	74 41                	je     401c3b <____w64_mingwthr_add_key_dtor+0x7b>
  401bfa:	8b 44 24 20          	mov    0x20(%esp),%eax
  401bfe:	c7 04 24 44 70 40 00 	movl   $0x407044,(%esp)
  401c05:	89 03                	mov    %eax,(%ebx)
  401c07:	8b 44 24 24          	mov    0x24(%esp),%eax
  401c0b:	89 43 04             	mov    %eax,0x4(%ebx)
  401c0e:	e8 dd 1f 00 00       	call   403bf0 <_EnterCriticalSection@4>
  401c13:	a1 3c 70 40 00       	mov    0x40703c,%eax
  401c18:	83 ec 04             	sub    $0x4,%esp
  401c1b:	89 1d 3c 70 40 00    	mov    %ebx,0x40703c
  401c21:	c7 04 24 44 70 40 00 	movl   $0x407044,(%esp)
  401c28:	89 43 08             	mov    %eax,0x8(%ebx)
  401c2b:	e8 68 1f 00 00       	call   403b98 <_LeaveCriticalSection@4>
  401c30:	83 ec 04             	sub    $0x4,%esp
  401c33:	89 f0                	mov    %esi,%eax
  401c35:	83 c4 14             	add    $0x14,%esp
  401c38:	5b                   	pop    %ebx
  401c39:	5e                   	pop    %esi
  401c3a:	c3                   	ret    
  401c3b:	be ff ff ff ff       	mov    $0xffffffff,%esi
  401c40:	eb 8e                	jmp    401bd0 <____w64_mingwthr_add_key_dtor+0x10>
  401c42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  401c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00401c50 <____w64_mingwthr_remove_key_dtor>:
  401c50:	53                   	push   %ebx
  401c51:	83 ec 18             	sub    $0x18,%esp
  401c54:	a1 40 70 40 00       	mov    0x407040,%eax
  401c59:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  401c5d:	85 c0                	test   %eax,%eax
  401c5f:	75 0f                	jne    401c70 <____w64_mingwthr_remove_key_dtor+0x20>
  401c61:	83 c4 18             	add    $0x18,%esp
  401c64:	31 c0                	xor    %eax,%eax
  401c66:	5b                   	pop    %ebx
  401c67:	c3                   	ret    
  401c68:	90                   	nop
  401c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  401c70:	c7 04 24 44 70 40 00 	movl   $0x407044,(%esp)
  401c77:	e8 74 1f 00 00       	call   403bf0 <_EnterCriticalSection@4>
  401c7c:	8b 15 3c 70 40 00    	mov    0x40703c,%edx
  401c82:	83 ec 04             	sub    $0x4,%esp
  401c85:	85 d2                	test   %edx,%edx
  401c87:	74 17                	je     401ca0 <____w64_mingwthr_remove_key_dtor+0x50>
  401c89:	8b 02                	mov    (%edx),%eax
  401c8b:	39 c3                	cmp    %eax,%ebx
  401c8d:	75 0a                	jne    401c99 <____w64_mingwthr_remove_key_dtor+0x49>
  401c8f:	eb 4e                	jmp    401cdf <____w64_mingwthr_remove_key_dtor+0x8f>
  401c91:	8b 08                	mov    (%eax),%ecx
  401c93:	39 d9                	cmp    %ebx,%ecx
  401c95:	74 29                	je     401cc0 <____w64_mingwthr_remove_key_dtor+0x70>
  401c97:	89 c2                	mov    %eax,%edx
  401c99:	8b 42 08             	mov    0x8(%edx),%eax
  401c9c:	85 c0                	test   %eax,%eax
  401c9e:	75 f1                	jne    401c91 <____w64_mingwthr_remove_key_dtor+0x41>
  401ca0:	c7 04 24 44 70 40 00 	movl   $0x407044,(%esp)
  401ca7:	e8 ec 1e 00 00       	call   403b98 <_LeaveCriticalSection@4>
  401cac:	83 ec 04             	sub    $0x4,%esp
  401caf:	83 c4 18             	add    $0x18,%esp
  401cb2:	31 c0                	xor    %eax,%eax
  401cb4:	5b                   	pop    %ebx
  401cb5:	c3                   	ret    
  401cb6:	8d 76 00             	lea    0x0(%esi),%esi
  401cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  401cc0:	8b 48 08             	mov    0x8(%eax),%ecx
  401cc3:	89 4a 08             	mov    %ecx,0x8(%edx)
  401cc6:	89 04 24             	mov    %eax,(%esp)
  401cc9:	e8 4a 1e 00 00       	call   403b18 <_free>
  401cce:	c7 04 24 44 70 40 00 	movl   $0x407044,(%esp)
  401cd5:	e8 be 1e 00 00       	call   403b98 <_LeaveCriticalSection@4>
  401cda:	83 ec 04             	sub    $0x4,%esp
  401cdd:	eb d0                	jmp    401caf <____w64_mingwthr_remove_key_dtor+0x5f>
  401cdf:	8b 42 08             	mov    0x8(%edx),%eax
  401ce2:	a3 3c 70 40 00       	mov    %eax,0x40703c
  401ce7:	89 d0                	mov    %edx,%eax
  401ce9:	eb db                	jmp    401cc6 <____w64_mingwthr_remove_key_dtor+0x76>
  401ceb:	90                   	nop
  401cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00401cf0 <___mingw_TLScallback>:
  401cf0:	83 ec 1c             	sub    $0x1c,%esp
  401cf3:	8b 44 24 24          	mov    0x24(%esp),%eax
  401cf7:	83 f8 01             	cmp    $0x1,%eax
  401cfa:	74 47                	je     401d43 <___mingw_TLScallback+0x53>
  401cfc:	72 17                	jb     401d15 <___mingw_TLScallback+0x25>
  401cfe:	83 f8 03             	cmp    $0x3,%eax
  401d01:	75 09                	jne    401d0c <___mingw_TLScallback+0x1c>
  401d03:	a1 40 70 40 00       	mov    0x407040,%eax
  401d08:	85 c0                	test   %eax,%eax
  401d0a:	75 65                	jne    401d71 <___mingw_TLScallback+0x81>
  401d0c:	b8 01 00 00 00       	mov    $0x1,%eax
  401d11:	83 c4 1c             	add    $0x1c,%esp
  401d14:	c3                   	ret    
  401d15:	a1 40 70 40 00       	mov    0x407040,%eax
  401d1a:	85 c0                	test   %eax,%eax
  401d1c:	75 62                	jne    401d80 <___mingw_TLScallback+0x90>
  401d1e:	a1 40 70 40 00       	mov    0x407040,%eax
  401d23:	83 f8 01             	cmp    $0x1,%eax
  401d26:	75 e4                	jne    401d0c <___mingw_TLScallback+0x1c>
  401d28:	c7 04 24 44 70 40 00 	movl   $0x407044,(%esp)
  401d2f:	c7 05 40 70 40 00 00 	movl   $0x0,0x407040
  401d36:	00 00 00 
  401d39:	e8 ba 1e 00 00       	call   403bf8 <_DeleteCriticalSection@4>
  401d3e:	83 ec 04             	sub    $0x4,%esp
  401d41:	eb c9                	jmp    401d0c <___mingw_TLScallback+0x1c>
  401d43:	a1 40 70 40 00       	mov    0x407040,%eax
  401d48:	85 c0                	test   %eax,%eax
  401d4a:	74 14                	je     401d60 <___mingw_TLScallback+0x70>
  401d4c:	c7 05 40 70 40 00 01 	movl   $0x1,0x407040
  401d53:	00 00 00 
  401d56:	b8 01 00 00 00       	mov    $0x1,%eax
  401d5b:	83 c4 1c             	add    $0x1c,%esp
  401d5e:	c3                   	ret    
  401d5f:	90                   	nop
  401d60:	c7 04 24 44 70 40 00 	movl   $0x407044,(%esp)
  401d67:	e8 34 1e 00 00       	call   403ba0 <_InitializeCriticalSection@4>
  401d6c:	83 ec 04             	sub    $0x4,%esp
  401d6f:	eb db                	jmp    401d4c <___mingw_TLScallback+0x5c>
  401d71:	e8 ea fd ff ff       	call   401b60 <.text>
  401d76:	eb 94                	jmp    401d0c <___mingw_TLScallback+0x1c>
  401d78:	90                   	nop
  401d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  401d80:	e8 db fd ff ff       	call   401b60 <.text>
  401d85:	eb 97                	jmp    401d1e <___mingw_TLScallback+0x2e>
  401d87:	90                   	nop
  401d88:	90                   	nop
  401d89:	90                   	nop
  401d8a:	90                   	nop
  401d8b:	90                   	nop
  401d8c:	90                   	nop
  401d8d:	90                   	nop
  401d8e:	90                   	nop
  401d8f:	90                   	nop

00401d90 <.text>:
  401d90:	56                   	push   %esi
  401d91:	53                   	push   %ebx
  401d92:	83 ec 14             	sub    $0x14,%esp
  401d95:	a1 a4 81 40 00       	mov    0x4081a4,%eax
  401d9a:	c7 44 24 08 17 00 00 	movl   $0x17,0x8(%esp)
  401da1:	00 
  401da2:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  401da9:	00 
  401daa:	8d 74 24 24          	lea    0x24(%esp),%esi
  401dae:	c7 04 24 6c 50 40 00 	movl   $0x40506c,(%esp)
  401db5:	8d 58 40             	lea    0x40(%eax),%ebx
  401db8:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  401dbc:	e8 4f 1d 00 00       	call   403b10 <_fwrite>
  401dc1:	8b 44 24 20          	mov    0x20(%esp),%eax
  401dc5:	89 74 24 08          	mov    %esi,0x8(%esp)
  401dc9:	89 1c 24             	mov    %ebx,(%esp)
  401dcc:	89 44 24 04          	mov    %eax,0x4(%esp)
  401dd0:	e8 e3 1c 00 00       	call   403ab8 <_vfprintf>
  401dd5:	e8 4e 1d 00 00       	call   403b28 <_abort>
  401dda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  401de0:	55                   	push   %ebp
  401de1:	57                   	push   %edi
  401de2:	89 cf                	mov    %ecx,%edi
  401de4:	56                   	push   %esi
  401de5:	53                   	push   %ebx
  401de6:	89 c3                	mov    %eax,%ebx
  401de8:	89 d6                	mov    %edx,%esi
  401dea:	83 ec 4c             	sub    $0x4c,%esp
  401ded:	8d 44 24 24          	lea    0x24(%esp),%eax
  401df1:	c7 44 24 08 1c 00 00 	movl   $0x1c,0x8(%esp)
  401df8:	00 
  401df9:	89 1c 24             	mov    %ebx,(%esp)
  401dfc:	89 44 24 04          	mov    %eax,0x4(%esp)
  401e00:	e8 6b 1d 00 00       	call   403b70 <_VirtualQuery@12>
  401e05:	83 ec 0c             	sub    $0xc,%esp
  401e08:	85 c0                	test   %eax,%eax
  401e0a:	0f 84 a8 00 00 00    	je     401eb8 <.text+0x128>
  401e10:	8b 44 24 38          	mov    0x38(%esp),%eax
  401e14:	83 f8 40             	cmp    $0x40,%eax
  401e17:	74 05                	je     401e1e <.text+0x8e>
  401e19:	83 f8 04             	cmp    $0x4,%eax
  401e1c:	75 22                	jne    401e40 <.text+0xb0>
  401e1e:	89 7c 24 08          	mov    %edi,0x8(%esp)
  401e22:	89 74 24 04          	mov    %esi,0x4(%esp)
  401e26:	89 1c 24             	mov    %ebx,(%esp)
  401e29:	e8 ca 1c 00 00       	call   403af8 <_memcpy>
  401e2e:	83 c4 4c             	add    $0x4c,%esp
  401e31:	5b                   	pop    %ebx
  401e32:	5e                   	pop    %esi
  401e33:	5f                   	pop    %edi
  401e34:	5d                   	pop    %ebp
  401e35:	c3                   	ret    
  401e36:	8d 76 00             	lea    0x0(%esi),%esi
  401e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  401e40:	8b 44 24 30          	mov    0x30(%esp),%eax
  401e44:	8d 6c 24 20          	lea    0x20(%esp),%ebp
  401e48:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
  401e4f:	00 
  401e50:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
  401e54:	89 44 24 04          	mov    %eax,0x4(%esp)
  401e58:	8b 44 24 24          	mov    0x24(%esp),%eax
  401e5c:	89 04 24             	mov    %eax,(%esp)
  401e5f:	e8 14 1d 00 00       	call   403b78 <_VirtualProtect@16>
  401e64:	83 ec 10             	sub    $0x10,%esp
  401e67:	8b 54 24 38          	mov    0x38(%esp),%edx
  401e6b:	89 7c 24 08          	mov    %edi,0x8(%esp)
  401e6f:	89 74 24 04          	mov    %esi,0x4(%esp)
  401e73:	89 1c 24             	mov    %ebx,(%esp)
  401e76:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  401e7a:	e8 79 1c 00 00       	call   403af8 <_memcpy>
  401e7f:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  401e83:	83 fa 40             	cmp    $0x40,%edx
  401e86:	74 a6                	je     401e2e <.text+0x9e>
  401e88:	83 fa 04             	cmp    $0x4,%edx
  401e8b:	74 a1                	je     401e2e <.text+0x9e>
  401e8d:	8b 44 24 20          	mov    0x20(%esp),%eax
  401e91:	89 6c 24 0c          	mov    %ebp,0xc(%esp)
  401e95:	89 44 24 08          	mov    %eax,0x8(%esp)
  401e99:	8b 44 24 30          	mov    0x30(%esp),%eax
  401e9d:	89 44 24 04          	mov    %eax,0x4(%esp)
  401ea1:	8b 44 24 24          	mov    0x24(%esp),%eax
  401ea5:	89 04 24             	mov    %eax,(%esp)
  401ea8:	e8 cb 1c 00 00       	call   403b78 <_VirtualProtect@16>
  401ead:	83 ec 10             	sub    $0x10,%esp
  401eb0:	83 c4 4c             	add    $0x4c,%esp
  401eb3:	5b                   	pop    %ebx
  401eb4:	5e                   	pop    %esi
  401eb5:	5f                   	pop    %edi
  401eb6:	5d                   	pop    %ebp
  401eb7:	c3                   	ret    
  401eb8:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  401ebc:	c7 44 24 04 1c 00 00 	movl   $0x1c,0x4(%esp)
  401ec3:	00 
  401ec4:	c7 04 24 84 50 40 00 	movl   $0x405084,(%esp)
  401ecb:	e8 c0 fe ff ff       	call   401d90 <.text>

00401ed0 <__pei386_runtime_relocator>:
  401ed0:	a1 5c 70 40 00       	mov    0x40705c,%eax
  401ed5:	85 c0                	test   %eax,%eax
  401ed7:	74 07                	je     401ee0 <__pei386_runtime_relocator+0x10>
  401ed9:	c3                   	ret    
  401eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  401ee0:	b8 d4 52 40 00       	mov    $0x4052d4,%eax
  401ee5:	c7 05 5c 70 40 00 01 	movl   $0x1,0x40705c
  401eec:	00 00 00 
  401eef:	2d d4 52 40 00       	sub    $0x4052d4,%eax
  401ef4:	83 f8 07             	cmp    $0x7,%eax
  401ef7:	7e e0                	jle    401ed9 <__pei386_runtime_relocator+0x9>
  401ef9:	57                   	push   %edi
  401efa:	56                   	push   %esi
  401efb:	53                   	push   %ebx
  401efc:	83 ec 20             	sub    $0x20,%esp
  401eff:	83 f8 0b             	cmp    $0xb,%eax
  401f02:	0f 8e e8 00 00 00    	jle    401ff0 <__pei386_runtime_relocator+0x120>
  401f08:	8b 35 d4 52 40 00    	mov    0x4052d4,%esi
  401f0e:	85 f6                	test   %esi,%esi
  401f10:	0f 85 8f 00 00 00    	jne    401fa5 <__pei386_runtime_relocator+0xd5>
  401f16:	8b 1d d8 52 40 00    	mov    0x4052d8,%ebx
  401f1c:	85 db                	test   %ebx,%ebx
  401f1e:	0f 85 81 00 00 00    	jne    401fa5 <__pei386_runtime_relocator+0xd5>
  401f24:	8b 0d dc 52 40 00    	mov    0x4052dc,%ecx
  401f2a:	bb e0 52 40 00       	mov    $0x4052e0,%ebx
  401f2f:	85 c9                	test   %ecx,%ecx
  401f31:	0f 84 be 00 00 00    	je     401ff5 <__pei386_runtime_relocator+0x125>
  401f37:	bb d4 52 40 00       	mov    $0x4052d4,%ebx
  401f3c:	8b 43 08             	mov    0x8(%ebx),%eax
  401f3f:	83 f8 01             	cmp    $0x1,%eax
  401f42:	0f 85 43 01 00 00    	jne    40208b <__pei386_runtime_relocator+0x1bb>
  401f48:	83 c3 0c             	add    $0xc,%ebx
  401f4b:	81 fb d4 52 40 00    	cmp    $0x4052d4,%ebx
  401f51:	0f 83 89 00 00 00    	jae    401fe0 <__pei386_runtime_relocator+0x110>
  401f57:	8b 13                	mov    (%ebx),%edx
  401f59:	8b 7b 04             	mov    0x4(%ebx),%edi
  401f5c:	8d b2 00 00 40 00    	lea    0x400000(%edx),%esi
  401f62:	8b 8a 00 00 40 00    	mov    0x400000(%edx),%ecx
  401f68:	0f b6 53 08          	movzbl 0x8(%ebx),%edx
  401f6c:	8d 87 00 00 40 00    	lea    0x400000(%edi),%eax
  401f72:	83 fa 10             	cmp    $0x10,%edx
  401f75:	0f 84 95 00 00 00    	je     402010 <__pei386_runtime_relocator+0x140>
  401f7b:	83 fa 20             	cmp    $0x20,%edx
  401f7e:	0f 84 ec 00 00 00    	je     402070 <__pei386_runtime_relocator+0x1a0>
  401f84:	83 fa 08             	cmp    $0x8,%edx
  401f87:	0f 84 b3 00 00 00    	je     402040 <__pei386_runtime_relocator+0x170>
  401f8d:	89 54 24 04          	mov    %edx,0x4(%esp)
  401f91:	c7 04 24 ec 50 40 00 	movl   $0x4050ec,(%esp)
  401f98:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  401f9f:	00 
  401fa0:	e8 eb fd ff ff       	call   401d90 <.text>
  401fa5:	bb d4 52 40 00       	mov    $0x4052d4,%ebx
  401faa:	81 fb d4 52 40 00    	cmp    $0x4052d4,%ebx
  401fb0:	73 2e                	jae    401fe0 <__pei386_runtime_relocator+0x110>
  401fb2:	8b 4b 04             	mov    0x4(%ebx),%ecx
  401fb5:	8b 13                	mov    (%ebx),%edx
  401fb7:	83 c3 08             	add    $0x8,%ebx
  401fba:	03 91 00 00 40 00    	add    0x400000(%ecx),%edx
  401fc0:	8d 81 00 00 40 00    	lea    0x400000(%ecx),%eax
  401fc6:	b9 04 00 00 00       	mov    $0x4,%ecx
  401fcb:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  401fcf:	8d 54 24 1c          	lea    0x1c(%esp),%edx
  401fd3:	e8 08 fe ff ff       	call   401de0 <.text+0x50>
  401fd8:	81 fb d4 52 40 00    	cmp    $0x4052d4,%ebx
  401fde:	72 d2                	jb     401fb2 <__pei386_runtime_relocator+0xe2>
  401fe0:	83 c4 20             	add    $0x20,%esp
  401fe3:	5b                   	pop    %ebx
  401fe4:	5e                   	pop    %esi
  401fe5:	5f                   	pop    %edi
  401fe6:	c3                   	ret    
  401fe7:	89 f6                	mov    %esi,%esi
  401fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  401ff0:	bb d4 52 40 00       	mov    $0x4052d4,%ebx
  401ff5:	8b 13                	mov    (%ebx),%edx
  401ff7:	85 d2                	test   %edx,%edx
  401ff9:	75 af                	jne    401faa <__pei386_runtime_relocator+0xda>
  401ffb:	8b 43 04             	mov    0x4(%ebx),%eax
  401ffe:	85 c0                	test   %eax,%eax
  402000:	0f 84 36 ff ff ff    	je     401f3c <__pei386_runtime_relocator+0x6c>
  402006:	eb a2                	jmp    401faa <__pei386_runtime_relocator+0xda>
  402008:	90                   	nop
  402009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  402010:	0f b7 97 00 00 40 00 	movzwl 0x400000(%edi),%edx
  402017:	66 85 d2             	test   %dx,%dx
  40201a:	79 06                	jns    402022 <__pei386_runtime_relocator+0x152>
  40201c:	81 ca 00 00 ff ff    	or     $0xffff0000,%edx
  402022:	29 f2                	sub    %esi,%edx
  402024:	01 d1                	add    %edx,%ecx
  402026:	8d 54 24 1c          	lea    0x1c(%esp),%edx
  40202a:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
  40202e:	b9 02 00 00 00       	mov    $0x2,%ecx
  402033:	e8 a8 fd ff ff       	call   401de0 <.text+0x50>
  402038:	e9 0b ff ff ff       	jmp    401f48 <__pei386_runtime_relocator+0x78>
  40203d:	8d 76 00             	lea    0x0(%esi),%esi
  402040:	0f b6 38             	movzbl (%eax),%edi
  402043:	89 fa                	mov    %edi,%edx
  402045:	84 d2                	test   %dl,%dl
  402047:	79 06                	jns    40204f <__pei386_runtime_relocator+0x17f>
  402049:	81 cf 00 ff ff ff    	or     $0xffffff00,%edi
  40204f:	29 f7                	sub    %esi,%edi
  402051:	8d 54 24 1c          	lea    0x1c(%esp),%edx
  402055:	01 f9                	add    %edi,%ecx
  402057:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
  40205b:	b9 01 00 00 00       	mov    $0x1,%ecx
  402060:	e8 7b fd ff ff       	call   401de0 <.text+0x50>
  402065:	e9 de fe ff ff       	jmp    401f48 <__pei386_runtime_relocator+0x78>
  40206a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  402070:	29 f1                	sub    %esi,%ecx
  402072:	03 08                	add    (%eax),%ecx
  402074:	8d 54 24 1c          	lea    0x1c(%esp),%edx
  402078:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
  40207c:	b9 04 00 00 00       	mov    $0x4,%ecx
  402081:	e8 5a fd ff ff       	call   401de0 <.text+0x50>
  402086:	e9 bd fe ff ff       	jmp    401f48 <__pei386_runtime_relocator+0x78>
  40208b:	89 44 24 04          	mov    %eax,0x4(%esp)
  40208f:	c7 04 24 b8 50 40 00 	movl   $0x4050b8,(%esp)
  402096:	e8 f5 fc ff ff       	call   401d90 <.text>
  40209b:	90                   	nop
  40209c:	90                   	nop
  40209d:	90                   	nop
  40209e:	90                   	nop
  40209f:	90                   	nop

004020a0 <___chkstk_ms>:
  4020a0:	51                   	push   %ecx
  4020a1:	50                   	push   %eax
  4020a2:	3d 00 10 00 00       	cmp    $0x1000,%eax
  4020a7:	8d 4c 24 0c          	lea    0xc(%esp),%ecx
  4020ab:	72 15                	jb     4020c2 <___chkstk_ms+0x22>
  4020ad:	81 e9 00 10 00 00    	sub    $0x1000,%ecx
  4020b3:	83 09 00             	orl    $0x0,(%ecx)
  4020b6:	2d 00 10 00 00       	sub    $0x1000,%eax
  4020bb:	3d 00 10 00 00       	cmp    $0x1000,%eax
  4020c0:	77 eb                	ja     4020ad <___chkstk_ms+0xd>
  4020c2:	29 c1                	sub    %eax,%ecx
  4020c4:	83 09 00             	orl    $0x0,(%ecx)
  4020c7:	58                   	pop    %eax
  4020c8:	59                   	pop    %ecx
  4020c9:	c3                   	ret    
  4020ca:	90                   	nop
  4020cb:	90                   	nop

004020cc <.text>:
  4020cc:	66 90                	xchg   %ax,%ax
  4020ce:	66 90                	xchg   %ax,%ax

004020d0 <_fesetenv>:
  4020d0:	83 ec 1c             	sub    $0x1c,%esp
  4020d3:	8b 44 24 20          	mov    0x20(%esp),%eax
  4020d7:	c7 44 24 0c 80 1f 00 	movl   $0x1f80,0xc(%esp)
  4020de:	00 
  4020df:	83 f8 fd             	cmp    $0xfffffffd,%eax
  4020e2:	74 31                	je     402115 <_fesetenv+0x45>
  4020e4:	83 f8 fc             	cmp    $0xfffffffc,%eax
  4020e7:	74 3a                	je     402123 <_fesetenv+0x53>
  4020e9:	85 c0                	test   %eax,%eax
  4020eb:	74 48                	je     402135 <_fesetenv+0x65>
  4020ed:	83 f8 ff             	cmp    $0xffffffff,%eax
  4020f0:	74 2d                	je     40211f <_fesetenv+0x4f>
  4020f2:	83 f8 fe             	cmp    $0xfffffffe,%eax
  4020f5:	74 36                	je     40212d <_fesetenv+0x5d>
  4020f7:	d9 20                	fldenv (%eax)
  4020f9:	0f b7 40 1c          	movzwl 0x1c(%eax),%eax
  4020fd:	89 44 24 0c          	mov    %eax,0xc(%esp)
  402101:	f6 05 24 70 40 00 10 	testb  $0x10,0x407024
  402108:	74 05                	je     40210f <_fesetenv+0x3f>
  40210a:	0f ae 54 24 0c       	ldmxcsr 0xc(%esp)
  40210f:	31 c0                	xor    %eax,%eax
  402111:	83 c4 1c             	add    $0x1c,%esp
  402114:	c3                   	ret    
  402115:	c7 05 30 41 40 00 ff 	movl   $0xffffffff,0x404130
  40211c:	ff ff ff 
  40211f:	db e3                	fninit 
  402121:	eb de                	jmp    402101 <_fesetenv+0x31>
  402123:	c7 05 30 41 40 00 fe 	movl   $0xfffffffe,0x404130
  40212a:	ff ff ff 
  40212d:	ff 15 9c 81 40 00    	call   *0x40819c
  402133:	eb cc                	jmp    402101 <_fesetenv+0x31>
  402135:	a1 30 41 40 00       	mov    0x404130,%eax
  40213a:	eb b1                	jmp    4020ed <_fesetenv+0x1d>
  40213c:	90                   	nop
  40213d:	90                   	nop
  40213e:	90                   	nop
  40213f:	90                   	nop

00402140 <.text>:
  402140:	85 c0                	test   %eax,%eax
  402142:	0f 84 82 00 00 00    	je     4021ca <.text+0x8a>
  402148:	56                   	push   %esi
  402149:	53                   	push   %ebx
  40214a:	89 d3                	mov    %edx,%ebx
  40214c:	c1 eb 05             	shr    $0x5,%ebx
  40214f:	31 c9                	xor    %ecx,%ecx
  402151:	83 f3 01             	xor    $0x1,%ebx
  402154:	83 e3 01             	and    $0x1,%ebx
  402157:	89 f6                	mov    %esi,%esi
  402159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  402160:	0f be 10             	movsbl (%eax),%edx
  402163:	85 d2                	test   %edx,%edx
  402165:	74 29                	je     402190 <.text+0x50>
  402167:	84 db                	test   %bl,%bl
  402169:	74 05                	je     402170 <.text+0x30>
  40216b:	83 fa 7f             	cmp    $0x7f,%edx
  40216e:	74 40                	je     4021b0 <.text+0x70>
  402170:	83 c0 01             	add    $0x1,%eax
  402173:	85 c9                	test   %ecx,%ecx
  402175:	75 1e                	jne    402195 <.text+0x55>
  402177:	83 fa 2a             	cmp    $0x2a,%edx
  40217a:	74 44                	je     4021c0 <.text+0x80>
  40217c:	83 fa 3f             	cmp    $0x3f,%edx
  40217f:	74 3f                	je     4021c0 <.text+0x80>
  402181:	31 c9                	xor    %ecx,%ecx
  402183:	83 fa 5b             	cmp    $0x5b,%edx
  402186:	0f be 10             	movsbl (%eax),%edx
  402189:	0f 94 c1             	sete   %cl
  40218c:	85 d2                	test   %edx,%edx
  40218e:	75 d7                	jne    402167 <.text+0x27>
  402190:	89 d0                	mov    %edx,%eax
  402192:	5b                   	pop    %ebx
  402193:	5e                   	pop    %esi
  402194:	c3                   	ret    
  402195:	83 f9 01             	cmp    $0x1,%ecx
  402198:	7e 05                	jle    40219f <.text+0x5f>
  40219a:	83 fa 5d             	cmp    $0x5d,%edx
  40219d:	74 21                	je     4021c0 <.text+0x80>
  40219f:	83 fa 21             	cmp    $0x21,%edx
  4021a2:	0f 95 c2             	setne  %dl
  4021a5:	0f b6 d2             	movzbl %dl,%edx
  4021a8:	01 d1                	add    %edx,%ecx
  4021aa:	eb b4                	jmp    402160 <.text+0x20>
  4021ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  4021b0:	80 78 01 00          	cmpb   $0x0,0x1(%eax)
  4021b4:	8d 70 02             	lea    0x2(%eax),%esi
  4021b7:	74 16                	je     4021cf <.text+0x8f>
  4021b9:	89 f0                	mov    %esi,%eax
  4021bb:	eb b6                	jmp    402173 <.text+0x33>
  4021bd:	8d 76 00             	lea    0x0(%esi),%esi
  4021c0:	ba 01 00 00 00       	mov    $0x1,%edx
  4021c5:	89 d0                	mov    %edx,%eax
  4021c7:	5b                   	pop    %ebx
  4021c8:	5e                   	pop    %esi
  4021c9:	c3                   	ret    
  4021ca:	31 d2                	xor    %edx,%edx
  4021cc:	89 d0                	mov    %edx,%eax
  4021ce:	c3                   	ret    
  4021cf:	31 d2                	xor    %edx,%edx
  4021d1:	eb bd                	jmp    402190 <.text+0x50>
  4021d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  4021d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  4021e0:	85 c0                	test   %eax,%eax
  4021e2:	74 5c                	je     402240 <.text+0x100>
  4021e4:	56                   	push   %esi
  4021e5:	53                   	push   %ebx
  4021e6:	89 c6                	mov    %eax,%esi
  4021e8:	83 ec 14             	sub    $0x14,%esp
  4021eb:	8b 40 0c             	mov    0xc(%eax),%eax
  4021ee:	8d 58 01             	lea    0x1(%eax),%ebx
  4021f1:	8d 04 9d 00 00 00 00 	lea    0x0(,%ebx,4),%eax
  4021f8:	89 04 24             	mov    %eax,(%esp)
  4021fb:	e8 08 19 00 00       	call   403b08 <_malloc>
  402200:	89 c1                	mov    %eax,%ecx
  402202:	89 46 08             	mov    %eax,0x8(%esi)
  402205:	b8 03 00 00 00       	mov    $0x3,%eax
  40220a:	85 c9                	test   %ecx,%ecx
  40220c:	74 22                	je     402230 <.text+0xf0>
  40220e:	85 db                	test   %ebx,%ebx
  402210:	89 da                	mov    %ebx,%edx
  402212:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
  402219:	7e 13                	jle    40222e <.text+0xee>
  40221b:	90                   	nop
  40221c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  402220:	83 ea 01             	sub    $0x1,%edx
  402223:	85 d2                	test   %edx,%edx
  402225:	c7 04 91 00 00 00 00 	movl   $0x0,(%ecx,%edx,4)
  40222c:	75 f2                	jne    402220 <.text+0xe0>
  40222e:	31 c0                	xor    %eax,%eax
  402230:	83 c4 14             	add    $0x14,%esp
  402233:	5b                   	pop    %ebx
  402234:	5e                   	pop    %esi
  402235:	c3                   	ret    
  402236:	8d 76 00             	lea    0x0(%esi),%esi
  402239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  402240:	31 c0                	xor    %eax,%eax
  402242:	c3                   	ret    
  402243:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  402249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  402250:	55                   	push   %ebp
  402251:	57                   	push   %edi
  402252:	89 c7                	mov    %eax,%edi
  402254:	56                   	push   %esi
  402255:	53                   	push   %ebx
  402256:	83 ec 3c             	sub    $0x3c,%esp
  402259:	0f be 18             	movsbl (%eax),%ebx
  40225c:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  402260:	89 4c 24 20          	mov    %ecx,0x20(%esp)
  402264:	83 fb 5d             	cmp    $0x5d,%ebx
  402267:	89 dd                	mov    %ebx,%ebp
  402269:	0f 84 61 01 00 00    	je     4023d0 <.text+0x290>
  40226f:	83 fb 2d             	cmp    $0x2d,%ebx
  402272:	0f 84 58 01 00 00    	je     4023d0 <.text+0x290>
  402278:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
  40227c:	89 c8                	mov    %ecx,%eax
  40227e:	f7 d0                	not    %eax
  402280:	89 44 24 28          	mov    %eax,0x28(%esp)
  402284:	b8 01 00 00 00       	mov    $0x1,%eax
  402289:	29 c8                	sub    %ecx,%eax
  40228b:	89 44 24 2c          	mov    %eax,0x2c(%esp)
  40228f:	eb 0d                	jmp    40229e <.text+0x15e>
  402291:	89 ee                	mov    %ebp,%esi
  402293:	2b 74 24 1c          	sub    0x1c(%esp),%esi
  402297:	85 f6                	test   %esi,%esi
  402299:	74 68                	je     402303 <.text+0x1c3>
  40229b:	0f be da             	movsbl %dl,%ebx
  40229e:	83 fb 5d             	cmp    $0x5d,%ebx
  4022a1:	8d 77 01             	lea    0x1(%edi),%esi
  4022a4:	0f 84 1a 01 00 00    	je     4023c4 <.text+0x284>
  4022aa:	83 fb 2d             	cmp    $0x2d,%ebx
  4022ad:	0f 84 8d 00 00 00    	je     402340 <.text+0x200>
  4022b3:	85 db                	test   %ebx,%ebx
  4022b5:	0f 84 09 01 00 00    	je     4023c4 <.text+0x284>
  4022bb:	83 fb 2f             	cmp    $0x2f,%ebx
  4022be:	0f 84 00 01 00 00    	je     4023c4 <.text+0x284>
  4022c4:	83 fb 5c             	cmp    $0x5c,%ebx
  4022c7:	0f 84 f7 00 00 00    	je     4023c4 <.text+0x284>
  4022cd:	0f b6 16             	movzbl (%esi),%edx
  4022d0:	89 dd                	mov    %ebx,%ebp
  4022d2:	89 f7                	mov    %esi,%edi
  4022d4:	f7 44 24 20 00 40 00 	testl  $0x4000,0x20(%esp)
  4022db:	00 
  4022dc:	75 b3                	jne    402291 <.text+0x151>
  4022de:	89 2c 24             	mov    %ebp,(%esp)
  4022e1:	88 54 24 24          	mov    %dl,0x24(%esp)
  4022e5:	e8 d6 17 00 00       	call   403ac0 <_tolower>
  4022ea:	89 c6                	mov    %eax,%esi
  4022ec:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  4022f0:	89 04 24             	mov    %eax,(%esp)
  4022f3:	e8 c8 17 00 00       	call   403ac0 <_tolower>
  4022f8:	29 c6                	sub    %eax,%esi
  4022fa:	0f b6 54 24 24       	movzbl 0x24(%esp),%edx
  4022ff:	85 f6                	test   %esi,%esi
  402301:	75 98                	jne    40229b <.text+0x15b>
  402303:	8b 44 24 20          	mov    0x20(%esp),%eax
  402307:	83 e0 20             	and    $0x20,%eax
  40230a:	eb 12                	jmp    40231e <.text+0x1de>
  40230c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  402310:	83 c7 01             	add    $0x1,%edi
  402313:	84 d2                	test   %dl,%dl
  402315:	0f 84 a9 00 00 00    	je     4023c4 <.text+0x284>
  40231b:	0f b6 17             	movzbl (%edi),%edx
  40231e:	80 fa 5d             	cmp    $0x5d,%dl
  402321:	0f 84 3e 01 00 00    	je     402465 <.text+0x325>
  402327:	80 fa 7f             	cmp    $0x7f,%dl
  40232a:	75 e4                	jne    402310 <.text+0x1d0>
  40232c:	85 c0                	test   %eax,%eax
  40232e:	0f 85 3c 01 00 00    	jne    402470 <.text+0x330>
  402334:	0f b6 57 01          	movzbl 0x1(%edi),%edx
  402338:	83 c7 01             	add    $0x1,%edi
  40233b:	eb d3                	jmp    402310 <.text+0x1d0>
  40233d:	8d 76 00             	lea    0x0(%esi),%esi
  402340:	0f b6 57 01          	movzbl 0x1(%edi),%edx
  402344:	80 fa 5d             	cmp    $0x5d,%dl
  402347:	0f 84 95 00 00 00    	je     4023e2 <.text+0x2a2>
  40234d:	0f be da             	movsbl %dl,%ebx
  402350:	85 db                	test   %ebx,%ebx
  402352:	74 70                	je     4023c4 <.text+0x284>
  402354:	8b 4c 24 20          	mov    0x20(%esp),%ecx
  402358:	8d 77 02             	lea    0x2(%edi),%esi
  40235b:	81 e1 00 40 00 00    	and    $0x4000,%ecx
  402361:	39 dd                	cmp    %ebx,%ebp
  402363:	0f 8d 0f 01 00 00    	jge    402478 <.text+0x338>
  402369:	89 74 24 24          	mov    %esi,0x24(%esp)
  40236d:	89 e8                	mov    %ebp,%eax
  40236f:	89 ce                	mov    %ecx,%esi
  402371:	eb 11                	jmp    402384 <.text+0x244>
  402373:	8b 44 24 28          	mov    0x28(%esp),%eax
  402377:	8d 3c 28             	lea    (%eax,%ebp,1),%edi
  40237a:	85 ff                	test   %edi,%edi
  40237c:	74 29                	je     4023a7 <.text+0x267>
  40237e:	39 eb                	cmp    %ebp,%ebx
  402380:	89 e8                	mov    %ebp,%eax
  402382:	74 6c                	je     4023f0 <.text+0x2b0>
  402384:	85 f6                	test   %esi,%esi
  402386:	8d 68 01             	lea    0x1(%eax),%ebp
  402389:	75 e8                	jne    402373 <.text+0x233>
  40238b:	89 04 24             	mov    %eax,(%esp)
  40238e:	e8 2d 17 00 00       	call   403ac0 <_tolower>
  402393:	89 c7                	mov    %eax,%edi
  402395:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  402399:	89 04 24             	mov    %eax,(%esp)
  40239c:	e8 1f 17 00 00       	call   403ac0 <_tolower>
  4023a1:	29 c7                	sub    %eax,%edi
  4023a3:	85 ff                	test   %edi,%edi
  4023a5:	75 d7                	jne    40237e <.text+0x23e>
  4023a7:	8b 54 24 20          	mov    0x20(%esp),%edx
  4023ab:	8b 74 24 24          	mov    0x24(%esp),%esi
  4023af:	83 e2 20             	and    $0x20,%edx
  4023b2:	0f b6 06             	movzbl (%esi),%eax
  4023b5:	3c 5d                	cmp    $0x5d,%al
  4023b7:	74 61                	je     40241a <.text+0x2da>
  4023b9:	3c 7f                	cmp    $0x7f,%al
  4023bb:	74 43                	je     402400 <.text+0x2c0>
  4023bd:	83 c6 01             	add    $0x1,%esi
  4023c0:	84 c0                	test   %al,%al
  4023c2:	75 ee                	jne    4023b2 <.text+0x272>
  4023c4:	83 c4 3c             	add    $0x3c,%esp
  4023c7:	31 c0                	xor    %eax,%eax
  4023c9:	5b                   	pop    %ebx
  4023ca:	5e                   	pop    %esi
  4023cb:	5f                   	pop    %edi
  4023cc:	5d                   	pop    %ebp
  4023cd:	c3                   	ret    
  4023ce:	66 90                	xchg   %ax,%ax
  4023d0:	3b 5c 24 1c          	cmp    0x1c(%esp),%ebx
  4023d4:	74 4f                	je     402425 <.text+0x2e5>
  4023d6:	0f be 5f 01          	movsbl 0x1(%edi),%ebx
  4023da:	83 c7 01             	add    $0x1,%edi
  4023dd:	e9 96 fe ff ff       	jmp    402278 <.text+0x138>
  4023e2:	bd 2d 00 00 00       	mov    $0x2d,%ebp
  4023e7:	89 f7                	mov    %esi,%edi
  4023e9:	e9 e6 fe ff ff       	jmp    4022d4 <.text+0x194>
  4023ee:	66 90                	xchg   %ax,%ax
  4023f0:	8b 74 24 24          	mov    0x24(%esp),%esi
  4023f4:	e9 c2 fe ff ff       	jmp    4022bb <.text+0x17b>
  4023f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  402400:	85 d2                	test   %edx,%edx
  402402:	75 0c                	jne    402410 <.text+0x2d0>
  402404:	0f b6 46 01          	movzbl 0x1(%esi),%eax
  402408:	83 c6 01             	add    $0x1,%esi
  40240b:	eb b0                	jmp    4023bd <.text+0x27d>
  40240d:	8d 76 00             	lea    0x0(%esi),%esi
  402410:	83 c6 01             	add    $0x1,%esi
  402413:	0f b6 06             	movzbl (%esi),%eax
  402416:	3c 5d                	cmp    $0x5d,%al
  402418:	75 9f                	jne    4023b9 <.text+0x279>
  40241a:	83 c4 3c             	add    $0x3c,%esp
  40241d:	8d 46 01             	lea    0x1(%esi),%eax
  402420:	5b                   	pop    %ebx
  402421:	5e                   	pop    %esi
  402422:	5f                   	pop    %edi
  402423:	5d                   	pop    %ebp
  402424:	c3                   	ret    
  402425:	8b 54 24 20          	mov    0x20(%esp),%edx
  402429:	83 c7 01             	add    $0x1,%edi
  40242c:	83 e2 20             	and    $0x20,%edx
  40242f:	90                   	nop
  402430:	0f b6 07             	movzbl (%edi),%eax
  402433:	3c 5d                	cmp    $0x5d,%al
  402435:	74 2e                	je     402465 <.text+0x325>
  402437:	3c 7f                	cmp    $0x7f,%al
  402439:	74 15                	je     402450 <.text+0x310>
  40243b:	83 c7 01             	add    $0x1,%edi
  40243e:	84 c0                	test   %al,%al
  402440:	75 ee                	jne    402430 <.text+0x2f0>
  402442:	e9 7d ff ff ff       	jmp    4023c4 <.text+0x284>
  402447:	89 f6                	mov    %esi,%esi
  402449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  402450:	85 d2                	test   %edx,%edx
  402452:	75 0c                	jne    402460 <.text+0x320>
  402454:	0f b6 47 01          	movzbl 0x1(%edi),%eax
  402458:	83 c7 01             	add    $0x1,%edi
  40245b:	eb de                	jmp    40243b <.text+0x2fb>
  40245d:	8d 76 00             	lea    0x0(%esi),%esi
  402460:	83 c7 01             	add    $0x1,%edi
  402463:	eb cb                	jmp    402430 <.text+0x2f0>
  402465:	83 c4 3c             	add    $0x3c,%esp
  402468:	8d 47 01             	lea    0x1(%edi),%eax
  40246b:	5b                   	pop    %ebx
  40246c:	5e                   	pop    %esi
  40246d:	5f                   	pop    %edi
  40246e:	5d                   	pop    %ebp
  40246f:	c3                   	ret    
  402470:	83 c7 01             	add    $0x1,%edi
  402473:	e9 a3 fe ff ff       	jmp    40231b <.text+0x1db>
  402478:	0f 8e 3d fe ff ff    	jle    4022bb <.text+0x17b>
  40247e:	89 74 24 24          	mov    %esi,0x24(%esp)
  402482:	89 ce                	mov    %ecx,%esi
  402484:	eb 1f                	jmp    4024a5 <.text+0x365>
  402486:	8d 76 00             	lea    0x0(%esi),%esi
  402489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  402490:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  402494:	8d 2c 38             	lea    (%eax,%edi,1),%ebp
  402497:	85 ed                	test   %ebp,%ebp
  402499:	74 2d                	je     4024c8 <.text+0x388>
  40249b:	39 fb                	cmp    %edi,%ebx
  40249d:	89 fd                	mov    %edi,%ebp
  40249f:	0f 84 4b ff ff ff    	je     4023f0 <.text+0x2b0>
  4024a5:	85 f6                	test   %esi,%esi
  4024a7:	8d 7d ff             	lea    -0x1(%ebp),%edi
  4024aa:	75 e4                	jne    402490 <.text+0x350>
  4024ac:	89 2c 24             	mov    %ebp,(%esp)
  4024af:	e8 0c 16 00 00       	call   403ac0 <_tolower>
  4024b4:	89 c5                	mov    %eax,%ebp
  4024b6:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  4024ba:	89 04 24             	mov    %eax,(%esp)
  4024bd:	e8 fe 15 00 00       	call   403ac0 <_tolower>
  4024c2:	29 c5                	sub    %eax,%ebp
  4024c4:	85 ed                	test   %ebp,%ebp
  4024c6:	75 d3                	jne    40249b <.text+0x35b>
  4024c8:	8b 54 24 20          	mov    0x20(%esp),%edx
  4024cc:	8b 74 24 24          	mov    0x24(%esp),%esi
  4024d0:	83 e2 20             	and    $0x20,%edx
  4024d3:	0f b6 06             	movzbl (%esi),%eax
  4024d6:	3c 5d                	cmp    $0x5d,%al
  4024d8:	0f 84 3c ff ff ff    	je     40241a <.text+0x2da>
  4024de:	3c 7f                	cmp    $0x7f,%al
  4024e0:	74 0e                	je     4024f0 <.text+0x3b0>
  4024e2:	83 c6 01             	add    $0x1,%esi
  4024e5:	84 c0                	test   %al,%al
  4024e7:	75 ea                	jne    4024d3 <.text+0x393>
  4024e9:	e9 d6 fe ff ff       	jmp    4023c4 <.text+0x284>
  4024ee:	66 90                	xchg   %ax,%ax
  4024f0:	85 d2                	test   %edx,%edx
  4024f2:	75 0c                	jne    402500 <.text+0x3c0>
  4024f4:	0f b6 46 01          	movzbl 0x1(%esi),%eax
  4024f8:	83 c6 01             	add    $0x1,%esi
  4024fb:	eb e5                	jmp    4024e2 <.text+0x3a2>
  4024fd:	8d 76 00             	lea    0x0(%esi),%esi
  402500:	83 c6 01             	add    $0x1,%esi
  402503:	eb ce                	jmp    4024d3 <.text+0x393>
  402505:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  402509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  402510:	55                   	push   %ebp
  402511:	57                   	push   %edi
  402512:	89 c5                	mov    %eax,%ebp
  402514:	56                   	push   %esi
  402515:	53                   	push   %ebx
  402516:	83 ec 2c             	sub    $0x2c,%esp
  402519:	80 3a 2e             	cmpb   $0x2e,(%edx)
  40251c:	89 4c 24 14          	mov    %ecx,0x14(%esp)
  402520:	0f b6 08             	movzbl (%eax),%ecx
  402523:	0f 84 37 01 00 00    	je     402660 <.text+0x520>
  402529:	8b 44 24 14          	mov    0x14(%esp),%eax
  40252d:	8d 7a 01             	lea    0x1(%edx),%edi
  402530:	c1 e8 05             	shr    $0x5,%eax
  402533:	83 f0 01             	xor    $0x1,%eax
  402536:	89 44 24 18          	mov    %eax,0x18(%esp)
  40253a:	0f be d1             	movsbl %cl,%edx
  40253d:	8d 77 ff             	lea    -0x1(%edi),%esi
  402540:	8d 45 01             	lea    0x1(%ebp),%eax
  402543:	85 d2                	test   %edx,%edx
  402545:	0f 84 69 01 00 00    	je     4026b4 <.text+0x574>
  40254b:	80 f9 3f             	cmp    $0x3f,%cl
  40254e:	0f 84 ed 00 00 00    	je     402641 <.text+0x501>
  402554:	80 f9 5b             	cmp    $0x5b,%cl
  402557:	0f 84 b3 00 00 00    	je     402610 <.text+0x4d0>
  40255d:	80 f9 2a             	cmp    $0x2a,%cl
  402560:	74 5e                	je     4025c0 <.text+0x480>
  402562:	f6 44 24 18 01       	testb  $0x1,0x18(%esp)
  402567:	74 09                	je     402572 <.text+0x432>
  402569:	83 fa 7f             	cmp    $0x7f,%edx
  40256c:	0f 84 2e 01 00 00    	je     4026a0 <.text+0x560>
  402572:	89 c5                	mov    %eax,%ebp
  402574:	0f be 5f ff          	movsbl -0x1(%edi),%ebx
  402578:	84 db                	test   %bl,%bl
  40257a:	0f 84 86 01 00 00    	je     402706 <.text+0x5c6>
  402580:	f7 44 24 14 00 40 00 	testl  $0x4000,0x14(%esp)
  402587:	00 
  402588:	0f 85 c2 00 00 00    	jne    402650 <.text+0x510>
  40258e:	89 14 24             	mov    %edx,(%esp)
  402591:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  402595:	e8 26 15 00 00       	call   403ac0 <_tolower>
  40259a:	89 1c 24             	mov    %ebx,(%esp)
  40259d:	89 c6                	mov    %eax,%esi
  40259f:	e8 1c 15 00 00       	call   403ac0 <_tolower>
  4025a4:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  4025a8:	29 c6                	sub    %eax,%esi
  4025aa:	85 f6                	test   %esi,%esi
  4025ac:	0f 84 83 00 00 00    	je     402635 <.text+0x4f5>
  4025b2:	89 d0                	mov    %edx,%eax
  4025b4:	29 d8                	sub    %ebx,%eax
  4025b6:	83 c4 2c             	add    $0x2c,%esp
  4025b9:	5b                   	pop    %ebx
  4025ba:	5e                   	pop    %esi
  4025bb:	5f                   	pop    %edi
  4025bc:	5d                   	pop    %ebp
  4025bd:	c3                   	ret    
  4025be:	66 90                	xchg   %ax,%ax
  4025c0:	0f b6 55 01          	movzbl 0x1(%ebp),%edx
  4025c4:	89 c3                	mov    %eax,%ebx
  4025c6:	80 fa 2a             	cmp    $0x2a,%dl
  4025c9:	75 10                	jne    4025db <.text+0x49b>
  4025cb:	90                   	nop
  4025cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  4025d0:	83 c3 01             	add    $0x1,%ebx
  4025d3:	0f b6 13             	movzbl (%ebx),%edx
  4025d6:	80 fa 2a             	cmp    $0x2a,%dl
  4025d9:	74 f5                	je     4025d0 <.text+0x490>
  4025db:	31 c0                	xor    %eax,%eax
  4025dd:	84 d2                	test   %dl,%dl
  4025df:	74 d5                	je     4025b6 <.text+0x476>
  4025e1:	8b 7c 24 14          	mov    0x14(%esp),%edi
  4025e5:	81 cf 00 00 01 00    	or     $0x10000,%edi
  4025eb:	eb 0c                	jmp    4025f9 <.text+0x4b9>
  4025ed:	8d 76 00             	lea    0x0(%esi),%esi
  4025f0:	83 c6 01             	add    $0x1,%esi
  4025f3:	80 7e ff 00          	cmpb   $0x0,-0x1(%esi)
  4025f7:	74 bd                	je     4025b6 <.text+0x476>
  4025f9:	89 f9                	mov    %edi,%ecx
  4025fb:	89 f2                	mov    %esi,%edx
  4025fd:	89 d8                	mov    %ebx,%eax
  4025ff:	e8 0c ff ff ff       	call   402510 <.text+0x3d0>
  402604:	85 c0                	test   %eax,%eax
  402606:	75 e8                	jne    4025f0 <.text+0x4b0>
  402608:	83 c4 2c             	add    $0x2c,%esp
  40260b:	5b                   	pop    %ebx
  40260c:	5e                   	pop    %esi
  40260d:	5f                   	pop    %edi
  40260e:	5d                   	pop    %ebp
  40260f:	c3                   	ret    
  402610:	0f be 57 ff          	movsbl -0x1(%edi),%edx
  402614:	85 d2                	test   %edx,%edx
  402616:	0f 84 fb 00 00 00    	je     402717 <.text+0x5d7>
  40261c:	80 7d 01 21          	cmpb   $0x21,0x1(%ebp)
  402620:	74 60                	je     402682 <.text+0x542>
  402622:	8b 4c 24 14          	mov    0x14(%esp),%ecx
  402626:	e8 25 fc ff ff       	call   402250 <.text+0x110>
  40262b:	89 c5                	mov    %eax,%ebp
  40262d:	85 ed                	test   %ebp,%ebp
  40262f:	0f 84 c7 00 00 00    	je     4026fc <.text+0x5bc>
  402635:	0f b6 4d 00          	movzbl 0x0(%ebp),%ecx
  402639:	83 c7 01             	add    $0x1,%edi
  40263c:	e9 f9 fe ff ff       	jmp    40253a <.text+0x3fa>
  402641:	80 7f ff 00          	cmpb   $0x0,-0x1(%edi)
  402645:	0f 84 c2 00 00 00    	je     40270d <.text+0x5cd>
  40264b:	89 c5                	mov    %eax,%ebp
  40264d:	eb e6                	jmp    402635 <.text+0x4f5>
  40264f:	90                   	nop
  402650:	89 d6                	mov    %edx,%esi
  402652:	29 de                	sub    %ebx,%esi
  402654:	e9 51 ff ff ff       	jmp    4025aa <.text+0x46a>
  402659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  402660:	80 f9 2e             	cmp    $0x2e,%cl
  402663:	0f 84 c0 fe ff ff    	je     402529 <.text+0x3e9>
  402669:	0f be c1             	movsbl %cl,%eax
  40266c:	83 e8 2e             	sub    $0x2e,%eax
  40266f:	f7 44 24 14 00 00 01 	testl  $0x10000,0x14(%esp)
  402676:	00 
  402677:	0f 85 ac fe ff ff    	jne    402529 <.text+0x3e9>
  40267d:	e9 34 ff ff ff       	jmp    4025b6 <.text+0x476>
  402682:	8d 5d 02             	lea    0x2(%ebp),%ebx
  402685:	8b 4c 24 14          	mov    0x14(%esp),%ecx
  402689:	89 d8                	mov    %ebx,%eax
  40268b:	e8 c0 fb ff ff       	call   402250 <.text+0x110>
  402690:	85 c0                	test   %eax,%eax
  402692:	74 2a                	je     4026be <.text+0x57e>
  402694:	89 dd                	mov    %ebx,%ebp
  402696:	eb 95                	jmp    40262d <.text+0x4ed>
  402698:	90                   	nop
  402699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  4026a0:	0f be 55 01          	movsbl 0x1(%ebp),%edx
  4026a4:	83 c5 02             	add    $0x2,%ebp
  4026a7:	85 d2                	test   %edx,%edx
  4026a9:	0f 85 c5 fe ff ff    	jne    402574 <.text+0x434>
  4026af:	e9 be fe ff ff       	jmp    402572 <.text+0x432>
  4026b4:	0f be 06             	movsbl (%esi),%eax
  4026b7:	f7 d8                	neg    %eax
  4026b9:	e9 f8 fe ff ff       	jmp    4025b6 <.text+0x476>
  4026be:	0f b6 45 02          	movzbl 0x2(%ebp),%eax
  4026c2:	3c 5d                	cmp    $0x5d,%al
  4026c4:	74 5b                	je     402721 <.text+0x5e1>
  4026c6:	8b 54 24 14          	mov    0x14(%esp),%edx
  4026ca:	83 e2 20             	and    $0x20,%edx
  4026cd:	eb 0b                	jmp    4026da <.text+0x59a>
  4026cf:	90                   	nop
  4026d0:	83 c3 01             	add    $0x1,%ebx
  4026d3:	84 c0                	test   %al,%al
  4026d5:	74 25                	je     4026fc <.text+0x5bc>
  4026d7:	0f b6 03             	movzbl (%ebx),%eax
  4026da:	3c 5d                	cmp    $0x5d,%al
  4026dc:	74 16                	je     4026f4 <.text+0x5b4>
  4026de:	3c 7f                	cmp    $0x7f,%al
  4026e0:	75 ee                	jne    4026d0 <.text+0x590>
  4026e2:	85 d2                	test   %edx,%edx
  4026e4:	75 09                	jne    4026ef <.text+0x5af>
  4026e6:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
  4026ea:	83 c3 01             	add    $0x1,%ebx
  4026ed:	eb e1                	jmp    4026d0 <.text+0x590>
  4026ef:	83 c3 01             	add    $0x1,%ebx
  4026f2:	eb e3                	jmp    4026d7 <.text+0x597>
  4026f4:	8d 6b 01             	lea    0x1(%ebx),%ebp
  4026f7:	e9 31 ff ff ff       	jmp    40262d <.text+0x4ed>
  4026fc:	b8 5d 00 00 00       	mov    $0x5d,%eax
  402701:	e9 b0 fe ff ff       	jmp    4025b6 <.text+0x476>
  402706:	31 db                	xor    %ebx,%ebx
  402708:	e9 a5 fe ff ff       	jmp    4025b2 <.text+0x472>
  40270d:	b8 3f 00 00 00       	mov    $0x3f,%eax
  402712:	e9 9f fe ff ff       	jmp    4025b6 <.text+0x476>
  402717:	b8 5b 00 00 00       	mov    $0x5b,%eax
  40271c:	e9 95 fe ff ff       	jmp    4025b6 <.text+0x476>
  402721:	8d 5d 03             	lea    0x3(%ebp),%ebx
  402724:	0f b6 45 03          	movzbl 0x3(%ebp),%eax
  402728:	eb 9c                	jmp    4026c6 <.text+0x586>
  40272a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  402730:	57                   	push   %edi
  402731:	56                   	push   %esi
  402732:	89 c6                	mov    %eax,%esi
  402734:	53                   	push   %ebx
  402735:	89 d3                	mov    %edx,%ebx
  402737:	83 ec 10             	sub    $0x10,%esp
  40273a:	8b 42 0c             	mov    0xc(%edx),%eax
  40273d:	03 42 04             	add    0x4(%edx),%eax
  402740:	8d 04 85 08 00 00 00 	lea    0x8(,%eax,4),%eax
  402747:	89 44 24 04          	mov    %eax,0x4(%esp)
  40274b:	8b 42 08             	mov    0x8(%edx),%eax
  40274e:	89 04 24             	mov    %eax,(%esp)
  402751:	e8 92 13 00 00       	call   403ae8 <_realloc>
  402756:	85 c0                	test   %eax,%eax
  402758:	74 26                	je     402780 <.text+0x640>
  40275a:	8b 4b 04             	mov    0x4(%ebx),%ecx
  40275d:	8b 53 0c             	mov    0xc(%ebx),%edx
  402760:	89 43 08             	mov    %eax,0x8(%ebx)
  402763:	8d 79 01             	lea    0x1(%ecx),%edi
  402766:	01 d1                	add    %edx,%ecx
  402768:	01 fa                	add    %edi,%edx
  40276a:	89 7b 04             	mov    %edi,0x4(%ebx)
  40276d:	89 34 88             	mov    %esi,(%eax,%ecx,4)
  402770:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
  402777:	83 c4 10             	add    $0x10,%esp
  40277a:	31 c0                	xor    %eax,%eax
  40277c:	5b                   	pop    %ebx
  40277d:	5e                   	pop    %esi
  40277e:	5f                   	pop    %edi
  40277f:	c3                   	ret    
  402780:	83 c4 10             	add    $0x10,%esp
  402783:	b8 01 00 00 00       	mov    $0x1,%eax
  402788:	5b                   	pop    %ebx
  402789:	5e                   	pop    %esi
  40278a:	5f                   	pop    %edi
  40278b:	c3                   	ret    
  40278c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  402790:	56                   	push   %esi
  402791:	53                   	push   %ebx
  402792:	89 c3                	mov    %eax,%ebx
  402794:	89 d6                	mov    %edx,%esi
  402796:	83 ec 14             	sub    $0x14,%esp
  402799:	8b 00                	mov    (%eax),%eax
  40279b:	85 c0                	test   %eax,%eax
  40279d:	74 05                	je     4027a4 <.text+0x664>
  40279f:	e8 ec ff ff ff       	call   402790 <.text+0x650>
  4027a4:	8b 43 08             	mov    0x8(%ebx),%eax
  4027a7:	85 c0                	test   %eax,%eax
  4027a9:	74 04                	je     4027af <.text+0x66f>
  4027ab:	85 f6                	test   %esi,%esi
  4027ad:	75 21                	jne    4027d0 <.text+0x690>
  4027af:	8b 43 04             	mov    0x4(%ebx),%eax
  4027b2:	85 c0                	test   %eax,%eax
  4027b4:	74 07                	je     4027bd <.text+0x67d>
  4027b6:	89 f2                	mov    %esi,%edx
  4027b8:	e8 d3 ff ff ff       	call   402790 <.text+0x650>
  4027bd:	89 1c 24             	mov    %ebx,(%esp)
  4027c0:	e8 53 13 00 00       	call   403b18 <_free>
  4027c5:	83 c4 14             	add    $0x14,%esp
  4027c8:	5b                   	pop    %ebx
  4027c9:	5e                   	pop    %esi
  4027ca:	c3                   	ret    
  4027cb:	90                   	nop
  4027cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  4027d0:	89 f2                	mov    %esi,%edx
  4027d2:	e8 59 ff ff ff       	call   402730 <.text+0x5f0>
  4027d7:	eb d6                	jmp    4027af <.text+0x66f>
  4027d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  4027e0:	55                   	push   %ebp
  4027e1:	89 e5                	mov    %esp,%ebp
  4027e3:	57                   	push   %edi
  4027e4:	56                   	push   %esi
  4027e5:	53                   	push   %ebx
  4027e6:	89 c3                	mov    %eax,%ebx
  4027e8:	83 ec 6c             	sub    $0x6c,%esp
  4027eb:	89 55 d0             	mov    %edx,-0x30(%ebp)
  4027ee:	80 e6 04             	and    $0x4,%dh
  4027f1:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  4027f4:	0f 85 56 03 00 00    	jne    402b50 <.text+0xa10>
  4027fa:	89 65 a8             	mov    %esp,-0x58(%ebp)
  4027fd:	89 1c 24             	mov    %ebx,(%esp)
  402800:	e8 c3 12 00 00       	call   403ac8 <_strlen>
  402805:	8d 50 01             	lea    0x1(%eax),%edx
  402808:	83 c0 10             	add    $0x10,%eax
  40280b:	c1 e8 04             	shr    $0x4,%eax
  40280e:	c1 e0 04             	shl    $0x4,%eax
  402811:	e8 8a f8 ff ff       	call   4020a0 <___chkstk_ms>
  402816:	29 c4                	sub    %eax,%esp
  402818:	8d 44 24 0c          	lea    0xc(%esp),%eax
  40281c:	89 54 24 08          	mov    %edx,0x8(%esp)
  402820:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  402824:	89 04 24             	mov    %eax,(%esp)
  402827:	e8 cc 12 00 00       	call   403af8 <_memcpy>
  40282c:	89 04 24             	mov    %eax,(%esp)
  40282f:	e8 8c 09 00 00       	call   4031c0 <___mingw_dirname>
  402834:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  402837:	89 c6                	mov    %eax,%esi
  402839:	8d 45 d8             	lea    -0x28(%ebp),%eax
  40283c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  402843:	e8 98 f9 ff ff       	call   4021e0 <.text+0xa0>
  402848:	85 c0                	test   %eax,%eax
  40284a:	89 45 cc             	mov    %eax,-0x34(%ebp)
  40284d:	0f 85 ed 02 00 00    	jne    402b40 <.text+0xa00>
  402853:	8b 7d d0             	mov    -0x30(%ebp),%edi
  402856:	89 f0                	mov    %esi,%eax
  402858:	89 fa                	mov    %edi,%edx
  40285a:	e8 e1 f8 ff ff       	call   402140 <.text>
  40285f:	85 c0                	test   %eax,%eax
  402861:	0f 84 d7 04 00 00    	je     402d3e <.text+0xbfe>
  402867:	8d 45 d8             	lea    -0x28(%ebp),%eax
  40286a:	89 fa                	mov    %edi,%edx
  40286c:	80 ce 80             	or     $0x80,%dh
  40286f:	89 04 24             	mov    %eax,(%esp)
  402872:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  402875:	89 f0                	mov    %esi,%eax
  402877:	e8 64 ff ff ff       	call   4027e0 <.text+0x6a0>
  40287c:	89 45 cc             	mov    %eax,-0x34(%ebp)
  40287f:	8b 4d cc             	mov    -0x34(%ebp),%ecx
  402882:	85 c9                	test   %ecx,%ecx
  402884:	0f 85 b6 02 00 00    	jne    402b40 <.text+0xa00>
  40288a:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
  40288e:	3c 2f                	cmp    $0x2f,%al
  402890:	74 19                	je     4028ab <.text+0x76b>
  402892:	3c 5c                	cmp    $0x5c,%al
  402894:	74 15                	je     4028ab <.text+0x76b>
  402896:	8b 75 d4             	mov    -0x2c(%ebp),%esi
  402899:	bf 18 51 40 00       	mov    $0x405118,%edi
  40289e:	b9 02 00 00 00       	mov    $0x2,%ecx
  4028a3:	f3 a6                	repz cmpsb %es:(%edi),%ds:(%esi)
  4028a5:	0f 84 0b 05 00 00    	je     402db6 <.text+0xc76>
  4028ab:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  4028ae:	89 04 24             	mov    %eax,(%esp)
  4028b1:	e8 12 12 00 00       	call   403ac8 <_strlen>
  4028b6:	01 d8                	add    %ebx,%eax
  4028b8:	39 c3                	cmp    %eax,%ebx
  4028ba:	0f 83 66 07 00 00    	jae    403026 <.text+0xee6>
  4028c0:	0f b6 08             	movzbl (%eax),%ecx
  4028c3:	80 f9 2f             	cmp    $0x2f,%cl
  4028c6:	88 4d a3             	mov    %cl,-0x5d(%ebp)
  4028c9:	0f 84 4f 07 00 00    	je     40301e <.text+0xede>
  4028cf:	80 f9 5c             	cmp    $0x5c,%cl
  4028d2:	75 24                	jne    4028f8 <.text+0x7b8>
  4028d4:	e9 45 07 00 00       	jmp    40301e <.text+0xede>
  4028d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  4028e0:	0f b6 48 ff          	movzbl -0x1(%eax),%ecx
  4028e4:	89 d0                	mov    %edx,%eax
  4028e6:	80 f9 2f             	cmp    $0x2f,%cl
  4028e9:	0f 84 6b 06 00 00    	je     402f5a <.text+0xe1a>
  4028ef:	80 f9 5c             	cmp    $0x5c,%cl
  4028f2:	0f 84 62 06 00 00    	je     402f5a <.text+0xe1a>
  4028f8:	8d 50 ff             	lea    -0x1(%eax),%edx
  4028fb:	39 d3                	cmp    %edx,%ebx
  4028fd:	75 e1                	jne    4028e0 <.text+0x7a0>
  4028ff:	0f b6 40 ff          	movzbl -0x1(%eax),%eax
  402903:	89 55 c8             	mov    %edx,-0x38(%ebp)
  402906:	88 45 a3             	mov    %al,-0x5d(%ebp)
  402909:	0f b6 45 a3          	movzbl -0x5d(%ebp),%eax
  40290d:	3c 2f                	cmp    $0x2f,%al
  40290f:	74 08                	je     402919 <.text+0x7d9>
  402911:	3c 5c                	cmp    $0x5c,%al
  402913:	0f 85 72 06 00 00    	jne    402f8b <.text+0xe4b>
  402919:	8b 55 c8             	mov    -0x38(%ebp),%edx
  40291c:	0f b6 75 a3          	movzbl -0x5d(%ebp),%esi
  402920:	eb 02                	jmp    402924 <.text+0x7e4>
  402922:	89 c6                	mov    %eax,%esi
  402924:	83 c2 01             	add    $0x1,%edx
  402927:	0f b6 02             	movzbl (%edx),%eax
  40292a:	3c 2f                	cmp    $0x2f,%al
  40292c:	0f 94 c3             	sete   %bl
  40292f:	3c 5c                	cmp    $0x5c,%al
  402931:	0f 94 c1             	sete   %cl
  402934:	08 cb                	or     %cl,%bl
  402936:	75 ea                	jne    402922 <.text+0x7e2>
  402938:	89 f0                	mov    %esi,%eax
  40293a:	89 55 c8             	mov    %edx,-0x38(%ebp)
  40293d:	88 45 a3             	mov    %al,-0x5d(%ebp)
  402940:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  402943:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  402946:	8b 45 e0             	mov    -0x20(%ebp),%eax
  402949:	8b 7d d0             	mov    -0x30(%ebp),%edi
  40294c:	c7 45 cc 02 00 00 00 	movl   $0x2,-0x34(%ebp)
  402953:	89 45 bc             	mov    %eax,-0x44(%ebp)
  402956:	8b 00                	mov    (%eax),%eax
  402958:	81 e7 00 80 00 00    	and    $0x8000,%edi
  40295e:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  402961:	85 c0                	test   %eax,%eax
  402963:	0f 84 11 05 00 00    	je     402e7a <.text+0xd3a>
  402969:	89 04 24             	mov    %eax,(%esp)
  40296c:	e8 cf 0d 00 00       	call   403740 <___mingw_opendir>
  402971:	85 c0                	test   %eax,%eax
  402973:	89 c7                	mov    %eax,%edi
  402975:	0f 84 b8 04 00 00    	je     402e33 <.text+0xcf3>
  40297b:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  40297e:	85 c0                	test   %eax,%eax
  402980:	0f 84 74 05 00 00    	je     402efa <.text+0xdba>
  402986:	8b 45 bc             	mov    -0x44(%ebp),%eax
  402989:	8b 00                	mov    (%eax),%eax
  40298b:	89 04 24             	mov    %eax,(%esp)
  40298e:	e8 35 11 00 00       	call   403ac8 <_strlen>
  402993:	89 45 c0             	mov    %eax,-0x40(%ebp)
  402996:	8b 45 c0             	mov    -0x40(%ebp),%eax
  402999:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
  4029a0:	83 c0 02             	add    $0x2,%eax
  4029a3:	89 45 ac             	mov    %eax,-0x54(%ebp)
  4029a6:	8d 76 00             	lea    0x0(%esi),%esi
  4029a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  4029b0:	89 3c 24             	mov    %edi,(%esp)
  4029b3:	e8 48 0f 00 00       	call   403900 <___mingw_readdir>
  4029b8:	85 c0                	test   %eax,%eax
  4029ba:	89 c6                	mov    %eax,%esi
  4029bc:	0f 84 11 04 00 00    	je     402dd3 <.text+0xc93>
  4029c2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  4029c5:	85 c0                	test   %eax,%eax
  4029c7:	74 06                	je     4029cf <.text+0x88f>
  4029c9:	83 7e 08 10          	cmpl   $0x10,0x8(%esi)
  4029cd:	75 e1                	jne    4029b0 <.text+0x870>
  4029cf:	8d 5e 0c             	lea    0xc(%esi),%ebx
  4029d2:	8b 4d d0             	mov    -0x30(%ebp),%ecx
  4029d5:	8b 45 c8             	mov    -0x38(%ebp),%eax
  4029d8:	89 da                	mov    %ebx,%edx
  4029da:	e8 31 fb ff ff       	call   402510 <.text+0x3d0>
  4029df:	85 c0                	test   %eax,%eax
  4029e1:	75 cd                	jne    4029b0 <.text+0x870>
  4029e3:	0f b7 56 06          	movzwl 0x6(%esi),%edx
  4029e7:	8b 45 ac             	mov    -0x54(%ebp),%eax
  4029ea:	89 65 b0             	mov    %esp,-0x50(%ebp)
  4029ed:	8d 44 02 0f          	lea    0xf(%edx,%eax,1),%eax
  4029f1:	c1 e8 04             	shr    $0x4,%eax
  4029f4:	c1 e0 04             	shl    $0x4,%eax
  4029f7:	e8 a4 f6 ff ff       	call   4020a0 <___chkstk_ms>
  4029fc:	29 c4                	sub    %eax,%esp
  4029fe:	8b 45 c0             	mov    -0x40(%ebp),%eax
  402a01:	c7 45 b4 00 00 00 00 	movl   $0x0,-0x4c(%ebp)
  402a08:	8d 74 24 0c          	lea    0xc(%esp),%esi
  402a0c:	85 c0                	test   %eax,%eax
  402a0e:	0f 85 7c 04 00 00    	jne    402e90 <.text+0xd50>
  402a14:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  402a17:	83 c2 01             	add    $0x1,%edx
  402a1a:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  402a1e:	89 54 24 08          	mov    %edx,0x8(%esp)
  402a22:	89 e3                	mov    %esp,%ebx
  402a24:	01 f0                	add    %esi,%eax
  402a26:	89 04 24             	mov    %eax,(%esp)
  402a29:	e8 ca 10 00 00       	call   403af8 <_memcpy>
  402a2e:	89 34 24             	mov    %esi,(%esp)
  402a31:	e8 92 10 00 00       	call   403ac8 <_strlen>
  402a36:	83 c0 10             	add    $0x10,%eax
  402a39:	c1 e8 04             	shr    $0x4,%eax
  402a3c:	c1 e0 04             	shl    $0x4,%eax
  402a3f:	e8 5c f6 ff ff       	call   4020a0 <___chkstk_ms>
  402a44:	29 c4                	sub    %eax,%esp
  402a46:	89 f0                	mov    %esi,%eax
  402a48:	8d 4c 24 0c          	lea    0xc(%esp),%ecx
  402a4c:	89 ce                	mov    %ecx,%esi
  402a4e:	eb 0d                	jmp    402a5d <.text+0x91d>
  402a50:	83 c6 01             	add    $0x1,%esi
  402a53:	83 c0 01             	add    $0x1,%eax
  402a56:	84 d2                	test   %dl,%dl
  402a58:	88 56 ff             	mov    %dl,-0x1(%esi)
  402a5b:	74 1c                	je     402a79 <.text+0x939>
  402a5d:	0f b6 10             	movzbl (%eax),%edx
  402a60:	80 fa 7f             	cmp    $0x7f,%dl
  402a63:	75 eb                	jne    402a50 <.text+0x910>
  402a65:	0f b6 50 01          	movzbl 0x1(%eax),%edx
  402a69:	83 c0 01             	add    $0x1,%eax
  402a6c:	83 c6 01             	add    $0x1,%esi
  402a6f:	83 c0 01             	add    $0x1,%eax
  402a72:	84 d2                	test   %dl,%dl
  402a74:	88 56 ff             	mov    %dl,-0x1(%esi)
  402a77:	75 e4                	jne    402a5d <.text+0x91d>
  402a79:	89 0c 24             	mov    %ecx,(%esp)
  402a7c:	e8 87 11 00 00       	call   403c08 <_strdup>
  402a81:	85 c0                	test   %eax,%eax
  402a83:	89 c6                	mov    %eax,%esi
  402a85:	89 dc                	mov    %ebx,%esp
  402a87:	0f 84 47 04 00 00    	je     402ed4 <.text+0xd94>
  402a8d:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  402a90:	83 fb 02             	cmp    $0x2,%ebx
  402a93:	0f 94 c0             	sete   %al
  402a96:	0f b6 c0             	movzbl %al,%eax
  402a99:	83 e8 01             	sub    $0x1,%eax
  402a9c:	21 c3                	and    %eax,%ebx
  402a9e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  402aa1:	89 5d cc             	mov    %ebx,-0x34(%ebp)
  402aa4:	a8 40                	test   $0x40,%al
  402aa6:	0f 85 74 03 00 00    	jne    402e20 <.text+0xce0>
  402aac:	8b 5d b8             	mov    -0x48(%ebp),%ebx
  402aaf:	85 db                	test   %ebx,%ebx
  402ab1:	0f 84 ae 04 00 00    	je     402f65 <.text+0xe25>
  402ab7:	25 00 40 00 00       	and    $0x4000,%eax
  402abc:	89 7d b4             	mov    %edi,-0x4c(%ebp)
  402abf:	89 c7                	mov    %eax,%edi
  402ac1:	eb 14                	jmp    402ad7 <.text+0x997>
  402ac3:	e8 08 10 00 00       	call   403ad0 <_strcoll>
  402ac8:	85 c0                	test   %eax,%eax
  402aca:	8b 13                	mov    (%ebx),%edx
  402acc:	8b 4b 04             	mov    0x4(%ebx),%ecx
  402acf:	7e 22                	jle    402af3 <.text+0x9b3>
  402ad1:	85 c9                	test   %ecx,%ecx
  402ad3:	74 24                	je     402af9 <.text+0x9b9>
  402ad5:	89 cb                	mov    %ecx,%ebx
  402ad7:	8b 43 08             	mov    0x8(%ebx),%eax
  402ada:	85 ff                	test   %edi,%edi
  402adc:	89 34 24             	mov    %esi,(%esp)
  402adf:	89 44 24 04          	mov    %eax,0x4(%esp)
  402ae3:	75 de                	jne    402ac3 <.text+0x983>
  402ae5:	e8 16 11 00 00       	call   403c00 <_stricoll>
  402aea:	85 c0                	test   %eax,%eax
  402aec:	8b 13                	mov    (%ebx),%edx
  402aee:	8b 4b 04             	mov    0x4(%ebx),%ecx
  402af1:	7f de                	jg     402ad1 <.text+0x991>
  402af3:	89 d1                	mov    %edx,%ecx
  402af5:	85 c9                	test   %ecx,%ecx
  402af7:	75 dc                	jne    402ad5 <.text+0x995>
  402af9:	8b 7d b4             	mov    -0x4c(%ebp),%edi
  402afc:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  402aff:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
  402b06:	e8 fd 0f 00 00       	call   403b08 <_malloc>
  402b0b:	85 c0                	test   %eax,%eax
  402b0d:	0f 84 18 03 00 00    	je     402e2b <.text+0xceb>
  402b13:	8b 55 b4             	mov    -0x4c(%ebp),%edx
  402b16:	89 70 08             	mov    %esi,0x8(%eax)
  402b19:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  402b20:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  402b26:	85 d2                	test   %edx,%edx
  402b28:	0f 8e d8 03 00 00    	jle    402f06 <.text+0xdc6>
  402b2e:	89 43 04             	mov    %eax,0x4(%ebx)
  402b31:	e9 f5 02 00 00       	jmp    402e2b <.text+0xceb>
  402b36:	c7 45 cc 01 00 00 00 	movl   $0x1,-0x34(%ebp)
  402b3d:	8d 76 00             	lea    0x0(%esi),%esi
  402b40:	8b 65 a8             	mov    -0x58(%ebp),%esp
  402b43:	8b 45 cc             	mov    -0x34(%ebp),%eax
  402b46:	8d 65 f4             	lea    -0xc(%ebp),%esp
  402b49:	5b                   	pop    %ebx
  402b4a:	5e                   	pop    %esi
  402b4b:	5f                   	pop    %edi
  402b4c:	5d                   	pop    %ebp
  402b4d:	c3                   	ret    
  402b4e:	66 90                	xchg   %ax,%ax
  402b50:	89 65 c0             	mov    %esp,-0x40(%ebp)
  402b53:	89 04 24             	mov    %eax,(%esp)
  402b56:	e8 6d 0f 00 00       	call   403ac8 <_strlen>
  402b5b:	83 c0 10             	add    $0x10,%eax
  402b5e:	c1 e8 04             	shr    $0x4,%eax
  402b61:	c1 e0 04             	shl    $0x4,%eax
  402b64:	e8 37 f5 ff ff       	call   4020a0 <___chkstk_ms>
  402b69:	29 c4                	sub    %eax,%esp
  402b6b:	89 de                	mov    %ebx,%esi
  402b6d:	8d 44 24 0c          	lea    0xc(%esp),%eax
  402b71:	89 c7                	mov    %eax,%edi
  402b73:	89 45 c8             	mov    %eax,-0x38(%ebp)
  402b76:	0f b6 03             	movzbl (%ebx),%eax
  402b79:	3c 7f                	cmp    $0x7f,%al
  402b7b:	74 28                	je     402ba5 <.text+0xa65>
  402b7d:	3c 7b                	cmp    $0x7b,%al
  402b7f:	74 3f                	je     402bc0 <.text+0xa80>
  402b81:	84 c0                	test   %al,%al
  402b83:	8d 57 01             	lea    0x1(%edi),%edx
  402b86:	8d 4e 01             	lea    0x1(%esi),%ecx
  402b89:	88 07                	mov    %al,(%edi)
  402b8b:	0f 84 bc 04 00 00    	je     40304d <.text+0xf0d>
  402b91:	3c 7b                	cmp    $0x7b,%al
  402b93:	0f 84 b4 04 00 00    	je     40304d <.text+0xf0d>
  402b99:	0f b6 46 01          	movzbl 0x1(%esi),%eax
  402b9d:	89 d7                	mov    %edx,%edi
  402b9f:	89 ce                	mov    %ecx,%esi
  402ba1:	3c 7f                	cmp    $0x7f,%al
  402ba3:	75 d8                	jne    402b7d <.text+0xa3d>
  402ba5:	0f b6 46 01          	movzbl 0x1(%esi),%eax
  402ba9:	c6 07 7f             	movb   $0x7f,(%edi)
  402bac:	84 c0                	test   %al,%al
  402bae:	0f 85 ac 00 00 00    	jne    402c60 <.text+0xb20>
  402bb4:	83 c7 01             	add    $0x1,%edi
  402bb7:	83 c6 01             	add    $0x1,%esi
  402bba:	eb c5                	jmp    402b81 <.text+0xa41>
  402bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  402bc0:	89 7d cc             	mov    %edi,-0x34(%ebp)
  402bc3:	89 f7                	mov    %esi,%edi
  402bc5:	8b 55 cc             	mov    -0x34(%ebp),%edx
  402bc8:	b9 01 00 00 00       	mov    $0x1,%ecx
  402bcd:	0f b6 47 01          	movzbl 0x1(%edi),%eax
  402bd1:	3c 7f                	cmp    $0x7f,%al
  402bd3:	74 26                	je     402bfb <.text+0xabb>
  402bd5:	83 c7 01             	add    $0x1,%edi
  402bd8:	3c 7d                	cmp    $0x7d,%al
  402bda:	74 09                	je     402be5 <.text+0xaa5>
  402bdc:	3c 2c                	cmp    $0x2c,%al
  402bde:	75 40                	jne    402c20 <.text+0xae0>
  402be0:	83 f9 01             	cmp    $0x1,%ecx
  402be3:	75 3b                	jne    402c20 <.text+0xae0>
  402be5:	83 e9 01             	sub    $0x1,%ecx
  402be8:	0f 84 83 00 00 00    	je     402c71 <.text+0xb31>
  402bee:	88 02                	mov    %al,(%edx)
  402bf0:	0f b6 47 01          	movzbl 0x1(%edi),%eax
  402bf4:	83 c2 01             	add    $0x1,%edx
  402bf7:	3c 7f                	cmp    $0x7f,%al
  402bf9:	75 da                	jne    402bd5 <.text+0xa95>
  402bfb:	0f b6 47 02          	movzbl 0x2(%edi),%eax
  402bff:	c6 02 7f             	movb   $0x7f,(%edx)
  402c02:	8d 5a 02             	lea    0x2(%edx),%ebx
  402c05:	84 c0                	test   %al,%al
  402c07:	88 42 01             	mov    %al,0x1(%edx)
  402c0a:	75 34                	jne    402c40 <.text+0xb00>
  402c0c:	c6 42 02 00          	movb   $0x0,0x2(%edx)
  402c10:	c7 45 cc 01 00 00 00 	movl   $0x1,-0x34(%ebp)
  402c17:	e9 0e 01 00 00       	jmp    402d2a <.text+0xbea>
  402c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  402c20:	3c 7b                	cmp    $0x7b,%al
  402c22:	74 2c                	je     402c50 <.text+0xb10>
  402c24:	84 c0                	test   %al,%al
  402c26:	0f 95 45 d4          	setne  -0x2c(%ebp)
  402c2a:	0f b6 5d d4          	movzbl -0x2c(%ebp),%ebx
  402c2e:	84 db                	test   %bl,%bl
  402c30:	8d 72 01             	lea    0x1(%edx),%esi
  402c33:	88 02                	mov    %al,(%edx)
  402c35:	0f 84 f9 03 00 00    	je     403034 <.text+0xef4>
  402c3b:	89 f2                	mov    %esi,%edx
  402c3d:	eb 8e                	jmp    402bcd <.text+0xa8d>
  402c3f:	90                   	nop
  402c40:	0f b6 47 03          	movzbl 0x3(%edi),%eax
  402c44:	89 da                	mov    %ebx,%edx
  402c46:	83 c7 03             	add    $0x3,%edi
  402c49:	eb 8d                	jmp    402bd8 <.text+0xa98>
  402c4b:	90                   	nop
  402c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  402c50:	83 c1 01             	add    $0x1,%ecx
  402c53:	bb 01 00 00 00       	mov    $0x1,%ebx
  402c58:	c6 45 d4 01          	movb   $0x1,-0x2c(%ebp)
  402c5c:	eb d0                	jmp    402c2e <.text+0xaee>
  402c5e:	66 90                	xchg   %ax,%ax
  402c60:	88 47 01             	mov    %al,0x1(%edi)
  402c63:	83 c6 02             	add    $0x2,%esi
  402c66:	0f b6 06             	movzbl (%esi),%eax
  402c69:	83 c7 02             	add    $0x2,%edi
  402c6c:	e9 08 ff ff ff       	jmp    402b79 <.text+0xa39>
  402c71:	3c 2c                	cmp    $0x2c,%al
  402c73:	0f 85 c1 00 00 00    	jne    402d3a <.text+0xbfa>
  402c79:	89 f8                	mov    %edi,%eax
  402c7b:	be 01 00 00 00       	mov    $0x1,%esi
  402c80:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
  402c84:	8d 48 01             	lea    0x1(%eax),%ecx
  402c87:	80 fb 7f             	cmp    $0x7f,%bl
  402c8a:	0f 85 1f 01 00 00    	jne    402daf <.text+0xc6f>
  402c90:	80 78 02 00          	cmpb   $0x0,0x2(%eax)
  402c94:	75 12                	jne    402ca8 <.text+0xb68>
  402c96:	e9 85 00 00 00       	jmp    402d20 <.text+0xbe0>
  402c9b:	90                   	nop
  402c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  402ca0:	80 78 01 00          	cmpb   $0x0,0x1(%eax)
  402ca4:	74 7a                	je     402d20 <.text+0xbe0>
  402ca6:	89 c1                	mov    %eax,%ecx
  402ca8:	0f b6 59 02          	movzbl 0x2(%ecx),%ebx
  402cac:	8d 41 02             	lea    0x2(%ecx),%eax
  402caf:	80 fb 7f             	cmp    $0x7f,%bl
  402cb2:	74 ec                	je     402ca0 <.text+0xb60>
  402cb4:	80 fb 7b             	cmp    $0x7b,%bl
  402cb7:	74 79                	je     402d32 <.text+0xbf2>
  402cb9:	80 fb 7d             	cmp    $0x7d,%bl
  402cbc:	75 55                	jne    402d13 <.text+0xbd3>
  402cbe:	83 ee 01             	sub    $0x1,%esi
  402cc1:	75 bd                	jne    402c80 <.text+0xb40>
  402cc3:	8d 48 01             	lea    0x1(%eax),%ecx
  402cc6:	0f b6 40 01          	movzbl 0x1(%eax),%eax
  402cca:	eb 07                	jmp    402cd3 <.text+0xb93>
  402ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  402cd0:	0f b6 01             	movzbl (%ecx),%eax
  402cd3:	83 c2 01             	add    $0x1,%edx
  402cd6:	83 c1 01             	add    $0x1,%ecx
  402cd9:	84 c0                	test   %al,%al
  402cdb:	88 42 ff             	mov    %al,-0x1(%edx)
  402cde:	75 f0                	jne    402cd0 <.text+0xb90>
  402ce0:	8b 45 08             	mov    0x8(%ebp),%eax
  402ce3:	89 04 24             	mov    %eax,(%esp)
  402ce6:	8b 75 d0             	mov    -0x30(%ebp),%esi
  402ce9:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  402cec:	8b 45 c8             	mov    -0x38(%ebp),%eax
  402cef:	89 f2                	mov    %esi,%edx
  402cf1:	83 ce 01             	or     $0x1,%esi
  402cf4:	e8 e7 fa ff ff       	call   4027e0 <.text+0x6a0>
  402cf9:	83 f8 01             	cmp    $0x1,%eax
  402cfc:	89 75 d0             	mov    %esi,-0x30(%ebp)
  402cff:	0f 84 0b ff ff ff    	je     402c10 <.text+0xad0>
  402d05:	80 3f 2c             	cmpb   $0x2c,(%edi)
  402d08:	0f 84 b7 fe ff ff    	je     402bc5 <.text+0xa85>
  402d0e:	89 45 cc             	mov    %eax,-0x34(%ebp)
  402d11:	eb 17                	jmp    402d2a <.text+0xbea>
  402d13:	84 db                	test   %bl,%bl
  402d15:	0f 85 65 ff ff ff    	jne    402c80 <.text+0xb40>
  402d1b:	90                   	nop
  402d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  402d20:	c6 02 00             	movb   $0x0,(%edx)
  402d23:	c7 45 cc 01 00 00 00 	movl   $0x1,-0x34(%ebp)
  402d2a:	8b 65 c0             	mov    -0x40(%ebp),%esp
  402d2d:	e9 11 fe ff ff       	jmp    402b43 <.text+0xa03>
  402d32:	83 c6 01             	add    $0x1,%esi
  402d35:	e9 46 ff ff ff       	jmp    402c80 <.text+0xb40>
  402d3a:	89 f8                	mov    %edi,%eax
  402d3c:	eb 85                	jmp    402cc3 <.text+0xb83>
  402d3e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  402d41:	89 e6                	mov    %esp,%esi
  402d43:	89 04 24             	mov    %eax,(%esp)
  402d46:	e8 7d 0d 00 00       	call   403ac8 <_strlen>
  402d4b:	83 c0 10             	add    $0x10,%eax
  402d4e:	c1 e8 04             	shr    $0x4,%eax
  402d51:	c1 e0 04             	shl    $0x4,%eax
  402d54:	e8 47 f3 ff ff       	call   4020a0 <___chkstk_ms>
  402d59:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  402d5c:	29 c4                	sub    %eax,%esp
  402d5e:	8d 7c 24 0c          	lea    0xc(%esp),%edi
  402d62:	89 f9                	mov    %edi,%ecx
  402d64:	eb 17                	jmp    402d7d <.text+0xc3d>
  402d66:	8d 76 00             	lea    0x0(%esi),%esi
  402d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  402d70:	83 c1 01             	add    $0x1,%ecx
  402d73:	83 c2 01             	add    $0x1,%edx
  402d76:	84 c0                	test   %al,%al
  402d78:	88 41 ff             	mov    %al,-0x1(%ecx)
  402d7b:	74 10                	je     402d8d <.text+0xc4d>
  402d7d:	0f b6 02             	movzbl (%edx),%eax
  402d80:	3c 7f                	cmp    $0x7f,%al
  402d82:	75 ec                	jne    402d70 <.text+0xc30>
  402d84:	0f b6 42 01          	movzbl 0x1(%edx),%eax
  402d88:	83 c2 01             	add    $0x1,%edx
  402d8b:	eb e3                	jmp    402d70 <.text+0xc30>
  402d8d:	89 3c 24             	mov    %edi,(%esp)
  402d90:	e8 73 0e 00 00       	call   403c08 <_strdup>
  402d95:	85 c0                	test   %eax,%eax
  402d97:	89 f4                	mov    %esi,%esp
  402d99:	0f 84 97 fd ff ff    	je     402b36 <.text+0x9f6>
  402d9f:	8d 55 d8             	lea    -0x28(%ebp),%edx
  402da2:	e8 89 f9 ff ff       	call   402730 <.text+0x5f0>
  402da7:	89 45 cc             	mov    %eax,-0x34(%ebp)
  402daa:	e9 d0 fa ff ff       	jmp    40287f <.text+0x73f>
  402daf:	89 c8                	mov    %ecx,%eax
  402db1:	e9 fe fe ff ff       	jmp    402cb4 <.text+0xb74>
  402db6:	f6 45 d0 10          	testb  $0x10,-0x30(%ebp)
  402dba:	0f 85 da 01 00 00    	jne    402f9a <.text+0xe5a>
  402dc0:	89 5d c8             	mov    %ebx,-0x38(%ebp)
  402dc3:	c6 45 a3 5c          	movb   $0x5c,-0x5d(%ebp)
  402dc7:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
  402dce:	e9 73 fb ff ff       	jmp    402946 <.text+0x806>
  402dd3:	89 3c 24             	mov    %edi,(%esp)
  402dd6:	e8 75 0b 00 00       	call   403950 <___mingw_closedir>
  402ddb:	8b 55 b8             	mov    -0x48(%ebp),%edx
  402dde:	85 d2                	test   %edx,%edx
  402de0:	74 0b                	je     402ded <.text+0xcad>
  402de2:	8b 55 08             	mov    0x8(%ebp),%edx
  402de5:	8b 45 b8             	mov    -0x48(%ebp),%eax
  402de8:	e8 a3 f9 ff ff       	call   402790 <.text+0x650>
  402ded:	8b 7d bc             	mov    -0x44(%ebp),%edi
  402df0:	8d 5f 04             	lea    0x4(%edi),%ebx
  402df3:	8b 43 fc             	mov    -0x4(%ebx),%eax
  402df6:	89 04 24             	mov    %eax,(%esp)
  402df9:	e8 1a 0d 00 00       	call   403b18 <_free>
  402dfe:	8b 47 04             	mov    0x4(%edi),%eax
  402e01:	85 c0                	test   %eax,%eax
  402e03:	0f 84 12 01 00 00    	je     402f1b <.text+0xddb>
  402e09:	83 7d cc 01          	cmpl   $0x1,-0x34(%ebp)
  402e0d:	74 47                	je     402e56 <.text+0xd16>
  402e0f:	89 5d bc             	mov    %ebx,-0x44(%ebp)
  402e12:	e9 52 fb ff ff       	jmp    402969 <.text+0x829>
  402e17:	89 f6                	mov    %esi,%esi
  402e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  402e20:	8b 4d 08             	mov    0x8(%ebp),%ecx
  402e23:	85 c9                	test   %ecx,%ecx
  402e25:	0f 85 c0 00 00 00    	jne    402eeb <.text+0xdab>
  402e2b:	8b 65 b0             	mov    -0x50(%ebp),%esp
  402e2e:	e9 7d fb ff ff       	jmp    4029b0 <.text+0x870>
  402e33:	f6 45 d0 04          	testb  $0x4,-0x30(%ebp)
  402e37:	0f 84 e9 00 00 00    	je     402f26 <.text+0xde6>
  402e3d:	8b 7d bc             	mov    -0x44(%ebp),%edi
  402e40:	8d 5f 04             	lea    0x4(%edi),%ebx
  402e43:	89 f8                	mov    %edi,%eax
  402e45:	8b 00                	mov    (%eax),%eax
  402e47:	89 04 24             	mov    %eax,(%esp)
  402e4a:	e8 c9 0c 00 00       	call   403b18 <_free>
  402e4f:	8b 47 04             	mov    0x4(%edi),%eax
  402e52:	85 c0                	test   %eax,%eax
  402e54:	74 17                	je     402e6d <.text+0xd2d>
  402e56:	8b 45 bc             	mov    -0x44(%ebp),%eax
  402e59:	8b 40 04             	mov    0x4(%eax),%eax
  402e5c:	83 c3 04             	add    $0x4,%ebx
  402e5f:	89 04 24             	mov    %eax,(%esp)
  402e62:	e8 b1 0c 00 00       	call   403b18 <_free>
  402e67:	8b 03                	mov    (%ebx),%eax
  402e69:	85 c0                	test   %eax,%eax
  402e6b:	75 ef                	jne    402e5c <.text+0xd1c>
  402e6d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  402e70:	c7 45 cc 01 00 00 00 	movl   $0x1,-0x34(%ebp)
  402e77:	89 45 bc             	mov    %eax,-0x44(%ebp)
  402e7a:	8b 45 bc             	mov    -0x44(%ebp),%eax
  402e7d:	89 04 24             	mov    %eax,(%esp)
  402e80:	e8 93 0c 00 00       	call   403b18 <_free>
  402e85:	8b 65 a8             	mov    -0x58(%ebp),%esp
  402e88:	e9 b6 fc ff ff       	jmp    402b43 <.text+0xa03>
  402e8d:	8d 76 00             	lea    0x0(%esi),%esi
  402e90:	8b 45 bc             	mov    -0x44(%ebp),%eax
  402e93:	89 55 b4             	mov    %edx,-0x4c(%ebp)
  402e96:	8b 55 c0             	mov    -0x40(%ebp),%edx
  402e99:	8b 00                	mov    (%eax),%eax
  402e9b:	89 34 24             	mov    %esi,(%esp)
  402e9e:	89 54 24 08          	mov    %edx,0x8(%esp)
  402ea2:	89 44 24 04          	mov    %eax,0x4(%esp)
  402ea6:	e8 4d 0c 00 00       	call   403af8 <_memcpy>
  402eab:	8b 4d c0             	mov    -0x40(%ebp),%ecx
  402eae:	8b 55 b4             	mov    -0x4c(%ebp),%edx
  402eb1:	0f b6 44 0c 0b       	movzbl 0xb(%esp,%ecx,1),%eax
  402eb6:	3c 2f                	cmp    $0x2f,%al
  402eb8:	74 26                	je     402ee0 <.text+0xda0>
  402eba:	3c 5c                	cmp    $0x5c,%al
  402ebc:	74 22                	je     402ee0 <.text+0xda0>
  402ebe:	89 c8                	mov    %ecx,%eax
  402ec0:	83 c0 01             	add    $0x1,%eax
  402ec3:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  402ec6:	89 c8                	mov    %ecx,%eax
  402ec8:	0f b6 4d a3          	movzbl -0x5d(%ebp),%ecx
  402ecc:	88 0c 06             	mov    %cl,(%esi,%eax,1)
  402ecf:	e9 40 fb ff ff       	jmp    402a14 <.text+0x8d4>
  402ed4:	c7 45 cc 03 00 00 00 	movl   $0x3,-0x34(%ebp)
  402edb:	e9 4b ff ff ff       	jmp    402e2b <.text+0xceb>
  402ee0:	8b 45 c0             	mov    -0x40(%ebp),%eax
  402ee3:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  402ee6:	e9 29 fb ff ff       	jmp    402a14 <.text+0x8d4>
  402eeb:	8b 55 08             	mov    0x8(%ebp),%edx
  402eee:	89 f0                	mov    %esi,%eax
  402ef0:	e8 3b f8 ff ff       	call   402730 <.text+0x5f0>
  402ef5:	e9 31 ff ff ff       	jmp    402e2b <.text+0xceb>
  402efa:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
  402f01:	e9 90 fa ff ff       	jmp    402996 <.text+0x856>
  402f06:	89 03                	mov    %eax,(%ebx)
  402f08:	8b 5d b8             	mov    -0x48(%ebp),%ebx
  402f0b:	85 db                	test   %ebx,%ebx
  402f0d:	0f 85 18 ff ff ff    	jne    402e2b <.text+0xceb>
  402f13:	89 45 b8             	mov    %eax,-0x48(%ebp)
  402f16:	e9 10 ff ff ff       	jmp    402e2b <.text+0xceb>
  402f1b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  402f1e:	89 45 bc             	mov    %eax,-0x44(%ebp)
  402f21:	e9 54 ff ff ff       	jmp    402e7a <.text+0xd3a>
  402f26:	8b 7d c4             	mov    -0x3c(%ebp),%edi
  402f29:	85 ff                	test   %edi,%edi
  402f2b:	0f 84 bc fe ff ff    	je     402ded <.text+0xcad>
  402f31:	e8 12 0c 00 00       	call   403b48 <__errno>
  402f36:	8b 00                	mov    (%eax),%eax
  402f38:	89 44 24 04          	mov    %eax,0x4(%esp)
  402f3c:	8b 75 bc             	mov    -0x44(%ebp),%esi
  402f3f:	8b 06                	mov    (%esi),%eax
  402f41:	89 04 24             	mov    %eax,(%esp)
  402f44:	ff d7                	call   *%edi
  402f46:	85 c0                	test   %eax,%eax
  402f48:	0f 84 9f fe ff ff    	je     402ded <.text+0xcad>
  402f4e:	89 f0                	mov    %esi,%eax
  402f50:	8d 5e 04             	lea    0x4(%esi),%ebx
  402f53:	89 f7                	mov    %esi,%edi
  402f55:	e9 eb fe ff ff       	jmp    402e45 <.text+0xd05>
  402f5a:	89 55 c8             	mov    %edx,-0x38(%ebp)
  402f5d:	88 4d a3             	mov    %cl,-0x5d(%ebp)
  402f60:	e9 a4 f9 ff ff       	jmp    402909 <.text+0x7c9>
  402f65:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
  402f6c:	e8 97 0b 00 00       	call   403b08 <_malloc>
  402f71:	85 c0                	test   %eax,%eax
  402f73:	0f 84 b2 fe ff ff    	je     402e2b <.text+0xceb>
  402f79:	89 70 08             	mov    %esi,0x8(%eax)
  402f7c:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  402f83:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  402f89:	eb 88                	jmp    402f13 <.text+0xdd3>
  402f8b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  402f8e:	c6 45 a3 5c          	movb   $0x5c,-0x5d(%ebp)
  402f92:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  402f95:	e9 ac f9 ff ff       	jmp    402946 <.text+0x806>
  402f9a:	8b 55 d0             	mov    -0x30(%ebp),%edx
  402f9d:	89 d8                	mov    %ebx,%eax
  402f9f:	e8 9c f1 ff ff       	call   402140 <.text>
  402fa4:	85 c0                	test   %eax,%eax
  402fa6:	89 45 cc             	mov    %eax,-0x34(%ebp)
  402fa9:	0f 85 11 fe ff ff    	jne    402dc0 <.text+0xc80>
  402faf:	89 1c 24             	mov    %ebx,(%esp)
  402fb2:	89 e6                	mov    %esp,%esi
  402fb4:	e8 0f 0b 00 00       	call   403ac8 <_strlen>
  402fb9:	83 c0 10             	add    $0x10,%eax
  402fbc:	c1 e8 04             	shr    $0x4,%eax
  402fbf:	c1 e0 04             	shl    $0x4,%eax
  402fc2:	e8 d9 f0 ff ff       	call   4020a0 <___chkstk_ms>
  402fc7:	29 c4                	sub    %eax,%esp
  402fc9:	8d 4c 24 0c          	lea    0xc(%esp),%ecx
  402fcd:	89 ca                	mov    %ecx,%edx
  402fcf:	eb 0d                	jmp    402fde <.text+0xe9e>
  402fd1:	83 c2 01             	add    $0x1,%edx
  402fd4:	83 c3 01             	add    $0x1,%ebx
  402fd7:	84 c0                	test   %al,%al
  402fd9:	88 42 ff             	mov    %al,-0x1(%edx)
  402fdc:	74 10                	je     402fee <.text+0xeae>
  402fde:	0f b6 03             	movzbl (%ebx),%eax
  402fe1:	3c 7f                	cmp    $0x7f,%al
  402fe3:	75 ec                	jne    402fd1 <.text+0xe91>
  402fe5:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
  402fe9:	83 c3 01             	add    $0x1,%ebx
  402fec:	eb e3                	jmp    402fd1 <.text+0xe91>
  402fee:	89 0c 24             	mov    %ecx,(%esp)
  402ff1:	e8 12 0c 00 00       	call   403c08 <_strdup>
  402ff6:	85 c0                	test   %eax,%eax
  402ff8:	89 f4                	mov    %esi,%esp
  402ffa:	0f 84 1b ff ff ff    	je     402f1b <.text+0xddb>
  403000:	8b 55 08             	mov    0x8(%ebp),%edx
  403003:	85 d2                	test   %edx,%edx
  403005:	0f 84 10 ff ff ff    	je     402f1b <.text+0xddb>
  40300b:	8b 55 08             	mov    0x8(%ebp),%edx
  40300e:	e8 1d f7 ff ff       	call   402730 <.text+0x5f0>
  403013:	8b 45 e0             	mov    -0x20(%ebp),%eax
  403016:	89 45 bc             	mov    %eax,-0x44(%ebp)
  403019:	e9 5c fe ff ff       	jmp    402e7a <.text+0xd3a>
  40301e:	89 45 c8             	mov    %eax,-0x38(%ebp)
  403021:	e9 e3 f8 ff ff       	jmp    402909 <.text+0x7c9>
  403026:	0f b6 18             	movzbl (%eax),%ebx
  403029:	89 45 c8             	mov    %eax,-0x38(%ebp)
  40302c:	88 5d a3             	mov    %bl,-0x5d(%ebp)
  40302f:	e9 d5 f8 ff ff       	jmp    402909 <.text+0x7c9>
  403034:	80 7d d4 00          	cmpb   $0x0,-0x2c(%ebp)
  403038:	0f 84 d2 fb ff ff    	je     402c10 <.text+0xad0>
  40303e:	3c 2c                	cmp    $0x2c,%al
  403040:	89 f2                	mov    %esi,%edx
  403042:	0f 85 d8 fc ff ff    	jne    402d20 <.text+0xbe0>
  403048:	e9 2c fc ff ff       	jmp    402c79 <.text+0xb39>
  40304d:	3c 7b                	cmp    $0x7b,%al
  40304f:	74 08                	je     403059 <.text+0xf19>
  403051:	8b 65 c0             	mov    -0x40(%ebp),%esp
  403054:	e9 a1 f7 ff ff       	jmp    4027fa <.text+0x6ba>
  403059:	89 55 cc             	mov    %edx,-0x34(%ebp)
  40305c:	89 cf                	mov    %ecx,%edi
  40305e:	e9 62 fb ff ff       	jmp    402bc5 <.text+0xa85>
  403063:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  403069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00403070 <___mingw_glob>:
  403070:	55                   	push   %ebp
  403071:	89 e5                	mov    %esp,%ebp
  403073:	57                   	push   %edi
  403074:	56                   	push   %esi
  403075:	53                   	push   %ebx
  403076:	83 ec 2c             	sub    $0x2c,%esp
  403079:	8b 75 14             	mov    0x14(%ebp),%esi
  40307c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  40307f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  403082:	85 f6                	test   %esi,%esi
  403084:	74 08                	je     40308e <___mingw_glob+0x1e>
  403086:	f7 c7 02 00 00 00    	test   $0x2,%edi
  40308c:	74 35                	je     4030c3 <___mingw_glob+0x53>
  40308e:	81 3e 1a 51 40 00    	cmpl   $0x40511a,(%esi)
  403094:	74 0d                	je     4030a3 <___mingw_glob+0x33>
  403096:	89 f0                	mov    %esi,%eax
  403098:	e8 43 f1 ff ff       	call   4021e0 <.text+0xa0>
  40309d:	c7 06 1a 51 40 00    	movl   $0x40511a,(%esi)
  4030a3:	89 34 24             	mov    %esi,(%esp)
  4030a6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  4030a9:	89 fa                	mov    %edi,%edx
  4030ab:	89 d8                	mov    %ebx,%eax
  4030ad:	e8 2e f7 ff ff       	call   4027e0 <.text+0x6a0>
  4030b2:	83 f8 02             	cmp    $0x2,%eax
  4030b5:	89 c1                	mov    %eax,%ecx
  4030b7:	74 17                	je     4030d0 <___mingw_glob+0x60>
  4030b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
  4030bc:	89 c8                	mov    %ecx,%eax
  4030be:	5b                   	pop    %ebx
  4030bf:	5e                   	pop    %esi
  4030c0:	5f                   	pop    %edi
  4030c1:	5d                   	pop    %ebp
  4030c2:	c3                   	ret    
  4030c3:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
  4030ca:	eb c2                	jmp    40308e <___mingw_glob+0x1e>
  4030cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  4030d0:	83 e7 10             	and    $0x10,%edi
  4030d3:	74 e4                	je     4030b9 <___mingw_glob+0x49>
  4030d5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  4030d8:	89 65 e4             	mov    %esp,-0x1c(%ebp)
  4030db:	89 1c 24             	mov    %ebx,(%esp)
  4030de:	e8 e5 09 00 00       	call   403ac8 <_strlen>
  4030e3:	83 c0 10             	add    $0x10,%eax
  4030e6:	c1 e8 04             	shr    $0x4,%eax
  4030e9:	c1 e0 04             	shl    $0x4,%eax
  4030ec:	e8 af ef ff ff       	call   4020a0 <___chkstk_ms>
  4030f1:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  4030f4:	29 c4                	sub    %eax,%esp
  4030f6:	8d 7c 24 04          	lea    0x4(%esp),%edi
  4030fa:	89 fa                	mov    %edi,%edx
  4030fc:	eb 0f                	jmp    40310d <___mingw_glob+0x9d>
  4030fe:	66 90                	xchg   %ax,%ax
  403100:	83 c2 01             	add    $0x1,%edx
  403103:	83 c3 01             	add    $0x1,%ebx
  403106:	84 c0                	test   %al,%al
  403108:	88 42 ff             	mov    %al,-0x1(%edx)
  40310b:	74 1b                	je     403128 <___mingw_glob+0xb8>
  40310d:	0f b6 03             	movzbl (%ebx),%eax
  403110:	3c 7f                	cmp    $0x7f,%al
  403112:	75 ec                	jne    403100 <___mingw_glob+0x90>
  403114:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
  403118:	83 c3 01             	add    $0x1,%ebx
  40311b:	83 c2 01             	add    $0x1,%edx
  40311e:	83 c3 01             	add    $0x1,%ebx
  403121:	84 c0                	test   %al,%al
  403123:	88 42 ff             	mov    %al,-0x1(%edx)
  403126:	75 e5                	jne    40310d <___mingw_glob+0x9d>
  403128:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  40312b:	89 3c 24             	mov    %edi,(%esp)
  40312e:	e8 d5 0a 00 00       	call   403c08 <_strdup>
  403133:	85 c0                	test   %eax,%eax
  403135:	8b 65 e4             	mov    -0x1c(%ebp),%esp
  403138:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  40313b:	0f 84 78 ff ff ff    	je     4030b9 <___mingw_glob+0x49>
  403141:	89 f2                	mov    %esi,%edx
  403143:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  403146:	e8 e5 f5 ff ff       	call   402730 <.text+0x5f0>
  40314b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  40314e:	e9 66 ff ff ff       	jmp    4030b9 <___mingw_glob+0x49>
  403153:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  403159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00403160 <___mingw_globfree>:
  403160:	57                   	push   %edi
  403161:	56                   	push   %esi
  403162:	53                   	push   %ebx
  403163:	83 ec 10             	sub    $0x10,%esp
  403166:	8b 74 24 20          	mov    0x20(%esp),%esi
  40316a:	81 3e 1a 51 40 00    	cmpl   $0x40511a,(%esi)
  403170:	74 0e                	je     403180 <___mingw_globfree+0x20>
  403172:	83 c4 10             	add    $0x10,%esp
  403175:	5b                   	pop    %ebx
  403176:	5e                   	pop    %esi
  403177:	5f                   	pop    %edi
  403178:	c3                   	ret    
  403179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  403180:	8b 46 04             	mov    0x4(%esi),%eax
  403183:	8b 56 0c             	mov    0xc(%esi),%edx
  403186:	85 c0                	test   %eax,%eax
  403188:	8d 78 ff             	lea    -0x1(%eax),%edi
  40318b:	8d 1c 95 00 00 00 00 	lea    0x0(,%edx,4),%ebx
  403192:	7e 19                	jle    4031ad <___mingw_globfree+0x4d>
  403194:	8b 46 08             	mov    0x8(%esi),%eax
  403197:	83 ef 01             	sub    $0x1,%edi
  40319a:	8b 04 18             	mov    (%eax,%ebx,1),%eax
  40319d:	83 c3 04             	add    $0x4,%ebx
  4031a0:	89 04 24             	mov    %eax,(%esp)
  4031a3:	e8 70 09 00 00       	call   403b18 <_free>
  4031a8:	83 ff ff             	cmp    $0xffffffff,%edi
  4031ab:	75 e7                	jne    403194 <___mingw_globfree+0x34>
  4031ad:	8b 46 08             	mov    0x8(%esi),%eax
  4031b0:	89 44 24 20          	mov    %eax,0x20(%esp)
  4031b4:	83 c4 10             	add    $0x10,%esp
  4031b7:	5b                   	pop    %ebx
  4031b8:	5e                   	pop    %esi
  4031b9:	5f                   	pop    %edi
  4031ba:	e9 59 09 00 00       	jmp    403b18 <_free>
  4031bf:	90                   	nop

004031c0 <___mingw_dirname>:
  4031c0:	55                   	push   %ebp
  4031c1:	89 e5                	mov    %esp,%ebp
  4031c3:	57                   	push   %edi
  4031c4:	56                   	push   %esi
  4031c5:	53                   	push   %ebx
  4031c6:	83 ec 2c             	sub    $0x2c,%esp
  4031c9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  4031d0:	00 
  4031d1:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  4031d8:	e8 03 09 00 00       	call   403ae0 <_setlocale>
  4031dd:	85 c0                	test   %eax,%eax
  4031df:	89 c3                	mov    %eax,%ebx
  4031e1:	74 0a                	je     4031ed <___mingw_dirname+0x2d>
  4031e3:	89 04 24             	mov    %eax,(%esp)
  4031e6:	e8 1d 0a 00 00       	call   403c08 <_strdup>
  4031eb:	89 c3                	mov    %eax,%ebx
  4031ed:	c7 44 24 04 2c 51 40 	movl   $0x40512c,0x4(%esp)
  4031f4:	00 
  4031f5:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  4031fc:	e8 df 08 00 00       	call   403ae0 <_setlocale>
  403201:	8b 75 08             	mov    0x8(%ebp),%esi
  403204:	85 f6                	test   %esi,%esi
  403206:	74 08                	je     403210 <___mingw_dirname+0x50>
  403208:	8b 45 08             	mov    0x8(%ebp),%eax
  40320b:	80 38 00             	cmpb   $0x0,(%eax)
  40320e:	75 71                	jne    403281 <___mingw_dirname+0xc1>
  403210:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  403217:	00 
  403218:	c7 44 24 04 2e 51 40 	movl   $0x40512e,0x4(%esp)
  40321f:	00 
  403220:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  403227:	e8 84 08 00 00       	call   403ab0 <_wcstombs>
  40322c:	8d 70 01             	lea    0x1(%eax),%esi
  40322f:	89 74 24 04          	mov    %esi,0x4(%esp)
  403233:	a1 68 70 40 00       	mov    0x407068,%eax
  403238:	89 04 24             	mov    %eax,(%esp)
  40323b:	e8 a8 08 00 00       	call   403ae8 <_realloc>
  403240:	a3 68 70 40 00       	mov    %eax,0x407068
  403245:	89 74 24 08          	mov    %esi,0x8(%esp)
  403249:	c7 44 24 04 2e 51 40 	movl   $0x40512e,0x4(%esp)
  403250:	00 
  403251:	89 04 24             	mov    %eax,(%esp)
  403254:	e8 57 08 00 00       	call   403ab0 <_wcstombs>
  403259:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  40325d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  403264:	e8 77 08 00 00       	call   403ae0 <_setlocale>
  403269:	89 1c 24             	mov    %ebx,(%esp)
  40326c:	e8 a7 08 00 00       	call   403b18 <_free>
  403271:	8b 35 68 70 40 00    	mov    0x407068,%esi
  403277:	8d 65 f4             	lea    -0xc(%ebp),%esp
  40327a:	5b                   	pop    %ebx
  40327b:	89 f0                	mov    %esi,%eax
  40327d:	5e                   	pop    %esi
  40327e:	5f                   	pop    %edi
  40327f:	5d                   	pop    %ebp
  403280:	c3                   	ret    
  403281:	89 65 dc             	mov    %esp,-0x24(%ebp)
  403284:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  40328b:	00 
  40328c:	8b 45 08             	mov    0x8(%ebp),%eax
  40328f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  403296:	89 44 24 04          	mov    %eax,0x4(%esp)
  40329a:	e8 61 08 00 00       	call   403b00 <_mbstowcs>
  40329f:	89 c2                	mov    %eax,%edx
  4032a1:	8d 44 00 12          	lea    0x12(%eax,%eax,1),%eax
  4032a5:	c1 e8 04             	shr    $0x4,%eax
  4032a8:	c1 e0 04             	shl    $0x4,%eax
  4032ab:	e8 f0 ed ff ff       	call   4020a0 <___chkstk_ms>
  4032b0:	29 c4                	sub    %eax,%esp
  4032b2:	89 54 24 08          	mov    %edx,0x8(%esp)
  4032b6:	8b 45 08             	mov    0x8(%ebp),%eax
  4032b9:	8d 7c 24 0c          	lea    0xc(%esp),%edi
  4032bd:	89 3c 24             	mov    %edi,(%esp)
  4032c0:	89 44 24 04          	mov    %eax,0x4(%esp)
  4032c4:	e8 37 08 00 00       	call   403b00 <_mbstowcs>
  4032c9:	31 c9                	xor    %ecx,%ecx
  4032cb:	89 45 d8             	mov    %eax,-0x28(%ebp)
  4032ce:	83 f8 01             	cmp    $0x1,%eax
  4032d1:	66 89 0c 47          	mov    %cx,(%edi,%eax,2)
  4032d5:	0f b7 07             	movzwl (%edi),%eax
  4032d8:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  4032db:	66 89 45 e2          	mov    %ax,-0x1e(%ebp)
  4032df:	76 1f                	jbe    403300 <___mingw_dirname+0x140>
  4032e1:	66 83 f8 2f          	cmp    $0x2f,%ax
  4032e5:	0f 84 1c 02 00 00    	je     403507 <___mingw_dirname+0x347>
  4032eb:	66 83 f8 5c          	cmp    $0x5c,%ax
  4032ef:	0f 84 12 02 00 00    	je     403507 <___mingw_dirname+0x347>
  4032f5:	66 83 7f 02 3a       	cmpw   $0x3a,0x2(%edi)
  4032fa:	0f 84 4f 02 00 00    	je     40354f <___mingw_dirname+0x38f>
  403300:	0f b7 45 e2          	movzwl -0x1e(%ebp),%eax
  403304:	66 85 c0             	test   %ax,%ax
  403307:	0f 84 e1 00 00 00    	je     4033ee <___mingw_dirname+0x22e>
  40330d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  403310:	89 c2                	mov    %eax,%edx
  403312:	89 ce                	mov    %ecx,%esi
  403314:	eb 1e                	jmp    403334 <___mingw_dirname+0x174>
  403316:	8d 76 00             	lea    0x0(%esi),%esi
  403319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  403320:	66 83 fa 5c          	cmp    $0x5c,%dx
  403324:	89 c8                	mov    %ecx,%eax
  403326:	74 12                	je     40333a <___mingw_dirname+0x17a>
  403328:	0f b7 50 02          	movzwl 0x2(%eax),%edx
  40332c:	8d 48 02             	lea    0x2(%eax),%ecx
  40332f:	66 85 d2             	test   %dx,%dx
  403332:	74 36                	je     40336a <___mingw_dirname+0x1aa>
  403334:	66 83 fa 2f          	cmp    $0x2f,%dx
  403338:	75 e6                	jne    403320 <___mingw_dirname+0x160>
  40333a:	0f b7 11             	movzwl (%ecx),%edx
  40333d:	89 c8                	mov    %ecx,%eax
  40333f:	66 83 fa 2f          	cmp    $0x2f,%dx
  403343:	75 0c                	jne    403351 <___mingw_dirname+0x191>
  403345:	83 c0 02             	add    $0x2,%eax
  403348:	0f b7 10             	movzwl (%eax),%edx
  40334b:	66 83 fa 2f          	cmp    $0x2f,%dx
  40334f:	74 f4                	je     403345 <___mingw_dirname+0x185>
  403351:	66 83 fa 5c          	cmp    $0x5c,%dx
  403355:	74 ee                	je     403345 <___mingw_dirname+0x185>
  403357:	66 85 d2             	test   %dx,%dx
  40335a:	74 0e                	je     40336a <___mingw_dirname+0x1aa>
  40335c:	0f b7 50 02          	movzwl 0x2(%eax),%edx
  403360:	89 c6                	mov    %eax,%esi
  403362:	8d 48 02             	lea    0x2(%eax),%ecx
  403365:	66 85 d2             	test   %dx,%dx
  403368:	75 ca                	jne    403334 <___mingw_dirname+0x174>
  40336a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  40336d:	0f 82 8d 00 00 00    	jb     403400 <___mingw_dirname+0x240>
  403373:	0f b7 45 e2          	movzwl -0x1e(%ebp),%eax
  403377:	66 83 f8 2f          	cmp    $0x2f,%ax
  40337b:	0f 84 e1 01 00 00    	je     403562 <___mingw_dirname+0x3a2>
  403381:	66 83 f8 5c          	cmp    $0x5c,%ax
  403385:	0f 84 d7 01 00 00    	je     403562 <___mingw_dirname+0x3a2>
  40338b:	8b 75 e4             	mov    -0x1c(%ebp),%esi
  40338e:	b9 2e 00 00 00       	mov    $0x2e,%ecx
  403393:	89 f0                	mov    %esi,%eax
  403395:	66 89 0e             	mov    %cx,(%esi)
  403398:	83 c0 02             	add    $0x2,%eax
  40339b:	31 d2                	xor    %edx,%edx
  40339d:	66 89 10             	mov    %dx,(%eax)
  4033a0:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  4033a7:	00 
  4033a8:	89 7c 24 04          	mov    %edi,0x4(%esp)
  4033ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  4033b3:	e8 f8 06 00 00       	call   403ab0 <_wcstombs>
  4033b8:	8d 50 01             	lea    0x1(%eax),%edx
  4033bb:	89 54 24 04          	mov    %edx,0x4(%esp)
  4033bf:	a1 68 70 40 00       	mov    0x407068,%eax
  4033c4:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  4033c7:	89 04 24             	mov    %eax,(%esp)
  4033ca:	e8 19 07 00 00       	call   403ae8 <_realloc>
  4033cf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  4033d2:	a3 68 70 40 00       	mov    %eax,0x407068
  4033d7:	89 c6                	mov    %eax,%esi
  4033d9:	89 7c 24 04          	mov    %edi,0x4(%esp)
  4033dd:	89 04 24             	mov    %eax,(%esp)
  4033e0:	89 54 24 08          	mov    %edx,0x8(%esp)
  4033e4:	e8 c7 06 00 00       	call   403ab0 <_wcstombs>
  4033e9:	e9 c2 00 00 00       	jmp    4034b0 <___mingw_dirname+0x2f0>
  4033ee:	8b 65 dc             	mov    -0x24(%ebp),%esp
  4033f1:	e9 1a fe ff ff       	jmp    403210 <___mingw_dirname+0x50>
  4033f6:	8d 76 00             	lea    0x0(%esi),%esi
  4033f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  403400:	8d 46 fe             	lea    -0x2(%esi),%eax
  403403:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
  403406:	0f 83 61 01 00 00    	jae    40356d <___mingw_dirname+0x3ad>
  40340c:	0f b7 56 fe          	movzwl -0x2(%esi),%edx
  403410:	89 c6                	mov    %eax,%esi
  403412:	66 83 fa 2f          	cmp    $0x2f,%dx
  403416:	74 e8                	je     403400 <___mingw_dirname+0x240>
  403418:	66 83 fa 5c          	cmp    $0x5c,%dx
  40341c:	74 e2                	je     403400 <___mingw_dirname+0x240>
  40341e:	31 d2                	xor    %edx,%edx
  403420:	89 f9                	mov    %edi,%ecx
  403422:	66 89 50 02          	mov    %dx,0x2(%eax)
  403426:	0f b7 17             	movzwl (%edi),%edx
  403429:	66 83 fa 2f          	cmp    $0x2f,%dx
  40342d:	74 11                	je     403440 <___mingw_dirname+0x280>
  40342f:	66 83 fa 5c          	cmp    $0x5c,%dx
  403433:	0f 85 04 01 00 00    	jne    40353d <___mingw_dirname+0x37d>
  403439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  403440:	83 c1 02             	add    $0x2,%ecx
  403443:	0f b7 01             	movzwl (%ecx),%eax
  403446:	66 83 f8 2f          	cmp    $0x2f,%ax
  40344a:	74 f4                	je     403440 <___mingw_dirname+0x280>
  40344c:	66 83 f8 5c          	cmp    $0x5c,%ax
  403450:	74 ee                	je     403440 <___mingw_dirname+0x280>
  403452:	89 c8                	mov    %ecx,%eax
  403454:	29 f8                	sub    %edi,%eax
  403456:	83 f8 05             	cmp    $0x5,%eax
  403459:	0f 8e de 00 00 00    	jle    40353d <___mingw_dirname+0x37d>
  40345f:	89 f9                	mov    %edi,%ecx
  403461:	89 c8                	mov    %ecx,%eax
  403463:	66 85 d2             	test   %dx,%dx
  403466:	74 21                	je     403489 <___mingw_dirname+0x2c9>
  403468:	83 c1 02             	add    $0x2,%ecx
  40346b:	66 83 fa 2f          	cmp    $0x2f,%dx
  40346f:	66 89 51 fe          	mov    %dx,-0x2(%ecx)
  403473:	74 62                	je     4034d7 <___mingw_dirname+0x317>
  403475:	66 83 38 5c          	cmpw   $0x5c,(%eax)
  403479:	8d 70 02             	lea    0x2(%eax),%esi
  40347c:	74 57                	je     4034d5 <___mingw_dirname+0x315>
  40347e:	0f b7 50 02          	movzwl 0x2(%eax),%edx
  403482:	89 f0                	mov    %esi,%eax
  403484:	66 85 d2             	test   %dx,%dx
  403487:	75 df                	jne    403468 <___mingw_dirname+0x2a8>
  403489:	8b 45 d8             	mov    -0x28(%ebp),%eax
  40348c:	31 f6                	xor    %esi,%esi
  40348e:	66 89 31             	mov    %si,(%ecx)
  403491:	89 7c 24 04          	mov    %edi,0x4(%esp)
  403495:	89 44 24 08          	mov    %eax,0x8(%esp)
  403499:	8b 45 08             	mov    0x8(%ebp),%eax
  40349c:	89 04 24             	mov    %eax,(%esp)
  40349f:	e8 0c 06 00 00       	call   403ab0 <_wcstombs>
  4034a4:	83 f8 ff             	cmp    $0xffffffff,%eax
  4034a7:	8b 75 08             	mov    0x8(%ebp),%esi
  4034aa:	74 04                	je     4034b0 <___mingw_dirname+0x2f0>
  4034ac:	c6 04 06 00          	movb   $0x0,(%esi,%eax,1)
  4034b0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  4034b4:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  4034bb:	e8 20 06 00 00       	call   403ae0 <_setlocale>
  4034c0:	89 1c 24             	mov    %ebx,(%esp)
  4034c3:	e8 50 06 00 00       	call   403b18 <_free>
  4034c8:	8b 65 dc             	mov    -0x24(%ebp),%esp
  4034cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
  4034ce:	89 f0                	mov    %esi,%eax
  4034d0:	5b                   	pop    %ebx
  4034d1:	5e                   	pop    %esi
  4034d2:	5f                   	pop    %edi
  4034d3:	5d                   	pop    %ebp
  4034d4:	c3                   	ret    
  4034d5:	89 f0                	mov    %esi,%eax
  4034d7:	0f b7 10             	movzwl (%eax),%edx
  4034da:	66 83 fa 5c          	cmp    $0x5c,%dx
  4034de:	74 10                	je     4034f0 <___mingw_dirname+0x330>
  4034e0:	66 83 fa 2f          	cmp    $0x2f,%dx
  4034e4:	0f 85 79 ff ff ff    	jne    403463 <___mingw_dirname+0x2a3>
  4034ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  4034f0:	83 c0 02             	add    $0x2,%eax
  4034f3:	0f b7 10             	movzwl (%eax),%edx
  4034f6:	66 83 fa 2f          	cmp    $0x2f,%dx
  4034fa:	74 f4                	je     4034f0 <___mingw_dirname+0x330>
  4034fc:	66 83 fa 5c          	cmp    $0x5c,%dx
  403500:	74 ee                	je     4034f0 <___mingw_dirname+0x330>
  403502:	e9 5c ff ff ff       	jmp    403463 <___mingw_dirname+0x2a3>
  403507:	0f b7 45 e2          	movzwl -0x1e(%ebp),%eax
  40350b:	66 3b 47 02          	cmp    0x2(%edi),%ax
  40350f:	0f 85 eb fd ff ff    	jne    403300 <___mingw_dirname+0x140>
  403515:	66 83 7f 04 00       	cmpw   $0x0,0x4(%edi)
  40351a:	0f 85 e0 fd ff ff    	jne    403300 <___mingw_dirname+0x140>
  403520:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  403524:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  40352b:	e8 b0 05 00 00       	call   403ae0 <_setlocale>
  403530:	89 1c 24             	mov    %ebx,(%esp)
  403533:	e8 e0 05 00 00       	call   403b18 <_free>
  403538:	8b 75 08             	mov    0x8(%ebp),%esi
  40353b:	eb 8b                	jmp    4034c8 <___mingw_dirname+0x308>
  40353d:	66 39 57 02          	cmp    %dx,0x2(%edi)
  403541:	0f 85 18 ff ff ff    	jne    40345f <___mingw_dirname+0x29f>
  403547:	0f b7 11             	movzwl (%ecx),%edx
  40354a:	e9 12 ff ff ff       	jmp    403461 <___mingw_dirname+0x2a1>
  40354f:	8d 47 04             	lea    0x4(%edi),%eax
  403552:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  403555:	0f b7 47 04          	movzwl 0x4(%edi),%eax
  403559:	66 89 45 e2          	mov    %ax,-0x1e(%ebp)
  40355d:	e9 9e fd ff ff       	jmp    403300 <___mingw_dirname+0x140>
  403562:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  403565:	83 c0 02             	add    $0x2,%eax
  403568:	e9 2e fe ff ff       	jmp    40339b <___mingw_dirname+0x1db>
  40356d:	0f 85 ab fe ff ff    	jne    40341e <___mingw_dirname+0x25e>
  403573:	0f b7 4d e2          	movzwl -0x1e(%ebp),%ecx
  403577:	66 83 f9 2f          	cmp    $0x2f,%cx
  40357b:	74 0a                	je     403587 <___mingw_dirname+0x3c7>
  40357d:	66 83 f9 5c          	cmp    $0x5c,%cx
  403581:	0f 85 97 fe ff ff    	jne    40341e <___mingw_dirname+0x25e>
  403587:	0f b7 4d e2          	movzwl -0x1e(%ebp),%ecx
  40358b:	66 39 48 02          	cmp    %cx,0x2(%eax)
  40358f:	0f 85 89 fe ff ff    	jne    40341e <___mingw_dirname+0x25e>
  403595:	0f b7 50 04          	movzwl 0x4(%eax),%edx
  403599:	66 83 fa 2f          	cmp    $0x2f,%dx
  40359d:	0f 84 7b fe ff ff    	je     40341e <___mingw_dirname+0x25e>
  4035a3:	66 83 fa 5c          	cmp    $0x5c,%dx
  4035a7:	0f 84 71 fe ff ff    	je     40341e <___mingw_dirname+0x25e>
  4035ad:	89 f0                	mov    %esi,%eax
  4035af:	e9 6a fe ff ff       	jmp    40341e <___mingw_dirname+0x25e>
  4035b4:	90                   	nop
  4035b5:	90                   	nop
  4035b6:	90                   	nop
  4035b7:	90                   	nop
  4035b8:	90                   	nop
  4035b9:	90                   	nop
  4035ba:	90                   	nop
  4035bb:	90                   	nop
  4035bc:	90                   	nop
  4035bd:	90                   	nop
  4035be:	90                   	nop
  4035bf:	90                   	nop

004035c0 <.text>:
  4035c0:	56                   	push   %esi
  4035c1:	53                   	push   %ebx
  4035c2:	89 d3                	mov    %edx,%ebx
  4035c4:	81 ec 54 01 00 00    	sub    $0x154,%esp
  4035ca:	8d 54 24 10          	lea    0x10(%esp),%edx
  4035ce:	89 04 24             	mov    %eax,(%esp)
  4035d1:	89 54 24 04          	mov    %edx,0x4(%esp)
  4035d5:	e8 fe 05 00 00       	call   403bd8 <_FindFirstFileA@8>
  4035da:	83 ec 08             	sub    $0x8,%esp
  4035dd:	83 f8 ff             	cmp    $0xffffffff,%eax
  4035e0:	89 c6                	mov    %eax,%esi
  4035e2:	74 5a                	je     40363e <.text+0x7e>
  4035e4:	31 c0                	xor    %eax,%eax
  4035e6:	8d 4b 0c             	lea    0xc(%ebx),%ecx
  4035e9:	66 89 43 06          	mov    %ax,0x6(%ebx)
  4035ed:	31 c0                	xor    %eax,%eax
  4035ef:	eb 12                	jmp    403603 <.text+0x43>
  4035f1:	0f b7 43 06          	movzwl 0x6(%ebx),%eax
  4035f5:	83 c0 01             	add    $0x1,%eax
  4035f8:	66 3d 04 01          	cmp    $0x104,%ax
  4035fc:	66 89 43 06          	mov    %ax,0x6(%ebx)
  403600:	83 d1 00             	adc    $0x0,%ecx
  403603:	0f b7 c0             	movzwl %ax,%eax
  403606:	0f b6 44 04 3c       	movzbl 0x3c(%esp,%eax,1),%eax
  40360b:	84 c0                	test   %al,%al
  40360d:	88 01                	mov    %al,(%ecx)
  40360f:	75 e0                	jne    4035f1 <.text+0x31>
  403611:	8b 44 24 10          	mov    0x10(%esp),%eax
  403615:	24 58                	and    $0x58,%al
  403617:	83 f8 10             	cmp    $0x10,%eax
  40361a:	76 14                	jbe    403630 <.text+0x70>
  40361c:	c7 43 08 18 00 00 00 	movl   $0x18,0x8(%ebx)
  403623:	81 c4 54 01 00 00    	add    $0x154,%esp
  403629:	89 f0                	mov    %esi,%eax
  40362b:	5b                   	pop    %ebx
  40362c:	5e                   	pop    %esi
  40362d:	c3                   	ret    
  40362e:	66 90                	xchg   %ax,%ax
  403630:	89 43 08             	mov    %eax,0x8(%ebx)
  403633:	81 c4 54 01 00 00    	add    $0x154,%esp
  403639:	89 f0                	mov    %esi,%eax
  40363b:	5b                   	pop    %ebx
  40363c:	5e                   	pop    %esi
  40363d:	c3                   	ret    
  40363e:	e8 05 05 00 00       	call   403b48 <__errno>
  403643:	89 c3                	mov    %eax,%ebx
  403645:	e8 6e 05 00 00       	call   403bb8 <_GetLastError@0>
  40364a:	83 f8 03             	cmp    $0x3,%eax
  40364d:	89 03                	mov    %eax,(%ebx)
  40364f:	74 31                	je     403682 <.text+0xc2>
  403651:	e8 f2 04 00 00       	call   403b48 <__errno>
  403656:	81 38 0b 01 00 00    	cmpl   $0x10b,(%eax)
  40365c:	74 17                	je     403675 <.text+0xb5>
  40365e:	e8 e5 04 00 00       	call   403b48 <__errno>
  403663:	83 38 02             	cmpl   $0x2,(%eax)
  403666:	74 bb                	je     403623 <.text+0x63>
  403668:	e8 db 04 00 00       	call   403b48 <__errno>
  40366d:	c7 00 16 00 00 00    	movl   $0x16,(%eax)
  403673:	eb ae                	jmp    403623 <.text+0x63>
  403675:	e8 ce 04 00 00       	call   403b48 <__errno>
  40367a:	c7 00 14 00 00 00    	movl   $0x14,(%eax)
  403680:	eb a1                	jmp    403623 <.text+0x63>
  403682:	e8 c1 04 00 00       	call   403b48 <__errno>
  403687:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  40368d:	eb 94                	jmp    403623 <.text+0x63>
  40368f:	90                   	nop
  403690:	56                   	push   %esi
  403691:	53                   	push   %ebx
  403692:	89 d3                	mov    %edx,%ebx
  403694:	81 ec 54 01 00 00    	sub    $0x154,%esp
  40369a:	8d 54 24 10          	lea    0x10(%esp),%edx
  40369e:	89 04 24             	mov    %eax,(%esp)
  4036a1:	89 54 24 04          	mov    %edx,0x4(%esp)
  4036a5:	e8 26 05 00 00       	call   403bd0 <_FindNextFileA@8>
  4036aa:	83 ec 08             	sub    $0x8,%esp
  4036ad:	85 c0                	test   %eax,%eax
  4036af:	89 c6                	mov    %eax,%esi
  4036b1:	74 5f                	je     403712 <.text+0x152>
  4036b3:	31 c0                	xor    %eax,%eax
  4036b5:	8d 4b 0c             	lea    0xc(%ebx),%ecx
  4036b8:	66 89 43 06          	mov    %ax,0x6(%ebx)
  4036bc:	31 c0                	xor    %eax,%eax
  4036be:	eb 12                	jmp    4036d2 <.text+0x112>
  4036c0:	0f b7 43 06          	movzwl 0x6(%ebx),%eax
  4036c4:	83 c0 01             	add    $0x1,%eax
  4036c7:	66 3d 04 01          	cmp    $0x104,%ax
  4036cb:	66 89 43 06          	mov    %ax,0x6(%ebx)
  4036cf:	83 d1 00             	adc    $0x0,%ecx
  4036d2:	0f b7 c0             	movzwl %ax,%eax
  4036d5:	0f b6 44 04 3c       	movzbl 0x3c(%esp,%eax,1),%eax
  4036da:	84 c0                	test   %al,%al
  4036dc:	88 01                	mov    %al,(%ecx)
  4036de:	75 e0                	jne    4036c0 <.text+0x100>
  4036e0:	8b 44 24 10          	mov    0x10(%esp),%eax
  4036e4:	24 58                	and    $0x58,%al
  4036e6:	83 f8 10             	cmp    $0x10,%eax
  4036e9:	77 15                	ja     403700 <.text+0x140>
  4036eb:	89 43 08             	mov    %eax,0x8(%ebx)
  4036ee:	81 c4 54 01 00 00    	add    $0x154,%esp
  4036f4:	89 f0                	mov    %esi,%eax
  4036f6:	5b                   	pop    %ebx
  4036f7:	5e                   	pop    %esi
  4036f8:	c3                   	ret    
  4036f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  403700:	c7 43 08 18 00 00 00 	movl   $0x18,0x8(%ebx)
  403707:	81 c4 54 01 00 00    	add    $0x154,%esp
  40370d:	89 f0                	mov    %esi,%eax
  40370f:	5b                   	pop    %ebx
  403710:	5e                   	pop    %esi
  403711:	c3                   	ret    
  403712:	e8 a1 04 00 00       	call   403bb8 <_GetLastError@0>
  403717:	83 f8 12             	cmp    $0x12,%eax
  40371a:	74 d2                	je     4036ee <.text+0x12e>
  40371c:	e8 27 04 00 00       	call   403b48 <__errno>
  403721:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  403727:	81 c4 54 01 00 00    	add    $0x154,%esp
  40372d:	89 f0                	mov    %esi,%eax
  40372f:	5b                   	pop    %ebx
  403730:	5e                   	pop    %esi
  403731:	c3                   	ret    
  403732:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  403739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00403740 <___mingw_opendir>:
  403740:	55                   	push   %ebp
  403741:	57                   	push   %edi
  403742:	56                   	push   %esi
  403743:	53                   	push   %ebx
  403744:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
  40374a:	8b 84 24 40 01 00 00 	mov    0x140(%esp),%eax
  403751:	85 c0                	test   %eax,%eax
  403753:	0f 84 83 01 00 00    	je     4038dc <___mingw_opendir+0x19c>
  403759:	80 38 00             	cmpb   $0x0,(%eax)
  40375c:	0f 84 5e 01 00 00    	je     4038c0 <___mingw_opendir+0x180>
  403762:	8d 7c 24 1c          	lea    0x1c(%esp),%edi
  403766:	c7 44 24 08 04 01 00 	movl   $0x104,0x8(%esp)
  40376d:	00 
  40376e:	89 44 24 04          	mov    %eax,0x4(%esp)
  403772:	89 3c 24             	mov    %edi,(%esp)
  403775:	e8 c6 03 00 00       	call   403b40 <__fullpath>
  40377a:	80 7c 24 1c 00       	cmpb   $0x0,0x1c(%esp)
  40377f:	89 f8                	mov    %edi,%eax
  403781:	74 4d                	je     4037d0 <___mingw_opendir+0x90>
  403783:	8b 08                	mov    (%eax),%ecx
  403785:	83 c0 04             	add    $0x4,%eax
  403788:	8d 91 ff fe fe fe    	lea    -0x1010101(%ecx),%edx
  40378e:	f7 d1                	not    %ecx
  403790:	21 ca                	and    %ecx,%edx
  403792:	81 e2 80 80 80 80    	and    $0x80808080,%edx
  403798:	74 e9                	je     403783 <___mingw_opendir+0x43>
  40379a:	f7 c2 80 80 00 00    	test   $0x8080,%edx
  4037a0:	0f 84 0a 01 00 00    	je     4038b0 <___mingw_opendir+0x170>
  4037a6:	89 d1                	mov    %edx,%ecx
  4037a8:	00 d1                	add    %dl,%cl
  4037aa:	83 d8 03             	sbb    $0x3,%eax
  4037ad:	29 f8                	sub    %edi,%eax
  4037af:	0f b6 54 04 1b       	movzbl 0x1b(%esp,%eax,1),%edx
  4037b4:	80 fa 2f             	cmp    $0x2f,%dl
  4037b7:	74 43                	je     4037fc <___mingw_opendir+0xbc>
  4037b9:	80 fa 5c             	cmp    $0x5c,%dl
  4037bc:	74 3e                	je     4037fc <___mingw_opendir+0xbc>
  4037be:	b9 5c 00 00 00       	mov    $0x5c,%ecx
  4037c3:	66 89 0c 07          	mov    %cx,(%edi,%eax,1)
  4037c7:	83 c0 01             	add    $0x1,%eax
  4037ca:	eb 30                	jmp    4037fc <___mingw_opendir+0xbc>
  4037cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  4037d0:	8b 08                	mov    (%eax),%ecx
  4037d2:	83 c0 04             	add    $0x4,%eax
  4037d5:	8d 91 ff fe fe fe    	lea    -0x1010101(%ecx),%edx
  4037db:	f7 d1                	not    %ecx
  4037dd:	21 ca                	and    %ecx,%edx
  4037df:	81 e2 80 80 80 80    	and    $0x80808080,%edx
  4037e5:	74 e9                	je     4037d0 <___mingw_opendir+0x90>
  4037e7:	f7 c2 80 80 00 00    	test   $0x8080,%edx
  4037ed:	0f 84 ad 00 00 00    	je     4038a0 <___mingw_opendir+0x160>
  4037f3:	89 d1                	mov    %edx,%ecx
  4037f5:	00 d1                	add    %dl,%cl
  4037f7:	83 d8 03             	sbb    $0x3,%eax
  4037fa:	29 f8                	sub    %edi,%eax
  4037fc:	ba 2a 00 00 00       	mov    $0x2a,%edx
  403801:	89 fb                	mov    %edi,%ebx
  403803:	66 89 14 07          	mov    %dx,(%edi,%eax,1)
  403807:	8b 13                	mov    (%ebx),%edx
  403809:	83 c3 04             	add    $0x4,%ebx
  40380c:	8d 82 ff fe fe fe    	lea    -0x1010101(%edx),%eax
  403812:	f7 d2                	not    %edx
  403814:	21 d0                	and    %edx,%eax
  403816:	25 80 80 80 80       	and    $0x80808080,%eax
  40381b:	74 ea                	je     403807 <___mingw_opendir+0xc7>
  40381d:	a9 80 80 00 00       	test   $0x8080,%eax
  403822:	75 06                	jne    40382a <___mingw_opendir+0xea>
  403824:	c1 e8 10             	shr    $0x10,%eax
  403827:	83 c3 02             	add    $0x2,%ebx
  40382a:	89 c1                	mov    %eax,%ecx
  40382c:	00 c1                	add    %al,%cl
  40382e:	83 db 03             	sbb    $0x3,%ebx
  403831:	29 fb                	sub    %edi,%ebx
  403833:	8d 83 1c 01 00 00    	lea    0x11c(%ebx),%eax
  403839:	89 04 24             	mov    %eax,(%esp)
  40383c:	e8 c7 02 00 00       	call   403b08 <_malloc>
  403841:	85 c0                	test   %eax,%eax
  403843:	89 c6                	mov    %eax,%esi
  403845:	0f 84 84 00 00 00    	je     4038cf <___mingw_opendir+0x18f>
  40384b:	8d a8 18 01 00 00    	lea    0x118(%eax),%ebp
  403851:	83 c3 01             	add    $0x1,%ebx
  403854:	89 7c 24 04          	mov    %edi,0x4(%esp)
  403858:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  40385c:	89 2c 24             	mov    %ebp,(%esp)
  40385f:	e8 94 02 00 00       	call   403af8 <_memcpy>
  403864:	89 f2                	mov    %esi,%edx
  403866:	89 e8                	mov    %ebp,%eax
  403868:	e8 53 fd ff ff       	call   4035c0 <.text>
  40386d:	83 f8 ff             	cmp    $0xffffffff,%eax
  403870:	89 86 10 01 00 00    	mov    %eax,0x110(%esi)
  403876:	74 73                	je     4038eb <___mingw_opendir+0x1ab>
  403878:	b8 10 01 00 00       	mov    $0x110,%eax
  40387d:	c7 86 14 01 00 00 00 	movl   $0x0,0x114(%esi)
  403884:	00 00 00 
  403887:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  40388d:	66 89 46 04          	mov    %ax,0x4(%esi)
  403891:	81 c4 2c 01 00 00    	add    $0x12c,%esp
  403897:	89 f0                	mov    %esi,%eax
  403899:	5b                   	pop    %ebx
  40389a:	5e                   	pop    %esi
  40389b:	5f                   	pop    %edi
  40389c:	5d                   	pop    %ebp
  40389d:	c3                   	ret    
  40389e:	66 90                	xchg   %ax,%ax
  4038a0:	c1 ea 10             	shr    $0x10,%edx
  4038a3:	83 c0 02             	add    $0x2,%eax
  4038a6:	e9 48 ff ff ff       	jmp    4037f3 <___mingw_opendir+0xb3>
  4038ab:	90                   	nop
  4038ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  4038b0:	c1 ea 10             	shr    $0x10,%edx
  4038b3:	83 c0 02             	add    $0x2,%eax
  4038b6:	e9 eb fe ff ff       	jmp    4037a6 <___mingw_opendir+0x66>
  4038bb:	90                   	nop
  4038bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  4038c0:	e8 83 02 00 00       	call   403b48 <__errno>
  4038c5:	31 f6                	xor    %esi,%esi
  4038c7:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  4038cd:	eb c2                	jmp    403891 <___mingw_opendir+0x151>
  4038cf:	e8 74 02 00 00       	call   403b48 <__errno>
  4038d4:	c7 00 0c 00 00 00    	movl   $0xc,(%eax)
  4038da:	eb b5                	jmp    403891 <___mingw_opendir+0x151>
  4038dc:	e8 67 02 00 00       	call   403b48 <__errno>
  4038e1:	31 f6                	xor    %esi,%esi
  4038e3:	c7 00 16 00 00 00    	movl   $0x16,(%eax)
  4038e9:	eb a6                	jmp    403891 <___mingw_opendir+0x151>
  4038eb:	89 34 24             	mov    %esi,(%esp)
  4038ee:	31 f6                	xor    %esi,%esi
  4038f0:	e8 23 02 00 00       	call   403b18 <_free>
  4038f5:	eb 9a                	jmp    403891 <___mingw_opendir+0x151>
  4038f7:	89 f6                	mov    %esi,%esi
  4038f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00403900 <___mingw_readdir>:
  403900:	53                   	push   %ebx
  403901:	83 ec 08             	sub    $0x8,%esp
  403904:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  403908:	85 db                	test   %ebx,%ebx
  40390a:	74 2b                	je     403937 <___mingw_readdir+0x37>
  40390c:	8b 83 14 01 00 00    	mov    0x114(%ebx),%eax
  403912:	8d 50 01             	lea    0x1(%eax),%edx
  403915:	85 c0                	test   %eax,%eax
  403917:	89 93 14 01 00 00    	mov    %edx,0x114(%ebx)
  40391d:	7e 11                	jle    403930 <___mingw_readdir+0x30>
  40391f:	8b 83 10 01 00 00    	mov    0x110(%ebx),%eax
  403925:	89 da                	mov    %ebx,%edx
  403927:	e8 64 fd ff ff       	call   403690 <.text+0xd0>
  40392c:	85 c0                	test   %eax,%eax
  40392e:	74 02                	je     403932 <___mingw_readdir+0x32>
  403930:	89 d8                	mov    %ebx,%eax
  403932:	83 c4 08             	add    $0x8,%esp
  403935:	5b                   	pop    %ebx
  403936:	c3                   	ret    
  403937:	e8 0c 02 00 00       	call   403b48 <__errno>
  40393c:	c7 00 09 00 00 00    	movl   $0x9,(%eax)
  403942:	31 c0                	xor    %eax,%eax
  403944:	eb ec                	jmp    403932 <___mingw_readdir+0x32>
  403946:	8d 76 00             	lea    0x0(%esi),%esi
  403949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00403950 <___mingw_closedir>:
  403950:	53                   	push   %ebx
  403951:	83 ec 18             	sub    $0x18,%esp
  403954:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  403958:	85 db                	test   %ebx,%ebx
  40395a:	74 24                	je     403980 <___mingw_closedir+0x30>
  40395c:	8b 83 10 01 00 00    	mov    0x110(%ebx),%eax
  403962:	89 04 24             	mov    %eax,(%esp)
  403965:	e8 76 02 00 00       	call   403be0 <_FindClose@4>
  40396a:	83 ec 04             	sub    $0x4,%esp
  40396d:	85 c0                	test   %eax,%eax
  40396f:	74 0f                	je     403980 <___mingw_closedir+0x30>
  403971:	89 1c 24             	mov    %ebx,(%esp)
  403974:	e8 9f 01 00 00       	call   403b18 <_free>
  403979:	31 c0                	xor    %eax,%eax
  40397b:	83 c4 18             	add    $0x18,%esp
  40397e:	5b                   	pop    %ebx
  40397f:	c3                   	ret    
  403980:	e8 c3 01 00 00       	call   403b48 <__errno>
  403985:	c7 00 09 00 00 00    	movl   $0x9,(%eax)
  40398b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  403990:	eb e9                	jmp    40397b <___mingw_closedir+0x2b>
  403992:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  403999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

004039a0 <___mingw_rewinddir>:
  4039a0:	53                   	push   %ebx
  4039a1:	83 ec 18             	sub    $0x18,%esp
  4039a4:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  4039a8:	85 db                	test   %ebx,%ebx
  4039aa:	74 15                	je     4039c1 <___mingw_rewinddir+0x21>
  4039ac:	8b 83 10 01 00 00    	mov    0x110(%ebx),%eax
  4039b2:	89 04 24             	mov    %eax,(%esp)
  4039b5:	e8 26 02 00 00       	call   403be0 <_FindClose@4>
  4039ba:	83 ec 04             	sub    $0x4,%esp
  4039bd:	85 c0                	test   %eax,%eax
  4039bf:	75 10                	jne    4039d1 <___mingw_rewinddir+0x31>
  4039c1:	e8 82 01 00 00       	call   403b48 <__errno>
  4039c6:	c7 00 09 00 00 00    	movl   $0x9,(%eax)
  4039cc:	83 c4 18             	add    $0x18,%esp
  4039cf:	5b                   	pop    %ebx
  4039d0:	c3                   	ret    
  4039d1:	8d 83 18 01 00 00    	lea    0x118(%ebx),%eax
  4039d7:	89 da                	mov    %ebx,%edx
  4039d9:	e8 e2 fb ff ff       	call   4035c0 <.text>
  4039de:	83 f8 ff             	cmp    $0xffffffff,%eax
  4039e1:	89 83 10 01 00 00    	mov    %eax,0x110(%ebx)
  4039e7:	74 e3                	je     4039cc <___mingw_rewinddir+0x2c>
  4039e9:	c7 83 14 01 00 00 00 	movl   $0x0,0x114(%ebx)
  4039f0:	00 00 00 
  4039f3:	83 c4 18             	add    $0x18,%esp
  4039f6:	5b                   	pop    %ebx
  4039f7:	c3                   	ret    
  4039f8:	90                   	nop
  4039f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00403a00 <___mingw_telldir>:
  403a00:	83 ec 0c             	sub    $0xc,%esp
  403a03:	8b 44 24 10          	mov    0x10(%esp),%eax
  403a07:	85 c0                	test   %eax,%eax
  403a09:	74 0a                	je     403a15 <___mingw_telldir+0x15>
  403a0b:	8b 80 14 01 00 00    	mov    0x114(%eax),%eax
  403a11:	83 c4 0c             	add    $0xc,%esp
  403a14:	c3                   	ret    
  403a15:	e8 2e 01 00 00       	call   403b48 <__errno>
  403a1a:	c7 00 09 00 00 00    	movl   $0x9,(%eax)
  403a20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  403a25:	eb ea                	jmp    403a11 <___mingw_telldir+0x11>
  403a27:	89 f6                	mov    %esi,%esi
  403a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00403a30 <___mingw_seekdir>:
  403a30:	56                   	push   %esi
  403a31:	53                   	push   %ebx
  403a32:	83 ec 14             	sub    $0x14,%esp
  403a35:	8b 74 24 24          	mov    0x24(%esp),%esi
  403a39:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  403a3d:	85 f6                	test   %esi,%esi
  403a3f:	78 4f                	js     403a90 <___mingw_seekdir+0x60>
  403a41:	89 1c 24             	mov    %ebx,(%esp)
  403a44:	e8 57 ff ff ff       	call   4039a0 <___mingw_rewinddir>
  403a49:	85 f6                	test   %esi,%esi
  403a4b:	74 37                	je     403a84 <___mingw_seekdir+0x54>
  403a4d:	83 bb 10 01 00 00 ff 	cmpl   $0xffffffff,0x110(%ebx)
  403a54:	75 1b                	jne    403a71 <___mingw_seekdir+0x41>
  403a56:	eb 2c                	jmp    403a84 <___mingw_seekdir+0x54>
  403a58:	90                   	nop
  403a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  403a60:	8b 83 10 01 00 00    	mov    0x110(%ebx),%eax
  403a66:	89 da                	mov    %ebx,%edx
  403a68:	e8 23 fc ff ff       	call   403690 <.text+0xd0>
  403a6d:	85 c0                	test   %eax,%eax
  403a6f:	74 13                	je     403a84 <___mingw_seekdir+0x54>
  403a71:	8b 83 14 01 00 00    	mov    0x114(%ebx),%eax
  403a77:	83 c0 01             	add    $0x1,%eax
  403a7a:	39 c6                	cmp    %eax,%esi
  403a7c:	89 83 14 01 00 00    	mov    %eax,0x114(%ebx)
  403a82:	7f dc                	jg     403a60 <___mingw_seekdir+0x30>
  403a84:	83 c4 14             	add    $0x14,%esp
  403a87:	5b                   	pop    %ebx
  403a88:	5e                   	pop    %esi
  403a89:	c3                   	ret    
  403a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  403a90:	e8 b3 00 00 00       	call   403b48 <__errno>
  403a95:	c7 00 16 00 00 00    	movl   $0x16,(%eax)
  403a9b:	83 c4 14             	add    $0x14,%esp
  403a9e:	5b                   	pop    %ebx
  403a9f:	5e                   	pop    %esi
  403aa0:	c3                   	ret    
  403aa1:	90                   	nop
  403aa2:	90                   	nop
  403aa3:	90                   	nop
  403aa4:	90                   	nop
  403aa5:	90                   	nop
  403aa6:	90                   	nop
  403aa7:	90                   	nop
  403aa8:	90                   	nop
  403aa9:	90                   	nop
  403aaa:	90                   	nop
  403aab:	90                   	nop
  403aac:	90                   	nop
  403aad:	90                   	nop
  403aae:	90                   	nop
  403aaf:	90                   	nop

00403ab0 <_wcstombs>:
  403ab0:	ff 25 f8 81 40 00    	jmp    *0x4081f8
  403ab6:	90                   	nop
  403ab7:	90                   	nop

00403ab8 <_vfprintf>:
  403ab8:	ff 25 f4 81 40 00    	jmp    *0x4081f4
  403abe:	90                   	nop
  403abf:	90                   	nop

00403ac0 <_tolower>:
  403ac0:	ff 25 f0 81 40 00    	jmp    *0x4081f0
  403ac6:	90                   	nop
  403ac7:	90                   	nop

00403ac8 <_strlen>:
  403ac8:	ff 25 ec 81 40 00    	jmp    *0x4081ec
  403ace:	90                   	nop
  403acf:	90                   	nop

00403ad0 <_strcoll>:
  403ad0:	ff 25 e8 81 40 00    	jmp    *0x4081e8
  403ad6:	90                   	nop
  403ad7:	90                   	nop

00403ad8 <_signal>:
  403ad8:	ff 25 e4 81 40 00    	jmp    *0x4081e4
  403ade:	90                   	nop
  403adf:	90                   	nop

00403ae0 <_setlocale>:
  403ae0:	ff 25 e0 81 40 00    	jmp    *0x4081e0
  403ae6:	90                   	nop
  403ae7:	90                   	nop

00403ae8 <_realloc>:
  403ae8:	ff 25 dc 81 40 00    	jmp    *0x4081dc
  403aee:	90                   	nop
  403aef:	90                   	nop

00403af0 <_printf>:
  403af0:	ff 25 d8 81 40 00    	jmp    *0x4081d8
  403af6:	90                   	nop
  403af7:	90                   	nop

00403af8 <_memcpy>:
  403af8:	ff 25 d4 81 40 00    	jmp    *0x4081d4
  403afe:	90                   	nop
  403aff:	90                   	nop

00403b00 <_mbstowcs>:
  403b00:	ff 25 d0 81 40 00    	jmp    *0x4081d0
  403b06:	90                   	nop
  403b07:	90                   	nop

00403b08 <_malloc>:
  403b08:	ff 25 cc 81 40 00    	jmp    *0x4081cc
  403b0e:	90                   	nop
  403b0f:	90                   	nop

00403b10 <_fwrite>:
  403b10:	ff 25 c8 81 40 00    	jmp    *0x4081c8
  403b16:	90                   	nop
  403b17:	90                   	nop

00403b18 <_free>:
  403b18:	ff 25 c4 81 40 00    	jmp    *0x4081c4
  403b1e:	90                   	nop
  403b1f:	90                   	nop

00403b20 <_calloc>:
  403b20:	ff 25 c0 81 40 00    	jmp    *0x4081c0
  403b26:	90                   	nop
  403b27:	90                   	nop

00403b28 <_abort>:
  403b28:	ff 25 b8 81 40 00    	jmp    *0x4081b8
  403b2e:	90                   	nop
  403b2f:	90                   	nop

00403b30 <__setmode>:
  403b30:	ff 25 b4 81 40 00    	jmp    *0x4081b4
  403b36:	90                   	nop
  403b37:	90                   	nop

00403b38 <__isctype>:
  403b38:	ff 25 a8 81 40 00    	jmp    *0x4081a8
  403b3e:	90                   	nop
  403b3f:	90                   	nop

00403b40 <__fullpath>:
  403b40:	ff 25 a0 81 40 00    	jmp    *0x4081a0
  403b46:	90                   	nop
  403b47:	90                   	nop

00403b48 <__errno>:
  403b48:	ff 25 98 81 40 00    	jmp    *0x408198
  403b4e:	90                   	nop
  403b4f:	90                   	nop

00403b50 <__cexit>:
  403b50:	ff 25 94 81 40 00    	jmp    *0x408194
  403b56:	90                   	nop
  403b57:	90                   	nop

00403b58 <___p__fmode>:
  403b58:	ff 25 8c 81 40 00    	jmp    *0x40818c
  403b5e:	90                   	nop
  403b5f:	90                   	nop

00403b60 <___p__environ>:
  403b60:	ff 25 88 81 40 00    	jmp    *0x408188
  403b66:	90                   	nop
  403b67:	90                   	nop

00403b68 <___getmainargs>:
  403b68:	ff 25 80 81 40 00    	jmp    *0x408180
  403b6e:	90                   	nop
  403b6f:	90                   	nop

00403b70 <_VirtualQuery@12>:
  403b70:	ff 25 6c 81 40 00    	jmp    *0x40816c
  403b76:	90                   	nop
  403b77:	90                   	nop

00403b78 <_VirtualProtect@16>:
  403b78:	ff 25 68 81 40 00    	jmp    *0x408168
  403b7e:	90                   	nop
  403b7f:	90                   	nop

00403b80 <_TlsGetValue@4>:
  403b80:	ff 25 64 81 40 00    	jmp    *0x408164
  403b86:	90                   	nop
  403b87:	90                   	nop

00403b88 <_SetUnhandledExceptionFilter@4>:
  403b88:	ff 25 60 81 40 00    	jmp    *0x408160
  403b8e:	90                   	nop
  403b8f:	90                   	nop

00403b90 <_LoadLibraryA@4>:
  403b90:	ff 25 5c 81 40 00    	jmp    *0x40815c
  403b96:	90                   	nop
  403b97:	90                   	nop

00403b98 <_LeaveCriticalSection@4>:
  403b98:	ff 25 58 81 40 00    	jmp    *0x408158
  403b9e:	90                   	nop
  403b9f:	90                   	nop

00403ba0 <_InitializeCriticalSection@4>:
  403ba0:	ff 25 54 81 40 00    	jmp    *0x408154
  403ba6:	90                   	nop
  403ba7:	90                   	nop

00403ba8 <_GetProcAddress@8>:
  403ba8:	ff 25 50 81 40 00    	jmp    *0x408150
  403bae:	90                   	nop
  403baf:	90                   	nop

00403bb0 <_GetModuleHandleA@4>:
  403bb0:	ff 25 4c 81 40 00    	jmp    *0x40814c
  403bb6:	90                   	nop
  403bb7:	90                   	nop

00403bb8 <_GetLastError@0>:
  403bb8:	ff 25 48 81 40 00    	jmp    *0x408148
  403bbe:	90                   	nop
  403bbf:	90                   	nop

00403bc0 <_GetCommandLineA@0>:
  403bc0:	ff 25 44 81 40 00    	jmp    *0x408144
  403bc6:	90                   	nop
  403bc7:	90                   	nop

00403bc8 <_FreeLibrary@4>:
  403bc8:	ff 25 40 81 40 00    	jmp    *0x408140
  403bce:	90                   	nop
  403bcf:	90                   	nop

00403bd0 <_FindNextFileA@8>:
  403bd0:	ff 25 3c 81 40 00    	jmp    *0x40813c
  403bd6:	90                   	nop
  403bd7:	90                   	nop

00403bd8 <_FindFirstFileA@8>:
  403bd8:	ff 25 38 81 40 00    	jmp    *0x408138
  403bde:	90                   	nop
  403bdf:	90                   	nop

00403be0 <_FindClose@4>:
  403be0:	ff 25 34 81 40 00    	jmp    *0x408134
  403be6:	90                   	nop
  403be7:	90                   	nop

00403be8 <_ExitProcess@4>:
  403be8:	ff 25 30 81 40 00    	jmp    *0x408130
  403bee:	90                   	nop
  403bef:	90                   	nop

00403bf0 <_EnterCriticalSection@4>:
  403bf0:	ff 25 2c 81 40 00    	jmp    *0x40812c
  403bf6:	90                   	nop
  403bf7:	90                   	nop

00403bf8 <_DeleteCriticalSection@4>:
  403bf8:	ff 25 28 81 40 00    	jmp    *0x408128
  403bfe:	90                   	nop
  403bff:	90                   	nop

00403c00 <_stricoll>:
  403c00:	ff 25 78 81 40 00    	jmp    *0x408178
  403c06:	90                   	nop
  403c07:	90                   	nop

00403c08 <_strdup>:
  403c08:	ff 25 74 81 40 00    	jmp    *0x408174
  403c0e:	90                   	nop
  403c0f:	90                   	nop

00403c10 <_register_frame_ctor>:
  403c10:	55                   	push   %ebp
  403c11:	89 e5                	mov    %esp,%ebp
  403c13:	5d                   	pop    %ebp
  403c14:	e9 27 d7 ff ff       	jmp    401340 <___gcc_register_frame>
  403c19:	90                   	nop
  403c1a:	90                   	nop
  403c1b:	90                   	nop
  403c1c:	90                   	nop
  403c1d:	90                   	nop
  403c1e:	90                   	nop
  403c1f:	90                   	nop

00403c20 <__CTOR_LIST__>:
  403c20:	ff                   	(bad)  
  403c21:	ff                   	(bad)  
  403c22:	ff                   	(bad)  
  403c23:	ff                   	.byte 0xff

00403c24 <.ctors.65535>:
  403c24:	10 3c 40             	adc    %bh,(%eax,%eax,2)
  403c27:	00 00                	add    %al,(%eax)
  403c29:	00 00                	add    %al,(%eax)
	...

00403c2c <__DTOR_LIST__>:
  403c2c:	ff                   	(bad)  
  403c2d:	ff                   	(bad)  
  403c2e:	ff                   	(bad)  
  403c2f:	ff 00                	incl   (%eax)
  403c31:	00 00                	add    %al,(%eax)
	...
