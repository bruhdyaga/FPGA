function output = vitdec_single_my(raw,D)
%D - ������� ������������� ����� ������������� ����
%raw - ������ ������� ������ � ������������

N = fix(length(raw)/2); % ����� ������ ��� ������� ��� � ������������

%��� (133,171)
k = 7;           % ������� �����������; ������ �������� ������ ������
Nvert = 2^(k-1); % ���������� ������ ������� ��������

G1 = k - [6,5,3,2]; % ��������, �.�. ����� ��������� ������� �� ������� �����
G2 = k - [6,3,2,1];

% � �� �����������, ��� ���. ����-� �������� �������

H_L = zeros(2,Nvert);  % ������ ������ ����� ��� ������ ������� ������� (�� ��� ������� �� ������ �������); ������� ����� ���������� ��������
% 1-�: �������� ����� �����; 2-�: �������� ����� ����
H = zeros(2,Nvert);  % ������ ������ ����� ��� ������ ������� ������� (�� ��� ������� �� ������ �������); ������� ����� ����
% 1-�: �������� ����� �����; 2-�: �������� ����� ����

% ������� �������� ������� �� ����� ��� �������� ��������
% way = nan(Nvert,D); % ������� ����������� �������� �� ������� � �������� �����������
way = nan(Nvert,N); % ������� ����������� �������� �� ������� � �������� �����������

for i_raw = 1:N  % ������� ������� ������
    fprintf('i_raw = %d:\n',i_raw)
    Ri = raw((1:2) + 2*(i_raw-1)); % �������� 2 ���� ����� state � nstate
    fprintf('Ri[1:0] = %d%d\n',Ri(2),Ri(1))
    for i_vert = 1:Nvert % ������� ������ �� ������� ������ (������� ���� ��������� ��������)
        state_dec = i_vert - 1;
        state = dec2bin(state_dec);
        state = [repmat('0',1,log2(Nvert)-length(state)),state]; % �������� ��������� ���������� ��������, ������� ��� ������
        
        nstate_0_dec = mod(state_dec *2,Nvert);     % ����� ������� ������; nstate_0 = [A_state(2:end),'0']; % ������� ��������� �������� ��� ������� 0
        nstate_1_dec = mod(state_dec *2 + 1,Nvert); % ����� ������� ������; nstate_1 = [A_state(2:end),'1']; % ������� ��������� �������� ��� ������� 1
        fprintf('state = %2d | nst_0 = %2d | nst_1 = %2d || ',state_dec,nstate_0_dec,nstate_1_dec)

        % ����� ������������� ������
        b1_0 = mod(sum([state(G1)-'0',0]),2); % ������ ��� 0  % ����� ������� ������: A_b1_0 = xor_arr([A_state(G1)-'0',0]);
        b2_0 = mod(sum([state(G2)-'0',0]),2);                 % ����� ������� ������: A_b2_0 = xor_arr([A_state(G2)-'0',0]);
        b1_1 = mod(sum([state(G1)-'0',1]),2); % ������ ��� 1  % ����� ������� ������: A_b1_1 = xor_arr([A_state(G1)-'0',1]);
        b2_1 = mod(sum([state(G2)-'0',1]),2);                 % ����� ������� ������: A_b2_1 = xor_arr([A_state(G2)-'0',1]);
        %---

        fprintf('b1_0,b1_1 = %d%d b2_0,b2_1 = %d%d || ',b1_0,b1_1,b2_0,b2_1)
        %% ������ ���� ������ ������� �������� ��� ������� ��� 0 � 1
        H_0 = sum(xor([b2_0,b1_0],Ri)); % ������ ��� 0
        H_1 = sum(xor([b2_1,b1_1],Ri)); % ������ ��� 1
        fprintf('H_bb(0,1) = %d %d || ',H_0,H_1)
        %% ����� ������� ������� � ����������� ������ ��� nstate_0
        if(i_raw == 1) % 1-� ������� ����������
            Hmin = 0;
        else
            if(H_L(2,state_dec + 1) > H_L(1,state_dec + 1)) % �������� �������� ���� ������� �����
                Hmin = H_L(1,state_dec + 1); % ������� �� ��� ������
            else % �������� �������� ���� ������� ����
                Hmin = H_L(2,state_dec + 1); % ������� �� ��� ������
            end
        end
        fprintf('Hmin = %3d\n',Hmin)

        %% ������
       if(i_vert <= Nvert/2)
           H(1,nstate_0_dec + 1) = Hmin + H_0; % ������ ��� 0
           H(1,nstate_1_dec + 1) = Hmin + H_1; % ������ ��� 1
%            fprintf('H_1_0 = %2d | H_1_1 = %2d\n',H(1,nstate_0_dec + 1),H(1,nstate_1_dec + 1))
       else
           H(2,nstate_0_dec + 1) = Hmin + H_0; % ������ ��� 0
           H(2,nstate_1_dec + 1) = Hmin + H_1; % ������ ��� 1
%            fprintf('H_2_0 = %2d | H_2_1 = %2d\n',H(2,nstate_0_dec + 1),H(2,nstate_1_dec + 1))
        %---
       end
       
        %% way
        if((i_raw ~= 1) && (i_vert > Nvert/2))
            %% ����� ��������� ���� ��� nstate_0
            if(H(2,nstate_0_dec + 1) > H(1,nstate_0_dec + 1)) % �������� �������� ���� ������� �����
                way(nstate_0_dec + 1,i_raw) = 0;
            else % �������� �������� ���� ������� ����
                way(nstate_0_dec + 1,i_raw) = 1;
            end
            %---
            % ����� ��������� ���� ��� nstate_1
            if(H(2,nstate_1_dec + 1) > H(1,nstate_1_dec + 1)) % �������� �������� ���� ������� �����
                way(nstate_1_dec + 1,i_raw) = 0;
            else % �������� �������� ���� ������� ����
                way(nstate_1_dec + 1,i_raw) = 1;
            end
%             fprintf('nstate_0_dec = %2d | H_2 = %d | H_1 = %d | way = %d\n',nstate_0_dec,H(2,nstate_0_dec + 1),H(1,nstate_0_dec + 1),way(nstate_0_dec + 1,i_raw-1))
%             fprintf('nstate_1_dec = %2d | H_2 = %d | H_1 = %d | way = %d\n',nstate_1_dec,H(2,nstate_1_dec + 1),H(1,nstate_1_dec + 1),way(nstate_1_dec + 1,i_raw-1))
        end
%         fprintf('nstate_0_dec = %d | H_0 = %d | H_1 = %d\n',nstate_0_dec,H(1,nstate_0_dec + 1),H(2,nstate_0_dec + 1))
%         fprintf('nstate_1_dec = %d | H_0 = %d | H_1 = %d\n',nstate_1_dec,H(1,nstate_1_dec + 1),H(2,nstate_1_dec + 1))
        %% ��������� �������, ����� ���������� �������
        if((i_raw == N) && (i_vert > Nvert/2))
            min_0 = min(H(:,nstate_0_dec + 1));
            min_1 = min(H(:,nstate_1_dec + 1));
            if(i_vert == Nvert/2 + 1)
                Hmin_end = min_0;
                Hmin_num = nstate_0_dec + 1; % ����� ���������� ����� (����� ������� �� ��������� ������)
            end
            if(min_0 < Hmin_end)
                Hmin_end = min_0;
                Hmin_num = nstate_0_dec + 1; % ����� ���������� ����� (����� ������� �� ��������� ������)
            end
            if(min_1 < Hmin_end)
                Hmin_end = min_1;
                Hmin_num = nstate_1_dec + 1; % ����� ���������� ����� (����� ������� �� ��������� ������)
            end
        end
        
    end
    
        for i_h = 1:Nvert
            fprintf('state = %2d || H(1,0) = %2d,%2d\n',i_h-1,H(2,i_h),H(1,i_h))
        end
    
    fprintf('--------------------------------------------------------\n')
    H_L = H; % ����������� �������
    
    % debug
    %     for i_vert = 1:Nvert
    %         fprintf('state= %2d H_0 = %2d | H_1 = %2d | way = %d\n',i_vert-1,H(1,i_vert),H(2,i_vert),way(i_vert))
    %     end
    
end

output = zeros(1,N); % ������������� ������� �������������� ������

fprintf('Hmin_end = %d\n',Hmin_end)
fprintf('Hmin_num = %d\n',Hmin_num)

% state_dec = Hmin_num;
state = dec2bin(Hmin_num - 1);
state = [repmat('0',1,log2(Nvert)-length(state)),state]; % �������� ��������� ���������� ��������, ������� ��� ������
for i_raw = N:-1:1  % �������� ���� �� �������� �����
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