% analyze PC collective stability on each day
% for a given day, for each PC, how many days is it stable? Look only backward.
% stability = day x - start day + 1
% animal-wise average
% X: time (day), Y: stability (day)
% add shuffled PF location data
%%
% WT
MouseID_WT = unique(PF_location_WT(:,1))';
stability_WT = [];
stability_cells_WT = {};
for i = 1:numel(MouseID_WT)
    for j = 1:size(Binned_Master_WT,2)
        row_indices = find(PF_location_WT(:,1) == MouseID_WT(i) & ~isnan(PF_location_WT(:,(j+2))));
        PC_labels = PF_location_WT(row_indices,1:2);
        stability_PCs = [];
        for k = 1:size(PC_labels,1)
            PFs_indices = find(PF_location_WT_track_7_days(:,1)==MouseID_WT(i) &...
                    PF_location_WT_track_7_days(:,2)==PC_labels(k,2));
            PFs = PF_location_WT_track_7_days(PFs_indices,:);
            b = [];
            b = find(PFs(:,10) <= j & PFs(:,11) >= j);
            stability = j - PFs(b,10) + 1;
            stability_PCs = [stability_PCs;stability];
        end
        stability_WT(i,j) = mean(stability_PCs);
        stability_cells_WT{i,j} = stability_PCs;
    end
end

%%
% RTT
MouseID_RTT = unique(PF_location_RTT(:,1))';
stability_RTT = [];
stability_cells_RTT = {};
for i = 1:numel(MouseID_RTT)
    for j = 1:size(Binned_Master_RTT,2)
        row_indices = find(PF_location_RTT(:,1) == MouseID_RTT(i) & ~isnan(PF_location_RTT(:,(j+2))));
        PC_labels = PF_location_RTT(row_indices,1:2);
        stability_PCs = [];
        for k = 1:size(PC_labels,1)
            PFs_indices = find(PF_location_RTT_track_7_days(:,1)==MouseID_RTT(i) &...
                    PF_location_RTT_track_7_days(:,2)==PC_labels(k,2));
            PFs = PF_location_RTT_track_7_days(PFs_indices,:);
            b = [];
            b = find(PFs(:,10) <= j & PFs(:,11) >= j);
            stability = j - PFs(b,10) + 1;
            stability_PCs = [stability_PCs;stability];
        end
        stability_RTT(i,j) = mean(stability_PCs);
        stability_cells_RTT{i,j} = stability_PCs;
    end
end

%%
% shuffled PF location data
tic;
stability_shuffle = [];

delete(gcp('nocreate'));
parfor i = 1:size(PF_location_shuffled,3)
    PF_location = PF_location_shuffled(:,:,i);
    PF_location_tracking = PF_shuffle_tracking_7days{i,1};
    for j = 1:7
        PC_indices = find(~isnan(PF_location(:,(j+2))));
        stability_PCs = [];
        for k = 1:numel(PC_indices)
            idx = PC_indices(k);
            PFs_indices = find(PF_location_tracking(:,12)==idx);
            PFs = PF_location_tracking(PFs_indices,:);
            b = [];
            b = find(PFs(:,10) <= j & PFs(:,11) >= j);
            stability = j - PFs(b,10) + 1;
            stability_PCs = [stability_PCs;stability];
        end
        stability_shuffle(i,j) = mean(stability_PCs);
    end
end
delete(gcp('nocreate'));

toc;
stability_shuffle_mean = mean(stability_shuffle,1);

%%
% ribbon plot, with shuffled data
WT = stability_WT;
RTT = stability_RTT;

[WT_mean,WT_SEM] = MeanSem_omitnan(WT);
[RTT_mean,RTT_SEM] = MeanSem_omitnan(RTT);

figure;
hold on;
rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];
MeanSEM_ribbon(WT_mean,WT_SEM,RTT_mean,RTT_SEM,rgb_blue,rgb_orange,0.2);
plot(stability_shuffle_mean,'-','LineWidth',2,'Color','black');
hold off;
xlim([0.8 7+0.2]);
ylim([1 3]);
xticks(1:7);
xlabel('Time (day)');
ylabel('Average PC stability (day)');
%legend([h1,h2],'WT','RTT','FontSize',14);
%title('consecutive days');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

%print(gcf, 'fig3D.pdf','-dpdf','-vector','-bestfit');

WT = stability_WT;
RTT = stability_RTT;
x_vec = 1:size(WT,2);
anovaTbl = LMEM(WT,RTT,x_vec);
