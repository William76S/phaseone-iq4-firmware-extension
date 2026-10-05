
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f1_f4_user_integration_build_01_attempt03/P1Linux_RatioMask_LVRecording_6.03.28.bin:	file format elf64-littleaarch64

Disassembly of section .f1.7.2.text:

0000000004248178 <iq4_f4_menu_native_pop_wrapper_03>:
 4248178: d100c3ff     	sub	sp, sp, #0x30
 424817c: a9017bfd     	stp	x29, x30, [sp, #0x10]
 4248180: a9024ff4     	stp	x20, x19, [sp, #0x20]
 4248184: 910043fd     	add	x29, sp, #0x10
 4248188: 900002c8     	adrp	x8, 0x42a0000
 424818c: 900002c9     	adrp	x9, 0x42a0000
 4248190: aa0003f3     	mov	x19, x0
 4248194: f941d908     	ldr	x8, [x8, #0x3b0]
 4248198: 3956a129     	ldrb	w9, [x9, #0x5a8]
 424819c: 9104a108     	add	x8, x8, #0x128
 42481a0: eb00011f     	cmp	x8, x0
 42481a4: 7a400924     	ccmp	w9, #0x0, #0x4, eq
 42481a8: 540003c0     	b.eq	0x4248220 <iq4_f4_menu_native_pop_wrapper_03+0xa8>
 42481ac: 97fff78f     	bl	0x4245fe8 <iq4_f4_menu_page_guard_03>
 42481b0: 7100041f     	cmp	w0, #0x1
 42481b4: 54000361     	b.ne	0x4248220 <iq4_f4_menu_native_pop_wrapper_03+0xa8>
 42481b8: 900002c8     	adrp	x8, 0x42a0000
 42481bc: f942e500     	ldr	x0, [x8, #0x5c8]
 42481c0: b40000e0     	cbz	x0, 0x42481dc <iq4_f4_menu_native_pop_wrapper_03+0x64>
 42481c4: 97ffe627     	bl	0x4241a60 <iq4_f4_source_request_stop_02>
 42481c8: 7100141f     	cmp	w0, #0x5
 42481cc: 54000081     	b.ne	0x42481dc <iq4_f4_menu_native_pop_wrapper_03+0x64>
 42481d0: 900002c8     	adrp	x8, 0x42a0000
 42481d4: 52800029     	mov	w9, #0x1                // =1
 42481d8: 390ea109     	strb	w9, [x8, #0x3a8]
 42481dc: 900002c8     	adrp	x8, 0x42a0000
 42481e0: 9116c108     	add	x8, x8, #0x5b0
 42481e4: 52800021     	mov	w1, #0x1                // =1
 42481e8: a9402500     	ldp	x0, x9, [x8]
 42481ec: 52800034     	mov	w20, #0x1               // =1
 42481f0: d63f0120     	blr	x9
 42481f4: 71000c1f     	cmp	w0, #0x3
 42481f8: 54000061     	b.ne	0x4248204 <iq4_f4_menu_native_pop_wrapper_03+0x8c>
 42481fc: 900002c8     	adrp	x8, 0x42a0000
 4248200: 390ea114     	strb	w20, [x8, #0x3a8]
 4248204: d10013a1     	sub	x1, x29, #0x4
 4248208: aa1303e0     	mov	x0, x19
 424820c: b81fc3bf     	stur	wzr, [x29, #-0x4]
 4248210: 94000317     	bl	0x4248e6c <iq4_f4_menu_pop_03>
 4248214: 34000100     	cbz	w0, 0x4248234 <iq4_f4_menu_native_pop_wrapper_03+0xbc>
 4248218: b85fc3a0     	ldur	w0, [x29, #-0x4]
 424821c: 14000009     	b	0x4248240 <iq4_f4_menu_native_pop_wrapper_03+0xc8>
 4248220: aa1303e0     	mov	x0, x19
 4248224: a9424ff4     	ldp	x20, x19, [sp, #0x20]
 4248228: a9417bfd     	ldp	x29, x30, [sp, #0x10]
 424822c: 9100c3ff     	add	sp, sp, #0x30
 4248230: 14000320     	b	0x4248eb0 <iq4_f4_menu_pop_passthrough_03>
 4248234: 900002c8     	adrp	x8, 0x42a0000
 4248238: 52800029     	mov	w9, #0x1                // =1
 424823c: 390ea109     	strb	w9, [x8, #0x3a8]
 4248240: a9424ff4     	ldp	x20, x19, [sp, #0x20]
 4248244: a9417bfd     	ldp	x29, x30, [sp, #0x10]
 4248248: 9100c3ff     	add	sp, sp, #0x30
 424824c: d65f03c0     	ret
