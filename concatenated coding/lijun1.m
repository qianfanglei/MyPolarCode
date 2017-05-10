clc                     %%%%%%%%%%%%%%%%%%%%%%
clear all
K = 1536; u = rand(1,1536)>0.5; R = 2/3; N = K/R; n = ceil(log2(N));
fun_hb;EbN0 = [1.5 2.0 2.5,3.0,3.5 4.0];iter_max0 = 10;
msg = reshape(u,96,16)';
initPC(4096,2304);
%initPC(N,K,'BEC',1/16);              %initPC(N,K,'BSC',10^(-5));

for i = 1:6
    len = 0;ErrB = 0;frame = 10;
    for j = 1:frame
        for z = 1   %%-----------%% useless
        %%%%%%%%%%%%%%   LDPC编码   %%%%%%%%%%%%%%%%%%
        lx = LD_enc(Hb2_3B,msg);    %length u = 1536;length lx = 2304
        %%%%%%%%%%%%%%    PC编码    %%%%%%%%%%%%%%%%%%
        rate = 0.5625; nl = length(lx)/rate;
        
        px = pencode(lx);
        %%%%%%%%%%%%%%     信道     %%%%%%%%%%%%%%%%%%
        py = OutputOfChannel(px,'AWGN',EbN0(i));
        %%%%%%%%%%%%%%    PC译码    %%%%%%%%%%%%%%%%%%
        LL = pdecode(py,'AWGN',EbN0(i));
        %%%%%%%%%%%%%%   LDPC译码   %%%%%%%%%%%%%%%%%% 问题在这！！！！！！！
        [dout LLD] = LD_dec(LL,iter_max0);
        %%%%%%%%%%%   LDPC减短并调整   %%%%%%%%%%%%%%%
        uu = dout(1:1536);
        end
        %%%%%%%%%%%%%%     误差     %%%%%%%%%%%%%%%%%%
        len = len + length(find(uu ~= u));
        if ~isequal(uu,u)
            ErrB = ErrB + 1;
        end
        %nerr = len / (K*frame); 
        %nferr = ErrB / frame;
        %if i == 1
        %    fprintf('nerr1 = %f, nferr1 = %f\n', nerr,nferr);
        %elseif i == 2
        %    fprintf('nerr2 = %f, nferr2 = %f\n', nerr,nferr);
        %elseif i == 3
        %    fprintf('nerr3 = %f, nferr3 = %f\n', nerr,nferr);
        %end
        
    end
	Nerr = len / (K*frame); 
	Nferr = ErrB / frame;
    if i == 1
        fprintf('NERR1 = %f, NFERR1 = %f\n', Nerr,Nferr);
    elseif i == 2
        fprintf('NERR2 = %f, NFERR2 = %f\n', Nerr,Nferr);
    elseif i == 3
        fprintf('NERR3 = %f, NFERR3 = %f\n', Nerr,Nferr);
    elseif i == 4
        fprintf('NERR4 = %f, NFERR4 = %f\n', Nerr,Nferr);
    elseif i == 5
        fprintf('NERR5 = %f, NFERR5 = %f\n', Nerr,Nferr);
    elseif i == 6
        fprintf('NERR6 = %f, NFERR6 = %f\n', Nerr,Nferr);
    end
end
%xlab = 1:.1:4;
%ylab = [NERR1 NERR2 NERR3 NERR4];
%yylab = [NFERR1 NFERR2 NFERR3 NFERR4];
%semilogy(EbN0(xlab),ylab(xlab),'^-');
%hold on
%semilogy(EbN0(xlab),yylab(xlab),'^v-');
%title('BER Performance and FER Performance');
%legend('NERR', 'NFERR');
%ylabel('Performance');
%xlabel('SNR');
%grid on;
