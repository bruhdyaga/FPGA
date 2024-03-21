interface arm_interface;

logic [14:0]DDR_addr;
logic [2:0]DDR_ba;
logic DDR_cas_n;
logic DDR_ck_n;
logic DDR_ck_p;
logic DDR_cke;
logic DDR_cs_n;
logic [3:0]DDR_dm;
logic [31:0]DDR_dq;
logic [3:0]DDR_dqs_n;
logic [3:0]DDR_dqs_p;
logic DDR_odt;
logic DDR_ras_n;
logic DDR_reset_n;
logic DDR_we_n;
logic FIXED_IO_ddr_vrn;
logic FIXED_IO_ddr_vrp;
logic [53:0]FIXED_IO_mio;
logic FIXED_IO_ps_clk;
logic FIXED_IO_ps_porb;
logic FIXED_IO_ps_srstb;

modport master
(
    inout DDR_addr          ,
    inout DDR_ba            ,
    inout DDR_cas_n         ,
    inout DDR_ck_n          ,
    inout DDR_ck_p          ,
    inout DDR_cke           ,
    inout DDR_cs_n          ,
    inout DDR_dm            ,
    inout DDR_dq            ,
    inout DDR_dqs_n         ,
    inout DDR_dqs_p         ,
    inout DDR_odt           ,
    inout DDR_ras_n         ,
    inout DDR_reset_n       ,
    inout DDR_we_n          ,
    inout FIXED_IO_ddr_vrn  ,
    inout FIXED_IO_ddr_vrp  ,
    inout FIXED_IO_mio      ,
    inout FIXED_IO_ps_clk   ,
    inout FIXED_IO_ps_porb  ,
    inout FIXED_IO_ps_srstb
);

endinterface