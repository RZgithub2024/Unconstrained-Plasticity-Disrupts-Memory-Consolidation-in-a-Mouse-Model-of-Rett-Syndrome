% total days with PF
% animal wise
% add shuffled data
%%
% WT
MouseID_WT = unique(PF_location_WT(:,1))';
PF_days_WT = {};
for n = 1:numel(MouseID_WT)
    MouseID = MouseID_WT(n);
    Cells_ID = find(PF_location_WT(:,1)==MouseID);
    PF_days = [];
    for p = 1:numel(Cells_ID)
        PForNot = ~isnan(PF_location_WT(Cells_ID(p),3:9));
        PF_days = [PF_days;sum(PForNot)];
    end
    PF_days_WT{n,1} = PF_days;
end

% Get histogram counts based on specified edges
edges = -0.5:1:7.5;
DayPF_counts_WT = [];
DayPF_prop_WT = [];
for n = 1:size(PF_days_WT,1)
    [DayPF_counts_WT(n,1:8), ~] = histcounts(PF_days_WT{n}, edges);
    DayPF_prop_WT(n,1:8) = DayPF_counts_WT(n,1:8)./numel(PF_days_WT{n})*100;
end

%%
% RTT
MouseID_RTT = unique(PF_location_RTT(:,1))';
PF_days_RTT = {};
for n = 1:numel(MouseID_RTT)
    MouseID = MouseID_RTT(n);
    Cells_ID = find(PF_location_RTT(:,1)==MouseID);
    PF_days = [];
    for p = 1:numel(Cells_ID)
        PForNot = ~isnan(PF_location_RTT(Cells_ID(p),3:9));
        PF_days = [PF_days;sum(PForNot)];
    end
    PF_days_RTT{n,1} = PF_days;
end

% Get histogram counts based on specified edges
edges = -0.5:1:7.5;
DayPF_counts_RTT = [];
DayPF_prop_RTT = [];
for n = 1:size(PF_days_RTT,1)
    [DayPF_counts_RTT(n,1:8), ~] = histcounts(PF_days_RTT{n}, edges);
    DayPF_prop_RTT(n,1:8) = DayPF_counts_RTT(n,1:8)./numel(PF_days_RTT{n})*100;
end

%%
% shuffled data
DayPF_prop_shuffled = [];
for i = 1:size(PF_location_shuffled,3)
    PF_days_s = [];
    PF_location_s = PF_location_shuffled(:,:,i);
    for p = 1:size(PF_location_s,1)
        PForNot = ~isnan(PF_location_s(p,3:9));
        PF_days_s = [PF_days_s;sum(PForNot)];
    end
    edges = -0.5:1:7.5;
    [DayPF_counts_s,~] = histcounts(PF_days_s, edges);
    DayPF_prop_s = DayPF_counts_s./numel(PF_days_s)*100;
    DayPF_prop_shuffled = [DayPF_prop_shuffled;DayPF_prop_s];
end

DayPF_prop_shuffled_mean = mean(DayPF_prop_shuffled,1);


%%
% plot % of cells having PFs for 0—7 days
WT_mean = mean(DayPF_prop_WT,1);
WT_SEM = std(DayPF_prop_WT)/...
        sqrt(size(DayPF_prop_WT,1));
RTT_mean = mean(DayPF_prop_RTT);
RTT_SEM = std(DayPF_prop_RTT)/...
        sqrt(size(DayPF_prop_RTT,1));

figure;
hold on;
% WT and RTT
rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];
MeanSEM_ribbon(WT_mean,WT_SEM,RTT_mean,RTT_SEM,rgb_blue,rgb_orange,0.2);
% shuffled data
color3 = [0.3 0.3 0.3];
plot(DayPF_prop_shuffled_mean,'--o','LineWidth',2,'Color',color3,'MarkerSize',8,'MarkerEdgeColor',...
    color3,'MarkerFaceColor','none');
hold off;
xlim([0.8 8+0.2]);
ylim([0 60]);
xticks(1:8);
xticklabels({'0','1','2','3','4','5','6','7'});
xlabel('Time with PFs (day)');
ylabel('% of CA1 cells');
%legend([h1 h2],'WT','RTT','FontSize',14);
%title('Total days with PF, norm2ROI');
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

%print(gcf, 'suppfig2_14.pdf','-dpdf','-vector','-bestfit');
