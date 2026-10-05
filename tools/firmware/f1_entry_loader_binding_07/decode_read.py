#!/usr/bin/env python3
"""Decode a saved fixed 104B UI07 read, with independently held identity."""
from pathlib import Path
import importlib.util,json,re,struct,sys
import contract
def decode(raw,expected_pid,expected_ticks):
 r=contract.strict_json(raw);fields={'schema','pid','start_ticks','module_sha256','publication_va','publication_bytes','sequence','first_hex','second_hex','firmware_calls','target_memory_writes','mask_enabled'}
 if type(r)is not dict or set(r)!=fields:raise ValueError('Exact copied-entry shape')
 for k,v in {'schema':'iq4_f1_entry_copied_read_v7','pid':expected_pid,'start_ticks':expected_ticks,'module_sha256':contract.ENTRY_SO,'publication_bytes':104,'firmware_calls':0,'target_memory_writes':0,'mask_enabled':False}.items():
  if type(r[k])is not type(v)or r[k]!=v:raise ValueError('UI07 copied identity/scope differs')
 if type(r['publication_va'])is not int or not 4096<=r['publication_va']<=2**63-104 or type(r['sequence'])is not int or not 0<=r['sequence']<2**32 or r['sequence']%2:raise ValueError('UI07 copied address/sequence')
 if any(type(r[k])is not str or re.fullmatch('[0-9a-f]{208}',r[k])is None for k in('first_hex','second_hex')):raise ValueError('Exactly 104 lower-case bytes per copy')
 first=bytes.fromhex(r['first_hex']);second=bytes.fromhex(r['second_hex'])
 if struct.unpack_from('<I',first)[0]!=r['sequence']:raise ValueError('Sequence differs from copied bytes')
 p=contract.HERE.parent/'f1_native_entry_binding_07/decode_entry.py';s=importlib.util.spec_from_file_location('frozen_ui07_decoder',p);m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
 result=m.decode(first,second);result['copied_read_identity_fields_matched']=True;result['receipt_hardware_origin_authenticated_here']=False;return result
if __name__=='__main__':
 if len(sys.argv)!=4:raise SystemExit('saved UI07 copied-read JSON, independently held PID and start ticks required')
 print(json.dumps(decode(Path(sys.argv[1]).read_bytes(),int(sys.argv[2]),int(sys.argv[3])),indent=2,allow_nan=False))
