#include "../../../src/codec/stream_rgb32.h"
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>
static unsigned groups;
static Iq4JpegApi api(void) {
    Iq4JpegApi a={jpeg_std_error,jpeg_CreateCompress,jpeg_set_defaults,jpeg_set_quality,
        jpeg_start_compress,jpeg_write_scanlines,jpeg_finish_compress,jpeg_destroy_compress,
        JPEG_LIB_VERSION,sizeof(struct jpeg_compress_struct),1};return a;
}
typedef struct Sink {uint8_t *data;size_t n,cap,calls;unsigned fail_call;} Sink;
static size_t put(void *v,const uint8_t *p,size_t n) {
    Sink *s=v;size_t actual=++s->calls==s->fail_call?n/2:n;
    if(s->n+actual>s->cap){s->cap=(s->n+actual)*2;s->data=realloc(s->data,s->cap);assert(s->data);}
    memcpy(s->data+s->n,p,actual);s->n+=actual;return actual;
}
static size_t file_put(void *v,const uint8_t *p,size_t n){return fwrite(p,1,n,(FILE *)v);}
static void reset(Sink *s){free(s->data);memset(s,0,sizeof(*s));}
static void fatal_start(j_compress_ptr c,boolean tables){(void)tables;c->err->msg_code=999;(*c->err->error_exit)((j_common_ptr)c);}
static void fatal_finish(j_compress_ptr c){c->err->msg_code=999;(*c->err->error_exit)((j_common_ptr)c);}
static void fatal_destroy(j_compress_ptr c){jpeg_destroy_compress(c);c->err->msg_code=999;(*c->err->error_exit)((j_common_ptr)c);}
static JDIMENSION suspend(j_compress_ptr c,JSAMPARRAY rows,JDIMENSION n){(void)c;(void)rows;(void)n;return 0;}
static JDIMENSION wrong_progress(j_compress_ptr c,JSAMPARRAY rows,JDIMENSION n){(void)rows;(void)n;c->next_scanline+=2;return 1;}
static void fixture(uint8_t *p,unsigned w,unsigned h,size_t stride) {
    unsigned x,y;memset(p,0x53,stride*h);
    for(y=0;y<h;++y)for(x=0;x<w;++x){uint8_t *q=p+y*stride+x*4;
        q[0]=(uint8_t)(x+y);q[1]=(uint8_t)(x*255u/w);q[2]=(uint8_t)(y*255u/h);q[3]=(uint8_t)(((x/32+y/32)&1)?192:64);}
}
static void check_decode(FILE *f,unsigned w,unsigned h) {
    struct jpeg_decompress_struct c={0};struct jpeg_error_mgr e;uint8_t *row;size_t n;
    c.err=jpeg_std_error(&e);jpeg_create_decompress(&c);rewind(f);jpeg_stdio_src(&c,f);
    assert(jpeg_read_header(&c,TRUE)==JPEG_HEADER_OK&&c.image_width==w&&c.image_height==h);
    c.out_color_space=JCS_RGB;assert(jpeg_start_decompress(&c));
    assert(c.output_width==w&&c.output_height==h&&c.output_components==3);
    row=malloc((size_t)w*3);assert(row);n=0;
    while(c.output_scanline<c.output_height){JSAMPROW a=row;assert(jpeg_read_scanlines(&c,&a,1)==1);++n;}
    assert(n==h&&jpeg_finish_decompress(&c));jpeg_destroy_decompress(&c);free(row);
}
static void small_tests(void) {
    const unsigned w=640,h=480;const size_t stride=w*4+17,bytes=stride*h;
    uint8_t *p=malloc(bytes),*before=malloc(bytes),*rgb=malloc(w*h*3),*packet=malloc(4*1024*1024);
    Iq4JpegApi a=api();Iq4Rgb32Input in={p,bytes,stride,w,h,92};Sink s={0};Iq4JpegSink sink={&s,put,4*1024*1024};Iq4StreamResult r;unsigned x,y;FILE *f;
    assert(p&&before&&rgb&&packet);fixture(p,w,h,stride);memcpy(before,p,bytes);
    assert(iq4_jpeg_stream_rgb32(&a,&in,&sink,&r)==IQ4_STREAM_OK);
    assert(r.rows_encoded==h&&r.destroy_calls==1&&r.jpeg_bytes==s.n&&r.destination_bytes==16384&&r.rgb24_scanline_bytes==w*3);
    f=tmpfile();assert(f&&fwrite(s.data,1,s.n,f)==s.n);check_decode(f,w,h);assert(!fclose(f));++groups;
    /* Byte equality with prior RGB24 codec isolates channel order, row stride,
     * and streaming destination from JPEG-library/compression differences. */
    for(y=0;y<h;++y)for(x=0;x<w;++x)memcpy(rgb+3*(y*w+x),p+y*stride+4*x+1,3);
    {Iq4JpegInput q={rgb,w*h*3,w,h,w*3,92};Iq4JpegResult rr;
     assert(iq4_jpeg_encode_bounded(&a,&q,packet,4*1024*1024,&rr)==IQ4_JPEG_OK);
     assert(rr.jpeg_bytes==s.n&&!memcmp(packet,s.data,s.n));}++groups;
    assert(!memcmp(p,before,bytes));reset(&s);
    a.binding_abi_verified=0;assert(iq4_jpeg_stream_rgb32(&a,&in,&sink,&r)==IQ4_STREAM_UNBOUND&&s.calls==0);a=api();++groups;
    sink.byte_budget=10;assert(iq4_jpeg_stream_rgb32(&a,&in,&sink,&r)==IQ4_STREAM_BUDGET&&r.jpeg_bytes==0&&s.calls==0&&r.destroy_calls==1);sink.byte_budget=4*1024*1024;++groups;
    s.fail_call=1;assert(iq4_jpeg_stream_rgb32(&a,&in,&sink,&r)==IQ4_STREAM_SHORT_WRITE&&r.jpeg_bytes==0&&r.accepted_prefix_bytes==s.n&&r.destroy_calls==1);reset(&s);++groups;
    a.start_compress=fatal_start;assert(iq4_jpeg_stream_rgb32(&a,&in,&sink,&r)==IQ4_STREAM_LIBRARY_ERROR&&r.jpeg_bytes==0&&r.destroy_calls==1);a=api();reset(&s);++groups;
    a.finish_compress=fatal_finish;assert(iq4_jpeg_stream_rgb32(&a,&in,&sink,&r)==IQ4_STREAM_LIBRARY_ERROR&&r.jpeg_bytes==0&&r.destroy_calls==1);a=api();reset(&s);++groups;
    a.destroy_compress=fatal_destroy;assert(iq4_jpeg_stream_rgb32(&a,&in,&sink,&r)==IQ4_STREAM_CLEANUP_ERROR&&r.jpeg_bytes==0&&r.destroy_calls==1);a=api();reset(&s);++groups;
    a.write_scanlines=suspend;assert(iq4_jpeg_stream_rgb32(&a,&in,&sink,&r)==IQ4_STREAM_SUSPENDED&&r.jpeg_bytes==0&&r.destroy_calls==1);a=api();reset(&s);++groups;
    a.write_scanlines=wrong_progress;assert(iq4_jpeg_stream_rgb32(&a,&in,&sink,&r)==IQ4_STREAM_SUSPENDED&&r.jpeg_bytes==0&&r.destroy_calls==1);a=api();reset(&s);++groups;
    in.bytes=3;assert(iq4_jpeg_stream_rgb32(&a,&in,&sink,&r)==IQ4_STREAM_ARGUMENT&&s.calls==0);in.bytes=bytes;
    in.stride=1;assert(iq4_jpeg_stream_rgb32(&a,&in,&sink,&r)==IQ4_STREAM_ARGUMENT);in.stride=stride;
    assert(iq4_jpeg_stream_rgb32(&a,&in,&sink,(Iq4StreamResult *)p)==IQ4_STREAM_ARGUMENT&&!memcmp(p,before,bytes));++groups;
    assert(iq4_jpeg_stream_rgb32(&a,&in,&sink,&r)==IQ4_STREAM_OK&&r.rows_encoded==h);reset(&s);++groups;
    free(p);free(before);free(rgb);free(packet);
}
static void full_geometry_tests(const char *directory) {
    const unsigned widths[3]={14204,10653,7102},heights[3]={10652,7989,5326};unsigned j;
    for(j=0;j<3;++j){
        const unsigned w=widths[j],h=heights[j];const size_t stride=(size_t)w*4+17,bytes=stride*h;
        uint8_t *pixels=malloc(bytes);Iq4JpegApi a=api();Iq4Rgb32Input in={pixels,bytes,stride,w,h,92};Iq4StreamResult r;
        char path[4096];FILE *f;Iq4JpegSink sink;
        assert(pixels);fixture(pixels,w,h,stride);snprintf(path,sizeof path,"%s/synthetic_%ux%u.jpg",directory,w,h);
        f=fopen(path,"wb+");assert(f);sink=(Iq4JpegSink){f,file_put,1024u*1024u*1024u};
        assert(iq4_jpeg_stream_rgb32(&a,&in,&sink,&r)==IQ4_STREAM_OK&&r.rows_encoded==h&&r.jpeg_bytes>0&&r.rgb24_scanline_bytes==w*3u);
        assert(!fflush(f));check_decode(f,w,h);assert(!fclose(f));
        printf("{\"synthetic_geometry\":[%u,%u],\"jpeg_bytes\":%" PRIu64 ",\"rgb24_row_bytes\":%zu,\"destination_bytes\":%zu,\"decoded_rows\":%u,\"camera\":false}\n",w,h,r.jpeg_bytes,r.rgb24_scanline_bytes,r.destination_bytes,h);
        free(pixels);++groups;
    }
}
int main(int argc,char **argv){small_tests();if(argc==2)full_geometry_tests(argv[1]);printf("{\"host_groups\":%u,\"passed\":true,\"native_target\":false}\n",groups);return 0;}
