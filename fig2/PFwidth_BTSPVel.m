function PFwidth_BTSPVel(Binned_Master_WT,BTSP_cells_animals_WT,...
    Binned_Master_RTT,BTSP_cells_animals_RTT,saving)

%{
This function looks for the correlation between PF width and velocity during BTSP induction 
in all the PCs with BTSP in WT and RTT mice. Include all 7-day data. n is
the frame window size. Find the BTSP event peak frame, and find a +- 30
frames window. Average all the velocity values of these frames.

X: BTSP induction velocity (cm/s). Y: PF width (cm).

ARGS:
- Binned_Master_WT: (cell array) Binned session data for WT animals (nAnimals × nDays).
Each cell contains a struct with dF/F, events, laps, etc.
- Binned_Master_RTT: (cell array) Binned session data for RTT animals (nAnimals × nDays).
Each cell contains a struct with dF/F, events, laps, etc.
- BTSP_cells_animals_WT: (cell array) Binned session data for WT animals (nAnimals × nDays).
Contains lap-wise information about BTSP.
- BTSP_cells_animals_RTT: (cell array) Binned session data for RTT animals (nAnimals × nDays).
Contains lap-wise information about BTSP.
- saving: save figure and variables (1) or not (0)

RETURNS:
- Scatter plot of PF width and average induction velocity of PCs
- Fitted regression lines of WT and RTT mice
- (optional) save figures and varibales to current folder
%}

BTSP_vel_width_7_days_WT = GetPF_width_vel(Binned_Master_WT,BTSP_cells_animals_WT);
BTSP_vel_width_7_days_RTT = GetPF_width_vel(Binned_Master_RTT,BTSP_cells_animals_RTT);

PFwidth_BTSP_vel_WT = cell2mat(BTSP_vel_width_7_days_WT.');
PFwidth_BTSP_vel_RTT = cell2mat(BTSP_vel_width_7_days_RTT.');

Fit_PFwidthOnsetVel_WT_RTT(PFwidth_BTSP_vel_WT,PFwidth_BTSP_vel_RTT,saving);

if saving == 1
    save('fig2E.mat','PFwidth_BTSP_vel_WT','PFwidth_BTSP_vel_RTT');
end

end


function BTSP_vel_width_7_days_WT = GetPF_width_vel(Binned_Master_WT,BTSP_cells_animals_WT)
n = 30;
BTSP_vel_width_7_days_WT = {};
for j = 1:size(BTSP_cells_animals_WT,2)
    BTSP_vel_width_WT = [];
    for i = 1:size(BTSP_cells_animals_WT,1)
        BTSP_cells = BTSP_cells_animals_WT{i,j};
        BinnedData = Binned_Master_WT{i,j};
        LapStructure = BinnedData.LapStructure;
        for k = 1:size(BTSP_cells,1)
            if ~isnan(BTSP_cells{k,2})
                if ismember(k,BinnedData.PFStats.PFIDs)
                    Induction_lap = BTSP_cells{k,3}(1);
                    Induction_lap_peak_frame = BTSP_cells{k,4}(1);
                    Induction_lap_frames = [];
                    Induction_lap_frames = max([(Induction_lap_peak_frame-n),1]):(Induction_lap_peak_frame+n);                   
                    Velocity_frame = [LapStructure.Velocity_frame];
                    FrameNumber = [LapStructure.FrameNumber];
                    InductionVel_indices = find(ismember(FrameNumber,Induction_lap_frames));
                    InductionVel = Velocity_frame(InductionVel_indices);
                    InductionVel = InductionVel(InductionVel>=0);
                    InductionVel_mean = mean(InductionVel);
                    PF_width = GetPFWidth(BinnedData,k);
                    BTSP_vel_width = [InductionVel_mean,PF_width];
                    BTSP_vel_width_WT = [BTSP_vel_width_WT;BTSP_vel_width];
                end
            end
        end
    end
    BTSP_vel_width_7_days_WT{j} = BTSP_vel_width_WT;
end

end