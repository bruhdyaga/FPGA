% Данная программа включается в функцию и разбирает её параметры из varargin
%
% Результаты записываются в виде команд Matlab в файл [TMP/test_params.m]
% Файл запускается, результаты попадают в переменные.
%
% Также можно указать параметр 'params_file' с названием файла, который будет
% запущен и заменит все введённые параметры

p = inputParser;

rand('state', sum(clock));
DefParams = [DefParams; {'params_file' ''}];
DefParams = [DefParams; {'rand_state' rand(35, 1)}];
DefParams = [DefParams; {'randn_state' fix(2^32*rand(2, 1))}];
for i=1:size(DefParams, 1)
    p.addOptional(DefParams{i, 1}, DefParams{i, 2});
end

parse(p, varargin{:});

fid = fopen([TMP 'test_params.m'], 'w');
for i=1:size(DefParams, 1)
    val = p.Results.(DefParams{i, 1});
    if ischar(val)
        cmd = sprintf('%s = ''%s'';', DefParams{i, 1}, val);
    else
        cmd = sprintf('%s = [', DefParams{i, 1});
        for j=1:length(val)
            if isnumeric(val(j))
                cmd = [cmd sprintf(' %g', val(j))];
            else
                cmd = [cmd sprintf(' %s', val(j))];
            end
        end
        cmd = [cmd '];'];
    end
    fprintf(fid, '%s\n', cmd);
end
fclose(fid);

% clear functions
% run([TMP '/test_params'])

cmd = fileread([TMP 'test_params.m']); eval(cmd);
if ~isempty(params_file)
    try
        cmd = fileread([TMP '/' params_file]); 
    catch
        fprintf('wrong params_file: %s.m\n', params_file);
        return
    end
    eval(cmd);
end

% Установка начальных значений датчиков случайных чисел
rand('state',  rand_state');
randn('state', randn_state');