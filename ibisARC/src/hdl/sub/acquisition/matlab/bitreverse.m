function h = bitreverse(x)

WordLength = log2(length(x));
h = 0;

for i = 1:WordLength
    h = bitshift(h,1) + bitand(x,1);
    x = bitshift(x,-1);
end

end

