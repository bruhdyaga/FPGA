 
INCLUDEPATH  += $$PWD/include
QMAKE_LIBDIR +=	$$PWD/src
LIBS         += -lfacq

SOURCES += \
    $$PWD/src/axi_rw.c \
    $$PWD/src/facq.c \
    $$PWD/src/psp_init_functions.c \
    $$PWD/src/service_func.c \
    $$PWD/src/fsm.c
    
HEADERS += \
    $$PWD/include/libfacq/axi_rw.h \
    $$PWD/include/libfacq/facq.h \
    $$PWD/include/libfacq/ID_DB.h \
    $$PWD/include/libfacq/psp_init_functions.h \
    $$PWD/include/libfacq/signal_types.h \
    $$PWD/include/libfacq/service_func.h \
    $$PWD/include/libfacq/fsm.h \
    $$PWD/include/libfacq/fsm_targets.h \
    $$PWD/src/global.h
    
DISTFILES += \
    $$PWD/test/CMakeLists.txt \
    $$PWD/src/CMakeLists.txt
