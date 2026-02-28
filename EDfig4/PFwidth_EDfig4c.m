% plot average PF width in cm

%%
% WT
PF_width_mean_WT_7_days = [];
PF_width_cells_WT = [];
for j = 1:size(Binned_Master_WT,2)
    for i = 1:size(Binned_Master_WT,1)
        BinnedData = Binned_Master_WT{i,j};
        PFIDs = BinnedData.PFStats.PFIDs;
        PFW = [];
        for p = 1:numel(PFIDs)
            ROI = PFIDs(p);
            PFwidth_mean = GetPFWidth(BinnedData,ROI);
            PFW = [PFW;PFwidth_mean];
        end
        PF_width_mean_WT_7_days(i,j) = nanmean(PFW,1);
        PF_width_cells_WT = [PF_width_cells_WT;PFW];
    end
end

%%
% RTT
PF_width_mean_RTT_7_days = [];
PF_width_cells_RTT = [];
for j = 1:size(Binned_Master_RTT,2)
    for i = 1:size(Binned_Master_RTT,1)
        BinnedData = Binned_Master_RTT{i,j};
        PFIDs = BinnedData.PFStats.PFIDs;
        PFW = [];
        for p = 1:numel(PFIDs)
            ROI = PFIDs(p);
            PFwidth_mean = GetPFWidth(BinnedData,ROI);
            PFW = [PFW;PFwidth_mean];
        end
        PF_width_mean_RTT_7_days(i,j) = nanmean(PFW,1);
        PF_width_cells_RTT = [PF_width_cells_RTT;PFW];
    end
end

%%
% plot mean PF width
WT = PF_width_mean_WT_7_days;
RTT = PF_width_mean_RTT_7_days;

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
xlim([0.8 7+0.2]);
ylim([0 30]);
xlabel('Time (day)');
ylabel('PF width (cm)');
%title('');
%legend([h1 h2],'WT','RTT','FontSize',14);
xticks(1:7);
set(gca, 'TickDir', 'out');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');
hold off;

%print(gcf, 'suppfig2_3.pdf','-dpdf','-vector','-bestfit');

WT = PF_width_mean_WT_7_days;
RTT = PF_width_mean_RTT_7_days;
[ranovatbl,anovatbl,results_posthoc] = twrm_ANOVA(WT,RTT);

