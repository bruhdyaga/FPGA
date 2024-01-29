module SYNC_750kHz(
    
    input rst,
    input clk,
    output logic sync_750kHz
);

reg [8:0] counter;

always @(posedge clk or posedge rst) begin
    if (!rst) begin
        sync_750kHz <= 0;
        counter <= 0;
    end
    else begin
        if (counter == 0) begin
            sync_750kHz <= ~sync_750kHz;
            counter <= 66; // Делитель для получения 750 кГц из 50 МГц
        end 
        else begin
            counter <= counter - 1;
        end
    end
end

endmodule