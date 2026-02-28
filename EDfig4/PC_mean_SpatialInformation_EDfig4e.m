% plot average spatial information
%%
% WT
PC_SI_WT_7_days = {};
PC_SI_mean_WT_7_days = [];
PC_SI_cells_WT = [];
for j = 1:size(Binned_Master_WT,2)
    PC_SI_WT = [];
    for i = 1:size(Binned_Master_WT,1)
        BinnedData = Binned_Master_WT{i,j};
        PlaceCell_ID = BinnedData.PFStats.PFIDs;
        PC_SI = BinnedData.SI(PlaceCell_ID)';
        PC_SI_WT = [PC_SI_WT;PC_SI];
        PC_SI_mean_WT_7_days(i,j) = mean(PC_SI);
        PC_SI_cells_WT = [PC_SI_cells_WT;PC_SI];
    end
    PC_SI_WT_7_days{j} = PC_SI_WT;
end

%%
% RTT
PC_SI_RTT_7_days = {};
PC_SI_mean_RTT_7_days = [];
PC_SI_cells_RTT = [];
for j = 1:size(Binned_Master_RTT,2)
    PC_SI_RTT = [];
    for i = 1:size(Binned_Master_RTT,1)
        BinnedData = Binned_Master_RTT{i,j};
        PlaceCell_ID = BinnedData.PFStats.PFIDs;
        PC_SI = BinnedData.SI(PlaceCell_ID)';
        PC_SI_RTT = [PC_SI_RTT;PC_SI];
        PC_SI_mean_RTT_7_days(i,j) = mean(PC_SI);
        PC_SI_cells_RTT = [PC_SI_cells_RTT;PC_SI];
    end
    PC_SI_RTT_7_days{j} = PC_SI_RTT;
end

%%
% plot mean SI
WT = PC_SI_mean_WT_7_days;
RTT = PC_SI_mean_RTT_7_days;

WT_mean = nanmean(WT,1);
WT_SEM = std(WT)/...
        sqrt(size(WT,1));
RTT_mean = nanmean(RTT,1);
RTT_SEM = std(RTT)/...
        sqrt(size(RTT,1));

figure;
hold on;
rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];
MeanSEM_ribbon(WT_mean,WT_SEM,RTT_mean,RTT_SEM,rgb_blue,rgb_orange,0.2);
xlim([0.8 7+0.2]);
ylim([0 0.08]);
xlabel('Time (day)');
ylabel('Spatial information');
%title('Mean reliability of PCs');
%legend([h1 h2],'WT','RTT','FontSize',14);
xticks(1:7);
set(gca, 'TickDir', 'out');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');
hold off;

%print(gcf, 'suppfig2_5.pdf','-dpdf','-vector','-bestfit');

WT = PC_SI_mean_WT_7_days;
RTT = PC_SI_mean_RTT_7_days;
[ranovatbl,anovatbl,results_posthoc] = twrm_ANOVA(WT,RTT);

