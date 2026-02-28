% PF distribution, percentage of PCs in bins (0:18:180)

%%
% WT
PFdistribution_frac_WT_7days = {};
PF_fraction_72_90_WT = [];
PF_fraction_90_108_WT = [];
PF_fraction_72_108_WT = [];
for j = 1:7
    PFdistribution_frac_WT = [];
    for i = 1:size(Binned_Master_WT,1)
        BinnedData = Binned_Master_WT{i,j};
        PFIDs = BinnedData.PFStats.PFIDs;
        PF_location = BinnedData.PForNot(PFIDs,8);
        edges = linspace(0,180,11);
        [PFdistribution_counts,~] = histcounts(PF_location,edges);
        [PFdistribution_frac,~] = histcounts(PF_location,edges,'Normalization','probability');
        PFdistribution_frac = PFdistribution_frac*100;
        PFdistribution_frac_WT = [PFdistribution_frac_WT;PFdistribution_frac];
        PF_fraction_72_90_WT(i,j) = PFdistribution_frac(5);
        PF_fraction_90_108_WT(i,j) = PFdistribution_frac(6);
        PF_fraction_72_108_WT(i,j) = PFdistribution_frac(5)+PFdistribution_frac(6);
    end
    PFdistribution_frac_WT_7days{j} = PFdistribution_frac_WT;
end

%%
% RTT
PFdistribution_frac_RTT_7days = {};
PF_fraction_72_90_RTT = [];
PF_fraction_90_108_RTT = [];
PF_fraction_72_108_RTT = [];
for j = 1:7
    PFdistribution_frac_RTT = [];
    for i = 1:size(Binned_Master_RTT,1)
        BinnedData = Binned_Master_RTT{i,j};
        PFIDs = BinnedData.PFStats.PFIDs;
        PF_location = BinnedData.PForNot(PFIDs,8);
        edges = linspace(0,180,11);
        [PFdistribution_counts,~] = histcounts(PF_location,edges);
        [PFdistribution_frac,~] = histcounts(PF_location,edges,'Normalization','probability');
        PFdistribution_frac = PFdistribution_frac*100;
        PFdistribution_frac_RTT = [PFdistribution_frac_RTT;PFdistribution_frac];
        PF_fraction_72_90_RTT(i,j) = PFdistribution_frac(5);
        PF_fraction_90_108_RTT(i,j) = PFdistribution_frac(6);
        PF_fraction_72_108_RTT(i,j) = PFdistribution_frac(5)+PFdistribution_frac(6);
    end
    PFdistribution_frac_RTT_7days{j} = PFdistribution_frac_RTT;
end

%%
% plot
for j = 7 % day index
    WT = PFdistribution_frac_WT_7days{j};
    RTT = PFdistribution_frac_RTT_7days{j};
    [WT_mean,WT_SEM] = MeanSem_omitnan(WT);
    [RTT_mean,RTT_SEM] = MeanSem_omitnan(RTT);
    
    figure;
    hold on;
    rgb_blue = [0, 0.4470, 0.7410];
    rgb_orange = [0.8500, 0.3250, 0.0980];
    MeanSEM_ribbon(WT_mean,WT_SEM,RTT_mean,RTT_SEM,rgb_blue,rgb_orange,0.2);
    hold off;
    xlim([0.8 10+0.2]);
    ylim([0 21]);
    newxticks = 1:1:10;
    newxticklabels = {'0—18','18—36','36—54','54—72','72—90','90—108','108—126','126—144','144—162','162—180'};
    xticks(newxticks);
    xticklabels(newxticklabels);
    xlabel('PF location (cm)');
    ylabel('% of PCs');
    set(gca, 'FontSize', 30);
    ax = gca;
    ax.XAxis.FontSize = 20;  
    set(gcf,'Position',[500 500 500 500]);
    set(gca, 'TickDir', 'out');
    set(gca, 'LineWidth',2);
    set(gca, 'Box', 'off');

    % mark the reward zone
    x_start = 5-0.3; % Starting x-coordinate
    x_end = 6+0.3;   % Ending x-coordinate
    y_start = 0;  % Starting y-coordinate
    ax_ylim = ylim(gca);
    y_end = ax_ylim(2);   % Ending y-coordinate
    width = x_end - x_start;
    height = y_end - y_start;
    color4 = [167,169,172]/255*0.7;
    rectangle('Position', [x_start, y_start, width, height], ...
        'FaceColor', color4, ...
        'EdgeColor', 'none', ...
        'FaceAlpha', 0.3);
    %print(gcf, 'fig1I.pdf','-dpdf','-vector','-bestfit');
    
    % Chi-squared test
    wt = WT_mean/100;
    rtt = RTT_mean/100;
    N_PC_WT = sum(~isnan(PF_location_WT(:,(j+2))));
    N_PC_RTT = sum(~isnan(PF_location_RTT(:,(j+2))));
    edges = linspace(0,180,11);
    [h,pval,chi2stat,df] = Csgof_ovr(wt,N_PC_WT,edges)
    [h,pval,chi2stat,df] = Csgof_ovr(rtt,N_PC_RTT,edges)
end
