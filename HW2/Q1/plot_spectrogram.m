function plot_spectrogram(spect,time,freq)

imagesc([time(1) time(end)]*1000,[1 length(freq)],spect)                    %display image with scaled colors
yinds = get(gca,'YTick');                                                   %obtain automatic axis values
set(gca,'YTickLabel',round(freq(yinds)/1000,1))                             %convert to kHz and round
set(gca,'XDir','normal')                                                    %set y-axis to be increasing
xlabel('Time (ms)')
ylabel('Frequency (kHz)')