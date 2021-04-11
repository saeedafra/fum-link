function [SER, BER]=runScenario(modulationOrder, SNRdB, numBits,noisePower)
    a=randi([0,1],[1,6*numBits]);
%     if strcmp(modulationOrder,"BPSK")
        
        
        sym=bit2sym(modulationOrder,a);
        signal_power=10.^(SNRdB/10)*noisePower*log2(modulationOrder);
        Scaled_signal=sqrt(signal_power)*sym;
        noise=sqrt(noisePower)*sqrt(0.5)*(randn(1,length(sym))+1i*randn(1,length(sym)));
        %c=awgn(b,SNRdB);
        noisy=noise+Scaled_signal;
        detected=min_distance_detection(noisy,modulationOrder,signal_power);
        SER=(sum(detected-1~=bit2symnum(a,modulationOrder)'))/length(detected);
        bit=sym2bit(detected-1,modulationOrder);
        BER=sum(a~=bit')/length(a);
%     else
%         error("modulation order not supported")
%     end
end
