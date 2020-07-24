t=0:1/600:1/6;                                                              %time increment vector
std=5/1000;                                                                 %standard deviation for Gaussian filter
fr=zeros(length(stimulus_start_times)-1,length(t));                         %firing rate for each stimulus presentation
normdist=0;
fr_avg=zeros(length(t),1);                                                  %average firing rate for each time point
for i=1:length(stimulus_start_times)-1                                      %over all stimulus presentations
    times=st{i};                                                            %vector of spike times associated with given presentation
    n=length(times);
        for j=1:n                                                           %for each spike
            normdist=normdist+normpdf(t,times(j),std);                      %apply normal distribution evaluated at all time points centered at spike
        end
        fr(i,:)=normdist;                                                   %firing rate is sum of all distributions from all spikes
        normdist=0;
end

for i=1:length(t)
    fr_avg(i)=sum(fr(:,i))/(length(stimulus_start_times)-1);                %calculate average firing rate at each time point
end
plot(t,fr_avg,'color','k','linewidth',2);
xlabel('time (s)');
ylabel('Firing Rate (Hz)');
title('Average Firing Rate vs. Stimulus');