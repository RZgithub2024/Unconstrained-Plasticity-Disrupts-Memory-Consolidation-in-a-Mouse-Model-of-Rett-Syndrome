function LickProb(Binned_Master_F00_WT,Binned_Master_WT,saving)

%{
This function plot traces of licking probability along the belt on Day 0, 1, and 7 for WT or RTT mice.
The 180-cm belt is divided into 50 bins. If at least one lick falls into a given bin, this bin is true; otherwise, false.
Licking probability of a bin = No. of true laps / total No. of laps. X:
location in bins, Y: licking probability. Only plot x = 19—21.

ARGS:
- Binned_Master_F00_WT: Binned session data for WT animals on Day 0  (nAnimals × 1).
- Binned_Master_WT: (cell array) Binned session data for WT animals (nAnimals × nDays).
Each cell contains a struct with dF/F, events, laps, etc.
- saving: save figure and variables (1) or not (0)

RETURNS:
- Plot licking probability traces (Day 0, 1, and 7)
- (optional) save figures and varibales to current folder
%}

LickingProb_WT_8days = GetLickProb_8day(Binned_Master_F00_WT,Binned_Master_WT);

LickProb_Plot(LickingProb_WT_8days,saving);

LickingProb_WT_017 = {};
LickingProb_WT_017 = LickingProb_WT_8days([1 2 8]);

if saving == 1
    save('fig1D_RTT.mat','LickingProb_WT_017');
end

end

function LickingProb_WT_8days = GetLickProb_8day(Binned_Master_F00_WT,Binned_Master_WT)

LickingProb_WT_8days = {};
for j = 1:8
    LickingProb_WT = [];
    for i = 1:size(Binned_Master_WT,1)
        if j == 1
            BinnedData = Binned_Master_F00_WT{i,1};
        elseif j ~= 1
            BinnedData = Binned_Master_WT{i,(j-1)};
        end

        [~,lickornot_pseudolaps] = Lickcount_align2reward(BinnedData);
        for ii = 1:50
            LickingProb(ii) = numel(find(lickornot_pseudolaps(:,ii)==1))/size(lickornot_pseudolaps,1);
        end

        LickingProb_WT = [LickingProb_WT;LickingProb];

    end
    LickingProb_WT_8days{j} = LickingProb_WT;
end

end

function LickProb_Plot(LickingProb_WT_8days,saving)

days = [0,1,7];
Mean_lick_prob_WT = [];
SEM_lick_prob_WT = [];
for d = 1:numel(days)
    m = days(d)+1;
    data_WT = LickingProb_WT_8days{m}(:,19:31);
    [Mean_lick_prob_WT(d,:),SEM_lick_prob_WT(d,:)] = MeanSem_omitnan(data_WT);
end

colors(1,:) = [105,105,105]/255;
colors(2,:) = [50,205,50]/255;
colors(3,:) = [30,144,255]/255;
colors(4,:) = [233,113,50]/255;

x0 = 19:31;
figure;
hold on;
for d = 1:size(Mean_lick_prob_WT,1)
    plot(x0,Mean_lick_prob_WT(d,:),'color',colors(d,:),'LineWidth',3);
    x = x0;
    x_fill = [x,fliplr(x)];
    y_fill_upper = Mean_lick_prob_WT(d,:) + SEM_lick_prob_WT(d,:);
    y_fill_lower = Mean_lick_prob_WT(d,:) - SEM_lick_prob_WT(d,:);
    y_fill = [y_fill_upper,fliplr(y_fill_lower)];
    fill(x_fill, y_fill,colors(d,:), 'FaceAlpha', 0.1,'EdgeColor', 'none');

end
xticks([19 25 31]);
xticklabels({'-21.6','0','21.6'});
xlim([19-0.2 31+0.2]);
ylim([0-0.01 1]);
xlabel('Position relative to reward (cm)');
ylabel('Licking probability');
xline(25,'--k','LineWidth',3);
%title('Mean licking prob, WT');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

% mark the anticipatory zone
x_start = 22-0.5;
x_end = 24+0.5;
y_start = 0-0.01;
y_end = 1;
width = x_end - x_start;
height = y_end - y_start;
rectangle('Position', [x_start, y_start, width, height], ...
          'FaceColor', colors(4,:), ...
          'EdgeColor', 'none', ...
          'FaceAlpha', 0.3);
hold off;

if saving == 1
    print(gcf, 'fig1D_RTT.pdf','-dpdf','-vector','-bestfit');
end

end