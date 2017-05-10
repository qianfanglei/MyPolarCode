function dout = LD_calss(Hb,u) %¼ÆËã°éËæÊ½S
  for i = 0:15
    for j = 1:96
        s(i+1,j) = u(i*96+j);
    end
  end
p1 = u(16*96+1:17*96);
for i = 17:23
    for j = 1:96
          p2(i-16,j) = u(i*96+j);
    end
end

ss(1,:) = LD_ushift(p1,95)+p2(1,:);
ss(8,:) = LD_ushift(p1,95)+p2(7,:);
for i = 2:7
    ss(i,:) = p2(i-1,:)+p2(i,:);
end
ss(7,:) = ss(7,:) + p1;
for i = 1:8
    for j = 1:16
        if Hb(i,j) >= 0
            ss(i,:) = ss(i,:) + LD_ushift(s(j,:),Hb(i,j));
        end 
    end
end
ss = mod(ss,2);
if(ss == zeros(8,96)) 
    dout = 0;
else dout = 1;
end