n=10;                                                                       %number of trials
t_el=zeros(n,4);                                                            %matrix containing rows of elapsed time for each operation for 10 trials

for i=1:n

r=rand(1000,5000);                                                          %script for testing speed of SVD and diagonalization
r2=rand(5000,1000);                                                         %generate random matrices
tic;                                                                        %mark down current time

S=svd(r);                                                                   %perform SVD and calculate elapsed time
t_el(i,1)=toc;
tic;

r_meansub=r-mean(r,1);                                                      %perform diagonalization and calculate elapsed time
cov_r=(1/size(r,1))*transpose(r)*r;
[Vr,Dr]=eig(cov_r);
t_el(i,2)=toc;
tic;

S2=svd(r2);                                                                 %repeat with second matrix
t_el(i,3)=toc;
tic;

r2_meansub=r2-mean(r2,1);
cov_r2=(1/size(r2,1))*transpose(r2)*r2;
[Vr2,Dr2]=eig(cov_r2);
t_el(i,4)=toc;

end

t_elapsed=(1/n)*sum(t_el,1);