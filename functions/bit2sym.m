function symbol=bit2sym(order,bit)
if order>2
        a=-sqrt(order)+1:2:sqrt(order)-1;
        b=(-sqrt(order)+1:2:sqrt(order)-1)*1j;
        c=(a+b');
     %   E_avg=sum(abs(c(:)).^2)./log2(order);
% elseif mod(log2(order),2)==1
    c=c(:);
    c=c.';
     coef=sum(abs(c).^2)/length(c);
     symbol=sqrt(1/coef)*c(bit+1);
else
    symbol=(2*bit-1)';
end