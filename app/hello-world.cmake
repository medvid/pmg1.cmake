project(hello-world)

# This application provides custom design.modus for the below boards
pmg1_check_bsp(
  CYPM1322-97BZXIT
  PMG1-CY7110
  PMG1-CY7111
  PMG1-CY7112
  PMG1-CY7113
)

pmg1_load_application(
  NAME mtb-example-pmg1-hello-world
  VERSION 1.0.0
)
pmg1_add_executable(
  SOURCES
    ${APP_DIR}/main.c
  DESIGN_MODUS
    ${APP_DIR}/COMPONENT_CUSTOM_DESIGN_MODUS/TARGET_${BSP_NAME}/design.modus
)
