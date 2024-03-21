function [M, NMult, err] = maccs2cvm( row, NCh, NT, sel )

if sel == 0
    NSp = fix(NCh/2);
    NTi = NT;
    [M, NMult, err] = raw2mtrx_lean( row, NSp, NTi );
elseif sel == 1
    NSp = fix(NCh/2);
    NTi = NT;
    [M, NMult, err] = raw2mtrx_lean( row, NSp, NTi );
elseif sel == 2
    NSp = NCh;
    NTi = 1;
    [M, NMult, err] = raw2mtrx_dumb( row, NSp, NTi );
elseif sel == 3
    NSp = NCh;
    NTi = NT;
    [M, NMult, err] = raw2mtrx_lean( row, NSp, NTi );
end

end

