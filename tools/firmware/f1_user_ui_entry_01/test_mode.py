#!/usr/bin/env python3
"""Only owned fake Native ports execute; extract the actual new state API body."""
from pathlib import Path
import json,subprocess
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2];OUT=ROOT/'analysis/firmware/f1_user_ui_entry_01'
def main():
 OUT.mkdir(parents=True,exist_ok=True);source=(HERE/'runtime.cpp').read_text();body=source[source.index('extern "C" unsigned iq4_f1_mode_get_01()'):]
 prefix=r'''#include "state.h"
#include <cassert>
#include <cstdint>
#include <stdexcept>
#include <atomic>
namespace iq4::f1::entry10 {enum class Phase:unsigned {Disabled,Bound,Building,Ready,Open,AwaitingStockPaint,Detaching,DetachedRetained,Hold};}
struct Status{unsigned phase=3;};
struct Native {void*context{};std::uintptr_t(*current_thread)(void*){};void(*invalidate)(void*,bool){};};
static unsigned calls=0;static bool fail=false;static std::uintptr_t actual_queue=0x1000;
static std::uintptr_t current(void*){return actual_queue;}
static void invalidate(void*p,bool force){assert(p==(void*)0x2000&&!force);++calls;if(fail)throw std::runtime_error("owned invalidation fault");}
struct Binding {Status status{};Status status_on_ui(){return status;}Native persistent_ports_on_ui(){return status.phase==8||status.phase==7?Native{}:Native{nullptr,current,invalidate};}};
static Binding owned;static Binding*binding=&owned;static std::atomic<bool>initialized{true},bound{true};
static std::uintptr_t current_queue(){return actual_queue;}
Iq4F1FirmwareState01 iq4_f1_state_01={1,64,0,3,3,0,1,0,0x1000,0x3000,0x2000,0};
static void reject(unsigned code){iq4_f1_state_01.last_failure=code;}
'''
 suffix=r'''int main(){
 assert(iq4_f1_mode_get_01()==0);
 for(unsigned m=0;m<=4;++m){assert(iq4_f1_mode_set_on_ui_01(m)==1);assert(iq4_f1_mode_get_01()==m);}assert(calls==5&&iq4_f1_state_01.request_generation==5);
 assert(iq4_f1_mode_set_on_ui_01(5)==0&&calls==5);
 actual_queue=0x4000;assert(iq4_f1_mode_set_on_ui_01(2)==0&&calls==5);actual_queue=0x1000;
 fail=true;assert(iq4_f1_mode_set_on_ui_01(2)==0&&iq4_f1_mode_get_01()==4&&iq4_f1_state_01.request_generation==5);fail=false;
 owned.status.phase=8;assert(iq4_f1_mode_get_01()==0&&iq4_f1_mode_set_on_ui_01(1)==0);owned.status.phase=3;
 assert(iq4_f1_firmware_disable_on_ui_01()==1&&iq4_f1_mode_get_01()==0&&iq4_f1_state_01.request_generation==6);
 bound=false;assert(iq4_f1_mode_set_on_ui_01(1)==0&&iq4_f1_mode_get_01()==0);
}
'''
 src=OUT/'owned_mode_fixture.cpp';src.write_text(prefix+body+suffix)
 sdk=subprocess.check_output(['xcrun','--show-sdk-path'],text=True).strip();binary=OUT/'owned_mode_fixture'
 cmd=['/usr/bin/clang++','-std=c++17','-O2','-Wall','-Wextra','-Werror','-isystem',sdk+'/usr/include/c++/v1','-I',str(HERE),str(src),'-o',str(binary)]
 subprocess.run(cmd,cwd=ROOT,check=True);subprocess.run([binary],cwd=ROOT,check=True)
 result={'owned_host_state_group':1,'cases':7,'result':'PASS','native_ports':'owned-fake-only','actual_mode_body_extracted':True,'requested_mode_not_pixel_ACK':True,'target_executed':False,'SDK_Windows_network_device_operations':0,'compile':cmd}
 (OUT/'OWN_MODE_CHECKS.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result))
if __name__=='__main__':main()
