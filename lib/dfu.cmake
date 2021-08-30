pmg1_load_library(
  NAME dfu
  VERSION 4.20.0
)

set(DFU_SOURCES
  ${DFU_DIR}/cy_dfu.h
  ${DFU_DIR}/cy_dfu.c
)
set(DFU_INCLUDE_DIRS
  ${DFU_DIR}
)
set(DFU_LINK_LIBRARIES
  mtb-pdl-cat2
)

set(DFU_I2C_SOURCES
  ${DFU_DIR}/config/CAT2/transport_i2c.h
  ${DFU_DIR}/config/CAT2/transport_i2c.c
)
set(DFU_I2C_INCLUDE_DIRS
  ${DFU_DIR}/config/CAT2
)
set(DFU_I2C_LINK_LIBRARIES
  dfu
)

set(DFU_SPI_SOURCES
  ${DFU_DIR}/config/CAT2/transport_spi.h
  ${DFU_DIR}/config/CAT2/transport_spi.c
)
set(DFU_SPI_INCLUDE_DIRS
  ${DFU_DIR}/config/CAT2
)
set(DFU_SPI_LINK_LIBRARIES
  dfu
)

set(DFU_UART_SOURCES
  ${DFU_DIR}/config/CAT2/transport_uart.h
  ${DFU_DIR}/config/CAT2/transport_uart.c
)
set(DFU_UART_INCLUDE_DIRS
  ${DFU_DIR}/config/CAT2
)
set(DFU_UART_LINK_LIBRARIES
  dfu
)

set(DFU_USB_CDC_SOURCES
  ${DFU_DIR}/config/CAT2/transport_usb_cdc.h
  ${DFU_DIR}/config/CAT2/transport_usb_cdc.c
)
set(DFU_USB_CDC_INCLUDE_DIRS
  ${DFU_DIR}/config/CAT2
)
set(DFU_USB_CDC_LINK_LIBRARIES
  dfu
  usbdev
)

# cy_dfu.c includes application-specific dfu_user.h, cannot be compiled as STATIC
add_library(dfu INTERFACE EXCLUDE_FROM_ALL)
target_sources(dfu INTERFACE ${DFU_SOURCES})
target_include_directories(dfu INTERFACE ${DFU_INCLUDE_DIRS})
target_link_libraries(dfu INTERFACE ${DFU_LINK_LIBRARIES})

add_library(dfu-i2c INTERFACE EXCLUDE_FROM_ALL)
target_sources(dfu-i2c INTERFACE ${DFU_I2C_SOURCES})
target_include_directories(dfu-i2c INTERFACE ${DFU_I2C_INCLUDE_DIRS})
target_link_libraries(dfu-i2c INTERFACE ${DFU_I2C_LINK_LIBRARIES})

add_library(dfu-spi INTERFACE EXCLUDE_FROM_ALL)
target_sources(dfu-spi INTERFACE ${DFU_SPI_SOURCES})
target_include_directories(dfu-spi INTERFACE ${DFU_SPI_INCLUDE_DIRS})
target_link_libraries(dfu-spi INTERFACE ${DFU_SPI_LINK_LIBRARIES})

add_library(dfu-uart INTERFACE EXCLUDE_FROM_ALL)
target_sources(dfu-uart INTERFACE ${DFU_UART_SOURCES})
target_include_directories(dfu-uart INTERFACE ${DFU_UART_INCLUDE_DIRS})
target_link_libraries(dfu-uart INTERFACE ${DFU_UART_LINK_LIBRARIES})

add_library(dfu-usb-cdc INTERFACE EXCLUDE_FROM_ALL)
target_sources(dfu-usb-cdc INTERFACE ${DFU_USB_CDC_SOURCES})
target_include_directories(dfu-usb-cdc INTERFACE ${DFU_USB_CDC_INCLUDE_DIRS})
target_link_libraries(dfu-usb-cdc INTERFACE ${DFU_USB_CDC_LINK_LIBRARIES})
