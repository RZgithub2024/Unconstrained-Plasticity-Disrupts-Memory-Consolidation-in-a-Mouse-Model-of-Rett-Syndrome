% percentage of PCs out of total imaged cells
%%
% WT
PC_fraction_WT_7_days = [];
PC_number_WT_7_days = [];
for j = 1:size(Binned_Master_WT,2)
    for i = 1:size(Binned_Master_WT,1)
        BinnedData = Binned_Master_WT{i,j};
        PC_fraction = BinnedData.PFStats.Percentage;
        PC_fraction_WT_7_days(i,j) = PC_fraction;
        PC_number_WT_7_days(i,j) = BinnedData.PFStats.No_PFs;
    end
end

% RTT
PC_fraction_RTT_7_days = [];
PC_number_RTT_7_days = [];
for j = 1:size(Binned_Master_RTT,2)
    for i = 1:size(Binned_Master_RTT,1)
        BinnedData = Binned_Master_RTT{i,j};
        PC_fraction = BinnedData.PFStats.Percentage;
        PC_fraction_RTT_7_days(i,j) = PC_fraction;
        PC_number_RTT_7_days(i,j) = BinnedData.PFStats.No_PFs;
    end
end

%%
% bar graph
% PC percentage of total imaged CA1 cells

WT = PC_fraction_WT_7_days;
RTT = PC_fraction_RTT_7_days;

[WT_mean,WT_SEM] = MeanSem_omitnan(WT);
[RTT_mean,RTT_SEM] = MeanSem_omitnan(RTT);

WT_RTT_means = [WT_mean; RTT_mean]';

rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];

% Create grouped bar plot
figure;
b = bar(WT_RTT_means, 'grouped','BarWidth', 1);
hold on;
% Set colors
b(1).FaceColor = rgb_blue;
b(2).FaceColor = rgb_orange;
% Set Opacity
b(1).FaceAlpha = 0.65;
b(2).FaceAlpha = 0.65;
% Calculate x positions for error bars
[ngroups, nbars] = size(WT_RTT_means);
x = nan(nbars, ngroups);
for i = 1:nbars
    x(i,:) = b(i).XEndPoints;
end
% Plot error bars
errorbar(x(1,:), WT_mean, WT_SEM, 'k', 'linestyle', 'none', 'LineWidth', 1);
errorbar(x(2,:), RTT_mean, RTT_SEM, 'k', 'linestyle', 'none', 'LineWidth', 1);

% Customize plot
xticks(1:size(WT,2));
xlabel('Time (day)');
ylim([0 40]);
ylabel('% of CA1 cells');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
box off;

%print(gcf, 'fig1K_bar.pdf','-dpdf','-vector','-bestfit');

WT = PC_fraction_WT_7_days;
RTT = PC_fraction_RTT_7_days;
[ranovatbl,anovatbl,results_posthoc] = twrm_ANOVA(WT,RTT);

