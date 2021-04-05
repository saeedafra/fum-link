function [SER, BER]=runScenario(modulationOrder, SNRdB, numBits, noisePower)
    k = 223; % message length, the number of symbols in one message. This should be smaller than (modulationOrder-1) and differ with (modulationOrder-1) by an even number. 
    a=randi([0,1],[1,6*numBits]);
    
%     if strcmp(modulationOrder,"BPSK")

%       Transmitter
        sym_num=bit2symnum(a,modulationOrder);
        
%       ENCODING message symbols -> codeword symbols: the block length is
%       modulationOrder-1 if a codeword symbol is
%       log2(modulationOrder)-bit. The input stream is going to be trimmed
%       so that its length becomes to be the multiple of the block length.
        sym_cw = encoder_rs(sym_num, log2(modulationOrder), k);
        sym=bit2sym(modulationOrder,sym_cw); 
        signal_power=10.^(SNRdB/10)*noisePower*log2(modulationOrder);
        Scaled_signal=sqrt(signal_power)*sym;
        
%       CHANNEL 
        noise=sqrt(noisePower)*sqrt(0.5)*(randn(1,length(sym))+1i*randn(1,length(sym)));
        %c=awgn(b,SNRdB);
        noisy=noise+Scaled_signal;
        
%       Receiver 
        detected=min_distance_detection(noisy,modulationOrder,signal_power);
%       DECODING codeword symbols -> message symbols
        sym_dec = decoder_rs(detected-1, log2(modulationOrder), k);
        bit=sym2bit(sym_dec,modulationOrder);
        
%       Error Probability Analysis
        sym_num_trim = sym_num(1: fix(length(sym_num)/k)*k); % If the sequence of symbols are not a multiple of the message length, it is trimmed to be one.
        SER=(sum(sym_dec~=sym_num_trim'))/length(sym_dec);
        a_trim = a(1:length(bit)); % a is trimmed so that its length is multiple of (block length)*(bits per symbol).
        BER=sum(a_trim~=bit')/length(a_trim);
%        bit=sym2bit(detected-1,modulationOrder);
%        BER=sum(a~=bit')/length(a);
%     else
%         error("modulation order not supported")
%     end
end
