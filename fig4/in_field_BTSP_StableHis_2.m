% analyze the probability of stable BTSP events (shift <= 30 cm compared with PF one day before) vs. stable history
% require PFs on day n and day (n-1)
% denominator: N of PCs with given stable history and reactivated and having BTSP on the next day

%%
% WT
MouseID_WT = unique(PF_location_WT(:,1))';
stBTSP_WT = [];
stPC_shift_WT = [];
for i = 1:numel(MouseID_WT)
    stHistory_stPC = [];
    stHistory_shift = [];
    ROIs_indices = find(PF_location_WT(:,1) == MouseID_WT(i));
    for p = 1:length(ROIs_indices)
        row_ID = ROIs_indices(p);
        ROI = PF_location_WT(row_ID,2);
        PF_loc = PF_location_WT(row_ID,3:9);
        for k = 1:size(Binned_Master_WT,2)
            if k < 7
                BTSP_cells = BTSP_cells_animals_WT{i,(k+1)};
                if ~isnan(PF_loc(k)) && ~isnan(PF_loc(k+1)) && ~isnan(BTSP_cells{p,1})
                    stHistory = StableHistory_WT(row_ID,k);
                    a = [];
                    a = [stHistory,0];
                    shift = BeltDistShift(PF_loc(k),BTSP_cells{p,5}(1));
                    if abs(shift) <= 30
                        a = [stHistory,1];
                    end
                    b = [stHistory,abs(shift)];
                    stHistory_shift = [stHistory_shift;b];
                    stHistory_stPC = [stHistory_stPC;a];
                end
            end
        end
    end

    for j = 0:6
        m = sum((stHistory_stPC(:, 1) == j) & (stHistory_stPC(:, 2) == 1));
        n = sum((stHistory_stPC(:, 1) == j));
        stBTSP_WT(i,(j+1)) = m/n*100;

        mm = find(stHistory_shift(:, 1) == j);
        nn = stHistory_shift(mm,2);
        stPC_shift_WT(i,(j+1)) = nanmean(nn);
    end
end

%%
% RTT
MouseID_RTT = unique(PF_location_RTT(:,1))';
stBTSP_RTT = [];
stPC_shift_RTT = [];
for i = 1:numel(MouseID_RTT)
    stHistory_stPC = [];
    stHistory_shift = [];
    ROIs_indices = find(PF_location_RTT(:,1) == MouseID_RTT(i));
    for p = 1:length(ROIs_indices)
        row_ID = ROIs_indices(p);
        ROI = PF_location_RTT(row_ID,2);
        PF_loc = PF_location_RTT(row_ID,3:9);
        for k = 1:size(Binned_Master_RTT,2)
            if k < 7
                BTSP_cells = BTSP_cells_animals_RTT{i,(k+1)};
                if ~isnan(PF_loc(k)) && ~isnan(PF_loc(k+1)) && ~isnan(BTSP_cells{p,1})
                    stHistory = StableHistory_RTT(row_ID,k);
                    a = [];
                    a = [stHistory,0];
                    shift = BeltDistShift(PF_loc(k),BTSP_cells{p,5}(1));
                    if abs(shift) <= 30
                        a = [stHistory,1];
                    end
                    b = [stHistory,abs(shift)];
                    stHistory_shift = [stHistory_shift;b];
                    stHistory_stPC = [stHistory_stPC;a];
                end
            end
        end
    end

    for j = 0:6
        m = sum((stHistory_stPC(:, 1) == j) & (stHistory_stPC(:, 2) == 1));
        n = sum((stHistory_stPC(:, 1) == j));
        stBTSP_RTT(i,(j+1)) = m/n*100;

        mm = find(stHistory_shift(:, 1) == j);
        nn = stHistory_shift(mm,2);
        stPC_shift_RTT(i,(j+1)) = nanmean(nn);
    end
end
