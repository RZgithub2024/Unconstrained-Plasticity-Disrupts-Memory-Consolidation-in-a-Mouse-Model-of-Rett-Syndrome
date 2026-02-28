function BTSP_PF_shift(Binned_Master_WT,BTSP_cells_animals_WT,...
    Binned_Master_RTT,BTSP_cells_animals_RTT,saving)

%{
This function visualize the distribution of shift between BTSP location and PF activity (after BTSP) 
peak in all the PCs with BTSP in WT and RTT mice. Include all 7-day data. To find the
PF peak after BTSP events, find out the firing laps after the BTSP lap. Then
average the activity of these firing laps and find its peak location.

X: shift distance (cm). Y: percentage of PCs.

ARGS:
- Binned_Master_WT: (cell array) Binned session data for WT animals (nAnimals × nDays).
Each cell contains a struct with dF/F, events, laps, etc.
- Binned_Master_RTT: (cell array) Binned session data for RTT animals (nAnimals × nDays).
Each cell contains a struct with dF/F, events, laps, etc.
- BTSP_cells_animals_WT: (cell array) Binned session data for WT animals (nAnimals × nDays).
Contains lap-wise information about BTSP.
- BTSP_cells_animals_RTT: (cell array) Binned session data for RTT animals (nAnimals × nDays).
Contains lap-wise information about BTSP.
- saving: save figure and variables (1) or not (0)

RETURNS:
- Plot the distribution of shift between BTSP location and PF
activity. Error bar is animal-wise.
- (optional) save figures and varibales to current folder
%}

PF_peak_shift_cells_WT = GetShiftDistribution(Binned_Master_WT,BTSP_cells_animals_WT);
PF_peak_shift_cells_RTT = GetShiftDistribution(Binned_Master_RTT,BTSP_cells_animals_RTT);

PlotShiftDistribution(PF_peak_shift_cells_WT,PF_peak_shift_cells_RTT,saving);

end

function PF_peak_shift_cells_WT = GetShiftDistribution(Binned_Master_WT,BTSP_cells_animals_WT)

PF_peak_shift_cells_WT = {};
shifts_WT = [];
for i = 1:size(BTSP_cells_animals_WT,1)
    PF_peak_shift_cells = [];
    for j = 1:size(BTSP_cells_animals_WT,2)
        BTSP_cells = BTSP_cells_animals_WT{i,j};
        BinnedData = Binned_Master_WT{i,j};
        for p = 1:size(BTSP_cells,1)
            if ~isnan(BTSP_cells{p,2})
                if ismember(p,BinnedData.PFStats.PFIDs)
                    BTSP_loc = [];
                    PF_loc = [];
                    BTSP_lap = BTSP_cells{p,3}(1);
                    BTSP_loc = BTSP_cells{p,5}(1);
                    Firing_laps = find(~isnan(squeeze(BinnedData.Cellstats(p,:,7))));
                    Firing_laps(Firing_laps<=BTSP_lap) = [];
                    dFoF = BinnedData.Cells_dFoF_binned_mean;
                    dFoF_firing = squeeze(dFoF(Firing_laps,:,p));
                    dFoF_firing_mean = nanmean(dFoF_firing,1);
                    [~,peak_bin] = max(dFoF_firing_mean,[],'omitnan');
                    PF_loc = 3.6*peak_bin - 1.8;
                    PF_peak_shift_cells = [PF_peak_shift_cells;BeltDistShift(BTSP_loc,PF_loc)];
                    shifts_WT = [shifts_WT;BeltDistShift(BTSP_loc,PF_loc)];
                end
            end
        end
    end
    PF_peak_shift_cells_WT{i} = PF_peak_shift_cells;
end

end

function PlotShiftDistribution(PF_peak_shift_cells_WT,PF_peak_shift_cells_RTT,saving)

edges = linspace(-90, 90, 50+1);
distribution_WT = [];
for i = 1:size(PF_peak_shift_cells_WT,2)
    [counts, ~] = histcounts(PF_peak_shift_cells_WT{i}, edges);
    binCenters = (edges(1:end-1) + edges(2:end)) / 2;
    prob = counts./sum(counts);
    distribution_WT = [distribution_WT;prob];
end
distribution_WT = distribution_WT*100;
mean_WT = mean(distribution_WT,1);
SEM_WT = std(distribution_WT,0,1)/sqrt(size(distribution_WT,1));

distribution_RTT = [];
for i = 1:size(PF_peak_shift_cells_RTT,2)
    [counts, ~] = histcounts(PF_peak_shift_cells_RTT{i}, edges);
    binCenters = (edges(1:end-1) + edges(2:end)) / 2;
    prob = counts./sum(counts);
    distribution_RTT = [distribution_RTT;prob];
end
distribution_RTT = distribution_RTT*100;
mean_RTT = mean(distribution_RTT,1);
SEM_RTT = std(distribution_RTT,0,1)/sqrt(size(distribution_RTT,1));

% calculate the median of the distribution
% WT
cum = cumsum(mean_WT);
median_bin = find(cum >= 50, 1);
median_value_WT = binCenters(median_bin)

% RTT
cum = cumsum(mean_RTT);
median_bin = find(cum >= 50, 1);
median_value_RTT = binCenters(median_bin)

rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];

figure;
hold on;
h1 = plot(binCenters, mean_WT, '-', 'LineWidth', 3,'Color',rgb_blue);
x1 = binCenters;
x_fill = [x1,fliplr(x1)];
y_fill_upper = mean_WT + SEM_WT;
y_fill_lower = mean_WT - SEM_WT;
y_fill = [y_fill_upper,fliplr(y_fill_lower)];
fill(x_fill, y_fill, rgb_blue, 'FaceAlpha', 0.1,'EdgeColor', 'none');

h2 = plot(binCenters, mean_RTT, '-', 'LineWidth', 3,'Color',rgb_orange);
x1 = binCenters;
x_fill = [x1,fliplr(x1)];
y_fill_upper = mean_RTT + SEM_RTT;
y_fill_lower = mean_RTT - SEM_RTT;
y_fill = [y_fill_upper,fliplr(y_fill_lower)];
fill(x_fill, y_fill, rgb_orange, 'FaceAlpha', 0.1,'EdgeColor', 'none');

xlim([-46 46]);
ylim([0 15]);
xticks([-45 0 45]);
xlabel('PF location shift (cm)');
ylabel('% of PCs with BTSP');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');
%xline(0,'--k','LineWidth',3);
% plot the median
xline(median_value_WT,'--k','LineWidth',3);
xline(median_value_RTT,'--k','LineWidth',3);
hold off;

if saving == 1
    print(gcf, 'fig2D.pdf','-dpdf','-vector','-bestfit');
    save('fig2D.mat','distribution_WT','distribution_RTT');
end



end