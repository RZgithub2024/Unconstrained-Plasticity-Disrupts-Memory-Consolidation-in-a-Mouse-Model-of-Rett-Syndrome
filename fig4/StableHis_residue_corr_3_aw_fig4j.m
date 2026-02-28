% analyze the relationship between the correlation between residuals and PF
% one day before vs. stable PF history
% animal-wise error bar

%%
% WT
MouseID_WT = unique(PF_location_WT(:,1))';
rcorr_his_WT = [];

for n = 1:numel(MouseID_WT)
    MouseID = MouseID_WT(n);
    Cells_ID = find(PF_location_WT(:,1)==MouseID);
    corr_his = [];
    for k = 2:7
        for p = 1:numel(Cells_ID)
            row_ID = Cells_ID(p);
            PF_loc = PF_location_WT(row_ID,3:9);
            if k > 1 && ~isnan(PF_loc(k-1)) && ~isnan(PF_loc(k))
                st_history = [];
                st_history = StableHistory_WT(row_ID,(k-1));
                a = [];
                if residue_corr_broken_WT(row_ID,(k+2)) > -100
                    a = [st_history,residue_corr_broken_WT(row_ID,(k+2))];
                else
                    a = [st_history,NaN];
                end
                corr_his = [corr_his;a];
            end
        end
    end

    for j = 0:6
        m = find(corr_his(:, 1) == j);
        nn = corr_his(m,2);
        rcorr_his_WT(n,(j+1)) = nanmean(nn);
    end
end

%%
% RTT
MouseID_RTT = unique(PF_location_RTT(:,1))';
rcorr_his_RTT = [];

for n = 1:numel(MouseID_RTT)
    MouseID = MouseID_RTT(n);
    Cells_ID = find(PF_location_RTT(:,1)==MouseID);
    corr_his = [];
    for k = 2:7
        for p = 1:numel(Cells_ID)
            row_ID = Cells_ID(p);
            PF_loc = PF_location_RTT(row_ID,3:9);
            if k > 1 && ~isnan(PF_loc(k-1)) && ~isnan(PF_loc(k))
                st_history = [];
                st_history = StableHistory_RTT(row_ID,(k-1));
                a = [];
                if residue_corr_broken_RTT(row_ID,(k+2)) > -100
                    a = [st_history,residue_corr_broken_RTT(row_ID,(k+2))];
                else
                    a = [st_history,NaN];
                end
                corr_his = [corr_his;a];
            end
        end
    end

    for j = 0:6
        m = find(corr_his(:, 1) == j);
        nn = corr_his(m,2);
        rcorr_his_RTT(n,(j+1)) = nanmean(nn);
    end
end

%%
% ribbon plot
WT = rcorr_his_WT(:,2:7);
RTT = rcorr_his_RTT(:,2:7);

[WT_mean,WT_SEM] = MeanSem_omitnan(WT);
[RTT_mean,RTT_SEM] = MeanSem_omitnan(RTT);

figure;
hold on;
rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];
MeanSEM_ribbon(WT_mean,WT_SEM,RTT_mean,RTT_SEM,rgb_blue,rgb_orange,0.2);
hold off;
xlim([0.8 6+0.2]);
ylim([0 0.6]);
xticks(1:6);
xlabel('Stable history (day)');
ylabel('PrevPF-residue corr. coef.');
%title('');
%legend([h1 h2],'WT','RTT','FontSize',14,'location','southeast');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

%print(gcf, 'fig4j.pdf','-dpdf','-vector','-bestfit');

WT = rcorr_his_WT(:,2:7);
RTT = rcorr_his_RTT(:,2:7);
[ranovatbl,anovatbl,results_posthoc] = twrm_ANOVA(WT,RTT);
%anovaTbl = LMEM(WT,RTT);
