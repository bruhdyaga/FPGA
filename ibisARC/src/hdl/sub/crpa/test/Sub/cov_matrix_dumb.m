function [M, NMult] = cov_matrix_dumb( y, NT )

YLENGTH = size(y, 1);
NA = size(y, 2);
NTNA = NT * NA;

M = zeros(NT*NA);
y_in = nan(NT*NA, 1);

for k = NT:YLENGTH
    for i = 1:NA
        pos = (i-1)*NT;
        y_in(pos+1:pos+NT) = y(k:-1:k-NT+1, i);
    end
    M = M + y_in*y_in';
end

NMult = (NTNA*NTNA + NTNA) / 2;

end

