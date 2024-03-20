function [test_result] = test(varargin)

addpath('../Sub');

% ������� ��� �������� ��������� �����������
TMP='tmp/';  system(['if [ ! -d ' TMP ' ]; then mkdir ' TMP ' ; fi']);

% ������ ���������� � �������� ��-���������
DefParams = {'NS',         17;
             'IN_WIDTH',   46;};
parse_params

% ==== ��������� ������, ������� ����� ��������������� "�����" ===
fid = fopen([TMP 'test_params.m'], 'w');

% ��������� ��������� ������� ��������� �����
try, rand_state;
catch
    % ���� ����� ���������� ���������� �� ������� � ������� - ����������������� ������ ����
    %    randn('state', 0);
    randn_state = randn('state');    
    % fprintf('randn state: %d %d\n', randn_state); % ������ ���������� ��������� ������� ��������� �����, ����� ����� ���� ���������
end
fprintf(fid, 'randn(''state'', [%d; %d]);\n', randn_state);

% ==== ��������� ������������ ������ ====
try, NS;
catch
    NS = 17;                 % ����� ���������
end
fprintf(fid, 'NS = %d;\n', NS);

try, IN_WIDTH;
catch
    IN_WIDTH = 46;             % ����������� ������� ������
end
fprintf(fid, 'IN_WIDTH = %d;\n', IN_WIDTH);

fclose(fid);  % ���������� ����� � �����������



% ======== ����� ��������� ������ ========
fd = 125e6;             % ������� �������������
Td = 1/fd;              % �������� �������������

fi = fd/10;              % ������������� ������� �������

T = 0.01e-3;             % ������������ ����������� �������
N = fix(T/Td);          % ���������� ��������

% ======== ������������ ��������������� �������� ========

s = -1+2*rand(NS, N);

% ����������� �������
Ks = 1/1.05 * 2^(IN_WIDTH-1);    % ���������� ����������� ��� �����������
s = quant(Ks*s, IN_WIDTH);       % ����������� �������

% ������ ������� ������� � ����
for i=1:NS
    fid = fopen(sprintf('%ss_%d.txt', TMP, i), 'w'); 
    fprintf(fid, '%d\n', s(i, :));
    fclose(fid);
end

% ======== ��������� ������� � Matlab ========
% ==== ���������� � Matlab ====
y = sum(s);

% ======== ��������� ������ � Verilog =========

% ==== ������ ���������� ��� Verilog =====
fid_param = fopen([TMP 'test_params.v'], 'w');       % ���� � ����������� ������������
fprintf(fid_param, '`define MSUM_NS %d\n', NS);
fprintf(fid_param, '`define MSUM_WIDTH %d\n', IN_WIDTH);
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
