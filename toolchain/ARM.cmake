# https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html

# Setting Linux is forcing the extension to be .o instead of .obj when building on Windows.
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_EXECUTABLE_SUFFIX ".elf")

# Avoid ARMClang.cmake error:
# System processor 'ARM' not supported by ARMClang C compiler
# The correct compiler flags set by cy_set_core are honored
set(CMAKE_SYSTEM_PROCESSOR cortex-m0)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

if(DEFINED ENV{ARM_TOOLCHAIN_PATH})
  set(ARM_TOOLCHAIN_DEFAULT_PATH "$ENV{ARM_TOOLCHAIN_PATH}")
else()
  set(ARM_TOOLCHAIN_DEFAULT_PATH "C:/Keil_v5/ARM/ARMCLANG")
endif()
set(ARM_TOOLCHAIN_PATH ${ARM_TOOLCHAIN_DEFAULT_PATH} CACHE PATH "ARM toolchain path")

if(WIN32)
  set(TOOLCHAIN_EXT ".exe")
else()
  set(TOOLCHAIN_EXT "")
endif()

set(CMAKE_C_COMPILER ${ARM_TOOLCHAIN_PATH}/bin/armclang${TOOLCHAIN_EXT} CACHE INTERNAL "C Compiler")
set(CMAKE_CXX_COMPILER ${ARM_TOOLCHAIN_PATH}/bin/armclang${TOOLCHAIN_EXT} CACHE INTERNAL "C++ Compiler")
set(CMAKE_ASM_COMPILER ${ARM_TOOLCHAIN_PATH}/bin/armasm${TOOLCHAIN_EXT} CACHE INTERNAL "ASM Compiler")
set(CMAKE_AR ${ARM_TOOLCHAIN_PATH}/bin/armar${TOOLCHAIN_EXT} CACHE INTERNAL "Archiver")
set(CMAKE_LINKER ${ARM_TOOLCHAIN_PATH}/bin/armlink${TOOLCHAIN_EXT} CACHE INTERNAL "Linker")

set(CMAKE_C_FLAGS "-g -fshort-enums -fshort-wchar -Wall" CACHE INTERNAL "C Compiler flags")
set(CMAKE_CXX_FLAGS "-g -fshort-enums -fshort-wchar -fno-rtti -fno-exceptions -Wall" CACHE INTERNAL "C++ Compiler flags")
set(CMAKE_ASM_FLAGS "" CACHE INTERNAL "ASM Compiler flags")
set(CMAKE_EXE_LINKER_FLAGS "--info=totals --stdlib=libc++" CACHE INTERNAL "Linker flags")

set(CMAKE_C_FLAGS_DEBUG "-DDEBUG -O1" CACHE INTERNAL "C Compiler flags for Debug configuration")
set(CMAKE_CXX_FLAGS_DEBUG "-DDEBUG -O1" CACHE INTERNAL "C++ Compiler flags for Debug configuration")
set(CMAKE_ASM_FLAGS_DEBUG "" CACHE INTERNAL "ASM Compiler flags for Debug configuration")
set(CMAKE_EXE_LINKER_FLAGS_DEBUG "" CACHE INTERNAL "Linker flags for Debug configuration")

set(CMAKE_C_FLAGS_RELEASE "-DNDEBUG -Oz" CACHE INTERNAL "C Compiler flags for Release configuration")
set(CMAKE_CXX_FLAGS_RELEASE "-DNDEBUG -Oz" CACHE INTERNAL "C++ Compiler flags for Release configuration")
set(CMAKE_ASM_FLAGS_RELEASE "" CACHE INTERNAL "ASM Compiler flags for Release configuration")
set(CMAKE_EXE_LINKER_FLAGS_RELEASE "" CACHE INTERNAL "Linker flags for Release configuration")

set(CMAKE_C_FLAGS_CM0 " -mcpu=cortex-m0" CACHE INTERNAL "C Compiler flags for CM0 CPU core")
set(CMAKE_CXX_FLAGS_CM0 " -mcpu=cortex-m0" CACHE INTERNAL "C++ Compiler flags for CM0 CPU core")
set(CMAKE_ASM_FLAGS_CM0 " --cpu=Cortex-M0" CACHE INTERNAL "ASM Compiler flags for CM0 CPU core")
set(CMAKE_EXE_LINKER_FLAGS_CM0 " --cpu=Cortex-M0" CACHE INTERNAL "Linker flags for CM0 CPU core")

set(CMAKE_C_FLAGS_CM0P " -mcpu=cortex-m0plus" CACHE INTERNAL "C Compiler flags for CM0+ CPU core")
set(CMAKE_CXX_FLAGS_CM0P " -mcpu=cortex-m0plus" CACHE INTERNAL "C++ Compiler flags for CM0+ CPU core")
set(CMAKE_ASM_FLAGS_CM0P " --cpu=Cortex-M0plus" CACHE INTERNAL "ASM Compiler flags for CM0+ CPU core")
set(CMAKE_EXE_LINKER_FLAGS_CM0P " --cpu=Cortex-M0plus" CACHE INTERNAL "Linker flags for CM0+ CPU core")

# Linker script and map file flags
set(TOOLCHAIN_LSFLAGS "--scatter ")
set(TOOLCHAIN_MAPFILE "--map --list ")
set(TOOLCHAIN_PREINCLUDE "-include")

# Linker script suffix
set(TOOLCHAIN_SUFFIX_LS ".sct")

# ModusToolbox toolchain name
set(MTB_TOOLCHAIN "ARM")

# Suppress ARM Linker warnings:
# L6314W: No section matches pattern
# L6329W: Pattern only matches removed unused sections
string(APPEND CMAKE_EXE_LINKER_FLAGS "  --diag_suppress=L6314W,L6329W")
