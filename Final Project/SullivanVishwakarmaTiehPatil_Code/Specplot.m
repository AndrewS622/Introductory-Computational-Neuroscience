[spec,fs]=audioread('independent_chords.wav');
l=length(spec);
%%signalwhite=Whiten(signal);
window=5000;
nfft=2048;
[Sp,w,t]=spectrogram(spec,window,floor(window/2),nfft,fs);
figure
%%subplot(2,1,1)
spectrogram(spec,window,floor(window/2),nfft,fs);
