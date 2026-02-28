% analyze the probability of out-of-field BTSP events (shift > 30 cm compared with PF one day before) vs. stable history
% require PFs on day n and day (n-1)
% denominator: N of PCs with given stable history and reactivated and having BTSP on the next day

%%
% WT
MouseID_WT = unique(PF_location_WT(:,1))';
ustBTSP_WT = [];
ustBTSP_shift_WT = [];
for i = 1:numel(MouseID_WT)
    stHistory_ustPC = [];
    stHistory_shift = [];
    ROIs_indices = find(PF_location_WT(:,1) == MouseID_WT(i));
    for p = 1:length(ROIs_indices)
        row_ID = ROIs_indices(p);
        ROI = PF_location_WT(row_ID,2);
        PF_loc = PF_location_WT(row_ID,3:9);
        for k = 1:size(Binned_Master_WT,2)
            if k < 7
                BTSP_cells = BTSP_cells_animals_WT{i,(k+1)};
                if ~isnan(PF_loc(k)) && ~isnan(PF_loc(k+1)) && ~isnan(BTSP_cells{p,1})
                    stHistory = StableHistory_WT(row_ID,k);
                    a = [];
                    a = [stHistory,0];
                    shift = BeltDistShift(PF_loc(k),BTSP_cells{p,5}(1));
                    if abs(shift) > 30
                        a = [stHistory,1];
                    end
                    b = [stHistory,abs(shift)];
                    stHistory_shift = [stHistory_shift;b];
                    stHistory_ustPC = [stHistory_ustPC;a];
                end
            end
        end
    end

    for j = 0:6
        m = sum((stHistory_ustPC(:, 1) == j) & (stHistory_ustPC(:, 2) == 1));
        n = sum((stHistory_ustPC(:, 1) == j));
        ustBTSP_WT(i,(j+1)) = m/n*100;

        mm = find(stHistory_shift(:, 1) == j);
        nn = stHistory_shift(mm,2);
        ustBTSP_shift_WT(i,(j+1)) = nanmean(nn);
    end
end

%%
% RTT
MouseID_RTT = unique(PF_location_RTT(:,1))';
ustBTSP_RTT = [];
ustBTSP_shift_RTT = [];
for i = 1:numel(MouseID_RTT)
    stHistory_ustPC = [];
    stHistory_shift = [];
    ROIs_indices = find(PF_location_RTT(:,1) == MouseID_RTT(i));
    for p = 1:length(ROIs_indices)
        row_ID = ROIs_indices(p);
        ROI = PF_location_RTT(row_ID,2);
        PF_loc = PF_location_RTT(row_ID,3:9);
        for k = 1:size(Binned_Master_RTT,2)
            if k < 7
                BTSP_cells = BTSP_cells_animals_RTT{i,(k+1)};
                if ~isnan(PF_loc(k)) && ~isnan(PF_loc(k+1)) && ~isnan(BTSP_cells{p,1})
                    stHistory = StableHistory_RTT(row_ID,k);
                    a = [];
                    a = [stHistory,0];
                    shift = BeltDistShift(PF_loc(k),BTSP_cells{p,5}(1));
                    if abs(shift) > 30
                        a = [stHistory,1];
                    end
                    b = [stHistory,abs(shift)];
                    stHistory_shift = [stHistory_shift;b];
                    stHistory_ustPC = [stHistory_ustPC;a];
                end
            end
        end
    end

    for j = 0:6
        m = sum((stHistory_ustPC(:, 1) == j) & (stHistory_ustPC(:, 2) == 1));
        n = sum((stHistory_ustPC(:, 1) == j));
        ustBTSP_RTT(i,(j+1)) = m/n*100;

        mm = find(stHistory_shift(:, 1) == j);
        nn = stHistory_shift(mm,2);
        ustBTSP_shift_RTT(i,(j+1)) = nanmean(nn);
    end
end

%%
% ribbon plot
WT = ustBTSP_WT(:,2:7);
RTT = ustBTSP_RTT(:,2:7);

[WT_mean,WT_SEM] = MeanSem_omitnan(WT);
[RTT_mean,RTT_SEM] = MeanSem_omitnan(RTT);

figure;
hold on;
rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];
MeanSEM_ribbon(WT_mean,WT_SEM,RTT_mean,RTT_SEM,rgb_blue,rgb_orange,0.2);
hold off;
xlim([1-0.2 6+0.2]);
ylim([0 43]);
xticks(1:6);
xticklabels({'1','2','3','4','5','6'});
xlabel('History with stable PFs (day)');
ylabel('Out-of-field BTSP rate (%)');
%title('stable PC (one day before) vs. history');
%legend([h1 h2],'WT','RTT','FontSize',14,'location','southeast');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

%print(gcf, 'fig4_3.pdf','-dpdf','-vector','-bestfit');

WT = ustBTSP_WT(:,2:7);
RTT = ustBTSP_RTT(:,2:7);
[ranovatbl,anovatbl,results_posthoc] = twrm_ANOVA(WT,RTT);
