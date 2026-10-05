#include "bounded_jpeg.h"
#include <setjmp.h>
#include <stdlib.h>
#include <string.h>

#if UINTPTR_MAX == UINT64_MAX
_Static_assert(sizeof(struct jpeg_compress_struct)==584,"JPEG8-family LP64 compressor ABI differs");
_Static_assert(sizeof(struct jpeg_error_mgr)==168,"JPEG error manager LP64 ABI differs");
_Static_assert(sizeof(struct jpeg_destination_mgr)==40,"JPEG destination LP64 ABI differs");
_Static_assert(offsetof(struct jpeg_compress_struct,dest)==40,"JPEG dest offset differs");
_Static_assert(offsetof(struct jpeg_compress_struct,image_width)==48,"JPEG width offset differs");
_Static_assert(offsetof(struct jpeg_compress_struct,next_scanline)==340,"JPEG scanline offset differs");
#endif

typedef struct Context Context;
typedef struct Error {
    struct jpeg_error_mgr public_error;
    jmp_buf jump;
    Context* owner;
} Error;
typedef struct Destination {
    struct jpeg_destination_mgr public_dest;
    uint8_t* base;
    size_t capacity,used;
    Context* owner;
} Destination;
struct Context {
    struct jpeg_compress_struct compressor;
    Error error;
    Destination dest;
    const Iq4JpegApi* api;
    Iq4JpegResult outcome;
    int destroying;
};

static void error_exit(j_common_ptr info) {
    Error* error=(Error*)info->err;
    Context* ctx=error->owner;
    if(ctx->destroying) {
        ctx->outcome.status=IQ4_JPEG_CLEANUP_ERROR;
        strcpy(ctx->outcome.error,"libjpeg error during resource cleanup");
    } else if(ctx->outcome.status!=IQ4_JPEG_OUTPUT_CAPACITY) {
        ctx->outcome.status=IQ4_JPEG_LIBRARY_ERROR;
        ctx->outcome.library_message_code=info->err->msg_code;
        if(info->err->format_message)info->err->format_message(info,ctx->outcome.error);
        else strcpy(ctx->outcome.error,"libjpeg fatal error");
    }
    longjmp(error->jump,1);
}
static void init_destination(j_compress_ptr info) {
    Destination* dest=(Destination*)info->dest;
    dest->public_dest.next_output_byte=dest->base;
    dest->public_dest.free_in_buffer=dest->capacity;
    dest->used=0;
}
static boolean empty_output_buffer(j_compress_ptr info) {
    Destination* dest=(Destination*)info->dest;
    dest->owner->outcome.status=IQ4_JPEG_OUTPUT_CAPACITY;
    strcpy(dest->owner->outcome.error,"JPEG output capacity exhausted; partial packet discarded");
    /* Fail immediately. Never grow, return suspension or reuse overwritten data. */
    (*info->err->error_exit)((j_common_ptr)info);
    return FALSE; /* unreachable for the installed error_exit */
}
static void term_destination(j_compress_ptr info) {
    Destination* dest=(Destination*)info->dest;
    dest->used=dest->capacity-dest->public_dest.free_in_buffer;
}
static Iq4JpegStatus reject(Iq4JpegResult* result,Iq4JpegStatus status,const char* message) {
    result->status=status;strncpy(result->error,message,sizeof(result->error)-1);return status;
}
static int api_valid(const Iq4JpegApi* a) {
    return a&&a->binding_abi_verified==1&&(a->api_version==80||a->api_version==82)
        &&a->compressor_struct_bytes==sizeof(struct jpeg_compress_struct)
        &&a->std_error&&a->create_compress&&a->set_defaults&&a->set_quality
        &&a->start_compress&&a->write_scanlines&&a->finish_compress&&a->destroy_compress;
}
static int ranges_overlap(const void* a,size_t an,const void* b,size_t bn) {
    const uintptr_t av=(uintptr_t)a,bv=(uintptr_t)b;
    if(!a||!b||!an||!bn)return 0;
    if(an>UINTPTR_MAX-av||bn>UINTPTR_MAX-bv)return 1;
    return av<bv+bn&&bv<av+an;
}
Iq4JpegStatus iq4_jpeg_encode_bounded(const Iq4JpegApi* api,const Iq4JpegInput* input,uint8_t* output,size_t capacity,Iq4JpegResult* result) {
    Context* ctx;
    size_t row,required;
    uintptr_t in_start,out_start;
    if(!result)return IQ4_JPEG_INVALID_ARGUMENT;
    /* Reject aliased result without writing an error into protected input.
     * Descriptors cannot be overwritten by the destination during encoding. */
    if(ranges_overlap(result,sizeof(*result),api,sizeof(*api))
        ||ranges_overlap(result,sizeof(*result),input,sizeof(*input))
        ||(input&&ranges_overlap(result,sizeof(*result),input->rgb24,input->bytes)))
        return IQ4_JPEG_INVALID_ARGUMENT;
    memset(result,0,sizeof(*result));
    if(ranges_overlap(output,capacity,result,sizeof(*result))
        ||ranges_overlap(output,capacity,api,sizeof(*api))
        ||ranges_overlap(output,capacity,input,sizeof(*input)))
        return reject(result,IQ4_JPEG_INVALID_ARGUMENT,"output overlaps result/API/input descriptor");
    if(!api_valid(api))return reject(result,IQ4_JPEG_UNBOUND_OR_ABI_MISMATCH,"unverified/missing JPEG API or incompatible struct layout");
    if(!input||!input->rgb24||!output||!capacity||capacity>128u*1024u*1024u
        ||!input->width||!input->height||input->width>65500||input->height>65500||input->quality<1||input->quality>100)
        return reject(result,IQ4_JPEG_INVALID_ARGUMENT,"invalid RGB24 geometry/quality/output capacity");
    row=(size_t)input->width*3;
    if(input->stride<row||(input->height>1&&input->stride>(SIZE_MAX-row)/(input->height-1)))
        return reject(result,IQ4_JPEG_INVALID_ARGUMENT,"invalid/overflowed RGB24 stride");
    required=(size_t)(input->height-1)*input->stride+row;
    if(required>input->bytes)return reject(result,IQ4_JPEG_INVALID_ARGUMENT,"RGB24 input buffer too short");
    in_start=(uintptr_t)input->rgb24;out_start=(uintptr_t)output;
    if(input->bytes>UINTPTR_MAX-in_start||capacity>UINTPTR_MAX-out_start
        ||(in_start<out_start+capacity&&out_start<in_start+input->bytes))
        return reject(result,IQ4_JPEG_INVALID_ARGUMENT,"overlapping/overflowed input and output ranges");
    ctx=(Context*)calloc(1,sizeof(*ctx));
    if(!ctx)return reject(result,IQ4_JPEG_NO_MEMORY,"JPEG context allocation failed");
    ctx->api=api;ctx->error.owner=ctx;ctx->dest.owner=ctx;
    ctx->dest.base=output;ctx->dest.capacity=capacity;
    ctx->dest.public_dest.init_destination=init_destination;
    ctx->dest.public_dest.empty_output_buffer=empty_output_buffer;
    ctx->dest.public_dest.term_destination=term_destination;
    /* The context and all modified error/cleanup state live on the heap.
     * Only unchanged automatic pointers cross setjmp/longjmp. No C++ objects
     * or destructors are skipped, including on CreateCompress's fatal checks. */
    if(setjmp(ctx->error.jump))goto cleanup;
    ctx->compressor.err=api->std_error(&ctx->error.public_error);
    ctx->error.public_error.error_exit=error_exit;
    ctx->compressor.client_data=ctx;
    api->create_compress(&ctx->compressor,api->api_version,api->compressor_struct_bytes);
    ctx->compressor.dest=&ctx->dest.public_dest;
    ctx->compressor.image_width=input->width;ctx->compressor.image_height=input->height;
    ctx->compressor.input_components=3;ctx->compressor.in_color_space=JCS_RGB;
    api->set_defaults(&ctx->compressor);
    api->set_quality(&ctx->compressor,input->quality,TRUE);
    api->start_compress(&ctx->compressor,TRUE);
    while(ctx->compressor.next_scanline<ctx->compressor.image_height) {
        const JDIMENSION before=ctx->compressor.next_scanline;
        JSAMPROW scan=(JSAMPROW)(input->rgb24+(size_t)ctx->compressor.next_scanline*input->stride);
        if(api->write_scanlines(&ctx->compressor,&scan,1)!=1||ctx->compressor.next_scanline!=before+1) {
            ctx->outcome.status=IQ4_JPEG_SUSPENDED;
            strcpy(ctx->outcome.error,"unexpected libjpeg scanline suspension");goto cleanup;
        }
    }
    api->finish_compress(&ctx->compressor);
    if(ctx->dest.used<4||ctx->dest.base[0]!=0xff||ctx->dest.base[1]!=0xd8
        ||ctx->dest.base[ctx->dest.used-2]!=0xff||ctx->dest.base[ctx->dest.used-1]!=0xd9) {
        ctx->outcome.status=IQ4_JPEG_LIBRARY_ERROR;
        strcpy(ctx->outcome.error,"libjpeg finish did not produce a complete JPEG packet");goto cleanup;
    }
    ctx->outcome.status=IQ4_JPEG_OK;ctx->outcome.jpeg_bytes=ctx->dest.used;
cleanup:
    if(ctx->compressor.mem&&!ctx->destroying) {
        ctx->destroying=1;++ctx->outcome.destroy_calls;
        api->destroy_compress(&ctx->compressor);
    }
    if(ctx->outcome.status!=IQ4_JPEG_OK)ctx->outcome.jpeg_bytes=0;
    *result=ctx->outcome;free(ctx);return result->status;
}
