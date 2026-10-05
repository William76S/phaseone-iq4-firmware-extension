#!/usr/bin/env python3
"""Read-only finite User/Capture One collector. Does not load either binary."""
from pathlib import Path
import hashlib, json, plistlib, re, struct, subprocess

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
USER = ROOT / 'analysis/firmware/extracted/P1Linux_6.03.21.bin'
C1 = Path('/Applications/Capture One.app/Contents/Frameworks/P1CaptureCoreObjC.framework/Versions/A/P1CaptureCoreObjC')
USER_SHA = '9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
C1_SHA = 'bfda616e927594f2a316c0d051fdd1c4003bbb4cb5986b15b1abf9965c21a3f2'
OBJDUMP = '/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
NM = '/Library/Developer/CommandLineTools/usr/bin/llvm-nm'
USER_WINDOWS = {
    'Main_Host_consumer': (0x425344, 0x4253d0),
    'IqpStorage_ctor': (0x8ddd54, 0x8ddf0c),
    'IqpStorage_selected_FS': (0x8de084, 0x8de114),
    'IqpStorage_native_task': (0x8de400, 0x8de510),
    'Generic_complete_IIQ_store': (0x8dcf98, 0x8dd534),
    'Iqp_transfer_handler_ctor': (0x85ec00, 0x85ef04),
    'Iqp_transfer_dispatch_enable_capacity': (0x85f2d0, 0x85f51c),
    'Iqp_prepare_outgoing': (0x85f994, 0x85fa6c),
    'Iqp_transfer_FS_open': (0x85fd44, 0x860360),
    'Iqp_transfer_FS_write': (0x860360, 0x860da8),
    'Iqp_transfer_close_front': (0x861098, 0x86116c),
    'Iqp_transfer_FS_close': (0x86116c, 0x861180),
    'Iqp_transfer_close_end_wait': (0x8611ac, 0x86159c),
    'Native_File_checked_close': (0x82580c, 0x82586c),
    'Store_writer_checked_close': (0x7d8a38, 0x7d8a78),
}
C1_WINDOWS = {
    'C1_ImageReceiver': 0x381a88,
    'C1_CaptureImage_Ctor': 0x394bf8,
    'C1_CaptureImage_Finalize': 0x3970b8,
    'C1_CaptureImage_Properties': 0x39733c,
    'C1_CaptureImage_SaveToFile': 0x395e2c,
    'C1_Raw_ReadTiffHeader': 0x3e1e70,
    'C1_ReceiveDataBegin': 0x3c7b24,
    'C1_ReceiveDataEnd': 0x3c8108,
    'C1_DeliverThread': 0x3c57c8,
    'C1_IQPCamera_CallImageReceiver': 0x3ab6e8,
}

def sha(b): return hashlib.sha256(b).hexdigest()
def emit(path, value): path.write_text(json.dumps(value, indent=2, sort_keys=True) + '\n')
def run(argv):
    return subprocess.run(argv, check=True, text=True, capture_output=True).stdout

def elf_getter(b):
    h = struct.unpack_from('<16sHHIQQQIHHHHHH', b)
    assert h[0][:6] == b'\x7fELF\x02\x01' and h[2] == 183
    ph = [struct.unpack_from('<IIQQQQQQ', b, h[5] + i*h[9]) for i in range(h[10])]
    def get(v, n):
        match = [p for p in ph if p[0] == 1 and p[3] <= v and v+n <= p[3]+p[5]]
        assert len(match) == 1
        p = match[0]; off = p[2] + v-p[3]
        return off, b[off:off+n]
    return get

def macho_getter(b):
    assert struct.unpack_from('>II', b) == (0xcafebabe, 2)
    slices = [struct.unpack_from('>IIIII', b, 8+i*20) for i in range(2)]
    a = [x for x in slices if x[0] == 0x0100000c]; assert len(a) == 1
    _, subtype, base, size, align = a[0]
    magic, cpu, sub, filetype, count, cmdbytes, flags, reserved = struct.unpack_from('<IIIIIIII', b, base)
    assert magic == 0xfeedfacf and cpu == 0x0100000c
    cursor = base+32; segments = []
    for _ in range(count):
        cmd, n = struct.unpack_from('<II', b, cursor); assert n >= 8
        if cmd == 0x19:
            name, v, vn, f, fn = struct.unpack_from('<16sQQQQ', b, cursor+8)
            segments.append(dict(name=name.split(b'\0')[0].decode(), va=v, vmsize=vn, slice_offset=f, bytes=fn))
        cursor += n
    assert cursor == base+32+cmdbytes
    def get(v, n):
        match = [p for p in segments if p['va'] <= v and v+n <= p['va']+p['bytes']]
        assert len(match) == 1
        p = match[0]; off = base+p['slice_offset']+v-p['va']
        return off, b[off:off+n]
    return get, dict(slice_file_offset=base, slice_bytes=size, subtype=subtype, segments=segments)

def row(get, label, v, e, asm, symbol=None):
    off, raw = get(v, e-v)
    normalized = '\n'.join(line.rstrip() for line in asm.splitlines() if line.startswith('  ') or line.startswith('__Z'))+'\n'
    (HERE/(label+'.asm')).write_text(normalized)
    return dict(label=label, VA=hex(v), end=hex(e), file_offset=off, bytes=len(raw),
                sha256=sha(raw), hex=raw.hex(), asm=label+'.asm', symbol=symbol)

def blob(get, label, v, n, encoding=None):
    off, raw = get(v, n)
    result = dict(label=label, VA=hex(v), file_offset=off, bytes=n, sha256=sha(raw), hex=raw.hex())
    if encoding: result['text'] = raw.decode(encoding).split('\0')[0]
    return result

def main():
    ub = USER.read_bytes(); cb = C1.read_bytes()
    assert len(ub) == 11874544 and sha(ub) == USER_SHA
    assert len(cb) == 30528080 and sha(cb) == C1_SHA
    ug = elf_getter(ub); cg, cm = macho_getter(cb)
    ur = []
    for label, (v,e) in USER_WINDOWS.items():
        asm = run([OBJDUMP, '-d', f'--start-address={v}', f'--stop-address={e}', str(USER)])
        ur.append(row(ug,label,v,e,asm))
    symbols = []
    for line in run([NM, '--arch=arm64', '--defined-only', '--numeric-sort', str(C1)]).splitlines():
        m = re.fullmatch(r'([0-9a-fA-F]+) [tT] (.+)',line)
        if m: symbols.append((int(m[1],16),m[2]))
    starts = sorted(set(v for v,_ in symbols)); cr = []
    for label,v in C1_WINDOWS.items():
        choices = [s for a,s in symbols if a == v]; assert len(choices) == 1
        sym = choices[0]; e = next(a for a in starts if a > v)
        asm = run([OBJDUMP,'--macho','--arch=arm64','--disassemble','--dis-symname',sym,str(C1)])
        addresses = [int(x,16) for x in re.findall(r'^  ([0-9a-f]+):',asm,re.M)]
        assert addresses and min(addresses) == v and max(addresses) == e-4
        cr.append(row(cg,label,v,e,asm,sym))
    tables = []
    for label,v,n in [('IqpStorage_VT',0xdbb8e0,0x70),('IqpStorage_RTTI_name',0xdbb968,19),
                      ('IqpStorage_name',0x9f5cc0,11),('Host_IIQ_filename',0xdbb8d0,11),
                      ('IqpHandler_VT',0xda37b0,0x168),('IqpFS_VT',0xda3978,0x128)]:
        t=blob(ug,label,v,n,'ascii' if 'name' in label or label.endswith('filename') else None)
        if label.endswith('_VT'):
            t['address_point'] = hex(v+16)
            t['slots'] = {hex(i-16):hex(struct.unpack_from('<Q',bytes.fromhex(t['hex']),i)[0]) for i in range(0,n,8)}
        tables.append(t)
    cdata = [blob(cg,'TetherConnection_property_pair',0x9c5720,16),
             blob(cg,'TetherConnection_property_name',0x79d29c,4*39,'utf-32-le'),
             blob(cg,'IQP_SaveToFile_open_mode',0x87a5ac,12,'utf-32-le')]
    assert int.from_bytes(bytes.fromhex(cdata[0]['hex'])[:4],'little') == 0x012f0008
    assert cdata[1]['text'] == 'kCaptureImageProperty_TetherConnection'
    docs=[]
    for rel in ['analysis/sdk_reference/vendor_downloads/dest/include/P1CameraCamera.hpp',
                'analysis/sdk_reference/vendor_downloads/dest/include/C_P1CameraCommonStructs.h']:
        d=(ROOT/rel).read_bytes(); docs.append(dict(path=rel,bytes=len(d),sha256=sha(d)))
    appinfo=Path('/Applications/Capture One.app/Contents/Info.plist')
    ai=plistlib.loads(appinfo.read_bytes()); assert ai['CFBundleShortVersionString']=='16.7.7.19'
    emit(HERE/'EXACT.json',dict(schema='iq4_native_host_CaptureOne_static_01',
        User=dict(path=str(USER.relative_to(ROOT)),bytes=len(ub),sha256=sha(ub)),
        CaptureOne=dict(path=str(C1),bytes=len(cb),sha256=sha(cb),application_version=ai['CFBundleShortVersionString'],
                        app_info_sha256=sha(appinfo.read_bytes()),arm64=cm),
        user_windows=ur,captureone_windows=cr,user_tables=tables,captureone_data=cdata,SDK_headers=docs,
        firmware_executed=False,CaptureOne_executed=False,SDK_loaded=False,camera_access=False))
    print(json.dumps(dict(User_windows=len(ur),CaptureOne_functions=len(cr),
                         exact_sha256=sha((HERE/'EXACT.json').read_bytes()))))
if __name__ == '__main__': main()
