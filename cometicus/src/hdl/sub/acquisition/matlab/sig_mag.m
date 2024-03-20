function [sig, mag, signed] = sig_mag(in)


N = length(in);
sig = zeros(1,N);
% mag = zeros(1,N);

por = find_por(in);

sig(in<0) = 1;
mag = abs(in)>por;

signed = ones(1,N);
signed(sig==1) = -1;
signed(mag==1) = signed(mag==1)*3;

end

function por = find_por(in)

in = abs(in);

a = 0;
b = max(in);
por = b;
por_old = a;

while(abs(por-por_old)/por > 0.001)% точность 0.1%
    
    num_mag = sum(in>por)/length(in);
    
    if(num_mag>1/3)
        a = por;
    else
        b = por;
    end
    
    por_old = por;
    por = (a+b)/2;
end

end