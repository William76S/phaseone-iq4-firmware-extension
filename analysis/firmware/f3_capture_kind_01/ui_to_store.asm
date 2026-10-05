
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000435fac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_>:
  492598: a9b87bfd     	stp	x29, x30, [sp, #-0x80]!
  49259c: 910003fd     	mov	x29, sp
  4925a0: f9000bf3     	str	x19, [sp, #0x10]
  4925a4: f90017e0     	str	x0, [sp, #0x28]
  4925a8: f94017e0     	ldr	x0, [sp, #0x28]
  4925ac: f942ec00     	ldr	x0, [x0, #0x5d8]
  4925b0: 9104a000     	add	x0, x0, #0x128
  4925b4: 94000b5c     	bl	0x495324 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f378>
  4925b8: f9003fe0     	str	x0, [sp, #0x78]
  4925bc: f9403fe0     	ldr	x0, [sp, #0x78]
  4925c0: f100001f     	cmp	x0, #0x0
  4925c4: 54002320     	b.eq	0x492a28 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5ca7c>
  4925c8: f9403fe0     	ldr	x0, [sp, #0x78]
  4925cc: f9400400     	ldr	x0, [x0, #0x8]
  4925d0: f9002fe0     	str	x0, [sp, #0x58]
  4925d4: f9402fe0     	ldr	x0, [sp, #0x58]
  4925d8: f100001f     	cmp	x0, #0x0
  4925dc: 54000141     	b.ne	0x492604 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5c658>
  4925e0: 52800ee3     	mov	w3, #0x77               // =119
  4925e4: 90003760     	adrp	x0, 0xb7e000
  4925e8: 911e0002     	add	x2, x0, #0x780
  4925ec: 90003760     	adrp	x0, 0xb7e000
  4925f0: 911ee001     	add	x1, x0, #0x7b8
  4925f4: 90003760     	adrp	x0, 0xb7e000
  4925f8: 911f2000     	add	x0, x0, #0x7c8
  4925fc: 97fddfe1     	bl	0x40a580 <printf@plt>
  492600: 940b6842     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  492604: f9402fe0     	ldr	x0, [sp, #0x58]
  492608: 9410bfcd     	bl	0x8c253c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bd10>
  49260c: f94017e0     	ldr	x0, [sp, #0x28]
  492610: b941b800     	ldr	w0, [x0, #0x1b8]
  492614: 2a0003e1     	mov	w1, w0
  492618: f94017e0     	ldr	x0, [sp, #0x28]
  49261c: b941a800     	ldr	w0, [x0, #0x1a8]
  492620: 6b00003f     	cmp	w1, w0
  492624: 54000183     	b.lo	0x492654 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5c6a8>
  492628: f94017e0     	ldr	x0, [sp, #0x28]
  49262c: b941a800     	ldr	w0, [x0, #0x1a8]
  492630: 2a0003e4     	mov	w4, w0
  492634: 90003760     	adrp	x0, 0xb7e000
  492638: 911fc003     	add	x3, x0, #0x7f0
  49263c: 52800fc2     	mov	w2, #0x7e               // =126
  492640: 90003760     	adrp	x0, 0xb7e000
  492644: 911e0001     	add	x1, x0, #0x780
  492648: 52800080     	mov	w0, #0x4                // =4
  49264c: 940acfc0     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  492650: 140000e2     	b	0x4929d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5ca2c>
  492654: f94017e0     	ldr	x0, [sp, #0x28]
  492658: 91070001     	add	x1, x0, #0x1c0
  49265c: 910143e0     	add	x0, sp, #0x50
  492660: 97fdfd58     	bl	0x411bc0 <.text+0x6990>
  492664: f94017e0     	ldr	x0, [sp, #0x28]
  492668: b941b800     	ldr	w0, [x0, #0x1b8]
  49266c: b90077e0     	str	w0, [sp, #0x74]
  492670: f94017e2     	ldr	x2, [sp, #0x28]
  492674: f94017e0     	ldr	x0, [sp, #0x28]
  492678: b941b800     	ldr	w0, [x0, #0x1b8]
  49267c: 11000400     	add	w0, w0, #0x1
  492680: 2a0003e1     	mov	w1, w0
  492684: aa0203e0     	mov	x0, x2
  492688: 97ffe1f8     	bl	0x48ae68 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x54ebc>
  49268c: f94017e0     	ldr	x0, [sp, #0x28]
  492690: f940d800     	ldr	x0, [x0, #0x1b0]
  492694: b98077e1     	ldrsw	x1, [sp, #0x74]
  492698: 97fff396     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  49269c: 79402001     	ldrh	w1, [x0, #0x10]
  4926a0: 321f0021     	orr	w1, w1, #0x2
  4926a4: 12003c21     	and	w1, w1, #0xffff
  4926a8: 79002001     	strh	w1, [x0, #0x10]
  4926ac: f9402ff3     	ldr	x19, [sp, #0x58]
  4926b0: f94017e0     	ldr	x0, [sp, #0x28]
  4926b4: f940d800     	ldr	x0, [x0, #0x1b0]
  4926b8: b98077e1     	ldrsw	x1, [sp, #0x74]
  4926bc: 97fff38d     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  4926c0: f9001013     	str	x19, [x0, #0x20]
  4926c4: f94017e0     	ldr	x0, [sp, #0x28]
  4926c8: 91138000     	add	x0, x0, #0x4e0
  4926cc: 52800001     	mov	w1, #0x0                // =0
  4926d0: 97fff72b     	bl	0x49037c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5a3d0>
  4926d4: 2a0003f3     	mov	w19, w0
  4926d8: f94017e0     	ldr	x0, [sp, #0x28]
  4926dc: f940d800     	ldr	x0, [x0, #0x1b0]
  4926e0: b98077e1     	ldrsw	x1, [sp, #0x74]
  4926e4: 97fff383     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  4926e8: b9001813     	str	w19, [x0, #0x18]
  4926ec: f9402fe0     	ldr	x0, [sp, #0x58]
  4926f0: b94077e1     	ldr	w1, [sp, #0x74]
  4926f4: 9410c2ce     	bl	0x8c322c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1ca00>
  4926f8: f9402fe0     	ldr	x0, [sp, #0x58]
  4926fc: 97ffec91     	bl	0x48d940 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57994>
  492700: 12001c00     	and	w0, w0, #0xff
  492704: 52000000     	eor	w0, w0, #0x1
  492708: 12001c00     	and	w0, w0, #0xff
  49270c: 7100001f     	cmp	w0, #0x0
  492710: 54000120     	b.eq	0x492734 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5c788>
  492714: 90003760     	adrp	x0, 0xb7e000
  492718: 9120a003     	add	x3, x0, #0x828
  49271c: 528011e2     	mov	w2, #0x8f               // =143
  492720: 90003760     	adrp	x0, 0xb7e000
  492724: 911e0001     	add	x1, x0, #0x780
  492728: 52800080     	mov	w0, #0x4                // =4
  49272c: 940acf88     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  492730: 1400002c     	b	0x4927e0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5c834>
  492734: f9402fe1     	ldr	x1, [sp, #0x58]
  492738: 910103e0     	add	x0, sp, #0x40
  49273c: 94000a6b     	bl	0x4950e8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f13c>
  492740: 910103e0     	add	x0, sp, #0x40
  492744: 94000aaa     	bl	0x4951ec <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f240>
  492748: 94000a53     	bl	0x495094 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f0e8>
  49274c: f90037e0     	str	x0, [sp, #0x68]
  492750: f94037e0     	ldr	x0, [sp, #0x68]
  492754: f100001f     	cmp	x0, #0x0
  492758: 54000101     	b.ne	0x492778 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5c7cc>
  49275c: 90003760     	adrp	x0, 0xb7e000
  492760: 91212003     	add	x3, x0, #0x848
  492764: 528012e2     	mov	w2, #0x97               // =151
  492768: 90003760     	adrp	x0, 0xb7e000
  49276c: 911e0001     	add	x1, x0, #0x780
  492770: 52800080     	mov	w0, #0x4                // =4
  492774: 940acf76     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  492778: f94017e0     	ldr	x0, [sp, #0x28]
  49277c: f940d800     	ldr	x0, [x0, #0x1b0]
  492780: b98077e1     	ldrsw	x1, [sp, #0x74]
  492784: 97fff35b     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  492788: aa0003e4     	mov	x4, x0
  49278c: f94037e0     	ldr	x0, [sp, #0x68]
  492790: 9140b000     	add	x0, x0, #0x2c, lsl #12  // =0x2c000
  492794: b9588c00     	ldr	w0, [x0, #0x188c]
  492798: 2a0003e3     	mov	w3, w0
  49279c: 90003760     	adrp	x0, 0xb7e000
  4927a0: 91218002     	add	x2, x0, #0x860
  4927a4: d28001c1     	mov	x1, #0xe                // =14
  4927a8: aa0403e0     	mov	x0, x4
  4927ac: 97fddde1     	bl	0x409f30 <snprintf@plt>
  4927b0: f9402fe0     	ldr	x0, [sp, #0x58]
  4927b4: 91009413     	add	x19, x0, #0x25
  4927b8: f94017e0     	ldr	x0, [sp, #0x28]
  4927bc: f940d800     	ldr	x0, [x0, #0x1b0]
  4927c0: b98077e1     	ldrsw	x1, [sp, #0x74]
  4927c4: 97fff34b     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  4927c8: d28001e2     	mov	x2, #0xf                // =15
  4927cc: aa0003e1     	mov	x1, x0
  4927d0: aa1303e0     	mov	x0, x19
  4927d4: 97fde07b     	bl	0x40a9c0 <strncpy@plt>
  4927d8: 910103e0     	add	x0, sp, #0x40
  4927dc: 94000a70     	bl	0x49519c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f1f0>
  4927e0: f9402fe0     	ldr	x0, [sp, #0x58]
  4927e4: 94000a38     	bl	0x4950c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f118>
  4927e8: 12001c00     	and	w0, w0, #0xff
  4927ec: 52000000     	eor	w0, w0, #0x1
  4927f0: 12001c00     	and	w0, w0, #0xff
  4927f4: 7100001f     	cmp	w0, #0x0
  4927f8: 54000120     	b.eq	0x49281c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5c870>
  4927fc: 90003760     	adrp	x0, 0xb7e000
  492800: 9121c003     	add	x3, x0, #0x870
  492804: 52801482     	mov	w2, #0xa4               // =164
  492808: 90003760     	adrp	x0, 0xb7e000
  49280c: 911e0001     	add	x1, x0, #0x780
  492810: 52800080     	mov	w0, #0x4                // =4
  492814: 940acf4e     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  492818: 14000051     	b	0x49295c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5c9b0>
  49281c: f9402fe1     	ldr	x1, [sp, #0x58]
  492820: 9100c3e0     	add	x0, sp, #0x30
  492824: 94000a78     	bl	0x495204 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f258>
  492828: 9100c3e0     	add	x0, sp, #0x30
  49282c: 94000aa3     	bl	0x4952b8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f30c>
  492830: 94000a1f     	bl	0x4950ac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f100>
  492834: f90033e0     	str	x0, [sp, #0x60]
  492838: f94033e0     	ldr	x0, [sp, #0x60]
  49283c: f100001f     	cmp	x0, #0x0
  492840: 54000121     	b.ne	0x492864 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5c8b8>
  492844: 90003760     	adrp	x0, 0xb7e000
  492848: 91224003     	add	x3, x0, #0x890
  49284c: 528015a2     	mov	w2, #0xad               // =173
  492850: 90003760     	adrp	x0, 0xb7e000
  492854: 911e0001     	add	x1, x0, #0x780
  492858: 52800080     	mov	w0, #0x4                // =4
  49285c: 940acf3c     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  492860: 1400003d     	b	0x492954 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5c9a8>
  492864: f94033e0     	ldr	x0, [sp, #0x60]
  492868: b9406801     	ldr	w1, [x0, #0x68]
  49286c: f9402fe0     	ldr	x0, [sp, #0x58]
  492870: b9003801     	str	w1, [x0, #0x38]
  492874: f94033e0     	ldr	x0, [sp, #0x60]
  492878: b9406c01     	ldr	w1, [x0, #0x6c]
  49287c: f9402fe0     	ldr	x0, [sp, #0x58]
  492880: b9003c01     	str	w1, [x0, #0x3c]
  492884: f9402fe0     	ldr	x0, [sp, #0x58]
  492888: f94033e1     	ldr	x1, [sp, #0x60]
  49288c: b940c021     	ldr	w1, [x1, #0xc0]
  492890: b9004801     	str	w1, [x0, #0x48]
  492894: f9402fe0     	ldr	x0, [sp, #0x58]
  492898: f94033e1     	ldr	x1, [sp, #0x60]
  49289c: b940e821     	ldr	w1, [x1, #0xe8]
  4928a0: b9004001     	str	w1, [x0, #0x40]
  4928a4: f9402fe0     	ldr	x0, [sp, #0x58]
  4928a8: f94033e1     	ldr	x1, [sp, #0x60]
  4928ac: b940e421     	ldr	w1, [x1, #0xe4]
  4928b0: b9004401     	str	w1, [x0, #0x44]
  4928b4: f94033e0     	ldr	x0, [sp, #0x60]
  4928b8: b9401801     	ldr	w1, [x0, #0x18]
  4928bc: f9402fe0     	ldr	x0, [sp, #0x58]
  4928c0: b9007001     	str	w1, [x0, #0x70]
  4928c4: f9402fe0     	ldr	x0, [sp, #0x58]
  4928c8: b9004c1f     	str	wzr, [x0, #0x4c]
  4928cc: f9402fe0     	ldr	x0, [sp, #0x58]
  4928d0: f94033e1     	ldr	x1, [sp, #0x60]
  4928d4: b940f021     	ldr	w1, [x1, #0xf0]
  4928d8: b9005401     	str	w1, [x0, #0x54]
  4928dc: f9402fe0     	ldr	x0, [sp, #0x58]
  4928e0: f94033e1     	ldr	x1, [sp, #0x60]
  4928e4: b940d821     	ldr	w1, [x1, #0xd8]
  4928e8: b9005801     	str	w1, [x0, #0x58]
  4928ec: f9402fe0     	ldr	x0, [sp, #0x58]
  4928f0: f94033e1     	ldr	x1, [sp, #0x60]
  4928f4: b940d421     	ldr	w1, [x1, #0xd4]
  4928f8: b9005c01     	str	w1, [x0, #0x5c]
  4928fc: f9402fe0     	ldr	x0, [sp, #0x58]
  492900: f94033e1     	ldr	x1, [sp, #0x60]
  492904: b940c421     	ldr	w1, [x1, #0xc4]
  492908: b9006001     	str	w1, [x0, #0x60]
  49290c: f9402fe0     	ldr	x0, [sp, #0x58]
  492910: f94033e1     	ldr	x1, [sp, #0x60]
  492914: b943fc21     	ldr	w1, [x1, #0x3fc]
  492918: b9006801     	str	w1, [x0, #0x68]
  49291c: f9402fe0     	ldr	x0, [sp, #0x58]
  492920: f94033e1     	ldr	x1, [sp, #0x60]
  492924: b9440021     	ldr	w1, [x1, #0x400]
  492928: b9006c01     	str	w1, [x0, #0x6c]
  49292c: f9402fe0     	ldr	x0, [sp, #0x58]
  492930: 52800021     	mov	w1, #0x1                // =1
  492934: 39009001     	strb	w1, [x0, #0x24]
  492938: f9402fe0     	ldr	x0, [sp, #0x58]
  49293c: b9405813     	ldr	w19, [x0, #0x58]
  492940: f94017e0     	ldr	x0, [sp, #0x28]
  492944: f940d800     	ldr	x0, [x0, #0x1b0]
  492948: b98077e1     	ldrsw	x1, [sp, #0x74]
  49294c: 97fff2e9     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  492950: b9001413     	str	w19, [x0, #0x14]
  492954: 9100c3e0     	add	x0, sp, #0x30
  492958: 94000a44     	bl	0x495268 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f2bc>
  49295c: f9402fe0     	ldr	x0, [sp, #0x58]
  492960: 97ffec01     	bl	0x48d964 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x579b8>
  492964: 12001c00     	and	w0, w0, #0xff
  492968: 7100001f     	cmp	w0, #0x0
  49296c: 540001a0     	b.eq	0x4929a0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5c9f4>
  492970: f94017e0     	ldr	x0, [sp, #0x28]
  492974: f943bc03     	ldr	x3, [x0, #0x778]
  492978: f94017e0     	ldr	x0, [sp, #0x28]
  49297c: f943bc00     	ldr	x0, [x0, #0x778]
  492980: f9400000     	ldr	x0, [x0]
  492984: 91012000     	add	x0, x0, #0x48
  492988: f9400002     	ldr	x2, [x0]
  49298c: f9402fe0     	ldr	x0, [sp, #0x58]
  492990: aa0003e1     	mov	x1, x0
  492994: aa0303e0     	mov	x0, x3
  492998: d63f0040     	blr	x2
  49299c: 14000008     	b	0x4929bc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5ca10>
  4929a0: 90003760     	adrp	x0, 0xb7e000
  4929a4: 9122a003     	add	x3, x0, #0x8a8
  4929a8: 52801a42     	mov	w2, #0xd2               // =210
  4929ac: 90003760     	adrp	x0, 0xb7e000
  4929b0: 911e0001     	add	x1, x0, #0x780
  4929b4: 52800040     	mov	w0, #0x2                // =2
  4929b8: 940acee5     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  4929bc: f94017e0     	ldr	x0, [sp, #0x28]
  4929c0: f9419400     	ldr	x0, [x0, #0x328]
  4929c4: 910aa000     	add	x0, x0, #0x2a8
  4929c8: b94077e1     	ldr	w1, [sp, #0x74]
  4929cc: 97fde7ba     	bl	0x40c8b4 <.text+0x1684>
  4929d0: 910143e0     	add	x0, sp, #0x50
  4929d4: 97fdfc88     	bl	0x411bf4 <.text+0x69c4>
  4929d8: f9402fe0     	ldr	x0, [sp, #0x58]
  4929dc: 9410bee3     	bl	0x8c2568 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bd3c>
  4929e0: f94017e0     	ldr	x0, [sp, #0x28]
  4929e4: f942ec00     	ldr	x0, [x0, #0x5d8]
  4929e8: f9402fe1     	ldr	x1, [sp, #0x58]
  4929ec: 9410cbdb     	bl	0x8c5958 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f12c>
  4929f0: 1400000e     	b	0x492a28 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5ca7c>
  4929f4: aa0003f3     	mov	x19, x0
  4929f8: 910103e0     	add	x0, sp, #0x40
  4929fc: 940009e8     	bl	0x49519c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f1f0>
  492a00: 14000006     	b	0x492a18 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5ca6c>
  492a04: aa0003f3     	mov	x19, x0
  492a08: 9100c3e0     	add	x0, sp, #0x30
  492a0c: 94000a17     	bl	0x495268 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f2bc>
  492a10: 14000002     	b	0x492a18 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5ca6c>
  492a14: aa0003f3     	mov	x19, x0
  492a18: 910143e0     	add	x0, sp, #0x50
  492a1c: 97fdfc76     	bl	0x411bf4 <.text+0x69c4>
  492a20: aa1303e0     	mov	x0, x19
  492a24: 97fddf4b     	bl	0x40a750 <_Unwind_Resume@plt>
  492a28: d503201f     	nop
  492a2c: f9400bf3     	ldr	x19, [sp, #0x10]
  492a30: a8c87bfd     	ldp	x29, x30, [sp], #0x80
  492a34: d65f03c0     	ret
  492a38: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  492a3c: 910003fd     	mov	x29, sp
  492a40: f9000fe0     	str	x0, [sp, #0x18]
  492a44: f9000be1     	str	x1, [sp, #0x10]
  492a48: f9400fe0     	ldr	x0, [sp, #0x18]
  492a4c: f943c000     	ldr	x0, [x0, #0x780]
  492a50: 91076000     	add	x0, x0, #0x1d8
  492a54: 94000a7d     	bl	0x495448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f49c>
  492a58: b90033e0     	str	w0, [sp, #0x30]
  492a5c: 3900bfff     	strb	wzr, [sp, #0x2f]
  492a60: 52800020     	mov	w0, #0x1                // =1
  492a64: 3900bbe0     	strb	w0, [sp, #0x2e]
  492a68: f9001fff     	str	xzr, [sp, #0x38]
  492a6c: b90037ff     	str	wzr, [sp, #0x34]
  492a70: b98037e0     	ldrsw	x0, [sp, #0x34]
  492a74: f100141f     	cmp	x0, #0x5
  492a78: 540002a8     	b.hi	0x492acc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cb20>
  492a7c: 90003760     	adrp	x0, 0xb7e000
  492a80: 91234001     	add	x1, x0, #0x8d0
  492a84: b98037e0     	ldrsw	x0, [sp, #0x34]
  492a88: d37df000     	lsl	x0, x0, #3
  492a8c: 8b000020     	add	x0, x1, x0
  492a90: b9400000     	ldr	w0, [x0]
  492a94: b94033e1     	ldr	w1, [sp, #0x30]
  492a98: 6b00003f     	cmp	w1, w0
  492a9c: 54000101     	b.ne	0x492abc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cb10>
  492aa0: b98037e0     	ldrsw	x0, [sp, #0x34]
  492aa4: d37df001     	lsl	x1, x0, #3
  492aa8: 90003760     	adrp	x0, 0xb7e000
  492aac: 91234000     	add	x0, x0, #0x8d0
  492ab0: 8b000020     	add	x0, x1, x0
  492ab4: f9001fe0     	str	x0, [sp, #0x38]
  492ab8: 14000005     	b	0x492acc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cb20>
  492abc: b94037e0     	ldr	w0, [sp, #0x34]
  492ac0: 11000400     	add	w0, w0, #0x1
  492ac4: b90037e0     	str	w0, [sp, #0x34]
  492ac8: 17ffffea     	b	0x492a70 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cac4>
  492acc: f9401fe0     	ldr	x0, [sp, #0x38]
  492ad0: f100001f     	cmp	x0, #0x0
  492ad4: 540001a1     	b.ne	0x492b08 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cb5c>
  492ad8: b94033e0     	ldr	w0, [sp, #0x30]
  492adc: 2a0003e4     	mov	w4, w0
  492ae0: 90003760     	adrp	x0, 0xb7e000
  492ae4: 91240003     	add	x3, x0, #0x900
  492ae8: 52802482     	mov	w2, #0x124              // =292
  492aec: 90003760     	adrp	x0, 0xb7e000
  492af0: 911e0001     	add	x1, x0, #0x780
  492af4: 52800040     	mov	w0, #0x2                // =2
  492af8: 940ace95     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  492afc: 90003760     	adrp	x0, 0xb7e000
  492b00: 91234000     	add	x0, x0, #0x8d0
  492b04: f9001fe0     	str	x0, [sp, #0x38]
  492b08: f9400fe0     	ldr	x0, [sp, #0x18]
  492b0c: f943c000     	ldr	x0, [x0, #0x780]
  492b10: 91076000     	add	x0, x0, #0x1d8
  492b14: 94000a5a     	bl	0x49547c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f4d0>
  492b18: aa0003e1     	mov	x1, x0
  492b1c: f9400be0     	ldr	x0, [sp, #0x10]
  492b20: eb01001f     	cmp	x0, x1
  492b24: 1a9f17e0     	cset	w0, eq
  492b28: 12001c00     	and	w0, w0, #0xff
  492b2c: 7100001f     	cmp	w0, #0x0
  492b30: 540003e0     	b.eq	0x492bac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cc00>
  492b34: f9400fe0     	ldr	x0, [sp, #0x18]
  492b38: 395ea000     	ldrb	w0, [x0, #0x7a8]
  492b3c: 7100001f     	cmp	w0, #0x0
  492b40: 540012c0     	b.eq	0x492d98 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cdec>
  492b44: f9401fe0     	ldr	x0, [sp, #0x38]
  492b48: 39401400     	ldrb	w0, [x0, #0x5]
  492b4c: 7100001f     	cmp	w0, #0x0
  492b50: 540000a0     	b.eq	0x492b64 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cbb8>
  492b54: 52800081     	mov	w1, #0x4                // =4
  492b58: f9400fe0     	ldr	x0, [sp, #0x18]
  492b5c: 9400011e     	bl	0x492fd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d028>
  492b60: 14000004     	b	0x492b70 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cbc4>
  492b64: f9400fe0     	ldr	x0, [sp, #0x18]
  492b68: 52800081     	mov	w1, #0x4                // =4
  492b6c: 97ffe29b     	bl	0x48b5d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5562c>
  492b70: f9401fe0     	ldr	x0, [sp, #0x38]
  492b74: 39401800     	ldrb	w0, [x0, #0x6]
  492b78: 7100001f     	cmp	w0, #0x0
  492b7c: 54000100     	b.eq	0x492b9c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cbf0>
  492b80: 52800203     	mov	w3, #0x10               // =16
  492b84: 52808002     	mov	w2, #0x400              // =1024
  492b88: 90003760     	adrp	x0, 0xb7e000
  492b8c: 91248001     	add	x1, x0, #0x920
  492b90: f9400fe0     	ldr	x0, [sp, #0x18]
  492b94: 94000281     	bl	0x493598 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d5ec>
  492b98: 14000080     	b	0x492d98 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cdec>
  492b9c: 52800201     	mov	w1, #0x10               // =16
  492ba0: f9400fe0     	ldr	x0, [sp, #0x18]
  492ba4: 9400037c     	bl	0x493994 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d9e8>
  492ba8: 1400007c     	b	0x492d98 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cdec>
  492bac: f9400fe0     	ldr	x0, [sp, #0x18]
  492bb0: f943e402     	ldr	x2, [x0, #0x7c8]
  492bb4: f9400fe0     	ldr	x0, [sp, #0x18]
  492bb8: f943e400     	ldr	x0, [x0, #0x7c8]
  492bbc: f9400000     	ldr	x0, [x0]
  492bc0: 91010000     	add	x0, x0, #0x40
  492bc4: f9400001     	ldr	x1, [x0]
  492bc8: aa0203e0     	mov	x0, x2
  492bcc: d63f0020     	blr	x1
  492bd0: 12001c00     	and	w0, w0, #0xff
  492bd4: 7100001f     	cmp	w0, #0x0
  492bd8: 54000520     	b.eq	0x492c7c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5ccd0>
  492bdc: f9400fe0     	ldr	x0, [sp, #0x18]
  492be0: 395f6000     	ldrb	w0, [x0, #0x7d8]
  492be4: 52000000     	eor	w0, w0, #0x1
  492be8: 12001c00     	and	w0, w0, #0xff
  492bec: 7100001f     	cmp	w0, #0x0
  492bf0: 540005e0     	b.eq	0x492cac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cd00>
  492bf4: f9400fe0     	ldr	x0, [sp, #0x18]
  492bf8: 97ffe0bf     	bl	0x48aef4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x54f48>
  492bfc: f9401fe0     	ldr	x0, [sp, #0x38]
  492c00: 39401000     	ldrb	w0, [x0, #0x4]
  492c04: 7100001f     	cmp	w0, #0x0
  492c08: 54000080     	b.eq	0x492c18 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cc6c>
  492c0c: 52800041     	mov	w1, #0x2                // =2
  492c10: f9400fe0     	ldr	x0, [sp, #0x18]
  492c14: 940000c4     	bl	0x492f24 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cf78>
  492c18: f9400fe0     	ldr	x0, [sp, #0x18]
  492c1c: 395ea000     	ldrb	w0, [x0, #0x7a8]
  492c20: 7100001f     	cmp	w0, #0x0
  492c24: 54000240     	b.eq	0x492c6c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5ccc0>
  492c28: f9401fe0     	ldr	x0, [sp, #0x38]
  492c2c: 39401400     	ldrb	w0, [x0, #0x5]
  492c30: 7100001f     	cmp	w0, #0x0
  492c34: 54000080     	b.eq	0x492c44 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cc98>
  492c38: 52800081     	mov	w1, #0x4                // =4
  492c3c: f9400fe0     	ldr	x0, [sp, #0x18]
  492c40: 940000e5     	bl	0x492fd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d028>
  492c44: f9401fe0     	ldr	x0, [sp, #0x38]
  492c48: 39401800     	ldrb	w0, [x0, #0x6]
  492c4c: 7100001f     	cmp	w0, #0x0
  492c50: 540000e0     	b.eq	0x492c6c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5ccc0>
  492c54: 52800203     	mov	w3, #0x10               // =16
  492c58: 52808002     	mov	w2, #0x400              // =1024
  492c5c: 90003760     	adrp	x0, 0xb7e000
  492c60: 91248001     	add	x1, x0, #0x920
  492c64: f9400fe0     	ldr	x0, [sp, #0x18]
  492c68: 9400024c     	bl	0x493598 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d5ec>
  492c6c: f9400fe0     	ldr	x0, [sp, #0x18]
  492c70: 52800021     	mov	w1, #0x1                // =1
  492c74: 391f6001     	strb	w1, [x0, #0x7d8]
  492c78: 1400000d     	b	0x492cac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cd00>
  492c7c: f9400fe0     	ldr	x0, [sp, #0x18]
  492c80: 395f6000     	ldrb	w0, [x0, #0x7d8]
  492c84: 7100001f     	cmp	w0, #0x0
  492c88: 54000120     	b.eq	0x492cac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cd00>
  492c8c: 52800201     	mov	w1, #0x10               // =16
  492c90: f9400fe0     	ldr	x0, [sp, #0x18]
  492c94: 94000340     	bl	0x493994 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d9e8>
  492c98: f9400fe0     	ldr	x0, [sp, #0x18]
  492c9c: 52800041     	mov	w1, #0x2                // =2
  492ca0: 97ffe24e     	bl	0x48b5d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5562c>
  492ca4: f9400fe0     	ldr	x0, [sp, #0x18]
  492ca8: 391f601f     	strb	wzr, [x0, #0x7d8]
  492cac: f9400fe0     	ldr	x0, [sp, #0x18]
