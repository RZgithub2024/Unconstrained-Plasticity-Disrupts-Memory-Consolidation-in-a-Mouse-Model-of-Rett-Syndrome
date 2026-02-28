saving = 0;
N = 10;
%% WT
RunVel_trace_Nlaps(Binned_Master_F00_WT,Binned_Master_WT,N,saving)

%% RTT
RunVel_trace_Nlaps(Binned_Master_F00_RTT,Binned_Master_RTT,N,saving)

%% Compare WT and RTT
VelAnticiSlow_Nlaps(Binned_Master_F00_WT,Binned_Master_F00_RTT,Binned_Master_WT,Binned_Master_RTT,N,saving)
