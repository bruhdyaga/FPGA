module SYNC_550kHz(
    
    input rst,
    input clk,
    output logic sync
);

reg [8:0] counter;

always @(posedge clk or posedge rst) begin
    if (!rst) begin
        sync <= 0;
        counter <= 0;
    end
    else begin
        if (counter == 0) begin
            sync <= ~sync;
            counter <= 91; // Делитель для получения 550 кГц из 50 МГц
        end 
        else begin
            counter <= counter - 1;
        end
    end
end

endmodule