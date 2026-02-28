% evaluate the Pearson's correlation between activity of t laps (or less) before the
% 1st BTSP and previous PF (average firing laps)
% in space domain
% check activity before the first BTSP event on Day 2—7
% require a PF on exactly one day before
% calculate a value for each cell in each session, and store the values in
% the form of PF_location
% codes: -100, no PF on a given day
%        -101, day 1, no previous PF
%        -102, day 2—7, no previous PF
%        -103, have a PF but no BTSP;
%        -104, have a PF but 1st BTSP at Lap 1;
%        -105, have a PF and BTSP but no significant transient in t laps before 1st BTSP

% revised on 251004

t = 5;
%%
% WT
MouseID_WT = unique(PF_location_WT(:,1))';
residue_corr_broken_WT = [];
for n = 1:numel(MouseID_WT)
    MouseID = MouseID_WT(n);
    Cells_ID = find(PF_location_WT(:,1)==MouseID);
    for p = 1:numel(Cells_ID)
        row_ID = Cells_ID(p);
        ROI = PF_location_WT(row_ID,2);
        PF_location = PF_location_WT(row_ID,3:9);
        a = [];
        a = PF_location_WT(row_ID,1:2);
        residue_corr = [];
        for j = 1:7
            x = [];
            if j > 1
                BTSP_cells = BTSP_cells_animals_WT{n,j};
                BinnedData = Binned_Master_WT{n,j};
                BinnedData_prev = Binned_Master_WT{n,(j-1)};
                Binned_noisy = Binned_noisy_dFoF_WT{n,j};
                Binned_noisy_prev = Binned_noisy_dFoF_WT{n,(j-1)};
                BTSPstats = BTSPstats_WT{n,j};

                if ~isnan(PF_location(j)) && ~isnan(PF_location(j-1))
                    if ~isnan(BTSP_cells{ROI,1})
                        PF_location_prev_cm = PF_location(j-1);
                        Firing_laps_prev = find(~isnan(squeeze(BinnedData_prev.Cellstats(ROI,:,7))));
                        Onset = BinnedData_prev.Onset;
                        Firing_laps_prev(Firing_laps_prev<Onset(ROI)) = [];
                        dFoF_firing = Binned_noisy_prev.Cells_dFoF_binned_mean_noisy(Firing_laps_prev,:,ROI);
                        dFoF_firing_mean = nanmean(dFoF_firing,1);
                        BTSP_lap = BTSP_cells{ROI,3}(1);
                        if BTSP_lap > 1
                            t_laps_start = max([1,(BTSP_lap-t)]);
                            t_laps = t_laps_start:(BTSP_lap-1);
                            t_laps_dFoF = BinnedData.Cells_dFoF_binned_mean(t_laps,:,ROI);
                            ff = t_laps_dFoF(:);
                            if any(ff(~isnan(ff)) > 0)
                                t_laps_dFoF_mean = nanmean(t_laps_dFoF,1);
                                x = corr(dFoF_firing_mean',t_laps_dFoF_mean','type','Pearson','rows','complete');
                            else
                                x = -105;
                            end
                        elseif BTSP_lap == 1
                            x = -104;
                        end
                    elseif isnan(BTSP_cells{ROI,1})
                        x = -103;
                    end
                elseif isnan(PF_location(j))
                    x = -100;
                elseif ~isnan(PF_location(j)) && isnan(PF_location(j-1))
                    x = -102;
                end


            elseif j == 1
                x = -101;
            end
            residue_corr(j) = x;
        end
        b = [];
        b = [a,residue_corr];
        residue_corr_broken_WT(row_ID,:) = b;
    end
end

%%
% RTT
MouseID_RTT = unique(PF_location_RTT(:,1))';
residue_corr_broken_RTT = [];
for n = 1:numel(MouseID_RTT)
    MouseID = MouseID_RTT(n);
    Cells_ID = find(PF_location_RTT(:,1)==MouseID);
    for p = 1:numel(Cells_ID)
        row_ID = Cells_ID(p);
        ROI = PF_location_RTT(row_ID,2);
        PF_location = PF_location_RTT(row_ID,3:9);
        a = [];
        a = PF_location_RTT(row_ID,1:2);
        residue_corr = [];
        for j = 1:7
            x = [];
            if j > 1
                BTSP_cells = BTSP_cells_animals_RTT{n,j};
                BinnedData = Binned_Master_RTT{n,j};
                BinnedData_prev = Binned_Master_RTT{n,(j-1)};
                Binned_noisy = Binned_noisy_dFoF_RTT{n,j};
                Binned_noisy_prev = Binned_noisy_dFoF_RTT{n,(j-1)};
                BTSPstats = BTSPstats_RTT{n,j};

                if ~isnan(PF_location(j)) && ~isnan(PF_location(j-1))
                    if ~isnan(BTSP_cells{ROI,1})
                        PF_location_prev_cm = PF_location(j-1);
                        Firing_laps_prev = find(~isnan(squeeze(BinnedData_prev.Cellstats(ROI,:,7))));
                        Onset = BinnedData_prev.Onset;
                        Firing_laps_prev(Firing_laps_prev<Onset(ROI)) = [];
                        dFoF_firing = Binned_noisy_prev.Cells_dFoF_binned_mean_noisy(Firing_laps_prev,:,ROI);
                        dFoF_firing_mean = nanmean(dFoF_firing,1);
                        BTSP_lap = BTSP_cells{ROI,3}(1);
                        if BTSP_lap > 1
                            t_laps_start = max([1,(BTSP_lap-t)]);
                            t_laps = t_laps_start:(BTSP_lap-1);
                            t_laps_dFoF = BinnedData.Cells_dFoF_binned_mean(t_laps,:,ROI);
                            ff = t_laps_dFoF(:);
                            if any(ff(~isnan(ff)) > 0)
                                t_laps_dFoF_mean = nanmean(t_laps_dFoF,1);
                                x = corr(dFoF_firing_mean',t_laps_dFoF_mean','type','Pearson','rows','complete');
                            else
                                x = -105;
                            end
                        elseif BTSP_lap == 1
                            x = -104;
                        end
                    elseif isnan(BTSP_cells{ROI,1})
                        x = -103;
                    end
                elseif isnan(PF_location(j))
                    x = -100;
                elseif ~isnan(PF_location(j)) && isnan(PF_location(j-1))
                    x = -102;
                end


            elseif j == 1
                x = -101;
            end
            residue_corr(j) = x;
        end
        b = [];
        b = [a,residue_corr];
        residue_corr_broken_RTT(row_ID,:) = b;
    end
end

%%
% plot residue_corr only for the Day-1 appearing PCs
% separated by stability (how long does it maintain the same PF)
% WT
MouseID_WT = unique(PF_location_WT(:,1))';
rcorr_7days_WT_F01 = {};
for i = 1:7
    PCs_indices =...
        find(PF_location_WT_track_7_days(:,10)==1 & PF_location_WT_track_7_days(:,11)==i);
    rcorr = [];
    for k = 1:numel(PCs_indices)
        MouseID = PF_location_WT_track_7_days(PCs_indices(k),1);
        ROI = PF_location_WT_track_7_days(PCs_indices(k),2);
        row_ID = find(PF_location_WT(:,1)==MouseID & PF_location_WT(:,2)==ROI);
        for j = 1:i
            coe = residue_corr_broken_WT(row_ID,(j+2));
            if coe > -100
                rcorr(k,j) = coe;
            else
                rcorr(k,j) = NaN;
            end
        end
    end
    rcorr_7days_WT_F01{i} = rcorr;
end

figure;
hold on;
for i = 1:7
    rcorr_cells = rcorr_7days_WT_F01{i};
    rcorr_cells_mean = nanmean(rcorr_cells,1);
    x = 1:i;
    plot(x,rcorr_cells_mean,'-o');
end
xlim([0.8 7]);
ylim([0 0.7]);
xlabel('Day');
ylabel('Prev PF-residual corr');
title('WT, Day 1-appearing PCs');
set(gca, 'FontSize', 14);
hold off;

%%
% plot residue_corr only for the Day-1 appearing PCs
% separated by stability (how long does it maintain the same PF)
% RTT
MouseID_RTT = unique(PF_location_RTT(:,1))';
rcorr_7days_RTT_F01 = {};
for i = 1:7
    PCs_indices =...
        find(PF_location_RTT_track_7_days(:,10)==1 & PF_location_RTT_track_7_days(:,11)==i);
    rcorr = [];
    for k = 1:numel(PCs_indices)
        MouseID = PF_location_RTT_track_7_days(PCs_indices(k),1);
        ROI = PF_location_RTT_track_7_days(PCs_indices(k),2);
        row_ID = find(PF_location_RTT(:,1)==MouseID & PF_location_RTT(:,2)==ROI);
        for j = 1:i
            coe = residue_corr_broken_RTT(row_ID,(j+2));
            if coe > -100
                rcorr(k,j) = coe;
            else
                rcorr(k,j) = NaN;
            end
        end
    end
    rcorr_7days_RTT_F01{i} = rcorr;
end

figure;
hold on;
for i = 1:7
    rcorr_cells = rcorr_7days_RTT_F01{i};
    rcorr_cells_mean = nanmean(rcorr_cells,1);
    x = 1:i;
    plot(x,rcorr_cells_mean,'-o');
end
xlim([0.8 7]);
ylim([0 0.7]);
xlabel('Day');
ylabel('Prev PF-residual corr');
title('RTT, Day 1-appearing PCs');
set(gca, 'FontSize', 14);
hold off;

%%
% plot residue_corr only for the Day-2 appearing PCs
% separated by stability (how long does it maintain the same PF)
% WT
MouseID_WT = unique(PF_location_WT(:,1))';
rcorr_7days_WT_F02 = {};
for i = 2:7
    PCs_indices =...
        find(PF_location_WT_track_7_days(:,10)==2 & PF_location_WT_track_7_days(:,11)==i);
    rcorr = [];
    for k = 1:numel(PCs_indices)
        MouseID = PF_location_WT_track_7_days(PCs_indices(k),1);
        ROI = PF_location_WT_track_7_days(PCs_indices(k),2);
        row_ID = find(PF_location_WT(:,1)==MouseID & PF_location_WT(:,2)==ROI);
        for j = 2:i
            coe = residue_corr_broken_WT(row_ID,(j+2));
            if coe > -100
                rcorr(k,j) = coe;
            else
                rcorr(k,j) = NaN;
            end
        end
    end
    rcorr_7days_WT_F02{i} = rcorr;
end

figure;
hold on;
for i = 2:7
    rcorr_cells = rcorr_7days_WT_F02{i}(:,2:end);
    rcorr_cells_mean = nanmean(rcorr_cells,1);
    x = 2:i;
    plot(x,rcorr_cells_mean,'-o');
end
xlim([0.8 7]);
ylim([-0.2 0.7]);
xlabel('Day');
ylabel('Prev PF-residual corr');
title('WT, Day 2-appearing PCs');
set(gca, 'FontSize', 14);
hold off;

%%
% plot residue_corr only for the Day-2 appearing PCs
% separated by stability (how long does it maintain the same PF)
% RTT
MouseID_RTT = unique(PF_location_RTT(:,1))';
rcorr_7days_RTT_F02 = {};
for i = 2:7
    PCs_indices =...
        find(PF_location_RTT_track_7_days(:,10)==2 & PF_location_RTT_track_7_days(:,11)==i);
    rcorr = [];
    for k = 1:numel(PCs_indices)
        MouseID = PF_location_RTT_track_7_days(PCs_indices(k),1);
        ROI = PF_location_RTT_track_7_days(PCs_indices(k),2);
        row_ID = find(PF_location_RTT(:,1)==MouseID & PF_location_RTT(:,2)==ROI);
        for j = 2:i
            coe = residue_corr_broken_RTT(row_ID,(j+2));
            if coe > -100
                rcorr(k,j) = coe;
            else
                rcorr(k,j) = NaN;
            end
        end
    end
    rcorr_7days_RTT_F02{i} = rcorr;
end

figure;
hold on;
for i = 2:7
    rcorr_cells = rcorr_7days_RTT_F02{i}(:,2:end);
    rcorr_cells_mean = nanmean(rcorr_cells,1);
    x = 2:i;
    plot(x,rcorr_cells_mean,'-o');
end
xlim([0.8 7]);
ylim([-0.2 0.7]);
xlabel('Day');
ylabel('Prev PF-residual corr');
title('RTT, Day 2-appearing PCs');
set(gca, 'FontSize', 14);
hold off;

%%
% only plot the prev PF-residual corr for the cells active for specified days

pr = [6,7];
% WT
MouseID_WT = unique(PF_location_WT(:,1))';
residual_corr_WT = [];

for n = 1:numel(MouseID_WT)
    MouseID = MouseID_WT(n);
    Cells_ID = find(PF_location_WT(:,1)==MouseID);
    row_ID_pr = [];
    for p = 1:numel(Cells_ID)
        row_ID = Cells_ID(p);
        PF_loc = [];
        PF_loc = PF_location_WT(row_ID,3:9);
        propensity = numel(find(~isnan(PF_loc)));
        if ismember(propensity,pr)
            row_ID_pr = [row_ID_pr;row_ID];
        end
    end

    if ~isempty(row_ID_pr)
        residual_corr_cells = [];
        for p = 1:numel(row_ID_pr)
            row_ID = row_ID_pr(p);
            ROI = PF_location_WT(row_ID,2);
            residual_corr = [];
            residual_corr = residue_corr_broken_WT(row_ID,3:9);
            residual_corr(residual_corr<=-100) = NaN;
            residual_corr_cells = [residual_corr_cells;residual_corr];
            PF_loc = [];
            PF_loc = PF_location_WT(row_ID,3:9);
        end
        residual_corr_WT(n,:) = nanmean(residual_corr_cells,1);
    end
end

% RTT
MouseID_RTT = unique(PF_location_RTT(:,1))';
residual_corr_RTT = [];

for n = 1:numel(MouseID_RTT)
    MouseID = MouseID_RTT(n);
    Cells_ID = find(PF_location_RTT(:,1)==MouseID);
    row_ID_pr = [];
    for p = 1:numel(Cells_ID)
        row_ID = Cells_ID(p);
        PF_loc = [];
        PF_loc = PF_location_RTT(row_ID,3:9);
        propensity = numel(find(~isnan(PF_loc)));
        if ismember(propensity,pr)
            row_ID_pr = [row_ID_pr;row_ID];
        end
    end

    if ~isempty(row_ID_pr)
        residual_corr_cells = [];
        for p = 1:numel(row_ID_pr)
            row_ID = row_ID_pr(p);
            ROI = PF_location_RTT(row_ID,2);
            residual_corr = [];
            residual_corr = residue_corr_broken_RTT(row_ID,3:9);
            residual_corr(residual_corr<=-100) = NaN;
            residual_corr_cells = [residual_corr_cells;residual_corr];
            PF_loc = [];
            PF_loc = PF_location_RTT(row_ID,3:9);
        end
        residual_corr_RTT(n,:) = nanmean(residual_corr_cells,1);
    end
end

WT = residual_corr_WT(:,2:7);
RTT = residual_corr_RTT(:,2:7);
WT_7_days_mean = nanmean(WT,1);
WT_7_days_SEM = [];
for k = 1:size(WT,2)
    WT_7_days_SEM(k) = std(WT(:,k),'omitnan')/...
        sqrt(size(WT,1)-numel(find(isnan(WT(:,k)))));
end
RTT_7_days_mean = nanmean(RTT,1);
RTT_7_days_SEM = [];
for k = 1:size(RTT,2)
    RTT_7_days_SEM(k) = std(RTT(:,k),'omitnan')/...
        sqrt(size(RTT,1)-numel(find(isnan(RTT(:,k)))));
end

figure;
hold on;
x = 1:size(WT,2);
% WT
h1 = errorbar(x,WT_7_days_mean,WT_7_days_SEM,...
     'o-','LineWidth',3,'Color','blue','MarkerSize',4,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue');
% for m = 1:size(WT,1)
%     plot(x,WT(m,:),...
%     'o','MarkerSize',4,'MarkerEdgeColor','blue','MarkerFaceColor','blue');
% end
% RTT
h2 = errorbar(x,RTT_7_days_mean,RTT_7_days_SEM,...
     'o-','LineWidth',3,'Color','red','MarkerSize',4,'MarkerEdgeColor',...
     'red','MarkerFaceColor','red');
% for m = 1:size(RTT,1)
%     plot(x,RTT(m,:),...
%     'o','MarkerSize',4,'MarkerEdgeColor','red','MarkerFaceColor','red');
% end
hold off;
xlim([0.8 6]);
ylim([0 0.5]);
xticks(1:6);
xnewticklabel = {'1—2','2—3','3—4','4—5','5—6','6—7'};
xticklabels(xnewticklabel);
xlabel('Day');
ylabel('Prev PF-residual corr');
%title('');
%legend([h1 h2],'WT','RTT','FontSize',14,'location','southeast');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

WT = residual_corr_WT(:,2:7);
RTT = residual_corr_RTT(:,2:7);
figure;
[p,tbl,stats,results,tbl_posthoc] = twowayanova(WT,RTT,6);
