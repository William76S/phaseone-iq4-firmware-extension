#!/usr/bin/env python3
"""Read-only exact-original collector. Never executes vendor code or connects a device."""
import argparse, hashlib, json, struct, subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
USER = ROOT / 'analysis/firmware/extracted/P1Linux_6.03.21.bin'
EXPECTED = '9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
OBJ = '/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
WINDOWS = {
    'ifm_file_flags_and_stored_event': (0x496784, 0x4968f8),
    'node_manager_file_flag_bridge': (0x8c5d98, 0x8c5de8),
    'jpeg_worker': (0x8e0b18, 0x8e1180),
    'jpeg_preflight': (0x8e1180, 0x8e12f0),
    'jpeg_4k_task': (0x8e17c8, 0x8e1d70),
    'jpeg_encode_write': (0x8e1d70, 0x8e1f7c),
    'jpeg_choose_file': (0x8e1f7c, 0x8e22d4),
    'jpeg_pending_helpers': (0x8e2590, 0x8e264c),
    'pending_add': (0x498994, 0x498a40),
    'file_object_wrappers': (0x825770, 0x825940),
    'linux_file_open': (0x825ed4, 0x826010),
    'linux_file_close': (0x826ca8, 0x826d6c),
    'linux_file_read_write': (0x826d6c, 0x826ea4),
    'linux_file_sync': (0x82721c, 0x82728c),
    'raw_storage_worker': (0x8dcc7c, 0x8dcef8),
    'storage_completion_callback': (0x8dbf58, 0x8dc13c),
    'storage_completion_dispatch': (0x8db480, 0x8db510),
    'storage_save_contents': (0x8dcf98, 0x8dd524),
    'xqd_save_contents': (0x8df1a0, 0x8df9c0),
    'raw_file_finalization': (0x7d8a38, 0x7d8a78),
    'sd_save_dispatch': (0x8e00c0, 0x8e0144),
    'sd_save_contents': (0x8e0144, 0x8e06bc),
    'filesystem_factory': (0x74e454, 0x74e688),
    'jpeg_model_constructor': (0x5e36c0, 0x5e3850),
    'jpeg_main_binding': (0x424b80, 0x424bd4),
}
CALL_TARGETS = [0x8c5d98, 0x496784, 0x8dcf98, 0x8df468,
                0x8e1d70, 0x8e17c8, 0x498994, 0x4989c0]
TABLES = {'linux_fs_vtable': (0xd91450, 0x130), 'fs_registry': (0xf55cb8, 19*32)}
def sha(b): return hashlib.sha256(b).hexdigest()

def main():
    p = argparse.ArgumentParser(); p.add_argument('--output', type=Path,
        default=ROOT/'analysis/firmware/f3_save_transaction_static_01'); a=p.parse_args()
    data=USER.read_bytes()
    if len(data)!=11874544 or sha(data)!=EXPECTED: raise ValueError('exact original User mismatch')
    h=struct.unpack_from('<16sHHIQQQIHHHHHH',data)
    if h[0][:6]!=b'\x7fELF\x02\x01' or h[2]!=183: raise ValueError('ELF format')
    loads=[]
    for i in range(h[10]):
        t,flags,off,va,pa,fs,ms,al=struct.unpack_from('<IIQQQQQQ',data,h[5]+i*h[9])
        if t==1: loads.append((va,fs,off,flags))
    def get(va,n):
        for v,fs,o,fl in loads:
            if va>=v and va+n<=v+fs:return o+va-v,data[o+va-v:o+va-v+n]
        raise ValueError(f'nonfilebacked VA {va:x}')
    a.output.mkdir(parents=True,exist_ok=True)
    exact=[]
    for label,(start,end) in WINDOWS.items():
        off,raw=get(start,end-start)
        name=label+'.asm'
        text=subprocess.check_output([OBJ,'-d',f'--start-address={start}',f'--stop-address={end}',str(USER)],text=True)
        # Remove misleading nearest stripped C++ symbol labels, preserve instruction text.
        text='\n'.join(line for line in text.splitlines() if line.startswith('  '))+'\n'
        (a.output/name).write_text(text)
        exact.append(dict(label=label,va=start,end=end,file_offset=off,bytes=len(raw),
            original_sha256=sha(raw),hex=raw.hex(),disasm=name,disasm_sha256=sha(text.encode()),
            bounds='finite instruction window; complete-function claims stated separately in REVIEW'))
    incoming={f'{t:x}':[] for t in CALL_TARGETS}
    for va,fs,off,flags in loads:
        if not flags&1:continue
        for delta in range(0,fs-3,4):
            w=struct.unpack_from('<I',data,off+delta)[0]
            if w>>26==0b100101:
                imm=w&0x3ffffff
                if imm&(1<<25):imm-=1<<26
                target=va+delta+imm*4
                if target in CALL_TARGETS:incoming[f'{target:x}'].append(va+delta)
    (a.output/'exact_bytes.json').write_text(json.dumps({'input_sha256':EXPECTED,'windows':exact},indent=2)+'\n')
    (a.output/'incoming_calls.json').write_text(json.dumps(incoming,indent=2)+'\n')
    tables=[]
    for label,(va,size) in TABLES.items():
        off,raw=get(va,size)
        item=dict(label=label,va=va,bytes=size,file_offset=off,hex=raw.hex(),sha256=sha(raw))
        if label=='linux_fs_vtable':item['slots']={hex(i):hex(struct.unpack_from('<Q',raw,i)[0]) for i in range(0,size,8)}
        if label=='fs_registry':
            records=[]
            for i in range(19):
                id,_,name,owner,flag,_=struct.unpack_from('<IIQQII',raw,i*32)
                stringoff,s=get(name,1);end=data.find(b'\0',stringoff,stringoff+256)
                if end<0:raise ValueError('registry name unterminated')
                records.append(dict(index=i,id=id,name=data[stringoff:end].decode('ascii'),owner_va=hex(owner),flag=flag))
            item['records']=records
        tables.append(item)
    (a.output/'tables.json').write_text(json.dumps(tables,indent=2)+'\n')
    members=[]
    for f in sorted(a.output.iterdir()):
        if f.is_file() and f.name!='manifest.json':members.append(dict(path=f.name,bytes=f.stat().st_size,sha256=sha(f.read_bytes())))
    manifest={'schema':'iq4_f3_save_static_01','input_sha256':EXPECTED,'input_bytes':len(data),
              'target_executed':False,'sdk_loaded':False,'device_connected':False,'members':members}
    (a.output/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
    print(json.dumps({'windows':len(exact),'manifest_sha256':sha((a.output/'manifest.json').read_bytes()),'target_executed':False}))

if __name__=='__main__':main()
