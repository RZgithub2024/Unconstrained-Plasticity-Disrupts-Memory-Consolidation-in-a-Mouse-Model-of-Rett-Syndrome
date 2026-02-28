function Licking_heatmap_align2reward(i,j,Binned_Master,saving)

%{
This function plot a heatmap for the count of licks in a given session.
Licks are discretized into 50 bins. For each lap, Aligned to reward, 24 bins before and 25
bins after reward delivery form a 1*50 vector. X: location in bins, Y:
laps, color: lick count

ARGS:
- i: animal index
- j: day
- Binned_Master: (cell array) Binned session data for WT or RTT animals (nAnimals × nDays). 
Each cell contains a struct with dF/F, events, laps, etc.
- saving: save figure and variables (1) or not (0)

RETURNS:
- Plot a heatmap
- (optional) save figure and varibales to current folder
%}


BinnedData = Binned_Master{i,j};
[lc_pseudolaps] = Lickcount_align2reward(BinnedData);
figure;
hold on;
imagesc(lc_pseudolaps);
set(gca, 'YDir', 'reverse');
colormap('jet');
clim([0 3]);
xlabel('Position (cm)');
ylabel('Laps');
ylim([1-0.5 size(lc_pseudolaps,1)+0.5+0.15]);
xlim([0-0.1 50]);
xticks([0 25 50]);
xticklabels({'-90','0','90'});
yticks([1,size(lc_pseudolaps,1)]);
yticklabels({'1',num2str(size(lc_pseudolaps,1))});

colorbar;
clb = colorbar();
clb.Ticks = [0 3];
clb.TickLabels = {'0','3'};
clb.FontSize = 30;
clb.Label.FontSize = 30;
clb.LineWidth = 1;
ylabel(clb, "Lick count");

set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');
set(gcf,'Position',[500 500 750 1000]);
set(gca,'FontSize', 30);
xline(25,'LineWidth',3,'Color',[1 1 1],'LineStyle','--');
hold off;

if saving == 1
    print(gcf, 'fig1i_WT.pdf','-dpdf','-vector','-bestfit');
    save('fig1i_WT.mat','lc_pseudolaps');
end

end