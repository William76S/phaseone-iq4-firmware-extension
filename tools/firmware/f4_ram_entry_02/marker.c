/* Bounded constructor marker only. No pointers/addresses, thread, allocation,
 * file open, security/property, frame/UI/encoder or hardware access.
 * FD198 is owned and explicitly provided by the one-shot launcher. The Unix
 * socket uses MSG_NOSIGNAL so a dead supervisor cannot SIGPIPE User.
 */
#define _GNU_SOURCE
#include <sys/socket.h>
#include <unistd.h>
__attribute__((constructor)) static void f4_marker_init(void){
 static const char marker[]="F4M2\n";
 (void)send(198,marker,sizeof(marker)-1,MSG_DONTWAIT|MSG_NOSIGNAL);
 (void)close(198);
}
