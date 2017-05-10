function b = LD_mul_inv_T7(a)
  b(1,:)=a(1,:);
  for i=2:7;
          b(i,:)=a(i,:)+b(i-1,:);
  end
  b = mod(b,2);