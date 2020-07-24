
for i=2:length(datar3)
    STC=datar3{i,9}/51;
    [Vec,Eig]=eig(STC-cov(stim_spectrogram'));
    Eig=diag(Eig);
    EigVec=[Eig Vec'];
    EigVec=sortrows(EigVec,1,'descend');
    Eigsort=EigVec(:,1);
    Vecsort=EigVec(:,2:39);
    Vecsort=Vecsort';
    
    datar3{i,9}=STC;
    datar3{i,10}=Eigsort;
    datar3{i,11}=Vecsort;
end
