function [M NMult err] = raw2mtrx_dumb( raw, NA, NT )

le = length(raw);
NMult = 0;

NTNA = NT * NA;
M = nan(NTNA);

err = 0;
if le < NTNA
    err = 1;
    fprintf('cov_matrix: A number of output elements is too small\n');
    return;
end

k = 0;
for i = 1 : NTNA
    for j = 1:i
        k = k + 1;
        M(i, j) = raw(k);
        M(j, i) = M(i, j);
    end
end

NMult = k;

end

