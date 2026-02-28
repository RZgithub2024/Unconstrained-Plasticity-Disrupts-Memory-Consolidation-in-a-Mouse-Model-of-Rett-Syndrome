% have PF_location loaded

% WT
PF_location_WT_track_7_days = [];
PF_ID_new = {};

% PFs that appear on F01
PF_ID_F01 = find(~isnan(PF_location_WT(:,3)));
PF_ID_new{1} = PF_ID_F01;

% track all PFs that first appear on F01
m = 1;
for i = 1:size(PF_ID_F01,1)
    PF_subsequent_days = PF_location_WT(PF_ID_F01(i),m+2:9);
    PF_subsequent_days_comparison = PF_location_WT(PF_ID_F01(i),1:9);
    PF_subsequent_days_comparison(10) = m;

    % PF location comparison, F02-F07
    PF_subsequent_days = PF_location_diff_30_NaN_2(PF_subsequent_days);

    % determine the day that PF becomes inconsistent
    NaN_indices = find(isnan(PF_subsequent_days(2:numel(PF_subsequent_days))))+1;
    if ~isempty(NaN_indices)
       first_NaN_index = NaN_indices(1);
       Last_consistent_day = first_NaN_index-1+m-1;
    else
       Last_consistent_day = 7;
    end
    PF_subsequent_days_comparison(11) = Last_consistent_day;
    PF_subsequent_days_comparison(12) = PF_ID_F01(i);

    PF_location_WT_track_7_days = [PF_location_WT_track_7_days;PF_subsequent_days_comparison];
end

% organize day-1-appearing PCs in the order of the day on which they lose consistency
PF_location_WT_track_7_days = sortrows(PF_location_WT_track_7_days,[10,11,1,2]);

% PFs that appear on F02
j = 2;
PF_ID_F02 = [];

for i = 1:size(PF_location_WT,1)
    if ~isnan(PF_location_WT(i,j+2)) &&...
       isnan(PF_location_WT(i,j+2-1))
       PF_ID_F02 = [PF_ID_F02;i];
    end
end

PF_Until_F01 = PF_location_WT_track_7_days(find(PF_location_WT_track_7_days(:,11)==j-1),12);
for i = 1:size(PF_Until_F01,1)
    if ~isnan(PF_location_WT(PF_Until_F01(i),j+2))
       PF_ID_F02 = [PF_ID_F02;PF_Until_F01(i)];
    end
end

PF_ID_F02 = sortrows(PF_ID_F02);
PF_ID_new{2} = PF_ID_F02;

% track all PFs that first appear on F02
m = 2;
for i = 1:size(PF_ID_F02,1)
    PF_subsequent_days = PF_location_WT(PF_ID_F02(i),m+2:9);
    PF_subsequent_days_comparison = PF_location_WT(PF_ID_F02(i),1:9);
    PF_subsequent_days_comparison(10) = m;

    % PF location comparison, F03-F07
    PF_subsequent_days = PF_location_diff_30_NaN_2(PF_subsequent_days);

    % determine the day that PF becomes inconsistent
    NaN_indices = find(isnan(PF_subsequent_days(2:numel(PF_subsequent_days))))+1;
    if ~isempty(NaN_indices)
       first_NaN_index = NaN_indices(1);
       Last_consistent_day = first_NaN_index-1+m-1;
    else
       Last_consistent_day = 7;
    end
    PF_subsequent_days_comparison(11) = Last_consistent_day;
    PF_subsequent_days_comparison(12) = PF_ID_F02(i);

    PF_location_WT_track_7_days = [PF_location_WT_track_7_days;PF_subsequent_days_comparison];
end

% organize day-1-appearing PCs in the order of the day on which they lose consistency
PF_location_WT_track_7_days = sortrows(PF_location_WT_track_7_days,[10,11,1,2]);


% PFs that appear on F03
j = 3;
PF_ID_F03 = [];

for i = 1:size(PF_location_WT,1)
    if ~isnan(PF_location_WT(i,j+2)) &&...
       isnan(PF_location_WT(i,j+2-1))
       PF_ID_F03 = [PF_ID_F03;i];
    end
end

PF_Until_F02 = PF_location_WT_track_7_days(find(PF_location_WT_track_7_days(:,11)==j-1),12);
for i = 1:size(PF_Until_F02,1)
    if ~isnan(PF_location_WT(PF_Until_F02(i),j+2))
       PF_ID_F03 = [PF_ID_F03;PF_Until_F02(i)];
    end
end

PF_ID_F03 = sortrows(PF_ID_F03);
PF_ID_new{3} = PF_ID_F03;

% track all PFs that first appear on F03
m = 3;
for i = 1:size(PF_ID_F03,1)
    PF_subsequent_days = PF_location_WT(PF_ID_F03(i),m+2:9);
    PF_subsequent_days_comparison = PF_location_WT(PF_ID_F03(i),1:9);
    PF_subsequent_days_comparison(10) = m;

    % PF location comparison, F04-F07
    PF_subsequent_days = PF_location_diff_30_NaN_2(PF_subsequent_days);

    % determine the day that PF becomes inconsistent
    NaN_indices = find(isnan(PF_subsequent_days(2:numel(PF_subsequent_days))))+1;
    if ~isempty(NaN_indices)
       first_NaN_index = NaN_indices(1);
       Last_consistent_day = first_NaN_index-1+m-1;
    else
       Last_consistent_day = 7;
    end
    PF_subsequent_days_comparison(11) = Last_consistent_day;
    PF_subsequent_days_comparison(12) = PF_ID_F03(i);

    PF_location_WT_track_7_days = [PF_location_WT_track_7_days;PF_subsequent_days_comparison];
end

% organize day-1-appearing PCs in the order of the day on which they lose consistency
PF_location_WT_track_7_days = sortrows(PF_location_WT_track_7_days,[10,11,1,2]);

% PFs that appear on F04
j = 4;
PF_ID_F04 = [];

for i = 1:size(PF_location_WT,1)
    if ~isnan(PF_location_WT(i,j+2)) &&...
       isnan(PF_location_WT(i,j+2-1))
       PF_ID_F04 = [PF_ID_F04;i];
    end
end

PF_Until_F03 = PF_location_WT_track_7_days(find(PF_location_WT_track_7_days(:,11)==j-1),12);
for i = 1:size(PF_Until_F03,1)
    if ~isnan(PF_location_WT(PF_Until_F03(i),j+2))
       PF_ID_F04 = [PF_ID_F04;PF_Until_F03(i)];
    end
end

PF_ID_F04 = sortrows(PF_ID_F04);
PF_ID_new{4} = PF_ID_F04;

% track all PFs that first appear on F04
m = 4;
for i = 1:size(PF_ID_F04,1)
    PF_subsequent_days = PF_location_WT(PF_ID_F04(i),m+2:9);
    PF_subsequent_days_comparison = PF_location_WT(PF_ID_F04(i),1:9);
    PF_subsequent_days_comparison(10) = m;

    % PF location comparison, F05-F07
    PF_subsequent_days = PF_location_diff_30_NaN_2(PF_subsequent_days);

    % determine the day that PF becomes inconsistent
    NaN_indices = find(isnan(PF_subsequent_days(2:numel(PF_subsequent_days))))+1;
    if ~isempty(NaN_indices)
       first_NaN_index = NaN_indices(1);
       Last_consistent_day = first_NaN_index-1+m-1;
    else
       Last_consistent_day = 7;
    end
    PF_subsequent_days_comparison(11) = Last_consistent_day;
    PF_subsequent_days_comparison(12) = PF_ID_F04(i);

    PF_location_WT_track_7_days = [PF_location_WT_track_7_days;PF_subsequent_days_comparison];
end

% organize day-1-appearing PCs in the order of the day on which they lose consistency
PF_location_WT_track_7_days = sortrows(PF_location_WT_track_7_days,[10,11,1,2]);

% PFs that appear on F05
j = 5;
PF_ID_F05 = [];

for i = 1:size(PF_location_WT,1)
    if ~isnan(PF_location_WT(i,j+2)) &&...
       isnan(PF_location_WT(i,j+2-1))
       PF_ID_F05 = [PF_ID_F05;i];
    end
end

PF_Until_F04 = PF_location_WT_track_7_days(find(PF_location_WT_track_7_days(:,11)==j-1),12);
for i = 1:size(PF_Until_F04,1)
    if ~isnan(PF_location_WT(PF_Until_F04(i),j+2))
       PF_ID_F05 = [PF_ID_F05;PF_Until_F04(i)];
    end
end

PF_ID_F05 = sortrows(PF_ID_F05);
PF_ID_new{5} = PF_ID_F05;

% track all PFs that first appear on F05
m = 5;
for i = 1:size(PF_ID_F05,1)
    PF_subsequent_days = PF_location_WT(PF_ID_F05(i),m+2:9);
    PF_subsequent_days_comparison = PF_location_WT(PF_ID_F05(i),1:9);
    PF_subsequent_days_comparison(10) = m;

    % PF location comparison, F06-F07
    PF_subsequent_days = PF_location_diff_30_NaN_2(PF_subsequent_days);

    % determine the day that PF becomes inconsistent
    NaN_indices = find(isnan(PF_subsequent_days(2:numel(PF_subsequent_days))))+1;
    if ~isempty(NaN_indices)
       first_NaN_index = NaN_indices(1);
       Last_consistent_day = first_NaN_index-1+m-1;
    else
       Last_consistent_day = 7;
    end
    PF_subsequent_days_comparison(11) = Last_consistent_day;
    PF_subsequent_days_comparison(12) = PF_ID_F05(i);

    PF_location_WT_track_7_days = [PF_location_WT_track_7_days;PF_subsequent_days_comparison];
end

% organize day-1-appearing PCs in the order of the day on which they lose consistency
PF_location_WT_track_7_days = sortrows(PF_location_WT_track_7_days,[10,11,1,2]);

% PFs that appear on F06
j = 6;
PF_ID_F06 = [];

for i = 1:size(PF_location_WT,1)
    if ~isnan(PF_location_WT(i,j+2)) &&...
       isnan(PF_location_WT(i,j+2-1))
       PF_ID_F06 = [PF_ID_F06;i];
    end
end

PF_Until_F05 = PF_location_WT_track_7_days(find(PF_location_WT_track_7_days(:,11)==j-1),12);
for i = 1:size(PF_Until_F05,1)
    if ~isnan(PF_location_WT(PF_Until_F05(i),j+2))
       PF_ID_F06 = [PF_ID_F06;PF_Until_F05(i)];
    end
end

PF_ID_F06 = sortrows(PF_ID_F06);
PF_ID_new{6} = PF_ID_F06;

% track all PFs that first appear on F06
m = 6;
for i = 1:size(PF_ID_F06,1)
    PF_subsequent_days = PF_location_WT(PF_ID_F06(i),m+2:9);
    PF_subsequent_days_comparison = PF_location_WT(PF_ID_F06(i),1:9);
    PF_subsequent_days_comparison(10) = m;

    % PF location comparison, F07
    PF_subsequent_days = PF_location_diff_30_NaN_2(PF_subsequent_days);

    % determine the day that PF becomes inconsistent
    NaN_indices = find(isnan(PF_subsequent_days(2:numel(PF_subsequent_days))))+1;
    if ~isempty(NaN_indices)
       first_NaN_index = NaN_indices(1);
       Last_consistent_day = first_NaN_index-1+m-1;
    else
       Last_consistent_day = 7;
    end
    PF_subsequent_days_comparison(11) = Last_consistent_day;
    PF_subsequent_days_comparison(12) = PF_ID_F06(i);

    PF_location_WT_track_7_days = [PF_location_WT_track_7_days;PF_subsequent_days_comparison];
end

% organize day-1-appearing PCs in the order of the day on which they lose consistency
PF_location_WT_track_7_days = sortrows(PF_location_WT_track_7_days,[10,11,1,2]);

% PFs that appear on F07
j = 7;
PF_ID_F07 = [];

for i = 1:size(PF_location_WT,1)
    if ~isnan(PF_location_WT(i,j+2)) &&...
       isnan(PF_location_WT(i,j+2-1))
       PF_ID_F07 = [PF_ID_F07;i];
    end
end

PF_Until_F06 = PF_location_WT_track_7_days(find(PF_location_WT_track_7_days(:,11)==j-1),12);
for i = 1:size(PF_Until_F06,1)
    if ~isnan(PF_location_WT(PF_Until_F06(i),j+2))
       PF_ID_F07 = [PF_ID_F07;PF_Until_F06(i)];
    end
end

PF_ID_F07 = sortrows(PF_ID_F07);
PF_ID_new{7} = PF_ID_F07;

% track all PFs that first appear on F07
for i = 1:size(PF_ID_F07,1)
    PF_subsequent_days_comparison = PF_location_WT(PF_ID_F07(i),1:9);
    PF_subsequent_days_comparison(10) = 7;
    PF_subsequent_days_comparison(11) = 7;
    PF_subsequent_days_comparison(12) = PF_ID_F07(i);
    PF_location_WT_track_7_days = [PF_location_WT_track_7_days;PF_subsequent_days_comparison];
end

% organize day-1-appearing PCs in the order of the day on which they lose consistency
PF_location_WT_track_7_days = sortrows(PF_location_WT_track_7_days,[10,11,1,2]);

% plot PF dynamics across 7 days
PF_consistent_days = {};

for i = 1:7
    PF_first_appear_indices = find(PF_location_WT_track_7_days(:,10)==i);
    PF_consistent_days{i} = PF_location_WT_track_7_days(PF_first_appear_indices,11);
end

PF_decay_7_days_WT = nan(7,7);

for i = 1:7
    for m = i:7
        PF_decay_7_days_WT(i,m) = sum(arrayfun(@(x) sum(PF_consistent_days{i} == x), m:7));
    end
end

% track PF dynamics using cell index (not cumulative)
PF_decay_7_days_WT_index = {};
for i = 1:7
    for m = i:7
        cell_row_indices = find(PF_location_WT_track_7_days(:,10)==i & PF_location_WT_track_7_days(:,11)==m);
        PF_decay_7_days_WT_index{i,m} = PF_location_WT_track_7_days(cell_row_indices,12);
    end
end

%%
% fit PFs that first appear on F01
t_F01 = [0 1 2 3 4 5 6]';
y_F01 = PF_decay_7_days_WT(1,1:7)';

[fitResult_F01_WT,gof] = fit(t_F01,y_F01,'exp2');
disp(fitResult_F01_WT);

% Extract amplitudes (A) and time constants (tau)
disp('WT fitResult_F01: ');
A1 = fitResult_F01_WT.a  % Amplitude 1
A2 = fitResult_F01_WT.c  % Amplitude 2
tau1 = -1 / fitResult_F01_WT.b  % Time constant 1
tau2 = -1 / fitResult_F01_WT.d  % Time constant 2

figure;
plot(t_F01, y_F01, 'ro');  % Plot data points
hold on;
plot(fitResult_F01_WT, 'b-');  % Plot fitted curve
xlabel('Time (day)');
ylabel('PC#');
title('Double Exponential Decay Fit');
legend('Data', 'Fitted Curve');
grid on;
hold off;

rsquare = gof.rsquare

% plot fast and slow components separately
t1 = linspace(1,7,1001);
t = t1-1;
y1 = A1*exp(-t/tau1);
y2 = A2*exp(-t/tau2);
figure;
hold on;
h1 = plot(t1,y1,'-','LineWidth',2,'Color','blue');
h2 = plot(t1,y2,'-','LineWidth',2,'Color','red');
xlim([0.8 7]);
ylim([0 900]);
xlabel('Days');
ylabel('Number of PCs');
title('WT, Day-1-appearing PCs');
set(gca, 'FontSize', 14);
legend([h1 h2],'Fast component','Slow component','FontSize',14);
hold off;

%%
% fit PFs that first appear on F02
t_F02 = [0 1 2 3 4 5]';
y_F02 = PF_decay_7_days_WT(2,2:7)';

[fitResult_F02_WT,gof] = fit(t_F02,y_F02,'exp2');
disp(fitResult_F02_WT);

% Extract amplitudes (A) and time constants (tau)
disp('WT fitResult_F02: ');
A1 = fitResult_F02_WT.a  % Amplitude 1
A2 = fitResult_F02_WT.c  % Amplitude 2
tau1 = -1 / fitResult_F02_WT.b  % Time constant 1
tau2 = -1 / fitResult_F02_WT.d  % Time constant 2

figure;
plot(t_F02, y_F02, 'ro');  % Plot data points
hold on;
plot(fitResult_F02_WT, 'b-');  % Plot fitted curve
xlabel('Time (day)');
ylabel('PC#');
title('Double Exponential Decay Fit');
legend('Data', 'Fitted Curve');
grid on;
hold off;

rsquare = gof.rsquare

% plot sustained and transient PCs separately
t2 = linspace(2,7,1001);
t = t2-2;
y1 = A1*exp(-t/tau1);
y2 = A2*exp(-t/tau2);
figure;
hold on;
h1 = plot(t2,y1,'-','LineWidth',2,'Color','blue');
h2 = plot(t2,y2,'-','LineWidth',2,'Color','red');
xlim([0.8 7]);
ylim([0 350]);
xlabel('Days');
ylabel('Number of PCs');
title('WT, Day-2-appearing PCs');
set(gca, 'FontSize', 14);
legend([h1 h2],'Fast component','Slow component','FontSize',14);
hold off;

%%
% plot PF dynamics, WT
figure;
hold on;

% F01
k = 1;
plot(PF_decay_7_days_WT(k,:),'o','LineWidth',2,'Color','red','MarkerSize',8,'MarkerEdgeColor',...
     'red','MarkerFaceColor','red');
custom_t = linspace(1,7,1001);
custom_y = fitResult_F01_WT(custom_t-1);
plot(custom_t,custom_y,'LineWidth',2,'Color','red');

% F02
k = 2;
plot(PF_decay_7_days_WT(k,:),'o','LineWidth',2,'Color','black','MarkerSize',8,'MarkerEdgeColor',...
     'black','MarkerFaceColor','black');
custom_t = linspace(2,7,1001);
custom_y = fitResult_F02_WT(custom_t-2);
plot(custom_t,custom_y,'LineWidth',2,'Color','black');

% F03
k = 3;
plot(PF_decay_7_days_WT(k,:),'-o','Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue','LineWidth',2);

% F04
k = 4;
plot(PF_decay_7_days_WT(k,:),'-o','LineWidth',2,'Color','green','MarkerSize',8,'MarkerEdgeColor',...
     'green','MarkerFaceColor','green');

% F05
k = 5;
plot(PF_decay_7_days_WT(k,:),'-o','LineWidth',2,'Color','magenta','MarkerSize',8,'MarkerEdgeColor',...
     'magenta','MarkerFaceColor','magenta');

% F06
k = 6;
plot(PF_decay_7_days_WT(k,:),'-o','LineWidth',2,'Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue');

% F07
k = 7;
plot(PF_decay_7_days_WT(k,:),'-o','LineWidth',2,'Color','green','MarkerSize',8,'MarkerEdgeColor',...
     'green','MarkerFaceColor','green');

xlim([0.8 7+0.2]);
xticks(1:7);
xlabel('Time (Day)');
ylabel('Number of PCs');
%title('WT','FontSize', 14);
set(gca, 'FontSize', 14);
hold off;
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

%%

% PF_decay_7_days normalized to the PC number on Day 1
PF_decay_7_days_WT_norm = PF_decay_7_days_WT./PF_decay_7_days_WT(1,1);

% plot normalized PF dynamics, WT
figure;
hold on;

% F01
k = 1;
plot(PF_decay_7_days_WT_norm(k,:),'o','LineWidth',2,'Color','red','MarkerSize',8,'MarkerEdgeColor',...
     'red','MarkerFaceColor','red');
custom_t = linspace(1,7,1001);
custom_y = fitResult_F01_WT(custom_t-1);
plot(custom_t,custom_y./PF_decay_7_days_WT(1,1),'LineWidth',2,'Color','red');

% F02
k = 2;
plot(PF_decay_7_days_WT_norm(k,:),'o','LineWidth',2,'Color','black','MarkerSize',8,'MarkerEdgeColor',...
     'black','MarkerFaceColor','black');
custom_t = linspace(2,7,1001);
custom_y = fitResult_F02_WT(custom_t-2);
plot(custom_t,custom_y./PF_decay_7_days_WT(1,1),'LineWidth',2,'Color','black');

% F03
k = 3;
plot(PF_decay_7_days_WT_norm(k,:),'-o','Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue','LineWidth',2);

% F04
k = 4;
plot(PF_decay_7_days_WT_norm(k,:),'-o','LineWidth',2,'Color','green','MarkerSize',8,'MarkerEdgeColor',...
     'green','MarkerFaceColor','green');

% F05
k = 5;
plot(PF_decay_7_days_WT_norm(k,:),'-o','LineWidth',2,'Color','magenta','MarkerSize',8,'MarkerEdgeColor',...
     'magenta','MarkerFaceColor','magenta');

% F06
k = 6;
plot(PF_decay_7_days_WT_norm(k,:),'-o','LineWidth',2,'Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue');

% F07
k = 7;
plot(PF_decay_7_days_WT_norm(k,:),'-o','LineWidth',2,'Color','green','MarkerSize',8,'MarkerEdgeColor',...
     'green','MarkerFaceColor','green');

xlim([0.8 7]);
xlabel('Days');
ylabel('Normalized number of PCs');
title('WT','FontSize', 14);
set(gca, 'FontSize', 14);
hold off;
%%
% total, past, and new PFs
total_PF_WT = [];
past_PF_WT = [];
new_PF_WT = [];
for i = 1:7
    total_PF_WT(i) = sum(PF_decay_7_days_WT(:,i),'omitmissing');
    past_PF_WT(i) = sum(PF_decay_7_days_WT(1:i-1,i),'omitmissing');
    new_PF_WT(i) = PF_decay_7_days_WT(i,i);
end

figure;
hold on;
h1 = plot(total_PF_WT,'-o','LineWidth',2,'Color','black','MarkerSize',8,'MarkerEdgeColor',...
     'black','MarkerFaceColor','black');
h2 = plot(past_PF_WT,'-o','LineWidth',2,'Color','red','MarkerSize',8,'MarkerEdgeColor',...
     'red','MarkerFaceColor','red');
h3 = plot(new_PF_WT,'-o','LineWidth',2,'Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue');

ylim([0 1100]);
legend([h1 h2 h3],'total PCs','past PCs','new PCs','FontSize',14,'location','southeast');
hold off;
xlim([0.8 7+0.2]);
xticks(1:7);
xlabel('Time (Day)');
ylabel('Number of PCs');
%title('WT','FontSize', 14);
hold off;
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

%%
% normalized total, past, and new PFs
total_PF_norm_WT = [];
past_PF_norm_WT = [];
new_PF_norm_WT = [];
for i = 1:7
    total_PF_norm_WT(i) = total_PF_WT(i)/total_PF_WT(i);
    past_PF_norm_WT(i) = past_PF_WT(i)/total_PF_WT(i);
    new_PF_norm_WT(i) = new_PF_WT(i)/total_PF_WT(i);
end

past_over_new_PF_WT = past_PF_WT./new_PF_WT;

figure;
hold on;
h1 = plot(total_PF_norm_WT,'-o','LineWidth',2,'Color','black','MarkerSize',8,'MarkerEdgeColor',...
     'black','MarkerFaceColor','black');
h2 = plot(past_PF_norm_WT,'-o','LineWidth',2,'Color','red','MarkerSize',8,'MarkerEdgeColor',...
     'red','MarkerFaceColor','red');
h3 = plot(new_PF_norm_WT,'-o','LineWidth',2,'Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue');
xlim([0.8 7]);
xlabel('Days');
ylabel('Normalized number of PCs');
title('WT');
set(gca, 'FontSize', 14);
legend([h1 h2 h3],'total PCs','past PCs','new PCs','FontSize',14);
hold off;


figure;
plot(past_over_new_PF_WT,'-o','LineWidth',2,'Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue');
xlim([0.8 7]);
xlabel('Days');
title('WT, pastPCs/newPCs');
set(gca, 'FontSize', 14);

% identify sustained and trasient PCs
% consistent PF for >= 3 sessions, sustained PCs
% consistent PF for < 3 sessions, transient PCs
% row 1 of the cell array: sust./trans PCs appearing on a given day
% row 2 of the cell array: cumulative sust./trans PCs on a given day

sustained_PC_7_days_WT = {};
transient_PC_7_days_WT = {};

% F01
sustained_PC_F01_appear = [];
transient_PC_F01_appear = [];
for i = 1:size(PF_location_WT_track_7_days,1)
    if PF_location_WT_track_7_days(i,10) == 1
       if PF_location_WT_track_7_days(i,11) >= 3
          sustained_PC_F01_appear = [sustained_PC_F01_appear;PF_location_WT_track_7_days(i,12)];
       else
          transient_PC_F01_appear = [transient_PC_F01_appear;PF_location_WT_track_7_days(i,12)];
       end
    end
end
sustained_PC_7_days_WT{1,1} = sustained_PC_F01_appear;
sustained_PC_7_days_WT{2,1} = sustained_PC_F01_appear;
transient_PC_7_days_WT{1,1} = transient_PC_F01_appear;

% F02
sustained_PC_F02_appear = [];
transient_PC_F02_appear = [];
for i = 1:size(PF_location_WT_track_7_days,1)
    if PF_location_WT_track_7_days(i,10) == 2
       if PF_location_WT_track_7_days(i,11) >= 4
          sustained_PC_F02_appear = [sustained_PC_F02_appear;PF_location_WT_track_7_days(i,12)];
       else
          transient_PC_F02_appear = [transient_PC_F02_appear;PF_location_WT_track_7_days(i,12)];
       end
    end
end
sustained_PC_F02 = [sustained_PC_F02_appear;sustained_PC_F01_appear];

sustained_PC_7_days_WT{1,2} = sustained_PC_F02_appear;
sustained_PC_7_days_WT{2,2} = sustained_PC_F02;
transient_PC_7_days_WT{1,2} = transient_PC_F02_appear;

% F03
sustained_PC_F03_appear = [];
transient_PC_F03_appear = [];
for i = 1:size(PF_location_WT_track_7_days,1)
    if PF_location_WT_track_7_days(i,10) == 3
       if PF_location_WT_track_7_days(i,11) >= 5
          sustained_PC_F03_appear = [sustained_PC_F03_appear;PF_location_WT_track_7_days(i,12)];
       else
          transient_PC_F03_appear = [transient_PC_F03_appear;PF_location_WT_track_7_days(i,12)];
       end
    end
end
sustained_PC_F03 = [sustained_PC_F03_appear;sustained_PC_F02_appear;...
    sustained_PC_F01_appear];
sustained_PC_7_days_WT{1,3} = sustained_PC_F03_appear;
sustained_PC_7_days_WT{2,3} = sustained_PC_F03;
transient_PC_7_days_WT{1,3} = transient_PC_F03_appear;

% F04
sustained_PC_F04_appear = [];
transient_PC_F04_appear = [];
for i = 1:size(PF_location_WT_track_7_days,1)
    if PF_location_WT_track_7_days(i,10) == 4
       if PF_location_WT_track_7_days(i,11) >= 6
          sustained_PC_F04_appear = [sustained_PC_F04_appear;PF_location_WT_track_7_days(i,12)];
       else
          transient_PC_F04_appear = [transient_PC_F04_appear;PF_location_WT_track_7_days(i,12)];
       end
    end
end

sustained_PC_F01_beyond_F03 = [];
for i = 1:size(PF_location_WT_track_7_days,1)
    if PF_location_WT_track_7_days(i,10) == 1 &&...
            PF_location_WT_track_7_days(i,11) >= 4
        sustained_PC_F01_beyond_F03 = [sustained_PC_F01_beyond_F03;PF_location_WT_track_7_days(i,12)];
    end
end

sustained_PC_F04 = [sustained_PC_F04_appear;...
    sustained_PC_F03_appear;...
    sustained_PC_F02_appear;...
    sustained_PC_F01_beyond_F03];
sustained_PC_7_days_WT{1,4} = sustained_PC_F04_appear;
sustained_PC_7_days_WT{2,4} = sustained_PC_F04;
transient_PC_7_days_WT{1,4} = transient_PC_F04_appear;

% F05
sustained_PC_F05_appear = [];
transient_PC_F05_appear = [];
for i = 1:size(PF_location_WT_track_7_days,1)
    if PF_location_WT_track_7_days(i,10) == 5
       if PF_location_WT_track_7_days(i,11) >= 7
          sustained_PC_F05_appear = [sustained_PC_F05_appear;PF_location_WT_track_7_days(i,12)];
       else
          transient_PC_F05_appear = [transient_PC_F05_appear;PF_location_WT_track_7_days(i,12)];
       end
    end
end

sustained_PC_F01_beyond_F04 = [];
for i = 1:size(PF_location_WT_track_7_days,1)
    if PF_location_WT_track_7_days(i,10) == 1 &&...
            PF_location_WT_track_7_days(i,11) >= 5
        sustained_PC_F01_beyond_F04 = [sustained_PC_F01_beyond_F04;PF_location_WT_track_7_days(i,12)];
    end
end

sustained_PC_F02_beyond_F04 = [];
for i = 1:size(PF_location_WT_track_7_days,1)
    if PF_location_WT_track_7_days(i,10) == 2 &&...
            PF_location_WT_track_7_days(i,11) >= 5
        sustained_PC_F02_beyond_F04 = [sustained_PC_F02_beyond_F04;PF_location_WT_track_7_days(i,12)];
    end
end

sustained_PC_F05 = [sustained_PC_F05_appear;...
    sustained_PC_F04_appear;...
    sustained_PC_F03_appear;...
    sustained_PC_F02_beyond_F04;...
    sustained_PC_F01_beyond_F04];
sustained_PC_7_days_WT{1,5} = sustained_PC_F05_appear;
sustained_PC_7_days_WT{2,5} = sustained_PC_F05;
transient_PC_7_days_WT{1,5} = transient_PC_F05_appear;

% F06, not consider sustained PCs appearing on F06
sustained_PC_F06 = [];
transient_PC_F06_appear = [];
transient_PC_F06 = [];

for i = 1:size(PF_location_WT_track_7_days,1)

    if PF_location_WT_track_7_days(i,11) == 6 &&...
        PF_location_WT_track_7_days(i,10) <= 4 
       sustained_PC_F06 = [sustained_PC_F06;PF_location_WT_track_7_days(i,12)];
    end
    if PF_location_WT_track_7_days(i,11) == 7 &&...
        PF_location_WT_track_7_days(i,10) <= 5 
       sustained_PC_F06 = [sustained_PC_F06;PF_location_WT_track_7_days(i,12)];
    end

    if PF_location_WT_track_7_days(i,10) == 6 &&...
        PF_location_WT_track_7_days(i,11) == 6 
       transient_PC_F06_appear = [transient_PC_F06_appear;PF_location_WT_track_7_days(i,12)];
    end
    if PF_location_WT_track_7_days(i,11) == 6 &&...
        PF_location_WT_track_7_days(i,10) == 5 
       transient_PC_F06 = [transient_PC_F06;PF_location_WT_track_7_days(i,12)];
    end
end
sustained_PC_7_days_WT{1,6} = NaN;
sustained_PC_7_days_WT{2,6} = sustained_PC_F06;
transient_PC_7_days_WT{1,6} = transient_PC_F06_appear;
transient_PC_F06 = [transient_PC_F06;transient_PC_F06_appear];
transient_PC_7_days_WT{2,6} = transient_PC_F06;

% F07, not consider sustained PCs appearing on F07
sustained_PC_F07 = [];
for i = 1:size(PF_location_WT_track_7_days,1)
    if PF_location_WT_track_7_days(i,11) == 7 &&...
        PF_location_WT_track_7_days(i,10) <= 5 
       sustained_PC_F07 = [sustained_PC_F07;PF_location_WT_track_7_days(i,12)];
    end
end
sustained_PC_7_days_WT{1,7} = NaN;
sustained_PC_7_days_WT{2,7} = sustained_PC_F07;
transient_PC_7_days_WT{1,7} = NaN;
transient_PC_7_days_WT{2,7} = NaN;


% transient PCs, fraction of sustained PCs
sustained_PC_5_days_number_WT = [];
sustained_PC_5_days_fraction_WT = [];
AllPCs_WT = {};
for i = 1:5
    AllPCs_WT{i} = find(~isnan(PF_location_WT(:,i+2)));
    transient_PC_7_days_WT{2,i} = setdiff(AllPCs_WT{i},sustained_PC_7_days_WT{2,i});
    sustained_PC_5_days_fraction_WT(i) = numel(sustained_PC_7_days_WT{2,i})/numel(AllPCs_WT{i});
    sustained_PC_5_days_number_WT(i) = numel(sustained_PC_7_days_WT{2,i});
end

%%
% plot the number of sustained PCs and total PCs to show the accumulation of sustained PCs
figure;
hold on;
x = 1:5;
h1 = plot(total_PF_WT(1:5),'-o','LineWidth',2,'Color','black','MarkerSize',8,'MarkerEdgeColor',...
     'black','MarkerFaceColor','black');
h2 = plot(sustained_PC_5_days_number_WT,'-o','LineWidth',2,'Color','red','MarkerSize',8,'MarkerEdgeColor',...
     'red','MarkerFaceColor','red');

fill([x fliplr(x)], [zeros(size(sustained_PC_5_days_number_WT)) fliplr(sustained_PC_5_days_number_WT)], 'r', ...
     'FaceAlpha',0.2, 'EdgeColor','none');
fill([x fliplr(x)], [sustained_PC_5_days_number_WT fliplr(total_PF_WT(1:5))], 'b', ...
     'FaceAlpha',0.2, 'EdgeColor','none');

ylim([0 1100]);
legend([h1 h2],'total PCs','sustained PCs','FontSize',14,'location','southeast');
hold off;
xlim([0.8 5+0.2]);
xticks(1:7);
xlabel('Time (Day)');
ylabel('Number of PCs');
%title('WT','FontSize', 14);
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');
hold off;

%%
% plot the fraction of sustained cells
figure;
hold on;
h1 = plot(sustained_PC_5_days_fraction_WT,'-o','LineWidth',2,'Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue');
xlim([0.8 5]);
ylim([0 1]);
xlabel('Days');
xticks([1 2 3 4 5]);
% ylabel('Fraction of total PCs');
title('Fraction of sustained PCs, WT','FontSize', 14);
set(gca, 'FontSize', 14);
hold off;

%%
% fit PFs that first appear on F01, normalized to F01
t_F01 = [0 1 2 3 4 5 6]';
y_F01_norm_WT = PF_decay_7_days_WT(1,1:7)'/PF_decay_7_days_WT(1,1);

[fitResult_F01_norm_WT,gof] = fit(t_F01,y_F01_norm_WT,'exp2');
disp(fitResult_F01_norm_WT);

% Extract amplitudes (A) and time constants (tau)
disp('fitResult_F01_norm_WT: ');
A1 = fitResult_F01_norm_WT.a  % Amplitude 1
A2 = fitResult_F01_norm_WT.c  % Amplitude 2
tau1 = -1 / fitResult_F01_norm_WT.b  % Time constant 1
tau2 = -1 / fitResult_F01_norm_WT.d  % Time constant 2

figure;
plot(t_F01, y_F01_norm_WT,'o','LineWidth',2,'Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue');  % Plot data points
hold on;
plot(fitResult_F01_norm_WT, 'b-');  % Plot fitted curve
xlabel('Time (days)');
ylabel('PC#');
title('Double Exponential Decay Fit');
legend('Data', 'Fitted Curve');
grid on;
hold off;

rsquare = gof.rsquare

% fit PFs that first appear on F02, normalized to F02
t_F02 = [0 1 2 3 4 5]';
y_F02_norm_WT = PF_decay_7_days_WT(2,2:7)'/PF_decay_7_days_WT(2,2);

[fitResult_F02_norm_WT,gof] = fit(t_F02,y_F02_norm_WT,'exp2');
disp(fitResult_F02_norm_WT);

% Extract amplitudes (A) and time constants (tau)
disp('fitResult_F02_norm_WT: ');
A1 = fitResult_F02_norm_WT.a  % Amplitude 1
A2 = fitResult_F02_norm_WT.c  % Amplitude 2
tau1 = -1 / fitResult_F02_norm_WT.b  % Time constant 1
tau2 = -1 / fitResult_F02_norm_WT.d  % Time constant 2

figure;
plot(t_F02, y_F02_norm_WT, 'o','LineWidth',2,'Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue');  % Plot data points
hold on;
plot(fitResult_F02_norm_WT, 'b-');  % Plot fitted curve
xlabel('Time (days)');
ylabel('PC#');
title('Double Exponential Decay Fit');
legend('Data', 'Fitted Curve');
grid on;
hold off;

rsquare = gof.rsquare
