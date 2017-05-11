clear;

load('gai.mat');
x = 1.5:.5:4;
y1 = gai(1,1:6);
y2 = gai(2,1:6);


semilogy(x,y1,'p-');

hold on
semilogy(x,y2,'k');
hold on

axis([1.5 4 5*1e-8 1]);
title('Bit Err Rate frame = 10000');
legend('concatenation','LDPC');
xlabel('EbN0');
ylabel('BER');
grid on;