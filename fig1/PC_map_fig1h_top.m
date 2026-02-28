% WT
Normalized_dFoF_PF_WT_sorted_7days = {};
for j = 1:size(Binned_Master_WT,2)
    Normalized_dFoF_PF_WT = [];
    for i = 1:size(Binned_Master_WT,1)
        BinnedData = Binned_Master_WT{i,j};
        PFIDs = BinnedData.PFStats.PFIDs;
        Onset = BinnedData.Onset;
        mean_dFoF_norm_cells = [];
        for k = 1:numel(PFIDs)
            PF = PFIDs(k);
            Firing_laps = find(~isnan(squeeze(BinnedData.Cellstats(PF,:,7))));
            Firing_laps(Firing_laps<Onset(PF)) = [];
            dFoF = squeeze(BinnedData.Cells_dFoF_binned_mean(:,:,PF));
            [~,pros_PF_binloc] = max(nanmean(dFoF,1));
            % Get centered dFoF array for PFloc calculation; flatten, shift, reshape
            Flat_array = reshape(dFoF.',1,[]); % Flatten the dFoF array
            shift = 25 - pros_PF_binloc; % positive if <25; negative if >25;
            Centered_flat_array = circshift(Flat_array,shift);
            Centered_dFoF = reshape(Centered_flat_array,size(dFoF,2),[])'; % use this for COM
            mean_dFoF = nanmean(Centered_dFoF(Firing_laps,:),1);
            [mean_dFoF_peak,centered_PFloc] = nanmax(mean_dFoF);
            PF_loc = centered_PFloc - shift;
            if PF_loc>50
               PF_loc = PF_loc -50;
            elseif PF_loc<1
               PF_loc = 50 + PF_loc;
            end
            PF_loc_cm = (PF_loc * 3.6) - 1.8;
            mean_dFoF_norm = mean_dFoF./mean_dFoF_peak;
            mean_dFoF_norm = circshift(mean_dFoF_norm,-shift);
            mean_dFoF_norm_cells(k,1) = PF;
            mean_dFoF_norm_cells(k,2) = PF_loc_cm;
            mean_dFoF_norm_cells(k,3:52) = mean_dFoF_norm;

        end
        Normalized_dFoF_PF_WT = [Normalized_dFoF_PF_WT;mean_dFoF_norm_cells];
        Normalized_dFoF_PF_WT_sorted = sortrows(Normalized_dFoF_PF_WT,2);
        Normalized_dFoF_PF_WT_sorted_7days{j} = Normalized_dFoF_PF_WT_sorted;
    end

end

%%
% WT PC map
% plot all the place cells with dFoF normalized to the peak
for j = 7 % day index
    figure;
    WT = Normalized_dFoF_PF_WT_sorted_7days{j}(:,3:52);
    imagesc(WT);
    colormap(jet);
    clim([0 1]);
    ylim([1 size(Normalized_dFoF_PF_WT_sorted_7days{j},1)+0.5+0.15]);
    xlim([0.5-0.15 50.5]);
    xticks([0.5 25.5 50.5]);
    xticklabels({'0','90','180'});
    newyticks = [1,size(Normalized_dFoF_PF_WT_sorted_7days{j},1)];
    newyticklabels = {'1',string(size(Normalized_dFoF_PF_WT_sorted_7days{j},1))};
    yticks(newyticks);
    yticklabels(newyticklabels);
    xlabel('Position (cm)');
    ylabel('PCs');
    set(gca, 'TickDir', 'out');
    set(gca, 'LineWidth',1);
    set(gca, 'Box', 'off');
    %colorbar; clb = colorbar(); ylabel(clb, "Peak-normalized ∆F/F"); clb.FontSize = 30; clb.Label.FontSize = 30; clb.LineWidth = 0.5;
    set(gca,'FontSize', 30);
    daspect([1 12 1]);
    set(gcf,'Position',[500 500 700 1000]);
    % xline(20,'--w','LineWidth',4,'FontSize',24);
    % xline(30,'--w','LineWidth',4,'FontSize',24);
    %title(['PF activity, WT, Day ',num2str(j)],'FontSize',16);
    
    %print(gcf, 'fig1G_WT_F07.pdf','-dpdf','-vector','-bestfit');
end

%%
% RTT
Normalized_dFoF_PF_RTT_sorted_7days = {};
for j = 1:size(Binned_Master_RTT,2)
    Normalized_dFoF_PF_RTT = [];
    for i = 1:size(Binned_Master_RTT,1)
        BinnedData = Binned_Master_RTT{i,j};
        PFIDs = BinnedData.PFStats.PFIDs;
        Onset = BinnedData.Onset;
        mean_dFoF_norm_cells = [];
        for k = 1:numel(PFIDs)
            PF = PFIDs(k);
            Firing_laps = find(~isnan(squeeze(BinnedData.Cellstats(PF,:,7))));
            Firing_laps(Firing_laps<Onset(PF)) = [];
            dFoF = squeeze(BinnedData.Cells_dFoF_binned_mean(:,:,PF));
            [~,pros_PF_binloc] = max(nanmean(dFoF,1));
            % Get centered dFoF array for PFloc calculation; flatten, shift, reshape
            Flat_array = reshape(dFoF.',1,[]); % Flatten the dFoF array
            shift = 25 - pros_PF_binloc; % positive if <25; negative if >25;
            Centered_flat_array = circshift(Flat_array,shift);
            Centered_dFoF = reshape(Centered_flat_array,size(dFoF,2),[])'; % use this for COM
            mean_dFoF = nanmean(Centered_dFoF(Firing_laps,:),1);
            [mean_dFoF_peak,centered_PFloc] = nanmax(mean_dFoF);
            PF_loc = centered_PFloc - shift;
            if PF_loc>50
               PF_loc = PF_loc -50;
            elseif PF_loc<1
               PF_loc = 50 + PF_loc;
            end
            mean_dFoF_norm = mean_dFoF./mean_dFoF_peak;
            mean_dFoF_norm = circshift(mean_dFoF_norm,-shift);
            mean_dFoF_norm_cells(k,1) = PF;
            mean_dFoF_norm_cells(k,2) = PF_loc;
            mean_dFoF_norm_cells(k,3:52) = mean_dFoF_norm;

        end
        Normalized_dFoF_PF_RTT = [Normalized_dFoF_PF_RTT;mean_dFoF_norm_cells];
        Normalized_dFoF_PF_RTT_sorted = sortrows(Normalized_dFoF_PF_RTT,2);
        Normalized_dFoF_PF_RTT_sorted_7days{j} = Normalized_dFoF_PF_RTT_sorted;
    end

end

%%
% RTT PC map
% plot all the place cells with dFoF normalized to the peak
for j = 7 % day index
    figure;
    RTT = Normalized_dFoF_PF_RTT_sorted_7days{j}(:,3:52);
    imagesc(RTT);
    colormap(jet);
    clim([0 1]);
    ylim([1 size(Normalized_dFoF_PF_RTT_sorted_7days{j},1)+0.5+0.15]);
    xlim([0.5-0.15 50.5]);
    xticks([0.5 25.5 50.5]);
    xticklabels({'0','90','180'});
    newyticks = [1,size(Normalized_dFoF_PF_RTT_sorted_7days{j},1)];
    newyticklabels = {'1',string(size(Normalized_dFoF_PF_RTT_sorted_7days{j},1))};
    yticks(newyticks);
    yticklabels(newyticklabels);
    xlabel('Position (cm)');
    ylabel('PCs');
    set(gca, 'TickDir', 'out');
    set(gca, 'LineWidth',1);
    set(gca, 'Box', 'off');

    % colorbar;
    % clb = colorbar();
    % ylabel(clb, "Peak-normalized ∆F/F");
    % clb.FontSize = 30;
    % clb.Label.FontSize = 30;
    % clb.LineWidth = 0.5;
    % clb.Ticks = [0 1];
    % clb.TickLabels = {'0','1'};

    set(gca,'FontSize', 30);
    daspect([1 15.2184 1]);
    set(gcf,'Position',[500 500 700 1000]);
    % xline(20,'--w','LineWidth',4,'FontSize',24);
    % xline(30,'--w','LineWidth',4,'FontSize',24);
    %title(['PF activity, RTT, Day ',num2str(j)],'FontSize',16);
    
    %print(gcf, 'fig1G_RTT_F07.pdf','-dpdf','-vector','-bestfit');
end
