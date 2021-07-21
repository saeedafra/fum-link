function outStruct=runSim(inStruct)

Modulation={'BPSK','QAM 4','QAM 8','QAM 16','QAM 32','QAM 64','QAM 128','QAM 256'};

%initializations
outStruct.SER=zeros(size(inStruct.SNRdb));
outStruct.BER=zeros(size(inStruct.SNRdb));

%loop over SNR
for kSNR=1:length(inStruct.SNRdb)
    [outStruct.SER(kSNR), outStruct.BER(kSNR)]=runScenario(inStruct.modulationOrder,inStruct.SNRdb(kSNR),inStruct.numBits,inStruct.noisePower, inStruct.channelParams);
end


