# CMake configuration for ttmath
cmake_minimum_required (VERSION 3.5)

set(TTMATH_PROJECT_NAME "ttmath" CACHE STRING "Project name for generators")
project("${TTMATH_PROJECT_NAME}" VERSION 0.9.3 LANGUAGES CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(misc_target)
include(target_folder)
include(CTest)

enable_testing()

add_library(ttmath INTERFACE
    "ttmath/ttmathbig.h"
    "ttmath/ttmathdec.h"
    "ttmath/ttmathint.h"
    "ttmath/ttmathmisc.h"
    "ttmath/ttmathobjects.h"
    "ttmath/ttmathparser.h"
    "ttmath/ttmaththreads.h"
    "ttmath/ttmathtypes.h"
    "ttmath/ttmathuint.h"
    "ttmath/ttmathuint_noasm.h"
    "ttmath/ttmathuint_x86.h"
    "ttmath/ttmathuint_x86_64.h"
    "ttmath/ttmath.h" 
)
target_include_directories(ttmath INTERFACE .)
target_folder(ttmath "Libraries")
# Building with Visual C++ x86_64 needs to compile the asm utilities first
if (MSVC AND "x${CMAKE_VS_PLATFORM_NAME}" STREQUAL "xx64")
  set(TTMATH_MSVC64_ASM ttmathuint_x86_64_msvc.asm) 
  enable_language(ASM_MASM)
  message(STATUS "Enabled MASM to compile '${TTMATH_MSVC64_ASM}'")
  set(TTMATH_SRC_ASM "${CMAKE_SOURCE_DIR}/ttmath/${TTMATH_MSVC64_ASM}")
  target_sources(ttmath INTERFACE "${TTMATH_SRC_ASM}")
endif()

add_subdirectory(samples)
add_subdirectory(tests)
add_subdirectory(tests2)
