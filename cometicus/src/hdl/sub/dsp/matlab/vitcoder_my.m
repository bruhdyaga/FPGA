function out_data = vitcoder_my(data)

D = length(data);
out_data = nan(1,2*D);

G1 = [2,3,5,6];
G2 = [1,2,3,6];

state = zeros(1,6);

for i = 1:D
        b1 = xor_arr([data(i),state(G1)]);
        b2 = xor_arr([data(i),state(G2)]);
        out_data((i-1)*2+1) = b2;
        out_data((i-1)*2+2) = b1;
%         fprintf('i=%3d | inp_data = %d | b1,b2 = %d,%d | state = %s\n',i,data(i),b1,b2,mat2str(state))
        state = [data(i),state(1:5)];
end


end

