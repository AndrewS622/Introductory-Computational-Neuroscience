spikes_single_unit=sort(spikes_single_unit);                                %make sure spikes are sorted in ascending order
if length(stimulus_start_times)==360
    stimulus_start_times=[stimulus_start_times 360/6];
end
i=1;
j=1;
st=cell(1,length(stimulus_start_times));                                    %create cell to store data for each stimulus
while j<=length(spikes_single_unit)                                         %for each spike
    if spikes_single_unit(j)<stimulus_start_times(i)                        %if the spike is before the current start time
        line([spikes_single_unit(j)-stimulus_start_times(i-1) spikes_single_unit(j)-stimulus_start_times(i-1)],[i-1 i+1],'color','k');
        st{i}=[st{i} spikes_single_unit(j)-stimulus_start_times(i-1)];      %draw a line, update array for stimulus i with spike onset
        j=j+1;                                                              %go to next spike
    else
        i=i+1;                                                              %if not, all spikes up until current time have been included
    end                                                                     %go to next time point
end
ylim([0 370]);
xlabel('time (s)');
ylabel('Trial Number');
title('Raster Plot of Spiking Activity');