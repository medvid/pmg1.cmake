# https://github.com/Infineon/mtb-example-pmg1-dfu-basic/tree/master/bootloader_cm0p/COMPONENT_CUSTOM_DESIGN_MODUS
pmg1_check_bsp(
  PMG1-CY7110
  PMG1-CY7111
  PMG1-CY7112
  PMG1-CY7113
)

project(dfu-basic)

pmg1_load_application(
  NAME mtb-example-pmg1-dfu-basic
  VERSION 1.0.0
)
pmg1_add_executable(
  NAME
    dfu-basic-bootloader
  SOURCES
    ${APP_DIR}/bootloader_cm0p/main.c
    ${APP_DIR}/bootloader_cm0p/source/dfu_user.h
    ${APP_DIR}/bootloader_cm0p/source/dfu_user.c
  INCLUDE_DIRS
    ${APP_DIR}/bootloader_cm0p/source
  LINK_LIBRARIES
    dfu-i2c
    mtb-hal-cat2
  LINKER_SCRIPT
    ${APP_DIR}/bootloader_cm0p/linker_script/TARGET_${BSP_NAME}/TOOLCHAIN_${MTB_TOOLCHAIN}/dfu_cm0p_app0${TOOLCHAIN_SUFFIX_LS}
  DESIGN_MODUS
    ${APP_DIR}/bootloader_cm0p/COMPONENT_CUSTOM_DESIGN_MODUS/TARGET_${BSP_NAME}/design.modus
  GENERATED_SOURCES
    cycfg.h
    cycfg.c
    cycfg_clocks.h
    cycfg_clocks.c
    cycfg_notices.h
    cycfg_peripherals.h
    cycfg_peripherals.c
    cycfg_pins.h
    cycfg_pins.c
    cycfg_routing.h
    cycfg_system.h
    cycfg_system.c
)
if(${TOOLCHAIN} STREQUAL ARM)
  target_sources(dfu-basic-bootloader PRIVATE
    ${APP_DIR}/bootloader_cm0p/linker_script/TARGET_${BSP_NAME}/TOOLCHAIN_ARM/dfu_elf_symbols.c
  )
  target_include_directories(dfu-basic-bootloader PRIVATE
    ${APP_DIR}/bootloader_cm0p/linker_script/TARGET_${BSP_NAME}/TOOLCHAIN_ARM
  )
endif()

pmg1_add_executable(
  NAME
    dfu-basic-blinky
  SOURCES
    ${APP_DIR}/blinky_cm0p/main.c
    ${APP_DIR}/blinky_cm0p/dfu_user.h
  INCLUDE_DIRS
    ${APP_DIR}/blinky_cm0p
  LINK_LIBRARIES
    dfu
    mtb-hal-cat2
  LINKER_SCRIPT
    ${APP_DIR}/blinky_cm0p/linker_script/TARGET_${BSP_NAME}/TOOLCHAIN_${MTB_TOOLCHAIN}/dfu_cm0p_app1${TOOLCHAIN_SUFFIX_LS}
)
if(${TOOLCHAIN} STREQUAL ARM)
  target_sources(dfu-basic-blinky PRIVATE
    ${APP_DIR}/blinky_cm0p/linker_script/TARGET_${BSP_NAME}/TOOLCHAIN_ARM/dfu_elf_symbols.c
  )
  target_include_directories(dfu-basic-blinky PRIVATE
    ${APP_DIR}/blinky_cm0p/linker_script/TARGET_${BSP_NAME}/TOOLCHAIN_ARM
  )
endif()
pmg1_add_cyacd2(dfu-basic-blinky)
