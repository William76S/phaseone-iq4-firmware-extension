INPUT_SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
STATIC_ONLY_NEAREST_LABELS_NOT_AUTHORITATIVE

/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000009770a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm>:
  98d950: d10183ff     	sub	sp, sp, #0x60
  98d954: a9017bfd     	stp	x29, x30, [sp, #0x10]
  98d958: 910043fd     	add	x29, sp, #0x10
  98d95c: f90027e0     	str	x0, [sp, #0x48]
  98d960: f90023e1     	str	x1, [sp, #0x40]
  98d964: b9003fe2     	str	w2, [sp, #0x3c]
  98d968: b9003be3     	str	w3, [sp, #0x38]
  98d96c: b90037e4     	str	w4, [sp, #0x34]
  98d970: f90017e5     	str	x5, [sp, #0x28]
  98d974: b90033e6     	str	w6, [sp, #0x30]
  98d978: b90027e7     	str	w7, [sp, #0x24]
  98d97c: f94027e0     	ldr	x0, [sp, #0x48]
  98d980: 91002000     	add	x0, x0, #0x8
  98d984: 97e9f1ef     	bl	0x40a140 <_setjmp@plt>
  98d988: 7100001f     	cmp	w0, #0x0
  98d98c: 1a9f07e0     	cset	w0, ne
  98d990: 12001c00     	and	w0, w0, #0xff
  98d994: 7100001f     	cmp	w0, #0x0
  98d998: 540000a0     	b.eq	0x98d9ac <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x1690c>
  98d99c: f94027e0     	ldr	x0, [sp, #0x48]
  98d9a0: 97ffff23     	bl	0x98d62c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x1658c>
  98d9a4: 52800000     	mov	w0, #0x0                // =0
  98d9a8: 14000012     	b	0x98d9f0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x16950>
  98d9ac: 52800001     	mov	w1, #0x0                // =0
  98d9b0: f94027e0     	ldr	x0, [sp, #0x48]
  98d9b4: 97fffd78     	bl	0x98cf94 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x15ef4>
  98d9b8: 52800080     	mov	w0, #0x4                // =4
  98d9bc: b9005fe0     	str	w0, [sp, #0x5c]
  98d9c0: b94027e0     	ldr	w0, [sp, #0x24]
  98d9c4: b90003e0     	str	w0, [sp]
  98d9c8: 52800087     	mov	w7, #0x4                // =4
  98d9cc: b94033e6     	ldr	w6, [sp, #0x30]
  98d9d0: f94017e5     	ldr	x5, [sp, #0x28]
  98d9d4: b94037e4     	ldr	w4, [sp, #0x34]
  98d9d8: b9403be3     	ldr	w3, [sp, #0x38]
  98d9dc: b9403fe2     	ldr	w2, [sp, #0x3c]
  98d9e0: f94023e1     	ldr	x1, [sp, #0x40]
  98d9e4: f94027e0     	ldr	x0, [sp, #0x48]
  98d9e8: 97ffff26     	bl	0x98d680 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x165e0>
  98d9ec: d503201f     	nop
  98d9f0: a9417bfd     	ldp	x29, x30, [sp, #0x10]
  98d9f4: 910183ff     	add	sp, sp, #0x60
  98d9f8: d65f03c0     	ret
