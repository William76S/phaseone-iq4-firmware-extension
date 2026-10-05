  492fd4: d108c3ff     	sub	sp, sp, #0x230
  492fd8: a9007bfd     	stp	x29, x30, [sp]
  492fdc: 910003fd     	mov	x29, sp
  492fe0: f9000bf3     	str	x19, [sp, #0x10]
  492fe4: f90017e0     	str	x0, [sp, #0x28]
  492fe8: b90027e1     	str	w1, [sp, #0x24]
  492fec: 9107c3e3     	add	x3, sp, #0x1f0
  492ff0: 52800022     	mov	w2, #0x1                // =1
  492ff4: 90003760     	adrp	x0, 0xb7e000
  492ff8: 91252001     	add	x1, x0, #0x948
  492ffc: aa0303e0     	mov	x0, x3
  493000: 97fe6c8c     	bl	0x42e230 <.text+0x23000>
  493004: f0003740     	adrp	x0, 0xb7e000
  493008: 91258000     	add	x0, x0, #0x960
  49300c: f90117e0     	str	x0, [sp, #0x228]
  493010: b94027e0     	ldr	w0, [sp, #0x24]
  493014: 7100081f     	cmp	w0, #0x2
  493018: 54000140     	b.eq	0x493040 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d094>
  49301c: 7100101f     	cmp	w0, #0x4
  493020: 540001e1     	b.ne	0x49305c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d0b0>
  493024: f94017e0     	ldr	x0, [sp, #0x28]
  493028: f943d000     	ldr	x0, [x0, #0x7a0]
  49302c: f900f7e0     	str	x0, [sp, #0x1e8]
  493030: f94017e0     	ldr	x0, [sp, #0x28]
  493034: f943d800     	ldr	x0, [x0, #0x7b0]
  493038: f90117e0     	str	x0, [sp, #0x228]
  49303c: 14000012     	b	0x493084 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d0d8>
  493040: f94017e0     	ldr	x0, [sp, #0x28]
  493044: f943e800     	ldr	x0, [x0, #0x7d0]
  493048: f900f7e0     	str	x0, [sp, #0x1e8]
  49304c: f94017e0     	ldr	x0, [sp, #0x28]
  493050: f943f000     	ldr	x0, [x0, #0x7e0]
  493054: f90117e0     	str	x0, [sp, #0x228]
  493058: 1400000b     	b	0x493084 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d0d8>
  49305c: b94027e0     	ldr	w0, [sp, #0x24]
  493060: 2a0003e4     	mov	w4, w0
  493064: f0003740     	adrp	x0, 0xb7e000
  493068: 9124a003     	add	x3, x0, #0x928
  49306c: 52803ec2     	mov	w2, #0x1f6              // =502
  493070: f0003740     	adrp	x0, 0xb7e000
  493074: 911e0001     	add	x1, x0, #0x780
  493078: 52800040     	mov	w0, #0x2                // =2
  49307c: 940acd34     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  493080: d503201f     	nop
  493084: f94017e0     	ldr	x0, [sp, #0x28]
  493088: 91070001     	add	x1, x0, #0x1c0
  49308c: 910783e0     	add	x0, sp, #0x1e0
  493090: 97fdfacc     	bl	0x411bc0 <.text+0x6990>
  493094: f940f7e0     	ldr	x0, [sp, #0x1e8]
  493098: f100001f     	cmp	x0, #0x0
  49309c: 54000141     	b.ne	0x4930c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d118>
  4930a0: 52804023     	mov	w3, #0x201              // =513
  4930a4: f0003740     	adrp	x0, 0xb7e000
  4930a8: 911e0002     	add	x2, x0, #0x780
  4930ac: f0003740     	adrp	x0, 0xb7e000
  4930b0: 9125a001     	add	x1, x0, #0x968
  4930b4: f0003740     	adrp	x0, 0xb7e000
  4930b8: 911f2000     	add	x0, x0, #0x7c8
  4930bc: 97fddd31     	bl	0x40a580 <printf@plt>
  4930c0: 940b6592     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  4930c4: a91c7fff     	stp	xzr, xzr, [sp, #0x1c0]
  4930c8: f900ebff     	str	xzr, [sp, #0x1d0]
  4930cc: b901dbff     	str	wzr, [sp, #0x1d8]
  4930d0: 7903bbff     	strh	wzr, [sp, #0x1dc]
  4930d4: 910703e3     	add	x3, sp, #0x1c0
  4930d8: f94117e2     	ldr	x2, [sp, #0x228]
  4930dc: f0003740     	adrp	x0, 0xb7e000
  4930e0: 9125e001     	add	x1, x0, #0x978
  4930e4: aa0303e0     	mov	x0, x3
  4930e8: 97fdddc6     	bl	0x40a800 <sprintf@plt>
  4930ec: 9100c3e0     	add	x0, sp, #0x30
  4930f0: 97ffeba4     	bl	0x48df80 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57fd4>
  4930f4: b90227ff     	str	wzr, [sp, #0x224]
  4930f8: f940f7e4     	ldr	x4, [sp, #0x1e8]
  4930fc: f940f7e0     	ldr	x0, [sp, #0x1e8]
  493100: f9400000     	ldr	x0, [x0]
  493104: 9100c000     	add	x0, x0, #0x30
  493108: f9400003     	ldr	x3, [x0]
  49310c: 9100c3e1     	add	x1, sp, #0x30
  493110: 910703e0     	add	x0, sp, #0x1c0
  493114: aa0103e2     	mov	x2, x1
  493118: aa0003e1     	mov	x1, x0
  49311c: aa0403e0     	mov	x0, x4
  493120: d63f0060     	blr	x3
  493124: 12001c00     	and	w0, w0, #0xff
  493128: 52000000     	eor	w0, w0, #0x1
  49312c: 39088fe0     	strb	w0, [sp, #0x223]
  493130: f94017e0     	ldr	x0, [sp, #0x28]
  493134: b941a801     	ldr	w1, [x0, #0x1a8]
  493138: b94227e0     	ldr	w0, [sp, #0x224]
  49313c: 6b00003f     	cmp	w1, w0
  493140: 540019a9     	b.ls	0x493474 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d4c8>
  493144: 39488fe0     	ldrb	w0, [sp, #0x223]
  493148: 7100001f     	cmp	w0, #0x0
  49314c: 54001941     	b.ne	0x493474 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d4c8>
  493150: 3944e3e0     	ldrb	w0, [sp, #0x138]
  493154: 52000000     	eor	w0, w0, #0x1
  493158: 12001c00     	and	w0, w0, #0xff
  49315c: 7100001f     	cmp	w0, #0x0
  493160: 54001700     	b.eq	0x493440 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d494>
  493164: b94137e0     	ldr	w0, [sp, #0x134]
  493168: 7144001f     	cmp	w0, #0x100, lsl #12     // =0x100000
  49316c: 540016a9     	b.ls	0x493440 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d494>
  493170: 9100c3e2     	add	x2, sp, #0x30
  493174: f0003740     	adrp	x0, 0xb7e000
  493178: 91260001     	add	x1, x0, #0x980
  49317c: aa0203e0     	mov	x0, x2
  493180: 97fddcb8     	bl	0x40a460 <strstr@plt>
  493184: f100001f     	cmp	x0, #0x0
  493188: 540015c0     	b.eq	0x493440 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d494>
  49318c: 52800020     	mov	w0, #0x1                // =1
  493190: 39088be0     	strb	w0, [sp, #0x222]
  493194: b9021fff     	str	wzr, [sp, #0x21c]
  493198: f94017e0     	ldr	x0, [sp, #0x28]
  49319c: b941b800     	ldr	w0, [x0, #0x1b8]
  4931a0: b9421fe1     	ldr	w1, [sp, #0x21c]
  4931a4: 6b00003f     	cmp	w1, w0
  4931a8: 5400042a     	b.ge	0x49322c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d280>
  4931ac: f94017e0     	ldr	x0, [sp, #0x28]
  4931b0: f940d800     	ldr	x0, [x0, #0x1b0]
  4931b4: b9821fe1     	ldrsw	x1, [sp, #0x21c]
  4931b8: 97fff0ce     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  4931bc: aa0003e2     	mov	x2, x0
  4931c0: 9100c3e0     	add	x0, sp, #0x30
  4931c4: aa0003e1     	mov	x1, x0
  4931c8: aa0203e0     	mov	x0, x2
  4931cc: 97fdde5d     	bl	0x40ab40 <strcmp@plt>
  4931d0: 7100001f     	cmp	w0, #0x0
  4931d4: 1a9f17e0     	cset	w0, eq
  4931d8: 12001c00     	and	w0, w0, #0xff
  4931dc: 7100001f     	cmp	w0, #0x0
  4931e0: 540001e0     	b.eq	0x49321c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d270>
  4931e4: f94017e0     	ldr	x0, [sp, #0x28]
  4931e8: f940d800     	ldr	x0, [x0, #0x1b0]
  4931ec: b9821fe1     	ldrsw	x1, [sp, #0x21c]
  4931f0: 97fff0c0     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  4931f4: 39403801     	ldrb	w1, [x0, #0xe]
  4931f8: 13001c22     	sxtb	w2, w1
  4931fc: b94027e1     	ldr	w1, [sp, #0x24]
  493200: 13001c21     	sxtb	w1, w1
  493204: 2a010041     	orr	w1, w2, w1
  493208: 13001c21     	sxtb	w1, w1
  49320c: 12001c21     	and	w1, w1, #0xff
  493210: 39003801     	strb	w1, [x0, #0xe]
  493214: 39088bff     	strb	wzr, [sp, #0x222]
  493218: 14000005     	b	0x49322c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d280>
  49321c: b9421fe0     	ldr	w0, [sp, #0x21c]
  493220: 11000400     	add	w0, w0, #0x1
  493224: b9021fe0     	str	w0, [sp, #0x21c]
  493228: 17ffffdc     	b	0x493198 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d1ec>
  49322c: 39488be0     	ldrb	w0, [sp, #0x222]
  493230: 7100001f     	cmp	w0, #0x0
  493234: 54001060     	b.eq	0x493440 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d494>
  493238: f94017e0     	ldr	x0, [sp, #0x28]
  49323c: b941b800     	ldr	w0, [x0, #0x1b8]
  493240: b90227e0     	str	w0, [sp, #0x224]
  493244: f94017e0     	ldr	x0, [sp, #0x28]
  493248: 91086001     	add	x1, x0, #0x218
  49324c: 9106e3e0     	add	x0, sp, #0x1b8
  493250: 97fdfa5c     	bl	0x411bc0 <.text+0x6990>
  493254: f94017e0     	ldr	x0, [sp, #0x28]
  493258: f940d800     	ldr	x0, [x0, #0x1b0]
  49325c: b98227e1     	ldrsw	x1, [sp, #0x224]
  493260: 97fff0a4     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  493264: 79402000     	ldrh	w0, [x0, #0x10]
  493268: 7100001f     	cmp	w0, #0x0
  49326c: 1a9f07e0     	cset	w0, ne
  493270: 12001c00     	and	w0, w0, #0xff
  493274: 7100001f     	cmp	w0, #0x0
  493278: 54000740     	b.eq	0x493360 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d3b4>
  49327c: f94017e0     	ldr	x0, [sp, #0x28]
  493280: f940d802     	ldr	x2, [x0, #0x1b0]
  493284: b94227e0     	ldr	w0, [sp, #0x224]
  493288: 11000400     	add	w0, w0, #0x1
  49328c: 93407c00     	sxtw	x0, w0
  493290: aa0003e1     	mov	x1, x0
  493294: aa0203e0     	mov	x0, x2
  493298: 97fff096     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  49329c: aa0003f3     	mov	x19, x0
  4932a0: f94017e0     	ldr	x0, [sp, #0x28]
  4932a4: f940d800     	ldr	x0, [x0, #0x1b0]
  4932a8: b98227e1     	ldrsw	x1, [sp, #0x224]
  4932ac: 97fff091     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  4932b0: aa0003e3     	mov	x3, x0
  4932b4: f94017e0     	ldr	x0, [sp, #0x28]
  4932b8: b941b801     	ldr	w1, [x0, #0x1b8]
  4932bc: b94227e0     	ldr	w0, [sp, #0x224]
  4932c0: 4b000020     	sub	w0, w1, w0
  4932c4: 93407c01     	sxtw	x1, w0
  4932c8: aa0103e0     	mov	x0, x1
  4932cc: d37ef400     	lsl	x0, x0, #2
  4932d0: 8b010000     	add	x0, x0, x1
  4932d4: d37df000     	lsl	x0, x0, #3
  4932d8: aa0003e2     	mov	x2, x0
  4932dc: aa0303e1     	mov	x1, x3
  4932e0: aa1303e0     	mov	x0, x19
  4932e4: 97fdda93     	bl	0x409d30 <memmove@plt>
  4932e8: b94227e0     	ldr	w0, [sp, #0x224]
  4932ec: 11000400     	add	w0, w0, #0x1
  4932f0: b9021be0     	str	w0, [sp, #0x218]
  4932f4: f94017e0     	ldr	x0, [sp, #0x28]
  4932f8: b941b800     	ldr	w0, [x0, #0x1b8]
  4932fc: 11000400     	add	w0, w0, #0x1
  493300: b9421be1     	ldr	w1, [sp, #0x218]
  493304: 6b00003f     	cmp	w1, w0
  493308: 540002cc     	b.gt	0x493360 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d3b4>
  49330c: f94017e0     	ldr	x0, [sp, #0x28]
  493310: f940d800     	ldr	x0, [x0, #0x1b0]
  493314: b9821be1     	ldrsw	x1, [sp, #0x218]
  493318: 97fff076     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  49331c: f9401000     	ldr	x0, [x0, #0x20]
  493320: f100001f     	cmp	x0, #0x0
  493324: 1a9f07e0     	cset	w0, ne
  493328: 12001c00     	and	w0, w0, #0xff
  49332c: 7100001f     	cmp	w0, #0x0
  493330: 54000100     	b.eq	0x493350 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d3a4>
  493334: f94017e0     	ldr	x0, [sp, #0x28]
  493338: f940d800     	ldr	x0, [x0, #0x1b0]
  49333c: b9821be1     	ldrsw	x1, [sp, #0x218]
  493340: 97fff06c     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  493344: f9401000     	ldr	x0, [x0, #0x20]
  493348: b9421be1     	ldr	w1, [sp, #0x218]
  49334c: 9410bfb8     	bl	0x8c322c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1ca00>
  493350: b9421be0     	ldr	w0, [sp, #0x218]
  493354: 11000400     	add	w0, w0, #0x1
  493358: b9021be0     	str	w0, [sp, #0x218]
  49335c: 17ffffe6     	b	0x4932f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d348>
  493360: f94017e0     	ldr	x0, [sp, #0x28]
  493364: f940d800     	ldr	x0, [x0, #0x1b0]
  493368: b98227e1     	ldrsw	x1, [sp, #0x224]
  49336c: 97fff061     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  493370: aa0003e3     	mov	x3, x0
  493374: 9100c3e0     	add	x0, sp, #0x30
  493378: d28001a2     	mov	x2, #0xd                // =13
  49337c: aa0003e1     	mov	x1, x0
  493380: aa0303e0     	mov	x0, x3
  493384: 97fddd8f     	bl	0x40a9c0 <strncpy@plt>
  493388: 9100c3e0     	add	x0, sp, #0x30
  49338c: 91044000     	add	x0, x0, #0x110
  493390: 9409da15     	bl	0x709be4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x1bb64>
  493394: 2a0003f3     	mov	w19, w0
  493398: f94017e0     	ldr	x0, [sp, #0x28]
  49339c: f940d800     	ldr	x0, [x0, #0x1b0]
  4933a0: b98227e1     	ldrsw	x1, [sp, #0x224]
  4933a4: 97fff053     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  4933a8: b9001413     	str	w19, [x0, #0x14]
  4933ac: b94027e0     	ldr	w0, [sp, #0x24]
  4933b0: 12001c13     	and	w19, w0, #0xff
  4933b4: f94017e0     	ldr	x0, [sp, #0x28]
  4933b8: f940d800     	ldr	x0, [x0, #0x1b0]
  4933bc: b98227e1     	ldrsw	x1, [sp, #0x224]
  4933c0: 97fff04c     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  4933c4: 2a1303e1     	mov	w1, w19
  4933c8: 39003801     	strb	w1, [x0, #0xe]
  4933cc: f94017e0     	ldr	x0, [sp, #0x28]
  4933d0: f940d800     	ldr	x0, [x0, #0x1b0]
  4933d4: b98227e1     	ldrsw	x1, [sp, #0x224]
  4933d8: 97fff046     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  4933dc: aa0003e1     	mov	x1, x0
  4933e0: 52800420     	mov	w0, #0x21               // =33
  4933e4: 79002020     	strh	w0, [x1, #0x10]
  4933e8: f94017e0     	ldr	x0, [sp, #0x28]
  4933ec: 91138000     	add	x0, x0, #0x4e0
  4933f0: 52800001     	mov	w1, #0x0                // =0
  4933f4: 97fff3e2     	bl	0x49037c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5a3d0>
  4933f8: 2a0003f3     	mov	w19, w0
  4933fc: f94017e0     	ldr	x0, [sp, #0x28]
  493400: f940d800     	ldr	x0, [x0, #0x1b0]
  493404: b98227e1     	ldrsw	x1, [sp, #0x224]
  493408: 97fff03a     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  49340c: b9001813     	str	w19, [x0, #0x18]
  493410: b94227e0     	ldr	w0, [sp, #0x224]
  493414: 11000400     	add	w0, w0, #0x1
  493418: b90227e0     	str	w0, [sp, #0x224]
  49341c: f94017e2     	ldr	x2, [sp, #0x28]
  493420: f94017e0     	ldr	x0, [sp, #0x28]
  493424: b941b800     	ldr	w0, [x0, #0x1b8]
  493428: 11000400     	add	w0, w0, #0x1
  49342c: 2a0003e1     	mov	w1, w0
  493430: aa0203e0     	mov	x0, x2
  493434: 97ffde8d     	bl	0x48ae68 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x54ebc>
  493438: 9106e3e0     	add	x0, sp, #0x1b8
  49343c: 97fdf9ee     	bl	0x411bf4 <.text+0x69c4>
  493440: f940f7e3     	ldr	x3, [sp, #0x1e8]
  493444: f940f7e0     	ldr	x0, [sp, #0x1e8]
  493448: f9400000     	ldr	x0, [x0]
  49344c: 9100e000     	add	x0, x0, #0x38
  493450: f9400002     	ldr	x2, [x0]
  493454: 9100c3e0     	add	x0, sp, #0x30
  493458: aa0003e1     	mov	x1, x0
  49345c: aa0303e0     	mov	x0, x3
  493460: d63f0040     	blr	x2
  493464: 12001c00     	and	w0, w0, #0xff
  493468: 52000000     	eor	w0, w0, #0x1
  49346c: 39088fe0     	strb	w0, [sp, #0x223]
  493470: 17ffff30     	b	0x493130 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d184>
  493474: f940f7e3     	ldr	x3, [sp, #0x1e8]
  493478: f940f7e0     	ldr	x0, [sp, #0x1e8]
  49347c: f9400000     	ldr	x0, [x0]
  493480: 91010000     	add	x0, x0, #0x40
  493484: f9400002     	ldr	x2, [x0]
  493488: 9100c3e0     	add	x0, sp, #0x30
  49348c: aa0003e1     	mov	x1, x0
  493490: aa0303e0     	mov	x0, x3
  493494: d63f0040     	blr	x2
  493498: f94017e0     	ldr	x0, [sp, #0x28]
  49349c: 97ffe0e3     	bl	0x48b828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5587c>
  4934a0: f94017e0     	ldr	x0, [sp, #0x28]
  4934a4: 97ffe11e     	bl	0x48b91c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x55970>
  4934a8: f94017e0     	ldr	x0, [sp, #0x28]
  4934ac: 97ffe12b     	bl	0x48b958 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x559ac>
  4934b0: f94017e0     	ldr	x0, [sp, #0x28]
  4934b4: b941b800     	ldr	w0, [x0, #0x1b8]
  4934b8: 51002800     	sub	w0, w0, #0xa
  4934bc: b90227e0     	str	w0, [sp, #0x224]
  4934c0: b94227e0     	ldr	w0, [sp, #0x224]
  4934c4: 7100241f     	cmp	w0, #0x9
  4934c8: 5400004c     	b.gt	0x4934d0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d524>
  4934cc: b90227ff     	str	wzr, [sp, #0x224]
  4934d0: f94017e0     	ldr	x0, [sp, #0x28]
  4934d4: b941b800     	ldr	w0, [x0, #0x1b8]
  4934d8: b94227e1     	ldr	w1, [sp, #0x224]
  4934dc: 6b00003f     	cmp	w1, w0
  4934e0: 5400012a     	b.ge	0x493504 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d558>
  4934e4: f94017e0     	ldr	x0, [sp, #0x28]
  4934e8: b94227e1     	ldr	w1, [sp, #0x224]
  4934ec: 52800022     	mov	w2, #0x1                // =1
  4934f0: 97ffe607     	bl	0x48cd0c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x56d60>
  4934f4: b94227e0     	ldr	w0, [sp, #0x224]
  4934f8: 11000400     	add	w0, w0, #0x1
  4934fc: b90227e0     	str	w0, [sp, #0x224]
  493500: 17fffff4     	b	0x4934d0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d524>
  493504: f94017e0     	ldr	x0, [sp, #0x28]
  493508: f9419400     	ldr	x0, [x0, #0x328]
  49350c: 91002002     	add	x2, x0, #0x8
  493510: f94017e0     	ldr	x0, [sp, #0x28]
  493514: b941b800     	ldr	w0, [x0, #0x1b8]
  493518: 51000400     	sub	w0, w0, #0x1
  49351c: 2a0003e1     	mov	w1, w0
  493520: aa0203e0     	mov	x0, x2
  493524: 97fde4e4     	bl	0x40c8b4 <.text+0x1684>
  493528: 9100c3e0     	add	x0, sp, #0x30
  49352c: 97ffef90     	bl	0x48f36c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x593c0>
  493530: 910783e0     	add	x0, sp, #0x1e0
  493534: 97fdf9b0     	bl	0x411bf4 <.text+0x69c4>
  493538: 9107c3e0     	add	x0, sp, #0x1f0
  49353c: 97fe6b4f     	bl	0x42e278 <.text+0x23048>
  493540: 14000012     	b	0x493588 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d5dc>
  493544: aa0003f3     	mov	x19, x0
  493548: 9106e3e0     	add	x0, sp, #0x1b8
  49354c: 97fdf9aa     	bl	0x411bf4 <.text+0x69c4>
  493550: 14000002     	b	0x493558 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d5ac>
  493554: aa0003f3     	mov	x19, x0
  493558: 9100c3e0     	add	x0, sp, #0x30
  49355c: 97ffef84     	bl	0x48f36c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x593c0>
  493560: 14000002     	b	0x493568 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d5bc>
  493564: aa0003f3     	mov	x19, x0
  493568: 910783e0     	add	x0, sp, #0x1e0
  49356c: 97fdf9a2     	bl	0x411bf4 <.text+0x69c4>
  493570: 14000002     	b	0x493578 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d5cc>
  493574: aa0003f3     	mov	x19, x0
  493578: 9107c3e0     	add	x0, sp, #0x1f0
  49357c: 97fe6b3f     	bl	0x42e278 <.text+0x23048>
  493580: aa1303e0     	mov	x0, x19
  493584: 97fddc73     	bl	0x40a750 <_Unwind_Resume@plt>
  493588: f9400bf3     	ldr	x19, [sp, #0x10]
  49358c: a9407bfd     	ldp	x29, x30, [sp]
  493590: 9108c3ff     	add	sp, sp, #0x230
  493594: d65f03c0     	ret
