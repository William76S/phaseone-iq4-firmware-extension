#ifndef IQ4_F3_JPEG_CAPACITY_01_H
#define IQ4_F3_JPEG_CAPACITY_01_H
#include "../f3_stream_transaction_02/stream.h"
#if F3_STREAM_MAX_BYTES != (256u*1024u*1024u)
#error unexpected original stream capacity
#endif
#undef F3_STREAM_MAX_BYTES
/* File length ceiling only. Encoder still uses one row and 16KiB chunks. */
#define F3_STREAM_MAX_BYTES (1024ull*1024ull*1024ull)
#endif
