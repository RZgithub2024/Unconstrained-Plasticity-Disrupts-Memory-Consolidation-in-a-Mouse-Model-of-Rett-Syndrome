%{
% this script follows BTSP_stats_8
% BTSP_stats_8 looks for BTSP events in both PCs and non-PCs using
Cellstats and calcium events
% analyze % of PC w/BTSP and % of imaged cells w/BTSP
% analyze BTSP rate

% BTSP_cells_animals_WT:
% column 1: ROI ID
% column 2: number of BTSP events
% column 3: lap ID of BTSP events
% column 4: event peak frame of BTSP events
% column 5: event peak location of BTSP event (cm)
% column 6: number of non-BTSP plateaus
% column 7: lap ID of non-BTSP plateaus
% column 8: event peak frame of non-BTSP plateaus
% column 9: event peak location of non-BTSP plateaus (cm)
% column 10: number of (BTSP events+non-BTSP plateaus)
% column 11: plateau rate (per lap) = column 10 / total lap number
% column 12: event amplitude of BTSP events (dF/F)
% column 13: PC or not, 1 = PC, 0 = non-PC
%}

%%
% WT
BTSP_cells_animals_WT = {};

for i = 1:size(Binned_Master_WT,1)
    for j = 1:size(Binned_Master_WT,2)
        Plateau_events = Plateau_events_WT{i,j};
        BinnedData = Binned_Master_WT{i,j};
        LapNumber = numel([BinnedData.LapStructure.LapNumber]);
        BTSP_cells = {};      
        for p = 1:size(Plateau_events,2)
            if ~isempty(Plateau_events{p})
                pl_events = [];
                pl_events = Plateau_events{p};
                BTSP_cells{p,1} = p;
                BTSP_cells{p,2} = numel(find(pl_events(:,16) == 1));
                BTSP_cells{p,3} = pl_events(pl_events(:,16) == 1,4);
                BTSP_cells{p,4} = pl_events(pl_events(:,16) == 1,10);
                BTSP_cells{p,5} = pl_events(pl_events(:,16) == 1,11);
                
                BTSP_cells{p,6} = numel(find(pl_events(:,16) == 2));
                BTSP_cells{p,7} = pl_events(pl_events(:,16) == 2,4);
                BTSP_cells{p,8} = pl_events(pl_events(:,16) == 2,10);
                BTSP_cells{p,9} = pl_events(pl_events(:,16) == 2,11);

                BTSP_cells{p,10} = BTSP_cells{p,2} + BTSP_cells{p,6};
                BTSP_cells{p,11} = BTSP_cells{p,10}/LapNumber;
                BTSP_cells{p,12} = pl_events(pl_events(:,16) == 1,9);

                if BTSP_cells{p,6} ~= 0 && BTSP_cells{p,2} == 0
                    i
                    j
                    p
                    return
                end
            else
                for ii = 1:12
                    BTSP_cells{p,ii} = NaN;
                end
            end

            if ismember(p,BinnedData.PFStats.PFIDs)
                BTSP_cells{p,13} = 1;
            else
                BTSP_cells{p,13} = 0;
            end
        end  
        BTSP_cells_animals_WT{i,j} = BTSP_cells;
    end
end

%%
% RTT
BTSP_cells_animals_RTT = {};

for i = 1:size(Binned_Master_RTT,1)
    for j = 1:size(Binned_Master_RTT,2)
        Plateau_events = Plateau_events_RTT{i,j};
        BinnedData = Binned_Master_RTT{i,j};
        LapNumber = numel([BinnedData.LapStructure.LapNumber]);
        BTSP_cells = {};      
        for p = 1:size(Plateau_events,2)
            if ~isempty(Plateau_events{p})
                pl_events = [];
                pl_events = Plateau_events{p};
                BTSP_cells{p,1} = p;
                BTSP_cells{p,2} = numel(find(pl_events(:,16) == 1));
                BTSP_cells{p,3} = pl_events(pl_events(:,16) == 1,4);
                BTSP_cells{p,4} = pl_events(pl_events(:,16) == 1,10);
                BTSP_cells{p,5} = pl_events(pl_events(:,16) == 1,11);
                
                BTSP_cells{p,6} = numel(find(pl_events(:,16) == 2));
                BTSP_cells{p,7} = pl_events(pl_events(:,16) == 2,4);
                BTSP_cells{p,8} = pl_events(pl_events(:,16) == 2,10);
                BTSP_cells{p,9} = pl_events(pl_events(:,16) == 2,11);

                BTSP_cells{p,10} = BTSP_cells{p,2} + BTSP_cells{p,6};
                BTSP_cells{p,11} = BTSP_cells{p,10}/LapNumber;
                BTSP_cells{p,12} = pl_events(pl_events(:,16) == 1,9);

                if BTSP_cells{p,6} ~= 0 && BTSP_cells{p,2} == 0
                    i
                    j
                    p
                    return
                end
            else
                for ii = 1:12
                    BTSP_cells{p,ii} = NaN;
                end
            end

            if ismember(p,BinnedData.PFStats.PFIDs)
                BTSP_cells{p,13} = 1;
            else
                BTSP_cells{p,13} = 0;
            end
        end  
        BTSP_cells_animals_RTT{i,j} = BTSP_cells;
    end
end

