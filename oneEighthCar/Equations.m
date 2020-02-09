function [dx, oth] = Equations(t,x)
% Global vars
global mass roadLen g amp vel G beq qe
%% Unpack
qs = x(1); % Spring state
pm = x(2); % mass momentum 
%% Calculate dy/dx from time and velocity
dist = vel * t; % distance
if dist < roadLen
    dyindx = amp*0.5 *2*(pi/roadLen)*sin(2*pi*(dist/roadLen)); % rate of change of input vertical velocity
    vin = vel * dyindx; % vertical velocity input (m/s)
else
    vin = 0; 
end
vm = pm/mass; %vertical velocity of mass
dqs = vin-vm; % relative velocity 
%% Spring calc
springForce = 3*G*(qe^2)*qs; % Linear spring
% springForce = G*qs^3; % Non-linear spring
%% Damper Calc
damperForce = beq*dqs;% Linear damper
% damperForce = 0.5*mass*g*sign(dqs) + beq*dqs; % Non-linear damp
%% Calculate rate of change
% dqs = vin - (pm/mass); %relative velocity of car mass to wheel
dpm = -mass*g + springForce + damperForce; % rate of change of mass momentum
dx = [dqs;dpm];
oth = damperForce;
end

