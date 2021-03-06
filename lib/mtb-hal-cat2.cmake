pmg1_load_library(
  NAME mtb-hal-cat2
  VERSION 1.1.0
)

set(MTB_HAL_CAT2_SOURCES
  ${MTB_HAL_CAT2_DIR}/include/cyhal.h
  ${MTB_HAL_CAT2_DIR}/include/cyhal_adc.h
  ${MTB_HAL_CAT2_DIR}/include/cyhal_clock.h
  ${MTB_HAL_CAT2_DIR}/include/cyhal_dma.h
  ${MTB_HAL_CAT2_DIR}/include/cyhal_ezi2c.h
  ${MTB_HAL_CAT2_DIR}/include/cyhal_flash.h
  ${MTB_HAL_CAT2_DIR}/include/cyhal_general_types.h
  ${MTB_HAL_CAT2_DIR}/include/cyhal_gpio.h
  ${MTB_HAL_CAT2_DIR}/include/cyhal_hwmgr.h
  ${MTB_HAL_CAT2_DIR}/include/cyhal_i2c.h
  ${MTB_HAL_CAT2_DIR}/include/cyhal_interconnect.h
  ${MTB_HAL_CAT2_DIR}/include/cyhal_keyscan.h
  ${MTB_HAL_CAT2_DIR}/include/cyhal_lptimer.h
  ${MTB_HAL_CAT2_DIR}/include/cyhal_pwm.h
  ${MTB_HAL_CAT2_DIR}/include/cyhal_quaddec.h
  ${MTB_HAL_CAT2_DIR}/include/cyhal_spi.h
  ${MTB_HAL_CAT2_DIR}/include/cyhal_syspm.h
  ${MTB_HAL_CAT2_DIR}/include/cyhal_system.h
  ${MTB_HAL_CAT2_DIR}/include/cyhal_timer.h
  ${MTB_HAL_CAT2_DIR}/include/cyhal_uart.h
  ${MTB_HAL_CAT2_DIR}/include/cyhal_wdt.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_adc_impl.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_analog_common.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_clock_impl.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_dma_dmac.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_dma_impl.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_drivers.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_gpio_impl.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_hw_resources.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_hw_types.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_hwmgr_impl.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_interconnect_impl.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_peri_common.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_pin_package.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_pwm_impl.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_quaddec_impl.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_scb_common.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_syspm_impl.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_system_impl.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_tcpwm_common.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_timer_impl.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_triggers.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_utils.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_utils_psoc.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_wdt_impl_common.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/cyhal_wdt_impl.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_adc_sar.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_analog_common.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_clock.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_dma.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_dma_dmac.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_ezi2c.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_flash.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_gpio.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_hwmgr.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_hwmgr_impl_part.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_i2c.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_interconnect.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_lptimer.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_pwm.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_quaddec.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_scb_common.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_spi.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_syspm.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_system.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_tcpwm_common.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_timer.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_uart.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_utils.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_utils_psoc.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/cyhal_wdt.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/pin_packages/cyhal_pmg1s0_24_qfn_pmg1_s0.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/pin_packages/cyhal_pmg1s1_40_qfn_pmg1_s1.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/pin_packages/cyhal_pmg1s2_40_qfn_pmg1_s2.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/pin_packages/cyhal_pmg1s2_42_csp_pmg1_s2.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/pin_packages/cyhal_pmg1s3_48_qfn_cypm1311.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/pin_packages/cyhal_pmg1s3_97_bga_cypd8225.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/pin_packages/cyhal_pmg1s3_97_bga_cypm1322.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/pin_packages/cyhal_pmg1s0_24_qfn_pmg1_s0.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/pin_packages/cyhal_pmg1s1_40_qfn_pmg1_s1.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/pin_packages/cyhal_pmg1s2_40_qfn_pmg1_s2.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/pin_packages/cyhal_pmg1s2_42_csp_pmg1_s2.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/pin_packages/cyhal_pmg1s3_48_qfn_cypm1311.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/pin_packages/cyhal_pmg1s3_97_bga_cypd8225.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/pin_packages/cyhal_pmg1s3_97_bga_cypm1322.c
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include/triggers/cyhal_triggers_pmg1s3.h
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/source/triggers/cyhal_triggers_pmg1s3.c
)
set(MTB_HAL_CAT2_INCLUDE_DIRS
  ${MTB_HAL_CAT2_DIR}/include
  ${MTB_HAL_CAT2_DIR}/COMPONENT_CAT2/include
)
set(MTB_HAL_CAT2_LINK_LIBRARIES
  mtb-pdl-cat2
)

add_library(mtb-hal-cat2 STATIC EXCLUDE_FROM_ALL ${MTB_HAL_CAT2_SOURCES})
target_include_directories(mtb-hal-cat2 PUBLIC ${MTB_HAL_CAT2_INCLUDE_DIRS})
target_link_libraries(mtb-hal-cat2 PUBLIC ${MTB_HAL_CAT2_LINK_LIBRARIES})

# BSP library depends on HAL
target_link_libraries(bsp PUBLIC mtb-hal-cat2)
