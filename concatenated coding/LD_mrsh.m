function Hc = LD_mrsh(H,a)
[~, n] = size(H);
Hc(:,1:a) = H(:,(n-a+1):n);
Hc(:,a+1:n) = H(:,1:(n-a));