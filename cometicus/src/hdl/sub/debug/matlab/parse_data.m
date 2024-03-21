function out = parse_data(hw,bits,name,data)
fprintf('Deparse data...');

datafields = fieldnames(data);


ch = 1;
bits_sum = 0;
for n = length(name):-1:1
    n
    for i = 1:length(data.(datafields{1}).raw_data)
        out.(datafields{ch}).(name{n})(i) = binvec2dec(bitget(data.(datafields{ch}).raw_data(i),bits{n}));
    end
    
    bits_sum = bits_sum + (max(bits{n}) - min(bits{n}) + 1);
    if(bits_sum == hw.WIDTH)
        ch = ch + 1
        bits_sum = 0;
    end
end


fprintf('DONE\n');
end

