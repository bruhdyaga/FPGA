#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <poll.h>
#include <sys/mman.h>
#include <time.h>

void * getBlockPtr(unsigned int addr, unsigned int size, unsigned int *offset);
uint32_t reg32Xor(uint32_t reg32);


//#define HW_BASE_ADDR 0x4000017C
volatile unsigned int* pIP_CORE;// Указатель на область виртуальной памяти, куда мапится HW_BASE_ADDR

int main(int argc, char **argv) {

    if (argc < (1+5)) {
        printf("Wrong args, example ./vitdec_test <base addr> <num of msg bits> <mode> <initial encoder state> <delta func test>\n");
        return -1;
    }

    uint32_t msgBits = 512;
    uint32_t mode = 0;
    uint32_t reg = 0; // initial encoder state
    uint32_t HW_BASE_ADDR = 0;

    bool delta = false;
    uint32_t tmp = 0;

    sscanf(argv[1], "%x", &HW_BASE_ADDR);
    sscanf(argv[2], "%d", &msgBits);
    sscanf(argv[3], "%d", &mode);
    sscanf(argv[4], "%x", &reg);
    sscanf(argv[5], "%d", &tmp);
    if (tmp != 0) {
        delta = true;
    }

    printf("Test params: base_addr=0x%08X len=%d, mode=%d, state=0x%02X delta=%d\n",HW_BASE_ADDR, msgBits, mode, reg, delta);


    // mapping memory
    unsigned int offset;
    unsigned int IP_CORE_SIZE = (1+1+32+16)*4;
    unsigned int *pPAGE_IP_CORE_BASE = (unsigned int*)getBlockPtr(HW_BASE_ADDR, IP_CORE_SIZE, &offset);
    unsigned int *pIP_CORE_BASE = pPAGE_IP_CORE_BASE + offset;
    pIP_CORE = (volatile unsigned int*)(pIP_CORE_BASE);

    volatile uint32_t * cfg = pIP_CORE+1;
    volatile uint32_t * dataIn = pIP_CORE+2;
    volatile uint32_t * dataOut = pIP_CORE+34;

    uint32_t OUT_BITMASK1 = 0x6D;//133
    uint32_t OUT_BITMASK2 = 0x4F;//171
    uint32_t bit0 = 0;
    uint32_t bit1 = 0;
    
    uint32_t bitsPerUint = 32;

    if (mode == 0) {
        OUT_BITMASK1 = 0x6D;//133
        OUT_BITMASK2 = 0x4F;//171
    } else if (mode == 1) {
        OUT_BITMASK1 = 0x4F;//171
        OUT_BITMASK2 = 0x6D;//133
    } else if (mode == 2) {
        OUT_BITMASK1 = 0x6D;//133
        OUT_BITMASK2 = 0x4F;//171
    }

    uint32_t msgEncBits = msgBits*2;

    uint8_t numOfWordsEnc = msgEncBits / bitsPerUint; // num of full words
    uint8_t numOfBitsEnc  = msgEncBits % bitsPerUint; // num of bits in last word
    
    uint8_t numOfWords = msgBits / bitsPerUint; // num of full words
    uint8_t numOfBits  = msgBits % bitsPerUint; // num of bits in last word
    
    uint32_t sizeInWord = msgEncBits/bitsPerUint;
    uint32_t sizeOutWord = msgBits/bitsPerUint;

    if(numOfBits != 0){
        sizeOutWord += 1;
    }
    
    if(numOfBitsEnc != 0){
        sizeInWord += 1;
    }
    
    uint32_t msg[sizeOutWord];
    uint32_t msgEnc[sizeInWord];
    uint32_t msgDec[sizeOutWord];

    srand(time(NULL));   // Initialization, should only be called once.

    if (delta) {
        for (uint32_t i=0; i<sizeOutWord; i++) {
            if(i==0){
                msg[i] = 0x1;
            } else {
                msg[i] = 0;
            }
            msgDec[i] = 0;
        }
    } else {
        for (uint32_t i=0; i<sizeOutWord; i++) {
            msg[i] = rand();
            msgDec[i] = 0;
        }
    }

    for (uint32_t i=0; i<sizeInWord; i++) {
        msgEnc[i] = 0;
    }

    // encoding
    uint32_t wi,bi,wo,bo,outBitCntr,nextMsgBit;
    outBitCntr = 0;
    for(uint32_t i=0; i<msgBits; i++) {
        wi = i/bitsPerUint;
        bi = i%bitsPerUint;

        nextMsgBit = (msg[wi]>>bi) & 0x1;

        reg <<= 1;
        reg = (reg&0xFFFFFFFE) | nextMsgBit;
        bit0 = reg32Xor(OUT_BITMASK2 & reg);
        bit1 = reg32Xor(OUT_BITMASK1 & reg);

        if (mode == 2) {
            bit1 = (~bit1) & 0x1;
        }

        wo = outBitCntr/bitsPerUint;
        bo = outBitCntr%bitsPerUint;
        msgEnc[wo] = msgEnc[wo] | (bit0<<bo);
        outBitCntr++;
        wo = outBitCntr/bitsPerUint;
        bo = outBitCntr%bitsPerUint;
        msgEnc[wo] = msgEnc[wo] | (bit1<<bo);
        outBitCntr++;
    }


    printf("Msg:      ");
    for (uint32_t i=0; i<sizeOutWord; i++) {
        printf(" 0x%08X",msg[i]);
    }
    printf("\n");

    printf("encMsg:   ");
    for (uint32_t i=0; i<sizeInWord; i++) {
        printf(" 0x%08X",msgEnc[i]);
    }
    printf("\n");

    printf("Write data to decoder\n");
    for (uint32_t i=0; i<sizeInWord; i++) {
        dataIn[i] = msgEnc[i];
    }
    
    uint8_t bits2use = 0;
    
    if (numOfBitsEnc != 0) {
        bits2use = numOfBitsEnc/2 - 1;
    } else {
        bits2use = bitsPerUint/2 - 1;
    }

    printf("Run decoding\n");
    uint32_t CFG = 0;
    CFG = (bits2use<<14) | (mode<<12) | ((sizeInWord-1)<<2) | 1;
    *cfg = CFG;

    usleep(10);

    printf("Wait for done...\n");
    bool done = (((*cfg)>>1)&0x1) == 1;
    while( !done ) {
        usleep(100);
        done = (((*cfg)>>1)&0x1) == 1;
    }
    printf("Done!\n");

    printf("Read data from decoder\n");
    for (uint32_t i=0; i<sizeInWord; i++) {
        msgDec[i] = dataOut[i];
    }

    printf("Msg:      ");
    for (uint32_t i=0; i<sizeOutWord; i++) {
        printf(" 0x%08X",msg[i]);
    }
    printf("\n");

    printf("MsgDec:   ");
    for (uint32_t i=0; i<sizeOutWord; i++) {
        printf(" 0x%08X",msgDec[i]);
    }
    printf("\n");

    printf("Err:      ");
    for (uint32_t i=0; i<sizeOutWord; i++) {
        printf(" 0x%08X",msgDec[i] ^ msg[i]);
    }
    printf("\n");

    return 0;
}

uint32_t reg32Xor(uint32_t reg32) {
    uint32_t x1 = reg32&0xFFFF;
    uint32_t x2 = (reg32>>16)&0xFFFF;

    reg32 = x1^x2; // 16 bits

    x1 = reg32;
    x2 = (reg32>>8);

    reg32 = x1^x2; // 8 bits

    x1 = reg32;
    x2 = (reg32>>4);

    reg32 = x1^x2; // 4 bits

    x1 = reg32;
    x2 = (reg32>>2);

    reg32 = x1^x2; // 2 bits

    if ((((reg32>>1)^(reg32)) & 0x1) == 0x1) {
        return 1;
    } else {
        return 0;
    }
}

void * getBlockPtr(unsigned int addr, unsigned int size, unsigned int *offset) {

    int fid;
    /* открываем /dev/mem */
    if ((fid = open("/dev/mem", O_RDWR|O_SYNC) ) < 0) {  //O_SYNC makes the memory uncacheable
        printf("getBlockPtr: can't open /dev/mem \n");
        exit(-1);
    }

    int page = getpagesize();
    unsigned int new_size;

    unsigned int new_addr = (addr / page) * page;  // Округление адреса вниз до размера страницы

    *offset = addr - new_addr;
    new_size = size + *offset;
    *offset /= 4;

    unsigned int tail = new_size % page;
    if (tail > 0)
        new_size = new_size + (page - tail);
    else
        new_size = new_size;

    volatile unsigned char *ptr = (unsigned char*) mmap(NULL, new_size, PROT_READ|PROT_WRITE, MAP_SHARED, fid, new_addr);

    close(fid); //закрываем fd после mmap

    if (ptr == MAP_FAILED) {
        printf("getBlockPtr: MAP_FAILED\n");
        exit(-1);
    }
    return (void*)ptr;

}

