m=inline('A-mean(A,1)');                                                    %inline function for mean subtraction
covar=inline('(1/(size(A,1)-1))*transpose(A)*(A)');                           %inline function for covariance calculation

mean_sub=m(toWhiten);
co=covar(mean_sub);
[V,D]=eig(co);                                                              %find eigenvalues and eigenvectors of covariance matrix

scatter(mean_sub(:,1),mean_sub(:,2),1,'b');                                 %plot data
hold on;
quiver(0,0,1.5*D(1,1)*V(1,1),1.5*D(1,1)*V(2,1),'color','k','LineWidth',1);  %plot principal components
quiver(0,0,1.5*D(2,2)*V(1,2),1.5*D(2,2)*V(2,2),'color','k','LineWidth',1);
pbaspect([1 1 1]);                                                          %set aspect ratio for x and y axes 1:1
xlabel('Dimension 1');
ylabel('Dimension 2');
title('Scatter Plot of Data with Overlayed Principal Components');