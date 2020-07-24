function [sta,STC,Vec,Eigen]=STASTC(spikeexp)

load dmr_experiment                                                         %%for recording parameters
%% Generate STA
%%spikeexp=spikeexp(1:10000);
t_past = 125; % in ms
t_future = 125; % in ms
sampling_rate = mean(median(diff(stim_time)));
sta_time = (-t_past/1000):sampling_rate:(t_future/1000);
sta_freq = stim_freq;
sta_stim = zeros(length(sta_freq),length(sta_time),length(spikeexp));         %3D array with each 2D matrix the frequencies at time points in window around spike

for k=1:length(spikeexp)                                                      %over all spikes
    t=spikeexp(k)+sta_time(1);                                                %find first time point in window (tspike-125 msec)
    tdiff=abs(stim_time-t);                                                 %evaluate difference between all time points and first point in window
    [M,I]=min(tdiff);                                                       %find index of closest value to include in stimulus window
    sta_stim(:,:,k)=stim_spectrogram(:,I:(I+length(sta_time)-1));           %extract stimulus window from -125 to 125 msec around spike k
end

sta = sum(sta_stim,3)/length(spikeexp);                                       %average 2D window over all spikes

% Plot results
figure(2)
plot_spectrogram(sta, sta_time, sta_freq);
xlabel('Time relative to spike (ms)')
ylabel('Frequency (kHz)');
title('Spike-Triggered Average');
colorbar

%%STC Estimation
siz=size(sta);
STAsub=zeros(siz(1),siz(2),length(spikeexp));
STCsum=zeros(siz(1),siz(1));
STCsub=zeros(siz(1),siz(1),length(spikeexp));

for i=1:length(spikeexp)
    STAsub(:,:,i)=sta_stim(:,:,i)-sta;
    STCsub(:,:,i)=STAsub(:,:,i)*STAsub(:,:,i)';
    STCsum=STCsum+STCsub(:,:,i);
end
STC=STCsum/(51*length(spikeexp));

Co=(1/length(stim_spectrogram))*(stim_spectrogram*stim_spectrogram');

%%Plot projection
eignum=1;
figure;
[Vec,Eigen]=eig(STC-Co);
Filters=zeros(siz(1),siz(2));
for i=1:length(spikeexp)
    Filters=Filters+(sta_stim(:,:,i));
end
Filters=sum(sta_stim,3);
Filters=Filters/length(spikeexp);
plot_spectrogram(Filters, sta_time, sta_freq);
xlabel('Time relative to spike (ms)')
ylabel('Frequency (kHz)');
title('Spike-Triggered Covariance');

figure;
plot(diag(Eigen));