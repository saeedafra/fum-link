classdef channel < handle
    properties
        channelParams
        filterZi
        channelFilterLength
    end
    methods
        function obj=channel(channelParams)
            obj.channelParams=channelParams;
            obj.buildChannelModel();
            obj.filterZi=zeros(obj.channelFilterLength-1,1);
        end
        function outSignal=passThrough(obj,inSignal)
            h=obj.generateRealization();
            [outSignal,obj.filterZi]=filter(h,1,inSignal,obj.filterZi);
        end
        function buildChannelModel(obj)
            %temporary code, building an ideal channel
            obj.channelFilterLength=1;
        end
        function h=generateRealization(obj)
            %temporary code, building an ideal channel
            h=1;
        end
    end
end

