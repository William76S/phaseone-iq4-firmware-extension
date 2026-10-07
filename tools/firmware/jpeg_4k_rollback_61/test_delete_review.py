#!/usr/bin/env python3
"""Finite independent deletion identity/ABI evidence. No camera or real I/O."""
from pathlib import Path
import hashlib,json,subprocess
R=Path(__file__).resolve().parents[3];D=Path(__file__).resolve().parent;O=R/'analysis/firmware/jpeg_4k_rollback_61_audit';P=R/'tools/firmware/jpeg_pair_delete_61';B=R/'analysis/firmware/jpeg_pair_delete_61/build'
def row(p):b=p.read_bytes();return dict(path=str(p.relative_to(R)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
inputs=[D/'gallery.cpp',D/'test_gallery_delete.cpp',Path(__file__),R/'tools/firmware/stock_jpeg_gallery_55/gallery.cpp',P/'pair.cpp',P/'wrappers.S',P/'pins.h',B/'pair.o',B/'wrappers.o',O/'prove_pair_abi.py',R/'analysis/firmware/extracted/P1Linux_6.03.21.bin'];locks=[row(p)for p in inputs];commands=[]
def cmd(argv):
 q=subprocess.run([str(x)for x in argv],cwd=R,capture_output=True,text=True);commands.append(dict(argv=list(map(str,argv)),exit=q.returncode,stdout=q.stdout,stderr=q.stderr));assert q.returncode==0,commands[-1];return q.stdout
sdk='/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk'
cmd(['/usr/bin/clang++','-isysroot',sdk,'-isystem',sdk+'/usr/include/c++/v1','-std=c++17','-O2','-ffunction-sections','-fdata-sections','-Wl,-dead_strip',D/'test_gallery_delete.cpp','-o',O/'test_gallery_delete'])
cmd([O/'test_gallery_delete'])
cmd([R/'build/dual-exposure-host-venv/bin/python',O/'prove_pair_abi.py'])
frames=cmd(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','--dwarf=frames',B/'wrappers.o']);assert frames.count('FDE cie=')==3 and 'CFA=reg31+32: reg29=[CFA-32], reg30=[CFA-24]'in frames
(O/'PAIR61_WRAPPER_CFI.txt').write_text(frames)
assert locks==[row(p)for p in inputs]
report=dict(schema='iq4_61_independent_gallery_identity_pair_wrapper_review',inputs=locks,commands=commands,host_cases=20,native_File_FS_delete_cases=4,actual_wrapper_count=3,caller_owns_catalog_mutex=True,new_registry_nativecalls_reads_locks_zero=True,wrapper_CFI_static_review=True,exception_unwind_execution=False,production_pair_helper_executed_by_this_script=False,actual_camera_or_card_IO=False)
(O/'PAIR61_REVIEW.json').write_text(json.dumps(report,indent=2)+'\n')
(O/'PAIR61_SOURCE_SHA256.json').write_text(json.dumps(dict(schema='iq4_61_pair_gallery_independent_review_supplement',files=locks+[row(O/x)for x in ['PAIR61_REVIEW.json','PAIR61_A64_ABI.json','PAIR61_WRAPPER_CFI.txt']]),indent=2)+'\n')
print(json.dumps(dict(receipt=row(O/'PAIR61_REVIEW.json'),lock=row(O/'PAIR61_SOURCE_SHA256.json'))))
