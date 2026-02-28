% decode animal position within a session using the OLE method
% use odd laps as template to decode even laps, include all cells
% report decoding error in cm
% not require a time window

%%
% WT
% enter the animal ID and the day to be decoded
i = 4; % animal ID
j = 1; % day index

BinnedData = Binned_Master_WT{i,j};
Binned_noisy = Binned_noisy_dFoF_WT{i,j};
Binned_dFoF_noisy = Binned_noisy.Cells_dFoF_binned_mean_noisy;
Cells_dFoF_noisy = Binned_noisy.Cells_dFoF_noisy;
LapStructure = BinnedData.LapStructure;

% odd laps as template
odd_laps = 1:2:numel([LapStructure.LapNumber]);
Cell_ID = 1:size(BinnedData.Cells_dFoF_denoised,1);
[w_cos,w_sin,training_mean] = GetOLE_train_laps(Binned_dFoF_noisy,odd_laps,Cell_ID);

decoded_pos_even = {};
act_pos_even = {};
decoded_error_even = {};
for k = 2:2:numel([LapStructure.LapNumber])
    FrameNumber_running = LapStructure(k).FrameNumber_running;
    actual_pos_running = LapStructure(k).Distance_frame_running * 100;
    [decoded_pos,decoded_error] = GetOLE_error_time_3(FrameNumber_running,...
        Cell_ID,Cells_dFoF_noisy,w_cos,w_sin,training_mean,actual_pos_running);
    decoded_pos_even{k,1} = decoded_pos;
    act_pos_even{k,1} = actual_pos_running';
    decoded_error_even{k,1} = decoded_error;
end


% plot decoding position of all the even laps
de_pos = [];
a_pos = [];
figure;
n = 0;
for k = 2:2:numel([LapStructure.LapNumber])
    n = n+1;
    subplot(ceil(numel([LapStructure.LapNumber])/(2*5)),5,n);
    a = decoded_pos_even{k,1};
    b = act_pos_even{k,1};
    hold on;
    plot(a,'r','LineWidth',1);
    plot(b,'k','LineWidth',1);
    de_pos = [de_pos;a];
    a_pos = [a_pos;b];
    hold off;
end

%%
% plot decoding position of given laps
% plot a corresponding scale bar for time (x axis)
% scale bar: 300 frames, 10 s

laps = 12:2:30;
gap1 = 10;
A = [];
B = [];
C = [];
for k = 1:numel(laps)
    la = laps(k);
    a = decoded_pos_even{la,1};
    b = act_pos_even{la,1};
    c = decoded_error_even{la,1};
    if k < numel(laps)
        a = [a;NaN(gap1,1)];
        b = [b;NaN(gap1,1)];
        c = [c;NaN(gap1,1)];
    end
    A = [A;a];
    B = [B;b];
    C = [C;c];
end

figure;
ax1 = subplot(2,1,1);
ax1.Position = [0.1 0.55 0.8 0.4]; 
color1 = [0.2, 0.6, 0.2];
rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];
hold on;
plot(A,'Color',rgb_blue,'LineWidth',1.5);
plot(B,'k','LineWidth',1.5);

x_start = 1607;
y_start = 10;
line([x_start, x_start + 300], [y_start, y_start], ...
    'Color', 'k', 'LineWidth', 3);

xlim([0-20 size(A,1)+20]);
xlim_WT = size(A,1)+20+20;
ylim([0 180]);
yticks(0:90:180);
ylabel('Position (cm)');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 1500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');
ax = gca;
ax.XColor = 'none';
ax.YColor = [0 0 0];
daspect([2 1 1]);
hold off;

ax2 = subplot(2,1,2);
ax2.Position = [0.1 0.2 0.8 0.2];
hold on;
color3 = [0.3 0.3 0.3];
plot(C,'Color',color3,'LineWidth',1.5);
xlim([0-20 size(C,1)+20]);
ylim([0 90]);
yticks(0:90:90);
set(gca, 'FontSize', 30);
%set(gcf,'Position',[500 500 1500 250]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');
ax = gca;
ax.XColor = 'none';
ax.YColor = [0 0 0];
ylabel({'Decoding','error (cm)'},'FontSize',24);
daspect([2 1 1]);
hold off;

%print(gcf, 'suppfig_5_1_2.pdf','-dpdf','-vector','-bestfit');
