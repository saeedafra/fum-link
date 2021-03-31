% Author: Saleh Vatankhah
function d=matchedFilter(data,filter,os)
%oversampling factor
y=conv(data,filter); 
mid=ceil(os/2)+40;
z=y(mid:end);
d=downsample(z,os);
