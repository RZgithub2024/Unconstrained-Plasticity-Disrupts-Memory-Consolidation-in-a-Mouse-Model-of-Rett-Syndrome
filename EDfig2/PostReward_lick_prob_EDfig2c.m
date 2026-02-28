% compare licking probability n bins after reward delivery on F00 and experiment days
% aligned to reward

%%
n = 9;

%%
% WT
LickingProb_8days_WT = [];
for j = 1:8
    LickingProb_WT = [];
    for i = 1:size(Binned_Master_WT,1)
        if j == 1
            BinnedData_F00 = Binned_Master_F00_WT{i,1};
            LapStructure = BinnedData_F00.LapStructure;
        elseif j ~= 1
            BinnedData = Binned_Master_WT{i,(j-1)};
            LapStructure = BinnedData.LapStructure;
        end
  
        laps_licks = [];
        for k = 1:numel([LapStructure.LapNumber])
            if ~isempty([LapStructure(k).RewardDeliveryLocation])
                Licks_loc = LapStructure(k).LickingLocation * 100;
                Reward_loc = LapStructure(k).RewardDeliveryLocation * 100;
                Zone_left = Reward_loc;
                Zone_right = min(180,Reward_loc+n*3.6);
                condition = (Licks_loc >= Zone_left) & (Licks_loc <= Zone_right);
                if any(condition)
                    laps_licks = [laps_licks;k];
                end
            end
        end

        LickingProb_8days_WT(i,j) = numel(laps_licks)/numel([LapStructure.LapNumber]);
    end
end


%%
% RTT
LickingProb_8days_RTT = [];
for j = 1:8
    LickingProb_RTT = [];
    for i = 1:size(Binned_Master_RTT,1)
        if j == 1
            BinnedData_F00 = Binned_Master_F00_RTT{i,1};
            LapStructure = BinnedData_F00.LapStructure;
        elseif j ~= 1
            BinnedData = Binned_Master_RTT{i,(j-1)};
            LapStructure = BinnedData.LapStructure;
        end
  
        laps_licks = [];
        for k = 1:numel([LapStructure.LapNumber])
            if ~isempty([LapStructure(k).RewardDeliveryLocation])
                Licks_loc = LapStructure(k).LickingLocation * 100;
                Reward_loc = LapStructure(k).RewardDeliveryLocation * 100;
                Zone_left = Reward_loc;
                Zone_right = min(180,Reward_loc+n*3.6);
                condition = (Licks_loc >= Zone_left) & (Licks_loc <= Zone_right);
                if any(condition)
                    laps_licks = [laps_licks;k];
                end
            end
        end

        LickingProb_8days_RTT(i,j) = numel(laps_licks)/numel([LapStructure.LapNumber]);
    end
end

%%
% plot average data across days in bar graph
% animal-wise two-sample t test
% include F00–F07 data

wt = nanmean(LickingProb_8days_WT(:,2:8),2);
rtt = nanmean(LickingProb_8days_RTT(:,2:8),2);

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
ylim([0 1.1]);
xticks([x1,x2]);
xticklabels({'WT', 'RTT'});
ylabel('Post-reward licking prob.');
%legend([s1,s2],'WT','RTT','FontSize',14);
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

%print(gcf, 'suppfig2D.pdf','-dpdf','-vector','-bestfit');

[h,p] = ttest2(wt,rtt)