function [SER, BER]=runScenario(modulationOrder, SNRdB, numBits,noisePower)
    a=randi([0,1],[1,6*numBits]);
%     if strcmp(modulationOrder,"BPSK")
        
        sym_num=bit2symnum(a,modulationOrder);
        sym=bit2sym(modulationOrder,sym_num);
        signal_power=10.^(SNRdB/10)*noisePower*log2(modulationOrder);
        Scaled_signal=sqrt(signal_power)*sym;
        noise=sqrt(noisePower)*sqrt(0.5)*(randn(1,length(sym))+1i*randn(1,length(sym)));
        %c=awgn(b,SNRdB);
        noisy=noise+Scaled_signal;
        detected=min_distance_detection(noisy,modulationOrder,signal_power);
        SER=(sum(detected-1~=sym_num'))/length(detected);
        bit=sym2bit(detected-1,modulationOrder);
        BER=sum(a~=bit')/length(a);
%     else
%         error("modulation order not supported")
%     end
end
