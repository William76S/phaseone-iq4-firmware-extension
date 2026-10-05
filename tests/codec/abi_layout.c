#include "../../src/codec/bounded_jpeg.h"
#include <stdio.h>
int main(void) {
    printf("{\"api_version\":%d,\"sample_bits\":%d,\"pointer_bytes\":%zu,\"compressor_bytes\":%zu,\"error_mgr_bytes\":%zu,\"destination_mgr_bytes\":%zu,\"fields\":{\"err\":%zu,\"mem\":%zu,\"client_data\":%zu,\"dest\":%zu,\"image_width\":%zu,\"image_height\":%zu,\"input_components\":%zu,\"in_color_space\":%zu,\"input_gamma\":%zu,\"next_scanline\":%zu}}\n",
      JPEG_LIB_VERSION,BITS_IN_JSAMPLE,sizeof(void*),sizeof(struct jpeg_compress_struct),sizeof(struct jpeg_error_mgr),sizeof(struct jpeg_destination_mgr),
      offsetof(struct jpeg_compress_struct,err),offsetof(struct jpeg_compress_struct,mem),offsetof(struct jpeg_compress_struct,client_data),offsetof(struct jpeg_compress_struct,dest),offsetof(struct jpeg_compress_struct,image_width),offsetof(struct jpeg_compress_struct,image_height),offsetof(struct jpeg_compress_struct,input_components),offsetof(struct jpeg_compress_struct,in_color_space),offsetof(struct jpeg_compress_struct,input_gamma),offsetof(struct jpeg_compress_struct,next_scanline));
    return 0;
}
