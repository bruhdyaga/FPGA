function [test_result] = test(varargin)
% clear; varargin={};

addpath('../Sub');

% ������� ��� �������� ��������� �����������
TMP='tmp/';  system(['if [ ! -d ' TMP ' ]; then mkdir ' TMP ' ; fi']);

% ������ ���������� � �������� ��-���������
DefParams = {'width',           14;
             'tau',              6};
parse_params

% ======== ����� ��������� ������ ========
fd = 125e6;             % ������� �������������
Td = 1/fd;              % �������� �������������

T = 0.1e-3;               % ������������ ����������� �������
N = fix(T/Td);          % ���������� ��������

% ======== ������������ ��������������� �������� ========

M = 1;
s = M + randn(1, N);        % ������� ������

% ����������� �������
Ks = 1/4*2^(width-1);      % ���������� ����������� ��� �����������
s = quant(Ks*s, width);    % ����������� �������

% ������ ������� ������� � ����
fid = fopen([TMP 's.txt'], 'w'); 
fprintf(fid, '%d\n', s);
fclose(fid);


% ======== ��������� ������� � Matlab ========

% ==== ���������� � Matlab ====
y = s - mean(s);

% ======== ��������� ������ � Verilog =========

% ==== ������ ���������� ��� Verilog =====
fid_param = fopen([TMP 'test_params.v'], 'w');       % ���� � ����������� ������������
fprintf(fid_param, '`define WDC_width %d\n', width);
fprintf(fid_param, '`define WDC_tau %d\n', tau);
fclose(fid_param);

fid = fopen('tmp/run.tcl', 'w');                     % ���� � ������������������ ������������
fprintf(fid, 'run %dns\n', ceil((8e-9 + T)*1e9));
fclose(fid);


% ==== ������ ����� modelsim ====
system('make batch');

% ==== ���������� ����������� ====
out = textread('tmp/out.txt', '%n')';


% ======== ������ � ��������� ����������� ��������� =========
[M dly] = max(abs(vkf_nan(out, s)));

err = circshift(s', dly-1)' - out;

subplot(2, 1, 1);
plot(1:length(out), circshift(s', dly-1)', 'b', 1:length(out), out, 'g')
grid on
subplot(2, 1, 2)
plot(1:length(err), err, 'b', 1:length(err), mean(s)*ones(size(err)), 'r')
grid on

if (mean(out) < std(s)/100) & (std(err) < std(y)*0.2)
    test_result = 1;
    fprintf('OK\n');
else
    test_result = 0;
    fprintf('Failed\n');
end

