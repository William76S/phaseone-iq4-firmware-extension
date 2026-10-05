
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

000000000040b230 <.text>:
  422700: f9430fe0     	ldr	x0, [sp, #0x618]
  422704: 94003572     	bl	0x42fccc <.text+0x24a9c>
  422708: aa0003e2     	mov	x2, x0
  42270c: 52800181     	mov	w1, #0xc                // =12
  422710: f949a7e0     	ldr	x0, [sp, #0x1348]
  422714: 940d9cde     	bl	0x789a8c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x6fd60>
  422718: f9430fe0     	ldr	x0, [sp, #0x618]
  42271c: 94003573     	bl	0x42fce8 <.text+0x24ab8>
  422720: aa0003e2     	mov	x2, x0
  422724: 528001a1     	mov	w1, #0xd                // =13
  422728: f949a7e0     	ldr	x0, [sp, #0x1348]
  42272c: 940d9cd8     	bl	0x789a8c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x6fd60>
  422730: f94c07e0     	ldr	x0, [sp, #0x1808]
  422734: 910b8000     	add	x0, x0, #0x2e0
  422738: aa0003e2     	mov	x2, x0
  42273c: 52800141     	mov	w1, #0xa                // =10
  422740: f949a7e0     	ldr	x0, [sp, #0x1348]
  422744: 940d9cd2     	bl	0x789a8c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x6fd60>
  422748: f94c07e0     	ldr	x0, [sp, #0x1808]
  42274c: 91256000     	add	x0, x0, #0x958
  422750: 52800041     	mov	w1, #0x2                // =2
  422754: 94002e77     	bl	0x42e130 <.text+0x22f00>
  422758: d2800400     	mov	x0, #0x20               // =32
  42275c: 97ff9dc1     	bl	0x409e60 <_Znwm@plt>
  422760: aa0003f3     	mov	x19, x0
  422764: f0001b20     	adrp	x0, 0x789000 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x6f2d4>
  422768: 911ca000     	add	x0, x0, #0x728
  42276c: f9019be0     	str	x0, [sp, #0x330]
  422770: f9019fff     	str	xzr, [sp, #0x338]
  422774: 911003e0     	add	x0, sp, #0x400
  422778: a9730c02     	ldp	x2, x3, [x0, #-0xd0]
  42277c: f949a7e1     	ldr	x1, [sp, #0x1348]
  422780: aa1303e0     	mov	x0, x19
  422784: 9400416c     	bl	0x432d34 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE6lengthEv+0x15ec>
  422788: f909a3f3     	str	x19, [sp, #0x1340]
  42278c: 52800020     	mov	w0, #0x1                // =1
  422790: 914007e1     	add	x1, sp, #0x1, lsl #12   // =0x1000
  422794: 91014021     	add	x1, x1, #0x50
  422798: 390bbc20     	strb	w0, [x1, #0x2ef]
  42279c: d2803700     	mov	x0, #0x1b8              // =440
  4227a0: 97ff9db0     	bl	0x409e60 <_Znwm@plt>
  4227a4: aa0003f3     	mov	x19, x0
  4227a8: f949a3e0     	ldr	x0, [sp, #0x1340]
  4227ac: 528000a4     	mov	w4, #0x5                // =5
  4227b0: 52800023     	mov	w3, #0x1                // =1
  4227b4: aa0003e2     	mov	x2, x0
  4227b8: f0002e80     	adrp	x0, 0x9f5000
  4227bc: 911c6001     	add	x1, x0, #0x718
  4227c0: aa1303e0     	mov	x0, x19
  4227c4: 97ffcbb1     	bl	0x415688 <.text+0xa458>
  4227c8: f9099bf3     	str	x19, [sp, #0x1330]
  4227cc: f9499be0     	ldr	x0, [sp, #0x1330]
  4227d0: 97ffbcea     	bl	0x411b78 <.text+0x6948>
  4227d4: f949a7e0     	ldr	x0, [sp, #0x1348]
  4227d8: 940d9cbd     	bl	0x789acc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x6fda0>
  4227dc: f9430fe0     	ldr	x0, [sp, #0x618]
  4227e0: 97ffbce6     	bl	0x411b78 <.text+0x6948>
  4227e4: f94307e0     	ldr	x0, [sp, #0x608]
  4227e8: aa0003e1     	mov	x1, x0
  4227ec: f94a3be0     	ldr	x0, [sp, #0x1470]
  4227f0: 94003b73     	bl	0x4315bc <.text+0x2638c>
  4227f4: f94237e0     	ldr	x0, [sp, #0x468]
  4227f8: f9400000     	ldr	x0, [x0]
  4227fc: 9102e000     	add	x0, x0, #0xb8
  422800: f9400013     	ldr	x19, [x0]
  422804: d2800f00     	mov	x0, #0x78               // =120
  422808: 97ff9d96     	bl	0x409e60 <_Znwm@plt>
  42280c: aa0003f4     	mov	x20, x0
  422810: f9430fe1     	ldr	x1, [sp, #0x618]
  422814: f94f47e0     	ldr	x0, [sp, #0x1e88]
  422818: 91002002     	add	x2, x0, #0x8
  42281c: f94bfbe0     	ldr	x0, [sp, #0x17f0]
  422820: f9400003     	ldr	x3, [x0]
  422824: f94bfbe0     	ldr	x0, [sp, #0x17f0]
  422828: f9400400     	ldr	x0, [x0, #0x8]
  42282c: f94f93e4     	ldr	x4, [sp, #0x1f20]
  422830: f94a83e7     	ldr	x7, [sp, #0x1500]
  422834: aa0403e6     	mov	x6, x4
  422838: aa0003e5     	mov	x5, x0
  42283c: aa0303e4     	mov	x4, x3
  422840: aa0203e3     	mov	x3, x2
  422844: f94eabe2     	ldr	x2, [sp, #0x1d50]
  422848: aa1403e0     	mov	x0, x20
  42284c: 9410427e     	bl	0x833244 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7727c>
  422850: aa1403e1     	mov	x1, x20
  422854: f94237e0     	ldr	x0, [sp, #0x468]
  422858: d63f0260     	blr	x19
  42285c: f9430be0     	ldr	x0, [sp, #0x610]
  422860: 940037c0     	bl	0x430760 <.text+0x25530>
  422864: aa0003f4     	mov	x20, x0
  422868: d2800700     	mov	x0, #0x38               // =56
  42286c: 97ff9d7d     	bl	0x409e60 <_Znwm@plt>
  422870: aa0003f3     	mov	x19, x0
  422874: f9430fe1     	ldr	x1, [sp, #0x618]
  422878: f94e47e0     	ldr	x0, [sp, #0x1c88]
  42287c: 9125c000     	add	x0, x0, #0x970
  422880: aa0003e4     	mov	x4, x0
  422884: f94a7be3     	ldr	x3, [sp, #0x14f0]
  422888: aa1403e2     	mov	x2, x20
  42288c: aa1303e0     	mov	x0, x19
  422890: 940dfabc     	bl	0x7a1380 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87654>
  422894: f90997f3     	str	x19, [sp, #0x1328]
  422898: f9430be0     	ldr	x0, [sp, #0x610]
  42289c: 940037b1     	bl	0x430760 <.text+0x25530>
  4228a0: aa0003f4     	mov	x20, x0
  4228a4: d2801000     	mov	x0, #0x80               // =128
  4228a8: 97ff9d6e     	bl	0x409e60 <_Znwm@plt>
  4228ac: aa0003f3     	mov	x19, x0
  4228b0: f9430fe8     	ldr	x8, [sp, #0x618]
  4228b4: f94e47e0     	ldr	x0, [sp, #0x1c88]
  4228b8: 9103a002     	add	x2, x0, #0xe8
  4228bc: f94e47e0     	ldr	x0, [sp, #0x1c88]
  4228c0: 912cc003     	add	x3, x0, #0xb30
  4228c4: f94e47e0     	ldr	x0, [sp, #0x1c88]
  4228c8: 91304004     	add	x4, x0, #0xc10
  4228cc: f94e47e0     	ldr	x0, [sp, #0x1c88]
  4228d0: 9133c005     	add	x5, x0, #0xcf0
  4228d4: f94e47e0     	ldr	x0, [sp, #0x1c88]
  4228d8: 91372000     	add	x0, x0, #0xdc8
  4228dc: f94e47e1     	ldr	x1, [sp, #0x1c88]
  4228e0: 91180021     	add	x1, x1, #0x600
  4228e4: f90007e1     	str	x1, [sp, #0x8]
  4228e8: f90003e0     	str	x0, [sp]
  4228ec: aa0503e7     	mov	x7, x5
  4228f0: aa0403e6     	mov	x6, x4
  4228f4: aa0303e5     	mov	x5, x3
  4228f8: f94a7be4     	ldr	x4, [sp, #0x14f0]
  4228fc: aa0203e3     	mov	x3, x2
  422900: aa1403e2     	mov	x2, x20
  422904: aa0803e1     	mov	x1, x8
  422908: aa1303e0     	mov	x0, x19
  42290c: 940dfbfe     	bl	0x7a1904 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87bd8>
  422910: f90993f3     	str	x19, [sp, #0x1320]
  422914: f9430be0     	ldr	x0, [sp, #0x610]
  422918: 94003792     	bl	0x430760 <.text+0x25530>
  42291c: aa0003f4     	mov	x20, x0
  422920: d2800c00     	mov	x0, #0x60               // =96
  422924: 97ff9d4f     	bl	0x409e60 <_Znwm@plt>
  422928: aa0003f3     	mov	x19, x0
  42292c: f9430fe8     	ldr	x8, [sp, #0x618]
  422930: f94e47e0     	ldr	x0, [sp, #0x1c88]
  422934: 913aa002     	add	x2, x0, #0xea8
  422938: f94e47e0     	ldr	x0, [sp, #0x1c88]
  42293c: 913e2003     	add	x3, x0, #0xf88
  422940: f94e47e1     	ldr	x1, [sp, #0x1c88]
  422944: d2820d00     	mov	x0, #0x1068             // =4200
  422948: 8b000020     	add	x0, x1, x0
  42294c: aa0003e7     	mov	x7, x0
  422950: aa0303e6     	mov	x6, x3
  422954: aa0203e5     	mov	x5, x2
  422958: f94e5be4     	ldr	x4, [sp, #0x1cb0]
  42295c: f94a7be3     	ldr	x3, [sp, #0x14f0]
  422960: aa1403e2     	mov	x2, x20
  422964: aa0803e1     	mov	x1, x8
  422968: aa1303e0     	mov	x0, x19
  42296c: 940dfe93     	bl	0x7a23b8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8868c>
  422970: f9098ff3     	str	x19, [sp, #0x1318]
  422974: d2800300     	mov	x0, #0x18               // =24
  422978: 97ff9d3a     	bl	0x409e60 <_Znwm@plt>
  42297c: aa0003f3     	mov	x19, x0
  422980: aa1303e0     	mov	x0, x19
  422984: 94003b57     	bl	0x4316e0 <.text+0x264b0>
  422988: f9098bf3     	str	x19, [sp, #0x1310]
  42298c: 12800000     	mov	w0, #-0x1               // =-1
  422990: b90a1be0     	str	w0, [sp, #0xa18]
  422994: f94997e0     	ldr	x0, [sp, #0x1328]
  422998: f90513e0     	str	x0, [sp, #0xa20]
  42299c: 912863e0     	add	x0, sp, #0xa18
  4229a0: aa0003e1     	mov	x1, x0
  4229a4: f9498be0     	ldr	x0, [sp, #0x1310]
  4229a8: 94004106     	bl	0x432dc0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE6lengthEv+0x1678>
  4229ac: 52800080     	mov	w0, #0x4                // =4
  4229b0: b90a2be0     	str	w0, [sp, #0xa28]
  4229b4: f94993e0     	ldr	x0, [sp, #0x1320]
  4229b8: f9051be0     	str	x0, [sp, #0xa30]
  4229bc: 9128a3e0     	add	x0, sp, #0xa28
  4229c0: aa0003e1     	mov	x1, x0
  4229c4: f9498be0     	ldr	x0, [sp, #0x1310]
  4229c8: 940040fe     	bl	0x432dc0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE6lengthEv+0x1678>
  4229cc: 528000a0     	mov	w0, #0x5                // =5
  4229d0: b90a3be0     	str	w0, [sp, #0xa38]
  4229d4: f9498fe0     	ldr	x0, [sp, #0x1318]
  4229d8: f90523e0     	str	x0, [sp, #0xa40]
  4229dc: 9128e3e0     	add	x0, sp, #0xa38
  4229e0: aa0003e1     	mov	x1, x0
  4229e4: f9498be0     	ldr	x0, [sp, #0x1310]
  4229e8: 940040f6     	bl	0x432dc0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE6lengthEv+0x1678>
  4229ec: f94eabe0     	ldr	x0, [sp, #0x1d50]
  4229f0: 94002e62     	bl	0x42e378 <.text+0x23148>
  4229f4: 12001c00     	and	w0, w0, #0xff
  4229f8: 7100001f     	cmp	w0, #0x0
  4229fc: 54000360     	b.eq	0x422a68 <.text+0x17838>
  422a00: f9430be0     	ldr	x0, [sp, #0x610]
  422a04: 94003757     	bl	0x430760 <.text+0x25530>
  422a08: aa0003f4     	mov	x20, x0
  422a0c: d2801600     	mov	x0, #0xb0               // =176
  422a10: 97ff9d14     	bl	0x409e60 <_Znwm@plt>
  422a14: aa0003f3     	mov	x19, x0
  422a18: f9430fe0     	ldr	x0, [sp, #0x618]
  422a1c: f9437be1     	ldr	x1, [sp, #0x6f0]
  422a20: f94a83e7     	ldr	x7, [sp, #0x1500]
  422a24: f94eabe6     	ldr	x6, [sp, #0x1d50]
  422a28: f94e4fe5     	ldr	x5, [sp, #0x1c98]
  422a2c: aa0103e4     	mov	x4, x1
  422a30: f94a7be3     	ldr	x3, [sp, #0x14f0]
  422a34: aa1403e2     	mov	x2, x20
  422a38: aa0003e1     	mov	x1, x0
  422a3c: aa1303e0     	mov	x0, x19
  422a40: 940e00eb     	bl	0x7a2dec <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x890c0>
  422a44: f90987f3     	str	x19, [sp, #0x1308]
  422a48: 528000e0     	mov	w0, #0x7                // =7
  422a4c: b90a4be0     	str	w0, [sp, #0xa48]
  422a50: f94987e0     	ldr	x0, [sp, #0x1308]
  422a54: f9052be0     	str	x0, [sp, #0xa50]
  422a58: 912923e0     	add	x0, sp, #0xa48
  422a5c: aa0003e1     	mov	x1, x0
  422a60: f9498be0     	ldr	x0, [sp, #0x1310]
  422a64: 940040d7     	bl	0x432dc0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE6lengthEv+0x1678>
  422a68: d2801700     	mov	x0, #0xb8               // =184
  422a6c: 97ff9cfd     	bl	0x409e60 <_Znwm@plt>
  422a70: aa0003f3     	mov	x19, x0
  422a74: f0002e80     	adrp	x0, 0x9f5000
  422a78: 911cc001     	add	x1, x0, #0x730
  422a7c: aa1303e0     	mov	x0, x19
  422a80: 940bb1ab     	bl	0x70f12c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x210ac>
  422a84: f90983f3     	str	x19, [sp, #0x1300]
  422a88: f9430fe0     	ldr	x0, [sp, #0x618]
  422a8c: 94003437     	bl	0x42fb68 <.text+0x24938>
  422a90: aa0003f4     	mov	x20, x0
  422a94: f9430fe0     	ldr	x0, [sp, #0x618]
  422a98: 9400342e     	bl	0x42fb50 <.text+0x24920>
  422a9c: aa0003f5     	mov	x21, x0
  422aa0: f9430fe0     	ldr	x0, [sp, #0x618]
  422aa4: 9400341f     	bl	0x42fb20 <.text+0x248f0>
  422aa8: aa0003f6     	mov	x22, x0
  422aac: f9430fe0     	ldr	x0, [sp, #0x618]
  422ab0: 94003464     	bl	0x42fc40 <.text+0x24a10>
  422ab4: aa0003f7     	mov	x23, x0
  422ab8: d2800900     	mov	x0, #0x48               // =72
  422abc: 97ff9ce9     	bl	0x409e60 <_Znwm@plt>
  422ac0: aa0003f3     	mov	x19, x0
  422ac4: f94e53e0     	ldr	x0, [sp, #0x1ca0]
  422ac8: 91070000     	add	x0, x0, #0x1c0
  422acc: aa0003e7     	mov	x7, x0
  422ad0: f94983e6     	ldr	x6, [sp, #0x1300]
  422ad4: aa1703e5     	mov	x5, x23
  422ad8: aa1603e4     	mov	x4, x22
  422adc: aa1503e3     	mov	x3, x21
  422ae0: aa1403e2     	mov	x2, x20
  422ae4: f94f5be1     	ldr	x1, [sp, #0x1eb0]
  422ae8: aa1303e0     	mov	x0, x19
  422aec: 940da974     	bl	0x78d0bc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x73390>
  422af0: d2800300     	mov	x0, #0x18               // =24
  422af4: 97ff9cdb     	bl	0x409e60 <_Znwm@plt>
  422af8: aa0003f3     	mov	x19, x0
  422afc: f943afe0     	ldr	x0, [sp, #0x758]
