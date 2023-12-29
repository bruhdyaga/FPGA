`timescale 1ns / 1ps

module tb_spi_module;

    // Inputs
    reg I_clk;
    reg I_rst_n;
    reg I_rx_en;
    reg I_tx_en;
    reg [7:0] I_data_in;
    reg I_spi_miso;

    // Outputs
    wire [7:0] O_data_out;
    wire O_tx_done;
    wire O_rx_done;
    wire O_spi_sck;
    wire O_spi_cs;
    wire O_spi_mosi;

    // Instantiate the Unit Under Test (UUT)
    spi_module uut (
        .I_clk           (I_clk         ), 
        .I_rst_n         (I_rst_n       ), 
        .I_rx_en         (I_rx_en       ), 
        .I_tx_en         (I_tx_en       ), 
        .O_data_out      (O_data_out    ), 
        .O_tx_done       (O_tx_done     ), 
        .O_rx_done       (O_rx_done     ), 
        .I_spi_miso      (I_spi_miso    ), 
        .O_spi_sck       (O_spi_sck     ), 
        .O_spi_cs        (O_spi_cs      ), 
        .O_spi_mosi      (O_spi_mosi    )
    );

    initial begin
        // Initialize Inputs
        I_clk = 0;
        I_rst_n = 0;
        I_rx_en = 0;
        I_tx_en = 1;
        I_data_in = 8'h00;
        I_spi_miso = 0;

        // Wait 100 ns for global reset to finish
        #100;
        I_rst_n = 1;  

    end
    
    always #10 I_clk = ~I_clk ;
      
endmodule
