#!/usr/bin/env python3
import hashlib,json
from derive_runtime import ROOT,HERE
def main():
 p=HERE/'SOURCE_SHA256.json';d=json.loads(p.read_text());n=0
 for g in('members','frozen_refs','review_artifacts'):
  for r in d[g]:f=ROOT/r['path'];assert f.stat().st_size==r['bytes']and hashlib.sha256(f.read_bytes()).hexdigest()==r['sha256'];n+=1
 assert not any(d[k]for k in('actual_module_loaded','UI_installed','mask_enabled','full_source_mapping_verified','fresh_stock_blit_verified','surface_lease_verified','frozen_sources_modified'))
 print(json.dumps({'source_sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'hashes_verified':n,'actual_module_loaded':False}))
if __name__=='__main__':main()
