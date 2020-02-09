function [dx,oth] = equations(t,x)
% Global variables
global Jfw L V0 P0 omegaDes Kp Ap R gamma
% Unpack variables
q    = x(1); % spring state
p    = x(2); % momentum 
xLoc = x(3); % mass location
theta= x(4); % angle of flywheel
% Expaned state space to cacluate dx and dtheta
dtheta = p/Jfw; % dtheta = omegafw = p/J
dxLoc = MTF(theta,L,R)*dtheta;  
%Proportional controller
torque = Kp*(omegaDes - dtheta);
%State equations
dp = torque - MTF(theta,L,R)*Ap*P0*((1/(1-(Ap*xLoc/V0))^gamma)-1);
dq  = Ap * MTF(theta,L,R) * p/Jfw;
%Additional values for analysis
p =  P0*((1/(1-(Ap*xLoc/V0))^gamma)-1);
V = (V0-Ap*xLoc);
dx =[dq;dp;dxLoc;dtheta];
oth = [p V]; % pressure and volume 
end