  4f0ac0: d2802300     	mov	x0, #0x118              // =280
  4f0ac4: 97fc64e7     	bl	0x409e60 <_Znwm@plt>
  4f0ac8: aa0003f3     	mov	x19, x0
  4f0acc: d2800003     	mov	x3, #0x0                // =0
  4f0ad0: d2800002     	mov	x2, #0x0                // =0
  4f0ad4: 528030e1     	mov	w1, #0x187              // =391
  4f0ad8: aa1303e0     	mov	x0, x19
  4f0adc: 97ffd31a     	bl	0x4e5744 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaf798>
  4f0ae0: f900bff3     	str	x19, [sp, #0x178]
  4f0ae4: f940bfe0     	ldr	x0, [sp, #0x178]
  4f0ae8: aa0003e1     	mov	x1, x0
  4f0aec: f94023e0     	ldr	x0, [sp, #0x40]
  4f0af0: 97ffd372     	bl	0x4e58b8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaf90c>
  4f0af4: d2802100     	mov	x0, #0x108              // =264
  4f0af8: 97fc64da     	bl	0x409e60 <_Znwm@plt>
  4f0afc: aa0003f3     	mov	x19, x0
  4f0b00: f94027e0     	ldr	x0, [sp, #0x48]
  4f0b04: f9448c00     	ldr	x0, [x0, #0x918]
  4f0b08: d2800005     	mov	x5, #0x0                // =0
  4f0b0c: d2800004     	mov	x4, #0x0                // =0
  4f0b10: 52800003     	mov	w3, #0x0                // =0
  4f0b14: aa0003e2     	mov	x2, x0
  4f0b18: 52805fa1     	mov	w1, #0x2fd              // =765
  4f0b1c: aa1303e0     	mov	x0, x19
  4f0b20: 97ffde38     	bl	0x4e8400 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb2454>
  4f0b24: aa1303e0     	mov	x0, x19
  4f0b28: aa0003e1     	mov	x1, x0
  4f0b2c: f940bfe0     	ldr	x0, [sp, #0x178]
  4f0b30: 97ffd362     	bl	0x4e58b8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaf90c>
  4f0b34: f94027e0     	ldr	x0, [sp, #0x48]
  4f0b38: f944dc00     	ldr	x0, [x0, #0x9b8]
  4f0b3c: f9400800     	ldr	x0, [x0, #0x10]
  4f0b40: 97fd7468     	bl	0x44dce0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x17d34>
  4f0b44: 12001c00     	and	w0, w0, #0xff
  4f0b48: 52000000     	eor	w0, w0, #0x1
  4f0b4c: 12001c00     	and	w0, w0, #0xff
  4f0b50: 7100001f     	cmp	w0, #0x0
  4f0b54: 540001e0     	b.eq	0x4f0b90 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xbabe4>
  4f0b58: d2800900     	mov	x0, #0x48               // =72
  4f0b5c: 97fc64c1     	bl	0x409e60 <_Znwm@plt>
  4f0b60: aa0003f3     	mov	x19, x0
  4f0b64: f94027e0     	ldr	x0, [sp, #0x48]
  4f0b68: f944dc00     	ldr	x0, [x0, #0x9b8]
  4f0b6c: f9407c00     	ldr	x0, [x0, #0xf8]
  4f0b70: 91002000     	add	x0, x0, #0x8
  4f0b74: aa0003e1     	mov	x1, x0
  4f0b78: aa1303e0     	mov	x0, x19
  4f0b7c: 97ffd679     	bl	0x4e6560 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb05b4>
  4f0b80: aa1303e0     	mov	x0, x19
  4f0b84: aa0003e1     	mov	x1, x0
  4f0b88: f940bfe0     	ldr	x0, [sp, #0x178]
  4f0b8c: 97ffd34b     	bl	0x4e58b8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaf90c>
  4f0b90: f94027e0     	ldr	x0, [sp, #0x48]
  4f0b94: f944dc00     	ldr	x0, [x0, #0x9b8]
  4f0b98: f9400800     	ldr	x0, [x0, #0x10]
  4f0b9c: 97fcf5f7     	bl	0x42e378 <.text+0x23148>
  4f0ba0: 12001c00     	and	w0, w0, #0xff
  4f0ba4: 7100001f     	cmp	w0, #0x0
  4f0ba8: 540001e0     	b.eq	0x4f0be4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xbac38>
  4f0bac: d2800900     	mov	x0, #0x48               // =72
  4f0bb0: 97fc64ac     	bl	0x409e60 <_Znwm@plt>
  4f0bb4: aa0003f3     	mov	x19, x0
  4f0bb8: f94027e0     	ldr	x0, [sp, #0x48]
  4f0bbc: f944dc00     	ldr	x0, [x0, #0x9b8]
  4f0bc0: f9401400     	ldr	x0, [x0, #0x28]
  4f0bc4: 912fa000     	add	x0, x0, #0xbe8
  4f0bc8: aa0003e1     	mov	x1, x0
  4f0bcc: aa1303e0     	mov	x0, x19
  4f0bd0: 97ffd664     	bl	0x4e6560 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb05b4>
  4f0bd4: aa1303e0     	mov	x0, x19
  4f0bd8: aa0003e1     	mov	x1, x0
  4f0bdc: f940bfe0     	ldr	x0, [sp, #0x178]
  4f0be0: 97ffd336     	bl	0x4e58b8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaf90c>
  4f0be4: d2800900     	mov	x0, #0x48               // =72
  4f0be8: 97fc649e     	bl	0x409e60 <_Znwm@plt>
  4f0bec: aa0003f3     	mov	x19, x0
  4f0bf0: f94027e0     	ldr	x0, [sp, #0x48]
  4f0bf4: f944dc00     	ldr	x0, [x0, #0x9b8]
  4f0bf8: f9401400     	ldr	x0, [x0, #0x28]
  4f0bfc: 911a2000     	add	x0, x0, #0x688
  4f0c00: aa0003e1     	mov	x1, x0
  4f0c04: aa1303e0     	mov	x0, x19
  4f0c08: 97ffd656     	bl	0x4e6560 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb05b4>
  4f0c0c: aa1303e0     	mov	x0, x19
  4f0c10: aa0003e1     	mov	x1, x0
  4f0c14: f940bfe0     	ldr	x0, [sp, #0x178]
  4f0c18: 97ffd328     	bl	0x4e58b8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaf90c>
  4f0c1c: d2803000     	mov	x0, #0x180              // =384
  4f0c20: 97fc6490     	bl	0x409e60 <_Znwm@plt>
  4f0c24: aa0003f3     	mov	x19, x0
  4f0c28: f94027e0     	ldr	x0, [sp, #0x48]
  4f0c2c: f940e401     	ldr	x1, [x0, #0x1c8]
  4f0c30: f94027e0     	ldr	x0, [sp, #0x48]
  4f0c34: f941b802     	ldr	x2, [x0, #0x370]
  4f0c38: f94027e0     	ldr	x0, [sp, #0x48]
  4f0c3c: b9437800     	ldr	w0, [x0, #0x378]
  4f0c40: 2a0003e5     	mov	w5, w0
  4f0c44: aa0203e4     	mov	x4, x2
  4f0c48: 52801803     	mov	w3, #0xc0               // =192
  4f0c4c: aa0103e2     	mov	x2, x1
  4f0c50: b0003500     	adrp	x0, 0xb91000
  4f0c54: 9129e001     	add	x1, x0, #0xa78
  4f0c58: aa1303e0     	mov	x0, x19
  4f0c5c: 9401251a     	bl	0x53a0c4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x41014>
  4f0c60: f900bbf3     	str	x19, [sp, #0x170]
  4f0c64: f94027e0     	ldr	x0, [sp, #0x48]
  4f0c68: f941c001     	ldr	x1, [x0, #0x380]
  4f0c6c: f94027e0     	ldr	x0, [sp, #0x48]
  4f0c70: b9438800     	ldr	w0, [x0, #0x388]
  4f0c74: 2a0003e3     	mov	w3, w0
  4f0c78: aa0103e2     	mov	x2, x1
  4f0c7c: 52800021     	mov	w1, #0x1                // =1
  4f0c80: f940bbe0     	ldr	x0, [sp, #0x170]
  4f0c84: 94012727     	bl	0x53a920 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x41870>
  4f0c88: f94027e0     	ldr	x0, [sp, #0x48]
  4f0c8c: f941c801     	ldr	x1, [x0, #0x390]
  4f0c90: f94027e0     	ldr	x0, [sp, #0x48]
  4f0c94: b9439800     	ldr	w0, [x0, #0x398]
  4f0c98: 2a0003e3     	mov	w3, w0
  4f0c9c: aa0103e2     	mov	x2, x1
  4f0ca0: 52800041     	mov	w1, #0x2                // =2
  4f0ca4: f940bbe0     	ldr	x0, [sp, #0x170]
  4f0ca8: 9401271e     	bl	0x53a920 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x41870>
  4f0cac: f94027e0     	ldr	x0, [sp, #0x48]
  4f0cb0: f941d801     	ldr	x1, [x0, #0x3b0]
  4f0cb4: f94027e0     	ldr	x0, [sp, #0x48]
  4f0cb8: b943b800     	ldr	w0, [x0, #0x3b8]
  4f0cbc: 2a0003e3     	mov	w3, w0
  4f0cc0: aa0103e2     	mov	x2, x1
  4f0cc4: 52800061     	mov	w1, #0x3                // =3
  4f0cc8: f940bbe0     	ldr	x0, [sp, #0x170]
  4f0ccc: 94012715     	bl	0x53a920 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x41870>
  4f0cd0: d2800300     	mov	x0, #0x18               // =24
  4f0cd4: 97fc6463     	bl	0x409e60 <_Znwm@plt>
  4f0cd8: aa0003f3     	mov	x19, x0
  4f0cdc: 5284e1e1     	mov	w1, #0x270f             // =9999
  4f0ce0: aa1303e0     	mov	x0, x19
  4f0ce4: 9400184e     	bl	0x4f6e1c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xc0e70>
  4f0ce8: aa1303f4     	mov	x20, x19
  4f0cec: d2804600     	mov	x0, #0x230              // =560
  4f0cf0: 97fc645c     	bl	0x409e60 <_Znwm@plt>
  4f0cf4: aa0003f3     	mov	x19, x0
  4f0cf8: f94027e0     	ldr	x0, [sp, #0x48]
  4f0cfc: f944dc00     	ldr	x0, [x0, #0x9b8]
  4f0d00: f9401401     	ldr	x1, [x0, #0x28]
  4f0d04: d2825700     	mov	x0, #0x12b8             // =4792
  4f0d08: 8b000020     	add	x0, x1, x0
  4f0d0c: d2800005     	mov	x5, #0x0                // =0
  4f0d10: aa1403e4     	mov	x4, x20
  4f0d14: 52800023     	mov	w3, #0x1                // =1
  4f0d18: f940bbe2     	ldr	x2, [sp, #0x170]
  4f0d1c: aa0003e1     	mov	x1, x0
  4f0d20: aa1303e0     	mov	x0, x19
  4f0d24: 97ffed8d     	bl	0x4ec358 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb63ac>
  4f0d28: aa1303e0     	mov	x0, x19
  4f0d2c: aa0003e1     	mov	x1, x0
  4f0d30: f940bfe0     	ldr	x0, [sp, #0x178]
  4f0d34: 97ffd2e1     	bl	0x4e58b8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaf90c>
