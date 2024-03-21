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

addpath('../Sub');

Nstat = 30;   % ���������� �������������

params = {'NS'        1 64;       % ������� ������� (����� ����������� NT=order+1)
          'IN_WIDTH'  1 55};      % ����������� ������� ������



[Perr, FailedData, TestDescr] = MonteCarlo(Nstat, params);

fprintf('����������� ����: %g\n', Perr);

if ~isempty(FailedData)
    for i=1:size(params, 1)
        fprintf('Failed %s:\n', params{i, 1});
        unique(FailedData(i, :))
    end

    A = params{1, 2}:params{1, 3};
    B = params{2, 2}:params{2, 3};
    res = zeros(length(A), length(B));
    for i=1:size(FailedData, 2)
        indA = find(A==FailedData(1, i));
        indB = find(B==FailedData(2, i));
        if (~isempty(indA)) & (~isempty(indB))
            res(indA(1), indB(1)) = 1;
        end
    end

    %imshow(res)
end
    