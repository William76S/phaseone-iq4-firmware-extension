# Native Dual EXP component

Maintained implementation is `src/display/dual_exposure.cpp`. It retains the working native310×70 stepper,70×70 arrows and native EXP label/font. The owned label flags12 release only horizontal padding; default is+3EV and supported requests are1/3..5EV in thirds.

The factory configuration maximum169 and ordinary shutter-seconds domain are distinct. The adapter admits169 as original configuration data, but queries only ordinary ticks0..166. It uses original table seconds×Ratio to tighten requested long time to≤1s and respects stricter factory readout/long constraints. Original range/float setters, notification delivery and capture/BlackRef flow remain in use; the post-bounds wrapper calls the original bare shutter setter exactly once with the clamped value. Long shutter display uses the native time quantizer; EXP displays requested EV. Native sensor row quantization is retained, so requested1s is not a measured guarantee of exact optical integration.

Run from repository root with a new output directory:

```sh
python3 tools/firmware/dual_exposure/generate_pins.py
build/dual-exposure-host-venv/bin/python tools/firmware/dual_exposure/generate_factory_times.py tests/display/dual_exposure_factory_times.h
python3 tools/firmware/dual_exposure/build.py NEW_BUILD_DIRECTORY
build/dual-exposure-host-venv/bin/python tools/firmware/dual_exposure/emulate.py NEW_BUILD_DIRECTORY/dual.o NEW_EVIDENCE_DIRECTORY/A64_EMULATION.json
build/dual-exposure-host-venv/bin/python tools/firmware/dual_exposure/emulate_sensor_parameters.py NEW_EVIDENCE_DIRECTORY/A64_EMULATION.json NEW_EVIDENCE_DIRECTORY/A64_SENSOR_PARAMETERS.json
```

Host normal and ASan/UBSan fixtures validate the bounded component contract. The emulator executes full stock configuration/numeric constructors, real maximum169 getters, EXP construction, normal OnOpen order, original range/bare setters and notifications, all15 arrow/held-repeat ratios, table seconds and quantizer. Sensor parameter evidence consumes those UI float values and runs original controller/setter/mode/integration bytes with explicit synthetic timing and memory-only register traps. Neither emulator opens the camera, emits firmware, measures optical exposure, verifies IIQ metadata or checks Capture One merging. Release evidence and exact installable firmware are linked from `deploy/`; immutable historical receipts retain their own hashes.
