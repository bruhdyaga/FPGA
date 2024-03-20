module flag_sync(
    sclk,
    dclk,
    reset_n,
    set_pulse,
    rst_pulse,
    flag
);

    input sclk;
    input dclk;
    input reset_n;
    input set_pulse;
    input rst_pulse;
    output flag;
    
    reg flag;    

    signal_sync sync(
        .sclk      (sclk),
        .dclk      (dclk),
        .reset_n   (reset_n),
        .start     (set_pulse),
        .ready     (set_pulse_sync)
    );
    
    always @ (posedge dclk or negedge reset_n) begin
        if (reset_n == 1'b0) begin
            flag <= 1'b0;      
        end
        else begin
            if (set_pulse_sync == 1'b1) begin
                flag <= 1'b1;
            end
            else if (rst_pulse == 1'b1) begin
                flag <= 1'b0;
            end
        end        
    end
    
endmodule
