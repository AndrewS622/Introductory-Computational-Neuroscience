function[U,S,V,Umax,Vmax,Vmin,asvd]= SVDAnalysis(sta,freq)
[U,S,V]=svd(sta);
U=-1.*U;
V=-1.*V;
time=-125:5:125;

figure;
subplot(1,2,1)
imagesc(time,[1 length(freq)],sta);
yinds = get(gca,'YTick');
set(gca,'YTickLabel',round(freq(yinds)/1000,1))
set(gca,'YDir','normal')
xlabel('Time (ms)')
ylabel('Frequency (kHz)')
title('STA')
subplot(1,2,2)
imagesc(time,[1 length(freq)],U(:,1)*S(1,1)*V(:,1)')
yinds = get(gca,'YTick');
set(gca,'YTickLabel',round(freq(yinds)/1000,1))
set(gca,'YDir','normal')
xlabel('Time (ms)')
ylabel('Frequency (kHz)')
title('Reconstruction')

figure;
subplot(2,1,1)
plot(freq/1000,U(:,1));
[P,L,W,prom]=findpeaks(U(:,1),'SortStr','descend','MinPeakHeight',0.2);
xlabel('Frequency (kHz)');
ylabel('First Singular Vector');
title('Spectral Representation');
subplot(2,1,2)
plot(time,V(:,1));
xlabel('Time (ms)');
ylabel('First Singular Vector');
title('Temporal Representation');

asvd=1-(S(1,1)^2)/sum(diag(S.^2));
[~,Umax]=max(abs(U(:,1)));
Umax=freq(Umax)/1000;

[~,Vmax]=max(V(1:26,1));
Vmax=time(Vmax);

[~,Vmin]=min(V(1:26,1));
Vmin=time(Vmin);

[Pfreq,Lfreq,Wfreq,~]=findpeaks(abs(U(:,1)),'SortStr','descend','MinPeakHeight',0.2);

[Ptemp,Ltemp,Wtemp,~]=findpeaks(abs(V(:,1)),'SortStr','descend','MinPeakHeight',0.2);

