function [SER, BER]=runScenario(modulation, SNRdB, numBits, noisePower)
    a=randi([0,1],[1,numBits]);
    if strcmp(modulation,"BPSK")
        b=2*a-1;
        signalPower=10^(SNRdB/10)*noisePower;
        scaledSig=b*sqrt(signalPower);
        %c=awgn(b,SNRdB);
        noiseVec=sqrt(noisePower)*sqrt(1/2)*...
            (randn(1,numBits)+ 1i*randn(1,numBits));
        c=scaledSig+noiseVec;
        c(real(c)>0)=1;
        c(real(c)<=0)=-1;
        SER=(sum(c~=b))/length(c);
        BER=SER;
    else
        error("modulation order not supported")
    end
end
