"""Synthetic IIQ-shaped source-boundary fixture; not a decodable RAW image."""
import struct
from pathlib import Path

def create(path: Path, big=False, tiff=False, profile=True, custom_profile=False):
    order = '>' if big else '<'
    base = 8 if tiff else 0
    raw_offset = 2048
    raw = bytes((i * 37 + 11) % 256 for i in range(96))
    wb_offset, rows_offset = 2144, 2156
    black_row_offset, black_col_offset, cal_offset = 2180, 2204, 2236
    fields = [(0x103,31),(0x105,100),(0x20b,0),(0x20c,2),(0x245,0x3f800000),
              (0x21e,1),(0x222,8),(0x21d,1024),(0x108,8),(0x109,6),(0x10a,1),
              (0x10b,1),(0x10c,6),(0x10d,4),(0x10e,8)]
    entries = [(tag,4,4,value) for tag,value in fields] + [
        (0x10f,2,96,raw_offset),(0x107,4,12,wb_offset),(0x21c,4,24,rows_offset),
        (0x25a,2,24,black_row_offset),(0x26a,2,32,black_col_offset),(0x110,1,16,cal_offset)]
    if profile:
        entries.append((0x548,1,8,2252))
    data = bytearray(4096)
    data[base:base+12] = (b'MMMM' if big else b'IIII') + struct.pack(order+'II',0x52617743,32)
    directory = base + 32
    data[directory:directory+8] = struct.pack(order+'II',len(entries),0)
    for i,row in enumerate(entries):
        data[directory+8+i*16:directory+24+i*16] = struct.pack(order+'IIII',*row)
    data[base+raw_offset:base+raw_offset+96] = raw
    data[base+wb_offset:base+wb_offset+12] = struct.pack(order+'III',0x3f800000,0x40000000,0x3f000000)
    data[base+rows_offset:base+rows_offset+24] = struct.pack(order+'6I',*range(0,96,16))
    data[base+black_row_offset:base+black_row_offset+24] = struct.pack(order+'12H',*range(12))
    data[base+black_col_offset:base+black_col_offset+32] = struct.pack(order+'16H',*range(16))
    data[base+cal_offset:base+cal_offset+16] = b'CALIBRATIONTEST!'
    data[base+2252:base+2260] = b'PROFILE!' if custom_profile else b'\0' * 8
    if tiff:
        data[:8] = (b'MM' if big else b'II') + struct.pack(order+'HI',42,3072)
        data[3072:3090] = struct.pack(order+'HHHIII',1,0x8769,4,1,3100,0)
        data[3100:3118] = struct.pack(order+'HHHIII',1,0x927c,7,1,8,0)
        # MakerNote byte count must cover the directory and every IIQ section.
        struct.pack_into(order+'I',data,3106,3000)
    path.write_bytes(data)

if __name__ == '__main__':
    import sys
    out=Path(sys.argv[1]); out.mkdir(parents=True,exist_ok=True)
    for name,big,tiff in [('little.iiq',False,False),('big.iiq',True,False),('tiff.iiq',False,True)]:
        create(out/name,big,tiff)
    create(out/'no-profile.iiq',profile=False)
    create(out/'custom-profile.iiq',custom_profile=True)
    data=(out/'little.iiq').read_bytes()
    def variant(name,offset,value):
        changed=bytearray(data);struct.pack_into('<I',changed,offset,value);(out/name).write_bytes(changed)
    variant('duplicate.iiq',40+16,0x103)
    variant('raw-outside.iiq',40+15*16+12,0xfffffffe)
    variant('crop-outside.iiq',40+10*16+12,8)
    variant('unknown-format.iiq',40+14*16+12,0)
    variant('multi-directory.iiq',36,32)
    (out/'truncated.iiq').write_bytes(data[:40])
