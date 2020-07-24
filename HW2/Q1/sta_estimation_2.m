%%clear all

% Load DMR stimulus specrogram and spiking responses from one neuron
load dmr_experiment

% Plot spectrogram of stimulus
plot_spectrogram(stim_spectrogram, stim_time, stim_freq)

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

figure;
corr=(1/(size(stim_spectrogram,2)-1))*(stim_spectrogram*stim_spectrogram'); %calculate covariance of spectrogram
corr=corr/max(max(abs(corr)));
heatmap(corr,'Colormap',gray,'Xlabel','','YLabel','');                      %plot on gray heatmap
title('Heatmap of Spectrogram Covariance');

%%STC Estimation
siz=size(sta);
STAsub=zeros(siz(1),siz(2),length(spikeexp));
STCsum=zeros(siz(1),siz(1));
STCsub=zeros(siz(1),siz(1),length(spikeexp));
Cosum=STCsum;
for i=1:length(spikeexp)
    STAsub(:,:,i)=sta_stim(:,:,i)-sta;
    Cosum(:,:)=Cosum(:,:)+sta_stim(:,:,i)*sta_stim(:,:,i)';
    STCsub(:,:,i)=STAsub(:,:,i)*STAsub(:,:,i)';
    STCsum=STCsum+STCsub(:,:,i);
end
STC=STCsum/length(spikeexp);
Co=Cosum/length(spikeexp);

[Vec,Eigen]=eig(STC-Co);
Filters=zeros(siz(1),siz(2));
for i=1:length(spikeexp)
    Filters=Filters+(Vec(:,1)'*sta_stim(:,:,i));
end
Filters=Filters/length(spikeexp);
plot_spectrogram(Filters, sta_time, sta_freq);
xlabel('Time relative to spike (ms)')
ylabel('Frequency (kHz)');
title('Spike-Triggered Covariance');

figure;
plot(diag(Eigen));


