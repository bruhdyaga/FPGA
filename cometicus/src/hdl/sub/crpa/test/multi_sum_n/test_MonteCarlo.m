clear;
% ���� ������ multi_sum_n.v
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

Nstat = 5;   % ���������� �������������

params = {'NS'        1 64;      % ������� ������� (����� ����������� NT=order+1)
          'IN_WIDTH'  20 100};      % ����������� ������� ������



[Perr, FailedData, TestDescr] = MonteCarlo(Nstat, params);

fprintf('����������� ����: %g\n', Perr);

for i=1:size(params, 1)
    fprintf('Failed %s:\n', params{i, 1});
    unique(FailedData(2+i, :))
end
