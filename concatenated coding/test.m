clear all
close all
clc
fun_hb;
EbN0 = [1.5,2.0,2.5,2.7];
rate = 2/3;
iter_max0 = 10;
for i = 1:4
    N0 = 1/(2*rate*exp(EbN0(i)*log(10)/10));
    msg = rand(24,96)>0.5;
    u = LD_enc(Hb2_3B,msg);
    LogBPskMod = 2*u - 1;
    tx = LogBPskMod + sqrt(N0)*randn(size(LogBPskMod));
    ch = -4*tx./N0; 
    [dout,LQi] = LD_dec(ch,iter_max0);
end
len = length(dout);
NoOfErr = length(find(dout~=u))