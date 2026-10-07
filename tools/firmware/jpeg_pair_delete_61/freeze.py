#!/usr/bin/env python3
from pathlib import Path
import hashlib,json
R=Path(__file__).resolve().parents[3];D=Path(__file__).resolve().parent;O=R/'analysis/firmware/jpeg_pair_delete_61';B=O/'build'
def row(p):
 p=Path(p);data=p.read_bytes();return dict(path=str(p.relative_to(R)),bytes=len(data),sha256=hashlib.sha256(data).hexdigest())
exact=json.loads((O/'EXACT.json').read_text());assert len(exact['BL_hooks'])==3
source=[row(p)for p in sorted(D.glob('*'))if p.is_file()]+[row(R/'tools/firmware/native_runtime_01/self_read.h')]
receipts=[row(O/'EXACT.json'),row(O/'A64_ORIGINAL_GAP.json'),row(B/'BUILD.json'),row(B/'COMMANDS.json')]
source_doc=dict(schema='iq4_pair_delete61_source',members=source,readonly_inputs=receipts,camera_accessed=False)
sp=O/'SOURCE_SHA256.json';sp.write_text(json.dumps(source_doc,indent=2)+'\n')
stock=R/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
import importlib.util
p=R/'analysis/firmware/half_request_owner_independent_59/verify_final.py';s=importlib.util.spec_from_file_location('pair_freeze_elf',p);m=importlib.util.module_from_spec(s);s.loader.exec_module(m);e=m.Elf(stock)
link=dict(schema='iq4_pair_delete61_link_inputs',objects=[row(B/'pair.o'),row(B/'wrappers.o')],BL_hooks=exact['BL_hooks'],auxiliary_hooks=[],aliases=[dict(symbol='iq4_pair_original_sd_mode_get_61',va=0x495448,kind='original imported routine',original_first16_LE=e.va(0x495448,16).hex())],required_functions=['iq4_jpeg_pair_raw_delete_61','iq4_jpeg_only_delete_61','iq4_jpeg_pair_sd_raw_wrapper_61','iq4_jpeg_pair_xqd_raw_wrapper_61','iq4_jpeg_only_delete_wrapper_61'],required_external_functions=['iq4_stock_jpeg_gallery_delete_card_61','iq4_stock_jpeg_gallery_delete_path_61','iq4_stock_jpeg_gallery_forget_deleted_61'],source_manifest=str(sp.relative_to(R)),source_manifest_sha256=row(sp)['sha256'],source_manifests=[row(sp)],receipts=receipts,pin_headers=[str((D/'pins.h').relative_to(R))],camera_accessed=False,device_accepted=False)
lp=O/'LINK_INPUTS.json';lp.write_text(json.dumps(link,indent=2)+'\n');print(json.dumps(dict(source=row(sp),link=row(lp),objects=link['objects'])))
