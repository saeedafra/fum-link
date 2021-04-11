%inputs
SNRdb=10:14;
modulationOrder=16;
Modulation={'BPSK','QAM 4','QAM 8','QAM 16','QAM 32','QAM 64','QAM 128','QAM 256'};
numBits=1e7;
noisePower=0.01;
alpha=0.3; % Pulse shaping Roll off factor
%initializations
SER=zeros(size(SNRdb));
BER=zeros(size(SNRdb));

%loop over SNR
for kSNR=1:length(SNRdb)
    [SER(kSNR), BER(kSNR)]=runScenario(modulationOrder,SNRdb(kSNR),numBits,noisePower,alpha);
end

%results
figure
snrlin=10.^(SNRdb/10);
semilogy(SNRdb,SER,'r*')
Theory=theory(modulationOrder,snrlin);
hold on
semilogy(SNRdb,Theory,'b.-')
xlabel('SNR [dB]')
ylabel('SER [dB]')
grid on
title(['Modulation' Modulation(log2(modulationOrder))])
