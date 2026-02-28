% analyze the probability of PCs having BTSP events vs. stable history
% require PFs on day n and day (n-1)
% denominator: N of PCs with given stable history

%%
% WT
MouseID_WT = unique(PF_location_WT(:,1))';

BTSP_WT = [];
for i = 1:numel(MouseID_WT)
    stHistory_BTSP = [];
    ROIs_indices = find(PF_location_WT(:,1) == MouseID_WT(i));
    for p = 1:length(ROIs_indices)
        row_ID = ROIs_indices(p);
        ROI = PF_location_WT(row_ID,2);
        PF_loc = PF_location_WT(row_ID,3:9);
        for k = 1:size(Binned_Master_WT,2)
            if k < 7
                if ~isnan(PF_loc(k)) && ~isnan(PF_loc(k+1))
                    BTSP_cells = BTSP_cells_animals_WT{i,(k+1)};
                    stHistory = StableHistory_WT(row_ID,k);
                    a = [];
                    a = [stHistory,0];
                    if ~isnan(BTSP_cells{p,1})
                        a = [stHistory,1];
                    end
                    stHistory_BTSP = [stHistory_BTSP;a];
                end
            end
        end
    end

    for j = 0:6
        m = sum((stHistory_BTSP(:, 1) == j) & (stHistory_BTSP(:, 2) == 1));
        n = sum((stHistory_BTSP(:, 1) == j));
        BTSP_WT(i,(j+1)) = m/n*100;
    end
end

%%
% RTT
MouseID_RTT = unique(PF_location_RTT(:,1))';

BTSP_RTT = [];
for i = 1:numel(MouseID_RTT)
    stHistory_BTSP = [];
    ROIs_indices = find(PF_location_RTT(:,1) == MouseID_RTT(i));
    for p = 1:length(ROIs_indices)
        row_ID = ROIs_indices(p);
        ROI = PF_location_RTT(row_ID,2);
        PF_loc = PF_location_RTT(row_ID,3:9);
        for k = 1:size(Binned_Master_RTT,2)
            if k < 7
                if ~isnan(PF_loc(k)) && ~isnan(PF_loc(k+1))
                    BTSP_cells = BTSP_cells_animals_RTT{i,(k+1)};
                    stHistory = StableHistory_RTT(row_ID,k);
                    a = [];
                    a = [stHistory,0];
                    if ~isnan(BTSP_cells{p,1})
                        a = [stHistory,1];
                    end
                    stHistory_BTSP = [stHistory_BTSP;a];
                end
            end
        end
    end

    for j = 0:6
        m = sum((stHistory_BTSP(:, 1) == j) & (stHistory_BTSP(:, 2) == 1));
        n = sum((stHistory_BTSP(:, 1) == j));
        BTSP_RTT(i,(j+1)) = m/n*100;
    end
end

%%
% bar graph

WT = BTSP_WT(:,2:7);
RTT = BTSP_RTT(:,2:7);

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
xlabel('PC stability (day)');
ylim([0 100]);
ylabel('BTSP detected next day');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
box off;

%print(gcf, 'fig1K_bar.pdf','-dpdf','-vector','-bestfit');

WT = BTSP_WT(:,2:7);
RTT = BTSP_RTT(:,2:7);
[ranovatbl,anovatbl,results_posthoc] = twrm_ANOVA(WT,RTT);