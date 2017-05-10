clc                     %%%%%%%%%%%%%%%%%%%%%%
clear all

fun_hb;EbN0 = [1.5 2.0 2.5,3.0,3.5 4.0];rate = 2/3;iter_max0 = 10;
for i = 1:6
    len = 0;ErrB = 0;frame = 10000;
    for j = 1:frame
        for z = 1   %%-----------%% useless
        u = rand(1,1536)>0.5;
        lmsg = reshape(u,96,16)';
        %%%%%%%%%%%%%%   LDPC±‡¬Î   %%%%%%%%%%%%%%%%%%
        N0 = 1/(2*rate*exp(EbN0(i)*log(10)/10));
        lx = LD_enc(Hb2_3B,lmsg);
        %%%%%%%%%%%%%%     –≈µ¿     %%%%%%%%%%%%%%%%%%
        LogBPskMod = 2*lx - 1;
        tx = LogBPskMod + sqrt(N0)*randn(size(LogBPskMod));
        ch = -4*tx./N0; 
        %%%%%%%%%%%%%%   LDPC“Î¬Î   %%%%%%%%%%%%%%%%%%
        [dout,LL] = LD_dec(ch,iter_max0);
        end
        %%%%%%%%%%%%%%     ŒÛ≤Ó     %%%%%%%%%%%%%%%%%%
        len = len + length(find(dout(1:1536) ~= u));
        if ~isequal(dout(1:1536),u)
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
	Nerr = len / (1536*frame); 
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
