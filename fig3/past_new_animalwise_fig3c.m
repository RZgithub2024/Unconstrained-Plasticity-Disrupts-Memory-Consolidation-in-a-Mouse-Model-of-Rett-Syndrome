% track PF decay in an animal-wise manner

%%
% WT
MouseID_WT = unique(PF_location_WT(:,1))';
past_over_new_PF_WT_animal = [];
past_PF_WT = [];
new_PF_WT = [];
PF_decay_7_days_animal_WT = {};
PF_decay_7_days_animal_WT_index = {};
for i = 1:numel(MouseID_WT)
    PF_location = [];
    PF_location = PF_location_WT(PF_location_WT(:,1) == MouseID_WT(i),:);
    MouseID_WT(i)
    [past_over_new_PF_WT_animal(i,:),past_PF_WT(i,:),new_PF_WT(i,:),...
        PF_decay_7_days_animal_WT{i,1},PF_decay_7_days_animal_WT_index{i,1},~,~,~] = PFdecay_animalwise(PF_location);
end

%%
% RTT
MouseID_RTT = unique(PF_location_RTT(:,1))';
past_over_new_PF_RTT_animal = [];
past_PF_RTT = [];
new_PF_RTT = [];
PF_decay_7_days_animal_RTT = {};
PF_decay_7_days_animal_RTT_index = {};
for i = 1:numel(MouseID_RTT)
    PF_location = [];
    PF_location = PF_location_RTT(PF_location_RTT(:,1) == MouseID_RTT(i),:);
    MouseID_RTT(i) 
    [past_over_new_PF_RTT_animal(i,:),past_PF_RTT(i,:),new_PF_RTT(i,:),...
        PF_decay_7_days_animal_RTT{i,1},PF_decay_7_days_animal_RTT_index{i,1},~,~,~] = PFdecay_animalwise(PF_location);
end

%%
% shuffled data
tic;
past_over_new_PF_shuffle = [];

delete(gcp('nocreate'));
parfor i = 1:size(PF_location_shuffled,3)
    PF_location = PF_location_shuffled(:,:,i);
    [past_over_new_PF_shuffle(i,:),~,~,~,~,~,~,~,~] = PFdecay_animalwise_shuffle(PF_location);
end
delete(gcp('nocreate'));

past_over_new_PF_shuffle_mean = mean(past_over_new_PF_shuffle,1);
toc;

%%
% plot past/new PC ratio, with shuffled data
WT = past_over_new_PF_WT_animal;
RTT = past_over_new_PF_RTT_animal;

[WT_mean,WT_SEM] = MeanSem_omitnan(WT);
[RTT_mean,RTT_SEM] = MeanSem_omitnan(RTT);

figure;
hold on;
rgb_blue = [0, 0.4470, 0.7410];
rgb_orange = [0.8500, 0.3250, 0.0980];
MeanSEM_ribbon(WT_mean,WT_SEM,RTT_mean,RTT_SEM,rgb_blue,rgb_orange,0.2);
plot(past_over_new_PF_shuffle_mean,'-','LineWidth',2,'Color','black');
hold off;
xlim([0.8 7+0.2]);
ylim([0 2]);
xticks(1:7);
set(gca, 'FontSize', 30);
ylabel('Past PCs/new PCs');
xlabel('Time (day)');

set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

%print(gcf, 'fig3C.pdf','-dpdf','-vector','-bestfit');

x_vec = 1:size(WT,2);
anovaTbl = LMEM(WT,RTT,x_vec);
