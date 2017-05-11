function [dout LLD] = LD_dec(Lci, itera_max)
fun_hb;
Hb = Hb2_3B;
H = LD_H_G(Hb);
[M N] = size(H);
dout = zeros(1,N);

% Initialization
Lrji = zeros(M, N);
Pibetaij = zeros(M, N);

% Asscociate the L(ci) matrix with non-zero elements of H
Lqij = H.*repmat(Lci, M, 1);

% Get non-zero elements
[r, c] = find(H);
iter=0;
% Iteration
while (iter < itera_max)
   alphaij = sign(Lqij);   
   betaij = abs(Lqij);

   for l = 1:length(r)
      Pibetaij(r(l), c(l)) = log((exp(betaij(r(l), c(l))) + 1)/...
                             (exp(betaij(r(l), c(l))) - 1));
   end
   
   % ----- Horizontal step -----
   for i = 1:M
       
      c1 = find(H(i, :));       % Find non-zeros in the column     
      for k = 1:length(c1)      % Get the summation of Pi(betaij))
         
         % Summation of Pi(betaij)\c1(k)
         sumOfPibetaij = sum(Pibetaij(i, c1)) - Pibetaij(i, c1(k));
         
         % Avoid division by zero/very small number, get Pi(sum(Pi(betaij)))
         if sumOfPibetaij < 1e-20
            sumOfPibetaij = 1e-10;
         end         
         PiSumOfPibetaij = log((exp(sumOfPibetaij) + 1)/(exp(sumOfPibetaij) - 1));
      
         % Multiplication of alphaij\c1(k) (use '*' since alphaij are -1/1s)
         prodOfalphaij = prod(alphaij(i, c1))*alphaij(i, c1(k));
         
         % Update L(rji)
         Lrji(i, c1(k)) = prodOfalphaij*PiSumOfPibetaij;
         
      end % for k
      
   end % for i

   % ------ Vertical step ------
    for j = 1:N

      % Find non-zero in the row
      r1 = find(H(:, j));
      
      for k = 1:length(r1)        
        
         % Update L(qij) by summation of L(rij)\r1(k)
         Lqij(r1(k), j) = Lci(j) + sum(Lrji(r1, j)) - Lrji(r1(k), j);
      
      end % for k
      
      % Get L(Qi)
      LQi = Lci(j) + sum(Lrji(r1, j));
      LLD(j) = LQi;
      % Decode L(Qi)
      
      if LQi < 0
         dout(j) = 1;
      else
         dout(j) = 0;
      end
                       
    end % for j
    iter=iter+1;
    
    sss = LD_calss(Hb,dout);   %¼ÆËã°éËæÊ½S
    if sss == 0 
        break;
    end
   
end % while (iter<itera_max)


