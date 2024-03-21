clear all; clc; close all;

addpath('../Sub');

YLENGTH   = 1000;
NA = 4;
NT = 3;
NANT = NA*NT;

% Model without delays
% y = nan(YLENGTH, NA);
% W = rand(NA) - 0.5;
% K = 0.5;
% yold = W*randn(NA, 1);
% yold = yold.';
% for k = 1:YLENGTH
%     yseed = W*randn(NA, 1);
%     ynew = yold + K*(yseed.' - yold);
%     y(k, :) = ynew;
%     yold = ynew;
% end
% ------------------

% Model with delays and multipath

NX = 10;
% Create time-correlated process
    x = nan(NX+YLENGTH, 1);
    K = 0.3;
    xold = randn(1, 1);
    for k = 1:NX+YLENGTH
        xseed = randn(1, 1);
        xnew = xold + K*(xseed.' - xold);
        x(k) = xnew;
        xold = xnew;
    end
% end create

% Create spatial-time correlated processes
    y = nan(YLENGTH, NA);
    W = rand(NA, NX);
    for i = 1:NA
        W(i, :) = 1*W(i, :) / sum(W(i, :)); % Многолучевая случайная помеха с единичным уровнем
        ind = ceil(NX/2);
        W(i, ind) = W(i, ind) + 2*1;            % Помеха с зенита без задержек в трактах
        ind = ceil(rand(1, 1)*NX);
        W(i, ind) = W(i, ind) + 1*1;        % Задержанная помеха, попадающая точно в случайный такт
    end
    for k = 1:YLENGTH
        Xk = x(k : k+NX-1);
        y(k, :) = (W*Xk)';
    end
% end create

% ------------------

[Md, NMd] = cov_matrix_dumb( y, NT );
[Ml, NMl, Mspace, Mtime] = cov_matrix_lean( y, NT );

figure(1)
Ns = 1; Ms = 2; ks = 0;

ks = ks + 1; ha = subplot(Ns, Ms, ks);
plot_matrix(ha, Md);
title({'Before:', ['Matrix ' num2str(NA) 'x' num2str(NT) ': ' num2str(NMd) ' multipliers']});

ks = ks + 1; ha = subplot(Ns, Ms, ks);
plot_matrix(ha, Ml);
title({'After:', ['Matrix ' num2str(NA) 'x' num2str(NT) ': ' num2str(NMl) ' multipliers']});

figure(2)
Ns = 1; Ms = 2; ks = 0;

ks = ks + 1; ha = subplot(Ns, Ms, ks);
Err = (Ml - Md );
plot_matrix(ha, Err);
title(['Max Err = ' num2str(max(max(abs(Err)))) ', mean Err = ' num2str(mean(mean((abs(Err)))))]);

ks = ks + 1; ha = subplot(Ns, Ms, ks);
ErrPer = (Ml - Md) ./ Md * 100;
plot_matrix(ha, ErrPer);
title(['Max Err = ' num2str(max(max(abs(ErrPer)))) '%, mean Err = ' num2str(mean(mean((abs(ErrPer))))) '%']);


figure(3);
MT = permute(Mtime, [3 1 2]);
k = 0;
for i = 1:NA
    for j = 1:NA
        k = k + 1;
        if (j <= i)
            subplot(NA, NA, k);
            plot(-NT+1:NT-1, [MT(end:-1:1, i, j)' Mspace(i, j) MT(:, j, i)']);
        end
    end
end
