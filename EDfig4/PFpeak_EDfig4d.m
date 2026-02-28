% plot average PF amplitude in dF/F
%%
% WT
PF_peak_WT_7_days = {};
PF_peak_mean_WT_7_days = [];
PF_peak_cells_WT = [];
for j = 1:size(Binned_Master_WT,2)
    PF_peak_WT = [];
    for i = 1:size(Binned_Master_WT,1)
        BinnedData = Binned_Master_WT{i,j};
        PlaceCell_ID = BinnedData.PFStats.PFIDs;
        PF_peak = BinnedData.PF_averaged_peak(PlaceCell_ID);
        PF_peak_WT = [PF_peak_WT;PF_peak];
        PF_peak_mean_WT_7_days(i,j) = mean(PF_peak);
        PF_peak_cells_WT = [PF_peak_cells_WT;PF_peak];
    end
    PF_peak_WT_7_days{j} = PF_peak_WT;
end

%%
% RTT
PF_peak_RTT_7_days = {};
PF_peak_mean_RTT_7_days = [];
PF_peak_cells_RTT = [];
for j = 1:size(Binned_Master_RTT,2)
    PF_peak_RTT = [];
    for i = 1:size(Binned_Master_RTT,1)
        BinnedData = Binned_Master_RTT{i,j};
        PlaceCell_ID = BinnedData.PFStats.PFIDs;
        PF_peak = BinnedData.PF_averaged_peak(PlaceCell_ID);
        PF_peak_RTT = [PF_peak_RTT;PF_peak];
        PF_peak_mean_RTT_7_days(i,j) = mean(PF_peak);
        PF_peak_cells_RTT = [PF_peak_cells_RTT;PF_peak];
    end
    PF_peak_RTT_7_days{j} = PF_peak_RTT;
end

%%
% plot PF peak dFoF (average firing laps)
WT = PF_peak_mean_WT_7_days;
RTT = PF_peak_mean_RTT_7_days;

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
xlim([0.8 7]);
ylim([0 1.3]);
xlabel('Time (day)');
ylabel('PF peak amplitude (ΔF/F)');
% title('Mean PF amplitude');
% legend([h1 h2],'WT','RTT','FontSize',14);
xticks(1:7);
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');
hold off;

%print(gcf, 'suppfig2_4.pdf','-dpdf','-vector','-bestfit');

WT = PF_peak_mean_WT_7_days;
RTT = PF_peak_mean_RTT_7_days;
[ranovatbl,anovatbl,results_posthoc] = twrm_ANOVA(WT,RTT);
