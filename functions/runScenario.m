function [SER, FER, BER]=runScenario(modulationOrder, SNRdB, numBits, noisePower, AlphabetSize, MessageLength)
    % AlphabetSize: alphabet size of channel coding. BlockLength = 2^AlphabetSize - 1 is the block length of the rs code. 
    % MessageLength: the number of alphabets in one message, which should be < 2^AlphabetSize-1.
    % E.g. When AlphabetSize = 3, MessageLength = 3, a (7,3)-RS code with 3-bit alphabets is constructed. The
    % encoder takes 3*3-bit message and returns 7*3-bit codeword. 
    
    InStream_bit = randi([0,1],[1,6*numBits]);
    N_msg = fix(length(InStream_bit)/MessageLength/AlphabetSize); % number of messages
    
%     if strcmp(modulationOrder,"BPSK")
       
%       TX        
%       ENCODING: k*m message bits -> n*m codeword bits
        cw = encoder_rs(InStream_bit, AlphabetSize, MessageLength); 
%       MODULATION: log2(modulationOrder) bits -> 1 complex symbol 
        sym_num=bit2symnum(cw,modulationOrder);
        sym=bit2sym(modulationOrder,sym_num);  
        signal_power=10.^(SNRdB/10)*noisePower*log2(modulationOrder);
        Scaled_signal=sqrt(signal_power)*sym;
        
%       CHANNEL 
        noise=sqrt(noisePower)*sqrt(0.5)*(randn(1,length(sym))+1i*randn(1,length(sym)));
        %c=awgn(b,SNRdB);
        noisy=noise+Scaled_signal;
        
%       RX 
%       DETECTION: 1 complex symbol -> log2(modulationOrder) bits
        detected=min_distance_detection(noisy,modulationOrder,signal_power);
        bit=sym2bit(detected-1,modulationOrder);

        if numel(bit) ~= numel(cw)
            disp("Some bits for the last block (codeword) are not sent as the bit stream is not a multiple of log2(modulation order).\n")
            disp("The last message will be ignored for the error analysis.")
            N_msg = N_msg - 1;
        end
        
%       DECODING: n*m codeword bits -> k*m message bits
        bit_dec = decoder_rs(bit(1:N_msg*(2^AlphabetSize-1)*AlphabetSize), AlphabetSize, MessageLength)';      
        
%       Error Probability Analysis
%       Symbol Error Rate of Modulation
        SER=(sum(detected-1~=sym_num'))/length(detected); 
%       Frame Error Rate of Channel Coding
        FE = 0;
        for i = 1:N_msg
            FE = FE + (sum(bit_dec((i-1)*MessageLength+1:i*MessageLength)~=InStream_bit((i-1)*MessageLength+1:i*MessageLength))>0);
        end
        FER=FE/N_msg;
%       Bit Error Rate
        BER=sum(InStream_bit(1:length(bit_dec))~=bit_dec) / length(bit_dec);
        
%     else
%         error("modulation order not supported")
%     end
end
