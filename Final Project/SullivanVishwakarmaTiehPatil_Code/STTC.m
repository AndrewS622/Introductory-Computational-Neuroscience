function [Corr] = STTC(t1,t2,dt,l)                                          %% two spike trains, window for correlation, and length of recording session

t1=sort(t1);
t2=sort(t2);
count1=0;
count2=0;

e1=[max(t1(1)-dt,0) t1(1)+dt];
e2=[max(t2(1)-dt,0) t2(1)+dt];

for i=2:length(t1)
    if t1(i)-dt<=e1(end,2)
        e1(end,2)=t1(i)+dt;
    else
        enew=[t1(i)-dt t1(i)+dt];
        e1=[e1;enew];
    end
end

for i=2:length(t2)
     if t2(i)-dt<=e2(end,2)
        e2(end,2)=t2(i)+dt;
     else
        enew=[t2(i)-dt t2(i)+dt];
        e2=[e2;enew];
     end
end

s1=size(e1);
s2=size(e2);
ta=0;
tb=0;

for i=1:length(t1)
    for j=1:s2(1)
        if t1(i)<=e2(j,2)&&t1(i)>=e2(j,1)
            count1=count1+1;
            continue;
        end
    end
end

for i=1:length(t2)
    for j=1:s1(1)
        if t2(i)<=e1(j,2)&&t2(i)>=e1(j,1)
            count2=count2+1;
            continue;
        end
    end
end

for i=1:s1(1)
    ta=ta+(e1(i,2)-e1(i,1));
end

for i=1:s2(1)
    tb=tb+(e2(i,2)-e2(i,1));
end

Ta=ta/l;
Tb=tb/l;
Pa=count1/length(t1);
Pb=count2/length(t2);
n1=Pa-Tb;
n2=Pb-Ta;
d1=1-Pa*Tb;
d2=1-Pb*Ta;
Corr=(1/2)*((n1/d1)+(n2/d2));