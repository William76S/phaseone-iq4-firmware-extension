
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

000000000040b230 <.text>:
  41e844: f9400011     	ldr	x17, [x0]
  41e848: f9437bf2     	ldr	x18, [sp, #0x6f0]
  41e84c: f943bbf3     	ldr	x19, [sp, #0x770]
  41e850: f94bfbe0     	ldr	x0, [sp, #0x17f0]
  41e854: f9400c00     	ldr	x0, [x0, #0x18]
  41e858: aa0003f5     	mov	x21, x0
  41e85c: f943afe7     	ldr	x7, [sp, #0x758]
  41e860: f94e53e0     	ldr	x0, [sp, #0x1ca0]
  41e864: f9400408     	ldr	x8, [x0, #0x8]
  41e868: f94c07e0     	ldr	x0, [sp, #0x1808]
  41e86c: 9108a009     	add	x9, x0, #0x228
  41e870: f943afe1     	ldr	x1, [sp, #0x758]
  41e874: d2833800     	mov	x0, #0x19c0             // =6592
  41e878: 8b00002a     	add	x10, x1, x0
  41e87c: f94e4be0     	ldr	x0, [sp, #0x1c90]
  41e880: 9100200b     	add	x11, x0, #0x8
  41e884: f94e4be0     	ldr	x0, [sp, #0x1c90]
  41e888: 9103800c     	add	x12, x0, #0xe0
  41e88c: f94e4be0     	ldr	x0, [sp, #0x1c90]
  41e890: 9126000d     	add	x13, x0, #0x980
  41e894: f94e4be0     	ldr	x0, [sp, #0x1c90]
  41e898: 9129600e     	add	x14, x0, #0xa58
  41e89c: f94e4be0     	ldr	x0, [sp, #0x1c90]
  41e8a0: 912ce00f     	add	x15, x0, #0xb38
  41e8a4: f94f93f0     	ldr	x16, [sp, #0x1f20]
  41e8a8: f943afe1     	ldr	x1, [sp, #0x758]
  41e8ac: d283c800     	mov	x0, #0x1e40             // =7744
  41e8b0: 8b000026     	add	x6, x1, x0
  41e8b4: f94e4be0     	ldr	x0, [sp, #0x1c90]
  41e8b8: 910de005     	add	x5, x0, #0x378
  41e8bc: f94e4be0     	ldr	x0, [sp, #0x1c90]
  41e8c0: 91114004     	add	x4, x0, #0x450
  41e8c4: f94e4be0     	ldr	x0, [sp, #0x1c90]
  41e8c8: 9114c003     	add	x3, x0, #0x530
  41e8cc: f943afe1     	ldr	x1, [sp, #0x758]
  41e8d0: d2828d00     	mov	x0, #0x1468             // =5224
  41e8d4: 8b000022     	add	x2, x1, x0
  41e8d8: f94f83e0     	ldr	x0, [sp, #0x1f00]
  41e8dc: 91098001     	add	x1, x0, #0x260
  41e8e0: f94ec3e0     	ldr	x0, [sp, #0x1d80]
  41e8e4: 912e6000     	add	x0, x0, #0xb98
  41e8e8: f90073e0     	str	x0, [sp, #0xe0]
  41e8ec: f94c23e0     	ldr	x0, [sp, #0x1840]
  41e8f0: f9006fe0     	str	x0, [sp, #0xd8]
  41e8f4: f9006be1     	str	x1, [sp, #0xd0]
  41e8f8: f94a7fe0     	ldr	x0, [sp, #0x14f8]
  41e8fc: f90067e0     	str	x0, [sp, #0xc8]
  41e900: f90063e2     	str	x2, [sp, #0xc0]
  41e904: f94a6fe0     	ldr	x0, [sp, #0x14d8]
  41e908: f9005fe0     	str	x0, [sp, #0xb8]
  41e90c: f9005be3     	str	x3, [sp, #0xb0]
  41e910: f90057e4     	str	x4, [sp, #0xa8]
  41e914: f90053e5     	str	x5, [sp, #0xa0]
  41e918: f9004fe6     	str	x6, [sp, #0x98]
  41e91c: f9004bf0     	str	x16, [sp, #0x90]
  41e920: f94a63e0     	ldr	x0, [sp, #0x14c0]
  41e924: f90047e0     	str	x0, [sp, #0x88]
  41e928: f94a67e0     	ldr	x0, [sp, #0x14c8]
  41e92c: f90043e0     	str	x0, [sp, #0x80]
  41e930: f94a6be0     	ldr	x0, [sp, #0x14d0]
  41e934: f9003fe0     	str	x0, [sp, #0x78]
  41e938: f9003bef     	str	x15, [sp, #0x70]
  41e93c: f90037ee     	str	x14, [sp, #0x68]
  41e940: f90033ed     	str	x13, [sp, #0x60]
  41e944: f9002fec     	str	x12, [sp, #0x58]
  41e948: f9002beb     	str	x11, [sp, #0x50]
  41e94c: f94a73e0     	ldr	x0, [sp, #0x14e0]
  41e950: f90027e0     	str	x0, [sp, #0x48]
  41e954: f94a8fe0     	ldr	x0, [sp, #0x1518]
  41e958: f90023e0     	str	x0, [sp, #0x40]
  41e95c: f94a93e0     	ldr	x0, [sp, #0x1520]
  41e960: f9001fe0     	str	x0, [sp, #0x38]
  41e964: f9001bea     	str	x10, [sp, #0x30]
  41e968: f90017e9     	str	x9, [sp, #0x28]
  41e96c: f90013e8     	str	x8, [sp, #0x20]
  41e970: f94e43e0     	ldr	x0, [sp, #0x1c80]
  41e974: f9000fe0     	str	x0, [sp, #0x18]
  41e978: f94e4fe0     	ldr	x0, [sp, #0x1c98]
  41e97c: f9000be0     	str	x0, [sp, #0x10]
  41e980: f90007e7     	str	x7, [sp, #0x8]
  41e984: f94e5fe0     	ldr	x0, [sp, #0x1cb8]
  41e988: f90003e0     	str	x0, [sp]
  41e98c: aa1503e7     	mov	x7, x21
  41e990: f94a7be6     	ldr	x6, [sp, #0x14f0]
  41e994: f94eabe5     	ldr	x5, [sp, #0x1d50]
  41e998: aa1303e4     	mov	x4, x19
  41e99c: aa1203e3     	mov	x3, x18
  41e9a0: aa1103e2     	mov	x2, x17
  41e9a4: f94ab7e1     	ldr	x1, [sp, #0x1568]
  41e9a8: aa1403e0     	mov	x0, x20
  41e9ac: 940de7cd     	bl	0x7988e0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7ebb4>
  41e9b0: f9030ff4     	str	x20, [sp, #0x618]
