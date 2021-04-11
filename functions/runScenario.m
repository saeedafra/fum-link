function [SER, BER]=runScenario(modulationOrder, SNRdB, numBits,noisePower,alpha)
    a=randi([0,1],[1,numBits]);
%     if strcmp(modulationOrder,"BPSK")
        
        sym_num=bit2symnum(a,modulationOrder);
        sym=bit2sym(modulationOrder,sym_num);
        signal_power=10.^(SNRdB/10)*noisePower*log2(modulationOrder);
        Scaled_signal=sqrt(signal_power)*sym;
        [pulse,filter]=pulse_shaping(Scaled_signal,1,8,alpha,2);
        noise=sqrt(noisePower)*sqrt(0.5)*(randn(1,length(pulse))+1i*randn(1,length(pulse)));
        %c=awgn(b,SNRdB);
        noisy=pulse+noise;
         received=matchedFilter(noisy,filter,8);
         received=received(1:length(sym));
        detected=min_distance_detection(received,modulationOrder,signal_power);
        SER=(sum(detected-1~=sym_num'))/length(detected);
        bit=sym2bit(detected-1,modulationOrder);
        BER=sum(a~=bit')/length(a);
%     else
%         error("modulation order not supported")
%     end
end
