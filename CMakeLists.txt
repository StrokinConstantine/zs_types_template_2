cmake_minimum_required(VERSION 3.20)

project(zs_types_template_2 LANGUAGES CXX)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

if(NOT TARGET ZserioCppRuntime)
    add_subdirectory($ENV{ZSERIO_CPP_RUNTIME} ZserioCppRuntime)
endif()

find_package(Java REQUIRED)

add_library(${PROJECT_NAME} SHARED)

include(cmake/generate_cpp.cmake)

target_include_directories(${PROJECT_NAME} PUBLIC ${ZSERIO_GENERATED_CPP_FILES_PATH})

target_link_libraries(${PROJECT_NAME} PUBLIC ZserioCppRuntime)