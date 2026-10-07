#include "sink.h"
#include <stdlib.h>
#include <string.h>
#include <setjmp.h>
#include <stdatomic.h>
#define DEST_BYTES 16384u
_Static_assert(sizeof(struct jpeg_compress_struct)==584,"Native JPEG8 LP64 ABI");
_Static_assert(JCS_EXT_ARGB==15,"Native ARGB channel order");
_Static_assert(offsetof(struct jpeg_compress_struct,next_scanline)==340,"Native scanline ABI");
typedef struct HalfContext HalfContext;
typedef struct HalfError {struct jpeg_error_mgr api;jmp_buf jump;HalfContext *owner;} HalfError;
typedef struct HalfDestination {struct jpeg_destination_mgr api;HalfContext *owner;uint8_t data[DEST_BYTES];} HalfDestination;
struct HalfContext {
 struct jpeg_compress_struct jpeg;HalfError error;HalfDestination dest;
 Iq4JpegApi api;Iq4HalfJpegResult01 result;uint8_t *output;size_t capacity,used;
 int(*guard)(void*);void *guard_context;int destroying;
 HalfContext *next;
};
static _Atomic(HalfContext*) retained;
static _Atomic uint64_t retained_count;
uint64_t iq4_half_jpeg_quarantined_contexts_01(void){return atomic_load_explicit(&retained_count,memory_order_acquire);}
static int overlap(const void*a,size_t an,const void*b,size_t bn){uintptr_t x=(uintptr_t)a,y=(uintptr_t)b;if(!a||!b||!an||!bn)return 0;if(an>UINTPTR_MAX-x||bn>UINTPTR_MAX-y)return 1;return x<y+bn&&y<x+an;}
static void fail(HalfContext*c,Iq4HalfJpegStatus01 s){c->result.status=s;longjmp(c->error.jump,1);}
static void valid(HalfContext*c){int r=c->guard(c->guard_context);if(r!=1)fail(c,r==0?IQ4_HALF_JPEG_CANCELLED_01:IQ4_HALF_JPEG_HOLD_01);}
static void jpeg_error(j_common_ptr j){HalfContext*c=((HalfError*)j->err)->owner;c->result.library_message=j->err->msg_code;fail(c,c->destroying?IQ4_HALF_JPEG_HOLD_01:IQ4_HALF_JPEG_LIBRARY_01);}
static void flush(HalfContext*c,size_t n){valid(c);if(n>c->capacity-c->used)fail(c,IQ4_HALF_JPEG_CAPACITY_01);memcpy(c->output+c->used,c->dest.data,n);c->used+=n;}
static void init_dest(j_compress_ptr j){HalfDestination*d=(HalfDestination*)j->dest;d->api.next_output_byte=d->data;d->api.free_in_buffer=DEST_BYTES;}
static boolean empty_dest(j_compress_ptr j){HalfDestination*d=(HalfDestination*)j->dest;flush(d->owner,DEST_BYTES);d->api.next_output_byte=d->data;d->api.free_in_buffer=DEST_BYTES;return TRUE;}
static void term_dest(j_compress_ptr j){HalfDestination*d=(HalfDestination*)j->dest;if(d->api.free_in_buffer>DEST_BYTES)fail(d->owner,IQ4_HALF_JPEG_LIBRARY_01);flush(d->owner,DEST_BYTES-d->api.free_in_buffer);}
static int bound(const Iq4JpegApi*a){return a&&a->binding_abi_verified==1&&(a->api_version==80||a->api_version==82)&&a->compressor_struct_bytes==584&&a->std_error&&a->create_compress&&a->set_defaults&&a->set_quality&&a->start_compress&&a->write_scanlines&&a->finish_compress&&a->destroy_compress;}
Iq4HalfJpegStatus01 iq4_half_jpeg_encode_01(const Iq4JpegApi*a,const Iq4HalfArgb01*p,uint8_t*out,size_t capacity,int quality,int(*guard)(void*),void*ctx,Iq4HalfJpegResult01*result){
 if(!result)return IQ4_HALF_JPEG_ARGUMENT_01;
 if(overlap(result,sizeof(*result),a,sizeof(*a))||overlap(result,sizeof(*result),p,sizeof(*p))||overlap(result,sizeof(*result),out,capacity)||(p&&overlap(result,sizeof(*result),p->visible,p->bytes)))return IQ4_HALF_JPEG_ARGUMENT_01;
 memset(result,0,sizeof(*result));
 if(!bound(a)){result->status=IQ4_HALF_JPEG_UNBOUND_01;return result->status;}
#if defined(__aarch64__) && defined(__linux__)
 if(a->api_version!=82){result->status=IQ4_HALF_JPEG_UNBOUND_01;return result->status;}
#endif
 if(!p||!p->visible||!out||!capacity||!guard||quality<1||quality>100||p->format!=5||p->width!=7102||p->height!=5326||p->stride<28408||p->stride>SIZE_MAX/5326||p->bytes<5325*p->stride+28408||overlap(out,capacity,p->visible,p->bytes)||overlap(out,capacity,a,sizeof(*a))||overlap(out,capacity,p,sizeof(*p))){result->status=IQ4_HALF_JPEG_ARGUMENT_01;return result->status;}
 int before=guard(ctx);if(before!=1){result->status=before==0?IQ4_HALF_JPEG_CANCELLED_01:IQ4_HALF_JPEG_HOLD_01;return result->status;}
 HalfContext*c=(HalfContext*)calloc(1,sizeof(*c));if(!c){result->status=IQ4_HALF_JPEG_MEMORY_01;return result->status;}
 c->api=*a;c->error.owner=c;c->dest.owner=c;c->output=out;c->capacity=capacity;c->guard=guard;c->guard_context=ctx;
 c->dest.api.init_destination=init_dest;c->dest.api.empty_output_buffer=empty_dest;c->dest.api.term_destination=term_dest;
 if(setjmp(c->error.jump))goto cleanup;
 c->jpeg.err=c->api.std_error(&c->error.api);if(c->jpeg.err!=&c->error.api)fail(c,IQ4_HALF_JPEG_UNBOUND_01);c->error.api.error_exit=jpeg_error;
 c->api.create_compress(&c->jpeg,c->api.api_version,c->api.compressor_struct_bytes);c->jpeg.dest=&c->dest.api;c->jpeg.image_width=p->width;c->jpeg.image_height=p->height;c->jpeg.input_components=4;c->jpeg.in_color_space=JCS_EXT_ARGB;
 c->api.set_defaults(&c->jpeg);c->jpeg.optimize_coding=FALSE;c->jpeg.num_scans=0;c->jpeg.scan_info=NULL;c->api.set_quality(&c->jpeg,quality,TRUE);c->api.start_compress(&c->jpeg,TRUE);
 while(c->jpeg.next_scanline<c->jpeg.image_height){valid(c);JDIMENSION row=c->jpeg.next_scanline;JSAMPROW pixels=(JSAMPROW)(p->visible+(size_t)row*p->stride);if(c->api.write_scanlines(&c->jpeg,&pixels,1)!=1||c->jpeg.next_scanline!=row+1)fail(c,IQ4_HALF_JPEG_SUSPENDED_01);++c->result.rows;}
 valid(c);c->api.finish_compress(&c->jpeg);valid(c);if(c->used<4||out[0]!=0xff||out[1]!=0xd8||out[c->used-2]!=0xff||out[c->used-1]!=0xd9)fail(c,IQ4_HALF_JPEG_LIBRARY_01);c->result.status=IQ4_HALF_JPEG_OK_01;
cleanup:
 if(c->jpeg.mem&&!c->destroying){c->destroying=1;++c->result.destroy_calls;c->api.destroy_compress(&c->jpeg);}
 if(c->result.status==IQ4_HALF_JPEG_OK_01)c->result.jpeg_bytes=c->used;
 *result=c->result;
 if(c->result.status==IQ4_HALF_JPEG_HOLD_01&&c->destroying&&c->jpeg.mem){
  /* All native calls have either returned or longjmped to this C frame.
   * Quarantine has no resume/retry entry. Forget external pointers before
   * returning the borrowed native image to its original processing worker. */
  c->output=NULL;c->guard=NULL;c->guard_context=NULL;HalfContext*head=atomic_load_explicit(&retained,memory_order_acquire);do{c->next=head;}while(!atomic_compare_exchange_weak_explicit(&retained,&head,c,memory_order_release,memory_order_acquire));atomic_fetch_add_explicit(&retained_count,1,memory_order_release);
 }else free(c);
 return result->status;
}
