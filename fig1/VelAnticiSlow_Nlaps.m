function VelAnticiSlow_Nlaps(Binned_Master_F00_WT,Binned_Master_F00_RTT,Binned_Master_WT,Binned_Master_RTT,N,saving)

%{
This function compare anticipatory slowing down in N laps on F00 and experiment days between WT or RTT mice.
Velocity is averaged in 50 bins. For each lap, Aligned to reward, 24 bins before and 25
bins after reward delivery form a 1*50 vector.
Anticipatory slowing down factor: 3-bin vel before reward / 6 bins at the beginning of the psedolap 
X: day, Y: velocity change (%)

ARGS:
- Binned_Master_F00_WT: Binned session data for WT animals on Day 0  (nAnimals × 1).
- Binned_Master_F00_RTT: Binned session data for RTT animals on Day 0  (nAnimals × 1).
- Binned_Master_WT: (cell array) Binned session data for WT animals (nAnimals × nDays).
Each cell contains a struct with dF/F, events, laps, etc.
- Binned_Master_RTT: (cell array) Binned session data for RTT animals (nAnimals × nDays).
Each cell contains a struct with dF/F, events, laps, etc.
- saving: save figure and variables (1) or not (0)

RETURNS:
- Plot animal-wise comparison of anticipatory slowing down factor
- (optional) save figures and varibales to current folder
%}

laps = 1:N;

slf_mean_WT = Get_slf(Binned_Master_F00_WT,Binned_Master_WT,laps);
slf_mean_RTT = Get_slf(Binned_Master_F00_RTT,Binned_Master_RTT,laps);

MeanSEMPlot(slf_mean_WT,slf_mean_RTT,saving);

if saving == 1
    save('fig1C.mat','slf_mean_WT','slf_mean_RTT');
end

end

function slf_mean_WT = Get_slf(Binned_Master_F00_WT,Binned_Master_WT,laps)

slf_mean_WT = [];
for j = 1:8
    slf_pseudolaps_animals = nan(size(Binned_Master_WT,1),180);
    for i = 1:size(Binned_Master_WT,1)
        if j == 1
            BinnedData = Binned_Master_F00_WT{i,1};
            LapStructure = BinnedData.LapStructure;
        elseif j ~= 1
            BinnedData = Binned_Master_WT{i,(j-1)};
            LapStructure = BinnedData.LapStructure;
        end

        slf_pseudolaps = [];
        [~,slf_pseudolaps] = Vel_align2reward(BinnedData);
        slf_mean_WT(i,j) = nanmean(slf_pseudolaps(laps),1);
    end
end

end

function MeanSEMPlot(WT,RTT,saving)

[WT_mean,WT_SEM] = MeanSem_omitnan(WT);
[RTT_mean,RTT_SEM] = MeanSem_omitnan(RTT);

figure;
hold on;
rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];
MeanSEM_ribbon(WT_mean,WT_SEM,RTT_mean,RTT_SEM,rgb_blue,rgb_orange,0.2);

xlim([0.8 8+0.2]);
ylim([0 115]);
xticks(1:8);
xnewticklabel = {'0','1','2','3','4','5','6','7'};
xticklabels(xnewticklabel);
xlabel('Time (day)');
ylabel('Velocity change (%)');
%legend([h1 h2],'WT','RTT','FontSize',14,'location','southeast');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');
%title('Anticipatory slowing down factor');
hold off;

if saving == 1
    print(gcf, 'fig1C.pdf','-dpdf','-vector','-bestfit');
end

x_vec = 0:7;
anovaTbl = LMEM(WT,RTT,x_vec);

end