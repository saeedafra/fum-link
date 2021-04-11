% Author: Saleh Vatankhah
function d=matchedFilter(data,filter,os)
%oversampling factor
y=conv(data,filter); 

mid=length(filter);
z=y(mid:end);
d=downsample(z,os);
stem(d,'filled')
