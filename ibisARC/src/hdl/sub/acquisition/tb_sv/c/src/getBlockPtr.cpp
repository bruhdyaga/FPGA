#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <poll.h>
#include <sys/mman.h>

void * getBlockPtr(unsigned int addr, unsigned int size, unsigned int *offset);


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
    
    *offset /= 4; // Это верно!

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

