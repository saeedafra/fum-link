%inputs
SNRdb=-10:2:20;
modulation="BPSK";
numBits=10e7;
noisePower=0.01;

%initializations
SER=zeros(size(SNRdb));
BER=zeros(size(SNRdb));

%loop over SNR
for kSNR=1:length(SNRdb)
    [SER(kSNR), BER(kSNR)]=runScenario(modulation,SNRdb(kSNR),numBits,noisePower);
end

%results
figure
semilogy(SNRdb,SER,'r.-')
Theory=0.5*erfc(sqrt(10.^(SNRdb/10)));
hold on
semilogy(SNRdb,Theory,'b.-')
xlabel('SNR [dB]')
ylabel('SER [dB]')
title(sprintf('modulation = %s', modulation))
