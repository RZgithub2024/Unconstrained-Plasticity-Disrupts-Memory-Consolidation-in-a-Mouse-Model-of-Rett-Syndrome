% analyze the probability of maintaining stable PF (shift <= 30 cm compared with one day before) vs. stable history
% require PFs on day n and day (n-1)
% denominator: N of PCs with given stable history

%%
% WT
MouseID_WT = unique(PF_location_WT(:,1))';

stPC_WT = [];
for i = 1:numel(MouseID_WT)
    stHistory_stPC = [];
    ROIs_indices = find(PF_location_WT(:,1) == MouseID_WT(i));
    for p = 1:length(ROIs_indices)
        row_ID = ROIs_indices(p);
        ROI = PF_location_WT(row_ID,2);
        PF_loc = PF_location_WT(row_ID,3:9);

        for k = 1:size(Binned_Master_WT,2)
            if k < 7
                stHistory = StableHistory_WT(row_ID,k);
                a = [];
                a = [stHistory,0];
                if ~isnan(PF_loc(k)) && ~isnan(PF_loc(k+1))
                    shift = BeltDistShift(PF_loc(k),PF_loc(k+1));
                    if abs(shift) <= 30
                       a = [stHistory,1];
                    end
                end
                stHistory_stPC = [stHistory_stPC;a];
            end
        end
    end

    for j = 0:6
        m = sum((stHistory_stPC(:, 1) == j) & (stHistory_stPC(:, 2) == 1));
        n = sum((stHistory_stPC(:, 1) == j));
        stPC_WT(i,(j+1)) = m/n;
    end
end

%%
% RTT
MouseID_RTT = unique(PF_location_RTT(:,1))';

stPC_RTT = [];
for i = 1:numel(MouseID_RTT)
    stHistory_stPC = [];
    ROIs_indices = find(PF_location_RTT(:,1) == MouseID_RTT(i));
    for p = 1:length(ROIs_indices)
        row_ID = ROIs_indices(p);
        ROI = PF_location_RTT(row_ID,2);
        PF_loc = PF_location_RTT(row_ID,3:9);

        for k = 1:size(Binned_Master_RTT,2)
            if k < 7
                stHistory = StableHistory_RTT(row_ID,k);
                a = [];
                a = [stHistory,0];
                if ~isnan(PF_loc(k)) && ~isnan(PF_loc(k+1))
                    shift = BeltDistShift(PF_loc(k),PF_loc(k+1));
                    if abs(shift) <= 30
                       a = [stHistory,1];
                    end
                end
                stHistory_stPC = [stHistory_stPC;a];
            end
        end
    end

    for j = 0:6
        m = sum((stHistory_stPC(:, 1) == j) & (stHistory_stPC(:, 2) == 1));
        n = sum((stHistory_stPC(:, 1) == j));
        stPC_RTT(i,(j+1)) = m/n;
    end
end

%%
% ribbon plot
WT = stPC_WT(:,2:7);
RTT = stPC_RTT(:,2:7);

[WT_mean,WT_SEM] = MeanSem_omitnan(WT);
[RTT_mean,RTT_SEM] = MeanSem_omitnan(RTT);

figure;
hold on;
rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];
MeanSEM_ribbon(WT_mean,WT_SEM,RTT_mean,RTT_SEM,rgb_blue,rgb_orange,0.2);
hold off;
xlim([1-0.2 6+0.2]);
ylim([0 1]);
xticks(1:6);
xticklabels({'1','2','3','4','5','6'});
xlabel('History with stable PFs (day)');
ylabel('% of stable PCs');
%title('stable PC (one day before) vs. history');
%legend([h1 h2],'WT','RTT','FontSize',14,'location','southeast');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

%print(gcf, 'fig4b.pdf','-dpdf','-vector','-bestfit');

WT = stPC_WT(:,2:7);
RTT = stPC_RTT(:,2:7);
[ranovatbl,anovatbl,results_posthoc] = twrm_ANOVA(WT,RTT);
