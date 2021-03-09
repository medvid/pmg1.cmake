pmg1_load_library(
  NAME pdstack
  VERSION 1.0.0
)

set(PDSTACK_SOURCES
  ${PDSTACK_DIR}/cy_pdstack_common.h
  ${PDSTACK_DIR}/cy_pdstack_dpm.h
  ${PDSTACK_DIR}/cy_pdstack_port_config.h
  ${PDSTACK_DIR}/cy_pdstack_utils.h
  ${PDSTACK_DIR}/cy_sw_timer.h
  ${PDSTACK_DIR}/cy_sw_timer_id.h
)
set(PDSTACK_INCLUDE_DIRS
  ${PDSTACK_DIR}
)
set(PDSTACK_LINK_LIBRARIES
  mtb-pdl-cat2
)

if(${TOOLCHAIN} STREQUAL GCC OR ${TOOLCHAIN} STREQUAL LLVM)
  set(PDSTACK_PD2_SNK_LITE_LINK_LIBRARIES
    ${PDSTACK_DIR}/COMPONENT_PMG1_PD2_SNK_LITE/TOOLCHAIN_GCC_ARM/libpmg1_pd2_snk_lite.a
  )
elseif(${TOOLCHAIN} STREQUAL ARM)
  set(PDSTACK_PD2_SNK_LITE_LINK_LIBRARIES
    ${PDSTACK_DIR}/COMPONENT_PMG1_PD2_SNK_LITE/TOOLCHAIN_ARM/libpmg1_pd2_snk_lite.ar
  )
elseif(${TOOLCHAIN} STREQUAL IAR)
  set(PDSTACK_PD2_SNK_LITE_LINK_LIBRARIES
    ${PDSTACK_DIR}/COMPONENT_PMG1_PD2_SNK_LITE/TOOLCHAIN_IAR/libpmg1_pd2_snk_lite.a
  )
else()
  message(FATAL_ERROR "pdstack: TOOLCHAIN ${TOOLCHAIN} is not supported.")
endif()

if(${TOOLCHAIN} STREQUAL GCC OR ${TOOLCHAIN} STREQUAL LLVM)
  set(PDSTACK_PD3_SNK_LITE_LINK_LIBRARIES
    ${PDSTACK_DIR}/COMPONENT_PMG1_PD3_SNK_LITE/TOOLCHAIN_GCC_ARM/libpmg1_pd3_snk_lite.a
  )
elseif(${TOOLCHAIN} STREQUAL ARM)
  set(PDSTACK_PD3_SNK_LITE_LINK_LIBRARIES
    ${PDSTACK_DIR}/COMPONENT_PMG1_PD3_SNK_LITE/TOOLCHAIN_ARM/libpmg1_pd3_snk_lite.ar
  )
elseif(${TOOLCHAIN} STREQUAL IAR)
  set(PDSTACK_PD3_SNK_LITE_LINK_LIBRARIES
    ${PDSTACK_DIR}/COMPONENT_PMG1_PD3_SNK_LITE/TOOLCHAIN_IAR/libpmg1_pd3_snk_lite.a
  )
else()
  message(FATAL_ERROR "pdstack: TOOLCHAIN ${TOOLCHAIN} is not supported.")
endif()

add_library(pdstack-pd2-snk-lite INTERFACE EXCLUDE_FROM_ALL)
target_include_directories(pdstack-pd2-snk-lite INTERFACE ${PDSTACK_INCLUDE_DIRS})
target_sources(pdstack-pd2-snk-lite INTERFACE ${PDSTACK_SOURCES})
target_link_libraries(pdstack-pd2-snk-lite INTERFACE
  ${PDSTACK_LINK_LIBRARIES}
  ${PDSTACK_PD2_SNK_LITE_LINK_LIBRARIES}
)

add_library(pdstack-pd3-snk-lite INTERFACE EXCLUDE_FROM_ALL)
target_include_directories(pdstack-pd3-snk-lite INTERFACE ${PDSTACK_INCLUDE_DIRS})
target_sources(pdstack-pd3-snk-lite INTERFACE ${PDSTACK_SOURCES})
target_link_libraries(pdstack-pd3-snk-lite INTERFACE
  ${PDSTACK_LINK_LIBRARIES}
  ${PDSTACK_PD3_SNK_LITE_LINK_LIBRARIES}
)
