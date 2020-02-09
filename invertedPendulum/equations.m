function [dx] = equations(t,x)
% Global variables
global mass g l A omega
% Unpack
px = x(1);
theta = x(2);

% Calculate y, dy and ddy
% y = A*sin(omega*t); % y location of base
% dy = A*omega*cos(omega*t); % rate of change of y
ddy = -A*omega*omega*sin(omega*t); % second derivative of y

dtheta = ((1/(l*cos(theta)))*(px/mass)); % Rate of change of theta

dpx = mass * g * sin(theta) * cos(theta) +...% Rate of change of px
    mass * ddy * sin(theta)*cos(theta) - (sin(theta)/cos(theta))*dtheta*px;
dx =[dpx; dtheta]; 
end
