function [M, NMult, Mspace, Mtime] = y2cvm( y, NT, sel )

Mspace = 0; Mtime = 0;

NCh = size(y, 2);
if sel == 0
    branches = 1:fix(NCh/2);
    NTi = NT;
    [M, NMult, Mspace, Mtime] = cov_matrix_lean(y(:, branches), NTi);
elseif sel == 1
    branches = (1:fix(NCh/2)) + fix(NCh/2);
    NTi = NT;
    [M, NMult, Mspace, Mtime] = cov_matrix_lean(y(:, branches), NTi);
elseif sel == 2
    branches = 1:NCh;
    NTi = 1;
    [M, NMult] = cov_matrix_dumb(y(:, branches), NTi);
elseif sel == 3
    branches = 1:NCh;
    NTi = NT;
    [M, NMult, Mspace, Mtime] = cov_matrix_lean(y(:, branches), NTi);
end

end

