`ifndef AXI_UARTLITE_SPI_SVH
`define AXI_UARTLITE_SPI_SVH

`include "macro.svh"

typedef struct packed {
    logic [31:8]  RESERVED;
    logic [7:0]   DATA;
} AXI_UARTLITE_SPI_RxFIFO;

typedef struct packed {
    logic [31:8]  RESERVED;
    logic [7:0]   DATA;
} AXI_UARTLITE_SPI_TxFIFO;

typedef struct packed {
    logic [31:8]  RESERVED;
    logic         PAR_ERR;
    logic         FRM_ERR;
    logic         OVER_ERR;
    logic         INTR_EN;
    logic         TxFIFO_FULL;
    logic         TxFIFO_EMPTY;
    logic         RxFIFO_FULL;
    logic         RxFIFO_VALID;
} AXI_UARTLITE_SPI_STAT;

typedef struct packed {
    logic [31:5]  RESERVED_2;
    logic         EN_INTR;
    logic [3:2]   RESERVED_1;
    logic         RST_RxFIFO;
    logic         RST_TxFIFO;
} AXI_UARTLITE_SPI_CTRL;

typedef struct packed {
    AXI_UARTLITE_SPI_RxFIFO  RxFIFO; // RO
    AXI_UARTLITE_SPI_TxFIFO  TxFIFO; // WO
    AXI_UARTLITE_SPI_STAT    STAT;   // RO
    AXI_UARTLITE_SPI_CTRL    CTRL;   // WO
} AXI_UARTLITE_SPI_STRUCT;

`define AXI_UARTLITE_SPI_ID_CONST  (16'hADC0)
`define AXI_UARTLITE_SPI_SIZE      (`size32(AXI_UARTLITE_SPI_STRUCT))
`define AXI_UARTLITE_SPI_FULL_SIZE (`AXI_UARTLITE_SPI_SIZE + \
                                    `RWREGSSIZE)

`endif