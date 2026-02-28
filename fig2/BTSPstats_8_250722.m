% BTSP analysis
% using BTSPStats_8 function
%%
% WT
tic
BTSPstats_WT = {};
PlateauThereshold_BTSP_WT = {};
Plateau_events_WT = {};

for i = 1:size(Binned_Master_WT,1)
    for j = 1:size(Binned_Master_WT,2)
        BinnedData = Binned_Master_WT{i,j};
        % dbstop if error
        [BTSPstats,PlateauThereshold_BTSP,Plateau_events] =...
            BTSPStats_8(BinnedData);

        BTSPstats_WT{i,j} = BTSPstats;
        PlateauThereshold_BTSP_WT{i,j} = PlateauThereshold_BTSP;
        Plateau_events_WT{i,j} = Plateau_events;

        clear BinnedData
    end
end
toc

%%
% RTT
tic
BTSPstats_RTT = {};
PlateauThereshold_BTSP_RTT = {};
Plateau_events_RTT = {};

for i = 1:size(Binned_Master_RTT,1)
    for j = 1:size(Binned_Master_RTT,2)
        BinnedData = Binned_Master_RTT{i,j};
        [BTSPstats,PlateauThereshold_BTSP,Plateau_events] =...
            BTSPStats_8(BinnedData);

        BTSPstats_RTT{i,j} = BTSPstats;
        PlateauThereshold_BTSP_RTT{i,j} = PlateauThereshold_BTSP;
        Plateau_events_RTT{i,j} = Plateau_events;

        clear BinnedData
    end
end
toc