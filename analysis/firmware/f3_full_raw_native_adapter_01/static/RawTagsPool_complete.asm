  7baadc: a9b57bfd     	stp	x29, x30, [sp, #-0xb0]!
  7baae0: 910003fd     	mov	x29, sp
  7baae4: f90017e0     	str	x0, [sp, #0x28]
  7baae8: f90013e1     	str	x1, [sp, #0x20]
  7baaec: f9000fe2     	str	x2, [sp, #0x18]
  7baaf0: f9000be3     	str	x3, [sp, #0x10]
  7baaf4: 52802060     	mov	w0, #0x103              // =259
  7baaf8: b9003be0     	str	w0, [sp, #0x38]
  7baafc: 9100e3e0     	add	x0, sp, #0x38
  7bab00: aa0003e1     	mov	x1, x0
  7bab04: f94013e0     	ldr	x0, [sp, #0x20]
  7bab08: 94000857     	bl	0x7bcc64
  7bab0c: aa0003e2     	mov	x2, x0
  7bab10: f9400be0     	ldr	x0, [sp, #0x10]
  7bab14: b9445800     	ldr	w0, [x0, #0x458]
  7bab18: 2a0003e1     	mov	w1, w0
  7bab1c: aa0203e0     	mov	x0, x2
  7bab20: 94000370     	bl	0x7bb8e0
  7bab24: 528020a0     	mov	w0, #0x105              // =261
  7bab28: b9003fe0     	str	w0, [sp, #0x3c]
  7bab2c: 9100f3e0     	add	x0, sp, #0x3c
  7bab30: aa0003e1     	mov	x1, x0
  7bab34: f94013e0     	ldr	x0, [sp, #0x20]
  7bab38: 9400084b     	bl	0x7bcc64
  7bab3c: aa0003e2     	mov	x2, x0
  7bab40: f9400be0     	ldr	x0, [sp, #0x10]
  7bab44: b940c000     	ldr	w0, [x0, #0xc0]
  7bab48: 2a0003e1     	mov	w1, w0
  7bab4c: aa0203e0     	mov	x0, x2
  7bab50: 94000364     	bl	0x7bb8e0
  7bab54: 52808020     	mov	w0, #0x401              // =1025
  7bab58: b90043e0     	str	w0, [sp, #0x40]
  7bab5c: 910103e0     	add	x0, sp, #0x40
  7bab60: aa0003e1     	mov	x1, x0
  7bab64: f94013e0     	ldr	x0, [sp, #0x20]
  7bab68: 9400083f     	bl	0x7bcc64
  7bab6c: aa0003e1     	mov	x1, x0
  7bab70: f9400be0     	ldr	x0, [sp, #0x10]
  7bab74: bd40e800     	ldr	s0, [x0, #0xe8]
  7bab78: aa0103e0     	mov	x0, x1
  7bab7c: 94000365     	bl	0x7bb910
  7bab80: 52804160     	mov	w0, #0x20b              // =523
  7bab84: b90047e0     	str	w0, [sp, #0x44]
  7bab88: 910113e0     	add	x0, sp, #0x44
  7bab8c: aa0003e1     	mov	x1, x0
  7bab90: f94013e0     	ldr	x0, [sp, #0x20]
  7bab94: 94000834     	bl	0x7bcc64
  7bab98: aa0003e2     	mov	x2, x0
  7bab9c: f9400be0     	ldr	x0, [sp, #0x10]
  7baba0: b9425400     	ldr	w0, [x0, #0x254]
  7baba4: 2a0003e1     	mov	w1, w0
  7baba8: aa0203e0     	mov	x0, x2
  7babac: 9400034d     	bl	0x7bb8e0
  7babb0: 52804180     	mov	w0, #0x20c              // =524
  7babb4: b9004be0     	str	w0, [sp, #0x48]
  7babb8: 910123e0     	add	x0, sp, #0x48
  7babbc: aa0003e1     	mov	x1, x0
  7babc0: f94013e0     	ldr	x0, [sp, #0x20]
  7babc4: 94000828     	bl	0x7bcc64
  7babc8: aa0003e2     	mov	x2, x0
  7babcc: f9400be0     	ldr	x0, [sp, #0x10]
  7babd0: b9425800     	ldr	w0, [x0, #0x258]
  7babd4: 2a0003e1     	mov	w1, w0
  7babd8: aa0203e0     	mov	x0, x2
  7babdc: 94000341     	bl	0x7bb8e0
  7babe0: 528048a0     	mov	w0, #0x245              // =581
  7babe4: b9004fe0     	str	w0, [sp, #0x4c]
  7babe8: 910133e0     	add	x0, sp, #0x4c
  7babec: aa0003e1     	mov	x1, x0
  7babf0: f94013e0     	ldr	x0, [sp, #0x20]
  7babf4: 9400081c     	bl	0x7bcc64
  7babf8: aa0003e1     	mov	x1, x0
  7babfc: f9400be0     	ldr	x0, [sp, #0x10]
  7bac00: bd425c00     	ldr	s0, [x0, #0x25c]
  7bac04: aa0103e0     	mov	x0, x1
  7bac08: 94000342     	bl	0x7bb910
  7bac0c: 528043c0     	mov	w0, #0x21e              // =542
  7bac10: b90053e0     	str	w0, [sp, #0x50]
  7bac14: 910143e0     	add	x0, sp, #0x50
  7bac18: aa0003e1     	mov	x1, x0
  7bac1c: f94013e0     	ldr	x0, [sp, #0x20]
  7bac20: 94000811     	bl	0x7bcc64
  7bac24: aa0003e2     	mov	x2, x0
  7bac28: f9400be0     	ldr	x0, [sp, #0x10]
  7bac2c: b9426000     	ldr	w0, [x0, #0x260]
  7bac30: 2a0003e1     	mov	w1, w0
  7bac34: aa0203e0     	mov	x0, x2
  7bac38: 9400032a     	bl	0x7bb8e0
  7bac3c: f9400be0     	ldr	x0, [sp, #0x10]
  7bac40: b9426801     	ldr	w1, [x0, #0x268]
  7bac44: f94017e2     	ldr	x2, [sp, #0x28]
  7bac48: d2880000     	mov	x0, #0x4000             // =16384
  7bac4c: f2acaa80     	movk	x0, #0x6554, lsl #16
  7bac50: 8b000040     	add	x0, x2, x0
  7bac54: b939a001     	str	w1, [x0, #0x39a0]
  7bac58: f9400be0     	ldr	x0, [sp, #0x10]
  7bac5c: b9426c01     	ldr	w1, [x0, #0x26c]
  7bac60: f94017e2     	ldr	x2, [sp, #0x28]
  7bac64: d2880000     	mov	x0, #0x4000             // =16384
  7bac68: f2acaa80     	movk	x0, #0x6554, lsl #16
  7bac6c: 8b000040     	add	x0, x2, x0
  7bac70: b939a401     	str	w1, [x0, #0x39a4]
  7bac74: f9400be0     	ldr	x0, [sp, #0x10]
  7bac78: b9427001     	ldr	w1, [x0, #0x270]
  7bac7c: f94017e2     	ldr	x2, [sp, #0x28]
  7bac80: d2880000     	mov	x0, #0x4000             // =16384
  7bac84: f2acaa80     	movk	x0, #0x6554, lsl #16
  7bac88: 8b000040     	add	x0, x2, x0
  7bac8c: b939a801     	str	w1, [x0, #0x39a8]
  7bac90: 528020e0     	mov	w0, #0x107              // =263
  7bac94: b90057e0     	str	w0, [sp, #0x54]
  7bac98: 910153e0     	add	x0, sp, #0x54
  7bac9c: aa0003e1     	mov	x1, x0
  7baca0: f94013e0     	ldr	x0, [sp, #0x20]
  7baca4: 940007f0     	bl	0x7bcc64
  7baca8: aa0003e3     	mov	x3, x0
  7bacac: f94017e1     	ldr	x1, [sp, #0x28]
  7bacb0: d28f3400     	mov	x0, #0x79a0             // =31136
  7bacb4: f2acaa80     	movk	x0, #0x6554, lsl #16
  7bacb8: 8b000020     	add	x0, x1, x0
  7bacbc: 52800182     	mov	w2, #0xc                // =12
  7bacc0: aa0003e1     	mov	x1, x0
  7bacc4: aa0303e0     	mov	x0, x3
  7bacc8: 9400031e     	bl	0x7bb940
  7baccc: 52804440     	mov	w0, #0x222              // =546
  7bacd0: b9005be0     	str	w0, [sp, #0x58]
  7bacd4: 910163e0     	add	x0, sp, #0x58
  7bacd8: aa0003e1     	mov	x1, x0
  7bacdc: f94013e0     	ldr	x0, [sp, #0x20]
  7bace0: 940007e1     	bl	0x7bcc64
  7bace4: aa0003e2     	mov	x2, x0
  7bace8: f9400be0     	ldr	x0, [sp, #0x10]
  7bacec: b9407000     	ldr	w0, [x0, #0x70]
  7bacf0: 2a0003e1     	mov	w1, w0
  7bacf4: aa0203e0     	mov	x0, x2
  7bacf8: 940002fa     	bl	0x7bb8e0
  7bacfc: 52804480     	mov	w0, #0x224              // =548
  7bad00: b9005fe0     	str	w0, [sp, #0x5c]
  7bad04: 910173e0     	add	x0, sp, #0x5c
  7bad08: aa0003e1     	mov	x1, x0
  7bad0c: f94013e0     	ldr	x0, [sp, #0x20]
  7bad10: 940007d5     	bl	0x7bcc64
  7bad14: aa0003e2     	mov	x2, x0
  7bad18: f9400be0     	ldr	x0, [sp, #0x10]
  7bad1c: b9407400     	ldr	w0, [x0, #0x74]
  7bad20: 2a0003e1     	mov	w1, w0
  7bad24: aa0203e0     	mov	x0, x2
  7bad28: 940002ee     	bl	0x7bb8e0
  7bad2c: 528043a0     	mov	w0, #0x21d              // =541
  7bad30: b90063e0     	str	w0, [sp, #0x60]
  7bad34: 910183e0     	add	x0, sp, #0x60
  7bad38: aa0003e1     	mov	x1, x0
  7bad3c: f94013e0     	ldr	x0, [sp, #0x20]
  7bad40: 940007c9     	bl	0x7bcc64
  7bad44: aa0003e2     	mov	x2, x0
  7bad48: f9400be0     	ldr	x0, [sp, #0x10]
  7bad4c: b9409400     	ldr	w0, [x0, #0x94]
  7bad50: 2a0003e1     	mov	w1, w0
  7bad54: aa0203e0     	mov	x0, x2
  7bad58: 940002e2     	bl	0x7bb8e0
  7bad5c: 52802100     	mov	w0, #0x108              // =264
  7bad60: b90067e0     	str	w0, [sp, #0x64]
  7bad64: 910193e0     	add	x0, sp, #0x64
  7bad68: aa0003e1     	mov	x1, x0
  7bad6c: f94013e0     	ldr	x0, [sp, #0x20]
  7bad70: 940007bd     	bl	0x7bcc64
  7bad74: aa0003e2     	mov	x2, x0
  7bad78: f9400be0     	ldr	x0, [sp, #0x10]
  7bad7c: b9405800     	ldr	w0, [x0, #0x58]
  7bad80: 2a0003e1     	mov	w1, w0
  7bad84: aa0203e0     	mov	x0, x2
  7bad88: 940002d6     	bl	0x7bb8e0
  7bad8c: 52802120     	mov	w0, #0x109              // =265
  7bad90: b9006be0     	str	w0, [sp, #0x68]
  7bad94: 9101a3e0     	add	x0, sp, #0x68
  7bad98: aa0003e1     	mov	x1, x0
  7bad9c: f94013e0     	ldr	x0, [sp, #0x20]
  7bada0: 940007b1     	bl	0x7bcc64
  7bada4: aa0003e2     	mov	x2, x0
  7bada8: f9400be0     	ldr	x0, [sp, #0x10]
  7badac: b9405c00     	ldr	w0, [x0, #0x5c]
  7badb0: 2a0003e1     	mov	w1, w0
  7badb4: aa0203e0     	mov	x0, x2
  7badb8: 940002ca     	bl	0x7bb8e0
  7badbc: 52802180     	mov	w0, #0x10c              // =268
  7badc0: b9006fe0     	str	w0, [sp, #0x6c]
  7badc4: 9101b3e0     	add	x0, sp, #0x6c
  7badc8: aa0003e1     	mov	x1, x0
  7badcc: f94013e0     	ldr	x0, [sp, #0x20]
  7badd0: 940007a5     	bl	0x7bcc64
  7badd4: aa0003e2     	mov	x2, x0
  7badd8: f9400be0     	ldr	x0, [sp, #0x10]
  7baddc: b9406800     	ldr	w0, [x0, #0x68]
  7bade0: 2a0003e1     	mov	w1, w0
  7bade4: aa0203e0     	mov	x0, x2
  7bade8: 940002be     	bl	0x7bb8e0
  7badec: 528021a0     	mov	w0, #0x10d              // =269
  7badf0: b90073e0     	str	w0, [sp, #0x70]
  7badf4: 9101c3e0     	add	x0, sp, #0x70
  7badf8: aa0003e1     	mov	x1, x0
  7badfc: f94013e0     	ldr	x0, [sp, #0x20]
  7bae00: 94000799     	bl	0x7bcc64
  7bae04: aa0003e2     	mov	x2, x0
  7bae08: f9400be0     	ldr	x0, [sp, #0x10]
  7bae0c: b9406c00     	ldr	w0, [x0, #0x6c]
  7bae10: 2a0003e1     	mov	w1, w0
  7bae14: aa0203e0     	mov	x0, x2
  7bae18: 940002b2     	bl	0x7bb8e0
  7bae1c: 52802140     	mov	w0, #0x10a              // =266
  7bae20: b90077e0     	str	w0, [sp, #0x74]
  7bae24: 9101d3e0     	add	x0, sp, #0x74
  7bae28: aa0003e1     	mov	x1, x0
  7bae2c: f94013e0     	ldr	x0, [sp, #0x20]
  7bae30: 9400078d     	bl	0x7bcc64
  7bae34: aa0003e2     	mov	x2, x0
  7bae38: f9400be0     	ldr	x0, [sp, #0x10]
  7bae3c: b9406000     	ldr	w0, [x0, #0x60]
  7bae40: 2a0003e1     	mov	w1, w0
  7bae44: aa0203e0     	mov	x0, x2
  7bae48: 940002a6     	bl	0x7bb8e0
  7bae4c: 52802160     	mov	w0, #0x10b              // =267
  7bae50: b9007be0     	str	w0, [sp, #0x78]
  7bae54: 9101e3e0     	add	x0, sp, #0x78
  7bae58: aa0003e1     	mov	x1, x0
  7bae5c: f94013e0     	ldr	x0, [sp, #0x20]
  7bae60: 94000781     	bl	0x7bcc64
  7bae64: aa0003e2     	mov	x2, x0
  7bae68: f9400be0     	ldr	x0, [sp, #0x10]
  7bae6c: b9406400     	ldr	w0, [x0, #0x64]
  7bae70: 2a0003e1     	mov	w1, w0
  7bae74: aa0203e0     	mov	x0, x2
  7bae78: 9400029a     	bl	0x7bb8e0
  7bae7c: f9400be0     	ldr	x0, [sp, #0x10]
  7bae80: b9445c00     	ldr	w0, [x0, #0x45c]
  7bae84: 7100101f     	cmp	w0, #0x4
  7bae88: 540001a0     	b.eq	0x7baebc
  7bae8c: 7100101f     	cmp	w0, #0x4
  7bae90: 540000c8     	b.hi	0x7baea8
  7bae94: 7100081f     	cmp	w0, #0x2
  7bae98: 54000120     	b.eq	0x7baebc
  7bae9c: 71000c1f     	cmp	w0, #0x3
  7baea0: 540002e0     	b.eq	0x7baefc
  7baea4: 14000036     	b	0x7baf7c
  7baea8: 7100141f     	cmp	w0, #0x5
  7baeac: 54000480     	b.eq	0x7baf3c
  7baeb0: 71001c1f     	cmp	w0, #0x7
  7baeb4: 54000648     	b.hi	0x7baf7c
  7baeb8: 14000011     	b	0x7baefc
  7baebc: 52804460     	mov	w0, #0x223              // =547
  7baec0: b9007fe0     	str	w0, [sp, #0x7c]
  7baec4: 9101f3e0     	add	x0, sp, #0x7c
  7baec8: aa0003e1     	mov	x1, x0
  7baecc: f94013e0     	ldr	x0, [sp, #0x20]
  7baed0: 94000765     	bl	0x7bcc64
  7baed4: aa0003e3     	mov	x3, x0
  7baed8: f9400fe0     	ldr	x0, [sp, #0x18]
  7baedc: 9100a001     	add	x1, x0, #0x28
  7baee0: f9400be0     	ldr	x0, [sp, #0x10]
  7baee4: b9405c00     	ldr	w0, [x0, #0x5c]
  7baee8: 531e7400     	lsl	w0, w0, #2
  7baeec: 2a0003e2     	mov	w2, w0
  7baef0: aa0303e0     	mov	x0, x3
  7baef4: 94000293     	bl	0x7bb940
  7baef8: 1400002b     	b	0x7bafa4
  7baefc: 52804b40     	mov	w0, #0x25a              // =602
  7baf00: b90083e0     	str	w0, [sp, #0x80]
  7baf04: 910203e0     	add	x0, sp, #0x80
  7baf08: aa0003e1     	mov	x1, x0
  7baf0c: f94013e0     	ldr	x0, [sp, #0x20]
  7baf10: 94000755     	bl	0x7bcc64
  7baf14: aa0003e3     	mov	x3, x0
  7baf18: f9400fe0     	ldr	x0, [sp, #0x18]
  7baf1c: 9100a001     	add	x1, x0, #0x28
  7baf20: f9400be0     	ldr	x0, [sp, #0x10]
  7baf24: b9405c00     	ldr	w0, [x0, #0x5c]
  7baf28: 531e7400     	lsl	w0, w0, #2
  7baf2c: 2a0003e2     	mov	w2, w0
  7baf30: aa0303e0     	mov	x0, x3
  7baf34: 94000283     	bl	0x7bb940
  7baf38: 1400001b     	b	0x7bafa4
  7baf3c: 52804b20     	mov	w0, #0x259              // =601
  7baf40: b90087e0     	str	w0, [sp, #0x84]
  7baf44: 910213e0     	add	x0, sp, #0x84
  7baf48: aa0003e1     	mov	x1, x0
  7baf4c: f94013e0     	ldr	x0, [sp, #0x20]
  7baf50: 94000745     	bl	0x7bcc64
  7baf54: aa0003e3     	mov	x3, x0
  7baf58: f9400fe0     	ldr	x0, [sp, #0x18]
  7baf5c: 9100a001     	add	x1, x0, #0x28
  7baf60: f9400be0     	ldr	x0, [sp, #0x10]
  7baf64: b9405c00     	ldr	w0, [x0, #0x5c]
  7baf68: 531e7400     	lsl	w0, w0, #2
  7baf6c: 2a0003e2     	mov	w2, w0
  7baf70: aa0303e0     	mov	x0, x3
  7baf74: 94000273     	bl	0x7bb940
  7baf78: 1400000b     	b	0x7bafa4
  7baf7c: f9400be0     	ldr	x0, [sp, #0x10]
  7baf80: b9445c00     	ldr	w0, [x0, #0x45c]
  7baf84: 2a0003e4     	mov	w4, w0
  7baf88: f0002e40     	adrp	x0, 0xd85000
  7baf8c: 91092003     	add	x3, x0, #0x248
  7baf90: 5280eae2     	mov	w2, #0x757              // =1879
  7baf94: d0002e40     	adrp	x0, 0xd84000
  7baf98: 91372001     	add	x1, x0, #0xdc8
  7baf9c: 52800040     	mov	w0, #0x2                // =2
  7bafa0: 97fe2d6b     	bl	0x74654c
  7bafa4: f9400be0     	ldr	x0, [sp, #0x10]
  7bafa8: b9445c00     	ldr	w0, [x0, #0x45c]
  7bafac: 7100101f     	cmp	w0, #0x4
  7bafb0: 54000160     	b.eq	0x7bafdc
  7bafb4: 7100101f     	cmp	w0, #0x4
  7bafb8: 54000088     	b.hi	0x7bafc8
  7bafbc: 7100081f     	cmp	w0, #0x2
  7bafc0: 54000983     	b.lo	0x7bb0f0
  7bafc4: 14000055     	b	0x7bb118
  7bafc8: 7100181f     	cmp	w0, #0x6
  7bafcc: 54000369     	b.ls	0x7bb038
  7bafd0: 71001c1f     	cmp	w0, #0x7
  7bafd4: 54000600     	b.eq	0x7bb094
  7bafd8: 14000046     	b	0x7bb0f0
  7bafdc: f9400fe0     	ldr	x0, [sp, #0x18]
  7bafe0: 9100a001     	add	x1, x0, #0x28
  7bafe4: f9400be0     	ldr	x0, [sp, #0x10]
  7bafe8: b9405c00     	ldr	w0, [x0, #0x5c]
  7bafec: 531e7400     	lsl	w0, w0, #2
  7baff0: 2a0003e0     	mov	w0, w0
  7baff4: 8b000020     	add	x0, x1, x0
  7baff8: f90057e0     	str	x0, [sp, #0xa8]
  7baffc: 528044a0     	mov	w0, #0x225              // =549
  7bb000: b9008be0     	str	w0, [sp, #0x88]
  7bb004: 910223e0     	add	x0, sp, #0x88
  7bb008: aa0003e1     	mov	x1, x0
  7bb00c: f94013e0     	ldr	x0, [sp, #0x20]
  7bb010: 94000715     	bl	0x7bcc64
  7bb014: aa0003e3     	mov	x3, x0
  7bb018: f9400be0     	ldr	x0, [sp, #0x10]
  7bb01c: b9405800     	ldr	w0, [x0, #0x58]
  7bb020: 531e7400     	lsl	w0, w0, #2
  7bb024: 2a0003e2     	mov	w2, w0
  7bb028: f94057e1     	ldr	x1, [sp, #0xa8]
  7bb02c: aa0303e0     	mov	x0, x3
  7bb030: 94000244     	bl	0x7bb940
  7bb034: 14000039     	b	0x7bb118
  7bb038: f9400fe0     	ldr	x0, [sp, #0x18]
  7bb03c: 9100a001     	add	x1, x0, #0x28
  7bb040: f9400be0     	ldr	x0, [sp, #0x10]
  7bb044: b9405c00     	ldr	w0, [x0, #0x5c]
  7bb048: 531e7400     	lsl	w0, w0, #2
  7bb04c: 2a0003e0     	mov	w0, w0
  7bb050: 8b000020     	add	x0, x1, x0
  7bb054: f90053e0     	str	x0, [sp, #0xa0]
  7bb058: 52804b00     	mov	w0, #0x258              // =600
  7bb05c: b9008fe0     	str	w0, [sp, #0x8c]
  7bb060: 910233e0     	add	x0, sp, #0x8c
  7bb064: aa0003e1     	mov	x1, x0
  7bb068: f94013e0     	ldr	x0, [sp, #0x20]
  7bb06c: 940006fe     	bl	0x7bcc64
  7bb070: aa0003e3     	mov	x3, x0
  7bb074: f9400be0     	ldr	x0, [sp, #0x10]
  7bb078: b9405800     	ldr	w0, [x0, #0x58]
  7bb07c: 531e7400     	lsl	w0, w0, #2
  7bb080: 2a0003e2     	mov	w2, w0
  7bb084: f94053e1     	ldr	x1, [sp, #0xa0]
  7bb088: aa0303e0     	mov	x0, x3
  7bb08c: 9400022d     	bl	0x7bb940
  7bb090: 14000022     	b	0x7bb118
  7bb094: f9400fe0     	ldr	x0, [sp, #0x18]
  7bb098: 9100a001     	add	x1, x0, #0x28
  7bb09c: f9400be0     	ldr	x0, [sp, #0x10]
  7bb0a0: b9405c00     	ldr	w0, [x0, #0x5c]
  7bb0a4: 531e7400     	lsl	w0, w0, #2
  7bb0a8: 2a0003e0     	mov	w0, w0
  7bb0ac: 8b000020     	add	x0, x1, x0
  7bb0b0: f9004fe0     	str	x0, [sp, #0x98]
  7bb0b4: 52804d40     	mov	w0, #0x26a              // =618
  7bb0b8: b90093e0     	str	w0, [sp, #0x90]
  7bb0bc: 910243e0     	add	x0, sp, #0x90
  7bb0c0: aa0003e1     	mov	x1, x0
  7bb0c4: f94013e0     	ldr	x0, [sp, #0x20]
  7bb0c8: 940006e7     	bl	0x7bcc64
  7bb0cc: aa0003e3     	mov	x3, x0
  7bb0d0: f9400be0     	ldr	x0, [sp, #0x10]
  7bb0d4: b9405800     	ldr	w0, [x0, #0x58]
  7bb0d8: 531e7400     	lsl	w0, w0, #2
  7bb0dc: 2a0003e2     	mov	w2, w0
  7bb0e0: f9404fe1     	ldr	x1, [sp, #0x98]
  7bb0e4: aa0303e0     	mov	x0, x3
  7bb0e8: 94000216     	bl	0x7bb940
  7bb0ec: 1400000b     	b	0x7bb118
  7bb0f0: f9400be0     	ldr	x0, [sp, #0x10]
  7bb0f4: b9445c00     	ldr	w0, [x0, #0x45c]
  7bb0f8: 2a0003e4     	mov	w4, w0
  7bb0fc: d0002e40     	adrp	x0, 0xd85000
  7bb100: 9109c003     	add	x3, x0, #0x270
  7bb104: 5280ee82     	mov	w2, #0x774              // =1908
  7bb108: b0002e40     	adrp	x0, 0xd84000
  7bb10c: 91372001     	add	x1, x0, #0xdc8
  7bb110: 52800040     	mov	w0, #0x2                // =2
  7bb114: 97fe2d0e     	bl	0x74654c
  7bb118: f94017e0     	ldr	x0, [sp, #0x28]
  7bb11c: f940dc06     	ldr	x6, [x0, #0x1b8]
  7bb120: b001d1e0     	adrp	x0, 0x41f8000
  7bb124: 910e6000     	add	x0, x0, #0x398
  7bb128: b9400001     	ldr	w1, [x0]
  7bb12c: f9400be0     	ldr	x0, [sp, #0x10]
  7bb130: b9411002     	ldr	w2, [x0, #0x110]
  7bb134: f9400be0     	ldr	x0, [sp, #0x10]
  7bb138: b9408c03     	ldr	w3, [x0, #0x8c]
  7bb13c: f9400be0     	ldr	x0, [sp, #0x10]
  7bb140: b9409000     	ldr	w0, [x0, #0x90]
  7bb144: 2a0003e5     	mov	w5, w0
  7bb148: 2a0303e4     	mov	w4, w3
  7bb14c: 52800003     	mov	w3, #0x0                // =0
  7bb150: aa0603e0     	mov	x0, x6
  7bb154: 9400f1d0     	bl	0x7f7894
  7bb158: f9001be0     	str	x0, [sp, #0x30]
  7bb15c: f9401be0     	ldr	x0, [sp, #0x30]
  7bb160: f100001f     	cmp	x0, #0x0
  7bb164: 540001a1     	b.ne	0x7bb198
  7bb168: f94017e0     	ldr	x0, [sp, #0x28]
  7bb16c: f940dc04     	ldr	x4, [x0, #0x1b8]
  7bb170: f9400be0     	ldr	x0, [sp, #0x10]
  7bb174: b9411001     	ldr	w1, [x0, #0x110]
  7bb178: f9400be0     	ldr	x0, [sp, #0x10]
  7bb17c: b9408c02     	ldr	w2, [x0, #0x8c]
  7bb180: f9400be0     	ldr	x0, [sp, #0x10]
  7bb184: b9409000     	ldr	w0, [x0, #0x90]
  7bb188: 2a0003e3     	mov	w3, w0
  7bb18c: aa0403e0     	mov	x0, x4
  7bb190: 9400f5cc     	bl	0x7f88c0
  7bb194: f9001be0     	str	x0, [sp, #0x30]
  7bb198: f9401be0     	ldr	x0, [sp, #0x30]
  7bb19c: f100001f     	cmp	x0, #0x0
  7bb1a0: 54000200     	b.eq	0x7bb1e0
  7bb1a4: 52802200     	mov	w0, #0x110              // =272
  7bb1a8: b90097e0     	str	w0, [sp, #0x94]
  7bb1ac: 910253e0     	add	x0, sp, #0x94
  7bb1b0: aa0003e1     	mov	x1, x0
  7bb1b4: f94013e0     	ldr	x0, [sp, #0x20]
  7bb1b8: 940006ab     	bl	0x7bcc64
  7bb1bc: aa0003e3     	mov	x3, x0
  7bb1c0: f9401be0     	ldr	x0, [sp, #0x30]
  7bb1c4: f9400001     	ldr	x1, [x0]
  7bb1c8: f9401be0     	ldr	x0, [sp, #0x30]
  7bb1cc: b9400800     	ldr	w0, [x0, #0x8]
  7bb1d0: 2a0003e2     	mov	w2, w0
  7bb1d4: aa0303e0     	mov	x0, x3
  7bb1d8: 940001da     	bl	0x7bb940
  7bb1dc: 14000008     	b	0x7bb1fc
  7bb1e0: d0002e40     	adrp	x0, 0xd85000
  7bb1e4: 910b0003     	add	x3, x0, #0x2c0
  7bb1e8: 5280f042     	mov	w2, #0x782              // =1922
  7bb1ec: b0002e40     	adrp	x0, 0xd84000
  7bb1f0: 91372001     	add	x1, x0, #0xdc8
  7bb1f4: 52800080     	mov	w0, #0x4                // =4
  7bb1f8: 97fe2cd5     	bl	0x74654c
  7bb1fc: f9401be0     	ldr	x0, [sp, #0x30]
  7bb200: f100001f     	cmp	x0, #0x0
  7bb204: 540000a0     	b.eq	0x7bb218
  7bb208: f94017e0     	ldr	x0, [sp, #0x28]
  7bb20c: f940dc00     	ldr	x0, [x0, #0x1b8]
  7bb210: 9100c3e1     	add	x1, sp, #0x30
  7bb214: 9400f3c8     	bl	0x7f8134
  7bb218: d503201f     	nop
  7bb21c: a8cb7bfd     	ldp	x29, x30, [sp], #0xb0
  7bb220: d65f03c0     	ret
