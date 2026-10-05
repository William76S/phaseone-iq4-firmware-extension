#!/usr/bin/env python3
"""Finite original Gallery mutex/record ABI, no target execution."""
from pathlib import Path
import hashlib,json,struct,subprocess
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f3_gallery_source_snapshot_static_01'
USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
def sha(b):return hashlib.sha256(b).hexdigest()
def main():
 b=USER.read_bytes();assert len(b)==11874544 and sha(b)==SHA
 h=struct.unpack_from('<16sHHIQQQIHHHHHH',b);ph=[struct.unpack_from('<IIQQQQQQ',b,h[5]+i*h[9])for i in range(h[10])]
 def raw(v,n):
  r=[(o+v-a,b[o+v-a:o+v-a+n])for t,f,o,a,pa,fs,ms,al in ph if t==1 and a<=v and v+n<=a+fs];assert len(r)==1;return r[0]
 specs=[('guard_construct',0x411bc0,0x411bf4),('guard_destroy',0x411bf4,0x411c18),('native_current_thread',0x710b0c,0x710b34),('catalog_mutex_lock',0x712130,0x712204),('catalog_mutex_unlock',0x712204,0x712324),('plain_record',0x48f4bc,0x48f524),('IFM_directory_sideeffect',0x494c8c,0x494d54),('IFM_file_branch',0x48c548,0x48c65c)]
 OUT.mkdir(parents=True,exist_ok=True);rows=[]
 for label,v,end in specs:
  off,r=raw(v,end-v);txt=subprocess.check_output(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d',f'--start-address={v}',f'--stop-address={end}',str(USER)],text=True)
  txt='\n'.join(s for s in txt.splitlines()if s.startswith('  '))+'\n';(OUT/(label+'.asm')).write_text(txt)
  rows.append(dict(label=label,va=v,end=end,offset=off,bytes=len(r),sha256=sha(r),hex=r.hex(),disasm=label+'.asm',disasm_sha256=sha(txt.encode())))
 bindings=[dict(symbol=s,va=v,bytes=n,hex=raw(v,n)[1].hex(),sha256=sha(raw(v,n)[1]))for s,v,n in [('iq4_f3_gallery_guard_construct_01',0x411bc0,52),('iq4_f3_gallery_guard_destroy_01',0x411bf4,36),('iq4_f3_gallery_current_thread_01',0x710b0c,40)]]
 (HERE/'ORIGINAL_BINDINGS.json').write_text(json.dumps(dict(schema='iq4_f3_gallery_native_01',original_user_sha256=SHA,bindings=bindings,target_executed=False),indent=2)+'\n')
 header=['#pragma once','struct GalleryPin01 {uintptr_t va;size_t bytes;const unsigned char*data;};']
 for i,p in enumerate(bindings):header.append('static const unsigned char GalleryPin%d[]={%s};'%(i,','.join('0x%02x'%c for c in bytes.fromhex(p['hex']))))
 header.append('static const GalleryPin01 GalleryPins01[]={'+','.join('{0x%x,%d,GalleryPin%d}'%(p['va'],p['bytes'],i)for i,p in enumerate(bindings))+'};')
 (HERE/'pins.inc').write_text('\n'.join(header)+'\n')
 (OUT/'EXACT.json').write_text(json.dumps(dict(schema='iq4_f3_gallery_static_01',input_sha256=SHA,windows=rows,bindings=bindings,target_executed=False),indent=2)+'\n')
 (OUT/'manifest.json').write_text(json.dumps(dict(members=[dict(path=p.relative_to(ROOT).as_posix(),bytes=p.stat().st_size,sha256=sha(p.read_bytes()))for p in sorted(OUT.iterdir())if p.name!='manifest.json']),indent=2)+'\n')
if __name__=='__main__':main()
