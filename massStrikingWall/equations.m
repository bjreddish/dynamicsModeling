function [dx,oth] = equations(t,x)
% Global variables
global omegan qi k mass timeStep
% Unpack variables
q    = x(1); % spring state
p    = x(2); % momentum 
xLoc = x(3); % mass location
v = qi* omegan* cos(omegan*t); % spring flow input
% v = 0;% if v = 0 the mass would oscilate around zero and up to +- 0.25

%% No wall
% inputForce = 0;

%% Wall force
% if xLoc >=0.5 
%     inputForce = 2*p/timeStep;
% else
%     inputForce = 0;
% end

%% Wall spring
if xLoc >0.5
    inputForce = (xLoc-0.5)*k*10;
else
    inputForce = 0;
end

%% Calculate dp,dq and dxLoc
dp = q * k - inputForce; % change in momentum 
dq = v -p/mass; % change in spring state
dxLoc = p/mass; % expanfing state space to get x of mass
dx =[dq;dp;dxLoc];
oth = v;
end