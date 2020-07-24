for i=2:length(datar6)
    sta=datar6{i,8};
    [U,S,V,Umax,Vmax,Vmin,asvd,Pfreq,Lfreq,Wfreq,Ptemp,Ltemp,Wtemp]=SVDAnalysisNoFig(sta,stim_freq);
    datar6{i,12}=U;
    datar6{i,13}=diag(S);
    datar6{i,14}=V;
    datar6{i,15}=Umax;
    datar6{i,16}=Vmax;
    datar6{i,17}=Vmin;
    datar6{i,18}=asvd;
    datar6{i,19}=Pfreq;
    datar6{i,20}=Lfreq;
    datar6{i,21}=Wfreq;
    datar6{i,22}=Ptemp;
    datar6{i,23}=Ltemp;
    datar6{i,24}=Wtemp;
end