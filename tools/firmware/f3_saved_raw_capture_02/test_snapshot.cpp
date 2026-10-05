/* Directly exercises the new actual runtime policy() body. Every native entry
 * is dead-stripped; fixture snapshot is the only getter allowed to execute. */
#include "runtime.cpp"
#include <cassert>
#include <cstdio>
static F3SettingsSnapshot04 actual;static unsigned snapshot_reads;static int allowed=1;
extern "C" int iq4_f3_settings_snapshot_04(F3SettingsSnapshot04*out){++snapshot_reads;if(!allowed)return 0;*out=actual;return 1;}
int main(){unsigned cases=0;for(unsigned m=0;m<3;++m){actual={m,5,100};snapshot_reads=0;F3CapturePolicy01Small out{};assert(policy(out)==1&&snapshot_reads==1&&out.mode==m&&out.size_mode==5&&out.quality==100);++cases;}
 const F3SettingsSnapshot04 bad[]={{3,0,90},{0,6,90},{1,1,0},{2,2,101}};for(auto b:bad){actual=b;snapshot_reads=0;F3CapturePolicy01Small out{};assert(!policy(out)&&snapshot_reads==1&&!out.quality);++cases;}
 actual={1,2,90};allowed=0;snapshot_reads=0;F3CapturePolicy01Small out{};assert(!policy(out)&&snapshot_reads==1);++cases;
 printf("{\"cases\":%u,\"passed\":true,\"actual_runtime_policy_body\":true,\"atomic_snapshot_getter_is_fixture\":true,\"target_executed\":false}\n",cases);
}
