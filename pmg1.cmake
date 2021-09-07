# https://cmake.org/cmake/help/latest/command/include_guard.html
include_guard(GLOBAL)

# https://cmake.org/cmake/help/latest/module/FetchContent.html
# https://cliutils.gitlab.io/modern-cmake/chapters/projects/fetch.html
include(FetchContent)

# Configure FetchContent module to use the common cache directory
set(FETCHCONTENT_BASE_DIR "${CMAKE_SOURCE_DIR}/build/_deps" CACHE STRING "" FORCE)

# Set paths to the ModusToolbox tools:
# CY_TOOLS_PATHS - base tools directory (ModusToolbox/tools_X.Y)
# CY_TOOL_CFG_BACKEND_CLI - Device Configurator Backend CLI
# CY_TOOL_CAPSENSE_CLI - CapSense Configurator CLI
# CY_TOOL_USBDEV_CLI - USB Device Configurator CLI
# CY_TOOL_EZPD_CLI - EZ-PD Configurator CLI
# CY_MCUELFTOOL - ElfTool CLI
# CY_OPENOCD_BIN - OpenOCD CLI
# CY_OPENOCD_SCRIPTS - OpenOCD scripts directory
macro(pmg1_add_tools)
  # Check CY_TOOLS_PATHS is set as environment variable
  if(NOT DEFINED CY_TOOLS_PATHS AND DEFINED ENV{CY_TOOLS_PATHS})
    set(CY_TOOLS_PATHS "$ENV{CY_TOOLS_PATHS}")
  endif()

  # Parse the expected one-value arguments
  cmake_parse_arguments(TOOLS "" "VERSION" "" ${ARGN})

  # VERSION is the required argument
  if(NOT DEFINED TOOLS_VERSION)
    message(FATAL_ERROR "pmg1_add_tools: missing required VERSION argument.")
  endif()

  string(REPLACE "." ";" _tools_version_list ${TOOLS_VERSION})
  list(GET _tools_version_list 0 TOOLS_VERSION_MAJOR)
  list(GET _tools_version_list 1 TOOLS_VERSION_MINOR)
  list(GET _tools_version_list 2 TOOLS_VERSION_PATCH)
  unset(_tools_version_list)

  # Try to determine the default path for a provided tools VERSION
  if(NOT DEFINED CY_TOOLS_PATHS)
    # Determine the default path to ModusToolbox installation
    if(WIN32) # Windows
      set(MODUSTOOLBOX_DIR "$ENV{USERPROFILE}/ModusToolbox")
    elseif(APPLE) # MacOS
      set(MODUSTOOLBOX_DIR "/Applications/ModusToolbox")
    else() # Linux
      set(MODUSTOOLBOX_DIR "$ENV{HOME}/ModusToolbox")
    endif()

    set(CY_TOOLS_PATHS ${MODUSTOOLBOX_DIR}/tools_${TOOLS_VERSION_MAJOR}.${TOOLS_VERSION_MINOR})

    # Clear the local variables
    unset(MODUSTOOLBOX_DIR)
  endif()

  # Check the directory exists
  if(NOT IS_DIRECTORY ${CY_TOOLS_PATHS})
    message(FATAL_ERROR "pmg1_add_tools: CY_TOOLS_PATHS=${CY_TOOLS_PATHS} doesn't exist.")
  endif()

  # Convert Windows path (C:\Users) to UNIX path (C:/Users)
  STRING(REGEX REPLACE "\\\\" "/" CY_TOOLS_PATHS ${CY_TOOLS_PATHS})

  # Diagnostic output
  message(STATUS "CY_TOOLS_PATHS=${CY_TOOLS_PATHS}")

  # Set ModusToolbox tool paths
  set(CY_TOOL_CFG_BACKEND_CLI ${CY_TOOLS_PATHS}/cfg-backend-cli/cfg-backend-cli)
  set(CY_TOOL_CAPSENSE_CLI ${CY_TOOLS_PATHS}/capsense-configurator/capsense-configurator-cli)
  set(CY_TOOL_USBDEV_CLI ${CY_TOOLS_PATHS}/usbdev-configurator/usbdev-configurator-cli)
  set(CY_TOOL_EZPD_CLI ${CY_TOOLS_PATHS}/ez-pd-configurator/ez-pd-configurator-cli)
  set(CY_MCUELFTOOL ${CY_TOOLS_PATHS}/cymcuelftool-1.0/bin/cymcuelftool)

  # Set OpenOCD related paths
  set(CY_OPENOCD_BIN ${CY_TOOLS_PATHS}/openocd/bin/openocd)
  set(CY_OPENOCD_SCRIPTS ${CY_TOOLS_PATHS}/openocd/scripts)
endmacro()

# Configure toolchain definitions
macro(pmg1_configure_toolchain)
  set(TOOLCHAIN GCC CACHE STRING "Target toolchain")
  set_property(CACHE TOOLCHAIN PROPERTY STRINGS GCC ARM IAR)

  set(_toolchain_cmake ${CMAKE_CURRENT_SOURCE_DIR}/toolchain/${TOOLCHAIN}.cmake)
  if(NOT EXISTS ${_toolchain_cmake})
    message(FATAL_ERROR "Invalid TOOLCHAIN: ${TOOLCHAIN}.")
  endif()
  include(${_toolchain_cmake})
  unset(_toolchain_cmake)
endmacro()

# Configure BSP target definitions
macro(pmg1_configure_bsp)
  set(TARGET "" CACHE STRING "Target BSP")
  if("${TARGET}" STREQUAL "")
    message(FATAL_ERROR "pmg1_configure_bsp: TARGET is not set.")
  endif()

  set(_bsp_cmake ${CMAKE_CURRENT_SOURCE_DIR}/bsp/${TARGET}.cmake)
  if(NOT EXISTS ${_bsp_cmake})
    message(FATAL_ERROR "pmg1_configure_bsp: invalid TARGET: ${TARGET}.")
  endif()
  include(${_bsp_cmake})
  unset(_bsp_cmake)
endmacro()

# Configure OS target definitions
macro(pmg1_configure_os)
  set(OS "NOOS" CACHE STRING "Target OS")
  set_property(CACHE OS PROPERTY STRINGS NOOS FREERTOS RTX)

  string(TOLOWER ${OS} _os)
  set(_os_cmake ${CMAKE_SOURCE_DIR}/os/${_os}.cmake)
  unset(_os)
  if(NOT EXISTS ${_os_cmake})
    message(FATAL_ERROR "pmg1_configure_os: invalid OS: ${OS}.")
  endif()
  include(${_os_cmake})
  unset(_os_cmake)
endmacro()

# Add component to the global COMPONENTS list (used to conditionally include library sources)
# Also, add -DCOMPONENT_${component} to the global C preprocessor definitions
macro(pmg1_add_component component)
  list(APPEND COMPONENTS ${component})
  add_definitions(-DCOMPONENT_${component})
endmacro()

# Set target device MPN
macro(pmg1_set_device device)
  if("${device}" STREQUAL "")
    message(FATAL_ERROR "pmg1_set_device: missing required 'device' argument.")
  endif()

  # Initialize global DEVICE variable
  set(DEVICE ${device} CACHE STRING "Target device MPN")

  # Add -DDEVICE to project-level macro definitions
  string(REPLACE "-" "_" device_macro ${DEVICE})
  add_definitions(-D${device_macro})
  unset(device_macro)
endmacro()

# Add CPU-specific compilation definitions
# Variables CMAKE_${LANG}_FLAGS_${core} must be defined in the toolchain configuration
# CPU core names: CM0P, CM0
macro(pmg1_set_core default_core)
  # Select target CPU core
  set(CORE ${default_core} CACHE STRING "Target CPU core")
  set_property(CACHE CORE PROPERTY STRINGS CM0P CM0)

  pmg1_add_component(${CORE})

  string(APPEND CMAKE_C_FLAGS ${CMAKE_C_FLAGS_${CORE}})
  string(APPEND CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS_${CORE}})
  string(APPEND CMAKE_ASM_FLAGS ${CMAKE_ASM_FLAGS_${CORE}})
  string(APPEND CMAKE_EXE_LINKER_FLAGS ${CMAKE_EXE_LINKER_FLAGS_${CORE}})
endmacro()

# Clone or update the content from the remote git repository
macro(pmg1_fetch id url rev dir)
  # Check whether ${id}_GIT_SHALLOW variable is defined
  # to determine if the git repo should be cloned as shallow
  if(NOT DEFINED ${id}_GIT_SHALLOW)
    # Try to guess if the revision points to tag or raw SHA
    if("${rev}" MATCHES "^([0-9a-f]+)\$")
      # Always create full clones for assets referenced by SHA
      set(${id}_GIT_SHALLOW OFF)
    elseif(DEFINED ENV{CMAKE_GIT_SHALLOW})
      # Variable CMAKE_GIT_SHALLOW overrides if above is not set
      set(${id}_GIT_SHALLOW "$ENV{CMAKE_GIT_SHALLOW}")
    else()
      # By default, clone assets normally
      set(${id}_GIT_SHALLOW OFF)
    endif()
  endif()
  FetchContent_Declare(
    ${id}
    GIT_REPOSITORY ${url}
    GIT_TAG        ${rev}
    SOURCE_DIR     ${dir}
    GIT_SHALLOW    ${${id}_GIT_SHALLOW}
    GIT_PROGRESS   TRUE
    USES_TERMINAL_DOWNLOAD TRUE
    USES_TERMINAL_UPDATE   TRUE
  )
  # Use custom caching of the last-known content version
  # Default update method implemented in ExternalProject.cmake is too slow
  # (involves too much git operation even in case the version is up-to-date)
  if(NOT "${rev}" STREQUAL "${${id}_REV}" OR NOT IS_DIRECTORY "${dir}/.git")
    message(STATUS "Fetch ${url}/#${rev} to ${dir}")
    FetchContent_Populate(${id})
    set(${id}_REV ${rev} CACHE STRING "${id} version" FORCE)
  endif()
endmacro()

# Fetch BSP from online Git repository
macro(pmg1_load_bsp)
  # Parse the expected one-value arguments
  cmake_parse_arguments(BSP "" "NAME;VERSION;URL;TAG;DIR" "" ${ARGN})

  # NAME is the required argument
  if(NOT DEFINED BSP_NAME)
    message(FATAL_ERROR "pmg1_load_bsp: missing required NAME argument.")
  endif()

  # Some assets use Mbed-compatible BSP name ('-' -> '_')
  STRING(REGEX REPLACE "-" "_" MBED_BSP_NAME ${BSP_NAME})
  add_definitions(-DTARGET_${MBED_BSP_NAME})

  # Either VERSION or TAG should be provided
  if(NOT DEFINED BSP_VERSION AND NOT DEFINED BSP_TAG)
    message(FATAL_ERROR "pmg1_load_bsp: missing VERSION or TAG argument.")
  endif()

  # If URL is not set, assume this is standard BSP from Cypress GitHub
  if(NOT DEFINED BSP_URL)
    set(BSP_URL https://github.com/Infineon/TARGET_${BSP_NAME})
  endif()

  # If TAG is not set, assume standard release tag
  if(NOT DEFINED BSP_TAG)
    set(BSP_TAG release-v${BSP_VERSION})
  endif()

  # If DIR is not set, use the BSP_NAME sub-directory
  if(NOT DEFINED BSP_DIR)
    set(BSP_DIR ${CMAKE_CURRENT_LIST_DIR}/${BSP_NAME})
  endif()

  # Fetch the BSP sources from GitHub
  pmg1_fetch(${BSP_NAME} ${BSP_URL} ${BSP_TAG} ${BSP_DIR})
endmacro()

# Translate library name to CMake variable prefix
# Example: core-lib -> CORE_LIB
macro(pmg1_lib_name_to_prefix lib_name lib_prefix)
  string(TOUPPER "${lib_name}" ${lib_prefix})
  string(REPLACE "-" "_" ${lib_prefix} "${${lib_prefix}}")
endmacro()

# Fetch library from online Git repository
macro(pmg1_load_library)
  # Parse the expected one-value arguments
  cmake_parse_arguments(LIB "" "NAME;VERSION;URL;TAG;DIR" "" ${ARGN})

  # NAME is the required argument
  if(NOT DEFINED LIB_NAME)
    message(FATAL_ERROR "pmg1_load_library: missing required NAME argument.")
  endif()

  # Either VERSION or TAG should be provided
  if(NOT DEFINED LIB_VERSION AND NOT DEFINED LIB_TAG)
    message(FATAL_ERROR "pmg1_load_library: missing VERSION or TAG argument.")
  endif()

  # If URL is not set, assume this is standard lirbary from Cypress GitHub
  if(NOT DEFINED LIB_URL)
    set(LIB_URL https://github.com/Infineon/${LIB_NAME})
  endif()

  # If TAG is not set, assume standard release tag
  if(NOT DEFINED LIB_TAG)
    set(LIB_TAG release-v${LIB_VERSION})
  endif()

  # If DIR is not set, use the LIB_NAME sub-directory
  if(NOT DEFINED LIB_DIR)
    set(LIB_DIR ${CMAKE_CURRENT_LIST_DIR}/${LIB_NAME})
  endif()

  # Determine the unique library prefix
  pmg1_lib_name_to_prefix(${LIB_NAME} LIB_PREFIX)

  # Create project-scope variables with the library prefix
  set(${LIB_PREFIX}_NAME    ${LIB_NAME})
  set(${LIB_PREFIX}_VERSION ${LIB_VERSION})
  set(${LIB_PREFIX}_URL     ${LIB_URL})
  set(${LIB_PREFIX}_DIR     ${LIB_DIR})

  # Fetch the library sources from GitHub
  pmg1_fetch(${LIB_NAME} ${LIB_URL} ${LIB_TAG} ${LIB_DIR})

  # Clear the unprefixed variables from the project scope
  unset(LIB_NAME)
  unset(LIB_VERSION)
  unset(LIB_URL)
  unset(LIB_TAG)
  unset(LIB_DIR)
  unset(LIB_PREFIX)
endmacro()

# Fetch application from online Git repository
macro(pmg1_load_application)
  # Parse the expected one-value arguments
  cmake_parse_arguments(APP "" "NAME;VERSION;URL;TAG;DIR" "" ${ARGN})

  # NAME is the required argument
  if(NOT DEFINED APP_NAME)
    message(FATAL_ERROR "pmg1_load_application: missing required NAME argument.")
  endif()

  # Either VERSION or TAG should be provided
  if(NOT DEFINED APP_VERSION AND NOT DEFINED APP_TAG)
    message(FATAL_ERROR "pmg1_load_application: missing VERSION or TAG argument.")
  endif()

  # If URL is not set, assume this is standard lirbary from Cypress GitHub
  if(NOT DEFINED APP_URL)
    set(APP_URL https://github.com/Infineon/${APP_NAME})
  endif()

  # If TAG is not set, assume standard release tag
  if(NOT DEFINED APP_TAG)
    set(APP_TAG release-v${APP_VERSION})
  endif()

  # If DIR is not set, use the PROJECT_NAME sub-directory
  if(NOT DEFINED APP_DIR)
    set(APP_DIR ${CMAKE_CURRENT_LIST_DIR}/${PROJECT_NAME})
  endif()

  # Fetch the application sources from GitHub
  pmg1_fetch(${APP_NAME} ${APP_URL} ${APP_TAG} ${APP_DIR})

  # Clear the unprefixed variables from the project scope
  unset(APP_NAME)
  unset(APP_VERSION)
  unset(APP_URL)
  unset(APP_TAG)
endmacro()

# Discover custom local application
macro(pmg1_find_application)
  # Parse the expected one-value arguments
  cmake_parse_arguments(APP "" "NAME;DIR" "" ${ARGN})

  # If NAME is not set, use the CMake project name
  if(NOT DEFINED APP_NAME)
    set(TARGET_NAME ${PROJECT_NAME})
  endif()

  # If DIR is not set, use 'ROOT/app/PROJECT_NAME'
  if(NOT DEFINED APP_DIR)
    set(APP_DIR ${CMAKE_SOURCE_DIR}/../app/${PROJECT_NAME})
  endif()
endmacro()

# Set variables and custom recipes for design.modus GeneratedSource
macro(pmg1_add_design_modus design_modus var_source_dir var_sources)
  if(${ARGC} GREATER 3)
    set(generated_sources ${ARGN})
  else()
    # Default list matches standard peripheral selections in the BSP design.modus
    set(generated_sources
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
  endif()

  if(NOT EXISTS ${design_modus})
    message(FATAL_ERROR "pmg1_add_design_modus: ${design_modus} doesn't exist.")
  endif()

  # Initialize var_source_dir and var_sources
  get_filename_component(design_dir ${design_modus} DIRECTORY)
  set(${var_source_dir} ${design_dir}/GeneratedSource)
  list(TRANSFORM generated_sources
    PREPEND ${${var_source_dir}}/
    OUTPUT_VARIABLE ${var_sources}
  )
  unset(generated_sources)
  unset(design_dir)

  # Define custom recipe to update design.modus generated source
  add_custom_command(
    COMMAND ${CY_TOOL_CFG_BACKEND_CLI} --library ${CMAKE_SOURCE_DIR}/lib/mtb-pdl-cat2/devicesupport.xml --tools ${CY_TOOLS_PATHS} --build ${design_modus} --readonly
    DEPENDS ${design_modus}
    OUTPUT  ${${var_sources}}
    COMMENT "Generating Device Configuration for ${design_modus}"
  )
endmacro()

# Set variables and custom recipes for design.cycapsense GeneratedSource
macro(pmg1_add_design_capsense design_capsense var_source_dir var_sources)
  if(NOT EXISTS ${design_capsense})
    message(FATAL_ERROR "pmg1_add_design_capsense: ${design_capsense} doesn't exist.")
  endif()

  # Initialize var_source_dir and var_sources
  get_filename_component(design_dir ${design_capsense} DIRECTORY)
  set(${var_source_dir} ${design_dir}/GeneratedSource)
  set(${var_sources}
    ${${var_source_dir}}/cycfg_capsense.h
    ${${var_source_dir}}/cycfg_capsense.c
  )
  unset(design_dir)

  # Define custom recipe to update design.cycapsense generated source
  add_custom_command(
    COMMAND ${CY_TOOL_CAPSENSE_CLI} -c ${design_capsense}
    DEPENDS ${design_capsense}
    OUTPUT  ${${var_sources}}
    COMMENT "Generating CapSense Configuration for ${design_capsense}"
  )
endmacro()

# Set variables and custom recipes for design.cyusbdev GeneratedSource
macro(pmg1_add_design_usbdev design_usbdev var_source_dir var_sources)
  if(NOT EXISTS ${design_usbdev})
    message(FATAL_ERROR "pmg1_add_design_usbdev: ${design_usbdev} doesn't exist.")
  endif()

  # Initialize var_source_dir and var_sources
  get_filename_component(design_dir ${design_usbdev} DIRECTORY)
  set(${var_source_dir} ${design_dir}/GeneratedSource)
  set(${var_sources}
    ${${var_source_dir}}/cycfg_usbdev.h
    ${${var_source_dir}}/cycfg_usbdev.c
  )
  unset(design_dir)

  # Define custom recipe to update design.cyusbdev generated source
  add_custom_command(
    COMMAND ${CY_TOOL_USBDEV_CLI} -c ${design_usbdev}
    DEPENDS ${design_usbdev}
    OUTPUT  ${${var_sources}}
    COMMENT "Generating USB Device Configuration for ${design_usbdev}"
  )
endmacro()

# Set variables and custom recipes for design.mtbezpd GeneratedSource
macro(pmg1_add_design_ezpd design_ezpd var_source_dir var_sources)
  if(NOT EXISTS ${design_ezpd})
    message(FATAL_ERROR "pmg1_add_design_ezpd: ${design_ezpd} doesn't exist.")
  endif()

  # Initialize var_source_dir and var_sources
  get_filename_component(design_dir ${design_ezpd} DIRECTORY)
  set(${var_source_dir} ${design_dir}/GeneratedSource)
  set(${var_sources}
    ${${var_source_dir}}/mtbcfg_ezpd.h
    ${${var_source_dir}}/mtbcfg_ezpd.c
  )
  unset(design_dir)

  # Define custom recipe to update design.mtbezpd generated source
  add_custom_command(
    COMMAND ${CY_TOOL_EZPD_CLI} -c ${design_ezpd}
    DEPENDS ${design_ezpd}
    OUTPUT  ${${var_sources}}
    COMMENT "Generating EZ-PD Configuration for ${design_ezpd}"
  )
endmacro()

macro(pmg1_add_bsp_design_modus design_modus)
  pmg1_add_design_modus(
    ${design_modus}
    BSP_GENERATED_SOURCE_DIR
    BSP_GENERATED_SOURCES
    ${ARGN}
  )
  add_library(bsp_design_modus STATIC EXCLUDE_FROM_ALL ${BSP_GENERATED_SOURCES})
  target_include_directories(bsp_design_modus PUBLIC ${BSP_GENERATED_SOURCE_DIR})
  target_link_libraries(bsp_design_modus PUBLIC mtb-pdl-cat2 mtb-hal-cat2)
  # BSP sources include cycfg.h
  target_include_directories(bsp PUBLIC ${BSP_GENERATED_SOURCE_DIR})
endmacro()

macro(pmg1_add_bsp_design_capsense design_capsense)
  pmg1_add_design_capsense(
    ${design_capsense}
    BSP_CAPSENSE_GENERATED_SOURCE_DIR
    BSP_CAPSENSE_GENERATED_SOURCES
  )
  add_library(bsp_design_capsense STATIC EXCLUDE_FROM_ALL ${BSP_CAPSENSE_GENERATED_SOURCES})
  target_include_directories(bsp_design_capsense PUBLIC ${BSP_CAPSENSE_GENERATED_SOURCE_DIR})
  target_link_libraries(bsp_design_capsense PUBLIC mtb-hal-cat2 capsense)
endmacro()

# Set application target variables and recipes
macro(pmg1_add_executable)
  # Parse the expected arguments
  cmake_parse_arguments(TARGET ""
    "NAME;DESIGN_MODUS;DESIGN_CAPSENSE;DESIGN_USBDEV;DESIGN_EZPD;LINKER_SCRIPT"
    "SOURCES;INCLUDE_DIRS;DEFINES;LINK_LIBRARIES;GENERATED_SOURCES"
    ${ARGN}
  )

  # If NAME is not set, use the CMake project name
  if(NOT DEFINED TARGET_NAME)
    set(TARGET_NAME ${PROJECT_NAME})
  endif()

  # Define executable target, add application sources
  add_executable(${TARGET_NAME} ${TARGET_SOURCES})

  # Add application-specific include dirs
  target_include_directories(${TARGET_NAME} PRIVATE ${TARGET_INCLUDE_DIRS})

  # Add application-specific -DDEFINES
  target_compile_definitions(${TARGET_NAME} PRIVATE ${TARGET_DEFINES})

  # Link the BSP lirbary
  if(TARGET bsp)
    list(PREPEND TARGET_LINK_LIBRARIES bsp)
  endif()

   # Explicitly link the startup source for armlink
  if(${TOOLCHAIN} STREQUAL ARM)
    target_sources(${TARGET_NAME} PRIVATE ${BSP_STARTUP})
  endif()

  # Check if the application provides custom design.modus
  if(DEFINED TARGET_DESIGN_MODUS)
    pmg1_add_design_modus(
      ${TARGET_DESIGN_MODUS}
      CUSTOM_GENERATED_SOURCE_DIR
      CUSTOM_GENERATED_SOURCES
      ${TARGET_GENERATED_SOURCES}
    )
    target_sources(${TARGET_NAME} PRIVATE ${CUSTOM_GENERATED_SOURCES})
    target_include_directories(${TARGET_NAME} PRIVATE ${CUSTOM_GENERATED_SOURCE_DIR})
  elseif(TARGET bsp_design_modus)
    list(PREPEND TARGET_LINK_LIBRARIES bsp_design_modus)
  endif()

  # Check if the application provides custom design.cycapsense
  if(DEFINED TARGET_DESIGN_CAPSENSE)
    pmg1_add_design_capsense(
      ${TARGET_DESIGN_CAPSENSE}
      CUSTOM_CAPSENSE_GENERATED_SOURCE_DIR
      CUSTOM_CAPSENSE_GENERATED_SOURCES
    )
    target_sources(${TARGET_NAME} PRIVATE ${CUSTOM_CAPSENSE_GENERATED_SOURCES})
    target_include_directories(${TARGET_NAME} PRIVATE ${CUSTOM_CAPSENSE_GENERATED_SOURCE_DIR})
  elseif(TARGET bsp_design_capsense)
    list(PREPEND TARGET_LINK_LIBRARIES bsp_design_capsense)
  endif()

  # Check if the application provides custom design.cyusbdev
  if(DEFINED TARGET_DESIGN_USBDEV)
    pmg1_add_design_usbdev(
      ${TARGET_DESIGN_USBDEV}
      CUSTOM_USBDEV_GENERATED_SOURCE_DIR
      CUSTOM_USBDEV_GENERATED_SOURCES
    )
    target_sources(${TARGET_NAME} PRIVATE ${CUSTOM_USBDEV_GENERATED_SOURCES})
    target_include_directories(${TARGET_NAME} PRIVATE ${CUSTOM_USBDEV_GENERATED_SOURCE_DIR})
  endif()

  # Check if the application provides custom design.cyezpd
  if(DEFINED TARGET_DESIGN_EZPD)
    pmg1_add_design_ezpd(
      ${TARGET_DESIGN_EZPD}
      CUSTOM_EZPD_GENERATED_SOURCE_DIR
      CUSTOM_EZPD_GENERATED_SOURCES
    )
    target_sources(${TARGET_NAME} PRIVATE ${CUSTOM_EZPD_GENERATED_SOURCES})
    target_include_directories(${TARGET_NAME} PRIVATE ${CUSTOM_EZPD_GENERATED_SOURCE_DIR})
  endif()

  # Link LLVM binary against GCC standard C/C++ libraries
  if(${TOOLCHAIN} STREQUAL LLVM)
    list(PREPEND TARGET_LINK_LIBRARIES ${GCC_LINK_LIBRARIES})
  endif()

  # Ensure all weak symbols can be overriden by the strong overrides defined in the static libraries
  if(${TOOLCHAIN} STREQUAL GCC OR ${TOOLCHAIN} STREQUAL LLVM)
    list(PREPEND TARGET_LINK_LIBRARIES "-Wl,--whole-archive")
    list(APPEND TARGET_LINK_LIBRARIES "-Wl,--no-whole-archive")
  endif()

  # Include all dependent libraries
  target_link_libraries(${TARGET_NAME} PRIVATE ${TARGET_LINK_LIBRARIES})

  # If LINKER_SCRIPT is not set, use the BSP linker script
  if(NOT DEFINED TARGET_LINKER_SCRIPT)
    if(DEFINED BSP_LINKER_SCRIPT)
      set(TARGET_LINKER_SCRIPT ${BSP_LINKER_SCRIPT})
    else()
      message(FATAL_ERROR "pmg1_add_executable: specify either target LINKER_SCRIPT or BSP_LINKER_SCRIPT.")
    endif()
  endif()

  # Set linker related options
  set_target_properties(${TARGET_NAME} PROPERTIES
    SUFFIX ".elf"
    LINK_FLAGS "${TOOLCHAIN_LSFLAGS}${TARGET_LINKER_SCRIPT} ${TOOLCHAIN_MAPFILE}${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}.map"
  )

  # Define toolchain-specific post-build actions for ELF target
  set(_hex_path ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}.hex)
  set(_asm_path ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}.asm)
  if(${TOOLCHAIN} STREQUAL GCC)
    # Convert ELF to HEX
    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
      COMMAND ${GCC_TOOLCHAIN_PATH}/bin/arm-none-eabi-objcopy -O ihex "$<TARGET_FILE:${TARGET_NAME}>" "${_hex_path}"
      USES_TERMINAL)

    # Generate disassembly listing
    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
      COMMAND ${GCC_TOOLCHAIN_PATH}/bin/arm-none-eabi-objdump -s "$<TARGET_FILE:${TARGET_NAME}>" > "${_asm_path}"
      USES_TERMINAL)

    # Print the memory usage summary
    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
      COMMAND ${GCC_TOOLCHAIN_PATH}/bin/arm-none-eabi-size --format=berkeley --totals "$<TARGET_FILE:${TARGET_NAME}>"
      USES_TERMINAL)
  elseif(${TOOLCHAIN} STREQUAL ARM)
    # Convert ELF to HEX
    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
      COMMAND ${ARM_TOOLCHAIN_PATH}/bin/fromelf --output "${_hex_path}" --i32combined "$<TARGET_FILE:${TARGET_NAME}>"
      USES_TERMINAL)

    # Generate disassembly listing
    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
      COMMAND ${ARM_TOOLCHAIN_PATH}/bin/fromelf --disassemble --output "${_asm_path}" "$<TARGET_FILE:${TARGET_NAME}>"
      USES_TERMINAL)

    # Print the memory usage summary
    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
      COMMAND ${ARM_TOOLCHAIN_PATH}/bin/fromelf --info=sizes,totals "$<TARGET_FILE:${TARGET_NAME}>"
      USES_TERMINAL)
  elseif(${TOOLCHAIN} STREQUAL IAR)
    # Convert ELF to HEX
    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
      COMMAND ${IAR_TOOLCHAIN_PATH}/bin/ielftool --ihex "$<TARGET_FILE:${TARGET_NAME}>" "${_hex_path}"
      USES_TERMINAL)

    # Generate disassembly listing
    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
      COMMAND ${IAR_TOOLCHAIN_PATH}/bin/ielfdumparm --code "$<TARGET_FILE:${TARGET_NAME}>" "${_asm_path}"
      USES_TERMINAL)

    # Print the memory usage summary
    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
      COMMAND ${IAR_TOOLCHAIN_PATH}/bin/ielfdumparm "$<TARGET_FILE:${TARGET_NAME}>"
      USES_TERMINAL)
  elseif(${TOOLCHAIN} STREQUAL LLVM)
    # Convert ELF to HEX
    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
      COMMAND ${LLVM_TOOLCHAIN_PATH}/bin/llvm-objcopy -O ihex "$<TARGET_FILE:${TARGET_NAME}>" "${_hex_path}"
      USES_TERMINAL)

    # Generate disassembly listing
    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
      COMMAND ${LLVM_TOOLCHAIN_PATH}/bin/llvm-objdump -s "$<TARGET_FILE:${TARGET_NAME}>" > "${_asm_path}"
      USES_TERMINAL)

    # Print the memory usage summary
    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
      COMMAND ${LLVM_TOOLCHAIN_PATH}/bin/llvm-size --format=berkeley --totals "$<TARGET_FILE:${TARGET_NAME}>"
      USES_TERMINAL)
  endif()

  # Define custom command for CMSIS-DAP programming
  add_custom_target(${TARGET_NAME}_PROGRAM
    COMMAND ${CY_OPENOCD_BIN}
      -s ${CY_OPENOCD_SCRIPTS}
      -f ${CMAKE_SOURCE_DIR}/openocd.tcl
      -c "if [catch {program $<TARGET_FILE:${TARGET_NAME}>} ] { echo {** Program operation failed **} } else { echo {** Program operation completed successfully **} }"
      -c "reset_config srst_only;reset run;psoc4.dap dpreg 0x04 0x00;shutdown"
    DEPENDS ${TARGET_NAME}
    COMMENT "Program ${TARGET_NAME} application"
    VERBATIM USES_TERMINAL
  )

  # Clear local variables
  unset(_hex_path)
  unset(_asm_path)
endmacro()

# Check the application is applicable to the target BSP
macro(pmg1_check_bsp)
  set(_match FALSE)
  foreach(arg ${ARGN})
    if(${TARGET} STREQUAL ${arg})
      set(_match TRUE)
      break()
    endif()
  endforeach()
  if(NOT ${_match})
    return()
  endif()
endmacro()

# Add BSP startup sources
macro(pmg1_add_bsp_startup startup linker_script)
  set(BSP_STARTUP ${BSP_DIR}/startup_${startup}.c)
  if(NOT ${TOOLCHAIN} STREQUAL ARM)
    list(APPEND BSP_SOURCES ${BSP_STARTUP})
  endif()

  set(BSP_LINKER_SCRIPT_NAME ${linker_script})
  list(APPEND BSP_SOURCES ${BSP_DIR}/system_cat2.h)
  list(APPEND BSP_SOURCES ${BSP_DIR}/system_cat2.c)
  if(${TOOLCHAIN} STREQUAL GCC)
    set(BSP_LINKER_SCRIPT ${BSP_DIR}/TOOLCHAIN_GCC_ARM/${BSP_LINKER_SCRIPT_NAME}.ld)
  elseif(${TOOLCHAIN} STREQUAL ARM)
    set(BSP_LINKER_SCRIPT ${BSP_DIR}/TOOLCHAIN_ARM/${BSP_LINKER_SCRIPT_NAME}.sct)
  elseif(${TOOLCHAIN} STREQUAL IAR)
    set(BSP_LINKER_SCRIPT ${BSP_DIR}/TOOLCHAIN_IAR/${BSP_LINKER_SCRIPT_NAME}.icf)
  elseif(${TOOLCHAIN} STREQUAL LLVM)
    set(BSP_LINKER_SCRIPT ${BSP_DIR}/TOOLCHAIN_GCC_ARM/${BSP_LINKER_SCRIPT_NAME}.ld)
  else()
    message(FATAL_ERROR "pmg1_add_bsp_startup: TOOLCHAIN ${TOOLCHAIN} is not supported.")
  endif()
endmacro()

# Configure post-build event to generate *.cyacd2
macro(pmg1_add_cyacd2 target_name)
  add_custom_command(TARGET ${target_name} POST_BUILD
    COMMAND ${CY_MCUELFTOOL} --sign "$<TARGET_FILE:${target_name}>" CRC --output ${CMAKE_CURRENT_BINARY_DIR}/${target_name}_crc.elf
    COMMAND ${CY_MCUELFTOOL} -P ${CMAKE_CURRENT_BINARY_DIR}/${target_name}_crc.elf --output ${CMAKE_CURRENT_BINARY_DIR}/${target_name}_crc.cyacd2
    USES_TERMINAL)
endmacro()
