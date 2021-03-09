pmg1_load_library(
  NAME mtb-pdl-cat2
  VERSION 1.1.0
)

set(MTB_PDL_CAT2_SOURCES
  ${MTB_PDL_CAT2_DIR}/devices/include/cypd8125_48lqxi.h
  ${MTB_PDL_CAT2_DIR}/devices/include/cypd8225_97bzxit.h
  ${MTB_PDL_CAT2_DIR}/devices/include/cypm1011_24lqxi.h
  ${MTB_PDL_CAT2_DIR}/devices/include/cypm1111_40lqxit.h
  ${MTB_PDL_CAT2_DIR}/devices/include/cypm1211_40lqxit.h
  ${MTB_PDL_CAT2_DIR}/devices/include/cypm1311_48lqxi.h
  ${MTB_PDL_CAT2_DIR}/devices/include/cypm1322_97bzxit.h
  ${MTB_PDL_CAT2_DIR}/devices/include/cy_device_headers.h
  ${MTB_PDL_CAT2_DIR}/devices/include/cy_usbpd_pmg1s0_regs.h
  ${MTB_PDL_CAT2_DIR}/devices/include/cy_usbpd_pmg1s1_regs.h
  ${MTB_PDL_CAT2_DIR}/devices/include/cy_usbpd_pmg1s2_regs.h
  ${MTB_PDL_CAT2_DIR}/devices/include/cy_usbpd_pmg1s3_regs.h
  ${MTB_PDL_CAT2_DIR}/devices/include/gpio_pmg1s0_24_qfn_pmg1_s0.h
  ${MTB_PDL_CAT2_DIR}/devices/include/gpio_pmg1s1_40_qfn_pmg1_s1.h
  ${MTB_PDL_CAT2_DIR}/devices/include/gpio_pmg1s2_40_qfn_pmg1_s2.h
  ${MTB_PDL_CAT2_DIR}/devices/include/gpio_pmg1s3_48_qfn.h
  ${MTB_PDL_CAT2_DIR}/devices/include/gpio_pmg1s3_97_bga.h
  ${MTB_PDL_CAT2_DIR}/devices/include/pmg1s0_config.h
  ${MTB_PDL_CAT2_DIR}/devices/include/pmg1s1_config.h
  ${MTB_PDL_CAT2_DIR}/devices/include/pmg1s2_config.h
  ${MTB_PDL_CAT2_DIR}/devices/include/pmg1s3_config.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_can.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_canfd_v2.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_cpuss_v3.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_cpuss_v5.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_cryptolite.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_crypto_v2.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_csd_v2.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_ctbm.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_ctbm_v2.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_dmac_v3.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_dmac_v5.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_exco.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_exco_v2.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_gpio.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_headers.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_hsiom.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_i2s_v2.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_lcd_v2.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_lpcomp_v2.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_mca.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_msc.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_pass.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_pass_v2.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_peri.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_prgio.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_sar.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_sar_v2.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_scb_v2.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_scb_v3.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_sflash_128.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_sflash_256.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_spcif_v3.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_spcif_v5.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_srsslt.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_tcpwm_v2.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_usbdevv2_v2.h
  ${MTB_PDL_CAT2_DIR}/devices/include/ip/cyip_wco.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_canfd.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_csd.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_device.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_dmac.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_flash.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_gpio.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_msc.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_pdl.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_sar.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_scb_common.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_scb_ezi2c.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_scb_i2c.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_scb_spi.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_scb_uart.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_smartio.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_sysclk.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_sysint.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_syslib.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_syspm.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_systick.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_tcpwm.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_tcpwm_counter.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_tcpwm_pwm.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_tcpwm_quaddec.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_trigmux.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_usbpd_bch.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_usbpd_common.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_usbpd_defines.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_usbpd_phy.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_usbpd_regs.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_usbpd_typec.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_usbpd_vbus_ctrl.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_wdc.h
  ${MTB_PDL_CAT2_DIR}/drivers/include/cy_wdt.h
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_canfd.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_csd.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_dmac.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_flash.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_gpio.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_msc.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_sar.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_scb_common.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_scb_ezi2c.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_scb_i2c.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_scb_spi.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_scb_uart.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_smartio.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_sysclk.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_sysint.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_syslib.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_syspm.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_systick.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_tcpwm_counter.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_tcpwm_pwm.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_tcpwm_quaddec.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_trigmux.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_usbpd_bch.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_usbpd_phy.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_usbpd_typec.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_usbpd_vbus_ctrl.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_wdc.c
  ${MTB_PDL_CAT2_DIR}/drivers/source/cy_wdt.c
)
set(MTB_PDL_CAT2_INCLUDE_DIRS
  ${MTB_PDL_CAT2_DIR}/devices/include
  ${MTB_PDL_CAT2_DIR}/drivers/include
)
set(MTB_PDL_CAT2_LINK_LIBRARIES
  core-lib cmsis-core
)

if (${CORE} STREQUAL CM0P)
  if(${TOOLCHAIN} STREQUAL GCC)
    list(APPEND MTB_PDL_CAT2_SOURCES ${MTB_PDL_CAT2_DIR}/drivers/source/COMPONENT_CM0P/TOOLCHAIN_GCC_ARM/cy_syslib_gcc.S)
  elseif(${TOOLCHAIN} STREQUAL ARM)
    list(APPEND MTB_PDL_CAT2_SOURCES ${MTB_PDL_CAT2_DIR}/drivers/source/COMPONENT_CM0P/TOOLCHAIN_ARM/cy_syslib_mdk.s)
  elseif(${TOOLCHAIN} STREQUAL IAR)
    list(APPEND MTB_PDL_CAT2_SOURCES ${MTB_PDL_CAT2_DIR}/drivers/source/COMPONENT_CM0P/TOOLCHAIN_IAR/cy_syslib_iar.s)
  elseif(${TOOLCHAIN} STREQUAL LLVM)
    list(APPEND MTB_PDL_CAT2_SOURCES ${LLVM_PORT_DIR}/syslib/cy_syslib_clang_cm0p.S)
  else()
    message(FATAL_ERROR "mtb-pdl-cat2: TOOLCHAIN ${TOOLCHAIN} is not supported.")
  endif()
elseif (${CORE} STREQUAL CM0)
  if(${TOOLCHAIN} STREQUAL GCC)
    list(APPEND MTB_PDL_CAT2_SOURCES ${MTB_PDL_CAT2_DIR}/drivers/source/COMPONENT_CM0/TOOLCHAIN_GCC_ARM/cy_syslib_gcc.S)
  elseif(${TOOLCHAIN} STREQUAL ARM)
    list(APPEND MTB_PDL_CAT2_SOURCES ${MTB_PDL_CAT2_DIR}/drivers/source/COMPONENT_CM0/TOOLCHAIN_ARM/cy_syslib_mdk.s)
  elseif(${TOOLCHAIN} STREQUAL IAR)
    list(APPEND MTB_PDL_CAT2_SOURCES ${MTB_PDL_CAT2_DIR}/drivers/source/COMPONENT_CM0/TOOLCHAIN_IAR/cy_syslib_iar.s)
  elseif(${TOOLCHAIN} STREQUAL LLVM)
    list(APPEND MTB_PDL_CAT2_SOURCES ${LLVM_PORT_DIR}/syslib/cy_syslib_clang_cm0.S)
  else()
    message(FATAL_ERROR "mtb-pdl-cat2: TOOLCHAIN ${TOOLCHAIN} is not supported.")
  endif()
else()
  message(FATAL_ERROR "mtb-pdl-cat2: CORE ${CORE} is not supported.")
endif()

add_library(mtb-pdl-cat2 STATIC EXCLUDE_FROM_ALL ${MTB_PDL_CAT2_SOURCES})
target_include_directories(mtb-pdl-cat2 PUBLIC ${MTB_PDL_CAT2_INCLUDE_DIRS})
target_link_libraries(mtb-pdl-cat2 PUBLIC ${MTB_PDL_CAT2_LINK_LIBRARIES})
