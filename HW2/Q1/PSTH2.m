ctrl=(spikes_control);
exp=(spikes_exp);
width=5/1000;                                                               %histogram bin width
tstim=[0 1/6];                                                              
numbin=ceil((tstim(2)-tstim(1))/width);                                     %total bin number

j=1;

while j<=length(ctrl)                                                       %for each spike in control dataset
    if ctrl(j)>=1/6                                                         %if spike time is greater than length of stimulus
       ctrl(j)=ctrl(j)-1/6;                                                 %subtract stimulus length until within 1 stimulus
    else
        j=j+1;                                                              %go to next spike
    end
end

j=1;

while j<=length(exp)                                                        %repeat for experimental dataset
    if exp(j)>=1/6
       exp(j)=exp(j)-1/6;
    else
        j=j+1;
    end
end

ctrl=sort(ctrl);                                                            %sort data vectors in ascending order
exp=sort(exp);

histogram(ctrl,'BinWidth',width,'Normalization','pdf');                     %use matlab histogram function with normalization 
xlabel('time (s)');                                                         %by total number of points and bin width
ylabel('Frequency (Hz)');                                                   %to get firing rate distribution for both control and experiment
title('Control Firing');
figure;
histogram(exp,'BinWidth',width,'Normalization','pdf');
xlabel('time (s)');
ylabel('Frequency (Hz)');
title('Experimental Firing');