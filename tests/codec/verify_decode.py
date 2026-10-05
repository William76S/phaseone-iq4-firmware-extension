#!/usr/bin/env python3
"""Real decoder checks on host-produced codec JPEG, no camera FPS claim."""
import json,pathlib,subprocess,sys
directory=pathlib.Path(sys.argv[1])
results=[]
for filename in ("strided_rgb.jpg","quality_1.jpg","quality_100.jpg"):
    file=directory/filename
    probe=json.loads(subprocess.run(["ffprobe","-v","error","-show_streams","-of","json",str(file)],check=True,capture_output=True,text=True).stdout)
    stream=probe["streams"][0]
    assert stream["codec_name"]=="mjpeg" and (stream["width"],stream["height"])==(96,64)
    decoded=subprocess.run(["ffmpeg","-v","error","-i",str(file),"-pix_fmt","rgb24","-f","rawvideo","-"],check=True,capture_output=True)
    assert not decoded.stderr and len(decoded.stdout)==96*64*3
    original=(directory/"input_rgb24.raw").read_bytes()
    assert len(original)==len(decoded.stdout)
    error=sum(abs(a-b) for a,b in zip(original,decoded.stdout))/len(original)
    results.append({"file":filename,"decode_ok":True,"width":96,"height":64,"mean_abs_rgb_code_error":error,"input_color_pattern":"synthetic host RGB gradient/checker"})
summary={"level":"host_validation","hardware_performance_claimed":False,"decoded":results,"all_passed":True}
(directory.parent/"decode_results.json").write_text(json.dumps(summary,indent=2)+"\n")
print(json.dumps(summary))
