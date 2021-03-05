%inputs
SNRdb=-10:2:20;
modulation="BPSK";

%initializations
SER=zeros(size(SNRdb));
BER=zeros(size(SNRdb));

%loop over SNR
for kSNR=1:length(SNRdb)
    [SER(kSNR), BER(kSNR)]=runScenario(modulation,SNRdb(kSNR));
end

%results
figure
semilogy(SNRdb,SER)
xlabel('SNR [dB]')
ylabel('SER [dB]')
title(sprintf('modulation = %s', modulation))
