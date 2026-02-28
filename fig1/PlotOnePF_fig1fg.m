%% browse all the PCs
% double-check the mouse genotype, WT or RTT
i = 4; % animal index
j = 2; % day index
BinnedData = Binned_Master_WT{i,j};
implay(BinnedData.Cells_dFoF_binned_mean(:,:,BinnedData.PFStats.PFIDs));

%% plot one PC
% enter which PC to plot
n = 25; % PC index
ROI = BinnedData.PFStats.PFIDs(n)
%%
% heatmap for a given cell, plot Lap 1—100
dFoF_cell = squeeze(BinnedData.Cells_dFoF_binned_mean(:,:,ROI));
size(dFoF_cell,1)
if size(dFoF_cell,1) > 100
   dFoF = dFoF_cell(1:100,:);
else
   dFoF = dFoF_cell;
end

figure;
imagesc(dFoF);
%heatmap(dFoF);
colormap(jet);
clim([0 2]);
xlim([0.5-0.15 50.5]);
ylim([1-0.5 size(dFoF,1)+0.5+0.15]);
xticks([0.5 25.5 50.5]);
xticklabels({'0','90','180'});
%newyticks = [1,size(BinnedData.Cells_dFoF_binned_mean,1)];
%newyticklabels = {'1',string(size(BinnedData.Cells_dFoF_binned_mean,1))};
newyticks = [1 100];
newyticklabels = {'1','100'};
yticks(newyticks);
yticklabels(newyticklabels);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');
xlabel('Position (cm)');
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
set(gcf,'Position',[500 500 700 1000]);
%title('RZ045, RTT, Day 6, ROI 36');

%print(gcf, 'fig1_PC_WT.pdf','-dpdf','-vector','-bestfit');

