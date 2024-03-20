close all; clc; clear
close all hidden
fclose('all');

path(path,'../automatic_facq_test/')

% %% fi TRCV
DC_NUM  = '1';
DC_MODE = '3';
DC_CHANNEL = '5';
DC_LEN  = '0';

%% prestore
DC_NUM  = '0';
DC_MODE = '3';
DC_CHANNEL = '5';
DC_LEN  = '0';

BOARD_USER = 'root';
BOARD_IP = '192.168.0.124';
BOARD_PORT = '22';
BOARD_PASSWORD = 'root';

BOARD_DC_PATH = '/tmp/';
HOST_PATH = 'G:\tmp\';
DC_EXENAME = 'datacoll';
DC_DATA_FILENAME = 'DC_data.csv';

[status,cmdout] = system(['C:/Putty/pscp.exe -P ', BOARD_PORT, ' -pw ', BOARD_PASSWORD,' ', DC_EXENAME, ' ', BOARD_USER,'@', BOARD_IP,':',BOARD_DC_PATH]);
if(status) error(cmdout); end

command = [' chmod +x ', BOARD_DC_PATH, DC_EXENAME];
[status,cmdout] = system(['C:/Putty/plink.exe -ssh -P ',BOARD_PORT,' -pw ',BOARD_PASSWORD,' ',BOARD_USER,'@',BOARD_IP, command]);
if(status) error(cmdout); end

%% parameters
F_d = 99.375e6;
T_d = 1 / F_d;
F_i = 1575.42e6-1590e6;
F_pre = 2.046e6;
N_KG = 2048;
T_KG = N_KG / F_pre;
N = fix(T_KG * F_d);
sat = 1;

%% heterodyne
i = 1 : (N * 2);
sin_ref = sin(2*pi*F_i*i*T_d); % делаем гетеродинный сигнал с запасом
cos_ref = cos(2*pi*F_i*i*T_d);
ref = cos_ref + 1i*sin_ref;

%% PRNs
PRN_CA = nan(36,N_KG);
for i = 1:36
    rc = import_prn(sprintf("..\\PSP_GPS\\psp_gps_L1_ca_%d.txt",i))'; % псп как есть в файле
    rc2 = rc(ceil((1:length(rc)*2)/2)); % растянута на 2 отсчета на чип
    prn_rep = repmat( rc2,1, ceil(N_KG/length(rc2)) ); % продублировали псп на несколько периодов
    PRN_CA(i,:) = prn_rep(1:N_KG); % нужная нам длина псп для длины БПФ
end

%% experiments
N_exp = 0;
while (1)
    command = [' ', BOARD_DC_PATH, DC_EXENAME,' -n ', DC_NUM,' -m ', DC_MODE,' -l ', DC_LEN, ' -c ', DC_CHANNEL, ' -p ', BOARD_DC_PATH];
    command = [' ', BOARD_DC_PATH, DC_EXENAME,' -n ', DC_NUM,' -m ', DC_MODE,' -l ', DC_LEN, ' -p ', BOARD_DC_PATH];
    [status,cmdout] = system(['C:/Putty/plink.exe -ssh -P ',BOARD_PORT,' -pw ',BOARD_PASSWORD,' ',BOARD_USER,'@',BOARD_IP, command]);
    if(status) error(cmdout); end
    [status,cmdout] = system(['C:/Putty/pscp.exe -P ', BOARD_PORT, ' -pw ', BOARD_PASSWORD,' ', BOARD_USER,'@', BOARD_IP,':',BOARD_DC_PATH, DC_DATA_FILENAME,' ',HOST_PATH]);% копируем файл с результатами
    if(status) error(cmdout); end
    data = csvread([HOST_PATH, DC_DATA_FILENAME])';
    
    L = length(data);
    
%     data_zero = data .* conj(ref(1:L));
%     data_pre = data_coll(real(data_zero(1:N)), N_KG) + 1i*data_coll(imag(data_zero(1:N)), N_KG);
    
    data_pre = data(1:N_KG,1)' + 1i*data(1:N_KG,2)';
%     data_pre_arr(N_exp + 1, :) = data_pre;
%     spectr(data_pre,1/2.046e6,0)
    
    N_exp = N_exp + 1;
    
    %% расчет порога
    for i = 1:N_exp
        R = abs(ifft(fft(data_pre) .* conj(fft(PRN_CA(sat + 1,:))))).^2;
        R_max_noise(N_exp) = max(R);
    end
    thr = get_thr(R_max_noise);
    Pf = sum(R_max_noise > thr) / N_exp;
    
    %% расчет обнаружения
    for i = 1:N_exp
        R = abs(ifft(fft(data_pre) .* conj(fft(PRN_CA(sat,:))))).^2;
        R_max_signal(N_exp) = max(R);
    end
    Pd = sum(R_max_signal > thr) / N_exp;
    
    
    
    fprintf("N_exp = %3d | thr = %7.2f | Pd = %.3f\n", N_exp, thr, Pd)
    plot(1:N_exp,[R_max_noise; R_max_signal; ones(1,N_exp)*thr])
    ylim([0 fix(max(R_max_signal)*1.2)])
    grid on
    title(sprintf("Pf = %.3f; Pd = %.3f; N\\_exp = %4d", Pf, Pd, N_exp))
    drawnow
end
