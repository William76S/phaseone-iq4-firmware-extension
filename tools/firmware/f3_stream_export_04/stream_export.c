#include "stream_export.h"
static int same(const struct F3File*a,const struct F3File*b,int bytes){
 return a->device==b->device&&a->inode==b->inode&&a->card_epoch==b->card_epoch&&a->task_nonce==b->task_nonce&&(!bytes||a->bytes==b->bytes);
}
static int valid(const struct F3File*f){return f->device&&f->inode&&f->card_epoch&&f->task_nonce&&f->bytes;}
static int overlap(const void*a,size_t an,const void*b,size_t bn){
 uintptr_t x=(uintptr_t)a,y=(uintptr_t)b;if(!a||!b||!an||!bn)return 0;
 if(an>UINTPTR_MAX-x||bn>UINTPTR_MAX-y)return 1;return x<y+bn&&y<x+an;
}
static int text_equal(const char*a,const char*b){for(unsigned i=0;i<65;++i)if(a[i]!=b[i])return 0;return 1;}
void f3_jpeg_syntax_init_03(struct F3JpegSyntax*s){struct F3JpegSyntax z={0};*s=z;}
static int segment_done(struct F3JpegSyntax*s){
 if(s->marker==192){
  if(s->found_sof||s->length!=17||s->body[0]!=8||s->body[5]!=3)return 0;
  s->height=((uint32_t)s->body[1]<<8)|s->body[2];s->width=((uint32_t)s->body[3]<<8)|s->body[4];
  if(!s->width||!s->height)return 0;
  for(unsigned i=0;i<3;++i){uint8_t id=s->body[6+3*i],sam=s->body[7+3*i],q=s->body[8+3*i];
   if(!(sam>>4)||!(sam&15)||(sam>>4)>4||(sam&15)>4||q>3)return 0;
   for(unsigned k=0;k<i;++k)if(s->component_ids[k]==id)return 0;s->component_ids[i]=id;
  }s->found_sof=1;
 }
 if(s->marker==218){
  if(!s->found_sof||s->found_sos||s->length!=12||s->body[0]!=3||s->body[7]!=0||s->body[8]!=63||s->body[9]!=0)return 0;
  for(unsigned i=0;i<3;++i){unsigned matches=0;for(unsigned k=0;k<3;++k)matches+=s->body[1+2*i]==s->component_ids[k];
   if(matches!=1||(s->body[2+2*i]>>4)>3||(s->body[2+2*i]&15)>3)return 0;
   for(unsigned k=0;k<i;++k)if(s->body[1+2*i]==s->body[1+2*k])return 0;
  }s->found_sos=1;s->state=7;return 1;
 }
 s->state=2;return 1;
}
int f3_jpeg_syntax_feed_03(struct F3JpegSyntax*s,const uint8_t*p,size_t n){
 if(!s||s->failed||(!p&&n))return 0;
 for(size_t i=0;i<n;++i){unsigned b=p[i];switch(s->state){
  case 0:if(b!=255)goto bad;s->state=1;break;
  case 1:if(b!=216)goto bad;s->state=2;break;
  case 2:if(b!=255)goto bad;s->state=3;break;
  case 3:if(b==255)break;
   if(!(b==192||b==196||b==219||b==221||b==254||(b>=224&&b<=239)||b==218))goto bad;
   if(b==218&&!s->found_sof)goto bad;s->marker=b;s->state=4;break;
  case 4:s->length=b<<8;s->state=5;break;
  case 5:s->length|=b;if(s->length<2)goto bad;
   if((s->marker==192&&s->length!=17)||(s->marker==218&&s->length!=12)||(s->marker==221&&s->length!=4))goto bad;
   s->remaining=s->length-2;s->position=0;s->state=6;
   if(!s->remaining&&!segment_done(s))goto bad;break;
  case 6:if(s->position<sizeof(s->body))s->body[s->position]=(uint8_t)b;
   ++s->position;if(!--s->remaining&&!segment_done(s))goto bad;break;
  case 7:if(b==255)s->state=8;else s->entropy=1;break;
  case 8:if(b==255)break;
   if(b==0||(b>=208&&b<=215)){s->entropy=1;s->state=7;break;}
   if(b==217&&s->entropy){s->state=9;break;}goto bad;
  default:goto bad;
 }}return 1;
 bad:s->failed=1;return 0;
}
int f3_jpeg_syntax_done_03(const struct F3JpegSyntax*s,uint32_t w,uint32_t h){
 return s&&!s->failed&&s->state==9&&s->found_sof&&s->found_sos&&s->entropy&&s->width==w&&s->height==h;
}
static int active(const struct F3Stream*c){return c&&c->session&&c->session->in_progress&&!c->session->hold&&(c->state==1||c->state==2);}
static void fail(struct F3Stream*c,unsigned step){c->state=2;c->result.saved.status=F3_FAILED_RAW_RETAINED;c->result.saved.failure_step=step;}
const struct F3StreamResult *f3_stream_hold_03(struct F3Stream*c,uint32_t step){
 if(!c)return 0;c->state=3;c->result.saved.status=F3_UNKNOWN_HOLD;c->result.saved.failure_step=step;
 if(c->session){c->session->hold=1;c->session->in_progress=1;}return &c->result;
}
static int observe(struct F3Stream*c,struct F3Io r,unsigned step){
 if(r.state==F3_IO_DONE)return 1;if(r.state==F3_IO_FAIL)fail(c,step);else f3_stream_hold_03(c,step);return 0;
}
static void end(struct F3Stream*c){c->state=4;c->session->in_progress=0;}
static int close_write(struct F3Stream*c,unsigned step){
 ++c->result.saved.close_write_calls;struct F3Io r=c->ports.close_write(c->ports.context);
 if(r.state==F3_IO_DONE||r.state==F3_IO_FAIL)c->result.saved.write_open=0;return observe(c,r,step);
}
static int close_read(struct F3Stream*c,unsigned step){
 ++c->result.saved.close_read_calls;struct F3Io r=c->ports.close_read(c->ports.context);
 if(r.state==F3_IO_DONE||r.state==F3_IO_FAIL)c->result.saved.read_open=0;return observe(c,r,step);
}
static int begin_checked(struct F3Stream*c,struct F3Session*s,const struct F3Job*j,const struct F3Ports*p,uint64_t budget,uint8_t*scratch,size_t cap,const struct Iq4ExportGeometry*g){
 if(!c||!s||!j||!p||!g||c->state||s->hold||s->in_progress||!s->boot_epoch||s->boot_epoch!=j->boot_epoch||!j->capture_id||!valid(&j->raw)||
    j->mode>F3_JPEG_ONLY||(j->purpose!=F3_NEW_CAPTURE&&j->purpose!=F3_MANUAL_EXISTING_RAW)||j->newly_created_raw_stage>1||
    (j->purpose==F3_MANUAL_EXISTING_RAW&&j->newly_created_raw_stage)||j->encoded||j->encoded_bytes||
    !p->check_raw||!p->open_exclusive||!p->write||!p->close_write||!p->open_read||!p->read||!p->stat_read||!p->close_read||!p->publish||
    !j->source_raw_width||!j->source_raw_height||j->render_source_kind!=1||!same(&j->render_source,&j->raw,1)||
    !j->output_width||!j->output_height||j->output_width>65535||j->output_height>65535||j->render_width!=j->output_width||j->render_height!=j->output_height||
    j->source_raw_width!=g->source_width||j->source_raw_height!=g->source_height||j->output_width!=g->output_width||j->output_height!=g->output_height||!budget||budget>F3_STREAM_MAX_BYTES||!scratch||cap<F3_STREAM_SCRATCH||
    overlap(c,sizeof(*c),j,sizeof(*j))||overlap(c,sizeof(*c),p,sizeof(*p))||overlap(c,sizeof(*c),s,sizeof(*s))||
    overlap(scratch,cap,c,sizeof(*c))||overlap(scratch,cap,j,sizeof(*j))||overlap(scratch,cap,p,sizeof(*p))||overlap(scratch,cap,s,sizeof(*s)))return 0;
 c->session=s;c->job=*j;c->ports=*p;c->scratch=scratch;c->scratch_bytes=cap;c->byte_budget=budget;c->state=1;s->in_progress=1;
 c->result.saved.status=F3_REJECTED;++c->result.saved.check_raw_calls;
 if(!observe(c,p->check_raw(p->context,j),1)){if(c->state!=3)end(c);return 0;}
 if(j->mode==F3_RAW){c->result.saved.status=F3_RAW_RETAINED;end(c);return 0;}
 if(!observe(c,p->open_exclusive(p->context,j,&c->result.saved.jpeg),2)){if(c->state!=3)end(c);return 0;}
 c->result.saved.write_open=1;struct F3File*f=&c->result.saved.jpeg;
 if(!f->device||!f->inode||f->card_epoch!=j->raw.card_epoch||f->task_nonce!=j->raw.task_nonce||same(f,&j->raw,0)||f->bytes){fail(c,3);f3_stream_abort_03(c);return 0;}
 f4_sha_init(&c->encoded_hash);f3_jpeg_syntax_init_03(&c->syntax);return 1;
}
size_t f3_stream_sink_write_03(void*v,const uint8_t*p,size_t n){
 struct F3Stream*c=v;if(!active(c)||c->state!=1||!c->result.saved.write_open)return 0;
 if(!p||!n||n>UINT32_MAX||c->result.accepted_prefix_bytes>c->byte_budget||(uint64_t)n>c->byte_budget-c->result.accepted_prefix_bytes||
    overlap(p,n,c,sizeof(*c))||overlap(p,n,c->scratch,c->scratch_bytes)||!f3_jpeg_syntax_feed_03(&c->syntax,p,n)){fail(c,4);return 0;}
 ++c->result.saved.write_calls;struct F3Io r=c->ports.write(c->ports.context,p,(uint32_t)n);
 if(!observe(c,r,4))return 0;
 if(r.value>n){f3_stream_hold_03(c,4);return 0;}
 c->result.accepted_prefix_bytes+=r.value;
 if(r.value!=n){fail(c,4);return(size_t)r.value;}
 f4_sha_update(&c->encoded_hash,p,n);return n;
}
const struct F3StreamResult *f3_stream_abort_03(struct F3Stream*c){
 if(!c)return 0;if(!active(c))return &c->result;
 if(c->state!=2)fail(c,5);
 if(c->result.saved.write_open&&!close_write(c,6)){if(c->state==3)return &c->result;}
 if(c->result.saved.read_open&&!close_read(c,13)){if(c->state==3)return &c->result;}
 end(c);return &c->result;
}
const struct F3StreamResult *f3_stream_finish_03(struct F3Stream*c,const struct F3EncoderCompletion*e){
 if(!c)return 0;if(!active(c))return &c->result;if(c->state==2)return f3_stream_abort_03(c);
 if(!e||e->succeeded!=1||e->finish_returned!=1||e->cleanup_returned!=1||e->rows_encoded!=c->job.output_height||
    !e->jpeg_bytes||e->jpeg_bytes!=c->result.accepted_prefix_bytes||!f3_jpeg_syntax_done_03(&c->syntax,c->job.output_width,c->job.output_height)){
  fail(c,5);return f3_stream_abort_03(c);
 }
 c->result.encoder_finish_checked=1;c->result.jpeg_structure_checked=1;c->result.encoded_bytes=e->jpeg_bytes;
 f4_sha_end(&c->encoded_hash,c->result.encoded_sha256);
 if(!close_write(c,6)){if(c->state!=3)end(c);return &c->result;}
 c->result.saved.jpeg.bytes=e->jpeg_bytes;struct F3File actual={0};
 if(!observe(c,c->ports.open_read(c->ports.context,&c->result.saved.jpeg,&actual),7)){if(c->state!=3)end(c);return &c->result;}
 c->result.saved.read_open=1;
 if(!same(&c->result.saved.jpeg,&actual,1)){fail(c,8);return f3_stream_abort_03(c);}
 F4Sha read_hash;struct F3JpegSyntax syntax;f4_sha_init(&read_hash);f3_jpeg_syntax_init_03(&syntax);
 for(uint64_t off=0;off<e->jpeg_bytes;){uint32_t n=(uint32_t)(e->jpeg_bytes-off);if(n>F3_STREAM_SCRATCH)n=F3_STREAM_SCRATCH;
  ++c->result.saved.read_calls;struct F3Io r=c->ports.read(c->ports.context,c->scratch,n);
  if(!observe(c,r,9)){if(c->state!=3)f3_stream_abort_03(c);return &c->result;}
  if(r.value!=n||!f3_jpeg_syntax_feed_03(&syntax,c->scratch,n)){fail(c,9);return f3_stream_abort_03(c);}
  f4_sha_update(&read_hash,c->scratch,n);off+=n;c->result.saved.verified_bytes=off;
 }
 f4_sha_end(&read_hash,c->result.readback_sha256);
 if(!text_equal(c->result.encoded_sha256,c->result.readback_sha256)||!f3_jpeg_syntax_done_03(&syntax,c->job.output_width,c->job.output_height)){fail(c,9);return f3_stream_abort_03(c);}
 if(!observe(c,c->ports.stat_read(c->ports.context,&actual),11)){if(c->state!=3)f3_stream_abort_03(c);return &c->result;}
 if(!same(&c->result.saved.jpeg,&actual,1)){fail(c,11);return f3_stream_abort_03(c);}
 if(!close_read(c,13)){if(c->state!=3)end(c);return &c->result;}
 if(!observe(c,c->ports.publish(c->ports.context,&c->result.saved.jpeg),14)){if(c->state!=3)end(c);return &c->result;}
 c->result.saved.published=1;c->result.saved.status=F3_JPEG_WITH_RAW;
 /* Encoder destruction is not native RAW-render cleanup. Deletion belongs to
  * the later native coordinator, never this synchronous JPEG file layer. */
 end(c);return &c->result;
}

int f3_export_stream_begin_03(struct F3ExportStream03*c,struct F3Session*s,
 const struct F3ExportRequest03*r,const struct F3Ports*p,uint64_t budget,uint8_t*scratch,size_t cap){
 if(!c||!r||c->checked.state||!s||!p||r->job.mode==F3_RAW||r->job.mode>F3_JPEG_ONLY||r->quality<1||r->quality>100||
  overlap(c,sizeof(*c),r,sizeof(*r))||overlap(c,sizeof(*c),p,sizeof(*p))||overlap(c,sizeof(*c),s,sizeof(*s))||
  overlap(scratch,cap,c,sizeof(*c)))return 0;
 struct Iq4ExportGeometry g;
 if(iq4_export_geometry(r->job.source_raw_width,r->job.source_raw_height,r->rotation,r->size_mode,&g)!=IQ4_EXPORT_GEOMETRY_OK||
  r->job.render_width!=g.output_width||r->job.render_height!=g.output_height||r->job.output_width!=g.output_width||r->job.output_height!=g.output_height)return 0;
 c->geometry=g;c->quality=r->quality;c->requested_mode=r->job.mode;
 struct F3Job internal=r->job;internal.mode=F3_RAW_JPEG;
 return begin_checked(&c->checked,s,&internal,p,budget,scratch,cap,&g);
}
const struct F3StreamResult*f3_export_stream_encode_03(struct F3ExportStream03*c,const Iq4JpegApi*a,
 const Iq4Rgb32Input*in,Iq4StreamResult*out){
 if(!c||!in||!out)return c?&c->checked.result:0;
 struct F3Stream*v=&c->checked;
 if(v->state!=1||!v->session||v->session->hold||!v->session->in_progress)return &v->result;
 if(overlap(out,sizeof(*out),in,sizeof(*in))||overlap(out,sizeof(*out),a,sizeof(*a))||
  overlap(out,sizeof(*out),in->pixels,in->bytes)||
  overlap(out,sizeof(*out),c,sizeof(*c))||overlap(out,sizeof(*out),v->session,sizeof(*v->session))||
  overlap(out,sizeof(*out),v->scratch,v->scratch_bytes)||overlap(in,sizeof(*in),c,sizeof(*c))||
  overlap(a,sizeof(*a),c,sizeof(*c))||overlap(in->pixels,in->bytes,c,sizeof(*c))||
  overlap(in->pixels,in->bytes,v->scratch,v->scratch_bytes)||in->width!=c->geometry.source_width||
  in->height!=c->geometry.source_height||in->quality!=c->quality)return f3_stream_abort_03(v);
 Iq4Rgb32Export export={in->pixels,in->bytes,in->stride,in->width,in->height,c->geometry.rotation,c->geometry.size_mode,c->quality};
 Iq4JpegSink sink={v,f3_stream_sink_write_03,v->byte_budget};
 Iq4StreamStatus status=iq4_jpeg_stream_export_rgb32_01(a,&export,&sink,out);
 if(v->state==3)return &v->result;
 if(status==IQ4_STREAM_CLEANUP_ERROR)return f3_stream_hold_03(v,24);
 if(status!=IQ4_STREAM_OK)return f3_stream_abort_03(v);
 struct F3EncoderCompletion e={1,1,out->destroy_calls==1,out->rows_encoded,out->jpeg_bytes};
 return f3_stream_finish_03(v,&e);
}
