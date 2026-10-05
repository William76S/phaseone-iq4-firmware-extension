#include "native_jpeg82.h"
#include "code_pins.h"

_Static_assert(JPEG_LIB_VERSION==82,"Use IQ4_JPEG_API_VERSION=82 explicitly");
_Static_assert(BITS_IN_JSAMPLE==8 && sizeof(JSAMPLE)==1,"8-bit sample ABI");
_Static_assert(sizeof(void*)==8 && sizeof(size_t)==8 && sizeof(boolean)==4,
               "JPEG8 LP64 ABI");
_Static_assert(sizeof(JDIMENSION)==4,"JDIMENSION U32");
_Static_assert(sizeof(struct jpeg_compress_struct)==584,"native Create size");
_Static_assert(sizeof(struct jpeg_error_mgr)==168,"native error manager size");
_Static_assert(sizeof(struct jpeg_destination_mgr)==40,"destination callbacks");
_Static_assert(offsetof(struct jpeg_compress_struct,err)==0,"err");
_Static_assert(offsetof(struct jpeg_compress_struct,mem)==8,"mem");
_Static_assert(offsetof(struct jpeg_compress_struct,client_data)==24,"client_data");
_Static_assert(offsetof(struct jpeg_compress_struct,global_state)==36,"state");
_Static_assert(offsetof(struct jpeg_compress_struct,dest)==40,"dest");
_Static_assert(offsetof(struct jpeg_compress_struct,image_width)==48,"width");
_Static_assert(offsetof(struct jpeg_compress_struct,image_height)==52,"height");
_Static_assert(offsetof(struct jpeg_compress_struct,input_components)==56,"components");
_Static_assert(offsetof(struct jpeg_compress_struct,in_color_space)==60,"colorspace");
_Static_assert(offsetof(struct jpeg_compress_struct,data_precision)==88,"precision");
_Static_assert(offsetof(struct jpeg_compress_struct,next_scanline)==340,"scanline");
_Static_assert(offsetof(struct jpeg_error_mgr,msg_code)==40,"error code");
_Static_assert(offsetof(struct jpeg_error_mgr,reset_error_mgr)==32,"reset callback");
_Static_assert(offsetof(struct jpeg_destination_mgr,init_destination)==16,"init dest");
_Static_assert(offsetof(struct jpeg_destination_mgr,empty_output_buffer)==24,"empty dest");
_Static_assert(offsetof(struct jpeg_destination_mgr,term_destination)==32,"term dest");
_Static_assert(JCS_RGB==2 && JCS_EXT_ARGB==15,"original colorspace values");

Iq4JpegApi iq4_native_jpeg82_unadmitted_table_01(void) {
    Iq4JpegApi a;
    a.std_error=(struct jpeg_error_mgr *(*)(struct jpeg_error_mgr *))(uintptr_t)0x9a20f0u;
    a.create_compress=(void (*)(j_compress_ptr,int,size_t))(uintptr_t)0x9a2148u;
    a.set_defaults=(void (*)(j_compress_ptr))(uintptr_t)0x9a34b8u;
    a.set_quality=(void (*)(j_compress_ptr,int,boolean))(uintptr_t)0x9a2fc8u;
    a.start_compress=(void (*)(j_compress_ptr,boolean))(uintptr_t)0x9a39e0u;
    a.write_scanlines=(JDIMENSION (*)(j_compress_ptr,JSAMPARRAY,JDIMENSION))(uintptr_t)0x9a3a88u;
    a.finish_compress=(void (*)(j_compress_ptr))(uintptr_t)0x9a22f0u;
    a.destroy_compress=(void (*)(j_compress_ptr))(uintptr_t)0x9a2248u;
    a.api_version=82;
    a.compressor_struct_bytes=584;
    a.binding_abi_verified=0;
    return a;
}

Iq4Jpeg82BindStatus01 iq4_native_jpeg82_bind_01(
    const uint8_t original_baseline_sha256[32], Iq4Jpeg82ReadExact01 read_exact,
    void *context, Iq4JpegApi *output) {
    uint8_t observed[64];
    size_t i,j,offset,n;
    if(!output)return IQ4_JPEG82_ARGUMENT_01;
    *output=(Iq4JpegApi){0};
    if(!original_baseline_sha256||!read_exact)return IQ4_JPEG82_ARGUMENT_01;
    for(i=0;i<32;++i)
        if(original_baseline_sha256[i]!=iq4_jpeg82_original_sha01[i])
            return IQ4_JPEG82_BASELINE_01;
#if !(defined(__aarch64__) && defined(__linux__)) && !defined(IQ4_JPEG82_SYNTHETIC_HOST_TEST_ONLY)
    (void)context;(void)observed;(void)j;(void)offset;(void)n;
    return IQ4_JPEG82_ARCHITECTURE_01;
#else
    for(i=0;i<sizeof(iq4_jpeg82_code_pins01)/sizeof(iq4_jpeg82_code_pins01[0]);++i) {
        const Iq4Jpeg82CodePin01 *p=&iq4_jpeg82_code_pins01[i];
        for(offset=0;offset<p->bytes;offset+=n) {
            n=p->bytes-offset;if(n>sizeof(observed))n=sizeof(observed);
            if(read_exact(context,p->va+offset,observed,n)!=1)
                return IQ4_JPEG82_CODE_READ_01;
            for(j=0;j<n;++j)
                if(observed[j]!=p->original[offset+j])
                    return IQ4_JPEG82_CODE_MISMATCH_01;
        }
    }
    *output=iq4_native_jpeg82_unadmitted_table_01();
    output->binding_abi_verified=1;
    return IQ4_JPEG82_BOUND_STATIC_ABI_01;
#endif
}
