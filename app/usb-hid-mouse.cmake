# https://github.com/Infineon/mtb-example-pmg1-usb-hid-mouse/tree/master/USB_DEVICE_CONFIG
pmg1_check_bsp(
  PMG1-CY7112
  PMG1-CY7113
)

project(usb-hid-mouse)

pmg1_load_application(
  NAME mtb-example-pmg1-usb-hid-mouse
  VERSION 1.0.0
)
pmg1_add_executable(
  SOURCES
    ${APP_DIR}/main.c
  LINK_LIBRARIES
    mtb-hal-cat2
    usbdev
  DESIGN_USBDEV
    ${APP_DIR}/USB_DEVICE_CONFIG/TARGET_${BSP_NAME}/design.cyusbdev
)
