% Optimal Linear Estimator to decode circular position
% Plot the distribution of cross-day decoding errors (delta = +1 day)

N_sample = 150;
N_iteration = 100;
time_window_size = 10;
%%
% WT
tic;
error_7day_WT_median = NaN(size(Binned_Master_WT,2),size(Binned_Master_WT,2),size(Binned_Master_WT,1));
error_7day_WT_mean = NaN(size(Binned_Master_WT,2),size(Binned_Master_WT,2),size(Binned_Master_WT,1));
error_session_WT_slice = [];

for i = 4
    for j = 1
        for c = j+1
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
                
                if c == j+1
                    error_session_WT_slice = [error_session_WT_slice;error_session];
                end
            end
            
            error_7day_WT_median(c,j,i) = nanmean(error_M_median);
            error_7day_WT_mean(c,j,i) = nanmean(error_M_mean);
           
        end
    end
end

toc;

%%
figure;
edges = 0:5:90;
h = histogram(error_session_WT_slice,edges);
xlim([0-2 90+2]);
xticks(0:45:90);
xlabel({'Cross-one-day','decoding error (cm)'});
rgb_blue = [0, 0.4470, 0.7410];
h.FaceColor = rgb_blue;
h.EdgeColor = 'k';
h.LineWidth = 1.5;

ylabel('Decoded bins');
ylim([0 60000]);
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

%print(gcf, 'suppfig6C.pdf','-dpdf','-vector','-bestfit');

%%
% RTT
tic;
error_7day_RTT_median = NaN(size(Binned_Master_RTT,2),size(Binned_Master_RTT,2),size(Binned_Master_RTT,1));
error_7day_RTT_mean = NaN(size(Binned_Master_RTT,2),size(Binned_Master_RTT,2),size(Binned_Master_RTT,1));
error_session_RTT_slice = [];
for i = 8
    for j = 1
        for c = j+1
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
                
                if c == j+1
                    error_session_RTT_slice = [error_session_RTT_slice;error_session];
                end
            end
            
            error_7day_RTT_median(c,j,i) = nanmean(error_M_median);
            error_7day_RTT_mean(c,j,i) = nanmean(error_M_mean);
           
        end
    end
end

toc;

%%
figure;
edges = 0:5:90;
h = histogram(error_session_RTT_slice,edges);
xlim([0-2 90+2]);
xticks(0:45:90);
xlabel({'Cross-one-day','decoding error (cm)'});
rgb_orange = [0.8500, 0.3250, 0.0980];
h.FaceColor = rgb_orange;
h.EdgeColor = 'k';
h.LineWidth = 1.5;

ylabel('Decoded bins');
ylim([0 60000]);
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

%print(gcf, 'suppfig6D.pdf','-dpdf','-vector','-bestfit');
