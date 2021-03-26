function SER=theory(modulationOrder,snrlin)
switch modulationOrder
    case 2
        SER=0.5*erfc(sqrt(snrlin));
    case 4
        SER=2*qfunc(sqrt(2*snrlin)).*(1-0.5*qfunc(sqrt(2*snrlin)));
    case 16
        SER=3*qfunc(sqrt(0.8*snrlin)).*(1-0.75*qfunc(sqrt(0.8*snrlin)));
    case 64
        SER=3.5*qfunc(sqrt(2/7*snrlin)).*(1-7/8*qfunc(sqrt(2/7*snrlin)));
    case 256
        SER=15/4*qfunc(sqrt(24/255*snrlin)).*(1-15/16*qfunc(sqrt(24/255*snrlin)));
    otherwise
        error('Undefined')
end
end