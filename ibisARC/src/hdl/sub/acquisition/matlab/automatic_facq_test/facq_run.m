function [R,freq,tau,kg_actual] = facq_run(sub_dir_name,prog_name,res_name,commands,ssh,disp_en)

dir_name=datestr(datetime('now','Format','yyyy-MM-dd_HH:mm:ss'));
dir_name(dir_name==' ') = '_';
dir_name = [sub_dir_name,dir_name,'/'];
% disp(dir_name)

for i_IP = 1:length(ssh.IP)
    run_command = sprintf('0 %d %d %u %u %u %u %u %u %u',...
        commands.Sat{i_IP},commands.fi,commands.Kg,commands.NN,commands.freq_dop,commands.tau_ms,commands.Nexp,commands.MUX_NUM{i_IP},commands.Fd); % ��� ������� ������ ����������� Nexp � 5 ���
    
    command_file_name = sprintf('resFileName_%d.txt',i_IP);
    fid_res = fopen(command_file_name,'w');
    first_command = ['cd ',dir_name];
    if i_IP==length(ssh.IP) % ��� ��������� ����� ���� ����� �������
        second_command = ['./',prog_name,' ',run_command];
    else
        second_command = ['./',prog_name,' ',run_command,' >1.txt &'];
    end
    fprintf(fid_res,'%s\n%s',first_command,second_command);
    fclose(fid_res); 
end
%% SSH commands
for i_IP = 1:length(ssh.IP)
    [status,cmdout] = system(['C:/Putty/plink.exe -ssh -P ',ssh.port,' -pw ',ssh.pass,' ',ssh.user,'@',ssh.IP{i_IP},' mkdir ',dir_name]); % ������� �������� � ������ ���� ��� ����� �����������
    if(disp_en) disp(cmdout); end
    [status,cmdout] = system(['C:/Putty/plink.exe -ssh -P ',ssh.port,' -pw ',ssh.pass,' ',ssh.user,'@',ssh.IP{i_IP},' cp /tmp/',prog_name,' ',dir_name,prog_name]); % ������� standalone
    if(disp_en) disp(cmdout); end
end
% tic
for i_IP = 1:length(ssh.IP)
    command_file_name = sprintf('resFileName_%d.txt',i_IP);
    [status,cmdout] = system(['C:/Putty/plink.exe -ssh -P ',ssh.port,' -pw ',ssh.pass,' ',ssh.user,'@',ssh.IP{i_IP},' -m ',pwd,'\',command_file_name]);% ����� ������ N ���
    if(disp_en) disp(cmdout); end
end
% toc
for i_IP = 1:length(ssh.IP)
    while(1)[status,cmdout] = system(['C:/Putty/pscp.exe -P ',      ssh.port,' -pw ',ssh.pass,' ',ssh.user,'@',ssh.IP{i_IP},':',dir_name,res_name,' ',pwd]);% �������� ���� � ������������
        
        if(disp_en) disp(cmdout); end
        
        
        %% read result data
        fid_res = fopen(res_name,'r');
        tmp = fgetl(fid_res);% ������� 1 ������
        if(tmp == -1)% ���� ��� �� �����
           fclose(fid_res); 
        else
            break
        end
    end
    rc = fscanf(fid_res,'%i;%i;%f;%f;%f;%f;%f;%i');
    kg_actual = rc(4);
    Nexp = rc(8)*2;% 2 ����� ������
    fgetl(fid_res);% ������� 3 ������
    
    rc = fscanf(fid_res,'%f;%f;%f',[3 Inf]);
    if(size(rc,2) ~= Nexp)
        warning('���-�� �� �� � �������� ������')
        return
    end
    fclose(fid_res);
    
    if(i_IP == 1)
        R    = rc(1,:);
        freq = rc(2,:);
        tau  = rc(3,:);
    else
        R(1:i_IP*Nexp)    = [rc(1,:),R(1:(i_IP-1)*Nexp)];
        freq(1:i_IP*Nexp) = [rc(2,:),freq(1:(i_IP-1)*Nexp)];
        tau(1:i_IP*Nexp)  = [rc(3,:),tau(1:(i_IP-1)*Nexp)];
    end
end

end

