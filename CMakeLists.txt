set(app_name    "sample")
set(app_version "1.0.0")

cmake_minimum_required(VERSION 3.10.2)
project(${app_name})

set(RCAR_SOC S4)

set(source
	sample.cpp
)

set(header
)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DDEBUG_PRINT_ENABLED -DLINUX_TEST_APP")

add_executable(${app_name})
target_sources(${app_name} PRIVATE ${source})

install(TARGETS ${app_name} DESTINATION bin)

