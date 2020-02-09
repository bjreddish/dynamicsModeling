function main()
%% Set parameters
global mass omegan k qi timeStep
close all
% Given values
mass = 1; % kg
fn = 1; % hz
omegan = 2 * pi * fn; 
k = mass * omegan * omegan; % spring constant
timeStep = 0.01;
tfinal = 3;
tspan = 0:timeStep:tfinal; 
%% Initial Conditions 
qi = 0.25; %initial spring displacement
% spring state is positive in compression so when the mass is moved forward
% by 0.25 m then the spring has a state of -0.25 m as it is being elongated
initials = [-qi 0 qi];

%% Run ode
[t,x] = ode45(@equations,tspan,initials);


% Extract derivatives and other values
for i = 1:length(t)
    [dx(i,:), oth(i,:)] = equations(t(i),x(i,:));
end

%% Post Proc
% Plot momentum
figure(1);
grid on
plot(t(:,1),x(:,2))
title('Mass Momentum')
xlabel('Time(s)')
ylabel('Momentum(kg*m/s)')
print('spring_Momentum','-dpng')

%% Mass location and spring state
figure(2);
grid on
hold on
% plot mass location
plot(t(:,1),x(:,3))
% plot spring state
plot(t(:,1),x(:,1))
legend('Mass Location','Spring Displacement','Location','southwest')
xlabel('Time(s)')
ylabel('Mass Displacement(m)/Spring Displacement(m) ')
print('spring_Location','-dpng')    
end