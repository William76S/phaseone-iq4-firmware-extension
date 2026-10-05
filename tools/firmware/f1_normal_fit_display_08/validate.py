#!/usr/bin/env python3
import hashlib,json
from hook_plan import ROOT,HERE
def main():
 p=HERE/'SOURCE_SHA256.json';d=json.loads(p.read_text());n=0
 for g in('members','frozen_refs','review_artifacts'):
  for r in d[g]:p=ROOT/r['path'];assert p.stat().st_size==r['bytes']and hashlib.sha256(p.read_bytes()).hexdigest()==r['sha256'];n+=1
 assert not d['target_loaded']and not d['mask_enabled']and not d['actual_surface_lease_verified']
 print(json.dumps({'source_sha256':hashlib.sha256((HERE/'SOURCE_SHA256.json').read_bytes()).hexdigest(),'hashes_verified':n,'target_loaded':False,'mask_enabled':False}))
if __name__=='__main__':main()
