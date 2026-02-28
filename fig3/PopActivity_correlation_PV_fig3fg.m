% population vector correlation across 7 days
% average of 50 spatial bins
% use noisy dFoF as input
%%
% WT
allCorrMatrices_WT = [];
for i = 1:size(Binned_Master_WT,1)
    Mean_dFoF_cells_bins = {};
    for j = 1:7
        BinnedData = Binned_Master_WT{i,j};
        noisy = Binned_noisy_dFoF_WT{i,j};
        Cells_dFoF_binned_mean_noisy = noisy.Cells_dFoF_binned_mean_noisy;
        Mean_dFoF_cells = [];
        for p = 1:size(Cells_dFoF_binned_mean_noisy,3)
            dFoF_cell = squeeze(Cells_dFoF_binned_mean_noisy(:,:,p));
            Mean_dFoF_cells = [Mean_dFoF_cells;nanmean(dFoF_cell,1)];
        end

        for k = 1:50
            Mean_dFoF_cells_bins{k}(:,j) = Mean_dFoF_cells(:,k);
        end
    end

    PVcorr = [];
    for k = 1:50
        x = Mean_dFoF_cells_bins{k};
        PVcorr(:,:,k) = corr(x,'Type','Pearson');
    end
    corrMatrix = mean(PVcorr,3);
    allCorrMatrices_WT(:,:,i) = corrMatrix;

    % % Plot the correlation matrix using imagesc
    % figure;
    % imagesc(corrMatrix);
    % colorbar;
    % clim([0.4 1]);
    % xlabel('Time (day)');
    % ylabel('Time (day)');
    % title(['WT, ',BinnedData.AnimalID,', Population vector correlation']);
    % [nRows, nCols] = size(corrMatrix);
    % for ii = 1:nRows
    %     for jj = 1:nCols
    %         text(jj, ii, num2str(corrMatrix(ii, jj), '%.2f'), ...
    %         'HorizontalAlignment', 'center', ...
    %         'VerticalAlignment', 'middle', ...
    %         'Color', 'white');
    %     end
    % end
end

averageCorrMatrix_WT = mean(allCorrMatrices_WT,3);
%%
% plot the averaged correlation matrix, WT
figure;
imagesc(averageCorrMatrix_WT);
% [nRows, nCols] = size(averageCorrMatrix_WT);
% for ii = 1:nRows
%     for jj = 1:nCols
%         text(jj, ii, num2str(averageCorrMatrix_WT(ii, jj), '%.2f'), ...
%             'HorizontalAlignment', 'center', ...
%             'VerticalAlignment', 'middle', ...
%             'Color', 'white','FontSize',18);
%     end
% end

colormap("parula");
%colormap(custom_colormap);
clim([0.4 1]);
xticks(1:7);
yticks(1:7);
xlabel('Time (day)');
ylabel('Time (day)');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

%print(gcf, 'fig3F_WT.pdf','-dpdf','-vector','-bestfit');

% title('WT');
% colorbar;
% ylabel(cb, 'Correlation Coefficient');
% cb.FontSize = 30; cb.Label.FontSize = 30; cb.LineWidth = 0.5;

%%
% RTT
allCorrMatrices_RTT = [];
for i = 1:size(Binned_Master_RTT,1)
    Mean_dFoF_cells_bins = {};
    for j = 1:7
        BinnedData = Binned_Master_RTT{i,j};
        noisy = Binned_noisy_dFoF_RTT{i,j};
        Cells_dFoF_binned_mean_noisy = noisy.Cells_dFoF_binned_mean_noisy;
        Mean_dFoF_cells = [];
        for p = 1:size(Cells_dFoF_binned_mean_noisy,3)
            dFoF_cell = squeeze(Cells_dFoF_binned_mean_noisy(:,:,p));
            Mean_dFoF_cells = [Mean_dFoF_cells;nanmean(dFoF_cell,1)];
        end

        for k = 1:50
            Mean_dFoF_cells_bins{k}(:,j) = Mean_dFoF_cells(:,k);
        end
    end

    PVcorr = [];
    for k = 1:50
        x = Mean_dFoF_cells_bins{k};
        PVcorr(:,:,k) = corr(x,'Type','Pearson');
    end
    corrMatrix = mean(PVcorr,3);
    allCorrMatrices_RTT(:,:,i) = corrMatrix;

    % % Plot the correlation matrix using imagesc
    % figure;
    % imagesc(corrMatrix);
    % colorbar;
    % clim([0.4 1]);
    % xlabel('Time (day)');
    % ylabel('Time (day)');
    % title(['RTT, ',BinnedData.AnimalID,', Population vector correlation']);
    % [nRows, nCols] = size(corrMatrix);
    % for ii = 1:nRows
    %     for jj = 1:nCols
    %         text(jj, ii, num2str(corrMatrix(ii, jj), '%.2f'), ...
    %         'HorizontalAlignment', 'center', ...
    %         'VerticalAlignment', 'middle', ...
    %         'Color', 'white');
    %     end
    % end
end

averageCorrMatrix_RTT = mean(allCorrMatrices_RTT,3);

%%
% plot the averaged correlation matrix, RTT
figure;
imagesc(averageCorrMatrix_RTT);
% [nRows, nCols] = size(averageCorrMatrix_RTT);
% for ii = 1:nRows
%     for jj = 1:nCols
%         text(jj, ii, num2str(averageCorrMatrix_RTT(ii, jj), '%.2f'), ...
%             'HorizontalAlignment', 'center', ...
%             'VerticalAlignment', 'middle', ...
%             'Color', 'white','FontSize',18);
%     end
% end

colormap("parula");
%colormap(custom_colormap);
clim([0.4 1]);
xticks(1:7);
yticks(1:7);
xlabel('Time (day)');
ylabel('Time (day)');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');
% title('RTT');
% colorbar;
% clb = colorbar;
% ylabel(clb, 'Correlation coefficient');
% clb.FontSize = 30;
% clb.Label.FontSize = 24;
% clb.LineWidth = 0.5;
% clb.Ticks = [0.4 1];
% clb.TickLabels = {'0.4','1'};

%print(gcf, 'fig3F_RTT.pdf','-dpdf','-vector','-bestfit');

%%
% plot correlation coefficient change of -6,-5,...,0,1,2,...,6 days
delta_days = -6:1:6;

WT_delta_coe = de_error_delta_day(delta_days,allCorrMatrices_WT);
RTT_delta_coe = de_error_delta_day(delta_days,allCorrMatrices_RTT);

WT = WT_delta_coe(:,7:11);
RTT = RTT_delta_coe(:,7:11);

[WT_mean,WT_SEM] = MeanSem_omitnan(WT);
[RTT_mean,RTT_SEM] = MeanSem_omitnan(RTT);

figure;
hold on;
rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];
MeanSEM_ribbon(WT_mean,WT_SEM,RTT_mean,RTT_SEM,rgb_blue,rgb_orange,0.2);
hold off;
%xlim([0.8 13+0.2]);
xlim([0.8 size(WT,2)+0.2]);
ylim([0 1]);
% xticks(1:13);
% xnewticklabel = {'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'};
xticks(1:size(WT,2));
xnewticklabel = {'0','+1','+2','+3','+4'};
xticklabels(xnewticklabel);
xlabel('Time (day)');
ylabel('Correlation coefficient');
%legend([h1,h2],'WT','RTT','FontSize',14);
%title('consecutive days');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

%print(gcf, 'fig3G.pdf','-dpdf','-vector','-bestfit');

WT = WT_delta_coe(:,8:11);
RTT = RTT_delta_coe(:,8:11);
[ranovatbl,anovatbl,results_posthoc] = twrm_ANOVA(WT,RTT);