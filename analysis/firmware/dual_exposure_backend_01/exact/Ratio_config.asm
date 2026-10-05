
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000004f90b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv>:
  5c3454: f94027e1     	ldr	x1, [sp, #0x48]
  5c3458: d2826e00     	mov	x0, #0x1370             // =4976
  5c345c: 8b000033     	add	x19, x1, x0
  5c3460: f94023e1     	ldr	x1, [sp, #0x40]
  5c3464: d2821000     	mov	x0, #0x1080             // =4224
  5c3468: 8b000034     	add	x20, x1, x0
  5c346c: d2800100     	mov	x0, #0x8                // =8
  5c3470: 97f91a7c     	bl	0x409e60 <_Znwm@plt>
  5c3474: aa0003f5     	mov	x21, x0
  5c3478: aa1503e0     	mov	x0, x21
  5c347c: 9400014a     	bl	0x5c39a4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xca8f4>
  5c3480: aa1503e6     	mov	x6, x21
  5c3484: 52800005     	mov	w5, #0x0                // =0
  5c3488: 52800084     	mov	w4, #0x4                // =4
  5c348c: f0004c60     	adrp	x0, 0xf52000
  5c3490: 912dc003     	add	x3, x0, #0xb70
  5c3494: 52807482     	mov	w2, #0x3a4              // =932
  5c3498: aa1403e1     	mov	x1, x20
  5c349c: aa1303e0     	mov	x0, x19
  5c34a0: 940001bf     	bl	0x5c3b9c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xcaaec>
  5c34a4: f94027e1     	ldr	x1, [sp, #0x48]
  5c34a8: d2828d00     	mov	x0, #0x1468             // =5224
  5c34ac: 8b000034     	add	x20, x1, x0
  5c34b0: f94023e1     	ldr	x1, [sp, #0x40]
  5c34b4: d2822c00     	mov	x0, #0x1160             // =4448
  5c34b8: 8b000035     	add	x21, x1, x0
  5c34bc: 90003320     	adrp	x0, 0xc27000
  5c34c0: 91065000     	add	x0, x0, #0x194
  5c34c4: b9400016     	ldr	w22, [x0]
  5c34c8: d2800100     	mov	x0, #0x8                // =8
  5c34cc: 97f91a65     	bl	0x409e60 <_Znwm@plt>
  5c34d0: aa0003f3     	mov	x19, x0
  5c34d4: f900027f     	str	xzr, [x19]
  5c34d8: aa1303e0     	mov	x0, x19
  5c34dc: 94000105     	bl	0x5c38f0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xca840>
  5c34e0: aa1303e6     	mov	x6, x19
  5c34e4: 52800005     	mov	w5, #0x0                // =0
  5c34e8: 2a1603e4     	mov	w4, w22
  5c34ec: f0003300     	adrp	x0, 0xc26000
  5c34f0: 91136003     	add	x3, x0, #0x4d8
  5c34f4: 52800182     	mov	w2, #0xc                // =12
  5c34f8: aa1503e1     	mov	x1, x21
  5c34fc: aa1403e0     	mov	x0, x20
  5c3500: 9405654e     	bl	0x71ca38 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2d0c>
