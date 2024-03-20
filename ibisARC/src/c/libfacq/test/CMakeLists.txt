# if (CMAKE_CROSSCOMPILING)
#   message(STATUS "Skipping unit tests, cross compiling")
# else (CMAKE_CROSSCOMPILING)
# 
#   find_package(Check)
#   if (NOT CHECK_FOUND)
#     message(STATUS "Skipping unit tests, Check library not found!")
#   else (NOT CHECK_FOUND)
# 
#     include_directories(${CHECK_INCLUDE_DIRS})
#     set(TEST_LIBS ${TEST_LIBS} ${CHECK_LIBRARIES} pthread m pipeprot-static nvsbinrparser-static yaml-static gennav-static)
# 
#     # Check needs to be linked against Librt on Linux
#     if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
#       set(TEST_LIBS ${TEST_LIBS} rt)
#     endif(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
# 
#     include_directories("${PROJECT_SOURCE_DIR}/include")
#     include_directories("${PROJECT_SOURCE_DIR}/../libpipeprot/libnvsbinrparser/c/include")
#     include_directories("${PROJECT_SOURCE_DIR}/../libpipeprot/libsrnsparser/c/include")
#     include_directories("${PROJECT_SOURCE_DIR}/../libyaml/include")
#     message(STATUS "PROJECT_SOURCE_DIR = " ${PROJECT_SOURCE_DIR})
# 
#     FILE(GLOB generated_c_sources auto*.c)
# 
#     add_executable(test_gennav
#       check_main.cpp
#       check_symbolsync.cpp
#       check_confyaml.cpp
#       check_replica.cpp
#     )
# 
#     target_link_libraries(test_gennav ${TEST_LIBS})
#     add_custom_command(
#       TARGET test_gennav POST_BUILD
#       COMMENT "Running unit tests"
#       COMMAND test_gennav
#     )
# 
#   endif (NOT CHECK_FOUND)
# endif (CMAKE_CROSSCOMPILING)
