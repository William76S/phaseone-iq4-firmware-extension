
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f1_f4_user_integration_build_02_attempt02/P1Linux_RatioMask_LVRecording_6.03.29.bin:	file format elf64-littleaarch64

Disassembly of section .f1.12.1.text:

000000000424c110 <iq4_extensions_lv_menu_wrapper_01>:
 424c110: d10403ff     	sub	sp, sp, #0x100
 424c114: a90f7bfd     	stp	x29, x30, [sp, #0xf0]
 424c118: 910003fd     	mov	x29, sp
 424c11c: a90007e0     	stp	x0, x1, [sp]
 424c120: a9010fe2     	stp	x2, x3, [sp, #0x10]
 424c124: a90217e4     	stp	x4, x5, [sp, #0x20]
 424c128: a9031fe6     	stp	x6, x7, [sp, #0x30]
 424c12c: f90023e8     	str	x8, [sp, #0x40]
 424c130: d53b4209     	mrs	x9, NZCV
 424c134: f90027e9     	str	x9, [sp, #0x48]
 424c138: ad0287e0     	stp	q0, q1, [sp, #0x50]
 424c13c: ad038fe2     	stp	q2, q3, [sp, #0x70]
 424c140: ad0497e4     	stp	q4, q5, [sp, #0x90]
 424c144: ad059fe6     	stp	q6, q7, [sp, #0xb0]
 424c148: aa1e03e2     	mov	x2, x30
 424c14c: 97fff444     	bl	0x424925c <iq4_f1_before_native_menu_04>
 424c150: a94007e0     	ldp	x0, x1, [sp]
 424c154: f9407fe2     	ldr	x2, [sp, #0xf8]
 424c158: 52800143     	mov	w3, #0xa                // =10
 424c15c: 97ffe679     	bl	0x4245b40 <iq4_f4_native_menu_entry_02>
 424c160: ad4287e0     	ldp	q0, q1, [sp, #0x50]
 424c164: ad438fe2     	ldp	q2, q3, [sp, #0x70]
 424c168: ad4497e4     	ldp	q4, q5, [sp, #0x90]
 424c16c: ad459fe6     	ldp	q6, q7, [sp, #0xb0]
 424c170: f94027e9     	ldr	x9, [sp, #0x48]
 424c174: d51b4209     	msr	NZCV, x9
 424c178: a94007e0     	ldp	x0, x1, [sp]
 424c17c: a9410fe2     	ldp	x2, x3, [sp, #0x10]
 424c180: a94217e4     	ldp	x4, x5, [sp, #0x20]
 424c184: a9431fe6     	ldp	x6, x7, [sp, #0x30]
 424c188: f94023e8     	ldr	x8, [sp, #0x40]
 424c18c: a94f7bfd     	ldp	x29, x30, [sp, #0xf0]
 424c190: 910403ff     	add	sp, sp, #0x100
 424c194: 170abc74     	b	0x4fb364 <.text+0xf0134>
