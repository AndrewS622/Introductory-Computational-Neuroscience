ctrl=(spikes_control);
exp=(spikes_exp);
width=5/1000;
tstim=[0 1/6];
numbin=ceil((tstim(2)-tstim(1))/width);
t=zeros(numbin+1,1);
bin=t;
countctrl=zeros(numbin+1,1);
countexp=countctrl;
for i=1:numbin+1
    t(i)=(i-1)*width;
    bin(i)=(width/2)+t(i);
end

j=1;

while j<=length(ctrl)
    if ctrl(j)>=1/6
       ctrl(j)=ctrl(j)-1/6;
    else
        j=j+1;
    end
end

j=1;

while j<=length(exp)
    if exp(j)>=1/6
       exp(j)=exp(j)-1/6;
    else
        j=j+1;
    end
end

ctrl=sort(ctrl);
exp=sort(exp);
j=1;
i=1;

while j<=length(ctrl)
    if ctrl(j)<=t(i)
        countctrl(i)=countctrl(i)+1;
        j=j+1;
    else
        i=i+1;
    end
end

while j<=length(exp)
    if exp(j)<t(i)
        countexp(i)=countexp(i)+1;
        j=j+1;
    else
        i=i+1;
    end
end

plot(bin,countctrl);