clc
clear all

N = 2^14;
K = 2^13;

u = rand(K,1)>0.5;
initPC(N,K,'BEC',1/2);

px = pencode(u);

y = OutputOfChannel(px,'BEC',1/2);
uu = pdecode(y,'BEC',1/2);

len = length(find(uu ~= u));
len