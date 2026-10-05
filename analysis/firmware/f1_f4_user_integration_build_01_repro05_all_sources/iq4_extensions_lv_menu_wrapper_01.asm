
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f1_f4_user_integration_build_01_repro05_all_sources/P1Linux_RatioMask_LVRecording_6.03.28.bin:	file format elf64-littleaarch64

Disassembly of section .f1.12.1.text:

000000000424c0f0 <iq4_extensions_lv_menu_wrapper_01>:
 424c0f0: d10403ff     	sub	sp, sp, #0x100
 424c0f4: a90f7bfd     	stp	x29, x30, [sp, #0xf0]
 424c0f8: 910003fd     	mov	x29, sp
 424c0fc: a90007e0     	stp	x0, x1, [sp]
 424c100: a9010fe2     	stp	x2, x3, [sp, #0x10]
 424c104: a90217e4     	stp	x4, x5, [sp, #0x20]
 424c108: a9031fe6     	stp	x6, x7, [sp, #0x30]
 424c10c: f90023e8     	str	x8, [sp, #0x40]
 424c110: d53b4209     	mrs	x9, NZCV
 424c114: f90027e9     	str	x9, [sp, #0x48]
 424c118: ad0287e0     	stp	q0, q1, [sp, #0x50]
 424c11c: ad038fe2     	stp	q2, q3, [sp, #0x70]
 424c120: ad0497e4     	stp	q4, q5, [sp, #0x90]
 424c124: ad059fe6     	stp	q6, q7, [sp, #0xb0]
 424c128: aa1e03e2     	mov	x2, x30
 424c12c: 97fff442     	bl	0x4249234 <iq4_f1_before_native_menu_04>
 424c130: a94007e0     	ldp	x0, x1, [sp]
 424c134: f9407fe2     	ldr	x2, [sp, #0xf8]
 424c138: 52800143     	mov	w3, #0xa                // =10
 424c13c: 97ffe677     	bl	0x4245b18 <iq4_f4_native_menu_entry_02>
 424c140: ad4287e0     	ldp	q0, q1, [sp, #0x50]
 424c144: ad438fe2     	ldp	q2, q3, [sp, #0x70]
 424c148: ad4497e4     	ldp	q4, q5, [sp, #0x90]
 424c14c: ad459fe6     	ldp	q6, q7, [sp, #0xb0]
 424c150: f94027e9     	ldr	x9, [sp, #0x48]
 424c154: d51b4209     	msr	NZCV, x9
 424c158: a94007e0     	ldp	x0, x1, [sp]
 424c15c: a9410fe2     	ldp	x2, x3, [sp, #0x10]
 424c160: a94217e4     	ldp	x4, x5, [sp, #0x20]
 424c164: a9431fe6     	ldp	x6, x7, [sp, #0x30]
 424c168: f94023e8     	ldr	x8, [sp, #0x40]
 424c16c: a94f7bfd     	ldp	x29, x30, [sp, #0xf0]
 424c170: 910403ff     	add	sp, sp, #0x100
 424c174: 170abc7c     	b	0x4fb364 <.text+0xf0134>
