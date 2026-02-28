function BTSP_dFoF_increase_aw(Binned_Master_WT,BTSP_cells_animals_WT,...
    PF_location_WT,PF_location_WT_track_7_days,Binned_Master_RTT,BTSP_cells_animals_RTT,...
    PF_location_RTT,PF_location_RTT_track_7_days,saving)

%{
This function plot dF/F increase following BTSP events in PCs with BTSP in WT and RTT mice.
Only include first appearance day of a given PF location to eliminate
residual activity.
X: laps (aligned to BTSP event lap). Y: peak dFoF of in-field events (+- 45 cm window of the BTSP event)

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
    = Get_dFoF_BTSP(Binned_Master_WT,BTSP_cells_animals_WT,PF_location_WT,PF_location_WT_track_7_days);
[dFoF_BTSP_cells_7days_RTT,end_of_session_cells_7days_RTT]...
    = Get_dFoF_BTSP(Binned_Master_RTT,BTSP_cells_animals_RTT,PF_location_RTT,PF_location_RTT_track_7_days);

Plot_dFoF_increase(dFoF_BTSP_cells_7days_WT,end_of_session_cells_7days_WT,...
    dFoF_BTSP_cells_7days_RTT,end_of_session_cells_7days_RTT,saving);

end

function [dFoF_BTSP_cells_7days_WT,end_of_session_cells_7days_WT]...
    = Get_dFoF_BTSP(Binned_Master_WT,BTSP_cells_animals_WT,PF_location_WT,PF_location_WT_track_7_days)

dFoF_BTSP_cells_7days_WT = {};
end_of_session_cells_7days_WT = {};
MouseID_WT = unique(PF_location_WT(:,1))';
tracking = PF_location_WT_track_7_days;
for j = 1:size(BTSP_cells_animals_WT,2)
    for i = 1:size(BTSP_cells_animals_WT,1)
        dFoF_BTSP_cells = [];
        end_of_session_cells = [];
        BTSP_cells = BTSP_cells_animals_WT{i,j};
        BinnedData = Binned_Master_WT{i,j};
        for p = 1:size(BTSP_cells,1)
            if ~isnan(BTSP_cells{p,2})
                if ismember(p,BinnedData.PFStats.PFIDs)
                    track_appear_days = [];
                    track_appear_days = tracking(tracking(:,1)==MouseID_WT(i) & tracking(:,2)==p,10);
                    if ~isempty(track_appear_days)
                        if ismember(j,track_appear_days)
                            Cellstats = [];
                            Cellstats = squeeze(BinnedData.Cellstats(p,:,:));
                            BTSP_lap = BTSP_cells{p,3}(1);
                            LapNumber = numel([BinnedData.LapStructure.LapNumber]);
                            BTSP_induction_dFoF = BTSP_cells{p,12}(1);
                            event_peak_bin = [];
                            [event_peak_bin,~] =...
                                GetEventPeakBin_2(BinnedData,BTSP_cells{p,4}(1),BTSP_cells{p,5}(1));
                            
                            laps_before_BTSP = (BTSP_lap-3):(BTSP_lap-1);
                            laps_before_BTSP(laps_before_BTSP<1) = NaN;
                            five_laps_after_BTSP = (BTSP_lap+1):(BTSP_lap+5);
                            five_laps_after_BTSP(five_laps_after_BTSP>LapNumber) = NaN;
                            end_of_session_laps = (LapNumber-2):LapNumber;

                            peak_dFoF_before_BTSP = [];
                            peak_dFoF_after_BTSP = [];
                            end_of_session_laps_dFoF = [];
                            
                            Events = BinnedData.Events(p).Events;
                            dFoF = squeeze(BinnedData.Cells_dFoF_binned_mean(:,:,p));
                            LapStructure = BinnedData.LapStructure;
                            [peak_dFoF_before_BTSP,~] =...
                                Get_in_field_peak(event_peak_bin,laps_before_BTSP,Events,dFoF,LapStructure,12);
                            [peak_dFoF_after_BTSP,~] =...
                                Get_in_field_peak(event_peak_bin,five_laps_after_BTSP,Events,dFoF,LapStructure,12);
                            [end_of_session_laps_dFoF,~] =...
                                Get_in_field_peak(event_peak_bin,end_of_session_laps,Events,dFoF,LapStructure,12);

                            dFoF_around_BTSP = [];
                            dFoF_around_BTSP = [peak_dFoF_before_BTSP,BTSP_induction_dFoF,peak_dFoF_after_BTSP];
                            dFoF_BTSP_cells = [dFoF_BTSP_cells;dFoF_around_BTSP];
                            end_of_session_cells = [end_of_session_cells;end_of_session_laps_dFoF];
                        end
                    end
                end
            end
        end
        dFoF_BTSP_cells_7days_WT{i,j} = dFoF_BTSP_cells;
        end_of_session_cells_7days_WT{i,j} = end_of_session_cells;
    end
end

end

function Plot_dFoF_increase(dFoF_BTSP_cells_7days_WT,end_of_session_cells_7days_WT,...
    dFoF_BTSP_cells_7days_RTT,end_of_session_cells_7days_RTT,saving)

dFoF_around_BTSP_cells_WT = [];
for i = 1:size(dFoF_BTSP_cells_7days_WT,1)
    dFoF_animal = [];
    for j = 1:size(dFoF_BTSP_cells_7days_WT,2)
        dFoF_animal = [dFoF_animal;dFoF_BTSP_cells_7days_WT{i,j}];
    end
    dFoF_around_BTSP_cells_WT = [dFoF_around_BTSP_cells_WT;nanmean(dFoF_animal,1)];
end

dFoF_around_BTSP_cells_RTT = [];
for i = 1:size(dFoF_BTSP_cells_7days_RTT,1)
    dFoF_animal = [];
    for j = 1:size(dFoF_BTSP_cells_7days_RTT,2)
        dFoF_animal = [dFoF_animal;dFoF_BTSP_cells_7days_RTT{i,j}];
    end
    dFoF_around_BTSP_cells_RTT = [dFoF_around_BTSP_cells_RTT;nanmean(dFoF_animal,1)];
end

end_of_session_laps_cells_WT = [];
for i = 1:size(end_of_session_cells_7days_WT,1)
    dFoF_animal = [];
    for j = 1:size(end_of_session_cells_7days_WT,2)
        dFoF_animal = [dFoF_animal;end_of_session_cells_7days_WT{i,j}];
    end
    end_of_session_laps_cells_WT = [end_of_session_laps_cells_WT;nanmean(dFoF_animal,1)];
end

end_of_session_laps_cells_RTT = [];
for i = 1:size(end_of_session_cells_7days_RTT,1)
    dFoF_animal = [];
    for j = 1:size(end_of_session_cells_7days_RTT,2)
        dFoF_animal = [dFoF_animal;end_of_session_cells_7days_RTT{i,j}];
    end
    end_of_session_laps_cells_RTT = [end_of_session_laps_cells_RTT;nanmean(dFoF_animal,1)];
end

WT_mean_BTSP = nanmean(dFoF_around_BTSP_cells_WT,1);
WT_SEM_BTSP = nanstd(dFoF_around_BTSP_cells_WT, 0, 1) ./ sqrt(sum(~isnan(dFoF_around_BTSP_cells_WT), 1));

RTT_mean_BTSP = nanmean(dFoF_around_BTSP_cells_RTT,1);
RTT_SEM_BTSP = nanstd(dFoF_around_BTSP_cells_RTT, 0, 1) ./ sqrt(sum(~isnan(dFoF_around_BTSP_cells_RTT), 1));

WT_mean_end = nanmean(end_of_session_laps_cells_WT,1);
WT_SEM_end = nanstd(end_of_session_laps_cells_WT, 0, 1) ./ sqrt(sum(~isnan(end_of_session_laps_cells_WT), 1));

RTT_mean_end = nanmean(end_of_session_laps_cells_RTT,1);
RTT_SEM_end = nanstd(end_of_session_laps_cells_RTT, 0, 1) ./ sqrt(sum(~isnan(end_of_session_laps_cells_RTT), 1));

rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];

figure;
hold on;
x1 = 1:9;
x2 = 10:12;
h1 = plot(x1,WT_mean_BTSP,'Color',rgb_blue,'LineWidth',3);
x_fill = [x1,fliplr(x1)];
y_fill_upper = WT_mean_BTSP + WT_SEM_BTSP;
y_fill_lower = WT_mean_BTSP - WT_SEM_BTSP;
y_fill = [y_fill_upper,fliplr(y_fill_lower)];
fill(x_fill, y_fill,rgb_blue, 'FaceAlpha', 0.1,'EdgeColor', 'none');

h2 = plot(x1,RTT_mean_BTSP,'Color',rgb_orange,'LineWidth',3);
x_fill = [x1,fliplr(x1)];
y_fill_upper = RTT_mean_BTSP + RTT_SEM_BTSP;
y_fill_lower = RTT_mean_BTSP - RTT_SEM_BTSP;
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

xlim([0.8 9.2])
newxticks = 1:9;
newxticklabels = {'-3','-2','-1','P','1','2','3','4','5'};
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
    print(gcf, 'fig2C.pdf','-dpdf','-vector','-bestfit');
    save('fig2C.mat','dFoF_around_BTSP_cells_WT','dFoF_around_BTSP_cells_RTT');
end


% plot the dF/F increase after BTSP
dFoF_increase_WT = [];
for t = 1:size(dFoF_around_BTSP_cells_WT,1)
    f1 = nanmean(dFoF_around_BTSP_cells_WT(t,1:3),2);
    f2 = nanmean(dFoF_around_BTSP_cells_WT(t,5:9),2);
    dFoF_increase_WT(t,1) = f2/f1;
end

dFoF_increase_RTT = [];
for t = 1:size(dFoF_around_BTSP_cells_RTT,1)
    f1 = nanmean(dFoF_around_BTSP_cells_RTT(t,1:3),2);
    f2 = nanmean(dFoF_around_BTSP_cells_RTT(t,5:9),2);
    dFoF_increase_RTT(t,1) = f2/f1;
end

% bar plot
wt = dFoF_increase_WT;
rtt = dFoF_increase_RTT;

mean_WT = mean(wt);
mean_RTT = mean(rtt);
errors_WT = std(wt)/sqrt(length(wt));
errors_RTT = std(rtt)/sqrt(length(rtt));

rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];
x1 = 1;
sf = 1.6;
x2 = x1*sf;
figure;
hold on;
% Plot bar graph
b1 = bar(x1, mean_WT,'FaceColor', rgb_blue, 'BarWidth', 0.4, 'EdgeColor', 'none'); 
b1.FaceAlpha = 0.5;
b2 = bar(x2, mean_RTT,'FaceColor', rgb_orange, 'BarWidth', 0.4, 'EdgeColor', 'none'); 
b2.FaceAlpha = 0.5;

% Add error bars
eb1 = errorbar(x1, mean_WT, errors_WT, 'Color',rgb_blue, 'LineStyle', 'none', 'LineWidth', 4,'CapSize',25);
eb2 = errorbar(x2, mean_RTT, errors_RTT, 'Color',rgb_orange, 'LineStyle', 'none', 'LineWidth', 4,'CapSize',25);

% Plot individual data points
% s1 = scatter(ones(size(wt)) * x1, wt, 100, rgb_blue, 'filled', 'jitter', 'on', 'jitterAmount', 0.15); % Group A
% s2 = scatter(ones(size(rtt)) * x2, rtt, 100, rgb_orange, 'filled', 'jitter', 'on', 'jitterAmount', 0.15); % Group B

% Customize plot
xlim([x1-0.3 x2+0.3]);
ylim([0 3]);
xticks([x1,x2]);
yticks(0:1:3);
xticklabels({'WT', 'RTT'});
ylabel('post-BTSP/pre-BTSP');
%legend([s1,s2],'WT','RTT','FontSize',14);
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

%print(gcf, 'fig4_2_2.pdf','-dpdf','-vector','-bestfit');

[h,p] = ttest2(wt,rtt)

if saving == 1
    print(gcf, 'suppfig4B.pdf','-dpdf','-vector','-bestfit');
    save('suppfig4B.mat','dFoF_increase_WT','dFoF_increase_RTT');
end

end