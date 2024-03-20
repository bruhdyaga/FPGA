#ifndef ACQ_API_H
#define ACQ_API_H

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <unistd.h>
#include <getBlockPtr.h>
extern "C" {
    #include <libfacq/facq.h>
    #include <libfacq/axi_rw.h>
    #include <libfacq/signal_types.h>
}

int get_por(struct facq_data * dfacq);

#endif