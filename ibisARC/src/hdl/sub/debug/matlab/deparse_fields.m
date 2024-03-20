function out = deparse_fields(input)
fprintf('Deparse verilog names...');

pos_delim = find(input == ',');

%список блокируемых символов из верилога
stop_list = {'{','}','''','[',']','`',':','(',')','.'};

for i = 1:length(stop_list)
    input((input == stop_list{i})) = '_';
end

%добавили в начало первый индекс и в конец последний
pos_delim = [0,pos_delim,length(input)+1];

out_size = length(pos_delim)-1;

out = cell(out_size,1);

for i = 1:out_size
    out{i} = input(pos_delim(i)+1:pos_delim(i+1)-1);
end

fprintf('DONE\n');
end

