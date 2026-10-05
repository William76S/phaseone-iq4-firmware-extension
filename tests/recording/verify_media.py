#!/usr/bin/env python3
"""Real host decode and packet/PTS proof, never hardware FPS evidence."""
import hashlib
import json
import pathlib
import subprocess
import sys

root=pathlib.Path(__file__).resolve().parents[2]
fixtures=pathlib.Path(sys.argv[1]).resolve()
outputs=pathlib.Path(sys.argv[2]).resolve()
evidence=pathlib.Path(sys.argv[3]).resolve()
evidence.mkdir(parents=True,exist_ok=True)
vfr=[1000000000,1031000123,1067000456,1100123789,1185000789,1200000901,1249010234,1298888888,1333333333,1400056789,1457777777,1512345678]
cases={"normal_1.avi":12,"aborted_recovered_1.avi":7,"disk_full_recovered_1.avi":5,"patch_recovered_1.avi":4,"sync_recovered_1.avi":1,"vfr_1.mkv":12,"mkv_abort_recovered_1.mkv":5,"mkv_disk_recovered_1.mkv":3,"mkv_bad_pts_recovered_1.mkv":1,"source_lost_1.mkv":2}
results=[]
for filename,count in cases.items():
    media=outputs/filename
    probe=subprocess.run(["ffprobe","-v","error","-count_frames","-show_packets","-show_streams","-of","json",str(media)],check=True,capture_output=True,text=True)
    (evidence/(filename+".ffprobe.json")).write_text(probe.stdout)
    data=json.loads(probe.stdout)
    assert len(data["streams"])==1 and data["streams"][0]["codec_name"]=="mjpeg"
    stream=data["streams"][0]
    assert (stream["width"],stream["height"])==(96,64)
    assert int(stream["nb_read_frames"])==count and len(data["packets"])==count
    decode=subprocess.run(["ffmpeg","-hide_banner","-v","error","-i",str(media),"-fps_mode","passthrough","-f","framemd5","-"],check=True,capture_output=True,text=True)
    assert not decode.stderr
    (evidence/(filename+".decode.framemd5")).write_text(decode.stdout)
    assert len([line for line in decode.stdout.splitlines() if not line.startswith("#") and line.strip()])==count
    packet_folder=evidence/(filename+".jpeg_packets")
    packet_folder.mkdir()
    subprocess.run(["ffmpeg","-hide_banner","-v","error","-i",str(media),"-c:v","copy","-fps_mode","passthrough",str(packet_folder/"packet_%02d.jpg")],check=True)
    for i in range(1,count+1):
        assert (packet_folder/f"packet_{i:02d}.jpg").read_bytes()==(fixtures/f"host_fixture_{i:02d}.jpg").read_bytes()
    actual_pts=[p["pts"] for p in data["packets"]]
    if filename.endswith(".mkv"):
        assert stream["time_base"]=="1/1000000000"
        assert actual_pts==[p-vfr[0] for p in vfr[:count]]
        pts_mode="exact_original_intervals_ns"
    else:
        assert actual_pts==list(range(count))
        pts_mode="strict_nominal_CFR_only_original_pts_embedded"
    results.append({"file":filename,"frames_decoded":count,"jpeg_packets_byte_identical":True,"pts_mode":pts_mode,"pts":actual_pts,"time_base":stream["time_base"],"sha256":hashlib.sha256(media.read_bytes()).hexdigest(),"probe_r_frame_rate_not_hardware_fps":stream.get("r_frame_rate")})
summary={"evidence_level":"host_validation","fixture_origin":"caller-provided host-generated synthetic 96x64 JPEG fixtures, no camera","hardware_fps_claimed":False,"decoded_files":results,"all_passed":True}
(evidence/"media_results.json").write_text(json.dumps(summary,indent=2)+"\n")
print(json.dumps({"decoded_files":len(results),"total_decoded_frames":sum(r["frames_decoded"] for r in results),"jpeg_packets_byte_identical":True,"VFR_pts_exact":True,"hardware_fps_claimed":False}))
