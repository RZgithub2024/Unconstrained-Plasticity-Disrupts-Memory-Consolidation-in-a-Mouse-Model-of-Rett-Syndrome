function BTSP_cells_perc_ROIs(Binned_Master_WT,Binned_Master_RTT,...
    BTSP_cells_animals_WT,BTSP_cells_animals_RTT,saving)

%{
This function compare the percentage of PCs (or cells) having BTSP events between WT or RTT mice.
X: time (day). Y: percentage of cells.

ARGS:
- Binned_Master_WT: (cell array) Binned session data for WT animals (nAnimals × nDays).
Each cell contains a struct with dF/F, events, laps, etc.
- Binned_Master_RTT: (cell array) Binned session data for RTT animals (nAnimals × nDays).
Each cell contains a struct with dF/F, events, laps, etc.
- BTSP_cells_animals_WT: (cell array) Binned session data for WT animals (nAnimals × nDays).
Contains lap-wise information about BTSP.
- BTSP_cells_animals_RTT: (cell array) Binned session data for RTT animals (nAnimals × nDays).
Contains lap-wise information about BTSP.
- saving: save figure and variables (1) or not (0)

RETURNS:
- Plot animal-wise comparison of the percentage of PCs having BTSP
events.
- (optional) save figures and varibales to current folder
%}

[~,Cells_with_BTSP_ROIs_WT,~,~,~,~,~]...
    = BTSPinfo_cells(Binned_Master_WT,BTSP_cells_animals_WT);

[~,Cells_with_BTSP_ROIs_RTT,~,~,~,~,~]...
    = BTSPinfo_cells(Binned_Master_RTT,BTSP_cells_animals_RTT);

MeanSEMPlot(Cells_with_BTSP_ROIs_WT,Cells_with_BTSP_ROIs_RTT,saving);

if saving == 1
    save('fig2F.mat','Cells_with_BTSP_ROIs_WT','Cells_with_BTSP_ROIs_RTT');
end

end

function [Cells_with_BTSP_counts_WT,Cells_with_BTSP_ROIs_WT,...
    Cells_with_BTSP_PCs_WT,PCs_with_BTSP_ROIs_WT,NonPC_BTSP_ROIs_WT,...
    Cells_mean_plateau_rate_WT,PCs_plateau_rate_WT]...
    = BTSPinfo_cells(Binned_Master_WT,BTSP_cells_animals_WT)

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

end

function MeanSEMPlot(WT,RTT,saving)

[WT_mean,WT_SEM] = MeanSem_omitnan(WT);
[RTT_mean,RTT_SEM] = MeanSem_omitnan(RTT);

figure;
hold on;
rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];
MeanSEM_ribbon(WT_mean,WT_SEM,RTT_mean,RTT_SEM,rgb_blue,rgb_orange,0.2);

hold off;
xlim([0.8 7+0.2]);
ylim([0 40]);
xticks(1:7);
xlabel('Time (day)');
ylabel('% of CA1 cells');
%legend([h1,h2],'WT','RTT','FontSize',14);
set(gca, 'TickDir', 'out');
%title('Place cell fraction');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

if saving == 1
    print(gcf, 'fig2F.pdf','-dpdf','-vector','-bestfit');
end

[ranovatbl,anovatbl,results_posthoc] = twrm_ANOVA(WT,RTT);

end