clear;
addpath('../Sub');
% ���� ������ NullFormer.v
% 
% ������������ ����� �����-�����. ��� ����������, ������� ����� ��������,
% ��������� ������� ���������� �������� � �������� ��������.
% ����������� ���� test.m, �������������� ������������� � Matlab � modelsim.
%
% ��� ������� ����������� ���� ��������� �� ����������
% � ���������� ���������� ����������� ���������� ����������� �����
% � ������ �������� ����������, ��� ������� ���� ��������.
%
% � �������� tmp ����������� ����� � ��������� test_params_failed_X.m
% ����� � ��������� ����� test.m �������� ������ �� ���� ������, ����� ���������
% ��������� ���� � ����������� � ��������

Nstat = 20;   % ���������� �������������

params = {'NCH'         3   8;      % ���������� ������
          'DIRECT_CH'   1   2;      % ������ �����
          'NT'          2   4;      % ����� �����������
          'input_width' 14 14;      % ����������� ������� ������
          'coeff_width' 14 14;};    % ����������� �������������


[Perr, FailedData, TestDescr] = MonteCarlo(Nstat, params);

fprintf('����������� ����: %g\n', Perr);
FailedData