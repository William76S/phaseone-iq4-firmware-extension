#!/usr/bin/env python3
"""Finite original request identity instructions; no queue, pixels or device.

Execute producer node/index/pointer setup, then the original queue-to-worker
request assignment's scalar/pointer section. The live queue and string copy are
not simulated as success. Original queue caller and worker sret setup are pinned.
"""
from pathlib import Path
import sys, json, hashlib
ROOT=Path(__file__).resolve().parents[3]
sys.path.insert(0,str(ROOT/'analysis/firmware/jpeg_replay_rethink_01'))
from emulate_boundaries import Machine, SP, M, X, SHA
from unicorn.arm64_const import UC_ARM64_REG_X8
OUT=Path(sys.argv[1]).resolve(); assert OUT.is_relative_to(ROOT) and not OUT.exists()
m=Machine(); u=m.u; node=M+0x2000; reader=M+0x3000; cache=M+0x4000
request=SP+0xa8; worker_request=SP+0x400
m.put(SP+0x360,node);m.put(SP+0x380,reader);m.put(SP+0x388,cache)
m.put(node+0xdc,12,'<I');m.put(SP+0x70,314159,'<I')
m.put(SP+0x68,M+0x5000);m.put(SP+0x60,M+0x5100)
m.run(0x48c898,0x48c8d4)
assert m.get(request+0x28,'<I')==12
assert m.get(request+0x38)==reader and m.get(request+0x58)==node
# 490098 uses x8 as destination then 4900cc invokes 48fea8(dest,queue+c0).
# Execute the unchanged scalar/pointer assignment after its string operation.
m.put(SP+0x10,request);m.put(SP+0x18,worker_request)
m.run(0x48fedc,0x48ff8c)
assert m.get(SP+0x428,'<I')==12
assert m.get(SP+0x438)==reader and m.get(SP+0x458)==node
m.run(0x7b74d0,0x7b74d8);assert u.reg_read(UC_ARM64_REG_X8)==worker_request
result=dict(schema='iq4_native_half_request_identity_a64_01',stock_sha256=SHA,
 original_producer_identity_instructions=True,original_catalog_photo_index_getter=True,
 original_request_pointer_assignment=True,original_worker_sret_setup=True,
 producer_request_frame_offset='0xa8',worker_request_frame_offset='0x400',
 request_photo_index_offset='0x28',request_catalog_node_offset='0x58',request_raw_reader_offset='0x38',
 worker_photo_index_offset='0x428',worker_catalog_node_offset='0x458',worker_raw_reader_offset='0x438',
 pointer_distinction_proved=True,fixture_photo_index=12,synthetic_pointer_memory=True,
 live_queue_executed=False,string_copy_executed=False,native_pixels=False,camera_access=False)
OUT.write_text(json.dumps(result,indent=2)+'\n');print(hashlib.sha256(OUT.read_bytes()).hexdigest())
