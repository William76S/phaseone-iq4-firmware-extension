#include "../f4_native_source_02/worker.h"
#include "../f3_native_jpeg8_binding_01/native_jpeg82.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>
static unsigned claims,releases,encodes,packets,seals;
static unsigned char rgb[64*48*3],packet[4096];static Iq4JpegStatus codec;
uint64_t iq4_f4_native_tid_02(void){return 2;}
int iq4_f4_source_worker_claim_02(void*s,Iq4F4OwnedFrame02*out){assert(s==(void*)1);++claims;*out=(Iq4F4OwnedFrame02){rgb,{.width=64,.height=48,.stride=192,.bytes=sizeof rgb,.software_id=7,.observed_completion_ns=12345},0,1};return IQ4_F4_SRC_OK;}
int iq4_f4_source_worker_release_02(void*s,const Iq4F4OwnedFrame02*f){assert(s==(void*)1&&f->bytes==rgb);++releases;return IQ4_F4_SRC_OK;}
int iq4_f4_source_fence_02(void*s){assert(s==(void*)1);return IQ4_F4_SRC_OK;}
Iq4Jpeg82BindStatus01 iq4_native_jpeg82_bind_01(const uint8_t*b,Iq4Jpeg82ReadExact01 r,void*c,Iq4JpegApi*out){assert(b&&r&&c);memset(out,0,sizeof*out);out->binding_abi_verified=1;return IQ4_JPEG82_BOUND_STATIC_ABI_01;}
Iq4JpegStatus iq4_jpeg_encode_bounded(const Iq4JpegApi*a,const Iq4JpegInput*i,uint8_t*out,size_t n,Iq4JpegResult*r){assert(a->binding_abi_verified&&i->rgb24==rgb&&out==packet&&n==sizeof packet);++encodes;memset(r,0,sizeof*r);r->status=codec;r->jpeg_bytes=codec==IQ4_JPEG_OK?123:0;return codec;}
enum Iq4MkvStatus iq4_mkv_packet(struct Iq4Mkv*m,const uint8_t*p,uint32_t n,uint64_t ns,uint64_t id){assert(m&&p==packet&&n==123&&ns==12345&&id==7&&releases==1);++packets;return IQ4_MKV_OK;}
enum Iq4MkvStatus iq4_mkv_seal(struct Iq4Mkv*m){assert(m);++seals;return IQ4_MKV_OK;}
static int readself(void*c,uintptr_t a,void*p,size_t n){(void)c;(void)a;(void)p;(void)n;return 0;}
static void one(unsigned fault){Iq4F4Worker02 w;struct Iq4Mkv m={0};m.state=IQ4_MKV_WRITING;m.width=64;m.height=48;codec=fault==0?IQ4_JPEG_CLEANUP_ERROR:fault==1?IQ4_JPEG_OUTPUT_CAPACITY:IQ4_JPEG_OK;
 assert(iq4_f4_worker_init_02(&w,(void*)1,&m,packet,sizeof packet,90,readself,0)==IQ4_F4_WORKER_PACKET);
 int r=iq4_f4_worker_pump_one_02(&w);
 if(!fault){assert(r==IQ4_F4_WORKER_HOLD&&w.held_uncertain&&claims==1&&encodes==1&&!releases&&!packets);assert(iq4_f4_worker_pump_one_02(&w)==IQ4_F4_WORKER_HOLD&&claims==1&&encodes==1);assert(iq4_f4_worker_seal_02(&w)==IQ4_F4_WORKER_HOLD&&!seals);}
 else if(fault==1)assert(r==IQ4_F4_WORKER_CODEC_ERROR&&!w.held_uncertain&&releases==1&&!packets);
 else assert(r==IQ4_F4_WORKER_PACKET&&!w.held_uncertain&&releases==1&&packets==1);
}
int main(void){for(unsigned i=0;i<3;++i){pid_t p=fork();assert(p>=0);if(!p){one(i);_exit(0);}int s;assert(waitpid(p,&s,0)==p&&WIFEXITED(s)&&!WEXITSTATUS(s));}puts("{\"groups\":3,\"modeled_worker_ownership_faults\":true,\"target_executed\":false}");}
