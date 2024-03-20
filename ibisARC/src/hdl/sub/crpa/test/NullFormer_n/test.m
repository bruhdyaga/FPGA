function [test_result] = test(varargin)

addpath('../Sub');

% ������� ��� �������� ��������� �����������
TMP='tmp/';  system(['if [ ! -d ' TMP ' ]; then mkdir ' TMP ' ; fi']);

% ������ ���������� � �������� ��-���������
DefParams = {'NCH',         2;
             'DIRECT_CH',   1;
             'order',       1;
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

s = randn(NCH, N);        % ������� ������

% ����������� �������
Ks = 1/4*2^(width-1);      % ���������� ����������� ��� �����������
s = quant(Ks*s, width);    % ����������� �������

% s = sign(s);

% ������ ������� ������� � ����
for i=1:NCH
    fid = fopen(sprintf('%ss_%d.txt', TMP, i), 'w'); 
    fprintf(fid, '%d\n', s(i, :));
    fclose(fid);
end

% ======== ��������� ������� � Matlab ========
% ==== ������ ������������� ====
Kb = 2^(ncfwidth-1);          % ���������� ���������� 

B = zeros(NCH-1, NT);
for i=1:NCH-1
    Wn = (0.5+0.5*rand(1, 1)) * fh/(fd/2);         % ������������� ������� �����

    B(i, :) = fir1(order, Wn);    % ������ ������������ �������
end

B = quant(B*Kb, ncfwidth);    % ����������� ������������� �������
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
fprintf(fid_param, '`define NF_WIDTH %d\n', width);
fprintf(fid_param, '`define NF_NCFWIDTH %d\n', ncfwidth);
fclose(fid_param);

fid = fopen('tmp/run.tcl', 'w');                     % ���� � ������������������ ������������
fprintf(fid, 'run %dns\n', ceil((8e-9 + T)*1e9));
fclose(fid);

% ==== ������ ����� modelsim ====
system('make batch');

% ==== ���������� ����������� ====
out = textread('tmp/out.txt', '%n')';

y = round(y*(Kb-1));  % ����������� ������� �� 2^(ncfwidth-1)-1 - �� ������� ������

% ======== ������ � ��������� ����������� ��������� =========
test_result = compare(y, out, Td);
