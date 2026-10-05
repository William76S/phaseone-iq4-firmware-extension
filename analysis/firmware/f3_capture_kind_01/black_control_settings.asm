
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000006a03c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm>:
  6a94ac: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  6a94b0: 910003fd     	mov	x29, sp
  6a94b4: f9000bf3     	str	x19, [sp, #0x10]
  6a94b8: f90017e0     	str	x0, [sp, #0x28]
  6a94bc: f94017e0     	ldr	x0, [sp, #0x28]
  6a94c0: f9400c01     	ldr	x1, [x0, #0x18]
  6a94c4: d2821d00     	mov	x0, #0x10e8             // =4328
  6a94c8: 8b000020     	add	x0, x1, x0
  6a94cc: 97fb9093     	bl	0x58d718 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x94668>
  6a94d0: 2a0003f3     	mov	w19, w0
  6a94d4: f94017e0     	ldr	x0, [sp, #0x28]
  6a94d8: f9400c01     	ldr	x1, [x0, #0x18]
  6a94dc: d2820100     	mov	x0, #0x1008             // =4104
  6a94e0: 8b000020     	add	x0, x1, x0
  6a94e4: 97faf18a     	bl	0x565b0c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x6ca5c>
  6a94e8: 2a0003e1     	mov	w1, w0
  6a94ec: 2a1303e0     	mov	w0, w19
  6a94f0: 9400000b     	bl	0x6a951c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x915c>
  6a94f4: b9003fe0     	str	w0, [sp, #0x3c]
  6a94f8: f94017e0     	ldr	x0, [sp, #0x28]
  6a94fc: f9400c00     	ldr	x0, [x0, #0x18]
  6a9500: 913ca000     	add	x0, x0, #0xf28
  6a9504: b9403fe1     	ldr	w1, [sp, #0x3c]
  6a9508: 97fb9690     	bl	0x58ef48 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x95e98>
  6a950c: d503201f     	nop
  6a9510: f9400bf3     	ldr	x19, [sp, #0x10]
  6a9514: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  6a9518: d65f03c0     	ret
  6a951c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  6a9520: 910003fd     	mov	x29, sp
  6a9524: b9001fe0     	str	w0, [sp, #0x1c]
  6a9528: b9001be1     	str	w1, [sp, #0x18]
  6a952c: b9401be0     	ldr	w0, [sp, #0x18]
  6a9530: 7100081f     	cmp	w0, #0x2
  6a9534: 54000061     	b.ne	0x6a9540 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x9180>
  6a9538: 52800080     	mov	w0, #0x4                // =4
  6a953c: 1400001e     	b	0x6a95b4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x91f4>
  6a9540: b9401fe0     	ldr	w0, [sp, #0x1c]
  6a9544: 7100041f     	cmp	w0, #0x1
  6a9548: 540001a0     	b.eq	0x6a957c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x91bc>
  6a954c: 7100041f     	cmp	w0, #0x1
  6a9550: 5400008c     	b.gt	0x6a9560 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x91a0>
  6a9554: 7100001f     	cmp	w0, #0x0
  6a9558: 540000e0     	b.eq	0x6a9574 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x91b4>
  6a955c: 1400000e     	b	0x6a9594 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x91d4>
  6a9560: 7100081f     	cmp	w0, #0x2
  6a9564: 54000100     	b.eq	0x6a9584 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x91c4>
  6a9568: 71000c1f     	cmp	w0, #0x3
  6a956c: 54000100     	b.eq	0x6a958c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x91cc>
  6a9570: 14000009     	b	0x6a9594 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x91d4>
  6a9574: 52800000     	mov	w0, #0x0                // =0
  6a9578: 1400000f     	b	0x6a95b4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x91f4>
  6a957c: 52800060     	mov	w0, #0x3                // =3
  6a9580: 1400000d     	b	0x6a95b4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x91f4>
  6a9584: 52800020     	mov	w0, #0x1                // =1
  6a9588: 1400000b     	b	0x6a95b4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x91f4>
  6a958c: 52800040     	mov	w0, #0x2                // =2
  6a9590: 14000009     	b	0x6a95b4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x91f4>
  6a9594: f0002ac0     	adrp	x0, 0xc04000
  6a9598: 91338003     	add	x3, x0, #0xce0
  6a959c: 52800722     	mov	w2, #0x39               // =57
  6a95a0: f0002ac0     	adrp	x0, 0xc04000
  6a95a4: 9134e001     	add	x1, x0, #0xd38
  6a95a8: 52800040     	mov	w0, #0x2                // =2
  6a95ac: 940273e8     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  6a95b0: 52800000     	mov	w0, #0x0                // =0
  6a95b4: a8c27bfd     	ldp	x29, x30, [sp], #0x20
