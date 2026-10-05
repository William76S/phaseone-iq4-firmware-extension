
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f1_f4_user_integration_build_02_attempt02/P1Linux_RatioMask_LVRecording_6.03.29.bin:	file format elf64-littleaarch64

Disassembly of section .f1.7.2.text:

00000000042481a0 <iq4_f4_menu_native_pop_wrapper_03>:
 42481a0: d100c3ff     	sub	sp, sp, #0x30
 42481a4: a9017bfd     	stp	x29, x30, [sp, #0x10]
 42481a8: a9024ff4     	stp	x20, x19, [sp, #0x20]
 42481ac: 910043fd     	add	x29, sp, #0x10
 42481b0: 900002c8     	adrp	x8, 0x42a0000
 42481b4: 900002c9     	adrp	x9, 0x42a0000
 42481b8: aa0003f3     	mov	x19, x0
 42481bc: f941d908     	ldr	x8, [x8, #0x3b0]
 42481c0: 3956a129     	ldrb	w9, [x9, #0x5a8]
 42481c4: 9104a108     	add	x8, x8, #0x128
 42481c8: eb00011f     	cmp	x8, x0
 42481cc: 7a400924     	ccmp	w9, #0x0, #0x4, eq
 42481d0: 540003c0     	b.eq	0x4248248 <iq4_f4_menu_native_pop_wrapper_03+0xa8>
 42481d4: 97fff78f     	bl	0x4246010 <iq4_f4_menu_page_guard_03>
 42481d8: 7100041f     	cmp	w0, #0x1
 42481dc: 54000361     	b.ne	0x4248248 <iq4_f4_menu_native_pop_wrapper_03+0xa8>
 42481e0: 900002c8     	adrp	x8, 0x42a0000
 42481e4: f942e500     	ldr	x0, [x8, #0x5c8]
 42481e8: b40000e0     	cbz	x0, 0x4248204 <iq4_f4_menu_native_pop_wrapper_03+0x64>
 42481ec: 97ffe61d     	bl	0x4241a60 <iq4_f4_source_request_stop_02>
 42481f0: 7100141f     	cmp	w0, #0x5
 42481f4: 54000081     	b.ne	0x4248204 <iq4_f4_menu_native_pop_wrapper_03+0x64>
 42481f8: 900002c8     	adrp	x8, 0x42a0000
 42481fc: 52800029     	mov	w9, #0x1                // =1
 4248200: 390ea109     	strb	w9, [x8, #0x3a8]
 4248204: 900002c8     	adrp	x8, 0x42a0000
 4248208: 9116c108     	add	x8, x8, #0x5b0
 424820c: 52800021     	mov	w1, #0x1                // =1
 4248210: a9402500     	ldp	x0, x9, [x8]
 4248214: 52800034     	mov	w20, #0x1               // =1
 4248218: d63f0120     	blr	x9
 424821c: 71000c1f     	cmp	w0, #0x3
 4248220: 54000061     	b.ne	0x424822c <iq4_f4_menu_native_pop_wrapper_03+0x8c>
 4248224: 900002c8     	adrp	x8, 0x42a0000
 4248228: 390ea114     	strb	w20, [x8, #0x3a8]
 424822c: d10013a1     	sub	x1, x29, #0x4
 4248230: aa1303e0     	mov	x0, x19
 4248234: b81fc3bf     	stur	wzr, [x29, #-0x4]
 4248238: 94000317     	bl	0x4248e94 <iq4_f4_menu_pop_03>
 424823c: 34000100     	cbz	w0, 0x424825c <iq4_f4_menu_native_pop_wrapper_03+0xbc>
 4248240: b85fc3a0     	ldur	w0, [x29, #-0x4]
 4248244: 14000009     	b	0x4248268 <iq4_f4_menu_native_pop_wrapper_03+0xc8>
 4248248: aa1303e0     	mov	x0, x19
 424824c: a9424ff4     	ldp	x20, x19, [sp, #0x20]
 4248250: a9417bfd     	ldp	x29, x30, [sp, #0x10]
 4248254: 9100c3ff     	add	sp, sp, #0x30
 4248258: 14000320     	b	0x4248ed8 <iq4_f4_menu_pop_passthrough_03>
 424825c: 900002c8     	adrp	x8, 0x42a0000
 4248260: 52800029     	mov	w9, #0x1                // =1
 4248264: 390ea109     	strb	w9, [x8, #0x3a8]
 4248268: a9424ff4     	ldp	x20, x19, [sp, #0x20]
 424826c: a9417bfd     	ldp	x29, x30, [sp, #0x10]
 4248270: 9100c3ff     	add	sp, sp, #0x30
 4248274: d65f03c0     	ret
