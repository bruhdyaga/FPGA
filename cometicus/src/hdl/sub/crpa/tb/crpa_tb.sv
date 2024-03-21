`timescale 1ns/10ps

`define pclk 105.6  // MHz
`define aclk 100    // MHz

`include "crpa.svh"

module crpa_tb();

localparam BASEADDR    = 32'h40000000/4;

reg pclk = 1;
reg aclk = 1;
reg aresetn = 1;

always #((1000/`pclk)/2) pclk <= !pclk;
always #((1000/`aclk)/2) aclk <= !aclk;

localparam RAM_DEPTH = 2**16;
reg [`CRPA_NCH*`CRPA_D_WIDTH-1:0] inp_ram [RAM_DEPTH-1:0];
reg [15:0] ram_cntr;

// ADC interface
adc_interf#(
    .PORTS (`CRPA_NCH),
    .R     (`CRPA_D_WIDTH)
)data_in [`CRPA_NUMB]();

adc_interf#(
    .PORTS (1),
    .R     (2)
)data_out [`CRPA_NUMB]();

adc_interf#(
    .PORTS (1),
    .R     (`CRPA_D_WIDTH)
)data_out_full [`CRPA_NUMB]();

axi3_interface axi3();
intbus_interf  bus();

cpu_sim cpu_sim_inst(
    .aclk   (aclk),
    .resetn (aresetn),
    .axi3   (axi3)
);

axi3_to_inter axi3_to_inter_inst(
    .axi3    (axi3),
    .int_bus (bus)
);

initial begin
    @ (negedge aclk)
      aresetn = 0;
    @ (negedge aclk)
    @ (negedge aclk)
    @ (negedge aclk)
    @ (negedge aclk)
    @ (negedge aclk)
      aresetn = 1;
end

/* genvar i;
genvar j;
generate
    // initial begin
        for(i = 0; i < 1000; i = i + 1) begin i_loop:
            for(j = 0; j < `CRPA_NCH; j = j + 1) begin j_loop:
                inp_ram[i][`CRPA_D_WIDTH-1+i*`CRPA_NCH:i*`CRPA_NCH] = j+i*`CRPA_NCH;
            end
        end
    // end
endgenerate */

initial
    $readmemb("model_IQ.txt", inp_ram, 0, RAM_DEPTH-1);

for(genvar i = 0; i < `CRPA_NUMB; i = i+ 1) begin
    assign data_in[i].clk = pclk;
    level_sync ADC_RESETN(
        .clk     (data_in[i].clk),
        .reset_n (aresetn),
        .async   (aresetn),
        .sync    (data_in[i].resetn)
    );

    always_ff@(posedge data_in[i].clk or negedge data_in[i].resetn)
    if(data_in[i].resetn == '0) begin
        ram_cntr <= '0;
    end else begin
        ram_cntr <= ram_cntr + 1'b1;
    end

    always_ff@(posedge data_in[i].clk or negedge data_in[i].resetn)
    if(data_in[i].resetn == '0) begin
        data_in[i].data <= '{default:0};
    end else begin
        {>>{data_in[i].data}} <= inp_ram[ram_cntr];
    end

    /* for(genvar i = 0; i < `CRPA_NCH; i ++) begin: GEN_DATA
        always_ff@(posedge data_in[i].clk or negedge data_in[i].resetn)
        if(data_in[i].resetn == '0) begin
            data_in[i].data[i] <= '0;
        end else begin
            // data_in[i].data[i] <= data_in[i].data[i] + (i + 1);
            // data_in[i].data[i] <= (i + 1);
            // data_in[i].data[i] <= $random%120;
            // data_in[i].data[i] <= $dist_normal( $urandom, 0, 100 );
            data_in[i].data[i] <= inp_ram[ram_cntr];
            // data_in[i].data[i] <= 100;
        end
    end */
end

crpa#(
    .BASEADDR    (BASEADDR),
    .CRPA_CH     (`CRPA_NUMB)
)CRPA (
    .data_in       (data_in),
    .data_out      (data_out),
    .data_out_full (data_out_full),
    .bus           (bus),
    .ce            ('1)
);

endmodule