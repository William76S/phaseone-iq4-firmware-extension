#!/usr/bin/env python3
import hashlib,json
from build_prepare import ROOT,HERE
def main():
 p=HERE/'SOURCE_SHA256.json';d=json.loads(p.read_text());n=0
 for group in('members','frozen_refs','review_artifacts'):
  for r in d[group]:f=ROOT/r['path'];assert f.stat().st_size==r['bytes']and hashlib.sha256(f.read_bytes()).hexdigest()==r['sha256'],r['path'];n+=1
 assert not any(d[k]for k in('target_executed','target_loaded','UI_entry_installed','mask_enabled','native_text_hook_installed','frozen_sources_modified'))
 print(json.dumps({'hashes_verified':n,'source_sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'actual_acceptance':False,'final_device_candidate':False,'installable':False}))
if __name__=='__main__':main()
