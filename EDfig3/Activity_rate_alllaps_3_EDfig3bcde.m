% examine AUC/sec and event rate of all running-related events
% check all cells
% use AUC_events_2()
% for each session, convert data (AUC/s and event rate) from linear scale to log scale, then
% calculate the mean under log scale for animal-wise comparison
% small addition to prevent log(0) = -inf: epsilon = 1e-8 (a fixed value)


%%
% WT
tic;
AUCsec_WT_cells = [];
AUCsec_WT_7day = [];
AUCsec_WT_7day_animals = {};

event_rate_WT_cells = [];
event_rate_WT_7day = [];
event_rate_WT_7day_animals = {};

for i = 1:size(Binned_Master_WT,1)
    for j = 1:size(Binned_Master_WT,2)
        BinnedData = Binned_Master_WT{i,j};
        noisy = Binned_noisy_dFoF_WT{i,j};
        Cells_N = size(BinnedData.Cells_dFoF_denoised,1);
        frame_numbers = [BinnedData.LapStructure.FrameNumber];
        
        f = [];
        for kk = 1:numel([BinnedData.LapStructure.LapNumber])
            f0 = BinnedData.LapStructure(kk).FrameNumber_running;
            f = [f,f0];
        end
        running_time = numel(f)/30;

        AUCsec_cells = [];
        event_rate_cells = [];
        for ROI = 1:Cells_N
            Events = [];
            Events = BinnedData.Events(ROI).Events;
            if ~isempty(Events)
                dFoF_noisy = noisy.Cells_dFoF_noisy(ROI,:);
                AUC_cumu = AUC_cumu_positive(dFoF_noisy);
                Events_Running = [];
                events_running_idx = [];
                events_running_idx = ismember(Events(:,1), frame_numbers) & ...
                    ismember(Events(:,2), frame_numbers) & ...
                    ismember(Events(:,5), frame_numbers) & ...
                    (Events(:,3) > 0) & ...
                    (Events(:,6) >= 0) & ...
                    (Events(:,6) <= 180);
                Events_Running = Events(events_running_idx,:);
                if ~isempty(Events_Running)
                    AUC_sum = AUC_events_2(AUC_cumu,Events_Running);
                    AUCsec = AUC_sum/running_time;
                    event_rate = size(Events_Running,1)/running_time;
                else
                    AUCsec = 0;
                    event_rate = 0;
                end
            else
                AUCsec = 0;
                event_rate = 0;
            end
            AUCsec_cells = [AUCsec_cells;AUCsec];
            event_rate_cells = [event_rate_cells;event_rate];  
        end
        AUCsec_WT_cells = [AUCsec_WT_cells;AUCsec_cells];
        AUCsec_WT_7day_animals{i,j} = AUCsec_cells;
        
        event_rate_WT_cells = [event_rate_WT_cells;event_rate_cells];
        event_rate_WT_7day_animals{i,j} = event_rate_cells;
        
        % convert data to log scale
        epsilon = 1e-8; % small addition to prevent log0 = -inf;
        AUCsec_cells_log = [];
        AUCsec_cells_log = log10(AUCsec_cells+epsilon);
        AUCsec_WT_7day(i,j) = nanmean(AUCsec_cells_log);
        
        event_rate_cells_log = [];
        event_rate_cells_log = log10(event_rate_cells+epsilon);
        event_rate_WT_7day(i,j) = nanmean(event_rate_cells_log);
    end
end
toc;

%%
% RTT
tic;
AUCsec_RTT_cells = [];
AUCsec_RTT_7day = [];
AUCsec_RTT_7day_animals = {};

event_rate_RTT_cells = [];
event_rate_RTT_7day = [];
event_rate_RTT_7day_animals = {};

for i = 1:size(Binned_Master_RTT,1)
    for j = 1:size(Binned_Master_RTT,2)
        BinnedData = Binned_Master_RTT{i,j};
        noisy = Binned_noisy_dFoF_RTT{i,j};
        Cells_N = size(BinnedData.Cells_dFoF_denoised,1);
        frame_numbers = [BinnedData.LapStructure.FrameNumber];
        
        f = [];
        for kk = 1:numel([BinnedData.LapStructure.LapNumber])
            f0 = BinnedData.LapStructure(kk).FrameNumber_running;
            f = [f,f0];
        end
        running_time = numel(f)/30;

        AUCsec_cells = [];
        event_rate_cells = [];
        for ROI = 1:Cells_N
            Events = [];
            Events = BinnedData.Events(ROI).Events;
            if ~isempty(Events)
                dFoF_noisy = noisy.Cells_dFoF_noisy(ROI,:);
                AUC_cumu = AUC_cumu_positive(dFoF_noisy);
                Events_Running = [];
                events_running_idx = [];
                events_running_idx = ismember(Events(:,1), frame_numbers) & ...
                    ismember(Events(:,2), frame_numbers) & ...
                    ismember(Events(:,5), frame_numbers) & ...
                    (Events(:,3) > 0) & ...
                    (Events(:,6) >= 0) & ...
                    (Events(:,6) <= 180);
                Events_Running = Events(events_running_idx,:);
                if ~isempty(Events_Running)
                    AUC_sum = AUC_events_2(AUC_cumu,Events_Running);
                    AUCsec = AUC_sum/running_time;
                    event_rate = size(Events_Running,1)/running_time;
                else
                    AUCsec = 0;
                    event_rate = 0;
                end
            else
                AUCsec = 0;
                event_rate = 0;
            end
            AUCsec_cells = [AUCsec_cells;AUCsec];
            event_rate_cells = [event_rate_cells;event_rate];  
        end
        AUCsec_RTT_cells = [AUCsec_RTT_cells;AUCsec_cells];
        AUCsec_RTT_7day_animals{i,j} = AUCsec_cells;
        
        event_rate_RTT_cells = [event_rate_RTT_cells;event_rate_cells];
        event_rate_RTT_7day_animals{i,j} = event_rate_cells;
        
        % convert data to log scale
        epsilon = 1e-8; % small addition to prevent log0 = -inf;
        AUCsec_cells_log = [];
        AUCsec_cells_log = log10(AUCsec_cells+epsilon);
        AUCsec_RTT_7day(i,j) = nanmean(AUCsec_cells_log);
        
        event_rate_cells_log = [];
        event_rate_cells_log = log10(event_rate_cells+epsilon);
        event_rate_RTT_7day(i,j) = nanmean(event_rate_cells_log);
    end
end
toc;

%%
% make cdf plot of event rate in log scale
epsilon_WT = 1e-8;
WT = log10(event_rate_WT_cells+epsilon_WT);

epsilon_RTT = 1e-8;
RTT = log10(event_rate_RTT_cells+epsilon_RTT);

figure;
hold on;
rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];
h1 = cdfplot(WT);
h2 = cdfplot(RTT);
set(h1, 'LineWidth', 3, 'Color', rgb_blue);
set(h2, 'LineWidth', 3, 'Color', rgb_orange);
xlim([-2.6 -0.35]);
ylim([-0.01 1]);
xlabel('log10(event rate (s-1))');
ylabel('Cumulative probability');
xticks(-3:0.5:0);
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
title('');
box off;
grid off;
hold off;

%print(gcf, 'suppfig3C_left.pdf','-dpdf','-vector','-bestfit');

[h,p,~] = kstest2(WT, RTT)

%%
% plot average event rate
WT = event_rate_WT_7day;
RTT = event_rate_RTT_7day;

[WT_mean,WT_SEM] = MeanSem_omitnan(WT);
[RTT_mean,RTT_SEM] = MeanSem_omitnan(RTT);

figure;
hold on;
rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];
MeanSEM_ribbon(WT_mean,WT_SEM,RTT_mean,RTT_SEM,rgb_blue,rgb_orange,0.2);
hold off;
xlim([0.8 7+0.2]);
ylim([-1.5 -1]);
xticks(1:7);
xlabel('Time (day)');
ylabel('log10(event rate (s-1))');
%legend([h1,h2],'WT','RTT','FontSize',14);
set(gca, 'TickDir', 'out');
%title('Place cell fraction');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

%print(gcf, 'suppfig3C_right.pdf','-dpdf','-vector','-bestfit');

WT = event_rate_WT_7day;
RTT = event_rate_RTT_7day;
[ranovatbl,anovatbl,results_posthoc] = twrm_ANOVA(WT,RTT);

%%
% make cdf plot of AUC/s in log scale
epsilon_WT = 1e-8;
WT = log10(AUCsec_WT_cells+epsilon_WT);

epsilon_RTT = 1e-8;
RTT = log10(AUCsec_RTT_cells+epsilon_RTT);

figure;
hold on;
rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];
h1 = cdfplot(WT);
h2 = cdfplot(RTT);
set(h1, 'LineWidth', 3, 'Color', rgb_blue);
set(h2, 'LineWidth', 3, 'Color', rgb_orange);
xlim([-3-0.2 1.2+0.2]);
ylim([-0.01 1]);
xlabel('log10(activity rate (AUC/s))');
ylabel('Cumulative probability');
xticks(-3:1:2);
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
title('');
box off;
grid off;
hold off;

%print(gcf, 'suppfig3B_left.pdf','-dpdf','-vector','-bestfit');

[h,p,~] = kstest2(WT, RTT)

%%
% plot average AUC/s
WT = AUCsec_WT_7day;
RTT = AUCsec_RTT_7day;

[WT_mean,WT_SEM] = MeanSem_omitnan(WT);
[RTT_mean,RTT_SEM] = MeanSem_omitnan(RTT);

figure;
hold on;
rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];
MeanSEM_ribbon(WT_mean,WT_SEM,RTT_mean,RTT_SEM,rgb_blue,rgb_orange,0.2);
hold off;
xlim([0.8 7+0.2]);
ylim([-1 -0.2]);
xticks(1:7);
yticks(-1:0.2:0);
xlabel('Time (day)');
ylabel('log10(activity rate (AUC/s))');
%legend([h1,h2],'WT','RTT','FontSize',14);
set(gca, 'TickDir', 'out');
%title('Place cell fraction');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

%print(gcf, 'suppfig3B_right.pdf','-dpdf','-vector','-bestfit');

WT = AUCsec_WT_7day;
RTT = AUCsec_RTT_7day;
[ranovatbl,anovatbl,results_posthoc] = twrm_ANOVA(WT,RTT);
