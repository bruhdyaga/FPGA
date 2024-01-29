module SYNC_550kHz(
    
    input rst,
    input clk,
    output logic sync_550kHz
);

reg [8:0] counter;

always @(posedge clk or posedge rst) begin
    if (!rst) begin
        sync_550kHz <= 0;
        counter <= 0;
    end
    else begin
        if (counter == 0) begin
            sync_550kHz <= ~sync_550kHz;
            counter <= 91; // Делитель для получения 550 кГц из 50 МГц
        end 
        else begin
            counter <= counter - 1;
        end
    end
end

endmodule