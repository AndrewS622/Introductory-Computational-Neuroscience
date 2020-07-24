function [t, y] = euler_solver(odefun, tspan, y0, dt)
% Solve differential equation y' = f(t,y), from time tspan = [t0 t_final], 
% with initial condition y0. Here odefun must be a function with signature 
% odefun(t,y), which for a scalar t and a vector y returns a column vector 
% corresponding to f(t,y). The solver uses the integration timestep dt. 
% Each row in the solution array y corresponds to a time returned in the 
% column vector t.

n=ceil((tspan(2)-tspan(1))/dt);		    %%Calculate total number of trials
y=zeros(n+1,length(y0));                %%Initialize output variables
t=zeros(n+1,1);
y(1,:)=y0;                              %%Initial condition set to first row
yderiv=zeros(length(y0),1);		        %%Initialize variable used in loop

for i=2:n+1
	t(i)=(i-1)*dt;			            %%Update time vector
	yderiv=feval(odefun,t(i),y(i-1,:)); %%Evaluate derivative at time point
	y(i,:)=y(i-1,:)+dt*yderiv’;		    %%Euler’s method equation
end
