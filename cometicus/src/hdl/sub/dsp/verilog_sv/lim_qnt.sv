//������������ ����� �� ������������ � ����������� ������� �������
//��������, ��� ����������
//�������� �� ��������� ������� � ���. ����
//�������� ����������� <= �������
module lim_qnt#(
    parameter in_width    = 1,
    parameter out_width   = 1,
    parameter SYMMETRICAL = 0  // ����/��� �����������, �������� -127/+127 (������ -128/+127)
)
(
    input                        clk,
    input                        WE,
    output                       valid,
    input        [in_width-1:0]  in,
    output logic [out_width-1:0] out
);

localparam cut_dig = in_width - out_width;//������� �������� ��������
localparam lat_valid = 1;//�������� ������� �� ������

latency#(
    .length  (lat_valid)
) latency_inst(
    .clk     (clk),
    .in      (WE),
    .out     (valid),
    .out_reg ()//���� ��������� ������� ��� ������������� ��������
);

generate
if(cut_dig == 0)//�� ������������ ������� �����
begin
    always@(posedge clk) begin
    if(WE)
        out <= in;
    end
end
else//���������� �����
begin
    always@(posedge clk) begin
    if(WE)
        if(in[in_width-1] == 0)//����� �������������
            if(in[in_width-2:in_width-1-cut_dig] == 0)//����� �� ��������� ������
                out[out_width-1:0] <= {1'b0,in[out_width-2:0]};//��������� ������� �������
            else//����� ��������� ������, ������������ ���
                out[out_width-1:0] <= {1'b0,{out_width-1{1'b1}}};
        else//����� �������������
            if(in[in_width-2:in_width-1-cut_dig] == {cut_dig{1'b1}})//����� �� ��������� ������
                if((in[out_width-2:0] == '0) & SYMMETRICAL) // ����� ����� ����������� �������������� ���������
                    out[out_width-1:0] <= {1'b1,{out_width-2{1'b0}},1'b1};
                else
                    out[out_width-1:0] <= {1'b1,in[out_width-2:0]};//��������� ������� �������
            else//����� ��������� ������, ������������ ���
                if(SYMMETRICAL)
                    out[out_width-1:0] <= {1'b1,{out_width-2{1'b0}},1'b1};
                else
                    out[out_width-1:0] <= {1'b1,{out_width-1{1'b0}}};
    end
end
endgenerate

endmodule