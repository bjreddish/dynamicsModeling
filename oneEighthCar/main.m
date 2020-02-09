%% EME 271 Simulation Number 1
% Brandon Reddish
% Eigth Car Over Bump
function main()
%% Set Parameters
global mass roadLen g amp vel G beq qe 
% Given values
mass  = 3000/2.2; % mass (kg)
qe = 0.25; % spring compression at equilibrium (m)
roadLen = 1; % road length (m)
g = 9.8; % gravitational constant (m/s^2)

%% damping ratio (non-dimentional)  
dampRatio = 0.3; 
% dampRatio = 0.4;
% dampRatio = 0.5;

%% amplitude (m)
% amp = 0.1; 
% amp = 0.3;
amp = 0.5;
%% car velocity (m/s)
vel = 10*0.45; 
% vel = 20*0.45;
% vel = 30*0.45;
% vel = 40*0.45;
% vel = 50*0.45;
%% Spring constants
G = (mass*g)/(qe^3); % non-linear spring const
keq = 3 * G * qe^2; % linear const
% Damper constants
fs = (1/(2*pi))*sqrt(keq/mass); % frequency
beq = 2*dampRatio*(2*pi*fs)*mass; % damping constant 

%% Set boundary conditions and run prameters
tfinal = 1; % time end of the simulation (sec)
tspan = linspace(0,tfinal,2000);
initials = [0.25 0]; % The weight of the car causes 0.25m of initial disp

%% ode45 
% x(1) spring state ; x(2) momentum
[t,x] = ode45(@Equations,tspan,initials);

%% Post Processing
% Process and plot spring state 
springDisp = x(:,1)-0.25 ;
figure;
plot(t,springDisp)
title('Spring State')

% Process and plot velocity
vfinal = x(:,2)/mass;
figure;
hold on
plot(t,vfinal)
title('Mass Velocity')
% x = [t springDisp vfinal];% output values to save and compare
end