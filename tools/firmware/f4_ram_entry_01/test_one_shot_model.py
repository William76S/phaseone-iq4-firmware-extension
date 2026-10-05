"""Host fixtures only: no firmware execution, actual runner patch or camera."""
import os
from pathlib import Path
import tempfile
import unittest
from one_shot_model import (CANDIDATE_LINE, ORIGINAL_LINE, Gates,
                            OneShotModel, State, describe_equal_length)


def all_gates():
    return Gates(**{name: True for name in Gates.__dataclass_fields__})


class OneShotTests(unittest.TestCase):
    def test_line_equal_and_only_expected_span(self):
        r = describe_equal_length(b"prefix\n" + ORIGINAL_LINE + b"suffix\n")
        self.assertEqual(r["call_line_bytes"], 36)  # 35 source chars plus original LF
        self.assertEqual(r["changed_bytes"], 15)
        self.assertEqual(r["changed_offsets"], list(range(11, 26)))
        self.assertFalse(r["output_script_generated"])

    def test_unique_line_refusal(self):
        for raw in [b"bad", ORIGINAL_LINE * 2]:
            with self.assertRaises(ValueError):
                describe_equal_length(raw)

    def test_each_absent_gate_refuses_before_mutation(self):
        for name in Gates.__dataclass_fields__:
            gates = all_gates()
            setattr(gates, name, False)
            model = OneShotModel(gates)
            self.assertFalse(model.ready(), name)
            self.assertEqual(model.state, State.REFUSED)
            self.assertTrue(model.runner_is_original)
            self.assertEqual(model.actions, [])

    def test_arm_without_supervisor_refused(self):
        with self.assertRaises(ValueError):
            OneShotModel(all_gates()).arm()

    def test_restore_before_exec_required(self):
        model = OneShotModel(all_gates())
        self.assertTrue(model.ready())
        model.arm()
        with self.assertRaises(ValueError):
            model.launch_once()
        model.restore()
        model.launch_once()
        self.assertEqual(model.preload_launches, 1)
        self.assertTrue(model.runner_is_original)

    def test_sdk_closed_does_not_disable_deadline_restore(self):
        model = OneShotModel(all_gates())
        model.ready()
        model.arm()
        model.sdk_close()
        self.assertTrue(model.supervisor_deadline())
        model.stock_respawn()
        self.assertEqual(model.state, State.STOCK_USER)
        self.assertEqual(model.preload_launches, 0)

    def test_unexpected_runner_refuses_overwrite(self):
        model = OneShotModel(all_gates())
        model.ready()
        model.arm()
        self.assertFalse(model.supervisor_deadline(runner_matches_candidate=False))
        self.assertFalse(model.runner_is_original)
        self.assertEqual(model.state, State.REFUSED)

    def test_artifact_mismatch_and_secure_fall_back_to_stock(self):
        for args in [{"artifact_matches": False}, {"at_secure_zero": False}]:
            model = OneShotModel(all_gates())
            model.ready()
            model.arm()
            model.restore()
            model.launch_once(**args)
            self.assertEqual(model.state, State.STOCK_USER)
            self.assertEqual(model.preload_launches, 0)

    def test_subsequent_respawn_never_reloads(self):
        model = OneShotModel(all_gates())
        model.ready()
        model.arm()
        model.restore()
        model.launch_once()
        model.sdk_close()
        model.stock_respawn()
        model.stock_respawn()
        self.assertEqual(model.preload_launches, 1)
        self.assertTrue(model.runner_is_original)

    def test_deadline_does_not_claim_to_unload_running_user(self):
        model = OneShotModel(all_gates())
        model.ready()
        model.arm()
        model.restore()
        model.launch_once()
        model.supervisor_deadline()
        self.assertEqual(model.state, State.ONE_SHOT_USER)
        self.assertFalse(any("kill" in a or "signal" in a for a in model.actions))

    def test_real_host_inode_and_open_fd_fixture(self):
        # Synthetic files in a temporary host directory, never original rootfs.
        with tempfile.TemporaryDirectory() as temp:
            directory = Path(temp)
            runner = directory / "fixture"
            saved = directory / "saved"
            replacement = directory / "replacement"
            baseline = b"host fixture\n" + ORIGINAL_LINE
            runner.write_bytes(baseline)
            runner.chmod(0o755)
            original_inode = runner.stat().st_ino
            with runner.open("rb", buffering=0) as original_fd:
                os.link(runner, saved)
                replacement.write_bytes(b"host fixture\n" + CANDIDATE_LINE)
                replacement.chmod(0o755)
                os.replace(replacement, runner)
                self.assertNotEqual(runner.stat().st_ino, original_inode)
                self.assertEqual(original_fd.read(), baseline)
                os.replace(saved, runner)
                self.assertEqual(runner.stat().st_ino, original_inode)
                self.assertEqual(runner.read_bytes(), baseline)
                self.assertEqual(runner.stat().st_nlink, 1)
                self.assertEqual(runner.stat().st_mode & 0o777, 0o755)


if __name__ == "__main__":
    unittest.main()
