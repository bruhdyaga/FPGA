function [Var] = make_randn_fb(a, b, NQ, NS, name)
% Формирование гауссовского датчика псевдослучайных чисел на Verilog
% Метод Фибоначчи с запаздыванием
% a, b - лаги
% NQ   - разрядность результата
% NS   - количество суммируемых чисел с равномерным распределением
% name - имя формируемого модуля
% Var  - оценка дисперсии выходного процесса

for i=1:NS
  name_u = sprintf('%s_u_%d', name, i);
  
  make_rand_fb(a, b, NQ, name_u);
end

NNQ = NQ + ceil(log2(NS));

fid = fopen([name '.v'], 'w');
fprintf(fid, 'module %s(clk, RESET, out);\n', name);

fprintf(fid, '   input clk;\n');
fprintf(fid, '   input RESET;\n');
fprintf(fid, '   output out;\n\n');

fprintf(fid, '   wire clk;\n');
fprintf(fid, '   wire RESET;\n');
fprintf(fid, '   reg signed [%d:0] out;\n\n', NNQ-1);

for i=1:NS
  fprintf(fid, '   wire signed [%d:0] rand_u_%d;\n', NQ-1, i);
end
fprintf(fid, '\n');

for i=1:NS
  fprintf(fid, '   reg signed [%d:0] X_%d;\n', NNQ-1, i);
end
fprintf(fid, '\n');

for i=1:NS
  name_u = sprintf('%s_u_%d', name, i);
  fprintf(fid, '   %s %s(clk, RESET, rand_u_%d);\n', name_u, name_u, i);
end
fprintf(fid, '\n');

%fprintf(fid, '   always @(posedge clk or posedge RESET) begin\n');
fprintf(fid, '   always @(posedge clk) begin\n');
fprintf(fid, '      if (RESET) begin\n');
fprintf(fid, '         out <= X_%d;\n', NS);
for i=1:NS-1
  fprintf(fid, '         X_%d <= X_%d + rand_u_%d;\n', NS-i+1, NS-i, NS-i+1);
end
fprintf(fid, '         X_1 <= 0 + rand_u_1;\n');
fprintf(fid, '      end else begin\n');
for i=1:NS
  fprintf(fid, '         X_%d <= 0;\n', i);
end

fprintf(fid, '      end\n');
fprintf(fid, '   end\n');
fprintf(fid, 'endmodule\n');

fclose(fid);

fid = fopen([name '_params.inc'], 'a');
fprintf(fid, 'parameter NNQ = %d;\n', NNQ);
fclose(fid);


Var = NS * (2^NQ)^2/12;  % Дисперсия выходного процесса