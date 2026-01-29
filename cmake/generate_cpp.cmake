# Set up paths for generated files
set(zserio_types_cpp_include ${CMAKE_CURRENT_BINARY_DIR}/include)
set(zserio_types_cpp_genpath ${zserio_types_cpp_include}/${ZSERIO_TYPES_INCLUDE_PATH})
#file(MAKE_DIRECTORY ${zserio_types_cpp_genpath})

include("$ENV{ZSERIO_CPP_RUNTIME}/../../cmake/zserio_compiler.cmake")

set(ZSERIO_JAR_FILE $ENV{ZSERIO_JAR})

zserio_generate_cpp(
    TARGET ${PROJECT_NAME}
    MAIN_ZS "euroradio_asc/subset_026/messages.zs"
    GEN_DIR ${zserio_types_cpp_genpath}
    GENERATED_SOURCES_VAR ZSERIO_GENERATED_SOURCES
)

message(STATUS "Generated C++ files: ${ZSERIO_GENERATED_SOURCES}")