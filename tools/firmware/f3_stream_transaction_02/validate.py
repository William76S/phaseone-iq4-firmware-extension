#!/usr/bin/env python3
import hashlib,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
def main():
 s=json.loads((Path(__file__).parent/'SOURCE_SHA256.json').read_text());n=0
 for r in s['members']+s['references']:
  b=(ROOT/r['path']).read_bytes()
  if len(b)!=r['bytes']or hashlib.sha256(b).hexdigest()!=r['sha256']:raise ValueError(r['path'])
  n+=1
 old=(ROOT/'tools/firmware/f4_ui_bootstrap_02/sha256.h').read_text()
 expected=old.replace('#ifndef F4_SHA256_H','#ifndef F3_STREAM_SHA256_REUSE_02_H').replace('#define F4_SHA256_H','#define F3_STREAM_SHA256_REUSE_02_H').replace('static uint32_t f4_','static inline uint32_t f4_').replace('static void f4_','static inline void f4_')
 if (Path(__file__).parent/'sha256.h').read_text()!=expected:raise ValueError('SHA reuse differs beyond linkage/guard')
 print(json.dumps({'hash_rows_verified':n,'sha_body_same':True,'native_ports_bound':False,'target_executed':False}))
if __name__=='__main__':main()
