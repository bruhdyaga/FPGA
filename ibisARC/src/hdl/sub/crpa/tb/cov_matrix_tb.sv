`timescale 1ns/10ps

`define pclk 105.6  // MHz
`define aclk 100    // MHz

module cov_matrix_tb();

localparam BASEADDR    = 32'h40000000/4;
localparam NCH         = 2;
localparam WIDTH       = 14;
localparam NT          = 10;
localparam MACCS_NUM   = (((NCH*NT)**2)-NCH*NT)/2+NCH*NT;
localparam ACCUM_WIDTH = 32;

reg pclk = 1;
reg aclk = 1;
reg aresetn = 1;

always #((1000/`pclk)/2) pclk <= !pclk;
always #((1000/`aclk)/2) aclk <= !aclk;

// ADC interface
adc_interf#(
    .PORTS (NCH),
    .R     (WIDTH)
)data_in ();

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

// always@(posedge adc.clk or negedge adc.resetn)
// if(adc.resetn == '0)
    // adc.data[0] <= '0;
// else
    // adc.data[0] <= {$random,$random};

assign data_in.clk = pclk;
level_sync ADC_RESETN(
    .clk     (data_in.clk),
    .reset_n (aresetn),
    .async   (aresetn),
    .sync    (data_in.resetn)
);


for(genvar i = 0; i < NCH; i ++) begin: GEN_DATA
    always_ff@(posedge data_in.clk or negedge data_in.resetn)
    if(data_in.resetn == '0) begin
        data_in.data[i] <= '0;
    end else begin
        data_in.data[i] <= data_in.data[i] + (i + 1);
    end
end

cov_matrix#(
    .BASEADDR    (BASEADDR),
    .NCH         (NCH),
    .NT          (NT),
    .WIDTH       (WIDTH),
    .MACCS_NUM   (MACCS_NUM),
    .ACCUM_WIDTH (ACCUM_WIDTH)
)CVM (
    .data_in (data_in),
    .bus     (bus),
    .ce      ('1)
);

endmodule