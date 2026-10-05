/* Finite read-only RAM execution probe; no SDK, injection or recovery writer.
 * This code only observes a supplied, already verified p1linux process.
 * It never signals User, starts another program, reads memory/credentials,
 * modifies files/configuration, registers callbacks or accesses hardware.
 */
#define _POSIX_C_SOURCE 200809L
#include <errno.h>
#include <fcntl.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

static int decimal(const char *s, size_t n, uint64_t limit, uint64_t *out) {
    uint64_t v = 0;
    if (!s || n == 0 || n > 20) return 0;
    for (size_t i = 0; i < n; ++i) {
        if (s[i] < '0' || s[i] > '9') return 0;
        unsigned d = (unsigned)(s[i] - '0');
        if (v > limit / 10 || (v == limit / 10 && d > limit % 10)) return 0;
        v = v * 10 + d;
    }
    *out = v;
    return 1;
}

/* Strict field 22 of /proc/PID/stat, with exact PID and comm identity.
 * The file is privately retained nowhere. All unneeded fields are discarded.
 */
int f4_parse_stat(const char *b, size_t n, uint64_t pid, uint64_t *ticks) {
    if (!b || n == 0 || n >= 4096 || memchr(b, 0, n)) return 0;
    const char *end = b + n, *p = b;
    while (p < end && *p >= '0' && *p <= '9') ++p;
    uint64_t actual_pid;
    if (!decimal(b, (size_t)(p - b), 10000000, &actual_pid) || actual_pid != pid)
        return 0;
    static const char name[] = " (p1linux) ";
    if ((size_t)(end - p) < sizeof(name) - 1 ||
        memcmp(p, name, sizeof(name) - 1) != 0) return 0;
    p += sizeof(name) - 1;
    if (p >= end || !strchr("RSDZTWtXxKPI", *p) || p + 1 >= end || p[1] != ' ')
        return 0;
    p += 2; /* field 4 */
    for (unsigned field = 4; field <= 22; ++field) {
        const char *first = p;
        while (p < end && *p != ' ' && *p != '\n') ++p;
        if (first == p) return 0;
        if (field == 22) {
            if (p == end || *p != ' ' ||
                !decimal(first, (size_t)(p - first), UINT64_MAX, ticks) || *ticks == 0)
                return 0;
            return 1;
        }
        /* Other numeric fields may be signed; refuse malformed tokens. */
        const char *q = first;
        if (*q == '-') ++q;
        if (q == p) return 0;
        while (q < p) { if (*q < '0' || *q > '9') return 0; ++q; }
        if (p == end || *p != ' ') return 0;
        ++p;
    }
    return 0;
}

#ifndef F4_MONITOR_PARSER_ONLY
static int read_stat(uint64_t pid, uint64_t *ticks) {
    char path[64], bytes[4096];
    int len = snprintf(path, sizeof(path), "/proc/%" PRIu64 "/stat", pid);
    if (len < 0 || (size_t)len >= sizeof(path)) return 0;
    int fd = open(path, O_RDONLY | O_CLOEXEC | O_NOFOLLOW);
    if (fd < 0) return 0;
    size_t used = 0;
    int okay = 1;
    for (;;) {
        ssize_t got = read(fd, bytes + used, sizeof(bytes) - used);
        if (got < 0 && errno == EINTR) continue;
        if (got < 0) { okay = 0; break; }
        if (got == 0) break;
        used += (size_t)got;
        if (used == sizeof(bytes)) { okay = 0; break; }
    }
    if (close(fd) != 0) okay = 0;
    return okay && f4_parse_stat(bytes, used, pid, ticks);
}

static int read_exe(uint64_t pid, char *buffer, size_t capacity) {
    char path[64];
    int len = snprintf(path, sizeof(path), "/proc/%" PRIu64 "/exe", pid);
    if (len < 0 || (size_t)len >= sizeof(path)) return 0;
    ssize_t got = readlink(path, buffer, capacity - 1);
    if (got < 0 || (size_t)got >= capacity - 1) return 0;
    buffer[got] = 0;
    const char *base = strrchr(buffer, '/');
    return buffer[0] == '/' && base && strcmp(base + 1, "p1linux") == 0;
}

static int monotonic_ms(uint64_t *out) {
    struct timespec ts;
    if (clock_gettime(CLOCK_MONOTONIC, &ts) != 0 || ts.tv_sec < 0 || ts.tv_nsec < 0 ||
        ts.tv_nsec >= 1000000000 || (uint64_t)ts.tv_sec > (UINT64_MAX - 999) / 1000)
        return 0;
    *out = (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
    return 1;
}

static int emit(const char *text) {
    /* No private file writer. Parent may capture only these finite public lines.
     * Nonblocking stdout prevents a missing receiver from extending the deadline.
     */
    size_t left = strlen(text);
    while (left) {
        ssize_t wrote = write(STDOUT_FILENO, text, left);
        if (wrote < 0 && errno == EINTR) continue;
        if (wrote <= 0) return 0;
        text += wrote;
        left -= (size_t)wrote;
    }
    return 1;
}

int main(int argc, char **argv) {
    uint64_t pid, ticks, actual, duration, start, now;
    char original_exe[4096], current_exe[4096];
    if (argc != 4 || !decimal(argv[1], strlen(argv[1]), 10000000, &pid) || pid < 2 ||
        !decimal(argv[2], strlen(argv[2]), UINT64_MAX, &ticks) || ticks == 0 ||
        !decimal(argv[3], strlen(argv[3]), 30000, &duration) || duration < 1)
        return 2;
    int flags = fcntl(STDOUT_FILENO, F_GETFL);
    if (flags < 0 || fcntl(STDOUT_FILENO, F_SETFL, flags | O_NONBLOCK) < 0) return 3;
    if (!read_stat(pid, &actual) || actual != ticks ||
        !read_exe(pid, original_exe, sizeof(original_exe)) ||
        !read_stat(pid, &actual) || actual != ticks || !monotonic_ms(&start)) {
        (void)emit("{\"probe\":\"f4_ram_readonly_01\",\"result\":\"identity_refused\"}\n");
        return 4;
    }
    if (!emit("{\"probe\":\"f4_ram_readonly_01\",\"result\":\"ready\",\"signals\":0,\"opened_write_files\":0}\n"))
        return 5;
    for (;;) {
        if (!monotonic_ms(&now) || now < start) return 6;
        if (now - start >= duration) break;
        if (!read_stat(pid, &actual) || actual != ticks ||
            !read_exe(pid, current_exe, sizeof(current_exe)) ||
            strcmp(original_exe, current_exe) != 0 ||
            !read_stat(pid, &actual) || actual != ticks) {
            (void)emit("{\"probe\":\"f4_ram_readonly_01\",\"result\":\"identity_changed_or_unreadable\"}\n");
            return 7;
        }
        uint64_t remaining = duration - (now - start);
        struct timespec delay = {0, (long)((remaining < 100 ? remaining : 100) * 1000000)};
        /* If interrupted, return to the monotonic deadline check immediately. */
        (void)nanosleep(&delay, NULL);
    }
    if (!read_stat(pid, &actual) || actual != ticks ||
        !read_exe(pid, current_exe, sizeof(current_exe)) ||
        strcmp(original_exe, current_exe) != 0 ||
        !read_stat(pid, &actual) || actual != ticks) return 7;
    if (!emit("{\"probe\":\"f4_ram_readonly_01\",\"result\":\"deadline_exit_identity_stable\",\"signals\":0,\"opened_write_files\":0}\n"))
        return 5;
    return 0;
}
#endif
