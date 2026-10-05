  826d6c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  826d70: 910003fd     	mov	x29, sp
  826d74: f90017e0     	str	x0, [sp, #0x28]
  826d78: f90013e1     	str	x1, [sp, #0x20]
  826d7c: b9001fe2     	str	w2, [sp, #0x1c]
  826d80: f9000be3     	str	x3, [sp, #0x10]
  826d84: f9400be0     	ldr	x0, [sp, #0x10]
  826d88: f9400000     	ldr	x0, [x0]
  826d8c: 9100e000     	add	x0, x0, #0x38
  826d90: f9400001     	ldr	x1, [x0]
  826d94: f9400be0     	ldr	x0, [sp, #0x10]
  826d98: d63f0020     	blr	x1
  826d9c: 12001c00     	and	w0, w0, #0xff
  826da0: 7100001f     	cmp	w0, #0x0
  826da4: 540002a0     	b.eq	0x826df8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6ae30>
  826da8: f9400be0     	ldr	x0, [sp, #0x10]
  826dac: 97f110ec     	bl	0x46b15c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x351b0>
  826db0: 2a0003e3     	mov	w3, w0
  826db4: b9401fe0     	ldr	w0, [sp, #0x1c]
  826db8: aa0003e2     	mov	x2, x0
  826dbc: f94013e1     	ldr	x1, [sp, #0x20]
  826dc0: 2a0303e0     	mov	w0, w3
  826dc4: 97ef8de7     	bl	0x40a560 <read@plt>
  826dc8: b9003fe0     	str	w0, [sp, #0x3c]
  826dcc: b9403fe0     	ldr	w0, [sp, #0x3c]
  826dd0: 7100001f     	cmp	w0, #0x0
  826dd4: 5400006b     	b.lt	0x826de0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6ae18>
  826dd8: b9403fe0     	ldr	w0, [sp, #0x3c]
  826ddc: 14000008     	b	0x826dfc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6ae34>
  826de0: 97ef8dc0     	bl	0x40a4e0 <__errno_location@plt>
  826de4: b9400000     	ldr	w0, [x0]
  826de8: 2a0003e1     	mov	w1, w0
  826dec: d0002b40     	adrp	x0, 0xd90000
  826df0: 91388000     	add	x0, x0, #0xe20
  826df4: 97ef8de3     	bl	0x40a580 <printf@plt>
  826df8: 52800000     	mov	w0, #0x0                // =0
  826dfc: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  826e00: d65f03c0     	ret
  826e04: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  826e08: 910003fd     	mov	x29, sp
  826e0c: f90017e0     	str	x0, [sp, #0x28]
  826e10: f90013e1     	str	x1, [sp, #0x20]
  826e14: b9001fe2     	str	w2, [sp, #0x1c]
  826e18: f9000be3     	str	x3, [sp, #0x10]
  826e1c: f9400be0     	ldr	x0, [sp, #0x10]
  826e20: f9400000     	ldr	x0, [x0]
  826e24: 9100e000     	add	x0, x0, #0x38
  826e28: f9400001     	ldr	x1, [x0]
  826e2c: f9400be0     	ldr	x0, [sp, #0x10]
  826e30: d63f0020     	blr	x1
  826e34: 12001c00     	and	w0, w0, #0xff
  826e38: 7100001f     	cmp	w0, #0x0
  826e3c: 540002e0     	b.eq	0x826e98 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6aed0>
  826e40: f9400be0     	ldr	x0, [sp, #0x10]
  826e44: 97f110c6     	bl	0x46b15c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x351b0>
  826e48: 2a0003e3     	mov	w3, w0
  826e4c: b9401fe0     	ldr	w0, [sp, #0x1c]
  826e50: aa0003e2     	mov	x2, x0
  826e54: f94013e1     	ldr	x1, [sp, #0x20]
  826e58: 2a0303e0     	mov	w0, w3
  826e5c: 97ef8eb5     	bl	0x40a930 <write@plt>
  826e60: b9003fe0     	str	w0, [sp, #0x3c]
  826e64: b9403fe0     	ldr	w0, [sp, #0x3c]
  826e68: 7100001f     	cmp	w0, #0x0
  826e6c: 540000ab     	b.lt	0x826e80 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6aeb8>
  826e70: f94017e0     	ldr	x0, [sp, #0x28]
  826e74: 940003d4     	bl	0x827dc4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6bdfc>
  826e78: b9403fe0     	ldr	w0, [sp, #0x3c]
  826e7c: 14000008     	b	0x826e9c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6aed4>
  826e80: 97ef8d98     	bl	0x40a4e0 <__errno_location@plt>
  826e84: b9400000     	ldr	w0, [x0]
  826e88: 2a0003e1     	mov	w1, w0
  826e8c: d0002b40     	adrp	x0, 0xd90000
  826e90: 9138e000     	add	x0, x0, #0xe38
  826e94: 97ef8dbb     	bl	0x40a580 <printf@plt>
  826e98: 52800000     	mov	w0, #0x0                // =0
  826e9c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  826ea0: d65f03c0     	ret
