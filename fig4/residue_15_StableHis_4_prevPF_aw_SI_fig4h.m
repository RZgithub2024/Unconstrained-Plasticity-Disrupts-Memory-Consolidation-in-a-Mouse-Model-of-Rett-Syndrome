% residue vs N th day at the same PF location
% residue: check at most t laps before BTSP event
% find out-of-field peaks for each lap using Get_out_field_peak(), then average them
% out-of-field: referenced to the PF location on one day before
% in-field: referenced to the PF location on one day before
% dF/F based selectivity index: 1) in-out; 2) (in-out)/(in+out)
% stable history: use data from StableHistory_WT/RTT
% animal-wise error bar

t = 5;
%%
% WT
MouseID_WT = unique(PF_location_WT(:,1))';
residue_stHis_SI_WT = [];

for p = 1:numel(MouseID_WT)
    stHis_residue = [];
    ROIs_indices = find(PF_location_WT(:,1) == MouseID_WT(p));
    for ii = 1:numel(ROIs_indices)
        i = ROIs_indices(ii);
        Cell_ID = PF_location_WT(i,2);
        PF_loc = PF_location_WT(i,3:9);
        for k = 1:7
            if k > 1 && ~isnan(PF_loc(k-1)) && ~isnan(PF_loc(k))
                BTSP_cells = BTSP_cells_animals_WT{p,k};
                BinnedData = Binned_Master_WT{p,k};
                if ~isnan(BTSP_cells{Cell_ID,1})
                    BTSP_lap = BTSP_cells{Cell_ID,3}(1);
                    if BTSP_lap > 1
                        st_history = [];
                        st_history = StableHistory_WT(i,(k-1));
                        start_lap = max([(BTSP_lap-t),1]);
                        laps_before_BTSP = start_lap:(BTSP_lap-1);
                        edges = 0:3.6:180;
                        prev_PF_bin = discretize(PF_loc(k-1),edges);
                        Events = BinnedData.Events(Cell_ID).Events;
                        dFoF = squeeze(BinnedData.Cells_dFoF_binned_mean(:,:,Cell_ID));
                        LapStructure = BinnedData.LapStructure;

                        % in
                        peak_dFoF_before_BTSP_in = [];
                        [peak_dFoF_before_BTSP_in,~] =...
                            Get_in_field_peak(prev_PF_bin,laps_before_BTSP,Events,dFoF,LapStructure,8);
                        thr = PlateauThereshold_BTSP_WT{p,k}(Cell_ID);

                        % out
                        peak_dFoF_before_BTSP_out = [];
                        [peak_dFoF_before_BTSP_out,~] =...
                            Get_out_field_peak(prev_PF_bin,laps_before_BTSP,Events,dFoF,LapStructure,8);

                        peak_dFoF_before_BTSP_in(peak_dFoF_before_BTSP_in>=thr) = NaN;
                        peak_dFoF_before_BTSP_out(peak_dFoF_before_BTSP_out>=thr) = NaN;

                        y1 = nanmean(peak_dFoF_before_BTSP_in);
                        y2 = nanmean(peak_dFoF_before_BTSP_out);
                        y3 = y1+y2;
                        if ~isnan(y3) && y3 ~= 0
                            ySI = (y1-y2)/(y1+y2);
                            a = [];
                            a = [st_history,ySI];
                            stHis_residue = [stHis_residue;a];
                        end
                    end
                end
            end
        end
    end

    for j = 0:6
        m = find(stHis_residue(:,1) == j);
        n = stHis_residue(m,2);
        residue_stHis_SI_WT(p,(j+1)) = nanmean(n);
    end

end


%%
% RTT
MouseID_RTT = unique(PF_location_RTT(:,1))';
residue_stHis_SI_RTT = [];

for p = 1:numel(MouseID_RTT)
    stHis_residue = [];
    ROIs_indices = find(PF_location_RTT(:,1) == MouseID_RTT(p));
    for ii = 1:numel(ROIs_indices)
        i = ROIs_indices(ii);
        Cell_ID = PF_location_RTT(i,2);
        PF_loc = PF_location_RTT(i,3:9);
        for k = 1:7
            if k > 1 && ~isnan(PF_loc(k-1)) && ~isnan(PF_loc(k))
                BTSP_cells = BTSP_cells_animals_RTT{p,k};
                BinnedData = Binned_Master_RTT{p,k};
                if ~isnan(BTSP_cells{Cell_ID,1})
                    BTSP_lap = BTSP_cells{Cell_ID,3}(1);
                    if BTSP_lap > 1
                        st_history = [];
                        st_history = StableHistory_RTT(i,(k-1));
                        start_lap = max([(BTSP_lap-t),1]);
                        laps_before_BTSP = start_lap:(BTSP_lap-1);
                        edges = 0:3.6:180;
                        prev_PF_bin = discretize(PF_loc(k-1),edges);
                        Events = BinnedData.Events(Cell_ID).Events;
                        dFoF = squeeze(BinnedData.Cells_dFoF_binned_mean(:,:,Cell_ID));
                        LapStructure = BinnedData.LapStructure;

                        % in
                        peak_dFoF_before_BTSP_in = [];
                        [peak_dFoF_before_BTSP_in,~] =...
                            Get_in_field_peak(prev_PF_bin,laps_before_BTSP,Events,dFoF,LapStructure,8);
                        thr = PlateauThereshold_BTSP_RTT{p,k}(Cell_ID);

                        % out
                        peak_dFoF_before_BTSP_out = [];
                        [peak_dFoF_before_BTSP_out,~] =...
                            Get_out_field_peak(prev_PF_bin,laps_before_BTSP,Events,dFoF,LapStructure,8);

                        peak_dFoF_before_BTSP_in(peak_dFoF_before_BTSP_in>=thr) = NaN;
                        peak_dFoF_before_BTSP_out(peak_dFoF_before_BTSP_out>=thr) = NaN;

                        y1 = nanmean(peak_dFoF_before_BTSP_in);
                        y2 = nanmean(peak_dFoF_before_BTSP_out);
                        y3 = y1+y2;
                        if ~isnan(y3) && y3 ~= 0
                            ySI = (y1-y2)/(y1+y2);
                            a = [];
                            a = [st_history,ySI];
                            stHis_residue = [stHis_residue;a];
                        end
                    end
                end
            end
        end
    end

    for j = 0:6
        m = find(stHis_residue(:,1) == j);
        n = stHis_residue(m,2);
        residue_stHis_SI_RTT(p,(j+1)) = nanmean(n);
    end

end

%%
WT = residue_stHis_SI_WT(:,2:7);
RTT = residue_stHis_SI_RTT(:,2:7);

[WT_mean,WT_SEM] = MeanSem_omitnan(WT);
[RTT_mean,RTT_SEM] = MeanSem_omitnan(RTT);

figure;
hold on;
rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];
MeanSEM_ribbon(WT_mean,WT_SEM,RTT_mean,RTT_SEM,rgb_blue,rgb_orange,0.2);
hold off;
xlim([0.8 6+0.2]);
ylim([-0.1 0.5]);
ylim([0 0.7])
xticks(1:6);
%yticks(-0.1:0.1:0.5);
xlabel('History with stable PFs (day)');
ylabel('Selectivity index of residue');
%legend([h1 h2],'WT','RTT','FontSize',14,'location','southeast');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

%print(gcf, 'fig4h.pdf','-dpdf','-vector','-bestfit');

WT = residue_stHis_SI_WT(:,2:7);
RTT = residue_stHis_SI_RTT(:,2:7);
[ranovatbl,anovatbl,results_posthoc] = twrm_ANOVA(WT,RTT);
