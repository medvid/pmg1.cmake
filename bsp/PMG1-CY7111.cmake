# Download BSP sources from GitHub
pmg1_load_bsp(
  NAME PMG1-CY7111
  VERSION 1.1.0
)

# Set target MPN
pmg1_set_device(CYPM1111-40LQXIT)

# Set target CPU core
pmg1_set_core(CM0)

set(BSP_SOURCES
  ${BSP_DIR}/cybsp.h
  ${BSP_DIR}/cybsp.c
  ${BSP_DIR}/cybsp_types.h
)
set(BSP_LINK_LIBRARIES
  mtb-pdl-cat2
  mtb-hal-cat2
)

# Include BSP_DIR globally
include_directories(${BSP_DIR})

add_definitions(-DCY_USING_HAL)
pmg1_add_component(BSP_DESIGN_MODUS)
pmg1_add_component(CAT2)
pmg1_add_component(CCG)
pmg1_add_bsp_startup(pmg1s1 pmg1s1)

# Define BSP library
add_library(bsp STATIC EXCLUDE_FROM_ALL ${BSP_SOURCES})
target_link_libraries(bsp PUBLIC ${BSP_LINK_LIBRARIES})

# Load library definitions
include(lib/cmsis.cmake)
include(lib/core-lib.cmake)
include(lib/mtb-pdl-cat2.cmake)

# Include common libraries
include(lib/mtb-hal-cat2.cmake)
include(lib/retarget-io.cmake)
include(lib/pdstack.cmake)

# Define custom recipes for BSP generated sources
pmg1_add_bsp_design_modus(${BSP_DIR}/COMPONENT_BSP_DESIGN_MODUS/design.modus)
