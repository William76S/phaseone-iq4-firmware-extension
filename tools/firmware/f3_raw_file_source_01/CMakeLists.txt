add_library(iq4_f3_raw_file_source_01 STATIC reader_stage.cpp source_builder.cpp)
target_compile_features(iq4_f3_raw_file_source_01 PUBLIC cxx_std_17)
target_include_directories(iq4_f3_raw_file_source_01 PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_compile_options(iq4_f3_raw_file_source_01 PRIVATE -Wall -Wextra -Werror)
# host_posix.cpp and test_source.cpp are deliberately host-only. Target FileOps
# must come from an exact-verified owned fd/syscall adapter; no target binding here.
