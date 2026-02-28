%%
% plot one PC, specifiy the laps to plot
% enter which PC to plot
i = 3; % animal index
j = 5; % day index
p = 56; % ROI ID

% enter the start and end laps
sl = 1; % start
el = 50; % end

% heatmap for specified laps
% make sure the mouse genotype, WT or RTT
BinnedData = Binned_Master_RTT{i,j};

ROI = p;
dFoF_cell = squeeze(BinnedData.Cells_dFoF_binned_mean(:,:,ROI));
dFoF = dFoF_cell(sl:el,:);

figure;
imagesc(dFoF);
colormap(jet);
clim([0 2]);
xlim([0.5-0.15 50.5]);
ylim([1-0.5 size(dFoF,1)+0.5+0.15]);
xticks([0.5 25.5 50.5]);
xticklabels({'0','90','180'});
xlabel('Position (cm)');
newyticks = [1,size(dFoF,1)];
newyticklabels = {num2str(sl),num2str(el)};
yticks(newyticks);
yticklabels(newyticklabels);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',1);
set(gca, 'Box', 'off');
ylabel('Laps');

% colorbar;
% clb = colorbar();
% clb.Ticks = [0 2];
% clb.TickLabels = {'0','2'};
% clb.FontSize = 30;
% clb.Label.FontSize = 30;
% clb.LineWidth = 0.5;
% ylabel(clb, "∆F/F");

set(gca,'FontSize', 30);
set(gcf,'Position',[500 500 375 500]);
% title('');
% ax1 = gca;
% ax1.XAxis.Visible = 'off';

%print(gcf, 'eg_cell.pdf','-dpdf','-vector','-bestfit');
