
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000007bbfc8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_>:
  80e794: d10043ff     	sub	sp, sp, #0x10
  80e798: f90007e0     	str	x0, [sp, #0x8]
  80e79c: bd0007e0     	str	s0, [sp, #0x4]
  80e7a0: bd4007e0     	ldr	s0, [sp, #0x4]
  80e7a4: 1e202018     	fcmpe	s0, #0.0
  80e7a8: 540000a8     	b.hi	0x80e7bc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x527f4>
  80e7ac: f94007e0     	ldr	x0, [sp, #0x8]
  80e7b0: 1e2e1000     	fmov	s0, #1.00000000
  80e7b4: bd013800     	str	s0, [x0, #0x138]
  80e7b8: 1400000e     	b	0x80e7f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x52828>
  80e7bc: bd4007e1     	ldr	s1, [sp, #0x4]
  80e7c0: 1e2e1000     	fmov	s0, #1.00000000
  80e7c4: 1e202030     	fcmpe	s1, s0
  80e7c8: 540000e5     	b.pl	0x80e7e4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x5281c>
  80e7cc: bd4007e0     	ldr	s0, [sp, #0x4]
  80e7d0: 1e2e1001     	fmov	s1, #1.00000000
  80e7d4: 1e201820     	fdiv	s0, s1, s0
  80e7d8: f94007e0     	ldr	x0, [sp, #0x8]
  80e7dc: bd013800     	str	s0, [x0, #0x138]
  80e7e0: 14000004     	b	0x80e7f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x52828>
  80e7e4: f94007e0     	ldr	x0, [sp, #0x8]
  80e7e8: b94007e1     	ldr	w1, [sp, #0x4]
  80e7ec: b9013801     	str	w1, [x0, #0x138]
  80e7f0: d503201f     	nop
  80e7f4: 910043ff     	add	sp, sp, #0x10
  80e7f8: d65f03c0     	ret
  80e7fc: d10043ff     	sub	sp, sp, #0x10
