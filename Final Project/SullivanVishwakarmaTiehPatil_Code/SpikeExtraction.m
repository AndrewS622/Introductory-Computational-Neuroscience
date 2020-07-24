function [spikeexp,sta,stc,Eigen,Vec]=SpikeExtraction(e,r,s,d,p,n)

spikeexp=[];
spike=[];

spike =e.r{r}.s{s}.d{d}.p{p}.n{n}.t';

stim_t = e.r{r}.s{s}.tr_t(e.r{r}.s{s}.stim_start_ind);
stim_start = stim_t(3);
 
spike = spike - stim_start;
spike(spike<0)=[];
spike(spike>899)=[];
spikeexp=[spikeexp,spike];

if isempty(spike)==0
    [sta,stc,Vec,Eigen]=STASTCNoFig(spikeexp);

else 
    sta=[];
    stc=sta;
    Vec=sta;
    Eigen=sta;
end