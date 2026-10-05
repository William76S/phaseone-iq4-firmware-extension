
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000004f90b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv>:
  5378e0: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  5378e4: 910003fd     	mov	x29, sp
  5378e8: f90017e0     	str	x0, [sp, #0x28]
  5378ec: f90013e1     	str	x1, [sp, #0x20]
  5378f0: f9000fe2     	str	x2, [sp, #0x18]
  5378f4: b90017e3     	str	w3, [sp, #0x14]
  5378f8: f94017e0     	ldr	x0, [sp, #0x28]
  5378fc: f941c002     	ldr	x2, [x0, #0x380]
  537900: f94017e0     	ldr	x0, [sp, #0x28]
  537904: f941c000     	ldr	x0, [x0, #0x380]
  537908: f9400000     	ldr	x0, [x0]
  53790c: 91010000     	add	x0, x0, #0x40
  537910: f9400001     	ldr	x1, [x0]
  537914: aa0203e0     	mov	x0, x2
  537918: d63f0020     	blr	x1
  53791c: 12001c00     	and	w0, w0, #0xff
  537920: 7100001f     	cmp	w0, #0x0
  537924: 54000d81     	b.ne	0x537ad4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x3ea24>
  537928: b94017e0     	ldr	w0, [sp, #0x14]
  53792c: 7100041f     	cmp	w0, #0x1
  537930: 54000660     	b.eq	0x5379fc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x3e94c>
  537934: b94017e0     	ldr	w0, [sp, #0x14]
  537938: 7100001f     	cmp	w0, #0x0
  53793c: 54000100     	b.eq	0x53795c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x3e8ac>
  537940: b94017e0     	ldr	w0, [sp, #0x14]
  537944: 7100081f     	cmp	w0, #0x2
  537948: 540008e0     	b.eq	0x537a64 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x3e9b4>
  53794c: b94017e0     	ldr	w0, [sp, #0x14]
  537950: 71000c1f     	cmp	w0, #0x3
  537954: 54000a40     	b.eq	0x537a9c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x3e9ec>
