`ifndef AXI_UART_SVH
`define AXI_UART_SVH

`include "macro.svh"

typedef struct packed {
    logic [31:8]  RESERVED;
    logic [7:0]   DATA;
} AXI_UART_RxFIFO;

typedef struct packed {
    logic [31:8]  RESERVED;
    logic [7:0]   DATA;
} AXI_UART_TxFIFO;

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
} AXI_UART_STAT;

typedef struct packed {
    logic [31:5]  RESERVED_2;
    logic         EN_INTR;
    logic [3:2]   RESERVED_1;
    logic         RST_RxFIFO;
    logic         RST_TxFIFO;
} AXI_UART_CTRL;

typedef struct packed {
    AXI_UART_RxFIFO  RxFIFO; // RO
    AXI_UART_TxFIFO  TxFIFO; // WO
    AXI_UART_STAT    STAT;   // RO
    AXI_UART_CTRL    CTRL;   // WO
} AXI_UART_STRUCT;

`define AXI_UART_ID_CONST  (16'hC1FA)
`define AXI_UART_SIZE      (`size32(AXI_UART_STRUCT))
`define AXI_UART_FULL_SIZE (`AXI_UART_SIZE + \
                            `RWREGSSIZE)

`endif