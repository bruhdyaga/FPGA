function ssh(command)

global ssh_par

commandFileName = 'command.txt';
fileID = fopen(commandFileName,'w');

fprintf(fileID,'%s',command);



fprintf([command '\n']);
system(['C:/Putty/plink.exe -ssh -P ',ssh_par.port,' -pw ',ssh_par.pass,...
    ' ',ssh_par.user,'@',ssh_par.IP,' -m ',commandFileName]);

fclose(fileID);

end

