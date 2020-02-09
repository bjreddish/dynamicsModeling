function main()
%% Set parameters
global mus g kt ms bs ks ka T ma ba U X_i slope_i Rw bc flag
close all
%% Parameters and initial conditions
%build a random road input
rng('default');
delta_x=.5; Length=500;% This defines a length of a road in meters
X_i=0:delta_x:Length;% This establishes a length vector
n_pts=fix(Length/delta_x);
slope_raw=randn(n_pts+1,1);% This generates uniformly distributed random number that we interpret as the road slope at each delta_x
slope_i=.007*(slope_raw-mean(slope_raw));
%This is the slope vector that has any average value removed.
%This makes the road zero mean slope. The scalin  number at the front makes the passive vehicle
%without control have a sprung mass acceleration that is
%reasonable. I experimented to determine this number.
for flag = [1 2]
    g = 9.8;
    m_tot=3000./2.2;
    msmus=5;
    mus=m_tot/(1+msmus); %unsprung mass
    ms=m_tot-mus; %Sprung mass
    w_s=2*pi*1.2; %Suspension frequency
    ks=ms*w_s^2; %Suspension stiffness
    if flag ==1
        zeta_s=.7;
        zeta_c=.7; %Damping ratio for passive and active
    else
        zeta_s=.1;
        zeta_c=.7; %Damping ratio for passive and active
    end
    bs=2*zeta_s*w_s*ms; %Suspension damping constant
    bc=2*zeta_c*w_s*ms; %Effective damping constant for control
    w_wh=2*pi*8; %Wheel hop frequency
    kt=mus*w_wh^2; %Tire stiffness
    Rw=.001; %Winding resistance, Ohm
    T=10; %Nm/A Coupling constant
    ma=.04*ms; %Actuator mass, kg
    w_a=2*pi*5; %Actuator frequency
    ka=ma*w_a^2*1.4; %Actuator stiffness
    ba=2*.1*w_a*ma; %Actuator damping
    U=40*.46; %m/s Trial vehicle velocity
    
    %% Initial conditions
    qti =(m_tot+ma)*g/kt;
    qsi = (ma+ms)*g/ks;
    qai = ma*g/ka;
    
    %% Run setup
    %          [qt pus qs ps qa pa]
    initials = [qti 0 qsi 0 qai 0];
    timeStep = 0.001;
    tfinal = Length/U;
    tspan = 0:timeStep:tfinal;
    
    %% Run ODE
    [t,x] = ode45(@equations,tspan,initials);
    %Extract derivatives and other values
    for i = 1:length(t)
        [dx(i,:),oth(i,:)] = equations(t(i),x(i,:));
    end
    %% Plotting
    figure(1)
    plot(t,(dx(:,4)/ms)/g)
    title('Sprung Mass Accel')
    xlabel('Time')
    ylabel('Acceleration (g)')
    daspect([12 1 1])
    grid on
    hold on
    
    figure(2)
    plot(t,x(:,5))
    title('Actuator Mass Displacement')
    grid on
    hold on
 
    figure(3)
    plot(t,oth(:,2))
    title('Actuator Power')
    grid on
    hold on  
end
figure(1)
hline = findobj(gcf, 'type', 'line');
set(hline(2),'LineStyle','-.')
legend('Passive System','Active Control')
print('accel','-dpng')
figure(2)
hline = findobj(gcf, 'type', 'line');
set(hline(2),'LineStyle','-.')
legend('Passive System','Active Control')
print('disp','-dpng')
figure(3)
hline = findobj(gcf, 'type', 'line');
set(hline(2),'LineStyle','-.')
legend('Passive System','Active Control')
print('power','-dpng')
end