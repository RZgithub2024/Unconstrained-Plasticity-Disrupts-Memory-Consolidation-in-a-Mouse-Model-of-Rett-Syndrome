% visualize history dependent-PF formation

%%
% WT
MouseID_WT = unique(PF_location_WT(:,1))';
PF_his_WT = [];

for n = 1:numel(MouseID_WT)
    MouseID = MouseID_WT(n);
    Cells_ID = find(PF_location_WT(:,1)==MouseID);
    PF_his = [];
    for p = 1:numel(Cells_ID)
        row_ID = Cells_ID(p);
        PF_loc = PF_location_WT(row_ID,3:9);
        for i = 1:7
            if i > 1
                history = numel(find(~isnan(PF_loc(1:(i-1)))));
            elseif i == 1
                history = 0;
            end

            a = [];
            a = [history,~isnan(PF_loc(i))];
            PF_his = [PF_his;a];
        end
    end

    for j = 0:6
        m = find(PF_his(:, 1) == j);
        nn = sum(PF_his(m,2));
        PF_his_WT(n,(j+1)) = nn/numel(m);
    end
end

%%
% RTT
MouseID_RTT = unique(PF_location_RTT(:,1))';
PF_his_RTT = [];

for n = 1:numel(MouseID_RTT)
    MouseID = MouseID_RTT(n);
    Cells_ID = find(PF_location_RTT(:,1)==MouseID);
    PF_his = [];
    for p = 1:numel(Cells_ID)
        row_ID = Cells_ID(p);
        PF_loc = PF_location_RTT(row_ID,3:9);
        for i = 1:7
            if i > 1
                history = numel(find(~isnan(PF_loc(1:(i-1)))));
            elseif i == 1
                history = 0;
            end

            a = [];
            a = [history,~isnan(PF_loc(i))];
            PF_his = [PF_his;a];
        end
    end

    for j = 0:6
        m = find(PF_his(:, 1) == j);
        nn = sum(PF_his(m,2));
        PF_his_RTT(n,(j+1)) = nn/numel(m);
    end
end

%%
WT = PF_his_WT;
RTT = PF_his_RTT;

WT_mean = mean(WT,1);
WT_SEM = std(WT)/...
        sqrt(size(WT,1));
RTT_mean = mean(RTT);
RTT_SEM = std(RTT)/...
        sqrt(size(RTT,1));

figure;
hold on;
% WT and RTT
rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];
MeanSEM_ribbon(WT_mean,WT_SEM,RTT_mean,RTT_SEM,rgb_blue,rgb_orange,0.2);

hold off;
xlim([0.8 7+0.2]);
ylim([0 1]);
xticks(1:7);
xticklabels({'0','1','2','3','4','5','6','7'});
xlabel('No. of previous day with PFs');
ylabel('Probability of PF formation');
%legend([h1 h2],'WT','RTT','FontSize',14);
%title('Total days with PF, norm2ROI');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');