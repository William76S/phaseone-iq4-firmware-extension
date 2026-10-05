#!/usr/bin/env python3
"""Finite original Reader/IFM dependency ABI; never execute vendor code."""
import hashlib,json,struct,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
SRC=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f3_source_dependencies_static_01'
USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
OBJ='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
WINDOWS={
 'Main_actual_Reader_construct':(0x424948,0x42497c),
 'Main_same_Reader_into_IFM':(0x424a94,0x424af0),
 'IFM_derived_constructor':(0x4921fc,0x49239c),
 'IFM_base_Reader_field':(0x487010,0x4871c8),
 'CaptureReader_constructor':(0x7d92b8,0x7d9390),
 'CaptureParser_dependency_stores':(0x7c6f3c,0x7c7070),
 'Reader_mutable_filesystem_setter':(0x7d95d0,0x7d9630),
 'IFM_directory_method_has_Reader_FS_side_effect':(0x494c8c,0x494d54),
 'IFM_SD_filename_open_context':(0x493be4,0x493c20),
 'RawManager_current_node_and_NodeManager':(0x8dc478,0x8dc4c8),
 'NodeManager_IFM_parent':(0x8c5990,0x8c59cc),
 'Gallery_request_actual_IFM_record_directory':(0x48c3b4,0x48c65c),
 'Gallery_catalog_handle_mutation':(0x48e9f4,0x48eb14),
 'Gallery_plain_record_stride':(0x48f4f0,0x48f524),
 'Gallery_node_index':(0x8c3250,0x8c3268),
 'Gallery_record_count':(0x48f4bc,0x48f4f0),
 'Original_catalog_mutex_guard_8bytes':(0x411bc0,0x411c18),
 'Original_catalog_mutex_lock':(0x712130,0x712204),
 'Original_catalog_mutex_unlock':(0x712204,0x712324),
}
TABLES={'actual_IFM_primary_vtable':(0xb7ece0,0x60),
        'actual_original_Reader_primary_vtable':(0xd86708,16)}
def sha(b):return hashlib.sha256(b).hexdigest()
def main():
 b=USER.read_bytes();assert len(b)==11874544 and sha(b)==SHA
 h=struct.unpack_from('<16sHHIQQQIHHHHHH',b);assert h[0][:7]==b'\x7fELF\x02\x01\x01' and h[1:3]==(2,183)
 ph=[struct.unpack_from('<IIQQQQQQ',b,h[5]+i*h[9])for i in range(h[10])]
 def raw(v,n):
  matches=[(o+v-a,b[o+v-a:o+v-a+n])for t,f,o,a,pa,fs,ms,al in ph if t==1 and a<=v and v+n<=a+fs]
  assert len(matches)==1;return matches[0]
 OUT.mkdir(parents=True,exist_ok=True);rows=[];tables=[]
 for label,(va,end)in WINDOWS.items():
  offset,r=raw(va,end-va);txt=subprocess.check_output([OBJ,'-d',f'--start-address={va}',f'--stop-address={end}',str(USER)],text=True)
  txt='\n'.join(s for s in txt.splitlines()if s.startswith('  '))+'\n';p=OUT/(label+'.asm');p.write_text(txt)
  rows.append(dict(label=label,va=va,end=end,file_offset=offset,bytes=len(r),sha256=sha(r),hex=r.hex(),disasm=p.name,disasm_sha256=sha(txt.encode())))
 for label,(va,n)in TABLES.items():
  offset,r=raw(va,n);tables.append(dict(label=label,va=va,file_offset=offset,bytes=n,sha256=sha(r),hex=r.hex(),slots={hex(i):hex(struct.unpack_from('<Q',r,i)[0])for i in range(0,n,8)}))
 # Runtime pins cover the pointer-storing instructions and actual table targets.
 pin_specs=[(0x7d92b8,64),(0x7c700c,48),(0x487144,32),(0x492250,16),
            (0xb7ece0,16),(0xb7ed18,8),(0xd86708,16),
            (0x8dc494,48),(0x8c59a0,44)]
 pins=[];header=['#pragma once','#include <cstddef>','#include <cstdint>','namespace iq4::source_dependencies_01 {','struct Pin {std::uintptr_t va;std::size_t bytes;const unsigned char*data;};']
 for i,(va,n)in enumerate(pin_specs):
  _,r=raw(va,n);header.append(f'inline constexpr unsigned char Pin{i}[]={{'+','.join('0x%02x'%x for x in r)+'};')
  pins.append(dict(va=va,bytes=n,sha256=sha(r),hex=r.hex()))
 header.append('inline constexpr Pin Pins[]={'+','.join('{0x%x,%d,Pin%d}'%(p['va'],p['bytes'],i)for i,p in enumerate(pins))+'};\n}')
 (SRC/'pins.hpp').write_text('\n'.join(header)+'\n')
 doc=dict(schema='iq4_f3_source_dependencies_static_01',input_sha256=SHA,input_bytes=len(b),windows=rows,tables=tables,runtime_pins=pins,target_executed=False,sdk_loaded=False,device_connected=False)
 (OUT/'EXACT.json').write_text(json.dumps(doc,indent=2)+'\n')
 members=[dict(path=p.relative_to(ROOT).as_posix(),bytes=p.stat().st_size,sha256=sha(p.read_bytes()))for p in sorted(OUT.iterdir())if p.is_file()and p.name!='manifest.json']
 (OUT/'manifest.json').write_text(json.dumps(dict(schema='iq4_f3_source_dependencies_manifest_01',input_sha256=SHA,members=members),indent=2)+'\n')
 print(json.dumps(dict(windows=len(rows),tables=len(tables),runtime_pins=len(pins),manifest_sha256=sha((OUT/'manifest.json').read_bytes()),target_executed=False)))
if __name__=='__main__':main()
