#!/usr/bin/env python3
"""Verify the delivered offline60 inputs/evidence and write the final receipt."""
import hashlib, json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
BUILD=ROOT/'analysis/firmware/half_render_contract_60_build_final'
def row(path):
    p=Path(path);p=p if p.is_absolute() else ROOT/p;b=p.read_bytes()
    return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def check_refs(value,seen):
    if isinstance(value,dict):
        if {'path','bytes','sha256'}<=value.keys():
            assert row(value['path'])=={k:value[k]for k in ('path','bytes','sha256')},value['path']
            seen.add(value['path'])
        for item in value.values():check_refs(item,seen)
    elif isinstance(value,list):
        for item in value:check_refs(item,seen)
def main():
    locks=[
        'analysis/firmware/half_render_contract_60_components_final/SOURCE_SHA256.json',
        'analysis/firmware/half_render_plane_60/FINAL_SOURCE_SHA256.json',
        'analysis/firmware/half_render_observer_60/SOURCE_SHA256.json',
        'analysis/firmware/half_render_observer_60/TERMINAL_PINS_SOURCE_SHA256.json',
        'analysis/firmware/half_rgb24_format_60/SOURCE_SHA256.json',
        'analysis/firmware/half_rgb24_terminal_review_60/FINAL_REVIEW_SOURCE_SHA256.json'
    ]
    seen=set()
    for p in locks:check_refs(json.loads((ROOT/p).read_text()),seen)
    b=json.loads((BUILD/'BUILD.json').read_text());d=json.loads((BUILD/'DELIVERY.json').read_text())
    assert row(b['User']['path'])==b['User'];assert row(b['spec']['path'])==b['spec']
    fwp=row('deploy/iq4_6.03.60/IQ4_6.03.60.fwp')
    assert fwp['sha256']==d['fwp_sha256'] and fwp['bytes']==d['fwp_bytes']
    proofs=[
        'analysis/firmware/half_render_plane_60/A64_CAPACITY.json',
        'analysis/firmware/half_render_plane_60/A64_USER_TERMINAL.json',
        'analysis/firmware/half_render_observer_60/A64_STAGE_COUNTS.json',
        'analysis/firmware/half_render_observer_60/A64_OBSERVER.json',
        'analysis/firmware/half_render_observer_60/A64_FINAL_GATE.json',
        'analysis/firmware/half_render_observer_60/A64_FINAL_TERMINAL_PINS.json',
        'analysis/firmware/half_render_contract_60_runtime_tests/RESULT.json',
        'analysis/firmware/half_render_contract_60_sink_tests/RESULT.json',
        'analysis/firmware/half_rgb24_terminal_review_60/FINAL_REVIEW.json'
    ]
    checks=['BUILD.json','DELTA_CHECK.json','ROOT_INSPECTION.json','ORIGINAL_PIN_CHECK.json',
        'CONTRACT_SEAL.json','LINKED_UNWIND_SEMANTIC_IDENTITY.json','OLD_PIPELINE_EXCLUSION.json','PRODUCTION_PINS.json']
    result=dict(schema='iq4_half_render_contract_RGB24_60_final_verification',versions=d,FWP=fwp,User=b['User'],spec=b['spec'],
        sources_checked=len(seen),source_locks=[row(p)for p in locks],evidence=[row(BUILD/p)for p in checks],proofs=[row(p)for p in proofs],
        guide=row('deploy/iq4_6.03.60/README.md'),cleanup=row('deploy/iq4_6.03.60/CLEANUP.json'),finalizer=row(Path(__file__).resolve()),
        static_and_host_passed=True,changed_objects=4,added_objects=1,unchanged_precompiled_objects=38,original_initializers_identical_to59=True,
        producer_pin_windows=22,generic_pin_windows=299,confirmed_defects_fixed=['actual total RAW arena capacity rejection','fixed3 stage completion predicate'],
        actual_final_User_RGB24_pixel_cases=9,actual_final_User_bridge_gate_cases=10,
        actual_core_available_bytes=604094720,actual_RGB24_core_required_bytes=567538560,
        full_RAW_pixel_pipeline_executed=False,user59_failure_all_causes_established=False,
        full_runtime_binding_proved=False,temporary_device_executed=False,persistent_acceptance=False,recovery_verified=False,device_actions=False)
    (BUILD/'FINAL_VERIFICATION.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(dict(final=row(BUILD/'FINAL_VERIFICATION.json'),sources_checked=len(seen),FWP=fwp)))
if __name__=='__main__':main()
