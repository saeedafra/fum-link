M=16;

inputBitBlock=[0 1 0 0];
m=log2(M);

n=0;
symbolR=inputBitBlock(m-n)*2-1;
symbolI=inputBitBlock(m-n-1)*(-2)+1;

for n=1:m/2-1
    pureR=inputBitBlock(m-2*n)*2-1;
    pureI=inputBitBlock(m-2*n-1)*(-2)+1;

    offsetR=pureR*n*2;
    offsetI=pureI*n*2;

    inverseR=(-1)*pureR;
    inverseI=pureI;

    symbolR=symbolR*inverseR+offsetR;
    symbolI=symbolI*inverseI+offsetI;
end
disp(symbolR+1i*symbolI)


