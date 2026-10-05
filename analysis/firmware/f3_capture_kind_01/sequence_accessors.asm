
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000719d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm>:
  7a1600: b9001fe0     	str	w0, [sp, #0x1c]
  7a1604: b9001be1     	str	w1, [sp, #0x18]
  7a1608: b9401fe0     	ldr	w0, [sp, #0x1c]
  7a160c: 7100041f     	cmp	w0, #0x1
  7a1610: 540013e1     	b.ne	0x7a188c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87b60>
  7a1614: b9401be1     	ldr	w1, [sp, #0x18]
  7a1618: 529fffe0     	mov	w0, #0xffff             // =65535
  7a161c: 6b00003f     	cmp	w1, w0
  7a1620: 54001361     	b.ne	0x7a188c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87b60>
  7a1624: 52800004     	mov	w4, #0x0                // =0
  7a1628: 52800003     	mov	w3, #0x0                // =0
  7a162c: 52800002     	mov	w2, #0x0                // =0
  7a1630: 12800001     	mov	w1, #-0x1               // =-1
  7a1634: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a1638: 9132e000     	add	x0, x0, #0xcb8
  7a163c: 97f1c364     	bl	0x4123cc <.text+0x719c>
  7a1640: 12800004     	mov	w4, #-0x1               // =-1
  7a1644: 12800003     	mov	w3, #-0x1               // =-1
  7a1648: 12800002     	mov	w2, #-0x1               // =-1
  7a164c: 12800001     	mov	w1, #-0x1               // =-1
  7a1650: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a1654: 91330000     	add	x0, x0, #0xcc0
  7a1658: 97f1c35d     	bl	0x4123cc <.text+0x719c>
  7a165c: 52800004     	mov	w4, #0x0                // =0
  7a1660: 52800003     	mov	w3, #0x0                // =0
  7a1664: 12800002     	mov	w2, #-0x1               // =-1
  7a1668: 12800001     	mov	w1, #-0x1               // =-1
  7a166c: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a1670: 91332000     	add	x0, x0, #0xcc8
  7a1674: 97f1c356     	bl	0x4123cc <.text+0x719c>
  7a1678: 12800004     	mov	w4, #-0x1               // =-1
  7a167c: 52800003     	mov	w3, #0x0                // =0
  7a1680: 12800002     	mov	w2, #-0x1               // =-1
  7a1684: 12800001     	mov	w1, #-0x1               // =-1
  7a1688: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a168c: 91334000     	add	x0, x0, #0xcd0
  7a1690: 97f1c34f     	bl	0x4123cc <.text+0x719c>
  7a1694: 12800fe4     	mov	w4, #-0x80              // =-128
  7a1698: 52800003     	mov	w3, #0x0                // =0
  7a169c: 12800fe2     	mov	w2, #-0x80              // =-128
  7a16a0: 12800001     	mov	w1, #-0x1               // =-1
  7a16a4: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a16a8: 91336000     	add	x0, x0, #0xcd8
  7a16ac: 97f1c348     	bl	0x4123cc <.text+0x719c>
  7a16b0: 52800004     	mov	w4, #0x0                // =0
  7a16b4: 12800003     	mov	w3, #-0x1               // =-1
  7a16b8: 52800002     	mov	w2, #0x0                // =0
  7a16bc: 12800001     	mov	w1, #-0x1               // =-1
  7a16c0: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a16c4: 91338000     	add	x0, x0, #0xce0
  7a16c8: 97f1c341     	bl	0x4123cc <.text+0x719c>
  7a16cc: 12800004     	mov	w4, #-0x1               // =-1
  7a16d0: 52800003     	mov	w3, #0x0                // =0
  7a16d4: 52800002     	mov	w2, #0x0                // =0
  7a16d8: 12800001     	mov	w1, #-0x1               // =-1
  7a16dc: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a16e0: 9133a000     	add	x0, x0, #0xce8
  7a16e4: 97f1c33a     	bl	0x4123cc <.text+0x719c>
  7a16e8: 12800004     	mov	w4, #-0x1               // =-1
  7a16ec: 12800003     	mov	w3, #-0x1               // =-1
  7a16f0: 52800002     	mov	w2, #0x0                // =0
  7a16f4: 12800001     	mov	w1, #-0x1               // =-1
  7a16f8: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a16fc: 9133c000     	add	x0, x0, #0xcf0
  7a1700: 97f1c333     	bl	0x4123cc <.text+0x719c>
  7a1704: 12800be4     	mov	w4, #-0x60              // =-96
  7a1708: 12800be3     	mov	w3, #-0x60              // =-96
  7a170c: 52800002     	mov	w2, #0x0                // =0
  7a1710: 12800001     	mov	w1, #-0x1               // =-1
  7a1714: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a1718: 9133e000     	add	x0, x0, #0xcf8
  7a171c: 97f1c32c     	bl	0x4123cc <.text+0x719c>
  7a1720: 52800004     	mov	w4, #0x0                // =0
  7a1724: 12800003     	mov	w3, #-0x1               // =-1
  7a1728: 12800002     	mov	w2, #-0x1               // =-1
  7a172c: 12800001     	mov	w1, #-0x1               // =-1
  7a1730: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a1734: 91340000     	add	x0, x0, #0xd00
  7a1738: 97f1c325     	bl	0x4123cc <.text+0x719c>
  7a173c: 12800fe4     	mov	w4, #-0x80              // =-128
  7a1740: 12800fe3     	mov	w3, #-0x80              // =-128
  7a1744: 12800fe2     	mov	w2, #-0x80              // =-128
  7a1748: 12800001     	mov	w1, #-0x1               // =-1
  7a174c: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a1750: 91342000     	add	x0, x0, #0xd08
  7a1754: 97f1c31e     	bl	0x4123cc <.text+0x719c>
  7a1758: 52800804     	mov	w4, #0x40               // =64
  7a175c: 52800803     	mov	w3, #0x40               // =64
  7a1760: 52800802     	mov	w2, #0x40               // =64
  7a1764: 12800001     	mov	w1, #-0x1               // =-1
  7a1768: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a176c: 91344000     	add	x0, x0, #0xd10
  7a1770: 97f1c317     	bl	0x4123cc <.text+0x719c>
  7a1774: 128009e4     	mov	w4, #-0x50              // =-80
  7a1778: 12800a43     	mov	w3, #-0x53              // =-83
  7a177c: 12800a82     	mov	w2, #-0x55              // =-85
  7a1780: 12800001     	mov	w1, #-0x1               // =-1
  7a1784: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a1788: 91346000     	add	x0, x0, #0xd18
  7a178c: 97f1c310     	bl	0x4123cc <.text+0x719c>
  7a1790: 12800204     	mov	w4, #-0x11              // =-17
  7a1794: 12800a23     	mov	w3, #-0x52              // =-82
  7a1798: 52800002     	mov	w2, #0x0                // =0
  7a179c: 12800001     	mov	w1, #-0x1               // =-1
  7a17a0: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a17a4: 91348000     	add	x0, x0, #0xd20
  7a17a8: 97f1c309     	bl	0x4123cc <.text+0x719c>
  7a17ac: 52800004     	mov	w4, #0x0                // =0
  7a17b0: 12800f03     	mov	w3, #-0x79              // =-121
  7a17b4: 12800002     	mov	w2, #-0x1               // =-1
  7a17b8: 12800001     	mov	w1, #-0x1               // =-1
  7a17bc: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a17c0: 9134a000     	add	x0, x0, #0xd28
  7a17c4: 97f1c302     	bl	0x4123cc <.text+0x719c>
  7a17c8: 52800004     	mov	w4, #0x0                // =0
  7a17cc: 52800003     	mov	w3, #0x0                // =0
  7a17d0: 52800002     	mov	w2, #0x0                // =0
  7a17d4: 52800001     	mov	w1, #0x0                // =0
  7a17d8: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a17dc: 9134c000     	add	x0, x0, #0xd30
  7a17e0: 97f1c2fb     	bl	0x4123cc <.text+0x719c>
  7a17e4: 52800004     	mov	w4, #0x0                // =0
  7a17e8: 52800003     	mov	w3, #0x0                // =0
  7a17ec: 52800002     	mov	w2, #0x0                // =0
  7a17f0: 12800fe1     	mov	w1, #-0x80              // =-128
  7a17f4: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a17f8: 9134e000     	add	x0, x0, #0xd38
  7a17fc: 97f1c2f4     	bl	0x4123cc <.text+0x719c>
  7a1800: 12800004     	mov	w4, #-0x1               // =-1
  7a1804: 12800003     	mov	w3, #-0x1               // =-1
  7a1808: 12800002     	mov	w2, #-0x1               // =-1
  7a180c: 12800fe1     	mov	w1, #-0x80              // =-128
  7a1810: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a1814: 91350000     	add	x0, x0, #0xd40
  7a1818: 97f1c2ed     	bl	0x4123cc <.text+0x719c>
  7a181c: 52800004     	mov	w4, #0x0                // =0
  7a1820: 52800003     	mov	w3, #0x0                // =0
  7a1824: 12800002     	mov	w2, #-0x1               // =-1
  7a1828: 12800fe1     	mov	w1, #-0x80              // =-128
  7a182c: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a1830: 91352000     	add	x0, x0, #0xd48
  7a1834: 97f1c2e6     	bl	0x4123cc <.text+0x719c>
  7a1838: 52800004     	mov	w4, #0x0                // =0
  7a183c: 12800003     	mov	w3, #-0x1               // =-1
  7a1840: 52800002     	mov	w2, #0x0                // =0
  7a1844: 12800fe1     	mov	w1, #-0x80              // =-128
  7a1848: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a184c: 91354000     	add	x0, x0, #0xd50
  7a1850: 97f1c2df     	bl	0x4123cc <.text+0x719c>
  7a1854: 12800004     	mov	w4, #-0x1               // =-1
  7a1858: 52800003     	mov	w3, #0x0                // =0
  7a185c: 52800002     	mov	w2, #0x0                // =0
  7a1860: 12800fe1     	mov	w1, #-0x80              // =-128
  7a1864: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a1868: 91356000     	add	x0, x0, #0xd58
  7a186c: 97f1c2d8     	bl	0x4123cc <.text+0x719c>
  7a1870: 12800fe4     	mov	w4, #-0x80              // =-128
  7a1874: 12800fe3     	mov	w3, #-0x80              // =-128
  7a1878: 12800fe2     	mov	w2, #-0x80              // =-128
  7a187c: 12800fe1     	mov	w1, #-0x80              // =-128
  7a1880: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a1884: 91358000     	add	x0, x0, #0xd60
  7a1888: 97f1c2d1     	bl	0x4123cc <.text+0x719c>
  7a188c: d503201f     	nop
  7a1890: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  7a1894: d65f03c0     	ret
  7a1898: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
  7a189c: 910003fd     	mov	x29, sp
  7a18a0: 529fffe1     	mov	w1, #0xffff             // =65535
  7a18a4: 52800020     	mov	w0, #0x1                // =1
  7a18a8: 97ffff54     	bl	0x7a15f8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x878cc>
  7a18ac: a8c17bfd     	ldp	x29, x30, [sp], #0x10
  7a18b0: d65f03c0     	ret
  7a18b4: d10043ff     	sub	sp, sp, #0x10
  7a18b8: f90007e0     	str	x0, [sp, #0x8]
  7a18bc: f94007e1     	ldr	x1, [sp, #0x8]
  7a18c0: d2844f00     	mov	x0, #0x2278             // =8824
  7a18c4: 8b000020     	add	x0, x1, x0
  7a18c8: 910043ff     	add	sp, sp, #0x10
  7a18cc: d65f03c0     	ret
  7a18d0: d10043ff     	sub	sp, sp, #0x10
  7a18d4: f90007e0     	str	x0, [sp, #0x8]
  7a18d8: f0002e80     	adrp	x0, 0xd74000
  7a18dc: 91358001     	add	x1, x0, #0xd60
  7a18e0: f94007e0     	ldr	x0, [sp, #0x8]
  7a18e4: f9000001     	str	x1, [x0]
  7a18e8: f94007e0     	ldr	x0, [sp, #0x8]
  7a18ec: f0002e81     	adrp	x1, 0xd74000
  7a18f0: 9132a021     	add	x1, x1, #0xca8
  7a18f4: f9000401     	str	x1, [x0, #0x8]
  7a18f8: d503201f     	nop
  7a18fc: 910043ff     	add	sp, sp, #0x10
  7a1900: d65f03c0     	ret
  7a1904: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
  7a1908: 910003fd     	mov	x29, sp
  7a190c: f90027e0     	str	x0, [sp, #0x48]
  7a1910: f90023e1     	str	x1, [sp, #0x40]
  7a1914: f9001fe2     	str	x2, [sp, #0x38]
  7a1918: f9001be3     	str	x3, [sp, #0x30]
  7a191c: f90017e4     	str	x4, [sp, #0x28]
  7a1920: f90013e5     	str	x5, [sp, #0x20]
  7a1924: f9000fe6     	str	x6, [sp, #0x18]
  7a1928: f9000be7     	str	x7, [sp, #0x10]
  7a192c: f94027e0     	ldr	x0, [sp, #0x48]
  7a1930: 97ffffe8     	bl	0x7a18d0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87ba4>
  7a1934: f0002e80     	adrp	x0, 0xd74000
  7a1938: 913f8001     	add	x1, x0, #0xfe0
  7a193c: f94027e0     	ldr	x0, [sp, #0x48]
  7a1940: f9000001     	str	x1, [x0]
  7a1944: f94027e0     	ldr	x0, [sp, #0x48]
  7a1948: f94023e1     	ldr	x1, [sp, #0x40]
  7a194c: f9000801     	str	x1, [x0, #0x10]
  7a1950: f94027e0     	ldr	x0, [sp, #0x48]
  7a1954: f94017e1     	ldr	x1, [sp, #0x28]
  7a1958: f9000c01     	str	x1, [x0, #0x18]
  7a195c: f94027e0     	ldr	x0, [sp, #0x48]
  7a1960: f9401fe1     	ldr	x1, [sp, #0x38]
  7a1964: f9001001     	str	x1, [x0, #0x20]
  7a1968: f94027e0     	ldr	x0, [sp, #0x48]
  7a196c: f9401be1     	ldr	x1, [sp, #0x30]
  7a1970: f9001401     	str	x1, [x0, #0x28]
  7a1974: f94027e0     	ldr	x0, [sp, #0x48]
  7a1978: f94013e1     	ldr	x1, [sp, #0x20]
  7a197c: f9001801     	str	x1, [x0, #0x30]
  7a1980: f94027e0     	ldr	x0, [sp, #0x48]
  7a1984: f9400fe1     	ldr	x1, [sp, #0x18]
  7a1988: f9001c01     	str	x1, [x0, #0x38]
  7a198c: f94027e0     	ldr	x0, [sp, #0x48]
  7a1990: f9402be1     	ldr	x1, [sp, #0x50]
  7a1994: f9002001     	str	x1, [x0, #0x40]
  7a1998: f94027e0     	ldr	x0, [sp, #0x48]
  7a199c: f9400be1     	ldr	x1, [sp, #0x10]
  7a19a0: f9002401     	str	x1, [x0, #0x48]
  7a19a4: f94027e0     	ldr	x0, [sp, #0x48]
  7a19a8: f9402fe1     	ldr	x1, [sp, #0x58]
  7a19ac: f9002801     	str	x1, [x0, #0x50]
  7a19b0: f94027e0     	ldr	x0, [sp, #0x48]
  7a19b4: b900581f     	str	wzr, [x0, #0x58]
  7a19b8: f94027e0     	ldr	x0, [sp, #0x48]
  7a19bc: b9005c1f     	str	wzr, [x0, #0x5c]
  7a19c0: f94027e0     	ldr	x0, [sp, #0x48]
  7a19c4: b900601f     	str	wzr, [x0, #0x60]
  7a19c8: f94027e0     	ldr	x0, [sp, #0x48]
  7a19cc: b900641f     	str	wzr, [x0, #0x64]
  7a19d0: f94027e0     	ldr	x0, [sp, #0x48]
  7a19d4: 3901a01f     	strb	wzr, [x0, #0x68]
  7a19d8: f0002e80     	adrp	x0, 0xd74000
  7a19dc: 91386000     	add	x0, x0, #0xe18
  7a19e0: 94000270     	bl	0x7a23a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x88674>
  7a19e4: 2a0003e1     	mov	w1, w0
  7a19e8: f94027e0     	ldr	x0, [sp, #0x48]
  7a19ec: b9007c01     	str	w1, [x0, #0x7c]
  7a19f0: f94027e0     	ldr	x0, [sp, #0x48]
  7a19f4: f0002e81     	adrp	x1, 0xd74000
  7a19f8: 913c0021     	add	x1, x1, #0xf00
  7a19fc: f9000401     	str	x1, [x0, #0x8]
