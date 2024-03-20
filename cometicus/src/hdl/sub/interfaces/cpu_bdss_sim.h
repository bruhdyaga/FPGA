// не ясно, нужен ли этот файл

/* MTI_DPI */

/*
 * Copyright 2002-2015 Mentor Graphics Corporation.
 *
 * Note:
 *   This file is automatically generated.
 *   Please do not edit this file - you will lose your edits.
 *
 * Settings when this file was generated:
 *   PLATFORM = 'win64'
 */
#ifndef CPU_BDSS_SIM_H
#define CPU_BDSS_SIM_H

#ifdef __cplusplus
#define DPI_LINK_DECL  extern "C" 
#else
#define DPI_LINK_DECL 
#endif

#include "svdpi.h"



DPI_LINK_DECL DPI_DLLESPEC
int
cpu_sim();

DPI_LINK_DECL int
readReg(
    int base,
    int offset,
    int burst_len,
    int* rdata,
    int* stime);

DPI_LINK_DECL void
waitClks(
    int numclks);

DPI_LINK_DECL int
writeReg(
    int base,
    int offset,
    int burst_len,
    const int* val,
    int* stime);

DPI_LINK_DECL int
APBreadReg(
    int base,
    int offset,
    int burst_len,
    int* rdata,
    int* stime);

DPI_LINK_DECL int
APBwriteReg(
    int base,
    int offset,
    int burst_len,
    const int* val,
    int* stime);

#endif