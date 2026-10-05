#include "worker.h"
#include "native_calls.h"
#include "../f3_native_jpeg8_binding_01/native_jpeg82.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
static Iq4F4OwnedFrame02 frame;static unsigned char rgb[64*48*3],packet[4096];static int claim=0,released,releasefail,encodefail,mkvfail,fence,bindfail;static uint64_t tid=2;static unsigned packets;static uint64_t lastseq,lastns;
uint64_t iq4_f4_native_tid_02(void){return tid;}
int iq4_f4_source_worker_claim_02(void*s,Iq4F4OwnedFrame02*out){assert(s==(void*)1);if(claim==0)*out=frame;return claim;}
int iq4_f4_source_worker_release_02(void*s,const Iq4F4OwnedFrame02*f){assert(s==(void*)1&&f->bytes==rgb);++released;return releasefail?2:0;}
int iq4_f4_source_fence_02(void*s){assert(s==(void*)1);return fence;}
Iq4Jpeg82BindStatus01 iq4_native_jpeg82_bind_01(const uint8_t*b,Iq4Jpeg82ReadExact01 r,void*c,Iq4JpegApi*out){assert(b&&r&&c);memset(out,0,sizeof*out);out->binding_abi_verified=1;return bindfail?IQ4_JPEG82_CODE_MISMATCH_01:IQ4_JPEG82_BOUND_STATIC_ABI_01;}
Iq4JpegStatus iq4_jpeg_encode_bounded(const Iq4JpegApi*a,const Iq4JpegInput*i,uint8_t*out,size_t n,Iq4JpegResult*r){assert(a->binding_abi_verified&&i->rgb24==rgb&&out==packet&&n==sizeof packet);memset(r,0,sizeof*r);r->jpeg_bytes=123;return encodefail?IQ4_JPEG_LIBRARY_ERROR:IQ4_JPEG_OK;}
enum Iq4MkvStatus iq4_mkv_packet(struct Iq4Mkv*m,const uint8_t*p,uint32_t n,uint64_t ns,uint64_t id){assert(m&&p==packet&&n==123&&released);++packets;lastseq=id;lastns=ns;return mkvfail?IQ4_MKV_IO:IQ4_MKV_OK;}
enum Iq4MkvStatus iq4_mkv_seal(struct Iq4Mkv*m){assert(m);m->state=IQ4_MKV_SEALED;return IQ4_MKV_OK;}
static int readself(void*c,uintptr_t a,void*p,size_t n){(void)c;(void)a;(void)p;(void)n;return 0;}
static void reset(Iq4F4Worker02*w,struct Iq4Mkv*m){claim=released=releasefail=encodefail=mkvfail=fence=bindfail=0;tid=2;packets=0;memset(m,0,sizeof*m);m->state=IQ4_MKV_WRITING;m->width=64;m->height=48;
 frame=(Iq4F4OwnedFrame02){rgb,{.width=64,.height=48,.stride=192,.bytes=sizeof rgb,.software_id=0xfffffffe,.observed_completion_ns=5000},0,1};assert(iq4_f4_worker_init_02(w,(void*)1,m,packet,sizeof packet,90,readself,0)==0);}
int main(void){Iq4F4Worker02 w;struct Iq4Mkv m;unsigned groups=0;
 reset(&w,&m);assert(iq4_f4_worker_pump_one_02(&w)==0&&released==1&&lastseq==0xfffffffe&&lastns==5000);frame.metadata.software_id=1;frame.metadata.observed_completion_ns=9000;assert(iq4_f4_worker_pump_one_02(&w)==0&&lastseq==0x100000001ull);++groups;
 reset(&w,&m);encodefail=1;assert(iq4_f4_worker_pump_one_02(&w)==3&&released==1&&packets==0);++groups;
 reset(&w,&m);releasefail=1;assert(iq4_f4_worker_pump_one_02(&w)==5&&packets==0&&iq4_f4_worker_seal_02(&w)==5);++groups;
 reset(&w,&m);frame.metadata.width=1920;assert(iq4_f4_worker_pump_one_02(&w)==2&&released==1&&packets==0);++groups;
 reset(&w,&m);mkvfail=1;assert(iq4_f4_worker_pump_one_02(&w)==4&&released==1&&packets==1);++groups;
 reset(&w,&m);claim=IQ4_F4_SRC_HOLD;assert(iq4_f4_worker_pump_one_02(&w)==5&&released==0&&iq4_f4_worker_seal_02(&w)==5);++groups;
 reset(&w,&m);fence=IQ4_F4_SRC_PENDING;assert(iq4_f4_worker_seal_02(&w)==1&&m.state==IQ4_MKV_WRITING);fence=0;assert(iq4_f4_worker_seal_02(&w)==0&&m.state==IQ4_MKV_SEALED);++groups;
 reset(&w,&m);tid=3;assert(iq4_f4_worker_pump_one_02(&w)==2&&released==0);++groups;
 reset(&w,&m);bindfail=1;assert(iq4_f4_worker_init_02(&w,(void*)1,&m,packet,sizeof packet,90,readself,0)==IQ4_F4_WORKER_REJECTED&&!w.ready);++groups;
 printf("%u worker fault groups PASS; codec/muxer ports simulated, no target\n",groups);return 0;}
