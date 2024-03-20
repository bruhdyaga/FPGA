function [test_result] = compare(y, out, Td)
% function [res] = compare(y, out)
% 
% Данная функция сравнивает два массива. По-умному

corr = vkf_nan(out, y); 
[M vdly] = max(abs(corr));
if (vdly > 100)
    vdly = 1;
end
% fprintf('Дополнительная задержка в модуле: %d тактов\n', vdly);

% ==== Построение графиков процессов ====
NC = min(length(y), length(out)-vdly);  % Наименьшая общая длина

% Откидывание Nan
SKIP = max(find(isnan(out(vdly+ (0:NC-1))))); 
if (SKIP > 100)
    SKIP
    test_result = 0;
    return
end
if isempty(SKIP)
    SKIP = 0;
end

subplot(2, 1, 1);
plot(Td*(SKIP:NC-1), y(1+SKIP:NC), 'b')
hold on
plot(Td*(SKIP:NC-1), out(vdly + (SKIP:NC-1)), 'r')
grid on
hold off
xlabel('t, c');
ylabel('y, out');

% ==== Построение графика разности процессов ====
subplot(2, 1, 2);
plot(Td*(SKIP:NC-1), y(1+SKIP:NC) - out(vdly+ (SKIP:NC-1)), 'r')
xlabel('t, c');
ylabel('y - out');


if sum(abs( y(1+SKIP:NC) - out(vdly+ (SKIP:NC-1)) )) == 0
    test_result = 1;
    fprintf('OK\n');
else
    test_result = 0;
    fprintf('Fail\n');
end

