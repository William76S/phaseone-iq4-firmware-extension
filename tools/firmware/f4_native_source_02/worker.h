#ifndef IQ4_F4_NATIVE_WORKER_02_H
#define IQ4_F4_NATIVE_WORKER_02_H
#include "source.h"
#include "../../../src/codec/bounded_jpeg.h"
#include "../../../src/recording/native_mkv.h"
#ifdef __cplusplus
extern "C" {
#endif
enum Iq4F4WorkerResult02 { IQ4_F4_WORKER_PACKET=0,IQ4_F4_WORKER_EMPTY=1,
 IQ4_F4_WORKER_REJECTED=2,IQ4_F4_WORKER_CODEC_ERROR=3,IQ4_F4_WORKER_FILE_ERROR=4,IQ4_F4_WORKER_HOLD=5 };
typedef struct {void*source;struct Iq4Mkv*mkv;Iq4JpegApi jpeg;
 unsigned char*packet;uint32_t packet_capacity;int quality;
 uint64_t native_worker_tid,encoded,codec_errors,mode_errors,last_extended_id;
 uint32_t last_id,seen_id,held_uncertain,ready;} Iq4F4Worker02;
/* Calls only the finite JPEG82 byte binder, never an encoder during init.
 * mkv is already begun by the same worker using a held native card lease.
 * No automatic file/path, native page, pthread, upsampling or fps control. */
int iq4_f4_worker_init_02(Iq4F4Worker02*,void*source,struct Iq4Mkv*,unsigned char*packet,
 uint32_t packet_capacity,int quality,Iq4F4SelfRead02,void*read_context);
int iq4_f4_worker_pump_one_02(Iq4F4Worker02*);
/* Source must first stop on its real UI owner. Pending is not finalize success.
 * Sealing is not publication; Root's native storage must flush/readback/publish. */
int iq4_f4_worker_seal_02(Iq4F4Worker02*);
#ifdef __cplusplus
}
#endif
#endif
