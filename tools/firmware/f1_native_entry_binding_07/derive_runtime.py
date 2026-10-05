#!/usr/bin/env python3
"""Own UI07 runtime derived from frozen Display06. No target operation."""
from pathlib import Path
import difflib,hashlib
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def derive():
 p=HERE.parent/'f1_display_observe_06/runtime_linux.cpp';s=p.read_text();original=s
 s='#include "bridge.hpp"\n'+s
 s=s.replace('#include "observe.hpp"','#include "../f1_display_observe_06/observe.hpp"')
 needle='extern "C" {__attribute__((visibility("default")))';assert s.count(needle)==1;s=s.replace(needle,'extern "C" unsigned iq4_f1_role_ctor_status;\nextern "C" __attribute__((visibility("default"))) iq4::f1::entry07::Published iq4_f1_entry_binding_observed_07;\niq4::f1::entry07::Published iq4_f1_entry_binding_observed_07;\n'+needle)
 needle='alignas(Module) unsigned char module_storage';assert s.count(needle)==1
 s=s.replace(needle,'alignas(iq4::f1::entry07::BoundaryBridge) unsigned char entry07_storage[sizeof(iq4::f1::entry07::BoundaryBridge)]{};\niq4::f1::entry07::BoundaryBridge* entry07_bridge=nullptr;\n'+needle)
 needle='    original_paint.store(0x51da0c,std::memory_order_release);';assert s.count(needle)==1
 s=s.replace(needle,'    entry07_bridge=new(entry07_storage)iq4::f1::entry07::BoundaryBridge;\n'+needle)
 needle='__attribute__((constructor)) void prepare() noexcept {';assert s.count(needle)==1
 addition='''// Protected entry-only admission from Root's separately reviewed new UI07
// deployment contract. Absence/unknown/failure stays OFF. This file does not
// attest geometry, source coverage, paint freshness, or Surface lifetime.
bool entry07_admission(iq4::f1::entry07::Placement& placement) noexcept {
    if(iq4_f1_role_ctor_status!=4)return false;
    const char*path="/run/iq4_f1_observe02/ui07.entry";
    struct stat d{},a{},b{},c{};
    if(::lstat("/run/iq4_f1_observe02",&d)||!S_ISDIR(d.st_mode)||d.st_uid||d.st_gid||(d.st_mode&07777)!=0700||
       ::lstat(path,&a)||!S_ISREG(a.st_mode)||a.st_uid||a.st_gid||(a.st_mode&07777)!=0600||a.st_nlink!=1||a.st_size<=0||a.st_size>=96)return false;
    int fd=static_cast<int>(raw_call(SYS_openat,AT_FDCWD,reinterpret_cast<long>(path),O_RDONLY|O_CLOEXEC|O_NOFOLLOW));if(fd<0)return false;
    char text[96]{},canonical[96]{};bool ok=!::fstat(fd,&b)&&a.st_dev==b.st_dev&&a.st_ino==b.st_ino&&a.st_size==b.st_size&&a.st_mode==b.st_mode&&a.st_uid==b.st_uid&&a.st_gid==b.st_gid&&b.st_nlink==1;
    long n=ok?raw_call(SYS_read,fd,reinterpret_cast<long>(text),b.st_size):-1;char extra{};
    ok=ok&&n==b.st_size&&raw_call(SYS_read,fd,reinterpret_cast<long>(&extra),1)==0&&!::fstat(fd,&c)&&b.st_dev==c.st_dev&&b.st_ino==c.st_ino&&b.st_size==c.st_size&&b.st_mtim.tv_sec==c.st_mtim.tv_sec&&b.st_mtim.tv_nsec==c.st_mtim.tv_nsec;
    rclose(fd);int x=-1,y=-1;char tail{};
    if(!ok||::sscanf(text,"IQ4_F1_UI07_ENTRY_ONLY %d %d%c",&x,&y,&tail)!=3||tail!='\\n'||x<0||y<0||x>32767||y>32767)return false;
    int size=::snprintf(canonical,sizeof canonical,"IQ4_F1_UI07_ENTRY_ONLY %d %d\\n",x,y);
    if(size!=n||std::memcmp(text,canonical,static_cast<std::size_t>(n))||::lstat(path,&c)||b.st_dev!=c.st_dev||b.st_ino!=c.st_ino||b.st_size!=c.st_size)return false;
    placement={x,y};return true;
}
'''
 s=s.replace(needle,addition+needle)
 needle='caller==0x6be8ac && result==0 && diagnostic_ready.load(std::memory_order_acquire) && !inside';assert s.count(needle)==1
 s=s.replace(needle,'caller==0x6be8ac && result==0 && (diagnostic_ready.load(std::memory_order_acquire) || (entry07_bridge&&entry07_bridge->admitted())) && !inside')
 needle='        inside=false;';assert s.count(needle)==1
 addition='''        if(entry07_bridge&&display_collector){
            iq4::f1::entry07::Placement placement{};
            if(!entry07_bridge->admitted()&&entry07_admission(placement))
                (void)entry07_bridge->admit_once({true,true,true,true},placement);
            entry07_bridge->after_original_unlock_on_ui({nullptr,self_read},*module,*display_collector,input,
                {reinterpret_cast<int(*)(void*)>(original_try_lock.load(std::memory_order_acquire)),reinterpret_cast<int(*)(void*)>(original_unlock.load(std::memory_order_acquire))});
            iq4_f1_entry_binding_observed_07.sequence.fetch_add(1,std::memory_order_acq_rel);
            iq4_f1_entry_binding_observed_07.metadata=entry07_bridge->binding().status_on_ui();
            iq4_f1_entry_binding_observed_07.sequence.fetch_add(1,std::memory_order_release);
            if(iq4_f1_entry_binding_observed_07.metadata.ui_mutation_attempted){
                auto changed=display_collector->snapshot();changed.native_ui_mutation_called=1;
                iq4::f1::display06::publish(iq4_f1_display_observed_06,changed);
            }
        }
'''
 s=s.replace(needle,addition+needle)
 # Prepared default exports have no public admit/setter function. Only the
 # protected, new-module-specific entry-only contract can stage this marker.
 return original,s
def main():
 assert not(HERE/'SOURCE_SHA256.json').exists(),'Frozen source cannot be changed'
 original,s=derive();(HERE/'runtime_linux.cpp').write_text(s);(HERE/'RUNTIME_DIFF.txt').write_text(''.join(difflib.unified_diff(original.splitlines(True),s.splitlines(True),fromfile='frozen_display06/runtime_linux.cpp',tofile='new_entry07/runtime_linux.cpp')))
 print(hashlib.sha256(s.encode()).hexdigest())
if __name__=='__main__':main()
