function [AnticiLickingProb_8days_WT,AnticiLickingProb_8days_RTT] = AnticiLickProb(Binned_Master_F00_WT,Binned_Master_F00_RTT,Binned_Master_WT,Binned_Master_RTT,saving)

%{
This function compare anticipatory licking probability on F00 and experiment days between WT or RTT mice.
For each lap, find the reward deliverty location (d). If there is at least one
lick in the region (d-10.8 cm)—d, the lap is true. Otherwaise, it is false.
Anticipatory licking probability: No. of true laps / total No. of laps 
X: day, Y: anticipatory licking probability

ARGS:
- Binned_Master_F00_WT: Binned session data for WT animals on Day 0  (nAnimals × 1).
- Binned_Master_F00_RTT: Binned session data for RTT animals on Day 0  (nAnimals × 1).
- Binned_Master_WT: (cell array) Binned session data for WT animals (nAnimals × nDays).
Each cell contains a struct with dF/F, events, laps, etc.
- Binned_Master_RTT: (cell array) Binned session data for RTT animals (nAnimals × nDays).
Each cell contains a struct with dF/F, events, laps, etc.
- saving: save figure and variables (1) or not (0)

RETURNS:
- Plot animal-wise comparison of anticipatory licking probability
- (optional) save figures and varibales to current folder
%}

AnticiLickingProb_8days_WT = Get_AnticiLickProb(Binned_Master_F00_WT,Binned_Master_WT);
AnticiLickingProb_8days_RTT = Get_AnticiLickProb(Binned_Master_F00_RTT,Binned_Master_RTT);

MeanSEMPlot(AnticiLickingProb_8days_WT,AnticiLickingProb_8days_RTT,saving);

if saving == 1
    save('fig1E.mat','AnticiLickingProb_8days_WT','AnticiLickingProb_8days_RTT');
end

end

function AnticiLickingProb_8days_WT = Get_AnticiLickProb(Binned_Master_F00_WT,Binned_Master_WT)

AnticiLickingProb_8days_WT = [];
for j = 1:8
    for i = 1:size(Binned_Master_WT,1)
        if j == 1
            BinnedData_F00 = Binned_Master_F00_WT{i,1};
            LapStructure = BinnedData_F00.LapStructure;
        elseif j ~= 1
            BinnedData = Binned_Master_WT{i,(j-1)};
            LapStructure = BinnedData.LapStructure;
        end
  
        laps_antici_licks = [];
        for k = 1:numel([LapStructure.LapNumber])
            if ~isempty([LapStructure(k).RewardDeliveryLocation])
                Licks_loc = LapStructure(k).LickingLocation * 100;
                Reward_loc = LapStructure(k).RewardDeliveryLocation * 100;
                AnticiZone_left = max(0,Reward_loc-10.8);
                AnticiZone_right = Reward_loc;
                condition = (Licks_loc >= AnticiZone_left) & (Licks_loc < AnticiZone_right);
                if any(condition)
                    laps_antici_licks = [laps_antici_licks;k];
                end
            end
        end
        AnticiLickingProb_8days_WT(i,j) = numel(laps_antici_licks)/numel([LapStructure.LapNumber]);
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
ylim([0 0.65]);
xticks(1:8);
yticks(0:0.2:0.6);
xnewticklabel = {'0','1','2','3','4','5','6','7'};
xticklabels(xnewticklabel);
xlabel('Time (day)');
ylabel('Prob. of anticipatory licking');
%legend([h1 h2],'WT','RTT','FontSize',14,'location','southeast');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');
%title('Anticipatory slowing down factor');
hold off;

if saving == 1
    print(gcf, 'fig1E.pdf','-dpdf','-vector','-bestfit');
end

x_vec = 0:7;
anovaTbl = LMEM(WT,RTT,x_vec);

end