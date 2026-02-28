% compute stable history using 'tracking' method used for sustained/transient PC analysis (track from the original PF appearing day)

%%
% WT
StableHistory_WT = [];
for p = 1:size(PF_location_WT,1)
    MouseID = PF_location_WT(p,1);
    ROI = PF_location_WT(p,2);
    PF_loc = PF_location_WT(p,:);
    stHis = [];
    for k = 3:size(PF_location_WT,2)
        if ~isnan(PF_loc(k))
            PFs_indices = find(PF_location_WT_track_7_days(:,1)==MouseID &...
                PF_location_WT_track_7_days(:,2)==ROI);
            PFs = PF_location_WT_track_7_days(PFs_indices,:);
            d = k-2;
            b = [];
            b = find(PFs(:,10) <= d & PFs(:,11) >= d);
            if ~isempty(b)
                stHis(k-2) = d-PFs(b,10)+1;
            else
                stHis(k-2) = 0;
            end
        else
            stHis(k-2) = 0;
        end
    end
    StableHistory_WT(p,:) = stHis;
end


%%
% RTT
StableHistory_RTT = [];
for p = 1:size(PF_location_RTT,1)
    MouseID = PF_location_RTT(p,1);
    ROI = PF_location_RTT(p,2);
    PF_loc = PF_location_RTT(p,:);
    stHis = [];
    for k = 3:size(PF_location_RTT,2)
        if ~isnan(PF_loc(k))
            PFs_indices = find(PF_location_RTT_track_7_days(:,1)==MouseID &...
                PF_location_RTT_track_7_days(:,2)==ROI);
            PFs = PF_location_RTT_track_7_days(PFs_indices,:);
            d = k-2;
            b = [];
            b = find(PFs(:,10) <= d & PFs(:,11) >= d);
            if ~isempty(b)
                stHis(k-2) = d-PFs(b,10)+1;
            else
                stHis(k-2) = 0;
            end
        else
            stHis(k-2) = 0;
        end
    end
    StableHistory_RTT(p,:) = stHis;
end