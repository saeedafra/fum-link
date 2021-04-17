function symbol=grayMapping(M,inputBitStream)

if ~isvector(inputBitStream)
    error('input bit stream expected to be a vector')
end

if mod(length(inputBitStream),log2(M)) ~= 0
    error('length of bit stream must be a multiple of log2 M. This must be handled before bit2sym')
end

%do it this way to take log2(M) bit chunks from the stream. Important for
%grayMappingVisualizer at least.
inputBit=reshape(inputBitStream,log2(M),length(inputBitStream)/log2(M));
inputBit=inputBit';

m=log2(M);

n=0;
symbolR=inputBit(:,m-n)*2-1;
symbolI=inputBit(:,m-n-1)*(-2)+1;

for n=1:m/2-1
    pureR=inputBit(:,m-2*n)*2-1;
    pureI=inputBit(:,m-2*n-1)*(-2)+1;

    offsetR=pureR*n*2;
    offsetI=pureI*n*2;

    inverseR=(-1)*pureR;
    inverseI=pureI;

    symbolR=symbolR.*inverseR+offsetR;
    symbolI=symbolI.*inverseI+offsetI;
end

symbol=symbolR+1i*symbolI;



