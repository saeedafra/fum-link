inStruct.SNRdb=-10:5:30;
inStruct.modulationOrder=16;
inStruct.numBits=1e6;
inStruct.noisePower=0.01;

%these internal variables must be kept internal. either turn it into a
%function or what?
snrlin=10.^(inStruct.SNRdb/10);
analyticSER=theory(inStruct.modulationOrder,snrlin);

refStruct.SER.value=analyticSER;
refStruct.SER.epsilon=0.01;



