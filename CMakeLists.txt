cmake_minimum_required(VERSION 3.20)

set(ZSERIO_TYPES_PROJECT_NAME "zs_types_template_2")
set(ZSERIO_TYPES_INCLUDE_PATH "zs_types_template_2")

project(${ZSERIO_TYPES_PROJECT_NAME} LANGUAGES CXX)

#set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/zserio")
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(ZSERIO_CPP_RUNTIME $ENV{ZSERIO_CPP_RUNTIME})
set(ZSERIO_JAR $ENV{ZSERIO_JAR})


if(NOT TARGET ZserioCppRuntime)
    add_subdirectory($ENV{ZSERIO_CPP_RUNTIME} ZserioCppRuntime)
endif()


find_package(Java REQUIRED)

add_library(zs_types_template_2 SHARED )

include(cmake/generate_cpp.cmake)

target_include_directories(zs_types_template_2 PUBLIC 
   # ${zserio_types_cpp_include}
    ${zserio_types_cpp_genpath}
    #${ZSERIO_RUNTIME_DIR}/include
)

target_link_libraries( zs_types_template_2
PRIVATE ZserioCppRuntime
)



#unset(ZSERIO_TYPES_PROJECT_NAME CACHE)
#unset(ZSERIO_TYPES_INCLUDE_PATH CACHE)