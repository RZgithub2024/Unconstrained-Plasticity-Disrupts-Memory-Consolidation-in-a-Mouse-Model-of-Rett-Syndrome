% compute the circular variance of plateau loc for each session

%%
% WT
pl_loc_cv_WT = [];
for j = 1:size(BTSP_cells_animals_WT,2)
    for i = 1:size(BTSP_cells_animals_WT,1)
        BinnedData = Binned_Master_WT{i,j};
        BTSP_cells = BTSP_cells_animals_WT{i,j};
        cells = find(~isnan(cell2mat(BTSP_cells(:,2))));
        BTSP_PCs = intersect(cells,BinnedData.PFStats.PFIDs);
        pl_loc_cv_PCs = [];
        for p = 1:numel(BTSP_PCs)
            ROI = BTSP_PCs(p);
            pl_loc = [];
            pl_loc = [BTSP_cells{ROI,5};BTSP_cells{ROI,9}];
            pl_loc = pl_loc(~isnan(pl_loc));
            pl_loc_cv_PCs = [pl_loc_cv_PCs;CircularVariance(pl_loc)];
        end
        pl_loc_cv_WT(i,j) = nanmean(pl_loc_cv_PCs);
    end
end

%%
% RTT
pl_loc_cv_RTT = [];
for j = 1:size(BTSP_cells_animals_RTT,2)
    for i = 1:size(BTSP_cells_animals_RTT,1)
        BinnedData = Binned_Master_RTT{i,j};
        BTSP_cells = BTSP_cells_animals_RTT{i,j};
        cells = find(~isnan(cell2mat(BTSP_cells(:,2))));
        BTSP_PCs = intersect(cells,BinnedData.PFStats.PFIDs);
        pl_loc_cv_PCs = [];
        for p = 1:numel(BTSP_PCs)
            ROI = BTSP_PCs(p);
            pl_loc = [];
            pl_loc = [BTSP_cells{ROI,5};BTSP_cells{ROI,9}];
            pl_loc = pl_loc(~isnan(pl_loc));
            pl_loc_cv_PCs = [pl_loc_cv_PCs;CircularVariance(pl_loc)];
        end
        pl_loc_cv_RTT(i,j) = nanmean(pl_loc_cv_PCs);
    end
end

%%
% plot circular variance of plateau locations
WT = pl_loc_cv_WT;
RTT = pl_loc_cv_RTT;

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
ylim([0 0.5]);
xticks(1:7);
xlabel('Time (Day)');
ylabel('Circular variance of plateau loc.');
set(gca, 'TickDir', 'out');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');
hold off;

%print(gcf, 'suppfig3_4.pdf','-dpdf','-vector','-bestfit');

[ranovatbl,anovatbl,results_posthoc] = twrm_ANOVA(WT,RTT);
anovaTbl = LMEM(WT,RTT);