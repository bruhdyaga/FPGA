function [test_result] = test(varargin)

addpath('../Sub');

% ������� ��� �������� ��������� �����������
TMP='tmp/';  system(['if [ ! -d ' TMP ' ]; then mkdir ' TMP ' ; fi']);

% ������ ���������� � �������� ��-���������
DefParams = {'order',       5;
             'width',      14;
             'ncfwidth',   14;};
parse_params

% �������������� ���������
NT = order + 1;             % ����� ����������� NT = order+1 !

% ======== ����� ��������� ������ ========
fd = 125e6;             % ������� �������������
Td = 1/fd;              % �������� �������������

fh = 10e6;              % ������� ����� ��� � �����

T = 0.1e-3;               % ������������ ����������� �������
N = fix(T/Td);          % ���������� ��������


% ======== ������������ ��������������� �������� ========

s = randn(1, N);        % ������� ������

% ����������� �������
Ks = 1/4*2^(width-1);      % ���������� ����������� ��� �����������
s = quant(Ks*s, width);    % ����������� �������


% ������ ������� ������� � ����
fid = fopen([TMP 's.txt'], 'w'); 
fprintf(fid, '%d\n', s);
fclose(fid);


% ======== ��������� ������� � Matlab ========
% ==== ������ ������������� ====
Kb = 2^(ncfwidth-1);          % ���������� ���������� 

Wn = fh/(fd/2);         % ������������� ������� �����

B = fir1(order, Wn);    % ������ ������������ �������

B = quant(B*Kb, ncfwidth);    % ����������� ������������� �������
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
fprintf(fid_param, '`define FIR_WIDTH %d\n', width);
fprintf(fid_param, '`define FIR_NT %d\n', NT);
fprintf(fid_param, '`define FIR_NCFWIDTH %d\n', ncfwidth);
fclose(fid_param);

fid = fopen('tmp/run.tcl', 'w');                     % ���� � ������������������ ������������
fprintf(fid, 'run %dns\n', ceil((8e-9 + T)*1e9));
fclose(fid);

% ==== ������ ����� modelsim ====
system('make batch');

% ==== ���������� ����������� ====
out = textread('tmp/out.txt', '%n')';

out = out/Kb;

% ======== ������ � ��������� ����������� ��������� =========
test_result = compare(y, out, Td);
