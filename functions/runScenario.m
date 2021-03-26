function [SER, BER]=runScenario(modulationOrder, SNRdB, numBits)
    a=randi([0,1],[1,numBits]);
%     if strcmp(modulationOrder,"BPSK")
        
        sym_num=bit2symnum(a,modulationOrder);
        sym=bit2sym(modulationOrder,sym_num);
        snrlin=10.^(SNRdB/10);
        noisy=add_noise(sym,snrlin,modulationOrder);
        %c=awgn(b,SNRdB);
        
        detected=min_distance_detection(noisy,modulationOrder);
        SER=(sum(detected-1~=sym_num))/length(detected);
        bit=sym2bit(detected-1,modulationOrder);
        BER=sum(a~=bit')/length(a);
%     else
%         error("modulation order not supported")
%     end
end
