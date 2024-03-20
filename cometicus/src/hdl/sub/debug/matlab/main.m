clc
clear
close all hidden
fclose('all');

global ssh_par
work_path = '/tmp/';
hwFileName = 'hw_descr.txt';
dataFileName = 'data.txt';

hw.fields = {'ID','COLL_NUM','NUM_PORTS','WIDTH','DEPTH'};

ssh_par.port = '22';
ssh_par.pass = 'plda';
ssh_par.user = 'root';
ssh_par.IP = '192.168.0.164';

ssh(sprintf('cd %s; pwd; %sdata_coll 0x50000800 get_hw',work_path,work_path));


scp(work_path,hwFileName)

f_hw = fopen('hw_descr.txt','r');
hw.read = textscan(f_hw,'%s %s');
fclose(f_hw);

for i = 1:size(hw.fields,2)
    for j = 1:size(hw.read{1},1)
        if(strcmp(hw.fields{i},hw.read{1}{j}))
            if(~strcmp(hw.fields{i},'ID'))
                hw.(hw.fields{i}) = str2double(hw.read{2}{j});
            else
                hw.(hw.fields{i}) = hw.read{2}{j};
            end
        end
    end
end

depth = hw.DEPTH;
% depth = 3;
channels = [1,2];


ssh(sprintf('cd %s; %sdata_coll 0x50000800 wr_data %s %d',work_path,work_path,dec2hex(sum(2.^(channels-1))),depth));

scp(work_path,dataFileName)

f_data = fopen(dataFileName);
for i = 1:length(channels)
    D.(sprintf('ch%d',i)).raw_data = fread(f_data,[1 depth],'uint');
end
fclose(f_data);

D = parse_data(hw,...
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1:22},...
    deparse_fields('gln_q_mag,gln_i_mag,gps_i_mag,adc_mag6,adc_mag5,adc_mag4,adc_mag3,adc_mag2,adc_mag1,adc_mag0,imi[0],gln_q_sig,gln_i_sig,gps_i_sig,adc_sig6,adc_sig5,adc_sig4,adc_sig3,adc_sig2,adc_sig1,adc_sig0,imi[1],aclk_cntr'),...
    D);

