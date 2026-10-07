#!/usr/bin/env python3
"""Finite 61 accessor/menu host checks and unchanged storage source slices."""
from pathlib import Path
import hashlib,json,subprocess,difflib
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/jpeg_4k_rollback_61_audit'
def row(p):b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def body(text,needle):
 at=text.index(needle);start=text.index('{',at)
 while text.find(';',at,start)>=0:
  at=text.index(needle,at+len(needle));start=text.index('{',at)
 depth=1;end=start+1
 while depth:
  if text[end]=='{':depth+=1
  elif text[end]=='}':depth-=1
  end+=1
 return text[at:end]
src=HERE/'runtime.cpp';menu=HERE/'menu.c';before=ROOT/'tools/firmware/half_render_contract_60/runtime.cpp'
paths=[src,menu,HERE/'size.h',HERE/'test_size.cpp',HERE/'test_menu.c',Path(__file__),before,ROOT/'tools/firmware/half_render_contract_60/menu.c',ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin']
locks=[row(p)for p in paths]
old=before.read_text();new=src.read_text()
unchanged=['static int power_shape(', 'static int identities(', 'static int leases_clear(', 'static void route(', 'static void source_route(', 'static int prepare_route(', 'static int backup_clients_quiet(', 'static int archive_prepare_only(', 'static int publish_card(', 'static int publish_buffer(', 'static int write_guard(', 'static int receipt_removed(', 'static int receipt_backup_quiet(', 'extern "C" uintptr_t iq4_stock_jpeg_pending_clear_guard_55(', 'extern "C" int iq4_stock_delete_lookup_guard_55(']
for needle in unchanged:assert body(old,needle)==body(new,needle),needle
expect=body(old,'static int failed_pending_retire(').replace('||\n  __atomic_load_n(&half_transaction.state,__ATOMIC_ACQUIRE)!=HALF_IDLE','')
assert expect==body(new,'static int failed_pending_retire(')
assert all(x not in new for x in ['HALF_HOLD','half_choice','half_transaction','iq4_stock_half_settings_load_01','iq4_stock_half_inner_wait_55','iq4_half_jpeg_encode_01'])
assert 'i<24' in menu.read_text() and 'i<22' in menu.read_text()
commands=[]
def cmd(argv):
 r=subprocess.run([str(x)for x in argv],cwd=ROOT,text=True,capture_output=True);commands.append(dict(argv=[str(x)for x in argv],exit=r.returncode,stdout=r.stdout,stderr=r.stderr));assert r.returncode==0,commands[-1]
sdk='/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk'
cmd(['/usr/bin/clang++','-isysroot',sdk,'-isystem',sdk+'/usr/include/c++/v1','-std=c++17','-O2','-ffunction-sections','-fdata-sections','-Wl,-dead_strip',HERE/'test_size.cpp','-o',OUT/'test_size'])
cmd([OUT/'test_size'])
cmd(['/usr/bin/clang','-std=c11','-O2',HERE/'test_menu.c','-o',OUT/'test_menu'])
cmd([OUT/'test_menu'])
assert locks==[row(p)for p in paths]
(OUT/'HOST61.json').write_text(json.dumps(dict(schema='iq4_61_4k_only_finite_host_accessors_menu_review',inputs=locks,commands=commands,preserved_source_functions=unchanged,failed_pending_only_removed_half_idle_guard=True,menu_tables_full24_and22=True,fixture_boundaries=['backend object shapes and scalar native enum getters/setters','settings lock and busy counters','native UI allocation/constructor/append and event queue','menu reads actual original ELF pins/vtables, not copies of expected pin tables'],native_job_return_simulated=False,native_render_encode_card_publish_executed=False,camera_accessed=False),indent=2)+'\n')
(OUT/'RUNTIME61.diff').write_text(''.join(difflib.unified_diff(old.splitlines(True),new.splitlines(True),fromfile=str(before.relative_to(ROOT)),tofile=str(src.relative_to(ROOT)))))
(OUT/'MENU61.diff').write_text(''.join(difflib.unified_diff(paths[7].read_text().splitlines(True),menu.read_text().splitlines(True),fromfile=str(paths[7].relative_to(ROOT)),tofile=str(menu.relative_to(ROOT)))))
(OUT/'HOST61_SOURCE_SHA256.json').write_text(json.dumps(dict(schema='iq4_61_finite_host_review_supplement',files=locks+[row(OUT/x)for x in ['HOST61.json','RUNTIME61.diff','MENU61.diff']]),indent=2)+'\n')
print(json.dumps(dict(receipt=row(OUT/'HOST61.json'),lock=row(OUT/'HOST61_SOURCE_SHA256.json'))))
