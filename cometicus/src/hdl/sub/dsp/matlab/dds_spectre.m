clc
clear
% close all hidden


Ph_dig = 5; % �������� ����
Fd = 100e6;
Fsynth = 1.023e6;
T = 1e-1;

Td = 1/Fd;
Nd = fix(T/Td);

max32 = 2^32;
max_ph = 2^Ph_dig;
code = fix(Fsynth/Fd*max32);

garm = zeros(1,Nd);
per  = zeros(1,ceil(T*Fsynth)); % ����� ������� �� ������������� ��������
sum = 0; % ������������� ��������

j = 1;
for i = 1:Nd
    sum = sum + code;
    if(sum >= max32)
        sum = sum - max32;
        j = j + 1;
    end
    per(j) = per(j) + 1;
    phase = fix(sum/2^(32-Ph_dig));
    garm(i) = sin(phase/max_ph*2*pi);
end
per(j)=nan; % ��������� �� � ����
per(per==0) = nan;

figure(1)
spectr(garm,Td,0)

figure(2)
tx = (1:length(per))/length(per)*T;
plot(tx,per,'.-')
xlabel('time, sec')