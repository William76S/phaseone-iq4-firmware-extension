#include "../../../src/codec/stream_rgb32.h"
#include <assert.h>
#include <stdlib.h>
#include <inttypes.h>
static size_t put(void*v,const uint8_t*p,size_t n){return fwrite(p,1,n,v);}
int main(void){
 const unsigned widths[]={14204,10653,7102},heights[]={10652,7989,5326};
 Iq4JpegApi api={jpeg_std_error,jpeg_CreateCompress,jpeg_set_defaults,jpeg_set_quality,jpeg_start_compress,jpeg_write_scanlines,jpeg_finish_compress,jpeg_destroy_compress,JPEG_LIB_VERSION,sizeof(struct jpeg_compress_struct),1};
 for(unsigned size=0;size<3;++size){
  unsigned w=widths[size],h=heights[size];size_t bytes=(size_t)w*h*4;uint8_t*p=malloc(bytes);assert(p);uint32_t rng=0x12345678;
  for(size_t i=0;i<bytes;++i){rng=rng*1664525u+1013904223u;p[i]=(uint8_t)(rng>>24);}
  FILE*f=tmpfile();assert(f);Iq4JpegSink sink={f,put,1024ull*1024*1024};Iq4Rgb32Input in={p,bytes,(size_t)w*4,w,h,100};Iq4StreamResult result;
  assert(iq4_jpeg_stream_rgb32(&api,&in,&sink,&result)==IQ4_STREAM_OK&&result.rows_encoded==h&&result.destroy_calls==1);free(p);assert(!fflush(f));rewind(f);
  struct jpeg_decompress_struct d={0};struct jpeg_error_mgr err;d.err=jpeg_std_error(&err);jpeg_create_decompress(&d);jpeg_stdio_src(&d,f);assert(jpeg_read_header(&d,TRUE)==JPEG_HEADER_OK&&d.image_width==w&&d.image_height==h);
  for(unsigned t=0;t<NUM_QUANT_TBLS;++t)if(d.quant_tbl_ptrs[t])for(unsigned q=0;q<DCTSIZE2;++q)assert(d.quant_tbl_ptrs[t]->quantval[q]==1);
  d.out_color_space=JCS_RGB;assert(jpeg_start_decompress(&d));p=malloc((size_t)w*3);assert(p);unsigned rows=0;while(d.output_scanline<h){JSAMPROW row=p;assert(jpeg_read_scanlines(&d,&row,1)==1);++rows;}assert(rows==h&&jpeg_finish_decompress(&d));jpeg_destroy_decompress(&d);free(p);assert(!fclose(f));
  printf("{\"width\":%u,\"height\":%u,\"quality\":100,\"all_quantizers\":1,\"jpeg_bytes\":%"PRIu64",\"fits_previous_256MiB\":%s,\"decoded_rows\":%u,\"input\":\"deterministic independent RGB noise\",\"hardware\":false}\n",w,h,result.jpeg_bytes,result.jpeg_bytes<=256ull*1024*1024?"true":"false",rows);fflush(stdout);
 }
}
