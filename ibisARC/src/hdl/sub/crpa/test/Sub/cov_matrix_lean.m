function [M, NMult, Mspace, Mtime] = cov_matrix_lean( y, NT )

% Don't use matlab-like style! The function is a prototype for our Verilog
% and C implementation

YLENGTH = size(y, 1);
NA = size(y, 2);

Mspace = zeros(NA);
Mtime = zeros(NA, NA, NT-1);
for k = NT:YLENGTH
    Mspace = Mspace + y(k, :)' * y(k, :);
    for i = 1:NA
        for j = 1:NA
            for d = 1:(NT-1)
                Mtime(i, j, d) = Mtime(i, j, d) + y(k, i)*y(k-d, j);
            end
        end
    end
end

M = zeros(NT*NA);

ve_a = nan(1, NA*NT);
for i = 1:NA    % ve_a = repelem(1:1:NA, NT);
    for j = 1:NT
        ve_a( (i-1)*NT + j ) = i;
    end
end

ve_t = nan(1, NA*NT);
for i = 1:NA    % ve_t = repmat(0:1:NT-1, [1 NA]);
    for j = 1:NT
        ve_t( j + NT*(i-1) ) = j;
    end
end
for i = 1:NA*NT
    for j = 1:NA*NT
        if ve_t(i) > ve_t(j) % ve_a(j) раньше ve_a(i) на ve_t(i) - ve_t(j) тактов
            M(i, j) = Mtime(ve_a(j), ve_a(i), ve_t(i) - ve_t(j));
        elseif ve_t(i) < ve_t(j) % ve_a(i) раньше ve_a(j) на ve_t(j) - ve_t(i) тактов
            M(i, j) = Mtime(ve_a(i), ve_a(j), ve_t(j) - ve_t(i));
        else % одновременно - используем чисто пространственную матрицу
            if (ve_a(i) >= ve_a(j)) % Используем только нижний треугольник
                M(i, j) = Mspace(ve_a(i), ve_a(j));
            else
                M(i, j) = Mspace(ve_a(j), ve_a(i));
            end
        end
    end
end

NMult = NA^2*(NT-1) + (NA^2 + NA)/2;

end

