#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

typedef struct { int32_t x,y,w,h; } Rect;
typedef struct { Rect keep,bands[4]; unsigned count; } Plan;
static Rect intersect(Rect a,Rect b) {
    int32_t x=a.x>b.x?a.x:b.x,y=a.y>b.y?a.y:b.y;
    int32_t right=a.x+a.w<b.x+b.w?a.x+a.w:b.x+b.w;
    int32_t bottom=a.y+a.h<b.y+b.h?a.y+a.h:b.y+b.h;
    Rect r={x,y,right>x?right-x:0,bottom>y?bottom-y:0};return r;
}
static int64_t area(Rect r) { return (int64_t)r.w*r.h; }
static int eq(Rect a,Rect b) {
    return a.x==b.x&&a.y==b.y&&a.w==b.w&&a.h==b.h;
}
static void append_clipped(Plan *p,Rect a,Rect clip) {
    Rect b=intersect(a,clip);
    if(b.w>0&&b.h>0)p->bands[p->count++]=b;
}
/* Pure host geometry: full projected frame is the composition reference.
 * No native addresses, pixels, canvas, device execution or coverage receipt. */
static Plan plan(Rect full,Rect visible,unsigned mode) {
    Plan p={0};unsigned n,d;int32_t kw,kh,kx,ky;
    if(mode==0)return p;
    assert(mode<=4);n=mode==1?65:mode==2?16:mode==3?3:1;
    d=mode==1?24:mode==2?9:mode==3?2:1;kw=full.w;kh=full.h;
    if((int64_t)full.w*d>(int64_t)full.h*n)kw=full.h*(int32_t)n/(int32_t)d;
    else kh=full.w*(int32_t)d/(int32_t)n;
    kx=full.x+(full.w-kw)/2;ky=full.y+(full.h-kh)/2;
    p.keep=(Rect){kx,ky,kw,kh};
    append_clipped(&p,(Rect){full.x,full.y,full.w,ky-full.y},visible);
    append_clipped(&p,(Rect){full.x,ky+kh,full.w,full.y+full.h-(ky+kh)},visible);
    append_clipped(&p,(Rect){full.x,ky,kx-full.x,kh},visible);
    append_clipped(&p,(Rect){kx+kw,ky,full.x+full.w-(kx+kw),kh},visible);
    return p;
}
static void print_rect(Rect r) { printf("[%d,%d,%d,%d]",r.x,r.y,r.w,r.h); }
int main(void) {
    float scale=22.0f,sx,sy,fit,untruncated_h;
    Rect destination={(800-(int32_t)(14204.0f/scale))/2,0,
                      (int32_t)(14204.0f/scale),(int32_t)(10652.0f/scale)};
    Rect projected,visible,native_write,lcd={0,0,800,480},clip={0,0,800,480};
    unsigned mode,i,j,case_idx;int32_t clipped_source_h,native_output_h;
    int32_t expected_y[5]={0,122,60,26,0};
    int32_t expected_w[5]={0,645,645,645,483},expected_h[5]={0,238,362,430,483};
    int64_t expected_mask[2][5]={{0,156090,76110,32250,77760},
                              {0,155445,75465,31605,77598}};uint32_t fit_bits;
    assert(eq(destination,(Rect){77,0,645,484}));
    sx=(float)destination.w/640.0f;sy=(float)destination.h/480.0f;
    fit=sx<sy?sx:sy;memcpy(&fit_bits,&fit,4);assert(fit_bits==0x3f810000);
    projected=(Rect){destination.x,destination.y,(int32_t)(640.0f*fit),(int32_t)(480.0f*fit)};
    projected.x+=(destination.w-projected.w)/2;
    projected.y+=(destination.h-projected.h)/2;
    untruncated_h=480.0f*fit;assert(untruncated_h==483.75f);
    assert(eq(projected,(Rect){77,0,645,483}));
    visible=intersect(intersect(projected,clip),lcd);
    assert(eq(visible,(Rect){77,0,645,480}));
    assert(projected.h-visible.h==3);
    /* Stock clipping/output integer counts, independently supplied by the SDK
     * static reviewer: 4756fc..718, 4758a4..b4, 47f910. No native code execution. */
    clipped_source_h=(int32_t)(480.0f/fit);
    native_output_h=(int32_t)((float)clipped_source_h*fit);
    assert(clipped_source_h==476&&native_output_h==479);
    native_write=(Rect){projected.x,projected.y,projected.w,native_output_h};
    assert(eq(native_write,intersect(native_write,visible)));
    puts("{\"schema\":\"iq4_f1_actual_projection_geometry_host_01\","
         "\"source_of_actual_values\":\"root_device_receipt\","
         "\"native_executed\":false,\"camera_access\":false,"
         "\"pixel_canvas_used\":false,\"native_fresh_coverage_proved\":false,");
    printf("\"destination\":");print_rect(destination);printf(",\"projected\":");print_rect(projected);
    printf(",\"visible_geometric_intersection\":");print_rect(visible);
    printf(",\"static_native_write_rectangle\":");print_rect(native_write);
    printf(",\"clipped_source_height\":%d,\"native_output_height\":%d",clipped_source_h,native_output_h);
    printf(",\"binary32_fit_bits\":\"%08x\",\"untruncated_height\":%.2f,\"modes\":[\n",fit_bits,untruncated_h);
    for(case_idx=0;case_idx<2;++case_idx) {
    Rect allowed=case_idx?native_write:visible;
    for(mode=0;mode<=4;++mode) {
        Plan p=plan(projected,allowed,mode);int64_t sum=0;
        assert(p.count==(mode?2u:0u));
        if(mode) {
            assert(p.keep.y==expected_y[mode]&&p.keep.w==expected_w[mode]&&p.keep.h==expected_h[mode]);
            assert(p.keep.x==(mode==4?158:77));
            /* At most a half pixel from the FULL frame centre, not the clipped centre. */
            assert(2*p.keep.x+p.keep.w>=2*projected.x+projected.w-1);
            assert(2*p.keep.x+p.keep.w<=2*projected.x+projected.w);
            assert(2*p.keep.y+p.keep.h>=2*projected.y+projected.h-1);
            assert(2*p.keep.y+p.keep.h<=2*projected.y+projected.h);
            for(i=0;i<p.count;++i) {
                Rect a=p.bands[i];assert(eq(a,intersect(a,allowed))&&a.w>0&&a.h>0);
                if(case_idx)assert(a.y+a.h<=479); /* no stale LCD row479 write */
                assert(area(intersect(a,p.keep))==0);sum+=area(a);
                for(j=0;j<i;++j)assert(area(intersect(a,p.bands[j]))==0);
            }
            assert(sum==expected_mask[case_idx][mode]);
            assert(sum+area(intersect(p.keep,allowed))==area(allowed));
            /* Re-centering from the cropped visible box changes the composition. */
            assert(!eq(p.keep,plan(allowed,allowed,mode).keep));
        }
        if(mode||case_idx)printf(",\n");
        printf("{\"clip_kind\":\"%s\",\"mode\":%u,\"band_count\":%u,\"full_frame_keep\":",
               case_idx?"static_native_write479":"geometric_intersection480_not_fresh",mode,p.count);print_rect(p.keep);
        printf(",\"visible_bands\":[");
        for(i=0;i<p.count;++i){if(i)printf(",");print_rect(p.bands[i]);}
        printf("],\"mask_area\":%lld}",(long long)sum);
    }
    }
    puts("\n],\"mode_cases_passed\":10,\"projection_case_passed\":true,"
         "\"native_clipping_counts_case_passed\":true,\"cropped_bottom_rows_geometry\":3,"
         "\"cropped_bottom_rows_static_native_write\":4}");
    return 0;
}
