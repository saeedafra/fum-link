function detected_symbol=min_distance_detection(symbol,order,signal_power)
detected_symbol=zeros(size(symbol));
if order>2
    a=-sqrt(order)+1:2:sqrt(order)-1;
    b=(-sqrt(order)+1:2:sqrt(order)-1)*1j;
    c=(a+b');
    c=c(:);
    coef=sum(abs(c).^2)/length(c);
    c=sqrt(signal_power)*sqrt(1/coef)*c;
    
    detected_symbol=zeros(size(symbol));
    for k=1:length(symbol)
        dist=abs(symbol(k)-c);
        [m,detected_symbol(k)]=min(dist);
    end
else
    c=[-1;1];
     for k=1:length(symbol)
         dist=abs(symbol(k)-c);
         [m,detected_symbol(k)]=min(dist);
     end
end