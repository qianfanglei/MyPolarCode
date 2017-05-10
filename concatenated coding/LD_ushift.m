function b = LD_ushift(a,x)
b = zeros(1,96);
for i = 1:96
    if(i+x == 96)
        b(i) = a(96);
    else 
        b(i) = a(mod(i+x,96));
    end
end
    
