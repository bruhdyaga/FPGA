function scp(work_path,resFileName)

global ssh_par

command = ['C:/Putty/pscp.exe -P ',ssh_par.port,' -pw ',ssh_par.pass,' ',ssh_par.user,'@',ssh_par.IP,':',work_path,resFileName,' '];

filePath = pwd;

system([command,filePath,'\',resFileName]);

end

