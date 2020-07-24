for i=1:37                                                                  %vector along diagonal up and to the right starting at 37,1
    corvect(i)=corr(38-i,i);
end

for i=1:37                                                                  %vector along diagonal up and to the right starting at 37,2
corvect2(i)=corr(38-i,i+1);
end

for i=1:37                                                                  %vector along diagonal up and to the right starting at 38,2
corvect3(i)=corr(39-i,i+1);
end

corvectmat=[corvect;corvect2;corvect3];                                 
cormean=mean(corvectmat,1);                                                 %average 3 diagonals
plot(1:37,cormean,'LineWidth',2,'color','k')                                                          %plot averages
xlabel('Position');
ylabel('Value');
title('Covariance Matrix Along Antidiagonal');