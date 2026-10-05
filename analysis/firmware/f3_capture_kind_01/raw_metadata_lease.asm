
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000435fac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_>:
  4950e8: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  4950ec: 910003fd     	mov	x29, sp
  4950f0: f9000fe0     	str	x0, [sp, #0x18]
  4950f4: f9000be1     	str	x1, [sp, #0x10]
  4950f8: f9400fe0     	ldr	x0, [sp, #0x18]
  4950fc: f9400be1     	ldr	x1, [sp, #0x10]
  495100: f9000001     	str	x1, [x0]
  495104: f9400fe0     	ldr	x0, [sp, #0x18]
  495108: f900041f     	str	xzr, [x0, #0x8]
  49510c: f9400fe0     	ldr	x0, [sp, #0x18]
  495110: f9400000     	ldr	x0, [x0]
  495114: f100001f     	cmp	x0, #0x0
  495118: 540003c0     	b.eq	0x495190 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f1e4>
  49511c: f9400fe0     	ldr	x0, [sp, #0x18]
  495120: f9400000     	ldr	x0, [x0]
  495124: 9410b506     	bl	0x8c253c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bd10>
  495128: f9400fe0     	ldr	x0, [sp, #0x18]
  49512c: f9400000     	ldr	x0, [x0]
  495130: 9410b524     	bl	0x8c25c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bd94>
  495134: aa0003e1     	mov	x1, x0
  495138: f9400fe0     	ldr	x0, [sp, #0x18]
  49513c: f9000401     	str	x1, [x0, #0x8]
  495140: f9400fe0     	ldr	x0, [sp, #0x18]
  495144: f9400400     	ldr	x0, [x0, #0x8]
  495148: f100001f     	cmp	x0, #0x0
  49514c: 54000221     	b.ne	0x495190 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f1e4>
  495150: b0003740     	adrp	x0, 0xb7e000
  495154: 9113c003     	add	x3, x0, #0x4f0
  495158: 52802b42     	mov	w2, #0x15a              // =346
  49515c: b0003740     	adrp	x0, 0xb7e000
  495160: 9114a001     	add	x1, x0, #0x528
  495164: 52800040     	mov	w0, #0x2                // =2
  495168: 940ac4f9     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  49516c: 52800500     	mov	w0, #0x28               // =40
  495170: 9409ee32     	bl	0x710a38 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x229b8>
  495174: f9400fe0     	ldr	x0, [sp, #0x18]
  495178: f9400000     	ldr	x0, [x0]
  49517c: 9410b511     	bl	0x8c25c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bd94>
  495180: aa0003e1     	mov	x1, x0
  495184: f9400fe0     	ldr	x0, [sp, #0x18]
  495188: f9000401     	str	x1, [x0, #0x8]
  49518c: 17ffffed     	b	0x495140 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f194>
  495190: d503201f     	nop
  495194: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  495198: d65f03c0     	ret
  49519c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  4951a0: 910003fd     	mov	x29, sp
  4951a4: f9000fe0     	str	x0, [sp, #0x18]
  4951a8: f9400fe0     	ldr	x0, [sp, #0x18]
  4951ac: f9400000     	ldr	x0, [x0]
  4951b0: f100001f     	cmp	x0, #0x0
  4951b4: 54000160     	b.eq	0x4951e0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f234>
  4951b8: f9400fe0     	ldr	x0, [sp, #0x18]
  4951bc: f9400400     	ldr	x0, [x0, #0x8]
  4951c0: f100001f     	cmp	x0, #0x0
  4951c4: 54000080     	b.eq	0x4951d4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f228>
  4951c8: f9400fe0     	ldr	x0, [sp, #0x18]
  4951cc: f9400000     	ldr	x0, [x0]
  4951d0: 9410b526     	bl	0x8c2668 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1be3c>
  4951d4: f9400fe0     	ldr	x0, [sp, #0x18]
  4951d8: f9400000     	ldr	x0, [x0]
  4951dc: 9410b4e3     	bl	0x8c2568 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bd3c>
  4951e0: d503201f     	nop
  4951e4: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  4951e8: d65f03c0     	ret
  4951ec: d10043ff     	sub	sp, sp, #0x10
  4951f0: f90007e0     	str	x0, [sp, #0x8]
  4951f4: f94007e0     	ldr	x0, [sp, #0x8]
  4951f8: f9400400     	ldr	x0, [x0, #0x8]
  4951fc: 910043ff     	add	sp, sp, #0x10
  495200: d65f03c0     	ret
  495204: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  495208: 910003fd     	mov	x29, sp
  49520c: f9000fe0     	str	x0, [sp, #0x18]
  495210: f9000be1     	str	x1, [sp, #0x10]
  495214: f9400fe0     	ldr	x0, [sp, #0x18]
  495218: f9400be1     	ldr	x1, [sp, #0x10]
  49521c: f9000001     	str	x1, [x0]
  495220: f9400fe0     	ldr	x0, [sp, #0x18]
  495224: f900041f     	str	xzr, [x0, #0x8]
  495228: f9400fe0     	ldr	x0, [sp, #0x18]
  49522c: f9400000     	ldr	x0, [x0]
  495230: f100001f     	cmp	x0, #0x0
  495234: 54000140     	b.eq	0x49525c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f2b0>
  495238: f9400fe0     	ldr	x0, [sp, #0x18]
  49523c: f9400000     	ldr	x0, [x0]
  495240: 9410b4bf     	bl	0x8c253c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bd10>
  495244: f9400fe0     	ldr	x0, [sp, #0x18]
  495248: f9400000     	ldr	x0, [x0]
  49524c: 9410b541     	bl	0x8c2750 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bf24>
  495250: aa0003e1     	mov	x1, x0
  495254: f9400fe0     	ldr	x0, [sp, #0x18]
  495258: f9000401     	str	x1, [x0, #0x8]
  49525c: d503201f     	nop
  495260: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  495264: d65f03c0     	ret
  495268: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  49526c: 910003fd     	mov	x29, sp
  495270: f9000fe0     	str	x0, [sp, #0x18]
  495274: f9400fe0     	ldr	x0, [sp, #0x18]
  495278: f9400000     	ldr	x0, [x0]
  49527c: f100001f     	cmp	x0, #0x0
  495280: 54000160     	b.eq	0x4952ac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f300>
  495284: f9400fe0     	ldr	x0, [sp, #0x18]
  495288: f9400400     	ldr	x0, [x0, #0x8]
  49528c: f100001f     	cmp	x0, #0x0
  495290: 54000080     	b.eq	0x4952a0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f2f4>
  495294: f9400fe0     	ldr	x0, [sp, #0x18]
  495298: f9400000     	ldr	x0, [x0]
  49529c: 9410b551     	bl	0x8c27e0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bfb4>
  4952a0: f9400fe0     	ldr	x0, [sp, #0x18]
  4952a4: f9400000     	ldr	x0, [x0]
  4952a8: 9410b4b0     	bl	0x8c2568 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bd3c>
  4952ac: d503201f     	nop
  4952b0: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  4952b4: d65f03c0     	ret
  4952b8: d10043ff     	sub	sp, sp, #0x10
  4952bc: f90007e0     	str	x0, [sp, #0x8]
  4952c0: f94007e0     	ldr	x0, [sp, #0x8]
  4952c4: f9400400     	ldr	x0, [x0, #0x8]
  4952c8: 910043ff     	add	sp, sp, #0x10
  4952cc: d65f03c0     	ret
