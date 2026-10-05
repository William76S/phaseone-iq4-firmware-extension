#!/usr/bin/env python3
"""Verify frozen source/evidence without loading SDK or target code."""
import hashlib,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
def main():
    source=json.loads((Path(__file__).parent/'SOURCE_SHA256.json').read_text())
    count=0
    for item in source['members']+source['references']:
        p=ROOT/item['path'];b=p.read_bytes()
        if len(b)!=item['bytes'] or hashlib.sha256(b).hexdigest()!=item['sha256']:
            raise ValueError('changed member '+item['path'])
        count+=1
    print(json.dumps({'hash_rows_verified':count,'target_executed':False,'native_ports_bound':False}))
if __name__=='__main__':main()
