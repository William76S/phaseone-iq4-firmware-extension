#ifndef IQ4_F3_STREAM_CODEC_BRIDGE_02_H
#define IQ4_F3_STREAM_CODEC_BRIDGE_02_H
#include "stream.h"
#include "../../../src/codec/stream_rgb32.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Begin transaction first. No automatic native codec lookup or FS binding. */
const struct F3StreamResult *f3_stream_encode_rgb32_02(struct F3Stream*,const Iq4JpegApi*,const Iq4Rgb32Input*,Iq4StreamResult*);
#ifdef __cplusplus
}
#endif
#endif
