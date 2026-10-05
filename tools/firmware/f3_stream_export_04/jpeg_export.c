#include "../../../src/codec/stream_export.h"
#include <stdatomic.h>
#include <setjmp.h>
#include <stdlib.h>
#include <string.h>
#define CHUNK_BYTES 16384u
_Static_assert(sizeof(struct jpeg_compress_struct)==584,"JPEG8 LP64 layout");
_Static_assert(offsetof(struct jpeg_compress_struct,next_scanline)==340,"JPEG8 scanline offset");
typedef struct StreamContext StreamContext;
typedef struct StreamError {
    struct jpeg_error_mgr api;
    jmp_buf jump;
    StreamContext *owner;
} StreamError;
typedef struct StreamDestination {
    struct jpeg_destination_mgr api;
    StreamContext *owner;
    uint8_t chunk[CHUNK_BYTES];
} StreamDestination;
struct StreamContext {
    struct jpeg_compress_struct compressor;
    StreamError error;
    StreamDestination dest;
    Iq4JpegApi api;
    Iq4JpegSink sink;
    Iq4StreamResult result;
    uint8_t *row;
    int destroying;
    StreamContext *retained_next;
};
static _Atomic(StreamContext *) retained_cleanup_contexts;
static _Atomic uint64_t retained_count;
uint64_t iq4_f3_jpeg_retained_cleanup_contexts_04(void) { return atomic_load_explicit(&retained_count,memory_order_acquire); }
static void retain_unknown(StreamContext *c) {
    StreamContext *head=atomic_load_explicit(&retained_cleanup_contexts,memory_order_acquire);
    do { c->retained_next=head; } while(!atomic_compare_exchange_weak_explicit(&retained_cleanup_contexts,&head,c,memory_order_release,memory_order_acquire));
    atomic_fetch_add_explicit(&retained_count,1,memory_order_release);
}
static int overlap(const void *a,size_t an,const void *b,size_t bn) {
    uintptr_t av=(uintptr_t)a,bv=(uintptr_t)b;
    if(!a||!b||!an||!bn)return 0;
    if(an>UINTPTR_MAX-av||bn>UINTPTR_MAX-bv)return 1;
    return av<bv+bn&&bv<av+an;
}
static void fail(StreamContext *c,Iq4StreamStatus s) {
    c->result.status=s;longjmp(c->error.jump,1);
}
static void library_error(j_common_ptr info) {
    StreamContext *c=((StreamError *)info->err)->owner;
    c->result.library_message_code=info->err->msg_code;
    fail(c,c->destroying?IQ4_STREAM_CLEANUP_ERROR:IQ4_STREAM_LIBRARY_ERROR);
}
static void flush_chunk(StreamContext *c,size_t n) {
    size_t written;
    if(!n)return;
    if(c->result.accepted_prefix_bytes>c->sink.byte_budget ||
       (uint64_t)n>c->sink.byte_budget-c->result.accepted_prefix_bytes)
        fail(c,IQ4_STREAM_BUDGET);
    written=c->sink.write(c->sink.context,c->dest.chunk,n);
    if(written<=n)c->result.accepted_prefix_bytes+=written;
    if(written!=n)fail(c,IQ4_STREAM_SHORT_WRITE);
}
static void start_destination(j_compress_ptr info) {
    StreamDestination *d=(StreamDestination *)info->dest;
    d->api.next_output_byte=d->chunk;d->api.free_in_buffer=CHUNK_BYTES;
}
static boolean empty_destination(j_compress_ptr info) {
    StreamDestination *d=(StreamDestination *)info->dest;
    flush_chunk(d->owner,CHUNK_BYTES);
    d->api.next_output_byte=d->chunk;d->api.free_in_buffer=CHUNK_BYTES;
    return TRUE;
}
static void finish_destination(j_compress_ptr info) {
    StreamDestination *d=(StreamDestination *)info->dest;
    if(d->api.free_in_buffer>CHUNK_BYTES)fail(d->owner,IQ4_STREAM_LIBRARY_ERROR);
    flush_chunk(d->owner,CHUNK_BYTES-d->api.free_in_buffer);
}
static int bound(const Iq4JpegApi *a) {
    return a && a->binding_abi_verified==1 && (a->api_version==80||a->api_version==82) &&
        a->compressor_struct_bytes==sizeof(struct jpeg_compress_struct) &&
        a->std_error&&a->create_compress&&a->set_defaults&&a->set_quality&&
        a->start_compress&&a->write_scanlines&&a->finish_compress&&a->destroy_compress;
}
Iq4StreamStatus iq4_jpeg_stream_export_rgb32_01(const Iq4JpegApi *a,const Iq4Rgb32Export *in,
                                    const Iq4JpegSink *sink,Iq4StreamResult *out) {
    StreamContext *c;struct Iq4ExportPixels sampler;
    if(!out)return IQ4_STREAM_ARGUMENT;
    if(overlap(out,sizeof(*out),a,sizeof(*a))||overlap(out,sizeof(*out),in,sizeof(*in))||
       overlap(out,sizeof(*out),sink,sizeof(*sink))||
       (in&&overlap(out,sizeof(*out),in->pixels,in->bytes)))return IQ4_STREAM_ARGUMENT;
    memset(out,0,sizeof(*out));
    if(!bound(a)){out->status=IQ4_STREAM_UNBOUND;return out->status;}
    if(!in||!in->pixels||!sink||!sink->write||!sink->byte_budget||
       !in->width||!in->height||in->width>65500||in->height>65500||
       in->quality<1||in->quality>100){out->status=IQ4_STREAM_ARGUMENT;return out->status;}
    if(!iq4_export_pixels_init(&sampler,in->pixels,in->bytes,in->stride,in->width,in->height,in->rotation,in->size_mode)) {
        out->status=IQ4_STREAM_ARGUMENT;return out->status;
    }
    c=(StreamContext *)calloc(1,sizeof(*c));
    if(!c){out->status=IQ4_STREAM_NO_MEMORY;return out->status;}
    c->api=*a;c->sink=*sink;c->error.owner=c;c->dest.owner=c;
    c->result.rgb24_scanline_bytes=(size_t)sampler.geometry.output_width*3u;c->result.destination_bytes=CHUNK_BYTES;
    c->row=(uint8_t *)malloc(c->result.rgb24_scanline_bytes);
    if(!c->row){c->result.status=IQ4_STREAM_NO_MEMORY;goto cleanup;}
    c->dest.api.init_destination=start_destination;
    c->dest.api.empty_output_buffer=empty_destination;
    c->dest.api.term_destination=finish_destination;
    if(setjmp(c->error.jump))goto cleanup;
    c->compressor.err=c->api.std_error(&c->error.api);
    if(c->compressor.err!=&c->error.api)fail(c,IQ4_STREAM_UNBOUND);
    c->error.api.error_exit=library_error;
    c->api.create_compress(&c->compressor,c->api.api_version,c->api.compressor_struct_bytes);
    c->compressor.dest=&c->dest.api;
    c->compressor.image_width=sampler.geometry.output_width;c->compressor.image_height=sampler.geometry.output_height;
    c->compressor.input_components=3;c->compressor.in_color_space=JCS_RGB;
    c->api.set_defaults(&c->compressor);
    /* Baseline sequential output: do not request full-image coefficient passes. */
    c->compressor.optimize_coding=FALSE;c->compressor.num_scans=0;c->compressor.scan_info=NULL;
    c->api.set_quality(&c->compressor,in->quality,TRUE);
    c->api.start_compress(&c->compressor,TRUE);
    while(c->compressor.next_scanline<c->compressor.image_height) {
        JDIMENSION before=c->compressor.next_scanline;JSAMPROW scan=c->row;
        if(!iq4_export_pixels_row(&sampler,before,c->row,c->result.rgb24_scanline_bytes))
            fail(c,IQ4_STREAM_ARGUMENT);
        if(c->api.write_scanlines(&c->compressor,&scan,1)!=1 || c->compressor.next_scanline!=before+1)
            fail(c,IQ4_STREAM_SUSPENDED);
        ++c->result.rows_encoded;
    }
    c->api.finish_compress(&c->compressor);
    if(c->result.accepted_prefix_bytes<4)fail(c,IQ4_STREAM_LIBRARY_ERROR);
    c->result.status=IQ4_STREAM_OK;
cleanup:
    if(c->compressor.mem&&!c->destroying) {
        c->destroying=1;++c->result.destroy_calls;c->api.destroy_compress(&c->compressor);
    }
    c->result.jpeg_bytes=c->result.status==IQ4_STREAM_OK?c->result.accepted_prefix_bytes:0;
    *out=c->result;
    if(c->result.status==IQ4_STREAM_CLEANUP_ERROR)retain_unknown(c);
    else { free(c->row);free(c); }
    return out->status;
}
