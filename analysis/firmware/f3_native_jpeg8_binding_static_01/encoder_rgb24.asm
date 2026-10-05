INPUT_SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
STATIC_ONLY_NEAREST_LABELS_NOT_AUTHORITATIVE

/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000009770a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm>:
  98d8a8: d10183ff     	sub	sp, sp, #0x60
  98d8ac: a9017bfd     	stp	x29, x30, [sp, #0x10]
  98d8b0: 910043fd     	add	x29, sp, #0x10
  98d8b4: f90027e0     	str	x0, [sp, #0x48]
  98d8b8: f90023e1     	str	x1, [sp, #0x40]
  98d8bc: b9003fe2     	str	w2, [sp, #0x3c]
  98d8c0: b9003be3     	str	w3, [sp, #0x38]
  98d8c4: b90037e4     	str	w4, [sp, #0x34]
  98d8c8: f90017e5     	str	x5, [sp, #0x28]
  98d8cc: b90033e6     	str	w6, [sp, #0x30]
  98d8d0: f94027e0     	ldr	x0, [sp, #0x48]
  98d8d4: 91002000     	add	x0, x0, #0x8
  98d8d8: 97e9f21a     	bl	0x40a140 <_setjmp@plt>
  98d8dc: 7100001f     	cmp	w0, #0x0
  98d8e0: 1a9f07e0     	cset	w0, ne
  98d8e4: 12001c00     	and	w0, w0, #0xff
  98d8e8: 7100001f     	cmp	w0, #0x0
  98d8ec: 540000a0     	b.eq	0x98d900 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x16860>
  98d8f0: f94027e0     	ldr	x0, [sp, #0x48]
  98d8f4: 97ffff4e     	bl	0x98d62c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x1658c>
  98d8f8: 52800000     	mov	w0, #0x0                // =0
  98d8fc: 14000012     	b	0x98d944 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x168a4>
  98d900: 52800060     	mov	w0, #0x3                // =3
  98d904: b9005fe0     	str	w0, [sp, #0x5c]
  98d908: 52800001     	mov	w1, #0x0                // =0
  98d90c: f94027e0     	ldr	x0, [sp, #0x48]
  98d910: 97fffda1     	bl	0x98cf94 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x15ef4>
  98d914: 12800000     	mov	w0, #-0x1               // =-1
  98d918: b90003e0     	str	w0, [sp]
  98d91c: 52800067     	mov	w7, #0x3                // =3
  98d920: b94033e6     	ldr	w6, [sp, #0x30]
  98d924: f94017e5     	ldr	x5, [sp, #0x28]
  98d928: b94037e4     	ldr	w4, [sp, #0x34]
  98d92c: b9403be3     	ldr	w3, [sp, #0x38]
  98d930: b9403fe2     	ldr	w2, [sp, #0x3c]
  98d934: f94023e1     	ldr	x1, [sp, #0x40]
  98d938: f94027e0     	ldr	x0, [sp, #0x48]
  98d93c: 97ffff51     	bl	0x98d680 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x165e0>
  98d940: d503201f     	nop
  98d944: a9417bfd     	ldp	x29, x30, [sp, #0x10]
  98d948: 910183ff     	add	sp, sp, #0x60
  98d94c: d65f03c0     	ret
