#include "codec_bridge.h"
static int overlap(const void*a,size_t an,const void*b,size_t bn){
 uintptr_t x=(uintptr_t)a,y=(uintptr_t)b;if(!a||!b||!an||!bn)return 0;
 if(an>UINTPTR_MAX-x||bn>UINTPTR_MAX-y)return 1;return x<y+bn&&y<x+an;
}
const struct F3StreamResult *f3_stream_encode_rgb32_02(struct F3Stream*c,const Iq4JpegApi*a,const Iq4Rgb32Input*in,Iq4StreamResult*out){
 if(!c||!in||!out||c->state!=1||!c->session||c->session->hold||!c->session->in_progress)return c?&c->result:0;
 if(overlap(out,sizeof(*out),c,sizeof(*c))||overlap(out,sizeof(*out),c->session,sizeof(*c->session))||
    overlap(out,sizeof(*out),c->scratch,c->scratch_bytes)||overlap(in,sizeof(*in),c,sizeof(*c))||
    overlap(a,sizeof(*a),c,sizeof(*c))||overlap(in->pixels,in->bytes,c,sizeof(*c))||
    overlap(in->pixels,in->bytes,c->scratch,c->scratch_bytes))return f3_stream_abort_02(c);
 if(in->width!=c->job.output_width||in->height!=c->job.output_height)return f3_stream_abort_02(c);
 Iq4JpegSink sink={c,f3_stream_sink_write_02,c->byte_budget};
 Iq4StreamStatus r=iq4_jpeg_stream_rgb32(a,in,&sink,out);
 if(c->state==3)return &c->result;
 if(r!=IQ4_STREAM_OK)return f3_stream_abort_02(c);
 struct F3EncoderCompletion e={1,1,out->destroy_calls==1,out->rows_encoded,out->jpeg_bytes};
 return f3_stream_finish_02(c,&e);
}
