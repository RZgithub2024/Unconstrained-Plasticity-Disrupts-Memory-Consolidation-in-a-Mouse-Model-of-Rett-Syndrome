% plot mean PF onset (in lap)

%%
% WT
PF_mean_onset_WT = [];
PF_onset_cells_WT = [];
for j = 1:size(Binned_Master_WT,2)
    for i = 1:size(Binned_Master_WT,1)
        BinnedData = Binned_Master_WT{i,j};
        PlaceCell_ID = BinnedData.PFStats.PFIDs;
        PF_onset = BinnedData.Onset(PlaceCell_ID)'; 
        PF_mean_onset_WT(i,j) = nanmean(PF_onset);
        PF_onset_cells_WT = [PF_onset_cells_WT;PF_onset];
    end
end

%%
% RTT
PF_mean_onset_RTT = [];
PF_onset_cells_RTT = [];
for j = 1:size(Binned_Master_RTT,2)
    for i = 1:size(Binned_Master_RTT,1)
        BinnedData = Binned_Master_RTT{i,j};
        PlaceCell_ID = BinnedData.PFStats.PFIDs;
        PF_onset = BinnedData.Onset(PlaceCell_ID)'; 
        PF_mean_onset_RTT(i,j) = nanmean(PF_onset);
        PF_onset_cells_RTT = [PF_onset_cells_RTT;PF_onset];
    end
end

%%
% plot mean onset
WT = PF_mean_onset_WT;
RTT = PF_mean_onset_RTT;

WT_mean = mean(WT,1);
WT_SEM = std(WT)/...
        sqrt(size(WT,1));
RTT_mean = mean(RTT,1);
RTT_SEM = std(RTT)/...
        sqrt(size(RTT,1));

figure;
hold on;
rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];
MeanSEM_ribbon(WT_mean,WT_SEM,RTT_mean,RTT_SEM,rgb_blue,rgb_orange,0.2);
hold off;
xlim([0.8 7+0.2]);
ylim([0 30]);
xticks(1:7);
xlabel('Time (day)');
ylabel('Onset lap');
%legend([h1,h2],'WT','RTT','FontSize',14);
set(gca, 'TickDir', 'out');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

%print(gcf, 'suppfig2_1.pdf','-dpdf','-vector','-bestfit');

WT = PF_mean_onset_WT;
RTT = PF_mean_onset_RTT;
[ranovatbl,anovatbl,results_posthoc] = twrm_ANOVA(WT,RTT);

