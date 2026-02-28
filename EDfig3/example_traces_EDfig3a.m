% plot example traces of several laps of a PC
% dF/F, velocity, reward delivery, licks

%%
% enter the mouse information, check the genotype
% 5 consecutive laps
% implay all PCs
% WT

i = 7;
j = 1;
BinnedData = Binned_Master_WT{i,j};
noisy = Binned_noisy_dFoF_WT{i,j};
implay(BinnedData.Cells_dFoF_binned_mean(:,:,BinnedData.PFStats.PFIDs));

%%
% enter the place cell index and plot a heatmap
p = 12;
ROI = BinnedData.PFStats.PFIDs(p);
figure;
heatmap(BinnedData.Cells_dFoF_binned_mean(:,:,ROI));

%%
% enter start lap and how many following laps to plot
lap_start = 53;
k = 5;
LapStructure = BinnedData.LapStructure;

%%
figure;
t = tiledlayout(5,1, 'TileSpacing', 'tight', 'Padding', 'tight');
for ii = 1:k
    lap = lap_start+ii-1;
    WS_time = LapStructure(lap).LapTimes_WS;
    time = WS_time(1):WS_time(end);
    t_indices = 1:length(WS_time);

    Frames = LapStructure(lap).FrameNumber;
    FrameTimes_abs = LapStructure(lap).FrameTimes_abs;
    fr_idx = find(ismember(time,FrameTimes_abs));
    dFoF = BinnedData.Cells_dFoF_denoised(ROI,Frames);
    % dFoF = noisy.Cells_dFoF_noisy(ROI,Frames);
    
    vel_noisy = LapStructure(lap).Velocity_noisy;
    vel_noisy = smooth(vel_noisy,50);
    
    LickingTimes = LapStructure(lap).LickingTimes;
    licks = ones(1,length(t_indices))*-1;
    LickingTimes_indices = find(ismember(time,LickingTimes));
    licks(LickingTimes_indices) = 1;
    
    reward = ones(1,length(t_indices))*-1;
    RewardDeliveryTimes = LapStructure(lap).RewardDeliveryTimes(1);
    reward_index = find(ismember(time,RewardDeliveryTimes));
    reward(reward_index) = 1;

    color1 = [0.5, 0.5, 0.5];
    color2 = [1, 0.5, 0];
    color3 = [0, 0, 1];
    nexttile;
    hold on;
    yyaxis left
    plot(t_indices,vel_noisy, '-', 'Color', color1,'LineWidth',3);
    ylim([-0.1 50]);

    yyaxis right
    plot(fr_idx,dFoF, '-', 'Color', 'k','LineWidth',3);
    plot(t_indices,licks, '-', 'Color', color2,'LineWidth',3);
    plot(t_indices,reward, '-', 'Color', color3,'LineWidth',3);
    ylim([-0.1 4]);
    xlim([0 150000]);
    set(gca, 'Visible', 'off');
    set(gcf, 'Color', 'w');

    hold off;
end

set(gcf,'Position',[500 500 500 500]);
%print(gcf, 'fig1n.pdf','-dpdf','-vector','-bestfit');

%%
% RTT
i = 6;
j = 1;
BinnedData = Binned_Master_RTT{i,j};
noisy = Binned_noisy_dFoF_RTT{i,j};
implay(BinnedData.Cells_dFoF_binned_mean(:,:,BinnedData.PFStats.PFIDs));

%%
% enter the place cell index and plot a heatmap
p = 117;
ROI = BinnedData.PFStats.PFIDs(p);
figure;
heatmap(BinnedData.Cells_dFoF_binned_mean(:,:,ROI));

%%
% enter start lap and how many following laps to plot
lap_start = 21;
k = 5;
LapStructure = BinnedData.LapStructure;

%%
figure;
t = tiledlayout(5,1, 'TileSpacing', 'tight', 'Padding', 'tight');
for ii = 1:k
    lap = lap_start+ii-1;
    WS_time = LapStructure(lap).LapTimes_WS;
    time = WS_time(1):WS_time(end);
    t_indices = 1:length(WS_time);

    Frames = LapStructure(lap).FrameNumber;
    FrameTimes_abs = LapStructure(lap).FrameTimes_abs;
    fr_idx = find(ismember(time,FrameTimes_abs));
    dFoF = BinnedData.Cells_dFoF_denoised(ROI,Frames);
    % dFoF = noisy.Cells_dFoF_noisy(ROI,Frames);
    
    vel_noisy = LapStructure(lap).Velocity_noisy;
    vel_noisy = smooth(vel_noisy,50);
    
    LickingTimes = LapStructure(lap).LickingTimes;
    licks = ones(1,length(t_indices))*-1;
    LickingTimes_indices = find(ismember(time,LickingTimes));
    licks(LickingTimes_indices) = 1;
    
    reward = ones(1,length(t_indices))*-1;
    RewardDeliveryTimes = LapStructure(lap).RewardDeliveryTimes(1);
    reward_index = find(ismember(time,RewardDeliveryTimes));
    reward(reward_index) = 1;

    color1 = [0.5, 0.5, 0.5];
    color2 = [1, 0.5, 0];
    color3 = [0, 0, 1];
    nexttile;
    hold on;
    yyaxis left
    plot(t_indices,vel_noisy, '-', 'Color', color1,'LineWidth',3);
    ylim([-0.1 50]);

    yyaxis right
    plot(fr_idx,dFoF, '-', 'Color', 'k','LineWidth',3);
    plot(t_indices,licks, '-', 'Color', color2,'LineWidth',3);
    plot(t_indices,reward, '-', 'Color', color3,'LineWidth',3);
    ylim([-0.1 4]);
    xlim([0 150000]);
    set(gca, 'Visible', 'off');
    set(gcf, 'Color', 'w');

    hold off;
end

set(gcf,'Position',[500 500 500 500]);
%print(gcf, 'fig1o.pdf','-dpdf','-vector','-bestfit');

%%
% plot scale bar
figure;
t = tiledlayout(5,1, 'TileSpacing', 'tight', 'Padding', 'tight');
for ii = 1:5
    nexttile;
    hold on;
    x_start = 1000;
    y_start = 0;
    line([x_start, x_start + 20000], [y_start, y_start], ...
    'Color', 'k', 'LineWidth', 2)
    line([x_start + 20000, x_start + 20000], [y_start, y_start + 4], ...
    'Color', 'k', 'LineWidth', 2)
    set(gca, 'Visible', 'off');
    set(gcf, 'Color', 'w');
    xlim([0 150000]);
    ylim([-0.1 4]);

    hold off;
end

set(gcf,'Position',[500 500 500 500]);
%print(gcf, 'fig1p.pdf','-dpdf','-vector','-bestfit');