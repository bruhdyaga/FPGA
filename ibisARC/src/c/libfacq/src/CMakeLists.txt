if (NOT DEFINED BUILD_SHARED_LIBS)
  set(BUILD_SHARED_LIBS OFF)
endif (NOT DEFINED BUILD_SHARED_LIBS)

set(LIBNAME facq)
#file(GLOB lib_SRCS "${PROJECT_SOURCE_DIR}/src/*.cpp")
set(lib_SRCS
  axi_rw.c
  facq.c
  psp_init_functions.c
  service_func.c
  fsm.c
)

add_library(${LIBNAME}-static STATIC ${lib_SRCS})
# target_link_libraries(${LIBNAME}-static pipeprot-static srnsparser-static nvsbinrparser-static yaml-static prncodes-static)
target_include_directories(${LIBNAME}-static PUBLIC ${PROJECT_SOURCE_DIR}/include)

if(BUILD_SHARED_LIBS)
  add_library(${LIBNAME} SHARED ${lib_SRCS}) 
  # target_link_libraries(${LIBNAME} pipeprot-static srnsparser-static nvsbinrparser-static yaml-static prncodes-static)
  target_include_directories(${LIBNAME} PUBLIC ${PROJECT_SOURCE_DIR}/include)
  install(TARGETS ${LIBNAME} DESTINATION lib${LIB_SUFFIX})
else(BUILD_SHARED_LIBS)
  # message(STATUS "Not building shared libraries")
endif(BUILD_SHARED_LIBS)