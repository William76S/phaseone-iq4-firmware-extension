#!/usr/bin/env python3
from pathlib import Path
import hashlib,json
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def main():
    source=HERE/'SOURCE_SHA256.json';doc=json.loads(source.read_text());count=0
    for group in ('members','frozen_refs','review_artifacts'):
        for item in doc[group]:
            p=ROOT/item['path'];assert p.stat().st_size==item['bytes']and hashlib.sha256(p.read_bytes()).hexdigest()==item['sha256'],item['path'];count+=1
    assert not any(doc[k]for k in ('camera_access','SDK_started','Windows_or_network_used','target_loaded','paint_installed','mask_enabled','full_source_mapping_verified','fresh_blit_verified','surface_lease_verified','frozen_sources_modified'))
    print(json.dumps({'hashes_verified':count,'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),'actual_target_or_device_acceptance':False}))
if __name__=='__main__':main()
