#!/usr/bin/env python3
"""Decode real host RGB->JPEG containers and validate preserved source timing."""
import json
import pathlib
import struct
import subprocess
import sys

out = pathlib.Path(sys.argv[1]).resolve()
checks = out / "decode_checks"
checks.mkdir()
vfr = [1000000000, 1031000123, 1077000456, 1185123456, 1249999999]
cases = {
    "rgb_vfr_1.mkv": (vfr, "expected_rgb_vfr"),
    "rgb_cfr_1.avi": ([2000000000 + n * 40000000 for n in range(4)], "expected_rgb_cfr"),
    "rgb_source_lost_1.mkv": (vfr[:2], "expected_rgb_source_lost"),
    "rgb_truncated_recovered_1.mkv": (vfr[:1], "expected_rgb_truncated"),
    "rgb_cfr_rejected_recovered_1.avi": (vfr[:1], "expected_rgb_cfr_rejected"),
}
results = []
for name, (original_pts, expected_folder) in cases.items():
    file = out / name
    probe = subprocess.run(["ffprobe", "-v", "error", "-count_frames", "-show_streams", "-show_packets", "-of", "json", str(file)], capture_output=True, text=True, check=True)
    (checks / (name + ".ffprobe.json")).write_text(probe.stdout)
    data = json.loads(probe.stdout)
    stream = data["streams"][0]
    assert len(data["streams"]) == 1 and stream["codec_name"] == "mjpeg"
    assert (stream["width"], stream["height"]) == (96, 64)
    assert int(stream["nb_read_frames"]) == len(original_pts) == len(data["packets"])
    actual_pts = [packet["pts"] for packet in data["packets"]]
    if name.endswith(".mkv"):
        assert stream["time_base"] == "1/1000000000"
        assert actual_pts == [pts - original_pts[0] for pts in original_pts]
    else:
        assert stream["time_base"] == "1/25" and actual_pts == list(range(len(original_pts)))
    decoded = subprocess.run(["ffmpeg", "-v", "error", "-i", str(file), "-fps_mode", "passthrough", "-f", "framemd5", "-"], capture_output=True, text=True, check=True)
    assert not decoded.stderr
    assert len([line for line in decoded.stdout.splitlines() if line.strip() and not line.startswith("#")]) == len(original_pts)
    (checks / (name + ".framemd5")).write_text(decoded.stdout)
    packets = checks / (name + ".packets")
    packets.mkdir()
    subprocess.run(["ffmpeg", "-v", "error", "-i", str(file), "-c:v", "copy", "-fps_mode", "passthrough", str(packets / "packet_%d.jpg")], check=True)
    for index in range(len(original_pts)):
        assert (packets / f"packet_{index+1}.jpg").read_bytes() == (out / expected_folder / f"packet_{index+1}.jpg").read_bytes()
    raw = file.read_bytes()
    assert raw.count(b"IQ4T") == len(original_pts)
    start = 0
    journals = []
    for index, pts in enumerate(original_pts):
        at = raw.index(b"IQ4T", start)
        version, source_pts, sequence, present, jpeg_bytes = struct.unpack_from("<IQQII", raw, at + 4)
        assert version == 1 and source_pts == pts and sequence == 40 + index * 2 and present == 1
        assert jpeg_bytes == len((out / expected_folder / f"packet_{index+1}.jpg").read_bytes())
        journals.append({"absolute_source_pts_ns": source_pts, "source_sequence": sequence})
        start = at + 36
    results.append({"file": name, "decoded_frames": len(original_pts), "byte_identical_encoded_packets": True,
                    "container_pts": actual_pts, "time_base": stream["time_base"], "unchanged_source_journal": journals,
                    "probe_r_frame_rate_not_hardware_fps": stream.get("r_frame_rate")})
summary = {"evidence_level": "host_validation", "synthetic_rgb_source": True, "camera_binding": False,
           "hardware_fps_claimed": False, "media": results, "all_passed": True}
(checks / "verification.json").write_text(json.dumps(summary, indent=2) + "\n")
print(json.dumps(summary))
