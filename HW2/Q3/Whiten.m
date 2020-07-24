function[Whitened] = Whiten(toWhiten)                                       %returns whitened dataset

m=inline('A-mean(A,1)');                                        
covar=inline('(1/(size(A,1)-1))*transpose(A)*(A)');

mean_sub=m(toWhiten);                                                       %mean subtract data and find covariance matrix
co=covar(mean_sub);
[Vunsort,D]=eig(co);                                                        %find eigenvalues and eigenvectors
dia=diag(D);                                                                %extract eigenvalues from diagonal matrix for sorting
[val,I]=sort(dia,'descend');                                                %sort in descending order of eigenvalues
D=diag(val);                                                                %construct new diagonal matrix
V=zeros(length(D));
for i=1:length(I)                                                           %construct new eigenvector matrix corresponding to eigenvalues
    V(:,i)=Vunsort(:,I(i));
end

Proj=mean_sub*V;                                                            %project mean-subtracted data into principal component space
for i=1:length(D)                                                           %scale each dimension by 1/sqrt(eigenvalue)
    Proj(:,i)=Proj(:,i)/sqrt(D(i,i));
end
Whitened=Proj;
%%scatter(Proj(:,1),Proj(:,2),1,'b');                                         %plot whitened matrix in first two PCs
%%pbaspect([1 1 1]);
%%xlabel('PC 1');
%%ylabel('PC2');
%%title('Scatter Plot of Whitened Data');