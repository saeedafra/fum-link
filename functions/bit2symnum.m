function sym_num=bit2symnum(bit_stream,order)
if order>2
bit=bit_stream(1:floor(length(bit_stream)/log2(order))*log2(order));
a=reshape(bit,[log2(order),floor(length(bit_stream)/log2(order))]);
b=2.^[0:log2(order)-1];
sym_num=(b*a)';

else 
    sym_num=bit_stream;
end
