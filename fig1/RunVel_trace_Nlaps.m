function RunVel_trace_Nlaps(Binned_Master_F00_WT,Binned_Master_WT,N,saving)

%{
This function plot traces of running velocity in N laps on Day 0, 1, and 7 for WT or RTT mice.
Velocity is averaged in 50 bins. For each lap, Aligned to reward, 24 bins before and 25
bins after reward delivery form a 1*50 vector. X: location in bins, Y: velocity (cm/s)

ARGS:
- Binned_Master_F00_WT: Binned session data for WT animals on Day 0  (nAnimals × 1).
- Binned_Master_WT: (cell array) Binned session data for WT animals (nAnimals × nDays).
Each cell contains a struct with dF/F, events, laps, etc.
- saving: save figure and variables (1) or not (0)

RETURNS:
- Plot velocity traces (Day 0, 1, and 7)
- (optional) save figures and varibales to current folder
%}

laps = 1:N;

Mean_velocity_by_animal_8days_WT = GetMeanVel_8day(Binned_Master_F00_WT,Binned_Master_WT,laps);

RunVel_Plot(Mean_velocity_by_animal_8days_WT,saving);

Mean_velocity_WT_017 = {};
Mean_velocity_WT_017 = Mean_velocity_by_animal_8days_WT([1 2 8]);

if saving == 1
    save('fig1B_WT.mat','Mean_velocity_WT_017');
end

end


function Mean_velocity_by_animal_8days_WT = GetMeanVel_8day(Binned_Master_F00_WT,Binned_Master_WT,laps)

Mean_velocity_by_animal_8days_WT = {};
for j = 1:8
    Mean_velocity_by_animal = [];
    for i = 1:size(Binned_Master_WT,1)
        if j == 1
            BinnedData = Binned_Master_F00_WT{i,1};
        elseif j ~= 1
            BinnedData = Binned_Master_WT{i,(j-1)};
        end
        
        Vel_pseudolaps = [];
        [Vel_pseudolaps,~] = Vel_align2reward(BinnedData);
        
        Mean_velocity = nanmean(Vel_pseudolaps(laps,:),1);
        Mean_velocity_by_animal = [Mean_velocity_by_animal;Mean_velocity];
    end
    Mean_velocity_by_animal_8days_WT{j} = Mean_velocity_by_animal;
end

end

function RunVel_Plot(Mean_velocity_by_animal_8days_WT,saving)

days = [0,1,7];
Mean_velocity_WT = [];
SEM_velocity_WT = [];
for d = 1:numel(days)
    m = days(d)+1;
    data_WT = Mean_velocity_by_animal_8days_WT{m};
    [Mean_velocity_WT(d,:),SEM_velocity_WT(d,:)] = MeanSem_omitnan(data_WT);
end

colors(1,:) = [105,105,105]/255;
colors(2,:) = [50,205,50]/255;
colors(3,:) = [30,144,255]/255;
colors(4,:) = [233,113,50]/255;
colors(5,:) = [22,96,130]/255;

figure;
hold on;
x1 = 13;
x2 = 37;
x = x1:x2;
for d = 1:size(Mean_velocity_WT,1)
    plot(x,Mean_velocity_WT(d,x1:x2),'color',colors(d,1:3),'LineWidth',3);
    x_fill = [x,fliplr(x)];
    y_fill_upper = Mean_velocity_WT(d,x1:x2) + SEM_velocity_WT(d,x1:x2);
    y_fill_lower = Mean_velocity_WT(d,x1:x2) - SEM_velocity_WT(d,x1:x2);
    y_fill = [y_fill_upper,fliplr(y_fill_lower)];
    fill(x_fill, y_fill,colors(d,1:3), 'FaceAlpha', 0.1,'EdgeColor', 'none');
end
xlim([x1-0.1 x2+0.6]);
xticks([13 25 37]);
xticklabels({'-43.2','0','43.2'});
ylim([0-0.1 40]);
xlabel('Position relative to reward (cm)');
ylabel('Velocity (cm/s)');
xline(25,'--k','LineWidth',3,'FontSize',24);
%title('Mean velocity, WT');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

% mark the remote and anticipatory zone
x_start = 22-0.5;
x_end = 24+0.5;
y_start = 0;
y_end = 40;
width = x_end - x_start;
height = y_end - y_start;
rectangle('Position', [x_start, y_start, width, height], ...
          'FaceColor', colors(4,1:3), ...
          'EdgeColor', 'none', ...
          'FaceAlpha', 0.3);

x_start = 1-0.5;
x_end = 6+0.5;
y_start = 0;
y_end = 40;
width = x_end - x_start;
height = y_end - y_start;
rectangle('Position', [x_start, y_start, width, height], ...
          'FaceColor', colors(5,1:3), ...
          'EdgeColor', 'none', ...
          'FaceAlpha', 0.3);

hold off;

if saving == 1
    print(gcf, 'fig1B_WT.pdf','-dpdf','-vector','-bestfit');
end


end