%this script is a template for runnig the simulator
setPath

%results
figure
snrlin=10.^(inStruct.SNRdb/10);
semilogy(inStruct.SNRdb,SER,'r*')
Theory=theory(inStruct.modulationOrder,snrlin);
hold on
semilogy(inStruct.SNRdb,Theory,'b.-')
xlabel('SNR [dB]')
ylabel('SER [dB]')
grid on
title(['Modulation' Modulation(log2(inStruct.modulationOrder))])