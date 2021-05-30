%this script is a template for runnig the simulator
setPath

inStruct.SNRdb=-10:5:15;
inStruct.modulationOrder=16;
inStruct.numBits=1e6;
inStruct.noisePower=0.01;

outStruct=runSim(inStruct);

figure
snrLin=10.^(inStruct.SNRdb/10);
semilogy(inStruct.SNRdb,outStruct.SER,'r*')

analyticSER=theory(inStruct.modulationOrder,snrLin);
hold on
semilogy(inStruct.SNRdb,analyticSER,'b.-')

xlabel('SNR [dB]')
ylabel('SER [dB]')
grid on
title(sprintf('modOrder=%d',inStruct.modulationOrder))