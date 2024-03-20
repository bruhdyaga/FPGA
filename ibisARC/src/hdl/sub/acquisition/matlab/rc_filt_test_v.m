clear
close all hidden
clc

N = 1e6;
K=8;

% x = ones(N,1);%исходная реализация
x = abs(randn(N,1));%исходная реализация

y = zeros(N,1);
y2_test = zeros(N,1);
% a = 2^K;
% b = 1;

h = waitbar(0,'progress')

for i = 2:N
    if(mod(i,1000)==0)
        waitbar(i/N,h)
    end
    y(i) = y(i-1) + (x(i)-y(i-1))/2^K;
    y2_test(i) = (x(i)/2^K + y2_test(i-1))/(1+1/2^K);
end

close(h)


x_axs = 1:N;
plot(x_axs,x,x_axs,y,x_axs,y2_test)


std_x = std(x(fix(0.1*length(x)):end));
std_y = std(y);
fprintf('std(in) = %f\n)',std_x)
fprintf('std(out) = %f\n)',std_y)
std_x/std_y