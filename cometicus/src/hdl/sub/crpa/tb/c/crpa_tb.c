#define BASE_ADDR           0x40000000

#include <stdio.h>
#include <stdlib.h>
#include <svdpi.h>
#include <math.h>
#include "ID_DB.h"
#include "axi_rw.h"

#define CRPA_OFFSET 1
#define CVM_HUB_OFFSET  CRPA_OFFSET + 3
#define CVM_OFFSET      CVM_HUB_OFFSET + 1

#define CVM_CONST_EN 0

double rms(double *v, int n);
double mean(double *v, int n);

int cpu_sim() {
    
    volatile unsigned int* pBASE = BASE_ADDR;
    unsigned int i,j,k;
    unsigned int CRPA_NCH;
    unsigned int rc;
    unsigned int addr;
    
    int64_t val;
    uint32_t shift;
    int64_t cvm[8][8]; // cvm[A][B]
    double cvmD[8][8]; // cvm[A][B]
    // double cvmD_non_diag[7*8]; // cvm[A][B]
    double max_cvm;
    double sum_abs_cvm;
    
    unsigned int CVM_RAM_OFFSET;
    unsigned int NULL_OFFSET;
    unsigned int FIR_OFFSET[8];
    int coeff[8][2];
    
    coeff[0][0] = 3307  ;
    coeff[0][1] = -1741 ;
    coeff[1][0] = -1932 ;
    coeff[1][1] = 2463  ;
    coeff[2][0] = -4352 ;
    coeff[2][1] = 3591  ;
    coeff[3][0] = 1212  ;
    coeff[3][1] = -908  ;
    coeff[4][0] = -7772 ;
    coeff[4][1] = 7655  ;
    coeff[5][0] = -1137 ;
    coeff[5][1] = 869   ;
    coeff[6][0] = 7588  ;
    coeff[6][1] = -8191 ;
    coeff[7][0] = -5221 ;
    coeff[7][1] = 5427  ;
    
    printf("Hello from cpu_sim!\n");
    printf("crpa_tb\n");
    
    printf("HUB                   = 0x%08X\n",*axi_read(pBASE, 0, 0));
    printf("CRPA size_ID          = 0x%08X\n",*axi_read(pBASE, CRPA_OFFSET, 0));
    printf("CRPA CRPA_ACCUM_WIDTH = %d\n",((*axi_read(pBASE, CRPA_OFFSET + 1, 0)) >> 0 ) & 0x3F);
    printf("CRPA CRPA_NNF         = %d\n",((*axi_read(pBASE, CRPA_OFFSET + 1, 0)) >> 6 ) & 0x1F);
    printf("CRPA CRPA_NT          = %d\n",((*axi_read(pBASE, CRPA_OFFSET + 1, 0)) >> 11) & 0xF);
    CRPA_NCH = ((*axi_read(pBASE, CRPA_OFFSET + 1, 0)) >> 15) & 0x1F;
    printf("CRPA CRPA_NCH         = %d\n",CRPA_NCH);
    printf("CRPA CRPA_C_WIDTH     = %d\n",((*axi_read(pBASE, CRPA_OFFSET + 1, 0)) >> 20) & 0x1F);
    printf("CRPA CRPA_D_WIDTH     = %d\n",((*axi_read(pBASE, CRPA_OFFSET + 1, 0)) >> 25) & 0x1F);
    printf("CRPA Q_ENABLE         = %d\n",((*axi_read(pBASE, CRPA_OFFSET + 1, 0)) >> 30) & 0x1);
    
    printf("CVM HUB               = 0x%08X\n",*axi_read(pBASE, CVM_HUB_OFFSET, 0));
    rc = *axi_read(pBASE, CVM_OFFSET, 0);
    printf("CVM CVM size_ID       = 0x%08X\n",rc);
    
    CVM_RAM_OFFSET = CVM_OFFSET + (rc >> 16);
    printf("CVM_RAM size_ID       = 0x%08X\n",*axi_read(pBASE, CVM_RAM_OFFSET, 0));
    rc = *axi_read(pBASE, CVM_RAM_OFFSET + 1, 0);
    printf("CVM_RAM RAM_SIZE      = %d\n",(rc >> 2) & 0xF);
    printf("CVM_RAM RAM_BLOCKS    = %d\n",(rc >> 6) & 0x1FFF);
    
    NULL_OFFSET = CVM_RAM_OFFSET + (*axi_read(pBASE, CVM_RAM_OFFSET, 0) >> 16);
    printf("NULL HUB              = 0x%08X\n",*axi_read(pBASE, NULL_OFFSET, 0));
    
    axi_write(pBASE, CVM_OFFSET + 1 /* CFG */
                                + 1 /* DATA */
                                + 128, 0x1111); // CONST I
    axi_write(pBASE, CVM_OFFSET + 1 /* CFG */
                                + 1 /* DATA */
                                + 128 + 1, 0x1111); // CONST Q
    
    for(i = 0; i < 8; i ++){
            FIR_OFFSET[i] = NULL_OFFSET + 1 + 3*i;
            printf("FIR[%d] [addr=0x%08X] size_ID      = 0x%08X\n",i,FIR_OFFSET[i],*axi_read(pBASE, FIR_OFFSET[i], 0));
    }
    
    
    while(1){
        break;
        axi_write(pBASE, CVM_OFFSET + 1, CVM_CONST_EN << 27); // CONST_EN
        
        axi_write(pBASE, CVM_RAM_OFFSET + 1,  1 | 
                                             9 << 19); // write to RAM
        printf("CVM_RAM W_BLOCKS      = %d\n",((*axi_read(pBASE, CVM_RAM_OFFSET + 1, 0)) >> 19) & 0x1FFF);
        waitClks(50);
        
        while(!(((*axi_read(pBASE, CVM_RAM_OFFSET + 1, 0)) >> 1) & 0x1)){ // is RAM complete
            // printf("CVM RAM not complete\n");
            waitClks(50);
        }
        printf("CVM RAM complete\n");
        
        for(j=0; j < 8; j++){
            axi_write(pBASE, CVM_RAM_OFFSET + 2, 1<<5 | j); // soft reset | chan
            waitClks(20);
            for(i=0; i < 64; i++){
                // printf("COV_RAM[%d][%d] = %d\n",i,j,*axi_read(pBASE, CVM_RAM_OFFSET + 3, 0));
                waitClks(20);
            }
            axi_write(pBASE, CVM_RAM_OFFSET + 2, 0); // soft reset | chan
        }
        
        axi_write(pBASE, CVM_OFFSET + 1,    1 | 
                                            5000 << 2 | // macc length
                                            0 << 19 | /* TA */
                                            0 << 23); /* TB */
        waitClks(50);
        
        while(!(((*axi_read(pBASE, CVM_OFFSET + 1, 0)) >> 1) & 0x1)){
            // printf("CVM not complete\n");
            waitClks(50);
        }
        
        printf("CVM complete\n");
        
        max_cvm = 0;
        k = 0;
        sum_abs_cvm = 0;
        for(i=0;i<CRPA_NCH;i++){
            for(j=0;j<CRPA_NCH;j++){
                    addr = i*2 + j*CRPA_NCH*2;
                    val = *axi_read(pBASE, CVM_OFFSET + 2 + addr, 0);
                    val = val << 32;
                    val = val | (*axi_read(pBASE, CVM_OFFSET + 2 + addr + 1, 0));// low
                    cvm[i][j] = val;
                    cvmD[i][j] = (double)cvm[i][j];
                    if(i != j){
                        // cvmD_non_diag[k++] = cvmD[i][j];
                        sum_abs_cvm += fabs(cvmD[i][j]);
                        k++;
                    }
                    max_cvm = (fabs(cvmD[i][j]) > max_cvm) ? fabs(cvmD[i][j]) : max_cvm;
            }
        }
        // mean_abs_cvm = mean(cvmD_non_diag, sizeof(cvmD_non_diag)/sizeof(double)) / max_cvm;
        
        for(i=0;i<CRPA_NCH;i++){
            printf("A = %2d | ",i);
            for(j=0;j<CRPA_NCH;j++){
                    // printf("%8.3f ",cvmD[i][j]/max_cvm);
                    printf("%15lld ",cvm[i][j]);
            }
            printf("\n");
        }
        printf("mean_abs_cvm (non_diag) = %f\n",sum_abs_cvm/k/max_cvm);
    }
    
    printf("Write to FIR\n");
    for(i = 0; i < 8; i ++){
        for(j = 0; j < 2; j ++){
            axi_write(pBASE, FIR_OFFSET[i] + 2,    (0x3FFF & coeff[i][j]) | 
                                                   j << 14 |
                                                   1 << 31
            );
            waitClks(50);
        }
    }
    
    axi_write(pBASE, CRPA_OFFSET + 2, 14); // NULL_DIV
    axi_write(pBASE, CRPA_OFFSET + 1, 1 << 31); // NULL_COEF_MIRR
    
    printf("The END\n");
    return 0;
}

double rms(double *v, int n)
{
  int i;
  double sum = 0.0;
  for(i = 0; i < n; i++)
    sum += v[i] * v[i];
  return sqrt(sum / n);
}


double mean(double *v, int n)
{
    double sum=0.0;
    int i;
    for(i=0; i<n; i++)
        sum += v[i];
    return (double)(sum / n);
}