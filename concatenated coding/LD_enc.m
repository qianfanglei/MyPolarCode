function msg = LD_enc(Hb,s)

as = zeros(7,96);
cs = zeros(1,96);
bp1 = zeros(7,96);
msg = zeros(1,2304);
    for i = 1:16
        for j = 1:7
            if Hb(j,i) >= 0
            as(j,:) = as(j,:) + LD_ushift(s(i,:),Hb(j,i));
            end
        end
    end
as = mod(as,2);
tas = LD_mul_inv_T7(as);
etas = tas(7,:);

for i = 1:16
   if Hb(8,i) >= 0
   cs = cs + LD_ushift(s(i,:),Hb(8,i));
   end
end
cs = mod(cs,2);
p1 = mod(cs + etas,2);
bp1(1,:) = LD_ushift(p1,95);
bp1(7,:) = p1;
bp1as = bp1 + as;
bp1as = mod(bp1as,2);
p2 = LD_mul_inv_T7(bp1as);
for i = 0:15
    for j = 1:96
        msg(i*96+j) = s(i+1,j);
    end
end
msg(16*96+1:17*96) = p1;
for i = 17:23
    for j = 1:96
         msg(i*96+j) = p2(i-16,j);
    end
end
