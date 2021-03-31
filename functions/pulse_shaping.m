% Author: Saleh Vatankhah
function [y,filter]=pulse_shaping(data,R,Fs,alpha,type)
% function which takes modulation order, set of symbols and sampling
% frequency and symbol duration (Ts) and outputs generated waveform
% Currently the only available pulse shapes are Raised Cosine and Squared
% Raised Cosine without any correlative coding. 
%in next version correlative coding will be added.
% alpha=pulse shaping parameter
% R=Symbol Rate
% Fs=Sampling Rate
% Type: Determining whether using Raised Cosine(1) or Squared Raised Cosine
% (2)
    Ts=1/Fs; 
    T=1/R; 
    Os=Fs./R;
    n=-20:20;
    N=n*Ts/T; 
    Type={'Raised Cosine','Squared Raised Cosine'};
    if type==1
        filter=sinc(N).*cos(alpha*pi*N)./(1-(2*alpha*N).^2);
        filter(N==0)=1;
        filter(1-(2*alpha*N).^2==0)=pi/4*sinc(N(1-(2*alpha*N).^2==0));
    elseif type==2
        filter=1./(sqrt(T))*(sin(pi*N*(1-alpha))+4*alpha*N.*cos(pi*N*(1+alpha)))./(pi*N.*(1-(4*alpha*N).^2));
        filter(N==0)=1./(sqrt(T))*(1-alpha+4*alpha/pi);
        filter(1-(4*alpha*N).^2==0)=alpha/sqrt(2*T)*((1+2/pi)*sin(pi/(4*alpha))+(1-2/pi)*cos(pi/(4*alpha)));
    else 
        error('Undefined')
    end 
    filter=filter./sqrt(sum(filter.^2));
    sym=zeros(1,length(data)*Os); 
    for i=1:length(data) 
     sym((i-1)*Os+1:i*Os)=data(i); 
    end
    filter=filter/(sum(sqrt(filter.^2)));
    y=conv(sym,filter); 

    stem(y,'filled') 
    title(['Output waveform of' Type(type)])
    xlabel('Samples') 





