function [lam,bound]=shortterm_mem()
clear all

N = 50; % Number of neurons in network

dt = .01; % Discretization timestep
tau = .4; % Time constant

T = 1000; % Max time
S = ceil(T/dt); % num simulation steps
t = ((1:S)-1)*dt; % time

%% Simulate network

% Set up recurrent weight structure

W = zeros(N,N); % No recurrent connections

weight_scale = 1;
W = weight_scale*eye(N); % Autapses

[U,~,~] = svd(randn(N,N)); % Random orthonormal connections
W = weight_scale*U;

noise_scale = 0.2;
W = W + noise_scale/sqrt(N)*randn(N,N);

% Create input
I = zeros(1,S);
I(t>1 & t<2)=1;

% Create weights from stimulus into neural population
V = ones(N,1);

r = zeros(N,S);
for s = 1:S-1
  r(:,s+1) = r(:,s) + (dt/tau)*(W*r(:,s)-r(:,s)+V*I(s));
end

l=zeros(1,50);

for i=1:50
    [f,g]=find(abs(r(i,:))>=0.1,1,'last');
    l(i)=g;
end

% Calculate eigenvalues of recurrent weights

lam = eig(W);

subplot(311)
plot(t,r')
xlabel('Time (a.u.)')
ylabel('Activity')
subplot(312)
plot(t,I)
xlabel('Time (a.u.)')
ylabel('Input')
ylim([0,1.5])
subplot(313) % Plot eigenvalues of W in sorted order
plot(sort(abs(lam),'descend'),'.')
ylim([0.8,1.2])
line([0 50],[1 1])
xlabel('Eigenvalue #')
ylabel('Eigenvalue Magnitude |\lambda|')

prompt='bound';
bound=input(prompt);
