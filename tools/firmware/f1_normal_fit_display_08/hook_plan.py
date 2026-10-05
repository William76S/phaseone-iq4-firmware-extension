#!/usr/bin/env python3
"""Exact static patch-byte prototype; never opens process memory or executes it."""
from pathlib import Path
import hashlib,json,struct
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
ENTRY=0x47f910
FIRST=0xd10403ff
USER_SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
def branch(source,target):
 if type(source)is not int or type(target)is not int or source<0 or target<0 or source>=1<<64 or target>=1<<64 or source%4 or target%4:raise ValueError('AArch64 aligned exact integer address required')
 delta=target-source
 if not -(1<<27)<=delta<(1<<27):raise ValueError('B imm26 out of signed range')
 return 0x14000000|((delta//4)&0x3ffffff)
def destination(source,word):
 if word&0xfc000000!=0x14000000:raise ValueError('unconditional B only')
 d=word&0x3ffffff
 if d&(1<<25):d-=1<<26
 return source+d*4
def plan(near_entry,near_trampoline,bridge,first_word=FIRST):
 if first_word!=FIRST:raise ValueError('original first instruction differs')
 if type(bridge)is not int or bridge<=0 or bridge>=1<<64 or bridge%4:raise ValueError('exact own bridge VA required')
 # LDR x16,[PC,+8]; BR x16; own 64-bit bridge literal. No original
 # PC-relative instruction or register/input argument is relocated.
 veneer=struct.pack('<IIQ',0x58000050,0xd61f0200,bridge)
 patch=struct.pack('<I',branch(ENTRY,near_entry))
 trampoline=struct.pack('<II',FIRST,branch(near_trampoline+4,ENTRY+4))
 if near_entry<near_trampoline+8 and near_trampoline<near_entry+16:raise ValueError('near regions overlap')
 return {'schema':'iq4_f1_scaler_entry_static_plan_v8','UserSHA':USER_SHA,'entry':ENTRY,'original_word':FIRST,'patch_hex':patch.hex(),'near_entry':near_entry,'near_veneer_hex':veneer.hex(),'near_trampoline':near_trampoline,'original_trampoline_hex':trampoline.hex(),'own_bridge':bridge,
 'target_loaded':False,'target_text_written':False,'ready_to_install':False,
 'requires_actual':['exact_User_exe_inode_whole_hash_and_all_executable_mapping_bytes','sole_controller_current_UI_owner_and_no_other_thread_in_entry_or_trampoline','actual_near_mmap_RW_to_RX_policy_and_addresses_with_no_MAP_FIXED_clobber','target_page_exact_current_permissions_and_W_to_RX_restore','single_aligned_instruction_atomic_store_and_AArch64_Dcache_Icache_barriers_on_all_relevant_cores','atomic_unpatch_only_when_all_hook_calls_quiescent_then_verified_original_word','original_provider_target_complete_body_and_Surface_lifetime_scope','callback_unwind_registration_accepted_and_no_unhandled_callback_throw']}
def source_evidence():
 p=ROOT/'analysis/firmware/f1_geometry_probe_03/static/Scaler_dispatch_complete.txt'
 text=p.read_text();assert '47f910: d10403ff' in text and '47f914: a9057bfd' in text
 q=ROOT/'analysis/firmware/f1_geometry_probe_03/static/exact_bytes.json';d=json.loads(q.read_text())
 return {'disassembly':str(p.relative_to(ROOT)),'sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'exact_bytes_manifest':str(q.relative_to(ROOT)),'manifest_sha256':hashlib.sha256(q.read_bytes()).hexdigest(),'manifest_schema':d.get('schema')}
if __name__=='__main__':print(json.dumps({'prep_only':True,'commands':[],'source':source_evidence(),'target_text_written':False,'target_loaded':False,'ready_to_install':False,'actual_near_addresses':None},indent=2))
