n=500;                                                                      %script for looping through neural net regression
test=500;                                                                   %vector of Nh to test

mse=zeros(length(test),length(n));                                          %matrix of returned mse for each test condition and trial
w=cell(length(test),1);                                                     %cell for each test condition with each matrix containing
                                                                            %values for each w over all trials
for i=1:length(test)
    for j=1:n
        [mse(i,j),w{i}(j,:)]=nn_regression_2(test(i));
    end
end

figure;
mse_avg=mean(mse,2);                                                        %calculate average mse and standard deviation of mse
mse_std=std(mse,0,2);
plot(test,mse_avg,'LineWidth',2,'color','k');
xlabel('Number of Neurons in Network');
ylabel('Average Mean-Squared Error');
title('Error in Regression');
figure;
plot(test,mse_std,'LineWidth',2,'color','k');
xlabel('Number of Neurons in Network');
ylabel('Standard Deviation of Mean-Squared Error');
title('Precision in Regression');