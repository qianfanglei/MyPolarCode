function [a,b,c] = testForNargin(x1,x2,x3,x4)
a=0;
b=0;
if(nargin==1)
c=x1;
elseif (nargin==2)
    c=3;
elseif(nargin>2)
        c=5;
end
