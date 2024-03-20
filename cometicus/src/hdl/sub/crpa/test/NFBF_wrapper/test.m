function [test_result] = test(varargin)

addpath('../Sub');

% ������� ��� �������� ��������� �����������
TMP='tmp/';  system(['if [ ! -d ' TMP ' ]; then mkdir ' TMP ' ; fi']);

% ������ ���������� � �������� ��-���������
DefParams = {'NCH',         8;
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

T = 0.01e-3;               % ������������ ����������� �������
N = fix(T/Td);          % ���������� ��������


% ======== ������������ ��������������� �������� ========

s = randn(NCH, N);        % ������� ������

% ����������� �������
Ks = 1/4*2^(width-1);      % ���������� ����������� ��� �����������
s = quant(Ks*s, width);    % ����������� �������

% s = sign(s);
% s(DIRECT_CH, :) = 0;

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
fid = fopen([TMP 'K_coefs.txt'], 'w');
fprintf(fid, '%d\n', B');
fclose(fid);

% ==== ���������� � Matlab ====
y = zeros(NCH, N);

for ch=1:NCH
    y(ch, :) = s(ch, :);
    k = 1;
    for i=1:NCH
        if i~= ch
            y(ch, :) = y(ch, :) + filter(B(k, :), A, s(i, :));
            k = k + 1;
        end
    end
end

% ======== ��������� ������ � Verilog =========

% ==== ������ ���������� ��� Verilog =====
fid_param = fopen([TMP 'test_params.v'], 'w');       % ���� � ����������� ������������
fprintf(fid_param, '`define NFBF_NCH %d\n', NCH);
fprintf(fid_param, '`define NFBF_NT %d\n', NT);
fprintf(fid_param, '`define NFBF_WIDTH %d\n', width);
fprintf(fid_param, '`define NFBF_NCFWIDTH %d\n', ncfwidth);
fprintf(fid_param, '`define NFBF_NBF %d\n', 0);
fprintf(fid_param, '`define NFBF_BCFWIDTH %d\n', 0);
fclose(fid_param);

fid = fopen('tmp/run.tcl', 'w');                     % ���� � ������������������ ������������
fprintf(fid, 'run %dns\n', ceil((8e-9 + T)*1e9));
fclose(fid);

% ==== ������ ����� modelsim ====
system('make batch');

% ==== ���������� ����������� ====
out = [];
for i=1:NCH
    i
    out = [out; textread(sprintf('tmp/out_NF_%d.txt', i), '%n')'];
end

y = round(y*(Kb-1));  % ����������� ������� �� 2^(ncfwidth-1)-1 - �� ������� ������

% ======== ������ � ��������� ����������� ��������� =========
for i=1:NCH
    test_result = compare(y(i, :), out(i, :), Td);
end

