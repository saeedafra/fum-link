function bit=sym2bit(detected,order)
        bit=(dec2bin(detected,log2(order)))';
        bit=bit(:);
        bit=str2num(bit);
end