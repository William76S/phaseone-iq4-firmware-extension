#ifndef IQ4_F3_STREAM_EXPORT_03_H
#define IQ4_F3_STREAM_EXPORT_03_H
#include "../f3_stream_transaction_02/stream.h"
#include "../../../src/codec/stream_export.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Immutable original complete valid-RAW source geometry plus canonical output.
 * render_width/height identify the actual streamed RGB24 row geometry; the
 * full native RGB32 plane remains borrowed and must match source_raw_width/h. */
struct F3ExportRequest03 {struct F3Job job;uint32_t rotation,size_mode;int quality;};
struct F3ExportStream03 {struct F3Stream checked;struct Iq4ExportGeometry geometry;int quality;uint32_t requested_mode;};
int f3_export_stream_begin_03(struct F3ExportStream03*,struct F3Session*,
 const struct F3ExportRequest03*,const struct F3Ports*,uint64_t,uint8_t*,size_t);
const struct F3StreamResult*f3_export_stream_encode_03(struct F3ExportStream03*,
 const Iq4JpegApi*,const Iq4Rgb32Input*,Iq4StreamResult*);
/* This layer ALWAYS retains RAW, including JPEG-only capture requests. Only the
 * production coordinator may apply requested_mode after checked JPEG publication,
 * native render cleanup, reader/arena ownership and a fresh new-capture proof. */
void f3_jpeg_syntax_init_03(struct F3JpegSyntax*);
int f3_jpeg_syntax_feed_03(struct F3JpegSyntax*,const uint8_t*,size_t);
int f3_jpeg_syntax_done_03(const struct F3JpegSyntax*,uint32_t,uint32_t);
size_t f3_stream_sink_write_03(void*,const uint8_t*,size_t);
const struct F3StreamResult*f3_stream_finish_03(struct F3Stream*,const struct F3EncoderCompletion*);
const struct F3StreamResult*f3_stream_abort_03(struct F3Stream*);
const struct F3StreamResult*f3_stream_hold_03(struct F3Stream*,uint32_t);
#ifdef __cplusplus
}
#endif
#endif
