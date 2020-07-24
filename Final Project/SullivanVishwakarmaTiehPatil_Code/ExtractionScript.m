    clear datar6;
    index=1;
    datar6=cell(1,11);
    datar6{1}='index';datar6{2}='r';datar6{3}='s';datar6{4}='d';
    datar6{5}='p';datar6{6}='n';datar6{7}='Spike Times';datar6{8}='STA';
    datar6{9}='STC';datar6{10}='Eigenvalues';datar6{11}='Eigenvectors';
    
for r=6
    for s=1:length(e.r{r}.s)
    for d=1:length(e.r{r}.s{s}.d)
    for p=1:length(e.r{r}.s{s}.d{d}.p)
    lengthn=length(e.r{r}.s{s}.d{d}.p{p}.n);
    for i=1:lengthn
        n=i;
        [spikes,sta,stc,Eigen,Vec]=SpikeExtraction(e,r,s,d,p,n);
        if isempty(sta)==0
            if exist('datar1')==1
                siz=size(datar6);
                k=siz(1)+1;
                datar6{k,1}=index;datar6{k,2}=r;datar6{k,3}=s;datar6{k,4}=d;
                datar6{k,5}=p;datar6{k,6}=n;datar6{k,7}=spikes;datar6{k,8}=sta;
                datar6{k,9}=stc;datar6{k,10}=Eigen;datar6{k,11}=Vec;
            else 
                datar6=cell(1,11);
                k=1;
                datar6{k,1}=index;datar6{k,2}=r;datar6{k,3}=s;datar6{k,4}=d;
                datar6{k,5}=p;datar6{k,6}=n;datar6{k,7}=spikes;datar6{k,8}=sta;
                datar6{k,9}=stc;datar6{k,10}=Eigen;datar6{k,11}=Vec;
            end
                index=index+1;
        end
    end
    end
    end
    end
end