function main()
%% Set parameters
global mass g l A omega
% Given values
mass = 1; % kg
g = 9.8; % Gravitational constant (m/s^2)
l = 1; % Length of arm (meters)
A = 0.1; % Amplitude
freq  = 20; % frequency in Hz
omega = 2*pi*freq;% angular frequency 
% Theta
thetai =20*(pi/180); % degrees to radians

tfinal = 50;
tspan = linspace(0,tfinal,3000);
initials = [0 thetai];

%ode
[t,x] = ode23(@equations,tspan,initials);
yloc = zeros(1,length(x(:,2)));
for i = 1:length(x(:,2))
    yloc(i) = cos(x(i,2));
end
% figure(1)
% hold on
% plot(t(:,1),yloc)
% title('yloc')
% figure(2)
% hold on
% plot(t(:,1),x(:,1))
% title('px')
figure(3)
hold on
plot(t(:,1),x(:,2)*(180/(pi)))
title('Theta vs Time w/ Input Vibration')
xlabel('Time (s)')
ylabel('Theta (degrees)')
grid on
end
