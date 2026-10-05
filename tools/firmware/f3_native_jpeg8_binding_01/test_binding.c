#include "native_jpeg82.h"
#include "code_pins.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>

typedef struct Fixture {int corrupt_pin;int fail_pin;unsigned calls;size_t bytes;} Fixture;
static int read_code(void *context,uintptr_t va,uint8_t *out,size_t bytes) {
    Fixture *f=(Fixture *)context;size_t i;
    assert(bytes>0&&bytes<=64);
    for(i=0;i<sizeof(iq4_jpeg82_code_pins01)/sizeof(iq4_jpeg82_code_pins01[0]);++i) {
        const Iq4Jpeg82CodePin01 *p=&iq4_jpeg82_code_pins01[i];
        if(va>=p->va&&va-p->va<=p->bytes&&bytes<=p->bytes-(va-p->va)) {
            ++f->calls;f->bytes+=bytes;
            if((int)i==f->fail_pin)return 0;
            memcpy(out,p->original+va-p->va,bytes);
            if((int)i==f->corrupt_pin)out[0]^=1;
            return 1;
        }
    }
    assert(!"Reader escaped finite native API code bodies");return 0;
}
static int empty(const Iq4JpegApi *a) {
    return !a->std_error&&!a->create_compress&&!a->set_defaults&&!a->set_quality&&
        !a->start_compress&&!a->write_scanlines&&!a->finish_compress&&!a->destroy_compress&&
        !a->api_version&&!a->compressor_struct_bytes&&!a->binding_abi_verified;
}
int main(void) {
    Iq4JpegApi a=iq4_native_jpeg82_unadmitted_table_01();
    Fixture f={-1,-1,0,0};uint8_t bad[32];size_t i,total=0;unsigned groups=0;
    assert((uintptr_t)a.std_error==0x9a20f0u);
    assert((uintptr_t)a.create_compress==0x9a2148u);
    assert((uintptr_t)a.destroy_compress==0x9a2248u);
    assert((uintptr_t)a.set_defaults==0x9a34b8u);
    assert((uintptr_t)a.set_quality==0x9a2fc8u);
    assert((uintptr_t)a.start_compress==0x9a39e0u);
    assert((uintptr_t)a.write_scanlines==0x9a3a88u);
    assert((uintptr_t)a.finish_compress==0x9a22f0u);
    assert(a.api_version==82&&a.compressor_struct_bytes==584&&!a.binding_abi_verified);++groups;
    assert(iq4_native_jpeg82_bind_01(NULL,read_code,&f,&a)==IQ4_JPEG82_ARGUMENT_01&&empty(&a));
    assert(iq4_native_jpeg82_bind_01(iq4_jpeg82_original_sha01,NULL,&f,&a)==IQ4_JPEG82_ARGUMENT_01&&empty(&a));
    assert(iq4_native_jpeg82_bind_01(iq4_jpeg82_original_sha01,read_code,&f,NULL)==IQ4_JPEG82_ARGUMENT_01);++groups;
    memcpy(bad,iq4_jpeg82_original_sha01,32);bad[31]^=1;
    assert(iq4_native_jpeg82_bind_01(bad,read_code,&f,&a)==IQ4_JPEG82_BASELINE_01&&empty(&a)&&f.calls==0);++groups;
#ifdef IQ4_JPEG82_SYNTHETIC_HOST_TEST_ONLY
    assert(iq4_native_jpeg82_bind_01(iq4_jpeg82_original_sha01,read_code,&f,&a)==IQ4_JPEG82_BOUND_STATIC_ABI_01);
    assert(a.binding_abi_verified==1);
    for(i=0;i<sizeof(iq4_jpeg82_code_pins01)/sizeof(iq4_jpeg82_code_pins01[0]);++i)total+=iq4_jpeg82_code_pins01[i].bytes;
    assert(f.bytes==total);++groups;
    for(i=0;i<sizeof(iq4_jpeg82_code_pins01)/sizeof(iq4_jpeg82_code_pins01[0]);++i) {
        f=(Fixture){(int)i,-1,0,0};
        assert(iq4_native_jpeg82_bind_01(iq4_jpeg82_original_sha01,read_code,&f,&a)==IQ4_JPEG82_CODE_MISMATCH_01&&empty(&a));++groups;
        f=(Fixture){-1,(int)i,0,0};
        assert(iq4_native_jpeg82_bind_01(iq4_jpeg82_original_sha01,read_code,&f,&a)==IQ4_JPEG82_CODE_READ_01&&empty(&a));++groups;
    }
#else
    (void)i;(void)total;
    assert(iq4_native_jpeg82_bind_01(iq4_jpeg82_original_sha01,read_code,&f,&a)==IQ4_JPEG82_ARCHITECTURE_01&&empty(&a)&&f.calls==0);++groups;
#endif
    printf("{\"host_synthetic_groups\":%u,\"native_functions_invoked\":0}\n",groups);
    return 0;
}
