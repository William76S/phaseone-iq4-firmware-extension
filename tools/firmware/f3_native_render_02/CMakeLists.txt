add_library(iq4_f3_native_render_02 STATIC
  adapter.cpp completion.cpp decode_receipt.c native_binding.cpp
  native_file_ops.cpp persistent_pool.cpp)
target_compile_features(iq4_f3_native_render_02 PUBLIC cxx_std_17 c_std_11)
target_include_directories(iq4_f3_native_render_02 PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_compile_options(iq4_f3_native_render_02 PRIVATE -Wall -Wextra -Werror)
target_link_libraries(iq4_f3_native_render_02 PUBLIC iq4_f3_raw_file_source_01)
if(CMAKE_SYSTEM_NAME STREQUAL "Linux" AND CMAKE_SYSTEM_PROCESSOR MATCHES "^(aarch64|arm64)$")
  enable_language(ASM)
  target_sources(iq4_f3_native_render_02 PRIVATE wrappers.S)
  target_compile_options(iq4_f3_native_render_02 PRIVATE
    $<$<COMPILE_LANGUAGE:C>:-mno-outline-atomics>)
endif()
# The executable must also link frozen f3_core_native_receipt_01 receipt.c,
# its AArch64 wrappers.S, and native_runtime_01/self_read.c. Do not compile a
# second core receipt state. Original-address linker aliases are in LINK_INPUT.
set(IQ4_F3_CORE_RECEIPT_TARGET "" CACHE STRING "Existing target for the frozen core receipt")
if(IQ4_F3_CORE_RECEIPT_TARGET)
  target_link_libraries(iq4_f3_native_render_02 PUBLIC ${IQ4_F3_CORE_RECEIPT_TARGET})
endif()
set(IQ4_F3_RENDER02_TEST_PYTHON "" CACHE FILEPATH "Host Python interpreter for independent offline validation")
if(BUILD_TESTING AND IQ4_F3_RENDER02_TEST_PYTHON AND NOT CMAKE_CROSSCOMPILING)
  add_test(NAME iq4_f3_render02_offline
    COMMAND ${IQ4_F3_RENDER02_TEST_PYTHON}
      ${CMAKE_CURRENT_SOURCE_DIR}/../../../tests/f3_native_render_02/ctest_entry.py)
endif()
