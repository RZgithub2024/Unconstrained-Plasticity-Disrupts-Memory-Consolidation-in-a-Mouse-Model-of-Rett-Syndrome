% plot activity of a cell for 7 days
% double check the genotype
% enter the cell information
i = 3; % animal index
cell = 78; % ROI ID

cell_dFoF_7days = [];
laps_7days = [];
for j = 1:7
    BinnedData = Binned_Master_WT{i,j};
    %dFoF_cells = BinnedData.Cells_dFoF_binned_mean;
    dFoF_cells = Gaussian(BinnedData.Cells_dFoF_binned_mean);
    cell_dFoF = squeeze(dFoF_cells(:,:,cell));
    cell_dFoF_7days = [cell_dFoF_7days;cell_dFoF];
    laps_7days = [laps_7days,numel([BinnedData.LapStructure.LapNumber])];
end
ytick_days = cumsum(laps_7days);
figure;
imagesc(cell_dFoF_7days);
colormap(jet);
clim([0 3]);
xlim([0.5 50.5]);
ylim([1-0.5 size(cell_dFoF_7days,1)+0.5+0.15]);
xticks([0.5 25.5 50.5]);
xticklabels({'0','90','180'});
newyticks = [1,ytick_days];
newyticklabels = {'1','2','3','4','5','6','7'};
yticks(newyticks);
yticklabels(newyticklabels);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',1);
set(gca, 'Box', 'off');
xlabel('Position (cm)');
ylabel('Time (day)');

% colorbar;
% clb = colorbar();
% clb.Ticks = [0 2];
% clb.TickLabels = {'0','2'};
% clb.FontSize = 30;
% clb.Label.FontSize = 30;
% clb.LineWidth = 0.5;
% ylabel(clb, "∆F/F");

daspect([1 5 1]);
set(gcf,'Position',[500 500 750 1000]);
set(gca,'FontSize', 30);
%title('');

%print(gcf, 'fig3B_eg.pdf','-dpdf','-vector','-bestfit');