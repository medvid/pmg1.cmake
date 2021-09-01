# Download BSP sources from GitHub
pmg1_load_bsp(
  NAME PMG1-CY7113
  VERSION 1.2.0
)

# Set target MPN
pmg1_set_device(CYPM1311-48LQXI)

# Set target CPU core
pmg1_set_core(CM0P)

set(BSP_SOURCES
  ${BSP_DIR}/cybsp.h
  ${BSP_DIR}/cybsp.c
  ${BSP_DIR}/cybsp_types.h
)
set(BSP_LINK_LIBRARIES
  mtb-pdl-cat2
  mtb-hal-cat2
)

add_definitions(-DCY_USING_HAL)
pmg1_add_component(BSP_DESIGN_MODUS)
pmg1_add_component(CAT2)
pmg1_add_component(CCG)
pmg1_add_bsp_startup(pmg1s3 pmg1s3)

# Define BSP library
add_library(bsp STATIC EXCLUDE_FROM_ALL ${BSP_SOURCES})
target_link_libraries(bsp PUBLIC ${BSP_LINK_LIBRARIES})

# Define custom recipes for BSP generated sources
pmg1_add_bsp_design_modus(${BSP_DIR}/COMPONENT_BSP_DESIGN_MODUS/design.modus
  cycfg.c
  cycfg.h
  cycfg_clocks.c
  cycfg_clocks.h
  cycfg_notices.h
  cycfg_peripherals.c
  cycfg_peripherals.h
  cycfg_pins.c
  cycfg_pins.h
  cycfg_routing.c
  cycfg_routing.h
  cycfg_system.c
  cycfg_system.h
)
pmg1_add_bsp_design_capsense(${BSP_DIR}/COMPONENT_BSP_DESIGN_MODUS/design.cycapsense)
