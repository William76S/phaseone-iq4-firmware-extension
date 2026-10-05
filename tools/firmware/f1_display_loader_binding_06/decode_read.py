#!/usr/bin/env python3
"""Decode saved finite copied-read JSON. Does not read /proc or contact camera."""
from pathlib import Path
import importlib.util,json,struct,sys
import contract
from build_prepare import OUT
def decode(raw,expected_sha,expected_pid,expected_ticks):
 r=contract.strict_json(raw);fields={'schema','pid','start_ticks','module_sha256','publication_va','publication_bytes','sequence','first_hex','second_hex','firmware_calls','target_memory_writes','mask_enabled'}
 if type(r)is not dict or set(r)!=fields:raise ValueError('Exact copied-read shape')
 for k,v in {'schema':'iq4_f1_display_copied_read_v6','pid':expected_pid,'start_ticks':expected_ticks,'module_sha256':expected_sha,'publication_bytes':1440,'firmware_calls':0,'target_memory_writes':0,'mask_enabled':False}.items():
  if type(r[k])is not type(v)or r[k]!=v:raise ValueError('Copied-read identity/scope mismatch')
 if type(r['publication_va'])is not int or not 4096<=r['publication_va']<=2**63-1440 or type(r['sequence'])is not int or not 0<=r['sequence']<2**32 or r['sequence']%2:raise ValueError('Copied-read address/sequence')
 import re
 if any(type(r[k])is not str or re.fullmatch('[0-9a-f]{2880}',r[k])is None for k in('first_hex','second_hex')):raise ValueError('Exact lowercase copied bytes')
 first=bytes.fromhex(r['first_hex']);second=bytes.fromhex(r['second_hex'])
 if struct.unpack_from('<I',first)[0]!=r['sequence']:raise ValueError('Outer sequence differs from copy')
 p=contract.HERE.parent/'f1_display_observe_06/decode_observation.py';s=importlib.util.spec_from_file_location('frozen_display06_decode',p);m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
 result=m.decode(first,second);result['copied_read_identity_fields_matched']=True;result['private_receipt_hardware_origin_authenticated_here']=False;return result
def main():
 if len(sys.argv)!=4:raise SystemExit('saved actual copied-read JSON, independently held expected PID and ticks required')
 build=json.loads((OUT/'BUILD_PREPARATION.json').read_text());print(json.dumps(decode(Path(sys.argv[1]).read_bytes(),build['authenticated_candidate']['sha256'],int(sys.argv[2]),int(sys.argv[3])),indent=2,allow_nan=False))
if __name__=='__main__':main()
