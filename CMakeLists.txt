# CMake 3.16 required for ARMClang toolchain support
# CMake 3.14 required for FetchContent module
cmake_minimum_required(VERSION 3.16)

# Load pmg1_* macros
include(pmg1.cmake)

# Load ModusToolbox tool definitions
pmg1_add_tools(VERSION 2.3)

# Configure toolchain definitions
pmg1_configure_toolchain()

# Define project name, set enabled languages
project(pmg1 C CXX ASM)

# https://cmake.org/cmake/help/latest/prop_tgt/CXX_STANDARD.html
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Configure target BSP, load common libraries
pmg1_configure_bsp()

# Configure target OS, load OS-specific libraries and applications
pmg1_configure_os()
