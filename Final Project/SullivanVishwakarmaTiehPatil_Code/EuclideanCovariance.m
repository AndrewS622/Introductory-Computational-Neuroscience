distexprange=[];
for i=1:length(longspike1)
    if (1000*datar1{longspike1(i),15}<=stim_freq(33) && 1000*datar1{longspike1(i),15}>=stim_freq(19)) == 1
        dim1=datar1{longspike1(i),26}';
        for j=i+1:length(longspike1)
            if (1000*datar1{longspike1(j),15}<=stim_freq(33) && 1000*datar1{longspike1(j),15}>=stim_freq(19)) == 1
                dim2=datar1{longspike1(j),26}';
                distexprange=[distexprange pdist2(dim1,dim2,'euclidean','Smallest',1)];
            end
        end
    end
end
for i=1:length(longspike2)
    if (1000*datar2{longspike2(i),15}<=stim_freq(33) && 1000*datar2{longspike2(i),15}>=stim_freq(19)) == 1
        dim1=datar2{longspike2(i),26}';
        for j=i+1:length(longspike2)
            if (1000*datar2{longspike2(j),15}<=stim_freq(33) && 1000*datar2{longspike2(j),15}>=stim_freq(19)) == 1
                dim2=datar2{longspike2(j),26}';
                distexprange=[distexprange pdist2(dim1,dim2,'euclidean','Smallest',1)];
            end
        end
    end
end
for i=1:length(longspike3)
    if (1000*datar3{longspike3(i),15}<=stim_freq(33) && 1000*datar3{longspike3(i),15}>=stim_freq(19)) == 1
        dim1=datar3{longspike3(i),26}';
        for j=i+1:length(longspike3)
            if (1000*datar3{longspike3(j),15}<=stim_freq(33) && 1000*datar3{longspike3(j),15}>=stim_freq(19)) == 1
                dim2=datar3{longspike3(j),26}';
                distexprange=[distexprange pdist2(dim1,dim2,'euclidean','Smallest',1)];
            end
        end
    end
end