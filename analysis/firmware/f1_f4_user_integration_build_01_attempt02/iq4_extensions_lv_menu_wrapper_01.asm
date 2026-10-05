
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f1_f4_user_integration_build_01_attempt02/P1Linux_RatioMask_LVRecording_6.03.28.bin:	file format elf64-littleaarch64

Disassembly of section .f1.12.1.text:

000000000424bee0 <iq4_extensions_lv_menu_wrapper_01>:
 424bee0: d10403ff     	sub	sp, sp, #0x100
 424bee4: a90f7bfd     	stp	x29, x30, [sp, #0xf0]
 424bee8: 910003fd     	mov	x29, sp
 424beec: a90007e0     	stp	x0, x1, [sp]
 424bef0: a9010fe2     	stp	x2, x3, [sp, #0x10]
 424bef4: a90217e4     	stp	x4, x5, [sp, #0x20]
 424bef8: a9031fe6     	stp	x6, x7, [sp, #0x30]
 424befc: f90023e8     	str	x8, [sp, #0x40]
 424bf00: d53b4209     	mrs	x9, NZCV
 424bf04: f90027e9     	str	x9, [sp, #0x48]
 424bf08: ad0287e0     	stp	q0, q1, [sp, #0x50]
 424bf0c: ad038fe2     	stp	q2, q3, [sp, #0x70]
 424bf10: ad0497e4     	stp	q4, q5, [sp, #0x90]
 424bf14: ad059fe6     	stp	q6, q7, [sp, #0xb0]
 424bf18: aa1e03e2     	mov	x2, x30
 424bf1c: 97fff444     	bl	0x424902c <iq4_f1_before_native_menu_04>
 424bf20: a94007e0     	ldp	x0, x1, [sp]
 424bf24: f9407fe2     	ldr	x2, [sp, #0xf8]
 424bf28: 52800143     	mov	w3, #0xa                // =10
 424bf2c: 97ffe679     	bl	0x4245910 <iq4_f4_native_menu_entry_02>
 424bf30: ad4287e0     	ldp	q0, q1, [sp, #0x50]
 424bf34: ad438fe2     	ldp	q2, q3, [sp, #0x70]
 424bf38: ad4497e4     	ldp	q4, q5, [sp, #0x90]
 424bf3c: ad459fe6     	ldp	q6, q7, [sp, #0xb0]
 424bf40: f94027e9     	ldr	x9, [sp, #0x48]
 424bf44: d51b4209     	msr	NZCV, x9
 424bf48: a94007e0     	ldp	x0, x1, [sp]
 424bf4c: a9410fe2     	ldp	x2, x3, [sp, #0x10]
 424bf50: a94217e4     	ldp	x4, x5, [sp, #0x20]
 424bf54: a9431fe6     	ldp	x6, x7, [sp, #0x30]
 424bf58: f94023e8     	ldr	x8, [sp, #0x40]
 424bf5c: a94f7bfd     	ldp	x29, x30, [sp, #0xf0]
 424bf60: 910403ff     	add	sp, sp, #0x100
 424bf64: 170abd00     	b	0x4fb364 <.text+0xf0134>
