# Recording card-busy repair 05

`f3_card_request_06` can return FAIL before touching the caller's zero-initialized
card when another task owns `sole_task`. The old movie binding treated that as
unknown ownership and permanent Hold. The replacement recognizes only FAIL plus
the entire canonical all-zero own card as a finite refusal. It never clears the
other task, releases its request, or treats partial/unknown ownership as empty.

Combine with session05: detach the unused listener, prove the source fence,
release this recording activity, and permit a later Start retry.

The old failure is reproduced with the actual Card06 body. Nine normal and nine
ASan/UBSan cases pass with actual binding/card/movie/MKV code, ordinary pthreads,
and real host files. Ten published MKV files pass ffprobe timing and full ffmpeg
decode. Their two JPEG frames and timestamps are explicit fixtures: no new native
encoder execution, real-camera cadence, or achieved frame-rate claim.
Native UI owners, mount state, source fence and card callbacks remain fixtures.

Final evidence: `analysis/firmware/f4_start_repair_build_05`. Target object compiled
with `-fPIC`; original `_02` ABI preserved. No camera or Windows access.
