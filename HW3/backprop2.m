clear all
%% Load MNIST dataset and plot some examples

oldparam = sympref('HeavisideAtOrigin',1);                                  %%Set heaviside function to be 1 at 0
load mnist_sevens_nines

% Sevens
figure(1)
for i = 1:16
    subplot(4,4,i)
    imshow(reshape(X_train(:,i),28,28))
end
sgtitle('Sevens');                                                          %%Title for group of subplots

% Nines
figure(2)
for i = 1:16
    subplot(4,4,i)
    imshow(reshape(X_train(:,i+900),28,28))
end
sgtitle('Nines');


%% Implement gradient descent
P = size(X_train,2); % Number of examples
max_itr = 5000;
alpha = .1/P;

Ni = size(X_train,1); % Input dimension
Nh1 = 100; % Hidden layer sizes
Nh2 = 80;

% Initialize weight matrices
weight_scale = .01;
W3 = weight_scale*randn(1,Nh2);
W2 = weight_scale*randn(Nh2,Nh1);
W1 = weight_scale*randn(Nh1,Ni);

clear L acc L_test acc_test
for i = 1:max_itr
    
    % Compute forward propagation for train and test data
    
    % Train data
    h1 = max(0,W1*X_train);
    h2 = max(0,W2*h1);
    yh = (W3*h2);
    
    % Test data
    yh_test = W3*(max(0,W2*max(0,W1*X_test)));
    
    % Compute losses and accuracy on train and test data
    L(i) = 1/2*norm(y_train-yh,'fro')^2;
    acc(i) = mean(sign(yh)==sign(y_train));
    
  
    L_test(i) = 1/2*norm(y_test-yh_test,'fro')^2;
    acc_test(i) = mean(sign(yh_test)==sign(y_test));
    
    % Compute backprop (just on training data)
    e = y_train-yh;
    
    d3 = e;
    d2 = (W3'*d3).*heaviside(h2);
    d1 = (W2'*d2).*heaviside(h1);

    % Compute gradient
    g3 = -d3*h2';
    g2 = -d2*h1';
    g1 = -d1*X_train';

    % Update weights
    W3 = W3-alpha*g3;
    W2 = W2-alpha*g2;
    W1 = W1-alpha*g1;
end

% Plot the learning trajectory
t = 1:max_itr;

figure
subplot(121)
plot(t,L/P,t,L_test/size(X_test,2),'linewidth',2) % Plot train and test loss normalized by the number of examples
legend('Train accuracy','Test accuracy');
xlabel('Epochs')
ylabel('MSE')
title('Loss vs. Iterations');
ylim([0 1.2]);

subplot(122)
plot(t,acc,t,acc_test,'linewidth',2)
legend('Train accuracy','Test accuracy');
xlabel('Epochs')
ylabel('Accuracy')
title('Accuracy vs. Iterations');
ylim([0 1.2]);

