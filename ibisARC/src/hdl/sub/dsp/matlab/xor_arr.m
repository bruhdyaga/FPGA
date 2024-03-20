function out = xor_arr(inp)

N = length(inp);

out = 0;

for i = 1:N-1
if(i == 1)
    out = xor(inp(1),inp(2));
else
    out = xor(out,inp(i+1));
end
end

end

