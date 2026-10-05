
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f3_capture_menu_build_02/wrapper.o:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000000000 <iq4_f3_file_settings_append_wrapper_01>:
       0: d10483ff     	sub	sp, sp, #0x120
       4: a9117bfd     	stp	x29, x30, [sp, #0x110]
       8: 910003fd     	mov	x29, sp
       c: f90083e0     	str	x0, [sp, #0x100]
      10: d28b1710     	mov	x16, #0x58b8            // =22712
      14: f2a009d0     	movk	x16, #0x4e, lsl #16
      18: d63f0200     	blr	x16
      1c: a90007e0     	stp	x0, x1, [sp]
      20: a9010fe2     	stp	x2, x3, [sp, #0x10]
      24: a90217e4     	stp	x4, x5, [sp, #0x20]
      28: a9031fe6     	stp	x6, x7, [sp, #0x30]
      2c: f90023e8     	str	x8, [sp, #0x40]
      30: d53b4209     	mrs	x9, NZCV
      34: f90027e9     	str	x9, [sp, #0x48]
      38: ad0287e0     	stp	q0, q1, [sp, #0x50]
      3c: ad038fe2     	stp	q2, q3, [sp, #0x70]
      40: ad0497e4     	stp	q4, q5, [sp, #0x90]
      44: ad059fe6     	stp	q6, q7, [sp, #0xb0]
      48: f94083e0     	ldr	x0, [sp, #0x100]
      4c: f9408fe1     	ldr	x1, [sp, #0x118]
      50: 94000000     	bl	0x50 <iq4_f3_file_settings_append_wrapper_01+0x50>
      54: ad4287e0     	ldp	q0, q1, [sp, #0x50]
      58: ad438fe2     	ldp	q2, q3, [sp, #0x70]
      5c: ad4497e4     	ldp	q4, q5, [sp, #0x90]
      60: ad459fe6     	ldp	q6, q7, [sp, #0xb0]
      64: f94027e9     	ldr	x9, [sp, #0x48]
      68: d51b4209     	msr	NZCV, x9
      6c: a94007e0     	ldp	x0, x1, [sp]
      70: a9410fe2     	ldp	x2, x3, [sp, #0x10]
      74: a94217e4     	ldp	x4, x5, [sp, #0x20]
      78: a9431fe6     	ldp	x6, x7, [sp, #0x30]
      7c: f94023e8     	ldr	x8, [sp, #0x40]
      80: a9517bfd     	ldp	x29, x30, [sp, #0x110]
      84: 910483ff     	add	sp, sp, #0x120
      88: d65f03c0     	ret
