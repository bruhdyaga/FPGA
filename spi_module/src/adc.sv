module adc
(	
        input I_clk, // 50 MHz
        input I_rst_n, 
        input I_tx_en, // flag to begin transmission

        output logic [7:0] I_data_in // data to transmit to spi_module
);

//Regs to tune
logic [7:0] reg_06_adress;
logic [7:0] reg_06_data  ;

logic [7:0] reg_07_adress;
logic [7:0] reg_07_data  ;

logic [7:0] reg_08_adress;
logic [7:0] reg_08_data  ;

logic [7:0] reg_0B_adress;
logic [7:0] reg_0B_data  ;

logic [7:0] reg_0C_adress;
logic [7:0] reg_0C_data  ;

logic [7:0] reg_0D_adress;
logic [7:0] reg_0D_data  ;

logic [7:0] reg_0F_adress;
logic [7:0] reg_0F_data  ;

logic [7:0] reg_10_adress;
logic [7:0] reg_10_data  ;

logic [7:0] reg_11_adress;
logic [7:0] reg_11_data  ;

logic [7:0] reg_12_adress;
logic [7:0] reg_12_data  ;

logic [7:0] reg_13_adress;
logic [7:0] reg_13_data  ;

logic [7:0] reg_14_adress;
logic [7:0] reg_14_data  ;

logic [7:0] reg_15_adress;
logic [7:0] reg_15_data  ;

logic [7:0] reg_16_adress;
logic [7:0] reg_16_data  ;

logic [7:0] reg_17_adress;
logic [7:0] reg_17_data  ;

logic [7:0] reg_18_adress;
logic [7:0] reg_18_data  ;

logic [7:0] reg_1F_adress;
logic [7:0] reg_1F_data  ;

logic [7:0] reg_20_adress;
logic [7:0] reg_20_data  ;

initial begin
    reg_06_adress <= 8'b1_0_0_0_0_0_0_1;
    reg_06_data   <= 8'b0_0_0_0_0_1_1_1;

    reg_07_adress <= 8'b1_0_0_0_0_0_0_1;
    reg_07_data   <= 8'b0_0_0_0_0_1_1_1;

    reg_08_adress <= 8'b1_0_0_0_0_0_0_1;
    reg_08_data   <= 8'b0_0_0_0_0_1_1_1;

    reg_0B_adress <= 8'b1_0_0_0_0_0_0_1;
    reg_0B_data   <= 8'b0_0_0_0_0_1_1_1;

    reg_0C_adress <= 8'b1_0_0_0_0_0_0_1;
    reg_0C_data   <= 8'b0_0_0_0_0_1_1_1;

    reg_0D_adress <= 8'b1_0_0_0_0_0_0_1;
    reg_0D_data   <= 8'b0_0_0_0_0_1_1_1;

    reg_0F_adress <= 8'b1_0_0_0_0_0_0_1;
    reg_0F_data   <= 8'b0_0_0_0_0_1_1_1;

    reg_10_adress <= 8'b1_0_0_0_0_0_0_1;
    reg_10_data   <= 8'b0_0_0_0_0_1_1_1;

    reg_11_adress <= 8'b1_0_0_0_0_0_0_1;
    reg_11_data   <= 8'b0_0_0_0_0_1_1_1;

    reg_12_adress <= 8'b1_0_0_0_0_0_0_1;
    reg_12_data   <= 8'b0_0_0_0_0_1_1_1;

    reg_13_adress <= 8'b1_0_0_0_0_0_0_1;
    reg_13_data   <= 8'b0_0_0_0_0_1_1_1;

    reg_14_adress <= 8'b1_0_0_0_0_0_0_1;
    reg_14_data   <= 8'b0_0_0_0_0_1_1_1;

    reg_15_adress <= 8'b1_0_0_0_0_0_0_1;
    reg_15_data   <= 8'b0_0_0_0_0_1_1_1;

    reg_16_adress <= 8'b1_0_0_0_0_0_0_1;
    reg_16_data   <= 8'b0_0_0_0_0_1_1_1;

    reg_17_adress <= 8'b1_0_0_0_0_0_0_1;
    reg_17_data   <= 8'b0_0_0_0_0_1_1_1;

    reg_18_adress <= 8'b1_0_0_0_0_0_0_1;
    reg_18_data   <= 8'b0_0_0_0_0_1_1_1;

    reg_1F_adress <= 8'b1_0_0_0_0_0_0_1;
    reg_1F_data   <= 8'b0_0_0_0_0_1_1_1;

    reg_20_adress <= 8'b1_0_0_0_0_0_0_1;
    reg_20_data   <= 8'b0_0_0_0_0_1_1_1;
end

logic [6:0] state; 
logic R_rx_state;
 
always @(posedge I_clk or negedge I_rst_n)
begin

    if(!I_rst_n)
        begin
			state   <=  6'd0 ;
        end 

        else if (I_tx_en )begin
				  
        case (state) // all registers from reg. map one by one writing to I_data_in

                6'd0:

                begin
                    I_data_in <= reg_06_adress;
                    state <= state + 1'b1;                   
                end

                6'd1:

                begin
                    I_data_in <= reg_06_data;   
                    state <= state + 1'b1;                   
                end

                6'd2:

                begin
                    I_data_in <= reg_07_adress;   
                    state <= state + 1'b1;                   
                end

                6'd3:

                begin
                    I_data_in <= reg_07_data;
                    state <= state + 1'b1;                      
                end

                6'd4:

                begin
                    I_data_in <= reg_08_adress;
                    state <= state + 1'b1;                       
                end

                6'd5:

                begin
                    I_data_in <= reg_08_data;
                    state <= state + 1'b1;                     
                end

                6'd6:

                begin
                    I_data_in <= reg_0B_adress;
                    state <= state + 1'b1;                       
                end

                6'd7:

                begin
                    I_data_in <= reg_0B_data;
                    state <= state + 1'b1;                       
                end

                6'd8:

                begin
                    I_data_in <= reg_0C_adress;
                    state <= state + 1'b1;                       
                end

                6'd9:

                begin
                    I_data_in <= reg_0C_data;
                    state <= state + 1'b1;                      
                end

                6'd10:

                begin
                    I_data_in <= reg_0D_adress;
                    state <= state + 1'b1;                       
                end

                6'd11:

                begin
                    I_data_in <= reg_0D_data;
                    state <= state + 1'b1;                      
                end

                6'd12:

                begin   
                    I_data_in <= reg_0F_adress;
                    state <= state + 1'b1;                      
                end

                6'd13:

                begin
                    I_data_in <= reg_0F_data;
                    state <= state + 1'b1;                    
                end

                6'd14:

                begin
                    I_data_in <= reg_10_adress;
                    state <= state + 1'b1;                    
                end

                6'd15:

                begin
                    I_data_in <= reg_10_data;
                    state <= state + 1'b1;                     
                end

                6'd16:

                begin
                    I_data_in <= reg_11_adress;
                    state <= state + 1'b1;                  
                end

                6'd17:

                begin
                    I_data_in <= reg_11_data;
                    state <= state + 1'b1;                  
                end

                6'd18:

                begin
                    I_data_in <= reg_12_adress;
                    state <= state + 1'b1;                   
                end

                6'd19:

                begin
                    I_data_in <= reg_12_data;
                    state <= state + 1'b1;                  
                end

               6'd20:

                begin
                    I_data_in <= reg_13_adress;
                    state <= state + 1'b1;                  
                end

                6'd21:

                begin
                    I_data_in <= reg_13_data;
                    state <= state + 1'b1;                   
                end

                6'd22:

                begin
                    I_data_in <= reg_14_adress;
                    state <= state + 1'b1;                  
                end

                6'd23:

                begin
                    I_data_in <= reg_14_data;
                    state <= state + 1'b1;            
                end

                6'd24:

                begin
                    I_data_in <= reg_15_adress;
                    state <= state + 1'b1;               
                end

                6'd25:

                begin
                    I_data_in <= reg_15_data;
                    state <= state + 1'b1;                   
                end

                6'd26:

                begin
                    I_data_in <= reg_16_adress;
                    state <= state + 1'b1;          
                end

                6'd27:

                begin
                    I_data_in <= reg_16_data;
                    state <= state + 1'b1;                 
                end

                6'd28:

                begin
                    I_data_in <= reg_17_adress;
                    state <= state + 1'b1;                  
                end

                6'd29:

                begin
                    I_data_in <= reg_17_data;
                    state <= state + 1'b1;                   
                end

                6'd30:

                begin
                    I_data_in <= reg_18_adress;
                    state <= state + 1'b1;                 
                end

                6'd31:

                begin
                    I_data_in <= reg_18_data;
                    state <= state + 1'b1;                   
                end

                6'd32:

                begin
                    I_data_in <= reg_1F_adress;
                    state <= state + 1'b1;             
                end

                6'd33:

                begin
                    I_data_in <= reg_1F_data;
                    state <= state + 1'b1;                 
                end

                6'd34:

                begin
                    I_data_in <= reg_20_adress;
                    state <= state + 1'b1;                    
                end

                6'd35:

                begin
                    I_data_in <= reg_20_data;
                    state <= state + 1'b1;                   
                end
              
				default: state <= 6'd0;

        endcase			
        end
end

endmodule
