function H = LD_H_G(Hb)
I96 = zeros(96,96);
for i=1:96
    I96(i,i) = 1;
end
[m1,n1] = size(Hb);
for i = 1:m1
    for j = 1:n1
        if Hb(i,j) == -1
            H( ((i-1)*96+1):i*96,((j-1)*96+1):j*96  ) = 0;
        else
            H( ((i-1)*96+1):i*96,((j-1)*96+1):j*96 ) = LD_mrsh(I96,Hb(i,j));
        end
    end 
end

