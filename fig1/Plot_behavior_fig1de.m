saving = 0;

%% WT
LickProb(Binned_Master_F00_WT,Binned_Master_WT,saving)

%% RTT
LickProb(Binned_Master_F00_RTT,Binned_Master_RTT,saving)

%% Compare WT and RTT
[~,~] = AnticiLickProb(Binned_Master_F00_WT,Binned_Master_F00_RTT,Binned_Master_WT,Binned_Master_RTT,saving);
