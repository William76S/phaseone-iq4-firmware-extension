
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f1_f4_user_integration_build_01_attempt02/P1Linux_RatioMask_LVRecording_6.03.28.bin:	file format elf64-littleaarch64

Disassembly of section .f1.7.2.text:

0000000004247f70 <iq4_f4_menu_native_pop_wrapper_03>:
 4247f70: d100c3ff     	sub	sp, sp, #0x30
 4247f74: a9017bfd     	stp	x29, x30, [sp, #0x10]
 4247f78: a9024ff4     	stp	x20, x19, [sp, #0x20]
 4247f7c: 910043fd     	add	x29, sp, #0x10
 4247f80: b00002c8     	adrp	x8, 0x42a0000
 4247f84: b00002c9     	adrp	x9, 0x42a0000
 4247f88: aa0003f3     	mov	x19, x0
 4247f8c: f941a908     	ldr	x8, [x8, #0x350]
 4247f90: 39552129     	ldrb	w9, [x9, #0x548]
 4247f94: 9104a108     	add	x8, x8, #0x128
 4247f98: eb00011f     	cmp	x8, x0
 4247f9c: 7a400924     	ccmp	w9, #0x0, #0x4, eq
 4247fa0: 540003c0     	b.eq	0x4248018 <iq4_f4_menu_native_pop_wrapper_03+0xa8>
 4247fa4: 97fff78f     	bl	0x4245de0 <iq4_f4_menu_page_guard_03>
 4247fa8: 7100041f     	cmp	w0, #0x1
 4247fac: 54000361     	b.ne	0x4248018 <iq4_f4_menu_native_pop_wrapper_03+0xa8>
 4247fb0: b00002c8     	adrp	x8, 0x42a0000
 4247fb4: f942b500     	ldr	x0, [x8, #0x568]
 4247fb8: b40000e0     	cbz	x0, 0x4247fd4 <iq4_f4_menu_native_pop_wrapper_03+0x64>
 4247fbc: 97ffe6a1     	bl	0x4241a40 <iq4_f4_source_request_stop_02>
 4247fc0: 7100141f     	cmp	w0, #0x5
 4247fc4: 54000081     	b.ne	0x4247fd4 <iq4_f4_menu_native_pop_wrapper_03+0x64>
 4247fc8: b00002c8     	adrp	x8, 0x42a0000
 4247fcc: 52800029     	mov	w9, #0x1                // =1
 4247fd0: 390d2109     	strb	w9, [x8, #0x348]
 4247fd4: b00002c8     	adrp	x8, 0x42a0000
 4247fd8: 91154108     	add	x8, x8, #0x550
 4247fdc: 52800021     	mov	w1, #0x1                // =1
 4247fe0: a9402500     	ldp	x0, x9, [x8]
 4247fe4: 52800034     	mov	w20, #0x1               // =1
 4247fe8: d63f0120     	blr	x9
 4247fec: 71000c1f     	cmp	w0, #0x3
 4247ff0: 54000061     	b.ne	0x4247ffc <iq4_f4_menu_native_pop_wrapper_03+0x8c>
 4247ff4: b00002c8     	adrp	x8, 0x42a0000
 4247ff8: 390d2114     	strb	w20, [x8, #0x348]
 4247ffc: d10013a1     	sub	x1, x29, #0x4
 4248000: aa1303e0     	mov	x0, x19
 4248004: b81fc3bf     	stur	wzr, [x29, #-0x4]
 4248008: 94000317     	bl	0x4248c64 <iq4_f4_menu_pop_03>
 424800c: 34000100     	cbz	w0, 0x424802c <iq4_f4_menu_native_pop_wrapper_03+0xbc>
 4248010: b85fc3a0     	ldur	w0, [x29, #-0x4]
 4248014: 14000009     	b	0x4248038 <iq4_f4_menu_native_pop_wrapper_03+0xc8>
 4248018: aa1303e0     	mov	x0, x19
 424801c: a9424ff4     	ldp	x20, x19, [sp, #0x20]
 4248020: a9417bfd     	ldp	x29, x30, [sp, #0x10]
 4248024: 9100c3ff     	add	sp, sp, #0x30
 4248028: 14000320     	b	0x4248ca8 <iq4_f4_menu_pop_passthrough_03>
 424802c: 900002c8     	adrp	x8, 0x42a0000
 4248030: 52800029     	mov	w9, #0x1                // =1
 4248034: 390d2109     	strb	w9, [x8, #0x348]
 4248038: a9424ff4     	ldp	x20, x19, [sp, #0x20]
 424803c: a9417bfd     	ldp	x29, x30, [sp, #0x10]
 4248040: 9100c3ff     	add	sp, sp, #0x30
 4248044: d65f03c0     	ret
