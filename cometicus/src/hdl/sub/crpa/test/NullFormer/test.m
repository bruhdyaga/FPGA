function [test_result] = test(varargin)
%clear; varargin = {};

addpath('../Sub');

% ������� ��� �������� ��������� �����������
TMP='tmp/';  system(['if [ ! -d ' TMP ' ]; then mkdir ' TMP ' ; fi']);

% ������ ���������� � �������� ��-���������
DefParams = {'NCH',           2;
             'DIRECT_CH',     1;
             'NT',            4;
             'input_width',  14;
             'coeff_width',  14;};
parse_params

% ======== ����� ��������� ������ ========
fd = 125e6;             % ������� �������������
Td = 1/fd;              % �������� �������������

fh = 10e6;              % ������� ����� ��� � �����

T = 0.1e-3;               % ������������ ����������� �������
N = fix(T/Td);          % ���������� ��������


% ======== ������������ ��������������� �������� ========

s = randn(NCH, N);        % ������� ������

% ����������� �������
Ks = 1/4*2^(input_width-1);      % ���������� ����������� ��� �����������
s = quant(Ks*s, input_width);    % ����������� �������

% ������ ������� ������� � ����
for i=1:NCH
    fid = fopen(sprintf('%ss_%d.txt', TMP, i), 'w'); 
    fprintf(fid, '%d\n', s(i, :));
    fclose(fid);
end

% ======== ��������� ������� � Matlab ========
% ==== ������ ������������� ====
Kb = 2^(coeff_width-1);          % ���������� ���������� 

B = zeros(NCH-1, NT);
for i=1:NCH-1
    Wn = (0.5+0.5*rand(1, 1)) * fh/(fd/2);         % ������������� ������� �����

    B(i, :) = fir1(NT-1, Wn);    % ������ ������������ �������
end

B = quant(B*Kb, coeff_width);    % ����������� ������������� �������
A = Kb-1;                     % ���������� ������������� � Matlab ������ ������� filter(B, A, y)


% ������ ������������ � ����
fid = fopen([TMP 'coefs.txt'], 'w');
fprintf(fid, '%d\n', B');
fclose(fid);

% ==== ���������� � Matlab ====
y = s(DIRECT_CH, :);
k = 1;
for i=1:NCH
    if i~= DIRECT_CH
        y = y + filter(B(k, :), A, s(i, :)); 
        k = k + 1;
    end
end

% ======== ��������� ������ � Verilog =========

% ==== ������ ���������� ��� Verilog =====
fid_param = fopen([TMP 'test_params.v'], 'w');       % ���� � ����������� ������������
fprintf(fid_param, '`define NF_NCH %d\n', NCH);
fprintf(fid_param, '`define NF_DIRECT_CH %d\n', DIRECT_CH-1); % � NullFormer_n DIRECT_CH ���������� � 0
fprintf(fid_param, '`define NF_NT %d\n', NT);
fprintf(fid_param, '`define NF_INPUT_WIDTH %d\n', input_width);
fprintf(fid_param, '`define NF_COEFF_WIDTH %d\n', coeff_width);
fclose(fid_param);

fid = fopen('tmp/run.tcl', 'w');                     % ���� � ������������������ ������������
fprintf(fid, 'run %dns\n', ceil((8e-9 + T)*1e9));
fclose(fid);

% ==== ������ ����� modelsim ====
system('make batch');

% ==== ���������� ����������� ====
out = textread('tmp/out.txt', '%n')';

y = round(y*(Kb-1));  % ����������� ������� �� 2^(coeff_width-1)-1 - �� ������� ������

% ======== ������ � ��������� ����������� ��������� =========
test_result = compare(y, out, Td);
