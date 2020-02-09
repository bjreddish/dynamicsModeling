%% Mass velocity plot
close all
figure
hold on
plot(run1(:,1),run1(:,3))
plot(run2(:,1),run2(:,3))
plot(run3(:,1),run3(:,3))
title('Mass Velocity vs Time')
grid on
legend...
    ('Nonlinear spring, linear damping',...
    'Nonlinear spring, nonlinear damping',...
    'Linear spring, linear damping')
xlabel('Time (s)')
ylabel('Mass Velocity (m/s)')
%% Suspension displacement plot
figure
hold on
plot(run1(:,1),run1(:,2))
plot(run2(:,1),run2(:,2))
plot(run3(:,1),run3(:,2))
title('Suspension Displacement')
grid on
legend...
    ('Nonlinear spring, linear damping',...
    'Nonlinear spring, nonlinear damping',...
    'Linear spring, linear damping')
xlabel('Time (s)')
ylabel('Suspension Displacement (m)')