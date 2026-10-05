#!/usr/bin/env python3
"""Build project-owned host tests + AArch64 object; never run target object."""
import argparse
import hashlib
import json
import struct
import subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    p=argparse.ArgumentParser();p.add_argument("--out",type=Path,default=ROOT/"analysis/sdk_reference/f4_ui_counter_host_01");p.add_argument("--zig",type=Path,default=ROOT/"build/toolchains/zig-aarch64-macos-0.15.2/zig");a=p.parse_args()
    out=a.out.resolve();out.mkdir(parents=True,exist_ok=True);commands=[]
    def run(argv):
        cmd=[str(x) for x in argv];commands.append(cmd);r=subprocess.run(cmd,cwd=ROOT,text=True,capture_output=True)
        if r.returncode:raise SystemExit(r.stdout+r.stderr)
        return r.stdout
    sdk=run(["xcrun","--show-sdk-path"]).strip()
    common=["/usr/bin/clang++","-std=c++17","-O2","-Wall","-Wextra","-Wpedantic","-Werror","-isystem",str(Path(sdk)/"usr/include/c++/v1"),"-DIQ4_F4_SYNTHETIC_HOST=1"]
    tests={}
    for name,flags in [("normal",[]),("asan_ubsan",["-fsanitize=address,undefined","-fno-omit-frame-pointer"])]:
        exe=out/("host_"+name);run([*common,*flags,HERE/"counter.cpp",HERE/"test_counter.cpp","-o",exe]);receipt=run([exe])
        if receipt!="18 SDK-free synthetic counter groups passed; notification count is not source FPS\n":raise SystemExit("unexpected host test receipt")
        (out/(name+".txt")).write_text(receipt);tests[name]={"exit_code":0,"receipt":receipt.strip(),"binary_sha256":sha(exe)}
    exe=out/"host_production_address_reject"
    run([*[x for x in common if x!="-DIQ4_F4_SYNTHETIC_HOST=1"],HERE/"counter.cpp",HERE/"test_binding_reject.cpp","-o",exe]);receipt=run([exe])
    if receipt!="2 production-address guard groups passed; zero native calls\n":raise SystemExit("production guard test failed")
    (out/"production_address_reject.txt").write_text(receipt);tests["production_address_reject"]={"exit_code":0,"receipt":receipt.strip(),"binary_sha256":sha(exe)}
    lock=json.loads((ROOT/"tools/target/toolchain.lock.json").read_text())
    if sha(a.zig)!=lock["zig_binary_sha256"] or run([a.zig,"version"]).strip()!=lock["version"]:raise SystemExit("fixed Zig changed")
    obj=out/"counter.aarch64.o"
    run([a.zig,"c++","-target",lock["target"],"-std=c++17","-O2","-fPIC","-Wall","-Wextra","-Wpedantic","-Werror","-c",HERE/"counter.cpp","-o",obj])
    raw=obj.read_bytes()
    if raw[:7]!=b"\x7fELF\x02\x01\x01" or struct.unpack_from("<HH",raw,16)!=(1,183):raise SystemExit("not ELF64 AArch64 ET_REL")
    report={"camera_operations":False,"sdk_loaded":False,"original_target_code_executed":False,"target_object_executed":False,"tests":tests,"target_object":{"bytes":len(raw),"sha256":sha(obj),"format":"ELF64 LE AArch64 ET_REL","synthetic_macro_present":False},"commands":commands,"sources":{str(x.relative_to(ROOT)):sha(x) for x in [HERE/"counter.hpp",HERE/"counter.cpp",HERE/"test_counter.cpp",HERE/"test_binding_reject.cpp",Path(__file__).resolve()]}}
    (out/"HOST_VALIDATION.json").write_text(json.dumps(report,indent=2)+"\n")
    print("18/18 normal + 18/18 ASan/UBSan + 2/2 production address guards; exact-toolchain AArch64 object only; no target execution")
if __name__=="__main__":main()
