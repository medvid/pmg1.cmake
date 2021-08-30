project(hello-world)

pmg1_load_application(
  NAME mtb-example-pmg1-hello-world
  VERSION 2.0.0
)
pmg1_add_executable(
  SOURCES
    ${APP_DIR}/main.c
)
