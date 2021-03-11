function [SER, BER]=runScenario(modulation, SNRdB)
a=randi([0,1],[1,1e7]);
if strcmp(modulation,"BPSK")
b=2*a-1;
c=awgn(b,SNRdB);
c(c>0)=1;
c(c<=0)=-1;
SER=(sum(c~=b))/length(c);
BER=SER;
end
end
