function SER=theory(modulationOrder,snrlin)
switch modulationOrder
    case 2
        SER=0.5*erfc(sqrt(snrlin));
    case 4
        SER=erfc(sqrt(snrlin)).*(1-0.25*erfc(sqrt(snrlin)));
    case 16
        SER=1.5*erfc(sqrt(0.4*snrlin)).*(1-0.375*erfc(sqrt(0.4*snrlin)));
    case 64
        SER=7/4*erfc(sqrt(1/7*snrlin)).*(1-7/16*erfc(sqrt(1/7*snrlin)));
    case 256
        SER=15/8*erfc(sqrt(12/255*snrlin)).*(1-15/32*erfc(sqrt(12/255*snrlin)));
    otherwise
        error('Undefined')
end
end