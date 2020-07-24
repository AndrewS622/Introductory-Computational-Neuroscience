expcorrrange=[];
for i=1:length(longspike1)
    if (1000*datar1{longspike1(i),15}<=stim_freq(33) && 1000*datar1{longspike1(i),15}>=stim_freq(19)) == 1
        t1=datar1{longspike1(i),7}';
        for j=i+1:length(longspike1)
            if (1000*datar1{longspike1(j),15}<=stim_freq(33) && 1000*datar1{longspike1(j),15}>=stim_freq(19)) == 1
                t2=datar1{longspike1(j),7}';
                expcorrrange=[expcorrrange STTC(t1,t2,0.1,900)];
            end
        end
    end
end
for i=1:length(longspike2)
    if (1000*datar2{longspike2(i),15}<=stim_freq(33) && 1000*datar2{longspike2(i),15}>=stim_freq(19)) == 1
        t1=datar2{longspike2(i),7}';
        for j=i+1:length(longspike2)
            if (1000*datar2{longspike2(j),15}<=stim_freq(33) && 1000*datar2{longspike2(j),15}>=stim_freq(19)) == 1
                t2=datar2{longspike2(j),7}';
                expcorrrange=[expcorrrange STTC(t1,t2,0.1,900)];
            end
        end
    end
end
for i=1:length(longspike3)
    if (1000*datar3{longspike3(i),15}<=stim_freq(33) && 1000*datar3{longspike3(i),15}>=stim_freq(19)) == 1
        t1=datar3{longspike3(i),7}';
        for j=i+1:length(longspike3)
            if (1000*datar3{longspike3(j),15}<=stim_freq(33) && 1000*datar3{longspike3(j),15}>=stim_freq(19)) == 1
                t2=datar3{longspike3(j),7}';
                expcorrrange=[expcorrrange STTC(t1,t2,0.1,900)];
            end
        end
    end
end