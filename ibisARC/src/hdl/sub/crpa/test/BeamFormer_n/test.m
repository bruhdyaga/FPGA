function [test_result] = test(varargin)

addpath('../Sub');

% ������� ��� �������� ��������� �����������
TMP='tmp/';  system(['if [ ! -d ' TMP ' ]; then mkdir ' TMP ' ; fi']);

% ������ ���������� � �������� ��-���������
DefParams = {'NN',          4;
             'a_width',    14;
             'b_width',    14;};
parse_params


% ======== ����� ��������� ������ ========
fd = 125e6;             % ������� �������������
Td = 1/fd;              % �������� �������������

fi = fd/10;              % ������������� ������� �������

T = 0.01e-3;             % ������������ ����������� �������
N = fix(T/Td);          % ���������� ��������

% ======== ������������ ��������������� �������� ========

s = zeros(NN, N);
phi = 2*pi*zeros(NN, 1);     % ������� ������������� �������� - ���� ��������, ���� ������

for i=1:NN
    s(i, :) = cos(2*pi*fi * Td*(0:N-1) + phi(i));
end

% ����������� �������
Ks = 1/1.05 * 2^(a_width-1);    % ���������� ����������� ��� �����������
s = quant(Ks*s, a_width);       % ����������� �������

% ������ ������� ������� � ����
for i=1:NN
    fid = fopen(sprintf('%ss_%d.txt', TMP, i), 'w'); 
    fprintf(fid, '%d\n', s(i, :));
    fclose(fid);
end

% ======== ��������� ������� � Matlab ========
% ==== ������ ������������� ====
Kb = 2^(b_width-1);             % ���������� ���������� 

%Kbf = ones(1, NN);              % ��������!!!
Kbf = rand(1, NN);              % ���� ����� ����� ��������� ������������

Kbf = quant(Kbf*Kb, b_width);   % ����������� ������������� �������

% ������ ������������ � ����
fid = fopen([TMP 'coefs.txt'], 'w');
fprintf(fid, '%d\n', Kbf);
fclose(fid);

% ==== ���������� � Matlab ====
y = Kbf * s;

% ======== ��������� ������ � Verilog =========

% ==== ������ ���������� ��� Verilog =====
fid_param = fopen([TMP 'test_params.v'], 'w');       % ���� � ����������� ������������
fprintf(fid_param, '`define BF_NN %d\n', NN);
fprintf(fid_param, '`define BF_A_WIDTH %d\n', a_width);
fprintf(fid_param, '`define BF_B_WIDTH %d\n', b_width);
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
