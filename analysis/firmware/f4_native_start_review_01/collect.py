#!/usr/bin/env python3
"""Read-only original User windows for native LV start and queue initialisation."""
import bisect, hashlib, json, re, struct, subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
OUT = Path(__file__).resolve().parent
USER = ROOT / 'analysis/firmware/extracted/P1Linux_6.03.21.bin'
EXPECTED = '9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
raw = USER.read_bytes()
assert len(raw) == 11874544 and hashlib.sha256(raw).hexdigest() == EXPECTED
starts = json.loads((ROOT/'analysis/firmware/unwind_functions.json').read_text())['functions']
ranges = {}
def add(name, va):
    i = bisect.bisect_right(starts, va)-1
    ranges[(starts[i], starts[i+1])] = name
for name,va in [
    ('NativeLVStart',0x5202a0),('NativeLVStop',0x520590),('NativeLVResume',0x5208cc),
    ('NativeLVEnter',0x51d884),('NativeLVExit',0x51d9bc),
    ('AccessAcquire',0x6b5a6c),('AccessPrepare',0x6b5d3c),('AccessStart',0x6b5da0),
    ('AccessStop',0x6b5ec8),('AccessRelease',0x6b5c44),
    ('QueueGlobalLock',0x712790),('MutexLock',0x71242c),('MutexUnlock',0x71248c),
    ('LV_ctor',0x5175b8),('Access_ctor',0x6b56ec),('ThreadActive',0x712000),
    ('GthreadMutexLock',0x712324),('GthreadMutexTryLock',0x712360),
    ('GthreadMutexUnlock',0x71239c),
]: add(name,va)
# Finite direct ADRP references to this original global page, used solely to
# locate whole unwind-delimited original functions, never target addresses.
page_refs = []
for offset in range(0, min(len(raw)-4, 0x600000), 4):
    w=struct.unpack_from('<I',raw,offset)[0]
    if w & 0x9f000000 != 0x90000000: continue
    imm=((w>>29)&3)|(((w>>5)&0x7ffff)<<2)
    if imm & (1<<20): imm-=1<<21
    va=offset+0x400000
    target=(va & ~0xfff)+(imm<<12)
    if target == 0xf55000:
        page_refs.append(hex(va))
rows=[]
for (va,end),name in sorted(ranges.items()):
    b=raw[va-0x400000:end-0x400000]
    dis=subprocess.check_output(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d',f'--start-address={va:#x}',f'--stop-address={end:#x}',str(USER)],text=True)
    lines=[x.split(' <')[0].split(' //')[0].rstrip() for x in dis.splitlines() if re.match(r'  [0-9a-f]+:',x)]
    p=OUT/(name+'.asm');p.write_text('Original User SHA256 '+EXPECTED+'\nSTATIC ONLY\n'+'\n'.join(lines)+'\n')
    rows.append(dict(name=name,va=hex(va),end=hex(end),bytes_hex=b.hex(),bytes_sha256=hashlib.sha256(b).hexdigest(),path=str(p.relative_to(ROOT)),file_sha256=hashlib.sha256(p.read_bytes()).hexdigest()))
result=dict(schema='iq4_f4_native_start_static_review_01',input_sha256=EXPECTED,input_bytes=len(raw),target_executed=False,camera_access=False,global_queue_page_direct_refs=page_refs,windows=rows)
# Original loader mapping matters for writable global data (not VA-0x400000).
eh=struct.unpack_from('<16sHHIQQQIHHHHHH',raw)
ph=[struct.unpack_from('<IIQQQQQQ',raw,eh[5]+56*i) for i in range(eh[10])]
sh=[struct.unpack_from('<IIQQQQIIQQ',raw,eh[6]+64*i) for i in range(eh[12])]
globals=[]
for va,n in [(0xf553a8,8),(0xf553c0,48)]:
    hits=[p[2]+va-p[3] for p in ph if p[0]==1 and p[3]<=va and va+n<=p[3]+p[5]]
    assert len(hits)==1
    b=raw[hits[0]:hits[0]+n]
    relocations=[]
    for s in sh:
        if s[1]!=4:continue
        assert s[9]==24
        for at in range(s[4],s[4]+s[5],24):
            target,info,addend=struct.unpack_from('<QQq',raw,at)
            if va<=target<va+n:relocations.append(dict(target=hex(target),info=hex(info),addend=addend))
    globals.append(dict(va=hex(va),file_offset=hex(hits[0]),bytes_hex=b.hex(),sha256=hashlib.sha256(b).hexdigest(),target_relocations=relocations))
result['global_original_data']=globals
(OUT/'EXACT.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(dict(windows=len(rows),page_refs=len(page_refs),exact_sha256=hashlib.sha256((OUT/'EXACT.json').read_bytes()).hexdigest())))
