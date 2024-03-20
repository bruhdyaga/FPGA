clear
clc
N = 64;

G1 = [2,3,5,6];
G2 = [1,2,3,6];

for i=0:N-1
    for j = 0:1
        fprintf('inp = %d || ',j)
        fprintf('state = %2d : ',i)
        bin = dec2bin(i);
        bin_ext = [repmat('0',1,log2(N)-length(bin)),bin];
        bin_rev = bin_ext(log2(N):-1:1);
        fprintf('%s || ',bin_rev)
        nstate = [dec2bin(j),bin_rev(1:5)];
        fprintf('nstate = %2d : %s || ',bin2dec(nstate(6:-1:1)),nstate)
        b1 = xor_arr([j,bin_rev(G1)-'0']);
        b2 = xor_arr([j,bin_rev(G2)-'0']);
        fprintf('b1,b2 = %d,%d\n',b1,b2)
    end
end