function periBTSP_dFoF_residue_2(Binned_Master_WT,BTSP_cells_animals_WT,BTSPstats_WT,...
    PF_location_WT,PF_location_WT_track_7_days,Binned_Master_RTT,BTSP_cells_animals_RTT,BTSPstats_RTT,...
    PF_location_RTT,PF_location_RTT_track_7_days,saving)

%{
This function plot dF/F increase following BTSP events in PCs with BTSP in
WT and RTT mice to show the existence of residue.
Only include the BTSP in PCs following one day with PF. Require a PF on one
day before.
Use Cellstats as input to extract peak dF/F.
BTSP lap number is extracted from BTSPStats.
Use the outputs of BTSPStats_8().

X: laps (aligned to BTSP event lap). Y: peak dFoF (from Cellstats, +- 45 cm window of the peak of average activity)

ARGS:
- Binned_Master_WT: (cell array) Binned session data for WT animals (nAnimals × nDays).
Each cell contains a struct with dF/F, events, laps, etc.
- Binned_Master_RTT: (cell array) Binned session data for RTT animals (nAnimals × nDays).
Each cell contains a struct with dF/F, events, laps, etc.
- BTSP_cells_animals_WT: (cell array) Binned session data for WT animals (nAnimals × nDays).
Contains lap-wise information about BTSP events.
- BTSP_cells_animals_RTT: (cell array) Binned session data for RTT animals (nAnimals × nDays).
Contains lap-wise information about BTSP events.
- PF_location_WT: (numeric array) Cell-wise data on PF or not and PF
location for WT animals.
- PF_location_RTT: (numeric array) Cell-wise data on PF or not and PF
location for RTT animals.
- PF_location_WT_track_7_days: (numeric array) Cell-wise data on PF location tracking for WT animals.
- PF_location_RTT_track_7_days: (numeric array) Cell-wise data on PF location tracking for RTT animals.
- saving: save figure and variables (1) or not (0)

RETURNS:
- Plot dF/F increase following BTSP events. Error bar is animal-wise.
- (optional) save figures and varibales to current folder
%}

[dFoF_BTSP_cells_7days_WT,end_of_session_cells_7days_WT]...
    = Get_dFoF_BTSP(Binned_Master_WT,BTSP_cells_animals_WT,BTSPstats_WT,PF_location_WT,PF_location_WT_track_7_days);
[dFoF_BTSP_cells_7days_RTT,end_of_session_cells_7days_RTT]...
    = Get_dFoF_BTSP(Binned_Master_RTT,BTSP_cells_animals_RTT,BTSPstats_RTT,PF_location_RTT,PF_location_RTT_track_7_days);

N_events_WT = size(dFoF_BTSP_cells_7days_WT,1)
N_events_RTT = size(dFoF_BTSP_cells_7days_RTT,1)

Plot_dFoF_increase(dFoF_BTSP_cells_7days_WT,end_of_session_cells_7days_WT,...
    dFoF_BTSP_cells_7days_RTT,end_of_session_cells_7days_RTT,saving);

end

function [dFoF_BTSP_cells_7days_WT,end_of_session_cells_7days_WT]...
    = Get_dFoF_BTSP(Binned_Master_WT,BTSP_cells_animals_WT,BTSPstats_WT,PF_location_WT,PF_location_WT_track_7_days)

k = 3; c = 0;
dFoF_BTSP_cells_7days_WT = [];
end_of_session_cells_7days_WT = [];
MouseID_WT = unique(PF_location_WT(:,1))';
tracking = PF_location_WT_track_7_days;
for j = 2:size(BTSP_cells_animals_WT,2)
    for i = 1:size(BTSP_cells_animals_WT,1)
        BTSP_cells = BTSP_cells_animals_WT{i,j};
        BTSPStats = BTSPstats_WT{i,j};
        BinnedData = Binned_Master_WT{i,j};
        BinnedData_prev = Binned_Master_WT{i,(j-1)};
        for p = 1:size(BTSP_cells,1)
            if ~isnan(BTSP_cells{p,1})
                row_index = find(PF_location_WT(:,1)==MouseID_WT(i) & PF_location_WT(:,2)==p);
                PF_loc = PF_location_WT(row_index,3:9);
                if ~isnan(PF_loc(j-1)) && ~isnan(PF_loc(j))
                    BTSPStats_cell = squeeze(BTSPStats(p,:,:));
                    BTSP_lap = find(BTSPStats_cell(:,22)==1);
                    if BTSP_lap > 1
                        LapNumber = numel([BinnedData.LapStructure.LapNumber]);
                        Cellstats = squeeze(BinnedData.Cellstats(p,:,:));

                        Cellstats_prev = squeeze(BinnedData_prev.Cellstats(p,:,:));
                        Firing_laps_prev = find(~isnan(Cellstats_prev(:,5)));
                        Onset = BinnedData_prev.Onset;
                        Firing_laps_prev(Firing_laps_prev<Onset(p)) = [];
                        last_k_laps = Firing_laps_prev((end-(k-1)):end);
                        peak_last_k_laps = Cellstats_prev(last_k_laps,5);
                        peak_last_k_laps = peak_last_k_laps';

                        laps_pre_BTSP = (BTSP_lap-5):(BTSP_lap-1);
                        laps_pre_BTSP(laps_pre_BTSP<1) = NaN;
                        laps_post_BTSP = (BTSP_lap+1):(BTSP_lap+5);
                        laps_post_BTSP(laps_post_BTSP>LapNumber) = NaN;
                        end_of_session_laps = (LapNumber-2):LapNumber;

                        peak_dFoF_pre_BTSP = [];
                        BTSP_induction_dFoF = [];
                        peak_dFoF_post_BTSP = [];
                        end_of_session_laps_dFoF = [];

                        for kk = 1:numel(laps_pre_BTSP)
                            if ~isnan(laps_pre_BTSP(kk))
                                if ~isnan(Cellstats(laps_pre_BTSP(kk),5))
                                    y0 = Cellstats(laps_pre_BTSP(kk),5);
                                else
                                    y0 = 0;
                                end
                            else
                                y0 = NaN;
                            end
                            peak_dFoF_pre_BTSP = [peak_dFoF_pre_BTSP,y0];
                        end

                        BTSP_induction_dFoF = Cellstats(BTSP_lap,5);

                        for kk = 1:numel(laps_post_BTSP)
                            if ~isnan(laps_post_BTSP(kk))
                                if ~isnan(Cellstats(laps_post_BTSP(kk),5))
                                    y0 = Cellstats(laps_post_BTSP(kk),5);
                                else
                                    y0 = 0;
                                end
                            else
                                y0 = NaN;
                            end
                            peak_dFoF_post_BTSP = [peak_dFoF_post_BTSP,y0];
                        end

                        end_of_session_laps_dFoF = Cellstats(end_of_session_laps,5);



                        dFoF_around_BTSP = [];
                        dFoF_around_BTSP = [peak_last_k_laps,peak_dFoF_pre_BTSP,BTSP_induction_dFoF,peak_dFoF_post_BTSP];
                        if isempty(dFoF_around_BTSP)
                            return
                        end
                        dFoF_BTSP_cells_7days_WT = [dFoF_BTSP_cells_7days_WT;dFoF_around_BTSP];
                        end_of_session_cells_7days_WT = [end_of_session_cells_7days_WT;end_of_session_laps_dFoF];
                        
                    end
                end
            end
        end
    end
end

end

function Plot_dFoF_increase(dFoF_BTSP_cells_7days_WT,end_of_session_cells_7days_WT,...
    dFoF_BTSP_cells_7days_RTT,end_of_session_cells_7days_RTT,saving)

% dFoF_around_BTSP_cells_WT = [];
% for i = 1:size(dFoF_BTSP_cells_7days_WT,1)
%     dFoF_animal = [];
%     for j = 1:size(dFoF_BTSP_cells_7days_WT,2)
%         dFoF_animal = [dFoF_animal;dFoF_BTSP_cells_7days_WT{i,j}];
%     end
%     dFoF_around_BTSP_cells_WT = [dFoF_around_BTSP_cells_WT;nanmean(dFoF_animal,1)];
% end
% 
% dFoF_around_BTSP_cells_RTT = [];
% for i = 1:size(dFoF_BTSP_cells_7days_RTT,1)
%     dFoF_animal = [];
%     for j = 1:size(dFoF_BTSP_cells_7days_RTT,2)
%         dFoF_animal = [dFoF_animal;dFoF_BTSP_cells_7days_RTT{i,j}];
%     end
%     dFoF_around_BTSP_cells_RTT = [dFoF_around_BTSP_cells_RTT;nanmean(dFoF_animal,1)];
% end
% 
% end_of_session_laps_cells_WT = [];
% for i = 1:size(end_of_session_cells_7days_WT,1)
%     dFoF_animal = [];
%     for j = 1:size(end_of_session_cells_7days_WT,2)
%         dFoF_animal = [dFoF_animal;end_of_session_cells_7days_WT{i,j}];
%     end
%     end_of_session_laps_cells_WT = [end_of_session_laps_cells_WT;nanmean(dFoF_animal,1)];
% end
% 
% end_of_session_laps_cells_RTT = [];
% for i = 1:size(end_of_session_cells_7days_RTT,1)
%     dFoF_animal = [];
%     for j = 1:size(end_of_session_cells_7days_RTT,2)
%         dFoF_animal = [dFoF_animal;end_of_session_cells_7days_RTT{i,j}];
%     end
%     end_of_session_laps_cells_RTT = [end_of_session_laps_cells_RTT;nanmean(dFoF_animal,1)];
% end
% 
% WT_mean_BTSP = nanmean(dFoF_around_BTSP_cells_WT,1);
% WT_SEM_BTSP = nanstd(dFoF_around_BTSP_cells_WT, 0, 1) ./ sqrt(sum(~isnan(dFoF_around_BTSP_cells_WT), 1));
% 
% RTT_mean_BTSP = nanmean(dFoF_around_BTSP_cells_RTT,1);
% RTT_SEM_BTSP = nanstd(dFoF_around_BTSP_cells_RTT, 0, 1) ./ sqrt(sum(~isnan(dFoF_around_BTSP_cells_RTT), 1));
% 
% WT_mean_end = nanmean(end_of_session_laps_cells_WT,1);
% WT_SEM_end = nanstd(end_of_session_laps_cells_WT, 0, 1) ./ sqrt(sum(~isnan(end_of_session_laps_cells_WT), 1));
% 
% RTT_mean_end = nanmean(end_of_session_laps_cells_RTT,1);
% RTT_SEM_end = nanstd(end_of_session_laps_cells_RTT, 0, 1) ./ sqrt(sum(~isnan(end_of_session_laps_cells_RTT), 1));



[WT_mean_BTSP,WT_SEM_BTSP] = MeanSem_omitnan(dFoF_BTSP_cells_7days_WT);
[RTT_mean_BTSP,RTT_SEM_BTSP] = MeanSem_omitnan(dFoF_BTSP_cells_7days_RTT);
[WT_mean_end,WT_SEM_end] = MeanSem_omitnan(end_of_session_cells_7days_WT);
[RTT_mean_end,RTT_SEM_end] = MeanSem_omitnan(end_of_session_cells_7days_RTT);

rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];

figure;
hold on;
x0 = 1:3;
x1 = 4:size(WT_mean_BTSP,2);
x2 = 10:12;

h1 = plot(x0,WT_mean_BTSP(x0),'Color',rgb_blue,'LineWidth',3);
x_fill = [x0,fliplr(x0)];
y_fill_upper = WT_mean_BTSP(x0) + WT_SEM_BTSP(x0);
y_fill_lower = WT_mean_BTSP(x0) - WT_SEM_BTSP(x0);
y_fill = [y_fill_upper,fliplr(y_fill_lower)];
fill(x_fill, y_fill,rgb_blue, 'FaceAlpha', 0.1,'EdgeColor', 'none');

h2 = plot(x0,RTT_mean_BTSP(x0),'Color',rgb_orange,'LineWidth',3);
x_fill = [x0,fliplr(x0)];
y_fill_upper = RTT_mean_BTSP(x0) + RTT_SEM_BTSP(x0);
y_fill_lower = RTT_mean_BTSP(x0) - RTT_SEM_BTSP(x0);
y_fill = [y_fill_upper,fliplr(y_fill_lower)];
fill(x_fill, y_fill, rgb_orange, 'FaceAlpha', 0.1,'EdgeColor', 'none');

h1 = plot(x1,WT_mean_BTSP(x1),'Color',rgb_blue,'LineWidth',3);
x_fill = [x1,fliplr(x1)];
y_fill_upper = WT_mean_BTSP(x1) + WT_SEM_BTSP(x1);
y_fill_lower = WT_mean_BTSP(x1) - WT_SEM_BTSP(x1);
y_fill = [y_fill_upper,fliplr(y_fill_lower)];
fill(x_fill, y_fill,rgb_blue, 'FaceAlpha', 0.1,'EdgeColor', 'none');

h2 = plot(x1,RTT_mean_BTSP(x1),'Color',rgb_orange,'LineWidth',3);
x_fill = [x1,fliplr(x1)];
y_fill_upper = RTT_mean_BTSP(x1) + RTT_SEM_BTSP(x1);
y_fill_lower = RTT_mean_BTSP(x1) - RTT_SEM_BTSP(x1);
y_fill = [y_fill_upper,fliplr(y_fill_lower)];
fill(x_fill, y_fill, rgb_orange, 'FaceAlpha', 0.1,'EdgeColor', 'none');

% plot dF/F at the end of sessions

% plot(x2,WT_mean_end,'blue','LineWidth',3);
% x_fill = [x2,fliplr(x2)];
% y_fill_upper = WT_mean_end + WT_SEM_end;
% y_fill_lower = WT_mean_end - WT_SEM_end;
% y_fill = [y_fill_upper,fliplr(y_fill_lower)];
% fill(x_fill, y_fill, 'b', 'FaceAlpha', 0.1,'EdgeColor', 'none');
% 
% plot(x2,RTT_mean_end,'red','LineWidth',3);
% x_fill = [x2,fliplr(x2)];
% y_fill_upper = RTT_mean_end + RTT_SEM_end;
% y_fill_lower = RTT_mean_end - RTT_SEM_end;
% y_fill = [y_fill_upper,fliplr(y_fill_lower)];
% fill(x_fill, y_fill, 'r', 'FaceAlpha', 0.1,'EdgeColor', 'none');

xlim([1-0.2 x1(end)+0.2])
newxticks = 1:x1(end);
newxticklabels = {'-2','-1','E','-5','-4','-3','-2','-1','P','1','2','3','4','5'};
xticks(newxticks);
xticklabels(newxticklabels);
xtickangle(0);
ylim([0 2.5]);
xlabel('Relative lap number');
ylabel('Amplitude (∆F/F)');
%legend([h1,h2],'WT','RTT','FontSize',14,'Location','northeast');
%title('dF/F around BTSP events');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

hold off;

% WT = dFoF_around_BTSP_cells_WT;
% RTT = dFoF_around_BTSP_cells_RTT;
% [ranovatbl,anovatbl,results_posthoc] = twrm_ANOVA(WT,RTT);
% anovaTbl = LMEM(WT,RTT);


if saving == 1
    print(gcf, 'fig4_4_2.pdf','-dpdf','-vector','-bestfit');
    %save('fig2C.mat','dFoF_BTSP_cells_7days_WT','dFoF_BTSP_cells_7days_RTT');
end

end