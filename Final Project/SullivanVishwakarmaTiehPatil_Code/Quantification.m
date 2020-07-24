clear a
clear b
countexpf=[];
countctrlf=[];
for i=1:1677
    a(i)=datar3{longspike3(i),15};
end

for i=1678:(1678+1124)
    a(i)=datar2{longspike2(i-1677),15};
end

for i=(1678+1125):(1678+1125+173)
    a(i)=datar1{longspike1(i-(1677+1125)),15};
end

for i=1:497
    b(i)=datar6{longspike6(i),15};
end

for i=498:(498+477)
    b(i)=datar5{longspike5(i-497),15};
end

for i=(479+497):(479+497+142)
    b(i)=datar4{longspike4(i-(478+497)),15};
end

for i=1:length(a)
    for j=1:8
        if round(a(i),2)==round(exposurefreq(j),2)
            countexpf=[countexpf exposurefreq(j)];
        end
    end
end

for i=1:length(b)
    for j=1:8
        if round(b(i),2)==round(exposurefreq(j),2)
            countctrlf=[countctrlf exposurefreq(j)];
        end
    end
end

countexpf2=zeros(1,8);
countctrlf2=zeros(1,8);
for i=1:length(a)
    for j=1:8
        if round(a(i),2)==round(exposurefreq(j),2)
            countexpf2(j)=countexpf2(j)+1;
        end
    end
end

for i=1:length(b)
    for j=1:8
        if round(b(i),2)==round(exposurefreq(j),2)
            countctrlf2(j)=countctrlf2(j)+1;
        end
    end
end

figure
subplot(1,2,1)
histogram(a,'Normalization','probability');
title('Experimental Inseparability');
xlabel('Inseparability Index');
ylabel('Fraction of Neurons');

subplot(1,2,2)
histogram(b,'Normalization','probability');
title('Control Inseparability');
xlabel('Inseparability Index');
ylabel('Fraction of Neurons');