
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

000000000040b230 <.text>:
  41e550: f9037bf3     	str	x19, [sp, #0x6f0]
  41e554: 1400004d     	b	0x41e688 <.text+0x13458>
  41e558: f0002ea0     	adrp	x0, 0x9f5000
  41e55c: 910b6002     	add	x2, x0, #0x2d8
  41e560: 52813221     	mov	w1, #0x991              // =2449
  41e564: b0002ea0     	adrp	x0, 0x9f3000
  41e568: 91390000     	add	x0, x0, #0xe40
  41e56c: 940c9fcc     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  41e570: d2803500     	mov	x0, #0x1a8              // =424
  41e574: 97ffae3b     	bl	0x409e60 <_Znwm@plt>
  41e578: aa0003f3     	mov	x19, x0
  41e57c: f94f47e0     	ldr	x0, [sp, #0x1e88]
  41e580: 91002001     	add	x1, x0, #0x8
  41e584: f94bfbe0     	ldr	x0, [sp, #0x17f0]
  41e588: f9400002     	ldr	x2, [x0]
  41e58c: f94bfbe0     	ldr	x0, [sp, #0x17f0]
  41e590: f9400c00     	ldr	x0, [x0, #0x18]
  41e594: f94ea7e5     	ldr	x5, [sp, #0x1d48]
  41e598: aa0003e4     	mov	x4, x0
  41e59c: f94eabe3     	ldr	x3, [sp, #0x1d50]
  41e5a0: aa1303e0     	mov	x0, x19
  41e5a4: 940fe2bc     	bl	0x817094 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x5b0cc>
  41e5a8: f9037bf3     	str	x19, [sp, #0x6f0]
  41e5ac: 14000037     	b	0x41e688 <.text+0x13458>
  41e5b0: f0002ea0     	adrp	x0, 0x9f5000
  41e5b4: 910bc002     	add	x2, x0, #0x2f0
  41e5b8: 528132c1     	mov	w1, #0x996              // =2454
  41e5bc: b0002ea0     	adrp	x0, 0x9f3000
  41e5c0: 91390000     	add	x0, x0, #0xe40
  41e5c4: 940c9fb6     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  41e5c8: d2803500     	mov	x0, #0x1a8              // =424
  41e5cc: 97ffae25     	bl	0x409e60 <_Znwm@plt>
  41e5d0: aa0003f3     	mov	x19, x0
  41e5d4: f94f47e0     	ldr	x0, [sp, #0x1e88]
  41e5d8: 91002001     	add	x1, x0, #0x8
  41e5dc: f94bfbe0     	ldr	x0, [sp, #0x17f0]
  41e5e0: f9400002     	ldr	x2, [x0]
  41e5e4: f94bfbe0     	ldr	x0, [sp, #0x17f0]
  41e5e8: f9400c00     	ldr	x0, [x0, #0x18]
  41e5ec: f94ea7e5     	ldr	x5, [sp, #0x1d48]
  41e5f0: aa0003e4     	mov	x4, x0
  41e5f4: f94eabe3     	ldr	x3, [sp, #0x1d50]
  41e5f8: aa1303e0     	mov	x0, x19
  41e5fc: 940ffcb2     	bl	0x81d8c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x618fc>
  41e600: f9037bf3     	str	x19, [sp, #0x6f0]
  41e604: 14000021     	b	0x41e688 <.text+0x13458>
  41e608: f94eabe0     	ldr	x0, [sp, #0x1d50]
  41e60c: b9403400     	ldr	w0, [x0, #0x34]
