% evaluate the correlation between activity of t1 laps (or less) before the
% 1st BTSP and previous PF (average firing laps)
% evaluate corrlarity between prev PF and activity of t2 laps (or less) after the 1st BTSP
% in space domain
% check activity before the first BTSP event on Day 2—7
% require a PF on exactly one day before
% analyze stable and unstable PFs (between successive days separately)
% if a lap doesn't have any significant activity, correlation coe = NaN

% enter the number of laps before and after BTSP to check
t1 = 100;
t2 = 100;

%%
% WT
MouseID_WT = unique(PF_location_WT(:,1))';

corr_cells_WT_days = [];
corr_cells_stWT_days = [];
corr_cells_ustWT_days = [];
corr_cells_stWT_sepadays = {};
corr_cells_ustWT_sepadays = {};

for j = 2:size(BTSP_cells_animals_WT,2)
    corr_cells_stWT = [];
    corr_cells_ustWT = [];
    for i = 1:size(BTSP_cells_animals_WT,1)
        BTSP_cells = BTSP_cells_animals_WT{i,j};
        BinnedData = Binned_Master_WT{i,j};
        BinnedData_prev = Binned_Master_WT{i,(j-1)};
        Binned_noisy_prev = Binned_noisy_dFoF_WT{i,(j-1)};
        Binned_noisy = Binned_noisy_dFoF_WT{i,j};
        MouseID = MouseID_WT(i);
        corr_stPCs = [];
        corr_ustPCs = [];

        for ii = 1:size(BTSP_cells,1)
            PF_location = PF_location_WT(PF_location_WT(:,1)==MouseID &...
                PF_location_WT(:,2) == ii,:);
            
            if ~isnan(BTSP_cells{ii,1}) && ~isnan(PF_location(j+1)) && ~isnan(PF_location(j+2))
                shift = [];
                shift = BeltDist(PF_location(j+1),PF_location(j+2));
                Firing_laps_prev = find(~isnan(squeeze(BinnedData_prev.Cellstats(ii,:,7))));
                Onset = BinnedData_prev.Onset;
                Firing_laps_prev(Firing_laps_prev<Onset(ii)) = [];
                dFoF_firing = Binned_noisy_prev.Cells_dFoF_binned_mean_noisy(Firing_laps_prev,:,ii);
                dFoF_firing_mean = nanmean(dFoF_firing,1);

                BTSP_lap = BTSP_cells{ii,3}(1);
                if BTSP_lap > 1
                    laps = numel([BinnedData.LapStructure.LapNumber]);
                    start_lap = max([1,(BTSP_lap-t1)]);
                    end_lap = min(laps,(BTSP_lap+t2));
                    prior_laps = start_lap:(BTSP_lap-1);
                    post_laps = (BTSP_lap+1):end_lap;
                    
                    corr_prior = [];
                    kk = 0;
                    for k = start_lap:(BTSP_lap-1)
                        kk = kk+1;
                        dFoF_lap = Binned_noisy.Cells_dFoF_binned_mean_noisy(k,:,ii);
                        ff = [];
                        ff = BinnedData.Cells_dFoF_binned_mean(k,:,ii);
                        if any(ff(~isnan(ff)) > 0)
                            coe = corr(dFoF_firing_mean',dFoF_lap','type','Pearson','rows','complete');
                        else
                            coe = NaN;
                        end
                        corr_prior(kk) = coe;
                    end
                    n = NaN(1,(100-numel(prior_laps)));
                    corr_prior = [n,corr_prior];

                    corr_post = [];
                    kk = 0;
                    for k = (BTSP_lap+1):end_lap
                        kk = kk+1;
                        dFoF_lap = Binned_noisy.Cells_dFoF_binned_mean_noisy(k,:,ii);
                        ff = [];
                        ff = BinnedData.Cells_dFoF_binned_mean(k,:,ii);
                        if any(ff(~isnan(ff)) > 0)
                            coe = corr(dFoF_firing_mean',dFoF_lap','type','Pearson','rows','complete');
                        else
                            coe = NaN;
                        end
                        corr_post(kk) = coe;
                    end
                    m = NaN(1,(100-numel(post_laps)));
                    corr_post = [corr_post,m];
                    
                    dFoF_BTSP = Binned_noisy.Cells_dFoF_binned_mean_noisy(BTSP_lap,:,ii);
                    coe = corr(dFoF_firing_mean',dFoF_BTSP','type','Pearson','rows','complete');
                    corr_BTSP = coe;
                    
                    corr_coe = [];
                    corr_coe = [corr_prior,corr_BTSP,corr_post];

                    if shift <= 30
                        corr_cells_stWT = [corr_cells_stWT;corr_coe];
                        corr_cells_stWT_days = [corr_cells_stWT_days;corr_coe];
                    elseif shift > 30
                        corr_cells_ustWT = [corr_cells_ustWT;corr_coe];
                        corr_cells_ustWT_days = [corr_cells_ustWT_days;corr_coe];
                    end

                    corr_cells_WT_days = [corr_cells_WT_days;corr_coe];
                end
            end
        end
    end
    corr_cells_stWT_sepadays{j-1} = corr_cells_stWT;
    corr_cells_ustWT_sepadays{j-1} = corr_cells_ustWT;
end


%%
% RTT
MouseID_RTT = unique(PF_location_RTT(:,1))';

corr_cells_RTT_days = [];
corr_cells_stRTT_days = [];
corr_cells_ustRTT_days = [];
corr_cells_stRTT_sepadays = {};
corr_cells_ustRTT_sepadays = {};

for j = 2:size(BTSP_cells_animals_RTT,2)
    corr_cells_stRTT = [];
    corr_cells_ustRTT = [];
    for i = 1:size(BTSP_cells_animals_RTT,1)
        BTSP_cells = BTSP_cells_animals_RTT{i,j};
        BinnedData = Binned_Master_RTT{i,j};
        BinnedData_prev = Binned_Master_RTT{i,(j-1)};
        Binned_noisy_prev = Binned_noisy_dFoF_RTT{i,(j-1)};
        Binned_noisy = Binned_noisy_dFoF_RTT{i,j};
        MouseID = MouseID_RTT(i);
        corr_stPCs = [];
        corr_ustPCs = [];

        for ii = 1:size(BTSP_cells,1)
            PF_location = PF_location_RTT(PF_location_RTT(:,1)==MouseID &...
                PF_location_RTT(:,2) == ii,:);
            
            if ~isnan(BTSP_cells{ii,1}) && ~isnan(PF_location(j+1)) && ~isnan(PF_location(j+2))
                shift = [];
                shift = BeltDist(PF_location(j+1),PF_location(j+2));
                Firing_laps_prev = find(~isnan(squeeze(BinnedData_prev.Cellstats(ii,:,7))));
                Onset = BinnedData_prev.Onset;
                Firing_laps_prev(Firing_laps_prev<Onset(ii)) = [];
                dFoF_firing = Binned_noisy_prev.Cells_dFoF_binned_mean_noisy(Firing_laps_prev,:,ii);
                dFoF_firing_mean = nanmean(dFoF_firing,1);

                BTSP_lap = BTSP_cells{ii,3}(1);
                if BTSP_lap > 1
                    laps = numel([BinnedData.LapStructure.LapNumber]);
                    start_lap = max([1,(BTSP_lap-t1)]);
                    end_lap = min(laps,(BTSP_lap+t2));
                    prior_laps = start_lap:(BTSP_lap-1);
                    post_laps = (BTSP_lap+1):end_lap;
                    
                    corr_prior = [];
                    kk = 0;
                    for k = start_lap:(BTSP_lap-1)
                        kk = kk+1;
                        dFoF_lap = Binned_noisy.Cells_dFoF_binned_mean_noisy(k,:,ii);
                        ff = [];
                        ff = BinnedData.Cells_dFoF_binned_mean(k,:,ii);
                        if any(ff(~isnan(ff)) > 0)
                            coe = corr(dFoF_firing_mean',dFoF_lap','type','Pearson','rows','complete');
                        else
                            coe = NaN;
                        end
                        corr_prior(kk) = coe;
                    end
                    n = NaN(1,(100-numel(prior_laps)));
                    corr_prior = [n,corr_prior];

                    corr_post = [];
                    kk = 0;
                    for k = (BTSP_lap+1):end_lap
                        kk = kk+1;
                        dFoF_lap = Binned_noisy.Cells_dFoF_binned_mean_noisy(k,:,ii);
                        ff = [];
                        ff = BinnedData.Cells_dFoF_binned_mean(k,:,ii);
                        if any(ff(~isnan(ff)) > 0)
                            coe = corr(dFoF_firing_mean',dFoF_lap','type','Pearson','rows','complete');
                        else
                            coe = NaN;
                        end
                        corr_post(kk) = coe;
                    end
                    m = NaN(1,(100-numel(post_laps)));
                    corr_post = [corr_post,m];
                    
                    dFoF_BTSP = Binned_noisy.Cells_dFoF_binned_mean_noisy(BTSP_lap,:,ii);
                    coe = corr(dFoF_firing_mean',dFoF_BTSP','type','Pearson','rows','complete');
                    corr_BTSP = coe;
                    
                    corr_coe = [];
                    corr_coe = [corr_prior,corr_BTSP,corr_post];

                    if shift <= 30
                        corr_cells_stRTT = [corr_cells_stRTT;corr_coe];
                        corr_cells_stRTT_days = [corr_cells_stRTT_days;corr_coe];
                    elseif shift > 30
                        corr_cells_ustRTT = [corr_cells_ustRTT;corr_coe];
                        corr_cells_ustRTT_days = [corr_cells_ustRTT_days;corr_coe];
                    end

                    corr_cells_RTT_days = [corr_cells_RTT_days;corr_coe];
                end
            end
        end
    end
    corr_cells_stRTT_sepadays{j-1} = corr_cells_stRTT;
    corr_cells_ustRTT_sepadays{j-1} = corr_cells_ustRTT;
end


%%
% plot all cells of WT and RTT mice
% put stable and unstable PCs together

WT = corr_cells_WT_days;
RTT = corr_cells_RTT_days;

WT_mean = nanmean(WT);
RTT_mean = nanmean(RTT);
WT_SEM = [];
RTT_SEM = [];

for ii = 1:size(WT,2)
    data = [];
    data = WT(:,ii);
    WT_SEM(ii) = nanstd(data) / sqrt(sum(~isnan(data)));
end

for ii = 1:size(RTT,2)
    data = [];
    data = RTT(:,ii);
    RTT_SEM(ii) = nanstd(data) / sqrt(sum(~isnan(data)));
end

figure;
hold on;
x = 91:151;
color1 = [0, 0.4470, 0.7410];
color2 = [0.8500, 0.3250, 0.0980];

h1 = plot(x,WT_mean(x),'color',color1,'LineWidth',3);

x_fill = [x,fliplr(x)];
y_fill_upper = WT_mean(x) + WT_SEM(x);
y_fill_lower = WT_mean(x) - WT_SEM(x);
y_fill = [y_fill_upper,fliplr(y_fill_lower)];
y_fill(isnan(y_fill)) = 0;
fill(x_fill, y_fill,color1, 'FaceAlpha', 0.1,'EdgeColor', 'none');

h2 = plot(x,RTT_mean(x),'color',color2,'LineWidth',3);

x_fill = [x,fliplr(x)];
y_fill_upper = RTT_mean(x) + RTT_SEM(x);
y_fill_lower = RTT_mean(x) - RTT_SEM(x);
y_fill = [y_fill_upper,fliplr(y_fill_lower)];
y_fill(isnan(y_fill)) = 0;
fill(x_fill, y_fill,color2, 'FaceAlpha', 0.1,'EdgeColor', 'none');

xlim([90 152]);
ylim([0 0.5]);
xline(101,'--k','LineWidth',3);
xticks([91 101 111 121 131 141 151]);
xticklabels({'-10','P','10','20','30','40','50'});
xtickangle(0);
xlabel('Relative lap number');
ylabel('Correlation coefficient');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

hold off;

%print(gcf, 'fig4_6.pdf','-dpdf','-vector','-bestfit');

N_WT_events = size(corr_cells_WT_days,1)
N_RTT_events = size(corr_cells_RTT_days,1)

wt = corr_cells_WT_days(:,x);
rtt = corr_cells_RTT_days(:,x);

% two-sample t-test
H = [];
P = [];
for c = 1:size(wt,2)
    y1 = wt(:,c);
    y2 = rtt(:,c);
    y1 = y1(~isnan(y1));
    y2 = y2(~isnan(y2));
    [H(c),P(c)] = ttest2(y1,y2);
end

figure;
plot(H);

figure;
plot(P);
max(P)
%%
p_FDR = mafdr(P, 'BHFDR', true);
figure;
hold on;
plot(p_FDR);
plot(P);
hold off;