% analyze thr correlation between % of PCs with stable BTSPs and in-prevPF
% residue amplitude (dF/F)

%% 
% residue_stHis_WT/RTT is animal-wise
residue_WT = residue_stHis_WT(:,2:7);
residue_RTT = residue_stHis_RTT(:,2:7);

BTSP_WT = stBTSP_WT(:,2:7);
BTSP_RTT = stBTSP_RTT(:,2:7);

x1 = [];
y1 = [];
p1 = [];
q1 = [];
AL_st_WT = [];
for j = 1:6
    x1 = [x1;nanmean(residue_WT(:,j))];
    y1 = [y1;mean(BTSP_WT(:,j))];
    SEMp = nanstd(residue_WT(:,j))/sqrt(sum(~isnan(residue_WT(:,j)),1));
    SEMq = std(BTSP_WT(:,j))/sqrt(size(BTSP_WT,1));
    p1 = [p1;SEMp];
    q1 = [q1;SEMq];
    % a = [residue_WT(:,j),BTSP_WT(:,(j+1))];
    % AL_st_WT = [AL_st_WT;a];
end

x2 = [];
y2 = [];
p2 = [];
q2 = [];
AL_st_RTT = [];
for j = 1:6
    x2 = [x2;nanmean(residue_RTT(:,j))];
    y2 = [y2;mean(BTSP_RTT(:,j))];
    SEMp = nanstd(residue_RTT(:,j))/sqrt(sum(~isnan(residue_RTT(:,j)),1));
    SEMq = std(BTSP_RTT(:,j))/sqrt(size(BTSP_RTT,1));
    p2 = [p2;SEMp];
    q2 = [q2;SEMq];
    % a = [residue_RTT(:,j),BTSP_RTT(:,(j+1))];
    % AL_st_RTT = [AL_st_RTT;a];
end

rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];

figure;
hold on;
errorbar(x1, y1, p1, 'horizontal','o','MarkerSize', 6, 'MarkerEdgeColor', rgb_blue, 'MarkerFaceColor',...
    rgb_blue, 'Color', rgb_blue, 'LineStyle', 'none', 'LineWidth',1.5, 'CapSize', 8);
errorbar(x1, y1, q1, 'vertical','o', 'MarkerSize', 6, 'MarkerEdgeColor', rgb_blue, 'MarkerFaceColor',...
    rgb_blue, 'Color', rgb_blue, 'LineStyle', 'none', 'LineWidth',1.5, 'CapSize', 8);

errorbar(x2, y2, p2, 'horizontal','o', 'MarkerSize', 6, 'MarkerEdgeColor', rgb_orange, 'MarkerFaceColor',...
    rgb_orange, 'Color', rgb_orange, 'LineStyle', 'none', 'LineWidth',1.5, 'CapSize', 8);
errorbar(x2, y2, q2, 'vertical','o', 'MarkerSize', 6, 'MarkerEdgeColor', rgb_orange, 'MarkerFaceColor',...
    rgb_orange, 'Color', rgb_orange, 'LineStyle', 'none', 'LineWidth',1.5, 'CapSize', 8);

linear_model_WT = fitlm(x1, y1);
disp(linear_model_WT);
linear_model_RTT = fitlm(x2, y2);
disp(linear_model_RTT);

x_fit1 = linspace(min(x1), max(x1), 100)';
x_fit2 = linspace(min(x2), max(x2), 100)';

slope_1 = linear_model_WT.Coefficients.Estimate(2)
intercept_1 = linear_model_WT.Coefficients.Estimate(1)
y_fit_line1 = slope_1 * x_fit1 + intercept_1;
p_value_slope_1 = linear_model_WT.Coefficients.pValue(2);
r_squared_1 = linear_model_WT.Rsquared.Ordinary;

slope_2 = linear_model_RTT.Coefficients.Estimate(2)
intercept_2 = linear_model_RTT.Coefficients.Estimate(1)
y_fit_line2 = slope_2 * x_fit2 + intercept_2;
p_value_slope_2 = linear_model_RTT.Coefficients.pValue(2);
r_squared_2 = linear_model_RTT.Rsquared.Ordinary;

plot(x_fit1, y_fit_line1, 'color',rgb_blue, 'LineWidth', 3);
%plot(x_fit2, y_fit_line2, 'color',rgb_orange, 'LineWidth', 3);

xlim([0.2 0.62]);
ylim([55 95]);
%xticks(1:0.5:3);
xlabel('Residue amplitude (dF/F)');
ylabel('% of PCs with in-prevPF BTSP');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

equation_1 = sprintf('y = %.4fx + %.4f', slope_1, intercept_1);
WT_model = ['WT, ',equation_1,', R-squared: ',num2str(r_squared_1),', p-value: ',num2str(p_value_slope_1)];
disp(WT_model);

equation_2 = sprintf('y = %.4fx + %.4f', slope_2, intercept_2);
RTT_model = ['RTT, ',equation_2,', R-squared: ',num2str(r_squared_2),', p-value: ',num2str(p_value_slope_2)];
disp(RTT_model);

% WT
% Get predicted y values and 95% CI
[y_fit1, y_ci1] = predict(linear_model_WT, x_fit1);

% Plot confidence bounds
% fill([x_fit1; flipud(x_fit1)], ...
%      [y_ci1(:,1); flipud(y_ci1(:,2))], ...
%      rgb_blue, 'EdgeColor', 'none', 'FaceAlpha', 0.2);
ciLower_WT = y_ci1(:,1);
ciUpper_WT = y_ci1(:,2);
% plot(x_fit1, ciLower_WT, '--', 'LineWidth', 1,'Color',rgb_blue);
% plot(x_fit1, ciUpper_WT, '--', 'LineWidth', 1,'Color',rgb_blue);

% RTT
% Get predicted y values and 95% CI
[y_fit2, y_ci2] = predict(linear_model_RTT, x_fit2);

% Plot confidence bounds
% fill([x_fit2; flipud(x_fit2)], ...
%      [y_ci2(:,1); flipud(y_ci2(:,2))], ...
%      rgb_orange, 'EdgeColor', 'none', 'FaceAlpha', 0.2);
ciLower_RTT = y_ci2(:,1);
ciUpper_RTT = y_ci2(:,2);
% plot(x_fit2, ciLower_RTT, '--', 'LineWidth', 1,'Color',rgb_orange);
% plot(x_fit2, ciUpper_RTT, '--', 'LineWidth', 1,'Color',rgb_orange);

hold off;

%print(gcf, 'fig4f.pdf','-dpdf','-vector','-bestfit');
