# https://github.com/Infineon/mtb-example-pmg1-usbpd-sink-capsense/tree/master/USBPD_CONFIG
pmg1_check_bsp(
  PMG1-CY7113
)

project(usbpd-sink-capsense)

pmg1_load_application(
  NAME mtb-example-pmg1-usbpd-sink-capsense
  VERSION 1.0.0
)
pmg1_add_executable(
  SOURCES
    ${APP_DIR}/config.h
    ${APP_DIR}/main.c
    ${APP_DIR}/src/app/app.h
    ${APP_DIR}/src/app/app.c
    ${APP_DIR}/src/app/charger_detect.h
    ${APP_DIR}/src/app/charger_detect.c
    ${APP_DIR}/src/app/fault_handlers.c
    ${APP_DIR}/src/app/pdo.h
    ${APP_DIR}/src/app/pdo.c
    ${APP_DIR}/src/app/psink.h
    ${APP_DIR}/src/app/psink.c
    ${APP_DIR}/src/app/swap.h
    ${APP_DIR}/src/app/swap.c
    ${APP_DIR}/src/app/vdm.h
    ${APP_DIR}/src/app/vdm.c
    ${APP_DIR}/src/system/instrumentation.h
    ${APP_DIR}/src/system/instrumentation.c
  INCLUDE_DIRS
    ${APP_DIR}
    ${APP_DIR}/src/app
    ${APP_DIR}/src/system
  DEFINES
    CY_PD_SINK_ONLY=1
    CY_PD_REV3_ENABLE=1
    VBUS_OVP_ENABLE=1
    VBUS_UVP_ENABLE=0
    SYS_DEEPSLEEP_ENABLE=1
  LINK_LIBRARIES
    mtb-pdl-cat2
    pdstack-pd3-snk-lite
    capsense
  DESIGN_EZPD
    ${APP_DIR}/USBPD_CONFIG/TARGET_${BSP_NAME}/design.mtbezpd
)
