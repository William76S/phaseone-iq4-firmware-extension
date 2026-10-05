  493598: d10983ff     	sub	sp, sp, #0x260
  49359c: a9007bfd     	stp	x29, x30, [sp]
  4935a0: 910003fd     	mov	x29, sp
  4935a4: f9000bf3     	str	x19, [sp, #0x10]
  4935a8: f9001fe0     	str	x0, [sp, #0x38]
  4935ac: f9001be1     	str	x1, [sp, #0x30]
  4935b0: b9002fe2     	str	w2, [sp, #0x2c]
  4935b4: b9002be3     	str	w3, [sp, #0x28]
  4935b8: 910883e3     	add	x3, sp, #0x220
  4935bc: 52800022     	mov	w2, #0x1                // =1
  4935c0: f0003740     	adrp	x0, 0xb7e000
  4935c4: 91262001     	add	x1, x0, #0x988
  4935c8: aa0303e0     	mov	x0, x3
  4935cc: 97fe6b19     	bl	0x42e230 <.text+0x23000>
  4935d0: f0003740     	adrp	x0, 0xb7e000
  4935d4: 91258000     	add	x0, x0, #0x960
  4935d8: f9012fe0     	str	x0, [sp, #0x258]
  4935dc: b9402be0     	ldr	w0, [sp, #0x28]
  4935e0: 7100101f     	cmp	w0, #0x4
  4935e4: 540000c0     	b.eq	0x4935fc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d650>
  4935e8: 7100401f     	cmp	w0, #0x10
  4935ec: 54000080     	b.eq	0x4935fc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d650>
  4935f0: 7100081f     	cmp	w0, #0x2
  4935f4: 54000120     	b.eq	0x493618 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d66c>
  4935f8: 1400000f     	b	0x493634 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d688>
  4935fc: f9401fe0     	ldr	x0, [sp, #0x38]
  493600: f943d000     	ldr	x0, [x0, #0x7a0]
  493604: f9010fe0     	str	x0, [sp, #0x218]
  493608: f9401fe0     	ldr	x0, [sp, #0x38]
  49360c: f943d800     	ldr	x0, [x0, #0x7b0]
  493610: f9012fe0     	str	x0, [sp, #0x258]
  493614: 14000012     	b	0x49365c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d6b0>
  493618: f9401fe0     	ldr	x0, [sp, #0x38]
  49361c: f943e800     	ldr	x0, [x0, #0x7d0]
  493620: f9010fe0     	str	x0, [sp, #0x218]
  493624: f9401fe0     	ldr	x0, [sp, #0x38]
  493628: f943f000     	ldr	x0, [x0, #0x7e0]
  49362c: f9012fe0     	str	x0, [sp, #0x258]
  493630: 1400000b     	b	0x49365c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d6b0>
  493634: b9402be0     	ldr	w0, [sp, #0x28]
  493638: 2a0003e4     	mov	w4, w0
  49363c: f0003740     	adrp	x0, 0xb7e000
  493640: 9124a003     	add	x3, x0, #0x928
  493644: 52804fa2     	mov	w2, #0x27d              // =637
  493648: f0003740     	adrp	x0, 0xb7e000
  49364c: 911e0001     	add	x1, x0, #0x780
  493650: 52800040     	mov	w0, #0x2                // =2
  493654: 940acbbe     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  493658: d503201f     	nop
  49365c: f9401fe0     	ldr	x0, [sp, #0x38]
  493660: 91070001     	add	x1, x0, #0x1c0
  493664: 910843e0     	add	x0, sp, #0x210
  493668: 97fdf956     	bl	0x411bc0 <.text+0x6990>
  49366c: f9410fe0     	ldr	x0, [sp, #0x218]
  493670: f100001f     	cmp	x0, #0x0
  493674: 54000141     	b.ne	0x49369c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d6f0>
  493678: 528050e3     	mov	w3, #0x287              // =647
  49367c: f0003740     	adrp	x0, 0xb7e000
  493680: 911e0002     	add	x2, x0, #0x780
  493684: f0003740     	adrp	x0, 0xb7e000
  493688: 9125a001     	add	x1, x0, #0x968
  49368c: f0003740     	adrp	x0, 0xb7e000
  493690: 911f2000     	add	x0, x0, #0x7c8
  493694: 97fddbbb     	bl	0x40a580 <printf@plt>
  493698: 940b641c     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  49369c: a91f7fff     	stp	xzr, xzr, [sp, #0x1f0]
  4936a0: f90103ff     	str	xzr, [sp, #0x200]
  4936a4: b9020bff     	str	wzr, [sp, #0x208]
  4936a8: 79041bff     	strh	wzr, [sp, #0x20c]
  4936ac: 9107c3e3     	add	x3, sp, #0x1f0
  4936b0: f9412fe2     	ldr	x2, [sp, #0x258]
  4936b4: f0003740     	adrp	x0, 0xb7e000
  4936b8: 9125e001     	add	x1, x0, #0x978
  4936bc: aa0303e0     	mov	x0, x3
  4936c0: 97fddc50     	bl	0x40a800 <sprintf@plt>
  4936c4: 9101a3e0     	add	x0, sp, #0x68
  4936c8: 97ffea2e     	bl	0x48df80 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57fd4>
  4936cc: b9024bff     	str	wzr, [sp, #0x248]
  4936d0: f9410fe4     	ldr	x4, [sp, #0x218]
  4936d4: f9410fe0     	ldr	x0, [sp, #0x218]
  4936d8: f9400000     	ldr	x0, [x0]
  4936dc: 9100c000     	add	x0, x0, #0x30
  4936e0: f9400003     	ldr	x3, [x0]
  4936e4: 9101a3e1     	add	x1, sp, #0x68
  4936e8: 9107c3e0     	add	x0, sp, #0x1f0
  4936ec: aa0103e2     	mov	x2, x1
  4936f0: aa0003e1     	mov	x1, x0
  4936f4: aa0403e0     	mov	x0, x4
  4936f8: d63f0060     	blr	x3
  4936fc: 12001c00     	and	w0, w0, #0xff
  493700: 52000000     	eor	w0, w0, #0x1
  493704: 39095fe0     	strb	w0, [sp, #0x257]
  493708: f9401fe0     	ldr	x0, [sp, #0x38]
  49370c: b941a801     	ldr	w1, [x0, #0x1a8]
  493710: b9424be0     	ldr	w0, [sp, #0x248]
  493714: 6b00003f     	cmp	w1, w0
  493718: 54000fc9     	b.ls	0x493910 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d964>
  49371c: 39495fe0     	ldrb	w0, [sp, #0x257]
  493720: 7100001f     	cmp	w0, #0x0
  493724: 54000f61     	b.ne	0x493910 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d964>
  493728: 3945c3e0     	ldrb	w0, [sp, #0x170]
  49372c: 52000000     	eor	w0, w0, #0x1
  493730: 12001c00     	and	w0, w0, #0xff
  493734: 7100001f     	cmp	w0, #0x0
  493738: 54000d20     	b.eq	0x4938dc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d930>
  49373c: b9416fe1     	ldr	w1, [sp, #0x16c]
  493740: b9402fe0     	ldr	w0, [sp, #0x2c]
  493744: 6b00003f     	cmp	w1, w0
  493748: 54000ca9     	b.ls	0x4938dc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d930>
  49374c: b90253ff     	str	wzr, [sp, #0x250]
  493750: b98253e0     	ldrsw	x0, [sp, #0x250]
  493754: 9101a3e1     	add	x1, sp, #0x68
  493758: 38606820     	ldrb	w0, [x1, x0]
  49375c: 7100b81f     	cmp	w0, #0x2e
  493760: 54000160     	b.eq	0x49378c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d7e0>
  493764: b98253e0     	ldrsw	x0, [sp, #0x250]
  493768: 9101a3e1     	add	x1, sp, #0x68
  49376c: 38606822     	ldrb	w2, [x1, x0]
  493770: b98253e0     	ldrsw	x0, [sp, #0x250]
  493774: 910123e1     	add	x1, sp, #0x48
  493778: 38206822     	strb	w2, [x1, x0]
  49377c: b94253e0     	ldr	w0, [sp, #0x250]
  493780: 11000400     	add	w0, w0, #0x1
  493784: b90253e0     	str	w0, [sp, #0x250]
  493788: 17fffff2     	b	0x493750 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d7a4>
  49378c: b94253e0     	ldr	w0, [sp, #0x250]
  493790: 11000401     	add	w1, w0, #0x1
  493794: b90253e1     	str	w1, [sp, #0x250]
  493798: 93407c00     	sxtw	x0, w0
  49379c: 910123e1     	add	x1, sp, #0x48
  4937a0: 528005c2     	mov	w2, #0x2e               // =46
  4937a4: 38206822     	strb	w2, [x1, x0]
  4937a8: b94253e0     	ldr	w0, [sp, #0x250]
  4937ac: 11000401     	add	w1, w0, #0x1
  4937b0: b90253e1     	str	w1, [sp, #0x250]
  4937b4: 93407c00     	sxtw	x0, w0
  4937b8: 910123e1     	add	x1, sp, #0x48
  4937bc: 52800922     	mov	w2, #0x49               // =73
  4937c0: 38206822     	strb	w2, [x1, x0]
  4937c4: b94253e0     	ldr	w0, [sp, #0x250]
  4937c8: 11000401     	add	w1, w0, #0x1
  4937cc: b90253e1     	str	w1, [sp, #0x250]
  4937d0: 93407c00     	sxtw	x0, w0
  4937d4: 910123e1     	add	x1, sp, #0x48
  4937d8: 52800922     	mov	w2, #0x49               // =73
  4937dc: 38206822     	strb	w2, [x1, x0]
  4937e0: b94253e0     	ldr	w0, [sp, #0x250]
  4937e4: 11000401     	add	w1, w0, #0x1
  4937e8: b90253e1     	str	w1, [sp, #0x250]
  4937ec: 93407c00     	sxtw	x0, w0
  4937f0: 910123e1     	add	x1, sp, #0x48
  4937f4: 52800a22     	mov	w2, #0x51               // =81
  4937f8: 38206822     	strb	w2, [x1, x0]
  4937fc: b94253e0     	ldr	w0, [sp, #0x250]
  493800: 11000401     	add	w1, w0, #0x1
  493804: b90253e1     	str	w1, [sp, #0x250]
  493808: 93407c00     	sxtw	x0, w0
  49380c: 910123e1     	add	x1, sp, #0x48
  493810: 3820683f     	strb	wzr, [x1, x0]
  493814: 9101a3e0     	add	x0, sp, #0x68
  493818: f9401be1     	ldr	x1, [sp, #0x30]
  49381c: 97fddb11     	bl	0x40a460 <strstr@plt>
  493820: f100001f     	cmp	x0, #0x0
  493824: 540005c0     	b.eq	0x4938dc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d930>
  493828: b9024fff     	str	wzr, [sp, #0x24c]
  49382c: f9401fe0     	ldr	x0, [sp, #0x38]
  493830: b941b800     	ldr	w0, [x0, #0x1b8]
  493834: b9424fe1     	ldr	w1, [sp, #0x24c]
  493838: 6b00003f     	cmp	w1, w0
  49383c: 5400050a     	b.ge	0x4938dc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d930>
  493840: f9401fe0     	ldr	x0, [sp, #0x38]
  493844: f940d800     	ldr	x0, [x0, #0x1b0]
  493848: b9824fe1     	ldrsw	x1, [sp, #0x24c]
  49384c: 97ffef29     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  493850: aa0003e2     	mov	x2, x0
  493854: 910123e0     	add	x0, sp, #0x48
  493858: aa0003e1     	mov	x1, x0
  49385c: aa0203e0     	mov	x0, x2
  493860: 97fddcb8     	bl	0x40ab40 <strcmp@plt>
  493864: 7100001f     	cmp	w0, #0x0
  493868: 1a9f17e0     	cset	w0, eq
  49386c: 12001c00     	and	w0, w0, #0xff
  493870: 7100001f     	cmp	w0, #0x0
  493874: 540002c0     	b.eq	0x4938cc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d920>
  493878: 9101a3e0     	add	x0, sp, #0x68
  49387c: aa0003e3     	mov	x3, x0
  493880: f0003740     	adrp	x0, 0xb7e000
  493884: 9126a002     	add	x2, x0, #0x9a8
  493888: 528056c1     	mov	w1, #0x2b6              // =694
  49388c: f0003740     	adrp	x0, 0xb7e000
  493890: 911e0000     	add	x0, x0, #0x780
  493894: 940acb02     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  493898: f9401fe0     	ldr	x0, [sp, #0x38]
  49389c: f940d800     	ldr	x0, [x0, #0x1b0]
  4938a0: b9824fe1     	ldrsw	x1, [sp, #0x24c]
  4938a4: 97ffef13     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  4938a8: 39403801     	ldrb	w1, [x0, #0xe]
  4938ac: 13001c22     	sxtb	w2, w1
  4938b0: b9402be1     	ldr	w1, [sp, #0x28]
  4938b4: 13001c21     	sxtb	w1, w1
  4938b8: 2a010041     	orr	w1, w2, w1
  4938bc: 13001c21     	sxtb	w1, w1
  4938c0: 12001c21     	and	w1, w1, #0xff
  4938c4: 39003801     	strb	w1, [x0, #0xe]
  4938c8: 14000005     	b	0x4938dc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d930>
  4938cc: b9424fe0     	ldr	w0, [sp, #0x24c]
  4938d0: 11000400     	add	w0, w0, #0x1
  4938d4: b9024fe0     	str	w0, [sp, #0x24c]
  4938d8: 17ffffd5     	b	0x49382c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d880>
  4938dc: f9410fe3     	ldr	x3, [sp, #0x218]
  4938e0: f9410fe0     	ldr	x0, [sp, #0x218]
  4938e4: f9400000     	ldr	x0, [x0]
  4938e8: 9100e000     	add	x0, x0, #0x38
  4938ec: f9400002     	ldr	x2, [x0]
  4938f0: 9101a3e0     	add	x0, sp, #0x68
  4938f4: aa0003e1     	mov	x1, x0
  4938f8: aa0303e0     	mov	x0, x3
  4938fc: d63f0040     	blr	x2
  493900: 12001c00     	and	w0, w0, #0xff
  493904: 52000000     	eor	w0, w0, #0x1
  493908: 39095fe0     	strb	w0, [sp, #0x257]
  49390c: 17ffff7f     	b	0x493708 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d75c>
  493910: f9410fe3     	ldr	x3, [sp, #0x218]
  493914: f9410fe0     	ldr	x0, [sp, #0x218]
  493918: f9400000     	ldr	x0, [x0]
  49391c: 91010000     	add	x0, x0, #0x40
  493920: f9400002     	ldr	x2, [x0]
  493924: 9101a3e0     	add	x0, sp, #0x68
  493928: aa0003e1     	mov	x1, x0
  49392c: aa0303e0     	mov	x0, x3
  493930: d63f0040     	blr	x2
  493934: 9101a3e0     	add	x0, sp, #0x68
  493938: 97ffee8d     	bl	0x48f36c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x593c0>
  49393c: 910843e0     	add	x0, sp, #0x210
  493940: 97fdf8ad     	bl	0x411bf4 <.text+0x69c4>
  493944: 910883e0     	add	x0, sp, #0x220
  493948: 97fe6a4c     	bl	0x42e278 <.text+0x23048>
  49394c: 1400000e     	b	0x493984 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d9d8>
  493950: aa0003f3     	mov	x19, x0
  493954: 9101a3e0     	add	x0, sp, #0x68
  493958: 97ffee85     	bl	0x48f36c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x593c0>
  49395c: 14000002     	b	0x493964 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d9b8>
  493960: aa0003f3     	mov	x19, x0
  493964: 910843e0     	add	x0, sp, #0x210
  493968: 97fdf8a3     	bl	0x411bf4 <.text+0x69c4>
  49396c: 14000002     	b	0x493974 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d9c8>
  493970: aa0003f3     	mov	x19, x0
  493974: 910883e0     	add	x0, sp, #0x220
  493978: 97fe6a40     	bl	0x42e278 <.text+0x23048>
  49397c: aa1303e0     	mov	x0, x19
  493980: 97fddb74     	bl	0x40a750 <_Unwind_Resume@plt>
  493984: f9400bf3     	ldr	x19, [sp, #0x10]
  493988: a9407bfd     	ldp	x29, x30, [sp]
  49398c: 910983ff     	add	sp, sp, #0x260
  493990: d65f03c0     	ret
