function[mean_squared_error,w] = nn_regression_2(Nh)                                         %make function that takes in number of neurons in network
                                                                            %returns mean-squared error and weight vector of synaptic strengths
%% Set up parameters
N = 40; % Number of training samples
epsilon = 0.2; % Amount of label noise
%%Nh = 20;
lambda = 10^-4;

%% Make dataset
target_fn = @(t) sin(t);                                                    %target function
x = linspace(-pi,pi,N);                                                     %equally spaced x values
y = target_fn(x) + epsilon*randn(size(x));                                  %training y values
    
Ntest = 100;
x_test = linspace(-pi,pi,Ntest);                                            %equally spaced test values
y_test = target_fn(x_test);                                                 %target y values

Ni = 2;

%% Compute network activity

J = randn(Nh,Ni)/Nh;                                                        %matrix of synaptic connections 

h = J*[x; ones(1,N)];                                                       %activity of network from inputs and synaptic connections
h(h<0)=0;                                                                   %set all h = 0 if h<0 (ReLU)

h_test = J*[x_test; ones(1,Ntest)];                                         %same for test set
h_test(h_test<0)=0;


%% Now train linear regression to map from h to y

w = y*h'*pinv(h*h'+lambda*eye(length(h*h')));                               %train network using target and network activity

y_pred = w*h_test;                                                          %model prediction based on learned weights

mean_squared_error = norm(y_test-y_pred).^2;


plot(x,y,'ob')
hold on
plot(x_test,y_test)
hold on
plot(x_test,y_pred)

text(-pi,[.1 .9]*get(gca,'YLim')',sprintf('MSE: %g ', mean_squared_error))
xlabel('Input')
ylabel('Output')
legend('Training data','Test data','Prediction')



