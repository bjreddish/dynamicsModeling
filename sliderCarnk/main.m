function main()
%% Set parameters
global Jfw L V0 P0 omegaDes Kp Ap R gamma
close all
%% Parameters and initial conditions
mfw = 10/2.2; % kg
R = 4*(0.0254); % m
L = 4*R; % m
Jfw = mfw * (R^2) /2; %kg m^2
Dp = 4*(0.0254); %m
Ap = pi * (Dp^2) /4;%m^2
Vdisp = Ap*2*R; %m^3
Vtdc = 240*1e-6; %m
V0 = Vdisp + Vtdc;
P0 = 155;%N/m^2
gamma = 1.4;
%% Run setup
initials = [0 2 0 0]; % [airSpring flywheelMomentum x theta]
timeStep = 0.0001;
tfinal = 1.2;
tspan = 0:timeStep:tfinal;
% Desired angular velocity
omegaDes = 1500*0.104719;%rpm to raidians/sec
%% Controller gain
Kp = 0.1; % gain of controller
%% Run ODE
[t,x] = ode45(@equations,tspan,initials);
% Extract derivatives and other values
for i = 1:length(t)
    [dx(i,:),oth(i,:)] = equations(t(i),x(i,:));
end
%% Post Proc
% Plot momentum
time = t(:,1);
spring = x(:,1);
momentum =  x(:,2);
angularVel = momentum/Jfw;
xLoc = x(:,3);
% limit theta for range 0<x<360 and convert to deg
for i = 1:length(x(:,4))
    x(i,4) = x(i,4)*180/pi;
end
theta= x(:,4);
dxLoc = dx(:,3);
dtheta = dx(:,4);
%% Plotting
% plot x vs theta
figure(1);
plot(theta,xLoc)
title('x vs theta')
xlabel('Theta(deg)')
ylabel('x(meters)')
print('xvstheta','-dpng')
grid on
% plot dx vs dtheta
figure(2);
plot(dtheta,dxLoc)
title('dx vs dtheta')
xlabel('dTheta(deg/s)')
ylabel('dx(meters/s)')
print('dxvsdtheta','-dpng')
grid on
%plot pressure over p0 vs time
figure(3)
plot(time,oth(:,1)/P0)
title('Pressure Ration vs Time')
xlabel('Time(s)')
ylabel('P/P0')
print('poverp0','-dpng')
grid on
%plot angular velocity over time
figure(4)
plot(time,angularVel*9.5492965964254)
title('Angular Velocity vs Time')
xlabel('Time(s)')
ylabel('Angular Velocity (RPM)')
print('angvelovertime','-dpng')
grid on
%plot pressure ratio over volume ratio
figure(5)
plot(oth(:,2)/V0,oth(:,1)/P0)
title('Pressure Ratio vs Volume Ratio')
xlabel('Volume Ratio')
ylabel('Pressure Ratio')
print('volratpresrat','-dpng')
grid on
end