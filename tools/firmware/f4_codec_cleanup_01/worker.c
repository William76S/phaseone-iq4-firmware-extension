#include "../f4_native_source_02/worker.h"
#include "../f4_native_source_02/native_calls.h"
#include "../f3_native_jpeg8_binding_01/native_jpeg82.h"
#include <string.h>
static const uint8_t source_sha[32]={0x9b,0x61,0x1e,0xfe,0x64,0x06,0x76,0x85,0xb7,0x70,0xba,0x39,0x84,0xae,0x95,0x16,0x84,0xc5,0xa4,0x01,0xf7,0x3f,0x77,0xa0,0x3b,0x31,0x6b,0xe3,0x74,0x03,0x2c,0xdb};
typedef struct {Iq4F4SelfRead02 read;void*context;} ReadContext;
static int read_jpeg(void*p,uintptr_t a,uint8_t*out,size_t n){ReadContext*r=p;return r->read(r->context,a,out,n);}
int iq4_f4_worker_init_02(Iq4F4Worker02*w,void*source,struct Iq4Mkv*m,unsigned char*p,uint32_t cap,int quality,Iq4F4SelfRead02 read,void*ctx){
 if(!w||!source||!m||m->state!=IQ4_MKV_WRITING||!p||cap<1024||cap>32u*1024u*1024u||quality<1||quality>100||!read)return IQ4_F4_WORKER_REJECTED;
 memset(w,0,sizeof*w);ReadContext r={read,ctx};
 if(iq4_native_jpeg82_bind_01(source_sha,read_jpeg,&r,&w->jpeg)!=IQ4_JPEG82_BOUND_STATIC_ABI_01)return IQ4_F4_WORKER_REJECTED;
 w->native_worker_tid=iq4_f4_native_tid_02();if(!w->native_worker_tid)return IQ4_F4_WORKER_REJECTED;
 w->source=source;w->mkv=m;w->packet=p;w->packet_capacity=cap;w->quality=quality;w->ready=1;return IQ4_F4_WORKER_PACKET;
}
int iq4_f4_worker_pump_one_02(Iq4F4Worker02*w){Iq4F4OwnedFrame02 f;Iq4JpegResult jpeg;uint64_t extended;uint32_t delta;int r;
 if(!w||!w->ready||iq4_f4_native_tid_02()!=w->native_worker_tid)return IQ4_F4_WORKER_REJECTED;
 if(w->held_uncertain)return IQ4_F4_WORKER_HOLD;
 r=iq4_f4_source_worker_claim_02(w->source,&f);
 if(r==IQ4_F4_SRC_HOLD){w->held_uncertain=1;return IQ4_F4_WORKER_HOLD;}if(r==IQ4_F4_SRC_EMPTY)return IQ4_F4_WORKER_EMPTY;if(r!=IQ4_F4_SRC_OK)return IQ4_F4_WORKER_REJECTED;
 const Iq4F4FrameMetadata02*m=&f.metadata;
 if(m->width!=w->mkv->width||m->height!=w->mkv->height||m->stride!=(uint64_t)m->width*3||m->bytes!=(uint64_t)m->stride*m->height||!m->observed_completion_ns){++w->mode_errors;r=IQ4_F4_WORKER_REJECTED;goto release;}
 delta=m->software_id-w->last_id;
 if(w->seen_id&&(!delta||delta>=0x80000000u||UINT64_MAX-w->last_extended_id<delta)){++w->mode_errors;r=IQ4_F4_WORKER_REJECTED;goto release;}
 extended=w->seen_id?w->last_extended_id+delta:m->software_id;
 Iq4JpegInput input={f.bytes,m->bytes,m->width,m->height,m->stride,w->quality};
 const Iq4JpegStatus codec=iq4_jpeg_encode_bounded(&w->jpeg,&input,w->packet,w->packet_capacity,&jpeg);
 if(codec==IQ4_JPEG_CLEANUP_ERROR){++w->codec_errors;w->held_uncertain=1;return IQ4_F4_WORKER_HOLD;}
 if(codec!=IQ4_JPEG_OK||!jpeg.jpeg_bytes||jpeg.jpeg_bytes>w->packet_capacity){++w->codec_errors;r=IQ4_F4_WORKER_CODEC_ERROR;goto release;}
 /* Owned RGB is released before file I/O; encoded packet has independent
  * lifetime. Unknown release cannot write a packet or seal/publish the file. */
 if(iq4_f4_source_worker_release_02(w->source,&f)!=IQ4_F4_SRC_OK){w->held_uncertain=1;return IQ4_F4_WORKER_HOLD;}
 if(iq4_mkv_packet(w->mkv,w->packet,(uint32_t)jpeg.jpeg_bytes,m->observed_completion_ns,extended)!=IQ4_MKV_OK){if(w->mkv->state==IQ4_MKV_UNKNOWN)w->held_uncertain=1;return w->held_uncertain?IQ4_F4_WORKER_HOLD:IQ4_F4_WORKER_FILE_ERROR;}
 w->seen_id=1;w->last_id=m->software_id;w->last_extended_id=extended;++w->encoded;return IQ4_F4_WORKER_PACKET;
 release:if(iq4_f4_source_worker_release_02(w->source,&f)!=IQ4_F4_SRC_OK){w->held_uncertain=1;return IQ4_F4_WORKER_HOLD;}return r;
}
int iq4_f4_worker_seal_02(Iq4F4Worker02*w){if(!w||!w->ready||iq4_f4_native_tid_02()!=w->native_worker_tid)return IQ4_F4_WORKER_REJECTED;
 if(w->held_uncertain)return IQ4_F4_WORKER_HOLD;
 int r=iq4_f4_source_fence_02(w->source);if(r==IQ4_F4_SRC_HOLD){w->held_uncertain=1;return IQ4_F4_WORKER_HOLD;}if(r!=IQ4_F4_SRC_OK)return IQ4_F4_WORKER_EMPTY;
 if(iq4_mkv_seal(w->mkv)!=IQ4_MKV_OK){if(w->mkv->state==IQ4_MKV_UNKNOWN)w->held_uncertain=1;return w->held_uncertain?IQ4_F4_WORKER_HOLD:IQ4_F4_WORKER_FILE_ERROR;}
 return IQ4_F4_WORKER_PACKET;
}
