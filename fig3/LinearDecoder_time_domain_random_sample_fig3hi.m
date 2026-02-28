% Optimal Linear Estimator to decode circular position

N_sample = 150;
N_iteration = 100;
time_window_size = 10;
%%
% WT
tic;
error_7day_WT_median = NaN(size(Binned_Master_WT,2),size(Binned_Master_WT,2),size(Binned_Master_WT,1));
error_7day_WT_mean = NaN(size(Binned_Master_WT,2),size(Binned_Master_WT,2),size(Binned_Master_WT,1));
error_session_WT_slice = [];
for i = 1:size(Binned_Master_WT,1)
    for j = 1:size(Binned_Master_WT,2)
        for c = 1:size(Binned_Master_WT,2)
            BinnedData = Binned_Master_WT{i,c};
            BinnedData_temp = Binned_Master_WT{i,j};

            Binned_noisy = Binned_noisy_dFoF_WT{i,c};
            Binned_noisy_temp = Binned_noisy_dFoF_WT{i,j};
            
            Cells_dFoF_noisy = Binned_noisy.Cells_dFoF_noisy;
            
            Binned_dFoF_noisy_temp = Binned_noisy_temp.Cells_dFoF_binned_mean_noisy;
            
            LapStructure = BinnedData.LapStructure;
            
            FrameNumber_running = [LapStructure.FrameNumber_running];
            Distance_frame_running = [LapStructure.Distance_frame_running];
            idx2 = find(Distance_frame_running <= (181.8/100));
            FrameNumber_running = FrameNumber_running(idx2);
            actual_pos_running = Distance_frame_running(idx2) * 100;
            error_M = [];
            decoded_pos_M = [];
            error_M_median = [];
            error_M_mean = [];
            for M = 1:N_iteration
                Cell_ID = randperm(size(Cells_dFoF_noisy,1),N_sample);
                [w_cos,w_sin,training_mean] = GetOLE_train(Binned_dFoF_noisy_temp,Cell_ID);
                error_session = [];
                decoded_pos = [];
                [decoded_pos,error_session] = GetOLE_error_time_2(FrameNumber_running,time_window_size,...
                    Cell_ID,Cells_dFoF_noisy,w_cos,w_sin,training_mean,actual_pos_running);
                decoded_pos_M(M,:) = decoded_pos';
                error_M_median(M) = nanmedian(error_session);
                error_M_mean(M) = nanmean(error_session);
                
            end
            
            error_7day_WT_median(c,j,i) = nanmean(error_M_median);
            error_7day_WT_mean(c,j,i) = nanmean(error_M_mean);
           
        end
    end
end

toc;

%%
% RTT
tic;
error_7day_RTT_median = NaN(size(Binned_Master_RTT,2),size(Binned_Master_RTT,2),size(Binned_Master_RTT,1));
error_7day_RTT_mean = NaN(size(Binned_Master_RTT,2),size(Binned_Master_RTT,2),size(Binned_Master_RTT,1));
for i = 1:size(Binned_Master_RTT,1)
    for j = 1:size(Binned_Master_RTT,2)
        for c = 1:size(Binned_Master_RTT,2)
            BinnedData = Binned_Master_RTT{i,c};
            BinnedData_temp = Binned_Master_RTT{i,j};

            Binned_noisy = Binned_noisy_dFoF_RTT{i,c};
            Binned_noisy_temp = Binned_noisy_dFoF_RTT{i,j};
            
            Cells_dFoF_noisy = Binned_noisy.Cells_dFoF_noisy;
            
            Binned_dFoF_noisy_temp = Binned_noisy_temp.Cells_dFoF_binned_mean_noisy;
            
            LapStructure = BinnedData.LapStructure;
            
            FrameNumber_running = [LapStructure.FrameNumber_running];
            Distance_frame_running = [LapStructure.Distance_frame_running];
            idx2 = find(Distance_frame_running <= (181.8/100));
            FrameNumber_running = FrameNumber_running(idx2);
            actual_pos_running = Distance_frame_running(idx2) * 100;
                        
            decoded_pos_M = [];
            error_M_median = [];
            error_M_mean = [];
            for M = 1:N_iteration
                Cell_ID = randperm(size(Cells_dFoF_noisy,1),N_sample);
                [w_cos,w_sin,training_mean] = GetOLE_train(Binned_dFoF_noisy_temp,Cell_ID);
                error_session = [];
                decoded_pos = [];
                [decoded_pos,error_session] = GetOLE_error_time_2(FrameNumber_running,time_window_size,...
                    Cell_ID,Cells_dFoF_noisy,w_cos,w_sin,training_mean,actual_pos_running);
                decoded_pos_M(M,:) = decoded_pos';
                error_M_median(M) = nanmedian(error_session);
                error_M_mean(M) = nanmean(error_session);
            end
            
            error_7day_RTT_median(c,j,i) = nanmean(error_M_median);
            error_7day_RTT_mean(c,j,i) = nanmean(error_M_mean);
        end
    end
end

toc;

%%
% plot the decoder error matrices in a customed colormap
A = error_7day_WT_avg;
B = error_7day_RTT_avg;

% ==== Custom blue-white-red with wider white center ====
n = 256; % Number of total colors
white_ratio = 0.1; % Fraction of colormap near center (0) that's white
fade_ratio = (1 - white_ratio) / 2;
% Number of steps for each transition
n_blue = round(fade_ratio * n);
n_white = round(white_ratio * n);
n_red = n - n_blue - n_white;
% Blue to white (0 to 1 fade in RGB)
blue = [linspace(0,1,n_blue)', linspace(0,1,n_blue)', ones(n_blue,1)];
% White center
white = ones(n_white, 3);
% White to red
red = [ones(n_red,1), linspace(1,0,n_red)', linspace(1,0,n_red)'];
% Combine full colormap
custom_colormap = [blue; white; red];

% Set color limits
cmin = min([A(:); B(:)]);
cmax = max([A(:); B(:)]);

% WT
% Create figure
figure;
imagesc(A, [cmin cmax]);
%title('WT');
%axis equal tight;
%colorbar;
colormap(custom_colormap);
xticks(1:7);
yticks(1:7);
xlabel('Template day');
ylabel('Test day');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');
%print(gcf, 'fig3H_WT.pdf','-dpdf','-vector','-bestfit');

% RTT
figure;
imagesc(B, [cmin cmax]);
%title('RTT');
%axis equal tight;
%colorbar;
colormap(custom_colormap);
xticks(1:7);
yticks(1:7);
xlabel('Template day');
ylabel('Test day');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');
%print(gcf, 'fig3H_RTT.pdf','-dpdf','-vector','-bestfit');

% add colorbar
figure;
imagesc(B, [cmin cmax]);
%title('RTT');
colorbar;
colormap(custom_colormap);
xticks(1:7);
yticks(1:7);
xlabel('Template day');
ylabel('Test day');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 750 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');
cb = colorbar;
cb.FontSize = 30; cb.Label.FontSize = 24; cb.LineWidth = 0.5;
cb.Ticks = [15,35];
cb.TickLabels = {'15','35'};
ylabel(cb, 'Decoding error (cm)');
%print(gcf, 'fig3H_RTT_clb.pdf','-dpdf','-vector','-bestfit');

%%
% normalize decoding error to the diagonal values (the same day decoding)
error_7day_WT_mean_norm = [];
for z = 1:size(error_7day_WT_mean,3)
    mtx = error_7day_WT_mean(:,:,z);
    mtx_norm = [];
    for j = 1:size(mtx,2)
        for c = 1:size(mtx,1)
            mtx_norm(c,j) = mtx(c,j)-mtx(j,j);
        end
    end
    error_7day_WT_mean_norm(:,:,z) = mtx_norm;
end

error_7day_RTT_mean_norm = [];
for z = 1:size(error_7day_RTT_mean,3)
    mtx = error_7day_RTT_mean(:,:,z);
    mtx_norm = [];
    for j = 1:size(mtx,2)
        for c = 1:size(mtx,1)
            mtx_norm(c,j) = mtx(c,j)-mtx(j,j);
        end
    end
    error_7day_RTT_mean_norm(:,:,z) = mtx_norm;
end

%%
% plot decoder performance of -6,-5,...,0,1,2,...,6 days
delta_days = -6:1:6;

WT_delta_error = de_error_delta_day(delta_days,error_7day_WT_mean_norm);
RTT_delta_error = de_error_delta_day(delta_days,error_7day_RTT_mean_norm);

WT = WT_delta_error(:,7:11);
RTT = RTT_delta_error(:,7:11);

[WT_mean,WT_SEM] = MeanSem_omitnan(WT);
[RTT_mean,RTT_SEM] = MeanSem_omitnan(RTT);

figure;
hold on;
rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];
MeanSEM_ribbon(WT_mean,WT_SEM,RTT_mean,RTT_SEM,rgb_blue,rgb_orange,0.2);
hold off;
%xlim([0.8 13+0.2]);
xlim([0.8 size(WT,2)+0.2]);
ylim([0 20]);
% xticks(1:13);
% xnewticklabel = {'-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6'};
xticks(1:size(WT,2));
xnewticklabel = {'0','+1','+2','+3','+4'};
xticklabels(xnewticklabel);
xlabel('Time (day)');
ylabel('Decoding error change (cm)');
%legend([h1,h2],'WT','RTT','FontSize',14);
%title('consecutive days');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

%print(gcf, 'fig3I_norm.pdf','-dpdf','-vector','-bestfit');

WT = WT_delta_error(:,8:11);
RTT = RTT_delta_error(:,8:11);
[ranovatbl,anovatbl,results_posthoc] = twrm_ANOVA(WT,RTT);