function bit=sym2bit(symbol,order)
        a=-sqrt(order)+1:2:sqrt(order)-1;
        b=(-sqrt(order)+1:2:sqrt(order)-1)*1j;
        c=(a+b');
        c=c(:);
        bitnum=zeros(1,length(symbol));
        for i=1:length(symbol)
            bitnum(i)=find(symbol(i)==c)-1;
        end
        bit=(dec2bin(bitnum,log2(order)))';
        bit=bit(:);
        bit=str2num(bit);
end