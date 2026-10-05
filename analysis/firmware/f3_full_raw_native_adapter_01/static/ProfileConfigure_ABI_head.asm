  961208: a9ae7bfd     	stp	x29, x30, [sp, #-0x120]!
  96120c: 910003fd     	mov	x29, sp
  961210: a90153f3     	stp	x19, x20, [sp, #0x10]
  961214: aa0103f4     	mov	x20, x1
  961218: 2a0203f3     	mov	w19, w2
  96121c: a9025bf5     	stp	x21, x22, [sp, #0x20]
  961220: aa0003f5     	mov	x21, x0
  961224: a90363f7     	stp	x23, x24, [sp, #0x30]
  961228: a9046bf9     	stp	x25, x26, [sp, #0x40]
  96122c: f9002bfb     	str	x27, [sp, #0x50]
  961230: fd002fea     	str	d10, [sp, #0x58]
  961234: 6d0627e8     	stp	d8, d9, [sp, #0x60]
  961238: 97ffc190     	bl	0x951878
  96123c: aa1403e1     	mov	x1, x20
  961240: aa1503e0     	mov	x0, x21
  961244: 97fffd55     	bl	0x960798
  961248: f9004bff     	str	xzr, [sp, #0x90]
  96124c: a909ffff     	stp	xzr, xzr, [sp, #0x98]
  961250: 35002913     	cbnz	w19, 0x961770
  961254: f940d6a1     	ldr	x1, [x21, #0x1a8]
  961258: aa0103e0     	mov	x0, x1
  96125c: f9400021     	ldr	x1, [x1]
  961260: f9401821     	ldr	x1, [x1, #0x30]
  961264: d63f0020     	blr	x1
  961268: 2a0003f3     	mov	w19, w0
  96126c: f9402aa0     	ldr	x0, [x21, #0x50]
  961270: 910122a3     	add	x3, x21, #0x48
  961274: aa0303e2     	mov	x2, x3
  961278: b9402297     	ldr	w23, [x20, #0x20]
  96127c: b9415296     	ldr	w22, [x20, #0x150]
  961280: b40002a0     	cbz	x0, 0x9612d4
  961284: d503201f     	nop
