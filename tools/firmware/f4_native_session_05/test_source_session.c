/* Actual source04 + session05 connected together. Only native device methods,
 * codec and card transport are fixtures. No target process is executed. */
#define main source_fixture_reference_main
#define iq4_f4_native_clock_02 source_fixture_clock
#define iq4_f4_native_event_notify_02 source_fixture_notify
#include "../f4_native_source_04/test_source.c"
#undef iq4_f4_native_event_notify_02
#undef iq4_f4_native_clock_02
#undef main
#include "../f4_native_source_02/session.h"
#include "../f4_native_source_02/thread_calls.h"
#include <time.h>

static pthread_t session_thread;
static void *(*session_run)(void *);
static void *session_arg;
static uint32_t publish_count, release_count;
static struct Iq4Mkv movie_mux;
static unsigned char encoded_packet[16384];

uint64_t iq4_f4_native_clock_02(void) {
    struct timespec value;
    assert(!clock_gettime(CLOCK_MONOTONIC, &value));
    return (uint64_t)value.tv_sec * 1000000000 + value.tv_nsec;
}
int iq4_f4_native_event_notify_02(void *event) {
    assert(event == control_event);
    __atomic_store_n(&control_pending, 1, __ATOMIC_RELEASE);
    return 1;
}
static void *session_thread_entry(void *unused) {
    (void)unused; tid = 2;
    return session_run(session_arg);
}
int iq4_f4_thread_pins_02(Iq4F4SelfRead02 r, void *c) { assert(r && !c); return 1; }
int iq4_f4_thread_create_02(uint64_t *out, void *(*run)(void *), void *arg, int *rc) {
    session_run = run; session_arg = arg;
    *rc = pthread_create(&session_thread, 0, session_thread_entry, 0);
    *out = (uintptr_t)session_thread; return 1;
}
int iq4_f4_thread_join_02(uint64_t thread, void **out, int *rc) {
    assert(thread == (uintptr_t)session_thread && tid != 1);
    *rc = pthread_join(session_thread, out); return 1;
}
void iq4_f4_thread_wake_02(uint32_t *p) { __atomic_fetch_add(p, 1, __ATOMIC_RELEASE); }
void iq4_f4_thread_wait_02(uint32_t *p, uint32_t before) {
    if (__atomic_load_n(p, __ATOMIC_ACQUIRE) == before) {
        struct timespec value = {0, 1000000}; nanosleep(&value, 0);
    }
}
int iq4_f4_menu_page_guard_03(void *unused) { (void)unused; return page_present; }
int iq4_f4_menu_refresh_on_ui_03(void) { assert(tid == 1); return 1; }
int iq4_f4_menu_finish_exit_on_ui_03(void) { assert(tid == 1); return 0; }
int iq4_f4_worker_init_02(Iq4F4Worker02 *worker, void *src, struct Iq4Mkv *mux,
                        unsigned char *packet, uint32_t cap, int quality,
                        Iq4F4SelfRead02 r, void *c) {
    assert(src == storage && mux == &movie_mux && packet == encoded_packet &&
           cap == sizeof encoded_packet && quality == 90 && r && !c);
    memset(worker, 0, sizeof *worker); worker->ready = 1; return IQ4_F4_WORKER_PACKET;
}
int iq4_f4_worker_pump_one_02(Iq4F4Worker02 *worker) {
    Iq4F4OwnedFrame02 frame;
    int result = iq4_f4_source_worker_claim_02(storage, &frame);
    if (result == IQ4_F4_SRC_EMPTY) return IQ4_F4_WORKER_EMPTY;
    assert(result == IQ4_F4_SRC_OK && tid == 2);
    assert(frame.bytes != pixels && frame.metadata.bytes == sizeof pixels &&
           frame.bytes[0] == 0x5a && frame.bytes[sizeof pixels - 1] == 0x5a);
    assert(iq4_f4_source_worker_release_02(storage, &frame) == IQ4_F4_SRC_OK);
    ++worker->encoded; return IQ4_F4_WORKER_PACKET;
}
static int acquire_card(void *p) { assert(!p && tid == 1); return IQ4_F4_MOVIE_READY; }
static int prepare_movie(void *p, uint32_t width, uint32_t height, struct Iq4Mkv **out) {
    assert(!p && tid == 2 && width == 64 && height == 48);
    movie_mux = (struct Iq4Mkv){.state=IQ4_MKV_WRITING, .width=width,
        .height=height, .max_packet_bytes=sizeof encoded_packet};
    *out = &movie_mux; return IQ4_F4_MOVIE_READY;
}
static int finalize_movie(void *p, struct Iq4Mkv *mux, int normal, uint32_t *published) {
    assert(!p && tid == 2 && mux == &movie_mux && normal);
    assert(iq4_f4_source_fence_02(storage) == IQ4_F4_SRC_OK);
    __atomic_fetch_add(&publish_count, 1, __ATOMIC_RELEASE);
    *published = 1; return IQ4_F4_MOVIE_READY;
}
static int release_card(void *p) {
    assert(!p && tid == 1 && __atomic_load_n(&publish_count, __ATOMIC_ACQUIRE) == 1);
    ++release_count; return IQ4_F4_MOVIE_READY;
}
static int cancel_card(void *p) { (void)p; assert(0); return IQ4_F4_MOVIE_UNKNOWN; }
static uint32_t card_id(void *p) { assert(!p && tid == 1); return 10; }
static int card_set(void *p, uint32_t id) { assert(!p && tid == 1 && id == 11); return 0; }
static void dispatch_session(void) {
    if (__atomic_exchange_n(&control_pending, 0, __ATOMIC_ACQ_REL)) {
        uintptr_t *object = control_observer;
        uintptr_t *vtable = (uintptr_t *)object[0];
        ((void (*)(void *, void *))vtable[2])(control_observer, control_event);
    }
}
static void wait_phase(Iq4F4MenuPorts03 *ports, uint32_t phase) {
    for (unsigned i=0; i<4000; ++i) {
        dispatch_session(); Iq4F4UiView03 current;
        assert(ports->view_on_ui(ports->context, &current));
        assert(current.phase != IQ4_F4_UI_HOLD);
        if (current.phase == phase) return;
        struct timespec pause = {0, 1000000}; nanosleep(&pause, 0);
    }
    assert(0);
}
int main(void) {
    reset();
    storage = aligned_alloc(16, (iq4_f4_source_storage_bytes_02()+15)&~(size_t)15);
    arena = malloc(32768); assert(storage && arena);
    assert(iq4_f4_source_init_02(storage, iq4_f4_source_storage_bytes_02(),
           readself, 0, arena, 32768, 2, 16384) == IQ4_F4_SRC_OK);
    assert(iq4_f4_source_bind_page_guard_on_ui_02(storage, page, 0) == IQ4_F4_SRC_OK);
    void *session = calloc(1, iq4_f4_session_storage_bytes_02()); assert(session);
    Iq4F4MoviePorts02 movie = {0, acquire_card, acquire_card, prepare_movie,
        finalize_movie, release_card, cancel_card, card_set, card_id};
    assert(iq4_f4_session_init_on_ui_02(session, iq4_f4_session_storage_bytes_02(),
           storage, readself, 0, encoded_packet, sizeof encoded_packet, 90, &movie)
           == IQ4_F4_UI_COMPLETE);
    Iq4F4MenuPorts03 ports = iq4_f4_session_menu_ports_02(session);
    /* Original UI may retain a native frame while the first Start arrives. */
    put(L+0x188, (uintptr_t)pixels, 8);
    assert(ports.control_on_ui(ports.context, IQ4_F4_UI_START) == IQ4_F4_UI_REJECTED);
    Iq4F4UiView03 view; assert(ports.view_on_ui(ports.context, &view));
    assert(view.phase == IQ4_F4_UI_IDLE && view.known_empty_cancelled_and_released);
    assert(iq4_f4_source_fence_02(storage) == IQ4_F4_SRC_OK);
    put(L+0x188, 0, 8);
    assert(ports.control_on_ui(ports.context, IQ4_F4_UI_START) == IQ4_F4_UI_PENDING);
    wait_phase(&ports, IQ4_F4_UI_RECORDING);
    for (uint32_t id=10; id<13; ++id) {
        put(E+0x2170+0xf0, id, 4); event();
        for (unsigned i=0; i<4000; ++i) {
            assert(ports.view_on_ui(ports.context, &view));
            if (view.encoded == id-9) break;
            assert(i < 3999); struct timespec pause={0,1000000}; nanosleep(&pause,0);
        }
    }
    assert(ports.control_on_ui(ports.context, IQ4_F4_UI_STOP) == IQ4_F4_UI_PENDING);
    wait_phase(&ports, IQ4_F4_UI_IDLE);
    assert(ports.view_on_ui(ports.context, &view) && view.encoded == 3 &&
           view.notifications == 3 && view.published_and_owners_released && release_count == 1);
    for (unsigned i=0; i<4000; ++i) {
        if(iq4_f4_session_request_shutdown_on_ui_02(session) == IQ4_F4_UI_PENDING) break;
        assert(i<3999); struct timespec pause={0,1000000}; nanosleep(&pause,0);
    }
    tid=3;
    for (unsigned i=0; i<4000; ++i) {
        if(iq4_f4_session_join_returned_not_ui_02(session) == IQ4_F4_UI_COMPLETE) break;
        assert(i<3999); struct timespec pause={0,1000000}; nanosleep(&pause,0);
    }
    free(session);free(storage);free(arena);
    puts("actual source04 + session05: finite retained-frame refusal, reattach, three unique owned copies, stop, release, join PASS; native/card/codec are fixtures");
    return 0;
}
