function y=add_noise(symbol,snrlin,order)
    y=2*snrlin*log2(order);
    noise_std=sqrt(1/y);
if ~isreal(symbol)

    y=symbol+noise_std.*(randn(size(symbol))+randn(size(symbol))*1i);
else
    y=symbol+noise_std.*randn(size(symbol));
end