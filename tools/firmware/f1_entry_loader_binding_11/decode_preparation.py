#!/usr/bin/env python3
"""Saved source-issued 192B preparation; no lease or text-install inference."""
from pathlib import Path
import json,re,struct,sys
import contract
RESULTS=('Disabled','InvalidInput','WrongOwner','OriginalChanged','AllocationFailed','NearOutOfRange','SealFailed','ProviderRejected','Prepared')
def decode(raw,pid,ticks):
 r=contract.strict_json(raw);fields={'schema','pid','start_ticks','module_sha256','publication_va','publication_bytes','sequence','first_hex','second_hex','firmware_calls','target_memory_writes','mask_state_not_inferred'}
 if type(r)is not dict or set(r)!=fields:raise ValueError('Exact UI10 preparation copy shape')
 for k,v in {'schema':'iq4_f1_preparation_copied_read_v11','pid':pid,'start_ticks':ticks,'module_sha256':contract.ENTRY_SO,'publication_bytes':192,'firmware_calls':0,'target_memory_writes':0,'mask_state_not_inferred':True}.items():
  if type(r[k])is not type(v)or r[k]!=v:raise ValueError('Exact source/outer identity')
 if type(pid)is not int or not 2<=pid<=10000000 or type(ticks)is not int or not 0<ticks<2**64:raise ValueError('Independent current PID/start ticks')
 if type(r['publication_va'])is not int or not 4096<=r['publication_va']<=2**63-192 or type(r['sequence'])is not int or not 0<=r['sequence']<2**32 or r['sequence']&1:raise ValueError('Address/sequence')
 if any(type(r[k])is not str or re.fullmatch('[0-9a-f]{384}',r[k])is None for k in('first_hex','second_hex'))or r['first_hex']!=r['second_hex']:raise ValueError('Exact stable double-copy')
 b=bytes.fromhex(r['first_hex']);seq,size,schema,meta,result,attempts,source_pid,ui_tid,requested,phase=struct.unpack_from('<10I',b)
 values=struct.unpack_from('<10Q',b,40)
 names=('pid_ticks','near_page','near_bytes','bridge','trampoline_slot','trampoline_value','original_pair','owner_queue','generation','renderer_status');m=dict(zip(names,values))
 if seq!=r['sequence']or size!=192 or schema!=10 or meta!=184 or result>=len(RESULTS)or attempts not in(0,1)or any(b[185:]):raise ValueError('Source layout/result/reserved bytes')
 digest=b[120:185]
 if attempts==0:
  if result or source_pid or ui_tid or requested or phase or any(values)or any(digest):raise ValueError('Unattempted publication cannot claim preparation')
 else:
  if source_pid!=pid or not 2<=ui_tid<2**32:raise ValueError('Source issued PID/UI TID')
  if any(digest)and(re.fullmatch(b'[0-9a-f]{64}\x00',digest)is None):raise ValueError('Input digest')
 if result==8:
  if m['pid_ticks']!=ticks or requested!=0 or phase!=1 or m['near_bytes']!=65536 or m['near_page']%4096 or m['trampoline_value']!=m['near_page']+16 or m['original_pair']!=0xa9057bfdd10403ff or any(not 4096<=m[k]<2**63 for k in('near_page','bridge','trampoline_slot','owner_queue','renderer_status'))or not m['generation']or re.fullmatch(b'[0-9a-f]{64}\x00',digest)is None:raise ValueError('Exact Prepared relationships')
 return {'schema':'iq4_f1_hook_preparation_decoded_v11','result':RESULTS[result],'attempts':attempts,'pid':source_pid,'UI_tid':ui_tid,'requested_mode':requested,'renderer_phase':phase,**m,'input_sha256':digest[:64].decode('ascii')if any(digest)else None,'source_publication_stable':True,'target_text_installation_inferred':False,'actual_surface_lease_verified':False,'actual_full_source_verified':False,'actual_stock_write_verified':False,'mask_state_not_inferred':True,'hardware_origin_authenticated_here':False}
if __name__=='__main__':
 if len(sys.argv)!=4:raise SystemExit('Saved preparation copy plus independently held PID/start ticks required')
 print(json.dumps(decode(Path(sys.argv[1]).read_bytes(),int(sys.argv[2]),int(sys.argv[3])),indent=2))
