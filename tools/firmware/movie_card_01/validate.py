#!/usr/bin/env python3
from pathlib import Path
import hashlib,json
ROOT=Path(__file__).resolve().parents[3]
def main():
 p=Path(__file__).with_name('SOURCE_SHA256.json');x=json.loads(p.read_text());n=0
 for key in ['members','references','artifacts']:
  for r in x[key]:
   b=(ROOT/r['path']).read_bytes();assert len(b)==r['bytes']and hashlib.sha256(b).hexdigest()==r['sha256'],r['path'];n+=1
 print(json.dumps({'hash_rows':n,'passed':True,'target_executed':False}))
if __name__=='__main__':main()
