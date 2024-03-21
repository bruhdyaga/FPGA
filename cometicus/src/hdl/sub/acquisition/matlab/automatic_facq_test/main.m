clc
clear
fclose('all');
close all hidden
delete *.txt

% необходимо, чтобы количество сигналов не было меньше блоков поиска иначе
% будут коррелированные результаты

disp_en = 0; % вывод консоли SSH

SigType = 'GpsL1CA';
Board = 'Samtec'; % 'Samtec' or 'BlackBox'
Nexp = 10;
Nexp_thr = Nexp*5;
Kg = 1;
tau_ms = 1;
freq_dop = 10000;

switch(Board)
    case 'Samtec' % Impala type
        fi = 7560000; % OryxADCBoard
        ssh.IP{1} = '192.168.0.66';
        ssh.IP{2} = '192.168.0.68';
        ssh.IP{3} = '192.168.0.69';
        ssh.IP{4} = '192.168.0.162';
        MUX_NUM{1} = 1;
        MUX_NUM{2} = 1;
        MUX_NUM{3} = 2;
        MUX_NUM{4} = 2;
        Testbed = 'Impala';
        Freq = fi;
        Fd = 100000000;
    case 'BlackBox'
        fi = -14580000; % OryxPortable
        ssh.IP = '192.168.0.163';
        Testbed = 'MCR';
        Freq = 1575.42e6;
        MUX_NUM{1} = 8;
        Fd = 99375000;
    otherwise
        warning('non valid Board type')
        return
end

prog_name = 'Multi_facq_test.exe';
res_name = 'log.txt';
ssh.user = 'root';
ssh.pass = 'plda';
ssh.port = '22';
prog_path = '/tmp/';
sub_dir_name = '/tmp/facq_res/';
% commands = sprintf('9 0 1 %d %u %u %u %u %u %u %u',fi,Kg,NN,freq_dop,tau_ms,Nexp,MUX_NUM,Fd);

fig_dir_name=datestr(datetime('now','Format','yyyy-MM-dd_HH:mm:ss'));
fig_dir_name(fig_dir_name==' ') = '_';
fig_dir_name(fig_dir_name==':') = '.';
mkdir(fig_dir_name);

q_cn0 = 25:1:48;
NN = [1,2,5,10,20,50,100];

ChangeSNRonly = 0;
data = 'RNData';
SV_ID1 = [1,2,3,4];
SV_ID2 = [5,6,7,8];
Sat_NUM = 4;


commands.fi = fi;
commands.Kg = Kg;
commands.freq_dop = freq_dop;
commands.tau_ms = tau_ms;
commands.MUX_NUM = MUX_NUM;
commands.Fd = Fd;
commands.Sat{1} = 1;
commands.Sat{2} = 3;
commands.Sat{3} = 5;
commands.Sat{4} = 7;

IPN = 0;
IP_SMBV1 = '192.168.0.176';
IP_SMBV2 = '192.168.0.177';

for i_IP = 1:length(ssh.IP)
    system(['C:/Putty/plink.exe -ssh -P ',ssh.port,' -pw ',ssh.pass,' ',ssh.user,'@',ssh.IP{i_IP},' mkdir /tmp/']); % созадем папку tmp
    %     if(disp_en) disp(cmdout); end
    [status,cmdout] = system(['C:/Putty/plink.exe -ssh -P ',ssh.port,' -pw ',ssh.pass,' ',ssh.user,'@',ssh.IP{i_IP},' rm -rf ',sub_dir_name]);
    if(disp_en) disp(cmdout); end
    [status,cmdout] = system(['C:/Putty/plink.exe -ssh -P ',ssh.port,' -pw ',ssh.pass,' ',ssh.user,'@',ssh.IP{i_IP},' mkdir ',sub_dir_name]); % созадем подпапку для папок логов результатов
    if(disp_en) disp(cmdout); end
end


Rq = zeros(length(q_cn0),1,length(NN));
Rq_NN = zeros(1,length(NN)); % зависимость R от NN
Rq_q = zeros(length(NN),length(q_cn0)); % зависимость R от q для разных NN
Pd = zeros(length(NN),length(q_cn0));
threshold = zeros(1,length(NN));
legend_name = cell(1,length(NN));
i_exp = 1;
while(1) % бесконечный набор статистики
    fprintf('Nexp = %d\n',i_exp)
    
    
    setupSMBV_all(IP_SMBV1, IPN, Testbed, SigType, Freq, Sat_NUM, SV_ID1, data, 0, ChangeSNRonly);
    setupSMBV_all(IP_SMBV2, IPN, Testbed, SigType, Freq, Sat_NUM, SV_ID2, data, 0, ChangeSNRonly);
    ChangeSNRonly = 1; % больше не перенастраиваем SMBV
    
    for i_NN = 1:length(NN)
        if(i_exp == 1)
            legend_name{i_NN} = sprintf('NN = %d',NN(i_NN));
        end
        
        fprintf('compute threshold, NN = %d\n',NN(i_NN))
        %         commands = sprintf('0 1 %d %u %u %u %u %u %u %u',fi,Kg,NN(i_NN),freq_dop,tau_ms,Nexp_thr,MUX_NUM,Fd); % для расчета порога увеличиваем Nexp в 5 раз
        
        commands.NN = NN(i_NN);
        commands.Nexp = Nexp_thr;
        R = facq_run(sub_dir_name,prog_name,res_name,commands,ssh,disp_en);
        if(i_exp == 1)
            R0(i_NN,:) = R;
            R0_size = length(R);
        else
            R0(i_NN,1:i_exp*R0_size) = [R,R0(i_NN,1:(i_exp-1)*R0_size)];
        end
        threshold(i_NN) = get_thr(R0(i_NN,:));
    end
    
    for i_NN = 1:length(NN)
        %         commands = sprintf('0 1 %d %u %u %u %u %u %u %u',fi,Kg,NN(i_NN),freq_dop,tau_ms,Nexp,MUX_NUM,Fd); % возвращаем настройки эксперимента поиска
        commands.NN = NN(i_NN);
        commands.Nexp = Nexp;
        fprintf('q = ')
        for i=1:length(q_cn0)
            fprintf('%g | ',q_cn0(i))
            %         disp('setup SMBV...')
            setupSMBV_all(IP_SMBV1, IPN, Testbed, SigType, Freq, Sat_NUM, SV_ID1, data, q_cn0(i), ChangeSNRonly);
            setupSMBV_all(IP_SMBV2, IPN, Testbed, SigType, Freq, Sat_NUM, SV_ID2, data, q_cn0(i), ChangeSNRonly);
            %         disp('DONE')
            
            [R,freq,tau] = facq_run(sub_dir_name,prog_name,res_name,commands,ssh,disp_en);
            if(i_exp == 1)
                Rq(i,1:length(R),i_NN) = R;
                R_size = length(R);
            else
                Rq(i,1:i_exp*R_size,i_NN) = [R,Rq(i,1:(i_exp-1)*R_size,i_NN)];
            end
            Pd(i_NN,i) = sum(Rq(i,:,i_NN)>threshold(i_NN))/length(Rq(i,:,i_NN));
            
            if(i == length(q_cn0))
                Rq_NN(i_NN) = mean(Rq(length(q_cn0),:,i_NN));
            end
            
            Rq_q(i_NN,i) = mean(Rq(i,:,i_NN))/NN(i_NN);
            
            
            
            subplot(2,2,1);
            plot(q_cn0,[Pd],'+-')
            hold on
            plot([q_cn0(1),q_cn0(end)],[0.9,0.9])
            hold off
            title(sprintf('Nexp=%d, NN=%d, q\\_cn_0=%d',i_exp,NN(i_NN),q_cn0(i)))
            xlim([q_cn0(1) q_cn0(end)])
            ylim([0 1])
            xlabel('q\_cn_0')
            ylabel('Pd')
            grid on
            set(gca,'xtick',[q_cn0(1):1:q_cn0(end)])
            legend(legend_name,'Location','southeast')
            
            subplot(2,2,2);
            plot(NN,threshold,'+-')
            xlim([NN(1) NN(end)])
            xlabel('NN')
            ylabel('threshold')
            grid on
            
            subplot(2,2,3);
            plot(q_cn0,Rq_q,'+-')
            xlim([q_cn0(1) q_cn0(end)])
            xlabel('q\_cn_0')
            ylabel('R/NN')
            legend(legend_name,'Location','northwest')
            grid on
            
            subplot(2,2,4);
            plot(NN,Rq_NN,'+-')
            xlim([NN(1) NN(end)])
            xlabel(sprintf('NN, q\\_cn_0=%d',q_cn0(end)))
            ylabel('R')
            grid on
            
            drawnow
        end
        fprintf('\n')
    end
    
    %     break % -------------------------
    savefig(sprintf('%s\\%d.fig',fig_dir_name,i_exp))
    i_exp = i_exp + 1;
end