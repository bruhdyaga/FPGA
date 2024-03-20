function [test_result] = test(varargin)

addpath('../Sub');

% ������� ��� �������� ��������� �����������
TMP='tmp/';  system(['if [ ! -d ' TMP ' ]; then mkdir ' TMP ' ; fi']);

% ������ ���������� � �������� ��-���������
DefParams = {'NCH',         16;
             'input_width', 20;
             'coeff_width', 20;};
parse_params


% ======== ����� ��������� ������ ========
fd = 125e6;             % ������� �������������
Td = 1/fd;              % �������� �������������

fi = fd/10;              % ������������� ������� �������

T = 0.01e-3;             % ������������ ����������� �������
N = fix(T/Td);          % ���������� ��������

% ======== ������������ ��������������� �������� ========

s = zeros(NCH, N);
phi = 2*pi*zeros(NCH, 1);     % ������� ������������� �������� - ���� ��������, ���� ������

for i=1:NCH
    s(i, :) = cos(2*pi*fi * Td*(0:N-1) + phi(i));
end
s = -1+2*rand(NCH, N);

% ����������� �������
Ks = 1/1.05 * 2^(input_width-1);    % ���������� ����������� ��� �����������
s = quant(Ks*s, input_width);       % ����������� �������

% ������ ������� ������� � ����
for i=1:NCH
    fid = fopen(sprintf('%ss_%d.txt', TMP, i), 'w'); 
    fprintf(fid, '%d\n', s(i, :));
    fclose(fid);
end

% ======== ��������� ������� � Matlab ========
% ==== ������ ������������� ====
Kb = 2^(coeff_width-1);             % ���������� ���������� 

%Kbf = ones(1, NCH);              % ��������!!!
Kbf = rand(1, NCH);              % ���� ����� ����� ��������� ������������

Kbf = quant(Kbf*Kb, coeff_width);   % ����������� ������������� �������

% ������ ������������ � ����
fid = fopen([TMP 'coefs.txt'], 'w');
fprintf(fid, '%d\n', Kbf);
fclose(fid);

% ==== ���������� � Matlab ====
y = Kbf * s;

% ======== ��������� ������ � Verilog =========

% ==== ������ ���������� ��� Verilog =====
fid_param = fopen([TMP 'test_params.v'], 'w');       % ���� � ����������� ������������
fprintf(fid_param, '`define BF_NCH %d\n', NCH);
fprintf(fid_param, '`define BF_INPUT_WIDTH %d\n', input_width);
fprintf(fid_param, '`define BF_COEFF_WIDTH %d\n', coeff_width);
fclose(fid_param);

fid = fopen('tmp/run.tcl', 'w');                     % ���� � ������������������ ������������
fprintf(fid, 'run %dns\n', ceil((8e-9 + T)*1e9));
fclose(fid);

% ==== ������ ����� modelsim ====
system('make batch');

% ==== ���������� ����������� ====
out = textread('tmp/out.txt', '%n')';

% ======== ������ � ��������� ����������� ��������� =========
test_result = compare(y, out, Td);
