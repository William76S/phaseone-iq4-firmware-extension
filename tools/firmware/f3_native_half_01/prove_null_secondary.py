#!/usr/bin/env python3
"""Original Preview half argument/control path, no decode or pixel dispatch.
Synthetic memory enters AFTER original RAW decode at the native branch. The
unchanged pipeline/core allocation executes. A documented simulated core-return
boundary then verifies the normal no-rotation continuation skips secondary.
"""
from pathlib import Path
import sys,json,struct,hashlib
ROOT=Path(__file__).resolve().parents[3];sys.path.insert(0,str(ROOT/'analysis/firmware/jpeg_replay_rethink_01'))
from emulate_stripe_pipeline import PipelineMachine,M,SP,STOP,X,SHA
from unicorn import UC_HOOK_CODE
from unicorn.arm64_const import *
OUT=Path(sys.argv[1]).resolve();assert OUT.is_relative_to(ROOT)
m=PipelineMachine();u=m.u;settings=M+0x1000;gen=M+0x2000;main=M+0x7300;source=SP+0x258;arena=SP+0x4e0
m.call(0x7bbc54,[settings]);m.put(settings,.5,'<f');m.put(settings+4,14204.,'<f');m.put(settings+8,10652.,'<f');m.put(settings+0x20,5,'<I');m.put(settings+0x30,0,'<I')
for off,v in [(0x2b8,0),(0x2bc,0),(0x2c0,14204),(0x2c4,10652)]:m.put(settings+off,v,'<I')
m.call(0x904550,[source]);m.call(0x9041f0,[source,14204,10652,1,28416,M+0x6000,0]);m.call(0x904550,[main])
m.put(SP+0xf8,M+0x8000);m.put(SP+0x100,609573888);m.put(SP+0xf0,0)
regs={UC_ARM64_REG_X19:settings,UC_ARM64_REG_X20:gen,UC_ARM64_REG_X21:arena,UC_ARM64_REG_X24:main,UC_ARM64_REG_X25:main,UC_ARM64_REG_X28:0,UC_ARM64_REG_D8:0,UC_ARM64_REG_D9:M+0x7400,UC_ARM64_REG_D11:M+0x7500}
for r,v in regs.items():u.reg_write(r,v)
u.reg_write(UC_ARM64_REG_SP,SP);u.reg_write(UC_ARM64_REG_LR,STOP)
captured={}
def before(u,pc,size,data):
 if pc==0x964860:
  captured['args']=[u.reg_read(x) for x in X];captured['ninth']=m.get(SP)
  captured['callee_saved']={r:u.reg_read(r) for r in regs}
u.hook_add(UC_HOOK_CODE,before)
u.emu_start(0x9647ec,0x919f0c,count=200000);assert u.reg_read(UC_ARM64_REG_PC)==0x919f0c
assert captured['args'][3]==0 and captured['args'][4]==0 and captured['ninth']==0
buffers=m.buffer_descriptors;assert sum(r['actual_byte_count'] for r in buffers)==605374464
# No actual pixel processing is claimed. Simulate only a normal core return;
# factory Preview uses callee-saved values retained by original core ABI.
for r,v in captured['callee_saved'].items():u.reg_write(r,v)
u.reg_write(UC_ARM64_REG_SP,SP);u.reg_write(UC_ARM64_REG_LR,STOP)
u.emu_start(0x964864,0x9641a0,count=200000);assert u.reg_read(UC_ARM64_REG_PC)==0x9641a0
r=dict(schema='iq4_native_half_null_secondary_a64_01',stock_sha256=SHA,original_preview_argument_setup=True,original_core_allocation=True,source_geometry=[14204,10652],working_scale=.5,core_args=[hex(x) for x in captured['args']],ninth_auxiliary=captured['ninth'],core_secondary_null=True,core_planar_null=True,buffers=buffers,actual_capacity_passed=True,normal_continuation_stop='0x9641a0',original_primary_equals_requested_output=True,secondary_getter_not_called=True,libc_host_shims=m.shims,synthetic_predecoded_geometry=True,simulated_normal_core_return_boundary=True,raw_decoded=False,pixels_processed=False,jpeg_encoded=False,camera_access=False)
OUT.write_text(json.dumps(r,indent=2)+'\n');print(hashlib.sha256(OUT.read_bytes()).hexdigest())
