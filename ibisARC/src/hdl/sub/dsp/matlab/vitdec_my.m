function output = vitdec_my(raw,D)
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
%     fprintf('i_raw = %d:\n',i_raw)
    Ri = raw((1:2) + 2*(i_raw-1)); % �������� 2 ���� ����� state � nstate
%     fprintf('Ri[1:0] = %d%d\n',Ri(2),Ri(1))
    for i_vert = 1:Nvert/2 % ������� ������ �� ������� ������ (������� ���� ��������� ��������); ����������� ������������ ��� �������� ������ (A,B)
        
        % ����������� ������������� ��� �������� ������, ������� � ���� �
        % �� �� ������� ���������� ���������
        A_state_dec = i_vert - 1;
        A_state = dec2bin(A_state_dec);
        A_state = [repmat('0',1,log2(Nvert)-length(A_state)),A_state]; % �������� ��������� ���������� ��������, ������� ��� ������
        
        nstate_0_dec = A_state_dec *2;     % ����� ������� ������; nstate_0 = [A_state(2:end),'0']; % ������� ��������� �������� ��� ������� 0
        nstate_1_dec = A_state_dec *2 + 1; % ����� ������� ������; nstate_1 = [A_state(2:end),'1']; % ������� ��������� �������� ��� ������� 1
        %---
        B_state_dec = i_vert - 1 + Nvert/2;
        B_state = dec2bin(B_state_dec);
        B_state = [repmat('0',1,log2(Nvert)-length(B_state)),B_state]; % �������� ��������� ���������� ��������, ������� ��� ������
        
        % ����� ������������� ������
        A_b1_0 = mod(sum([A_state(G1)-'0',0]),2); % ������ ��� 0  % ����� ������� ������: A_b1_0 = xor_arr([A_state(G1)-'0',0]);
        A_b2_0 = mod(sum([A_state(G2)-'0',0]),2);                 % ����� ������� ������: A_b2_0 = xor_arr([A_state(G2)-'0',0]);
        A_b1_1 = mod(sum([A_state(G1)-'0',1]),2); % ������ ��� 1  % ����� ������� ������: A_b1_1 = xor_arr([A_state(G1)-'0',1]);
        A_b2_1 = mod(sum([A_state(G2)-'0',1]),2);                 % ����� ������� ������: A_b2_1 = xor_arr([A_state(G2)-'0',1]);
        %---
        B_b1_0 = mod(sum([B_state(G1)-'0',0]),2); % ������ ��� 0  % ����� ������� ������: B_b1_0 = xor_arr([B_state(G1)-'0',0]);
        B_b2_0 = mod(sum([B_state(G2)-'0',0]),2);                 % ����� ������� ������: B_b2_0 = xor_arr([B_state(G2)-'0',0]);
        B_b1_1 = mod(sum([B_state(G1)-'0',1]),2); % ������ ��� 1  % ����� ������� ������: B_b1_1 = xor_arr([B_state(G1)-'0',1]);
        B_b2_1 = mod(sum([B_state(G2)-'0',1]),2);                 % ����� ������� ������: B_b2_1 = xor_arr([B_state(G2)-'0',1]);
        %         fprintf('state = %2d || A_b1_0 = %d | A_b2_0 = %d | A_b1_1 = %d | A_b2_1 = %d ||| B_b1_0 = %d | B_b2_0 = %d | B_b1_1 = %d | B_b2_1 = %d\n',i_vert-1,A_b1_0,A_b2_0,A_b1_1,A_b2_1, B_b1_0,B_b2_0,B_b1_1,B_b2_1)
        
        %% ������ ���� ������ ������� �������� ��� ������� ��� 0 � 1
        A_H_0 = sum(xor([A_b2_0,A_b1_0],Ri)); % ������ ��� 0
        A_H_1 = sum(xor([A_b2_1,A_b1_1],Ri)); % ������ ��� 1
        %---
        B_H_0 = sum(xor([B_b2_0,B_b1_0],Ri)); % ������ ��� 0
        B_H_1 = sum(xor([B_b2_1,B_b1_1],Ri)); % ������ ��� 1
        %         fprintf('A_H = %d %d ||| B_H %d %d\n',A_H_1,A_H_0,B_H_1,B_H_0)
        %% ����� ������� ������� � ����������� ������ ��� nstate_0
        if(i_raw == 1) % 1-� ������� ����������
            A_Hmin = 0;
        else
            if(H_L(2,A_state_dec + 1) > H_L(1,A_state_dec + 1)) % �������� �������� ���� ������� �����
                A_Hmin = H_L(1,A_state_dec + 1); % ������� �� ��� ������
            else % �������� �������� ���� ������� ����
                A_Hmin = H_L(2,A_state_dec + 1); % ������� �� ��� ������
            end
        end
        %---
        % ����� ������� ������� � ����������� ������ ��� nstate_1
        if(i_raw == 1) % 1-� ������� ����������
            B_Hmin = 0;
        else
            if(H_L(2,B_state_dec + 1) > H_L(1,B_state_dec + 1)) % �������� �������� ���� ������� �����
                B_Hmin = H_L(1,B_state_dec + 1); % ������� �� ��� ������
            else % �������� �������� ���� ������� ����
                B_Hmin = H_L(2,B_state_dec + 1); % ������� �� ��� ������
            end
        end
        
        %% ������
        %         H_L(1,nstate_0_dec + 1) = A_H_0; % ������ ��� 0
        %         H_L(2,nstate_0_dec + 1) = B_H_0;
        H(1,nstate_0_dec + 1) = A_Hmin + A_H_0; % ������ ��� 0
        H(2,nstate_0_dec + 1) = B_Hmin + B_H_0;
        %---
        %         H_L(1,nstate_1_dec + 1) = A_H_1; % ������ ��� 0
        %         H_L(2,nstate_1_dec + 1) = B_H_1;
        H(1,nstate_1_dec + 1) = A_Hmin + A_H_1; % ������ ��� 1
        H(2,nstate_1_dec + 1) = B_Hmin + B_H_1;
        
        %% way
        if(i_raw ~= 1)
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
%         fprintf('state = %2d | nstate_0_dec = %2d | H_1_0 = %d | H_2_0 = %d\n',A_state_dec,nstate_0_dec,H(1,nstate_0_dec + 1),H(2,nstate_0_dec + 1))
%         fprintf('state = %2d | nstate_1_dec = %2d | H_1_1 = %d | H_2_1 = %d\n',A_state_dec,nstate_1_dec,H(1,nstate_1_dec + 1),H(2,nstate_1_dec + 1))
        %% ��������� �������, ����� ���������� �������
        if(i_raw == N)
            min_0 = min(H(:,nstate_0_dec + 1));
            min_1 = min(H(:,nstate_1_dec + 1));
            if(i_vert == 1)
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
        
        %%
        %         fprintf('L=%2d|bit=0|Ri=%d%d|A_state= %2d|nstate= %2d|b2,b1 = %d,%d | A_H = %d ||| ',i_raw,Ri,i_vert-1,nstate_0_dec,A_b2_0,A_b1_0,A_H_0)
        %         fprintf('B_state= %2d|b2,b1 = %d,%d | B_H = %d\n',i_vert-1 + Nvert/2,B_b2_0,B_b1_0,B_H_0)
        %
        %         fprintf('L=%2d|bit=1|Ri=%d%d|A_state= %2d|nstate= %2d|b2,b1 = %d,%d | A_H = %d ||| ',i_raw,Ri,i_vert-1,nstate_1_dec,A_b2_1,A_b1_1,A_H_1)
        %         fprintf('B_state= %2d|b2,b1 = %d,%d | B_H = %d\n',i_vert-1 + Nvert/2,B_b2_1,B_b1_1,B_H_1)
    end
    
    %     for i_h = 1:Nvert
    %         fprintf('state = %2d || H = %2d %2d\n',i_h-1,H(2,i_h),H(1,i_h))
    %     end
    
%     fprintf('--------------------------------------------------------\n')
    H_L = H; % ����������� �������
    
    % debug
    %     for i_vert = 1:Nvert
    %         fprintf('state= %2d H_0 = %2d | H_1 = %2d | way = %d\n',i_vert-1,H(1,i_vert),H(2,i_vert),way(i_vert))
    %     end
    
end

output = zeros(1,N); % ������������� ������� �������������� ������

% fprintf('Hmin_end = %d\n',Hmin_end)
% fprintf('Hmin_num = %d\n',Hmin_num)

% state_dec = Hmin_num;
A_state = dec2bin(Hmin_num - 1);
A_state = [repmat('0',1,log2(Nvert)-length(A_state)),A_state]; % �������� ��������� ���������� ��������, ������� ��� ������
for i_raw = N:-1:1  % �������� ���� �� �������� �����
%         fprintf('N = %2d | A_state = %s || ',i_raw-1,A_state)
    output(i_raw) = A_state(k-1) - '0';
    if(i_raw ~= 1)
        state_dec = bin2dec(A_state) + 1;
        A_state = [dec2bin(way(state_dec,i_raw)),A_state(1:5)];
%         fprintf('i_raw = %2d | A_state = %s | state_dec = %2d | way = %d\n',i_raw-1,A_state,state_dec-1,way(state_dec,i_raw))
    else
%         fprintf('\n')
    end
end

% fprintf('max_H = %f\n',max(max(H)))
% H

end