"""Offline model only: no command builder, runner writer, transport or loader."""
from dataclasses import dataclass
from enum import Enum, auto


ORIGINAL_LINE = b"    ${P1LINUX_PATH} ${P1LINUX_ARGS}\n"
CANDIDATE_LINE = b"    /run/f4launch   ${P1LINUX_ARGS}\n"


def describe_equal_length(original: bytes) -> dict:
    """Inspect a fixed original in memory; deliberately do not return a patch."""
    if original.count(ORIGINAL_LINE) != 1:
        raise ValueError("Original call line must occur exactly once")
    if len(ORIGINAL_LINE) != len(CANDIDATE_LINE):
        raise ValueError("Unexpected candidate length")
    offset = original.index(ORIGINAL_LINE)
    changed = [offset + i for i, (a, b) in
               enumerate(zip(ORIGINAL_LINE, CANDIDATE_LINE)) if a != b]
    return {"call_line_offset": offset, "call_line_bytes": len(ORIGINAL_LINE),
            "original_line_hex": ORIGINAL_LINE.hex(),
            "candidate_line_hex": CANDIDATE_LINE.hex(),
            "changed_offsets": changed, "changed_bytes": len(changed),
            "output_script_generated": False}


class State(Enum):
    ORIGINAL = auto()
    SUPERVISOR_READY = auto()
    ARMED = auto()
    ORIGINAL_RESTORED = auto()
    ONE_SHOT_USER = auto()
    STOCK_USER = auto()
    REFUSED = auto()


@dataclass
class Gates:
    actual_root_ram: bool = False
    no_covering_persistent_mount: bool = False
    exact_original_double_backup: bool = False
    same_fs_original_inode_retained: bool = False
    tools_and_exec_tmpfs_observed: bool = False
    actual_user_hash_and_start_ticks: bool = False
    original_argv_environment_observed: bool = False
    upgrade_debug_respawn_flags_absent: bool = False
    independent_restore_owner_observed: bool = False
    native_user_exit_and_stock_respawn_observed: bool = False

    def complete(self) -> bool:
        return all(vars(self).values())


class OneShotModel:
    """Actions are modeled events, not an implementation of device recovery.

    The supervisor never signals User. Without separately validated original
    exit, restoration of the runner cannot forcibly remove a loaded module.
    """
    def __init__(self, gates: Gates):
        self.gates = gates
        self.state = State.ORIGINAL
        self.runner_is_original = True
        self.sdk_online = True
        self.preload_launches = 0
        self.actions = []

    def ready(self):
        if self.state != State.ORIGINAL or not self.gates.complete():
            self.state = State.REFUSED
            return False
        self.state = State.SUPERVISOR_READY
        return True

    def arm(self):
        if self.state != State.SUPERVISOR_READY:
            raise ValueError("No independently ready supervisor")
        self.runner_is_original = False
        self.state = State.ARMED
        self.actions.append("atomic_new_inode_runner_candidate")

    def restore(self, *, runner_matches_candidate=True):
        if self.runner_is_original:
            return True
        if not runner_matches_candidate:
            self.state = State.REFUSED
            self.actions.append("unexpected_runner_do_not_overwrite")
            return False
        self.runner_is_original = True
        self.state = State.ORIGINAL_RESTORED
        self.actions.append("restore_original_inode_before_exec")
        return True

    def launch_once(self, *, artifact_matches=True, at_secure_zero=True):
        if self.state != State.ORIGINAL_RESTORED or not self.runner_is_original:
            raise ValueError("Cannot exec preload before original runner restore")
        if not artifact_matches or not at_secure_zero:
            self.state = State.STOCK_USER
            self.actions.append("exec_unchanged_user_without_preload")
            return
        self.state = State.ONE_SHOT_USER
        self.preload_launches += 1
        self.actions.append("one_execve_preload_environment")

    def sdk_close(self):
        self.sdk_online = False

    def supervisor_deadline(self, *, runner_matches_candidate=True):
        # No kill/stop/reboot action is modeled or claimed safe.
        return self.restore(runner_matches_candidate=runner_matches_candidate)

    def stock_respawn(self):
        if not self.runner_is_original:
            raise ValueError("Original runner not restored")
        self.state = State.STOCK_USER
        self.actions.append("init_exec_original_runner_no_preload")
