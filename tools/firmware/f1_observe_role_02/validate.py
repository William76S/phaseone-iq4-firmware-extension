#!/usr/bin/env python3
"""Read and hash fixed source/target artifacts only; never load them."""
from pathlib import Path
import hashlib,json
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def row(p):
 b=p.read_bytes();return {'path':str(p.relative_to(ROOT)),'bytes':len(b),'sha256':hashlib.sha256(b).hexdigest()}
def main():
 m=json.loads((HERE/'SOURCE_SHA256.json').read_text());rows=m['members']+m['frozen_refs']+m['target_review_artifacts']
 for r in rows:
  if row(ROOT/r['path'])!=r:raise SystemExit('Fixed source/artifact changed: '+r['path'])
 assert m['camera_access'] is False and m['target_loaded'] is False and m['actual_installation'] is False
 print(json.dumps({'members':len(m['members']),'frozen_refs':len(m['frozen_refs']),'target_review_artifacts':len(m['target_review_artifacts']),'hashes_verified':len(rows),'device_access':False,'target_loaded':False}))
if __name__=='__main__':main()
