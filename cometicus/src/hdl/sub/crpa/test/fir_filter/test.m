function [test_result] = test(varargin)

addpath('../Sub');

% ������� ��� �������� ��������� �����������
TMP='tmp/';  system(['if [ ! -d ' TMP ' ]; then mkdir ' TMP ' ; fi']);

% ������ ���������� � �������� ��-���������
DefParams = {'NT',            14;
             'data_width',     6;
             'coeff_width',    2;};
parse_params

% ======== ����� ��������� ������ ========
fd = 125e6;             % ������� �������������
Td = 1/fd;              % �������� �������������

fh = 10e6;              % ������� ����� ��� � �����

T = 0.1e-3;               % ������������ ����������� �������
N = fix(T/Td);          % ���������� ��������


% ======== ������������ ��������������� �������� ========

s = randn(1, N);        % ������� ������

% ����������� �������
Ks = 1/4*2^(data_width-1);      % ���������� ����������� ��� �����������
s = quant(Ks*s, data_width);    % ����������� �������


% ������ ������� ������� � ����
fid = fopen([TMP 's.txt'], 'w'); 
fprintf(fid, '%d\n', s);
fclose(fid);


% ======== ��������� ������� � Matlab ========
% ==== ������ ������������� ====
Kb = 2^(coeff_width-1);          % ���������� ���������� 

Wn = fh/(fd/2);         % ������������� ������� �����

B = fir1(NT-1, Wn);    % ������ ������������ �������

B = quant(B*Kb, coeff_width);    % ����������� ������������� �������
A = Kb;                 % ���������� ������������� � Matlab ������ ������� filter(B, A, y)

% ������ ������������ � ����
fid = fopen([TMP 'coefs.txt'], 'w');
fprintf(fid, '%d\n', B);
fclose(fid);

% ==== ���������� � Matlab ====
y = filter(B, A, s); 


% ======== ��������� ������ � Verilog =========

% ==== ������ ���������� ��� Verilog =====
fid_param = fopen([TMP 'test_params.v'], 'w');       % ���� � ����������� ������������
fprintf(fid_param, '`define FIR_NT %d\n', NT);
fprintf(fid_param, '`define FIR_DATA_WIDTH %d\n', data_width);
fprintf(fid_param, '`define FIR_COEFF_WIDTH %d\n', coeff_width);
fclose(fid_param);

fid = fopen('tmp/run.tcl', 'w');                     % ���� � ������������������ ������������
fprintf(fid, 'run %dns\n', ceil((8e-9 + T)*1e9));
fclose(fid);

% ==== ������ ����� modelsim ====
system('make batch');

% ==== ���������� ����������� ====
out = textread('tmp/out.txt', '%n')';

y = y*Kb;

% ======== ������ � ��������� ����������� ��������� =========
test_result = compare(y, out, Td);
