function [Perr, FailedData, TestDescr] = MonteCarlo(NMCstat, params)
% function [Perr, FailedData, TestDescr] = MonteCarlo(NMCstat, params)
%
% ���� �����-����� ��� �������� ���� ����������
% ��������� ������� �������� ��������� ���������� ������������ ������
% � ��������� ������� ��� ��������� ����������
% ������� ���������:
%   NMCstat  - ���������� �������������
%   params - ������ ���������� - cell: ���, �������, ��������
%      params = {'order' 1 3; 'width' 10 20}
% �������� ���������
%   Perr       - ����������� ������
%   FailedData - ������ �������� ����������, ��� ������� ��������� ����
%   TestDescr  - ������ �������� ����������

% ���������� �������� ��� ��������� ������
TMP='tmp/';  system(['if [ ! -d ' TMP ' ]; then mkdir ' TMP ' ; fi']);
system(['rm -f ' TMP 'test_params_fail*']);

res.iP = 1;

FailCnt = 0;
tstat = tic;
for iStat = 1:NMCstat
    if iStat > 1
        fprintf('MonteCarlo test  %5d / %5d (%g c)\n', iStat, NMCstat, toc(tstat)/(iStat-1)*(NMCstat-iStat+1));
    else
        fprintf('MonteCarlo test  %5d / %5d\n', iStat, NMCstat);
    end

    % ======== ����� ����������� ���������� ========
    ParamVals = {};
    
    res.iP = 1;
    % ��������� ��������� ������� ��������� �����
    %    randn('state', 0);
    rand('state', sum(clock));
    
    % ��������� ������������ ������
    for i=1:size(params, 1)
        val = rand_lim( [params{i, 2} params{i, 3}]);
        eval(sprintf('%s = %d;\n', params{i, 1}, val));
        res = Store(params{i, 1}, val, res, iStat);
        
        ParamVals = [ParamVals {params{i, 1} val}];

    end

    % ======== ������ ����� ========
    test_result = test(ParamVals{:});
    
    % ======== ������ ����������� ========
    if test_result == 1  % ���� ������ �������
        res.TestRes(iStat) = 1;
    else                 % ���� �� �������
        res.TestRes(iStat) = 0;
        
        % ���������� ����������� ������������ ��� ��������
        system(sprintf('cp tmp/test_params.m tmp/test_params_fail_%d.m', FailCnt)); FailCnt=FailCnt+1;
    end

end

Perr = 1-mean(res.TestRes);
%fprintf('����������� ����: %g\n', Perr);

ind = find(res.TestRes == 0);
FailedData = res.TestData(:, ind);

TestDescr = res.TestDescr;


function [res] = Store(ParamName, Value, res, iStat)
% ���������� ��������� �� ���������� ��������� ���������
   n = length(Value);

   if iStat < 2
       res.TestDescr{res.iP} = ParamName;
   end
   res.TestData(res.iP+(0:n-1), iStat) = Value; 
   res.iP = res.iP+n;

