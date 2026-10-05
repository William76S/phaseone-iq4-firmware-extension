#!/usr/bin/env python3
"""Source-preparation only. No enabled package or deployment is emitted."""
import argparse,json
import contract
from build_prepare import ROOT,HERE,OUT,sha
from stager import stage_plan

def wrapper(action,enabled):
 if action not in('install','disable')or enabled:raise ValueError('Only inert local wrappers in this freeze')
 return ('#!/bin/sh\nset -eu\necho preview-only-no-target-action\nexit 2\n').encode()
def blobs_for(entry,module,enabled):
 if enabled:raise ValueError('Enabled package is outside this source-preparation freeze')
 return {'entrytool':entry.read_bytes(),'observe.so':module.read_bytes(),'entry.sha256':(sha(entry)+'\n').encode(),'install.sh':wrapper('install',False),'disable.sh':wrapper('disable',False)}
def bind_stage_identity(plan,source):
 if source['sha256']!=contract.ENTRY_SO or source['bytes']!=118080 or source['publication_symbol']!='iq4_f1_normal_fit_ingress_observed_10' or source['publication_va']!=308056 or source['publication_bytes']!=496 or source['preparation_publication']!=[308552,192]:raise ValueError('Exact Source11 SO/schema10 publication identity required')
 config=(HERE/'config.preview.h').read_text()
 for line in('#define F1_ENTRY_BYTES 496U','#define F1_ENTRY_VA 308056ULL','#define F1_PREPARATION_BYTES 192U','#define F1_PREPARATION_VA 308552ULL','#define F1_MODULE_BYTES 118080ULL','#define F4_ENABLED 0','#define F1_RUNNER_ARM_ENABLED 0'):
  if line not in config:raise ValueError('Default-OFF config/actual SO layout mismatch')
 plan.update(entry_publication_bytes=496,entry_publication_relative_va=308056,preparation_publication_bytes=192,preparation_publication_relative_va=308552,new_so_sha256=source['sha256'],new_so_bytes=118080,public_ABI=10,module_source_identity=11,installable=False,native_text_hook_installation_authorized=False,mask_enabled=False)
 return plan
def main():
 a=argparse.ArgumentParser();a.parse_args()
 manifest=HERE/'SOURCE_SHA256.json';doc=json.loads(manifest.read_text())
 for group in('members','frozen_refs','review_artifacts'):
  for r in doc[group]:p=ROOT/r['path'];assert sha(p)==r['sha256']and p.stat().st_size==r['bytes'],r['path']
 build=json.loads((OUT/'BUILD_PREPARATION.json').read_text());assert build['installable']is False
 print(json.dumps({'schema':'iq4_f1_entry_loader_source_preparation_v11','prep_only':True,'commands':[],'installable':False,'target_loaded':False,'mask_enabled':False,'embedded_controller':True,'public_artifacts':build['preview_artifacts']}))
if __name__=='__main__':main()
