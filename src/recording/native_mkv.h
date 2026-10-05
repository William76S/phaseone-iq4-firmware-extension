#ifndef IQ4_NATIVE_MKV_H
#define IQ4_NATIVE_MKV_H
#include "../../tools/firmware/f3_stream_transaction_02/stream.h"
#ifdef __cplusplus
extern "C" {
#endif
enum Iq4MkvStatus { IQ4_MKV_OK,IQ4_MKV_ARGUMENT,IQ4_MKV_STATE,
 IQ4_MKV_PACKET,IQ4_MKV_ORDER,IQ4_MKV_LIMIT,IQ4_MKV_IO,IQ4_MKV_HOLD };
enum Iq4MkvState { IQ4_MKV_IDLE,IQ4_MKV_WRITING,IQ4_MKV_SEALED,
                  IQ4_MKV_FAILED,IQ4_MKV_UNKNOWN };
struct Iq4MkvIo {
 void *context;
 struct F3Io (*append)(void*,const uint8_t*,uint32_t);
 struct F3Io (*patch)(void*,uint64_t,const uint8_t*,uint32_t);
};
struct Iq4Mkv {
 struct Iq4MkvIo io;
 uint32_t state,width,height,max_packet_bytes,max_frames,frames;
 uint64_t max_file_bytes,file_bytes,segment_size_offset,segment_start;
 uint64_t first_observed_ns,last_observed_ns,last_local_sequence;
};
/* Concrete freestanding downport of the existing VFR Matroska backend.
 * Does not allocate, create/open/publish files, generate timestamps, duplicate
 * frames or claim a local sequence is a sensor counter. Existing private fd
 * and actual card/source owners are the external native worker's responsibility. */
enum Iq4MkvStatus iq4_mkv_begin(struct Iq4Mkv*,const struct Iq4MkvIo*,
 uint32_t,uint32_t,uint64_t,uint32_t,uint32_t);
enum Iq4MkvStatus iq4_mkv_packet(struct Iq4Mkv*,const uint8_t*,uint32_t,
 uint64_t observed_ns,uint64_t local_sequence);
/* Only seals Segment length. Checked fsync/close/full readback/noreplace
 * publication is required separately; SEALED does not mean published. */
enum Iq4MkvStatus iq4_mkv_seal(struct Iq4Mkv*);
enum Iq4MkvScanStatus {IQ4_MKV_SCAN_PACKET,IQ4_MKV_SCAN_END,
 IQ4_MKV_SCAN_ARGUMENT,IQ4_MKV_SCAN_FORMAT,IQ4_MKV_SCAN_IO,IQ4_MKV_SCAN_HOLD};
struct Iq4MkvReader {
 void *context;
 struct F3Io (*read_at)(void*,uint64_t,uint8_t*,uint32_t);
};
struct Iq4MkvScan {
 struct Iq4MkvReader reader;
 uint64_t file_bytes,offset,first_ns,last_ns,last_local_sequence;
 uint32_t width,height,packet_limit,frames,ended,hold;
};
/* Recovery reads original partial read-only and yields only complete JPEG +
 * CRC'd local-timestamp pairs. Feed into a NEW exclusive writer; no in-place
 * repair or deletion. Actual immutable fd/card owner is required externally. */
enum Iq4MkvScanStatus iq4_mkv_scan_begin(struct Iq4MkvScan*,const struct Iq4MkvReader*,
 uint64_t,uint32_t,uint32_t,uint32_t);
enum Iq4MkvScanStatus iq4_mkv_scan_next(struct Iq4MkvScan*,uint8_t*,uint32_t,
 uint32_t *bytes,uint64_t *observed_ns,uint64_t *local_sequence);
#ifdef __cplusplus
}
#endif
#endif
