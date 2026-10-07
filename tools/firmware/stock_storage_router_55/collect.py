#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,struct,subprocess
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/stock_storage_router_55';USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 OUT.mkdir(parents=True,exist_ok=True);b=USER.read_bytes();assert hashlib.sha256(b).hexdigest()==SHA
 phoff=struct.unpack_from('<Q',b,32)[0];esz,num=struct.unpack_from('<HH',b,54)
 def raw(va,n):
  for i in range(num):
   typ,fl,off,a,pa,fs,ms,align=struct.unpack_from('<IIQQQQQQ',b,phoff+i*esz)
   if typ==1 and a<=va and va+n<=a+fs:return b[off+va-a:off+va-a+n]
  raise AssertionError(hex(va))
 windows=[('MainStorageVmInputs',0x41a838,108),('MainSequencePointer',0x41a1bc,24),('MainProcessingQueueInput',0x422e58,52),('NativeWorkerQueueOwner',0x7b54b4,20),('NativeCatalogQueueOwner',0x48714c,12),('NativeNodeUniqueIdentity',0x8c2294,36),('NativeProcessingIdentityGetter',0x48da44,24),('NativeJpegInnerWait',0x48c880,384),
  ('VmNativeEventFields',0x5b50d0,248),('NativeSDCompositeGetter',0x495448,16),
  ('NativeCaptureSequenceBoolean',0x5f9dc0,56),('NativeBoolGetter',0x41497c,16),
  ('NativeJpegPendingQuery',0x8e2590,16),('NativePendingCount',0x49746c,168),
  ('NativeJpegOffPendingClear',0x8e25dc,32),('NativeSinglePendingClear',0x8e25b0,44),('NativePendingClearLock',0x4975c8,156),('NativePendingClearOperation',0x48793c,84),('NativeGetPresence',0x496df4,156),
  ('NativeClearPresence',0x496e90,204),('CatalogSlotLookup',0x48f4f0,52),('BackupNativeClientBind',0x8e2738,68),('BackupClientName',0xdbcf98,16),('NativeBackupModeCtor',0x5e41f8,16),('NativeBackupModeGetter',0x5e7fb8,16),('NativeBackupModeSetter',0x5e7fec,128),('NativeBackupPendingCount',0x8e3d38,32),('NativeBackupModeVTable',0xbca908,16)]
 # Main sequence pointer evidence is reused from its actual field consumers;
 # exact construction site is also locked via peer original evidence.
 hooks=[dict(va=0x496f28,old_hex=raw(0x496f28,4).hex(),original_target=0x48f4f0,
  target_symbol='iq4_stock_delete_lookup_wrapper_55'),dict(va=0x497630,old_hex=raw(0x497630,4).hex(),original_target=0x48793c,target_symbol='iq4_stock_jpeg_pending_clear_guard_55'),dict(va=0x48c98c,old_hex=raw(0x48c98c,4).hex(),original_target=0x713a18,target_symbol='iq4_stock_half_inner_wait_wrapper_55')]
 for hook in hooks:
  op=int.from_bytes(raw(hook['va'],4),'little');d=op&0x3ffffff
  d=d-(1<<26) if d&(1<<25) else d
  assert op>>26==0b100101 and hook['va']+d*4==hook['original_target']
 exclusions=sorted([0x496f28,0x497630,0x48c98c])
 lines=['#ifndef IQ4_STORAGE_ROUTER_PINS_55_H','#define IQ4_STORAGE_ROUTER_PINS_55_H',
 '#include <stdint.h>','#include <stddef.h>',
 'struct StorageRouterPin55{uintptr_t va;size_t bytes;const unsigned char*data;};']
 pins=[]
 for name,lo,n in windows:
  hi=lo+n;inside=[v for v in exclusions if lo<=v<hi]
  asm=subprocess.run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d',
   '--start-address='+hex(lo),'--stop-address='+hex(hi),str(USER)],text=True,capture_output=True,check=True)
  (OUT/(name+'.asm')).write_text(asm.stdout)
  for a,z in zip([lo]+[v+4 for v in inside],inside+[hi]):
   if a>=z:continue
   data=raw(a,z-a);i=len(pins);lines.append('static const unsigned char StorageRouterBytes55_%u[]={%s};'%(i,','.join('0x%02x'%v for v in data)))
   pins.append(dict(name=name,va=a,bytes=len(data),hex=data.hex(),sha256=hashlib.sha256(data).hexdigest()))
 lines.append('static const StorageRouterPin55 StorageRouterPins55[]={'+','.join('{0x%x,%u,StorageRouterBytes55_%u}'%(q['va'],q['bytes'],i)for i,q in enumerate(pins))+'};')
 lines.append('#endif');(HERE/'router_pins_55.h').write_text('\n'.join(lines)+'\n')
 # Derive immutable 53 policy windows, excluding only the newly owned observer
 # BL. Its target is checked by actual production code, not an old-byte pin.
 policy=json.loads((ROOT/'analysis/firmware/stock_jpeg_policy_build_01/EXACT.json').read_text())
 assert policy['input']['sha256']==SHA
 plines=['#ifndef IQ4_STORAGE_POLICY_PINS_55_H','#define IQ4_STORAGE_POLICY_PINS_55_H',
 '#include <stdint.h>','#include <stddef.h>',
 'struct StoragePolicyPin55{uintptr_t va;size_t bytes;const unsigned char*data;};'];pp=[]
 for q in policy['pins']:
  lo=q['va'];hi=lo+q['bytes'];inside=[0x6a9a94] if lo<=0x6a9a94<hi else []
  assert raw(lo,hi-lo).hex()==q['hex']
  for a,z in zip([lo]+[v+4 for v in inside],inside+[hi]):
   if a>=z:continue
   data=raw(a,z-a);i=len(pp);plines.append('static const unsigned char StoragePolicyBytes55_%u[]={%s};'%(i,','.join('0x%02x'%v for v in data)))
   pp.append(dict(va=a,bytes=len(data),hex=data.hex(),sha256=hashlib.sha256(data).hexdigest()))
 plines.append('static const StoragePolicyPin55 StoragePolicyPins55[]={'+','.join('{0x%x,%u,StoragePolicyBytes55_%u}'%(q['va'],q['bytes'],i)for i,q in enumerate(pp))+'};')
 plines.append('#endif');(HERE/'policy_pins_55.h').write_text('\n'.join(plines)+'\n')
 (OUT/'EXACT.json').write_text(json.dumps(dict(schema='iq4_storage_router_exact_55',input=row(USER),
  pins=pins,policy_pins=pp,BL_hooks=hooks,policy_observer_exclusion=0x6a9a94,
  policy_observer_target='iq4_stock_storage_policy_wrapper_55',
  native_55_fields_evidence='tools/firmware/stock_storage_menu_55/FACTORY_LAYOUT.json',
  camera_accessed=False),indent=2)+'\n')
 print('PASS exact 55 VM/sequence/pending/catalog windows; remove/observer BL excluded')
if __name__=='__main__':main()
