% Solve RNA clock
clear
% Bistable parametrs
h = 3600;
uM = 10^(-6);
uMh = uM*h;

% Chemical rates Oscillate
g = 2.1*10^5*uMh*1; % sequestration rate
ph = log(2)/10*60/1; % 1/h RNA degradation
kp = 2.1*10^5*uMh*.1;
kn = .3*kp;
kc = 4*2*.1*10; % production rate k_cat
km = (kn+kc)/kp; % unbinding/binding between RNA
th = 0.01; % rate activator
b = 0.1; % rate sequester
z1t = 0.1; % gene concentration 1
z2t = 0; % gene concentration 2
m1 = 5; % positive feedback 1
m2 = 0; % positive feedback 2

A = 0.09; % amplitude of pulse
T = 3; % Width of the pulse
t0 = 3; % Time of pulse

N = 5; % number of loads
vec = linspace(0,.2,N); % range of loads

ColM1 = ColorVector([252 187 161;203 24 29],N); % red range
ColM2 = ColorVector([198 219 239;33 113 181],N); % blue range

p = [g ph kp kn kc th z1t z2t m1 m2 A T t0 b];

set(0,'DefaultAxesFontName', 'Arial')
set(0,'DefaultAxesFontSize', 12)

tf = 20;
tspan =[0 tf];
options = odeset('AbsTol',10^-6);
x0 = [0    0    0    0    0];
% x0 = [0.0226    0.0027    0.0027    0.0255    1.3632];
idx = 1; % z(1) is X

hFig=figure(1);
set(hFig,'Units','inches', 'Position', [0 9 3.5 1.5])

% Normal
subplot(1,2,1)
m2 = 0; % positive feedback 2
for i=1:N
    z2t = vec(i); % gene concentration 2
    p = [g ph kp kn kc th z1t z2t m1 m2 A T t0 b];
    color = ColM1(i,:);
    [t,s] = ode23s(@(t,x) ODE_Module_Pulse(t,x,p),tspan,x0,options);
    y = s(:,idx);
    plot(t,y,'Color',color,'LineWidth',2)
    ylim([0,.5])
    hold on
end
hold off

u = ones(1,length(t))*th;
idx2 = find(t>=t0 & t<=t0+T);
u(idx2) = ones(1,length(idx2))*(th+A);

subplot(1,2,2)
plot(t,u,'k','LineWidth',2)
ylim([0,.15])
hold off

hFig=figure(2);
set(hFig,'Units','inches', 'Position', [0 9 3.5 1.5])

% Normal
subplot(1,2,1)
m2 = 1; % positive feedback 2
for i=1:N
    z2t = vec(i); % gene concentration 2
    p = [g ph kp kn kc th z1t z2t m1 m2 A T t0 b];
    color = ColM2(i,:);
    [t,s] = ode23s(@(t,x) ODE_Module_Pulse(t,x,p),tspan,x0,options);
    y = s(:,idx);
    plot(t,y,'Color',color,'LineWidth',2)
    ylim([0,.5])
    hold on
end
hold off

u = ones(1,length(t))*th;
idx2 = find(t>=t0 & t<=t0+T);
u(idx2) = ones(1,length(idx2))*(th+A);

subplot(1,2,2)
plot(t,u,'k','LineWidth',2)
ylim([0,.15])
hold off
