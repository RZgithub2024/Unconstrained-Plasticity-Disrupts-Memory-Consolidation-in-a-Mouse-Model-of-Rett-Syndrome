% get percentage of PCs with BTSP

%%
% WT
Cells_with_BTSP_counts_WT = [];
Cells_with_BTSP_ROIs_WT = [];
Cells_with_BTSP_PCs_WT = [];
PCs_with_BTSP_ROIs_WT = [];
NonPC_BTSP_ROIs_WT = [];
Cells_mean_plateau_rate_WT = [];
PCs_plateau_rate_WT = [];

for j = 1:size(BTSP_cells_animals_WT,2)
    for i = 1:size(BTSP_cells_animals_WT,1)
        BinnedData = Binned_Master_WT{i,j};
        BTSP_cells = BTSP_cells_animals_WT{i,j};
        Cells_with_BTSP_counts_WT(i,j) = numel(find(~isnan(cell2mat(BTSP_cells(:,2)))));
        
        cells = [];
        BTSP_PCs = [];
        BTSP_NonPCs = [];
        cells = find(~isnan(cell2mat(BTSP_cells(:,2))));
        BTSP_PCs = intersect(cells,BinnedData.PFStats.PFIDs);
        BTSP_NonPCs = setdiff(cells,BinnedData.PFStats.PFIDs);

        Cells_with_BTSP_ROIs_WT(i,j) =...
            Cells_with_BTSP_counts_WT(i,j)/size(BinnedData.Cells_dFoF_denoised,1)*100;
        Cells_with_BTSP_PCs_WT(i,j) = numel(BTSP_PCs)/BinnedData.PFStats.No_PFs*100;
        PCs_with_BTSP_ROIs_WT(i,j) = numel(BTSP_PCs)/size(BinnedData.Cells_dFoF_denoised,1)*100;

        NonPC_BTSP_ROIs_WT(i,j) = ...
            numel(BTSP_NonPCs)/size(BinnedData.Cells_dFoF_denoised,1)*100;

        Cells_mean_plateau_rate_WT(i,j) = nanmean(cell2mat(BTSP_cells(:,11)));
        PCs_plateau_rate_WT(i,j) = nanmean(cell2mat(BTSP_cells(BTSP_PCs,11)));
    end
end

%%
% RTT
Cells_with_BTSP_counts_RTT = [];
Cells_with_BTSP_ROIs_RTT = [];
Cells_with_BTSP_PCs_RTT = [];
PCs_with_BTSP_ROIs_RTT = [];
NonPC_BTSP_ROIs_RTT = [];
Cells_mean_plateau_rate_RTT = [];
PCs_plateau_rate_RTT = [];

for j = 1:size(BTSP_cells_animals_RTT,2)
    for i = 1:size(BTSP_cells_animals_RTT,1)
        BinnedData = Binned_Master_RTT{i,j};
        BTSP_cells = BTSP_cells_animals_RTT{i,j};
        Cells_with_BTSP_counts_RTT(i,j) = numel(find(~isnan(cell2mat(BTSP_cells(:,2)))));
        
        cells = [];
        BTSP_PCs = [];
        BTSP_NonPCs = [];
        cells = find(~isnan(cell2mat(BTSP_cells(:,2))));
        BTSP_PCs = intersect(cells,BinnedData.PFStats.PFIDs);
        BTSP_NonPCs = setdiff(cells,BinnedData.PFStats.PFIDs);

        Cells_with_BTSP_ROIs_RTT(i,j) =...
            Cells_with_BTSP_counts_RTT(i,j)/size(BinnedData.Cells_dFoF_denoised,1)*100;
        Cells_with_BTSP_PCs_RTT(i,j) = numel(BTSP_PCs)/BinnedData.PFStats.No_PFs*100;
        PCs_with_BTSP_ROIs_RTT(i,j) = numel(BTSP_PCs)/size(BinnedData.Cells_dFoF_denoised,1)*100;

        NonPC_BTSP_ROIs_RTT(i,j) = ...
            numel(BTSP_NonPCs)/size(BinnedData.Cells_dFoF_denoised,1)*100;

        Cells_mean_plateau_rate_RTT(i,j) = nanmean(cell2mat(BTSP_cells(:,11)));
        PCs_plateau_rate_RTT(i,j) = nanmean(cell2mat(BTSP_cells(BTSP_PCs,11)));
    end
end


%% 
% plot % of cells with BTSP out of PCs
WT = Cells_with_BTSP_PCs_WT;
RTT = Cells_with_BTSP_PCs_RTT;

[WT_mean,WT_SEM] = MeanSem_omitnan(WT);
[RTT_mean,RTT_SEM] = MeanSem_omitnan(RTT);

figure;
hold on;
rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];
MeanSEM_ribbon(WT_mean,WT_SEM,RTT_mean,RTT_SEM,rgb_blue,rgb_orange,0.2);
hold off;
%legend([h1 h2],'WT','RTT','FontSize',14,'location','southeast');
%title('Percentage of PCs with BTSP out of PCs');
xlim([0.8 7+0.2]);
ylim([0 100]);
xticks(1:7);
xlabel('Time (day)');
ylabel('% of PCs with BTSP');
set(gca, 'TickDir', 'out');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');
hold off;

%print(gcf, 'suppfig4A.pdf','-dpdf','-vector','-bestfit');

WT = Cells_with_BTSP_PCs_WT;
RTT = Cells_with_BTSP_PCs_RTT;
[ranovatbl,anovatbl,results_posthoc] = twrm_ANOVA(WT,RTT);
