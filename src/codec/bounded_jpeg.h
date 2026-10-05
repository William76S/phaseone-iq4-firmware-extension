#ifndef IQ4_BOUNDED_JPEG_H
#define IQ4_BOUNDED_JPEG_H
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include "vendor/libjpeg-turbo-1.5.3/jpeglib.h"
#ifdef __cplusplus
extern "C" {
#endif

/* No automatic symbol/address lookup, and no default target binding. Callers
 * supply a verified C API table and keep its library valid through the call.
 * This API cannot validate a camera firmware hash or a private function address.
 */
typedef struct Iq4JpegApi {
    struct jpeg_error_mgr* (*std_error)(struct jpeg_error_mgr*);
    void (*create_compress)(j_compress_ptr,int,size_t);
    void (*set_defaults)(j_compress_ptr);
    void (*set_quality)(j_compress_ptr,int,boolean);
    void (*start_compress)(j_compress_ptr,boolean);
    JDIMENSION (*write_scanlines)(j_compress_ptr,JSAMPARRAY,JDIMENSION);
    void (*finish_compress)(j_compress_ptr);
    void (*destroy_compress)(j_compress_ptr);
    int api_version;
    size_t compressor_struct_bytes;
    int binding_abi_verified; /* explicit caller assertion; default zero refuses */
} Iq4JpegApi;
typedef enum Iq4JpegStatus {
    IQ4_JPEG_OK=0, IQ4_JPEG_INVALID_ARGUMENT, IQ4_JPEG_UNBOUND_OR_ABI_MISMATCH,
    IQ4_JPEG_OUTPUT_CAPACITY, IQ4_JPEG_LIBRARY_ERROR, IQ4_JPEG_NO_MEMORY,
    IQ4_JPEG_CLEANUP_ERROR, IQ4_JPEG_SUSPENDED
} Iq4JpegStatus;
typedef struct Iq4JpegInput {
    const uint8_t* rgb24;
    size_t bytes;
    uint32_t width,height;
    size_t stride;
    int quality; /* explicit 1..100, baseline force=true */
} Iq4JpegInput;
typedef struct Iq4JpegResult {
    Iq4JpegStatus status;
    size_t jpeg_bytes; /* zero on EVERY failure; never expose a partial packet */
    int library_message_code;
    unsigned destroy_calls;
    char error[200];
} Iq4JpegResult;

/* Synchronous read-only RGB24 input -> caller-owned hard-capacity output.
 * Input and output must not overlap; input/stride/capacity stay valid until
 * return. API/input descriptors and result storage must also be distinct from
 * output and RGB storage; an overlapping result is rejected without writing it.
 * Never reallocates output. Library working memory is separate and is
 * NOT claimed bounded by destination capacity. All longjmp paths remain in C.
 */
Iq4JpegStatus iq4_jpeg_encode_bounded(const Iq4JpegApi* api,const Iq4JpegInput* input,
                                     uint8_t* output,size_t capacity,Iq4JpegResult* result);
#ifdef __cplusplus
}
#endif
#endif
