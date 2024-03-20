clc
clear

ssh.IP{1} = '192.168.0.66';
ssh.IP{2} = '192.168.0.68';
ssh.IP{3} = '192.168.0.69';
ssh.IP{4} = '192.168.0.162';
ssh.user = 'root';
ssh.pass = 'plda';
ssh.port = '22';

prog_name = 'd:\my_git\subs\c_tests\Multi_facq_test\prj\bin\Release\Multi_facq_test.exe';


for i=1:length(ssh.IP)
    fprintf('\n\n---- IP=%s ----\n',ssh.IP{i})
    system(['C:/Putty/plink.exe -ssh -P ',ssh.port,' -pw ',ssh.pass,' ',ssh.user,'@',ssh.IP{i},' /etc/init.d/receiver stop']);
    system(['C:/Putty/plink.exe -ssh -P ',ssh.port,' -pw ',ssh.pass,' ',ssh.user,'@',ssh.IP{i},' kill -9 `pidof receiver`']);
    system(['C:/Putty/pscp.exe -P ',      ssh.port,' -pw ',ssh.pass,' ',prog_name,' ',ssh.user,'@',ssh.IP{i},':/tmp']);
    system(['C:/Putty/plink.exe -ssh -P ',ssh.port,' -pw ',ssh.pass,' ',ssh.user,'@',ssh.IP{i},' chmod 777 /tmp/Multi_facq_test.exe']);
    
    system(['C:/Putty/pscp.exe -P ',      ssh.port,' -pw ',ssh.pass,' ',pwd,'\mainboard_facq_2.bit ',ssh.user,'@',ssh.IP{i},':/tmp']);
    system(['C:/Putty/plink.exe -ssh -P ',ssh.port,' -pw ',ssh.pass,' ',ssh.user,'@',ssh.IP{i},' "cat /tmp/mainboard_facq_2.bit > /dev/xdevcfg"']);
end