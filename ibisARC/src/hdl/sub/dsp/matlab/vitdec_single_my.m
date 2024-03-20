function output = vitdec_single_my(raw,D)
%D - глубина декодирования перед отбрасыванием пути
%raw - массив входных данных с демодулятора

N = fix(length(raw)/2); % число полных пар входных бит с демодулятора

%код (133,171)
k = 7;           % кодовое ограничение; размер регистра сдвига кодера
Nvert = 2^(k-1); % количество вершин решетки декодера

G1 = k - [6,5,3,2]; % вычитаем, т.к. здесь использую регистр со сдвигом влево
G2 = k - [6,3,2,1];

% я не предполагаю, что нач. сост-е регистра нулевое

H_L = zeros(2,Nvert);  % массив метрик путей для каждой вершины решитки (по две метрики на каждую вершину); метрика между ближайшими уровнями
% 1-й: обратная ветвь ВВЕРХ; 2-й: обратная ветвь ВНИЗ
H = zeros(2,Nvert);  % массив метрик путей для каждой вершины решитки (по две метрики на каждую вершину); метрика всего пути
% 1-й: обратная ветвь ВВЕРХ; 2-й: обратная ветвь ВНИЗ

% матрица возврата урезана по длине для экономии ресурсов
% way = nan(Nvert,D); % матрица направления движения по решетке в обратном направлении
way = nan(Nvert,N); % матрица направления движения по решетке в обратном направлении

for i_raw = 1:N  % перебор входных данных
    fprintf('i_raw = %d:\n',i_raw)
    Ri = raw((1:2) + 2*(i_raw-1)); % принятые 2 бита между state и nstate
    fprintf('Ri[1:0] = %d%d\n',Ri(2),Ri(1))
    for i_vert = 1:Nvert % перебор вершин на текущем уровне (перебор всех состояний регистра)
        state_dec = i_vert - 1;
        state = dec2bin(state_dec);
        state = [repmat('0',1,log2(Nvert)-length(state)),state]; % бинарное состояние сдвигового регистра, младший бит справа
        
        nstate_0_dec = mod(state_dec *2,Nvert);     % более быстрый расчет; nstate_0 = [A_state(2:end),'0']; % будущее состояние регистра при приходе 0
        nstate_1_dec = mod(state_dec *2 + 1,Nvert); % более быстрый расчет; nstate_1 = [A_state(2:end),'1']; % будущее состояние регистра при приходе 1
        fprintf('state = %2d | nst_0 = %2d | nst_1 = %2d || ',state_dec,nstate_0_dec,nstate_1_dec)

        % выход комбинаторной логики
        b1_0 = mod(sum([state(G1)-'0',0]),2); % пришел бит 0  % более быстрый расчет: A_b1_0 = xor_arr([A_state(G1)-'0',0]);
        b2_0 = mod(sum([state(G2)-'0',0]),2);                 % более быстрый расчет: A_b2_0 = xor_arr([A_state(G2)-'0',0]);
        b1_1 = mod(sum([state(G1)-'0',1]),2); % пришел бит 1  % более быстрый расчет: A_b1_1 = xor_arr([A_state(G1)-'0',1]);
        b2_1 = mod(sum([state(G2)-'0',1]),2);                 % более быстрый расчет: A_b2_1 = xor_arr([A_state(G2)-'0',1]);
        %---

        fprintf('b1_0,b1_1 = %d%d b2_0,b2_1 = %d%d || ',b1_0,b1_1,b2_0,b2_1)
        %% расчет двух метрик данного перехода для входных бит 0 и 1
        H_0 = sum(xor([b2_0,b1_0],Ri)); % пришел бит 0
        H_1 = sum(xor([b2_1,b1_1],Ri)); % пришел бит 1
        fprintf('H_bb(0,1) = %d %d || ',H_0,H_1)
        %% выбор меньшей метрики с предыдущего уровня для nstate_0
        if(i_raw == 1) % 1-й уровень пропускаем
            Hmin = 0;
        else
            if(H_L(2,state_dec + 1) > H_L(1,state_dec + 1)) % выбираем обратный путь обратно ВВЕРХ
                Hmin = H_L(1,state_dec + 1); % меньшая из пар метрик
            else % выбираем обратный путь обратно ВНИЗ
                Hmin = H_L(2,state_dec + 1); % меньшая из пар метрик
            end
        end
        fprintf('Hmin = %3d\n',Hmin)

        %% расчет
       if(i_vert <= Nvert/2)
           H(1,nstate_0_dec + 1) = Hmin + H_0; % пришел бит 0
           H(1,nstate_1_dec + 1) = Hmin + H_1; % пришел бит 1
%            fprintf('H_1_0 = %2d | H_1_1 = %2d\n',H(1,nstate_0_dec + 1),H(1,nstate_1_dec + 1))
       else
           H(2,nstate_0_dec + 1) = Hmin + H_0; % пришел бит 0
           H(2,nstate_1_dec + 1) = Hmin + H_1; % пришел бит 1
%            fprintf('H_2_0 = %2d | H_2_1 = %2d\n',H(2,nstate_0_dec + 1),H(2,nstate_1_dec + 1))
        %---
       end
       
        %% way
        if((i_raw ~= 1) && (i_vert > Nvert/2))
            %% выбор обратного пути для nstate_0
            if(H(2,nstate_0_dec + 1) > H(1,nstate_0_dec + 1)) % выбираем обратный путь обратно ВВЕРХ
                way(nstate_0_dec + 1,i_raw) = 0;
            else % выбираем обратный путь обратно ВНИЗ
                way(nstate_0_dec + 1,i_raw) = 1;
            end
            %---
            % выбор обратного пути для nstate_1
            if(H(2,nstate_1_dec + 1) > H(1,nstate_1_dec + 1)) % выбираем обратный путь обратно ВВЕРХ
                way(nstate_1_dec + 1,i_raw) = 0;
            else % выбираем обратный путь обратно ВНИЗ
                way(nstate_1_dec + 1,i_raw) = 1;
            end
%             fprintf('nstate_0_dec = %2d | H_2 = %d | H_1 = %d | way = %d\n',nstate_0_dec,H(2,nstate_0_dec + 1),H(1,nstate_0_dec + 1),way(nstate_0_dec + 1,i_raw-1))
%             fprintf('nstate_1_dec = %2d | H_2 = %d | H_1 = %d | way = %d\n',nstate_1_dec,H(2,nstate_1_dec + 1),H(1,nstate_1_dec + 1),way(nstate_1_dec + 1,i_raw-1))
        end
%         fprintf('nstate_0_dec = %d | H_0 = %d | H_1 = %d\n',nstate_0_dec,H(1,nstate_0_dec + 1),H(2,nstate_0_dec + 1))
%         fprintf('nstate_1_dec = %d | H_0 = %d | H_1 = %d\n',nstate_1_dec,H(1,nstate_1_dec + 1),H(2,nstate_1_dec + 1))
        %% последний уровень, поиск наименьшей метрики
        if((i_raw == N) && (i_vert > Nvert/2))
            min_0 = min(H(:,nstate_0_dec + 1));
            min_1 = min(H(:,nstate_1_dec + 1));
            if(i_vert == Nvert/2 + 1)
                Hmin_end = min_0;
                Hmin_num = nstate_0_dec + 1; % номер победившей ветви (номер вершины на последнем уровне)
            end
            if(min_0 < Hmin_end)
                Hmin_end = min_0;
                Hmin_num = nstate_0_dec + 1; % номер победившей ветви (номер вершины на последнем уровне)
            end
            if(min_1 < Hmin_end)
                Hmin_end = min_1;
                Hmin_num = nstate_1_dec + 1; % номер победившей ветви (номер вершины на последнем уровне)
            end
        end
        
    end
    
        for i_h = 1:Nvert
            fprintf('state = %2d || H(1,0) = %2d,%2d\n',i_h-1,H(2,i_h),H(1,i_h))
        end
    
    fprintf('--------------------------------------------------------\n')
    H_L = H; % зеркалируем метрики
    
    % debug
    %     for i_vert = 1:Nvert
    %         fprintf('state= %2d H_0 = %2d | H_1 = %2d | way = %d\n',i_vert-1,H(1,i_vert),H(2,i_vert),way(i_vert))
    %     end
    
end

output = zeros(1,N); % инициализация массива декодированных данных

fprintf('Hmin_end = %d\n',Hmin_end)
fprintf('Hmin_num = %d\n',Hmin_num)

% state_dec = Hmin_num;
state = dec2bin(Hmin_num - 1);
state = [repmat('0',1,log2(Nvert)-length(state)),state]; % бинарное состояние сдвигового регистра, младший бит справа
for i_raw = N:-1:1  % обратный путь по выжившей ветви
        fprintf('N = %2d | state = %s || ',i_raw-1,state)
    output(i_raw) = state(k-1) - '0';
    if(i_raw ~= 1)
        state_dec = bin2dec(state) + 1;
        state = [dec2bin(way(state_dec,i_raw)),state(1:5)];
        fprintf('i_raw = %2d | state = %s | state_dec = %2d | way = %d\n',i_raw-1,state,state_dec-1,way(state_dec,i_raw))
    else
        fprintf('\n')
    end
end

% fprintf('max_H = %f\n',max(max(H)))
% H

end