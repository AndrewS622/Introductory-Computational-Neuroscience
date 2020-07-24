for i=2:length(datar6)
    eigspec=datar6{i,10};
    vec=datar6{i,11};
    m=mean(eigspec);
    st=std(eigspec);
    count=0;
    sigeig=[];
    for j=1:38
        if eigspec(j)>m+st || eigspec(j)<m-st
            count=count+1;
            sigeig=[sigeig vec(:,j)];
        end
    end
    datar6{i,25}=count;
    datar6{i,26}=sigeig;
end

numsigexp=zeros(1,length(longspike1)+length(longspike2)+length(longspike3));
freqsigexp=numsigexp;
for i=1:length(longspike1)
    numsigexp(i)=datar1{longspike1(i),25};
    freqsigexp(i)=datar1{longspike1(i),15};
end
for i=1:length(longspike2)
    numsigexp(i+length(longspike1))=datar2{longspike2(i),25};
    freqsigexp(i+length(longspike1))=datar2{longspike2(i),15};
end
for i=1:length(longspike3)
    numsigexp(i+length(longspike2)+length(longspike1))=datar3{longspike3(i),25};
    freqsigexp(i+length(longspike2)+length(longspike1))=datar3{longspike3(i),15};
end

numsigctrl=zeros(1,length(longspike4)+length(longspike5)+length(longspike6));
freqsigctrl=numsigctrl;
for i=1:length(longspike4)
    numsigctrl(i)=datar4{longspike4(i),25};
    freqsigctrl(i)=datar4{longspike4(i),15};
end
for i=1:length(longspike5)
    numsigctrl(i+length(longspike4))=datar5{longspike5(i),25};
    freqsigctrl(i+length(longspike4))=datar5{longspike5(i),15};
end
for i=1:length(longspike6)
    numsigctrl(i+length(longspike4)+length(longspike5))=datar6{longspike6(i),25};
    freqsigctrl(i+length(longspike4)+length(longspike5))=datar6{longspike6(i),15};
end

se=[freqsigexp',numsigexp'];
se=sortrows(se,1);
sc=[freqsigctrl',numsigctrl'];
sc=sortrows(sc,1);

freqdep=struct([]);
for i=1:38
    freqdep{1,i}=stim_freq(i)/1000;
    countexp=[];
    countctrl=[];
    for j=1:length(se)
        if se(j,1)==stim_freq(i)/1000
            countexp=[countexp se(j,2)];
        end
    end
    for j=1:length(sc)
        if sc(j,1)==stim_freq(i)/1000
            countctrl=[countctrl sc(j,2)];
        end
    end
    freqdep{2,i}=countexp;
    freqdep{3,i}=countctrl;
end

for i=1:38
    exp=freqdep{2,i};
    ctrl=freqdep{3,i};
    freqdep{4,i}=mean(exp);
    freqdep{5,i}=mean(ctrl);
    freqdep{6,i}=std(exp);
    freqdep{7,i}=std(ctrl);
end

for i=1:38
    expstd(i)=freqdep{6,i};
    ctrlstd(i)=freqdep{7,i};
end
plot(stim_freq/1000,expmean);
figure
plot(stim_freq/1000,ctrlmean);

