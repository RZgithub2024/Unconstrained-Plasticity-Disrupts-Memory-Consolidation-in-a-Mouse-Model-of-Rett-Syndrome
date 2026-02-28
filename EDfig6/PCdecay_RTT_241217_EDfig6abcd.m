% have PF_location loaded

% RTT
PF_location_RTT_track_7_days = [];
PF_ID_new = {};

% PFs that appear on F01
PF_ID_F01 = find(~isnan(PF_location_RTT(:,3)));
PF_ID_new{1} = PF_ID_F01;

% track all PFs that first appear on F01
m = 1;
for i = 1:size(PF_ID_F01,1)
    PF_subsequent_days = PF_location_RTT(PF_ID_F01(i),m+2:9);
    PF_subsequent_days_comparison = PF_location_RTT(PF_ID_F01(i),1:9);
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

    PF_location_RTT_track_7_days = [PF_location_RTT_track_7_days;PF_subsequent_days_comparison];
end

% organize day-1-appearing PCs in the order of the day on which they lose consistency
PF_location_RTT_track_7_days = sortrows(PF_location_RTT_track_7_days,[10,11,1,2]);

% PFs that appear on F02
j = 2;
PF_ID_F02 = [];

for i = 1:size(PF_location_RTT,1)
    if ~isnan(PF_location_RTT(i,j+2)) &&...
       isnan(PF_location_RTT(i,j+2-1))
       PF_ID_F02 = [PF_ID_F02;i];
    end
end

PF_Until_F01 = PF_location_RTT_track_7_days(find(PF_location_RTT_track_7_days(:,11)==j-1),12);
for i = 1:size(PF_Until_F01,1)
    if ~isnan(PF_location_RTT(PF_Until_F01(i),j+2))
       PF_ID_F02 = [PF_ID_F02;PF_Until_F01(i)];
    end
end

PF_ID_F02 = sortrows(PF_ID_F02);
PF_ID_new{2} = PF_ID_F02;

% track all PFs that first appear on F02
m = 2;
for i = 1:size(PF_ID_F02,1)
    PF_subsequent_days = PF_location_RTT(PF_ID_F02(i),m+2:9);
    PF_subsequent_days_comparison = PF_location_RTT(PF_ID_F02(i),1:9);
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

    PF_location_RTT_track_7_days = [PF_location_RTT_track_7_days;PF_subsequent_days_comparison];
end

% organize day-1-appearing PCs in the order of the day on which they lose consistency
PF_location_RTT_track_7_days = sortrows(PF_location_RTT_track_7_days,[10,11,1,2]);


% PFs that appear on F03
j = 3;
PF_ID_F03 = [];

for i = 1:size(PF_location_RTT,1)
    if ~isnan(PF_location_RTT(i,j+2)) &&...
       isnan(PF_location_RTT(i,j+2-1))
       PF_ID_F03 = [PF_ID_F03;i];
    end
end

PF_Until_F02 = PF_location_RTT_track_7_days(find(PF_location_RTT_track_7_days(:,11)==j-1),12);
for i = 1:size(PF_Until_F02,1)
    if ~isnan(PF_location_RTT(PF_Until_F02(i),j+2))
       PF_ID_F03 = [PF_ID_F03;PF_Until_F02(i)];
    end
end

PF_ID_F03 = sortrows(PF_ID_F03);
PF_ID_new{3} = PF_ID_F03;

% track all PFs that first appear on F03
m = 3;
for i = 1:size(PF_ID_F03,1)
    PF_subsequent_days = PF_location_RTT(PF_ID_F03(i),m+2:9);
    PF_subsequent_days_comparison = PF_location_RTT(PF_ID_F03(i),1:9);
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

    PF_location_RTT_track_7_days = [PF_location_RTT_track_7_days;PF_subsequent_days_comparison];
end

% organize day-1-appearing PCs in the order of the day on which they lose consistency
PF_location_RTT_track_7_days = sortrows(PF_location_RTT_track_7_days,[10,11,1,2]);

% PFs that appear on F04
j = 4;
PF_ID_F04 = [];

for i = 1:size(PF_location_RTT,1)
    if ~isnan(PF_location_RTT(i,j+2)) &&...
       isnan(PF_location_RTT(i,j+2-1))
       PF_ID_F04 = [PF_ID_F04;i];
    end
end

PF_Until_F03 = PF_location_RTT_track_7_days(find(PF_location_RTT_track_7_days(:,11)==j-1),12);
for i = 1:size(PF_Until_F03,1)
    if ~isnan(PF_location_RTT(PF_Until_F03(i),j+2))
       PF_ID_F04 = [PF_ID_F04;PF_Until_F03(i)];
    end
end

PF_ID_F04 = sortrows(PF_ID_F04);
PF_ID_new{4} = PF_ID_F04;

% track all PFs that first appear on F04
m = 4;
for i = 1:size(PF_ID_F04,1)
    PF_subsequent_days = PF_location_RTT(PF_ID_F04(i),m+2:9);
    PF_subsequent_days_comparison = PF_location_RTT(PF_ID_F04(i),1:9);
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

    PF_location_RTT_track_7_days = [PF_location_RTT_track_7_days;PF_subsequent_days_comparison];
end

% organize day-1-appearing PCs in the order of the day on which they lose consistency
PF_location_RTT_track_7_days = sortrows(PF_location_RTT_track_7_days,[10,11,1,2]);

% PFs that appear on F05
j = 5;
PF_ID_F05 = [];

for i = 1:size(PF_location_RTT,1)
    if ~isnan(PF_location_RTT(i,j+2)) &&...
       isnan(PF_location_RTT(i,j+2-1))
       PF_ID_F05 = [PF_ID_F05;i];
    end
end

PF_Until_F04 = PF_location_RTT_track_7_days(find(PF_location_RTT_track_7_days(:,11)==j-1),12);
for i = 1:size(PF_Until_F04,1)
    if ~isnan(PF_location_RTT(PF_Until_F04(i),j+2))
       PF_ID_F05 = [PF_ID_F05;PF_Until_F04(i)];
    end
end

PF_ID_F05 = sortrows(PF_ID_F05);
PF_ID_new{5} = PF_ID_F05;

% track all PFs that first appear on F05
m = 5;
for i = 1:size(PF_ID_F05,1)
    PF_subsequent_days = PF_location_RTT(PF_ID_F05(i),m+2:9);
    PF_subsequent_days_comparison = PF_location_RTT(PF_ID_F05(i),1:9);
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

    PF_location_RTT_track_7_days = [PF_location_RTT_track_7_days;PF_subsequent_days_comparison];
end

% organize day-1-appearing PCs in the order of the day on which they lose consistency
PF_location_RTT_track_7_days = sortrows(PF_location_RTT_track_7_days,[10,11,1,2]);

% PFs that appear on F06
j = 6;
PF_ID_F06 = [];

for i = 1:size(PF_location_RTT,1)
    if ~isnan(PF_location_RTT(i,j+2)) &&...
       isnan(PF_location_RTT(i,j+2-1))
       PF_ID_F06 = [PF_ID_F06;i];
    end
end

PF_Until_F05 = PF_location_RTT_track_7_days(find(PF_location_RTT_track_7_days(:,11)==j-1),12);
for i = 1:size(PF_Until_F05,1)
    if ~isnan(PF_location_RTT(PF_Until_F05(i),j+2))
       PF_ID_F06 = [PF_ID_F06;PF_Until_F05(i)];
    end
end

PF_ID_F06 = sortrows(PF_ID_F06);
PF_ID_new{6} = PF_ID_F06;

% track all PFs that first appear on F06
m = 6;
for i = 1:size(PF_ID_F06,1)
    PF_subsequent_days = PF_location_RTT(PF_ID_F06(i),m+2:9);
    PF_subsequent_days_comparison = PF_location_RTT(PF_ID_F06(i),1:9);
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

    PF_location_RTT_track_7_days = [PF_location_RTT_track_7_days;PF_subsequent_days_comparison];
end

% organize day-1-appearing PCs in the order of the day on which they lose consistency
PF_location_RTT_track_7_days = sortrows(PF_location_RTT_track_7_days,[10,11,1,2]);

% PFs that appear on F07
j = 7;
PF_ID_F07 = [];

for i = 1:size(PF_location_RTT,1)
    if ~isnan(PF_location_RTT(i,j+2)) &&...
       isnan(PF_location_RTT(i,j+2-1))
       PF_ID_F07 = [PF_ID_F07;i];
    end
end

PF_Until_F06 = PF_location_RTT_track_7_days(find(PF_location_RTT_track_7_days(:,11)==j-1),12);
for i = 1:size(PF_Until_F06,1)
    if ~isnan(PF_location_RTT(PF_Until_F06(i),j+2))
       PF_ID_F07 = [PF_ID_F07;PF_Until_F06(i)];
    end
end

PF_ID_F07 = sortrows(PF_ID_F07);
PF_ID_new{7} = PF_ID_F07;

% track all PFs that first appear on F07
for i = 1:size(PF_ID_F07,1)
    PF_subsequent_days_comparison = PF_location_RTT(PF_ID_F07(i),1:9);
    PF_subsequent_days_comparison(10) = 7;
    PF_subsequent_days_comparison(11) = 7;
    PF_subsequent_days_comparison(12) = PF_ID_F07(i);
    PF_location_RTT_track_7_days = [PF_location_RTT_track_7_days;PF_subsequent_days_comparison];
end

% organize day-1-appearing PCs in the order of the day on which they lose consistency
PF_location_RTT_track_7_days = sortrows(PF_location_RTT_track_7_days,[10,11,1,2]);

% plot PF dynamics across 7 days
PF_consistent_days = {};

for i = 1:7
    PF_first_appear_indices = find(PF_location_RTT_track_7_days(:,10)==i);
    PF_consistent_days{i} = PF_location_RTT_track_7_days(PF_first_appear_indices,11);
end

PF_decay_7_days_RTT = nan(7,7);

for i = 1:7
    for m = i:7
        PF_decay_7_days_RTT(i,m) = sum(arrayfun(@(x) sum(PF_consistent_days{i} == x), m:7));
    end
end

% track PF dynamics using cell index (not cumulative)
PF_decay_7_days_RTT_index = {};
for i = 1:7
    for m = i:7
        cell_row_indices = find(PF_location_RTT_track_7_days(:,10)==i & PF_location_RTT_track_7_days(:,11)==m);
        PF_decay_7_days_RTT_index{i,m} = PF_location_RTT_track_7_days(cell_row_indices,12);
    end
end

%%
% fit PFs that first appear on F01
t_F01 = [0 1 2 3 4 5 6]';
y_F01 = PF_decay_7_days_RTT(1,1:7)';

[fitResult_F01_RTT,gof] = fit(t_F01,y_F01,'exp2');
disp(fitResult_F01_RTT);

% Extract amplitudes (A) and time constants (tau)
disp('RTT fitResult_F01: ');
A1 = fitResult_F01_RTT.a  % Amplitude 1
A2 = fitResult_F01_RTT.c  % Amplitude 2
tau1 = -1 / fitResult_F01_RTT.b  % Time constant 1
tau2 = -1 / fitResult_F01_RTT.d  % Time constant 2

figure;
plot(t_F01, y_F01, 'ro');  % Plot data points
hold on;
plot(fitResult_F01_RTT, 'b-');  % Plot fitted curve
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
title('RTT, Day-1-appearing PCs');
set(gca, 'FontSize', 14);
legend([h1 h2],'Fast component','Slow component','FontSize',14);
hold off;

%%
% fit PFs that first appear on F02
t_F02 = [0 1 2 3 4 5]';
y_F02 = PF_decay_7_days_RTT(2,2:7)';

[fitResult_F02_RTT,gof] = fit(t_F02,y_F02,'exp2');
disp(fitResult_F02_RTT);

% Extract amplitudes (A) and time constants (tau)
disp('RTT fitResult_F02: ');
A1 = fitResult_F02_RTT.a  % Amplitude 1
A2 = fitResult_F02_RTT.c  % Amplitude 2
tau1 = -1 / fitResult_F02_RTT.b  % Time constant 1
tau2 = -1 / fitResult_F02_RTT.d  % Time constant 2

figure;
plot(t_F02, y_F02, 'ro');  % Plot data points
hold on;
plot(fitResult_F02_RTT, 'b-');  % Plot fitted curve
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
title('RTT, Day-2-appearing PCs');
set(gca, 'FontSize', 14);
legend([h1 h2],'Fast component','Slow component','FontSize',14);
hold off;

%%
% plot PF dynamics, RTT
figure;
hold on;

% F01
k = 1;
plot(PF_decay_7_days_RTT(k,:),'o','LineWidth',2,'Color','red','MarkerSize',8,'MarkerEdgeColor',...
     'red','MarkerFaceColor','red');
custom_t = linspace(1,7,1001);
custom_y = fitResult_F01_RTT(custom_t-1);
plot(custom_t,custom_y,'LineWidth',2,'Color','red');

% F02
k = 2;
plot(PF_decay_7_days_RTT(k,:),'o','LineWidth',2,'Color','black','MarkerSize',8,'MarkerEdgeColor',...
     'black','MarkerFaceColor','black');
custom_t = linspace(2,7,1001);
custom_y = fitResult_F02_RTT(custom_t-2);
plot(custom_t,custom_y,'LineWidth',2,'Color','black');

% F03
k = 3;
plot(PF_decay_7_days_RTT(k,:),'-o','Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue','LineWidth',2);

% F04
k = 4;
plot(PF_decay_7_days_RTT(k,:),'-o','LineWidth',2,'Color','green','MarkerSize',8,'MarkerEdgeColor',...
     'green','MarkerFaceColor','green');

% F05
k = 5;
plot(PF_decay_7_days_RTT(k,:),'-o','LineWidth',2,'Color','magenta','MarkerSize',8,'MarkerEdgeColor',...
     'magenta','MarkerFaceColor','magenta');

% F06
k = 6;
plot(PF_decay_7_days_RTT(k,:),'-o','LineWidth',2,'Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue');

% F07
k = 7;
plot(PF_decay_7_days_RTT(k,:),'-o','LineWidth',2,'Color','green','MarkerSize',8,'MarkerEdgeColor',...
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

% PF_decay_7_days normalized to the PC number on Day 1
PF_decay_7_days_RTT_norm = PF_decay_7_days_RTT./PF_decay_7_days_RTT(1,1);

% plot normalized PF dynamics, RTT
figure;
hold on;

% F01
k = 1;
plot(PF_decay_7_days_RTT_norm(k,:),'o','LineWidth',2,'Color','red','MarkerSize',8,'MarkerEdgeColor',...
     'red','MarkerFaceColor','red');
custom_t = linspace(1,7,1001);
custom_y = fitResult_F01_RTT(custom_t-1);
plot(custom_t,custom_y./PF_decay_7_days_RTT(1,1),'LineWidth',2,'Color','red');

% F02
k = 2;
plot(PF_decay_7_days_RTT_norm(k,:),'o','LineWidth',2,'Color','black','MarkerSize',8,'MarkerEdgeColor',...
     'black','MarkerFaceColor','black');
custom_t = linspace(2,7,1000);
custom_y = fitResult_F02_RTT(custom_t-2);
plot(custom_t,custom_y./PF_decay_7_days_RTT(1,1),'LineWidth',2,'Color','black');

% F03
k = 3;
plot(PF_decay_7_days_RTT_norm(k,:),'-o','Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue','LineWidth',2);

% F04
k = 4;
plot(PF_decay_7_days_RTT_norm(k,:),'-o','LineWidth',2,'Color','green','MarkerSize',8,'MarkerEdgeColor',...
     'green','MarkerFaceColor','green');

% F05
k = 5;
plot(PF_decay_7_days_RTT_norm(k,:),'-o','LineWidth',2,'Color','magenta','MarkerSize',8,'MarkerEdgeColor',...
     'magenta','MarkerFaceColor','magenta');

% F06
k = 6;
plot(PF_decay_7_days_RTT_norm(k,:),'-o','LineWidth',2,'Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue');

% F07
k = 7;
plot(PF_decay_7_days_RTT_norm(k,:),'-o','LineWidth',2,'Color','green','MarkerSize',8,'MarkerEdgeColor',...
     'green','MarkerFaceColor','green');

xlim([0.8 7]);
xlabel('Days');
ylabel('Normalized number of PCs');
title('RTT','FontSize', 14);
set(gca, 'FontSize', 14);
hold off;
%%
% total, past, and new PFs
total_PF_RTT = [];
past_PF_RTT = [];
new_PF_RTT = [];
for i = 1:7
    total_PF_RTT(i) = sum(PF_decay_7_days_RTT(:,i),'omitmissing');
    past_PF_RTT(i) = sum(PF_decay_7_days_RTT(1:i-1,i),'omitmissing');
    new_PF_RTT(i) = PF_decay_7_days_RTT(i,i);
end

figure;
hold on;
h1 = plot(total_PF_RTT,'-o','LineWidth',2,'Color','black','MarkerSize',8,'MarkerEdgeColor',...
     'black','MarkerFaceColor','black');
h2 = plot(past_PF_RTT,'-o','LineWidth',2,'Color','red','MarkerSize',8,'MarkerEdgeColor',...
     'red','MarkerFaceColor','red');
h3 = plot(new_PF_RTT,'-o','LineWidth',2,'Color','blue','MarkerSize',8,'MarkerEdgeColor',...
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
total_PF_norm_RTT = [];
past_PF_norm_RTT = [];
new_PF_norm_RTT = [];
for i = 1:7
    total_PF_norm_RTT(i) = total_PF_RTT(i)/total_PF_RTT(i);
    past_PF_norm_RTT(i) = past_PF_RTT(i)/total_PF_RTT(i);
    new_PF_norm_RTT(i) = new_PF_RTT(i)/total_PF_RTT(i);
end

figure;
hold on;
h1 = plot(total_PF_norm_RTT,'-o','LineWidth',2,'Color','black','MarkerSize',8,'MarkerEdgeColor',...
     'black','MarkerFaceColor','black');
h2 = plot(past_PF_norm_RTT,'-o','LineWidth',2,'Color','red','MarkerSize',8,'MarkerEdgeColor',...
     'red','MarkerFaceColor','red');
h3 = plot(new_PF_norm_RTT,'-o','LineWidth',2,'Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue');
xlim([0.8 7]);
xlabel('Days');
ylabel('Normalized number of PCs');
title('RTT');
set(gca, 'FontSize', 14);
legend([h1 h2 h3],'total PCs','past PCs','new PCs','FontSize',14);
hold off;
copygraphics(gcf);

%%
past_over_new_PF_RTT = past_PF_RTT./new_PF_RTT;
figure;
hold on;
h1 = plot(past_over_new_PF_WT,'-o','LineWidth',3,'Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue');
h2 = plot(past_over_new_PF_RTT,'-o','LineWidth',3,'Color','red','MarkerSize',8,'MarkerEdgeColor',...
     'red','MarkerFaceColor','red');
xlim([0.8 7]);
ylim([0 1.4]);
yticks(0:0.2:1.4);
xlabel('Days');
ylabel('pastPCs/newPCs');
title('pastPCs/newPCs');
xticks(1:7);
%legend([h1,h2],'WT','RTT','FontSize',14);
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');
hold off;
%%
% identify sustained and trasient PCs
% consistent PF for >= 3 sessions, sustained PCs
% consistent PF for < 3 sessions, transient PCs
% row 1 of the cell array: sust./trans PCs appearing on a given day
% row 2 of the cell array: cumulative sust./trans PCs on a given day

sustained_PC_7_days_RTT = {};
transient_PC_7_days_RTT = {};

% F01
sustained_PC_F01_appear = [];
transient_PC_F01_appear = [];
for i = 1:size(PF_location_RTT_track_7_days,1)
    if PF_location_RTT_track_7_days(i,10) == 1
       if PF_location_RTT_track_7_days(i,11) >= 3
          sustained_PC_F01_appear = [sustained_PC_F01_appear;PF_location_RTT_track_7_days(i,12)];
       else
          transient_PC_F01_appear = [transient_PC_F01_appear;PF_location_RTT_track_7_days(i,12)];
       end
    end
end
sustained_PC_7_days_RTT{1,1} = sustained_PC_F01_appear;
sustained_PC_7_days_RTT{2,1} = sustained_PC_F01_appear;
transient_PC_7_days_RTT{1,1} = transient_PC_F01_appear;

% F02
sustained_PC_F02_appear = [];
transient_PC_F02_appear = [];
for i = 1:size(PF_location_RTT_track_7_days,1)
    if PF_location_RTT_track_7_days(i,10) == 2
       if PF_location_RTT_track_7_days(i,11) >= 4
          sustained_PC_F02_appear = [sustained_PC_F02_appear;PF_location_RTT_track_7_days(i,12)];
       else
          transient_PC_F02_appear = [transient_PC_F02_appear;PF_location_RTT_track_7_days(i,12)];
       end
    end
end
sustained_PC_F02 = [sustained_PC_F02_appear;sustained_PC_F01_appear];

sustained_PC_7_days_RTT{1,2} = sustained_PC_F02_appear;
sustained_PC_7_days_RTT{2,2} = sustained_PC_F02;
transient_PC_7_days_RTT{1,2} = transient_PC_F02_appear;

% F03
sustained_PC_F03_appear = [];
transient_PC_F03_appear = [];
for i = 1:size(PF_location_RTT_track_7_days,1)
    if PF_location_RTT_track_7_days(i,10) == 3
       if PF_location_RTT_track_7_days(i,11) >= 5
          sustained_PC_F03_appear = [sustained_PC_F03_appear;PF_location_RTT_track_7_days(i,12)];
       else
          transient_PC_F03_appear = [transient_PC_F03_appear;PF_location_RTT_track_7_days(i,12)];
       end
    end
end
sustained_PC_F03 = [sustained_PC_F03_appear;sustained_PC_F02_appear;...
    sustained_PC_F01_appear];
sustained_PC_7_days_RTT{1,3} = sustained_PC_F03_appear;
sustained_PC_7_days_RTT{2,3} = sustained_PC_F03;
transient_PC_7_days_RTT{1,3} = transient_PC_F03_appear;

% F04
sustained_PC_F04_appear = [];
transient_PC_F04_appear = [];
for i = 1:size(PF_location_RTT_track_7_days,1)
    if PF_location_RTT_track_7_days(i,10) == 4
       if PF_location_RTT_track_7_days(i,11) >= 6
          sustained_PC_F04_appear = [sustained_PC_F04_appear;PF_location_RTT_track_7_days(i,12)];
       else
          transient_PC_F04_appear = [transient_PC_F04_appear;PF_location_RTT_track_7_days(i,12)];
       end
    end
end

sustained_PC_F01_beyond_F03 = [];
for i = 1:size(PF_location_RTT_track_7_days,1)
    if PF_location_RTT_track_7_days(i,10) == 1 &&...
            PF_location_RTT_track_7_days(i,11) >= 4
        sustained_PC_F01_beyond_F03 = [sustained_PC_F01_beyond_F03;PF_location_RTT_track_7_days(i,12)];
    end
end

sustained_PC_F04 = [sustained_PC_F04_appear;...
    sustained_PC_F03_appear;...
    sustained_PC_F02_appear;...
    sustained_PC_F01_beyond_F03];
sustained_PC_7_days_RTT{1,4} = sustained_PC_F04_appear;
sustained_PC_7_days_RTT{2,4} = sustained_PC_F04;
transient_PC_7_days_RTT{1,4} = transient_PC_F04_appear;

% F05
sustained_PC_F05_appear = [];
transient_PC_F05_appear = [];
for i = 1:size(PF_location_RTT_track_7_days,1)
    if PF_location_RTT_track_7_days(i,10) == 5
       if PF_location_RTT_track_7_days(i,11) >= 7
          sustained_PC_F05_appear = [sustained_PC_F05_appear;PF_location_RTT_track_7_days(i,12)];
       else
          transient_PC_F05_appear = [transient_PC_F05_appear;PF_location_RTT_track_7_days(i,12)];
       end
    end
end

sustained_PC_F01_beyond_F04 = [];
for i = 1:size(PF_location_RTT_track_7_days,1)
    if PF_location_RTT_track_7_days(i,10) == 1 &&...
            PF_location_RTT_track_7_days(i,11) >= 5
        sustained_PC_F01_beyond_F04 = [sustained_PC_F01_beyond_F04;PF_location_RTT_track_7_days(i,12)];
    end
end

sustained_PC_F02_beyond_F04 = [];
for i = 1:size(PF_location_RTT_track_7_days,1)
    if PF_location_RTT_track_7_days(i,10) == 2 &&...
            PF_location_RTT_track_7_days(i,11) >= 5
        sustained_PC_F02_beyond_F04 = [sustained_PC_F02_beyond_F04;PF_location_RTT_track_7_days(i,12)];
    end
end

sustained_PC_F05 = [sustained_PC_F05_appear;...
    sustained_PC_F04_appear;...
    sustained_PC_F03_appear;...
    sustained_PC_F02_beyond_F04;...
    sustained_PC_F01_beyond_F04];
sustained_PC_7_days_RTT{1,5} = sustained_PC_F05_appear;
sustained_PC_7_days_RTT{2,5} = sustained_PC_F05;
transient_PC_7_days_RTT{1,5} = transient_PC_F05_appear;

% F06, not consider sustained PCs appearing on F06
sustained_PC_F06 = [];
transient_PC_F06_appear = [];
transient_PC_F06 = [];

for i = 1:size(PF_location_RTT_track_7_days,1)

    if PF_location_RTT_track_7_days(i,11) == 6 &&...
        PF_location_RTT_track_7_days(i,10) <= 4 
       sustained_PC_F06 = [sustained_PC_F06;PF_location_RTT_track_7_days(i,12)];
    end
    if PF_location_RTT_track_7_days(i,11) == 7 &&...
        PF_location_RTT_track_7_days(i,10) <= 5 
       sustained_PC_F06 = [sustained_PC_F06;PF_location_RTT_track_7_days(i,12)];
    end

    if PF_location_RTT_track_7_days(i,10) == 6 &&...
        PF_location_RTT_track_7_days(i,11) == 6 
       transient_PC_F06_appear = [transient_PC_F06_appear;PF_location_RTT_track_7_days(i,12)];
    end
    if PF_location_RTT_track_7_days(i,11) == 6 &&...
        PF_location_RTT_track_7_days(i,10) == 5 
       transient_PC_F06 = [transient_PC_F06;PF_location_RTT_track_7_days(i,12)];
    end
end
sustained_PC_7_days_RTT{1,6} = NaN;
sustained_PC_7_days_RTT{2,6} = sustained_PC_F06;
transient_PC_7_days_RTT{1,6} = transient_PC_F06_appear;
transient_PC_F06 = [transient_PC_F06;transient_PC_F06_appear];
transient_PC_7_days_RTT{2,6} = transient_PC_F06;

% F07, not consider sustained PCs appearing on F07
sustained_PC_F07 = [];
for i = 1:size(PF_location_RTT_track_7_days,1)
    if PF_location_RTT_track_7_days(i,11) == 7 &&...
        PF_location_RTT_track_7_days(i,10) <= 5 
       sustained_PC_F07 = [sustained_PC_F07;PF_location_RTT_track_7_days(i,12)];
    end
end
sustained_PC_7_days_RTT{1,7} = NaN;
sustained_PC_7_days_RTT{2,7} = sustained_PC_F07;
transient_PC_7_days_RTT{1,7} = NaN;
transient_PC_7_days_RTT{2,7} = NaN;


% transient PCs, fraction of sustained PCs
sustained_PC_5_days_number_RTT = [];
sustained_PC_5_days_fraction_RTT = [];
AllPCs_RTT = {};
for i = 1:5
    AllPCs_RTT{i} = find(~isnan(PF_location_RTT(:,i+2)));
    transient_PC_7_days_RTT{2,i} = setdiff(AllPCs_RTT{i},sustained_PC_7_days_RTT{2,i});
    sustained_PC_5_days_fraction_RTT(i) = numel(sustained_PC_7_days_RTT{2,i})/numel(AllPCs_RTT{i});
    sustained_PC_5_days_number_RTT(i) = numel(sustained_PC_7_days_RTT{2,i});
end

%%
% plot the number of sustained PCs and total PCs to show the accumulation of sustained PCs
figure;
hold on;
h1 = plot(total_PF_RTT(1:5),'-o','LineWidth',2,'Color','black','MarkerSize',8,'MarkerEdgeColor',...
     'black','MarkerFaceColor','black');
h2 = plot(sustained_PC_5_days_number_RTT,'-o','LineWidth',2,'Color','red','MarkerSize',8,'MarkerEdgeColor',...
     'red','MarkerFaceColor','red');

fill([x fliplr(x)], [zeros(size(sustained_PC_5_days_number_RTT)) fliplr(sustained_PC_5_days_number_RTT)], 'r', ...
     'FaceAlpha',0.2, 'EdgeColor','none');
fill([x fliplr(x)], [sustained_PC_5_days_number_RTT fliplr(total_PF_RTT(1:5))], 'b', ...
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
figure;
hold on;
plot(sustained_PC_5_days_fraction_RTT,'-o','LineWidth',2,'Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue');
xlim([0.8 5]);
ylim([0 1]);
xlabel('Days');
% ylabel('Fraction of total PCs');
title('Fraction of sustained PCs, RTT','FontSize', 14);
set(gca, 'FontSize', 14);
hold off;

% fit PFs that first appear on F01, normalized to F01
t_F01 = [0 1 2 3 4 5 6]';
y_F01_norm_RTT = PF_decay_7_days_RTT(1,1:7)'/PF_decay_7_days_RTT(1,1);

[fitResult_F01_norm_RTT,gof] = fit(t_F01,y_F01_norm_RTT,'exp2');
disp(fitResult_F01_norm_RTT);

% Extract amplitudes (A) and time constants (tau)
disp('fitResult_F01_norm_RTT: ');
A1 = fitResult_F01_norm_RTT.a  % Amplitude 1
A2 = fitResult_F01_norm_RTT.c  % Amplitude 2
tau1 = -1 / fitResult_F01_norm_RTT.b  % Time constant 1
tau2 = -1 / fitResult_F01_norm_RTT.d  % Time constant 2

figure;
plot(t_F01, y_F01_norm_RTT,'o','LineWidth',2,'Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue');  % Plot data points
hold on;
plot(fitResult_F01_norm_RTT, 'b-');  % Plot fitted curve
xlabel('Time (days)');
ylabel('PC#');
title('Double Exponential Decay Fit');
legend('Data', 'Fitted Curve');
grid on;
hold off;

rsquare = gof.rsquare

% plot normalized decays of F01 PCs, WT and RTT
figure;
hold on;
h2 = plot(t_F01, y_F01_norm_RTT,'o','LineWidth',2,'Color','red','MarkerSize',8,'MarkerEdgeColor',...
     'red','MarkerFaceColor','red');  % Plot data points
h1 = plot(t_F01, y_F01_norm_WT,'o','LineWidth',2,'Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue');  % Plot data points
h4 = plot(fitResult_F01_norm_RTT, 'r-');  % Plot fitted curve
h3 = plot(fitResult_F01_norm_WT, 'b-');  % Plot fitted curve
xticks([0,1,2,3,4,5,6]);
xticklabels({'1','2','3','4','5','6','7'});
xlim([-0.2 6]);
ylim([0 1]);
xlabel('Days');
ylabel('PC fraction norm. to Day 1');
legend([h1 h2 h3 h4],'Data-WT','Data-RTT','Fitted Curve-WT','Fitted Curve-RTT');
grid on;
set(gca, 'FontSize', 14);
hold off;

% fit PFs that first appear on F02, normalized to F02
t_F02 = [0 1 2 3 4 5]';
y_F02_norm_RTT = PF_decay_7_days_RTT(2,2:7)'/PF_decay_7_days_RTT(2,2);

[fitResult_F02_norm_RTT,gof] = fit(t_F02,y_F02_norm_RTT,'exp2');
disp(fitResult_F02_norm_RTT);

% Extract amplitudes (A) and time constants (tau)
disp('fitResult_F02_norm_RTT: ');
A1 = fitResult_F02_norm_RTT.a  % Amplitude 1
A2 = fitResult_F02_norm_RTT.c  % Amplitude 2
tau1 = -1 / fitResult_F02_norm_RTT.b  % Time constant 1
tau2 = -1 / fitResult_F02_norm_RTT.d  % Time constant 2

figure;
plot(t_F02, y_F02_norm_RTT, 'o','LineWidth',2,'Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue');  % Plot data points
hold on;
plot(fitResult_F02_norm_RTT, 'b-');  % Plot fitted curve
xlabel('Time (days)');
ylabel('PC#');
title('Double Exponential Decay Fit');
legend('Data', 'Fitted Curve');
grid on;
hold off;

rsquare = gof.rsquare

figure;
hold on;
h1 = plot(t_F02, y_F02_norm_WT,'o','LineWidth',2,'Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue');
h2 = plot(t_F02, y_F02_norm_RTT,'o','LineWidth',2,'Color','red','MarkerSize',8,'MarkerEdgeColor',...
     'red','MarkerFaceColor','red');
h3 = plot(fitResult_F02_norm_WT, 'b-'); 
h4 = plot(fitResult_F02_norm_RTT, 'r-');
xticks([0,1,2,3,4,5]);
xticklabels({'2','3','4','5','6','7'});
xlim([-0.2 5]);
ylim([0 1]);
xlabel('Days');
ylabel('PC fraction norm. to Day 2');
legend([h1 h2 h3 h4],'Data-WT','Data-RTT','Fitted Curve-WT','Fitted Curve-RTT');
grid on;
set(gca, 'FontSize', 14);
hold off;

% PF_decay_7_days normalized to total PC number on a specific day
% WT and RTT

PF_decay_7_days_RTT_norm_today = nan(7,7);
for i = 1:7
    for j = 1:7
        if ~isnan(PF_decay_7_days_RTT(j,i))
           PF_decay_7_days_RTT_norm_today(j,i) = PF_decay_7_days_RTT(j,i)/sum(PF_decay_7_days_RTT(:,i),"omitmissing");
        end
    end
end

PF_decay_7_days_WT_norm_today = nan(7,7);
for i = 1:7
    for j = 1:7
        if ~isnan(PF_decay_7_days_WT(j,i))
           PF_decay_7_days_WT_norm_today(j,i) = PF_decay_7_days_WT(j,i)/sum(PF_decay_7_days_WT(:,i),"omitmissing");
        end
    end
end

% bar plot
for i = 2:7
    PCs_appear_day_fraction = [PF_decay_7_days_WT_norm_today(:,i)';...
        PF_decay_7_days_RTT_norm_today(:,i)'];
    PC_appear_day = {};
    for j = 1:i
        PC_appear_day{j} = ['Day',num2str(j)];
    end
    figure;
    categories = {'WT','RTT'};
    bar(categories,PCs_appear_day_fraction,'stacked');
    ylabel('Fraction of PCs', 'FontSize', 14);
    legend(PC_appear_day);
    title(['Day ',num2str(i)]);
    set(gca, 'FontSize', 14);
end

% plot PF_decay_7_days normalized to total PC number on a specific day
tiledlayout(2,4);
for i = 1:7
    tile = nexttile;
    hold(tile, 'on');
    hold on;
    h2 = plot(tile,PF_decay_7_days_RTT_norm_today(i,1:7),'-o','LineWidth',2,'Color','red','MarkerSize',8,'MarkerEdgeColor',...
     'red','MarkerFaceColor','red');
    h1 = plot(tile,PF_decay_7_days_WT_norm_today(i,1:7),'-o','LineWidth',2,'Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue');
    xlim([0.8 7]);
    ylim([0 1]);
    xlabel('Days');
    ylabel('PC fraction norm. to each day');
    legend([h1 h2],'WT','RTT');
    title(['Day-',num2str(i),'-appearing']);
    set(gca, 'FontSize', 14);
    hold(tile, 'off');
end

%%
% plot fraction of sustained PCs, both WT and RTT
figure;
hold on;
h1 = plot(sustained_PC_5_days_fraction_WT*100,'-o','LineWidth',3,'Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue');
h2 = plot(sustained_PC_5_days_fraction_RTT*100,'-o','LineWidth',3,'Color','red','MarkerSize',8,'MarkerEdgeColor',...
     'red','MarkerFaceColor','red');
xlim([0.8 5]);
ylim([0 100]);
xlabel('Days');
ylabel('Fraction of PCs (%)');
title('sustained PCs');
%legend([h1 h2],'WT','RTT','FontSize',14);
xticks([1,2,3,4,5]);
xticklabels({'1','2','3','4','5'});
set(gca, 'FontSize', 30);
set(gcf,'Position',[500 500 500 500]);
set(gca, 'TickDir', 'out');
set(gca, 'LineWidth',2);
set(gca, 'Box', 'off');

hold off;

%%
% plot fraction of past PCs, both WT and RTT
figure;
hold on;
h1 = plot(past_PF_norm_WT,'-o','LineWidth',2,'Color','blue','MarkerSize',8,'MarkerEdgeColor',...
     'blue','MarkerFaceColor','blue');
h2 = plot(past_PF_norm_RTT,'-o','LineWidth',2,'Color','red','MarkerSize',8,'MarkerEdgeColor',...
     'red','MarkerFaceColor','red');
xlim([0.8 7]);
ylim([0 1]);
xlabel('Days');
% ylabel('Fraction of total PCs');
title('Fraction of past PCs','FontSize', 14);
set(gca, 'FontSize', 14);
legend([h1 h2],'WT','RTT','FontSize',14);
xticks([1,2,3,4,5,6,7]);
xticklabels({'1','2','3','4','5','6','7'});
set(gca, 'FontSize', 14);
hold off;

