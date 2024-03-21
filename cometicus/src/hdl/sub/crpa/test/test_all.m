clear;

orig_path = path;

TestList = {'multi_sum_n';
            'piped_adder';
            'kix_filter_n';
            'BeamFormer_n';
            'NullFormer_n';
            'fir_filter';
            'NullFormer';
            'BeamFormer';
            'cov_matrix';
            'CRPA'
            };

TestResults = zeros(size(TestList, 1), 1);
TestTime = zeros(size(TestList, 1), 1);
      
            
for i=1:size(TestList, 1)
    fprintf('Test: %s  (%d / %d)\n', TestList{i}, i, size(TestList, 1));

    tTestStart = tic;
    cd(TestList{i})
    rc = test();
    TestResults(i) = rc;
    TestTime(i) = toc(tTestStart);
    cd('..')
    
end

fprintf('\n\n\n\n');

for i=1:size(TestList, 1)
    fprintf('%30s:    ', TestList{i});
    if (TestResults(i)==1)
        fprintf('OK    ');
    else
        fprintf('Failed');
    end
    fprintf(' (%g c)\n', TestTime(i));
end