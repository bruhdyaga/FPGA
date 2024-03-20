function make_rand_fb(a, b, NQ, name)
% ������������ ������� ��������������� ����� �� Verilog
% ����� ��������� � �������������
% a, b - ����
% NQ   - ����������� ����������
% name - ��� ������������ ������

N = max(a, b);

rng('shuffle');

fid = fopen([name '.v'], 'w');
fprintf(fid, 'module %s(clk, RESET, out);\n', name);

fprintf(fid, '   input clk;\n');
fprintf(fid, '   input RESET;\n');
fprintf(fid, '   output out;\n\n', NQ-1);

fprintf(fid, '   wire clk;\n');
fprintf(fid, '   wire RESET;\n');
fprintf(fid, '   reg [%d:0] out;\n\n', NQ-1);
for i=1:N
  fprintf(fid, '   reg [%d:0] X_%d;\n', NQ-1, i);
end
fprintf(fid, '\n');

fprintf(fid, '   always @(posedge clk) begin\n');
fprintf(fid, '      if (RESET) begin\n');
fprintf(fid, '         if (X_%d >= X_%d) begin\n', a, b);
fprintf(fid, '            X_1 <= X_%d - X_%d;\n', a, b);

fprintf(fid, '         end else begin\n');
fprintf(fid, '            X_1 <= X_%d - X_%d + %d;\n', a, b, 2^NQ);

fprintf(fid, '         end\n');
for i=1:N-1
  fprintf(fid, '         X_%d <= X_%d;\n', N-i+1, N-i);
end
fprintf(fid, '         out <= X_1;\n');
fprintf(fid, '      end else begin\n');
for i=1:max(a, b);
  fprintf(fid, '         X_%d <= %d;\n', i, floor(rand(1, 1) * 2^NQ));
end
fprintf(fid, '      end\n');
fprintf(fid, '   end\n');
fprintf(fid, 'endmodule\n');

fclose(fid);

fid = fopen('rand_fb_params.inc', 'w');
fprintf(fid, 'parameter NQ = %d;\n', NQ);
fclose(fid);

