#!/usr/bin/env python3
from pathlib import Path
import hashlib,json
R=Path(__file__).resolve().parents[3];D=Path(__file__).resolve().parent;O=R/'analysis/firmware/stock_new_raw_receipt_55';B=O/'build'
def row(p):return dict(path=p.relative_to(R).as_posix(),bytes=p.stat().st_size,sha256=hashlib.sha256(p.read_bytes()).hexdigest())
exact=json.loads((O/'EXACT.json').read_text());files=[p for p in D.iterdir() if p.is_file() and p.name not in ['SOURCE_SHA256.json','LINK_INPUTS.json']]
files += [B/'receipt.o',B/'wrappers.o',B/'COMMANDS.json',B/'BUILD.json',O/'EXACT.json',O/'NATIVE_A64.json',O/'STORAGE_MODE_A64.json']
files += list(O.glob('*.asm'))
manifest=dict(schema='iq4_new_raw_receipt55_source_lock',stock_sha256=exact['stock_sha256'],files=[row(p)for p in sorted(set(files))],camera_accessed=False,target_device_executed=False)
(D/'SOURCE_SHA256.json').write_text(json.dumps(manifest,indent=2)+'\n')
newfunctions=['iq4_new_raw_bind_55','iq4_new_raw_settings_enter_55','iq4_new_raw_settings_leave_55','iq4_new_raw_active_55','iq4_new_raw_policy_55','iq4_new_raw_acquire_55','iq4_new_raw_publication_55','iq4_new_raw_end_55','iq4_new_raw_backup_suppressed_55']
newfunctions+=list(dict.fromkeys(h['target_symbol']for h in exact['hooks']))
link=dict(schema='iq4_new_raw_receipt55_link_inputs',source_manifest=str((D/'SOURCE_SHA256.json').relative_to(R)),source_manifest_sha256=row(D/'SOURCE_SHA256.json')['sha256'],objects=[row(B/'receipt.o'),row(B/'wrappers.o')],runtime_pin_header=str((D/'pins.h').relative_to(R)),runtime_pin_header_sha256=row(D/'pins.h')['sha256'],BL_hooks=[{k:v for k,v in h.items()if k!='original_kind'}for h in exact['hooks']if h['original_kind']=='BL'],auxiliary_hooks=[{k:v for k,v in h.items()if k not in ['original_kind','original_target']}for h in exact['hooks']if h['original_kind']=='BLR'],aliases=[dict(symbol=name,va=va)for name,va in exact['aliases'].items()],new_required_functions=newfunctions,external_pin_exclusion_sites=exact['externally_consumed_patch_sites'],host_groups=26,camera_accessed=False,target_device_executed=False)
(D/'LINK_INPUTS.json').write_text(json.dumps(link,indent=2)+'\n')
print(json.dumps(dict(source_manifest=row(D/'SOURCE_SHA256.json'),link_inputs=row(D/'LINK_INPUTS.json'),objects=link['objects']),indent=2))
