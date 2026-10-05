#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,struct,subprocess
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/f3_native_storage_bridge_01'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 u=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';b=u.read_bytes();assert row(u)['sha256']=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
 ranges=[('sd_argument',0x4f04bc,52),('sd_return',0x4f04f4,32),('submenu_ctor',0x4e5744,32),('leaf_ctor',0x4e9d30,32),('append',0x4e58b8,32),('current',0x710b0c,20),('tls',0x713f60,20),('submenu_vtable',0xb8f9a8,192),('leaf_vtable',0xb90738,176),('sd_dto',0xbbf718,312),('storage_dto',0xbbf8a8,312),('storage_event',0xbcac08,168),('get_mode',0x55b500,52),('set_mode_prefix',0x5e9868,28),('set_mode_core',0x5e9888,56),('set_mode_tail',0x5e98c4,36),('silent_prefix',0x5e98e8,24),('silent_core',0x5e9904,8),('silent_tail',0x5e9910,16),('pthread_lock_PLT',0x40aae0,16),('pthread_unlock_PLT',0x40a730,16),('xqd_composite_before',0x6aa120,72),('xqd_composite_after',0x6aa16c,12),('sd_composite_before',0x6aa178,72),('sd_composite_after',0x6aa1c4,12)]
 pins=[];src=['#pragma once','#include <stdint.h>','#include <stddef.h>','struct BridgePin01{uintptr_t va;size_t bytes;const unsigned char*data;};']
 for i,(name,va,n) in enumerate(ranges):
  raw=b[va-0x400000:va-0x400000+n];pins.append(dict(name=name,va=va,bytes=n,sha256=hashlib.sha256(raw).hexdigest(),hex=raw.hex()));src.append('static const unsigned char BridgeData%d[]={%s};'%(i,','.join('0x%02x'%v for v in raw)))
 src.append('static const struct BridgePin01 BridgePins01[]={'+','.join('{0x%x,%d,BridgeData%d}'%(va,n,i)for i,(_,va,n)in enumerate(ranges))+'};');(HERE/'pins.h').write_text('\n'.join(src)+'\n')
 hooks=[]
 for va,kind,target,original in [(0x4f04f0,'BL','iq4_f3_storage_output_append_wrapper_01',0x4e58b8),(0x8e0bf8,'BL','iq4_f3_legacy_jpeg_disabled_01',0x5e8c20),(0x8e0d40,'BL','iq4_f3_legacy_jpeg_disabled_01',0x5e8c20),(0x5e9884,'B','iq4_f3_storage_regular_enter_01',None),(0x5e98c0,'B','iq4_f3_storage_regular_leave_01',None),(0x5e9900,'B','iq4_f3_storage_silent_enter_01',None),(0x5e990c,'B','iq4_f3_storage_silent_leave_01',None)]:
  h=dict(va=va,branch_kind=kind,old_hex=b[va-0x400000:va-0x400000+4].hex(),target_symbol=target)
  if original:h['original_target']=original
  hooks.append(h)
 windows=[('eager_menu_constructor',0x4f0364,0x4f0d38),('storage_dto_constructor',0x5b7d60,0x5b7f28),('storage_event_constructor',0x5e3f24,0x5e3fc0),('composite_policy',0x6a9aa4,0x6aa1d0),('native_disable_restore',0x708a1c,0x708c10),('legacy_worker',0x8e0b18,0x8e1180),('native_raw_status',0x8dbbac,0x8dbd20),('null_lock_not_mutex',0x40c2a0,0x40c370),('setter_whole',0x5e9868,0x5e9920)]
 proof=[]
 for name,start,end in windows:
  raw=b[start-0x400000:end-0x400000];s=subprocess.check_output(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d','--start-address='+hex(start),'--stop-address='+hex(end),str(u)],text=True);s='\n'.join(l.rstrip()for l in s.splitlines()if l.startswith('  '))+'\n';(OUT/(name+'.asm')).write_text(s);proof.append(dict(name=name,va=start,bytes=end-start,sha256=hashlib.sha256(raw).hexdigest()))
 # Normal control flow between the eager Storage and File Settings builders.
 branches=[]
 for a in range(0x4f04f4,0x4f0d38,4):
  w=struct.unpack_from('<I',b,a-0x400000)[0]
  if w&0xff000010==0x54000000:
   imm=(w>>5)&0x7ffff;imm=imm-(1<<19)if imm&(1<<18)else imm;branches.append([a,a+4*imm])
  assert w&0x7c000000!=0x14000000 or w&0xfc000000==0x94000000,hex(a)
  assert w&0x7e000000 not in (0x34000000,0x36000000),hex(a)
  assert w&0xfe1ffc1f not in (0xd61f0000,0xd65f0000),hex(a)
 assert branches==[[0x4f0b54,0x4f0b90],[0x4f0ba8,0x4f0be4]],branches
 (OUT/'EXACT.json').write_text(json.dumps(dict(schema='iq4_native_storage_bridge_exact_01',original=row(u),hooks=hooks,pins=pins,windows=proof,eager_build_branch_edges=branches,legacy_worker_reads_disabled_at_install_stage100=2,legacy_worker_fallback_on_initialization_failure=True,conditional_composite_only=True,original_native_protection_setter_arguments_unchanged=True,target_executed=False),indent=2)+'\n')
 print('Exact original windows and 7 hook prebytes collected; no target access')
if __name__=='__main__':main()
