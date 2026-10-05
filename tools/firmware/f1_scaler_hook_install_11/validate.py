#!/usr/bin/env python3
"""Read-only new11 source/artifact hash verification; does not execute target."""
import hashlib,json
from build_prepare import ROOT,HERE
def main():
 p=HERE/'SOURCE_SHA256.json';d=json.loads(p.read_bytes());n=0
 assert d['schema']==11 and d['public_ABI']==10
 for group in('members','frozen_refs','review_artifacts'):
  for r in d[group]:
   f=ROOT/r['path'];assert f.stat().st_size==r['bytes']and hashlib.sha256(f.read_bytes()).hexdigest()==r['sha256'],r['path'];n+=1
 assert not any(d[k]for k in('target_loaded','UI_installed','target_text_written','actual_full_source_verified','actual_stock_write_verified','actual_surface_lease_verified','mask_enabled','frozen_sources_modified'))
 print(json.dumps({'hashes_verified':n,'source_sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'runtime_qualification':False,'public_ABI':10}))
if __name__=='__main__':main()
