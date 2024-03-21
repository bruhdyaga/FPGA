function ID_gen(module_name, comment)

[NAME_arr,ID_arr,comment_arr,n] = ReadFromHeader;

N_bits = 16;

Forbidden_IDs = [
    hex2dec('0')
    hex2dec('FFFF')
    ];

%% исправляем синтаксические ошибки в имени модуля и комментарии
module_name(module_name == ' ') = '_';
module_name(module_name == '|') = '';
module_name(module_name == '/') = '';
module_name(module_name == '''') = '';

comment(comment == '/') = '';
comment(comment == '|') = '';

%% проверяем имя модуля на уникальность
for i=1:n
    if(strcmp(NAME_arr{i},module_name))
        disp('Имя модуля уже занято')
        return
    end
end
%% выравниваем строки
allign_arr = cell(1,n);
max_name_len = 0;
if(n)
    for i = 1:n
        if(length(NAME_arr{i}) > max_name_len)
            max_name_len = length(NAME_arr{i});
        end
    end
end
if(length(module_name) > max_name_len)
    max_name_len = length(module_name);
end

if(n)
    for i = 1:n
        if(max_name_len > length(NAME_arr{i}))
            allign_arr{i} = repmat(' ',1,max_name_len - length(NAME_arr{i}));
        else
            allign_arr{i} = '';
        end
    end
end
if(max_name_len > length(module_name))
    allign = repmat(' ',1,max_name_len - length(module_name));
else
    allign = '';
end
%% проверяем ID на уникальность
ID = fix(rand*(2^N_bits-1));
while (ID<0) || (ID>(2^N_bits-1)) || sum(ID==Forbidden_IDs) || sum(ID==ID_arr)
    ID = fix(rand*(2^N_bits-1));
end

%% записываем
WriteToHeader(NAME_arr,ID_arr,allign_arr,comment_arr,n,module_name,ID,allign,comment);
WriteToSVHeader(NAME_arr,ID_arr,allign_arr,comment_arr,n,module_name,ID,allign,comment);
end
%% чтение header-файла
function [NAME_arr,ID_arr,comment_arr,n] = ReadFromHeader
try
    fid = fopen('ID_DB.h');
end

name_list_fl = 0;
id_list_fl = 0;
n = 0;
watchdog_cntr = 0;
ID_arr = 0;
comment_arr = {0};
NAME_arr = {0};

if(fid < 0)
    return
end



tline = fgetl(fid);
while (~strcmp(tline,'#endif'))
    tline_prev = tline;
    tline = fgetl(fid);
    if(strcmp(tline,'    //ID list'))
        name_list_fl = 1;
        i = 1;
        tline = fgetl(fid);
    end
    if(name_list_fl)
        if(strcmp(tline,'    //end of ID list'))
            name_list_fl = 0;
        else
            ID_arr(i) = hex2dec(tline(7:10));
            
            name_start = find(tline == '''',1)+1;
            name_end = max(find(tline == '''',2))-1;
            comment_start = find(tline == '|',1)+2;
            NAME_arr{i} = tline(name_start:name_end);
            comment_arr{i} = tline(comment_start:end);
            i = i + 1;
            n = n + 1;
        end
    end
    
    %     watchdog
    if(strcmp(tline,tline_prev))
        watchdog_cntr = watchdog_cntr + 1;
    end
    
    if(watchdog_cntr == 50)
        n = 0;
        ID_arr = 0;
        NAME_arr = {0};
        comment_arr = {0};
        
        disp('Не вижу конца файла')
        fclose(fid);
        return
    end
end

fclose(fid);
end
% fprintf(fid,'%s\n','');
%% запись в header-файл
function WriteToHeader(NAME_arr,ID_arr,allign_arr,comment_arr,n,module_name,ID,allign,comment)

fid = fopen('ID_DB.h','w');

fprintf(fid,'%s\n','#ifndef ID_DB');
fprintf(fid,'%s\n','#define ID_DB');
fprintf(fid,'\n');
fprintf(fid,'%s%d%s\n','const unsigned int numOfModIDs = ',n+1,';');
fprintf(fid,'\n');
fprintf(fid,'%s\n','unsigned int IDs[] = {');
fprintf(fid,'%s\n','    //ID list');
if(n)
    for i = 1:n
        if(length(dec2hex(ID_arr(i)))<4)
            hex_allign = repmat('0',1,4-length(dec2hex(ID_arr(i))));
        else
            hex_allign = '';
        end
        fprintf(fid,'    0x%s%s,// ''%s''%s | %s\n',hex_allign,dec2hex(ID_arr(i)),NAME_arr{i},allign_arr{i},comment_arr{i});
    end
end
if(length(dec2hex(ID))<4)
    hex_allign = repmat('0',1,4-length(dec2hex(ID)));
else
    hex_allign = '';
end
fprintf(fid,'    0x%s%s // ''%s''%s | %s\n',hex_allign,dec2hex(ID),module_name,allign,comment);
fprintf(fid,'%s\n','    //end of ID list');
fprintf(fid,'%s\n','};');
fprintf(fid,'\n');
fprintf(fid,'%s\n','char *IDnamelist[] = {');
if(n)
    for i = 1:n
        fprintf(fid,'    (char *)"%s",\n',NAME_arr{i});
    end
end
fprintf(fid,'    (char *)"%s"\n',module_name);
fprintf(fid,'%s\n','};');
fprintf(fid,'\n');
fprintf(fid,'%s\n','typedef enum');
fprintf(fid,'%s\n','{');
if(n)
    for i = 1:n
        fprintf(fid,'    %s,\n',NAME_arr{i});
    end
end
fprintf(fid,'    %s\n',module_name);
fprintf(fid,'%s\n','}');
fprintf(fid,'%s\n','module_name_list;');
fprintf(fid,'\n');
fprintf(fid,'%s\n','#endif');

fclose(fid);
end

%% запись в svheader-файл
function WriteToSVHeader(NAME_arr,ID_arr,allign_arr,comment_arr,n,module_name,ID,allign,comment)
fid = fopen('ID_DB.svh','w');

fprintf(fid,'%s\n','`ifndef ID_DB_SVH');
fprintf(fid,'%s\n','`define ID_DB_SVH');
fprintf(fid,'\n');
fprintf(fid,'%s\n','struct {');
if(n)
    for i = 1:n
        fprintf(fid,'    int  %s;\n',NAME_arr{i});
    end
end
fprintf(fid,'    int  %s;\n',module_name);
fprintf(fid,'%s\n','} ID_DB = ''{');
if(n)
    for i = 1:n
        fprintf(fid,'    16''h%s,// %s\n',dec2hex(ID_arr(i)),NAME_arr{i});
    end
end
fprintf(fid,'    16''h%s // %s\n',dec2hex(ID),module_name);
fprintf(fid,'%s\n','};');
fprintf(fid,'\n');
fprintf(fid,'%s\n','`endif');

fclose(fid);
end
