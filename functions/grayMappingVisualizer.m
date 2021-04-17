function grayMappingVisualizer(M)

inputDecimal=0:M-1;
inputBit=double(dec2bin(inputDecimal))-48;

inputBitVec=inputBit';
inputBitVec=inputBitVec(:);

symbol=grayMapping(M,inputBitVec);

symbolR=real(symbol);
symbolI=imag(symbol);

posR=(symbolR+sqrt(M)-1)/2+1;
posI=(symbolI+sqrt(M)-1)/2+1;
mappingShape=zeros(log2(M),log2(M));
bitsShape="";
for k=1:M
    mappingShape(posR(k),posI(k))=symbolR(k)+1j*symbolI(k);
    tmpStr=num2str(inputBit(k,:));
    tmpStr(tmpStr==' ')=[];
    bitsShape(posR(k),posI(k))=string(tmpStr);
end

bitsShape=bitsShape';
mappingShape=mappingShape.';

bitsShape=bitsShape(end:-1:1,:);
mappingShape=mappingShape(end:-1:1,:);

for cRow=1:log2(M)
    for cCol=1:log2(M)
        fprintf('%2d + %2dj,%s  ',real(mappingShape(cRow,cCol)),...
            imag(mappingShape(cRow,cCol)),bitsShape(cRow,cCol))
    end
    fprintf('\n')
end

