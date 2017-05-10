clc                     %%%%%%%%%%%%%%%%%%%%%%
clear all
K = 1536; u = rand(1,1536)>0.5; R = 2/3; N = K/R; n = ceil(log2(N));
fun_hb;iter_max0 = 10;
EbN0 = [1.5 2.0 2.5,3.0,3.5 4.0];
msg = reshape(u,96,16)';

for i = 1:6
    len = 0;ErrB = 0;frame = 1000;
    for j = 1:frame
        initPC(4096,2304,'AWGN',0);
        if mod(j,4) == 0
            fprintf('frame = %d\n',j)
        end
        for z = 1   %%-----------%% useless
        %%%%%%%%%%%%%%   LDPC±àÂë   %%%%%%%%%%%%%%%%%%
        lx = LD_enc(Hb2_3B,msg);    %length u = 1536;length lx = 2304
        %%%%%%%%%%%%%%    PC±àÂë    %%%%%%%%%%%%%%%%%%        
        px = pencode(lx);
        %%%%%%%%%%%%%%     ÐÅµÀ     %%%%%%%%%%%%%%%%%%
        py = OutputOfChannel(px,'AWGN',round(EbN0(i)));
        %%%%%%%%%%%%%%    PCÒëÂë    %%%%%%%%%%%%%%%%%%
        puu = pdecode(py,'AWGN',round(EbN0(i)));
        pu = puu';
        %%%%%%%%%%%%%%   LDPCÒëÂë   %%%%%%%%%%%%%%%%%%
        dout = BFdecode(pu,Hb2_3B,iter_max0);
        %%%%%%%%%%%   LDPC¼õ¶Ì²¢µ÷Õû   %%%%%%%%%%%%%%%
        uu = dout(1:1536);
        end
        %%%%%%%%%%%%%%     Îó²î     %%%%%%%%%%%%%%%%%%
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
