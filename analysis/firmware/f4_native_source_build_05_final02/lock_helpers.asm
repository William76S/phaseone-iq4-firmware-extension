
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000006ee080 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_>:
  712324: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  712328: 910003fd     	mov	x29, sp
  71232c: f9000fe0     	str	x0, [sp, #0x18]
  712330: 97ffff34     	bl	0x712000 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x23f80>
  712334: 7100001f     	cmp	w0, #0x0
  712338: 1a9f07e0     	cset	w0, ne
  71233c: 12001c00     	and	w0, w0, #0xff
  712340: 7100001f     	cmp	w0, #0x0
  712344: 54000080     	b.eq	0x712354 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x242d4>
  712348: f9400fe0     	ldr	x0, [sp, #0x18]
  71234c: 97f3e1e5     	bl	0x40aae0 <pthread_mutex_lock@plt>
  712350: 14000002     	b	0x712358 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x242d8>
  712354: 52800000     	mov	w0, #0x0                // =0
  712358: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  71235c: d65f03c0     	ret
  712360: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  712364: 910003fd     	mov	x29, sp
  712368: f9000fe0     	str	x0, [sp, #0x18]
  71236c: 97ffff25     	bl	0x712000 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x23f80>
  712370: 7100001f     	cmp	w0, #0x0
  712374: 1a9f07e0     	cset	w0, ne
  712378: 12001c00     	and	w0, w0, #0xff
  71237c: 7100001f     	cmp	w0, #0x0
  712380: 54000080     	b.eq	0x712390 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24310>
  712384: f9400fe0     	ldr	x0, [sp, #0x18]
  712388: 97f3e2be     	bl	0x40ae80 <pthread_mutex_trylock@plt>
  71238c: 14000002     	b	0x712394 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24314>
  712390: 52800000     	mov	w0, #0x0                // =0
  712394: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  712398: d65f03c0     	ret
  71239c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  7123a0: 910003fd     	mov	x29, sp
  7123a4: f9000fe0     	str	x0, [sp, #0x18]
  7123a8: 97ffff16     	bl	0x712000 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x23f80>
  7123ac: 7100001f     	cmp	w0, #0x0
  7123b0: 1a9f07e0     	cset	w0, ne
  7123b4: 12001c00     	and	w0, w0, #0xff
  7123b8: 7100001f     	cmp	w0, #0x0
  7123bc: 54000080     	b.eq	0x7123cc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2434c>
  7123c0: f9400fe0     	ldr	x0, [sp, #0x18]
  7123c4: 97f3e0db     	bl	0x40a730 <pthread_mutex_unlock@plt>
  7123c8: 14000002     	b	0x7123d0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24350>
  7123cc: 52800000     	mov	w0, #0x0                // =0
  7123d0: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  7123d4: d65f03c0     	ret
  7123d8: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  7123dc: 910003fd     	mov	x29, sp
  7123e0: f9000fe0     	str	x0, [sp, #0x18]
  7123e4: f9400fe0     	ldr	x0, [sp, #0x18]
  7123e8: 97ffffcf     	bl	0x712324 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x242a4>
  7123ec: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  7123f0: d65f03c0     	ret
  7123f4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  7123f8: 910003fd     	mov	x29, sp
  7123fc: f9000fe0     	str	x0, [sp, #0x18]
  712400: f9400fe0     	ldr	x0, [sp, #0x18]
  712404: 97ffffd7     	bl	0x712360 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x242e0>
  712408: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  71240c: d65f03c0     	ret
  712410: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  712414: 910003fd     	mov	x29, sp
  712418: f9000fe0     	str	x0, [sp, #0x18]
  71241c: f9400fe0     	ldr	x0, [sp, #0x18]
  712420: 97ffffdf     	bl	0x71239c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2431c>
  712424: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  712428: d65f03c0     	ret
  71242c: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  712430: 910003fd     	mov	x29, sp
  712434: f9000fe0     	str	x0, [sp, #0x18]
  712438: f9400fe0     	ldr	x0, [sp, #0x18]
  71243c: 97ffffe7     	bl	0x7123d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24358>
  712440: b9002fe0     	str	w0, [sp, #0x2c]
  712444: b9402fe0     	ldr	w0, [sp, #0x2c]
  712448: 7100001f     	cmp	w0, #0x0
  71244c: 54000060     	b.eq	0x712458 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x243d8>
  712450: b9402fe0     	ldr	w0, [sp, #0x2c]
  712454: 97f3dfb7     	bl	0x40a330 <_ZSt20__throw_system_errori@plt>
  712458: d503201f     	nop
  71245c: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  712460: d65f03c0     	ret
  712464: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  712468: 910003fd     	mov	x29, sp
  71246c: f9000fe0     	str	x0, [sp, #0x18]
  712470: f9400fe0     	ldr	x0, [sp, #0x18]
  712474: 97ffffe0     	bl	0x7123f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24374>
  712478: 7100001f     	cmp	w0, #0x0
  71247c: 1a9f17e0     	cset	w0, eq
  712480: 12001c00     	and	w0, w0, #0xff
  712484: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  712488: d65f03c0     	ret
  71248c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  712490: 910003fd     	mov	x29, sp
  712494: f9000fe0     	str	x0, [sp, #0x18]
  712498: f9400fe0     	ldr	x0, [sp, #0x18]
  71249c: 97ffffdd     	bl	0x712410 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24390>
  7124a0: d503201f     	nop
  7124a4: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  7124a8: d65f03c0     	ret
