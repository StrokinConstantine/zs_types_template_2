include("$ENV{ZSERIO_CPP_RUNTIME}/../../cmake/zserio_compiler.cmake")

set(ZSERIO_JAR_FILE $ENV{ZSERIO_JAR})

set(ZSERIO_GENERATED_CPP_FILES_PATH ${CMAKE_CURRENT_BINARY_DIR}/include)

zserio_generate_cpp(
    TARGET ${PROJECT_NAME}
    MAIN_ZS "euroradio_asc/subset_026/messages.zs"
    GEN_DIR ${ZSERIO_GENERATED_CPP_FILES_PATH}
    GENERATED_SOURCES_VAR ZSERIO_GENERATED_SOURCES
)

message(STATUS "Generated C++ files: ${ZSERIO_GENERATED_SOURCES}")