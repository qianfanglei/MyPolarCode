clc                     %%%%%%%%%%%%%%%%%%%%%%
clear all
K = 768; u = rand(K,1)>0.5; R = 3/4; N = K/R; n = ceil(log2(N));

initPC(N,K,'BEC',1/16);              %initPC(N,K,'BSC',10^(-5));

fun_hb;EbN0 = [1.5 2.0 2.5,3.0,3.5 4.0];rate = 2/3;iter_max0 = 10;
for i = 1:6
    len = 0;ErrB = 0;frame = 100;
    for j = 1:frame
        for z = 1   %%-----------%% useless
        %%%%%%%%%%%%%%    PC±àÂë    %%%%%%%%%%%%%%%%%%
        px = pencode(u);
        %%%%%%%%%%%%%%    PC¼Ó³¤    %%%%%%%%%%%%%%%%%%
        ppx = zeros(1,1536);
        ppx(1:N) = px;
        lmsg = reshape(ppx,96,16)';
        %%%%%%%%%%%%%%   LDPC±àÂë   %%%%%%%%%%%%%%%%%%
        N0 = 1/(2*rate*exp(EbN0(i)*log(10)/10));
        lx = LD_enc(Hb2_3B,lmsg);
        %%%%%%%%%%%%%%     ÐÅµÀ     %%%%%%%%%%%%%%%%%%
        LogBPskMod = 2*lx - 1;
        tx = LogBPskMod + sqrt(N0)*randn(size(LogBPskMod));
        ch = -4*tx./N0; 
        %%%%%%%%%%%%%%   LDPCÒëÂë   %%%%%%%%%%%%%%%%%%
        [dout,LL] = LD_dec(ch,iter_max0);
        %%%%%%%%%%%   LDPC¼õ¶Ì²¢µ÷Õû   %%%%%%%%%%%%%%%
        yy = LL(1:1024);
        zero_yy = [yy 0];
        temp_yy = sort(zero_yy);
        indOfZero = find(temp_yy==0);
        ymsg = zeros(1,1024);
        end   %%-----------%% useless
        for k = 1:1024
            if yy(k) > temp_yy(indOfZero + 8)
                
                ymsg(k) = 0;
            elseif yy(k) <= temp_yy(indOfZero - 8)
                ymsg(k) = 1;
            else
                ymsg(k) = 2;
            end
        end
        %%%%%%%%%%%%%%    PCÒëÂë    %%%%%%%%%%%%%%%%%%
        %uu = pdecode(dout(1:1024),'BSC',10^(-5));
        uu = pdecode(ymsg,'BEC',1/64);
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