function [SER, BER]=runScenario(modulationOrder, SNRdB, numBits,noisePower, channelParams)
    a=randi([0,1],[1,6*numBits]);
%     if strcmp(modulationOrder,"BPSK")
        
        
        sym=bit2sym(modulationOrder,a);
        
        %scale signal to the right power based on SNR
        signal_power=10.^(SNRdB/10)*noisePower*log2(modulationOrder);
        scaled_signal=sqrt(signal_power)*sym;
        
        %channel goes here
        channelOut=channel(scaled_signal, channelParams);
        
        %build and add noise
        noise=sqrt(noisePower)*sqrt(0.5)*(randn(1,length(sym))+1i*randn(1,length(sym)));
        %c=awgn(b,SNRdB);
        noisy=noise+channelOut;
        
        %detection
        detected=min_distance_detection(noisy,modulationOrder,signal_power);
        SER=(sum(detected-1~=bit2symnum(a,modulationOrder)'))/length(detected);
        bit=sym2bit(detected-1,modulationOrder);
        BER=sum(a~=bit')/length(a);
%     else
%         error("modulation order not supported")
%     end
end
