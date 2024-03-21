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

% Spatial part
Mspace = nan(NA);
k = 0;
for i = 1 : NA
    for j = 1:i
        k = k + 1;
        Mspace(i, j) = raw(k);
        Mspace(j, i) = Mspace(i, j);
    end
end

% Time part
CF_sh = k;
Mtime = nan(NA, NA, NT-1);
k = 0;
for i = 1 : NA
    for j = 1 : NA
        for d = 1:NT-1
            k = k + 1;
                Mtime(i, j, d) = raw(k + CF_sh);
        end
    end
end
NMult = k + CF_sh;

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





end

