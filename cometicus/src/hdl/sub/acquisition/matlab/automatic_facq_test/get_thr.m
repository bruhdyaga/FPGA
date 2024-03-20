function threshold = get_thr(R)

Pf_ref = 0.1;

a = 0;
b = max(R);

L = length(R);

i = 1;
while(1)
    threshold = mean([a,b]);
    Pf = sum(R>threshold)/L;
    if(Pf>Pf_ref)
        a = threshold;
    else
        b = threshold;
    end
    
    min_brk = min(0.01,1/(L*Pf_ref)/10);
    
    if(abs(Pf-Pf_ref) < min_brk)
        fprintf("break ((Pf-Pf_ref)<min) i = %d/%d, min = %f\n", i, L, min_brk)
        break
    end
    
    if(a==b)
        fprintf("break (a==b) i = %d/%d\n", i, L)
        break
    end
    
    if(i > 3*L)
        fprintf("break by iterations i = %d/%d; a = %.10f | b = %.10f\n", i, L, a, b)
        break
    end
    %     fprintf("a = %.10f | b = %.10f\n", a, b)
    i = i + 1;
end

end

